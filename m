Return-Path: <linux-kselftest+bounces-9975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4E28C1B91
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5475280E1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94F14290A;
	Fri, 10 May 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAtmuD9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BF1420D2
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299928; cv=none; b=ntaknQxRK5HSCxIL8583+Um1VMdqwUn42ip0R+ywpeLkKuEVl/GAev6DjG/UFdCrkXwaDzvQIj9uu4hImLFM8Z+z9lR6SCV2dh7GKtoGw/JR9fgWiC6YqxZ5R/p7wJ1r+NUxylf7ZyPI73HZ/ArOb/yQBZ7zZlQP/qxZKAQC3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299928; c=relaxed/simple;
	bh=cY1yLjDVOZyUKN7zy3cH0I6yfDbGKSufrusCzHder2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fnFbboppEjm0ph7HiX8p95S1+JDhaO0wmwVbPIDBZ7TEEDDUrKXi6WkTAWq0VTCyKdtdM44LKUe2fih07TBIJo9VNSjtl5pJ6PPNu2WGZXPCRAyXEt4/ekCJa/14AOaDCCNECAhMEZl+/BRX5nK+e75ZEmJUOy9xLPjUksq6zNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAtmuD9W; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46acb3537so1038161b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299926; x=1715904726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+/kjO6igpY5Z9IiOKAmMz8PNt+9Eolw6t7DBSMXgDQ=;
        b=EAtmuD9WCSKsTAnkTmM1crXLqjyHlaYH7cg8jF9zWPnpcoKSaJa5NQ8TpIX4K+ZdEO
         djjWGkIe9TQfNArCNwaDQSzEK2DhQHaGEy7qIZqN9Yf2ibkx3jFgQcuLFCEOTZD/cfSI
         8GQC07RRQnBFEWEqtPi/zxLmO0GbvgT+if54SKdS50NbXZ5FNqLniKAOuG75X0esoOIP
         maDV9Jg6AQul8dMw7tKBpsJZ7AzoNLzEKC3NYnctIgzmzFyfz15OmPIy+ob2jt2EC4at
         FOQHtWdbjel7Qqhqzj2mG3iJINrPj9xA1yXuAEgPlPQhntyenYijZJEindY2AnYn3akP
         FdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299926; x=1715904726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+/kjO6igpY5Z9IiOKAmMz8PNt+9Eolw6t7DBSMXgDQ=;
        b=awHRkDFHxUqnwAkKFHN78d1BNeUB9N7XfmtMcPOyazSNibRXfAYyCbLY9XoPfM3DmZ
         P3EryrIpK7eMS1KofLabZPZtk6kq/nEU7SEvsEMzQQODM45pErNyRdmGQHyba9ixPqTA
         pFj2gFIvceAl291MFbJsGNVBm2NDd1Pm3LN1suyF2dEUKAJ/5fHDQMSMN53ZFLB6A56j
         /muxC7q4/V90/mzLG5mWXaAR3NOuU8X2+o59Tx6W8bglslwKsNjJAsS2gAyRTpuM0wah
         /LQvN8UCP4hT3770LzpXnm73wcGwqCCg92jiWKfx67woOA7jRYbHSbMYYcYNiusPAqcE
         Oulw==
X-Forwarded-Encrypted: i=1; AJvYcCVGqfuo1vPoJPs2c/Tvp6S3ABPkqj4IcIZhws1MzDeUSC8munC+UyyNAgNTaNJ9szJGmpS4iyCXK3Or5Bsz/uOJqXEUelih8n2hRQt5I19f
X-Gm-Message-State: AOJu0YxIu6i3CJ4KL8a3t4pBnqizL4kjoBoIHLincelIaiqJjShgjArH
	DkR/0D7S4LbLvb5MXVgD5wHnY+JjwT4p0jk8H66x66LNl2t7D++o2HPhUqcO4YzqTAEbF+no/MN
	O2w==
X-Google-Smtp-Source: AGHT+IFqVJhwpwwqiHXuwXmYYl8rNoTCx5/ixsGah9it9PhH2pp2rnYEYGHSA0lrqROCVxUa7NHIESir2HY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3992:b0:6ea:dfc1:b79 with SMTP id
 d2e1a72fcca58-6f4df42b865mr83743b3a.2.1715299926061; Thu, 09 May 2024
 17:12:06 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:21 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-65-edliaw@google.com>
Subject: [PATCH v4 64/66] selftests/vDSO: Drop define _GNU_SOURCE
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
 tools/testing/selftests/vDSO/vdso_test_abi.c          | 1 -
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 2 --
 tools/testing/selftests/vDSO/vdso_test_correctness.c  | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 96d32fd65b42..fb01e6ffb9a0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -14,7 +14,6 @@
 #include <time.h>
 #include <sys/auxv.h>
 #include <sys/time.h>
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cb..f0adb906c8bd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -10,8 +10,6 @@
  * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
  * Might work on other architectures.
  */
-
-#define _GNU_SOURCE
 #include <elf.h>
 #include <err.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf1491..c435b7a5b38d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -3,9 +3,6 @@
  * ldt_gdt.c - Test cases for LDT and GDT access
  * Copyright (c) 2011-2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <sys/time.h>
 #include <time.h>
-- 
2.45.0.118.g7fe29c98d7-goog


