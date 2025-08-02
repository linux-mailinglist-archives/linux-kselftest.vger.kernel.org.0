Return-Path: <linux-kselftest+bounces-38207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D2B18BD4
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05EE625600
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDAA23B624;
	Sat,  2 Aug 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNxf8C44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14438220F25;
	Sat,  2 Aug 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126690; cv=none; b=InkipTMkO262mKk+HqfBuCRKVQcOuhFeooJW3ND/z83ycEIyekL6lIPoMrE+MfPNMNzaLh/rvwQax+0o9f++efA7hRhvDYssHpKPdvWNqI8KAIRVwcg7ICOeECla3bJYCiCmfB9Pby/m3VhvAGxSBBw0upff2pKvtDy5UHBPb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126690; c=relaxed/simple;
	bh=xD8KgrqpPiDmgazFetjG6Tsu7LzX7BP/AY/H44AoAag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpah6qi7i5DNn4sqZsP8fnOgs4hbxzJdWNsIbBrnANehY4BNWQ0w4o5llFmbedY0OgoA/KuQKyPLzB5hfQWVNor5dSdEqxoZu5Ni5F77UA30WmM9e3BR0bCHx7DiWcXuC/rLmuv9kZWfViQOZGvvVxzEo+k56vi3+XwiQS+VnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNxf8C44; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2019108b3a.2;
        Sat, 02 Aug 2025 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754126688; x=1754731488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pqbEz0Zn1pMZAPVskT9dBH7JU+WRuUgNUEVSJgTrQM=;
        b=cNxf8C44L+v6eBoLIlhGekdMgEJmjkuqiQ26kCY6XXOy/bqwUQmhsS5uJo7iR83hr0
         2TZmxe+BdxMWhwcqeLNKxOlEyPY7QAQZPOYQJ8w9unXWrkkyX308alpTyZT8/lKzE2kp
         kGvyIxD+oiwf5kJoYulOgpH2yQhI3BktgePOe6V1329oR9svK00nlrD8/njM0wisS/y5
         b6koqeS/Zdn76NKOExJoeZrhNm+gS++2NvSct94b4XItnvv2J5FvkugUr3Jhnn7GxyS2
         Umjcy3CsxPdJGFy+W1UMmdAJABrF2JdidLRuWCxKQHkgYGvbkFWnK4EoCqRMOoIRvS0p
         pm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754126688; x=1754731488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pqbEz0Zn1pMZAPVskT9dBH7JU+WRuUgNUEVSJgTrQM=;
        b=vkM50M2fNvTn6x4fS/YPkgvlCHECr8ceC2Gk233LHVmTvCJ6SRWEKiSy9nKG21eNRG
         epkEsTTkgcunuMr56xwkwDPEM+qJACXEe1o5jEbSJ2V4vrKGXhaG+J8Jn3OGJiOh76f3
         p0aB+yb0MRpdGb9duY+EagnBNGuGSG+dupi8o5K5JA4m3er7QROIpCp6RJ5rNDJuDVAN
         ZcvmVyFxKqULipSfjlPFzhmT5aMkbtLmKXYKBKHJWMz+oIJFRVji2Fm8OHFD7hPzAnwj
         AkKMHmOaHD6cevpnEEAJR55JsXExwymwtsXQWaYj7QSEWpK+ql0hQGgoT1iyXCG+ZJ7D
         HhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGUTdUB3/C036h/9ZycRgZRcyQxz6mtxbs1B8CljmHOY8no3m2BHt0/JKkyr7m7vyb3dydJLk+QlS2XGU=@vger.kernel.org, AJvYcCW8NyopsyTSc9n8vN1Bj1QsOWkVsbSIPJpshv+8K3FDL/twDUOZjsppilhAg0Y6JEv8mxO78SryhA+0NV7Dmo86@vger.kernel.org, AJvYcCWGgC1LzVJ/0NZR0QrPsFiCoJw+3BjTgJJVIw7dJqu9kdyh+1a5WVWQOcWsRdrp6bmAYSgFKqVV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdoc7obL34izRgTgYKchDAeGy+hJvmmndxt3AZmxtU7zpDBdng
	qcWzsM2MjK3axf/NRgarsz6nQHdeagAef+VJtsI/eFHa2hnvJ+mX2zAh
X-Gm-Gg: ASbGncsMf4X5RXWB77yM0FcqkfZGLrQs53EjQRvgjQxw8CBk7foVH2UxHWBQAAaxT71
	5ORZtjAqTV2GUlsrNkZ5sLFN4i9yVE5ohX0QEhG/zt784wwH9JnX9FOVFMGakBgMQzcpEvN1w7a
	ShQ2zU3JHQE07z9p7NDrwiCiTJQYJDtu7lRrzYLLe+niq9eg42C4p+HTRLHxms10RF1VmrQj5EI
	JFi1MCd2ca1LnrXJPk8ZUB+WGj2t3Hk6Z9JGPO6W+G8tnhPno6kd5pHs4ZHoi263pNyGOVqlVXx
	6mjNiIhMMTMZNAXlg7ahIzlmTUcjQRN/j+hEMhospFNc8JFBHkuRBJ+y7JtGhR1UqGmg9V17lH2
	BmvkluBa3YNMU3/c83VI=
X-Google-Smtp-Source: AGHT+IGgeQcYnQMmpXHWsqcSvhUwirdKYfKvusr/0T3aWzhhNlarhs87jNgNFmyTtiAP4MJsf7HlUg==
X-Received: by 2002:a05:6a00:92a9:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-76bec4dbd7fmr3638004b3a.24.1754126688215;
        Sat, 02 Aug 2025 02:24:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm4799161b3a.20.2025.08.02.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 02:24:47 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuniyu@google.com
Cc: ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	kraig@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 1/2] net: tcp: lookup the best matched listen socket
Date: Sat,  2 Aug 2025 17:24:34 +0800
Message-ID: <20250802092435.288714-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802092435.288714-1-dongml2@chinatelecom.cn>
References: <20250802092435.288714-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the tcp socket lookup will terminate if the socket is reuse port
in inet_lhash2_lookup(), which makes the socket is not the best match.

For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
but socket1 bind on "eth0". We create socket1 first, and then socket2.
Then, all connections will goto socket2, which is not expected, as socket1
has higher priority.

This can cause unexpected behavior if TCP MD5 keys is used, as described
in Documentation/networking/vrf.rst -> Applications.

Therefor, we lookup the best matched socket first, and then do the reuse
port logic. This can increase some overhead if there are many reuse port
socket :/

Fixes: c125e80b8868 ("soreuseport: fast reuseport TCP socket selection")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
* use the approach in V1
* add the Fixes tag
---
 net/ipv4/inet_hashtables.c  | 13 +++++++------
 net/ipv6/inet6_hashtables.c | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..51751337f394 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum, inet_ehashfn);
-			if (result)
-				return result;
-
 			result = sk;
 			hiscore = score;
 		}
 	}
 
-	return result;
+	if (!result)
+		return NULL;
+
+	sk = inet_lookup_reuseport(net, result, skb, doff,
+				   saddr, sport, daddr, hnum, inet_ehashfn);
+
+	return sk ? sk : result;
 }
 
 struct sock *inet_lookup_run_sk_lookup(const struct net *net,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 76ee521189eb..2554f26d6c20 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -161,17 +161,18 @@ static struct sock *inet6_lhash2_lookup(const struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum, inet6_ehashfn);
-			if (result)
-				return result;
-
 			result = sk;
 			hiscore = score;
 		}
 	}
 
-	return result;
+	if (!result)
+		return NULL;
+
+	sk = inet6_lookup_reuseport(net, result, skb, doff,
+				    saddr, sport, daddr, hnum, inet6_ehashfn);
+
+	return sk ? sk : result;
 }
 
 struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
-- 
2.50.1


