Return-Path: <linux-kselftest+bounces-44642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C423C2B7E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4853A6E31
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1F3054F8;
	Mon,  3 Nov 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7iFSoYt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6B2FC865
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170311; cv=none; b=Sm8yiNoTY98v1k+6vE4ePKjVh31sVjm3KPmWEB3lGn67k+eVsB1ljUQS0NMTXEa+/HG0AqgWBUN6O/TLuneAP/na0z3vH9j4bJ4AWPy+PNE3HiaLfoKTRSUDOeESo6qvbOtkbmUpiBW3hy3OWjpYKRxnCiIXZWDgFqs7ZpdEj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170311; c=relaxed/simple;
	bh=Snze6QioZdunD7PUrwavI51s5kZUyeRbHJ1WZVExJeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bq48YiOWjLb8iCtYE5UMfxR0VjaMy0GqJiUqZI+eRDz+hpYuUYRiblOhuJjL/zrOswMyhXn9UKQgjcBp6D5Zso6IV0tVkNYEo3HYv/tG2/Oe6/gmGow8adUwhPhK+2R+V0nLscBwvGwsPQglyySdDdcz7OoZAJIFt0LGFldWeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7iFSoYt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-783c3400b5dso2819885b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 03:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762170309; x=1762775109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AxL6XsSqUIW3egu/GBVC/mr8ycUobBmvTaoJnifx9U=;
        b=T7iFSoYtQhQBAtb75m0biqcMf+0yUCPE0NjyEhx0TL+BFlm6NQ6S7pr5+2SpFVOUC5
         txV31+abEvAgAl+nFnAVWVk4T4m3lp683itXwISjY2+Njd4yFqgXhL0UNHOP1IHh4NaV
         +oF+XzwI+tJ3RPD8997wZhxqHnYuqDg9BGo/+QCmVLWQiEd9ktEXrn0Ve8QwVzFxeBJ/
         krMeEqLtRib0ONSehsThX1buFzNU1NSdqOKEq9IebOoe+Nir4ZQZkvnY3EAVZpjlEGD7
         CfkpLTnBW7S3uFnpJOQ/2pB41JtYNixsdT5BpF2+BtrpiRlgu8m8OzEFsulC3CPhnmLX
         vv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762170309; x=1762775109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AxL6XsSqUIW3egu/GBVC/mr8ycUobBmvTaoJnifx9U=;
        b=MsUStefDDymmligtmiPv6X1th3OSlWESLDbsfo9QyCxAuYpEDYej4RQ2CehO4psG5N
         L2CpxIwKyrXNe4hgMdR3g85eA2SpanoRzV3JxPjrIOS130nT3s+8Fb+xTPFMyEjjLsIe
         TiBehF60mAENN3rvjVbJPMKxP5xPQmLqhyJNm57tDo4EOtRbLJS2Z/+RVwGW1SNEwYvv
         jU5484mS6OPEAr1qYj+ZOMn5Js07DCzwecLFoUzjXzgS6iUCLxrrS1uhAgzkuoMbJmd1
         jBpHn7ihoqv2ZVrqImhmz4hwSlrcpFYL88WExQPfFEQ+iqlJCu+fCgjhvMjmzRB+vLPV
         OFsA==
X-Forwarded-Encrypted: i=1; AJvYcCX67jop8kPnZjqPi7Cxf8n6X7uKKrsYBgkPpNA+LFsz6ixZ43oMlR885Q/8iplroxMNg5xChUutkrAMsYPh5aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BAtR8Z0yKP5LtR9t485IwHuM1A18pKx4Wdk7k3wxNYVTfC+P
	oaOCzOduD5FqB01IBPWkmRZHfn3OJVssrrDoWlJcXZ9oXfXgGXKoPY0ceYJGm2MpxaQKBN6GgN/
	5zQ==
X-Google-Smtp-Source: AGHT+IHjJmZ9wmMZ2ev1ZeENp/FvTCGuCpK99OFGTZI8mDpUAbscgPDrpPQmYTYpCewECCXeyZRPHMd3zA==
X-Received: from pfbfb41.prod.google.com ([2002:a05:6a00:2da9:b0:7a1:f3d3:6658])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2191:b0:7aa:9e4d:b693
 with SMTP id d2e1a72fcca58-7aa9e4db99dmr5369991b3a.17.1762170309058; Mon, 03
 Nov 2025 03:45:09 -0800 (PST)
Date: Mon,  3 Nov 2025 19:45:02 +0800
In-Reply-To: <87o6r46xsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87o6r46xsw.ffs@tglx>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103114502.584940-1-wakel@google.com>
Subject: [PATCH v2] selftests/timers: Clean up kernel version check in posix_timers
From: Wake Liu <wakel@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kselftest@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	linux-kernel@vger.kernel.org, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

Several tests in the posix_timers selftest which test timer behavior
related to SIG_IGN fail on kernels older than 6.13. This is due to
a refactoring of signal handling in commit caf77435dd8a ("signal:
Handle ignored signals in do_sigaction(action != SIG_IGN)").

A previous attempt to fix this by adding a kernel version check to each
of the nine affected tests was suboptimal, as it resulted in emitting
the same skip message nine times.

Following the suggestion from Thomas Gleixner, this is refactored to
perform a single version check in main(). To satisfy the kselftest
framework's requirement for the test count to match the declared plan,
the plan is now conditionally set to 10 (for older kernels) or 19.

While setting the plan conditionally may seem complex, it is the
better approach to avoid the alternatives: either running tests on
unsupported kernels that are known to fail, or emitting a noisy series
of nine identical skip messages. A single informational message is now
printed instead when the tests are skipped.

Link: https://lore.kernel.org/all/20250807085042.1690931-1-wakel@google.com/
Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..a563c438ac79 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -18,6 +18,7 @@
 #include <time.h>
 #include <include/vdso/time64.h>
 #include <pthread.h>
+#include <stdbool.h>
 
 #include "../kselftest.h"
 
@@ -670,8 +671,14 @@ static void check_timer_create_exact(void)
 
 int main(int argc, char **argv)
 {
+	bool run_sig_ign_tests = ksft_min_kernel_version(6, 13);
+
 	ksft_print_header();
-	ksft_set_plan(19);
+	if (run_sig_ign_tests) {
+		ksft_set_plan(19);
+	} else {
+		ksft_set_plan(10);
+	}
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -695,15 +702,20 @@ int main(int argc, char **argv)
 	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_timer_distribution();
 
-	check_sig_ign(0);
-	check_sig_ign(1);
-	check_rearm();
-	check_delete();
-	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
-	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
-	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
-	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
-	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	if (run_sig_ign_tests) {
+		check_sig_ign(0);
+		check_sig_ign(1);
+		check_rearm();
+		check_delete();
+		check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+		check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+		check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+		check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+		check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
+	} else {
+		ksft_print_msg("Skipping SIG_IGN tests on kernel < 6.13\n");
+	}
+
 	check_overrun(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_overrun(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 	check_overrun(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
-- 
2.51.1.930.gacf6e81ea2-goog


