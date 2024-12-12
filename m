Return-Path: <linux-kselftest+bounces-23260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3F9EECE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123C2166216
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895E217F30;
	Thu, 12 Dec 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LDLFbw+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMtIdgsN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692A2139CB;
	Thu, 12 Dec 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017815; cv=none; b=n+IrdaGlTcLuwgzahK83l7tcrwFO70TUayaUpwhPDtFTPVypLwwL1p3YQagfAHPaWJkz97iX7aK5WyzedfCxJMVk+V7R4qeXwemM4d5fIT3u6mzL9ONcVNqPzWAgefjm/KzGWge/0eIayhp4OxCdYBlePIVTrSn5OxVaqaY4q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017815; c=relaxed/simple;
	bh=tp4uKQX13fJh3bUnjCJ/SqmcZNosgcvCj66FmkkzDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDYbmBETvchhCdzuppq7IDaHjPjerTVD0Bbph/A4oTNgwdeumyQUZsYRZsFJlAQoVaCKuLi69qbUSdA/DVOF7UVXdi2ubrvZdxbTwEg+59Y8KtR9L9kc9l4XVttLSTLtIzpBW80e/azYmgHOlhRjF/NlwVV3bqcRo39phvmuhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LDLFbw+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMtIdgsN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCEFE25400E3;
	Thu, 12 Dec 2024 10:36:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 10:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017811; x=
	1734104211; bh=FuQpAzA3XS1vmVuKC6+Ktn4plbA2C0dUghvv+jl8CJc=; b=L
	DLFbw+YdGkrWPvspgJORMkAo6fJoIpkpJ7C6QbG5H8tVQ448ZETMbwR6jb1PbMPe
	9cDwklsw1JIAUl1n/Lr6m7hJVumLBmtEr6hu1mRLMBEE9VwP7N8fuGC9hyYJJ8ge
	003BHrSKVgYZPuvxaxZ1k6X1OFbk5uVZ17yohBfm2xKUk7oe2PqDWfG9hHrECYH/
	g4BCcX7gqwNjlrDBqq7hbNo1x52R/lUWy4pdOMlbQC/GU4E9b6Tln9l02Txgjgvm
	hgbydXKzxjHnM+h8Mhgy4AHvCU2WHwQdUeGjd3q4bNO69ZsNHpmqZYfv5VYB9W//
	ofIoRH5u7LZK0sLxLlLkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017811; x=1734104211; bh=F
	uQpAzA3XS1vmVuKC6+Ktn4plbA2C0dUghvv+jl8CJc=; b=rMtIdgsNZ2MV5/N12
	4mY4a/jkpatx9HtVq7ho/hIcLVZUi1VeQynoaUmjWwQIFfvuw43eC6iQpbAl6tVc
	WQM+64Yk06Cra5kQ0QlJkHqSrx9RAQ/mouMQ/9IX0iXcr1GcGUIpuNM7+WZpW5ci
	x+5F3pPfhdRPxSbL9q2z99WevmG+HSTdS6K56Q9HdCsq3s7h6/mLSXAhG4aeBpbR
	H01l1zSscFy03zdcmIOT+eYuvhzqJyqQBH9oF0oOokAuSK1atmcq+c/P38LMmlPY
	OF4qxqhwBO87IO7KwN3Kp5tGEYrhN1SwtHZVFDA9lDZ9X0JwE78w26lNakb79pjb
	RLLVA==
X-ME-Sender: <xms:EwNbZ09zJhyM-tzZTMtLlrTvgz-_zx7DV5R7bITjRPIJAvncZ3fUCw>
    <xme:EwNbZ8suwp6jkyQp1MvPrMfHUdjS8ZsvOUHg6Krr9BKF22x20BJWU0hertMTd0hew
    Wm8uG7hMwWPuYfsxRc>
X-ME-Received: <xmr:EwNbZ6CmPDNyVh-cYrkWuV4WpWeVVw6V_XcEN8DDFc-ox8luXfWT3ID4ZN8P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejiecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:EwNbZ0ce6u59dw1dShexoXdtO8NGz1epkODwd9Wk3QkXDbI7cf7vMQ>
    <xmx:EwNbZ5Nymsj5R4mvS_6o7qv6WL0_OgjJFJMDfY6CpQggqK03Jd8yog>
    <xmx:EwNbZ-l2HcfohCyoscRL0eHkgMu_IqCttEcFZ-LW5F_uzR6Bb2hssQ>
    <xmx:EwNbZ7uIyl-DsGIoJpw1zr-uG_FwYV8diODglSvN-rrThbp5MKCHrA>
    <xmx:EwNbZ6vf7M5_8InmJ_dk_pafIhw2cjta9VuIMO5SD7yrc51YlMv5Nhva>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:36:50 -0500 (EST)
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
Subject: [PATCH net-next v5 1/6] tls: block decryption when a rekey is pending
Date: Thu, 12 Dec 2024 16:36:04 +0100
Message-ID: <2f5f05db51d624c47fe92e27f02c922dc7d9c035.1734013874.git.sd@queasysnail.net>
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

When a TLS handshake record carrying a KeyUpdate message is received,
all subsequent records will be encrypted with a new key. We need to
stop decrypting incoming records with the old key, and wait until
userspace provides a new key.

Make a note of this in the RX context just after decrypting that
record, and stop recvmsg/splice calls with EKEYEXPIRED until the new
key is available.

key_update_pending can't be combined with the existing bitfield,
because we will read it locklessly in ->poll.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v3:
 - move key_update_pending check into tls_rx_rec_wait (Jakub)
 - TLS_RECORD_TYPE_HANDSHAKE was added to include/net/tls_prot.h by
   the tls handshake series, drop that from this patch
 - move key_update_pending into an existing hole

v4:
 - flip TLS_RECORD_TYPE_HANDSHAKE test and use likely() (Jakub)
 - pass ctx rather than sk to tls_check_pending_rekey (Jakub)
 - use WRITE_ONCE to set key_update_pending to pair with poll's
   lockless read

v5:
 - some coding style changes (Parthiban Veerasoora)
 - changes to error handling in tls_check_pending_rekey (Jakub)

 include/net/tls.h |  3 +++
 net/tls/tls_sw.c  | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 61fef2880114..857340338b69 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -59,6 +59,8 @@ struct tls_rec;
 
 #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
 
+#define TLS_HANDSHAKE_KEYUPDATE		24	/* rfc8446 B.3: Key update */
+
 #define TLS_AAD_SPACE_SIZE		13
 
 #define TLS_MAX_IV_SIZE			16
@@ -130,6 +132,7 @@ struct tls_sw_context_rx {
 	u8 async_capable:1;
 	u8 zc_capable:1;
 	u8 reader_contended:1;
+	bool key_update_pending;
 
 	struct tls_strparser strp;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bbf26cc4f6ee..3dcf8ee60fea 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1314,6 +1314,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	int ret = 0;
 	long timeo;
 
+	/* a rekey is pending, let userspace deal with it */
+	if (unlikely(ctx->key_update_pending))
+		return -EKEYEXPIRED;
+
 	timeo = sock_rcvtimeo(sk, nonblock);
 
 	while (!tls_strp_msg_ready(ctx)) {
@@ -1720,6 +1724,34 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 	return 1;
 }
 
+static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
+{
+	const struct strp_msg *rxm = strp_msg(skb);
+	const struct tls_msg *tlm = tls_msg(skb);
+	char hs_type;
+	int err;
+
+	if (likely(tlm->control != TLS_RECORD_TYPE_HANDSHAKE))
+		return 0;
+
+	if (rxm->full_len < 1)
+		return 0;
+
+	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
+	if (err < 0) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return err;
+	}
+
+	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
+		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
+
+		WRITE_ONCE(rx_ctx->key_update_pending, true);
+	}
+
+	return 0;
+}
+
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1739,7 +1771,7 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	rxm->full_len -= prot->overhead_size;
 	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
 
-	return 0;
+	return tls_check_pending_rekey(tls_ctx, darg->skb);
 }
 
 int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
@@ -2719,6 +2751,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
+		sw_ctx_rx->key_update_pending = false;
 	}
 
 	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-- 
2.47.1


