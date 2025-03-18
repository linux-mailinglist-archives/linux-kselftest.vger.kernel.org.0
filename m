Return-Path: <linux-kselftest+bounces-29317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED681A66579
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E683BBADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53B1D8DFE;
	Tue, 18 Mar 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dMV2C9p9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C08335C0
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262083; cv=none; b=WZe4ZZS93JHXxj6Y40HG7mq6aHZA+1RrNH6XfUqyaMokwxbiytf3BHnuEnIV3nKQOd+dt8m/B1qFfPY+wSdBNmh1thkMu3xshkwiGMJPfNnx6hFxp8/QyR+GUAZmQYs5MwlBQTAxim8nJ6oW8YhSAg9VvjsZe5g8OGPNCGOXfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262083; c=relaxed/simple;
	bh=Wenq0rHtC5pSWdACJagZ2DqPS6WAKVaMHQ5I1kqOY9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWatHvzAUpacVhM5HchTEJwfWh98iKybFCVDnPlW6VhkygmaKE3QNcVNGm1ZnizlNesRWerXqe8/0y56bOkaT0gGXw2QSnGlztUmIRgoTlKAcueuRZVPvdu23lJRcfcbmMJ3LegMagr5deM09mpkLnPBLoYWd0wJp6Zew8ULEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dMV2C9p9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so18315585e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742262077; x=1742866877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYdGUtAMMG+2uLexgjyOSBPaG1FMOy17yBuqYRVcshU=;
        b=dMV2C9p9vKPRoYpLfyaFwfNA+O8d5luEBE2l72j27XYbNhUDf3T/54DbbX07G3vyaN
         mSoxBNE59baui9r7DgAxSU3deyT58Ywns9FtRHJ6nS2XrJMb5PFucrUu5CP+xcqsGML8
         MrqYhPxVclpItzC/nh713N45EeC9idWp64zCvWMN66eUDop5Hwmown/vbDNUGYALcBXq
         hWjtq32ScaeGC8BQO7sbcJ2KgyY/PoYz3wr8QRaAcUtgOdQh20suB6l0TTLV/w3GVKg8
         sCVi1seoXocD6vtGdW/qun8H8NT2E6usquXORbZaTmDGLRC0ke6zolS/qoxnN8DL5/C9
         DWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262077; x=1742866877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYdGUtAMMG+2uLexgjyOSBPaG1FMOy17yBuqYRVcshU=;
        b=f9ScRJCp7UH8h6J3+FrT6b0eLtcy2iTT2N8mvXoqTSB16FKDw/Q825vuBYmExEc5D3
         Y4d+YaZoFQyMZVwAnSqa/MCnoqE9kW1mGeBAbc0206UIoLYDQmTzwOdwL4lrMAdU7vvR
         49XkBNCFMSnsTgoTLIm4ejsaVBmBMrps0B8FjhGg/Mb5C3lM8aw1GvnJOagq5UrVYJOt
         OLoiqLAE6S2s3z8Ka+zjMka8KIgAnQkPwB/A0+9D5QW4Q70rh1j4uPiOwRjaIcbCQ2v8
         vFkrNA1LWF1yALtXTpH1UFZvg67Cs0jIOxFISgCuOU8W4Klo+qu7eS8OFQdo4pf2lab3
         lzuA==
X-Forwarded-Encrypted: i=1; AJvYcCWBxdrVoqTJTzqEYtQ9MoGetGJSr4K9juJoxSxyu7xiapxbb0xB4VpAiShv4heCEqnI6uW+PkQFrRnUxDFCLqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYz64Ybqb60UhDQHysZZ3clitVctWPnfX/zj1+xaUR6MaieC4
	olZBwWK/bJiYv5S1bRswODs98xWGLUfEpAUPHIXPrsxETgXQaT4tK2IPTcBSiFiI3ng+9oAfyon
	7n2ay/QfJSe/99hORgKQR/Z2ZzLhketA5pZq+mJ7xdA8lHQ3oQURMx8c/5vc=
X-Gm-Gg: ASbGncslnRy5ZaUdSDCMeckm+hfHzzfnZl5+JdVEFLVpzyMcoxbVfct/mwxrc2WxDUm
	AD00pXd5OSIUxkKyQN9EGX3Gb5a0GNlpb388l0OjKMSS3O1N6y0nNlhIwl82YAtfO95CjOlaGdC
	XqENbGaGje9wyLwN+KSoI1eWJmySKvTAQZPviAnxdsRiMqSIENQHh+ANeiw1ZDT9VSLlNJsIN/0
	kHNgRFzsz+KgF2KDpBdkorNr25tQFguuZ6uV1D7HxtJtpy+ocECa2gDa0OZe6ZrwiSOJhiQNWXp
	r7stxt/3vWW97d9fKKRWhKnieaMcPdV+AAk3vUw09Q==
X-Google-Smtp-Source: AGHT+IGAY/wtaM63SgOZnbZ6dBJQP6+er13isqkX4W2DBGMqM8NJaeyJNvxFhU5DHE8+J6ldk+Z9Iw==
X-Received: by 2002:a05:600c:5106:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43d3ba2a07fmr2805365e9.31.1742262077266;
        Mon, 17 Mar 2025 18:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:3577:c57d:1329:9a15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b2bsm16230838f8f.26.2025.03.17.18.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:41:16 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 18 Mar 2025 02:40:47 +0100
Subject: [PATCH net-next v24 12/23] skb: implement
 skb_send_sock_locked_with_flags()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-b4-ovpn-v24-12-3ec4ab5c4a77@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Wenq0rHtC5pSWdACJagZ2DqPS6WAKVaMHQ5I1kqOY9Y=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn2M8qOUv8JycRmZe+nJ1NUUP9Ap42CiI+as8LQ
 jpmtVoxOeSJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9jPKgAKCRALcOU6oDjV
 h5sAB/9DNAJMhspn/mzKBscpekmynuH3N49dGhL+VcvfT/rffrOQVinvhy54+6iUjbDiXt55o/c
 nbEA8e0+27es0XkwXHENO/Z2PKnny2uOVfq9Mq+/3AI0XVtsBUhiip6fO51Lbn5PxwTl0RnWUNW
 wKKtQm4R31vd0DFzERtiNvmcM9NUmtKvdIdWtXqWwFVX2DCEH5FMdtwtA50VREGCnU7KMhWp9Rx
 a4d9DVsImQLRtqmsoXC5fFxiObiX9efYYZjHamGJlqyYEC3uiulUBadkrmlqG4kPrWvZ8ogEVDo
 d20Yh/7IbQDRh+ssDbQ+/J/e4IB7aCsYCAIkkofzjlYzax9b
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
index b8a1343d6785cff6b270a0be7777061fc9dfafbb..cb633cb9d67bf9011ee9954a28e3479f3f185cb6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4164,6 +4164,8 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
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


