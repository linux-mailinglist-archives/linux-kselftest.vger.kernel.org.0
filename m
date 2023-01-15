Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636C66B2E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAORVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAORVN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB3CC06;
        Sun, 15 Jan 2023 09:21:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1484B80B40;
        Sun, 15 Jan 2023 17:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557E9C433D2;
        Sun, 15 Jan 2023 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803268;
        bh=nnW3CFH7g0ZmcQh35+KjnAeqv+QdfIggcyoHzREtwJY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=srzFvxpYIyvpei/uHfrceu2Kq4Qf72nHcJs+RGJ1S1FcgkeAPvbUA4qj/SGGQAYRp
         t3rmzgjg/+ihiW+7QKZspcHjcZqVsopcVeAFxV3ZHecy6ARZLAX5267Hfr+MYjDPXj
         gkg7t6SfkqnkxkYmqD/Lcrz3/DjRyPkZKw+WgbFDURrgGBPNQB4s9VJZckXdyc5qBq
         oHKW1sAil1E3dQiK6qYpeOlkKps4bIjaS1E1rjcv0XwcpcLzz7bwet82mn0CLuloPm
         5a/YtWtzVqyA9le4cI8P27lE5As1cEwcdT/U2TO0g8F5WCQ7NXKq3K390hQuB/GJv8
         k7GaLSkvkr4TA==
Subject: [PATCH v2 08/41] SUNRPC: Obscure Kerberos signing keys
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:07 -0500
Message-ID: <167380326743.10651.7004868288954451006.stgit@bazille.1015granger.net>
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

There's no need to keep the signing keys around if we instead allocate
and key an ahash and keep that. This not only enables the subkeys to
be destroyed immediately after deriving them, but it makes the
Kerberos signing code path more efficient.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |    5 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   70 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_internal.h |    4 ++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   37 ++++++++++++----
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   30 +++++--------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |   29 ++++++-------
 6 files changed, 127 insertions(+), 48 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 46eaa2ee9c21..9d897f1ac85a 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -102,14 +102,14 @@ struct krb5_ctx {
 	struct crypto_sync_skcipher *initiator_enc;
 	struct crypto_sync_skcipher *acceptor_enc_aux;
 	struct crypto_sync_skcipher *initiator_enc_aux;
+	struct crypto_ahash	*acceptor_sign;
+	struct crypto_ahash	*initiator_sign;
 	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
 	u8			cksum[GSS_KRB5_MAX_KEYLEN];
 	atomic_t		seq_send;
 	atomic64_t		seq_send64;
 	time64_t		endtime;
 	struct xdr_netobj	mech_used;
-	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
-	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
 	u8			initiator_integ[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
 };
@@ -252,7 +252,6 @@ u32
 gss_unwrap_kerberos(struct gss_ctx *ctx_id, int offset, int len,
 		struct xdr_buf *buf);
 
-
 u32
 krb5_encrypt(struct crypto_sync_skcipher *key,
 	     void *iv, void *in, void *out, int length);
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 7c06c11e452c..44dfcd5f6cbe 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -346,6 +346,76 @@ make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
 	return err ? GSS_S_FAILURE : 0;
 }
 
+/**
+ * gss_krb5_checksum - Compute the MAC for a GSS Wrap or MIC token
+ * @tfm: an initialized hash transform
+ * @header: pointer to a buffer containing the token header, or NULL
+ * @hdrlen: number of octets in @header
+ * @body: xdr_buf containing an RPC message (body.len is the message length)
+ * @body_offset: byte offset into @body to start checksumming
+ * @cksumout: OUT: a buffer to be filled in with the computed HMAC
+ *
+ * Usually expressed as H = HMAC(K, message)[1..h] .
+ *
+ * Caller provides the truncation length of the output token (h) in
+ * cksumout.len.
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Digest computed, @cksumout filled in
+ *   %GSS_S_FAILURE: Call failed
+ */
+u32
+gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
+		  const struct xdr_buf *body, int body_offset,
+		  struct xdr_netobj *cksumout)
+{
+	struct ahash_request *req;
+	int err = -ENOMEM;
+	u8 *checksumdata;
+
+	checksumdata = kmalloc(crypto_ahash_digestsize(tfm), GFP_KERNEL);
+	if (!checksumdata)
+		return GSS_S_FAILURE;
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto out_free_cksum;
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	err = crypto_ahash_init(req);
+	if (err)
+		goto out_free_ahash;
+
+	/*
+	 * Per RFC 4121 Section 4.2.4, the checksum is performed over the
+	 * data body first, then over the octets in "header".
+	 */
+	err = xdr_process_buf(body, body_offset, body->len - body_offset,
+			      checksummer, req);
+	if (err)
+		goto out_free_ahash;
+	if (header) {
+		struct scatterlist sg[1];
+
+		sg_init_one(sg, header, hdrlen);
+		ahash_request_set_crypt(req, sg, NULL, hdrlen);
+		err = crypto_ahash_update(req);
+		if (err)
+			goto out_free_ahash;
+	}
+
+	ahash_request_set_crypt(req, NULL, checksumdata, 0);
+	err = crypto_ahash_final(req);
+	if (err)
+		goto out_free_ahash;
+	memcpy(cksumout->data, checksumdata, cksumout->len);
+
+out_free_ahash:
+	ahash_request_free(req);
+out_free_cksum:
+	kfree_sensitive(checksumdata);
+	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
+}
+
 struct encryptor_desc {
 	u8 iv[GSS_KRB5_MAX_BLOCKSIZE];
 	struct skcipher_request *req;
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 16a83d507075..42f7fd0bbf3a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -10,4 +10,8 @@
 
 void krb5_make_confounder(u8 *p, int conflen);
 
+u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
+		      const struct xdr_buf *body, int body_offset,
+		      struct xdr_netobj *cksumout);
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 8bc24c0684cb..5478f741287e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -347,6 +347,21 @@ context_derive_keys_des3(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	return -EINVAL;
 }
 
+static struct crypto_ahash *
+gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
+{
+	struct crypto_ahash *tfm;
+
+	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return NULL;
+	if (crypto_ahash_setkey(tfm, key->data, key->len)) {
+		crypto_free_ahash(tfm);
+		return NULL;
+	}
+	return tfm;
+}
+
 static int
 context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
@@ -414,23 +429,21 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 
 	/* initiator sign checksum */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	keyout.data = ctx->initiator_sign;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving initiator_sign key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->initiator_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->initiator_sign == NULL)
 		goto out_free;
-	}
 
 	/* acceptor sign checksum */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	keyout.data = ctx->acceptor_sign;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving acceptor_sign key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->acceptor_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->acceptor_sign == NULL)
 		goto out_free;
-	}
 
 	/* initiator seal integrity */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
@@ -458,6 +471,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	return ret;
 
 out_free:
+	crypto_free_ahash(ctx->acceptor_sign);
+	crypto_free_ahash(ctx->initiator_sign);
 	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(ctx->acceptor_enc);
 	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
@@ -581,6 +596,8 @@ gss_delete_sec_context_kerberos(void *internal_ctx) {
 	crypto_free_sync_skcipher(kctx->initiator_enc);
 	crypto_free_sync_skcipher(kctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(kctx->initiator_enc_aux);
+	crypto_free_ahash(kctx->acceptor_sign);
+	crypto_free_ahash(kctx->initiator_sign);
 	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 33061417ec97..1d6f8a345354 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -65,6 +65,8 @@
 #include <linux/crypto.h>
 #include <linux/atomic.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
@@ -166,14 +168,14 @@ static u32
 gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 		struct xdr_netobj *token)
 {
-	char cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj cksumobj = { .len = sizeof(cksumdata),
-				       .data = cksumdata};
+	struct crypto_ahash *tfm = ctx->initiate ?
+				   ctx->initiator_sign : ctx->acceptor_sign;
+	struct xdr_netobj cksumobj = {
+		.len =	ctx->gk5e->cksumlength,
+	};
+	__be64 seq_send_be64;
 	void *krb5_hdr;
 	time64_t now;
-	u8 *cksumkey;
-	unsigned int cksum_usage;
-	__be64 seq_send_be64;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -184,22 +186,12 @@ gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 	seq_send_be64 = cpu_to_be64(atomic64_fetch_inc(&ctx->seq_send64));
 	memcpy(krb5_hdr + 8, (char *) &seq_send_be64, 8);
 
-	if (ctx->initiate) {
-		cksumkey = ctx->initiator_sign;
-		cksum_usage = KG_USAGE_INITIATOR_SIGN;
-	} else {
-		cksumkey = ctx->acceptor_sign;
-		cksum_usage = KG_USAGE_ACCEPTOR_SIGN;
-	}
-
-	if (make_checksum_v2(ctx, krb5_hdr, GSS_KRB5_TOK_HDR_LEN,
-			     text, 0, cksumkey, cksum_usage, &cksumobj))
+	cksumobj.data = krb5_hdr + GSS_KRB5_TOK_HDR_LEN;
+	if (gss_krb5_checksum(tfm, krb5_hdr, GSS_KRB5_TOK_HDR_LEN,
+			      text, 0, &cksumobj))
 		return GSS_S_FAILURE;
 
-	memcpy(krb5_hdr + GSS_KRB5_TOK_HDR_LEN, cksumobj.data, cksumobj.len);
-
 	now = ktime_get_real_seconds();
-
 	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index ba04e3ec970a..d52103f1203b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -57,11 +57,14 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <crypto/algapi.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/crypto.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
@@ -146,16 +149,18 @@ static u32
 gss_verify_mic_v2(struct krb5_ctx *ctx,
 		struct xdr_buf *message_buffer, struct xdr_netobj *read_token)
 {
+	struct crypto_ahash *tfm = ctx->initiate ?
+				   ctx->acceptor_sign : ctx->initiator_sign;
 	char cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj cksumobj = {.len = sizeof(cksumdata),
-				      .data = cksumdata};
-	time64_t now;
+	struct xdr_netobj cksumobj = {
+		.len	= ctx->gk5e->cksumlength,
+		.data	= cksumdata,
+	};
 	u8 *ptr = read_token->data;
-	u8 *cksumkey;
+	__be16 be16_ptr;
+	time64_t now;
 	u8 flags;
 	int i;
-	unsigned int cksum_usage;
-	__be16 be16_ptr;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -177,16 +182,8 @@ gss_verify_mic_v2(struct krb5_ctx *ctx,
 		if (ptr[i] != 0xff)
 			return GSS_S_DEFECTIVE_TOKEN;
 
-	if (ctx->initiate) {
-		cksumkey = ctx->acceptor_sign;
-		cksum_usage = KG_USAGE_ACCEPTOR_SIGN;
-	} else {
-		cksumkey = ctx->initiator_sign;
-		cksum_usage = KG_USAGE_INITIATOR_SIGN;
-	}
-
-	if (make_checksum_v2(ctx, ptr, GSS_KRB5_TOK_HDR_LEN, message_buffer, 0,
-			     cksumkey, cksum_usage, &cksumobj))
+	if (gss_krb5_checksum(tfm, ptr, GSS_KRB5_TOK_HDR_LEN,
+			      message_buffer, 0, &cksumobj))
 		return GSS_S_FAILURE;
 
 	if (memcmp(cksumobj.data, ptr + GSS_KRB5_TOK_HDR_LEN,


