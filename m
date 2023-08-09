Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699877600C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjHIM7t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjHIM7s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:48 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D501FF6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:47 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-RR7Vi7HsPUCu7CzNB5blJg-1; Wed, 09 Aug 2023 08:59:27 -0400
X-MC-Unique: RR7Vi7HsPUCu7CzNB5blJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14DD885CBE7;
        Wed,  9 Aug 2023 12:59:27 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 362132166B25;
        Wed,  9 Aug 2023 12:59:25 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Date:   Wed,  9 Aug 2023 14:58:52 +0200
Message-Id: <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the possibility to change the key and IV when using
TLS1.3. Changing the cipher or TLS version is not supported.

Once we have updated the RX key, we can unblock the receive side. If
the rekey fails, the context is unmodified and userspace is free to
retry the update or close the socket.

This change only affects tls_sw, since 1.3 offload isn't supported.

v2:
 - reverse xmas tree
 - turn the alt_crypto_info into an else if
 - don't modify the context when rekey fails

v3:
 - only call tls_sw_strparser_arm when setting the initial RX key, not
   on rekeys
 - update tls_sk_poll to not say the socket is readable when we're
   waiting for a rekey, and wake up poll() when the new key is installed
 - use unsafe_memcpy to make FORTIFY_SOURCE happy

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |   3 +-
 net/tls/tls_device.c |   2 +-
 net/tls/tls_main.c   |  47 +++++++++++----
 net/tls/tls_sw.c     | 137 +++++++++++++++++++++++++++++++------------
 4 files changed, 138 insertions(+), 51 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 6916ff4fbde6..fd80cfc7604a 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -89,7 +89,8 @@ void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
 
-int tls_set_sw_offload(struct sock *sk, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cc1918a279d4..af269875a772 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1275,7 +1275,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0);
+	rc = tls_set_sw_offload(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index ffc50454758e..a5dfb562d99b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -380,9 +380,10 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	ctx = tls_sw_ctx_rx(tls_ctx);
 	psock = sk_psock_get(sk);
 
-	if (skb_queue_empty_lockless(&ctx->rx_list) &&
-	    !tls_strp_msg_ready(ctx) &&
-	    sk_psock_queue_empty(psock))
+	if ((skb_queue_empty_lockless(&ctx->rx_list) &&
+	     !tls_strp_msg_ready(ctx) &&
+	     sk_psock_queue_empty(psock)) ||
+	    READ_ONCE(ctx->key_update_pending))
 		mask &= ~(EPOLLIN | EPOLLRDNORM);
 
 	if (psock)
@@ -696,9 +697,11 @@ static int tls_getsockopt(struct sock *sk, int level, int optname,
 static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 				  unsigned int optlen, int tx)
 {
-	struct tls_crypto_info *crypto_info;
-	struct tls_crypto_info *alt_crypto_info;
+	struct tls_crypto_info *crypto_info, *alt_crypto_info;
+	struct tls_crypto_info *old_crypto_info = NULL;
 	struct tls_context *ctx = tls_get_ctx(sk);
+	union tls_crypto_context tmp = {};
+	bool update = false;
 	size_t optsize;
 	int rc = 0;
 	int conf;
@@ -714,9 +717,17 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		alt_crypto_info = &ctx->crypto_send.info;
 	}
 
-	/* Currently we don't support set crypto info more than one time */
-	if (TLS_CRYPTO_INFO_READY(crypto_info))
-		return -EBUSY;
+	if (TLS_CRYPTO_INFO_READY(crypto_info)) {
+		/* Currently we only support setting crypto info more
+		 * than one time for TLS 1.3
+		 */
+		if (crypto_info->version != TLS_1_3_VERSION)
+			return -EBUSY;
+
+		update = true;
+		old_crypto_info = crypto_info;
+		crypto_info = &tmp.info;
+	}
 
 	rc = copy_from_sockptr(crypto_info, optval, sizeof(*crypto_info));
 	if (rc) {
@@ -731,8 +742,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		goto err_crypto_info;
 	}
 
-	/* Ensure that TLS version and ciphers are same in both directions */
-	if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
+	if (update) {
+		/* Ensure that TLS version and ciphers are not modified */
+		if (crypto_info->version != old_crypto_info->version ||
+		    crypto_info->cipher_type != old_crypto_info->cipher_type) {
+			rc = -EINVAL;
+			goto err_crypto_info;
+		}
+	} else if (TLS_CRYPTO_INFO_READY(alt_crypto_info)) {
+		/* Ensure that TLS version and ciphers are same in both directions */
 		if (alt_crypto_info->version != crypto_info->version ||
 		    alt_crypto_info->cipher_type != crypto_info->cipher_type) {
 			rc = -EINVAL;
@@ -799,7 +817,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 		} else {
-			rc = tls_set_sw_offload(sk, 1);
+			rc = tls_set_sw_offload(sk, 1,
+						update ? crypto_info : NULL);
 			if (rc)
 				goto err_crypto_info;
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -813,14 +832,16 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 		} else {
-			rc = tls_set_sw_offload(sk, 0);
+			rc = tls_set_sw_offload(sk, 0,
+						update ? crypto_info : NULL);
 			if (rc)
 				goto err_crypto_info;
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
 			conf = TLS_SW;
 		}
-		tls_sw_strparser_arm(sk, ctx);
+		if (!update)
+			tls_sw_strparser_arm(sk, ctx);
 	}
 
 	if (tx)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 497f56c5f169..bb5560fc8bcf 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2616,23 +2616,52 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx)
 		tls_ctx->prot_info.version != TLS_1_3_VERSION;
 }
 
-int tls_set_sw_offload(struct sock *sk, int tx)
+static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
+{
+	struct tls_sw_context_rx *ctx = tls_ctx->priv_ctx_rx;
+
+	WRITE_ONCE(ctx->key_update_pending, false);
+	/* wake-up pre-existing poll() */
+	ctx->saved_data_ready(sk);
+}
+
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info)
 {
 	u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	char *iv, *rec_seq, *key, *salt, *cipher_name;
 	struct tls_sw_context_tx *sw_ctx_tx = NULL;
 	struct tls_sw_context_rx *sw_ctx_rx = NULL;
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct tls_crypto_info *crypto_info;
+	size_t keysize, crypto_info_size;
 	struct cipher_context *cctx;
 	struct tls_prot_info *prot;
 	struct crypto_aead **aead;
 	struct crypto_tfm *tfm;
-	size_t keysize;
 	int rc = 0;
 
 	prot = &ctx->prot_info;
 
+	if (new_crypto_info) {
+		/* non-NULL new_crypto_info means rekey */
+		src_crypto_info = new_crypto_info;
+		if (tx) {
+			sw_ctx_tx = ctx->priv_ctx_tx;
+			crypto_info = &ctx->crypto_send.info;
+			cctx = &ctx->tx;
+			aead = &sw_ctx_tx->aead_send;
+			sw_ctx_tx = NULL;
+		} else {
+			sw_ctx_rx = ctx->priv_ctx_rx;
+			crypto_info = &ctx->crypto_recv.info;
+			cctx = &ctx->rx;
+			aead = &sw_ctx_rx->aead_recv;
+			sw_ctx_rx = NULL;
+		}
+		goto skip_init;
+	}
+
 	if (tx) {
 		if (!ctx->priv_ctx_tx) {
 			sw_ctx_tx = kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
@@ -2679,12 +2708,15 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 		aead = &sw_ctx_rx->aead_recv;
 		sw_ctx_rx->key_update_pending = false;
 	}
+	src_crypto_info = crypto_info;
 
+skip_init:
 	switch (crypto_info->cipher_type) {
 	case TLS_CIPHER_AES_GCM_128: {
 		struct tls12_crypto_info_aes_gcm_128 *gcm_128_info;
 
-		gcm_128_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_aes_gcm_128);
+		gcm_128_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_AES_GCM_128_IV_SIZE;
 		tag_size = TLS_CIPHER_AES_GCM_128_TAG_SIZE;
 		iv_size = TLS_CIPHER_AES_GCM_128_IV_SIZE;
@@ -2701,7 +2733,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_AES_GCM_256: {
 		struct tls12_crypto_info_aes_gcm_256 *gcm_256_info;
 
-		gcm_256_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_aes_gcm_256);
+		gcm_256_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_AES_GCM_256_IV_SIZE;
 		tag_size = TLS_CIPHER_AES_GCM_256_TAG_SIZE;
 		iv_size = TLS_CIPHER_AES_GCM_256_IV_SIZE;
@@ -2718,7 +2751,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_AES_CCM_128: {
 		struct tls12_crypto_info_aes_ccm_128 *ccm_128_info;
 
-		ccm_128_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_aes_ccm_128);
+		ccm_128_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_AES_CCM_128_IV_SIZE;
 		tag_size = TLS_CIPHER_AES_CCM_128_TAG_SIZE;
 		iv_size = TLS_CIPHER_AES_CCM_128_IV_SIZE;
@@ -2735,7 +2769,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_CHACHA20_POLY1305: {
 		struct tls12_crypto_info_chacha20_poly1305 *chacha20_poly1305_info;
 
-		chacha20_poly1305_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_chacha20_poly1305);
+		chacha20_poly1305_info = (void *)src_crypto_info;
 		nonce_size = 0;
 		tag_size = TLS_CIPHER_CHACHA20_POLY1305_TAG_SIZE;
 		iv_size = TLS_CIPHER_CHACHA20_POLY1305_IV_SIZE;
@@ -2752,7 +2787,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_SM4_GCM: {
 		struct tls12_crypto_info_sm4_gcm *sm4_gcm_info;
 
-		sm4_gcm_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_sm4_gcm);
+		sm4_gcm_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_SM4_GCM_IV_SIZE;
 		tag_size = TLS_CIPHER_SM4_GCM_TAG_SIZE;
 		iv_size = TLS_CIPHER_SM4_GCM_IV_SIZE;
@@ -2769,7 +2805,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_SM4_CCM: {
 		struct tls12_crypto_info_sm4_ccm *sm4_ccm_info;
 
-		sm4_ccm_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_sm4_ccm);
+		sm4_ccm_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_SM4_CCM_IV_SIZE;
 		tag_size = TLS_CIPHER_SM4_CCM_TAG_SIZE;
 		iv_size = TLS_CIPHER_SM4_CCM_IV_SIZE;
@@ -2786,7 +2823,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_ARIA_GCM_128: {
 		struct tls12_crypto_info_aria_gcm_128 *aria_gcm_128_info;
 
-		aria_gcm_128_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_aria_gcm_128);
+		aria_gcm_128_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
 		tag_size = TLS_CIPHER_ARIA_GCM_128_TAG_SIZE;
 		iv_size = TLS_CIPHER_ARIA_GCM_128_IV_SIZE;
@@ -2803,7 +2841,8 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	case TLS_CIPHER_ARIA_GCM_256: {
 		struct tls12_crypto_info_aria_gcm_256 *gcm_256_info;
 
-		gcm_256_info = (void *)crypto_info;
+		crypto_info_size = sizeof(struct tls12_crypto_info_aria_gcm_256);
+		gcm_256_info = (void *)src_crypto_info;
 		nonce_size = TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
 		tag_size = TLS_CIPHER_ARIA_GCM_256_TAG_SIZE;
 		iv_size = TLS_CIPHER_ARIA_GCM_256_IV_SIZE;
@@ -2847,19 +2886,18 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 			      prot->tag_size + prot->tail_size;
 	prot->iv_size = iv_size;
 	prot->salt_size = salt_size;
-	cctx->iv = kmalloc(iv_size + salt_size, GFP_KERNEL);
-	if (!cctx->iv) {
-		rc = -ENOMEM;
-		goto free_priv;
-	}
-	/* Note: 128 & 256 bit salt are the same size */
-	prot->rec_seq_size = rec_seq_size;
-	memcpy(cctx->iv, salt, salt_size);
-	memcpy(cctx->iv + salt_size, iv, iv_size);
-	cctx->rec_seq = kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
-	if (!cctx->rec_seq) {
-		rc = -ENOMEM;
-		goto free_iv;
+	if (!new_crypto_info) {
+		cctx->iv = kmalloc(iv_size + salt_size, GFP_KERNEL);
+		if (!cctx->iv) {
+			rc = -ENOMEM;
+			goto free_priv;
+		}
+
+		cctx->rec_seq = kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
+		if (!cctx->rec_seq) {
+			rc = -ENOMEM;
+			goto free_iv;
+		}
 	}
 
 	if (!*aead) {
@@ -2873,14 +2911,24 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
 
+	/* setkey is the last operation that could fail during a
+	 * rekey. if it succeeds, we can start modifying the
+	 * context.
+	 */
 	rc = crypto_aead_setkey(*aead, key, keysize);
+	if (rc) {
+		if (new_crypto_info)
+			goto out;
+		else
+			goto free_aead;
+	}
 
-	if (rc)
-		goto free_aead;
-
-	rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-	if (rc)
-		goto free_aead;
+	if (!new_crypto_info) {
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc) {
+			goto free_aead;
+		}
+	}
 
 	if (sw_ctx_rx) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
@@ -2895,6 +2943,21 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 			goto free_aead;
 	}
 
+	/* Note: 128 & 256 bit salt are the same size */
+	prot->rec_seq_size = rec_seq_size;
+	memcpy(cctx->iv, salt, salt_size);
+	memcpy(cctx->iv + salt_size, iv, iv_size);
+
+	if (new_crypto_info) {
+		memcpy(cctx->rec_seq, rec_seq, rec_seq_size);
+
+		unsafe_memcpy(crypto_info, new_crypto_info, crypto_info_size,
+			      /* size was checked in do_tls_getsockopt_conf */);
+		memzero_explicit(new_crypto_info, crypto_info_size);
+		if (!tx)
+			tls_finish_key_update(sk, ctx);
+	}
+
 	goto out;
 
 free_aead:
@@ -2907,12 +2970,14 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	kfree(cctx->iv);
 	cctx->iv = NULL;
 free_priv:
-	if (tx) {
-		kfree(ctx->priv_ctx_tx);
-		ctx->priv_ctx_tx = NULL;
-	} else {
-		kfree(ctx->priv_ctx_rx);
-		ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		if (tx) {
+			kfree(ctx->priv_ctx_tx);
+			ctx->priv_ctx_tx = NULL;
+		} else {
+			kfree(ctx->priv_ctx_rx);
+			ctx->priv_ctx_rx = NULL;
+		}
 	}
 out:
 	return rc;
-- 
2.40.1

