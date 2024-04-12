Return-Path: <linux-kselftest+bounces-7741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354A8A2411
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5221C218FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92B11CAB;
	Fri, 12 Apr 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0d1LGDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039412B79
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890752; cv=none; b=CweWyMbAYGCecPX3g0ZSlO+W035cgZSUoYPMtb1YqZ8suGr0YXsnkMVLhmiPZQISMSIM6aH2VL5TBiRSATH82ZEj55g7Kxs36/W9ToQ14FhDz7h5tG+rhZXQpVWb3wxhi5bG+P0rTydnfbGHa8lsF6qIycTnACatFySTZZpxtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890752; c=relaxed/simple;
	bh=hrqmwUE8fd1mN84iAge55zIcPoB9rx7z4jD8bJyRNiI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UBwqKQ9xTXr8+JlWdIYW5Ec9JSXR6k4WZz9RkPMtjJpEz+O4E8x5c3RkHcyhkELUG8P/K8YPj5UYZKFrA9bgt4hG8p3zJwUA23XZ9kgz0Q8Edsodf8+FdhwiVhiznPyYU/fXJf6RCeB7JjyxnYDCcrDrgKAFnjQuZ/q0lfcfnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0d1LGDh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so701360276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712890750; x=1713495550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6pnMn18AJQJudL6vSBz3NgEO0nPvsr06Y+BmA4MJEs=;
        b=h0d1LGDhmNs6BqvmFFtJGU2b3eS79aRYAsEXsf6SLBXgLN4GetzYcra2fDoNG37bzR
         D686/wr8KX7bR2DT9NEj2GWcTySg64GvhUDVmSAuBqu+93q2E0MgfWsyzyPeqexCtD60
         2liT5Ac8XQHEvj+R3vIRCc/qYdYGTLF58nFaIBJfN3v+moT1C6XKV/67P5ZZMocw5j1F
         G2tqtG9JzQtM3QvsRYeEI37TDTaPyAGvdVc7Fta5vrxxK8tLtmheSSD+j0cV6bJ6IRjK
         u1WWjUAzHwN7HB/PKiajkA6yhWi/nJYgNivfPH5YmKtnwLChUPSwHNy5Pu22rjhlMd6n
         wahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712890750; x=1713495550;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6pnMn18AJQJudL6vSBz3NgEO0nPvsr06Y+BmA4MJEs=;
        b=sReVTie4sql9Bh9MVTVCUglF7xTb8q6S9w+2sJ3tFEjCBZbHCyoIdbVmMyJecbRWF7
         kNUNjPLFg970+HwAQcYZ2DxGbN2UaSZFoZtNXnMjVB/2Hs+rmfEbdImbmJPDIaYGs0R2
         IQ8bjAdZltiEyJ92QkECQaQQtCU9hEubTS0lB/V6DUU+N+WdEAwQx6lUqOXzSu8MRu3F
         JVJ83GYDNVJ0Gi7ltaPc/AvZv9concxDXB3KA6k73vPymOSnqHOAIyM8DQ5zQQfuLFAU
         2USBtemV7OByeg+saqqPElj01LUv+mzWjV6tooUg1QN06RPtjRdaukjHyIOWcXJH1Ldp
         cGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVu8GXN9L6AP6vpArOUvr5ajB0oub3ZY7uep12PqYNeSkCoH3Qcq3VfavTGzklQDy3DcY8ySSgYlkmYHg+p5GSwHS96bvhtW8GV920Obp
X-Gm-Message-State: AOJu0Yx9+OSUJQ3njq5c0DgbLQ0xGL0y33xcvDfTU7Vzc2JnaFfubhMV
	PR8j4+De3LOf8SlyAbSS/rj85wXf22CbpSFW4Gs5RkEEdxFM/2pkoMlwGrX7ij301n3zlmZJ+9e
	usPPK+XWpnA==
X-Google-Smtp-Source: AGHT+IE+rLw4/WNq/lOIj0dIsfJTt0mD9xMOL8JlEywxbKsGGpQsGsw6MB0ICLRb0eflzl+Qlv9lKoV1g9u9Mw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1027:b0:dc6:dfd9:d423 with SMTP
 id x7-20020a056902102700b00dc6dfd9d423mr142022ybt.3.1712890750037; Thu, 11
 Apr 2024 19:59:10 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:59:01 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412025903.489470-1-davidgow@google.com>
Subject: [PATCH] kunit: Fix race condition in try-catch completion
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, Will Deacon <will@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

KUnit's try-catch infrastructure now uses vfork_done, which is always
set to a valid completion when a kthread is created, but which is set to
NULL once the thread terminates. This creates a race condition, where
the kthread exits before we can wait on it.

Keep a copy of vfork_done, which is taken before we wake_up_process()
and so valid, and wait on that instead.

Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/lkml/20240410102710.35911-1-naresh.kamboju@=
linaro.org/
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/try-catch.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index fa687278ccc9..6bbe0025b079 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catc=
h, void *context)
 {
 	struct kunit *test =3D try_catch->test;
 	struct task_struct *task_struct;
+	struct completion *task_done;
 	int exit_code, time_remaining;
=20
 	try_catch->context =3D context;
@@ -75,13 +76,16 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
 		return;
 	}
 	get_task_struct(task_struct);
-	wake_up_process(task_struct);
 	/*
 	 * As for a vfork(2), task_struct->vfork_done (pointing to the
 	 * underlying kthread->exited) can be used to wait for the end of a
-	 * kernel thread.
+	 * kernel thread. It is set to NULL when the thread exits, so we
+	 * keep a copy here.
 	 */
-	time_remaining =3D wait_for_completion_timeout(task_struct->vfork_done,
+	task_done =3D task_struct->vfork_done;
+	wake_up_process(task_struct);
+
+	time_remaining =3D wait_for_completion_timeout(task_done,
 						     kunit_test_timeout());
 	if (time_remaining =3D=3D 0) {
 		try_catch->try_result =3D -ETIMEDOUT;
--=20
2.44.0.683.g7961c838ac-goog


