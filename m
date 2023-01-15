Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6074A66B319
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjAORX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjAORX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8BB10AA3;
        Sun, 15 Jan 2023 09:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B31860DB5;
        Sun, 15 Jan 2023 17:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA06C433D2;
        Sun, 15 Jan 2023 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803434;
        bh=bBUxC36IfRRnvu/JItt6Ze8wj8XLNo7wovaB78uVkvU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g/KSE1dNT/aYYG6bZDX2ZdIUKV4j53e7b/C4r/S9XOb9brqm7EOYNmlPGVRXrzaB2
         BiTVMNh2IovsFL6ctw9pb/vDNgx6CwUXLjbbsq9s+LcAbV+Ui9vqdXoKiMviweFFDR
         uXSP38v3iMkl1gQn8Jo3hJWMXNRCCAzhJs2BkpfUcJCJvKAeIGTn2eCJXPamyipKzx
         Ovpmi4YwEdbHMMvB2opl72D+fKtazzvMYWLMMwiqKB75BK58aE0Cdpyn+zPblgdeGC
         PyveOlxWoff26U662U/68Ita3hU9jTxsLN60FZ6K3aoEkbyLX5cKcgtpSN7HirKQXa
         agczZw8DWev8g==
Subject: [PATCH v2 34/41] SUNRPC: Add Kunit tests for RFC 3962-defined
 encryption/decryption
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:53 -0500
Message-ID: <167380343332.10651.1810091379063177726.stgit@bazille.1015granger.net>
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add Kunit tests for ENCTYPE_AES128_CTS_HMAC_SHA1_96. The test
vectors come from RFC 3962 Appendix B.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/.kunitconfig                 |    2 
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   32 +++-
 net/sunrpc/auth_gss/gss_krb5_internal.h |    4 
 net/sunrpc/auth_gss/gss_krb5_test.c     |  267 +++++++++++++++++++++++++++++++
 4 files changed, 296 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/.kunitconfig b/net/sunrpc/.kunitconfig
index dc9abe4faa4f..01e12729f465 100644
--- a/net/sunrpc/.kunitconfig
+++ b/net/sunrpc/.kunitconfig
@@ -14,9 +14,11 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_AES=y
 CONFIG_NFS_FS=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
+CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
 CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 5c811b554fd1..5d8dff65d014 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -46,6 +46,7 @@
 #include <linux/random.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
+#include <kunit/visibility.h>
 
 #include "gss_krb5_internal.h"
 
@@ -640,14 +641,28 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher, struct xdr_buf *buf,
 	return ret;
 }
 
-/*
+/**
+ * krb5_cbc_cts_encrypt - encrypt in CBC mode with CTS
+ * @cts_tfm: CBC cipher with CTS
+ * @cbc_tfm: base CBC cipher
+ * @offset: starting byte offset for plaintext
+ * @buf: OUT: output buffer
+ * @pages: plaintext
+ * @iv: output CBC initialization vector, or NULL
+ * @ivsize: size of @iv, in octets
+ *
  * To provide confidentiality, encrypt using cipher block chaining
  * with ciphertext stealing. Message integrity is handled separately.
+ *
+ * Return values:
+ *   %0: encryption successful
+ *   negative errno: encryption could not be completed
  */
-static int
-krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
-		     struct crypto_sync_skcipher *cbc_tfm,
-		     u32 offset, struct xdr_buf *buf, struct page **pages)
+VISIBLE_IF_KUNIT
+int krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
+			 struct crypto_sync_skcipher *cbc_tfm,
+			 u32 offset, struct xdr_buf *buf, struct page **pages,
+			 u8 *iv, unsigned int ivsize)
 {
 	u32 blocksize, nbytes, nblocks, cbcbytes;
 	struct encryptor_desc desc;
@@ -691,8 +706,11 @@ krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
 	if (err)
 		return err;
 
+	if (unlikely(iv))
+		memcpy(iv, desc.iv, ivsize);
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(krb5_cbc_cts_encrypt);
 
 static int
 krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
@@ -800,7 +818,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 
 	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
 				   offset + GSS_KRB5_TOK_HDR_LEN,
-				   buf, pages);
+				   buf, pages, NULL, 0);
 	if (err)
 		return GSS_S_FAILURE;
 
@@ -992,7 +1010,7 @@ krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset,
 
 	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
 				   offset + GSS_KRB5_TOK_HDR_LEN,
-				   buf, pages);
+				   buf, pages, NULL, 0);
 	if (err)
 		return GSS_S_FAILURE;
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index cca4026f986d..bebe1ec2f507 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -217,6 +217,10 @@ u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 #if IS_ENABLED(CONFIG_KUNIT)
 void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
 const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype);
+int krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
+			 struct crypto_sync_skcipher *cbc_tfm, u32 offset,
+			 struct xdr_buf *buf, struct page **pages,
+			 u8 *iv, unsigned int ivsize);
 #endif
 
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 550f1b3a11a3..2f7e31b8004e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -23,9 +23,11 @@ struct gss_krb5_test_param {
 	u32				enctype;
 	u32				nfold;
 	const struct xdr_netobj		*base_key;
+	const struct xdr_netobj		*Ke;
 	const struct xdr_netobj		*usage;
-	const struct xdr_netobj         *plaintext;
+	const struct xdr_netobj		*plaintext;
 	const struct xdr_netobj		*expected_result;
+	const struct xdr_netobj		*next_iv;
 };
 
 static inline void gss_krb5_get_desc(const struct gss_krb5_test_param *param,
@@ -465,7 +467,268 @@ static struct kunit_suite rfc3961_suite = {
 	.test_cases		= rfc3961_test_cases,
 };
 
-kunit_test_suites(&rfc3961_suite);
+/*
+ * From RFC 3962 Appendix B:   Sample Test Vectors
+ *
+ * Some test vectors for CBC with ciphertext stealing, using an
+ * initial vector of all-zero.
+ *
+ * This test material is copyright (C) The Internet Society (2005).
+ */
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_encryption_key,
+		      0x63, 0x68, 0x69, 0x63, 0x6b, 0x65, 0x6e, 0x20,
+		      0x74, 0x65, 0x72, 0x69, 0x79, 0x61, 0x6b, 0x69
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test1_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test1_expected_result,
+		      0xc6, 0x35, 0x35, 0x68, 0xf2, 0xbf, 0x8c, 0xb4,
+		      0xd8, 0xa5, 0x80, 0x36, 0x2d, 0xa7, 0xff, 0x7f,
+		      0x97
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test1_next_iv,
+		      0xc6, 0x35, 0x35, 0x68, 0xf2, 0xbf, 0x8c, 0xb4,
+		      0xd8, 0xa5, 0x80, 0x36, 0x2d, 0xa7, 0xff, 0x7f
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test2_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x6c,
+		      0x20, 0x47, 0x61, 0x75, 0x27, 0x73, 0x20
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test2_expected_result,
+		      0xfc, 0x00, 0x78, 0x3e, 0x0e, 0xfd, 0xb2, 0xc1,
+		      0xd4, 0x45, 0xd4, 0xc8, 0xef, 0xf7, 0xed, 0x22,
+		      0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+		      0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test2_next_iv,
+		      0xfc, 0x00, 0x78, 0x3e, 0x0e, 0xfd, 0xb2, 0xc1,
+		      0xd4, 0x45, 0xd4, 0xc8, 0xef, 0xf7, 0xed, 0x22
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test3_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x6c,
+		      0x20, 0x47, 0x61, 0x75, 0x27, 0x73, 0x20, 0x43
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test3_expected_result,
+		      0x39, 0x31, 0x25, 0x23, 0xa7, 0x86, 0x62, 0xd5,
+		      0xbe, 0x7f, 0xcb, 0xcc, 0x98, 0xeb, 0xf5, 0xa8,
+		      0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+		      0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5, 0x84
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test3_next_iv,
+		      0x39, 0x31, 0x25, 0x23, 0xa7, 0x86, 0x62, 0xd5,
+		      0xbe, 0x7f, 0xcb, 0xcc, 0x98, 0xeb, 0xf5, 0xa8
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test4_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x6c,
+		      0x20, 0x47, 0x61, 0x75, 0x27, 0x73, 0x20, 0x43,
+		      0x68, 0x69, 0x63, 0x6b, 0x65, 0x6e, 0x2c, 0x20,
+		      0x70, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x2c
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test4_expected_result,
+		      0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+		      0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5, 0x84,
+		      0xb3, 0xff, 0xfd, 0x94, 0x0c, 0x16, 0xa1, 0x8c,
+		      0x1b, 0x55, 0x49, 0xd2, 0xf8, 0x38, 0x02, 0x9e,
+		      0x39, 0x31, 0x25, 0x23, 0xa7, 0x86, 0x62, 0xd5,
+		      0xbe, 0x7f, 0xcb, 0xcc, 0x98, 0xeb, 0xf5
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test4_next_iv,
+		      0xb3, 0xff, 0xfd, 0x94, 0x0c, 0x16, 0xa1, 0x8c,
+		      0x1b, 0x55, 0x49, 0xd2, 0xf8, 0x38, 0x02, 0x9e
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test5_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x6c,
+		      0x20, 0x47, 0x61, 0x75, 0x27, 0x73, 0x20, 0x43,
+		      0x68, 0x69, 0x63, 0x6b, 0x65, 0x6e, 0x2c, 0x20,
+		      0x70, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x2c, 0x20
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test5_expected_result,
+		      0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+		      0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5, 0x84,
+		      0x9d, 0xad, 0x8b, 0xbb, 0x96, 0xc4, 0xcd, 0xc0,
+		      0x3b, 0xc1, 0x03, 0xe1, 0xa1, 0x94, 0xbb, 0xd8,
+		      0x39, 0x31, 0x25, 0x23, 0xa7, 0x86, 0x62, 0xd5,
+		      0xbe, 0x7f, 0xcb, 0xcc, 0x98, 0xeb, 0xf5, 0xa8
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test5_next_iv,
+		      0x9d, 0xad, 0x8b, 0xbb, 0x96, 0xc4, 0xcd, 0xc0,
+		      0x3b, 0xc1, 0x03, 0xe1, 0xa1, 0x94, 0xbb, 0xd8
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test6_plaintext,
+		      0x49, 0x20, 0x77, 0x6f, 0x75, 0x6c, 0x64, 0x20,
+		      0x6c, 0x69, 0x6b, 0x65, 0x20, 0x74, 0x68, 0x65,
+		      0x20, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x6c,
+		      0x20, 0x47, 0x61, 0x75, 0x27, 0x73, 0x20, 0x43,
+		      0x68, 0x69, 0x63, 0x6b, 0x65, 0x6e, 0x2c, 0x20,
+		      0x70, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x2c, 0x20,
+		      0x61, 0x6e, 0x64, 0x20, 0x77, 0x6f, 0x6e, 0x74,
+		      0x6f, 0x6e, 0x20, 0x73, 0x6f, 0x75, 0x70, 0x2e
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test6_expected_result,
+		      0x97, 0x68, 0x72, 0x68, 0xd6, 0xec, 0xcc, 0xc0,
+		      0xc0, 0x7b, 0x25, 0xe2, 0x5e, 0xcf, 0xe5, 0x84,
+		      0x39, 0x31, 0x25, 0x23, 0xa7, 0x86, 0x62, 0xd5,
+		      0xbe, 0x7f, 0xcb, 0xcc, 0x98, 0xeb, 0xf5, 0xa8,
+		      0x48, 0x07, 0xef, 0xe8, 0x36, 0xee, 0x89, 0xa5,
+		      0x26, 0x73, 0x0d, 0xbc, 0x2f, 0x7b, 0xc8, 0x40,
+		      0x9d, 0xad, 0x8b, 0xbb, 0x96, 0xc4, 0xcd, 0xc0,
+		      0x3b, 0xc1, 0x03, 0xe1, 0xa1, 0x94, 0xbb, 0xd8
+);
+DEFINE_HEX_XDR_NETOBJ(rfc3962_enc_test6_next_iv,
+		      0x48, 0x07, 0xef, 0xe8, 0x36, 0xee, 0x89, 0xa5,
+		      0x26, 0x73, 0x0d, 0xbc, 0x2f, 0x7b, 0xc8, 0x40
+);
+
+static const struct gss_krb5_test_param rfc3962_encrypt_test_params[] = {
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 1",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test1_plaintext,
+		.expected_result	= &rfc3962_enc_test1_expected_result,
+		.next_iv		= &rfc3962_enc_test1_next_iv,
+	},
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 2",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test2_plaintext,
+		.expected_result	= &rfc3962_enc_test2_expected_result,
+		.next_iv		= &rfc3962_enc_test2_next_iv,
+	},
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 3",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test3_plaintext,
+		.expected_result	= &rfc3962_enc_test3_expected_result,
+		.next_iv		= &rfc3962_enc_test3_next_iv,
+	},
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 4",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test4_plaintext,
+		.expected_result	= &rfc3962_enc_test4_expected_result,
+		.next_iv		= &rfc3962_enc_test4_next_iv,
+	},
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 5",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test5_plaintext,
+		.expected_result	= &rfc3962_enc_test5_expected_result,
+		.next_iv		= &rfc3962_enc_test5_next_iv,
+	},
+	{
+		.desc			= "Encrypt with aes128-cts-hmac-sha1-96 case 6",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &rfc3962_enc_test6_plaintext,
+		.expected_result	= &rfc3962_enc_test6_expected_result,
+		.next_iv		= &rfc3962_enc_test6_next_iv,
+	},
+};
+
+/* Creates the function rfc3962_encrypt_gen_params */
+KUNIT_ARRAY_PARAM(rfc3962_encrypt, rfc3962_encrypt_test_params,
+		  gss_krb5_get_desc);
+
+/*
+ * This tests the implementation of the encryption part of the mechanism.
+ * It does not apply a confounder or test the result of HMAC over the
+ * plaintext.
+ */
+static void rfc3962_encrypt_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	struct crypto_sync_skcipher *cts_tfm, *cbc_tfm;
+	const struct gss_krb5_enctype *gk5e;
+	struct xdr_buf buf;
+	void *iv, *text;
+	u32 err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	cbc_tfm = crypto_alloc_sync_skcipher(gk5e->aux_cipher, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cbc_tfm);
+	err = crypto_sync_skcipher_setkey(cbc_tfm, param->Ke->data, param->Ke->len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	cts_tfm = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cts_tfm);
+	err = crypto_sync_skcipher_setkey(cts_tfm, param->Ke->data, param->Ke->len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	iv = kunit_kzalloc(test, crypto_sync_skcipher_ivsize(cts_tfm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, iv);
+
+	text = kunit_kzalloc(test, param->plaintext->len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, text);
+
+	memcpy(text, param->plaintext->data, param->plaintext->len);
+	memset(&buf, 0, sizeof(buf));
+	buf.head[0].iov_base = text;
+	buf.head[0].iov_len = param->plaintext->len;
+	buf.len = buf.head[0].iov_len;
+
+	/* Act */
+	err = krb5_cbc_cts_encrypt(cts_tfm, cbc_tfm, 0, &buf, NULL,
+				   iv, crypto_sync_skcipher_ivsize(cts_tfm));
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    param->expected_result->len, buf.len,
+			    "ciphertext length mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   text, param->expected_result->len), 0,
+			    "ciphertext mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->next_iv->data, iv,
+				   param->next_iv->len), 0,
+			    "IV mismatch");
+
+	crypto_free_sync_skcipher(cts_tfm);
+	crypto_free_sync_skcipher(cbc_tfm);
+}
+
+static struct kunit_case rfc3962_test_cases[] = {
+	{
+		.name			= "RFC 3962 encryption",
+		.run_case		= rfc3962_encrypt_case,
+		.generate_params	= rfc3962_encrypt_gen_params,
+	},
+};
+
+static struct kunit_suite rfc3962_suite = {
+	.name			= "RFC 3962 suite",
+	.test_cases		= rfc3962_test_cases,
+};
+
+kunit_test_suites(&rfc3961_suite,
+		  &rfc3962_suite);
 
 MODULE_DESCRIPTION("Test RPCSEC GSS Kerberos 5 functions");
 MODULE_LICENSE("GPL");


