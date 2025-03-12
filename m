Return-Path: <linux-kselftest+bounces-28853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F45A5E5C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3671917BA7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916E1F3BBB;
	Wed, 12 Mar 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cs/hm/GJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D51F2C58
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812884; cv=none; b=bXrXEsCBiy6fEt5HrjwBRA9UvTygMtcCFGYRfzA7jOZ4WwB8yWnv/yaK/Y2XYB1y+kVVjuzkO2spQYUWHX6KqGyVE5rM11c7l3XZDu1K37U62s47QBGftticgWPTbuSAP7oNIxtN7Nszj++upD7/pJC7e5EVB+1KEy6FkVaDRlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812884; c=relaxed/simple;
	bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iF0hhbrTBpXsYFWzqt3lzRRaQ0PizBNRcu3h3xhwoOpCgosWIWrGwrKiVUDVle9ZWHlLz34IiDpCV85pdpSRl4wl6i+Bo8ppVLjTa58V7iWL7HapvFrUhe8dfLBVOouHefaL4/VIuzMl3nqXfCbQMP5vFoI1Za+GCU4yx95+gBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cs/hm/GJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso1317365e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812880; x=1742417680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=cs/hm/GJscco6A71mHhyn4lvABcCt50yqawJ3jmLeOZWI/YpldRSoYlxXddo/rl6wf
         xJaPAP13l6bNTZajj7Bc7TVQG309qdUOIicXP0wlOGwntIxAXVcNh+Ff/rlP6ru3qx7O
         obVdlGwXVdvIOcKwZsDWbrgL13MM3h3lfzrAGY9SOFEagNBL/FxvVd2RmH/Dhg5xY3cg
         GzFpUF+OziG4EzdfKgVbMbHfxUR6A8Btq2vmQxo5PWsdq9vNsh/5xsnSou9Vq0tmHbCg
         CmPtkC7JN8sSz7lWQ5fKMaAi5JgGSQm+7jjOdq9lWaa2ykkRSrKWXh2764SUod1aaKaD
         yD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812880; x=1742417680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=hfq2+PZlWRF7qb0RzhI1d7hw0eWBCB047fzHr2X2VqlDBnNKt4jRe9GGuTn19BQQ+8
         RUUAVq7rtGcuaYfhLUybukiIxS+VMM+154CsSa+wv54Kpc2dxp50mmwtHpGNr+PoWIPD
         ggzkF3CNq39h05c/smFMuj+TyzYxa4PhOdY4GYku9EEYnX7ELKlMCa/EGYoE0CQr0tQG
         da0fete0S47bFvd8mDYLogWv1QH3W5Knfw4XCYHK4aY56HbOEPD9aX81tRiVtS+CIXdm
         S9HTLuKibXZKjD73+F4u3Kgk5iya7KGPkWlCljxE5ThgWnS6SSdb544w51rqOjJJv+zN
         FTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWQre9yQ11162XawDvkO9TejBCNTMVp5mvS4BZhTd6oox1IiA+JAXdRp4u/a6m0sRIy2jtPGqFWzs6aP7taZv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxAuUbum6hfHcLk6j29BQx6UF9JnJjdXL38U1U61VkPIXYxIeH
	oaLEBjEe1mnQEuDACzB7n+Aj7RZsl6YhU5ppgKPTLfKNhXqg4PTazIPMXQrseNA=
X-Gm-Gg: ASbGncswEOjIn99hBBst+xeADdpP4alhxN7NFOkcj6UX049+g4Tq1+00gk7OLv2YeCC
	gXq8JKBl9Bc0PC2pwVl23KCLLlrYAcwPWkeaRb6BCZMhW5tjAtNLxofd6q7o0GwHmzH9V6LDgTa
	mC0/dSepzV7++rbGR8jpKFiuOPGXC+4Y418bfzARVgcPEZqm8rmVO5xRQ18HjRvlF6FwxSR5F7e
	YAVDeSiA126Qv30GgEMjuQmHKwN0y3zsLUMvhf5JbBGQR51qJUJMP1trLeHrmteii2rFv20YWJm
	cgU60F9dlE2UREbnWcEE4UT/c6LcQ3Omth4RffW3SQ==
X-Google-Smtp-Source: AGHT+IFbvXUxVdFwMmuANfoBIjPUkyRJZKkWGTPUuaA/9OmO93Zw2FNviGBa+IJBKDMwN3cuIbYP5A==
X-Received: by 2002:a5d:6c6d:0:b0:390:f641:d8bb with SMTP id ffacd0b85a97d-39132d98b62mr15787982f8f.36.1741812880326;
        Wed, 12 Mar 2025 13:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:39 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:21 +0100
Subject: [PATCH net-next v23 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-12-76066bc0a30c@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7uLS3f3LLEPQd4z55D+Y2jGcPU4OcJIPTh
 0l0VZOZSEqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h2ZmB/9/zf79vMKc/ZN0jXXPU/w4+VLuyGQhPBuWCXGgxx0jNW6pzJmnv3YTz5diozxD0AuUM86
 BGObINml7qXqJ8DHfslyjvkTuU0vXyywEEH7BXbltDxtACDgDY2gas23tbdutHCaLZObc+Dqi2w
 HN8gJkM0E0m6dHUt5RuCYeJ55fMQQNgYNNqvya599ZXfRPdPvY+Uag0P2B2OnvNgLIXfEEwEUO9
 SlWyvSRzqR2zJm8NYCo4FG9ytULNaii4rOwPV0L4vBCDpm0nS77nktUOAZor8gVK74Y0WlQ+PR3
 cYM0X1BHfpqHWVtmVn1ANZQhdUGwqsi1vPOSr4PTivA1rzbF
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
index 14517e95a46c4e6f9a04ef7c7193b82b5e145b28..afd694b856b0dee3a657f23cb92cdd33885efbb1 100644
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
index ab8acb737b93299f503e5c298b87e18edd59d555..bd627cfea8052faf3e9e745291b54ed22d2e7ed3 100644
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
2.48.1


