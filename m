Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7166B2F8
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAORWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAORWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145261041F;
        Sun, 15 Jan 2023 09:22:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B4460D2C;
        Sun, 15 Jan 2023 17:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7BC433EF;
        Sun, 15 Jan 2023 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803326;
        bh=fdxfG1V/an43K0pC0d61OfVIocyesxCbah/o9TmeYOI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JYOLknoTfLYcn8VsaCzXw0If34xzuvb3gyJA53zbspQjE/q7HYRJvokim7touwFJF
         A6qhRlIK951go5X9EWBRe/+3uPOgDG4heCzZwAQAIKv14lrZinLMGnoRZZJCbtO3Y9
         4/gKl04mKZtMNhFYLS7TH/IblLqNWXEZQJeopt8zXnAMu37ibtJAPL7+vrPEk2qZzB
         TP73ACnArRlhctvK8IypIX2DtyKqe4AG5A/YcRLt08tFamLNHD/SYAaacQcNOuTdKU
         Jqg2kLk0YnE1PJdsQ1ceNdb7OknBVgsZ/kKMKhEpaPHzUJ7TbNzhr8pnOnMDWXj+pX
         bzg8vcIbedrcg==
Subject: [PATCH v2 17/41] SUNRPC: Rename .encrypt_v2 and .decrypt_v2 methods
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:04 -0500
Message-ID: <167380332492.10651.16562721216705849288.stgit@bazille.1015granger.net>
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

Clean up: there is now only one encrypt and only one decrypt method,
thus there is no longer a need for the v2-suffixed method names.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |   20 ++++----------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 ++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    8 ++++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   12 +++---------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index a0646df12beb..85fce36c242d 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -73,12 +73,10 @@ struct gss_krb5_enctype {
 	u32 (*mk_key) (const struct gss_krb5_enctype *gk5e,
 		       struct xdr_netobj *in,
 		       struct xdr_netobj *out);	/* complete key generation */
-	u32 (*encrypt_v2) (struct krb5_ctx *kctx, u32 offset,
-			   struct xdr_buf *buf,
-			   struct page **pages); /* v2 encryption function */
-	u32 (*decrypt_v2) (struct krb5_ctx *kctx, u32 offset, u32 len,
-			   struct xdr_buf *buf, u32 *headskip,
-			   u32 *tailskip);	/* v2 decryption function */
+	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
+			struct xdr_buf *buf, struct page **pages);
+	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
+		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
 	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
 		       struct xdr_netobj *token);
 	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
@@ -276,14 +274,4 @@ gss_krb5_aes_make_key(const struct gss_krb5_enctype *gk5e,
 		      struct xdr_netobj *randombits,
 		      struct xdr_netobj *key);
 
-u32
-gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
-		     struct xdr_buf *buf,
-		     struct page **pages);
-
-u32
-gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
-		     struct xdr_buf *buf, u32 *plainoffset,
-		     u32 *plainlen);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index a4b752af6951..837bcfa3742f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -50,4 +50,10 @@ u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 		 void *out, int length);
 
+u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
+			 struct xdr_buf *buf, struct page **pages);
+
+u32 gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+			 struct xdr_buf *buf, u32 *plainoffset, u32 *plainlen);
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 47c065aa4a14..9f393175a276 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -98,8 +98,8 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
-	  .encrypt_v2 = gss_krb5_aes_encrypt,
-	  .decrypt_v2 = gss_krb5_aes_decrypt,
+	  .encrypt = gss_krb5_aes_encrypt,
+	  .decrypt = gss_krb5_aes_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
 	  .verify_mic = gss_krb5_verify_mic_v2,
@@ -125,8 +125,8 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .mk_key = gss_krb5_aes_make_key,
-	  .encrypt_v2 = gss_krb5_aes_encrypt,
-	  .decrypt_v2 = gss_krb5_aes_decrypt,
+	  .encrypt = gss_krb5_aes_encrypt,
+	  .decrypt = gss_krb5_aes_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
 	  .verify_mic = gss_krb5_verify_mic_v2,
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 7dabf379406b..6d6b082380b2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -390,9 +390,6 @@ gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
 
 	dprintk("RPC:       %s\n", __func__);
 
-	if (kctx->gk5e->encrypt_v2 == NULL)
-		return GSS_S_FAILURE;
-
 	/* make room for gss token header */
 	if (xdr_extend_head(buf, offset, GSS_KRB5_TOK_HDR_LEN))
 		return GSS_S_FAILURE;
@@ -420,7 +417,7 @@ gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
 	be64ptr = (__be64 *)be16ptr;
 	*be64ptr = cpu_to_be64(atomic64_fetch_inc(&kctx->seq_send64));
 
-	err = (*kctx->gk5e->encrypt_v2)(kctx, offset, buf, pages);
+	err = (*kctx->gk5e->encrypt)(kctx, offset, buf, pages);
 	if (err)
 		return err;
 
@@ -445,9 +442,6 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 
 	dprintk("RPC:       %s\n", __func__);
 
-	if (kctx->gk5e->decrypt_v2 == NULL)
-		return GSS_S_FAILURE;
-
 	ptr = buf->head[0].iov_base + offset;
 
 	if (be16_to_cpu(*((__be16 *)ptr)) != KG2_TOK_WRAP)
@@ -477,8 +471,8 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 	if (rrc != 0)
 		rotate_left(offset + 16, buf, rrc);
 
-	err = (*kctx->gk5e->decrypt_v2)(kctx, offset, len, buf,
-					&headskip, &tailskip);
+	err = (*kctx->gk5e->decrypt)(kctx, offset, len, buf,
+				     &headskip, &tailskip);
 	if (err)
 		return GSS_S_FAILURE;
 


