Return-Path: <linux-kselftest+bounces-9951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3716C8C1B17
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E751F26BCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FD13956C;
	Fri, 10 May 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI/Fccnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCAE1386DA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299864; cv=none; b=ZiacLhMHEiw+Foqw1+SfECdTmVQnQiqf4e7rApZoLbZFxlipTp7MmWA2g4qKAQfPo8WB2+4GKUgAmVJEvQogyNOqVW42u2IvzFjONkUX7iwxjTEyNe2YrSgZVIuXIxueTZOEuoEyLe+Twl/RbRJpFu12qYQ2AghnAP8ayW3YUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299864; c=relaxed/simple;
	bh=L2xiJs0pvkHTyYEWb/dHuPHUb0aoyNpUC9tm+GW7Yvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKKlnZc0yELo/VGZthpeeI1mGNLxsLQWQbhUKiIMD57AXb+QHlhT2p+POML5N4jW+JYGxFgZ1dssMUE9MColI2chlWbj3PPbm0TGKYeQK3+SEcfiwxHktiwxdDOIR37VH7IGlS3Whg0/F0PG8nTxm0ALcgBUwbVVVP7nAlHX/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI/Fccnw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62079696c58so25830697b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299860; x=1715904660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D5J95pTto7bxbDE1cccaXNIpSHnuQdMjPAvgEtW+8E=;
        b=ZI/FccnwydftpCTsWBICZzni4XlznE8txSZti84AyoJxhIecc0z0YGcPKdGW9T/Bpl
         v3ZUGwVxpqACjDO/HeIIaO9bjIJfHT5bhLLnwh+aZZNiHWcm9nIsa5MRQUXzhzC6Jo1A
         PbNHYTHe7Zopr2w/USQX4txe2oB/XUTly36WbGaWZL3NKB4rahhd1t927SRfT05Lq2Ae
         uFTYJE7f6PAO2Bpt672AO8L7rbqqUjoQtKAde7FGHGS51593cnG7/SnNVOOI+5UCu0dG
         JVTf0orCWc8z8ajGbafb24kk38e5wSkqzGlbDmD/sq8oXyhbC0mECAI3Zxzc/gh1DDBe
         fHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299860; x=1715904660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1D5J95pTto7bxbDE1cccaXNIpSHnuQdMjPAvgEtW+8E=;
        b=I6TdDuAq38qtMvrrOdgvy9+6Cd3cPUZCON8TdoqKNSjgrB+jpMLLZBislRl93BI79X
         twjclIaTlc1okpLUoqaxIO0uOxm6nJcYot3L5Q6GYdD/KCDwD4YyQssiCLzvGYTdpQap
         kj540LwT2ryJv642A60zhuVLCTgaiZFfi/3BDEVJxeU8UV55t2SzYUlWuZArM4EJcUcF
         0/iVSTmsBikLg5DMmDjtAdMiIb89NiFkea3OKFafWD5xWcMtPS5PotZGhmbeEQSQvi7H
         IhnMhRiGaLENm4Jzlu0JwN73LeqbGxnVt5WdO69vw7SPusHbmffPnTAHDlGQK856/Bej
         F1hw==
X-Forwarded-Encrypted: i=1; AJvYcCWkFC3bCCsp0lCpMix+U9BinTkVe5WpQ91wNljuWfH2+PpBmmxEMYXp4DTncN/N27P9bUAu5yREkBJkmzIzGAoUeww8P/DtmPWxx3ZWpV4a
X-Gm-Message-State: AOJu0YwG/9DOBDzaTX5oCBL0bQVsPafK8tDIl3alEJO28teKtLJcBiEP
	8P4w180XIsh8O2D8lJaYUappFpqLZmcPNE26BKLqHU4akcTD+J2sFp6tJ3GWTTXFrSfcqkk5WWo
	Qtw==
X-Google-Smtp-Source: AGHT+IGhcJ7GjAM6Vy/ApGmusiwwih9+KKpTPcTPYhDNCwh5wA+pqL1DV0C5FY2sheVBHvhFaDSoPDUPtOg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:284:b0:61b:e8ce:18a1 with SMTP id
 00721157ae682-622b016af8cmr2822137b3.10.1715299860502; Thu, 09 May 2024
 17:11:00 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:57 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-41-edliaw@google.com>
Subject: [PATCH v4 40/66] selftests/perf_events: Drop define _GNU_SOURCE
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
 tools/testing/selftests/perf_events/remove_on_exec.c   | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c  | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..ef4d923f4759 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..14d1a3c8cb5c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..19557bd16e9e 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/perf_event.h>
-- 
2.45.0.118.g7fe29c98d7-goog


