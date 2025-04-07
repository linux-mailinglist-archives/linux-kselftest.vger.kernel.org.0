Return-Path: <linux-kselftest+bounces-30292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B720CA7EE0C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89783B060C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42A254AE0;
	Mon,  7 Apr 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PN7vKgAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B04253B76
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055250; cv=none; b=pwS1It113k5dUlfLFWJzZzfdCYURpyV8X6uIZ3HRnDO3DQGB8fXH//tMp7i8Otts6Nymis/AXJpjMyYTcyM4xh/v2Ft1DyicPI1Nsc1Q9MmvMW2Cf7UbrvIzbebSB803if1NMkln9gselbSAot6jzGIQgQBp6VbyfpJf7huxySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055250; c=relaxed/simple;
	bh=wzH4mZ1losQ9EcIaWl7/8jmbciLzvK7M9av0XqnIR7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9H3HqooUeDd8iQGVBcZkXnBXXI01Qqhjv77uNc6Z37n2PrbSlpsAK9BqnoPJbJGyWLiBOAKe2Hx09iAcoWykVRBLwyaTeaRSr/ZuNZ7WqryMze+6AoQN+Z3qISF8CQQHgZpYE0DMEFmWwsCsOEWyHGnRk3WNbDVdaoKOSFWzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PN7vKgAY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso30448355e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055245; x=1744660045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ma0bQIv5ZH+RvgJgwGygKzfyMy80EbTPziB74rZI0s=;
        b=PN7vKgAYLPLwCPtWfT3k//JoZFrIcLwM1Nbo5n5TDeXyB7sZE6BR/A2pRx7yC/HKnl
         3D/qpcHKttD9+hQmWjzrD3PDadV7ZSonneV2Vu7E5LGoSuZtvusUUVqbj74a8nCQx06d
         oPb7L6YwHOiL2rxjS5S3I/ZqX84XsXxht4L72pQHkFNln77d8mmwN16UYua9Bu9OivnH
         20F76FWnL7OyuXvvLGrirb4r4rh8+VM3C7TTDy908Hcc6HhgSkx/WWMFiAxkScxq11Zj
         Fo8okN/gfOHWUZxP1rEWbkYnGmwlD++CphUg1SowjZm2ltj+P5mzJ3mI9TBwrA2rgFFf
         H/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055245; x=1744660045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ma0bQIv5ZH+RvgJgwGygKzfyMy80EbTPziB74rZI0s=;
        b=ASq30j2NfUZU3sRBaY9IpAEem5NKPno+0T8VyxcGYIaovrNOCwX1yQNA5eZNIytw4v
         2npuHWLpRV4hdhIjbGgb7K3hdpMxOhm0uBBuoKICKkSSJkuR3oRzSTuvhYmyaEpkeu+S
         O9I7od/8hwSa2JqFLhla0qwW+mLazJYNEOLsAVdDNJcIG8N0JNyfETXktI2x361tL/Ir
         GExSV8uguajRyhfvzQRi0tb+7+ZFEmqm08owhrVkEAVUD75SLg0wPUR7mjsE1YEX6som
         fuqsm9HUTeKUTzfblAdQOIp9zjPWDdOChMcl7bpd4Eymmt8cUE9XkLz7k4haM10nC0G6
         B3mA==
X-Forwarded-Encrypted: i=1; AJvYcCX6+5j7KTVnAJSi8Xhl4mmQDeKRSJK/fPMh2DZ39vf8o03CKqTDnJJaHiTb1HMmEnZFNJwZZwp9Zr/ZvLay2/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ckD4VnvwAik409+Rn2lUwAiG5zC9Uw0+hulGa0LF2+XTOnTy
	7HUojonmaNjbjPuunmsx8MLmPop3BnP0edRzzSvKiKCINeIZsGhNNKIqTnIIvALucOUSBJuPG1a
	GYvfDOATnXRG/Y/HhMilvOI7KyQF1C9dY/6azwYj9bmKk45XvtUftOy+UImk=
X-Gm-Gg: ASbGncvK53vDlXQPx/fozbSieb1NPsiOXG+rLfPR5XfaoifsGkWcBspsmHcH+xi+yv1
	ea4PFfhMG+2qVmh0IZr1pcCtzz8KoAMRWrtmag1vY9zjwHXp2w69LVj8ijCq4TMsRgX0isB9h7+
	lTczT2lWb/z47m3u0O+d5YoDEtm3UbStPFgmvZvzYQS89q7WrbceybIOCfqgAUrcRgRszz0dqf1
	m1faQULdaVRbnPQkFuXpicI5FtovHdG5FjRa8XLZNriSRE1ttcTpHZ0q1MkvaE0k2Oi8/2HII74
	YtRXmdSHt9dLZMiJn173S3ZF9Ptx8J1hM99/MOD4Xw==
X-Google-Smtp-Source: AGHT+IE6EXUufFkZTu2mYomG97r2nQTYBX4UF5AGsCbG15Njqy8DVgtH+oVI4RGOusxdtC/V8JmmPQ==
X-Received: by 2002:a05:600c:6994:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43f0e59bb7cmr6146735e9.8.1744055245216;
        Mon, 07 Apr 2025 12:47:25 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:20 +0200
Subject: [PATCH net-next v25 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-12-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=wzH4mZ1losQ9EcIaWl7/8jmbciLzvK7M9av0XqnIR7g=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu12L3Ytp9N6w1qC2Zo4kQTwB9Uzzbrbz8fQ
 pHdGnWUG9aJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtQAKCRALcOU6oDjV
 h/yLCACyfOy+KqqiehEkT1tBhCe7V+T/Fv6xhyVSSHyQwkvUwd5HkLmHdivopAT27S1Z0g2UaLR
 ngPZKcl6V/tufMPEXXp6OE5c0VCq6880FZB9n5YOxevttoulmahgyLSkPR6foTb5Bb5nmHu7Vdr
 ypl55CCSNOR3NpmB8NISFndvxEoAccwOzpENvCyJjhln7+Q2+77kdME0m3uh+JiQGKes/KTCRhX
 r649fCoSt82SNEuWQKYx78oE2aXdiGqZ++C0DgbDzVaMSyiD/qTdU7YTpwjWcaZMZFJAMglbCho
 0hjJxH8lmGL+xpOGq8Ky6WKPnfH2Pu7kwfZkLv1jmgpOI0MB
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

When sending an skb over a socket using skb_send_sock_locked(),
it is currently not possible to specify any flag to be set in
msghdr->msg_flags.

However, we may want to pass flags the user may have specified,
like MSG_NOSIGNAL.

Extend __skb_send_sock() with a new argument 'flags' and add a
new interface named skb_send_sock_locked_with_flags().

Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b974a277975a8a7b6f40c362542e9e8522539009..31f09f1d187dfb4ddcae38fea377e27141cd83e8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4146,6 +4146,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6cbf77bc61fce74c934628fd74b3a2cb7809e464..b7acb83083a8c33f4d0daadafad0393c6459fc75 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3239,7 +3239,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3257,7 +3257,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3294,7 +3294,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3340,14 +3341,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, 0);
 }
 EXPORT_SYMBOL_GPL(skb_send_sock_locked);
 
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags)
+{
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked, flags);
+}
+EXPORT_SYMBOL_GPL(skb_send_sock_locked_with_flags);
+
 /* Send skb data on a socket. Socket must be unlocked. */
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked, 0);
 }
 
 /**

-- 
2.49.0


