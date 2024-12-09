Return-Path: <linux-kselftest+bounces-22998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4C9E8F31
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A3282B5A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083121638B;
	Mon,  9 Dec 2024 09:50:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4D215709;
	Mon,  9 Dec 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737841; cv=none; b=m6YXOE8uLw4jXoV47RQbsh/MMNa1tP0cQvONm9fYC7I7IGV3juuTxq+eRVUCL/fNwbeMtxNlUxZCG8/4Pevbjs9qkQHqHqivxIZE67LL0Q0Hc0wnOOfmz7dDeJN1TvCBwv4FwUkWS/NP7D1JFJMJLW/MhmMWse2/qAmnphowPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737841; c=relaxed/simple;
	bh=T+iE/oK5WqmK7L57Htnk7xy3yWLy+HmIv6vHM6mb1Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMcmt8hoEWs9JrxQbhDns5yMaNgT4Tq1gd6Euv0iqmS/SEEmMW5gmg/d0axwrAGgkZRVxtvalyv2M0rs4raBjIm7Rco1LCNwdMYESKmsDSCvMDEnqiGc5CA9bMInYO2SSEDKSATgO5f0rVSwZrOq+7rSYuFZtQgNqiozDzEzTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69759113E;
	Mon,  9 Dec 2024 01:51:07 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EAAF3F720;
	Mon,  9 Dec 2024 01:50:37 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 00/14] pkeys kselftests improvements
Date: Mon,  9 Dec 2024 09:50:05 +0000
Message-ID: <20241209095019.1732120-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings various cleanups and fixes for the mm (mostly
pkeys) kselftests. The original goal was to make the pkeys tests work
out of the box and without build warning - it turned out to be more
involved than expected.

The most important change is enabling -O2 when building all mm
kselftests (patch 5). This is actually needed for the pkeys tests to run
successfully (see gcc command line at the top of protection_keys.c and
pkey_sighandler_tests.c), and seems to have no negative impact on the
other tests. It certainly can't hurt performance!

The following patches address a few obvious issues in the pkeys tests
(unused code, bad scope for functions/variables, etc.) and finally make
a couple of small improvements.

There is one ugliness that this series does not fix: some functions in
pkey-<arch>.h call functions that are actually defined in
protection_keys.c. For instance, expect_fault_on_read_execonly_key() in
pkey-x86.h calls expected_pkey_fault(). This means that other test
programs that use pkey-helpers.h (namely pkey_sighandler_tests) would
fail to link if they called such functions defined in pkey-<arch>.h.
Fixing this would require a more comprehensive reorganisation of the
pkey-* headers, which doesn't seem worth it (patch 9 adds a comment to
pkey-helpers.h to clarify the situation).

Some more details on the patches:

- Patch 1 is an unrelated fix that was revealed by inspecting a warning.
  It seems fairly harmless though, so I thought I'd just post it as part
  of this series.

- Patch 2-5 fix various warnings that come up by building the mm tests
  at -O2 and finally enable -O2.

- Patch 6-12 are various cleanups for the pkeys tests. Patch 11 in
  particular enables is_pkeys_supported() to be called from outside
  protection_keys.c (patch 13 relies on this).

- Patch 13-14 are small improvements to pkey_sighandler_tests.c.


Many thanks to Ryan Roberts for checking that the mm tests still run
fine on arm64 with those patches applied. I've also checked that the
pkeys tests run fine on arm64 and x86.

- Kevin

---
Cc: akpm@linux-foundation.org
Cc: aruna.ramakrishna@oracle.com
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: joey.gouly@arm.com
Cc: keith.lucas@oracle.com
Cc: ryan.roberts@arm.com
Cc: shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: x86@kernel.org
---
Kevin Brodsky (14):
  selftests/mm: Fix condition in uffd_move_test_common()
  selftests/mm: Fix -Wmaybe-uninitialized warnings
  selftests/mm: Fix strncpy() length
  selftests/mm: Fix -Warray-bounds warnings in pkey_sighandler_tests
  selftests/mm: Build with -O2
  selftests/mm: Remove unused pkey helpers
  selftests/mm: Define types using typedef in pkey-helpers.h
  selftests/mm: Ensure pkey-*.h define inline functions only
  selftests/mm: Remove empty pkey helper definition
  selftests/mm: Ensure non-global pkey symbols are marked static
  selftests/mm: Use sys_pkey helpers consistently
  selftests/mm: Rename pkey register macro
  selftests/mm: Skip pkey_sighandler_tests if support is missing
  selftests/mm: Remove X permission from sigaltstack mapping

 tools/testing/selftests/mm/Makefile           |   6 +-
 tools/testing/selftests/mm/ksm_tests.c        |   2 +-
 tools/testing/selftests/mm/mremap_test.c      |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h       |   6 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  61 ++---
 tools/testing/selftests/mm/pkey-powerpc.h     |   4 +-
 tools/testing/selftests/mm/pkey-x86.h         |   6 +-
 .../selftests/mm/pkey_sighandler_tests.c      |  32 +--
 tools/testing/selftests/mm/pkey_util.c        |  40 ++++
 tools/testing/selftests/mm/protection_keys.c  | 212 +++++++-----------
 tools/testing/selftests/mm/soft-dirty.c       |   2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  |   4 +-
 .../testing/selftests/mm/write_to_hugetlbfs.c |   2 +-
 13 files changed, 163 insertions(+), 216 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_util.c

-- 
2.47.0


