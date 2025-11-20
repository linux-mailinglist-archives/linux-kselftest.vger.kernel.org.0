Return-Path: <linux-kselftest+bounces-46056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FDC72036
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 241112CA83
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588FB301027;
	Thu, 20 Nov 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ioh+t15g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B242F4A05
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609835; cv=none; b=sxDdBUSx6eJBtiajw3Yp0JLQVy/DkrcK5gOKxcLbbEacnA1r5cPv97EWZHYjNwnosT3z6lZXUu1HLCPzS/m1bzsyyQ8lxjhhnTkO5ISJLDILLKV0ZITaKOIPhcHFWFRUJg1CegRb3vEgrg8oM0vO5wkVH4PSqQ2i60GYrUlxZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609835; c=relaxed/simple;
	bh=7/XNyB/QLFMRNjNb6PbYdwSizLyVpMNRusy8wp8n+pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOHc4xqDYOkP5kZ26yY4vFAUuJz6CJJu1ZTylrTbwqHjtkr2ZonitU4zp1qbL4DHkUVFqEgXLElwBHJ+fLGIe2X8cbEqpw7PUFg8iHOxU/ViwdTr9HUAPbPOLFeTBVB881ygS/kztmcmdYQnKimhgGd6Em+NZYZM0KS+pNzATMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ioh+t15g; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787be077127so4248377b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 19:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609833; x=1764214633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8HPHcTcPHipeEg2J18CsLH7RrVON818AUh8XbynViI=;
        b=Ioh+t15gUP1FCkd+u+1wtNH1+icyAb7TgFSIk6rfTt8t6X0aFy9u4O2fcFE9JddFPl
         Jn7+9ppxCHSLMGhLfmnGvD0Pc27M9EFixc+/7o7JwipbIcFSqE5yN3E2tew3I13gMfSw
         lKl0oBJlk7Y6PCsDwpalzjolzGmPIqOwqqtzcwhI/S8WC6RbONgTw+xdg679Xp1V+CRQ
         pGBMc+qmJsCFrwXKPltmREf2KHIfRQ6SMnHYP39Poff3uTwkJcGAuKWOdFg6opck773v
         JPbvZAXvATsStAp4dqZpFycuBwHvcaCwyajXDdQReAFezniYm7ZELYG6ADsn3rrfK2d3
         PDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609833; x=1764214633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8HPHcTcPHipeEg2J18CsLH7RrVON818AUh8XbynViI=;
        b=ZE6+YtGOiwMiOPurp9NGVm0BtdK8FuxCa7HkOLNIGnFQh7hgtMZ4+xcXp9ShFUVWhj
         vbgMSBVJ7psi+ag7OJgP1jklcOydrszLTnDkP6fcnD0/s7Ig7jt2VUoIVx+ktC2h81LT
         LWKxOozDdRRJzsZsxxEdLCEriOsIWwvTt2THmHQUBMLdl5lMgaMaARG7YlCt4IAm7Ch0
         p84TcsIPYW4RSNMzzdQRYqmMCKOa3O+O/hgon7SutXV1jZi4j/KNFYqj5PPvgH5IV9y3
         PSDRz78wrXTEG2+D2Xib67UlijC873HW0rLAjN1dVHSzOBNd8fXsjuEyo6a0BO8LP5E+
         PHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwzttvkumRKpihq+4NpG1zDS22HRUHPVfhB9gYqmbP/k9Dd5+mHAowWD3b74zvXh+RaMjlGavjx9Gsg/DsuOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6/Wt6dG2NWLW8oZ/HRiZaxFgZnQl+0lvnRPWjf36SPlTLiNE
	6w2Bbbhx1I9iB/Q6IJACabeWtXuY1pGr8F/qmFzH2QFThZDdvt6VEo9S
X-Gm-Gg: ASbGnctx4T3gGyQFg27qt0Uo1RAXUXr/UUbGWWyawYR6k3jHECbVpL3Z92bW1K3ztAS
	0VnvUAmWc8X+g9NHmWh3Xlb7AXeLok56OOI3s+IeO8WA8RgnUCSDt6T/k2kbiHSQxrFA+pdIg8C
	5UpAc9hlu3zEDg68g1wddmFK4an4kVH/5lV/myN7F3N+MvJr0zGml7iJnSlb10aV99DQQ7eW272
	svGW9HPD9MY03ay5eQhDMKBCrbRN7EPw7OqQVnZxcllUVnLpAG13jlXLvMz1JjJes9rMLMPwfAX
	huJ9H9n3kUZhX0jbHRqJaOPFiFnsdmCkrJiRwXfhPFJBaNCsmtfrRX2tgRMtA4Q5E4uXLyTgDep
	GNAq8McxecxfN2kx2a9j36Ab8Zd9rGxbYd4OUW0zKPq7PSMOjyC/WWFm2Wcv+rNs49NGj54ZOuC
	5HSzTsRFQ5GgZ3iDHAOz09q90BQF5NJVlZ
X-Google-Smtp-Source: AGHT+IE0rUu8qu5Rkx9gHq3ccJHYL3kg9sZQWOC4lc4TwPWjYLNRb4WIbwmt/9NAqgJ1/c/9jA9W/w==
X-Received: by 2002:a81:ee0b:0:b0:789:29ba:562c with SMTP id 00721157ae682-78a7965dfcamr13513017b3.64.1763609832623;
        Wed, 19 Nov 2025 19:37:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a77d0sm4153177b3.22.2025.11.19.19.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:12 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 19 Nov 2025 19:37:09 -0800
Subject: [PATCH net-next v7 2/5] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-2-1abc8467354c@meta.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Refactor sock_devmem_dontneed() in preparation for supporting both
autorelease and manual token release modes.

Split the function into two parts:
- sock_devmem_dontneed(): handles input validation, token allocation,
  and copying from userspace
- sock_devmem_dontneed_autorelease(): performs the actual token release
  via xarray lookup and page pool put

This separation allows a future commit to add a parallel
sock_devmem_dontneed_manual_release() function that uses a different
token tracking mechanism (per-niov reference counting) without
duplicating the input validation logic.

The refactoring is purely mechanical with no functional change. Only
intended to minimize the noise in subsequent patches.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 3b74fc71f51c..41274bd0394e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_FRAGS 1024
 
 static noinline_for_stack int
-sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
+				 unsigned int num_tokens)
 {
-	unsigned int num_tokens, i, j, k, netmem_num = 0;
-	struct dmabuf_token *tokens;
+	unsigned int i, j, k, netmem_num = 0;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	if (!sk_is_tcp(sk))
-		return -EBADF;
-
-	if (optlen % sizeof(*tokens) ||
-	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
-		return -EINVAL;
-
-	num_tokens = optlen / sizeof(*tokens);
-	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
-	if (!tokens)
-		return -ENOMEM;
-
-	if (copy_from_sockptr(tokens, optval, optlen)) {
-		kvfree(tokens);
-		return -EFAULT;
-	}
-
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
@@ -1135,6 +1118,35 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
+	return ret;
+}
+
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct dmabuf_token *tokens;
+	unsigned int num_tokens;
+	int ret;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen % sizeof(*tokens) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
+	if (!tokens)
+		return -ENOMEM;
+
+	if (copy_from_sockptr(tokens, optval, optlen)) {
+		kvfree(tokens);
+		return -EFAULT;
+	}
+
+	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+
 	kvfree(tokens);
 	return ret;
 }

-- 
2.47.3


