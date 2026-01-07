Return-Path: <linux-kselftest+bounces-48420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78DCFF726
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B70633D64DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8423C34D4ED;
	Wed,  7 Jan 2026 16:49:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7BA34AB1D;
	Wed,  7 Jan 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804544; cv=none; b=dplN/9jxHHKiwh58SRDzmpRA0hNW5ivIwRFgNtao2GSoDZUKNC2Lmqai5xVZerXX0p8odbyFL6E5buUY0ZqG3z46RhFIFmDGD6ftsXWxvNd3UCXOT00auVQi1Qsnau5ICtPB6YCQOP3hpjhP4nCnqS81I8JRVUoiQbxvRvWN1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804544; c=relaxed/simple;
	bh=I79DnR1ir8QZmj+udno1Mp43vB+3x3zTQdfEiIjBK0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjcSGBi6r2B1KQdSrduBI/P/x7wpI4iRDWXGmUMAZmGvc1to0EqjINmfPEHi60F5f2tY83xWRJODz5I+lhnngYUXa3pT6IXOLra2dYlkuovm7LxTjg9htlp3EkMGK+bU5mBuLQFkDFTIu0Kog4MH1xfAL/kiO6F/+bGowqLEAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3409D497;
	Wed,  7 Jan 2026 08:48:44 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F2A3F5A1;
	Wed,  7 Jan 2026 08:48:49 -0800 (PST)
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
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 0/8] Various mm kselftests improvements/fixes
Date: Wed,  7 Jan 2026 16:48:34 +0000
Message-ID: <20260107164842.3289559-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various improvements/fixes for the mm kselftests:

- Patch 1-3 extend support for more build configurations: out-of-tree
  $KDIR, cross-compilation, etc.

- Patch 4-6 fix issues related to faulting in pages, introducing a new
  helper for that purpose.

- Patch 7 fixes the value returned by pagemap_ioctl (PASS was always
  returned, which explains why the issue fixed in patch 6 went
  unnoticed).

- Patch 8 improves the exit code of pfnmap.

Net results:
- 1 test no longer fails (patch 6)
- 3 tests are no longer skipped (patch 4)
- More accurate return values for whole suites (patch 7, 8)
- Extra tests are more likely to be built (patch 1-3)

---
v1..v2:
- New patches: 1, 4, 5, 8

v1: https://lore.kernel.org/all/20251216142633.2401447-1-kevin.brodsky@arm.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
Kevin Brodsky (8):
  selftests/mm: default KDIR to build directory
  selftests/mm: remove flaky header check
  selftests/mm: pass down full CC and CFLAGS to check_config.sh
  selftests/mm: fix usage of FORCE_READ() in cow tests
  selftests/mm: introduce helper to read every page in range
  selftests/mm: fix faulting-in code in pagemap_ioctl test
  selftests/mm: fix exit code in pagemap_ioctl
  selftests/mm: report SKIP in pfnmap if a check fails

 tools/testing/selftests/mm/Makefile           |  8 +-
 tools/testing/selftests/mm/check_config.sh    |  3 +-
 tools/testing/selftests/mm/cow.c              | 16 ++--
 tools/testing/selftests/mm/hugetlb-madvise.c  |  9 +-
 tools/testing/selftests/mm/page_frag/Makefile |  2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c    | 10 +-
 tools/testing/selftests/mm/pfnmap.c           | 95 ++++++++++++-------
 .../selftests/mm/split_huge_page_test.c       |  6 +-
 tools/testing/selftests/mm/vm_util.h          |  6 ++
 9 files changed, 84 insertions(+), 71 deletions(-)


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.51.2


