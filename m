Return-Path: <linux-kselftest+bounces-27300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C9A4135A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD37116BA4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572C1BEF81;
	Mon, 24 Feb 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8ZQi1vX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F811A7253;
	Mon, 24 Feb 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363746; cv=none; b=K/t5bf10PlHWwWSKPyykL3f9zGTe/JQeJ1YG+KewgotueeOpWYgKOJFhOvp25dwJJ5ICwB+Xuh4EFbA7ce32snpByY41hIszpe5Wg1tKGlnn7BLDYpsTIr7h3frzM2NYlLV8/Qqdd2TRTnOgbh6t+sM2aagzaRq+n4ksnT9PeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363746; c=relaxed/simple;
	bh=wANPTy97bY/zTdpU+z3ZCDuJvLVgmYnNsjBC6Zp8iT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=an1i3JkNjHodotAUaMID8IFFgcpv3wwRV5yS9VX6la00eQ89P6ru8dTYMcuCfwtG1DHyVJI/yxblZ0c/8gFMtLra8ZjGNIuk7E4Zf4eNILaD8BCNhK+EUf95EXWDh6cCnLe6oWf9KnLy3UAIl9ADDcAADcBwTlhiSsIiTyZgeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8ZQi1vX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471fabc5bf5so22118501cf.3;
        Sun, 23 Feb 2025 18:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363743; x=1740968543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOLMEk+pK7yaifZ1uynRQqEOYQw0oxUKxlJ/oKqOFnU=;
        b=V8ZQi1vXaLPxirPuDrtavSTG2HOBhbfCAW00ECngBvTufAhCBT6O+L58jy2yrVQHld
         Gc79KMaOSmAsBzWJ6B8jjyJyFnNyPctW9IiNjNV6Hk3X/PM9G0SARpLUxPSglK7W4pCz
         bWe8wQ6ZyVKNbq7Dp1YKNACQypHiXwP/Qlm7kg+z+yf0T7eyp3nWeosqDx/JUlfFnP+1
         7s+Iy27xrvaazxVQ1WIptU3tA4in+7T5pytxdt9WAMqJ9/cFuMqAEJlH1pMgz0wfw5vc
         tFz5ndHwVDwiizdRxLP1ykSGKGNSoaPNXHY6ynOtQpaRnBysC3e6wk8cmml1s2B+lNSB
         21MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363743; x=1740968543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOLMEk+pK7yaifZ1uynRQqEOYQw0oxUKxlJ/oKqOFnU=;
        b=LeU4av4pworWOsjijcpFWNhjFe1pLiK7Qv0ivj3Lvc+xKXsEzY4vQslG4iXpIh4JHp
         lXQj0cYF/38V4AvnKC5eiSqlAHmyW3k1bYbNsxzVyGZ5Pt3eKHvlk9X7eNxm5j4JpHLe
         tuRb9hMUY1EKeBRor36q/o40wHOG/XTTMYlSXg4UYZ83yhnuhLn+3wZ2ucKhIcOiXK0G
         /+7qrqqhQkUicxS+9eAteqF6taemPShTs1NeonyxLM52KAG2zOuJ3IhCFWQH2E0y83Vs
         jzB7tJ+F4a/z1awzJpR8LgyPBJKoFssuFHhPgLmNtSxgTEJgERZ31XhbDJBgAB1zpcqJ
         kBhA==
X-Forwarded-Encrypted: i=1; AJvYcCUkD1depFC10FcWeGdkQVZ2zXJ6vg1vzCsGJQFkfySNMMVBMFYnJdDYIx/utwVJyKocpj98yKgvm3h/9WH9CpGU@vger.kernel.org, AJvYcCVTG0XxA+RJwbJ1SekjDI9BA0yFZJXoLiLN6huaJwmkaxTENWiEzE0GRikgNEMe+VmWZdU=@vger.kernel.org, AJvYcCVUZLeVZu5riZRluogMryASgRa5BwZMPu6GFnRvbZoBt6RpelT+hsgLJUKDsu+WJWZDpH5HBuqkQttKr4iI@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIck14CiLslo8iMknwKUJ3EMZtwCRuv9JLtsQGleEizGWSnTO
	YrDtw43kY+IxSx0/81OZhX0BLrpQpTz26+nstFLc/rwNPCZLedGo
X-Gm-Gg: ASbGnctDeUEF3OobbIquwTqrPkLejXtL0KtLKrsiuhcyCfslg3S9ekZsm0KOA+Ac14C
	uxIijixTK0wTuoL5PwBNYTR/uOoR91iVCl+g/pSjwprw/MY0qrL1FUUo2RFX+zVYBVsgPzAF28n
	vgaIkOGbS54IozVSGivEdwbrHOT0kEpalzyFb0UX0lYEkr9e/+k0oRQh7kYiF/nueyMrP+WYoL9
	8SBiN8L2R28Uxg5MQtmzjhDUo6/8CvaWtOTwW7vxHoWqrNTiOj34ziWFrQC4maZqEEq1QzpP7Os
	gsOT4xlYwnXqoe4M98R9YMziZ357tJt3CYRHNn8gZItslq7YDMhXwmB2rGQXd2cbqB+IViLFlzr
	H6ZDUWn0pIHGtmpOR
X-Google-Smtp-Source: AGHT+IFx4DEUzY8iXU9N91XMG8aD4j9QaEqr6DyvWhkoV6w4KF1Me5GNMAhFv0AUVhGfqJH7aUxvhQ==
X-Received: by 2002:a05:622a:2d2:b0:471:a523:6ac1 with SMTP id d75a77b69052e-472228a7e9bmr150011431cf.6.1740363743099;
        Sun, 23 Feb 2025 18:22:23 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471ed70947fsm89446881cf.14.2025.02.23.18.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:22 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 166D91200043;
	Sun, 23 Feb 2025 21:22:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 21:22:22 -0500
X-ME-Sender: <xms:3de7Z5IEiS_-QMxR5uDInwopT_YZT4jGR3nwmx-1VjvD9vzhPs4Epg>
    <xme:3de7Z1I6AHKD3ZiKXyAkYrckf1oPsPBsdmckQa3Iqwjpo8gRpPmI-4fWYEjL2uEj_
    fkrcVxZ0QL7SxUYwg>
X-ME-Received: <xmr:3de7ZxvZdpWuR0Ax12zVmVt9KlukDgQuYJZesDOlvM2zwyhys0ad6o7F4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:3te7Z6YecD6ZiQcO61PAwt8vezCYfs2cDW__hVsLxpBsf3r50oBegg>
    <xmx:3te7Zwb1kcLY6JMTfuc0aCzf7SuqltFFrW9d8Sqqgu_ClD82sOkZGQ>
    <xmx:3te7Z-BTt5AevdCBKql_lZM_2LhMOL83sGKpy-46QVOkby6a1Q1lCA>
    <xmx:3te7Z-aHh1hDvOOu39YizwXTiPzcCKvwrUKdZ7nLR8OqUUT3geQEcg>
    <xmx:3te7Z8pNhjrw9_JPSqFsjhd8UPAeE6lB6h2XQJBwW4snJFNwVOY6xotC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:21 -0500 (EST)
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
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 04/20] srcu: Pull ->srcu_{un,}lock_count into a new srcu_ctr structure
Date: Sun, 23 Feb 2025 18:21:58 -0800
Message-Id: <20250224022214.12037-5-boqun.feng@gmail.com>
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

This commit prepares for array-index-free srcu_read_lock*() by moving the
->srcu_{un,}lock_count fields into a new srcu_ctr structure.  This will
permit ->srcu_index to be replaced by a per-CPU pointer to this structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h |  13 +++--
 kernel/rcu/srcutree.c    | 115 +++++++++++++++++++--------------------
 2 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index b17814c9d1c7..c794d599db5c 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -17,14 +17,19 @@
 struct srcu_node;
 struct srcu_struct;
 
+/* One element of the srcu_data srcu_ctrs array. */
+struct srcu_ctr {
+	atomic_long_t srcu_locks;	/* Locks per CPU. */
+	atomic_long_t srcu_unlocks;	/* Unlocks per CPU. */
+};
+
 /*
  * Per-CPU structure feeding into leaf srcu_node, similar in function
  * to rcu_node.
  */
 struct srcu_data {
 	/* Read-side state. */
-	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
-	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
+	struct srcu_ctr srcu_ctrs[2];		/* Locks and unlocks per CPU. */
 	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */
 						/* Values: SRCU_READ_FLAVOR_.*  */
 
@@ -221,7 +226,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -240,7 +245,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
 }
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e69ce9d59abf..d7ee2f345e19 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -116,8 +116,9 @@ do {										\
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
- * srcu_read_unlock() running against them.  So if the is_static parameter
- * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
+ * srcu_read_unlock() running against them.  So if the is_static
+ * parameter is set, don't initialize ->srcu_ctrs[].srcu_locks and
+ * ->srcu_ctrs[].srcu_unlocks.
  */
 static void init_srcu_struct_data(struct srcu_struct *ssp)
 {
@@ -128,8 +129,6 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
 	 */
-	BUILD_BUG_ON(ARRAY_SIZE(sdp->srcu_lock_count) !=
-		     ARRAY_SIZE(sdp->srcu_unlock_count));
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
 		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
@@ -429,10 +428,10 @@ static bool srcu_gp_is_expedited(struct srcu_struct *ssp)
 }
 
 /*
- * Computes approximate total of the readers' ->srcu_lock_count[] values
- * for the rank of per-CPU counters specified by idx, and returns true if
- * the caller did the proper barrier (gp), and if the count of the locks
- * matches that of the unlocks passed in.
+ * Computes approximate total of the readers' ->srcu_ctrs[].srcu_locks
+ * values for the rank of per-CPU counters specified by idx, and returns
+ * true if the caller did the proper barrier (gp), and if the count of
+ * the locks matches that of the unlocks passed in.
  */
 static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
 {
@@ -443,7 +442,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
 			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
@@ -455,8 +454,8 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 }
 
 /*
- * Returns approximate total of the readers' ->srcu_unlock_count[] values
- * for the rank of per-CPU counters specified by idx.
+ * Returns approximate total of the readers' ->srcu_ctrs[].srcu_unlocks
+ * values for the rank of per-CPU counters specified by idx.
  */
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
 {
@@ -467,7 +466,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, u
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks);
 		mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
@@ -510,9 +509,9 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * been no readers on this index at some point in this function.
 	 * But there might be more readers, as a task might have read
 	 * the current ->srcu_idx but not yet have incremented its CPU's
-	 * ->srcu_lock_count[idx] counter.  In fact, it is possible
+	 * ->srcu_ctrs[idx].srcu_locks counter.  In fact, it is possible
 	 * that most of the tasks have been preempted between fetching
-	 * ->srcu_idx and incrementing ->srcu_lock_count[idx].  And there
+	 * ->srcu_idx and incrementing ->srcu_ctrs[idx].srcu_locks.  And there
 	 * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
 	 * in a system whose address space was fully populated with memory.
 	 * Call this quantity Nt.
@@ -521,36 +520,36 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * code for a long time.  That now-preempted updater has already
 	 * flipped ->srcu_idx (possibly during the preceding grace period),
 	 * done an smp_mb() (again, possibly during the preceding grace
-	 * period), and summed up the ->srcu_unlock_count[idx] counters.
+	 * period), and summed up the ->srcu_ctrs[idx].srcu_unlocks counters.
 	 * How many times can a given one of the aforementioned Nt tasks
-	 * increment the old ->srcu_idx value's ->srcu_lock_count[idx]
+	 * increment the old ->srcu_idx value's ->srcu_ctrs[idx].srcu_locks
 	 * counter, in the absence of nesting?
 	 *
 	 * It can clearly do so once, given that it has already fetched
-	 * the old value of ->srcu_idx and is just about to use that value
-	 * to index its increment of ->srcu_lock_count[idx].  But as soon as
-	 * it leaves that SRCU read-side critical section, it will increment
-	 * ->srcu_unlock_count[idx], which must follow the updater's above
-	 * read from that same value.  Thus, as soon the reading task does
-	 * an smp_mb() and a later fetch from ->srcu_idx, that task will be
-	 * guaranteed to get the new index.  Except that the increment of
-	 * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
-	 * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
-	 * is before the smp_mb().  Thus, that task might not see the new
-	 * value of ->srcu_idx until the -second- __srcu_read_lock(),
-	 * which in turn means that this task might well increment
-	 * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
-	 * not just once.
+	 * the old value of ->srcu_idx and is just about to use that
+	 * value to index its increment of ->srcu_ctrs[idx].srcu_locks.
+	 * But as soon as it leaves that SRCU read-side critical section,
+	 * it will increment ->srcu_ctrs[idx].srcu_unlocks, which must
+	 * follow the updater's above read from that same value.	Thus,
+	 * as soon the reading task does an smp_mb() and a later fetch from
+	 * ->srcu_idx, that task will be guaranteed to get the new index.
+	 * Except that the increment of ->srcu_ctrs[idx].srcu_unlocks
+	 * in __srcu_read_unlock() is after the smp_mb(), and the fetch
+	 * from ->srcu_idx in __srcu_read_lock() is before the smp_mb().
+	 * Thus, that task might not see the new value of ->srcu_idx until
+	 * the -second- __srcu_read_lock(), which in turn means that this
+	 * task might well increment ->srcu_ctrs[idx].srcu_locks for the
+	 * old value of ->srcu_idx twice, not just once.
 	 *
 	 * However, it is important to note that a given smp_mb() takes
 	 * effect not just for the task executing it, but also for any
 	 * later task running on that same CPU.
 	 *
-	 * That is, there can be almost Nt + Nc further increments of
-	 * ->srcu_lock_count[idx] for the old index, where Nc is the number
-	 * of CPUs.  But this is OK because the size of the task_struct
-	 * structure limits the value of Nt and current systems limit Nc
-	 * to a few thousand.
+	 * That is, there can be almost Nt + Nc further increments
+	 * of ->srcu_ctrs[idx].srcu_locks for the old index, where Nc
+	 * is the number of CPUs.  But this is OK because the size of
+	 * the task_struct structure limits the value of Nt and current
+	 * systems limit Nc to a few thousand.
 	 *
 	 * OK, but what about nesting?  This does impose a limit on
 	 * nesting of half of the size of the task_struct structure
@@ -581,10 +580,10 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
-		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
-		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
-		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
+		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
 	}
 	return sum;
 }
@@ -746,7 +745,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -760,7 +759,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -777,7 +776,7 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	atomic_long_inc(&sdp->srcu_lock_count[idx]);
+	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -793,7 +792,7 @@ void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
-	atomic_long_inc(&sdp->srcu_unlock_count[idx]);
+	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_unlocks);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
@@ -1123,17 +1122,17 @@ static void srcu_flip(struct srcu_struct *ssp)
 	/*
 	 * Because the flip of ->srcu_idx is executed only if the
 	 * preceding call to srcu_readers_active_idx_check() found that
-	 * the ->srcu_unlock_count[] and ->srcu_lock_count[] sums matched
-	 * and because that summing uses atomic_long_read(), there is
-	 * ordering due to a control dependency between that summing and
-	 * the WRITE_ONCE() in this call to srcu_flip().  This ordering
-	 * ensures that if this updater saw a given reader's increment from
-	 * __srcu_read_lock(), that reader was using a value of ->srcu_idx
-	 * from before the previous call to srcu_flip(), which should be
-	 * quite rare.  This ordering thus helps forward progress because
-	 * the grace period could otherwise be delayed by additional
-	 * calls to __srcu_read_lock() using that old (soon to be new)
-	 * value of ->srcu_idx.
+	 * the ->srcu_ctrs[].srcu_unlocks and ->srcu_ctrs[].srcu_locks sums
+	 * matched and because that summing uses atomic_long_read(),
+	 * there is ordering due to a control dependency between that
+	 * summing and the WRITE_ONCE() in this call to srcu_flip().
+	 * This ordering ensures that if this updater saw a given reader's
+	 * increment from __srcu_read_lock(), that reader was using a value
+	 * of ->srcu_idx from before the previous call to srcu_flip(),
+	 * which should be quite rare.  This ordering thus helps forward
+	 * progress because the grace period could otherwise be delayed
+	 * by additional calls to __srcu_read_lock() using that old (soon
+	 * to be new) value of ->srcu_idx.
 	 *
 	 * This sum-equality check and ordering also ensures that if
 	 * a given call to __srcu_read_lock() uses the new value of
@@ -1914,8 +1913,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			struct srcu_data *sdp;
 
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			u0 = data_race(atomic_long_read(&sdp->srcu_unlock_count[!idx]));
-			u1 = data_race(atomic_long_read(&sdp->srcu_unlock_count[idx]));
+			u0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_unlocks));
+			u1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks));
 
 			/*
 			 * Make sure that a lock is always counted if the corresponding
@@ -1923,8 +1922,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			 */
 			smp_rmb();
 
-			l0 = data_race(atomic_long_read(&sdp->srcu_lock_count[!idx]));
-			l1 = data_race(atomic_long_read(&sdp->srcu_lock_count[idx]));
+			l0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_locks));
+			l1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks));
 
 			c0 = l0 - u0;
 			c1 = l1 - u1;
-- 
2.39.5 (Apple Git-154)


