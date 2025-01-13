Return-Path: <linux-kselftest+bounces-24344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A20A0B308
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D1C7A399E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A73DABEF;
	Mon, 13 Jan 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bNMlSrtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AA284A6F
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760686; cv=none; b=TeqC4OXDTabLWYiwHZ0GplVksKdkuIC9KkE1MtIfnDrOi3qNofa6mcr3+mBTPkGTnK5/P/T6/2T/orlLgw3aLUPiEOFO+XpgJ64PBtkEHFVJIscfvPxd5O25CeAhw2lRgJR1TLEacZ51a/QNep0fBAvCouLSDNUT5iwt8SC3V20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760686; c=relaxed/simple;
	bh=5nB6P1uqMYCKCgFkweOVzibQBqTXu4/Iu+/EqgwmLPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLQ1aWckq1zVFthOGFFQ57B5CUj4M3k1X/spThjN+s0bGVhQ8tYgkjcAoptuo/9jnJdPrkVbT30SQapepJ4m43ju0Ta+jS3+0EcaKgOgB41/ADh0HyOM5+aHkQdzPByTP1g5IkYs0UqO2pFrsCp6kOsqywNsnFccEUnmBc1Ttdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bNMlSrtC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3175872f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760682; x=1737365482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=bNMlSrtCtinVuHx/VkGuewB4Fejr8lcxGohC055Ac+uAHkvHAnC24usz8QuU3wm+tN
         XuTWpxP5cq/vIMIWEcyxjc9Q0Bh6Jb0NGAmkthj9R0ClTj0JCCojZVmbYfKoVDCjPPaO
         RLTVDQpb195f91zOfhh6fgykZs+9d6znVnNEQonot4LpBqiuotOLW8uq1XE5YLd6iQmf
         ux0m8bd9xCmjyV11bGPTABdejo2HaEcZ1r6S/f0wtlB0cGRsN7hRZMcoPNvSAd4vSU8B
         aRrNXLnRV9tsM/+namY2sBtYKteYn+4StbOaHdQjyZOGp17dT53Ci7bya4FcpBk4MtWx
         NSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760682; x=1737365482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPCdnsDybTbSek31CaEhyHUdFmbRNtk8egB04xoYnP8=;
        b=FLIqbbTd5I8boCUkf9NUjrA5Ynj5ak7iM0fsDgB7JfpavzqPxxHyeraSB+D1apyu9O
         2+b+yvf7XZRMmUnCsFlVK0ZtIMzSJ03L31ZlMjnwXOid8VjuXH0qSQZ8L3diS/MoizU1
         OD0JJGl4bCW9nGdbabMHbRJzY9NEr2pQBWt/d2TLyIXZ6cQFMzj3+8u+eX377hq+8QYs
         LYQX9gbRkimwELT2yvhvGTmuVimWX9ep7p753IAhCQpfUlxO2DwA/xin7kYd1yy91aVH
         AHaGrA3fgr2xUuVIOX6eY0MV/QoBd7liagACgwpo4s/8rgANgEh1EcTSjQPs6e9UWJyN
         o41Q==
X-Forwarded-Encrypted: i=1; AJvYcCWy14Sa/mpbEC4lw5sZ8xQeoE/Zd27Jgo8ftZtyJnsj3i1XYZUqomg3FgPLDGAao5Ju0oh9dTwUxqwozlmO+2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYPKvqX9g/O14AfMWU7XaVMT7nV5ImQlMU5xVWJWNaSMTqtU1
	gOrCxARt9UppT/jWDJYzZen5oKJzFeF/8WfR+Wkf0v9FI5HoqwHXNGJO/1uQTLw=
X-Gm-Gg: ASbGncsZBgjqYlUHBLSe7WMwYHvyqBB7wbVM5NzGHVa5QXbj6JIUkhFf509NwSg/Juv
	p+ZtMvf9RBfALchHmYl2BuhO9jaK+ykUZE0IBKBSmtzklwiaDfGccxOBdIVqHRPGj1nImzEfHxX
	Abyk7qUIq/H4dLnpFAdxBRa4i9ushN7QCOX8+h3CzMSm8iyAR6myTTFTOyHTRnaEUxwxYkMMIr5
	jAVsgUVWLygMbA3fOfg6ejAGziFnKEULldVqGOdC6tHFN08JA4iEgoyyAV+TNV3x1ES
X-Google-Smtp-Source: AGHT+IFIs7dhmzOrcVNorA82vYYmPXs8ShfyPm8K48NyT9urWqDSFZAWdFqVGGkPXvzzWIaeUZHP+Q==
X-Received: by 2002:a05:6000:1aca:b0:386:3bde:9849 with SMTP id ffacd0b85a97d-38a8b0caa82mr13477567f8f.12.1736760682044;
        Mon, 13 Jan 2025 01:31:22 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:21 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:33 +0100
Subject: [PATCH net-next v18 14/25] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-14-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5nB6P1uqMYCKCgFkweOVzibQBqTXu4/Iu+/EqgwmLPc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2HktwmWnZ35SPI5LzMnLooHJ3jRMj2Uk/Tv
 fe9X/26wCeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhwAKCRALcOU6oDjV
 h03gB/9555eoMt4Obn7X4D5zArMCrJXlFoC9L4yCFiOlnL6hiDvMy4g1jJGAsF6JK03VfiGH7rg
 w77kkSjUM2cdhOIziIkf2Elhwu719OerNemkYN6ZGphds6Nf9pCteUno0gdc6JllJImAjz7V7aQ
 334xDIO7ZhcPI3wnv5AfeGFHWz5tTr3xUopGfpLG3LHkmB4oWtvV4gfMGRKwpmD4sia52XN/O6X
 GxkGIA9ScjIze52t3s5bCjZEPeX4DfrNPwGChg8fjPJ3r7c5CiCFXae/3hXJ5as8pL78kHRJxaP
 G+1pyLQEhDqz5P0lMffh+V/rF9lX3x6tHY0tR29b7twf560r
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
index fd19cc3081227e01c4c1ef25155de614b2dc2795..67c6e1e4a79041198f554d7c534bc2373ca96033 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -24,6 +24,7 @@ struct ovpn_cb {
 	struct aead_request *req;
 	struct scatterlist *sg;
 	unsigned int payload_offset;
+	bool nosignal;
 };
 
 static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index f42b449b24d04ac247576d9de2c0513683e0072c..9776d87acc4742661423cd1824ac12b385889a97 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -217,6 +217,7 @@ void ovpn_tcp_socket_detach(struct ovpn_socket *ovpn_sock)
 static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
 {
 	struct sk_buff *skb = peer->tcp.out_msg.skb;
+	int ret, flags;
 
 	if (!skb)
 		return;
@@ -227,9 +228,11 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
 	peer->tcp.tx_in_progress = true;
 
 	do {
-		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
-					       peer->tcp.out_msg.offset,
-					       peer->tcp.out_msg.len);
+		flags = ovpn_skb_cb(skb)->nosignal ? MSG_NOSIGNAL : 0;
+		ret = skb_send_sock_locked_with_flags(peer->sock->sock->sk, skb,
+						      peer->tcp.out_msg.offset,
+						      peer->tcp.out_msg.len,
+						      flags);
 		if (unlikely(ret < 0)) {
 			if (ret == -EAGAIN)
 				goto out;
@@ -369,7 +372,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(peer->sock->sock->sk);
 
-	if (msg->msg_flags & ~MSG_DONTWAIT) {
+	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret = -EOPNOTSUPP;
 		goto peer_free;
 	}
@@ -402,6 +405,7 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(sock->peer, skb);
 	ret = size;
 peer_free:

-- 
2.45.2


