Return-Path: <linux-kselftest+bounces-30851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B57A89C05
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1736441DDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3F29A3E0;
	Tue, 15 Apr 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Km3SQY+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C3297A5A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715869; cv=none; b=mZXq19u1Lz6XEputf6ZQV5SBzrbSqO+Buh1TJF/Zf89hyj7O61X8DzsRN2KjRii3C3pacjuj4i9rIZyG1gJtlR4rU+7G+L/3PgZlkmJpyu3pQzrwo8zlMVYqfWTWTM/GfBGLf+xuDPJPik5gx9JFpeXAgzqzPJeat4tXLpMsiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715869; c=relaxed/simple;
	bh=+Unom1yykFNqbE9773wCLW/thNu13gqRTUvNb4z4izU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bj5RW8g5I/HV27hKvCaJAs7x9IGOpnLKKWLC9/ITd6+mdd9u6TYI0AyZNFdsnxdluQ84n+qTBF8TT8XezNpS62DWd5581t8nnDoLZIqge68Aav/VQmA6TI7pgfOpBF1bdFPgXAsSIaIUsJkoyUS9W1qT2E8Fe7yGCOfiCfj/0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Km3SQY+g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so43924035e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715864; x=1745320664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTV89+C/IAgzFB5m5xPEkC+pORUgcF9jMRUpcGRiTts=;
        b=Km3SQY+g68dlL5WDJfC9Wox3eGYLBFS2chRqnlwomuKB2kuzSEES130Oy+FHQQ5bu+
         myJtOB+U//Tcy0CjVyTfP5kBUA52GLq7PwPu+DfrHXPeNheDDXb93LSwXUAnR8uL2DPr
         Dmd0KmtfdB3xhE9AEwDThk2DQeD230CzX0uy+HICxT3OnDcLiV6ylXK2XZabjUNm+sjA
         Drk+ReGt3IE8q3cQ+sCc2wRdoCj2rEtWpoyQAUL3XkBmNNb01RfxD78YEZi7h0aV7yDm
         zer7EsnuVPYnAy6P+nSmtcWLfbT/7UISDrIpFatKYKMPprMnmrqKfsMVXqVVK13Q0pdu
         fX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715864; x=1745320664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTV89+C/IAgzFB5m5xPEkC+pORUgcF9jMRUpcGRiTts=;
        b=N75LogsOsEomcGIrgfm5UaBd2OG9cWExigBGJX55rP3TFycg+LdAEpn0hYpDrhK1HZ
         5HnbHQ7ZizPAXE1Pwkmn7UiR9jwj5aM+wGskVErNXAEE0yu6nEZlgvR3GijyPodfwJoq
         Y9UIHU/khARbwuPDlLX8klyny4yi3eRtWq9DN6GhDNVCQE2R0p5WMf7Cb3RoeuXfMyyJ
         WL070Ap8hZp2ILFrvjY1LFhkTTEhPI4kaX3QFtUF9xoYXZbK3LO2SKLvBJoFbLnCa9zy
         HqvORAZYTu/X31i06+I93PwZuZTkY08aS2NuuK2XCdy7utolz+egxjNEMx/6qnlOvdKa
         WjgA==
X-Forwarded-Encrypted: i=1; AJvYcCX91v4XdTwYJ1LGVa/iI1dC1ob/hL2wqlO5dfdgUSfdV80NHHAOEaFg73vqG33AIf/XkQ7jyJSNHA5VVjhLEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrF1DL0Z3wDZmlR4V7/eog4ZROLn75+oZw9E0PwKZr08YZlTyI
	CPfMp9WT805MuBi5BwNIhUPtAgfTexPndeP6XO98UvGBNVBTz7M0nfm7eq6aSDXX+J0JIjb8Zi5
	aiu1IAkEYVmhz/D/k4/HDy69YQupeS2t7ctekwpRwq5au1VFOw21PcfE4exA=
X-Gm-Gg: ASbGncswBwsJ6lHXcysb7epKMW21GLY3c2UPzNJ/PrRAShQLXD4Yoot72ZrH4XtpUmb
	i7UeC8cyH+NdmVtd+DHeTHx+1Mk8u5+NAdMp/MehuSn1D6HfC7GhmxIgVzLPUSW46b+s13nm9Ic
	viqirByc9AJYtWlCNQ0S4mecUf4HqSJyZ/BgVehMBNJtswn+Jop7Z1KufpUnqirOejBi0mrSMXa
	O2o6sdPJf6XqAqBB/7QSeE0UdGl3AzM5f5UDaK8Mi+yUa6htdZQrNgTtCeSDr6ppWDRq5F2CP8i
	YhQtJk6RsFEfz/TnjIrLU9iD51wRv+6LkqLd5w==
X-Google-Smtp-Source: AGHT+IFMQlof59fOSg2M7Eq+m/RtbhU+97yysT9+PCWJfN8QfdC4S+dr1wKcgeULLpXXtIHsL2RW3A==
X-Received: by 2002:a05:600c:4fc1:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43f3a9afc1emr114850195e9.25.1744715864556;
        Tue, 15 Apr 2025 04:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:44 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:30 +0200
Subject: [PATCH net-next v26 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-13-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+Unom1yykFNqbE9773wCLW/thNu13gqRTUvNb4z4izU=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBC5GCVEXr1yIn8QuqochbJhgC073YBScniF
 aNqKp9N6/qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h0skCACVDtxscS+U1pTczUQRXmdOPUnVYdiNZu9j/IbBs6wPQNrsNWG68KmhumIbaHSuJ3KhE2j
 o0r8LcyNbe/eAQcsnJcmiWxD6lXq0Nj3Ksh8fvo3jtAlN78gdkCCJkacixK0AbAAZL8j7/FySOk
 snWdSK2+2gc746sqw1LA+7x+BWFTaxf3GV31em7bTGo+WIFQ4Dy2YDolNlN9kLghzUXj84iXJOY
 K30JWMryR49joNOZLiOQQ5GjqfkF1MxiqTAdtixCs5qi9LL8njRQx54g0tJCT/UzezZccB5WxcU
 zUaehnb687l5liknaruBdGyY3ooLvo4a5e9VmfDKkm+wkrgx
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Userspace may want to pass the MSG_NOSIGNAL flag to
tcp_sendmsg() in order to avoid generating a SIGPIPE.

To pass this flag down the TCP stack a new skb sending API
accepting a flags argument is introduced.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/skb.h |  1 +
 drivers/net/ovpn/tcp.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index bd3cbcfc770d2c28d234fcdd081b4d02e6496ea0..64430880f1dae33a41f698d713cf151be5b38577 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -25,6 +25,7 @@ struct ovpn_cb {
 	struct scatterlist *sg;
 	u8 *iv;
 	unsigned int payload_offset;
+	bool nosignal;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 588ff6b0440103f6620837a75ea2f1029d91b8a3..7c42d84987ad362289dbf5e7992403c76e910ed9 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -220,6 +220,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -230,9 +231,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	peer->tcp.tx_in_progress = true;
 
 	do {
-		int ret = skb_send_sock_locked(sk, skb,
-					       peer->tcp.out_msg.offset,
-					       peer->tcp.out_msg.len);
+		flags = ovpn_skb_cb(skb)->nosignal ? MSG_NOSIGNAL : 0;
+		ret = skb_send_sock_locked_with_flags(sk, skb,
+						      peer->tcp.out_msg.offset,
+						      peer->tcp.out_msg.len,
+						      flags);
 		if (unlikely(ret < 0)) {
 			if (ret == -EAGAIN)
 				goto out;
@@ -380,7 +383,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	rcu_read_unlock();
 	peer = sock->peer;
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -413,6 +416,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.49.0


