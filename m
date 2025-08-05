Return-Path: <linux-kselftest+bounces-38265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B35B1ACC0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 05:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10FB7A5CB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 03:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ADC1F0984;
	Tue,  5 Aug 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/mUcFmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF071E8322
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754364608; cv=none; b=d3ISlgfHjJVBL5ZszGZW1SpDiBU4r2L4eS15DC9xcU/ny95VRNg8AK814F8NFUPLwkLkdWB4DPhJG9gr/Ruc8vJOx7V+MZh5YbmIhqoVnktyz7pt9uUL4F11IVmCcvzE6zs4V6IOOCIp+SzAOZqFT4eGUvQr8xNeLDHBzpBwtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754364608; c=relaxed/simple;
	bh=ysWe7TnoOFnH8lxx33hmcXOlweoL+Bbh0q78mUcHxng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E35JMd6vDemmHwh9+dMNWKUhkDGaN0MVhkGzr7A+jcffrV46eJhTG9gBQZngranCJP2yd9Mr6ozrX4um+Upf9zFeYh8keMgtxIwq08CBiSSFGzoZdwuhGn3wgkrLmcMQbNZP2suKU4r4L63frbKEAS8BTFJuk1R2HiwkhVhfH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/mUcFmC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24283069a1cso11040455ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 20:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754364606; x=1754969406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DExi0VtMWJacoQVv1mFzUvUcPh2EilKcKwfkrYmyue0=;
        b=l/mUcFmCWoKXD2OoJfa+sO4CdV2TjeJm5QBWSLlzOoCeeHECMJUPdP4MZRpyvIRvJ0
         3Vhp3GccZ4u6FuxtbF18nJtyBDr+qMvFTPpumtoM7MI+KOaSQDhEkijFnMugzp11oKxF
         2wmt6cFjNpeKsCRYERtMWLL9isijT6n3F0JPFL/vk4L9GzdQJTq3ddeP0ytqJl2AVJrd
         6xVKVjAmOxRsKjBLrC2zS/WKiLeAbKE5PRX1VhRblIdqDkguTDdT9g9VBm5sp+zqprPo
         Pb1Nhm0pdXKcEwHTq8mg5DKk/hT267rhV2FD7gqGBxN0QbokDwNYblgUytilrbMSnXs6
         yTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754364606; x=1754969406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DExi0VtMWJacoQVv1mFzUvUcPh2EilKcKwfkrYmyue0=;
        b=pwBiOcHiVFIXzlo6/Y3QxKc6m9BZBEPCdqRU9VjPCMBzyly+KIeTg5kofc2xAXnkVR
         JIdElSnlaiG1u8KwcJuWcbl4xWMDubNjD4WdCTcvU2PFZFyV0Wvlt6x6AGp81fdZtJhq
         nQPBSOipIDmxs3qE8iwRz/5H5Tn2nvV8wR7YRjCQngYf8QpOrHwjow9hztxwr47Jcj7e
         9HKplgLr6NGvBeDrjc4/XQ4YwKtDUB5XRsIVKus0A8temL+dfYvNOrIDqWBHkNIykUJO
         LTCmrgvYmA9UDyEepkZyRBp9lqCVvMqgyJVuC0Ur4aRZzty/RCW54LQHNvg2UmUc6ht7
         17tA==
X-Forwarded-Encrypted: i=1; AJvYcCXozS6yNGs0zZ33tGPU+ysXGWW0Rz9F8xI2IQAZse+VDFQ5gr5EeB72JTqKqNy1K2E1m1N8uJUNwhPGDD++aRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN3sQDZpg5q+zSmMAX7QQ3HVQYZAP0G5mliS8U2xgMZj0EWLH
	ygxt64WwEJplT1G1m8uZZpvsoM3Ivdh/OnFCBhUKf1YxIdEdOAYKcMi24U6M+IS3EdJm+klTznh
	dKZ37AlAQiQ==
X-Google-Smtp-Source: AGHT+IGdakJcbBe+tQwW4UnsZqdEi1ZIwNj4IVWQVkGFg5s//P7OXZj0OmQJJmxF8FOEGdw9b2hDUM2m0rii
X-Received: from plq11.prod.google.com ([2002:a17:903:2f8b:b0:23f:d929:167b])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea06:b0:240:887c:7b95
 with SMTP id d9443c01a7336-24246f30415mr182640075ad.5.1754364606134; Mon, 04
 Aug 2025 20:30:06 -0700 (PDT)
Date: Mon,  4 Aug 2025 20:29:42 -0700
In-Reply-To: <20250805032940.3587891-4-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805032940.3587891-4-ynaffit@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805032940.3587891-6-ynaffit@google.com>
Subject: [RFC PATCH v3 2/2] cgroup: selftests: Add tests for freezer time
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test cgroup v2 freezer time stat. Freezer time accounting should
be independent of other cgroups in the hierarchy and should increase
iff a cgroup is CGRP_FREEZE (regardless of whether it reaches
CGRP_FROZEN).

Skip these tests on systems without freeze time accounting.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 686 ++++++++++++++++++
 1 file changed, 686 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 8730645d363a..c0880ecfa814 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -804,6 +804,685 @@ static int test_cgfreezer_vfork(const char *root)
 	return ret;
 }
 
+/*
+ * Get the current freeze_time_total for the cgroup.
+ */
+static long cg_check_freezetime(const char *cgroup)
+{
+	return cg_read_key_long(cgroup, "cgroup.freeze.stat.local",
+				"freeze_time_total ");
+}
+
+/*
+ * Test that the freeze time will behave as expected for an empty cgroup.
+ */
+static int test_cgfreezer_time_empty(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	long prev, curr;
+	int i;
+
+	cgroup = cg_name(root, "cg_time_test_empty");
+	if (!cgroup)
+		goto cleanup;
+
+	/*
+	 * 1) Create an empty cgroup and check that its freeze time
+	 *    is 0.
+	 */
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr = cg_check_freezetime(cgroup);
+	if (curr) {
+		if (curr < 0)
+			ret = KSFT_SKIP;
+		else
+			debug("Expect time (%ld) to be 0\n", curr);
+
+		goto cleanup;
+	}
+
+	/*
+	 * 2) Freeze the cgroup. Check that its freeze time is
+	 *    larger than 0.
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) > 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 3) Sleep for 100 us. Check that the freeze time is at
+	 *    least 100 us larger than it was at 2).
+	 */
+	usleep(100);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if ((curr - prev) < 100) {
+		debug("Expect time (%ld) to be at least 100 us more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 3).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 5) Check the freeze time again to ensure that it has not
+	 *    changed.
+	 */
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr != prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * A simple test for cgroup freezer time accounting. This test follows
+ * the same flow as test_cgfreezer_time_empty, but with a single process
+ * in the cgroup.
+ */
+static int test_cgfreezer_time_simple(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	long prev, curr;
+	int i;
+
+	cgroup = cg_name(root, "cg_time_test_simple");
+	if (!cgroup)
+		goto cleanup;
+
+	/*
+	 * 1) Create a cgroup and check that its freeze time is 0.
+	 */
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr = cg_check_freezetime(cgroup);
+	if (curr) {
+		if (curr < 0)
+			ret = KSFT_SKIP;
+		else
+			debug("Expect time (%ld) to be 0\n", curr);
+
+		goto cleanup;
+	}
+
+	/*
+	 * 2) Populate the cgroup with one child and check that the
+	 *    freeze time is still 0.
+	 */
+	cg_run_nowait(cgroup, child_fn, NULL);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr > prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 3) Freeze the cgroup. Check that its freeze time is
+	 *    larger than 0.
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) > 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Sleep for 100 us. Check that the freeze time is at
+	 *    least 100 us larger than it was at 3).
+	 */
+	usleep(100);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if ((curr - prev) < 100) {
+		debug("Expect time (%ld) to be at least 100 us more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 5) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 4).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 6) Sleep for 100 us. Check that the freeze time is the
+	 *    same as at 5).
+	 */
+	usleep(100);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr != prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * Test that freezer time accounting works as expected, even while we're
+ * populating a cgroup with processes.
+ */
+static int test_cgfreezer_time_populate(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	long prev, curr;
+	int i;
+
+	cgroup = cg_name(root, "cg_time_test_populate");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr = cg_check_freezetime(cgroup);
+	if (curr) {
+		if (curr < 0)
+			ret = KSFT_SKIP;
+		else
+			debug("Expect time (%ld) to be 0\n", curr);
+
+		goto cleanup;
+	}
+
+	/*
+	 * 1) Populate the cgroup with 100 processes. Check that
+	 *    the freeze time is 0.
+	 */
+	for (i = 0; i < 100; i++)
+		cg_run_nowait(cgroup, child_fn, NULL);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr != prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 2) Wait for the group to become fully populated. Check
+	 *    that the freeze time is 0.
+	 */
+	if (cg_wait_for_proc_count(cgroup, 100))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr != prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 3) Freeze the cgroup and then populate it with 100 more
+	 *    processes. Check that the freeze time continues to grow.
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	for (i = 0; i < 100; i++)
+		cg_run_nowait(cgroup, child_fn, NULL);
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Wait for the group to become fully populated. Check
+	 *    that the freeze time is larger than at 3).
+	 */
+	if (cg_wait_for_proc_count(cgroup, 200))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 5) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 4).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 6) Kill the processes. Check that the freeze time is the
+	 *    same as it was at 5).
+	 */
+	if (cg_killall(cgroup))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr != prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 7) Freeze and unfreeze the cgroup. Check that the freeze
+	 *    time is larger than it was at 6).
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev = curr;
+	curr = cg_check_freezetime(cgroup);
+	if (curr <= prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * Test that frozen time for a cgroup continues to work as expected,
+ * even as processes are migrated. Frozen cgroup A's freeze time should
+ * continue to increase and running cgroup B's should stay 0.
+ */
+static int test_cgfreezer_time_migrate(const char *root)
+{
+	long prev_A, curr_A, curr_B;
+	char *cgroup[2] = {0};
+	int ret = KSFT_FAIL;
+	int pid, i;
+
+	cgroup[0] = cg_name(root, "cg_time_test_migrate_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] = cg_name(root, "cg_time_test_migrate_B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	if (cg_create(cgroup[0]))
+		goto cleanup;
+
+	if (cg_check_freezetime(cgroup[0]) < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(cgroup[1]))
+		goto cleanup;
+
+	pid = cg_run_nowait(cgroup[0], child_fn, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_wait_for_proc_count(cgroup[0], 1))
+		goto cleanup;
+
+	curr_A = cg_check_freezetime(cgroup[0]);
+	if (curr_A) {
+		debug("Expect time (%ld) to be 0\n", curr_A);
+		goto cleanup;
+	}
+	curr_B = cg_check_freezetime(cgroup[1]);
+	if (curr_B) {
+		debug("Expect time (%ld) to be 0\n", curr_B);
+		goto cleanup;
+	}
+
+	/*
+	 * Freeze cgroup A.
+	 */
+	if (cg_freeze_wait(cgroup[0], true))
+		goto cleanup;
+	prev_A = curr_A;
+	curr_A = cg_check_freezetime(cgroup[0]);
+	if (curr_A <= prev_A) {
+		debug("Expect time (%ld) to be > 0\n", curr_A);
+		goto cleanup;
+	}
+
+	/*
+	 * Migrate from A (frozen) to B (running).
+	 */
+	if (cg_enter(cgroup[1], pid))
+		goto cleanup;
+
+	usleep(1000);
+	curr_B = cg_check_freezetime(cgroup[1]);
+	if (curr_B) {
+		debug("Expect time (%ld) to be 0\n", curr_B);
+		goto cleanup;
+	}
+
+	prev_A = curr_A;
+	curr_A = cg_check_freezetime(cgroup[0]);
+	if (curr_A <= prev_A) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr_A, prev_A);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup[0])
+		cg_destroy(cgroup[0]);
+	free(cgroup[0]);
+	if (cgroup[1])
+		cg_destroy(cgroup[1]);
+	free(cgroup[1]);
+	return ret;
+}
+
+/*
+ * The test creates a cgroup and freezes it. Then it creates a child cgroup.
+ * After that it checks that the child cgroup has a non-zero freeze time
+ * that is less than the parent's. Next, it freezes the child, unfreezes
+ * the parent, and sleeps. Finally, it checks that the child's freeze
+ * time has grown larger than the parent's.
+ */
+static int test_cgfreezer_time_parent(const char *root)
+{
+	char *parent, *child = NULL;
+	int ret = KSFT_FAIL;
+	long ptime, ctime;
+
+	parent = cg_name(root, "cg_test_parent_A");
+	if (!parent)
+		goto cleanup;
+
+	child = cg_name(parent, "cg_test_parent_B");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_check_freezetime(parent) < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_freeze_wait(parent, true))
+		goto cleanup;
+
+	usleep(1000);
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_check_frozen(child, true))
+		goto cleanup;
+
+	/*
+	 * Since the parent was frozen the entire time the child cgroup
+	 * was being created, we expect the parent's freeze time to be
+	 * larger than the child's.
+	 *
+	 * Ideally, we would be able to check both times simultaneously,
+	 * but here we get the child's after we get the parent's.
+	 */
+	ptime = cg_check_freezetime(parent);
+	ctime = cg_check_freezetime(child);
+	if (ptime <= ctime) {
+		debug("Expect ptime (%ld) > ctime (%ld)\n", ptime, ctime);
+		goto cleanup;
+	}
+
+	if (cg_freeze_nowait(child, true))
+		goto cleanup;
+
+	if (cg_freeze_wait(parent, false))
+		goto cleanup;
+
+	if (cg_check_frozen(child, true))
+		goto cleanup;
+
+	usleep(100000);
+
+	ctime = cg_check_freezetime(child);
+	ptime = cg_check_freezetime(parent);
+
+	if (ctime <= ptime) {
+		debug("Expect ctime (%ld) > ptime (%ld)\n", ctime, ptime);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	free(child);
+	if (parent)
+		cg_destroy(parent);
+	free(parent);
+	return ret;
+}
+
+/*
+ * The test creates a parent cgroup and a child cgroup. Then, it freezes
+ * the child and checks that the child's freeze time is greater than the
+ * parent's, which should be zero.
+ */
+static int test_cgfreezer_time_child(const char *root)
+{
+	char *parent, *child = NULL;
+	int ret = KSFT_FAIL;
+	long ptime, ctime;
+
+	parent = cg_name(root, "cg_test_child_A");
+	if (!parent)
+		goto cleanup;
+
+	child = cg_name(parent, "cg_test_child_B");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_check_freezetime(parent) < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_freeze_wait(child, true))
+		goto cleanup;
+
+	ctime = cg_check_freezetime(child);
+	ptime = cg_check_freezetime(parent);
+	if (ptime != 0) {
+		debug("Expect ptime (%ld) to be 0\n", ptime);
+		goto cleanup;
+	}
+
+	if (ctime <= ptime) {
+		debug("Expect ctime (%ld) <= ptime (%ld)\n", ctime, ptime);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	free(child);
+	if (parent)
+		cg_destroy(parent);
+	free(parent);
+	return ret;
+}
+
+/*
+ * The test creates the following hierarchy:
+ *    A
+ *    |
+ *    B
+ *    |
+ *    C
+ *
+ * Then it freezes the cgroups in the order C, B, A.
+ * Then it unfreezes the cgroups in the order A, B, C.
+ * Then it checks that C's freeze time is larger than B's and
+ * that B's is larger than A's.
+ */
+static int test_cgfreezer_time_nested(const char *root)
+{
+	char *cgroup[3] = {0};
+	int ret = KSFT_FAIL;
+	long time[3] = {0};
+	int i;
+
+	cgroup[0] = cg_name(root, "cg_test_time_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] = cg_name(cgroup[0], "B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	cgroup[2] = cg_name(cgroup[1], "C");
+	if (!cgroup[2])
+		goto cleanup;
+
+	if (cg_create(cgroup[0]))
+		goto cleanup;
+
+	if (cg_check_freezetime(cgroup[0]) < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(cgroup[1]))
+		goto cleanup;
+
+	if (cg_create(cgroup[2]))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[2], true))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[1], true))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[0], true))
+		goto cleanup;
+
+	usleep(1000);
+
+	if (cg_freeze_nowait(cgroup[0], false))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[1], false))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[2], false))
+		goto cleanup;
+
+	time[2] = cg_check_freezetime(cgroup[2]);
+	time[1] = cg_check_freezetime(cgroup[1]);
+	time[0] = cg_check_freezetime(cgroup[0]);
+
+	if (time[2] <= time[1]) {
+		debug("Expect C's time (%ld) > B's time (%ld)", time[2], time[1]);
+		goto cleanup;
+	}
+
+	if (time[1] <= time[0]) {
+		debug("Expect B's time (%ld) > A's time (%ld)", time[1], time[0]);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = 2; i >= 0 && cgroup[i]; i--) {
+		cg_destroy(cgroup[i]);
+		free(cgroup[i]);
+	}
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cgfreezer_test {
 	int (*fn)(const char *root);
@@ -819,6 +1498,13 @@ struct cgfreezer_test {
 	T(test_cgfreezer_stopped),
 	T(test_cgfreezer_ptraced),
 	T(test_cgfreezer_vfork),
+	T(test_cgfreezer_time_empty),
+	T(test_cgfreezer_time_simple),
+	T(test_cgfreezer_time_populate),
+	T(test_cgfreezer_time_migrate),
+	T(test_cgfreezer_time_parent),
+	T(test_cgfreezer_time_child),
+	T(test_cgfreezer_time_nested),
 };
 #undef T
 
-- 
2.50.1.565.gc32cd1483b-goog


