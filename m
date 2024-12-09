Return-Path: <linux-kselftest+bounces-23012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A288E9E8F53
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5921883684
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F075219E9D;
	Mon,  9 Dec 2024 09:51:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926E219E91;
	Mon,  9 Dec 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737873; cv=none; b=AqQzFk9E0MM/8hToJJJRy63HBhOhfH3EPCF5a8m6D9F4y12Kag48yAnJK91+Xl8M+wwljqEMC+0uH7oUbAqJTp8TxzX9g1MC9TKhg31OZoqojEZrpE26c8OKzcfb/9JsHnTVWNq+ycFNizAI81RLCCEMu0uzmzr921/fJ3oIj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737873; c=relaxed/simple;
	bh=MvhezTTxFbJK29hWXRfef53TZk3il/zUElkvvYWqRvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEej7R51U5pUt5pS2FmCVKcE87PklrgOAOf/IledOm4aq8lC0z3n8rBy2u43hubD1A7AADJD4VT2L3bSslJ/n9vUymislTOy0xPcjIvLzfh3oW2ENXmjA8Wz7ZTdbHSeXMVYLSnzUu/QNKMUlEpno2s8oxqr79rFJSSrQMGi1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84549113E;
	Mon,  9 Dec 2024 01:51:39 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ADDE3F720;
	Mon,  9 Dec 2024 01:51:09 -0800 (PST)
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
Subject: [PATCH 14/14] selftests/mm: Remove X permission from sigaltstack mapping
Date: Mon,  9 Dec 2024 09:50:19 +0000
Message-ID: <20241209095019.1732120-15-kevin.brodsky@arm.com>
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

There is no reason why the alternate signal stack should be mapped
as RWX. Map it as RW instead.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 449ec5acec75..17bbfcd552c6 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -315,7 +315,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
-	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
 			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	sigstack.ss_flags = 0;
 	sigstack.ss_size = STACK_SIZE;
@@ -488,7 +488,7 @@ static void test_pkru_sigreturn(void)
 	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
-	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
 			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	sigstack.ss_flags = 0;
 	sigstack.ss_size = STACK_SIZE;
-- 
2.47.0


