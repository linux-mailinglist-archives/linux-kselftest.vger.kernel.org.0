Return-Path: <linux-kselftest+bounces-9765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D178C0B01
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B0A28232A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAE514A4DB;
	Thu,  9 May 2024 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwmjA3dv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AC14A4D6;
	Thu,  9 May 2024 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232835; cv=none; b=DFUwUQO53jnHXPKea0K2hf6PhqXhLIyR/QyELkZXPmRKxMD9HTCwgpHib41PQ0z64v5wPl6IrZsB1/q/X5mLJEH4PsEB6zHYxQF1xRYHU83l1UPkdU5rRdyARAupypNUBbVsHIgcbC0/jMl8+P9cf2BB70qFPckFWK3ot79Hjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232835; c=relaxed/simple;
	bh=iv9hLnqrvv2CkI1vhuzvz8jBABYnqUjWrkoMs2uokBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXAk+G8O3o5o7aQFyCUSg48d06MIHCGssPzVxviPWYcFexZoZOkXkvW9dNITEUNxMCLoMr77fIWxrfUMRxngHD3gaYaGrgZ6RsmveCojHVdRXhCFaLbsEkPVamom9DsjO9bbf+agnYFuisvqw/T/MhtKmhH5QJVQZRHYlfyRZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwmjA3dv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715232834; x=1746768834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iv9hLnqrvv2CkI1vhuzvz8jBABYnqUjWrkoMs2uokBA=;
  b=IwmjA3dvkFwR5kvgkfZeTGuwoFKIHlk5grNOkdGDnuin/qXVGfYPb0xi
   xXiDLO2V4YCwa7ACtY22JhCifHrVwXErWN6Rl/4hf0aQ5lTgiqNMw2OLg
   iz0dsxjltZLn7uSoA7T7Dg+njLSCfmoKkK34DS2sE0eHVJOG0g28MECM5
   aXliGWqTyOyxEqtg34iE5UMgyIFiWAzqkMHjsk1ADIsAbG6uYTR7JI0iP
   /kgKCMKUqyKwtqOZzOSd1gEp6Xu8LiuocFgJXNDyuBIHmLpSbIwYL3UIl
   BbwzIG8gp9rmV7nCJBW7koEsfZcr2AFymPvThjxv4MCu1rH1/IEcUfhs+
   g==;
X-CSE-ConnectionGUID: wQJ6FXveToG9KTS5U80eXQ==
X-CSE-MsgGUID: cGqjq05UQXyfH5QsY/Jnpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11286360"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11286360"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:33:54 -0700
X-CSE-ConnectionGUID: Iq3AG2ReS+SQQHcDaHL0Nw==
X-CSE-MsgGUID: L3Zqwl26T8m2RX3F2WeaLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="66558887"
Received: from unknown (HELO st-server.bj.intel.com) ([10.240.193.102])
  by orviesa001.jf.intel.com with ESMTP; 08 May 2024 22:33:48 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Cc: akpm@linux-foundation.org,
	edliaw@google.com,
	ivan.orlov0322@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandre.belloni@bootlin.com,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tao1.su@linux.intel.com
Subject: [PATCH v2 1/2] Revert "selftests/harness: remove use of LINE_MAX"
Date: Thu,  9 May 2024 13:31:12 +0800
Message-Id: <20240509053113.43462-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509053113.43462-1-tao1.su@linux.intel.com>
References: <20240509053113.43462-1-tao1.su@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 8092162335554c8ef5e7f50eff68aa9cfbdbf865.

asprintf() is declared in stdio.h when defining _GNU_SOURCE, but stdio.h
is so common that many files don’t define _GNU_SOURCE before including
stdio.h, and defining _GNU_SOURCE after including stdio.h will no longer
take effect, which causes warnings or even errors during compilation in
many selftests.

Revert 'commit 809216233555 ("selftests/harness: remove use of LINE_MAX")'
as that came in quite late in the 6.9 cycle.

Link: https://lore.kernel.org/linux-kselftest/ZjuA3aY_iHkjP7bQ@google.com/
Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 tools/testing/selftests/kselftest_harness.h | 12 ++++--------
 tools/testing/selftests/mm/mdwe_test.c      |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d98702b6955d..ba3ddeda24bf 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -1158,7 +1159,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
-	char *test_name;
+	char test_name[LINE_MAX];
 	const char *diagnostic;
 
 	/* reset test struct */
@@ -1166,12 +1167,8 @@ void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-	if (asprintf(&test_name, "%s%s%s.%s", f->name,
-		variant->name[0] ? "." : "", variant->name, t->name) == -1) {
-		ksft_print_msg("ERROR ALLOCATING MEMORY\n");
-		t->exit_code = KSFT_FAIL;
-		_exit(t->exit_code);
-	}
+	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
+		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
 
 	ksft_print_msg(" RUN           %s ...\n", test_name);
 
@@ -1209,7 +1206,6 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_test_result_code(t->exit_code, test_name,
 			      diagnostic ? "%s" : NULL, diagnostic);
-	free(test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 1e01d3ddc11c..200bedcdc32e 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -7,7 +7,6 @@
 #include <linux/mman.h>
 #include <linux/prctl.h>
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/auxv.h>
-- 
2.34.1


