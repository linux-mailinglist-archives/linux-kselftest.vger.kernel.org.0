Return-Path: <linux-kselftest+bounces-8406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C48AA966
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A81F21BBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9D43ACA;
	Fri, 19 Apr 2024 07:44:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF74D137;
	Fri, 19 Apr 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512645; cv=none; b=CDfsqR18KemEBGjW5ACG2fMjNQQ4GzlGipk8mH2CxcXM6MymCWTvK8UuVdvOckLA2K2GK8Sz/KpaEhgrLynty0uEEhsaloBy6eeekw6oex2NftN2RGoC4X+zaoPMgEr1aGjwfWT42J23IlDx7H9LdeODvDc4b3GmPJLzJfuMpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512645; c=relaxed/simple;
	bh=4puIi/iIsSa4ouWs2lBAfu9cJ1fC9wmjL4uk0fMNooQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwdGsXow9Vu8vwym9uAh4NkqdnkauqJA2Jyk+xzTS0/QDPmauiL4NN4eubBwBLJBv3IjHyjIaupCcAZfATiGzT1W/iDSCmwkHK6lZ48UyuJi9XJF+nWYANQob+bJrZ8OU3e0BIx1TkpvEnbbutp+yE0N5xYrmzxNPzMyO22UFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E48F62F;
	Fri, 19 Apr 2024 00:44:23 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93E4A3F792;
	Fri, 19 Apr 2024 00:43:53 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty tracking
Date: Fri, 19 Apr 2024 08:43:39 +0100
Message-Id: <20240419074344.2643212-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series adds uffd write-protect and soft-dirty tracking support for arm64. I
consider the soft-dirty support (patches 3 and 4) as RFC - see rationale below.

Previous attempts to add these features have failed because of a perceived lack
of available PTE SW bits. However it actually turns out that there are 2
available but they are hidden. PTE_PROT_NONE was previously occupying a SW bit,
but it only applies when PTE_VALID is clear, so this is moved to overlay PTE_UXN
in patch 1, freeing up the SW bit. Bit 63 is marked as "IGNORED" in the Arm ARM,
but it does not currently indicate "reserved for SW use" like it does for the
other SW bits. I've confirmed with the spec owner that this is an oversight; the
bit is intended to be reserved for SW use and the spec will clarify this in a
future update.

So we have our two bits; patch 2 enables uffd-wp, patch 3 enables soft-dirty and
patches 4 and 5 sort out the selftests so that the soft-dirty tests are compiled
for, and run on arm64.

That said, these are the last 2 SW bits and we may want to keep 1 bit in reserve
for future use. soft-dirty is only used for CRIU to my knowledge, and it is
thought that their use case could be solved with the more generic uffd-wp. So
unless somebody makes a clear case for the inclusion of soft-dirty support, we
are probably better off dropping patches 3 and 4 and keeping bit 63 for future
use. Although note that the most recent attempt to add soft-dirty for arm64 was
last month [1] so I'd like to give Shivansh Vij the opportunity to make the
case.

---8<---
As an appendix, I've also experimented with adding an "extended SW bits" region
linked by the `struct ptdesc` (which you can always find from the `pte_t *`). If
demonstrated to work, this would act as an insurance policy in case we ever need
more SW bits in future, giving us confidence to merge soft-dirty now.
Unfortunately this approach suffers from 2 problems; 1) its slow; my fork()
microbenchmark takes 40% longer in the worst case. 2) it is not possible to read
the HW pte and the extended SW bits atomically so it is impossible to implement
ptep_get_lockess() in its current form. So I've abandoned this experiment. (I
can provide more details if there is interest).
---8<---

[1] https://lore.kernel.org/linux-arm-kernel/MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com/

Thanks,
Ryan


Ryan Roberts (5):
  arm64/mm: Move PTE_PROT_NONE and PMD_PRESENT_INVALID
  arm64/mm: Add uffd write-protect support
  arm64/mm: Add soft-dirty page tracking support
  selftests/mm: Enable soft-dirty tests on arm64
  selftests/mm: soft-dirty should fail if a testcase fails

 arch/arm64/Kconfig                         |   2 +
 arch/arm64/include/asm/pgtable-prot.h      |  20 +++-
 arch/arm64/include/asm/pgtable.h           | 118 +++++++++++++++++++--
 arch/arm64/mm/contpte.c                    |   6 +-
 arch/arm64/mm/fault.c                      |   3 +-
 arch/arm64/mm/hugetlbpage.c                |   6 +-
 tools/testing/selftests/mm/Makefile        |   5 +-
 tools/testing/selftests/mm/madv_populate.c |  26 +----
 tools/testing/selftests/mm/run_vmtests.sh  |   5 +-
 tools/testing/selftests/mm/soft-dirty.c    |   2 +-
 10 files changed, 141 insertions(+), 52 deletions(-)

--
2.25.1


