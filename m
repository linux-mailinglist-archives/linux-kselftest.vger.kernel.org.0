Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E851466B2DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjAORU6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAORU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1A76BB;
        Sun, 15 Jan 2023 09:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719CA60DB5;
        Sun, 15 Jan 2023 17:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5FFC433EF;
        Sun, 15 Jan 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803255;
        bh=zYi2ueYMLcSaT3wm1s6p1AXHj0zLrrN9qjhB9fgplvk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s5A2Q04xx9xRyLO8K7QC//McHqwN/6hLs8kGPllXbYXvBI2M4x4rhO/4D8yteQFAQ
         1hbvahoL2aKKwR5jCNAFKeX5FIn0mO0pFG5/wTPuVArE0WexgN44cNsMcyoSyva5JE
         bKzYO8daK16W1sx51yHWvGg78aWhHZIk89Nh5Y4P9Z/hX01Y3N1gJykxCIpj9H3q2G
         Vaw2+0pb5ulWkz/aSkUW6We/qZSa0NMIQ2pwmVhLmYW6gQiAUHAbNNQ+N3xnj4YfdC
         0CQnuIRV76IUTrmVrf0wPZOW+WImsFm5rfmUlQLnSGbYximKCf/UaygFAPR7CYf2Ju
         SxM3v7KztQT8A==
Subject: [PATCH v2 06/41] SUNRPC: Refactor set-up for aux_cipher
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:54 -0500
Message-ID: <167380325468.10651.18330271110867929299.stgit@bazille.1015granger.net>
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

Hoist the name of the aux_cipher into struct gss_krb5_enctype to
prepare for obscuring the encryption keys just after they are
derived.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c |   50 ++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index f0fac1e69731..34d54714c6a3 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -61,6 +61,7 @@ struct gss_krb5_enctype {
 	const u32		ctype;		/* checksum type */
 	const char		*name;		/* "friendly" name */
 	const char		*encrypt_name;	/* crypto encrypt name */
+	const char		*aux_cipher;	/* aux encrypt cipher name */
 	const char		*cksum_name;	/* crypto checksum name */
 	const u16		signalg;	/* signing algorithm */
 	const u16		sealalg;	/* sealing algorithm */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index b982c9d495f2..afa6a692ccdd 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -78,6 +78,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .ctype = CKSUMTYPE_HMAC_SHA1_96_AES128,
 	  .name = "aes128-cts",
 	  .encrypt_name = "cts(cbc(aes))",
+	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
@@ -99,6 +100,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .ctype = CKSUMTYPE_HMAC_SHA1_96_AES256,
 	  .name = "aes256-cts",
 	  .encrypt_name = "cts(cbc(aes))",
+	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
@@ -373,6 +375,13 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 						     ctx->initiator_seal);
 	if (ctx->initiator_enc == NULL)
 		goto out_err;
+	if (ctx->gk5e->aux_cipher) {
+		ctx->initiator_enc_aux =
+			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
+						ctx->initiator_seal);
+		if (ctx->initiator_enc_aux == NULL)
+			goto out_free;
+	}
 
 	/* acceptor seal encryption */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
@@ -381,13 +390,20 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (err) {
 		dprintk("%s: Error %d deriving acceptor_seal key\n",
 			__func__, err);
-		goto out_free_initiator_enc;
+		goto out_free;
 	}
 	ctx->acceptor_enc = context_v2_alloc_cipher(ctx,
 						    ctx->gk5e->encrypt_name,
 						    ctx->acceptor_seal);
 	if (ctx->acceptor_enc == NULL)
-		goto out_free_initiator_enc;
+		goto out_free;
+	if (ctx->gk5e->aux_cipher) {
+		ctx->acceptor_enc_aux =
+			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
+						ctx->acceptor_seal);
+		if (ctx->acceptor_enc_aux == NULL)
+			goto out_free;
+	}
 
 	/* initiator sign checksum */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
@@ -396,7 +412,7 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (err) {
 		dprintk("%s: Error %d deriving initiator_sign key\n",
 			__func__, err);
-		goto out_free_acceptor_enc;
+		goto out_free;
 	}
 
 	/* acceptor sign checksum */
@@ -406,7 +422,7 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (err) {
 		dprintk("%s: Error %d deriving acceptor_sign key\n",
 			__func__, err);
-		goto out_free_acceptor_enc;
+		goto out_free;
 	}
 
 	/* initiator seal integrity */
@@ -416,7 +432,7 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (err) {
 		dprintk("%s: Error %d deriving initiator_integ key\n",
 			__func__, err);
-		goto out_free_acceptor_enc;
+		goto out_free;
 	}
 
 	/* acceptor seal integrity */
@@ -426,31 +442,15 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (err) {
 		dprintk("%s: Error %d deriving acceptor_integ key\n",
 			__func__, err);
-		goto out_free_acceptor_enc;
-	}
-
-	switch (ctx->enctype) {
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		ctx->initiator_enc_aux =
-			context_v2_alloc_cipher(ctx, "cbc(aes)",
-						ctx->initiator_seal);
-		if (ctx->initiator_enc_aux == NULL)
-			goto out_free_acceptor_enc;
-		ctx->acceptor_enc_aux =
-			context_v2_alloc_cipher(ctx, "cbc(aes)",
-						ctx->acceptor_seal);
-		if (ctx->acceptor_enc_aux == NULL) {
-			crypto_free_sync_skcipher(ctx->initiator_enc_aux);
-			goto out_free_acceptor_enc;
-		}
+		goto out_free;
 	}
 
 	return 0;
 
-out_free_acceptor_enc:
+out_free:
+	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(ctx->acceptor_enc);
-out_free_initiator_enc:
+	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
 	crypto_free_sync_skcipher(ctx->initiator_enc);
 out_err:
 	return -EINVAL;


