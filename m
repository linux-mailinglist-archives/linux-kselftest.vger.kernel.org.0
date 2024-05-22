Return-Path: <linux-kselftest+bounces-10497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF78CB727
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DEFB24B2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493237711C;
	Wed, 22 May 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MC5nN8Yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8174BEC
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339605; cv=none; b=lBmOu7Ht+FxeK0wjSDJbfpplKgGWgFHAPv9B/xev1zUj0mvZqxIuv/1fpvipf+v4cLeVku1fm/Vt6VgrDSmK4Fg3YFwbwKhmawh89VBQGwdNoVKqRpg1fxMRZ1m64dr5Vf9DSvSIEqaCZXZyQWKYVSleV4gZ3Rpi3AQT56zVlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339605; c=relaxed/simple;
	bh=48j0kBVIuwpXnzwPdE9EQKf+xvifHDss5b365P6opso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XmXZlZES1Gq3w0zl8fGx9GNwKb033uax5jzMques9r0QX8rgWGKHrV8c5yddUKQUTaPgtrs2EWwc/0NK2xsQV2kXn32SBlMv8VHIZXc5KgbhOsXm8i6pITwAIfnahNehGbIqJQHaQtAYb3qiGYrf7CEOnpfvZ+94vamsPNqo0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MC5nN8Yk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f46acb3537so261275b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339603; x=1716944403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfexs9UjGmBXqFDc3RmOYfuuIPIjhIku4381mEPxmek=;
        b=MC5nN8Yk+V1tBtvhXTPyW8RnlD26+YaQu/KDz6C/esic2/eGXIhIoPvgFLTUXs6r/D
         wabIolgZnXM/5X6tVAsW+oVikpliZf5whLUOnwUM5bsSlUu7PZTYQEOPrr6QDYAateDi
         nRvGKGUuGrx6BoYGQNwM/bRg+0sA6W/FksH7iYVSn8Dmt5A7A4ZcqXU1HW/oX2V1SacC
         eUC+OQ4ncDzJpN5N+6hMaiS62s+t0xnasyWi2rSxgNJ5qSeVxQ7AqIApVrES/3V3Q+qg
         iMKQ4DCCGkYiRbz1LYeQ4AS5nwTJCtLCoMA8A9e9+Yv6JgO9FnwQ02/16O/OsmMqXQvG
         xp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339603; x=1716944403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfexs9UjGmBXqFDc3RmOYfuuIPIjhIku4381mEPxmek=;
        b=U/I9HSpjN4zZrqZIkeZFmdT9TXdc2Rhp1314XGtVmk9VR/NQsRn190bWaaCtyXGZJJ
         wYCxpolnmE5d3hZgo6NpIdCxwMrH8NDl4dBF6lKucOS/21j4vrNFaiu6IsfmCPfN+ZQo
         bBvVCWlmChydp32xzw00Xz8mDYwB042twREW+CimWJSKwI0arQA6wrXpRNC/61g5ojre
         PPaZ7YsZFDu0CDRhVIfjQpHNqaaey7PdPfq87CO8cjm0Fb4nsww34enUFZvWbJKuxKDG
         3ySpMz8oqIRg2CLkVnaQY9pYVBB/tRrj1RkVdDeAPYKC3Uvc2CDyMjY3AHtJElouQA7o
         ZiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW98ccmRCAbWi5UHNjl93rOVggt1pgi3eWG7g3c+zKdlut2UtMxhjDN4V86m6O5ScwCi1yFBg7PmDfX2wU5CJ+PQdfAjT2r5FlSimt98qMT
X-Gm-Message-State: AOJu0YwqJVZg9AxRHEYSH6QCc3xebOLmXX9aTWbyflaq3xPAsCAhzpT8
	uUPzUHEoMWv4tgh7QALgtuvnc87w5t/h7t3sOY+2azTQuCnS5wnyry0ItJVTcNJZrtxP4MU05HJ
	bcw==
X-Google-Smtp-Source: AGHT+IEPkERz80TavebKf8h6ivCdraONOXoxyZx+85NntRxFKBy5lPixdFq9EghEr+xMMbOlv4i0i8mXE/M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:8b87:b0:6ea:df4b:86d0 with SMTP id
 d2e1a72fcca58-6f69fc55137mr43971b3a.2.1716339603118; Tue, 21 May 2024
 18:00:03 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:56 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-11-edliaw@google.com>
Subject: [PATCH v5 10/68] selftests/clone3: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/clone3/clone3.c                        | 2 --
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c | 2 --
 tools/testing/selftests/clone3/clone3_clear_sighand.c          | 2 --
 tools/testing/selftests/clone3/clone3_selftests.h              | 1 -
 tools/testing/selftests/clone3/clone3_set_tid.c                | 2 --
 5 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5..ce2c149dab46 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Based on Christian Brauner's clone3() example */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 31b56d625655..bb99ea20f7d5 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -7,8 +7,6 @@
  */
 
 /* capabilities related code based on selftests/bpf/test_verifier.c */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index ce0426786828..8ee24da7aea8 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..172e19d5515f 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -3,7 +3,6 @@
 #ifndef _CLONE3_SELFTESTS_H
 #define _CLONE3_SELFTESTS_H
 
-#define _GNU_SOURCE
 #include <sched.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index bfb0da2b4fdd..a6df528341bb 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -5,8 +5,6 @@
  * These tests are assuming to be running in the host's
  * PID namespace.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-- 
2.45.1.288.g0e0cd299f1-goog


