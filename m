Return-Path: <linux-kselftest+bounces-48421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28323CFF6A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8581A3073070
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3C1349B10;
	Wed,  7 Jan 2026 16:49:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69F33EAEA;
	Wed,  7 Jan 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804544; cv=none; b=kzGmPZsnVfrjWccZeLPP4VPUYml3kYBQ7zRAOtgSLMsPLonlgiQsiIctrqEBoGLGQsWAUqcjx50nWXq2q6xQIxWFo55PfIvTDCwM6vSaVMH0Bl0Wj8QtCyOys+6SPD+V/rn0iAK9b2GvjR+urM+MNpoIBABijh/JSSLXu2AQxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804544; c=relaxed/simple;
	bh=2hMGx95vnh6gsO5PRXVTxc0UWEAyKtwTPhrSM17PS18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFhMV2cSCfWYjydWp8/NB1ZDxbxWGXpCITKQi5H+xUuOtr8u0C9s/ojx0Y+/7wuk2b/2H7dqMl77MYwvwDtmg9y68A2FbP+Qe3h9M2FXBu6qpp8MH6gXO3LWZGzSNDdybP+4RH0x4uIkz9AbA9lj4xOjQlNU8czo2Q9ciO/lLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ACAA1655;
	Wed,  7 Jan 2026 08:48:47 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8E433F5A1;
	Wed,  7 Jan 2026 08:48:52 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH v2 2/8] selftests/mm: remove flaky header check
Date: Wed,  7 Jan 2026 16:48:36 +0000
Message-ID: <20260107164842.3289559-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 96ed62ea0298 ("mm: page_frag: fix a compile error when kernel
is not compiled") introduced a check to avoid attempting to build
the page_frag module if <linux/page_frag_cache.h> is missing.

Unfortunately this check only works if KDIR points to
/lib/modules/... or an in-tree kernel build. It always fails if KDIR
points to an out-of-tree build (i.e. when the kernel was built with
O=... make) because only generated headers are present under
$KDIR/include/ in that case.

A recent commit switched KDIR to default to the kernel's build
directory, so that check is no longer justified.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index bb93101e339e..4e5c8a330a0c 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -46,12 +46,8 @@ CFLAGS += -U_FORTIFY_SOURCE
 
 KDIR ?= $(if $(O),$(O),$(realpath ../../../..))
 ifneq (,$(wildcard $(KDIR)/Module.symvers))
-ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
 else
-PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
-endif
-else
 PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
 endif
 
-- 
2.51.2


