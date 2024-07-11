Return-Path: <linux-kselftest+bounces-13621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14992EFD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4861F243F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA018755E;
	Thu, 11 Jul 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fg5YMIR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36918732C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726794; cv=none; b=GVbiIJQQoWovRXW8BLDRVjSXFYBHDyC0A4g0iEDmuIYHZDFRvkAshMotY1kj68y9kkWMKqBywThr4+6mSbP32p0U9wSI74DMpoNZ38E2INLdjGkozlvV1KKXQwe7omFoc5Dm9xuH1pq7lxO73xoind4Mdx+KFrhRamaEkk8bwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726794; c=relaxed/simple;
	bh=6c9enNd5xXF7GHrH/1e8o7hHuPbsJhlGShC4QQsotxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E77bmgQo6hFC8hWvBOeA2VKA8l80tNaQCVydlrVSHy3+pplznkxWNgMTLkmYd1yQ8lIlKpWzJubtt6OuYsXqKGLqZ8ftaZfPFqiCuBmnPPOE2LnHvgndbAiJKLxbmE320q7ILZ5g6EewYM2AWUQQeMtTudFGgLfDvv/qd3n5UGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fg5YMIR3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a5534d58so1851619276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726791; x=1721331591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGX/U2MB6y0a+maZqAk3LokToAOteYrURf5ZQXwr7AQ=;
        b=Fg5YMIR3GvpHP4P6Lt0HMN9UZC3r7a5H0HJxlnaFY3V4fdXnehM/MrSyvTzermS98z
         /skwh3mZCEVMPk4+IU9fVmbD5uxxG5yLr1nndkxHf8ouRGgg973sSRIfOKwtOD/eAM20
         KLv8lCG0mXCzZ4bwinxqkfIhP84iUk69hCR3qHv6sdYFXEXyimPQnIKYM0uqdPfFcF1a
         xykB4i7LaQnti8aDzbBb7dE8jAU0j+2YZbfljlwVMrLF2XrJBIkLjhiOegYHkC3CG537
         AfZ9ly8pxMf1h7rLnZ693n5Mo3B+gqs0ahKM2Yg0FWvjxAbBsqRW6KumW00tACmIuZZn
         CP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726791; x=1721331591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGX/U2MB6y0a+maZqAk3LokToAOteYrURf5ZQXwr7AQ=;
        b=vXSM2FL51ZT9LP2Pf9Faevs+7v4+9adHxogX/nn00YLsLu/SX59ej7R3X8VgfY5GRX
         sTNPAHkaaenUo+L0ZG+y1sk9hVuKk6H2Nq6D8XQ0SUKhwC8v7AqsSrUZMVlJEpM95H1g
         sqzY9F0ThWZpbNhi7LlgJDj2Jaj5cMGklk7TYcY3dVPWp/jotkFDBSbEkJPQNupgBKNz
         i+g5tbw7PGLlyTO/v018vsmPFsNz5i5u6FiLOwTJhMRS7TbuxMULxcZLL9LbkAzrIHSf
         4fs5lZ3sSZTVj2TO7qT4PZd3QD4ny3k5PodiZoU+EXWfnHp8My0JCERVAqkZuFX7d3LB
         q1jg==
X-Gm-Message-State: AOJu0Yzl1PorQBQBQr5bodqBvCbBss79K8CCID55koLxO5FyeZKJD6Q2
	TGxNYu+w9BOV4oOJX+AUWRtjtoXo3jjKcDaa5IAAiRmt3c2vsKuMiZnIO+RjNc0ahOazw60pB/Z
	HQ0+BQkwkzFg3iASuhA==
X-Google-Smtp-Source: AGHT+IFQhBj+gG4iTlqi9n6jzYom//iTBl4rGE2Zd1V1Jd14gBb2JQb/Ng5vfq+MIw6tBclm4kGizOa0PjvJNpJl
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:722:b0:e02:8473:82c4 with SMTP
 id 3f1490d57ef6-e041b17715amr17667276.11.1720726791048; Thu, 11 Jul 2024
 12:39:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:39:45 +0000
In-Reply-To: <20240711193729.108720-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193945.110170-1-ericchancf@google.com>
Subject: [PATCH v2 3/3] kunit: Introduce KUNIT_ASSERT_MEMEQ and
 KUNIT_ASSERT_MEMNEQ macros
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduces KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros
to provide assert-type equivalents for memory comparison.
While KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ are available for
expectations, the addition of these new macros ensures that assertions
can also be used for memory comparisons, enhancing the consistency and
completeness of the kunit framework.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 774c42721412..67ad0e026bbf 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1451,6 +1451,60 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_ASSERT_MEMEQ() - Asserts that the first @size bytes of @left and @right are equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
+ * KUNIT_ASSERT_TRUE() for more information.
+ *
+ * Although this assertion works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This assertion is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_ASSERT_MEMEQ(test, left, right, size) \
+	KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_ASSERTION,				       \
+			    left, ==, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_MEMNEQ() - Asserts that the first @size bytes of @left and @right are not equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, memcmp((@left), (@right), (@size))). See
+ * KUNIT_ASSERT_TRUE() for more information.
+ *
+ * Although this assertion works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This assertion is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_ASSERT_MEMNEQ(test, left, right, size) \
+	KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_ASSERTION,				       \
+			    left, !=, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
  * @test: The test context object.
-- 
2.45.2.993.g49e7a77208-goog


