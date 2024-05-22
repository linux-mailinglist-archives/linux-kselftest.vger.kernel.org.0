Return-Path: <linux-kselftest+bounces-10546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78E8CB82C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2541F27B1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E49158DA2;
	Wed, 22 May 2024 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlZBA4Uh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AF158D85
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339744; cv=none; b=YIAVeBMBiTHXXHWRK7RUrdF2gVTSgj4eCau46LjImuVtx5K2rOCQmPWnyauGHNB+cNy4aVIS8Fdp1MsqpXclMU37Tj2AaDmucOQMcK4wGxzOC9j7KxAf/vh2bD2WI/xZI1CS9wZLsbAJTqmVT4BMpPob4zYZNARnSQTjLf/LObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339744; c=relaxed/simple;
	bh=mpbP8rEr3C0vbeTbWGYcRrYPwWGHWpMy1BoxidaCGBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7opDoT4GYaeVfB6ETB6BVSGIl5y0usPWN68k6l6FqZfWtw3dXZ4wGd7D+xIzqttBpSSoesU70LnHAmZBiKPsguByZ6kWIi2CY9GjgDkWWx3e4tfY8ChREniaNrmYXNj3Dw8/g9UilOWKANy9uUz3MyzMug+Q7AYyAZvSai+9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlZBA4Uh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-65789db0259so6462801a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339743; x=1716944543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14hyqItgH27nXrTOpySK5+rM0Eq8K4UXKAFuWetO8r4=;
        b=vlZBA4Uhl4IIn9na0IneEgwSS5Yuax7MgmiiIMuLcNGDzdDLVE7qSQK7mE+JJpG7Be
         IiQ27jIfty50TcGV9u9NBdWYB1jUSvPamJUsiQPc3neiR5qKKrkD+SzHVdg31Q/m17/r
         WzGAdhyuewKSstPVkxaNrpRwM1QYesydst0jCm1HMhLof/WFi8K0Pi176M7S/PGLDsgY
         8sA1PFzDrJuU6dYgRjZlZ9PKaFUVKeNR/HPH3uvfpSwFdSqz04DtXD23uHD5tiHRH97T
         Q6EC0c3iBrMWijEX6jlMgteJo93t541IbKJ6gzPioTSMDU6eOouiYVU+vJoRWX8Lr/lh
         rwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339743; x=1716944543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14hyqItgH27nXrTOpySK5+rM0Eq8K4UXKAFuWetO8r4=;
        b=tTsp6w72OiReEBu2hxgpnqa3r3h5A1s32kw/MBEbAKSEO1dwNAAlhr4ZUH2/94WCaf
         IffBHLXtg6T3I65tJl25Iqm/tEqKfJECGM9RoQTCjS4P8J8GlhTCi39kptAJ7HNglE0z
         6ASPMRueSniGpkzzL8ATHLCsiERgLDSBd+/f/jVcauqTcKvQtMNA5VFbnUDdfoFTjqkQ
         +D5CnkN9dy+0Gr4emWPFSmFfk3W8CzwcOT826YT1LmtMInf79mcr3LOFNvMY7Fhf0MCX
         8t7AZUx+KUz7Zm232ywAXBVnU25K76MsK9jlBkBcA38iH9BIv/lY3ggq/sxTx/7kPglN
         islg==
X-Forwarded-Encrypted: i=1; AJvYcCWJIpea2sbJOUgjCgFGTz7okbelCayoIu0j5ZKhB3q1BveOZKQN9a4DCU7+HFYa+3DaWHhs4vExzTEPPxtVfB7lsL9lPTVAzTutzXyD3Yzx
X-Gm-Message-State: AOJu0YwyRqtL9zL24oNB00KmWsJQck51ePpr1l4wkYl0lJ6mA4wbS/zd
	oSgz6srPQr0aOV/Bb4Iq69vNCskUNgJ2M2Jx6QAi25/ogGVWH0AIPwpCOOFCPq997fqIwBQX+Cf
	/Mw==
X-Google-Smtp-Source: AGHT+IGgEz8vQb6kJDfYmepGef5RK+eICK6sJFyqtVp8ack5BW5MAFsWuVTX7dDchbUYTS8xXBgD80Wr2iA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:60a:b0:5dc:5111:d89b with SMTP id
 41be03b00d2f7-6764dd9810cmr1252a12.8.1716339742654; Tue, 21 May 2024 18:02:22
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:45 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-60-edliaw@google.com>
Subject: [PATCH v5 59/68] selftests/syscall_user_dispatch: Drop define _GNU_SOURCE
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
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 --
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..758fa910e510 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -4,8 +4,6 @@
  *
  * Benchmark and test syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index d975a6767329..76e8f3d91537 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -4,8 +4,6 @@
  *
  * Test code for syscall user dispatch
  */
-
-#define _GNU_SOURCE
 #include <sys/prctl.h>
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
-- 
2.45.1.288.g0e0cd299f1-goog


