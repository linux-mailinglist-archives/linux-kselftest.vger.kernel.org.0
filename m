Return-Path: <linux-kselftest+bounces-27689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D4A47127
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF651164FB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34D1DF247;
	Thu, 27 Feb 2025 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TzPe2+qh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAA1DD886
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619386; cv=none; b=cgl3pTLCpIsJIpBLowzCsuS20pcheJJ9+/EO7l7lnVt2XzUOpGcxqRXFcZvUiZ3/Jr1vQmA3VORBwoEYv1McLh1hs8HeSkwsz0VNmPEKHmEsdsF5mOxALJ8YM5pl8eMQYd3rjO/79L0aDDR5eThe5ez/h2xjN9dYxLPkXQD6Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619386; c=relaxed/simple;
	bh=TtyqMEWWXVuF5D1AonBdS9TIDufBNGXd/kgliq1Dnl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihk4x3uqe4T/2e3EjwhRQRhLVxgL23EqCHH7MVBhzshc4X21EKQB+SDeS4MTKa99KVwDsuR9lBUsRVcNoqdV6OOOdv6cX0PCw79u2RO0YCAYdshQ+xIFeCX/mHm6ZLBR2j530lJUqQygW+tZVO2XHuR3EDWcLgf0JCZVMANFsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TzPe2+qh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4397dff185fso3767345e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619382; x=1741224182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uMr00AMeKOQq6/G8Cq5+hM8t9kqBTSy3qx3wjRFbm8=;
        b=TzPe2+qh0i2N991gBSnTJXifuqnHpd7Sqi+G5b8AXh08+UlCXOp2CdOFZg80oMg7DF
         P3+V8GTKLFUzf9MNcXNkCTLBLhzRCMFu8xCcz1xyVodlk1Y1pZNYq7AC4K/x/u7oPDm6
         3JmbvaZJhZsmcusXaEaCfmWnF3XagDkRCvM/fMWou1/dxnx624xpzMCoQlUqYBsAkaB1
         OAFY+NhQw0X3ymsPZGVcAUhQe/2mPYmz5zgo4KJ25d2+r6IyFuxKq+6SiPb2H4T2OvH5
         sOng6HttJV4c4k2Atd5n0joIvSBlsZNpm8/sizhjQt8MCok0zb48u0rFlXAqQYNAOSft
         pKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619382; x=1741224182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uMr00AMeKOQq6/G8Cq5+hM8t9kqBTSy3qx3wjRFbm8=;
        b=pGkqBvnZnd/9yTdUPRhBm6IFytsMUqtp0FXXXnq91P8KPmdDtEOj9gYB/73uEr6xfg
         IEfTCOCz2XmkeI7/q4M6aD0bqZvCvkFUHl7J263X8DBsqYZywqvH76wHTirVrEmF4NFL
         sexWu0EwtcPlsWvFkFY4A09zm+cy+9QhW2rgSt8yz73HPU2tosE3LB1OuAbBoslacf2Z
         Ze+J1LhGnhfyZBoCUyvBJAYsyhtG6QJmQQO/zPQ/HfW6GQcuOv2c823SVL2mNNK3WO/G
         /KPLENluoTtz8cvAwlzyqox9A4VIOSQrEjw0xqzZnOuitG2OiEEVpdB/qlbco9Ns/Bkf
         svrg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6d3jy6n5a8bL+TV/n0+niKwEZUSZHlXF9+WiekLBENYLg8uBACl9sFhEyVXDy0LCEAPvCmTB52mJeeznh2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95j864UL5CiAp2GVSg+ddbV7xhSVZF3S207hoFNys6NoF3NIy
	yL1ACNVDX0BygYxrqmY705n5scp7E5iO3wVmjrrzhI7/5fFY39MMoSpPJgPbJEI=
X-Gm-Gg: ASbGncsBIFWhgS74GesFlgOCeWvC8V6y4wADlTYirKDRjXnu7wnG/678BFh5mEcP8cR
	f1M8/U9XTlGvo5yu0LESVss3wOI2KO6bOBvDHn0IsBbtg/SDt7ud1ukHCaXRzYDhu59lNEc7R8M
	iNX0uWbafeUL7t4Zn7CiFlSh07JCd2X/kMYJSxNVnG25xP5jcN0V1J0bPg85er4wieYJ+P3//At
	odFr/k+2m9VRHbVOPpw06/QYsZ9bUOAUvDZLDh/OIhjC9IH8WUOnC7G1UDuzWshsOwKDeBHOyXB
	D1Eey/+3kpGsdXeiQmG5QLYmyZmQmtCUPmNsbg==
X-Google-Smtp-Source: AGHT+IGZThjyw8csEc9jaKBEB01FBs7BagGwCj/RTwFGtAQi5NzxPS4XLTcnCxkbaJJKJ5YG1bTYuA==
X-Received: by 2002:a05:600c:3148:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-43ab9027824mr39036915e9.26.1740619381916;
        Wed, 26 Feb 2025 17:23:01 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:39 +0100
Subject: [PATCH net-next v20 14/25] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-14-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
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
 h=from:subject:message-id; bh=TtyqMEWWXVuF5D1AonBdS9TIDufBNGXd/kgliq1Dnl4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gt9fLJiTmhxT0bUy5Bi6FTRSIqFhwvBG/A
 2zr4Z49m6qJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 h9NQB/48oDDwO6rfMTo/wD4vJDTUBdcmTjVgmpfNVuMKMBdBbkaaKaziuenj8/OcDoCwbRuXOIm
 4k3SLbk1dc1Vd+AAZL4XfRJjhwAfsyOCqbeit/q2CjTi5vUReTA15QVMm6yZEhIXlau4IHeH7dq
 c3IpDoT/c2OYGGAcNlN3JzUhuVq3u2W3PLuO0yFzb7ZJ49XzZQedJpqiSTIWm+KJTG1mbjizx1p
 fcy+MoK++2YUania4VCIgo6H216+LY6gceB1TXsqtKNIZUSuYWbJBAfTj7KN+uLzFasxwPQpXRt
 hbet8lVu2vx4RfMSU2oOw/4EIfmVTb9fRIkgIqvofOH1iops
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
index 2d343bce477156a9f60ce92d18c815b7c832d2af..10cb0493290c9c4b90fb2734bcc208853d77dfd3 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -215,6 +215,7 @@ void ovpn_tcp_socket_wait_finish(struct ovpn_socket *sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -225,9 +226,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
@@ -370,7 +373,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	rcu_read_unlock();
 	peer = sock->peer;
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -403,6 +406,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.45.3


