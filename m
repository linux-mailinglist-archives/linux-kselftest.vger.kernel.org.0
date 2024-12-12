Return-Path: <linux-kselftest+bounces-23261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED39EECE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E1B167348
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A212210CD;
	Thu, 12 Dec 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HGrpu0Km";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkh1eyYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14521E0AA;
	Thu, 12 Dec 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017819; cv=none; b=h647/O9lmaaZnZruANZqZbc2cvMTBdi+q6t6o1jFTVnzcEfKTkGM5/YgEz8/cxC3lXi/DaytwNt9ymbO02wsc9spc0mlQwNjqThgPBRvDQIsJgcjO3KQe4k+JeRHt9FKe8ZytNPNL2/jujsiHUAri1Ty2FnUwCe9WElYtvGonIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017819; c=relaxed/simple;
	bh=WRb8zyVfkKEf3V2LP7v507kPz9prbLyRmDyghJ3DxIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APInJ0Ms8b1bstixPMTId4b4wqWz6Wdk6TXU98f5mTmQd83YC4l+/IWgRqkcbu2v1T3SmVm6udnYADSvTyAln+XwsgcBdOd19qMZzndVs06nhbabLcZO1joWjqjANTHC27/7zV8ahTrvw/8rIpPObomZaI6DRCXCQAF+VsmpZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HGrpu0Km; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkh1eyYn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2AE1254009F;
	Thu, 12 Dec 2024 10:36:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 12 Dec 2024 10:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017814; x=
	1734104214; bh=7lCeiUCbZWNTRnlYVDTu79mmqwc/OnQORHATq882gt8=; b=H
	Grpu0KmvwzXK5gBASRuwhmrubC//R6oBihXyobJ64LrJPOWPYOUUcam8EjMrammr
	Rrw/T16W2rtKqFqpFwy3/evsdoQ2N8g1BZEA0V88ZufQo8mqQcvbar7APi5zuT0Y
	xQyVqsu7sS9uOisEvpJ/ofCPV2+RURPdBzxDEg2rlLeEKwDWVNIBUT6q/1/v9dyI
	SyL3JmM8eriGuG8HY5eznvxOAtefmNs4EkJhvSI7keTkqNVV6a+Xs+1le/I6VH5E
	E/w75HuV7rat/xu5JxMmxntlfURA7L2c963fkq9AgU3ElmfRCG9VLLWUE5Z8xHJB
	Kxa8/KpM/AVLFKqGolywA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017814; x=1734104214; bh=7
	lCeiUCbZWNTRnlYVDTu79mmqwc/OnQORHATq882gt8=; b=fkh1eyYnjSv8BfTbU
	l5YhKK9lH3gUnRgw0TcIXrk8OsAgCdSeQU9r3x21UYXt2IOIqqYeYP6+bf8NVDh0
	Cy4AWGOae3oIkNdR2vr2iirmWExXV4FPqjO7oNI5on4XTqs56/T1kt2AOIRz8rPn
	PNPUAYrgXriVGKE/7XNKoxkX6xvqolv87U6iT6kbO4HIySDoVVGPc6i1/956MAUm
	/QQAIiclmywWO9QW8A4jscpm+KygStmfrdO0zDFIUI2V0tedNHhNyu8f2t5mtcJW
	VF1b35vjE+dzaX3ZZWGBw81eezjS3VLV2WfuweMmAC9G8xAJiT7VW9I7WnUF0Wg6
	IQPZA==
X-ME-Sender: <xms:FgNbZ4-MZKoR9XAr5vo3H6MSKXZLMxWHv7i04i0j2eETdcwcakF60w>
    <xme:FgNbZwtv4sCnr3_yNHz8xXVa85gOREXt6QhbpvaXO5EkZi0ggOcCrupwwbwLqJpyO
    wjfAUu6GIZwQELd5ic>
X-ME-Received: <xmr:FgNbZ-CBsW_G06uTugyB4NfUpOmF73jJCnq7XfEsSs2pSEPIG8MAPM4DcAUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FgNbZ4f4pkjm6HbCaI0XA9blPZ5tvUS6G-ZksEhU_TfNhx5HxZoRyA>
    <xmx:FgNbZ9PfGF1rMRWCHMjPsEkpkm4Mq5OQkUyCiR7fHGshrPxWkmGv_w>
    <xmx:FgNbZyl7Gc5AXB1VWAzFxEIGbT4A4ZUrLYlXFdcoYQ-lBl9tJCUUGw>
    <xmx:FgNbZ_vX6S9nUpaIJVkiJ4C9McCnVzaytLrZZTOF09uBrMGM0OZeVA>
    <xmx:FgNbZ-t3T3fXW0zuVbANf2sT8FvGvdoXogyEwFNSB00yg_GeaWNtqclz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:36:53 -0500 (EST)
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
	Simon Horman <horms@kernel.org>,
	Parthiban.Veerasooran@microchip.com
Subject: [PATCH net-next v5 2/6] tls: implement rekey for TLS1.3
Date: Thu, 12 Dec 2024 16:36:05 +0100
Message-ID: <a4278b8f7a396daf7e5cdc1c435a46346cf09aa9.1734013874.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734013874.git.sd@queasysnail.net>
References: <cover.1734013874.git.sd@queasysnail.net>
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

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
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

v5: unchanged, keep Jakub's ack from v4

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
index 3dcf8ee60fea..9e5aff5bab98 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2716,12 +2716,22 @@ int init_prot_info(struct tls_prot_info *prot,
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
@@ -2733,45 +2743,47 @@ int tls_set_sw_offload(struct sock *sk, int tx)
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
@@ -2784,20 +2796,30 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 
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
@@ -2805,18 +2827,33 @@ int tls_set_sw_offload(struct sock *sk, int tx)
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
2.47.1


