Return-Path: <linux-kselftest+bounces-27687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B3A4711E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C0D1891147
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 01:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45C1DC9B8;
	Thu, 27 Feb 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g2u3zrYG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782171B2EF2
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619383; cv=none; b=e+6zjldSTgB3eWMo96q0tNkfYUQcKaF5GHTBUP02KhC7uvtGi5KuLXbjcswaHTsHxWLhZFUPYv6s7W1Kv7BPlV5xL8M6l1n3rapAdv6LbcHPyKvln0bAm9/IGprui7gQ1YhhF/+dOr+/qtkLsY5EtmrClyXnPOT3ocdDXE6IctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619383; c=relaxed/simple;
	bh=5x1rNQS+i8qIEVlJHUaivmjM2z9KpCfLQSLZi4beUTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibrH+zryRt3sfpg9aI8JwRcCpftCVMiNS/4w3SI6rLCrzcQULiazF+uZ4puD3V3u9yRK8r0saTIUdBNfRW8IalsFLaisyHQpvlHWyh+AD2Cn6mFiiHdejEcXi3suvFLCpVY8MkFTl60gHh91sfgo8+KGld9f/JfvENfdvH+ac3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g2u3zrYG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43b5859d1f1so1603585e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 17:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619379; x=1741224179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiXlnK66PRknjL98HQmWkWbNalA15mzd2X4uepTec18=;
        b=g2u3zrYGoKblvOKv8ARZMwR7S/iryDd8rcgsJQaNPgB0Su2tR+4a9GKzb4XslKCtZ3
         e1KBncibU5AkqdqGUHv++m75/FUA7To9uTlPI740OTKUbB5SHpEqz6jjjZSZb8rjQwRS
         pHKazmHzFIkgoO3tYNU4gt05dqIwhw+l6W+4kmEwc23+i91Scv9WjQdHTUslL9VJFBtf
         8TLWpBcnZ1gqVCQmSP6hINk3LjfUnntXKXQUGBpsmYyY7Aqy68z4CU5n7gS6scq6FQoe
         su4a08DYee3tTOxz0euy9vfkI0y2LCRqxVPKa0DTZNpDRHTGP+lCJZTOLefxiGmK4Q4i
         50qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619379; x=1741224179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiXlnK66PRknjL98HQmWkWbNalA15mzd2X4uepTec18=;
        b=voHRUd6hLA62Q4Tb8MjmUoC9h9gVEPPIK2PnA+izc9iEIi9N6w4hYE9rEUnv2D641n
         vqaXGVhCzJ15hBuYajKsnBaIQcE9xUz1cvFl20ZsB/RQcQBon7EOqp0KOuaru0IwNW0a
         NMWc6V3YpWZLfLNzpU6ieZuGsv1QsoPRvh07//rW3Ot17TFTYy8eCfi1ZrQ9cVXYeOZP
         pBW75s+1bAxfAlhBtPIcwErv+HO6nPmTFrCNRdDIjYDiHeYSd8wsVD6IfZkkp4l0/HwR
         7N+QDZ5HG3ebzad8xjdEQOd7W/rl0exmAqT8luPg33y8rPsKUMXb3sasibKT4L82CNoW
         gsmA==
X-Forwarded-Encrypted: i=1; AJvYcCWg8/y3s94XeHVU3kncaj5KIkT2L63ZDwHiTEWOSaZ1BQNp34h1GVIzc4oUP1DmpuhFCLnFWRWLMt01fBmk85U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXNUzfqDgBDDEJry8H1j1HyISxv3FS2liN8a9J2BYISmOdhGO
	8X4FSAQgfxriogz3NzymFytVmqJN6b5Dk1TRvt0XWT5iTie2WaJkW5xAALc4p3E=
X-Gm-Gg: ASbGncu+uE3R3S2YINKUGKZtfIASgRV10RXUgaecz7nhYQkeYacMWayrN7skMkJzzFh
	SJQBeteqGRX+oMaQ+N1d29E/OUfvBTI58ebMWwKKkyRFfRaYXc34/OLwUKn/rxa3ZMzNUadLoPN
	cHXWCxz5vALpLFFbwhUf0FQuV4RvfcyjM+RsE4DG2nOmHJqtVC0vFWo9D30VA63K1nvhbPfpDi4
	5QdDip8Y9Z+nncaYcsSqoGkgjCytBksBb5aPyzNEzboFJ0MotaaRi3PTutGM830efKfJ8qgpGXm
	F7iZUKSBTxv0upzDrZGtBA5ZVltvThrEwP9RdA==
X-Google-Smtp-Source: AGHT+IFnuETeSxaqmVAuRzw7rkj3iGlVcd8KtZ0uZ4bLEvAXUeQnW7pF7gGAB5mWN1qBvqoRJT5RFA==
X-Received: by 2002:a05:600c:4753:b0:439:a1ef:c238 with SMTP id 5b1f17b1804b1-43ab0f3cc86mr81731005e9.13.1740619378876;
        Wed, 26 Feb 2025 17:22:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:38 +0100
Subject: [PATCH net-next v20 13/25] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-13-93f363310834@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5x1rNQS+i8qIEVlJHUaivmjM2z9KpCfLQSLZi4beUTE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75gqHbLwfhtOHnR4AEsyIlv+nTM4wRXcgNHK
 dMdEGaG8lWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YAAKCRALcOU6oDjV
 hz8eCACsgQotbzXflg0MQwp0h/8JSZ7sZGovfl1Q5Apx79pfa152RqE6S9VrGBnwIpCGnpyikgK
 gkmRr/89novf9DXlUQd51JlcPVqNKrMdDXu8sphpkFhfA0Ez/aOz6cb08/w+gAbGELs/zrjz3Sl
 SPJXxBwyNcoHXyBkbPljsiEJY623quAPu8waHNjYOUoGU9vpvwhqNK5BHAyuF07YNbnUFal77Yk
 Fqeo/nYJumpKGXtL9lgrnvqFt3mGOUiftKGzqJE+cYhnOyQREVFVgF/FM1qnK4XnmhisVrBvm47
 jGarp/AMcb0gmM42PaSOXnuGSulmLzj4miWEGTGt00wFCeAr
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
index f2bb8473d99a57e341366c6cbbd6a1e2d03881ca..0e69e52b5c8f082f0d9024e63e72e67b2dadd742 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4162,6 +4162,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		    unsigned int flags);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
+int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
+				    int offset, int len, int flags);
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
 void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
 unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b241c9e6f38101699f4e0ec35283dccdf7f4fb0..c1809fdb63f6ddf469fae1594fa4aa4a966e8b0d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3177,7 +3177,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3195,7 +3195,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3232,7 +3232,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3278,14 +3279,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
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
2.45.3


