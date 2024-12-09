Return-Path: <linux-kselftest+bounces-23003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E89E8F3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A0162C25
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915E217643;
	Mon,  9 Dec 2024 09:50:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22746216E24;
	Mon,  9 Dec 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737854; cv=none; b=Lj3JvDMZAxuqwGK8/nxJap4mzGr/TENnu7NGAjsaoSrEbqxvDXzCrgGetZWMbqHSZ3vjQ/pIjZU+aip3VGDZX/G1fKcNoIifYBugnm8m90EwxpS0NWi8d7kSEakN3cYMFuRYo6ftnvHdMytSsoccWSEQ10D/JqrF8CmSa1EhjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737854; c=relaxed/simple;
	bh=No2G2MlkIqJPjup1+11Pz23i437KcGkyXnPUa6UJJWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRrYLT2S7ALjVt9y1jq76HLh8OZw/k+wvI5BT2wCfhxcngcedxSM4X90Y1Rp32LRFj9xw8BEiifL7cEIW5bWeYCaC4206lrbrhhjAkZIHzmOeulYtumqCfZgwdDavXKRrj3cYhba8w0QPSFgSzQHrODz2atok64C6403+uOmMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89FB5113E;
	Mon,  9 Dec 2024 01:51:16 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80A133F720;
	Mon,  9 Dec 2024 01:50:46 -0800 (PST)
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
Subject: [PATCH 04/14] selftests/mm: Fix -Warray-bounds warnings in pkey_sighandler_tests
Date: Mon,  9 Dec 2024 09:50:09 +0000
Message-ID: <20241209095019.1732120-5-kevin.brodsky@arm.com>
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

GCC doesn't like dereferencing a pointer set to 0x1 (when building
at -O2):

pkey_sighandler_tests.c:166:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
  166 |         *(int *) (0x1) = 1;
      |         ^~~~~~~~~~~~~~
cc1: note: source object is likely at address zero

Using NULL instead seems to make it happy. This should make no
difference in practice (SIGSEGV with SEGV_MAPERR will be the outcome
regardless), we just need to update the expected si_addr.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index c593a426341c..e7b91794f184 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -163,7 +163,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* Segfault (with SEGV_MAPERR) */
-	*(int *) (0x1) = 1;
+	*(int *)NULL = 1;
 	return NULL;
 }
 
@@ -179,7 +179,6 @@ static void *thread_segv_pkuerr_stack(void *ptr)
 static void *thread_segv_maperr_ptr(void *ptr)
 {
 	stack_t *stack = ptr;
-	int *bad = (int *)1;
 	u64 pkey_reg;
 
 	/*
@@ -195,7 +194,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
-	*bad = 1;
+	*(int *)NULL = 1;
 	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
 	return NULL;
 }
@@ -234,7 +233,7 @@ static void test_sigsegv_handler_with_pkey0_disabled(void)
 
 	ksft_test_result(siginfo.si_signo == SIGSEGV &&
 			 siginfo.si_code == SEGV_MAPERR &&
-			 siginfo.si_addr == (void *)1,
+			 siginfo.si_addr == NULL,
 			 "%s\n", __func__);
 }
 
@@ -349,7 +348,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 
 	ksft_test_result(siginfo.si_signo == SIGSEGV &&
 			 siginfo.si_code == SEGV_MAPERR &&
-			 siginfo.si_addr == (void *)1,
+			 siginfo.si_addr == NULL,
 			 "%s\n", __func__);
 }
 
-- 
2.47.0


