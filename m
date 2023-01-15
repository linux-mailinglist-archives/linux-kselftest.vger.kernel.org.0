Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DD66B2F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjAORWR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAORWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FB110AA8;
        Sun, 15 Jan 2023 09:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC1E60DB6;
        Sun, 15 Jan 2023 17:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCE3C433EF;
        Sun, 15 Jan 2023 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803332;
        bh=hvO8NbQ4101ANyMU9hLJxU4GFi0LfgRJMb1+qEmFk2E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rCv9lZYU1A65bL2SRiINT7mFJ06p6FQQ5DSJk9v46R38C7UE/OgTFZVJrEgoIfEDQ
         oGGjWMbjMLEVaCLuzwKpugF4HIcsaIaErOJy4lvUAh5k2oi4bR6W54v50dwqdSgrB1
         8QVJwOsZqjqB5hpem4XiJj7c/GHDjg9NhVc2+xg3KpOhNL9kyaiPVqFuXN3rvgPrcI
         DIzTS9vUu+ZSo5asofBHBlKKs+e2N5Gf+WhCUWLfi9Ny5DOi8rNoFzg4bBXlbcFqRY
         qbgpcAhUHlM9GsoTrziAnPQ5I17cXBEmL8AyQkNYyxkEvj2UxBnDVR3HGx6zEgc+bW
         H0JrQgJwWKfPA==
Subject: [PATCH v2 18/41] SUNRPC: Hoist KDF into struct gss_krb5_enctype
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:11 -0500
Message-ID: <167380333130.10651.4689677262887011588.stgit@bazille.1015granger.net>
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

Each Kerberos enctype can have a different KDF. Refactor the key
derivation path to support different KDFs for the enctypes
introduced in subsequent patches.

In particular, expose the key derivation function in struct
gss_krb5_enctype instead of the enctype's preferred random-to-key
function. The latter is usually the identity function and is only
ever called during key derivation, so have each KDF call it
directly.

A couple of extra clean-ups:
- Deduplicate the set_cdata() helper
- Have ->derive_key return negative errnos, in accordance with usual
  kernel coding conventions

This patch is a little bigger than I'd like, but these are all
mechanical changes and they are all to the same areas of code. No
behavior change is intended.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |   25 +-----
 net/sunrpc/auth_gss/gss_krb5_internal.h |   46 +++++++++++
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  131 ++++++++++++++++++++-----------
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   76 ++++--------------
 4 files changed, 156 insertions(+), 122 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 85fce36c242d..04addef79177 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -70,9 +70,11 @@ struct gss_krb5_enctype {
 	const u32		keybytes;	/* raw key len, in bytes */
 	const u32		keylength;	/* final key len, in bytes */
 	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
-	u32 (*mk_key) (const struct gss_krb5_enctype *gk5e,
-		       struct xdr_netobj *in,
-		       struct xdr_netobj *out);	/* complete key generation */
+	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
+			  const struct xdr_netobj *in,
+			  struct xdr_netobj *out,
+			  const struct xdr_netobj *label,
+			  gfp_t gfp_mask);
 	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
 			struct xdr_buf *buf, struct page **pages);
 	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
@@ -257,21 +259,4 @@ krb5_get_seq_num(struct krb5_ctx *kctx,
 int
 xdr_extend_head(struct xdr_buf *buf, unsigned int base, unsigned int shiftlen);
 
-u32
-krb5_derive_key(const struct gss_krb5_enctype *gk5e,
-		const struct xdr_netobj *inkey,
-		struct xdr_netobj *outkey,
-		const struct xdr_netobj *in_constant,
-		gfp_t gfp_mask);
-
-u32
-gss_krb5_des3_make_key(const struct gss_krb5_enctype *gk5e,
-		       struct xdr_netobj *randombits,
-		       struct xdr_netobj *key);
-
-u32
-gss_krb5_aes_make_key(const struct gss_krb5_enctype *gk5e,
-		      struct xdr_netobj *randombits,
-		      struct xdr_netobj *key);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 837bcfa3742f..c7580026adc7 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -38,6 +38,52 @@ u32 gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
  * Implementation internal functions
  */
 
+/* Key Derivation Functions */
+
+int krb5_derive_key_v1(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *label,
+		       gfp_t gfp_mask);
+
+int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *label,
+		       gfp_t gfp_mask);
+
+/**
+ * krb5_derive_key - Derive a subkey from a protocol key
+ * @kctx: Kerberos 5 context
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @usage: key usage value
+ * @seed: key usage seed (one octet)
+ * @gfp_mask: memory allocation control flags
+ *
+ * Caller sets @outkey->len to the desired length of the derived key.
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+static inline int krb5_derive_key(struct krb5_ctx *kctx,
+				  const struct xdr_netobj *inkey,
+				  struct xdr_netobj *outkey,
+				  u32 usage, u8 seed, gfp_t gfp_mask)
+{
+	const struct gss_krb5_enctype *gk5e = kctx->gk5e;
+	u8 label_data[GSS_KRB5_K5CLENGTH];
+	struct xdr_netobj label = {
+		.len	= sizeof(label_data),
+		.data	= label_data,
+	};
+	__be32 *p = (__be32 *)label_data;
+
+	*p = cpu_to_be32(usage);
+	label_data[4] = seed;
+	return gk5e->derive_key(gk5e, inkey, outkey, &label, gfp_mask);
+}
+
 void krb5_make_confounder(u8 *p, int conflen);
 
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index a7c6866dad96..f6de4fdd63ae 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -139,23 +139,20 @@ static void krb5_nfold(u32 inbits, const u8 *in,
  * This is the DK (derive_key) function as described in rfc3961, sec 5.1
  * Taken from MIT Kerberos and modified.
  */
-
-u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
-		    const struct xdr_netobj *inkey,
-		    struct xdr_netobj *outkey,
-		    const struct xdr_netobj *in_constant,
-		    gfp_t gfp_mask)
+static int krb5_DK(const struct gss_krb5_enctype *gk5e,
+		   const struct xdr_netobj *inkey, u8 *rawkey,
+		   const struct xdr_netobj *in_constant, gfp_t gfp_mask)
 {
 	size_t blocksize, keybytes, keylength, n;
-	unsigned char *inblockdata, *outblockdata, *rawkey;
+	unsigned char *inblockdata, *outblockdata;
 	struct xdr_netobj inblock, outblock;
 	struct crypto_sync_skcipher *cipher;
-	u32 ret = EINVAL;
+	int ret = -EINVAL;
 
 	keybytes = gk5e->keybytes;
 	keylength = gk5e->keylength;
 
-	if ((inkey->len != keylength) || (outkey->len != keylength))
+	if (inkey->len != keylength)
 		goto err_return;
 
 	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
@@ -165,7 +162,7 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
 		goto err_return;
 
-	ret = ENOMEM;
+	ret = -ENOMEM;
 	inblockdata = kmalloc(blocksize, gfp_mask);
 	if (inblockdata == NULL)
 		goto err_free_cipher;
@@ -174,10 +171,6 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	if (outblockdata == NULL)
 		goto err_free_in;
 
-	rawkey = kmalloc(keybytes, gfp_mask);
-	if (rawkey == NULL)
-		goto err_free_out;
-
 	inblock.data = (char *) inblockdata;
 	inblock.len = blocksize;
 
@@ -210,26 +203,8 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 		n += outblock.len;
 	}
 
-	/* postprocess the key */
-
-	inblock.data = (char *) rawkey;
-	inblock.len = keybytes;
-
-	BUG_ON(gk5e->mk_key == NULL);
-	ret = (*(gk5e->mk_key))(gk5e, &inblock, outkey);
-	if (ret) {
-		dprintk("%s: got %d from mk_key function for '%s'\n",
-			__func__, ret, gk5e->encrypt_name);
-		goto err_free_raw;
-	}
-
-	/* clean memory, free resources and exit */
-
 	ret = 0;
 
-err_free_raw:
-	kfree_sensitive(rawkey);
-err_free_out:
 	kfree_sensitive(outblockdata);
 err_free_in:
 	kfree_sensitive(inblockdata);
@@ -252,15 +227,11 @@ static void mit_des_fixup_key_parity(u8 key[8])
 	}
 }
 
-/*
- * This is the des3 key derivation postprocess function
- */
-u32 gss_krb5_des3_make_key(const struct gss_krb5_enctype *gk5e,
-			   struct xdr_netobj *randombits,
-			   struct xdr_netobj *key)
+static int krb5_random_to_key_v1(const struct gss_krb5_enctype *gk5e,
+				 struct xdr_netobj *randombits,
+				 struct xdr_netobj *key)
 {
-	int i;
-	u32 ret = EINVAL;
+	int i, ret = -EINVAL;
 
 	if (key->len != 24) {
 		dprintk("%s: key->len is %d\n", __func__, key->len);
@@ -292,14 +263,49 @@ u32 gss_krb5_des3_make_key(const struct gss_krb5_enctype *gk5e,
 	return ret;
 }
 
+/**
+ * krb5_derive_key_v1 - Derive a subkey for an RFC 3961 enctype
+ * @gk5e: Kerberos 5 enctype profile
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @label: subkey usage label
+ * @gfp_mask: memory allocation control flags
+ *
+ * Caller sets @outkey->len to the desired length of the derived key.
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+int krb5_derive_key_v1(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *label,
+		       gfp_t gfp_mask)
+{
+	struct xdr_netobj inblock;
+	int ret;
+
+	inblock.len = gk5e->keybytes;
+	inblock.data = kmalloc(inblock.len, gfp_mask);
+	if (!inblock.data)
+		return -ENOMEM;
+
+	ret = krb5_DK(gk5e, inkey, inblock.data, label, gfp_mask);
+	if (!ret)
+		ret = krb5_random_to_key_v1(gk5e, &inblock, outkey);
+
+	kfree_sensitive(inblock.data);
+	return ret;
+}
+
 /*
- * This is the aes key derivation postprocess function
+ * This is the identity function, with some sanity checking.
  */
-u32 gss_krb5_aes_make_key(const struct gss_krb5_enctype *gk5e,
-			  struct xdr_netobj *randombits,
-			  struct xdr_netobj *key)
+static int krb5_random_to_key_v2(const struct gss_krb5_enctype *gk5e,
+				 struct xdr_netobj *randombits,
+				 struct xdr_netobj *key)
 {
-	u32 ret = EINVAL;
+	int ret = -EINVAL;
 
 	if (key->len != 16 && key->len != 32) {
 		dprintk("%s: key->len is %d\n", __func__, key->len);
@@ -320,3 +326,38 @@ u32 gss_krb5_aes_make_key(const struct gss_krb5_enctype *gk5e,
 err_out:
 	return ret;
 }
+
+/**
+ * krb5_derive_key_v2 - Derive a subkey for an RFC 3962 enctype
+ * @gk5e: Kerberos 5 enctype profile
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @label: subkey usage label
+ * @gfp_mask: memory allocation control flags
+ *
+ * Caller sets @outkey->len to the desired length of the derived key.
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *label,
+		       gfp_t gfp_mask)
+{
+	struct xdr_netobj inblock;
+	int ret;
+
+	inblock.len = gk5e->keybytes;
+	inblock.data = kmalloc(inblock.len, gfp_mask);
+	if (!inblock.data)
+		return -ENOMEM;
+
+	ret = krb5_DK(gk5e, inkey, inblock.data, label, gfp_mask);
+	if (!ret)
+		ret = krb5_random_to_key_v2(gk5e, &inblock, outkey);
+
+	kfree_sensitive(inblock.data);
+	return ret;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 9f393175a276..9e9551b224f6 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -49,7 +49,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cbc(des)",
 	  .cksum_name = "md5",
 	  .import_ctx = gss_krb5_import_ctx_des,
-	  .mk_key = NULL,
 	  .get_mic = gss_krb5_get_mic_v1,
 	  .verify_mic = gss_krb5_verify_mic_v1,
 	  .wrap = gss_krb5_wrap_v1,
@@ -71,7 +70,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cbc(des3_ede)",
 	  .cksum_name = "hmac(sha1)",
 	  .import_ctx = gss_krb5_import_ctx_v1,
-	  .mk_key = gss_krb5_des3_make_key,
+	  .derive_key = krb5_derive_key_v1,
 	  .get_mic = gss_krb5_get_mic_v1,
 	  .verify_mic = gss_krb5_verify_mic_v1,
 	  .wrap = gss_krb5_wrap_v1,
@@ -97,7 +96,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .import_ctx = gss_krb5_import_ctx_v2,
-	  .mk_key = gss_krb5_aes_make_key,
+	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aes_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
 
@@ -124,7 +123,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .import_ctx = gss_krb5_import_ctx_v2,
-	  .mk_key = gss_krb5_aes_make_key,
+	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aes_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
 
@@ -358,16 +357,6 @@ context_v2_alloc_cipher(struct krb5_ctx *ctx, const char *cname, u8 *key)
 	return cp;
 }
 
-static inline void
-set_cdata(u8 cdata[GSS_KRB5_K5CLENGTH], u32 usage, u8 seed)
-{
-	cdata[0] = (usage>>24)&0xff;
-	cdata[1] = (usage>>16)&0xff;
-	cdata[2] = (usage>>8)&0xff;
-	cdata[3] = usage&0xff;
-	cdata[4] = seed;
-}
-
 #if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
 static int
 gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
@@ -378,16 +367,10 @@ gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
 static int
 gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
-	struct xdr_netobj c, keyin, keyout;
-	u8 cdata[GSS_KRB5_K5CLENGTH];
-	u32 err;
-
-	c.len = GSS_KRB5_K5CLENGTH;
-	c.data = cdata;
+	struct xdr_netobj keyin, keyout;
 
 	keyin.data = ctx->Ksess;
 	keyin.len = ctx->gk5e->keylength;
-	keyout.len = ctx->gk5e->keylength;
 
 	/* seq uses the raw key */
 	ctx->seq = context_v2_alloc_cipher(ctx, ctx->gk5e->encrypt_name,
@@ -401,14 +384,11 @@ gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		goto out_free_seq;
 
 	/* derive cksum */
-	set_cdata(cdata, KG_USAGE_SIGN, KEY_USAGE_SEED_CHECKSUM);
 	keyout.data = ctx->cksum;
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving cksum key\n",
-			__func__, err);
+	keyout.len = ctx->gk5e->keylength;
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_SIGN,
+			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
 		goto out_free_enc;
-	}
 
 	return 0;
 
@@ -441,11 +421,6 @@ gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
 static int
 gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
-	u8 cdata[GSS_KRB5_K5CLENGTH];
-	struct xdr_netobj c = {
-		.len	= sizeof(cdata),
-		.data	= cdata,
-	};
 	struct xdr_netobj keyin = {
 		.len	= ctx->gk5e->keylength,
 		.data	= ctx->Ksess,
@@ -453,7 +428,6 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	struct xdr_netobj keyout;
 	int ret = -EINVAL;
 	void *subkey;
-	u32 err;
 
 	subkey = kmalloc(ctx->gk5e->keylength, gfp_mask);
 	if (!subkey)
@@ -462,13 +436,9 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	keyout.data = subkey;
 
 	/* initiator seal encryption */
-	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving initiator_seal key\n",
-			__func__, err);
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
+			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
 		goto out;
-	}
 	ctx->initiator_enc = context_v2_alloc_cipher(ctx,
 						     ctx->gk5e->encrypt_name,
 						     subkey);
@@ -483,13 +453,9 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	}
 
 	/* acceptor seal encryption */
-	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving acceptor_seal key\n",
-			__func__, err);
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SEAL,
+			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
 		goto out_free;
-	}
 	ctx->acceptor_enc = context_v2_alloc_cipher(ctx,
 						    ctx->gk5e->encrypt_name,
 						    subkey);
@@ -504,36 +470,32 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	}
 
 	/* initiator sign checksum */
-	set_cdata(cdata, KG_USAGE_INITIATOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err)
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SIGN,
+			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
 		goto out_free;
 	ctx->initiator_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
 	if (ctx->initiator_sign == NULL)
 		goto out_free;
 
 	/* acceptor sign checksum */
-	set_cdata(cdata, KG_USAGE_ACCEPTOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err)
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SIGN,
+			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
 		goto out_free;
 	ctx->acceptor_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
 	if (ctx->acceptor_sign == NULL)
 		goto out_free;
 
 	/* initiator seal integrity */
-	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err)
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
+			    KEY_USAGE_SEED_INTEGRITY, gfp_mask))
 		goto out_free;
 	ctx->initiator_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
 	if (ctx->initiator_integ == NULL)
 		goto out_free;
 
 	/* acceptor seal integrity */
-	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
-	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err)
+	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SEAL,
+			    KEY_USAGE_SEED_INTEGRITY, gfp_mask))
 		goto out_free;
 	ctx->acceptor_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
 	if (ctx->acceptor_integ == NULL)


