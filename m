Return-Path: <linux-kselftest+bounces-11225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9258FBFC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 01:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE553283178
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 23:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB714D6EB;
	Tue,  4 Jun 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htXTRpR4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB51442F5
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542997; cv=none; b=M9JoOXky7J4X0D1yFYJAkEtlB5kg/A2R1VYsGkIyqvKr5lokbHZlecgenLBOZ9IILouihatDovO9d1CIb6L7k/yVDRKIdIZzLjYDzaOxKtHqClBjTyoVaYcUezpBCIsj1ViVkGujS8OYh0cEWgs/MUl1ApW/Xn9KVvK9N0F5pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542997; c=relaxed/simple;
	bh=d3KD+dGdQ4ZHnHhSkskyUBnHOtvBSxNQVc1S9GV3jlM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QCjlivL1/ILEVXHH8iWVQckG8GWOHIK6oPHlNmHrKqRluK4f6KvrGDOuUXrBnuua9D85SaOzZlhEKSZGROlRJt/OpNjOQgFU/autZI+I4BCyBSVntMe4KckuJuXA9lK+cdrqPwLIwpp1eFxPxYk1+bct/z8Kv3QSTF3fmfUrEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htXTRpR4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e4afa326so25043767b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717542994; x=1718147794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZNrZXaQe5QjyrPFceQH2LfhlF3G2burIHCEgVqIZ78=;
        b=htXTRpR4QIB4i1YJBt5laFa6GBBoLwVvJZTLsxPx+VbyK3eL9dVoIVFwert05DLdW5
         cbFRoGwhGbGAzJH9Kh5wPmZKU3etS5ECGnpJzQLl28kM3Cr6XUsoiGq2WtgmitRa6nvw
         so1gqxJV6GH6Y1TLqRuVMgeZnfckPQ6bMLuw27MbXf0oBJIcuSeT+r2Dz11smGBkobNF
         u/n3AYhufEeMK3u3dqAeIaRHz4sjUPUYIEXB9KTXs3n434aeX/19C1nxzvl8PjUWI9Dv
         91z3W2j0l0Ophb7gAA+P1AoEH4q4zwHbcPBxdfvneA4j0Sd+xVuuLZSu933AcXb5BNg9
         XSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542994; x=1718147794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZNrZXaQe5QjyrPFceQH2LfhlF3G2burIHCEgVqIZ78=;
        b=Dg74MnnaO5jqDrr5RvvGB58Ek9A8XvMvmaRZ1swkNv+JMSvNpgEXWRSz/pY+tvJRe+
         xOORS8SFad0F5oXBHRLKsWX9ytatO8PzEnwWP4xQS1wxS39qhbnX8w7cRQ0F1Zo2wh0K
         qXyHGj45isXic52OSCbMOHgvj/A3jGCzPJE8xQ9dBxUnSEo1ac07zadLCmoFzfrF2j18
         A23e8m3GQ9N+BnrSGpcjzhbF817K/l04+xL0zFFhLxYuzQASKcUpZbtdWfKFyO6p47M6
         RJ7q9jLAWbIQNyKw2bo5LC/eK7oADYpyoDLuSNOol+ENHxeTXuhTT+9O1VhLBVB0tqbJ
         nsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX00PfHAb7cAHzfShq92qzOMSXayUGrvgFXwOrixYjHf5pXLKBHIh1lsK3WxS40lsBDZMWiAzea08Ktj/dfiWCMVBDejKE46nuzXCs/etS
X-Gm-Message-State: AOJu0YzCB7uKcV289esqocb7qOnDJp26yfFtdieCsX5InueUIFRtpRhG
	aqjEivXKjyNhWqvxCAJtA9VMUnfwnLvcnBOfnQLf6sW1viKVnZU959a00rSv7SeSeZZotA9su+s
	m9g==
X-Google-Smtp-Source: AGHT+IGjXoXe+YCWwO+tWw0X7qGEAnModzncTc1ziQR914tc4YoJFWMBFQKkS7uv8fTlHNhwtR04tsmeZDo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:887:b0:62c:35fd:678b with SMTP id
 00721157ae682-62cbb5ab5a2mr885387b3.8.1717542994498; Tue, 04 Jun 2024
 16:16:34 -0700 (PDT)
Date: Tue,  4 Jun 2024 23:12:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240604231219.444603-1-edliaw@google.com>
Subject: [PATCH] selftests/timers: Guard LONG_MAX / LONG_MIN defines
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add ifndef guards around LONG_MAX / LONG_MIN defines. When building with
Android bionic, these macros are redefined because bionic's time.h will
include linux/time.h, which includes limit.h.

INFO: From Compiling common/tools/testing/selftests/timers/valid-adjtimex.c:
common/tools/testing/selftests/timers/valid-adjtimex.c:107:9: warning: 'LONG_MAX' macro redefined [-Wmacro-redefined]
  107 | #define LONG_MAX (~0UL>>1)
      |         ^
prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:47:9: note: previous definition is here
   47 | #define LONG_MAX  __LONG_MAX__
      |         ^
common/tools/testing/selftests/timers/valid-adjtimex.c:108:9: warning: 'LONG_MIN' macro redefined [-Wmacro-redefined]
  108 | #define LONG_MIN (-LONG_MAX - 1)
      |         ^
prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:52:9: note: previous definition is here
   52 | #define LONG_MIN  (-__LONG_MAX__ -1L)
      |         ^

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d500884801d8..3d9f1baff86e 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -102,8 +102,12 @@ long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
 	 1000 * SHIFTED_PPM,
 };
 
+#ifndef LONG_MAX
 #define LONG_MAX (~0UL>>1)
+#endif
+#ifndef LONG_MIN
 #define LONG_MIN (-LONG_MAX - 1)
+#endif
 
 long invalid_freq[NUM_FREQ_INVALID] = {
 	LONG_MAX,
-- 
2.45.1.288.g0e0cd299f1-goog


