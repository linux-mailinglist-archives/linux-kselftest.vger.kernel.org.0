Return-Path: <linux-kselftest+bounces-1083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 772FE803F5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A490F1C20BA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792A35EEB;
	Mon,  4 Dec 2023 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRdo68l9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5035EE9;
	Mon,  4 Dec 2023 20:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E99C433C8;
	Mon,  4 Dec 2023 20:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722003;
	bh=DmLcVDVMT5DQb4/cnrHAIskw0sq/6uoZsdZgUyZ0CGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRdo68l9MepVTosbqD8pe8I/w3MwY0W5Jn5Rk1xGbcRgwa9KCkfvS7AIvdZa/IWHG
	 MOtMdFnm1qPIOGLx5NaAHbqBlqFxYSz8eA1gLkxuGLEuvN3RwxuxPWpS0l6AXUoV0z
	 cik3+SVtZvniuhVQFsjEkVMiMauNfqdeh5hHwq3weOE56VGcgHVSoiT0VIO7TAP3q0
	 dttMJMxi3KR70DMw5rypot5esMyYo61l9rpaNYc3IFSgiX5k15iihj1xEkQjyV3ylh
	 BdEyazHEdO23dIZVL2yuJXhQYaxgN4eEm2hxqYxJlPqAP5ulOT62XXuSIaCHyyIYa8
	 phxIdlyrROMpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.6 02/32] kunit: Warn if tests are slow
Date: Mon,  4 Dec 2023 15:32:22 -0500
Message-ID: <20231204203317.2092321-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit f8f2847f739dc899d0e563eac01299dadefa64ff ]

Kunit recently gained support to setup attributes, the first one being
the speed of a given test, then allowing to filter out slow tests.

A slow test is defined in the documentation as taking more than one
second. There's an another speed attribute called "super slow" but whose
definition is less clear.

Add support to the test runner to check the test execution time, and
report tests that should be marked as slow but aren't.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f139814123..e451cfe6143ec 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -372,6 +372,36 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
+/* Only warn when a test takes more than twice the threshold */
+#define KUNIT_SPEED_WARNING_MULTIPLIER	2
+
+/* Slow tests are defined as taking more than 1s */
+#define KUNIT_SPEED_SLOW_THRESHOLD_S	1
+
+#define KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S	\
+	(KUNIT_SPEED_WARNING_MULTIPLIER * KUNIT_SPEED_SLOW_THRESHOLD_S)
+
+#define s_to_timespec64(s) ns_to_timespec64((s) * NSEC_PER_SEC)
+
+static void kunit_run_case_check_speed(struct kunit *test,
+				       struct kunit_case *test_case,
+				       struct timespec64 duration)
+{
+	struct timespec64 slow_thr =
+		s_to_timespec64(KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S);
+	enum kunit_speed speed = test_case->attr.speed;
+
+	if (timespec64_compare(&duration, &slow_thr) < 0)
+		return;
+
+	if (speed == KUNIT_SPEED_VERY_SLOW || speed == KUNIT_SPEED_SLOW)
+		return;
+
+	kunit_warn(test,
+		   "Test should be marked slow (runtime: %lld.%09lds)",
+		   duration.tv_sec, duration.tv_nsec);
+}
+
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
@@ -379,6 +409,8 @@ static void kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
+	struct timespec64 start, end;
+
 	if (suite->init) {
 		int ret;
 
@@ -390,7 +422,13 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
+	ktime_get_ts64(&start);
+
 	test_case->run_case(test);
+
+	ktime_get_ts64(&end);
+
+	kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
-- 
2.42.0


