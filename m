Return-Path: <linux-kselftest+bounces-28124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7EA4D019
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B97F18988A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319F1F416B;
	Tue,  4 Mar 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QYiBv0OP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D177102
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048489; cv=none; b=B+G7uO1sGAKNiih5dZEtC91WvP5LpfHUPpnXRBZDkj2f2PK4VryfEStkZWSyoOKva87nqMG8QGWmnDzJEn9xUYthdxe+33Kjad/fI4EDHbnlqd1hroxaUfVgA76e7C1JE8qB4Qdez3Fe7YkH3ueXP5IxEaEZ+G2aV2R3pdWcX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048489; c=relaxed/simple;
	bh=PbesptcARg4Ut8HDInQJPzampu5E1akZeWd43i/N/Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eepBzTaXNAVS+WB9A//VaUBKv8mCwL7sUDImISBx0c864INMarP5DnA31n3LhfuEULAzDlxarNif82w5I83IR9wWC7CBTNxk8/nUjWqUDHenZUX+7skmA3bAEmUyn+R/0REF56LeGna1FphS1YMs4EhRPKZU0KWcvMHJ7XKlf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QYiBv0OP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e3b3d432so3444646f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048485; x=1741653285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQwqdxOgwt/7vrDDaSdpoZa809dnvtmEHZJ/1Qd3Cks=;
        b=QYiBv0OPkfYVUPMtYiEWTJ8b2jgG4XtphMg1EESs0chsunYkJpU+khg4JaWhS7lnvJ
         LAhOR6PNcIUO98OvSrw3rM4XiZnDFn0PFbqQk11sQY1HIU4lQjwhOMXaqn8PEtY4AcyG
         1ojBAKYFwcFhNAfVT+zmIHpxwGKtIFwRM9oFF2EzTryFoy6xK8a2PRe3Ae/DVHiuYtxD
         ULPuroDJIBFsmtkPe7Cc6U1Ihm1R5kg2bQO2VvbwMlbgbfE2vLoFB90j06/qzI+DAKGD
         cYnE6FxDxRNYxTE4ApkI+fU79J7+WjR2vgR51OzQTTEZLEHsVrY9gQl9D+KO07WAXUe4
         i78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048485; x=1741653285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQwqdxOgwt/7vrDDaSdpoZa809dnvtmEHZJ/1Qd3Cks=;
        b=BQnFJpD07/4JrLwuaW7NFxoFcduXu7awZ6eUysDdBUyZGKcEHFM8TKQAhTZ5AvSNIW
         HdB0aHH/fgigwNiWqy1GxRJY3vc7iH9t/GSYWzUeVi03+VAT1ck1Pm/fGdl+TlpPbsRy
         hAalC8rLxBRfU1qUB3jAJz/E5p8vcz5CcBRHMB8hWXWtJ588OTIqSXnAg1bkxTaMQM8C
         Wb2sGOIO/zOztNGPsrLOZh9dWRFtFyjvKbbI8J5Po/Wqe6lP6iGOjiE3OU4un5HNLjqI
         YdUc5VfHMF0T9DHLyGelh06dxkAGsgDIteLPgTDSztEEVBASXNjDU1WJqDWjH0oSlUF5
         +RSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkqXcJ95b/z0Hd3HrNJEfNCmHsTSInImkR76BPwd8DAWDII2hmqj91g9D8iMovRRYw7e7OtJ5tmrxreC0ipg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1PyGNrH1n2AQ5tmaBbgqgGccAZQYbeoja3LcmeiCxkV5Ik/I
	eM5p9ApdkuTf/vHbn+QWWiW5ncrxviu2KzDvPeHrRLcatHTT1H6JimxUaWJRbHw=
X-Gm-Gg: ASbGncsoaVsHt+At4ZaI44vfaJtjc96QG9nbCtbU4w6Myp3DGGFSN+1pkyOjHzsg/Q/
	AzFRwmWYBpJz5DkeYQAh2JB5g9GzV/7TbGAg0RVpPYOBeuPf8l25cts9foon5Qam/zRUdf37tNI
	P7m6ix9zU1gyYNV9vIdDF2G0dpOJ7fDX6HsC6ySsxuooJcRbwOy7IzJMmt9ddaLmBf6oQ9sHY0V
	ZwE3MZ2eRZgGMJjsE+NReBnndaXprQk6YQ9rqemm/W32kv0jJxYLCMUaaRXgeB7zlCOkF1Cf9Bo
	+Xzqa/RLmIdUrg0VPWR+kAbYojDdrwd2Dt5RAmRmkg==
X-Google-Smtp-Source: AGHT+IGpspvam1C8RvPX3/BPMzjM9rqVq3JyBrFhcL/I3qL/bRtoK51mArGaJhCepTOZHumA+U7xlg==
X-Received: by 2002:a05:6000:270f:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-390ec9c166cmr11093758f8f.31.1741048484905;
        Mon, 03 Mar 2025 16:34:44 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:44 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:43 +0100
Subject: [PATCH v21 13/24] ovpn: add support for MSG_NOSIGNAL in
 tcp_sendmsg
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-13-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=PbesptcARg4Ut8HDInQJPzampu5E1akZeWd43i/N/Rw=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqP/jzo2uEazn/QB72AvP9fuVB0jc8fJ/Vmy
 uhh++zc9EKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 hw0zB/9PDa5RIGWd1z5zEqhVr4s3Bqd82G1uYxc8ZtfRDxTPTF8EXEiKUAnBGq0dWn8C0iv9OTd
 dBls84bUJndZavWNdqyo23ztKlyVYSnkGaFupwNnOTrQg9hHdGLry3LwjnTIVHVSfDpKjHB60xM
 qHOJuZy3w+7oUwTyk1nOHVWIeVvKAz+ArjibifgtY9LN/v5CmypQvTv6zWFCReBJe3/1livlFtS
 3cCBIOeqpsj8ADZa7r4hk6epaydKP/Jg5NxHpB33si2ivpQXrbmY5nftNA27bOtqmmBkBQ0eWfh
 1WTfgqknhjXgESuskrVN3w1OGCJO+/DcAG4XIkk0uM58bE7o
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
2.45.3


