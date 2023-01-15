Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768F966B2FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjAORWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAORW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC954113C7;
        Sun, 15 Jan 2023 09:22:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88D9BB80B8A;
        Sun, 15 Jan 2023 17:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BBEC433F0;
        Sun, 15 Jan 2023 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803345;
        bh=clAgqu8PKjFIp8s+H3wh50T/u/Bzpo1ZNwB6BCr/h3Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N5+An1wdEBFEyRnIRAIeYaIPO1TVUfQCJYRC0n9zXfP0iy+e8HuzePJiHlOSZSN2J
         HpN+/0Rs2N11M7saiN97zsw0Kh+IO8xobUQrg4J+ZgtBKyye5fmKMLYwAL+MPmtMhO
         l8D3iujnFjY3rCh/X8aR03b2uwjhBdrAstdeSxz3zxrVgw7u/tcVa2e/yCk0FwbMiR
         3LivEieBI0wZ7jozVVQvOmDqQzCTpZzSWkfXRYcZSjRJVbD0doqFOCWjHuYAxQFX8t
         xCLFGUl3SKnV09D/omK+bCZGpu98mIF09NI39tJZs1EO4CZFua/UtIijUqQbJb6sAs
         X8CVGAcEAYdSA==
Subject: [PATCH v2 20/41] SUNRPC: Parametrize the key length passed to
 context_v2_alloc_cipher()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:24 -0500
Message-ID: <167380334406.10651.16032231089727548065.stgit@bazille.1015granger.net>
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

Although the Kerberos specs have always listed separate subkey
lengths, the Linux kernel's SunRPC GSS Kerberos enctype profiles
assume the base key and the derived keys have identical lengths.

The aes256-cts-hmac-sha384-192 enctype specifies the length of its
checksum and integrity subkeys as 192 bits, but the length of its
encryption subkey (Ke) as 256 bits.

To support that enctype, parametrize context_v2_alloc_cipher() so
that each of its call sites can pass in its desired key length. For
now it will be the same length as before (gk5e->keylength), but a
subsequent patch will change this.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |   61 +++++++++++++++--------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 9575fb291d33..45f461f9b5ba 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -341,26 +341,6 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
 	return PTR_ERR(p);
 }
 
-static inline struct crypto_sync_skcipher *
-context_v2_alloc_cipher(struct krb5_ctx *ctx, const char *cname, u8 *key)
-{
-	struct crypto_sync_skcipher *cp;
-
-	cp = crypto_alloc_sync_skcipher(cname, 0, 0);
-	if (IS_ERR(cp)) {
-		dprintk("gss_kerberos_mech: unable to initialize "
-			"crypto algorithm %s\n", cname);
-		return NULL;
-	}
-	if (crypto_sync_skcipher_setkey(cp, key, ctx->gk5e->keylength)) {
-		dprintk("gss_kerberos_mech: error setting key for "
-			"crypto algorithm %s\n", cname);
-		crypto_free_sync_skcipher(cp);
-		return NULL;
-	}
-	return cp;
-}
-
 #if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
 static int
 gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
@@ -403,6 +383,21 @@ gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 
 #if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 
+static struct crypto_sync_skcipher *
+gss_krb5_alloc_cipher_v2(const char *cname, const struct xdr_netobj *key)
+{
+	struct crypto_sync_skcipher *tfm;
+
+	tfm = crypto_alloc_sync_skcipher(cname, 0, 0);
+	if (IS_ERR(tfm))
+		return NULL;
+	if (crypto_sync_skcipher_setkey(tfm, key->data, key->len)) {
+		crypto_free_sync_skcipher(tfm);
+		return NULL;
+	}
+	return tfm;
+}
+
 static struct crypto_ahash *
 gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
 {
@@ -427,27 +422,24 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	};
 	struct xdr_netobj keyout;
 	int ret = -EINVAL;
-	void *subkey;
 
-	subkey = kmalloc(ctx->gk5e->keylength, gfp_mask);
-	if (!subkey)
+	keyout.data = kmalloc(ctx->gk5e->keylength, gfp_mask);
+	if (!keyout.data)
 		return -ENOMEM;
 	keyout.len = ctx->gk5e->keylength;
-	keyout.data = subkey;
 
 	/* initiator seal encryption */
 	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
 			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
 		goto out;
-	ctx->initiator_enc = context_v2_alloc_cipher(ctx,
-						     ctx->gk5e->encrypt_name,
-						     subkey);
+	ctx->initiator_enc = gss_krb5_alloc_cipher_v2(ctx->gk5e->encrypt_name,
+						      &keyout);
 	if (ctx->initiator_enc == NULL)
 		goto out;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->initiator_enc_aux =
-			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						subkey);
+			gss_krb5_alloc_cipher_v2(ctx->gk5e->aux_cipher,
+						 &keyout);
 		if (ctx->initiator_enc_aux == NULL)
 			goto out_free;
 	}
@@ -456,15 +448,14 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SEAL,
 			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
 		goto out_free;
-	ctx->acceptor_enc = context_v2_alloc_cipher(ctx,
-						    ctx->gk5e->encrypt_name,
-						    subkey);
+	ctx->acceptor_enc = gss_krb5_alloc_cipher_v2(ctx->gk5e->encrypt_name,
+						     &keyout);
 	if (ctx->acceptor_enc == NULL)
 		goto out_free;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->acceptor_enc_aux =
-			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						subkey);
+			gss_krb5_alloc_cipher_v2(ctx->gk5e->aux_cipher,
+						 &keyout);
 		if (ctx->acceptor_enc_aux == NULL)
 			goto out_free;
 	}
@@ -503,7 +494,7 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 
 	ret = 0;
 out:
-	kfree_sensitive(subkey);
+	kfree_sensitive(keyout.data);
 	return ret;
 
 out_free:


