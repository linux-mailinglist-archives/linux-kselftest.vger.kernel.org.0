Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E608F66B2E0
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjAORVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAORVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7376BB;
        Sun, 15 Jan 2023 09:21:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACFB60DB5;
        Sun, 15 Jan 2023 17:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F54C433D2;
        Sun, 15 Jan 2023 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803262;
        bh=6hn1qgOMTgfXhHAsbBIsSGtuSgr5IumnurDdn7yPTTg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KFqlMYSwn0xVUZIoOK5T4fkKGJFA5mYlUfgvRslP7y+hE5uBVel31U8zL4ylIzcHP
         5qGoCBSKoxV+XDDFqmvV6JJ3vmLwjdDg40kRl9hJWZi9osI6SDeN6ZWnz5IeXvlk8L
         G5X7vrXysGXkMwybHtI76sRPbOrzrPFMoOt9rIqKSEkoQySXE9WDXiGjd/PileA0P7
         tC/roU537ZluR54TmCeO+XuLYXfIIbaaFm4SSMo59iNk6Q4wkyCkHK0tDBlLkiEZq6
         gqkVavmdplan4KFC3j0TW9UrsB5tqs67vDsMSe3ygDhFKOInNe+u3RiP6RcgH1zeet
         0doNJds+9MJdQ==
Subject: [PATCH v2 07/41] SUNRPC: Obscure Kerberos encryption keys
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:01 -0500
Message-ID: <167380326106.10651.3883618931801361872.stgit@bazille.1015granger.net>
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

The encryption subkeys are not used after the cipher transforms have
been allocated and keyed. There is no need to retain them in struct
krb5_ctx.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    2 --
 net/sunrpc/auth_gss/gss_krb5_mech.c |   43 +++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 34d54714c6a3..46eaa2ee9c21 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -110,8 +110,6 @@ struct krb5_ctx {
 	struct xdr_netobj	mech_used;
 	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
-	u8			initiator_seal[GSS_KRB5_MAX_KEYLEN];
-	u8			acceptor_seal[GSS_KRB5_MAX_KEYLEN];
 	u8			initiator_integ[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
 };
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index afa6a692ccdd..8bc24c0684cb 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -350,42 +350,49 @@ context_derive_keys_des3(struct krb5_ctx *ctx, gfp_t gfp_mask)
 static int
 context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
-	struct xdr_netobj c, keyin, keyout;
 	u8 cdata[GSS_KRB5_K5CLENGTH];
+	struct xdr_netobj c = {
+		.len	= sizeof(cdata),
+		.data	= cdata,
+	};
+	struct xdr_netobj keyin = {
+		.len	= ctx->gk5e->keylength,
+		.data	= ctx->Ksess,
+	};
+	struct xdr_netobj keyout;
+	int ret = -EINVAL;
+	void *subkey;
 	u32 err;
 
-	c.len = GSS_KRB5_K5CLENGTH;
-	c.data = cdata;
-
-	keyin.data = ctx->Ksess;
-	keyin.len = ctx->gk5e->keylength;
+	subkey = kmalloc(ctx->gk5e->keylength, gfp_mask);
+	if (!subkey)
+		return -ENOMEM;
 	keyout.len = ctx->gk5e->keylength;
+	keyout.data = subkey;
 
 	/* initiator seal encryption */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	keyout.data = ctx->initiator_seal;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
 	if (err) {
 		dprintk("%s: Error %d deriving initiator_seal key\n",
 			__func__, err);
-		goto out_err;
+		goto out;
 	}
 	ctx->initiator_enc = context_v2_alloc_cipher(ctx,
 						     ctx->gk5e->encrypt_name,
-						     ctx->initiator_seal);
+						     subkey);
 	if (ctx->initiator_enc == NULL)
-		goto out_err;
+		goto out;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->initiator_enc_aux =
 			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						ctx->initiator_seal);
+						subkey);
 		if (ctx->initiator_enc_aux == NULL)
 			goto out_free;
 	}
 
 	/* acceptor seal encryption */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	keyout.data = ctx->acceptor_seal;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
 	if (err) {
 		dprintk("%s: Error %d deriving acceptor_seal key\n",
@@ -394,13 +401,13 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	}
 	ctx->acceptor_enc = context_v2_alloc_cipher(ctx,
 						    ctx->gk5e->encrypt_name,
-						    ctx->acceptor_seal);
+						    subkey);
 	if (ctx->acceptor_enc == NULL)
 		goto out_free;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->acceptor_enc_aux =
 			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						ctx->acceptor_seal);
+						subkey);
 		if (ctx->acceptor_enc_aux == NULL)
 			goto out_free;
 	}
@@ -445,15 +452,17 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		goto out_free;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree_sensitive(subkey);
+	return ret;
 
 out_free:
 	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(ctx->acceptor_enc);
 	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
 	crypto_free_sync_skcipher(ctx->initiator_enc);
-out_err:
-	return -EINVAL;
+	goto out;
 }
 
 static int


