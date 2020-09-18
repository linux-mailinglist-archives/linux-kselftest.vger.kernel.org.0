Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9642526FAE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRKry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRKru (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 06:47:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C9C061788;
        Fri, 18 Sep 2020 03:47:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so4868942wmj.2;
        Fri, 18 Sep 2020 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXEWTobRs9s4LJElS8zg1xI5BJD4hPEpT7/WyMI0e3E=;
        b=tLIzLF1385PXg1qesSX6Ao/H78e7i6GpdmrAz11ynssT3DtTjFVN2OJ5aykNxkqPVD
         1wdd0ygyRWN03W9bYycXGfGflKa2zAulQT3+TFSXAr3G8XVwSgFoCNp4GtudmijXbVkQ
         vXA4XqqaH/0+v5dfDffV7dwV08iwMe8lg45Gt9hacm8RaQKM6pGKgx4dvhpyg/4IkKDn
         zT4OXsSSaMl3MSutU2MfWNZlKeuwCV/mBH4Uoum0XYJeuCWvnygWWshK1A7lJPGD4oDT
         ITsb1PYfO17ipwV6UaekjbQAg6RZHvN76urKQjGUWDok5r2yevKby5vgYefS9VHz8vGy
         XWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RXEWTobRs9s4LJElS8zg1xI5BJD4hPEpT7/WyMI0e3E=;
        b=hRO7wvBHdPENMz+ONCVoWeg8qrwnH3yR7cdLkBF2dGo/tlHhJiEfOQEnyn74F5cdjg
         wITEInsUly0uRFlWNugwBGWhY3iHrfXuepoRgNfTTGeCZnzwY5cralt3foFVtX5C7aGt
         AkmtLK9QMXbn/71zxero8rbHPmwJZ2weRzZn/C8HX7p+JndR30l7LN8slsUfdvpYSHxZ
         I30lAutPBxtTAQWfqJfGKXPMzQZDLJ7cAMf1T3VDOA7zRw84sW6BdnKpvhOVGJ8omAG2
         dqZlhzPu8+/h3Vff1UfnDXIgLuFxIACnc+Pl4lN0co5O8BfmEkHl+tNKYIDELlAqXj1F
         /GTA==
X-Gm-Message-State: AOAM5306Q6ZO/YK2XeYveDK3k5Nea5FSHtmkT89RCPus+DYQpASnZFEE
        hsu1bGJoz/Uy50ovr7E6dzI=
X-Google-Smtp-Source: ABdhPJx+JMAvI8aS57FSOrkxf9jA7gU15ImEW1d0y0N9Gei37t0QRZBKOUQzrhl5UZIy8UQvPwZ93A==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr14534401wmi.37.1600426068480;
        Fri, 18 Sep 2020 03:47:48 -0700 (PDT)
Received: from trantor.home (cpc153975-seac28-2-0-cust722.7-2.cable.virginm.net. [81.109.38.211])
        by smtp.gmail.com with ESMTPSA id h4sm5197846wrm.54.2020.09.18.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:47:48 -0700 (PDT)
From:   Boyan Karatotev <boian4o1@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boyan Karatotev <boian4o1@gmail.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 4/4] kselftests/arm64: add PAuth tests for single threaded consistency and differently initialized keys
Date:   Fri, 18 Sep 2020 11:47:15 +0100
Message-Id: <20200918104715.182310-5-boian4o1@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918104715.182310-1-boian4o1@gmail.com>
References: <20200918104715.182310-1-boian4o1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Boyan Karatotev <boyan.karatotev@arm.com>

PAuth adds 5 different keys that can be used to sign addresses.

Add a test that verifies that the kernel initializes them to different
values and preserves them across context switches.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
---
 tools/testing/selftests/arm64/pauth/pac.c | 123 ++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index b363ad6a0b50..592fe538506e 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
 
+#define _GNU_SOURCE
+
 #include <sys/auxv.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <signal.h>
 #include <setjmp.h>
+#include <sched.h>
 
 #include "../../kselftest_harness.h"
 #include "helper.h"
@@ -17,6 +20,7 @@
  * The VA space size is 48 bits. Bigger is opt-in.
  */
 #define PAC_MASK (~0xff80ffffffffffff)
+#define ARBITRARY_VALUE (0x1234)
 #define ASSERT_PAUTH_ENABLED() \
 do { \
 	unsigned long hwcaps = getauxval(AT_HWCAP); \
@@ -61,13 +65,37 @@ int n_same(struct signatures *old, struct signatures *new, int nkeys)
 	return res;
 }
 
+int n_same_single_set(struct signatures *sign, int nkeys)
+{
+	size_t vals[nkeys];
+	int same = 0;
+
+	vals[0] = sign->keyia & PAC_MASK;
+	vals[1] = sign->keyib & PAC_MASK;
+	vals[2] = sign->keyda & PAC_MASK;
+	vals[3] = sign->keydb & PAC_MASK;
+
+	if (nkeys >= 4)
+		vals[4] = sign->keyg & PAC_MASK;
+
+	for (int i = 0; i < nkeys - 1; i++) {
+		for (int j = i + 1; j < nkeys; j++) {
+			if (vals[i] == vals[j])
+				same += 1;
+		}
+	}
+	return same;
+}
+
 int exec_sign_all(struct signatures *signed_vals, size_t val)
 {
 	int new_stdin[2];
 	int new_stdout[2];
 	int status;
+	int i;
 	ssize_t ret;
 	pid_t pid;
+	cpu_set_t mask;
 
 	ret = pipe(new_stdin);
 	if (ret == -1) {
@@ -81,6 +109,20 @@ int exec_sign_all(struct signatures *signed_vals, size_t val)
 		return -1;
 	}
 
+	/*
+	 * pin this process and all its children to a single CPU, so it can also
+	 * guarantee a context switch with its child
+	 */
+	sched_getaffinity(0, sizeof(mask), &mask);
+
+	for (i = 0; i < sizeof(cpu_set_t); i++)
+		if (CPU_ISSET(i, &mask))
+			break;
+
+	CPU_ZERO(&mask);
+	CPU_SET(i, &mask);
+	sched_setaffinity(0, sizeof(mask), &mask);
+
 	pid = fork();
 	// child
 	if (pid == 0) {
@@ -205,6 +247,44 @@ TEST(pac_instructions_not_nop_generic)
 	ASSERT_NE(0, keyg)  TH_LOG("keyg instructions did nothing");
 }
 
+TEST(single_thread_different_keys)
+{
+	int same = 10;
+	int nkeys = NKEYS;
+	int tmp;
+	struct signatures signed_vals;
+	unsigned long hwcaps = getauxval(AT_HWCAP);
+
+	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
+	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
+	if (!(hwcaps & HWCAP_PACG)) {
+		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
+		nkeys = NKEYS - 1;
+	}
+
+	/*
+	 * In Linux the PAC field can be up to 7 bits wide. Even if keys are
+	 * different, there is about 5% chance for PACs to collide with
+	 * different addresses. This chance rapidly increases with fewer bits
+	 * allocated for the PAC (e.g. wider address). A comparison of the keys
+	 * directly will be more reliable.
+	 * All signed values need to be different at least once out of n
+	 * attempts to be certain that the keys are different
+	 */
+	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++) {
+		if (nkeys == NKEYS)
+			sign_all(&signed_vals, i);
+		else
+			sign_specific(&signed_vals, i);
+
+		tmp = n_same_single_set(&signed_vals, nkeys);
+		if (tmp < same)
+			same = tmp;
+	}
+
+	ASSERT_EQ(0, same) TH_LOG("%d keys clashed every time", same);
+}
+
 /*
  * fork() does not change keys. Only exec() does so call a worker program.
  * Its only job is to sign a value and report back the resutls
@@ -242,4 +322,47 @@ TEST(exec_changed_keys)
 	ASSERT_EQ(0, same) TH_LOG("exec() did not change %d keys", same);
 }
 
+TEST(context_switch_keep_keys)
+{
+	int ret;
+	struct signatures trash;
+	struct signatures before;
+	struct signatures after;
+
+	ASSERT_PAUTH_ENABLED();
+
+	sign_specific(&before, ARBITRARY_VALUE);
+
+	/* will context switch with a process with different keys at least once */
+	ret = exec_sign_all(&trash, ARBITRARY_VALUE);
+	ASSERT_EQ(0, ret) TH_LOG("failed to run worker");
+
+	sign_specific(&after, ARBITRARY_VALUE);
+
+	ASSERT_EQ(before.keyia, after.keyia) TH_LOG("keyia changed after context switching");
+	ASSERT_EQ(before.keyib, after.keyib) TH_LOG("keyib changed after context switching");
+	ASSERT_EQ(before.keyda, after.keyda) TH_LOG("keyda changed after context switching");
+	ASSERT_EQ(before.keydb, after.keydb) TH_LOG("keydb changed after context switching");
+}
+
+TEST(context_switch_keep_keys_generic)
+{
+	int ret;
+	struct signatures trash;
+	size_t before;
+	size_t after;
+
+	ASSERT_GENERIC_PAUTH_ENABLED();
+
+	before = keyg_sign(ARBITRARY_VALUE);
+
+	/* will context switch with a process with different keys at least once */
+	ret = exec_sign_all(&trash, ARBITRARY_VALUE);
+	ASSERT_EQ(0, ret) TH_LOG("failed to run worker");
+
+	after = keyg_sign(ARBITRARY_VALUE);
+
+	ASSERT_EQ(before, after) TH_LOG("keyg changed after context switching");
+}
+
 TEST_HARNESS_MAIN
-- 
2.28.0

