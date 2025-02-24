Return-Path: <linux-kselftest+bounces-27301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6EAA41357
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1F7A5188
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45421C7009;
	Mon, 24 Feb 2025 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKcWl11q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110651B0413;
	Mon, 24 Feb 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363747; cv=none; b=kwD+fI2z1nHbIVIDXknhyKV1aHuAmBWZjIadEGs8cNHXtfo+2uTmbF35UK/9NfmRYBwrfDuu286/cmdCeTzpCatXeyXMk4UJSyAFWDgAmDvOKkcAJ/tpunUn1Kvig78QcnRSAuqnCwxZG8EZ50gIBYnTQvbUPUy1YjDY/2uG98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363747; c=relaxed/simple;
	bh=zRra4zBBZtDQO3WoVybDDJwUOBjEV98iMvYd/Qf7oxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZI4spgjbzTQeMmXiOygvT1+arDQboommqHmt7Y+MjG3OButsS/tnLpfl/W0G3kWGdVvuYFNaVl9mzH35Kc2TeJeubc0AueXlsB4YMv8oWwAI9ReR3jo9a5HocIokgHurmrz/EVObqKe9WeDxk3gKrTJ5Lkd2/XuSuN8rjxYV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKcWl11q; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0a1677aebso381003285a.0;
        Sun, 23 Feb 2025 18:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363745; x=1740968545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h9z6N5Bvl2pb8/I5e6YQjTUdeZNzH7F0rRvppc4nnQA=;
        b=JKcWl11qrjp4qaPyL+L2KEdieCKWJqyDBYV/4Kjq33/xWF2cn0T+yML5XmG/OqaoAX
         FWt9ZsYJqy+ZIrnZouA6ahkSijlCG9onxsmwV5Ubm7q/4EhAHsxRxpuhnZT1YevEqUjq
         5hDw64uCpklSm1eTrD7bQjGbZI5oTUonU9NUaOzgULAy42T6bJKOuHPMaWiAkX6wZbnq
         bRur1gK0lDtOsWoq/8buwYGBeKe/E/X+UAk9wA2uf+gDEtvvJRNqmYKkX88tWrb3H4Eg
         tJXF73svRPhjoEL9tVv1mplaG0VCDQ8hyVph0Hyn++xgwOpQP43XDkK3skS3gQm+63Kq
         FvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363745; x=1740968545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9z6N5Bvl2pb8/I5e6YQjTUdeZNzH7F0rRvppc4nnQA=;
        b=a3dYCltreXimbNHPzUe/bacFZpzW/hJ7BGTxi9SfXDW+Cq4+8i4Lm+0k+C1/kKD4Z0
         ZKKemNKLGMFzgsUN2ut7k1xc4ePA5StJKmk+ZueDxSA62d+d6p0XBw2ulQdFNpPrd3Cz
         WQziQ1eO89z8Sh6UPE88JJX98s9HUX6iYnxOCF2W26UqHgkYKu2ZcIQP+KEoYoN0EZED
         q7o+qXsSRNtatpTW24wANd00/VRlxFi8aVkpyK0z5esxexNGVT+tSUVEQggcOMBGdC8j
         UyxufxFTFtKsh8Vg58XocgEq6zO+DPA2XqrSMiQsy+YAd81nko2iNJMf7lJWufpniUi4
         zfSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNVY7REWT4Qo28RZJUwY8yAKBpoR/d8SgiXvEwqyAPnR7QvOhI2X3GbufHlGc28V/8PofRF70k14TL0MS96Kcd@vger.kernel.org, AJvYcCWzD3A87ociruc5cMmUcvmcp/pAiNQoee/I3MlZCvu/IvXFqwaq81XtSl4ZZUj1utpvXvY=@vger.kernel.org, AJvYcCXoJLV3vaMU5va3AACzKMWHJbRNgWAaHwm6NrvlJ+5c++Vlm2qDhyUa8Pbi6De6+Hp6h5yFdzeZw/vECCTm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fGDTl2vEo48Pfz2h5rXN8v2L5gJ2uA4o6C/WMB9LjQUK6Ko3
	kflmBle9kdt2xo6TQbPmK4w6udoEszSfSk8KXvXgBDYPSv6gpLUKhzS1MA==
X-Gm-Gg: ASbGncuKBnvGlF2lWVgQC1xOeh9q/GXjqwEdkyLmFK+krYTvLbDBLOa6h2bQWVCydMr
	S+OAQJ88QGqewlQZJ1YFg0kDkg3S7yc5gugSfD2scbUjbN5dJtimjRR3tDuzbZiIOCo18asY39j
	JcmjzefpcMzTLvq3jrBN5/zqkuElA8Wf8LLIezMgUxThC3y0Uz1OrsVkrX8ZzbsBMiGAdEthmNN
	An8wOvpjBL1mv9rX1+X3thHODo2IgfGX3OVP2FZKhwhIF8KNPxOOCKfmnWeG1LOg5020XkISHoo
	2gS1UqiyhUQ73GT+n9wF83kOedOKq7iKvSu9r/+DVI7z6lUIwZ+Ba/RQNCHbAS+QuN9h1xToKID
	WUMue/CPWlc9qTTJZ
X-Google-Smtp-Source: AGHT+IFgbIWJVDI5TX05kb/ZTvdYGWwbSJPyqHQrPiTksA7vZMhwnuGLYKGh02gnGO7Mv+ckvF8gdg==
X-Received: by 2002:a05:620a:800b:b0:7c0:c264:6737 with SMTP id af79cd13be357-7c0cf8b015emr1564047085a.4.1740363744776;
        Sun, 23 Feb 2025 18:22:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09e95b68fsm938235185a.12.2025.02.23.18.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:24 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D8C81200043;
	Sun, 23 Feb 2025 21:22:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 23 Feb 2025 21:22:23 -0500
X-ME-Sender: <xms:39e7Z_wSmEK1U1vzI5wrbHgnv6H9DGZxR0OXK6HdRtEfkl84KxtuHw>
    <xme:39e7Z3SZFEzsmnzYCoaSu6hnTPM5BjqIBXb-AVRqPMEUeOPI_BQsFvKC6Lh5wAEVl
    ycXxC6Ynd1GHXvDww>
X-ME-Received: <xmr:39e7Z5Xm8-zwf0StX0Eh6XvnpsjUob-pm036t2GTDPz0zytG4kJiuF5MGQ>
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
X-ME-Proxy: <xmx:39e7Z5h3QhH7c9jN6sIF5qz80qJ6982MuwFD4JMuPbriDBpzZ3Lfmg>
    <xmx:39e7ZxBAI10b4erUcp2BUo4MMeq2QMPbfiWW5sz8WmeNROTkYzyUoQ>
    <xmx:39e7ZyJDN8M5e07s0DKsmGCBpwLZv-QJze-FFqJz8Ea-EyjhHvne2Q>
    <xmx:39e7ZwCzzZbnGheOMW7NudLTiB0O0r4BgzDzzZFJAffRnmsKoLe6IQ>
    <xmx:39e7Z9wDGBE0nDZfAbGNADh5eY5vU4gdOxRKheG--YsK7xhrJS80p3_9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:22 -0500 (EST)
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
	kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 05/20] srcu: Make SRCU readers use ->srcu_ctrs for counter selection
Date: Sun, 23 Feb 2025 18:21:59 -0800
Message-Id: <20250224022214.12037-6-boqun.feng@gmail.com>
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

This commit causes SRCU readers to use ->srcu_ctrs for counter
selection instead of ->srcu_idx.  This takes another step towards
array-indexing-free SRCU readers.

[ paulmck: Apply kernel test robot feedback. ]

Co-developed-by: Z qiang <qiang.zhang1211@gmail.com>
Signed-off-by: Z qiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcutree.h |  9 +++++----
 kernel/rcu/srcutree.c    | 23 +++++++++++++----------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index c794d599db5c..1b01ced61a45 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -101,6 +101,7 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
+	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	struct lockdep_map dep_map;
 	struct srcu_usage *srcu_sup;		/* Update-side data. */
@@ -167,6 +168,7 @@ struct srcu_struct {
 #define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
 {												\
 	.sda = &pcpu_name,									\
+	.srcu_ctrp = &pcpu_name.srcu_ctrs[0],							\
 	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 }
 
@@ -222,13 +224,12 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
  */
 static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
+	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d7ee2f345e19..7efde1a2344e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -253,8 +253,10 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
 	ssp->srcu_sup->sda_is_static = is_static;
-	if (!is_static)
+	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
+	}
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
@@ -742,12 +744,11 @@ EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
+	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -772,13 +773,12 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 {
-	int idx;
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+	struct srcu_ctr __percpu *scpp = READ_ONCE(ssp->srcu_ctrp);
+	struct srcu_ctr *scp = raw_cpu_ptr(scpp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
+	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scpp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
@@ -1152,6 +1152,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
+	WRITE_ONCE(ssp->srcu_ctrp,
+		   &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
@@ -2000,6 +2002,7 @@ static int srcu_module_coming(struct module *mod)
 		ssp->sda = alloc_percpu(struct srcu_data);
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
 	}
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


