Return-Path: <linux-kselftest+bounces-39332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C19B2CD20
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 21:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC05E68825B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71233EAEE;
	Tue, 19 Aug 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbmM1DJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B92FC869;
	Tue, 19 Aug 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632549; cv=none; b=A8adkh+2xLfflCfxyaciImgB/5KBQgzUdPJe05h1AvTE0b4azRtm8kcVRFlXZz66XM/H9N3Wz0HItMBcgGNbLAvVlwGaCNADEblRKmIs/1G/H6N9av5TQCZsr28lX5G84Fob/mXKjIJVS7yyjfJvJnm/1pGgofpu9uiOArP27wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632549; c=relaxed/simple;
	bh=nwxVrMin6dMeS4ij7lzF0cTgvHCl/I1m58fZGnw+Yj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtX+rJve8giLrkdYkxj08k/T37lOM7opXWzHH1Hhbl4EMMqmOcBznkMAe393ZYkOFwb6Qoa75KVDb14VCw8RzR05NILwfqEqSIGd+ull5oHxyAckFQPDjHyAKnE4WJtMq3ZV6sMcRUB2Q2IOwwdCG9BE0KWDwL5feTgvwHEIgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbmM1DJx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f53d2eso69598125ad.0;
        Tue, 19 Aug 2025 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755632546; x=1756237346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KC1lPRoxnUf8he3rHIw15pXCrh6Vl/3lxM5oAryxK0M=;
        b=fbmM1DJxNgJP0byWWO3JLLEsSf0wubI/UEO71RTjoFzXgv1nH9YpQUFMZlgrBVAJsj
         xzIU4bcWJQUgoiGRottajY4/gvvVyYQyJ8zjSMVRsg+34qUefyrB5exAQTsKkDAWzrtb
         FVCIhan570AfzAs+1Cvy0jeXHogLH/1FagRGgWo8MwhPik/EomrNgKJ/d+COCd00DzFO
         F7oVRakVumZh5xej0GWtWHUxc08JJ3xwDjTxqJOsXsAl5Kb3Qq3sXVj9M/DDicWnzSlx
         2M8xMvqu8Mx7/jzSb1+0tppedYQBTbIgSXNUrqxWYGkkVRsD29MthHrhKow9d2ZDYg8C
         +pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632546; x=1756237346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC1lPRoxnUf8he3rHIw15pXCrh6Vl/3lxM5oAryxK0M=;
        b=Ucy5stiFshTbSlyv+/KEsap2foa6H7XSr0nIT1Gd0bb/HvDDOtXwDRoz8OvGgRr4fV
         QS65qOzdC030LnQbnpuYmmV0EZ/Xu78xLKB1MJdPWHzKX/t7b+AVYIA1sWBIVqEVvrI/
         M7T/hvX9Q0ZhhNKLsDBf11QmjuvyNOSiHUlwR9Tziqwk4SQeH2sK2cIENL4suR4yHS4T
         wz5KWae1WzuJZSLif6CWg1ycUv2q+3UwbVOjrNgJ9WQVmTKJXbmrEMblmv3JFbhq1tbR
         IN5WXQPEV3ZxnPuaBsWrOcIb0ZJhRdtXkY8MhEiaxhfaim2swbTTCoOpMgnBwRzVtc4L
         ywbw==
X-Forwarded-Encrypted: i=1; AJvYcCUcOJ5rB4BbsCwjh8nXsoieoVMDEwYUqKzp/0RD/VS6gbvPHjYKXw3hoBv7Aom6oTRruYMZt+cm6SIaKLu72OHR@vger.kernel.org, AJvYcCUvUzLK1BJ9yfYBW7ru2vnG+9SqmKPMgek+s6Zc9lWumi8+7pWgXhYb/CVvoS5JpzsdaP1jE0AMSlJRZBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzahsrtu9dmX+X7OBgtuP2wrNgo89agiU8uS4RR1R75J3gARNWz
	5hl7i0cx/ETwmWZYpE7LKipEATCaKfPxSsu06i+KCbc1OyKPkZEYMJM=
X-Gm-Gg: ASbGncv9317kHKzFGWCU9uxC63dWfhziDM94grZinb8KhoAQsDPIwRyx07/OWehexda
	FSYg5lFGSTuySW81LaLzqMqa+Cw00Z4EPe/ZIWd55Qfgiv/A6vQGHvjsI3Sr7Qwx8T0rBW/14/k
	qRPW1A+rLn45TZbyjYLzvejPLvM9kBF9KG7RevB4mQiLJqHjr2OCIGexu3e0NDaAwD6gRM0dwUq
	nzUS/zfirXxn+Xc2KExztZmi0oWcQn0/vHQ8sxs8BVgRCestcr9XfQU2Tlb4+4w0ZoJZ6mhUIdQ
	P+mFNL8AA+p8EgxhlNUxn0nX1Z8BQDHxDLFdCUNchfukzY0IIefublU0r7zTrsNUIXw7xp+Dz9A
	rCtSOvo+6K4hFa1XUWik5SqTomklJqpSubJZM18tQ
X-Google-Smtp-Source: AGHT+IGCwHuMKnC2F+kRNktEzaNRZOFIgsNY5rNEqJHRhPed8ECAY+eNTmxnKQACTnzUjLTz51XsiQ==
X-Received: by 2002:a17:902:f706:b0:240:50c9:7f26 with SMTP id d9443c01a7336-245ef124acbmr2327065ad.13.1755632545817;
        Tue, 19 Aug 2025 12:42:25 -0700 (PDT)
Received: from kerneldocs.. ([157.51.109.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8b227652sm913127b3a.91.2025.08.19.12.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:42:25 -0700 (PDT)
From: Nikil Paul S <snikilpaul@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org,
	mpe@ellerman.id.au,
	maddy@linux.ibm.com
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com,
	ritesh.list@gmail.com,
	catalin.marinas@arm.com,
	yury.khrustalev@arm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-mentees@lists.linuxfoundation.org,
	Nikil Paul S <snikilpaul@gmail.com>
Subject: [PATCH] selftests/powerpc: fix spelling errors across test sources
Date: Tue, 19 Aug 2025 19:42:08 +0000
Message-ID: <20250819194207.6239-2-snikilpaul@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a number of minor spelling mistakes in selftests/powerpc sources,
including ptrace, tm, pmu, math, alignment, and gzip tests. These
changes improve readability of test messages and comments without
affecting functionality as only comments were edited.

Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
---
 .../selftests/powerpc/alignment/alignment_handler.c       | 4 ++--
 tools/testing/selftests/powerpc/math/vmx_preempt.c        | 2 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S            | 2 +-
 tools/testing/selftests/powerpc/math/vsx_preempt.c        | 2 +-
 tools/testing/selftests/powerpc/nx-gzip/gunz_test.c       | 2 +-
 .../pmu/event_code_tests/group_constraint_cache_test.c    | 4 ++--
 .../pmu/event_code_tests/group_constraint_l2l3_sel_test.c | 6 +++---
 .../group_constraint_radix_scope_qual_test.c              | 4 ++--
 .../event_code_tests/group_constraint_thresh_cmp_test.c   | 8 ++++----
 .../event_code_tests/group_constraint_thresh_ctl_test.c   | 4 ++--
 .../event_code_tests/group_constraint_thresh_sel_test.c   | 4 ++--
 .../pmu/event_code_tests/group_constraint_unit_test.c     | 8 ++++----
 tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c | 4 ++--
 .../powerpc/pmu/sampling_tests/mmcra_bhrb_cond_test.c     | 2 +-
 .../sampling_tests/mmcra_bhrb_disable_no_branch_test.c    | 2 +-
 .../powerpc/pmu/sampling_tests/mmcra_bhrb_disable_test.c  | 2 +-
 .../powerpc/pmu/sampling_tests/mmcra_bhrb_ind_call_test.c | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c      | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c   | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c      | 4 ++--
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c         | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c               | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c             | 2 +-
 tools/testing/selftests/powerpc/tm/tm-trap.c              | 4 ++--
 24 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 33ee34fc0828..abd9267bc68c 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -10,7 +10,7 @@
  *
  * We create two sets of source and destination buffers, one in regular memory,
  * the other cache-inhibited (by default we use /dev/fb0 for this, but an
- * alterative path for cache-inhibited memory may be provided, e.g. memtrace).
+ * alternative path for cache-inhibited memory may be provided, e.g. memtrace).
  *
  * We initialise the source buffers, then use whichever set of load/store
  * instructions is under test to copy bytes from the source buffers to the
@@ -215,7 +215,7 @@ int test_memcmp(void *s1, void *s2, int n, int offset, char *test_name)
 }
 
 /*
- * Do two memcpy tests using the same instructions. One cachable
+ * Do two memcpy tests using the same instructions. One cacheable
  * memory and the other doesn't.
  */
 int do_test(char *test_name, void (*test_func)(char *, char *))
diff --git a/tools/testing/selftests/powerpc/math/vmx_preempt.c b/tools/testing/selftests/powerpc/math/vmx_preempt.c
index 6f7cf400c687..475060728d5e 100644
--- a/tools/testing/selftests/powerpc/math/vmx_preempt.c
+++ b/tools/testing/selftests/powerpc/math/vmx_preempt.c
@@ -74,7 +74,7 @@ int test_preempt_vmx(void)
 	}
 
 	setbuf(stdout, NULL);
-	/* Not really nessesary but nice to wait for every thread to start */
+	/* Not really necessary but nice to wait for every thread to start */
 	printf("\tWaiting for all workers to start...");
 	while(threads_starting)
 		asm volatile("": : :"memory");
diff --git a/tools/testing/selftests/powerpc/math/vsx_asm.S b/tools/testing/selftests/powerpc/math/vsx_asm.S
index ffc165d984cc..7b10c26d6336 100644
--- a/tools/testing/selftests/powerpc/math/vsx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vsx_asm.S
@@ -7,7 +7,7 @@
 #include "vsx_asm.h"
 
 #long check_vsx(vector int *r3);
-#This function wraps storeing VSX regs to the end of an array and a
+#This function wraps storing VSX regs to the end of an array and a
 #call to a comparison function in C which boils down to a memcmp()
 FUNC_START(check_vsx)
 	PUSH_BASIC_STACK(32)
diff --git a/tools/testing/selftests/powerpc/math/vsx_preempt.c b/tools/testing/selftests/powerpc/math/vsx_preempt.c
index d1601bb889d4..d432ae095572 100644
--- a/tools/testing/selftests/powerpc/math/vsx_preempt.c
+++ b/tools/testing/selftests/powerpc/math/vsx_preempt.c
@@ -106,7 +106,7 @@ int test_preempt_vsx(void)
 	}
 
 	setbuf(stdout, NULL);
-	/* Not really nessesary but nice to wait for every thread to start */
+	/* Not really necessary but nice to wait for every thread to start */
 	printf("\tWaiting for %d workers to start...", threads_starting);
 	while(threads_starting)
 		asm volatile("": : :"memory");
diff --git a/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c b/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
index 7c23d3dd7d6d..5fbb240c5cda 100644
--- a/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
+++ b/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
@@ -102,7 +102,7 @@ const int window_max = 1<<15;
  * the indirect (base) dde that points to a list of direct ddes.
  * See Section 6.4 of the NX-gzip user manual for DDE description.
  * Addr=NULL, len=0 clears the ddl[0].  Returns the total number of
- * bytes in ddl.  Caller is responsible for allocting the array of
+ * bytes in ddl.  Caller is responsible for allocating the array of
  * nx_dde_t *ddl.  If N addresses are required in the scatter-gather
  * list, the ddl array must have N+1 entries minimum.
  */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_cache_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_cache_test.c
index f4be05aa3a3d..855dca7334da 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_cache_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_cache_test.c
@@ -31,7 +31,7 @@ static int group_constraint_cache(void)
 	/* Check for platform support for the test */
 	SKIP_IF(platform_check_for_tests());
 
-	/* Init the events for the group contraint check for l1 cache select bits */
+	/* Init the events for the group constraint check for l1 cache select bits */
 	event_init(&leader, EventCode_1);
 	FAIL_IF(event_open(&leader));
 
@@ -42,7 +42,7 @@ static int group_constraint_cache(void)
 
 	event_close(&event);
 
-	/* Init the event for the group contraint l1 cache select test */
+	/* Init the event for the group constraint l1 cache select test */
 	event_init(&event, EventCode_3);
 
 	/* Expected to succeed as sibling event request same l1 cache select bits as leader */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_l2l3_sel_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_l2l3_sel_test.c
index e3c7a0c071e2..9de991d7a767 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_l2l3_sel_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_l2l3_sel_test.c
@@ -30,12 +30,12 @@ static int group_constraint_l2l3_sel(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is only aplicable on ISA v3.1
+	 * This test is only applicable on ISA v3.1
 	 */
 	SKIP_IF(platform_check_for_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
-	/* Init the events for the group contraint check for l2l3_sel bits */
+	/* Init the events for the group constraint check for l2l3_sel bits */
 	event_init(&leader, EventCode_1);
 	FAIL_IF(event_open(&leader));
 
@@ -46,7 +46,7 @@ static int group_constraint_l2l3_sel(void)
 
 	event_close(&event);
 
-	/* Init the event for the group contraint l2l3_sel test */
+	/* Init the event for the group constraint l2l3_sel test */
 	event_init(&event, EventCode_3);
 
 	/* Expected to succeed as sibling event request same l2l3_sel bits as leader */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_radix_scope_qual_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_radix_scope_qual_test.c
index 9233175787cc..e354129cd7fb 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_radix_scope_qual_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_radix_scope_qual_test.c
@@ -26,12 +26,12 @@ static int group_constraint_radix_scope_qual(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is aplicable on ISA v3.1 only.
+	 * This test is applicable on ISA v3.1 only.
 	 */
 	SKIP_IF(platform_check_for_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
-	/* Init the events for the group contraint check for radix_scope_qual bits */
+	/* Init the events for the group constraint check for radix_scope_qual bits */
 	event_init(&leader, EventCode_1);
 	FAIL_IF(event_open(&leader));
 
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_cmp_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_cmp_test.c
index 4b69e7214c0b..433fa9982c8c 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_cmp_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_cmp_test.c
@@ -37,7 +37,7 @@ static int group_constraint_thresh_cmp(void)
 	SKIP_IF(platform_check_for_tests());
 
 	if (have_hwcap2(PPC_FEATURE2_ARCH_3_1)) {
-		/* Init the events for the group contraint check for thresh_cmp bits */
+		/* Init the events for the group constraint check for thresh_cmp bits */
 		event_init(&leader, p10_EventCode_1);
 
 		/* Add the thresh_cmp value for leader in config1 */
@@ -54,7 +54,7 @@ static int group_constraint_thresh_cmp(void)
 
 		event_close(&event);
 
-		/* Init the event for the group contraint thresh compare test */
+		/* Init the event for the group constraint thresh compare test */
 		event_init(&event, p10_EventCode_2);
 
 		/* Add the same thresh_cmp value for leader and sibling event in config1 */
@@ -66,7 +66,7 @@ static int group_constraint_thresh_cmp(void)
 		event_close(&leader);
 		event_close(&event);
 	} else {
-		/* Init the events for the group contraint check for thresh_cmp bits */
+		/* Init the events for the group constraint check for thresh_cmp bits */
 		event_init(&leader, p9_EventCode_1);
 		FAIL_IF(event_open(&leader));
 
@@ -77,7 +77,7 @@ static int group_constraint_thresh_cmp(void)
 
 		event_close(&event);
 
-		/* Init the event for the group contraint thresh compare test */
+		/* Init the event for the group constraint thresh compare test */
 		event_init(&event, p9_EventCode_3);
 
 		/* Expected to succeed as sibling and leader event request same thresh_cmp bits */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_ctl_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_ctl_test.c
index e0852ebc1671..7e7206eefcfd 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_ctl_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_ctl_test.c
@@ -35,7 +35,7 @@ static int group_constraint_thresh_ctl(void)
 	/* Check for platform support for the test */
 	SKIP_IF(platform_check_for_tests());
 
-	/* Init the events for the group contraint thresh control test */
+	/* Init the events for the group constraint thresh control test */
 	event_init(&leader, EventCode_1);
 	FAIL_IF(event_open(&leader));
 
@@ -46,7 +46,7 @@ static int group_constraint_thresh_ctl(void)
 
 	event_close(&event);
 
-	/* Init the event for the group contraint thresh control test */
+	/* Init the event for the group constraint thresh control test */
 	event_init(&event, EventCode_3);
 
 	 /* Expected to succeed as sibling and leader event request same thresh_ctl bits */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_sel_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_sel_test.c
index 50a8cd843ce7..1b1336c1ddb1 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_sel_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_thresh_sel_test.c
@@ -34,7 +34,7 @@ static int group_constraint_thresh_sel(void)
 	/* Check for platform support for the test */
 	SKIP_IF(platform_check_for_tests());
 
-	/* Init the events for the group contraint thresh select test */
+	/* Init the events for the group constraint thresh select test */
 	event_init(&leader, EventCode_1);
 	FAIL_IF(event_open(&leader));
 
@@ -45,7 +45,7 @@ static int group_constraint_thresh_sel(void)
 
 	event_close(&event);
 
-	/* Init the event for the group contraint thresh select test */
+	/* Init the event for the group constraint thresh select test */
 	event_init(&event, EventCode_3);
 
 	 /* Expected to succeed as sibling and leader event request same thresh_sel bits */
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_unit_test.c b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_unit_test.c
index a2c18923dcec..86684331f2bc 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_unit_test.c
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/group_constraint_unit_test.c
@@ -21,7 +21,7 @@
  * Testcase for group constraint check of unit and pmc bits which is
  * used to program corresponding unit and pmc field in Monitor Mode
  * Control Register 1 (MMCR1)
- * One of the event in the group should use PMC 4 incase units field
+ * One of the event in the group should use PMC 4 in case units field
  * value is within 6 to 9 otherwise event_open for the group will fail.
  */
 static int group_constraint_unit(void)
@@ -37,21 +37,21 @@ static int group_constraint_unit(void)
 	SKIP_IF(platform_check_for_tests());
 	SKIP_IF(have_hwcap2(PPC_FEATURE2_ARCH_3_1));
 
-	/* Init the events for the group contraint check for unit bits */
+	/* Init the events for the group constraint check for unit bits */
 	e = &events[0];
 	event_init(e, EventCode_1);
 
 	 /* Expected to fail as PMC 4 is not used with unit field value 6 to 9 */
 	FAIL_IF(!event_open(&events[0]));
 
-	/* Init the events for the group contraint check for unit bits */
+	/* Init the events for the group constraint check for unit bits */
 	e = &events[1];
 	event_init(e, EventCode_2);
 
 	/* Expected to pass as PMC 4 is used with unit field value 6 to 9 */
 	FAIL_IF(event_open(&events[1]));
 
-	/* Init the event for the group contraint unit test */
+	/* Init the event for the group constraint unit test */
 	e = &events[2];
 	event_init(e, EventCode_3);
 
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
index 8a538b6182a1..7ec35566790a 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
@@ -466,7 +466,7 @@ int get_thresh_cmp_val(struct event event)
 		return value;
 
 	/*
-	 * Incase of P10, thresh_cmp value is not part of raw event code
+	 * In case of P10, thresh_cmp value is not part of raw event code
 	 * and provided via attr.config1 parameter. To program threshold in MMCRA,
 	 * take a 18 bit number N and shift right 2 places and increment
 	 * the exponent E by 1 until the upper 10 bits of N are zero.
@@ -498,7 +498,7 @@ int get_thresh_cmp_val(struct event event)
  * by comparing base_platform value from auxv and real
  * PVR value.
  * auxv_base_platform() func gives information of "base platform"
- * corresponding to PVR value. Incase, if the distro doesn't
+ * corresponding to PVR value. In case, if the distro doesn't
  * support platform PVR (missing cputable support), base platform
  * in auxv will have a default value other than the real PVR's.
  * In this case, ISAv3 PMU (generic compat PMU) will be registered
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_cond_test.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_cond_test.c
index 809de8d58b3b..696f4285af3e 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_cond_test.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_cond_test.c
@@ -29,7 +29,7 @@ static int mmcra_bhrb_cond_test(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is only aplicable on ISA v3.1
+	 * This test is only applicable on ISA v3.1
 	 */
 	SKIP_IF(check_pvr_for_sampling_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_no_branch_test.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_no_branch_test.c
index fa0dc15f9123..6ed293d18a34 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_no_branch_test.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_no_branch_test.c
@@ -26,7 +26,7 @@ static int mmcra_bhrb_disable_no_branch_test(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is only aplicable on ISA v3.1
+	 * This test is only applicable on ISA v3.1
 	 */
 	SKIP_IF(check_pvr_for_sampling_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_test.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_test.c
index bc3161ab003d..858e37705275 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_test.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_disable_test.c
@@ -26,7 +26,7 @@ static int mmcra_bhrb_disable_test(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is only aplicable on ISA v3.1
+	 * This test is only applicable on ISA v3.1
 	 */
 	SKIP_IF(check_pvr_for_sampling_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_ind_call_test.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_ind_call_test.c
index fd6c9f12212c..6ae3edfedd51 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_ind_call_test.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_bhrb_ind_call_test.c
@@ -29,7 +29,7 @@ static int mmcra_bhrb_ind_call_test(void)
 
 	/*
 	 * Check for platform support for the test.
-	 * This test is only aplicable on ISA v3.1
+	 * This test is only applicable on ISA v3.1
 	 */
 	SKIP_IF(check_pvr_for_sampling_tests());
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index 10f63042cf91..102d3f8b215f 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -73,7 +73,7 @@ static int child(struct shared_info *info)
 	info->amr2 |= 3ul << pkeyshift(pkey2);
 	/*
 	 * invalid amr value where we try to force write
-	 * things which are deined by a uamor setting.
+	 * things which are denied by a uamor setting.
 	 */
 	info->invalid_amr = info->amr2 | (~0x0UL & ~info->expected_uamor);
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
index 4a61e9bd12b4..8aee18819603 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -42,7 +42,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
 #else
 	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
 #endif
-	/* Should segv on return becuase of invalid context */
+	/* Should segv on return because of invalid context */
 	segv_expected = 1;
 }
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index 68807aac8dd3..e793b5d97c48 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2015, Michael Neuling, IBM Corp.
  *
- * Test the kernel's signal delievery code to ensure that we don't
+ * Test the kernel's signal delivery code to ensure that we don't
  * trelaim twice in the kernel signal delivery code.  This can happen
  * if we trigger a signal when in a transaction and the stack pointer
  * is bogus.
@@ -52,7 +52,7 @@ int tm_signal_stack()
 
 	/*
 	 * The flow here is:
-	 * 1) register a signal handler (so signal delievery occurs)
+	 * 1) register a signal handler (so signal delivery occurs)
 	 * 2) make stack pointer (r1) = NULL
 	 * 3) start transaction
 	 * 4) cause segv
diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
index ffe4e5515f33..4dfb25409393 100644
--- a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
+++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
@@ -5,7 +5,7 @@
  *
  * Test the kernel's signal returning code to check reclaim is done if the
  * sigreturn() is called while in a transaction (suspended since active is
- * already dropped trough the system call path).
+ * already dropped through the system call path).
  *
  * The kernel must discard the transaction when entering sigreturn, since
  * restoring the potential TM SPRS from the signal frame is requiring to not be
diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index f2a9137f3c1e..ea420caa3961 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -50,7 +50,7 @@ int test_tar(void)
 			"bne	2b;"
 			"tend.;"
 
-			/* Transaction sucess! TAR should be 3 */
+			/* Transaction success! TAR should be 3 */
 			"mfspr  7, %[tar];"
 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
 			"b	4f;"
diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
index dd5ddffa28b7..e2c3ae7c9035 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -9,7 +9,7 @@
  * - TFIAR  - stores address of location of transaction failure
  * - TFHAR  - stores address of software failure handler (if transaction
  *   fails)
- * - TEXASR - lots of info about the transacion(s)
+ * - TEXASR - lots of info about the transaction(s)
  *
  * (1) create more threads than cpus
  * (2) in each thread:
diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
index 97cb74768e30..f9bf45446320 100644
--- a/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -91,9 +91,9 @@ void trap_signal_handler(int signo, siginfo_t *si, void *uc)
 			 * LE endianness does in effect nothing, instruction (2)
 			 * is then executed again as 'trap', generating a second
 			 * trap event (note that in that case 'trap' is caught
-			 * not in transacional mode). On te other hand, if after
+			 * not in transactional mode). On te other hand, if after
 			 * the return from the signal handler the endianness in-
-			 * advertently flipped, instruction (1) is tread as a
+			 * advertently flipped, instruction (1) is thread as a
 			 * branch instruction, i.e. b .+8, hence instruction (3)
 			 * and (4) are executed (tbegin.; trap;) and we get sim-
 			 * ilaly on the trap signal handler, but now in TM mode.
-- 
2.43.0


