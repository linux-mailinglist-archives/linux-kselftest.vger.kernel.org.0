Return-Path: <linux-kselftest+bounces-26293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA9A2FF68
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB9167C86
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC01E7C27;
	Tue, 11 Feb 2025 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EsdC+dYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2E1C3C1C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234481; cv=none; b=kve6jIliEg612w8vLVb257qcWZ5yN383PUlWoF7EeTUqEk1jk+sQ9d34EZRKsLp7F/BlIedLasXwN17mEm3GmCn2PBVDFJ1RVdysvrkEEIhtjHi0awUD7T2ZNbK1lnzOXl5IOyH/9Nv1hhxVFd4HOkguTMjVIiIsDcen2uKnYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234481; c=relaxed/simple;
	bh=HM//bHTohG8SvGOgFgZGSFroiEuOnVDx8FaefbIl69A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxK5A/1OOWdqeJKE9NvWyQ5NczEo52VRS1PinUbYHw0577a9C18Y6PRYHvQq/+mHP+dI8mmbEH8gUcYXWE6eVEk7I/CK1OMkhgNmh9rKKSDr3s7fW3sS80hS8gmmr8WVlEDCGDMYrHmP8sE6BzBcdH4pYu6z36RFYKBLi600zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EsdC+dYu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439307d83f0so16008085e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234477; x=1739839277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptgiyCj4pUS1E/CVtWO5d7FE/mkFEtjVVkKloLWtXBs=;
        b=EsdC+dYu8YPs8FmKSuiRmtRMmYJjkPKm088V/FRXv9qicXPq14cAYcP64QMHJ0R8Vj
         nM2IXESJN7nT7NGO5it2kNdlT1kTXnGN1g6+aKa6Mgf+TNmI+R7Ckv+mQYe6wPm4pEYf
         fZZ2uLTeHpBmfLisQOqEkWf5jUZx5t5UUrhNWu2f4vekUH+iSqVwIDDF47VOqqU3Ig/B
         RDVlFw+mbdTEU0B5s3f8oKeSQqNfkFwwjhh2aoJzUPUfsovQe17jXuN7uIPww09mpTCq
         J0Ri7E9vd5Y3KcIy7KVzCDiY87FllNsfI20pRjAxvYLd3C4AOHPa8qM8T1dZHT62UQs1
         AMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234477; x=1739839277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptgiyCj4pUS1E/CVtWO5d7FE/mkFEtjVVkKloLWtXBs=;
        b=ClQyCdIlE85Ugg8fPpsrr+JAVKLoFtRGinNXupK9frgKUvIZTA3875bPIPFa5wMvjL
         2+7pwB6KEVCKAowYuWwQxJ68yRFV8JAbtUf+DzGSlEFlcyiulGpO4WwgGNXO7ZMMYy78
         aptjwonWdVpBWjQnSrjzSYQsB/BhZgBp235oGrqEB9Qq67FW14Jb8QBgFybFwuwxKN5H
         BWetdOoleqQP1RqlZh4DjbInnY+3uf7zyXMCTKDIXyjUktzbbgs3bbWFAuM1SNCcD6aH
         v5L7fQ/H3TDcFBX2xvsbnL/P+zfznmpJIt+5ost1IYip3Db+eKCvjHpdyN6afoxHrZLS
         zSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGayp31LnTynEzx2MSn2hdw26cXjMNn+FsuhQ1+J1KS7zvXU7SdzayXveFKpdxd5XvAhA2AdhRT3mNafTiE5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10jsIfVVjMJcoGHwwdg+nuHfRwiVOte4JC0qgeMGbRdReVXXS
	J58+FJohq4hB7MxKLpNDG1/0AVyxtuORsUbh4vKDh7QVgA1PU9xFqZma75Xba/0=
X-Gm-Gg: ASbGnctuBbyPLZX+hJheB55WDXY8NMnVvDnRmB9lFNo36oinylLr3eBEidC3APFP9/K
	9wMqU5pWEZROOVoaQ45Kk6jvs1aOyoSdMXqw+V2fClXH26224gmWQ/HSedv3yNCkFrmNz6XECfS
	tklff3kDCz4dn0xViuM4WyTm5/3+r5Z6DO42XJxsl0P3bYM6b8MVVeBd9UvbSzR3TIphPUT1f9W
	VZJNGSaTb/nfefRI/PG0YeNk5Gdi3rUQCWEorE0d5m0fX++Rh7iS7MyoowZDHCKw36hoXNNGwyx
	AxLw41fr9ZefXk0wF2Yp56hqsrA=
X-Google-Smtp-Source: AGHT+IFRCSU+ybIfkI/DJ4SVGZSjIRgj8dfuW9WaCHij7uURHFTOjTNFFX0M6AGiMWdTD3/w/BrHhA==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr122163395e9.8.1739234477434;
        Mon, 10 Feb 2025 16:41:17 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:41:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:40:06 +0100
Subject: [PATCH net-next v19 13/26] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-13-86d5daf2a47a@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HM//bHTohG8SvGOgFgZGSFroiEuOnVDx8FaefbIl69A=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyNfPmbwysZS6fzCYc1ZtrfcCXd1vj7nUbNQ
 dbtvjPYQeiJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjQAKCRALcOU6oDjV
 h859B/9s8DriVDTwh4l7CRvY9KfqzFoBdRro6mK412+Xi7fpyEmPrYthaMjcVZcNAN3Bl8vXqT0
 t59wZQnqrszLf+ezCMZn+vptUQwkPvFJIPtHbQsZgDr1Rl0qlpyHzRuG4eMu/TGqyMFUiUdyXzH
 +EVmpY8UFA2MES9OWJt4N+GZMMX3s1bcCZEP4VXY4MYTSQLGghuVpg0yyweRUFbW+2XvVPdMoug
 yerjap5yrjrZsYVlzAy6fuNec+Pbrz/eUiUVSjV+h2XyPqb11GliJwFzrEjHe3m51jmcSXfcFEy
 iLSOzJnDLm4PWbMkLoF0E1XYVxLrl5rjdEmAqfrycRGuHCq3
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
2.45.3


