Return-Path: <linux-kselftest+bounces-47607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142ECC38FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCD243005D30
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44A834CFCA;
	Tue, 16 Dec 2025 14:26:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30064345CAF;
	Tue, 16 Dec 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895205; cv=none; b=MWAOTV18p5F7rjaIX4m3aAld6cCdSJIQ4URrw0e1ELlUOTlXhWlwW9wJWwxDnobh9QK0Ml5NnhhSxv3PcpWsj4eKVwYG1UnVoSwx+B+G0CWCG6zWGqy5dqdgKewu66X9hOSYGKpbc8QAAVxZIRykf3z5v4+wPc5uEIEveQYWhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895205; c=relaxed/simple;
	bh=ulRaCuI2R5Ra/9l8IWLGkwcmHbKAofBAfOXkEXfB1u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKQxIfU84bHLQhVdVBmZeOqN0m28J95ZKQjemkrX4Ve2gcuhaTBtGDOhIylPs4rRRlajBf3dmfrIH6R29cUTzZYrMuFy9St4ndA2OR9QPS/9ocxhWxyY/2AnCPf7lhWrbfvZUvNkCMWfvY9+UWgF0kEOaYsUxYvnbjL90lmp/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66CE41516;
	Tue, 16 Dec 2025 06:26:36 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36F83F694;
	Tue, 16 Dec 2025 06:26:41 -0800 (PST)
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
Subject: [PATCH 1/4] selftests/mm: remove flaky header check
Date: Tue, 16 Dec 2025 14:26:30 +0000
Message-ID: <20251216142633.2401447-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216142633.2401447-1-kevin.brodsky@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
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
O=$KDIR make) because only generated headers are present under
$KDIR/include/ in that case.

<linux/page_frag_cache.h> was added more than a year ago (v6.13) so
we can probably live without that check.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7..aba51fcac752 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -46,12 +46,8 @@ CFLAGS += -U_FORTIFY_SOURCE
 
 KDIR ?= /lib/modules/$(shell uname -r)/build
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


