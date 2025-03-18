Return-Path: <linux-kselftest+bounces-29318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14AA6657C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CB83BBF4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45F51D9A49;
	Tue, 18 Mar 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TRpXd+pB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A21CAA7A
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262083; cv=none; b=UvceZLmOFPULUr0OH7oG+T037qr8UUQ0ASI0AFjkBBmeHAzuWelZJ1z39OyciyqS40K8ShpDiQ5Co3eodVBEN+kp4LzoSBDB6DPStMdqiVIQdnG60mL/aDSgnOVl+4IH13qAmAwS+YyZaeZcenEbm+RjD+EqGp6egJHCgFXQPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262083; c=relaxed/simple;
	bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeQWnp7OJdethkTZXzL8aLfOB/gUjQmUI+2Q44GwPe1qKBQDxrJXgoCX82V/Jn7x53BXR0jDYogxB2y7Jfsxk4tTRZDkZPCXVnAsHp8zvtqWZ9QddCy0UEHcIdFK8m11PvjBjd2j/pofiUjv63YU7hfeJYV7ac0aQsPvGUSobcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TRpXd+pB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so17453945e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262078; x=1742866878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=TRpXd+pBcCszU+68vSH0te3bPl+3eytQUJ4k1FMXw9bvLhEJh60b2s9RsebOb3sPUX
         YJwwzbGSJIsJFYSZBeppneIsK5+fNxfpfxCEDO2TAZX+ziwpeB1pknqZg6J21SrFzdRj
         NzqVFMOwqDKhXFVMWp4aDcs8K+pPTx+qwS/f8s6cth9YzoU8IFnhpVXRo7QcmmFYBwZ1
         jNpRR7OuJyfzsK5YYvvr1GhdOHMTnormilRR9XWLC4uUDlrsHmXQqiV+V+XqM7XA8ak8
         wC5knYbv3QdAXoDoczl+CLWVDAWXL5CZRmPD6fXZaxPbRLEXrSsrM9MppHonarRLNQ2L
         6h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262078; x=1742866878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=T9RBNjWBZOwez0GP80G5eOUCJSjCr6yCD7fA/KBqlf3hpkkq/I6rGX6g0D18Urd8tZ
         KCXFYtNpCgspkIpmIUJ8gPiHFA3+JrWlO27B3GwayGzMbjwozm/Fgq6Br2uqMIRBPjES
         JESI4pkU+bDk86vGBqFUKUmANIOV1yBeaVxaQhkY69uGPSzFLzTgsMSwZPULYzB0UK9k
         z/VV1cbD7NnvqtpADXNTBrRr6xP/JKYT/c87sOFXVbEXkeQAyLJ8l8e5GxDXxYtWFJnJ
         dqznxJlR/LKsNNJD5Iv2ysv0Qro7jBEUASunjb9z2ZKfGFRcLEap64k6P1RfRD9yQfU+
         pNBg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHBMCSBKJX6QY750hSWMWGcKepXDGM8+eo34gsQlJ3L7h++1ywAp00grRyE5DItlyYa5SI7zD6M9QgpsEee8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Xdq/BFuOaenMmVyTVrnHLfZRkWd+VsaBJHngy4OgwpgjX9wx
	sSAjR54b64UC7zSOrCnqAVdW9gk5rxMODWeSdFjFb6aHryO4Yn+jbUUNZ4MYP8iJ1DkjhZkmY3J
	yD6jmFZ1IzIVXTvmcGP10IJVFIKmR6O8EzPwkO7cSm/VyWWhphKUFD3tesys=
X-Gm-Gg: ASbGncu4t/iy8mWzbzOzBYgW1VhOtufONhpBjyzlnoepAHUXOEHI+I/sTSWiE2FvU+K
	QY1QOY4UHpwlWm1zL5OPiaQD0UxqPho96Co6YLVMqLe5sNmV9Wm4HopOpjAvt62S1Qv/XmdS0Lp
	M6kciZu4LmEbY+gCQglNJG5NEg4C1XsC7YEuJXbaKwR4sAGb+FMBs0IeHvrH0/HeTK7mRZfLIQy
	wlZks1LAcugUzoEidtJhO1qv7mTgrq5M7gULuFShj7mcj4CjsUE98Mq+cuiT6/TWp8ENtaTx9kV
	f4MQqsMl1sk4bn2+KNujH3UXrwepwrijU/Em2SxYNw==
X-Google-Smtp-Source: AGHT+IHqeJJB6p3PoA5xtIGi6myNY1bmF45NitqbqT0x2T6gAO+urMnONrlMbIIy83p4Xork7TqQKw==
X-Received: by 2002:a05:6000:1786:b0:391:3157:7717 with SMTP id ffacd0b85a97d-3971ee44b3amr15250169f8f.34.1742262078404;
        Mon, 17 Mar 2025 18:41:18 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:17 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:48 +0100
Subject: [PATCH net-next v24 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-13-3ec4ab5c4a77@openvpn.net>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
In-Reply-To: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
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
 h=from:subject:message-id; bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8q86/OsIjQ6nK0ztYo7KkJNN0dXT522Z0ox
 2bbsdTYGFeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKgAKCRALcOU6oDjV
 h4ffCACkINFQ8KkAhxcg7EQ9+mUNoxuLMqTJt+SaFAr+yP5c9EV4RW2WSWCW9CGl2X9RQa9g3/D
 vbv5lVRCtItJfOQwI77FnWhsgl3nhfo/34zahw2JveMalAMt6XqegwzuN0cRdBbCZnm9iG/h3xn
 30juipXr762plkImaZxxDse4LFCzzameDcHMO6NJtuF/UISYGfywGvaF9VWmO/+tEvXgFACVdqo
 xrot+85ngpCL4CSfNbb7ZvmW/snhNJKGEzxcMn0BGkcsmxZnDXREO2SUbrhPGiUhHymjy4YIw9W
 YgBDgm4F/zPJJoOXvHNn1tqWY2kxMkuKPi0OisBqMuQcnFb4
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
index a5bfd06bc9499b6886b42e039095bb8ce93994fb..e05c9ba0e0f5f74bd99fc0ed918fb93cd1f3d494 100644
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
2.48.1


