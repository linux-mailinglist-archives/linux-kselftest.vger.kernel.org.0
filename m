Return-Path: <linux-kselftest+bounces-9024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758188B5BB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876FCB25DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418597F46C;
	Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvaWLrpT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5B7EF04;
	Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401873; cv=none; b=ibVhF+i+wZR/p+FkM+kyRCOBQuvuuQ+CRGw+VdEptCrqzI3oNdN7VtiGaG2Z+u96j6UZmudFbKzgzXMoDIWUbbWPqs8qUwtpGs+fTsmPzswf2xA+ek7vvIymaVrQXMLDSUxCrTtzKBiH0VQ7H2pQ9Pf/tfeHLayXo1oagYLgOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401873; c=relaxed/simple;
	bh=q2yvj/F84Q34toXFpS8iHIkK9/vno+r8OjUyh0QYzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu3n0cvWjBBbfmhzDmIcLw5AD/HISk9eK3U6BUDbQE0YSkJbQYyVQY0UEKu2l8zo0YguNbZCM6j9xThkHqYAZwY/1AeFZ78rqy/R+NwcvSXBBvLIRbL8l3qG7pgQgYaRzblOe00/lVVgBeZ8eQDZ4wyFnvTXaTlZDmuujEV88yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvaWLrpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FE3C116B1;
	Mon, 29 Apr 2024 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401872;
	bh=q2yvj/F84Q34toXFpS8iHIkK9/vno+r8OjUyh0QYzwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvaWLrpTkGAW7m7VXRKCed4IlTCPHY6n5d4nk+hJb1okIDldo5xdqNqsW4dAJ76EV
	 WoTdpIDdaDPkuxYyPOsBZuz3Dhbc4jCp5CrJoJ6iZMFG5LTicNLXiotNOay32o0CZ9
	 LVRHeQ5JE0VxyKSS9aiuFZdPF89uhC73sZp8JZKrJ2uILPQ1FUqKVfSgCqBvdSYsLH
	 pw/Kf3YMXfKJUp4hqiWnayJS4P1zgtxXtp3cOCOHulMAYRtQYTf5xS8zhRA8p+5/G1
	 PI/tE7RDkC5Iju9207HaH1wNeN8h1tFIBccF6QDhOCNd/EsFfb3qE8VeyOpGtfTtIE
	 fA4tGi4jZCpYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next v2 1/6] net: page_pool: support error injection
Date: Mon, 29 Apr 2024 07:44:21 -0700
Message-ID: <20240429144426.743476-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because of caching / recycling using the general page allocation
failures to induce errors in page pool allocation is very hard.
Add direct error injection support to page_pool_alloc_pages().

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
---
 net/core/page_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 273c24429bce..8bcc7014a61a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -5,6 +5,7 @@
  *	Copyright (C) 2016 Red Hat, Inc.
  */
 
+#include <linux/error-injection.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -550,6 +551,7 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
+ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
 
 /* Calculate distance between two u32 values, valid if distance is below 2^(31)
  *  https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution
-- 
2.44.0


