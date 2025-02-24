Return-Path: <linux-kselftest+bounces-27297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCEA4134D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD2318945DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59C1A2393;
	Mon, 24 Feb 2025 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHjcPRdY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40024B29;
	Mon, 24 Feb 2025 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363741; cv=none; b=Mobu/Dazgl9M8LOunZ8l0heLyWOb/+xpMnylnfkLOVyBBKHoRUpArHTPXQfj6PkjzK+WCy3S4vTWgGnBm+LH7v2y71KTJ1vcSwbg+MaWtLkgKbOAdcZaAkG2bCvGwWWu7ZVaYQ/x1qLGv2NBw9d8zBZ36tTWEY4CO5g4Col3t98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363741; c=relaxed/simple;
	bh=3hLfqkqwajj486Pe46ojiChhC3AdPfNGZK5wX465TGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAhhxwLkRP4I0GQp9OH1IZO6dQbEWeRgZjJ0Ix9yX4Sj2BATJ+k5Dymvigwg0xytOqsl1dG+iOeqhYWgGtJbMZkEclp9Mk9r4AvL4K00TecTGXTtIFxoftweIr+TVy9WEBJ0PfsWtA05R1pNL8uVRuOJSigmgrKMvWpNTzZhQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHjcPRdY; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0a3d6a6e4so376569485a.1;
        Sun, 23 Feb 2025 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363739; x=1740968539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJvBAuzH2IJvhDI3I6/wuJNYmCk2oz4gPvTHRsBnqEo=;
        b=kHjcPRdYVefMIkwLS8brhXQY6HO22Yu75OClvgI3QUpvARTiu6ISgJa6EU2cJQp2sE
         qtyUGWulCLaylQ8pe8aZdUAQl75pwp0lRpdi1m27Z5b+JiPJw1OhHIDkt+F7tA9FwWGu
         KozfVhEaZo/LlcxxrQsHg5kxGlg570ipt2yjhfdAiflPLoFZJCgLyH2AFahS+BxdW6Gn
         Jy1euB4cK5gniWJIdcocat2QcEKqwgAsA695nu97Lklxay8kPX8HlPYz0RNoAkEDsVAK
         5sdt8nZEVv6aPu+F8lP+XHUagcoBmIsYnQyzBG9GPcwEGsoT/H/L+/dKGX3F2z2fiJl9
         q9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363739; x=1740968539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJvBAuzH2IJvhDI3I6/wuJNYmCk2oz4gPvTHRsBnqEo=;
        b=aYnpzpwVbCEVlITq4ya5RvdZkKVtuDjkBQ1T0Bx1VrvW10lZ83PhbKkZEU8nDmOwXa
         YsIViGBvYmPjUOji7+YIvS7uTj9x6us3nX3xyAMm3ua01vg5/X+VUVCoZifXoDKsq5jz
         0BZq0klQ5Ib4atW8akH3HI8I/FhEVrbCUEfOmZTq4D5rreVHTlf/08hINzgnqr8UIdaS
         sa4K0ELjylVGtEwzwW5Qu+/lB7G0+WkQRK22LVes2rz6NHpxdUVkBCfoVy466OlrqVs9
         s3Hhuu2U5RC+4PGbE4rnWrDjljsoETCRXfqATO86X5vwpj/G8nDHWLCZ6QNmR+QwJoU/
         bzUg==
X-Forwarded-Encrypted: i=1; AJvYcCUoe/v2ht5Tt1AWx0gXyCsleASIZoh8SmbSDMMX8Oga81ICrVgegYmMQUWNluz0e4rsT8ms2vVCaorpoMm1@vger.kernel.org, AJvYcCVG4yAkWKkpJHGyIVFEn9QpDJQE2SrB2czii/Yg/2L0SxjlPMG03K54q2WiYqaXfQIlcto=@vger.kernel.org, AJvYcCXLIPVMaGYsOhkDjVv3B+ucTErkNFvyU25h/ig+82nb/W1hiq//mEKtdJNT4PmLv0SStQ0iYsrZnHjZugrJJgon@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTSeAAvLFsozvPFEC1d7jU0oacjdCylz5Vo6Nqh/QRsArwglG
	RHc0U7/J6bRBIMtqVRTdCtTzsxdVYj99yWlkFHbOMwCkEatZSeMC
X-Gm-Gg: ASbGncsjbWgtSpK6MMJXGGdE7w+45BO5zddFsB67biDE/qoCxZ38/SOye9IRNFI5P+5
	RYoTcag8z1qpAl80ouM2tUW4AbWNUsyfFqfa/zgZuIKyEYERlnAFx68P2qViOZQJdwJgLsTV7L0
	WBRmpiRwdjEt/ldRirkPVVZvwintVPzHw1D7S9ZiX5XN8n+7AEKHacsdf6fL28UQyPQUXg5J08k
	xctEglUUc4c80yZ2ZQTqCOR+T9E0ntX6ek8oEZMktb1NlSIa2pVVLMgILTowN9i0pyg2ihJgkwy
	xRt7FwN+VRfvJ1akKnYG2hviaBrVBNcmuX8ayoJ6K6IqQMOOEi3dmS+5bS1oK3SpL5OPdk039Ki
	cd96u58CKgzbAW9n/
X-Google-Smtp-Source: AGHT+IFUBJ/19SzIMd4phxmUKiWctiSDZpRIqcsMy7b55y/0AHhQ+k0TqMz944j7Fg4RJXmaFX+y3Q==
X-Received: by 2002:a05:620a:24c4:b0:7c0:b185:a952 with SMTP id af79cd13be357-7c0ceee6234mr1410812585a.2.1740363738851;
        Sun, 23 Feb 2025 18:22:18 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0d81b2fsm744810485a.84.2025.02.23.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:18 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EBDA81200043;
	Sun, 23 Feb 2025 21:22:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 21:22:17 -0500
X-ME-Sender: <xms:2de7Z8NcztikaCNW8eEq-XKY6oecIP1Z22KKy5u2JeM2VtINDRKsOw>
    <xme:2de7Zy_N7pzp_H1iktDTc7ZdkVbvyI9mXRhopeWn3CL96ntV4sO465_go5rykAbk5
    IN9B8LL2I-dBAbNUA>
X-ME-Received: <xmr:2de7ZzTvuT5-zgcpSIZsFF3wYvKjC7Y5gxH_XwuMwqOVMfq1mZXR7wPXhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:2de7Z0v95qK_9_3YDNg1ZjP97qFyVT7S7ZIap7-VMP26TprwZKAx4Q>
    <xmx:2de7Z0f_Uqsc1N4ZwvvTKXzExmiV6yhwaQebRWGBuXzFBX7XBmqF9Q>
    <xmx:2de7Z40XC-wLhEqH9Wa9iSU-Cz0YfOOJcCf0NR5KYQFeV9Isi5I0-g>
    <xmx:2de7Z49Ge-bGP2BHM1P0_F_RuhlQbffVZOfPcSEE7pf317l5Qm2VVA>
    <xmx:2de7Z79RZvrj5nE1IjDaTYCBFBrAHXQxHyRyBo0aKPmWXhTzrBwB3Zx8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:17 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 01/20] srcu: Make Tiny SRCU able to operate in preemptible kernels
Date: Sun, 23 Feb 2025 18:21:55 -0800
Message-Id: <20250224022214.12037-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224022214.12037-1-boqun.feng@gmail.com>
References: <20250224022214.12037-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that SRCU allows its read-side critical sections are not just
preemptible, but also allow general blocking, there is not much
reason to restrict Tiny SRCU to non-preemptible kernels.  This commit
therefore removes Tiny SRCU dependencies on non-preemptibility, primarily
surrounding its interaction with rcutorture and early boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcu.h      | 9 ++++++---
 kernel/rcu/srcutiny.c | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..2909662c805f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -611,8 +611,6 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
-static inline unsigned long
-srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
 static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
 static inline void show_rcu_gp_kthreads(void) { }
@@ -624,7 +622,6 @@ static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
-unsigned long srcu_batches_completed(struct srcu_struct *sp);
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
@@ -636,6 +633,12 @@ void rcu_gp_slow_register(atomic_t *rgssp);
 void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_TINY_SRCU
+static inline unsigned long srcu_batches_completed(struct srcu_struct *sp) { return 0; }
+#else // #ifdef CONFIG_TINY_SRCU
+unsigned long srcu_batches_completed(struct srcu_struct *sp);
+#endif // #else // #ifdef CONFIG_TINY_SRCU
+
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_bind_current_to_nocb(void);
 #else
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 4dcbf8aa80ff..2a94f0e65606 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -20,7 +20,11 @@
 #include "rcu_segcblist.h"
 #include "rcu.h"
 
+#ifndef CONFIG_TREE_RCU
 int rcu_scheduler_active __read_mostly;
+#else // #ifndef CONFIG_TREE_RCU
+extern int rcu_scheduler_active;
+#endif // #else // #ifndef CONFIG_TREE_RCU
 static LIST_HEAD(srcu_boot_list);
 static bool srcu_init_done;
 
@@ -282,11 +286,13 @@ bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
 
+#ifndef CONFIG_TREE_RCU
 /* Lockdep diagnostics.  */
 void __init rcu_scheduler_starting(void)
 {
 	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
 }
+#endif // #ifndef CONFIG_TREE_RCU
 
 /*
  * Queue work for srcu_struct structures with early boot callbacks.
-- 
2.39.5 (Apple Git-154)


