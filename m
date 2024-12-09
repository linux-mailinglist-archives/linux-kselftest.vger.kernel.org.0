Return-Path: <linux-kselftest+bounces-23010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624B9E8F4E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FE16579E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302B218ACD;
	Mon,  9 Dec 2024 09:51:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8CF218850;
	Mon,  9 Dec 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737868; cv=none; b=ghtCxvrIT+cPfZzhSg/Ep/VYwoeW7p5ZZ21yNH2UdRdOj4+JVJ0iurK8MRJThhQhKUc2ORWHslxOXCLY1ctQrUJRgIwqpLQf1XG50WjJ1/XCzvmcG2SyGUbhqAIKqovL6K5KM76RzDHcWydn8s6rMjW+pUrteQdRCRN+AKDvhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737868; c=relaxed/simple;
	bh=20mNN0d7JVepsnUCdMOPjOwmbvMtoyyvxw3IWBAY5yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAwAR3g4ebM+JlTuIClXOlAmKhYTNUcFUlqFWwxMVCTEd1QuWQg5o1bRiy/qkC4SHJZ7lyEMrlyexHAbXXBmDloUt4zzkmI/l7WsrdHvLW5zAZQQwGHzb3pIzkbQt4eaLd0eyyWMcG6xNyBIz4AqpX822yffRmrD1+D3hGkxBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC24113E;
	Mon,  9 Dec 2024 01:51:34 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43033F720;
	Mon,  9 Dec 2024 01:51:04 -0800 (PST)
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
Subject: [PATCH 12/14] selftests/mm: Rename pkey register macro
Date: Mon,  9 Dec 2024 09:50:17 +0000
Message-ID: <20241209095019.1732120-13-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PKEY_ALLOW_ALL is meant to represent the pkey register value that
allows all accesses (enables all pkeys). However its current naming
suggests that the value applies to *one* key only (like
PKEY_DISABLE_ACCESS for instance).

Rename PKEY_ALLOW_ALL to PKEY_REG_ALLOW_ALL to avoid such
misunderstanding. This is consistent with the PKEY_REG_ALLOW_NONE
macro introduced by commit 6e182dc9f268 ("selftests/mm: Use generic
pkey register manipulation").

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-arm64.h      | 2 +-
 tools/testing/selftests/mm/protection_keys.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index 9897e31f16dd..8e9685e03c44 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -30,7 +30,7 @@
 #define NR_PKEYS		8
 #define NR_RESERVED_PKEYS	1 /* pkey-0 */
 
-#define PKEY_ALLOW_ALL		0x77777777
+#define PKEY_REG_ALLOW_ALL	0x77777777
 #define PKEY_REG_ALLOW_NONE	0x0
 
 #define PKEY_BITS_PER_PKEY	4
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 3688571e6b39..a4683f2476f2 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -396,7 +396,7 @@ static void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	/* restore access and let the faulting instruction continue */
 	pkey_access_allow(siginfo_pkey);
 #elif defined(__aarch64__)
-	aarch64_write_signal_pkey(uctxt, PKEY_ALLOW_ALL);
+	aarch64_write_signal_pkey(uctxt, PKEY_REG_ALLOW_ALL);
 #endif /* arch */
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
@@ -842,7 +842,7 @@ void expected_pkey_fault(int pkey)
 	 */
 	if (__read_pkey_reg() != 0)
 #elif defined(__aarch64__)
-	if (__read_pkey_reg() != PKEY_ALLOW_ALL)
+	if (__read_pkey_reg() != PKEY_REG_ALLOW_ALL)
 #else
 	if (__read_pkey_reg() != shadow_pkey_reg)
 #endif /* arch */
-- 
2.47.0


