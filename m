Return-Path: <linux-kselftest+bounces-9920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE38C1A73
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27D91F220C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1D481B3;
	Fri, 10 May 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U198Oimm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3A481DA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299776; cv=none; b=bFL9ECyAPIA1vvgAt1L5R2Gp+RaNmL1t2bv0YghprEsAUUKihf7U/F/NQ4MwDVHahWn3YlRFTbmh3kAddllExSZpmHf2/7TVNqPJIYvIwwerp80IpL3/QmSz5D6bsNkQEyD8oXOAOL2gr5u0/uPp07BwcBiRA+cPBvfFak3amow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299776; c=relaxed/simple;
	bh=YVixhmZhRjWn1UW1/nLeC3BNMDVFeI4H6J07JcP3lQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPfisj2jwY/CWJpJ9PDewc4blKfOC551Kl8/gtLuVYIcPc8zZitvL/L4ZLntqS0ZCLX1Wcsaa9iLOq9vBw82p0nctxOFjHKjikOvsqxQ0yuvP2rhroHLihjLZeGQdTyPFBXWb3/SzoCMj1+DslwmW092+WDhH4zQyiebkdurzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U198Oimm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so1504781b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299774; x=1715904574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW3mfjkgd+MZlh3nBATuOvH+NDY42sIa+VAHDQCo4gg=;
        b=U198OimmtKWlCUAo+vQQpwjg+nNJNYdumRKta3qPFf0VQbl/ovFKgaCbN6GR9Zi9Vo
         LsYfKw0TlWBVc9Uk5ehy9VaGKsacw1q7fN5ezRldOJtyfpSyUierBRqNBrchPj/PHCzA
         05hkSzYzgAiNcqAHc2qIgqRO6jdSeBWrfZ0esti4GYUiYaIFvhsElSgd4H5Staqw5xoz
         F6N6jQ57J606nlHiuagf42V86Nuc9MpZOX3PH82tbpQxvlE/Qd6+I/6jvMCiGqfcMz8f
         yneh5z4xIqpC4muPbyDFT8hP53+wjft+zpQgYj5TL3G0FdGq0q8L//vhjf5YyOCP713x
         ZvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299774; x=1715904574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW3mfjkgd+MZlh3nBATuOvH+NDY42sIa+VAHDQCo4gg=;
        b=R+NMj62oqZLr2rNoAoNm5xZnPJ147l5R0sXcJqOVg3rOz2LrpQ96TRNRmQ/hE2/WSo
         rdQ8d8ARU8akF5A8KfcDGcYi9g4oMjnNleFYBGDZ+331TNNkEnZCLRCxl3ospYBw+PZa
         vKVap68wYrJzizQ2W09KK5kQ8TmVIJMGgeaGXt27taW7BASXQtzmnHeZJsFSmgMGxium
         p8kZ8pd0xhoBWGjIVu4kYThv8eVxuh3lqVB1GJCifU5aZ1RaFkH1q+mQktiSRsSQoky1
         TK4pHSCdLOpYM8u9Ky7L90dPyWRL5KQ8xLrisG6oOuiPvOJRVP459Zdi5FV/sd6uA6Mm
         JuRg==
X-Forwarded-Encrypted: i=1; AJvYcCXPkzGFIp5fYEnBP6pwLwEI0L0KgnEoHBzoxJBW/bgVoN2tL81WChbY0cl9phGkAYAqzjRrcoWPJt19EMwCC6V2+erdiSGlEhH1wfO7j1ty
X-Gm-Message-State: AOJu0YwP3jjc9a5AHvF/Eh+HSWR9RMApP3nZU6QmjZ+BaVbD1hgd3Guy
	6x+hQxllvQDiK0EgrII33XKDdnWQ4Z8v4tLcp1e0U6ogN3HxbZVt3/SEVDBFdEhllv3qIv7isAD
	wsQ==
X-Google-Smtp-Source: AGHT+IG+56tzsbyva1ZUQtPuRI+DlskjPnyTRIt8RkIrDnkpdAUoEV1Ksd4/O0D6pcKIPC/4JuC4Gkgv66o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ea:88cd:67e9 with SMTP id
 d2e1a72fcca58-6f4e0376006mr68314b3a.4.1715299773958; Thu, 09 May 2024
 17:09:33 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:26 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-10-edliaw@google.com>
Subject: [PATCH v4 09/66] selftests/clone3: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


