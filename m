Return-Path: <linux-kselftest+bounces-7372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BDD89B92B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2F1C220D3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CDC524CB;
	Mon,  8 Apr 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="plIrvCaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EA3CF6E
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562429; cv=none; b=AD5IGC/7JbrjwVADgG+ZFrxqOQ80CZH9UndkiKamH3QxmbkF4vbB+dgPd5j/4AgqOX9eSRK4B+pJdAQRp3xopd8x4+OpaJUHivex15wZdybj5+qtwqSRddITC46R0cWTDtFK+q7SRGROp6+gZ7L8JTGCSruJdNMVi9tOpvk+U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562429; c=relaxed/simple;
	bh=DSVedLN/9sNq/HBRK05msQLVmLdeU8WEsK5nC9gm8+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amd8Um+vzlo/cAAPp3TXGyZVsSnhiYKSksYfFio3pvRX8I2+zDN041UrBq6rQOxdcY9gdZqw3pKZw3brp0YBLt2QmsJU6XtoV3tC03h5/Ti7da1lB2FI11tXVE4wGjgHYhuEempDIgnReU8LsZlz5ob9AfCJt8ryBGgF0WucomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=plIrvCaC; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VCh4f4XSKzLMs;
	Mon,  8 Apr 2024 09:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712562418;
	bh=DSVedLN/9sNq/HBRK05msQLVmLdeU8WEsK5nC9gm8+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plIrvCaCTl2uB50gN84HYodD7H8HQiFSINSoCXMjfQl23eukDoU30Y0Idn6p2DtOa
	 UtzO+MtiJhZ11JPAf8m+J3QpBv/lbHe6RBXHHBM/x0vzZOnTf3s+YTiEkAD1OWFQlN
	 UPGcS4zYrQFY+7jxFjh0nXgSV9ariQbyvbEbcdT4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VCh4d6Rnlzgq4;
	Mon,  8 Apr 2024 09:46:57 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kunit-dev@googlegroups.com,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 RESEND 6/7] kunit: Print last test location on fault
Date: Mon,  8 Apr 2024 09:46:24 +0200
Message-ID: <20240408074625.65017-7-mic@digikod.net>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
References: <20240408074625.65017-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This helps identify the location of test faults with opportunistic calls
to _KUNIT_SAVE_LOC().  This can be useful while writing tests or
debugging them.  It is possible to call KUNIT_SUCCESS() to explicit save
last location.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240408074625.65017-7-mic@digikod.net
---

Changes since v3:
* Improve the try-fault error message as suggested by David.

Changes since v2:
* Extend the commit message according to discussion with David.

Changes since v1:
* Add Kees's Reviewed-by.
---
 include/kunit/test.h  | 24 +++++++++++++++++++++---
 lib/kunit/try-catch.c | 10 +++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index fcb4a4940ace..f3aa66eb0087 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -301,6 +301,8 @@ struct kunit {
 	struct list_head resources; /* Protected by lock. */
 
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
+	/* Saves the last seen test. Useful to help with faults. */
+	struct kunit_loc last_seen;
 };
 
 static inline void kunit_set_failure(struct kunit *test)
@@ -567,6 +569,15 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 #define kunit_err(test, fmt, ...) \
 	kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * Must be called at the beginning of each KUNIT_*_ASSERTION().
+ * Cf. KUNIT_CURRENT_LOC.
+ */
+#define _KUNIT_SAVE_LOC(test) do {					       \
+	WRITE_ONCE(test->last_seen.file, __FILE__);			       \
+	WRITE_ONCE(test->last_seen.line, __LINE__);			       \
+} while (0)
+
 /**
  * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
  * @test: The test context object.
@@ -575,7 +586,7 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
  * words, it does nothing and only exists for code clarity. See
  * KUNIT_EXPECT_TRUE() for more information.
  */
-#define KUNIT_SUCCEED(test) do {} while (0)
+#define KUNIT_SUCCEED(test) _KUNIT_SAVE_LOC(test)
 
 void __noreturn __kunit_abort(struct kunit *test);
 
@@ -601,14 +612,16 @@ void __kunit_do_failed_assertion(struct kunit *test,
 } while (0)
 
 
-#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)		       \
+#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...) do {		       \
+	_KUNIT_SAVE_LOC(test);						       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
 		      kunit_fail_assert,				       \
 		      kunit_fail_assert_format,				       \
 		      {},						       \
 		      fmt,						       \
-		      ##__VA_ARGS__)
+		      ##__VA_ARGS__);					       \
+} while (0)
 
 /**
  * KUNIT_FAIL() - Always causes a test to fail when evaluated.
@@ -637,6 +650,7 @@ void __kunit_do_failed_assertion(struct kunit *test,
 			      fmt,					       \
 			      ...)					       \
 do {									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(!!(condition_) == !!expected_true_))			       \
 		break;							       \
 									       \
@@ -698,6 +712,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(__left op __right))					       \
 		break;							       \
 									       \
@@ -758,6 +773,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
 		break;							       \
 									       \
@@ -791,6 +807,7 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (likely(__left && __right))					       \
 		if (likely(memcmp(__left, __right, __size) op 0))	       \
 			break;						       \
@@ -815,6 +832,7 @@ do {									       \
 do {									       \
 	const typeof(ptr) __ptr = (ptr);				       \
 									       \
+	_KUNIT_SAVE_LOC(test);						       \
 	if (!IS_ERR_OR_NULL(__ptr))					       \
 		break;							       \
 									       \
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 7a3910dd78a6..fa687278ccc9 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -96,9 +96,13 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	if (exit_code == -EFAULT)
 		try_catch->try_result = 0;
-	else if (exit_code == -EINTR)
-		kunit_err(test, "try faulted\n");
-	else if (exit_code == -ETIMEDOUT)
+	else if (exit_code == -EINTR) {
+		if (test->last_seen.file)
+			kunit_err(test, "try faulted: last line seen %s:%d\n",
+				  test->last_seen.file, test->last_seen.line);
+		else
+			kunit_err(test, "try faulted\n");
+	} else if (exit_code == -ETIMEDOUT)
 		kunit_err(test, "try timed out\n");
 	else if (exit_code)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
-- 
2.44.0


