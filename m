Return-Path: <linux-kselftest+bounces-25369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F5A21FBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DFF18858DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2971C5F25;
	Wed, 29 Jan 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFphCWbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA5199B8
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162340; cv=none; b=nKdim968vINK0oHSmxLGwXBwLp3ByxbY6wXv41ohA+WzZrG89QKzQiXz5n8j+hJDIwsnP22UWhoUeJfwXBffEijfhGTbIHv3IjAlf1oVMiRmvlSVHWB2q7HgZNHLm20zdYTurMauVqiNxY7Xp/lPnBIop3+xlxDLXWtrOj2IS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162340; c=relaxed/simple;
	bh=et+F4lIsP0xLBEbka+5mTy5sc5OWcPICDnaj+Dnfut8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SjH+9vYH16GZ0KAK9ZiTwkfleWZcmpt89pZBoxMyrrCQTpOLMQptEnyMoRGjjNd22r0Ha9g83K64WBCW7ergNMOQGfrclwea95M3MgDNQLzQUWbzI4T8KOsANjULuERSH4CxQ9C3cj7p71sEBB0BEvA/SkbHR+TOZ8ZfDCmiEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFphCWbx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862c78536bso422422f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738162336; x=1738767136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS/ki7blkPY5sgOhGGtxpI4uVopNxUZR7+zpKj9shxw=;
        b=KFphCWbxtQanHTbnXPzSBYVt61Jbi9/3mwC+EbPKpM1eKuyYifa7uIc54ZZm7X2FpJ
         bFKXtpu0Laoq0aGWXmr/FiMNvdsJpSE9UjbXBRXW1ll+MKZLIcvztTF8Cmyq7TJFyfqa
         W67+aih8iMUi7m3RRAIHhdqUgFmtfGCadgZTb5yw5H0ha5O6VPAWvLH+ggIgTmNCrO0v
         V+cAKfwIQ/A1UQZY7fWifHsvE9EGON6kdXnjMI/rAeCyVjEOn+f6o2d2N+STerOwcwpo
         +hNO1QpvnaY/WqEocKLCgyj5vHlVKofy83x2bE0tvtSELx3y7WpevvpDnpxwdpzy+ZM5
         q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738162336; x=1738767136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS/ki7blkPY5sgOhGGtxpI4uVopNxUZR7+zpKj9shxw=;
        b=Q+DjGax6BkjeyKxHZAjgWNWc8iUBva+FGZQtBScPeAQNTf+NWaz8tl9QlfFQnXTqUU
         BKiOk0KYJVZN2zYKRZIH1PLR8TtBXb8DZDz+f8oYBirF0WpnK6CCmapZmPzxMEgDZw/y
         AAiwOzIehXQMYsbKdmV3a7pJxiHdfecwBdqssEpid4UrNkpHZSNX7WPc88hBppElDyBl
         v0zDBOQMQ2hRgfmhLDQE+nkxe/Fs/aR//63u36Qqab+BKvPNdF7lDlsfrhsUBmD+Vbe7
         42wwG8BK/dRURVok5vaO47aPYS1EvbOzsWidcDHe/hJdeSjy7SfwDmMGjdAv2MKdMWNS
         nuyA==
X-Gm-Message-State: AOJu0Yw7D6RpFo4nUQGqDB5KqvqwkeNdqqmjNWwrogwNsEpCNm62RfcV
	RkqkRnD1/tLyIVXBJVVOA6kU57mikr2Z6iGLMiXFkkKDXk3r0dBG
X-Gm-Gg: ASbGncuND3Uzx7F2/XyJZiP1BWy2egRyV8nDDN4E2KZ4zWJy8TYmQp2ZpU998JfIdNs
	j4thahEA7awuJNO1LCLv8+NpsvqAJeha7Kz0BKRXU3Nxc6nCwQYEpmiAYOC0nAo2HT6nVpRU2EI
	H+Uy3DumuXnf/LZ7UTOgLSulU2d5ZlFFd1D1CIK7sS1BQ8O2Fzip86MQBlPotTLaIvIe3ml+Qv1
	KtdgZFP0UZ2KkX73YiGdZPGyuWh9zRBQLILE6UKOjfF7G111sl5RJnslZsEw2AwZrD+ZLHJO13U
	NUpHKM8TlQWzxOqirLBft6TUYJT4AA3ymE6a4/8dMAYzqqKYOxJqF/giAvhho4IX
X-Google-Smtp-Source: AGHT+IFGFRfEtWeeOuFqwHIT5fNME/cxSZ1qM51MyiCWR114rDnQdm4RIXqhGiywmZb5pbHxlKLTXg==
X-Received: by 2002:a05:6000:1566:b0:38a:9ed4:9ffc with SMTP id ffacd0b85a97d-38c520940c7mr1275934f8f.10.1738162335965;
        Wed, 29 Jan 2025 06:52:15 -0800 (PST)
Received: from pop-os.localdomain (14.78.11.37.dynamic.jazztel.es. [37.11.78.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4212sm16753724f8f.87.2025.01.29.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:52:15 -0800 (PST)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] selftests: Fix typos and grammar in multiple test files
Date: Wed, 29 Jan 2025 15:52:12 +0100
Message-Id: <20250129145212.37486-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 tools/testing/selftests/alsa/mixer-test.c                     | 2 +-
 tools/testing/selftests/arm64/gcs/libc-gcs.c                  | 2 +-
 tools/testing/selftests/cgroup/test_cpuset.c                  | 2 +-
 tools/testing/selftests/mm/gup_longterm.c                     | 2 +-
 tools/testing/selftests/mm/mseal_test.c                       | 2 +-
 tools/testing/selftests/mm/protection_keys.c                  | 4 ++--
 tools/testing/selftests/mm/test_vmalloc.sh                    | 2 +-
 tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 2 +-
 .../pmu/event_code_tests/group_constraint_thresh_sel_test.c   | 4 ++--
 tools/testing/selftests/safesetid/safesetid-test.c            | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 2a4b2662035e..dc7b290fc4ad 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -685,7 +685,7 @@ static int write_and_verify(struct ctl_data *ctl,
 	}
 
 	/*
-	 * Use the libray to compare values, if there's a mismatch
+	 * Use the library to compare values, if there's a mismatch
 	 * carry on and try to provide a more useful diagnostic than
 	 * just "mismatch".
 	 */
diff --git a/tools/testing/selftests/arm64/gcs/libc-gcs.c b/tools/testing/selftests/arm64/gcs/libc-gcs.c
index 17b2fabfec38..482e1c634a65 100644
--- a/tools/testing/selftests/arm64/gcs/libc-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/libc-gcs.c
@@ -129,7 +129,7 @@ TEST(gcs_find_terminator)
  * We can access a GCS via ptrace
  *
  * This could usefully have a fixture but note that each test is
- * fork()ed into a new child whcih causes issues.  Might be better to
+ * fork()ed into a new child which causes issues.  Might be better to
  * lift at least some of this out into a separate, non-harness, test
  * program.
  */
diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index 4034d14ba69a..3f802e3e8480 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -160,7 +160,7 @@ static int test_cpuset_perms_object_deny(const char *root)
 }
 
 /*
- * Migrate a process between parent and child implicitely
+ * Migrate a process between parent and child implicitly
  * Implicit migration happens when a controller is enabled/disabled.
  *
  */
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a61..d2dc3b59a084 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -154,7 +154,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/*
 		 * R/O pinning or pinning in a private mapping is always
 		 * expected to work. Otherwise, we expect long-term R/W pinning
-		 * to only succeed for special fielesystems.
+		 * to only succeed for special filesystems.
 		 */
 		should_work = !shared || !rw ||
 			      fs_supports_writable_longterm_pinning(fs_type);
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 01675c412b2a..2ec2c5aea44a 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -732,7 +732,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	/* the fouth page is not sealed. */
+	/* the fourth page is not sealed. */
 	ret = sys_mprotect(ptr + 3 * page_size, page_size,
 			PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4990f7ab4cb7..fcac7bb26b7a 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -900,7 +900,7 @@ void expected_pkey_fault(int pkey)
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler should have cleared out PKEY register to let the
 	 * test program continue.  We now have to restore it.
 	 */
 	if (__read_pkey_reg() != 0)
@@ -1372,7 +1372,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	long ret;
 	int status;
 	/*
-	 * This is the "control" for our little expermient.  Make sure
+	 * This is the "control" for our little experiment.  Make sure
 	 * we can always access it when ptracing.
 	 */
 	int *plain_ptr_unaligned = malloc(HPAGE_SIZE);
diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
index d73b846736f1..2d4b3e0a6a17 100755
--- a/tools/testing/selftests/mm/test_vmalloc.sh
+++ b/tools/testing/selftests/mm/test_vmalloc.sh
@@ -21,7 +21,7 @@ ksft_skip=4
 
 #
 # Static templates for performance, stressing and smoke tests.
-# Also it is possible to pass any supported parameters manualy.
+# Also it is possible to pass any supported parameters manually.
 #
 PERF_PARAM="sequential_test_order=1 test_repeat_count=3"
 SMOKE_PARAM="test_loop_count=10000 test_repeat_count=10"
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 70f65eb320a7..a6d9f7bd1443 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -682,7 +682,7 @@ TEST_F(mount_setattr, mount_has_writers)
 	ASSERT_GE(fd, 0);
 
 	/*
-	 * We're holding a fd open to a mount somwhere in the middle so this
+	 * We're holding a fd open to a mount somewhere in the middle so this
 	 * needs to fail somewhere in the middle. After this the mount options
 	 * need to be unchanged.
 	 */
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
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..80f736d545a9 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -19,7 +19,7 @@
 
 /*
  * NOTES about this test:
- * - requries libcap-dev to be installed on test system
+ * - requires libcap-dev to be installed on test system
  * - requires securityfs to me mounted at /sys/kernel/security, e.g.:
  * mount -n -t securityfs -o nodev,noexec,nosuid securityfs /sys/kernel/security
  * - needs CONFIG_SECURITYFS and CONFIG_SAFESETID to be enabled
-- 
2.34.1


