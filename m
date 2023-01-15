Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EA66B301
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjAORWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAORWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA71041F;
        Sun, 15 Jan 2023 09:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C0360D2C;
        Sun, 15 Jan 2023 17:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC2C433F0;
        Sun, 15 Jan 2023 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803358;
        bh=45m96J5KWPKZVW+2fsRJu7bQ5STAd82eJ1NPlWVlSts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I3lUEiuCL4fMu3cRgMv+tfF87EZbhHJh467jqfS5wMn1w8ZlwCCO5UEmFjmGmoaS6
         ZyuukmC68O3NmQmxgNV0KOJKLvpWoMVDc9tCTQuIozhKNRa+9ORJTbxcrxx7DS0HgN
         qDYi5fozfh1qJ2An/PU+AJT/1h4/tROPLPU4nFbjmaMqRW3MaqAmCMB2SFSPUz9nif
         Kczlo56RkcE0MWl4A3Hrn7t0ip8DE0pBKM9/M2ZNNpV9LCFKOH/RIeYCqa8ym0RHR0
         CwGI/e34EnB0B1UctF58TwXEGMcx4m+D4O9XjKEop2lJtD/NUj6tQMeEB1A+K4Mgxz
         DtAk1EjJmzQ5w==
Subject: [PATCH v2 22/41] SUNRPC: Refactor CBC with CTS into helpers
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:36 -0500
Message-ID: <167380335682.10651.15171292873857240391.stgit@bazille.1015granger.net>
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

Cryptosystem profile enctypes all use cipher block chaining
with ciphertext steal (CBC-with-CTS). However enctypes that are
currently supported in the Linux kernel SunRPC implementation
use only the encrypt-&-MAC approach. The RFC 8009 enctypes use
encrypt-then-MAC, which performs encryption and checksumming in
a different order.

Refactor to make it possible to share the CBC with CTS encryption
and decryption mechanisms between e&M and etM enctypes.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |  187 +++++++++++++++++++--------------
 1 file changed, 105 insertions(+), 82 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index c5845fdda527..65c8b6982729 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -641,6 +641,100 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher, struct xdr_buf *buf,
 	return ret;
 }
 
+/*
+ * To provide confidentiality, encrypt using cipher block chaining
+ * with ciphertext stealing. Message integrity is handled separately.
+ */
+static int
+krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
+		     struct crypto_sync_skcipher *cbc_tfm,
+		     u32 offset, struct xdr_buf *buf, struct page **pages)
+{
+	u32 blocksize, nbytes, nblocks, cbcbytes;
+	struct encryptor_desc desc;
+	int err;
+
+	blocksize = crypto_sync_skcipher_blocksize(cts_tfm);
+	nbytes = buf->len - offset;
+	nblocks = (nbytes + blocksize - 1) / blocksize;
+	cbcbytes = 0;
+	if (nblocks > 2)
+		cbcbytes = (nblocks - 2) * blocksize;
+
+	memset(desc.iv, 0, sizeof(desc.iv));
+
+	/* Handle block-sized chunks of plaintext with CBC. */
+	if (cbcbytes) {
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, cbc_tfm);
+
+		desc.pos = offset;
+		desc.fragno = 0;
+		desc.fraglen = 0;
+		desc.pages = pages;
+		desc.outbuf = buf;
+		desc.req = req;
+
+		skcipher_request_set_sync_tfm(req, cbc_tfm);
+		skcipher_request_set_callback(req, 0, NULL, NULL);
+
+		sg_init_table(desc.infrags, 4);
+		sg_init_table(desc.outfrags, 4);
+
+		err = xdr_process_buf(buf, offset, cbcbytes, encryptor, &desc);
+		skcipher_request_zero(req);
+		if (err)
+			return err;
+	}
+
+	/* Remaining plaintext is handled with CBC-CTS. */
+	err = gss_krb5_cts_crypt(cts_tfm, buf, offset + cbcbytes,
+				 desc.iv, pages, 1);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
+		     struct crypto_sync_skcipher *cbc_tfm,
+		     u32 offset, struct xdr_buf *buf)
+{
+	u32 blocksize, nblocks, cbcbytes;
+	struct decryptor_desc desc;
+	int err;
+
+	blocksize = crypto_sync_skcipher_blocksize(cts_tfm);
+	nblocks = (buf->len + blocksize - 1) / blocksize;
+	cbcbytes = 0;
+	if (nblocks > 2)
+		cbcbytes = (nblocks - 2) * blocksize;
+
+	memset(desc.iv, 0, sizeof(desc.iv));
+
+	/* Handle block-sized chunks of plaintext with CBC. */
+	if (cbcbytes) {
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, cbc_tfm);
+
+		desc.fragno = 0;
+		desc.fraglen = 0;
+		desc.req = req;
+
+		skcipher_request_set_sync_tfm(req, cbc_tfm);
+		skcipher_request_set_callback(req, 0, NULL, NULL);
+
+		sg_init_table(desc.frags, 4);
+
+		err = xdr_process_buf(buf, 0, cbcbytes, decryptor, &desc);
+		skcipher_request_zero(req);
+		if (err)
+			return err;
+	}
+
+	/* Remaining plaintext is handled with CBC-CTS. */
+	return gss_krb5_cts_crypt(cts_tfm, buf, cbcbytes, desc.iv, NULL, 0);
+}
+
 u32
 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 		     struct xdr_buf *buf, struct page **pages)
@@ -650,11 +744,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	u8 *ecptr;
 	struct crypto_sync_skcipher *cipher, *aux_cipher;
 	struct crypto_ahash *ahash;
-	int blocksize;
 	struct page **save_pages;
-	int nblocks, nbytes;
-	struct encryptor_desc desc;
-	u32 cbcbytes;
 	unsigned int conflen;
 
 	if (kctx->initiate) {
@@ -666,7 +756,6 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 		aux_cipher = kctx->acceptor_enc_aux;
 		ahash = kctx->acceptor_integ;
 	}
-	blocksize = crypto_sync_skcipher_blocksize(cipher);
 	conflen = crypto_sync_skcipher_blocksize(cipher);
 
 	/* hide the gss token header and insert the confounder */
@@ -710,69 +799,30 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	if (err)
 		return GSS_S_FAILURE;
 
-	nbytes = buf->len - offset - GSS_KRB5_TOK_HDR_LEN;
-	nblocks = (nbytes + blocksize - 1) / blocksize;
-	cbcbytes = 0;
-	if (nblocks > 2)
-		cbcbytes = (nblocks - 2) * blocksize;
-
-	memset(desc.iv, 0, sizeof(desc.iv));
-
-	if (cbcbytes) {
-		SYNC_SKCIPHER_REQUEST_ON_STACK(req, aux_cipher);
-
-		desc.pos = offset + GSS_KRB5_TOK_HDR_LEN;
-		desc.fragno = 0;
-		desc.fraglen = 0;
-		desc.pages = pages;
-		desc.outbuf = buf;
-		desc.req = req;
-
-		skcipher_request_set_sync_tfm(req, aux_cipher);
-		skcipher_request_set_callback(req, 0, NULL, NULL);
-
-		sg_init_table(desc.infrags, 4);
-		sg_init_table(desc.outfrags, 4);
-
-		err = xdr_process_buf(buf, offset + GSS_KRB5_TOK_HDR_LEN,
-				      cbcbytes, encryptor, &desc);
-		skcipher_request_zero(req);
-		if (err)
-			goto out_err;
-	}
-
-	/* Make sure IV carries forward from any CBC results. */
-	err = gss_krb5_cts_crypt(cipher, buf,
-				 offset + GSS_KRB5_TOK_HDR_LEN + cbcbytes,
-				 desc.iv, pages, 1);
-	if (err) {
-		err = GSS_S_FAILURE;
-		goto out_err;
-	}
+	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
+				   offset + GSS_KRB5_TOK_HDR_LEN,
+				   buf, pages);
+	if (err)
+		return GSS_S_FAILURE;
 
 	/* Now update buf to account for HMAC */
 	buf->tail[0].iov_len += kctx->gk5e->cksumlength;
 	buf->len += kctx->gk5e->cksumlength;
 
-out_err:
-	if (err)
-		err = GSS_S_FAILURE;
-	return err;
+	return GSS_S_COMPLETE;
 }
 
 u32
 gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
 {
-	struct xdr_buf subbuf;
-	u32 ret = 0;
 	struct crypto_sync_skcipher *cipher, *aux_cipher;
 	struct crypto_ahash *ahash;
 	struct xdr_netobj our_hmac_obj;
 	u8 our_hmac[GSS_KRB5_MAX_CKSUM_LEN];
 	u8 pkt_hmac[GSS_KRB5_MAX_CKSUM_LEN];
-	int nblocks, blocksize, cbcbytes;
-	struct decryptor_desc desc;
+	struct xdr_buf subbuf;
+	u32 ret = 0;
 
 	if (kctx->initiate) {
 		cipher = kctx->acceptor_enc;
@@ -783,44 +833,17 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		aux_cipher = kctx->initiator_enc_aux;
 		ahash = kctx->initiator_integ;
 	}
-	blocksize = crypto_sync_skcipher_blocksize(cipher);
 
 	/* create a segment skipping the header and leaving out the checksum */
 	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
 				    (len - offset - GSS_KRB5_TOK_HDR_LEN -
 				     kctx->gk5e->cksumlength));
 
-	nblocks = (subbuf.len + blocksize - 1) / blocksize;
-
-	cbcbytes = 0;
-	if (nblocks > 2)
-		cbcbytes = (nblocks - 2) * blocksize;
-
-	memset(desc.iv, 0, sizeof(desc.iv));
-
-	if (cbcbytes) {
-		SYNC_SKCIPHER_REQUEST_ON_STACK(req, aux_cipher);
-
-		desc.fragno = 0;
-		desc.fraglen = 0;
-		desc.req = req;
-
-		skcipher_request_set_sync_tfm(req, aux_cipher);
-		skcipher_request_set_callback(req, 0, NULL, NULL);
-
-		sg_init_table(desc.frags, 4);
-
-		ret = xdr_process_buf(&subbuf, 0, cbcbytes, decryptor, &desc);
-		skcipher_request_zero(req);
-		if (ret)
-			goto out_err;
-	}
-
-	/* Make sure IV carries forward from any CBC results. */
-	ret = gss_krb5_cts_crypt(cipher, &subbuf, cbcbytes, desc.iv, NULL, 0);
+	ret = krb5_cbc_cts_decrypt(cipher, aux_cipher, 0, &subbuf);
 	if (ret)
 		goto out_err;
 
+	/* Calculate our hmac over the plaintext data */
 	our_hmac_obj.len = sizeof(our_hmac);
 	our_hmac_obj.data = our_hmac;
 	ret = gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac_obj);
@@ -837,7 +860,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		ret = GSS_S_BAD_SIG;
 		goto out_err;
 	}
-	*headskip = blocksize;
+	*headskip = crypto_sync_skcipher_blocksize(cipher);
 	*tailskip = kctx->gk5e->cksumlength;
 out_err:
 	if (ret && ret != GSS_S_BAD_SIG)


