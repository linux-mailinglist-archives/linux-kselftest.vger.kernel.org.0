Return-Path: <linux-kselftest+bounces-34863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9EAD821D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 06:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BD13B7CD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 04:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53902522B4;
	Fri, 13 Jun 2025 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2xHEDUG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E243202963
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788906; cv=none; b=JOA5g+cF1BdTEW0NtOtf3e+QsYrvKjBNtt6gsFDT5R7xfsWgn+kfGoXN7sTjlJ05c8YpKzD5PzzTDxJvTd5S79QFO5nDh/a+pgUPq+1UVy0dYogzXOCFMAFlE+CjFoZbXnj7mZ2qiJkX5vhzVN1MU04Qp7YP8KbgFtag9RhLQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788906; c=relaxed/simple;
	bh=cLMFRytwCAbUcsumEZy3rbgGn6MqQQrWrO6EyWB53GY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/ZMdUMLSk1CqujCW1zfCme4zPeYpPf2RQPMx1ZbP1sZWY7LFyjyBkWUEsNmqjDZlMhsNQ9rMsft4qAB8cmcKRqYQc9vgEzlVecrwoyESaeKzTU4GomLPvUHs6Ef3SX+7r7IdsPIPutZL39XTU3ahXznRghZtHDsn+Qw53GDmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2xHEDUG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23592f5fcb0so23238255ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788904; x=1750393704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq0DQz/GmNzjKY9rWVYo4cPfcNQII7suJKVz4zh1h04=;
        b=o2xHEDUGMCumw91n8paMImOVbTfnYreertLkKnleDbr5+y9UDSoGfUgMfLpbd1Rh5N
         1KjqnFqaIdoY99PbrYEPLEK0vqVNAlBf4U7Ca963kyLC0YloS7nXGJv+YJIRY2uCHXl/
         RYzo41LXjeeCGQaiRf8NdviVdkgO2jnrQdqYzno5oa/y1BYyYD6WW1Ii1ZStETozN+A7
         Y++Dy0H3I9xCF2WecLfoo8hC2fQBoBmdtFOBDTB0IHLFGJSKfcXjh1qpNOI5O3vo14nR
         qlIa7F3lRBiCRS3eTFLGLoQkBY6jEyD1OSkGcuwC8vKGP4RX869jjxqeyN0mjvlqtmKx
         nfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788904; x=1750393704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq0DQz/GmNzjKY9rWVYo4cPfcNQII7suJKVz4zh1h04=;
        b=ej2z26/i9DsqKoeFa0O0lIUd6iPeqV9MkFQUc57nmkvM+PgLs3l6BqAOiXAYqUECVW
         htWDxJ9omYK7ecDdO81keANNbkV75UTQmfexiuyYQkI0MXq1cyzUpyzoRRGkqCLYBLZV
         17QYDlKOIM/02Z/xnPCG2mHcAkjm5gXdEoePNZC6i/ceBmID8SyX4133HyElCTmRlPzm
         Hp2JmbI0AZP/UpJqAzLItdrmVgswoAep90Y3PT79UjkRWCxo3a9dBWtqICfcakUIqGTI
         l/IBJ3//h5OUHpIRgwesY/0t5gdk9zktI00khJOE3Kbz0uujzMKMmQgxImNcFm2ZnIbY
         Rbuw==
X-Forwarded-Encrypted: i=1; AJvYcCVqd4ZKKVmSBiqm3ZJKds0WVUoUAJlik3QrrcffFM854ErP3DzVhdsrqJemssEOmq3xU99v23nSWocYsNh6hbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdEkfRgyaJi7D4deD5KXlwzTYsvvkrdglqyBCo/vmZ5ePOsa5
	g5B6x5GwPnYlo9QvoU3THgVtyeFOU669bG+d4WSeBzB1Nr8SpOTyMRkpQW5TgT7d4rLPLwp2G33
	T7QKxdhVxuUJgAqw/wAN+JLDrcA==
X-Google-Smtp-Source: AGHT+IFaqKu15tKP0UOvmvj4nCuAG9FBRJl5t2EPwtoFoYDsrTb/txjDVkvyhDwsAv5xUUWvtptEIssgdy6Mhndrug==
X-Received: from plqt6.prod.google.com ([2002:a17:902:a5c6:b0:234:cfe1:44a3])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2a88:b0:234:8ec1:4ad3 with SMTP id d9443c01a7336-2365dd3e4a3mr25251795ad.40.1749788904428;
 Thu, 12 Jun 2025 21:28:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:28:02 +0000
In-Reply-To: <20250613042804.3259045-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613042804.3259045-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613042804.3259045-2-almasrymina@google.com>
Subject: [PATCH net-next v1 2/4] netmem: fix netmem comments
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Trivial fix to a couple of outdated netmem comments. No code changes,
just more accurately describing current code.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..28ca931dc860 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -89,8 +89,7 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
  * typedef netmem_ref - a nonexistent type marking a reference to generic
  * network memory.
  *
- * A netmem_ref currently is always a reference to a struct page. This
- * abstraction is introduced so support for new memory types can be added.
+ * A netmem_ref can be a struct page* or a struct net_iov* underneath.
  *
  * Use the supplied helpers to obtain the underlying memory pointer and fields.
  */
@@ -117,9 +116,6 @@ static inline struct page *__netmem_to_page(netmem_ref netmem)
 	return (__force struct page *)netmem;
 }
 
-/* This conversion fails (returns NULL) if the netmem_ref is not struct page
- * backed.
- */
 static inline struct page *netmem_to_page(netmem_ref netmem)
 {
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
@@ -178,6 +174,21 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+/* __netmem_clear_lsb - clear the lsb of &netmem and return it as
+ * a net_iov*.
+ * @netmem: netmem reference to extract as net_iov.
+ *
+ * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
+ * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
+ * these fields without a type check to make sure that the underlying mem is
+ * net_iov or page.
+ *
+ * The resulting value of this function can only be used to access the fields
+ * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
+ * undefined behavior.
+ *
+ * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
+ */
 static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 {
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


