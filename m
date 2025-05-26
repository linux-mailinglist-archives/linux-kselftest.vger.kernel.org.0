Return-Path: <linux-kselftest+bounces-33787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D3AC4066
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017363A7F4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD420C47B;
	Mon, 26 May 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcyDshW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E020B7FB
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266108; cv=none; b=qiuzjJKCrMFuztSFf9A+XrX1dV9uO12An5q9Er1Pg3vIVP2w3sI3FsFWm7TODV9DKPSjVdB/R6I3idlUoJTrKyZBWXooiYSiSPdIixzyzsjreZh4JEfNjuzFUwvAqGZZuRq2VzVEnDuWs4vDhJYAaYdSKXkO8vNMJDWHfI3yK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266108; c=relaxed/simple;
	bh=7yRg+dfR8t8qM7YDN3CmiOT2bOidYPimlJooWf0iZlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=FuD6zzRyS1VkcWxV4SyZSudGOiiqofpNFMydJLSHv5UK1U2xKmMIytKm9kYd/w16B+zFYSUHa7A83Qe3WF2u63hUdKwZbvMBElO7BeZ60HfMsN3xfrcIAlUwvpTvVdbhBhWHVLzDCLzQ34JU91ui/x8TYYj0DWCENVysT1pLAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcyDshW5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748266104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0YRJWOlICqCgS45Er6beMSN4o1Be1F4DIB5uq3fyIU=;
	b=IcyDshW5ZsjTmRzuOqRajmZIJwoXekddLuLWs2yQcQZk2WKkT43gTNX4I66FZ6bObhPORH
	NQVGJ7TPs3m8azfyuso8OWgfkKOYZ9b3s36K2ke7SamfWVoB4WRd6OGF6Gj0Gs7ALT4DoU
	Mzg39RU2VtS/Xgvao1kBq1jdAeGWD3Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-mLvqyGbWO3urCaj67TA7DQ-1; Mon, 26 May 2025 09:28:22 -0400
X-MC-Unique: mLvqyGbWO3urCaj67TA7DQ-1
X-Mimecast-MFC-AGG-ID: mLvqyGbWO3urCaj67TA7DQ_1748266101
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a371fb826cso882766f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266100; x=1748870900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0YRJWOlICqCgS45Er6beMSN4o1Be1F4DIB5uq3fyIU=;
        b=LHub+jxNcroVOGIVwMlHfb9spF3I9o7f9mvi49pw6FJkvDC96F6YtL2OTAUAAT2Ozx
         7Y7YcVZ7xNLyBsIuHFjW/LTR9WURss38uMsDIU35oc7SsDmlkIzvmdGxbSkhPl+jBkLy
         Fg1VzPjQeMhm8l02auBj8EEyZFaYQopHEAyc8+WZX7HUt7LnqjmOPNZcCHIIafzScvzQ
         x5F7yG/pBCiA3Q6CyHZEK4KlMPWn//KQRJdw24WOsWznBVUnu40NfX8aG3LwwMnvOkKU
         +TEjGGZc7cQRjwgproV3YNk5xA+N+Rt5BCxob1qiwdD0jglf4h46I4QhxOxDZwJNgyoV
         ktcw==
X-Gm-Message-State: AOJu0Yx1qyy/5ud37Oe0vWKNajz+07Gor57XnnoL19m4Jslmkw9by/Vg
	38j12EFMzqWFDq2PlUBNdGy4RaVTqaQyWpHHRgHTC3vfmIRt23b9clmiuBM49LxXkZRi/JH8uGw
	f1R3zbuy+buVJCZFvn0/VPXEtqQwJ4pgxmGQ7h+Pfb3WPsRC3r7F+D27BE0e3T7ptm1fx/XfrLC
	x2e+rwkYMkVuHmtXwYVewgD5QrX2x0f3GtrQ15z8e8ojk8Xrodhrcotw1g
X-Gm-Gg: ASbGncsfYDwObv+4vMKQlReerDk46tJL/+NJRW91Capy3ycMt31M1ZpgUmc8wHXr2r+
	Yx7AKlghK15yzApEi/+tqrOGf0jMKgwSNnmxKU8io+93jN0GMAcd1iO+v20zrlPEzGvKkeAsE4e
	S4o+/jJMna/gkMsu6ecwX35wM3Mnjcrz9lSNz9pchChtzq0MEXTPiZzMZDH/1WofVdJb5RDsbiK
	r7ZhqwMx6YVntLC/y1g0xDZyfzSFbfeh460iQ2wGutlhaiKYUc0Du7ClPxkrhgYptzf/N8QTbnj
	6BmAlXQwGotooq6h
X-Received: by 2002:a05:6000:4022:b0:3a3:7638:d754 with SMTP id ffacd0b85a97d-3a4cb454b98mr7833520f8f.21.1748266100611;
        Mon, 26 May 2025 06:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6pOAvbuHyLjhUOMwzoRe4s1Do1fW/hrkf0UqrCoecUCHTClHzHJUHZb8Hgf3W8Hzp8xWVNA==
X-Received: by 2002:a05:6000:4022:b0:3a3:7638:d754 with SMTP id ffacd0b85a97d-3a4cb454b98mr7833471f8f.21.1748266100089;
        Mon, 26 May 2025 06:28:20 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c8455e7dsm8836663f8f.9.2025.05.26.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:28:19 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v5 3/5] Add unit tests to verify that warning backtrace suppression works.
Date: Mon, 26 May 2025 13:27:53 +0000
Message-Id: <20250526132755.166150-4-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526132755.166150-1-acarmina@redhat.com>
References: <20250526132755.166150-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add unit tests to verify that warning backtrace suppression works.

If backtrace suppression does _not_ work, the unit tests will likely
trigger unsuppressed backtraces, which should actually help to get
the affected architectures / platforms fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 lib/kunit/Makefile                     |   3 +
 lib/kunit/backtrace-suppression-test.c | 105 +++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 lib/kunit/backtrace-suppression-test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 3195e861d63c..05fb19d69709 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -23,6 +23,9 @@ obj-y +=				hooks.o \
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
+ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
+obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
+endif
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
new file mode 100644
index 000000000000..a3d5991b9b15
--- /dev/null
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for suppressing warning tracebacks
+ *
+ * Copyright (C) 2024, Guenter Roeck
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+
+static void backtrace_suppression_test_warn_direct(struct kunit *test)
+{
+	KUNIT_DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+	WARN(1, "This backtrace should be suppressed");
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_direct), 1);
+}
+
+static void trigger_backtrace_warn(void)
+{
+	WARN(1, "This backtrace should be suppressed");
+}
+
+static void backtrace_suppression_test_warn_indirect(struct kunit *test)
+{
+	KUNIT_DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_multi(struct kunit *test)
+{
+	KUNIT_DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	KUNIT_DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	WARN(1, "This backtrace should be suppressed");
+	trigger_backtrace_warn();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_multi), 1);
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
+{
+	KUNIT_DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
+
+	KUNIT_START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+	WARN_ON(1);
+	KUNIT_END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	KUNIT_EXPECT_EQ(test,
+			KUNIT_SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_on_direct), 1);
+}
+
+static void trigger_backtrace_warn_on(void)
+{
+	WARN_ON(1);
+}
+
+static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
+{
+	KUNIT_DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
+
+	KUNIT_START_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+	trigger_backtrace_warn_on();
+	KUNIT_END_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn_on), 1);
+}
+
+static struct kunit_case backtrace_suppression_test_cases[] = {
+	KUNIT_CASE(backtrace_suppression_test_warn_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
+	KUNIT_CASE(backtrace_suppression_test_warn_multi),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
+	{}
+};
+
+static struct kunit_suite backtrace_suppression_test_suite = {
+	.name = "backtrace-suppression-test",
+	.test_cases = backtrace_suppression_test_cases,
+};
+kunit_test_suites(&backtrace_suppression_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");
-- 
2.34.1


