Return-Path: <linux-kselftest+bounces-8680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9348AE0A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC16DB25EE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6D59B4D;
	Tue, 23 Apr 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5S60Rmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE35823F
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863296; cv=none; b=PkFf+2Wp10/LgDOaScLe3Yn5v5LSgcSp/ZeX+C6/ml4cwG6hdDEA0vKngQ+kdJ4kbHdhXg5u/yH+38BNs7leXtVW5Uzt5HYNgxfnAL/EZ1j44E/6T92RRwXjPBTbQi7EqunLKXuWqqFUQgtWkfC9cE0fBmV+BxyVJIACsWWG22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863296; c=relaxed/simple;
	bh=0rV1Ku+pcVQFW3sVe5g2nnNHm4ytFcT2WipJXX42ZRk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gru282T6yUfonR7XKBGQbpbDy+K0/f8KRjLHX7pXyEaRfTjoQ7uFk7w952ENSaIwgkKRuew3qjHU2YqJMuKTsnXC8rh5geunvYp9ZbbW2Zumo4snQAKWQjfB3d5JSCk1k06Et6gY21Z7teka/INXlaHTNoZgGsdGzA/Ch4xIoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5S60Rmp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so8615739276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713863293; x=1714468093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVAaYYUYRjsITzR+rLStFX9oltnbfPIIpZ1fuxXV7XI=;
        b=M5S60RmpzD8ZgBm3CSJU+/oXKdMchLrX1cFpQGpFulesF/MfM1Akkbt90ys3wkTRIu
         1jaTJrt2AO+9rRc1i7JAkV1qTmE9MklvKS+CfjrsR1U7aCrEyc1rYyipY27QP8B6zTVr
         Hzjseug4YncjOFim+3t1lqdy7YLUadWhmk3uyv7GqINASNR5OeOEiLbfnN8+quDR3XC2
         UZQCULFZ5n6B//Xg02QifcAWoiSmHx5S8nduS/KWRAd27+IpnGn0M4BbsYm/zv9p+98e
         nT7IX82+J6WfQOi7+hKFRQ66AhZGHwfL8MgLgGN5VjC2scMb/oPQO3EFvmQq+VwZ5lCT
         86uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713863293; x=1714468093;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVAaYYUYRjsITzR+rLStFX9oltnbfPIIpZ1fuxXV7XI=;
        b=cvvgVNKTYUhABOIQL/9NaSyPVke8gtt7uEI7WsYML8+jgB5Ti5H5FnX7TD4ebTolTk
         eWjAiBSSt9ntyZDKjMLP05g6fWW6veDaZEEkRkbk1UWwrwpV8m1pOcBtDLDIiRKBndem
         MqTDtVu/flsnbHOS91mW90qAR7kxBTpylaYo6Fu3ZWmwwG6b58KRuVOd9wfmoMnuiFV/
         0gRcJjFMeMujiTxa/Moi8Frlzk2OvNDchCCwJJKgg1wLNQ5xMR/c9eSP0vJf7HNANLB0
         A7uYOhSEkpIIcHl9x4bKzH+O8DZkc11WEoBpYgVEWZqi+fucuEK9RqKCExZ/C7hnqp2i
         oI2w==
X-Forwarded-Encrypted: i=1; AJvYcCWKff70LbYsMx+8hNrQrEgnhK2AS4FigAyHJCWQVFK2RmUh/opBgX8ZalMZFDkkrqRXNyNPyrSE11WbukRVU98xrRbfVP3EsjYzzcYgYp3E
X-Gm-Message-State: AOJu0YwDHhJWAoDYZr4ym5qK2J+VXBfvAqHyDHI6lHAUIzoux8JoBci9
	4WfzDtxLNGNHxNVXQOF23/1tK0sXxiz2qCafqLs1cichQSbHD4hI2KzI79sDtZbKvB9XhQd3RL1
	7i7rndAhgCA==
X-Google-Smtp-Source: AGHT+IFU0jlOyX9I+mwd40yApvsRfjBwt5t4OBU5P727dBTc45GWW4TdEtasewfwzzhy5LM65oNmgOpmVDst6g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1023:b0:dda:c4ec:7db5 with SMTP
 id x3-20020a056902102300b00ddac4ec7db5mr691696ybt.4.1713863293622; Tue, 23
 Apr 2024 02:08:13 -0700 (PDT)
Date: Tue, 23 Apr 2024 17:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423090808.242389-1-davidgow@google.com>
Subject: [PATCH] kunit: test: Move fault tests behind KUNIT_FAULT_TEST Kconfig option
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The NULL dereference tests in kunit_fault deliberately trigger a kernel
BUG(), and therefore print the associated stack trace, even when the
test passes. This is both annoying (as it bloats the test output), and
can confuse some test harnesses, which assume any BUG() is a failure.

Allow these tests to be specifically disabled (without disabling all
of KUnit's other tests), by placing them behind the
CONFIG_KUNIT_FAULT_TEST Kconfig option. This is enabled by default, but
can be set to 'n' to disable the test. An empty 'kunit_fault' suite is
left behind, which will automatically be marked 'skipped'.

As the fault tests already were disabled under UML (as they weren't
compatible with its fault handling), we can simply adapt those
conditions, and add a dependency on !UML for our new option.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net/
Fixes: 82b0beff3497 ("kunit: Add tests for fault")
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/Kconfig      | 11 +++++++++++
 lib/kunit/kunit-test.c |  8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 68a6daec0aef..34d7242d526d 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -24,6 +24,17 @@ config KUNIT_DEBUGFS
 	  test suite, which allow users to see results of the last test suite
 	  run that occurred.
 
+config KUNIT_FAULT_TEST
+	bool "Enable KUnit tests which print BUG stacktraces"
+	depends on KUNIT_TEST
+	depends on !UML
+	default y
+	help
+	  Enables fault handling tests for the KUnit framework. These tests may
+	  trigger a kernel BUG(), and the associated stack trace, even when they
+	  pass. If this conflicts with your test infrastrcture (or is confusing
+	  or annoying), they can be disabled by setting this to N.
+
 config KUNIT_TEST
 	tristate "KUnit test for KUnit" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 0fdca5fffaec..e3412e0ca399 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -109,7 +109,7 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 
-#ifndef CONFIG_UML
+#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
 
 static void kunit_test_null_dereference(void *data)
 {
@@ -136,12 +136,12 @@ static void kunit_test_fault_null_dereference(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, ctx->function_called);
 }
 
-#endif /* !CONFIG_UML */
+#endif /* CONFIG_KUNIT_FAULT_TEST */
 
 static struct kunit_case kunit_fault_test_cases[] = {
-#ifndef CONFIG_UML
+#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
 	KUNIT_CASE(kunit_test_fault_null_dereference),
-#endif /* !CONFIG_UML */
+#endif /* CONFIG_KUNIT_FAULT_TEST */
 	{}
 };
 
-- 
2.44.0.769.g3c40516874-goog


