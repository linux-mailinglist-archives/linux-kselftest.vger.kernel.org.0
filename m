Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C366B2EA
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAORVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjAORVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765711041F;
        Sun, 15 Jan 2023 09:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B45DB80B8A;
        Sun, 15 Jan 2023 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ED7C433EF;
        Sun, 15 Jan 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803287;
        bh=fZjcv8VBETDeth7FrIQJ3BT3Exty8Z9/lj2cozNxMH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dk4lyeSFgqMLySbRlAC1y3j4HcZTyQEumGLsmp1RF5vizlLaWn1Bz0Vo4te9plVQI
         PlDVgGqkmrmJMdLoYAE/oDBjku3ZgvQIO4JdbbO6S8ZkOGBAQOaY/tD3T4uyeu1JkC
         7hehAvtWyN0OshBL5DKDJACzxugRwdEY1tUw4wC4d1qfVsIi3ZwVBlmAuQ4FLQ4W0i
         +Yi6NK8SD51wjpKKuEv0+SIBfr3HNL/J4FA0UngCf1Ro1JyXV3yk4Kj5uEr/l9CxZ+
         +EzizwhxdhxV2IJD+TFHCiu2SKSRjTR7IYKbNMgL1epG06Jq8CqTDzBkmg+l5/kVXV
         vLLpP3ZRfljrg==
Subject: [PATCH v2 11/41] SUNRPC: Remove another switch on ctx->enctype
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:26 -0500
Message-ID: <167380328671.10651.3964178085310392456.stgit@bazille.1015granger.net>
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

Replace another switch on encryption type so that it does not have
to be modified when adding or removing support for an enctype.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c |   30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index f1201478fdd5..68ae0c3d4cf7 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -75,6 +75,7 @@ struct gss_krb5_enctype {
 	u32 (*decrypt) (struct crypto_sync_skcipher *tfm,
 			void *iv, void *in, void *out,
 			int length);		/* decryption function */
+	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
 	u32 (*mk_key) (const struct gss_krb5_enctype *gk5e,
 		       struct xdr_netobj *in,
 		       struct xdr_netobj *out);	/* complete key generation */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 0a831b5cea6b..e33575216a01 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -28,7 +28,11 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
-static struct gss_api_mech gss_kerberos_mech;	/* forward declaration */
+static struct gss_api_mech gss_kerberos_mech;
+
+static int gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask);
+static int gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask);
+static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
 
 static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 #ifndef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
@@ -43,6 +47,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "md5",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
+	  .import_ctx = gss_krb5_import_ctx_des,
 	  .mk_key = NULL,
 	  .get_mic = gss_krb5_get_mic_v1,
 	  .verify_mic = gss_krb5_verify_mic_v1,
@@ -67,6 +72,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
+	  .import_ctx = gss_krb5_import_ctx_v1,
 	  .mk_key = gss_krb5_des3_make_key,
 	  .get_mic = gss_krb5_get_mic_v1,
 	  .verify_mic = gss_krb5_verify_mic_v1,
@@ -91,6 +97,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
+	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
 	  .decrypt_v2 = gss_krb5_aes_decrypt,
@@ -119,6 +126,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
+	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
 	  .decrypt_v2 = gss_krb5_aes_decrypt,
@@ -324,7 +332,13 @@ set_cdata(u8 cdata[GSS_KRB5_K5CLENGTH], u32 usage, u8 seed)
 }
 
 static int
-context_derive_keys_des3(struct krb5_ctx *ctx, gfp_t gfp_mask)
+gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
+{
+	return -EINVAL;
+}
+
+static int
+gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
 	struct xdr_netobj c, keyin, keyout;
 	u8 cdata[GSS_KRB5_K5CLENGTH];
@@ -384,7 +398,7 @@ gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
 }
 
 static int
-context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
+gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
 	u8 cdata[GSS_KRB5_K5CLENGTH];
 	struct xdr_netobj c = {
@@ -563,15 +577,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	}
 	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
 
-	switch (ctx->enctype) {
-	case ENCTYPE_DES3_CBC_RAW:
-		return context_derive_keys_des3(ctx, gfp_mask);
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return context_derive_keys_new(ctx, gfp_mask);
-	default:
-		return -EINVAL;
-	}
+	return ctx->gk5e->import_ctx(ctx, gfp_mask);
 
 out_err:
 	return PTR_ERR(p);


