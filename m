Return-Path: <linux-kselftest+bounces-8965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D718B42B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ED51C21E06
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C43BBF5;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck2xVZBP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A03BBDC;
	Fri, 26 Apr 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173845; cv=none; b=R/0Cd6/Pufj1zqHjFN0Lrc6cAw2VBf8Dpd3wf+Ye4apE3jaV6v+ih+CRcavTJz1YC70nwWIU19nwdTr2lQt66WE4MZJmeOKpVYVLZMqeTvLUFLPssaPbY+TmYFC8NA5jJsBZE4zpzJGsTzQZEFmvSg7UE6U8UDdw2uYesd7xqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173845; c=relaxed/simple;
	bh=mORTOztAviz6anBh5JZKiWwXRJ8TMklFXNQyvGi9kww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KauAGEPcumji5BS7v2NDNPtJHior+ca4MQXHwEgTtyx0F71fiwVh0kK9yObsAowdgXsJuDycf1oEcdlCPu2ZpMNSG1vgs+CFmI80giaEqFTCpU6PsVOJNwN6pHst0tvfIt2ECWIsSAtNz0qBd+FQUb+gQUmQJOOo95rV5yyyfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck2xVZBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CE0C32781;
	Fri, 26 Apr 2024 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173844;
	bh=mORTOztAviz6anBh5JZKiWwXRJ8TMklFXNQyvGi9kww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ck2xVZBP/oc16lHGI+QqSwwyOcUaE2hxktIMS7IMcctdoYJL4FdMzrEm49J8l8j8B
	 h8LCa8HsVXm/fWB95aEoT8ler3D7AMmhb4biaMolqaQiGfSpd3PRmey5uzRLebLTwA
	 rn609d2W72Ya8xOnulKXUrEVoVPPUJzWXFOuHaUAcKNtxBTvj5S2MzZsJ25qqm/a40
	 qcNb6NyUV6lp3JIEw5YeJPgnxy7C1hXxAK0PjONXonbjx4cWN8dNL7r3tCgzRcwFi8
	 UkkadNl+yvbjMkW6OsijomdwfkEgmwMLuA50kQxe5uYqt1ciOa1fa0/EIIg2Sfb92k
	 IjqHvht98yxcw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH net-next 1/6] net: page_pool: support error injection
Date: Fri, 26 Apr 2024 16:23:54 -0700
Message-ID: <20240426232400.624864-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
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


