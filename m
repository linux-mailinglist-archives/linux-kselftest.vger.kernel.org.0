Return-Path: <linux-kselftest+bounces-22037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553169C8EDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF61C1F230B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624B189F39;
	Thu, 14 Nov 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aSfdPi0W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glg9hqdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DD13B288;
	Thu, 14 Nov 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599479; cv=none; b=jBid3RqbMF+/xv6GDBnEo+FUk+el9Dwuu7EheEaTyri5XWaNvml/sepfBnheJIW4vowfjrqBXAITtqqSs8B1a9ExY75WfpVGm5KMa3nBI0AfgggaPX9SpcFfnS9eSnlFZYMavjEBvD5oRTn9NOVAOdcpQ+KBFpDAAEC5X3wgZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599479; c=relaxed/simple;
	bh=haoBI1UC66DNnVzb9xAw0KQFgN3vYme7dPdO/dRBJ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYygmRca9OxxFFVik7DyhHX51dbcEgH5eo6ogR7ckhYNSgJkbCbAcfHq0oz1LLyW4qVisscITSf4hzWhYVBpyvHJpzf/5RSh/HlgAwwBb11KO7cyKmKGsgS9SNflMMkdOn0YsqCO/Ejp5Qkjoa5qxOdZi65fOD/qq7Yn37q6ReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aSfdPi0W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glg9hqdI; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id A440B1D4072B;
	Thu, 14 Nov 2024 10:51:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 14 Nov 2024 10:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599475; x=
	1731603075; bh=u1GCMis5plunGNBgOIvZFKCIWH5Da90ybQDDoSOkqzU=; b=a
	SfdPi0Wb7zh7ACDUC2+IJdcUKT6+1YIzK80U4oBYjEiG1vjtM7azezWmob8iOSKv
	nFEYbPYQVySL0bviGBxHBhXUq+xdUn+X/uzdCWLchSV0mXDlKuI2PY15NlIgmTNY
	6JLfZPgXHaYiRVMMULx/ZnaaEywmkVVg2hTNd8DDekWSGxmyijCLjdvJaau9h5eN
	uYHElcbN531DKUBP5MUmUQoSyO/Cjh6MSSLgaearHuq8aaMfJNs8sOpqmt/zsyoI
	wdQszlwOjTHybPhpZkWtwZ3bB5cU4QkD986Usfitpl6gLZbVaOT5+EScLn5sE3yP
	duWtRkYRGnszqsfx1Uiag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599475; x=1731603075; bh=u
	1GCMis5plunGNBgOIvZFKCIWH5Da90ybQDDoSOkqzU=; b=glg9hqdIwgBqqUMP1
	Yt22gu+kP4T2jgX/C05Nlh2gSE50giJGm2eFtRpDzD7WWiyu5C/8g7oPNzvykCTH
	ZWN6r5zDMGQ/uBnXOjMHAD6sK300kHvYLbE7zEZSINNRUHgGseK0VG5VSlFgi1KD
	L6gg3Z791wD+XcBV7TWidmNYBJNUE2PfasOfk3zw6W0KbfrGOHjqq5RIG4Tg3qhh
	kTpQhhZ5Lurbf32LPQpGkwy129HfUH+6gACkWBL21OS5ywMpc8o+Vlzrzl2dIi2O
	pWkTBUNf4yW4irxFrn/K5ZmXJZsd+lMpoplIL5sExBEVPvuWdRwiZOy8TsoNPiCR
	WsFCQ==
X-ME-Sender: <xms:cxw2Z2v0QGKiOhWenev4wnuEyCEzmsDKZq8LaeLyXINUCYzAuT3tNg>
    <xme:cxw2Z7dP2pV47tb9YgBV3rUHTueGiVoeCHtDOP71ql_gRCb4u7n3dxi3BxwocFnYB
    BDte7CwBVZmPZMuvbk>
X-ME-Received: <xmr:cxw2ZxyzphefMMQ6GkMlX4YJCt07tNEA9G33gr_BKPTgsYJPqaDETQ4zejU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdekudcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:cxw2ZxPXmIGrWnHx1SnCCurykS8T9FG2HllqS40ahm_n0clUPzvz_w>
    <xmx:cxw2Z29pFnvh99O3LTQZEeqxJSokaIQ0MuUEe3zXxhD7XrWH-nqmwQ>
    <xmx:cxw2Z5U6f4DG3OcGUFqwmg903Vt4N1hEnKfgSlKlcWmR2uhV4IgTzw>
    <xmx:cxw2Z_dgx66WJHN6Hod7mWk45zJ6Bi9ySsTAxIngArW-94U8zAgJ5g>
    <xmx:cxw2Z5Uc3UiHdiP1gI9TStRgwYip1sQGdM7IuTe0CvRPn-xqsZx7UaKm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:14 -0500 (EST)
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
Subject: [PATCH net-next v4 1/6] tls: block decryption when a rekey is pending
Date: Thu, 14 Nov 2024 16:50:48 +0100
Message-ID: <327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
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

When a TLS handshake record carrying a KeyUpdate message is received,
all subsequent records will be encrypted with a new key. We need to
stop decrypting incoming records with the old key, and wait until
userspace provides a new key.

Make a note of this in the RX context just after decrypting that
record, and stop recvmsg/splice calls with EKEYEXPIRED until the new
key is available.

key_update_pending can't be combined with the existing bitfield,
because we will read it locklessly in ->poll.

v3:
 - move key_update_pending check into tls_rx_rec_wait (Jakub)
 - TLS_RECORD_TYPE_HANDSHAKE was added to include/net/tls_prot.h by
   the tls handshake series, drop that from this patch
 - move key_update_pending into an existing hole

v4:
 - flip TLS_RECORD_TYPE_HANDSHAKE test and use likely() (Jakub)
 - pass ctx rather than sk to tls_check_pending_rekey (Jakub)
 - use WRITE_ONCE to set key_update_pending to pair with ->poll's
   lockless read

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h |  3 +++
 net/tls/tls_sw.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 3a33924db2bc..870e4421c599 100644
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
index bbf26cc4f6ee..db98710c4810 100644
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
@@ -1720,6 +1724,32 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 	return 1;
 }
 
+static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
+{
+	const struct tls_msg *tlm = tls_msg(skb);
+	const struct strp_msg *rxm = strp_msg(skb);
+	char hs_type;
+	int err;
+
+	if (likely(tlm->control != TLS_RECORD_TYPE_HANDSHAKE))
+		return 0;
+
+	if (rxm->full_len < 1)
+		return -EINVAL;
+
+	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
+	if (err < 0)
+		return err;
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
@@ -1739,6 +1769,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	rxm->full_len -= prot->overhead_size;
 	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
 
+	err = tls_check_pending_rekey(tls_ctx, darg->skb);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -2719,6 +2753,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
+		sw_ctx_rx->key_update_pending = false;
 	}
 
 	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-- 
2.47.0


