Return-Path: <linux-kselftest+bounces-9971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0B8C1B7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0721283FF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563F13F42E;
	Fri, 10 May 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcyRJtaD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8C13F015
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299918; cv=none; b=VLrhsiTNKXlW+p42VmzkaBCL2dj/oQE+AGKooEE22sQrVYyLYmAgaShg5t38zH8xNNULLx8tE5lcLnOqV+AdPqWuHhxDTkLQi8EkXkU0ZsHreTaC336s7rWbALt+/VG20NtAh5Nk2NaeCrtXDvHDfP1j2vMh5pJRCG0HfUSpPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299918; c=relaxed/simple;
	bh=3mf9ubp2IjLBV/7FQEFzZTh+exmau0QfS0swO/EUef0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4w92FfDphynW9RJUvJ8E3eDAmYgSYFIvqzO5HJyW202pudk0jxmgtjxoPuoe7BwC/y0Haas0map0F5vm22KMnFbkTSVCrgr0sPUYweO44Q8TljF8KHb9zh6xKIQ79H+xUmBqJfaPP1tHzQOF8daan+D5oY/1MEkuQIOlLcrYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcyRJtaD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61e2b365c9fso1276177a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299917; x=1715904717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRNRq1qF8bny7SXtkZUZA1yyodfV/k2JiC2RYv7Zcwo=;
        b=pcyRJtaD+MBfpyQUNaCSLKmDFpXBKSWrB28+Hi76wFvyUPSTZ+B/FPmmUbk7L+Xv1s
         RXxllBMSm5M+lNt/nks0YMAnyw/z3bjYSegwORhZfNyS/LVih1gbt7dNZqlWm+3QWJv1
         L22EloVEXKXVtAaBUKA4BIgvQKOrfH5etrD+uXCPzmwlcZQXZFOIVl1RuOvI0/3sv4fk
         DA4NjjTEjXSmqmGnp9Q5onvYV6zZ98mwlU+27/y2Bb2EqxeLL4uCYwoLVLvnrneLgE4F
         3E5ETPUziS7YTBtBtJXCgu0R75W5R4Q6UgYqHyFshxTNV+CA4rIJokOXHC2G9/+rQCWw
         ICtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299917; x=1715904717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRNRq1qF8bny7SXtkZUZA1yyodfV/k2JiC2RYv7Zcwo=;
        b=bRQ4BjEFUUQCINSYXidVB/xWIBj2/3NIfJ/U7zRN4nug6pvPUs7e5RTc4j6P4AO/Lo
         +1pjMfqS+YhMREGvoY98dLDmNzIUK3OhxN5n4r4+0xOkxPIfDm1KQL7axWiq39Kdtw+h
         PpnLs+G4R+FQsB+yL3GYeK7AYMJDRU2GEQlwkK0mdYP5RQWw18CM7X+2kXPbRFrHabls
         lRSNPm/4tTOHcrtnjskjRch5z7ws3AACyliN4Wg92jZQd5qd4+p+E8IzWipceJTQMfOF
         8iiG+VSV0kauzbI9cWk+sslJ6JLIB1nzRjVnQFuEo9cwPmPUzKM0zukGBiRBsN+/q74G
         NOZg==
X-Forwarded-Encrypted: i=1; AJvYcCXv7O1n+n0i98jvOkbcgw9yPA3ZRMmBwlvkRGHh+yAu6K8JN/0Mg2pSCfScTA1jaCrv1i/dCn0jpLPGkxdx8412dP8YMPUcaMakpnXJOhkS
X-Gm-Message-State: AOJu0YxDD1uYbQ3mYeQPnNZKURZqq8OQQAhd6aTrvVWMwAVFT/Vp3rz5
	b9rmHGcyX4ixsf+uNeZpz0lFAxUEsTLsksXSUE2aKamyrNI/fy0isqYPrXaUav0eo/V+NwkeTDU
	Ypg==
X-Google-Smtp-Source: AGHT+IHJ/Z8yTZVEty1N/QdZrLUX087HrMPb2W/aoyS4qCIrsBTTBdEKswueVBWbPmwhLdiVqvZ/UOq9Jdo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:503:b0:623:2c3c:ab09 with SMTP id
 41be03b00d2f7-6373451a8bdmr2786a12.0.1715299916621; Thu, 09 May 2024 17:11:56
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:17 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-61-edliaw@google.com>
Subject: [PATCH v4 60/66] selftests/timens: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timens/clock_nanosleep.c | 1 -
 tools/testing/selftests/timens/exec.c            | 1 -
 tools/testing/selftests/timens/futex.c           | 1 -
 tools/testing/selftests/timens/gettime_perf.c    | 1 -
 tools/testing/selftests/timens/procfs.c          | 1 -
 tools/testing/selftests/timens/timens.c          | 1 -
 tools/testing/selftests/timens/timer.c           | 1 -
 tools/testing/selftests/timens/timerfd.c         | 1 -
 tools/testing/selftests/timens/vfork_exec.c      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 72d41b955fb2..5608f2b519e1 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..7f718a3bb043 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
index 6b2b9264e851..0a5a81939220 100644
--- a/tools/testing/selftests/timens/futex.c
+++ b/tools/testing/selftests/timens/futex.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <linux/unistd.h>
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 6b13dc277724..9fe6690edd2a 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..7bc389b05799 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <math.h>
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 387220791a05..7941a43155a8 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..378e058359c1 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..807edb9d83c9 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..675c6a8b2eed 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


