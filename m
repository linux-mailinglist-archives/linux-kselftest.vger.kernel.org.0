Return-Path: <linux-kselftest+bounces-13620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF892EFD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4206428520D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134F18732F;
	Thu, 11 Jul 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZSXmeJv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2217CA01
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726779; cv=none; b=s2HK7vrQtc5o9PTGmDUAL17OG2aH6Kb1oz+jdfdTkkqzLW0vFKA2Dohzj7m7b0byHAAaqFWDxJgeO5lQ+srAKzjOtjPMFB/wAh3PPLAUDe6sJ1mKjlrn7Y4VglIkCvM04XufpdEC59G4PB3WUdJ+31o4mCIaD8uguHlM3OLAXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726779; c=relaxed/simple;
	bh=zuv7aU9+6EwizhT7k58qrKHFO1TyJwLy/+7sOFS+/2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aNhMkP0ZIfItNNvAY/xuGBkE40g9WGO5TzPvvjBEdmFUsxBxY5Byy0yWL+F88icIXAwI+9wrEJwCm1zYowfspgyC9qMhhuEjqvRMcGY2IRJgmYul4qg+S8+96YNDT9MfTr8rMu4tOzsiSvuKyLOh55hbSvbWU0ajIvRoTIAhC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZSXmeJv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a59172dbso2060875276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726777; x=1721331577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgxac9QB2KM4ApAkhvoORMapcVhlUbyyyjsgT2eKMs0=;
        b=2ZSXmeJv3/glWt5cfhfLAvpaJ7XQSf8QjblA6qoh2sjh7975lKZHfvz6/nbiEE1AIW
         H7dAwJN8yZAmpqSZ7ONtFi8hVv6WXV27kUVCcBAHkMNs1zGyrmtGVJaNs5xlHiTLTHn9
         dS0q9LyrQ2z4ffh2PzlS3pCC51MmgM4DC+esZcZGyhnnHeq5KPOGiP1ql6ZgLTzE/vGg
         8gy6zXu6aF+HQDFcNpnIW5AlLfhWHYckaChpianGUm8Sqp2Qtx+lPHBIoXAQsrP+CYNJ
         9w2Pd/H17P9ai/vlj9NnDuOf5AiBBKxhGZm9wsfF6l51o1VuoVVaVodT7lmAyXURFqPX
         lmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726777; x=1721331577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgxac9QB2KM4ApAkhvoORMapcVhlUbyyyjsgT2eKMs0=;
        b=dwzuEJTXj9tDFGLcq0LU/XWSXZLGL6Kl1yNLL/koaVhvbwYf2VTQeB62CknG6OrdhJ
         nuYDzeUYRGGRFbVz0g/ylatztEPF2LRfcXvI2vNuLA4wGTDHUh0OM/VhZC0xG1U0eoeG
         B69aHwHGQDOPmN83JeLrpQlSWOro8V9f6IjQry9jcgOc1rb43gEDOFCLBH1nbmDMX8/f
         5KRcAeW+MeRSH1kSBT5RqM/IEgAzBdM6wprVt2AajNFqQqcOVjKxAjt9yTHeSf4MM6V9
         Z+ohUMvxQwSJbT4qRh2dpdwj0sqxeLaULmi4IpmjG7qQ1ACYLyCq+kMpDK35LOhaTqWp
         Z5dA==
X-Gm-Message-State: AOJu0YxP0FWKmJx0drg9KQXt+X7thAxkUBRe7S4WIaPHdxSropdsnHaj
	qeqpeynBnfOU44iY9rjhRjdBhLyc+D0KVJV2UaGYy26onaGuZUyqJ3u78k6STthC2ducrCxWNd2
	m06re1Yoka0hWgrrWOA==
X-Google-Smtp-Source: AGHT+IFiZy3IJYTsIL2Alpwcdwku4C0/zoCvC/67nAo//ap35R2LErIX4igMHhNBKIedcgpWnliHinbXANx1eZYw
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1ac1:b0:e03:62dc:63de with
 SMTP id 3f1490d57ef6-e041b0593efmr775705276.6.1720726777026; Thu, 11 Jul 2024
 12:39:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:39:31 +0000
In-Reply-To: <20240711193729.108720-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193931.109771-1-ericchancf@google.com>
Subject: [PATCH v2 2/3] kunit: Rename KUNIT_ASSERT_FAILURE to
 KUNIT_FAIL_AND_ABORT for readability
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Both KUNIT_FAIL and KUNIT_ASSERT_FAILURE defined to KUNIT_FAIL_ASSERTION
with different tpye of kunit_assert_type. The current naming of
KUNIT_ASSERT_FAILURE and KUNIT_FAIL_ASSERTION is confusing due to their
similarities. To improve readability and symmetry, renames
KUNIT_ASSERT_FAILURE to KUNIT_FAIL_AND_ABORT. Makes the naming
consistent, with KUNIT_FAIL and KUNIT_FAIL_AND_ABORT being symmetrical.
Additionally, an explanation for KUNIT_FAIL_AND_ABORT has been added to
clarify its usage.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index 2fa5b725ae0a..9711ced180b8 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -31,7 +31,7 @@ static int input_test_init(struct kunit *test)
 	ret = input_register_device(input_dev);
 	if (ret) {
 		input_free_device(input_dev);
-		KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
+		KUNIT_FAIL_AND_ABORT(test, "Register device failed: %d", ret);
 	}
 
 	test->priv = input_dev;
diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 24c2b9fa61e8..9cc86a402c34 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -60,7 +60,7 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
  * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
  * @assert: The parent of this type.
  *
- * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
+ * Represents a simple KUNIT_FAIL/KUNIT_FAIL_AND_ABORT that always fails.
  */
 struct kunit_fail_assert {
 	struct kunit_assert assert;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87a232421089..774c42721412 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1193,7 +1193,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
-#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
+/**
+ * KUNIT_FAIL_AND_ABORT() - Always causes a test to fail and abort when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an assertion that always fails. In
+ * other words, it always results in a failed assertion, and consequently
+ * always causes the test case to fail and abort when evaluated.
+ * See KUNIT_ASSERT_TRUE() for more information.
+ */
+#define KUNIT_FAIL_AND_ABORT(test, fmt, ...) \
 	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
 
 /**
-- 
2.45.2.993.g49e7a77208-goog


