Return-Path: <linux-kselftest+bounces-33246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA0ABA936
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D54C1BA1FBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B335979;
	Sat, 17 May 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm3i2igQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B9F4FA
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747475135; cv=none; b=taIRTN4oiGH5ZY8CirabVQzxs78AxYOZ5ayaRckdd+OwoYxOidUquH5q2s5TNxeTs7qVsELwIpJhqFugX0Mf9NG2NAkKFnCEuL1CV7UmHXqGxrhVr13cmhZRScDUjR720Geyd3jUZsFb+uiYKK90uxFVENXTC374ZdBxMQU2vp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747475135; c=relaxed/simple;
	bh=F2H4cmNO1G6NDEz6j6GjaFPNnRZ/KvLHDsdVMLlUvS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy3y1Z3K37gzJIoON6eA7XOTUa5MO/u0jOAT/u8SYwK/OKVmMsuNPMf4YioaeDcwEqV+2dY7Svc+aTrN/GyB6GCFKs2EDYH7fHiV2nMJAullAlfXnpwDKMeT9t6ZWvhBi4+rNtl0Nu8MR9VvKtoAqQ93902frGj7PRKW10IHrO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm3i2igQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231f6af929eso11237395ad.2
        for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747475132; x=1748079932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKaxa9zrcjxu61M8qyfHfOJtZJc52H9FM/hZLnxhkYQ=;
        b=gm3i2igQXSwEoMxwNGqd18Unq54I9DK6NnNR9WpF5ka9tdsvsRMsW8wzUXHXdiMa29
         hqp+XnMaS06LUyb5PBK035B+0n9kVdayulRhxqoK6aQFipFL93hbQVbW8x47NmYzOs/x
         9VovxIlrF+Bhb47iawKbX4DRbknx5e+qjkCKaqc64iO5Yin9KQvZB5pYWsHsthGb44d7
         F1zmhDYIYKT3qDr1NhYkzjFfiaeUzpb68rI5/xQtFc9qezX+5BhuhTxgW4YIzWS4ALTu
         m3hoos9ekpUcvIEREDNnwyAAe3NqXAm+MISBRoHt8S8ruppbNynqa/ZzpVaW/P3R1zad
         /+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747475132; x=1748079932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKaxa9zrcjxu61M8qyfHfOJtZJc52H9FM/hZLnxhkYQ=;
        b=nm9UVV5lVeD23KVWLqPlFZzENDirQM82ceg2b9tZpXSwnDw7gd5Wv1XdgCGkogRk9M
         MRySq90laDqUUkddHMercUkZOipZdbwYT28ba5h2mU0V/XHEUkEwvPSwftcLlOXh/Ony
         nODRSPkZUOrrG9GcoG0XEWYL49qpX5k3lc3cAAFd7vVxovECERT9XuMsNwFsxcl5eJEE
         1++JM1KOlTq8YRdSZl++2HMKLgzIOv+mA+0r/LovewnkisTTfO1kEnAOx/F2tANscono
         uWlzaYPzf1aAMGNiSrrFvBlEGthEO546rQ5/oPajYIIWqWtvh3D2fIVYo5922U5jynlu
         qKZg==
X-Gm-Message-State: AOJu0Ywt+eM6Ay5gM64wExfPCtvGLcLvxkaGuzlVY4njyd+3vt582NX0
	mV0TsMZNd/ovpW4+9OoF2w9MrJzVIQiDwTPeXEN7b+cpEAVlUDYHeynv
X-Gm-Gg: ASbGncvz8HSoYlaeq3UQRK1Mo0NK007V/Bh3x3c2qZTA9l8IiHCGziWg+xyeDH3V1P1
	ySI/3/ck+UxLjV49aE31LPFcku6yPW4/FXdlN/CYUPYNxepeOHsKq3gRaRKJNL2qOynE85SHcpt
	wN8tr9RekYwE6pMZHd73iEDmluZ5n0biU48BOihq9bGsVxSAoTvaLjql1L1FU3Zt5+WNZZbpzfE
	cu6Fb93HVp9DJYaRRCsiWH6Ai09juMbzxMCD8WpYCEyjRlGpFHWkp6rs1yRRoH8bcZqfs3eVU0g
	12tzE1ZeJkw0E6ck9aJ4G3TLFdXFT7Ezt48e9PK0RLE5cecxNGFnqI/sMoKwn2oWDMeJc4kAOC9
	HP+ziHg==
X-Google-Smtp-Source: AGHT+IE7ZPL9NDJfyYk5lPnbfYy2d3egD7ZUBC1Vx6I6x3Fp9oTiYlLqPeH88coL4ocqSa5oXLRQhw==
X-Received: by 2002:a17:903:17cb:b0:229:1cef:4c83 with SMTP id d9443c01a7336-231d438b415mr92580075ad.4.1747475132472;
        Sat, 17 May 2025 02:45:32 -0700 (PDT)
Received: from ak-workspace.tail730999.ts.net ([2406:7400:63:a412:9ce1:c852:2f5a:2714])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5b06sm27377945ad.247.2025.05.17.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 02:45:32 -0700 (PDT)
From: Akshaykumar Gunari <akshaygunari@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	akshaygunari@gmail.com
Subject: [PATCH] selftests: powerpc: Fix spelling and grammar in PMU test files
Date: Sat, 17 May 2025 15:15:25 +0530
Message-ID: <20250517094525.20041-1-akshaygunari@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected multiple spelling and grammar issues in the under powerpc PMU
selftests:

- Corrected 'aplicable' -> 'applicable'.
- Corrected 'contraint' -> 'constraint'.
- Corrected 'Incase' -> 'In Case'.

These changes improve documentation quality and maintain code readability.

Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
---
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
 12 files changed, 25 insertions(+), 25 deletions(-)

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
-- 
2.43.0


