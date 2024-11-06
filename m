Return-Path: <linux-kselftest+bounces-21531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA49BED55
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D98F1F2505F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F091F9426;
	Wed,  6 Nov 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZbvhujQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301C1E133E
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898306; cv=none; b=ibCaoHtnaLiafuOmUuzpgr6BJRXuuxV8m5mMHO1rtgD9rfxoh1DBBnVD8aXIhc7JeXg+B3Sh4WdrkxSwzbnVYoRk0bYFc4lUUl/noCi0MJEXrixZb/Kt1MQ1EjfSTlb1MsSPoRfg2di11cp7DVCIASoS8K7+Cl2YohO7hcaenn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898306; c=relaxed/simple;
	bh=l8Q1vGCIoKfYGSDC1yH7dOX6TeIovQ3Au2Uep97oqDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1qg2G1Q7cc7bEM7qQUqrGgZNX4UD6DUWh/kDpWqIjoHpxf3mfG3eNhIuvZz6UOkrt6HZhPlv0Ni3e+uKx4umf4FJuuyM4xInwIHPYPqi03351tX6NYhMYNy1eh4PD6K9OVZoFdn4WZqI79T1l2Noiu7uHcNwL9wpAcpYHCYRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ZbvhujQB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898300;
	bh=gWi3uhGcloOwTYgGQh/KqDPknZHDL95CKVUKUmrlZBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbvhujQB4eB1WiNH7s6IozVLIgYkcsc6iL3gC5Q5EBcvgpng+ZVtGaNW0pdllbGRG
	 TLO9yIjsYUaXePmT0nEPbK6RD72GnRhVcvRxHYMNkjRQMTfKc2RE3P82xU9qVs63+P
	 eA6u/F29xflAqJkoRsQskTJHx5dVir8smRwRHAKOboAJJ0oJ0ui7kjafMvawjJ4sfF
	 rsc1aer4ol58BN1PwpKuBFEHjw9da7wsXu00LuY8cq+8OF5SR8dqupkKd3BhgudiGA
	 5iuQ1w9gtKaI+vFcnKM+Pvrz+GJk93nkLiCa5+39sKqxjfJc20Do0CEZGvAmJECiK+
	 E+01GxxokfjkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55m2JRrz4xR5;
	Thu,  7 Nov 2024 00:05:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 3/5] selftests/powerpc: Fix 32-bit BE build errors on Ubuntu 24.04
Date: Thu,  7 Nov 2024 00:04:51 +1100
Message-ID: <20241106130453.1741013-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106130453.1741013-1-mpe@ellerman.id.au>
References: <20241106130453.1741013-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Ubuntu 24.04, building the selftests with the big endian
compiler (which defaults to 32-bit) fails with errors:

  stack_expansion_ldst.c:178:37: error: format '%lx' expects argument
  of type 'long unsigned int', but argument 2 has type 'rlim_t' {aka 'long long unsigned int'}
  subpage_prot.c:214:38: error: format '%lx' expects argument of type
  'long unsigned int', but argument 3 has type 'off_t' {aka 'long long int'}

Prior to 24.04 rlim_t was long unsigned int, and off_t was long int.

Cast to unsigned long long and long long before passing to printf to
avoid the errors.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c | 2 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
index ed9143990888..9c0d343d7137 100644
--- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -175,7 +175,7 @@ static int test(void)
 
 	page_size = getpagesize();
 	getrlimit(RLIMIT_STACK, &rlimit);
-	printf("Stack rlimit is 0x%lx\n", rlimit.rlim_cur);
+	printf("Stack rlimit is 0x%llx\n", (unsigned long long)rlimit.rlim_cur);
 
 	printf("Testing loads ...\n");
 	test_one_type(LOAD, page_size, rlimit.rlim_cur);
diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
index 3ae77ba93208..8cf9fd5fed1c 100644
--- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -211,8 +211,8 @@ int test_file(void)
 		perror("failed to map file");
 		return 1;
 	}
-	printf("allocated %s for 0x%lx bytes at %p\n",
-	       file_name, filesize, fileblock);
+	printf("allocated %s for 0x%llx bytes at %p\n",
+	       file_name, (long long)filesize, fileblock);
 
 	printf("testing file map...\n");
 
-- 
2.47.0


