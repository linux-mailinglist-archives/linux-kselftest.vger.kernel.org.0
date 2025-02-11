Return-Path: <linux-kselftest+bounces-26294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD8A2FF6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9CB1884778
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D81E9907;
	Tue, 11 Feb 2025 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YUpkXHaE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC81DDC14
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234482; cv=none; b=udSkGkTmp+Hw8mFQk5aSmV/JJk70KCbFp6dvk6LoxG5/8HpB1nT3QYFjC4dr9ZYmLBHokYMccDCedvdIbq6G655dONZJwl/klTPtiks1jfsPT8qDx5K0FaLYWtsHLYpMY3H64mabJSJJ9zqiHOhVmFprZXtkyCVdCyYCM78NQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234482; c=relaxed/simple;
	bh=KD5BFpOHNqSvy48hENeZDo81i4H16OBz+7xPO4NE0r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYi/Of0rc2WEiZtlJKnEVHBGozJD226/yJs2IS11Sp+VpOgzNN42084w0TKTylWFLC4jjUqksLnp7xDG0NcHs0+AYQ7I71VPhs2w65iEcjjUMQcgKaG0tHtSrnP2Jwzjy2tm6xSkGMkM7/SJs9bjAp8Z4oFkCMTgxOmc8a3ORo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YUpkXHaE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436345cc17bso34411965e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234478; x=1739839278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EI3H1b1PYT7I1BdLZ0sMTpvWIzL+1PSLPvHLdSDaSw=;
        b=YUpkXHaEx091KYbmKYpEGYgGdKH/GpDsCGP1W0xI+xWnp7EtkFpqDwLpw3tkTzagNV
         MGbKjgyYf0Yw2Yn0fdXe0i6Q5PEJCKbBmlSAOgkhqgCMyUsNE9iEHtlOxEwVlSe4G8JZ
         Hpo6TpDmTkkXDMFm5ylTabyIRoVH0MP0XpW0HuUEbBJlFFSK/FOTzBWZ9sjAt6pPCBxO
         n0MQgQ7/745U4XAjZK2RzBKS9IBsDpOpic7TWeZ+SHXKyb0NQ4iQbIcqd7ZRO45a1Vt1
         TLnpWtnxm8fXDG5g0oLhDGXu/CesvEAA2gtu5CNlTeYQuZNauT+NYlUuVTiMjlGhboMx
         mPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234478; x=1739839278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EI3H1b1PYT7I1BdLZ0sMTpvWIzL+1PSLPvHLdSDaSw=;
        b=eAJDduMDS9K0u1BKzCiObyxJal9M52gA5JYaFwXuEeFarrEFbYNKw9v7Xz5MmhvLZC
         kq3remBmAOJkon8/4s3c3ZBGMJNznocZLe3uQ9RwctAf0z8DVVg6/7TgkfTs1KBKOfSO
         +o56Zb4UziGr5rszl7ilwk1DDxZTN4k2bqn6a92sac9GmpDVdx2LqOvreS1WIdvXhuEf
         fIdUb206391cWIAxM/yATIYSw41Xtx23GWBYKFhRa4Dh+/AifaBlemE/aWkuzIq7Btfc
         iqx6T318g7TR179Tzi3SYhDgvEa6f/kO5R9Xbhx5zTKoeBwIidlZXVIXEXljUJQEPA61
         cDUA==
X-Forwarded-Encrypted: i=1; AJvYcCV2s5NfOzY9lUqXcnb9fookf9vLmFHK+NeX/K7HU3tOTMbyyrVv0N5eBxYkDZPiIWaGS6FsJyXgElDul2+xwDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Vllo0OstiBKWMbuKHNCcGTF7+9KJG2xD8wtuAFQwwNCt/znR
	sQ2zFECiGNex711XqV0QX8KY8wXsrou3M1qB4m67WYUZYVvozP9sWJ0d8suCsj8=
X-Gm-Gg: ASbGnct0Q54U76U6CpM5+G3S8gLvKHMjD6I3XziX/T9GELWnyl26qMbKFRZcUFQ9Oer
	6HL+9/pDCaSj3Gqzhl22edrd57t7E9OlW3p2B5HIqBiVsUAV76zdh1et+tNyjHO535g9eD0s3hy
	wU6yK3Lp1FHNN3t0SJGc+v8EqT1dVsocoMY9tptFksUQ8MhLC3KlxNrexcXBSQSE5c0Uy9qVP/L
	JmvYWVpIAnea+EqEII1BzuktUXc1m69j+CN2gtYWpSILzft97SA4wg7Pb569aRlUgIleprIQ/Ax
	26tQUglYLI6pV6Xs6iqfgsh8V8Q=
X-Google-Smtp-Source: AGHT+IFKSdsxUH0mb61Yv8dAVEGvPV8nyRzJdwcsKzf0RWS0xgzb4/3SNNPkbAAI2sAkmgFuFxDXbw==
X-Received: by 2002:a05:600c:4e13:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-4394c8538fdmr13205315e9.25.1739234478587;
        Mon, 10 Feb 2025 16:41:18 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:18 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:07 +0100
Subject: [PATCH net-next v19 14/26] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-14-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=KD5BFpOHNqSvy48hENeZDo81i4H16OBz+7xPO4NE0r0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNw21/hSe4FFL2FB90CoPI8CErMCqUwISSR
 b0KPLN4+omJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h+hJCACw4xagGSlZCHvOYq7pyy+QacdWEq0boNs7Y5MNnj4dTkcTDE40KlY+hm/PLHcde3PjZUv
 46qUAzT8iKBWyErBWxcw7dnbaVEU61U2W1+YQsCET2ai0u4gRf40CMOFCPQixYEgoAMCntCcop/
 ek3yc8Zxgj8LqUF/elVwPiyEuzqQcKNtLJ7TNnYj9WubT7zAWxVP3F2HJEY4kmWeTqc9fap2TpV
 XCYszQES0HzAjJ3RDwThMTdZu0o0Pn5ys1bDbEzW7iF/UL6VjJ+klIIjvPc/lLlUNwjrJYX3D7f
 9Bwm+2mlK+aJnksQIQVYbDgKvJYK9FZYUCJ6p8Lv4j9eh0CS
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
index 6a256684d68682bd4dfab93dbff092d238192316..e4df039f959e8af945844b2bbcd9ea416e1bcec9 100644
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
index c7eb96d79e0229d178e1cf090cea45361730685e..c4d90cfeaaf7d032270fa2c9cb78f4ca7745750f 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -210,6 +210,7 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -220,9 +221,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
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
@@ -363,7 +366,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(sk);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -396,6 +399,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
 peer_free:

-- 
2.45.3


