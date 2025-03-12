Return-Path: <linux-kselftest+bounces-28855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F306A5E5C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D505517B808
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90B1F4186;
	Wed, 12 Mar 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="djT9y1zv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E01F3B82
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812886; cv=none; b=Brl4A8KSpx8m5BOPH9VleDo4uJPyeEQlI12aVD6C4WYV80sifUFYneb3kYjquexMhxjacSM76PbSR24PuNEas9Xg0Kw+6GTNkZjoEpfKncprtj16s3U6fxITgzTCGfXQTASYjiZAi8PHdym6XUDLUTbgMvBEoXUAvDB1TvdV7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812886; c=relaxed/simple;
	bh=ri2c4Ytlpnb6MthNw5Uj/vFPwNDGP/hWkEwxnYNr2f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLHpSVPabWIu43dR5Y5/1JYvBwADY12xm8EccudUCg4RdnLhsZREdYaZ2whJr1BY/2cX9NPDwgB3ZaFn8C54ZqWXUjoC88vpJFS6fcUm0g410VA3JBeVSjhH+9XuJ/tsUBmblTeGL2fHmPppUnmeH2bJuP7i3OiWmcbwB4v9E6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=djT9y1zv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913b539aabso167362f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812882; x=1742417682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=djT9y1zvuG5ANj8AI6HEuh18nnTyQhD8roeaQyvLsPB0RffkhsA4J8xNB9Z5zzHaQF
         NmWD+FxYIBwmWwp6ZWqA70++tUmknTjHdTjaHwfjPx8po1wLw+dnjoOqNb6bSQCTjImG
         tmZ6caaeV/ticSLI4j0shJi5VSz9Ib8Gl4yykK4elmdaEuvPTyOHLigKygnKTA18dvFf
         gj15lxKz431iD/9I4+/r9n/ggyuXCFeEUniwcBtosvaBW1d8PqO66EHq6VkqWiAmNyak
         wbjLkqEOUAXcYdJhSBrmJKsBea42I8NDCf6TlF8jNnY2GGtsFP4QOBtEzUr4rLgrj11n
         qu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812882; x=1742417682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knj5Ou9okDSc0sSB2beqc0E37iP0V7u+FLPcU5pOcYQ=;
        b=l56RReOrC98tW5mm/Ohge1FeFEZXCNcgHm+HHROHqobqM3XjGGnvzNACkr+hLA2A0A
         LhoHcXSiGg6yJvLyyf3gFmYfuWcwJy3+oUygyCQ6Dqz5beuc4wjy3NhYQ9/XfD29o7bg
         Pr0mI0nWhwg1LK6buzZSuHTN4oGHZAV28AdYAwWzQcolY+KXEC7Ar1E642lbDUmzcdhG
         NgOD7w+P8YX6Dxat/vGN7rQrFQRnC5wGlA+4Z8qY5uZCXybBR66MI9jpxbHYzM4s/9Yb
         Hyi4uGlkieUuG7lOEdjgRI5mEak2qDUQNNowI+xHvXeuc9PkhJeD6lze1Z7pf21i52Yx
         alDw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJfM8tBwXryixoi+/Lpxy0Uwwe2/Jk19NtVP6nuTkXiM8xxUP0o3BbEiKxB0DB8qbevdRy6tj7Px1CAFfGQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRJCcHbKog1vCnO4c+HBsR6thb9BDJO+KNCCpApabiTRcgj+l
	6aLs/bySVl69ZUFNuLrWXhXlnZ60yU2CV80p3Cw73WTeL6L5IB2zwVQ5Lb/R06g=
X-Gm-Gg: ASbGncsI26O+CZgpKwggxW9J/lRZoX+T2t1H0KS1jAI5Vtq4c/+6td6YAOU9KxlBi2N
	RURGY939dG49QrvQjg1SBniA2rv/2whwdKZ07jbFWEULO2PkYXvpBIAlSHahFdkG6y3CRuE/qMy
	8oiDUQRuvb9mzeNpstkSwC7GXHWh+Wj09E9JfoZvQ3JjFWULCzBY3tQmyq+TGpn7vZ0DQlWyeTY
	3GSzU2AboVsBCgnSTrzrtZnsERBwItPTWP/UCAdIkQv97czb6j3no5JtWbZyHCj/tESKcb86CRb
	1zLFdoRSN2SfpFzwxyVrhH4Uc6OMWClbPmrjASButnh8GbQ9Akhm
X-Google-Smtp-Source: AGHT+IGsKi/g9tTfdIYMQ2+5gzzLe9qr24FBaeHZnyBSiI/rosx7j3FR+Nv/8kNQGcY/mrSHMCTnUA==
X-Received: by 2002:a05:6000:1fa9:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-39132b64eadmr20065294f8f.0.1741812881656;
        Wed, 12 Mar 2025 13:54:41 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:22 +0100
Subject: [PATCH net-next v23 13/23] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-13-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR76m0hAo2RoNjt5PB3pzOhRoyHdF6/Y8kPh
 TpoA0UpByGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h1HvB/9pZtpRxUneGLzMmP6CbUDiHfiCGySTihKhulzHNbz1/7rWNyhYqVWlHHWWRWHD1Rdq/sB
 JVB9VOS14NBt+z/910raa385EnN3UpXJ4+XOesdE1idpspQUxMCSgTc6g9DdoH9g2NHfLqy2lpU
 589mqCgqZeCDqTANgW4gaAxn8g6Qdt/4UR/qi+PgnceMyzuGy+W3R9pw9U6g09wallv8feFNTkx
 rfzXvKDvnJt96V+ssva+VUcH4AZ9Zl133lCzJ4HXjEPr+LSZXsypRBK1XGz8JWXTr9f2/daQEnq
 DrDawtf3mkn6WTN3evq5WIsGG65wczmIi3cS40fBrTUhkHB3
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


