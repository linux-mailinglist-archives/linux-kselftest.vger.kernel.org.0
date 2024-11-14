Return-Path: <linux-kselftest+bounces-22038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1B9C8EE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B06288843
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598E1ADFFE;
	Thu, 14 Nov 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kQSgC7d0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L40OsV+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEF18A95D;
	Thu, 14 Nov 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599482; cv=none; b=k15ts7oJWZxOuxkOmSkPJGwNe25Tqu1jy/RCPaMpI9zCHNbpoTNMJ99GROAqM5UGsLjqbiMca4I0v1egPfRYjh3dx9wQhNuH7f01mQa+9OZGymPisWe1iAOlT82iA0BU35ZQqDSj0T2tBEjfgeHpyBwrQPVOU2xv8wb/NF0ChE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599482; c=relaxed/simple;
	bh=53sf/vxHGDszM/z0iAw/n934va+I3Mv4anDGwvpfSrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5TrmVG1kC1QRz8XQtkm15nS1yDWY4u+GRa5hYkqImAlQieElZjYqfWIOpygXLElxudi7FSCj2Dwsl9Ppe3zsdwe5yRZY0GDhzyF6WmFW8eIeSXpsAYfbtrYyhtNy8Kil3+/S6ntSI6uiNy8CI+99YkI2jxmRmbcjAnRwv9uXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kQSgC7d0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L40OsV+J; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id D617E1D4072D;
	Thu, 14 Nov 2024 10:51:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 10:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599478; x=
	1731603078; bh=wnN3q70FYHVaaVOckVCFc4PmvynZg5W0p3QCZifPWAo=; b=k
	QSgC7d00BHD1A164YB+K4Eiy+aVPYgjvDKPicCJbn+kwqM/vY/apxv8pPFDtrK60
	xOcuotoE8kbCMPZDBW2KWbaqu4ZPTOhljYytwdptSFLrfgEzU6IDNX1L2okrgUNd
	wGXMmo9Zgf9HT1JI5HB7doFk3xHqzMIJaEHkMF7VXt32+A5R/B+uf8p/PjfAHAn8
	p+bTaEGJPWtdMkpBkZ6Ru7x4oehL/+jSqXQpgEIVnEriC428ThUAHSJAdHf+9ip9
	vz5Q16lQxdVjCJJThuylRHyxF6SIPC6PnpeWEONV18oijMoHMY683NVtTMeg6NzA
	ZcMTJKfaRcpLk6kuVQyHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599478; x=1731603078; bh=w
	nN3q70FYHVaaVOckVCFc4PmvynZg5W0p3QCZifPWAo=; b=L40OsV+Js7IYDPuvB
	I3G2dLp+QgQ5i7WNpjdVT+WI0Z03VYU+Kc6BqbOafsUhPzSZZxZnqfcE3F22j07f
	vsiclWVhLDRQaNr71qR++dwRXB7T/j3RU7KxQfILLyzkg/MlGbgYk7JO8ylnSpdO
	xBhkfOlm+/rQ4d/+EVSYO5Rt7DPS0YgwpOJfROu4Eb7z7ocNtbQMcl1LIlfauM9v
	0FFCU40HxPHcBWPQ3dFMOVoBd7mh2rlla8V7weTJ/PI6rcpAfYW16ed/Kskk6763
	0URNDFXg7Ys6P4rNwHD3eW8Yg9wleoXFmTZfvYyPpn9O6V2FXfwj4LqNOMlKVrI/
	jnxlg==
X-ME-Sender: <xms:dRw2Z4ED4P-QYYlwko4mPzTvbyPDBD1vbLPkCNpD5m3WQUgDEfIMEQ>
    <xme:dRw2ZxWAaZarxUbgRg7i1cFtxbbKyv17nOngweyPFPazjxv_91hEFcHeikTYLLqD8
    JKi3HdHqLMhaMMx578>
X-ME-Received: <xmr:dRw2ZyK_uhQp4RWjfXusaMdXnEuwA-3ODsCInUjSsxifApBRfOKgge_Gf08A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dRw2Z6FZd48pu6jfeIMcKSw2AecCgEN5uJhCGp872vxUJjLAVWKMdg>
    <xmx:dRw2Z-WTB8tBJFZRPT8Skc9hTNnAQzsFvfkf23qbepK3AlJrvClxqA>
    <xmx:dRw2Z9NSHK8F9pfPXwNHg5ZTVmlInVq1x8s8FPS_AHIs3tI8IOS1LA>
    <xmx:dRw2Z11nmsg0Fx0Znoq2LaW2H3CoS25RRmljwyNHoW7mau51vz4W4g>
    <xmx:dhw2Z1PACJUSe8oLnW24qmXWP6OYkUzTvrDq3CtzcvAiFF_BmAlnDG-6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:17 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 2/6] tls: implement rekey for TLS1.3
Date: Thu, 14 Nov 2024 16:50:49 +0100
Message-ID: <8db5c0e8ccb9e989d8dfd3bf78939fd63e6ac062.1731597571.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

v4:
 - rebase on top of current net-next
 - no {} needed around single line (Simon)

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |   3 +-
 net/tls/tls_device.c |   2 +-
 net/tls/tls_main.c   |  46 ++++++++++++++-----
 net/tls/tls_sw.c     | 105 +++++++++++++++++++++++++++++--------------
 4 files changed, 108 insertions(+), 48 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index e5e47452308a..774859b63f0d 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -145,7 +145,8 @@ void tls_err_abort(struct sock *sk, int err);
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
 		   const struct tls_cipher_desc *cipher_desc);
-int tls_set_sw_offload(struct sock *sk, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index dc063c2c7950..e50b6e71df13 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1227,7 +1227,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0);
+	rc = tls_set_sw_offload(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 6b4b9f2749a6..68b5735dafc1 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -423,9 +423,10 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
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
@@ -612,11 +613,13 @@ static int validate_crypto_info(const struct tls_crypto_info *crypto_info,
 static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 				  unsigned int optlen, int tx)
 {
-	struct tls_crypto_info *crypto_info;
-	struct tls_crypto_info *alt_crypto_info;
+	struct tls_crypto_info *crypto_info, *alt_crypto_info;
+	struct tls_crypto_info *old_crypto_info = NULL;
 	struct tls_context *ctx = tls_get_ctx(sk);
 	const struct tls_cipher_desc *cipher_desc;
 	union tls_crypto_context *crypto_ctx;
+	union tls_crypto_context tmp = {};
+	bool update = false;
 	int rc = 0;
 	int conf;
 
@@ -633,9 +636,18 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 
 	crypto_info = &crypto_ctx->info;
 
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
+		crypto_ctx = &tmp;
+	}
 
 	rc = copy_from_sockptr(crypto_info, optval, sizeof(*crypto_info));
 	if (rc) {
@@ -643,7 +655,14 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		goto err_crypto_info;
 	}
 
-	rc = validate_crypto_info(crypto_info, alt_crypto_info);
+	if (update) {
+		/* Ensure that TLS version and ciphers are not modified */
+		if (crypto_info->version != old_crypto_info->version ||
+		    crypto_info->cipher_type != old_crypto_info->cipher_type)
+			rc = -EINVAL;
+	} else {
+		rc = validate_crypto_info(crypto_info, alt_crypto_info);
+	}
 	if (rc)
 		goto err_crypto_info;
 
@@ -673,7 +692,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 		} else {
-			rc = tls_set_sw_offload(sk, 1);
+			rc = tls_set_sw_offload(sk, 1,
+						update ? crypto_info : NULL);
 			if (rc)
 				goto err_crypto_info;
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -687,14 +707,16 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
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
index db98710c4810..78b9b89f495e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2718,12 +2718,22 @@ int init_prot_info(struct tls_prot_info *prot,
 	return 0;
 }
 
-int tls_set_sw_offload(struct sock *sk, int tx)
+static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
 {
+	struct tls_sw_context_rx *ctx = tls_ctx->priv_ctx_rx;
+
+	WRITE_ONCE(ctx->key_update_pending, false);
+	/* wake-up pre-existing poll() */
+	ctx->saved_data_ready(sk);
+}
+
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	struct tls_sw_context_tx *sw_ctx_tx = NULL;
 	struct tls_sw_context_rx *sw_ctx_rx = NULL;
 	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
 	char *iv, *rec_seq, *key, *salt;
 	struct cipher_context *cctx;
 	struct tls_prot_info *prot;
@@ -2735,45 +2745,47 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
-	if (tx) {
-		ctx->priv_ctx_tx = init_ctx_tx(ctx, sk);
-		if (!ctx->priv_ctx_tx)
-			return -ENOMEM;
+	/* new_crypto_info != NULL means rekey */
+	if (!new_crypto_info) {
+		if (tx) {
+			ctx->priv_ctx_tx = init_ctx_tx(ctx, sk);
+			if (!ctx->priv_ctx_tx)
+				return -ENOMEM;
+		} else {
+			ctx->priv_ctx_rx = init_ctx_rx(ctx);
+			if (!ctx->priv_ctx_rx)
+				return -ENOMEM;
+		}
+	}
 
+	if (tx) {
 		sw_ctx_tx = ctx->priv_ctx_tx;
 		crypto_info = &ctx->crypto_send.info;
 		cctx = &ctx->tx;
 		aead = &sw_ctx_tx->aead_send;
 	} else {
-		ctx->priv_ctx_rx = init_ctx_rx(ctx);
-		if (!ctx->priv_ctx_rx)
-			return -ENOMEM;
-
 		sw_ctx_rx = ctx->priv_ctx_rx;
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
-		sw_ctx_rx->key_update_pending = false;
 	}
 
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	src_crypto_info = new_crypto_info ?: crypto_info;
+
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
 	if (!cipher_desc) {
 		rc = -EINVAL;
 		goto free_priv;
 	}
 
-	rc = init_prot_info(prot, crypto_info, cipher_desc);
+	rc = init_prot_info(prot, src_crypto_info, cipher_desc);
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(crypto_info, cipher_desc);
-	key = crypto_info_key(crypto_info, cipher_desc);
-	salt = crypto_info_salt(crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
-
-	memcpy(cctx->iv, salt, cipher_desc->salt);
-	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
-	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
+	iv = crypto_info_iv(src_crypto_info, cipher_desc);
+	key = crypto_info_key(src_crypto_info, cipher_desc);
+	salt = crypto_info_salt(src_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2786,20 +2798,30 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
 
+	/* setkey is the last operation that could fail during a
+	 * rekey. if it succeeds, we can start modifying the
+	 * context.
+	 */
 	rc = crypto_aead_setkey(*aead, key, cipher_desc->key);
-	if (rc)
-		goto free_aead;
+	if (rc) {
+		if (new_crypto_info)
+			goto out;
+		else
+			goto free_aead;
+	}
 
-	rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-	if (rc)
-		goto free_aead;
+	if (!new_crypto_info) {
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc)
+			goto free_aead;
+	}
 
-	if (sw_ctx_rx) {
+	if (!tx && !new_crypto_info) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
 
 		tls_update_rx_zc_capable(ctx);
 		sw_ctx_rx->async_capable =
-			crypto_info->version != TLS_1_3_VERSION &&
+			src_crypto_info->version != TLS_1_3_VERSION &&
 			!!(tfm->__crt_alg->cra_flags & CRYPTO_ALG_ASYNC);
 
 		rc = tls_strp_init(&sw_ctx_rx->strp, sk);
@@ -2807,18 +2829,33 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 			goto free_aead;
 	}
 
+	memcpy(cctx->iv, salt, cipher_desc->salt);
+	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
+	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
+
+	if (new_crypto_info) {
+		unsafe_memcpy(crypto_info, new_crypto_info,
+			      cipher_desc->crypto_info,
+			      /* size was checked in do_tls_setsockopt_conf */);
+		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+		if (!tx)
+			tls_finish_key_update(sk, ctx);
+	}
+
 	goto out;
 
 free_aead:
 	crypto_free_aead(*aead);
 	*aead = NULL;
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
2.47.0


