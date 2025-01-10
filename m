Return-Path: <linux-kselftest+bounces-24257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD3A09DE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E765188F091
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFE225796;
	Fri, 10 Jan 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AxkbEhkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3A224B13
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547992; cv=none; b=Gui0oPimoLZbqaZv1plyQscrza8qa9261XSqwjM/RMQqIU12Hi7ere/In37rGQASZREr6unXpYRM+etXvZ8r4ZIkq8PWUCMqX3sGFxryS+4Va7+MYyt/QMK8g0v+hmbO8fMVjB/uIwAVTfJhmJ3Wg3zXV3A20r42JKzJPpgEjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547992; c=relaxed/simple;
	bh=fHoVTVq5BbCLTwJdoK2tOCtjrx/maX1L8ZezNHLmiiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxRoioUmbNXZa4T0t1oWuInMkWyqasgJaUPMaZAH9Tr8OWyKPG0DaKlbqNuaGT730hoa9F7NIziRpxJxs8etTF8GRDkLMF+N0N04Zd5CJ617uOecm7gFN2B7wnl/otEvs1RmicqArrtbkLT8nVS+ydpwJooFFPIOwCpRo2KyyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AxkbEhkq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f796586so26948455e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547988; x=1737152788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j2GBpc2aFHsc+qlcjcQ+gt1cS1cPMzxzPpCsISmzE0=;
        b=AxkbEhkq3z0rsdZAcqd4/5IOsePMq7jSC33pACBV3Mu8gy7csLGbIFPYqfVUAIn9hp
         1cEZOVRlS3qZAzTPpVW8D6CljtEhA5Ol7x/6F2Yj905RvQPZ3c0k2AMx1I0rDFDpPDQt
         K82+pOJtvinX/z3MkkT58XKz9QW0i/93gcDVn2nfh1nH0CHRgw81vnoo/iEg8PdDoVIB
         Y3mHFzWQTmbOBYfDDeKZeOX7GOy1cD4jlD12eUnSP0Zppmj9OgMmg6b1mW1mNZMfL3Mk
         qzisgIC5FiYH8GC4bOqunfiX6UbQMovt5gMen6OQbaUPDYKPl3rnnSnXDpi8I/jK3dOL
         069A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547988; x=1737152788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j2GBpc2aFHsc+qlcjcQ+gt1cS1cPMzxzPpCsISmzE0=;
        b=QntCdlOzjPAlA4wCoXrkkmAqPZQMWdgwuwxtro7kEhT8suNDJ9F/mwWYlRiTNbikTO
         virhx/QwhWIuQOCkckgMJBJQ2Ji8HzPqX96KjQHMxAdt5VeEF0U8SuDVoDGQFDApF8wv
         s9GS0Fe4iog7n3unI+H6NhMKOJbs2+HFSKhB4TA+5bdo/Ujd8YKqOHx6DqU4ddbyrtLR
         E5UIwASe9dPHuhbAllYMqRDdKMOKqrm6rezctbbZOB8IVudlKi4LXymJi0w8YOEmoLCZ
         v5teetZW2x9adFJi3CX81c+6HiYjYGnCb0yeHV8sQuxlndZ7i+uYjdqfhmsWUt/pybqb
         Mu+g==
X-Forwarded-Encrypted: i=1; AJvYcCWuHvFShk/Vqwv3TaFTwX65lwjPe3qj1LauDaCxAlJbXlmCUBm+VYgYEorSZJXGSFhL5MJ+ELBZA0VQu7EI070=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqqz2KX7g03r3JEkilVbU9w5zrDIz9jDjxksq27c0jVm4NNU8
	PvcDpvmJLUuiE4XT+9Ua2zWQT5tAY832X9d0iclXivR4E4nNNecw7g28uye18jY=
X-Gm-Gg: ASbGncunHwEWEp8mt9/eqyytm+cwunbwB6/gVLnzIbf7qj/9Lvr5ywu9tG3YBVAj6Jt
	gqBVNGswFpW2EwDCqABk/TvJebv/u4u6XHxqfFQ70ETYCbeUjvbCFCOwUzVpA2tg8NtnpbT5vXi
	X8SxR7ZCmW7ogetPR5mS7NTdtVagjeX0tKMOJSbqAFEByyVDTeZzGBoax+lLNXFkelnFE9OT+jf
	fAraoUSp81oIpsa4KnxT/WZ2J5hQRfhsffJzT9erCtvK/4rO/SIPADbzNFVP/d2h0Wy
X-Google-Smtp-Source: AGHT+IFG+ImJVuPkGgsTHfL3JMuM/ggztioYIFat0jbqBkWB8TgLIbIceZlrBANqOvykiT7PDZ/dGQ==
X-Received: by 2002:a05:6000:4802:b0:385:e877:c037 with SMTP id ffacd0b85a97d-38a87338d79mr11086456f8f.42.1736547988260;
        Fri, 10 Jan 2025 14:26:28 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:27 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:29 +0100
Subject: [PATCH net-next v17 13/25] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-13-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
 h=from:subject:message-id; bh=fHoVTVq5BbCLTwJdoK2tOCtjrx/maX1L8ZezNHLmiiA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xfQjTqZlohHRPSCwKdTh1KqKFJqWDKDUCF
 k+tTJIvWHyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h93HB/9xC7/qNkjAp8XurEAjnEUN87NZWbeaTUuScBLkk1e/SfrHI4UYSAjVQnFjWJgAsLqJ7PJ
 GWxM1ZqrlOgPftmK9CfGFuMT/++QH+1/z79lrcZ56nVVTT4oo9WEwwi+UFrRzad0iizzQQofthU
 xmZl1lynKxMf6N8G5f5ReU299+ujhrCbxigGh+zEIn5A4vgpSclxWcSnFsZl6OWjNfXOAdhHvJR
 jG2OBpWbhPcL6l/0KUc/Me65IeYR+wzfelVcvIZbVDHuFbXr65cRzQkpybLOyouPLywQ7yTsYdM
 3FgGlahclyQUeBO7kT8aptg/4GzOMqdK4Nhh/67pybEdBloh
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
index bb2b751d274acff931281a72e8b4b0c699b4e8af..c7afa7871e1c26e0caad4f77facf8a225425bce5 100644
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
index a441613a1e6c1765f7fc2e40f982b81f8f8fdb96..e83327bcbce37625f5c0b8b0581d6e3bf5fb55a5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3267,7 +3267,7 @@ static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 
 typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg)
+			   int len, sendmsg_func sendmsg, int flags)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3285,7 +3285,7 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		kv.iov_base = skb->data + offset;
 		kv.iov_len = slen;
 		memset(&msg, 0, sizeof(msg));
-		msg.msg_flags = MSG_DONTWAIT;
+		msg.msg_flags = MSG_DONTWAIT | flags;
 
 		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
 		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
@@ -3322,7 +3322,8 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		while (slen) {
 			struct bio_vec bvec;
 			struct msghdr msg = {
-				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT |
+					     flags,
 			};
 
 			bvec_set_page(&bvec, skb_frag_page(frag), slen,
@@ -3368,14 +3369,21 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
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
2.45.2


