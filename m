Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43B66B2E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjAORVU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjAORVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5976BB;
        Sun, 15 Jan 2023 09:21:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B456B80B8A;
        Sun, 15 Jan 2023 17:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3EAC433EF;
        Sun, 15 Jan 2023 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803275;
        bh=MQKEK+NB4l90V6YRHXnGMlvDNc5U5ILcRl5LIL4YP04=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AkTHU3lx6DhYX1ZwxgIfmgj86QM9JkjF60Bt5H5ho06yHVscv+hEWc2XsjHSustqb
         HRwfykl/z535wAneaGFfYrjUTIkspq6cMj6VlfdexO9wbFrvVM3em2r09aYUELvdOH
         FiLSUGTKqlm7YZTrfERGMJsMxWX5RerzR34DhBbhy8ePljkc9NFFr0sZDTEX6gNhIi
         JODOsGuSdr5YfCog7kIkPIGqYPuEpO5SewjDIFkN156CFG7F2lLSy1u/bTqCyiWmps
         De7zIrP63PlLpToW3Xmy863C7UEdu7cPHQ6AvRhz3Nw6/dVBFIJIexOdA2y8jOiWRf
         zrW1Dzls/NlUw==
Subject: [PATCH v2 09/41] SUNRPC: Obscure Kerberos integrity keys
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:13 -0500
Message-ID: <167380327383.10651.15753244229923642363.stgit@bazille.1015granger.net>
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

There's no need to keep the integrity keys around if we instead
allocate and key a pair of ahashes and keep those. This not only
enables the subkeys to be destroyed immediately after deriving
them, but it makes the Kerberos integrity code path more efficient.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h       |    9 +--
 net/sunrpc/auth_gss/gss_krb5_crypto.c |  116 +++------------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c   |   22 +++---
 3 files changed, 23 insertions(+), 124 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 9d897f1ac85a..85e65232bb61 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -104,14 +104,14 @@ struct krb5_ctx {
 	struct crypto_sync_skcipher *initiator_enc_aux;
 	struct crypto_ahash	*acceptor_sign;
 	struct crypto_ahash	*initiator_sign;
+	struct crypto_ahash	*initiator_integ;
+	struct crypto_ahash	*acceptor_integ;
 	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
 	u8			cksum[GSS_KRB5_MAX_KEYLEN];
 	atomic_t		seq_send;
 	atomic64_t		seq_send64;
 	time64_t		endtime;
 	struct xdr_netobj	mech_used;
-	u8			initiator_integ[GSS_KRB5_MAX_KEYLEN];
-	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
 };
 
 /* The length of the Kerberos GSS token header */
@@ -233,11 +233,6 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 		struct xdr_buf *body, int body_offset, u8 *cksumkey,
 		unsigned int usage, struct xdr_netobj *cksumout);
 
-u32
-make_checksum_v2(struct krb5_ctx *, char *header, int hdrlen,
-		 struct xdr_buf *body, int body_offset, u8 *key,
-		 unsigned int usage, struct xdr_netobj *cksum);
-
 u32 gss_get_mic_kerberos(struct gss_ctx *, struct xdr_buf *,
 		struct xdr_netobj *);
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 44dfcd5f6cbe..098faaf02fe6 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -259,93 +259,6 @@ make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
 	return err ? GSS_S_FAILURE : 0;
 }
 
-/*
- * checksum the plaintext data and hdrlen bytes of the token header
- * Per rfc4121, sec. 4.2.4, the checksum is performed over the data
- * body then over the first 16 octets of the MIC token
- * Inclusion of the header data in the calculation of the
- * checksum is optional.
- */
-u32
-make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
-		 struct xdr_buf *body, int body_offset, u8 *cksumkey,
-		 unsigned int usage, struct xdr_netobj *cksumout)
-{
-	struct crypto_ahash *tfm;
-	struct ahash_request *req;
-	struct scatterlist sg[1];
-	int err = -1;
-	u8 *checksumdata;
-
-	if (kctx->gk5e->keyed_cksum == 0) {
-		dprintk("%s: expected keyed hash for %s\n",
-			__func__, kctx->gk5e->name);
-		return GSS_S_FAILURE;
-	}
-	if (cksumkey == NULL) {
-		dprintk("%s: no key supplied for %s\n",
-			__func__, kctx->gk5e->name);
-		return GSS_S_FAILURE;
-	}
-
-	checksumdata = kmalloc(GSS_KRB5_MAX_CKSUM_LEN, GFP_KERNEL);
-	if (!checksumdata)
-		return GSS_S_FAILURE;
-
-	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		goto out_free_cksum;
-
-	req = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!req)
-		goto out_free_ahash;
-
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
-
-	err = crypto_ahash_setkey(tfm, cksumkey, kctx->gk5e->keylength);
-	if (err)
-		goto out;
-
-	err = crypto_ahash_init(req);
-	if (err)
-		goto out;
-	err = xdr_process_buf(body, body_offset, body->len - body_offset,
-			      checksummer, req);
-	if (err)
-		goto out;
-	if (header != NULL) {
-		sg_init_one(sg, header, hdrlen);
-		ahash_request_set_crypt(req, sg, NULL, hdrlen);
-		err = crypto_ahash_update(req);
-		if (err)
-			goto out;
-	}
-	ahash_request_set_crypt(req, NULL, checksumdata, 0);
-	err = crypto_ahash_final(req);
-	if (err)
-		goto out;
-
-	cksumout->len = kctx->gk5e->cksumlength;
-
-	switch (kctx->gk5e->ctype) {
-	case CKSUMTYPE_HMAC_SHA1_96_AES128:
-	case CKSUMTYPE_HMAC_SHA1_96_AES256:
-		/* note that this truncates the hash */
-		memcpy(cksumout->data, checksumdata, kctx->gk5e->cksumlength);
-		break;
-	default:
-		BUG();
-		break;
-	}
-out:
-	ahash_request_free(req);
-out_free_ahash:
-	crypto_free_ahash(tfm);
-out_free_cksum:
-	kfree(checksumdata);
-	return err ? GSS_S_FAILURE : 0;
-}
-
 /**
  * gss_krb5_checksum - Compute the MAC for a GSS Wrap or MIC token
  * @tfm: an initialized hash transform
@@ -702,27 +615,24 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 {
 	u32 err;
 	struct xdr_netobj hmac;
-	u8 *cksumkey;
 	u8 *ecptr;
 	struct crypto_sync_skcipher *cipher, *aux_cipher;
+	struct crypto_ahash *ahash;
 	int blocksize;
 	struct page **save_pages;
 	int nblocks, nbytes;
 	struct encryptor_desc desc;
 	u32 cbcbytes;
-	unsigned int usage;
 	unsigned int conflen;
 
 	if (kctx->initiate) {
 		cipher = kctx->initiator_enc;
 		aux_cipher = kctx->initiator_enc_aux;
-		cksumkey = kctx->initiator_integ;
-		usage = KG_USAGE_INITIATOR_SEAL;
+		ahash = kctx->initiator_integ;
 	} else {
 		cipher = kctx->acceptor_enc;
 		aux_cipher = kctx->acceptor_enc_aux;
-		cksumkey = kctx->acceptor_integ;
-		usage = KG_USAGE_ACCEPTOR_SEAL;
+		ahash = kctx->acceptor_integ;
 	}
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
 	conflen = crypto_sync_skcipher_blocksize(cipher);
@@ -762,9 +672,8 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	save_pages = buf->pages;
 	buf->pages = pages;
 
-	err = make_checksum_v2(kctx, NULL, 0, buf,
-			       offset + GSS_KRB5_TOK_HDR_LEN,
-			       cksumkey, usage, &hmac);
+	err = gss_krb5_checksum(ahash, NULL, 0, buf,
+				offset + GSS_KRB5_TOK_HDR_LEN, &hmac);
 	buf->pages = save_pages;
 	if (err)
 		return GSS_S_FAILURE;
@@ -825,25 +734,22 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 {
 	struct xdr_buf subbuf;
 	u32 ret = 0;
-	u8 *cksum_key;
 	struct crypto_sync_skcipher *cipher, *aux_cipher;
+	struct crypto_ahash *ahash;
 	struct xdr_netobj our_hmac_obj;
 	u8 our_hmac[GSS_KRB5_MAX_CKSUM_LEN];
 	u8 pkt_hmac[GSS_KRB5_MAX_CKSUM_LEN];
 	int nblocks, blocksize, cbcbytes;
 	struct decryptor_desc desc;
-	unsigned int usage;
 
 	if (kctx->initiate) {
 		cipher = kctx->acceptor_enc;
 		aux_cipher = kctx->acceptor_enc_aux;
-		cksum_key = kctx->acceptor_integ;
-		usage = KG_USAGE_ACCEPTOR_SEAL;
+		ahash = kctx->acceptor_integ;
 	} else {
 		cipher = kctx->initiator_enc;
 		aux_cipher = kctx->initiator_enc_aux;
-		cksum_key = kctx->initiator_integ;
-		usage = KG_USAGE_INITIATOR_SEAL;
+		ahash = kctx->initiator_integ;
 	}
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
 
@@ -883,13 +789,9 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 	if (ret)
 		goto out_err;
 
-
-	/* Calculate our hmac over the plaintext data */
 	our_hmac_obj.len = sizeof(our_hmac);
 	our_hmac_obj.data = our_hmac;
-
-	ret = make_checksum_v2(kctx, NULL, 0, &subbuf, 0,
-			       cksum_key, usage, &our_hmac_obj);
+	ret = gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac_obj);
 	if (ret)
 		goto out_err;
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 5478f741287e..2237f640cef4 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -447,23 +447,21 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 
 	/* initiator seal integrity */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
-	keyout.data = ctx->initiator_integ;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving initiator_integ key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->initiator_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->initiator_integ == NULL)
 		goto out_free;
-	}
 
 	/* acceptor seal integrity */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
-	keyout.data = ctx->acceptor_integ;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving acceptor_integ key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->acceptor_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->acceptor_integ == NULL)
 		goto out_free;
-	}
 
 	ret = 0;
 out:
@@ -471,6 +469,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	return ret;
 
 out_free:
+	crypto_free_ahash(ctx->acceptor_integ);
+	crypto_free_ahash(ctx->initiator_integ);
 	crypto_free_ahash(ctx->acceptor_sign);
 	crypto_free_ahash(ctx->initiator_sign);
 	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
@@ -598,6 +598,8 @@ gss_delete_sec_context_kerberos(void *internal_ctx) {
 	crypto_free_sync_skcipher(kctx->initiator_enc_aux);
 	crypto_free_ahash(kctx->acceptor_sign);
 	crypto_free_ahash(kctx->initiator_sign);
+	crypto_free_ahash(kctx->acceptor_integ);
+	crypto_free_ahash(kctx->initiator_integ);
 	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }


