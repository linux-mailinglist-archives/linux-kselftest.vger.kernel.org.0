Return-Path: <linux-kselftest+bounces-29520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888CA6AEF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7428A1D51
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281B229B1F;
	Thu, 20 Mar 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2Q095qh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F63229B0F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500992; cv=none; b=CDvp/EBHjxS3GNJSjl6uQA/nk1rf0QwNPgwmWLdugCc/CZ4jc3YgBsH0ZjHnd7kMrPCb6MUpQwwL6nONPkGb5mEp04CkwRd6Kwpxo7VeXRC0kKPonSRmKrRDIffnk3ddmxI/rcndAcixR8lhi/XGGgmorZYamwFVpDbjSXTOmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500992; c=relaxed/simple;
	bh=IAwIAxxG8p4iEqmmxlYf8o3Ykua428QNXsNS7e2jxOQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jfG/nJsBsOsto9hL3bGpac59SPU5NG99094dv6hAnl0Zi3HjiE6/G5HIa2icyTF35mibhsRLkzcld05wjNe5MtdaCekMDxthohlFYatPyyVPycpaHOTVfi3u06dZBZwiXXdo35N0KPZgOJjv7PhV9mtLxikwAWgxMMTRLmGYh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2Q095qh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso3235127a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500990; x=1743105790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kh/xQ9fv8FpIbfWlmJMxeApDHDonFtfV58rPyR5rKeI=;
        b=M2Q095qh6armokD8ezcgm2+dJ7HzFKC9YPQC1c/n+Rzoz1Z0O0St5KPMd3mSdtEv1j
         AqGqL/Qd7kHVmVPBdLNb3VWqfLFreTh4cowoulednnuXxPPLvro05dcrO8S4vbVDRyxX
         GU6+ZN/DNfIytDiMrSSap+1r72RBMc1LAbTkerkh6fe3U8zJNDm5mWOeGRxaUXllTyyM
         FVGwv/qmHynmvhh9LDcZRmexvZ+0BtMycAkChFnvJXfyVslppafU7mjNIaViti82j6F7
         TW0Htojuj7dpjjk03qAUPL5y7ivAohCS1kM/bmITmr4JrYKz3OiKFX69MF0JeZ1EL3jM
         pOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500990; x=1743105790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kh/xQ9fv8FpIbfWlmJMxeApDHDonFtfV58rPyR5rKeI=;
        b=qiXw+L2BGEfuMIudg0fWvTAG2qApElYqanlCHYmnhn1TXDj9l9Q0R98VLr4BLhIXAe
         nxGdjXn7EPQIlB2JvbyokXDUbA6Oub1s+lfnmhevkW1UnQOuFaGvkJiGUPP/c5OOkEcg
         Y3KvFKY1+ZayYQdFhxVUcMoBxIOnc0bSMmD07DeH/7ZMDc5XpXdW6vhu96ozbNzsmrKw
         V6/65GpeqB0aWMjvA9Y4bcFZncU47pI+MicCiKmvyWiQk7xrAdQXdCaESsEhlk2eYLhQ
         FNGjUZMbjy1tfIfuqOpBVezdnS9Wpk5goCS7eEbu95d7rzLg6kywebEV5NFfHNtbT+y7
         5Ojg==
X-Forwarded-Encrypted: i=1; AJvYcCWg3iBfD9cit4+3WIUJMinLqcXZCRkEZcnAQn03mVJ9acSkLlubju58rlmcr5uez+WkrLmoeSQssm3ar2biSqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYnjnRqp8Ov9x0HAQJqNyi9nVBQne8CoQxosqK0txnhSGa/2W
	lo1tjB3gZ83nVf4r2boNtv6XDK4yN/ObQqLhATzAO+pyTf0UHlwweewq7Z5l/vNyFqe0L1FVgb4
	6pWMr
X-Google-Smtp-Source: AGHT+IFfmIe8hY7j98W04pDpd89yWI1PHIh/o7e/RuYoGRB/sB83B78OHDmeQdOKl3N7Eg1AlHp4CnvjoEhX
X-Received: from pgje2.prod.google.com ([2002:a63:d942:0:b0:af5:fb69:84d2])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7011:b0:1f5:8655:3287
 with SMTP id adf61e73a8af0-1fe434562bcmr1359484637.40.1742500990149; Thu, 20
 Mar 2025 13:03:10 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:03:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320200306.1712599-1-jstultz@google.com>
Subject: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing
time inconsistencies.

Lei tracked down that this was being caused by the adjustment
  tk->tkr_mono.xtime_nsec -= offset;

which is made to compensate for the unaccumulated cycles in
offset when the mult value is adjusted forward, so that
the non-_COARSE clockids don't see inconsistencies.

However, the _COARSE clockids don't use the mult*offset value
in their calculations, so this subtraction can cause the
_COARSE clock ids to jump back a bit.

Now, by design, this negative adjustment should be fine, because
the logic run from timekeeping_adjust() is done after we
accumulate approx mult*interval_cycles into xtime_nsec.
The accumulated (mult*interval_cycles) will be larger then the
(mult_adj*offset) value subtracted from xtime_nsec, and both
operations are done together under the tk_core.lock, so the net
change to xtime_nsec should always be positive.

However, do_adjtimex() calls into timekeeping_advance() as well,
since we want to apply the ntp freq adjustment immediately.
In this case, we don't return early when the offset is smaller
then interval_cycles, so we don't end up accumulating any time
into xtime_nsec. But we do go on to call timekeeping_adjust(),
which modifies the mult value, and subtracts from xtime_nsec
to correct for the new mult value.

Here because we did not accumulate anything, we have a window
where the _COARSE clockids that don't utilize the mult*offset
value, can see an inconsistency.

So to fix this, rework the timekeeping_advance() logic a bit
so that when we are called from do_adjtimex(), we call
timekeeping_forward(), to first accumulate the sub-interval
time into xtime_nsec. Then with no unaccumulated cycles in
offset, we can do the mult adjustment without worry of the
subtraction having an impact.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kernel-team@android.com
Cc: Lei Chen <lei.chen@smartx.com>
Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
Diagnosed-by: Thomas Gleixner <tglx@linutronix.de>
Additional-fixes-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2: Include fixes from Thomas, dropping the unnecessary clock_set
    setting, and instead clearing ntp_error, along with some other
    minor tweaks.
---
 kernel/time/timekeeping.c | 94 ++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f1955..929846b8b45ab 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,20 +682,19 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 }
 
 /**
- * timekeeping_forward_now - update clock to the current time
+ * timekeeping_forward - update clock to given cycle now value
  * @tk:		Pointer to the timekeeper to update
+ * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward_now(struct timekeeper *tk)
+static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 {
-	u64 cycle_now, delta;
+	u64 delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				      tk->tkr_mono.clock->max_raw_delta);
 
-	cycle_now = tk_clock_read(&tk->tkr_mono);
-	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
-				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -710,6 +709,21 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	}
 }
 
+/**
+ * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
+ *
+ * Forward the current clock to update its state since the last call to
+ * update_wall_time(). This is useful before significant clock changes,
+ * as it avoids having to deal with this time offset explicitly.
+ */
+static void timekeeping_forward_now(struct timekeeper *tk)
+{
+	u64 cycle_now = tk_clock_read(&tk->tkr_mono);
+
+	timekeeping_forward(tk, cycle_now);
+}
+
 /**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
@@ -2151,6 +2165,54 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
+static u64 timekeeping_accumulate(struct timekeeper *tk, u64 offset,
+				  enum timekeeping_adv_mode mode,
+				  unsigned int *clock_set)
+{
+	int shift = 0, maxshift;
+
+	/*
+	 * TK_ADV_FREQ indicates that adjtimex(2) directly set the
+	 * frequency or the tick length.
+	 *
+	 * Accumulate the offset, so that the new multiplier starts from
+	 * now. This is required as otherwise for offsets, which are
+	 * smaller than tk::cycle_interval, timekeeping_adjust() could set
+	 * xtime_nsec backwards, which subsequently causes time going
+	 * backwards in the coarse time getters. But even for the case
+	 * where offset is greater than tk::cycle_interval the periodic
+	 * accumulation does not have much value.
+	 *
+	 * Also reset tk::ntp_error as it does not make sense to keep the
+	 * old accumulated error around in this case.
+	 */
+	if (mode == TK_ADV_FREQ) {
+		timekeeping_forward(tk, tk->tkr_mono.cycle_last + offset);
+		tk->ntp_error = 0;
+		return 0;
+	}
+
+	/*
+	 * With NO_HZ we may have to accumulate many cycle_intervals
+	 * (think "ticks") worth of time at once. To do this efficiently,
+	 * we calculate the largest doubling multiple of cycle_intervals
+	 * that is smaller than the offset.  We then accumulate that
+	 * chunk in one go, and then try to consume the next smaller
+	 * doubled multiple.
+	 */
+	shift = ilog2(offset) - ilog2(tk->cycle_interval);
+	shift = max(0, shift);
+	/* Bound shift to one less than what overflows tick_length */
+	maxshift = (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
+	shift = min(shift, maxshift);
+	while (offset >= tk->cycle_interval) {
+		offset = logarithmic_accumulation(tk, offset, shift, clock_set);
+		if (offset < tk->cycle_interval << shift)
+			shift--;
+	}
+	return offset;
+}
+
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2160,7 +2222,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
-	int shift = 0, maxshift;
 	u64 offset;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
@@ -2177,24 +2238,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
 
-	/*
-	 * With NO_HZ we may have to accumulate many cycle_intervals
-	 * (think "ticks") worth of time at once. To do this efficiently,
-	 * we calculate the largest doubling multiple of cycle_intervals
-	 * that is smaller than the offset.  We then accumulate that
-	 * chunk in one go, and then try to consume the next smaller
-	 * doubled multiple.
-	 */
-	shift = ilog2(offset) - ilog2(tk->cycle_interval);
-	shift = max(0, shift);
-	/* Bound shift to one less than what overflows tick_length */
-	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
-	shift = min(shift, maxshift);
-	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
-		if (offset < tk->cycle_interval<<shift)
-			shift--;
-	}
+	offset = timekeeping_accumulate(tk, offset, mode, &clock_set);
 
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);
-- 
2.49.0.395.g12beb8f557-goog


