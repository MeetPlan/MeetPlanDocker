mkdir cacerts

openssl req \
	-newkey rsa:2048 \
	-subj /CN=MeetPlanCA \
	-nodes   \
	-keyout cacerts/key.pem \
	-x509 \
	-addext keyUsage=digitalSignature   \
	-out cacerts/cert.pem \
	2>/dev/null
openssl pkcs12 \
	-inkey cacerts/key.pem \
	-in cacerts/cert.pem \
	-export \
	-passout pass: \
	-out cacerts/key-pair.p12 \
	-certpbe PBE-SHA1-3DES \
	-keypbe PBE-SHA1-3DES \
	-macalg sha1
