Return-Path: <linux-kselftest+bounces-26989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9CA3C3D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31940167A00
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369511FDE2B;
	Wed, 19 Feb 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmxnJETn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F761FCFDA;
	Wed, 19 Feb 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979589; cv=none; b=ERI7ca0J3ozym0R3qBcVlEsqmYY9OwcyYlFNDiKF/jnI8PZqHlg7TX4x04p8zJa8dMtNL20zEw5U2fs1bNW3Vi0lXW122XxH3DCHaKinjkna9ROJ3egkDycZ9fMptzQXQWnKnLItpj3NbZdbH1pqTlsPUHeglR/aUbrzyilxWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979589; c=relaxed/simple;
	bh=Qu11x7NasF+MB9Td7DYoVtX6gPqDeWYjYwf+ItHRZwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghBd77v1JHnPhl9x9ZwedIdkAx7/3Gmkh5XTHVpLvbVcMOaE6eTDEPWol8BRCauIt66/HMhuAAFIiP8zeYeSu2QpLL/8hHBtZb/0lcsTsDK6FPqH6L3wz0Tuq5d1r+0K5sGuZBIV3OQJwKZQrQ5kj+O6x00/ALZambt+roYxnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmxnJETn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e65be7d86fso9451726d6.1;
        Wed, 19 Feb 2025 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979586; x=1740584386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4sQVmUK5IVtunQ4FZ3JCjmg6oGCHZcpUatJm4+/LB0I=;
        b=dmxnJETn3NhsKdRrojx23J+dxxNUkqAOug49TBA6pyVHbnzBP8tN6RI095I7FjjIYc
         TfTlW4DyRQZcpIBI/8eVxx9LzusBe0+Kzf0TR2Ae2FN7tLHloXEP0X7jgyOVlclwvnCX
         nyR6mwpevXubUvSsylnRsPcVgqxHvP1LuDpk2cgb0pXZrt+KA2NStlMNgE9asm9r3q4N
         29wUPKaK+pENe0kEYFVXKCl/tvKsXrGuK17BbfWpcBv6I96rflMirV5VPE3Ur9FCy/ZC
         PxyMIVyeDd2u7lgQoKt1O3pnd+VWOH3jMm74WNeVoWAAzkiuQh9nq+5r7iUBMbfGmkZm
         ygkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979586; x=1740584386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sQVmUK5IVtunQ4FZ3JCjmg6oGCHZcpUatJm4+/LB0I=;
        b=agdMzemCFeHZo0KUCKm0upua84EeUhfwrx1aL7Z0xK5VNasJp/Dbew3oc6zk7Jko2s
         1TClb//TQLD0DfWBVHd0N2FkXJVo9dClwxKQMMvnPCD5GzL6K+cMESwyJBeriskyQ78r
         JjSmhOSNflS9+LF2XJhm8xuBSdQt7k5OmazptQ02tDZqniHDCe70IKz9aQw2jN5afXKK
         N4t6PbYWcn9ay+4J4ncvHcn0K5pUjVKptRbPzHBsPps914d4i3VZ1NXx1tFbDQONm8gq
         0pWrElL+t9tcOAIJAE0Id6UqEICm0MaiBuLurCAYbZ52LgBQ9XQQRJHFUnz6DijisZFl
         Txjw==
X-Forwarded-Encrypted: i=1; AJvYcCUrPEQ2kJ2fAPXhLDcZa+V6ZD0VBJykZ/6gXkb99qQHQiDhbSxfvSn/EfNR2MISLMUjqSpcC3Uk47w=@vger.kernel.org, AJvYcCV0beTzV3lKPvmDOFBygUW7L1TfICzbqZAijbwu4+/RNQvF4LXkjX5wScPadatDDHPrKJKygruAiMPZR0Ot@vger.kernel.org, AJvYcCVCWvPIaKJpSXA039ygchyiIqImqOrNT0aNGXNYwmNmNC+FBaUmrK4lhADnyYI9uLL5/BTvN7AKeRB2w9mPFIZn@vger.kernel.org, AJvYcCVzvrFQeZjrSvxZhMH/KB+txet8yFEXKK+wUKsnFBPk+0XRCC6sYxI2vrrtGLWNheRraHNBbsy2+xQnDBTvFKWno5Aj@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIP7lztzbxVmcFE0gIs8riHiOHRwmq7Cj5PMT3+w3W/4TKzfK
	0bBAMpfl+cyPJ4922Lpv8kjUaLKf9+KWvZOp1FrmfSzvVtT8aYP4
X-Gm-Gg: ASbGncvUYyFMh4iK1uJDZNyQ1yDw4h7/h4iPBRMAovBlRm8oyXpbIi3qBGEHLXLd9fq
	KuRHQKh6uFXBtKfeimyZvWHiNQbwRn7hwL5gn1paM7Vkjy6/5pmRsl0/h2FhbWBWvPtZSSBDhO0
	SBUG+ofxwuX7fdPSHVqejDULTMZhHPEQpCoX+qte9guCnLKiNGNm2f07x1+3os9dRrzy2nkBqew
	QLqGqhsuCuFBLGBvGUjCMArcbcr8e3/1PGyqeL60QQmTwF8lCxkG5KdHSi+BhA09vi+I3ns3zCb
	lo6B47ic9oqEEY5iTXNPVmK1jalRKvQYYDKQVONosk9udTemBm6e8P/Dek6YAacg1i2pzh4gqNu
	IBqLLVQ==
X-Google-Smtp-Source: AGHT+IHtpv3dpc70SaDr/V++5hlxUyvMZlKOx7+s1harXTHv++6MCeChn/jLHznKjqhAvJOkxc1YKg==
X-Received: by 2002:a05:6214:21ca:b0:6d8:b733:47c with SMTP id 6a1803df08f44-6e6972de435mr70861356d6.22.1739979586160;
        Wed, 19 Feb 2025 07:39:46 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dce9b56sm75743786d6.112.2025.02.19.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:45 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 223B01200043;
	Wed, 19 Feb 2025 10:39:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Feb 2025 10:39:45 -0500
X-ME-Sender: <xms:Qfu1Z_lqBFl3E0BWHdrDl-JqRemJSc_33H084LoX18eNXJguf6zoog>
    <xme:Qfu1Zy1ef7LUCKL6GcZVfN5Qoym-NUdwEUMuUlwBptNMQPYgwOWg9xPXc4mMHetmc
    y0f7TwI5g_Xi8SQAQ>
X-ME-Received: <xmr:Qfu1Z1rfsz3V0Y0anbHRMyncvYsytYFRuuLylbBnFnSuyZ772g6kd3oNAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegv
    fhhfihgtihhoshdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:Qfu1Z3lhHBjW-vZQkfT6tWZ9id_vNlCoodVhZmA8wPiLN5dpPkJk8A>
    <xmx:Qfu1Z936d8mNZUvZLsfMe2BCxAQXYzN0bRPT5OALiTJC1cCCO1z3-g>
    <xmx:Qfu1Z2v6Gv7mxc749ZKRrZUFv3sCGuhKj5L1Tpfdau5_mqOI1Pu-4A>
    <xmx:Qfu1ZxVTuoXm3DqjR7tKhUuq1owNvgzJwT5LV2n1wEOkND3YeN9zfw>
    <xmx:Qfu1Z80KBy2ZxSQhJy_VlJsy65MxUuEfafUGnLqYFubtHuYoVhhWCPK4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:44 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Yury Norov <yury.norov@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 02/11] rcutorture: Add a test_boost_holdoff module parameter
Date: Wed, 19 Feb 2025 07:39:29 -0800
Message-Id: <20250219153938.24966-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219153938.24966-1-boqun.feng@gmail.com>
References: <20250219153938.24966-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a test_boost_holdoff module parameter that tells the RCU
priority-boosting tests to wait for the specified number of seconds past
the start of the rcutorture test.  This can be useful when rcutorture
is built into the kernel (as opposed to being modprobed), especially on
large systems where early start of RCU priority boosting can delay the
boot sequence, which adds a full CPU's worth of load onto the system.
This can in turn result in pointless stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 kernel/rcu/rcutorture.c                       | 19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..ed1a0df03b18 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5758,6 +5758,11 @@
 	rcutorture.test_boost_duration= [KNL]
 			Duration (s) of each individual boost test.
 
+	rcutorture.test_boost_holdoff= [KNL]
+			Holdoff time (s) from start of test to the start
+			of RCU priority-boost testing.	Defaults to zero,
+			that is, no holdoff.
+
 	rcutorture.test_boost_interval= [KNL]
 			Interval (s) between each boost test.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d26fb1d33ed9..fbf1d7fcf61d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -135,6 +135,7 @@ torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
+torture_param(int, test_boost_holdoff, 0, "Holdoff time from rcutorture start, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
 torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
@@ -1148,8 +1149,19 @@ static int rcu_torture_boost(void *arg)
 	unsigned long gp_state;
 	unsigned long gp_state_time;
 	unsigned long oldstarttime;
+	unsigned long booststarttime = get_torture_init_jiffies() + test_boost_holdoff * HZ;
 
-	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
+	if (test_boost_holdoff <= 0 || time_after(jiffies, booststarttime)) {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost started");
+	} else {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost started holdoff period");
+		while (time_before(jiffies, booststarttime)) {
+			schedule_timeout_idle(HZ);
+			if (kthread_should_stop())
+				goto cleanup;
+		}
+		VERBOSE_TOROUT_STRING("rcu_torture_boost finished holdoff period");
+	}
 
 	/* Set real-time priority. */
 	sched_set_fifo_low(current);
@@ -1225,6 +1237,7 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
+cleanup:
 	/* Clean up and exit. */
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
@@ -2512,7 +2525,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "shuffle_interval=%d stutter=%d irqreader=%d "
 		 "fqs_duration=%d fqs_holdoff=%d fqs_stutter=%d "
 		 "test_boost=%d/%d test_boost_interval=%d "
-		 "test_boost_duration=%d shutdown_secs=%d "
+		 "test_boost_duration=%d test_boost_holdoff=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
 		 "stall_cpu_block=%d stall_cpu_repeat=%d "
 		 "n_barrier_cbs=%d "
@@ -2526,7 +2539,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
-		 test_boost_interval, test_boost_duration, shutdown_secs,
+		 test_boost_interval, test_boost_duration, test_boost_holdoff, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
 		 stall_cpu_block, stall_cpu_repeat,
 		 n_barrier_cbs,
-- 
2.39.5 (Apple Git-154)


