Return-Path: <linux-kselftest+bounces-38056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4CB1539E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D159A18A54AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66EA25DB1A;
	Tue, 29 Jul 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCzHZ1yO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFD256C9E
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817844; cv=none; b=gjbIf36o5RNRZkHSfC9psQs5F1GZtJ0ru74kDMSKE7N7Si8uE6IG/Svg74L4FjIfv+78T/pcNiSmIav0qGSHIZFTzWLzzbkTjX7xYePPahEbzbTYMlDkLraFl6/nX0ox2HYXEZbfIfIHoVt2uRh2qw7mOqIDczN3Puo9HS/g9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817844; c=relaxed/simple;
	bh=NsAsE0K6XtC838sAhCEDbzWc2+LZjzuI5QUtOwwrrho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6CmUfk1fTRKURCUIbWIdW5A3s0sfYi/ONnIwnkRMo5uC6QNXFQ7megwvpp+TZkGZKDYC1zhRjQ1AjzWi1B3mq7ahRAIbpGLseWKSUVHvT/G8BjuCI1kNVBPJ9XElk0WjlDmHplN5FZAXZkwqf3HGGs6kfMgUTL+IRX5m3mSlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCzHZ1yO; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab701d5317so164668211cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817842; x=1754422642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOeFclXy3T+mxjPs2r95qUwInGd9f34oaUC//E5T6EQ=;
        b=nCzHZ1yO7T9pJ3wHabAWFYM2HubXgRW+CvhcwQqefvDfuW7qBSOx2ibOfMEslKbDeS
         C3iX9VAHET8CsN45MogiazT94f+j8Kon7jAHjSrrW51U35bWkMasqFlrPJLd4xtEnTkZ
         3z3RprfOqf51uJWLFG/IOTPsPAqivW2DjZpr7MvqXfwaJoJUHLUes2m9WGXhQWeRBk7J
         8yUgRIbNrx3htvxL7vnCgu7ArPtJwrGL8fy+zbnNLSv+8BRbfFCEwJC321KDKOJgtW6I
         LvZnnmexDPfIEk2BjA4h31ocVw+il3WTe4vF6yfeFYjTpklX61RRBQGoI5U9nu6N8YM0
         hddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817842; x=1754422642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOeFclXy3T+mxjPs2r95qUwInGd9f34oaUC//E5T6EQ=;
        b=NQorZMvM1KZk5cI9i0VOab1dpmGX3c7o86W2n0sFOhPQEIlz39PMq/hE3AbNiSBhnb
         Wr3lFECNSsyz9rmExjg99dWRYRLd5SE5ensrHy7DkV6FllFTGM92m2owQ9MiFLEDQvMB
         P/r9FeFQnEkq9GLHsuEjNycwttDWQIxE1KFN4uq/Zj1UOCUO9YFaERmKQC/KCrxPvmHl
         i/qj4vb27KwFoQpuWBaUUvbaAMealK9F0bHjuCBFdE8JBMOjnI1JBUR4L1Ta4OXCsB4L
         fZIUc0Fwj8rvcKWSWD6erVWmu4ES/67HQx/ow9GYBYrpkT4ymcSalsYcFuwrOdM6BmyZ
         K5YA==
X-Forwarded-Encrypted: i=1; AJvYcCWeBdC776r0TP8/8oiB+0nxpIryl5J5rz3paZo/DlBYO1lWbb5O5C0huZLjgOCYtTOS7pSeZWPgeCmajiu93ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YztMY+Fvbb2AxOJ52/ZW6der07VN0yGqv/l0UAKEqmdTL+ulRTm
	LnivCUqMr9kvlJe/6HD29gKM2V4p/WAFOF2rpkkFHwb3Gdrom55QkUVXALSQiwYKaiRzZfwCA2i
	1z9uIwMm+AIntNg==
X-Google-Smtp-Source: AGHT+IGMUSrZqdOskeosr+igUyfuxaNIUOfIiK4baHfY/+3YYV3woVzpXvK0qcFaE6oy2EYskMsu3hBqN2Ggaw==
X-Received: from qtbfh7.prod.google.com ([2002:a05:622a:5887:b0:4ab:b3a4:9650])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1906:b0:4ab:6a4c:83a2 with SMTP id d75a77b69052e-4aedbc5d048mr14740211cf.39.1753817842099;
 Tue, 29 Jul 2025 12:37:22 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:41 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-4-marievic@google.com>
Subject: [PATCH 3/9] kunit: Pass additional context to generate_params for
 parameterized testing
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

To enable more complex parameterized test scenarios,
the `generate_params` function sometimes needs additional
context beyond just the previously generated parameter.
This patch modifies the `generate_params` function signature
to include an extra `struct kunit *test` argument, giving
users access to the parent kunit test's context when
generating subsequent parameters.

The `struct kunit *test` argument was added as the first parameter
to the function signature as it aligns with the convention
of other KUnit functions that accept `struct kunit *test` first.
This also mirrors the "this" or "self" reference found
in object-oriented programming languages.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/test.h | 9 ++++++---
 lib/kunit/test.c     | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d8dac7efd745..4ba65dc35710 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -128,7 +128,8 @@ struct kunit_attributes {
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
-	const void* (*generate_params)(const void *prev, char *desc);
+	const void* (*generate_params)(struct kunit *test,
+				       const void *prev, char *desc);
 	struct kunit_attributes attr;
 
 	/*
@@ -1701,7 +1702,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
@@ -1722,7 +1724,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d80b5990d85d..f50ef82179c4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -696,7 +696,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
-			curr_param = test_case->generate_params(NULL, param_desc);
+			curr_param = test_case->generate_params(&test, NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
@@ -727,7 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-				curr_param = test_case->generate_params(curr_param, param_desc);
+				curr_param = test_case->generate_params(&test, curr_param,
+									param_desc);
 			}
 		}
 
-- 
2.50.1.552.g942d659e1b-goog


