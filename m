Return-Path: <linux-kselftest+bounces-21015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE439B5482
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23281C22864
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E5209672;
	Tue, 29 Oct 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0gZIR53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE657207A0F
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235333; cv=none; b=ctBXq4OU4i9QvkG1IlLGGiVg0MKJFmsbcas8fNVbsHURosbTxNHNt4V/Z8FpwaHzx9Ru+7bpg0GidiKUPWJB0CxIFTmCmtATR4gkwhujvM/EpreGAl+YSU9WEfkPo1bfqqGurR43bx+zA/9K3LR4qiippysStB6ToKSqTzbqPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235333; c=relaxed/simple;
	bh=mQ6IINwbv+WqN8eNzea0/anvNw/9DICQ4rWqPuw7YWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmvz6alG97GxMmnnk6uUFjDcPddV2U/haGfDxNYuKI4ImwPhEUOIGMXA85/SPOu50dSVamnC4vO4LZQJ8MjciIPSe6DJqnea34LlLdBsmXEgqBqFE69G7q9ocDqbPvlPze3yY39ZZMTWH3OD8M0jP6v/V2NGvad4+va/Ycwk1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0gZIR53; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so9612518276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730235330; x=1730840130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKpRCsSetJLLXlDYxzCijv6xVtSe3eCBCnbKb8kuBnA=;
        b=n0gZIR53ZEh5948T2NT5Vtz5gI9lNdqRir/X+O1P5EcN01YFb3GiY7XgkHwoKewjbe
         WcSu7P8lYVj/VRxsTfqRXQFURPG7Idvp2DpC09XNloM93JG79HvaJks+qGzWLANH4Es4
         uO8G2lEdJ1Kpt9IIJ0f3WlR1s1YZcDNW3wnnguGIi72ukVDe5bXlICtMdyw585bmhUuw
         +GrMyjHnvZzQBIfSNyo3ZE1E0XvkAlywhO8bptDKAQ4WwthvNVTDwB6qJGvuYbnnWTOJ
         8tveQFDLx3e4GEtsPMHZlKpfs8goTs60YMqXxr2jLT1O2wA2tZTs9LE6j6b75NqBEjE8
         zgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235330; x=1730840130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKpRCsSetJLLXlDYxzCijv6xVtSe3eCBCnbKb8kuBnA=;
        b=XS8yWIqK8IHF//hkOeDEo875DC7I4QUeqbBi+dQsyqhSNuXBBcjRFWrSpM7gN80Sf+
         tW0jicsHydzOKMuSqG7rtpmSj5zgGG5dnwJk4caYRqq6wV4aEqTus10yDKRhsC81CIoF
         rX4MURiqbDs+mdKtM7LFF7G5h0n3qatL3e8S8FjZIU1UgqAuZMxLHHvBz+582Q/KIDOx
         lUQfu4LTPc/4RbHYfbixaih91EbNqeo6DCiF5DwALX1ILOkCvyBk5cjwIdRa4wD/nUJE
         zjjrElCk5u68uTrEcOtkavwYFu1fuVO56gmFDsYOgAjtdhUfDM32fAy27IUff5vhi1N9
         ilpw==
X-Forwarded-Encrypted: i=1; AJvYcCVPg9Rn9VEnCwDzytxMizlqmPr3gLh7xsVM53aGBNAwv9H8e82apcjd6HXkv8kECjMRdv8cM8pTZnhHqhVM0dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Hlt4t5ahgSCNdW+G4eENZLDEQ8TDgv8wGTGEoTZZCbUSsgR+
	lRPKt96D1z0BLmf4lQW8jPxjXZfDIbmFInH5PMNoSjwhWHZBJ7SAynYkx5vj6zRDQea8ed9iWsb
	OhLgiMDSwQi39M/sQvnbuHg==
X-Google-Smtp-Source: AGHT+IEE7dLJq88/f4VVbxU0VfsyGl1ZHgwa5wCblziyZGTjJhsrP38TX70qH8bVr1KXcQFHnEzpeHyoZA5aeIAonQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:c78a:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e3087c2d8b1mr69573276.11.1730235329787; Tue, 29 Oct 2024
 13:55:29 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:55:21 +0000
In-Reply-To: <20241029205524.1306364-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029205524.1306364-2-almasrymina@google.com>
Subject: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too long
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Yi Lai <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Check we're going to free a reasonable number of frags in token_count
before starting the loop, to prevent looping too long.

Also minor code cleanups:
- Flip checks to reduce indentation.
- Use sizeof(*tokens) everywhere for consistentcy.

Cc: Yi Lai <yi1.lai@linux.intel.com>

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/sock.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7f398bd07fb7..8603b8d87f2e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock *sk, int bytes)

 #ifdef CONFIG_PAGE_POOL

-/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
+/* This is the number of frags that the user can SO_DEVMEM_DONTNEED in
  * 1 syscall. The limit exists to limit the amount of memory the kernel
- * allocates to copy these tokens.
+ * allocates to copy these tokens, and to prevent looping over the frags for
+ * too long.
  */
-#define MAX_DONTNEED_TOKENS 128
+#define MAX_DONTNEED_FRAGS 1024

 static noinline_for_stack int
 sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
@@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	unsigned int num_tokens, i, j, k, netmem_num = 0;
 	struct dmabuf_token *tokens;
 	netmem_ref netmems[16];
+	u64 num_frags = 0;
 	int ret = 0;

 	if (!sk_is_tcp(sk))
 		return -EBADF;

-	if (optlen % sizeof(struct dmabuf_token) ||
-	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+	if (optlen % sizeof(*tokens) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
 		return -EINVAL;

-	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
 	if (!tokens)
 		return -ENOMEM;

-	num_tokens = optlen / sizeof(struct dmabuf_token);
 	if (copy_from_sockptr(tokens, optval, optlen)) {
 		kvfree(tokens);
 		return -EFAULT;
 	}

+	for (i = 0; i < num_tokens; i++) {
+		num_frags += tokens[i].token_count;
+		if (num_frags > MAX_DONTNEED_FRAGS) {
+			kvfree(tokens);
+			return -E2BIG;
+		}
+	}
+
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
 			netmem_ref netmem = (__force netmem_ref)__xa_erase(
 				&sk->sk_user_frags, tokens[i].token_start + j);

-			if (netmem &&
-			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
-				netmems[netmem_num++] = netmem;
-				if (netmem_num == ARRAY_SIZE(netmems)) {
-					xa_unlock_bh(&sk->sk_user_frags);
-					for (k = 0; k < netmem_num; k++)
-						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
-					netmem_num = 0;
-					xa_lock_bh(&sk->sk_user_frags);
-				}
-				ret++;
+			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
+				continue;
+
+			netmems[netmem_num++] = netmem;
+			if (netmem_num == ARRAY_SIZE(netmems)) {
+				xa_unlock_bh(&sk->sk_user_frags);
+				for (k = 0; k < netmem_num; k++)
+					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				netmem_num = 0;
+				xa_lock_bh(&sk->sk_user_frags);
 			}
+			ret++;
 		}
 	}

--
2.47.0.163.g1226f6d8fa-goog

