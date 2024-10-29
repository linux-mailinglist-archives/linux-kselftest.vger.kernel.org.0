Return-Path: <linux-kselftest+bounces-21009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58789B5456
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D8FB22AA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBD20820C;
	Tue, 29 Oct 2024 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3Gvwbv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C172076D7
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234748; cv=none; b=pP+4tfWJe9V+OFArjXbBwRcuLWQKQ7j5CnlGLPM+JT/5EZuluB7YVnjJtaMWeMXd3RcNIHV254AqEzA8R/iNNmiidYVKE0l5m10J8hcDI3bHvesnwZ9BEjBf1LzWdGtBrgvrCFnFcHJqx4u5ovT1Cu2kMh6ndA1V6y9lcKrnjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234748; c=relaxed/simple;
	bh=ANVvHO/Zb6fJtzVUz2e7HjfsostgYB8KbWIfjKVTCSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OsgXDQTh5zxhRDubjodVxy1yCudY3f1LmA61xNfMvdHZFTw4fVp/jEzQ5V8hTPw/+agSGko9PP50DxpfodsptDFWW3iarbLsrV5acNCaV0P8KYWMRkocqlK2h0J5kQrekHm1FoquHoexM6VD2lp/ijsh1xW87fGo9hW5i1MFDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3Gvwbv8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so95893167b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234745; x=1730839545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKVtq75fITyzSDoz03OSyDAa5pp0EHjXr3igFrBPeF4=;
        b=L3Gvwbv8sSTOIpogPw3LWLYmnHht8jwdmNw/qSjtDDksVdpGU/tGmwZxqFZ74WKK0H
         12L7A9eGG53PMYiM2lFmIEEns5WeYUMQB6wIDVmnQar3aqS+C0S8Dm0EdjTkG6M9SDvi
         utGfDQlQFGZene1H5+Q5J+R2myh+2j3J8abM7qnHMgNB9/LTdj5VEz5mwJJRNKBmvjTr
         ylDK2r4w/3DsPW6lrfyATTIrbTdoO6zHYdnoxSWBxs13uW/g87Ny5+8ZsgaopN6X9fGQ
         BqLf86gNmUNV3ciPp4IHpjnHxSO5XFqxcBq1rkz6t+sPQ3qAubSy7Jg7vgluvLqSO2+2
         oTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234745; x=1730839545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKVtq75fITyzSDoz03OSyDAa5pp0EHjXr3igFrBPeF4=;
        b=hW3PGm80lGbVferBbmRCC5bYhdq6XALyy7c+O+dt5Aqo9V/cyL+j1ak8uvjIQJcdFM
         J9eBwBk1Kl3H2c/Wxh7hCm0EB/ZHA+lhy/m4gm/vugDlZeBE0DRjt91fXs9KNduK94U9
         pqCOVfK967MCkqB7WIu2v52Yjk2IGMLuoAHXKY0EiAxuIPNVcTCTXcboWeoukE4QPAKg
         +RoCKAmK1K1Y/O9lSVZ09IjrI2IBqruQ/oxZ4C9JlIvPSM4MOpi2v4fsemAM97XSPlbR
         RokDWfNtgb0QSP5+FZzhgZIFspR7TDRPaSnwYmz28Q8W3Xi03f1zwvq7ZSG+wGbv2lkl
         WJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIr4kAQW7fil3V3KfcjDnhRD/2FVqat+Kg3ZlvZ9PwXEVpjVtXNue5nQhws1mNKIi+VpHwvaqqxsolhvh4qY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6K35mld5nBxydQjAMktzMcRFEnA73bplTQYAxB7Xr2oLLG4e8
	14mvbFsArfNG5xj7uZ3bEy6siytC2Xf44AbCvPliS+eJP5FC4n5iSmN/je56sqJhbtMRl1acevw
	RCV6YHOumgax8I8DaX+SItA==
X-Google-Smtp-Source: AGHT+IHZYCaL3wj1+u0hTpzTRQJ1G7IFk6vtNOjfqwf31bO7KQxkZpsTH7OU8mGhiD8LbP4+F/NssnNl88Gr6RiQGg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:c14:b0:6ea:34c0:966 with SMTP
 id 00721157ae682-6ea34c00d19mr990757b3.5.1730234745296; Tue, 29 Oct 2024
 13:45:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:35 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-2-almasrymina@google.com>
Subject: [PATCH net-next v1 1/7] net: page_pool: rename page_pool_alloc_netmem
 to *_netmems
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

page_pool_alloc_netmem (without an s) was the mirror of
page_pool_alloc_pages (with an s), which was confusing.

Rename to page_pool_alloc_netmems so it's the mirror of
page_pool_alloc_pages.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..8f564fe9eb9a 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -242,7 +242,7 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp);
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..77de79c1933b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -574,7 +574,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -590,11 +590,11 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
 }
-EXPORT_SYMBOL(page_pool_alloc_netmem);
+EXPORT_SYMBOL(page_pool_alloc_netmems);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
-	return netmem_to_page(page_pool_alloc_netmem(pool, gfp));
+	return netmem_to_page(page_pool_alloc_netmems(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
 ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
@@ -956,7 +956,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	}
 
 	if (!netmem) {
-		netmem = page_pool_alloc_netmem(pool, gfp);
+		netmem = page_pool_alloc_netmems(pool, gfp);
 		if (unlikely(!netmem)) {
 			pool->frag_page = 0;
 			return 0;
-- 
2.47.0.163.g1226f6d8fa-goog


