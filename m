Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B066B2F5
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjAORWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjAORWB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7B76BB;
        Sun, 15 Jan 2023 09:22:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C8660DB5;
        Sun, 15 Jan 2023 17:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF37C433EF;
        Sun, 15 Jan 2023 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803319;
        bh=D4d8Pb3z0pDHwNMqDgVp8xrnd+ujGSW39wDZs1V5tLw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d5osKaEVagncUyYgLtr3PE85QJYdxEND2l44Zk+F3q1D2P0pUfnDIkKv2H152SABl
         hedJJa9z9faUR3sKAs8/L7fdccotc0YazLHHXSbmhm+ADFGJ07vvodIxAShkCwGBKM
         R08zWUWjXX7P1dGyfSxjeQzogldu0w4kSIMrmlMBR3x5WlkQ7DffBrezTlmYvzwtbb
         O+eSFTakRXI9zUQJdg4b9TnLOAvkxLgI5JjEtOs9iArClfclr5x+cCp4dAlkv5kcJ9
         uWNN4P5Lafu0gUALQfx28CNVp0LhMykySKB//1X5DjuNrimrZN0tNqZbb4wUq6uMjc
         T/CLHtSUWIz9Q==
Subject: [PATCH v2 16/41] SUNRPC: Remove ->encrypt and ->decrypt methods from
 struct gss_krb5_enctype
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:58 -0500
Message-ID: <167380331853.10651.3080554090671940588.stgit@bazille.1015granger.net>
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

Clean up: ->encrypt is set to only one value. Replace the two
remaining call sites with direct calls to krb5_encrypt().

There have never been any call sites for the ->decrypt() method.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |   14 ------------
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   36 +++++++++++++++++++++++++++++--
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 +++++
 net/sunrpc/auth_gss/gss_krb5_keys.c     |    6 +++--
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    8 -------
 net/sunrpc/auth_gss/gss_krb5_seqnum.c   |    2 ++
 6 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 68ae0c3d4cf7..a0646df12beb 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -69,12 +69,6 @@ struct gss_krb5_enctype {
 	const u32		keyed_cksum;	/* is it a keyed cksum? */
 	const u32		keybytes;	/* raw key len, in bytes */
 	const u32		keylength;	/* final key len, in bytes */
-	u32 (*encrypt) (struct crypto_sync_skcipher *tfm,
-			void *iv, void *in, void *out,
-			int length);		/* encryption function */
-	u32 (*decrypt) (struct crypto_sync_skcipher *tfm,
-			void *iv, void *in, void *out,
-			int length);		/* decryption function */
 	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
 	u32 (*mk_key) (const struct gss_krb5_enctype *gk5e,
 		       struct xdr_netobj *in,
@@ -243,14 +237,6 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 		struct xdr_buf *body, int body_offset, u8 *cksumkey,
 		unsigned int usage, struct xdr_netobj *cksumout);
 
-u32
-krb5_encrypt(struct crypto_sync_skcipher *key,
-	     void *iv, void *in, void *out, int length);
-
-u32
-krb5_decrypt(struct crypto_sync_skcipher *key,
-	     void *iv, void *in, void *out, int length); 
-
 int
 gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *outbuf,
 		    int offset, struct page **pages);
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 098faaf02fe6..c5845fdda527 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -82,6 +82,22 @@ void krb5_make_confounder(u8 *p, int conflen)
 	get_random_bytes(p, conflen);
 }
 
+/**
+ * krb5_encrypt - simple encryption of an RPCSEC GSS payload
+ * @tfm: initialized cipher transform
+ * @iv: pointer to an IV
+ * @in: plaintext to encrypt
+ * @out: OUT: ciphertext
+ * @length: length of input and output buffers, in bytes
+ *
+ * @iv may be NULL to force the use of an all-zero IV.
+ * The buffer containing the IV must be as large as the
+ * cipher's ivsize.
+ *
+ * Return values:
+ *   %0: @in successfully encrypted into @out
+ *   negative errno: @in not encrypted
+ */
 u32
 krb5_encrypt(
 	struct crypto_sync_skcipher *tfm,
@@ -121,6 +137,22 @@ krb5_encrypt(
 	return ret;
 }
 
+/**
+ * krb5_decrypt - simple decryption of an RPCSEC GSS payload
+ * @tfm: initialized cipher transform
+ * @iv: pointer to an IV
+ * @in: ciphertext to decrypt
+ * @out: OUT: plaintext
+ * @length: length of input and output buffers, in bytes
+ *
+ * @iv may be NULL to force the use of an all-zero IV.
+ * The buffer containing the IV must be as large as the
+ * cipher's ivsize.
+ *
+ * Return values:
+ *   %0: @in successfully decrypted into @out
+ *   negative errno: @in not decrypted
+ */
 u32
 krb5_decrypt(
      struct crypto_sync_skcipher *tfm,
@@ -234,8 +266,8 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 
 	switch (kctx->gk5e->ctype) {
 	case CKSUMTYPE_RSA_MD5:
-		err = kctx->gk5e->encrypt(kctx->seq, NULL, checksumdata,
-					  checksumdata, checksumlen);
+		err = krb5_encrypt(kctx->seq, NULL, checksumdata,
+				   checksumdata, checksumlen);
 		if (err)
 			goto out;
 		memcpy(cksumout->data,
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 04d2781e2ce2..a4b752af6951 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -44,4 +44,10 @@ u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 		      const struct xdr_buf *body, int body_offset,
 		      struct xdr_netobj *cksumout);
 
+u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
+		 void *out, int length);
+
+u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
+		 void *out, int length);
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 554cfd23f288..a7c6866dad96 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -61,6 +61,8 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/lcm.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
@@ -195,8 +197,8 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 
 	n = 0;
 	while (n < keybytes) {
-		(*(gk5e->encrypt))(cipher, NULL, inblock.data,
-				   outblock.data, inblock.len);
+		krb5_encrypt(cipher, NULL, inblock.data, outblock.data,
+			     inblock.len);
 
 		if ((keybytes - n) <= outblock.len) {
 			memcpy(rawkey + n, outblock.data, (keybytes - n));
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 9ddc6fc7077f..47c065aa4a14 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -48,8 +48,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .name = "des-cbc-crc",
 	  .encrypt_name = "cbc(des)",
 	  .cksum_name = "md5",
-	  .encrypt = krb5_encrypt,
-	  .decrypt = krb5_decrypt,
 	  .import_ctx = gss_krb5_import_ctx_des,
 	  .mk_key = NULL,
 	  .get_mic = gss_krb5_get_mic_v1,
@@ -72,8 +70,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .name = "des3-hmac-sha1",
 	  .encrypt_name = "cbc(des3_ede)",
 	  .cksum_name = "hmac(sha1)",
-	  .encrypt = krb5_encrypt,
-	  .decrypt = krb5_decrypt,
 	  .import_ctx = gss_krb5_import_ctx_v1,
 	  .mk_key = gss_krb5_des3_make_key,
 	  .get_mic = gss_krb5_get_mic_v1,
@@ -100,8 +96,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cts(cbc(aes))",
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
-	  .encrypt = krb5_encrypt,
-	  .decrypt = krb5_decrypt,
 	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
@@ -129,8 +123,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cts(cbc(aes))",
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
-	  .encrypt = krb5_encrypt,
-	  .decrypt = krb5_decrypt,
 	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
diff --git a/net/sunrpc/auth_gss/gss_krb5_seqnum.c b/net/sunrpc/auth_gss/gss_krb5_seqnum.c
index 3200b971a814..1babc3474e10 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seqnum.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seqnum.c
@@ -35,6 +35,8 @@
 #include <linux/types.h>
 #include <linux/sunrpc/gss_krb5.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif


