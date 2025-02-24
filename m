Return-Path: <linux-kselftest+bounces-27302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AB7A41362
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2143B6452
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C11C8608;
	Mon, 24 Feb 2025 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVVtcLTl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF51C6FEC;
	Mon, 24 Feb 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363749; cv=none; b=T8VY8Bulv0z5VlHDARi8y4XFblvfVXN4MGlUEt9JNiFXUvXpF/yXtn90KFWZHBzi23kfKNwMFr7CCbC3sOyuXm9Ja3V9XsaKWO6b5iShKngna4VCzcvcD4RUVWBGrIfEYn2DLswGTgwMumsQ6xVih5P39zdUv8Sq8rjbA+S+NOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363749; c=relaxed/simple;
	bh=n8KYK+ApLOt1uHZCuF43++Q8gIRMXbNEKX0ciRrabXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhjGqXDTnWgcltalZb535Qc6pLtOG2CILGCZUkeE0yA7gGl6SI/hn97IEbp2vX0RfCitBcToIlUWuNDsgUjQ4/1ytsMdC5xkT6ueu4NyGOFGKFOIGsCTgwi1wsb7lZjYcgKDQCoAPuFCzgLMQNoM6lq061HGdWGmb/t8EZIyznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVVtcLTl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c09a30e14dso688316085a.0;
        Sun, 23 Feb 2025 18:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363746; x=1740968546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AcTo3KBDVWrf1oe45FpKbyw6ahcrt2yvV77yr4g8K3g=;
        b=mVVtcLTlHQXj/KKTCK2fvFuZOEce7Px7xt25KIwN188XTTvCCg3Nh7XvMEdxAMeA3l
         vANHClV2dRNlBLZpmls87ufEHGxqBKbVluz6uVRmjIzy4Bc7mKYVDw3Bf7oXgByWrnDK
         i2FnoSpVRxhb0bLfRXLy5/jqa9svJJ8oCh5ulKBb6XbMAzaXEvchNJlc9dWhuzwLKSQD
         6Xc8HDLv0qPZNhfUy4VYtQIgd1I2GxAjLBT95KgZhBFKRQoy6QqPLZo0JKmqdvErXnwe
         ecItlmryEyDnpeYwHETbmlgI/XjDtcndrlMcDpD1ETTdDpa/b67UcDG7dsv1+NAOoFV8
         HjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363746; x=1740968546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcTo3KBDVWrf1oe45FpKbyw6ahcrt2yvV77yr4g8K3g=;
        b=I0t9xiSj8qHOf3kBnqD6F2BxImfj5fZSCiaPz+gf/mo55L07/SSOw+4zjC7d1gsPAo
         ZFmRTu9+vhZLuCNF5DRkmB+xQ9qsZUSW4DCBBnawg53LzVwD8eKcaBas7axmhxu6P4k1
         gYg7POYQDXhD9gto+7JbprgycYVwbqqTjLbwDQXDL7+eGG152LOynkFe+nayeFEBvvK+
         osMtrBnchCUb4cS9oKk7u4bzCVqpC4f3FlRzRMt9cpjiNtiyBvu9pq9j8lLwR0M/ZOj5
         Cgo0zPwiPY8T2bLk8WjEgin4fC85mKGq75bMTW365Dq13KTYcn3GvZsPvYBNeHmDAjxX
         VRAg==
X-Forwarded-Encrypted: i=1; AJvYcCWM78JkMnXhH1pWrNyhiUqcVin3V72pimR1BGlrprdqAeh1nDUmwenygI7YVnSoxOFXruV5YnJBx0QoC2bjLOg2@vger.kernel.org, AJvYcCXO+2NTXleUgNrYDpQ368legic6Et5/O6gRKr624yZL2hsmgmsvjUKysHji2QdECE6Zs+PqG6KI8Nl0HneS@vger.kernel.org, AJvYcCXdb9GeWNFz0DB5/Ny3f/5Gt87gqAB3U3ip6t+w17fO0jgpC8vKbjlmQ5gO9CkfIr219/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4uBmsIMixYnqloJbs64c9xdAai9r2aLO6RM9F/kBRCog6fWdz
	wWVcIrzp5wIw1DsJzMVPXsqvb7HR409vzSuzZeqgeaFpNbemmU5O
X-Gm-Gg: ASbGncvB5rbADtlTojnk3m4JvJumGBoRC8XxKkAc7Z4ZNEhIi4aKYKJJxL40BajAwPP
	a/5Scr397XNqXH7VdazElfpb1jxMyJJ4CE7T74uenfDXzHtOcCNSSKmbzAoUgg7Iu4xd9ncsoMp
	Yj/Y+SsOnuvEz1VRhHUTyVbCSAyUWHK4Ve9Y1DfsvIaDAa85ia6kds0lcTsTLQNuRyyy6T5Oz4/
	cPXB7qqZm1ubzBQNiYkY5TBYsu0DhoVc3KYE8Cf3yBcla97ylN2/oW5SExPYPpUDxcZwRz7KbNy
	s+HII2w8CtP6i/aJooY08Olm/FxoQH0xkrmbVDY2QYnMCzgqjLwTDkexdS7X2qrrxtdbZXYkSvI
	UEZOBq6jxOshncrEl
X-Google-Smtp-Source: AGHT+IGEM+/HZwVspmar+q03xk2siTeyFzKw3jnpholWrfwhHL/2SXZ2X7t+5uARsJftW+6Gd12JeA==
X-Received: by 2002:a05:620a:4045:b0:7c0:c282:702d with SMTP id af79cd13be357-7c0cef561aemr1595736785a.39.1740363745924;
        Sun, 23 Feb 2025 18:22:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c2d9f679sm552767685a.5.2025.02.23.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:25 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id D791F1200066;
	Sun, 23 Feb 2025 21:22:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:24 -0500
X-ME-Sender: <xms:4Ne7ZylzPOwdBYPn8effpEMw-aXI1oAw21c4P4vd5Ch2lsegbQtvXA>
    <xme:4Ne7Z5369eRoZg3PYNQq2-uBfoWaeLZJfXwbLGFDSJgCCjGPUoy5hlI9Xf5v6Ae1I
    tN5U2v1BJFVjVd-jw>
X-ME-Received: <xmr:4Ne7ZwobAaIyUMRiSVVudBtPixQj8jw4quiLTq7PRo_WLFYojDbULbnYbg>
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
X-ME-Proxy: <xmx:4Ne7Z2nr3tYvlExpwVFaEx4Kx9AA5CWQV0K5fezh4rhW5Je31rKV5g>
    <xmx:4Ne7Zw1WehOjfcvRYyqdLjBYWn3ERTJeugP0rah_XPYzz-DjYwBleA>
    <xmx:4Ne7Z9vtSE-XcqDIIT1GiKdjhojCgas3HzkP1lS5_WU5CLhNbzOOYg>
    <xmx:4Ne7Z8WZQernCxnmhZNmmGklyV0rw3usEZNFxrpvU7OfX5YFO2KdSQ>
    <xmx:4Ne7Z71DYk4z7KPZ7jZomTVCkXynToMjmhTOoDZ4T853Z3uHRs1RXulI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:24 -0500 (EST)
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
Subject: [PATCH rcu 06/20] srcu: Make Tree SRCU updates independent of ->srcu_idx
Date: Sun, 23 Feb 2025 18:22:00 -0800
Message-Id: <20250224022214.12037-7-boqun.feng@gmail.com>
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

This commit makes Tree SRCU updates independent of ->srcu_idx, then
drop ->srcu_idx.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h |  1 -
 kernel/rcu/srcutree.c    | 68 ++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 1b01ced61a45..6b7eba59f384 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -100,7 +100,6 @@ struct srcu_usage {
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	struct lockdep_map dep_map;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7efde1a2344e..247bdf42fb54 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -246,7 +246,6 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
-	ssp->srcu_idx = 0;
 	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
@@ -510,38 +509,39 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * If the locks are the same as the unlocks, then there must have
 	 * been no readers on this index at some point in this function.
 	 * But there might be more readers, as a task might have read
-	 * the current ->srcu_idx but not yet have incremented its CPU's
+	 * the current ->srcu_ctrp but not yet have incremented its CPU's
 	 * ->srcu_ctrs[idx].srcu_locks counter.  In fact, it is possible
 	 * that most of the tasks have been preempted between fetching
-	 * ->srcu_idx and incrementing ->srcu_ctrs[idx].srcu_locks.  And there
-	 * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
-	 * in a system whose address space was fully populated with memory.
-	 * Call this quantity Nt.
+	 * ->srcu_ctrp and incrementing ->srcu_ctrs[idx].srcu_locks.  And
+	 * there could be almost (ULONG_MAX / sizeof(struct task_struct))
+	 * tasks in a system whose address space was fully populated
+	 * with memory.  Call this quantity Nt.
 	 *
-	 * So suppose that the updater is preempted at this point in the
-	 * code for a long time.  That now-preempted updater has already
-	 * flipped ->srcu_idx (possibly during the preceding grace period),
-	 * done an smp_mb() (again, possibly during the preceding grace
-	 * period), and summed up the ->srcu_ctrs[idx].srcu_unlocks counters.
-	 * How many times can a given one of the aforementioned Nt tasks
-	 * increment the old ->srcu_idx value's ->srcu_ctrs[idx].srcu_locks
-	 * counter, in the absence of nesting?
+	 * So suppose that the updater is preempted at this
+	 * point in the code for a long time.  That now-preempted
+	 * updater has already flipped ->srcu_ctrp (possibly during
+	 * the preceding grace period), done an smp_mb() (again,
+	 * possibly during the preceding grace period), and summed up
+	 * the ->srcu_ctrs[idx].srcu_unlocks counters.  How many times
+	 * can a given one of the aforementioned Nt tasks increment the
+	 * old ->srcu_ctrp value's ->srcu_ctrs[idx].srcu_locks counter,
+	 * in the absence of nesting?
 	 *
 	 * It can clearly do so once, given that it has already fetched
-	 * the old value of ->srcu_idx and is just about to use that
+	 * the old value of ->srcu_ctrp and is just about to use that
 	 * value to index its increment of ->srcu_ctrs[idx].srcu_locks.
 	 * But as soon as it leaves that SRCU read-side critical section,
 	 * it will increment ->srcu_ctrs[idx].srcu_unlocks, which must
-	 * follow the updater's above read from that same value.	Thus,
-	 * as soon the reading task does an smp_mb() and a later fetch from
-	 * ->srcu_idx, that task will be guaranteed to get the new index.
+	 * follow the updater's above read from that same value.  Thus,
+	   as soon the reading task does an smp_mb() and a later fetch from
+	 * ->srcu_ctrp, that task will be guaranteed to get the new index.
 	 * Except that the increment of ->srcu_ctrs[idx].srcu_unlocks
 	 * in __srcu_read_unlock() is after the smp_mb(), and the fetch
-	 * from ->srcu_idx in __srcu_read_lock() is before the smp_mb().
-	 * Thus, that task might not see the new value of ->srcu_idx until
+	 * from ->srcu_ctrp in __srcu_read_lock() is before the smp_mb().
+	 * Thus, that task might not see the new value of ->srcu_ctrp until
 	 * the -second- __srcu_read_lock(), which in turn means that this
 	 * task might well increment ->srcu_ctrs[idx].srcu_locks for the
-	 * old value of ->srcu_idx twice, not just once.
+	 * old value of ->srcu_ctrp twice, not just once.
 	 *
 	 * However, it is important to note that a given smp_mb() takes
 	 * effect not just for the task executing it, but also for any
@@ -1095,7 +1095,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 /*
  * Wait until all readers counted by array index idx complete, but
  * loop an additional time if there is an expedited grace period pending.
- * The caller must ensure that ->srcu_idx is not changed while checking.
+ * The caller must ensure that ->srcu_ctrp is not changed while checking.
  */
 static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
@@ -1113,14 +1113,14 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 }
 
 /*
- * Increment the ->srcu_idx counter so that future SRCU readers will
+ * Increment the ->srcu_ctrp counter so that future SRCU readers will
  * use the other rank of the ->srcu_(un)lock_count[] arrays.  This allows
  * us to wait for pre-existing readers in a starvation-free manner.
  */
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Because the flip of ->srcu_idx is executed only if the
+	 * Because the flip of ->srcu_ctrp is executed only if the
 	 * preceding call to srcu_readers_active_idx_check() found that
 	 * the ->srcu_ctrs[].srcu_unlocks and ->srcu_ctrs[].srcu_locks sums
 	 * matched and because that summing uses atomic_long_read(),
@@ -1128,15 +1128,15 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 * summing and the WRITE_ONCE() in this call to srcu_flip().
 	 * This ordering ensures that if this updater saw a given reader's
 	 * increment from __srcu_read_lock(), that reader was using a value
-	 * of ->srcu_idx from before the previous call to srcu_flip(),
+	 * of ->srcu_ctrp from before the previous call to srcu_flip(),
 	 * which should be quite rare.  This ordering thus helps forward
 	 * progress because the grace period could otherwise be delayed
 	 * by additional calls to __srcu_read_lock() using that old (soon
-	 * to be new) value of ->srcu_idx.
+	 * to be new) value of ->srcu_ctrp.
 	 *
 	 * This sum-equality check and ordering also ensures that if
 	 * a given call to __srcu_read_lock() uses the new value of
-	 * ->srcu_idx, this updater's earlier scans cannot have seen
+	 * ->srcu_ctrp, this updater's earlier scans cannot have seen
 	 * that reader's increments, which is all to the good, because
 	 * this grace period need not wait on that reader.  After all,
 	 * if those earlier scans had seen that reader, there would have
@@ -1151,7 +1151,6 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
 	WRITE_ONCE(ssp->srcu_ctrp,
 		   &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
 
@@ -1466,8 +1465,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  *
  * Wait for the count to drain to zero of both indexes. To avoid the
  * possible starvation of synchronize_srcu(), it waits for the count of
- * the index=((->srcu_idx & 1) ^ 1) to drain to zero at first,
- * and then flip the srcu_idx and wait for the count of the other index.
+ * the index=!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]) to drain to zero
+ * at first, and then flip the ->srcu_ctrp and wait for the count of the
+ * other index.
  *
  * Can block; must be called from process context.
  *
@@ -1693,7 +1693,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 
 	/*
 	 * Because readers might be delayed for an extended period after
-	 * fetching ->srcu_idx for their index, at any point in time there
+	 * fetching ->srcu_ctrp for their index, at any point in time there
 	 * might well be readers using both idx=0 and idx=1.  We therefore
 	 * need to wait for readers to clear from both index values before
 	 * invoking a callback.
@@ -1721,7 +1721,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
-		idx = 1 ^ (ssp->srcu_idx & 1);
+		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 1)) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
@@ -1739,7 +1739,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		 * SRCU read-side critical sections are normally short,
 		 * so check at least twice in quick succession after a flip.
 		 */
-		idx = 1 ^ (ssp->srcu_idx & 1);
+		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 2)) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
@@ -1897,7 +1897,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 	int ss_state = READ_ONCE(ssp->srcu_sup->srcu_size_state);
 	int ss_state_idx = ss_state;
 
-	idx = ssp->srcu_idx & 0x1;
+	idx = ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0];
 	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
 		ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
 	pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
-- 
2.39.5 (Apple Git-154)


