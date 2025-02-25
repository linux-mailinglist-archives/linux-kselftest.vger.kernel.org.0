Return-Path: <linux-kselftest+bounces-27412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE27A433FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499D3B6002
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD3253B4A;
	Tue, 25 Feb 2025 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1wSVsYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0F2512DA;
	Tue, 25 Feb 2025 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455732; cv=none; b=CEQ29hTHZ91zYVeywUy2mIdNxXG1nwVfsSm6RAXiamXdzCAFwo63o7mJtjjSDdDBRxhGax8d2qv0BmpeQ3cqFXDA3Odw4Fj7Tz/p5mSPAwDilaY397WntV/ly9wlOJn/IQpn21XQxqnnUln6Ad+rJ93lW1/DdT/ecAAQ1F+nCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455732; c=relaxed/simple;
	bh=vAoTryD7Ubn6jeOom5AqCgaUTXh/NIMl45CYHdmRAEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvlJ47p1IS0KWzd+Nb/ot+mhrEthz8qYmMFM11tCVzyxHu7UqNNhxZDMMsp9yJfPLowOGlkwDGJlspC8BV82Irue77/GhFl6mRSGYhdjrBcfxcWboIxkj83CbAvA5nXdzsopfIuAl79zaN6aynjfdFnIGHHY6m9yblpLoCdDByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1wSVsYR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0155af484so761459285a.0;
        Mon, 24 Feb 2025 19:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740455730; x=1741060530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQARWggofyARbzO1v8dhj3CLs+WsMSpSVZ/wO7/jEqQ=;
        b=B1wSVsYRL6U+gSCg+MLCkmM88uDandHBOwnJy4f3S/2zLFnN6CWEfsZxhYSPUtbtrT
         wh246dtk+kdhIj7+xST8DoorB1LL8gzxZa7Dzg/HbZFDRLRBu9JXuKPzD3oPFxvq7IP+
         nQqbapBJZS2HXsYk6Os3HaovEch8GNb/thMigEGvIC6G9OX0SYCzeIBnIP++CJAbjFGN
         W0yTBWDfBZN1YJBuckcwv9lr9jJpi/e1v0PMa4oWw5lqwVHZI1W7X4tkkeV3cb9uDcW4
         xNcSunt/hdmHrcR3K55wkGiLliMm4cbmm9FbxA1luQVX9fzco9s6exSoKdKEtT4mcdG1
         zIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455730; x=1741060530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQARWggofyARbzO1v8dhj3CLs+WsMSpSVZ/wO7/jEqQ=;
        b=jTYZSRuRVksXANQTBlcoPvuzVqXWMmYASvIAeRfNt2a/YEHh9GM0UXwBNqoA4pGjLz
         1ctnhPKy65wZ+5h0883j7zZ4odYVxQxzN0Nj/icSlNSb68t/jvDs16Ddolq5km2VXB29
         zIZE7sThloZuV0ChLmFVX2llonznhJssbv8Kl2H3kYDbICvpV3kliQOBxfbCCdzuHzr3
         4A9pRxJI5aA8eMMfuciLWXimjx/wnHMwuoMXoe4rm9vmpS7mqocfppdiVZWJjP3g/7Kv
         r9bA4B3f4dEyWVpjP/ivC3REf7cMxA1mlgUZvkRZTZ9nPj1jtpYWdrVgWCHUcObdVmPi
         lguw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQHGk4iHV5BniZO/ocfQQLLy1sWkU6GssqO+8kWEMLwGbzxde39YxquV5TDK7w8FTPxpLfNXyvdwSlB34oIAF@vger.kernel.org, AJvYcCUPNPnyzxRFad+P/lGCOwaKDopvkDK6Lw0G3T+55kdKA3Nsl2XNbb8qy/dZUD6UafB2POtTu+KkrcCjvwI=@vger.kernel.org, AJvYcCV0+DPa/MHcoCE5Eto0Dcl/hn2A+w3kmoIwhsgY1yn16xCH+hGacgVc40iY3npM0ybgjmN5dQvUtut7ZShAI3m4nkVL@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZJzKvghTu6jv4Y6IdEs5GgFlNxZ45zZoIbH7T18XrGjnC6tn
	SH1R00Lebj7Om4bNRLMzV1kF3H8hKhys2WXzk51uiT6DGRZD2J2O
X-Gm-Gg: ASbGnctRZbubu2TmhDg3+TPLWQZKVWLJwoSE+MYF60Onva6JP6tqgstdCnC8ajfP9w+
	XQpps5V6YN+OM/cE0/SO1V2KegXOfDGpHt/g4o1GS4Zmhx0vHPGi+/yq++8PcEgzPAMBGwmtD31
	/ve8SwSjgCJSvR/yj9vRaD2V3tR7VsrCI/ewc+HlZTeSJo9AkxJkB9TM6J23NbiYMWVpIb1Tl1+
	3s8/jZASFt8pIl4ooaxlqoPhBwDC8xgCX9aug+wARCHzuoCAtPLyqV0FO1R23AMB3izfm8ZJoFl
	ZEpNsNYhjDw/Ss5kc4QaZyKOcu82TnHjsAUf9KuJTAosASszbJ79wx+gy7S/huKFpSy3vBGhKkR
	mEhhGBSfsUGpQZEYB
X-Google-Smtp-Source: AGHT+IEse+IHb8ym/dd3Pk98eVbMhrTZY6i51QAsLVcIqmgSrvsy8pR/7b123U5idbXYlGhD7E9XWg==
X-Received: by 2002:a05:620a:1706:b0:7c0:aaf7:76d9 with SMTP id af79cd13be357-7c23be12855mr199242185a.24.1740455729971;
        Mon, 24 Feb 2025 19:55:29 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c2a3239sm60559485a.37.2025.02.24.19.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:55:29 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D9A901200043;
	Mon, 24 Feb 2025 22:55:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 24 Feb 2025 22:55:28 -0500
X-ME-Sender: <xms:MD-9Z6eRuRRDYlfazbwLM7IaOBmE-ECwIR-a9AW4ngZNSKSs7I5TYA>
    <xme:MD-9Z0MqyeuVP8JXzx9prtUnKYlCOT0EiyoY1aUNWLOZdL0ZKihuj3UKbmJkpDEzD
    iDVaRI31lmAcTRPbw>
X-ME-Received: <xmr:MD-9Z7iIwyf05xXqA4nlSr7-smxrJIVpKA1WbyyCUL1wOV-0AgzzPE8iVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:MD-9Z3_ymXnj-qKt5-_ZupGOqn--bjqZHuDk5ON84hQrqOYuXzlWlg>
    <xmx:MD-9Z2sewgHd0SnO8O4nhVLe0H70NQTPjeVvfnWQqdY5-TWgLCUTzw>
    <xmx:MD-9Z-GxhXxCzTg5g7Gop7I7PzGX-a2HZR3ENtkxTDEhzMPJ-RZhXw>
    <xmx:MD-9Z1N0xq5XXDwwKPjijXdAD3PInf7VjK1VfFCb6qAkBMSoD-plLQ>
    <xmx:MD-9ZzPmNvYftR-CC2ku2JM2lxfVJQ2sifVfJ5lkpsSxJ67R0VJpH4Mt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 22:55:28 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,	Ankur Arora <ankur.a.arora@oracle.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH rcu 06/11] osnoise: provide quiescent states
Date: Mon, 24 Feb 2025 19:55:11 -0800
Message-Id: <20250225035516.26443-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250225035516.26443-1-boqun.feng@gmail.com>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. For PREEMPT_RCU=y configurations -- where
cond_resched() is a stub -- we do this by directly calling
rcu_momentary_eqs().

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
of the above can help.

Handle that by providing an explicit quiescent state here for all
configurations.

As mentioned above this is not needed for non-stubbed cond_resched(),
but, providing a quiescent state here just pulls in one that a future
cond_resched() would provide, so doesn't cause any extra work for
this configuration.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f3a2722ee4c0..512034e365ad 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1542,27 +1542,25 @@ static int run_osnoise(void)
 
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
-		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * a stopped tick PREEMPT_RCU or PREEMPT_LAZY have no way to
+		 * account for QSs. This will eventually cause unwarranted
+		 * noise as RCU forces preemption as the means of ending the
+		 * current grace period.  We avoid this by calling
+		 * rcu_momentary_eqs(), which performs a zero duration EQS
+		 * allowing RCU to end the current grace period. This call
+		 * shouldn't be wrapped inside an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * Normally QSs for other cases are handled through cond_resched().
+		 * For simplicity, however, we call rcu_momentary_eqs() for all
+		 * configurations here.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			if (!disable_irq)
-				local_irq_disable();
+		if (!disable_irq)
+			local_irq_disable();
 
-			rcu_momentary_eqs();
+		rcu_momentary_eqs();
 
-			if (!disable_irq)
-				local_irq_enable();
-		}
+		if (!disable_irq)
+			local_irq_enable();
 
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
-- 
2.39.5 (Apple Git-154)


