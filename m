Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2D66B2E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAORV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAORV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90076BB;
        Sun, 15 Jan 2023 09:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D716CB80B40;
        Sun, 15 Jan 2023 17:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E1C433EF;
        Sun, 15 Jan 2023 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803281;
        bh=yaezsZUQ0vghQbTmuCWd+CvVFy5/qx/bje0IqEp6Lmw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WWteM+iej9iismfql245snv7S8YkRMJRprPsMlNHJ8hsYnQemTgM+uxUp8HkFigqj
         /ZZZb4YVtviup4hhtLBNJs63H9HTlHi+KngDW0R/FxId+6IgNX3CLAFzyeijCyMR1V
         tvOzKJxcDC7DSFZzd7ICSR0SVn6+Zq2DmrpHt43Cv4va87Ck2OtPtPWYjgbkUmRogY
         A8rdhZOxhfnKbmtYR1P7ZGrwrOwGpmjSZizwkkwz0lT16wGomkHYePO75QerzQ+mO8
         IFr+pkYPlF4vbYtqtrvt2+59/ANvWNK5sW6hf7lKpZOJtptYyf2HgNBnYVRcqW5jQu
         W/I7lnbddCdsA==
Subject: [PATCH v2 10/41] SUNRPC: Refactor the GSS-API Per Message calls in
 the Kerberos mechanism
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:20 -0500
Message-ID: <167380328023.10651.13187566932509778409.stgit@bazille.1015granger.net>
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

Replace a number of switches on encryption type so that all of them don't
have to be modified when adding or removing support for an enctype.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |   23 ++----
 net/sunrpc/auth_gss/gss_krb5_internal.h |   30 +++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |  126 ++++++++++++++++++++++++++++---
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   30 +------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |   31 +-------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   66 +++-------------
 6 files changed, 180 insertions(+), 126 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 85e65232bb61..f1201478fdd5 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -84,6 +84,15 @@ struct gss_krb5_enctype {
 	u32 (*decrypt_v2) (struct krb5_ctx *kctx, u32 offset, u32 len,
 			   struct xdr_buf *buf, u32 *headskip,
 			   u32 *tailskip);	/* v2 decryption function */
+	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
+		       struct xdr_netobj *token);
+	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
+			  struct xdr_netobj *read_token);
+	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
+		    struct xdr_buf *buf, struct page **pages);
+	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
+		      struct xdr_buf *buf, unsigned int *slack,
+		      unsigned int *align);
 };
 
 /* krb5_ctx flags definitions */
@@ -233,20 +242,6 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 		struct xdr_buf *body, int body_offset, u8 *cksumkey,
 		unsigned int usage, struct xdr_netobj *cksumout);
 
-u32 gss_get_mic_kerberos(struct gss_ctx *, struct xdr_buf *,
-		struct xdr_netobj *);
-
-u32 gss_verify_mic_kerberos(struct gss_ctx *, struct xdr_buf *,
-		struct xdr_netobj *);
-
-u32
-gss_wrap_kerberos(struct gss_ctx *ctx_id, int offset,
-		struct xdr_buf *outbuf, struct page **pages);
-
-u32
-gss_unwrap_kerberos(struct gss_ctx *ctx_id, int offset, int len,
-		struct xdr_buf *buf);
-
 u32
 krb5_encrypt(struct crypto_sync_skcipher *key,
 	     void *iv, void *in, void *out, int length);
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 42f7fd0bbf3a..04d2781e2ce2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -8,6 +8,36 @@
 #ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 #define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 
+/*
+ * GSS Kerberos 5 mechanism Per-Message calls.
+ */
+
+u32 gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
+			struct xdr_netobj *token);
+u32 gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
+			struct xdr_netobj *token);
+
+u32 gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
+			   struct xdr_netobj *read_token);
+u32 gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
+			   struct xdr_netobj *read_token);
+
+u32 gss_krb5_wrap_v1(struct krb5_ctx *kctx, int offset,
+		     struct xdr_buf *buf, struct page **pages);
+u32 gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
+		     struct xdr_buf *buf, struct page **pages);
+
+u32 gss_krb5_unwrap_v1(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align);
+u32 gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align);
+
+/*
+ * Implementation internal functions
+ */
+
 void krb5_make_confounder(u8 *p, int conflen);
 
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 2237f640cef4..0a831b5cea6b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -22,6 +22,7 @@
 #include <linux/sunrpc/gss_krb5_enctypes.h>
 
 #include "auth_gss_internal.h"
+#include "gss_krb5_internal.h"
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY	RPCDBG_AUTH
@@ -43,6 +44,10 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
 	  .mk_key = NULL,
+	  .get_mic = gss_krb5_get_mic_v1,
+	  .verify_mic = gss_krb5_verify_mic_v1,
+	  .wrap = gss_krb5_wrap_v1,
+	  .unwrap = gss_krb5_unwrap_v1,
 	  .signalg = SGN_ALG_DES_MAC_MD5,
 	  .sealalg = SEAL_ALG_DES,
 	  .keybytes = 7,
@@ -63,6 +68,10 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = krb5_encrypt,
 	  .decrypt = krb5_decrypt,
 	  .mk_key = gss_krb5_des3_make_key,
+	  .get_mic = gss_krb5_get_mic_v1,
+	  .verify_mic = gss_krb5_verify_mic_v1,
+	  .wrap = gss_krb5_wrap_v1,
+	  .unwrap = gss_krb5_unwrap_v1,
 	  .signalg = SGN_ALG_HMAC_SHA1_DES3_KD,
 	  .sealalg = SEAL_ALG_DES3KD,
 	  .keybytes = 21,
@@ -85,6 +94,12 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
 	  .decrypt_v2 = gss_krb5_aes_decrypt,
+
+	  .get_mic = gss_krb5_get_mic_v2,
+	  .verify_mic = gss_krb5_verify_mic_v2,
+	  .wrap = gss_krb5_wrap_v2,
+	  .unwrap = gss_krb5_unwrap_v2,
+
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 16,
@@ -107,6 +122,12 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .mk_key = gss_krb5_aes_make_key,
 	  .encrypt_v2 = gss_krb5_aes_encrypt,
 	  .decrypt_v2 = gss_krb5_aes_decrypt,
+
+	  .get_mic = gss_krb5_get_mic_v2,
+	  .verify_mic = gss_krb5_verify_mic_v2,
+	  .wrap = gss_krb5_wrap_v2,
+	  .unwrap = gss_krb5_unwrap_v2,
+
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 32,
@@ -557,10 +578,8 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 }
 
 static int
-gss_import_sec_context_kerberos(const void *p, size_t len,
-				struct gss_ctx *ctx_id,
-				time64_t *endtime,
-				gfp_t gfp_mask)
+gss_krb5_import_sec_context(const void *p, size_t len, struct gss_ctx *ctx_id,
+			    time64_t *endtime, gfp_t gfp_mask)
 {
 	const void *end = (const void *)((const char *)p + len);
 	struct  krb5_ctx *ctx;
@@ -587,7 +606,8 @@ gss_import_sec_context_kerberos(const void *p, size_t len,
 }
 
 static void
-gss_delete_sec_context_kerberos(void *internal_ctx) {
+gss_krb5_delete_sec_context(void *internal_ctx)
+{
 	struct krb5_ctx *kctx = internal_ctx;
 
 	crypto_free_sync_skcipher(kctx->seq);
@@ -604,13 +624,97 @@ gss_delete_sec_context_kerberos(void *internal_ctx) {
 	kfree(kctx);
 }
 
+/**
+ * gss_krb5_get_mic - get_mic for the Kerberos GSS mechanism
+ * @gctx: GSS context
+ * @text: plaintext to checksum
+ * @token: buffer into which to write the computed checksum
+ *
+ * Return values:
+ *    %GSS_S_COMPLETE - success, and @token is filled in
+ *    %GSS_S_FAILURE - checksum could not be generated
+ *    %GSS_S_CONTEXT_EXPIRED - Kerberos context is no longer valid
+ */
+static u32 gss_krb5_get_mic(struct gss_ctx *gctx, struct xdr_buf *text,
+			    struct xdr_netobj *token)
+{
+	struct krb5_ctx *kctx = gctx->internal_ctx_id;
+
+	return kctx->gk5e->get_mic(kctx, text, token);
+}
+
+/**
+ * gss_krb5_verify_mic - verify_mic for the Kerberos GSS mechanism
+ * @gctx: GSS context
+ * @message_buffer: plaintext to check
+ * @read_token: received checksum to check
+ *
+ * Return values:
+ *    %GSS_S_COMPLETE - computed and received checksums match
+ *    %GSS_S_DEFECTIVE_TOKEN - received checksum is not valid
+ *    %GSS_S_BAD_SIG - computed and received checksums do not match
+ *    %GSS_S_FAILURE - received checksum could not be checked
+ *    %GSS_S_CONTEXT_EXPIRED - Kerberos context is no longer valid
+ */
+static u32 gss_krb5_verify_mic(struct gss_ctx *gctx,
+			       struct xdr_buf *message_buffer,
+			       struct xdr_netobj *read_token)
+{
+	struct krb5_ctx *kctx = gctx->internal_ctx_id;
+
+	return kctx->gk5e->verify_mic(kctx, message_buffer, read_token);
+}
+
+/**
+ * gss_krb5_wrap - gss_wrap for the Kerberos GSS mechanism
+ * @gctx: initialized GSS context
+ * @offset: byte offset in @buf to start writing the cipher text
+ * @buf: OUT: send buffer
+ * @pages: plaintext to wrap
+ *
+ * Return values:
+ *    %GSS_S_COMPLETE - success, @buf has been updated
+ *    %GSS_S_FAILURE - @buf could not be wrapped
+ *    %GSS_S_CONTEXT_EXPIRED - Kerberos context is no longer valid
+ */
+static u32 gss_krb5_wrap(struct gss_ctx *gctx, int offset,
+			 struct xdr_buf *buf, struct page **pages)
+{
+	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
+
+	return kctx->gk5e->wrap(kctx, offset, buf, pages);
+}
+
+/**
+ * gss_krb5_unwrap - gss_unwrap for the Kerberos GSS mechanism
+ * @gctx: initialized GSS context
+ * @offset: starting byte offset into @buf
+ * @len: size of ciphertext to unwrap
+ * @buf: ciphertext to unwrap
+ *
+ * Return values:
+ *    %GSS_S_COMPLETE - success, @buf has been updated
+ *    %GSS_S_DEFECTIVE_TOKEN - received blob is not valid
+ *    %GSS_S_BAD_SIG - computed and received checksums do not match
+ *    %GSS_S_FAILURE - @buf could not be unwrapped
+ *    %GSS_S_CONTEXT_EXPIRED - Kerberos context is no longer valid
+ */
+static u32 gss_krb5_unwrap(struct gss_ctx *gctx, int offset,
+			   int len, struct xdr_buf *buf)
+{
+	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
+
+	return kctx->gk5e->unwrap(kctx, offset, len, buf,
+				  &gctx->slack, &gctx->align);
+}
+
 static const struct gss_api_ops gss_kerberos_ops = {
-	.gss_import_sec_context	= gss_import_sec_context_kerberos,
-	.gss_get_mic		= gss_get_mic_kerberos,
-	.gss_verify_mic		= gss_verify_mic_kerberos,
-	.gss_wrap		= gss_wrap_kerberos,
-	.gss_unwrap		= gss_unwrap_kerberos,
-	.gss_delete_sec_context	= gss_delete_sec_context_kerberos,
+	.gss_import_sec_context	= gss_krb5_import_sec_context,
+	.gss_get_mic		= gss_krb5_get_mic,
+	.gss_verify_mic		= gss_krb5_verify_mic,
+	.gss_wrap		= gss_krb5_wrap,
+	.gss_unwrap		= gss_krb5_unwrap,
+	.gss_delete_sec_context	= gss_krb5_delete_sec_context,
 };
 
 static struct pf_desc gss_kerberos_pfs[] = {
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 1d6f8a345354..f74125407588 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -125,9 +125,9 @@ setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
 	return krb5_hdr;
 }
 
-static u32
-gss_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
-		struct xdr_netobj *token)
+u32
+gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
+		    struct xdr_netobj *token)
 {
 	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
 	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
@@ -164,9 +164,9 @@ gss_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
 	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
-static u32
-gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
-		struct xdr_netobj *token)
+u32
+gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
+		    struct xdr_netobj *token)
 {
 	struct crypto_ahash *tfm = ctx->initiate ?
 				   ctx->initiator_sign : ctx->acceptor_sign;
@@ -194,21 +194,3 @@ gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 	now = ktime_get_real_seconds();
 	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
-
-u32
-gss_get_mic_kerberos(struct gss_ctx *gss_ctx, struct xdr_buf *text,
-		     struct xdr_netobj *token)
-{
-	struct krb5_ctx		*ctx = gss_ctx->internal_ctx_id;
-
-	switch (ctx->enctype) {
-	default:
-		BUG();
-	case ENCTYPE_DES_CBC_RAW:
-	case ENCTYPE_DES3_CBC_RAW:
-		return gss_get_mic_v1(ctx, text, token);
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_get_mic_v2(ctx, text, token);
-	}
-}
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index d52103f1203b..939d199eb7b7 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -73,9 +73,9 @@
 /* read_token is a mic token, and message_buffer is the data that the mic was
  * supposedly taken over. */
 
-static u32
-gss_verify_mic_v1(struct krb5_ctx *ctx,
-		struct xdr_buf *message_buffer, struct xdr_netobj *read_token)
+u32
+gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
+		       struct xdr_netobj *read_token)
 {
 	int			signalg;
 	int			sealalg;
@@ -145,9 +145,9 @@ gss_verify_mic_v1(struct krb5_ctx *ctx,
 	return GSS_S_COMPLETE;
 }
 
-static u32
-gss_verify_mic_v2(struct krb5_ctx *ctx,
-		struct xdr_buf *message_buffer, struct xdr_netobj *read_token)
+u32
+gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
+		       struct xdr_netobj *read_token)
 {
 	struct crypto_ahash *tfm = ctx->initiate ?
 				   ctx->acceptor_sign : ctx->initiator_sign;
@@ -202,22 +202,3 @@ gss_verify_mic_v2(struct krb5_ctx *ctx,
 
 	return GSS_S_COMPLETE;
 }
-
-u32
-gss_verify_mic_kerberos(struct gss_ctx *gss_ctx,
-			struct xdr_buf *message_buffer,
-			struct xdr_netobj *read_token)
-{
-	struct krb5_ctx *ctx = gss_ctx->internal_ctx_id;
-
-	switch (ctx->enctype) {
-	default:
-		BUG();
-	case ENCTYPE_DES_CBC_RAW:
-	case ENCTYPE_DES3_CBC_RAW:
-		return gss_verify_mic_v1(ctx, message_buffer, read_token);
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_verify_mic_v2(ctx, message_buffer, read_token);
-	}
-}
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 66e65e4c6336..d983da6f9530 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -122,9 +122,9 @@ gss_krb5_remove_padding(struct xdr_buf *buf, int blocksize)
 
 /* XXX factor out common code with seal/unseal. */
 
-static u32
-gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
-		struct xdr_buf *buf, struct page **pages)
+u32
+gss_krb5_wrap_v1(struct krb5_ctx *kctx, int offset,
+		 struct xdr_buf *buf, struct page **pages)
 {
 	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
 	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
@@ -211,10 +211,10 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 	return (kctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
-static u32
-gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
-		       struct xdr_buf *buf, unsigned int *slack,
-		       unsigned int *align)
+u32
+gss_krb5_unwrap_v1(struct krb5_ctx *kctx, int offset, int len,
+		   struct xdr_buf *buf, unsigned int *slack,
+		   unsigned int *align)
 {
 	int			signalg;
 	int			sealalg;
@@ -373,9 +373,9 @@ static void rotate_left(u32 base, struct xdr_buf *buf, unsigned int shift)
 	_rotate_left(&subbuf, shift);
 }
 
-static u32
-gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
-		     struct xdr_buf *buf, struct page **pages)
+u32
+gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
+		 struct xdr_buf *buf, struct page **pages)
 {
 	u8		*ptr;
 	time64_t	now;
@@ -424,10 +424,10 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
 	return (kctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
-static u32
-gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
-		       struct xdr_buf *buf, unsigned int *slack,
-		       unsigned int *align)
+u32
+gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
+		   struct xdr_buf *buf, unsigned int *slack,
+		   unsigned int *align)
 {
 	time64_t	now;
 	u8		*ptr;
@@ -524,41 +524,3 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
 	*slack = *align + XDR_QUADLEN(ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 	return GSS_S_COMPLETE;
 }
-
-u32
-gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
-		  struct xdr_buf *buf, struct page **pages)
-{
-	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
-
-	switch (kctx->enctype) {
-	default:
-		BUG();
-	case ENCTYPE_DES_CBC_RAW:
-	case ENCTYPE_DES3_CBC_RAW:
-		return gss_wrap_kerberos_v1(kctx, offset, buf, pages);
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_wrap_kerberos_v2(kctx, offset, buf, pages);
-	}
-}
-
-u32
-gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
-		    int len, struct xdr_buf *buf)
-{
-	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
-
-	switch (kctx->enctype) {
-	default:
-		BUG();
-	case ENCTYPE_DES_CBC_RAW:
-	case ENCTYPE_DES3_CBC_RAW:
-		return gss_unwrap_kerberos_v1(kctx, offset, len, buf,
-					      &gctx->slack, &gctx->align);
-	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
-	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
-					      &gctx->slack, &gctx->align);
-	}
-}


