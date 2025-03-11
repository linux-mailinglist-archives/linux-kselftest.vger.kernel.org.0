Return-Path: <linux-kselftest+bounces-28719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2439A5C026
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA25176FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354C25A32E;
	Tue, 11 Mar 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hHXG00W4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B292356C4
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694606; cv=none; b=IRMSeAYxskwH/Q/02kMC1c/ggszb/o6owhUR0oR/DEyzyf3krWl0jkOsNTHHjRWffRfQe6weJHGDgn0tRy2Gs+4YVndJJMEhI42cwCPmnoS6nGVPdvmQNGXcGTYc9w/TQFrEFL8Jq45NejAEDFzwXQYi5mTaRZlpjsusmk+U31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694606; c=relaxed/simple;
	bh=7s5Bx5ZbjMC4zD/dWY2YaXmrMwndZtJGYPhF85ahL20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwH66KTp11Oa7jLYVASzPq+nCI2bwyAOnDjG4eHPXEPBoMHvs2bkQvmPAiQ5XD9kpmggEddt8XbN8Q+Jrqnsh6bkAsf5+1FAVWTz0KExvDD9MacF6UNQDRkSttLtOHKvfHTqcw5O31zfzdnW0ljmRu20F+4ZARcwftZXNB2H49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hHXG00W4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso31871685e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694598; x=1742299398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=hHXG00W4oYFLhLZ+DN+61B6ZQg45eviR66cjBJSyT6ln8U8nnjk5xoXjipVJBLK6VZ
         z9JVx83V6Gkrr8p2D7bkY7ZEL2niLpU9bpHsMe+7CYtC+zWa3TJD0al9OvCdA4TcmnG3
         qQAPQxsAjAJlYKs0UF1HL9ul1Osl748MdBwPIBHb5Ea58qNsZDSZoBOVXXz34ve8sKSL
         uZo3fYS2fzlKBgHZYE0wrNqTEEEtgr7z7NqcqKwSb5nwTR98c51h5nYacm/1HFvb/nkv
         9C2i++PlxGZYgqN1p8xBgqEdJg62gnzQkIHHkwOYghWZ4zR9Z19OQze5lxrsZK9KKVY7
         cjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694598; x=1742299398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj7l3JFxkV3JUIYqy4m5tX6xQCQ8lcKyoxKw7Xhd+jo=;
        b=b8DyiVT/L/Vd9S54U3OC1ReeXdjFh1kgjyFz6/MaMCc4vDOvOkhuqIyrJHwbveMVSu
         NgmrjFNvfyJGL4lhqmYlQTDOHTbZ/qAbVnpvCyGRUA34emEqL/O5hniFdCByGHYypNTA
         MvoD3T8HDoo44zmYZisQpIhEbMPATmdUXfdG69D3v5oUSKKc/eJkmXO1Rz+lsOUs2GQl
         NWy29Tm7+vcbZMo3PvMa2Qj6GVnKDJ3TDe0smYshbL5VhV1vDSk0jWKyscAwjxKr9M8F
         y5Ra4wwYWsX+WnxubjYyFde8xa5Kepl+eHOGfpB1NPZJveVJrNxXmeCkLDnWBifBHrur
         zIeg==
X-Forwarded-Encrypted: i=1; AJvYcCWOYUYRnJAv4fNxlMIvU0kQag3I7xsac+5+RcdUCqy+6+FxOnLhtjCsOizzkJ/3wx1FlftxytdKwNbcueiGlnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdzOjZJJN3CcKkQlWYRDLJW5VAOX+zIyiFXoMPH976NXx3ASP
	P37/znHHl3FZAKseVSkquswAcgwz0t/j6IYN/F3gOZXlhX/A0+w5Xkdl764IlrI=
X-Gm-Gg: ASbGncswg89zJ3ry6k/VpCFIjPENss5vayzEl7BrjYuXoFJrw0TymMfrmxQ086y5olm
	Dr5vP3NrTWNV4veSvlxcKSOe9d9jk01JCWVLURCDw5Kxzql7FWJ1PEHRKvUF3eyirZUNke/E8lc
	94LmcvwfMW1NN5h4t5kcXhuLiFQBFzwaoX8tyChxjdllwq7hQZZkWC4IcJjImCc3FOLO+D09q9B
	qVLalo/O8ioeave69hnmDYhVqXju3ksremk3SMuaj4JxE0InwrhGnJup1RFJBFm3QujQL/CBkT/
	Q42Bo68oz7Vpv1GPElSA9p8+yeR0VQWrdF51XNdxMQ==
X-Google-Smtp-Source: AGHT+IF+d6JvFBfJOHeAIXvtZqiiuLeusCJMghibRmIueZgBdSmvrHcvNSuL/1M+sgdeOMHcKwsskQ==
X-Received: by 2002:a05:600c:3b13:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-43d00b313bemr47399265e9.28.1741694598471;
        Tue, 11 Mar 2025 05:03:18 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:18 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:13 +0100
Subject: [PATCH net-next v22 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-12-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
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
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOkX1Apbk5+7SxgVsXec/t7br/C+7i9TjDFbw5ukf5xrD
 GufPMzsZDRmYWDkYJAVU2SZufpOzo8rQk/uxR/4AzOIlQlkCgMXpwBMRLeB/Z9Corxm3ye5vzFS
 HnMmTPnasnfWp9tthYuFf3huYjjxbXXC1etMHHm6M3YoMvP8iXqc+VfKqOZIGeM/9+RAybkFOle
 PNc6qbJWw3d9vL3i5mGP29C/JXd8fVbzMmJEmXF518o5nnVrAT/XOaoHyNa8v5VRkODuc8mFY1/
 bA6FLDHrdbzXOTi3Yf//1kl7ffw4l88+1vclS5BHBZxW/Yveyb2C5J3yRFxumdKydeqFh/mWeHg
 NMaCbMA++TFqjnMXUFVamnn9ORrVv4IiVzpHv4x9bF80sm3miyRhTNdQ3wkIk+ER1y71n47r73v
 VIzX6n/52xZ2i/Gb5dXe7pmq+GyVBYvQLVeWu042ddZNAA==
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


