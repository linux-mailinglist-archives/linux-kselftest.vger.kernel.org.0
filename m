Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F916BDF63
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCQDPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCQDOJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC2E1CAE2;
        Thu, 16 Mar 2023 20:13:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r16so4338587qtx.9;
        Thu, 16 Mar 2023 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lr+K/uboeCkCqHfD20mrlauFmTp3I14TicVqGgSXV88=;
        b=CCWsmXAZCxxzokyLycN9oF7fEn9KVBXw90UAFywsrDulUO+iiFO8duc63LMqPmW6CJ
         qxLqNzkNtWbQ4UuW1j05BAqZrfSFlMrHWDo7OwyiFyuYeuaJwBvVdHb5uDf+7kT4Koiv
         mmZM9lgaHCByu5UzloMekKPOBYRJVDVU7HM1rcs5X1qkXI2Zgf4AOv8VCfj5r/sdeF5/
         cbrQcik2TmDCk4ok945ocXtZNCJL1CuK1dwLESXvsl9frGCDuXElUW5zE7TUNJ7CLmft
         3rVX3p6PXQotiNjGdkR9NKXPDGaCNgL+UadZvfANcXeFWw9pOY+hIYUplIT0L5rysaqN
         2Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lr+K/uboeCkCqHfD20mrlauFmTp3I14TicVqGgSXV88=;
        b=NDTC+htSPKQCyxN6DISA+q+8FAyzzlW0iNdifKf6xF5zBQ56Yrwz1xHcF9yii3VGy3
         roHuxJCax5eGTmLaR42sHxYxBh4umAiRvL6cIH5XzNs+whnobbppA++MH4X3yE9HYJNu
         nnmjjkc7npGfaRVxC8RaSMuB7jz9XzD0SCswK5geZ2Me8rqHQ3SBUE5A1I3Yn6Of8J18
         KsAM/fsPB/silc9oXQOirMLu5fmX0iRlvlZdNBiBR7ke2kPTPwY9vy0Fqsx5ZJ5LgLrX
         u/pTZdTYAFaYyPVE45LF4YYEZkwMTDQ7NBSjvROhcWEGDF6b+ZFwuSq7STiN/zsfsUmr
         yZEg==
X-Gm-Message-State: AO0yUKXQ6MDHOaqVprI3wXYb0lx2Mfy5Uf+UnBYFSKXcKMf5tyvbBMO8
        vrbzW+QPpgD3fqdflkeZyYk=
X-Google-Smtp-Source: AK7set9GMbqn9Qc3NwBg/WGH3yAz/kg582FuwtZLIWUD1V59erPO6l0iBDXQx8kiJ4DiaRsBsWtdHg==
X-Received: by 2002:a05:622a:1714:b0:3bf:cb70:8a4f with SMTP id h20-20020a05622a171400b003bfcb708a4fmr10161511qtk.41.1679022833868;
        Thu, 16 Mar 2023 20:13:53 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c2-20020a379a02000000b007436d0e9408sm786165qke.127.2023.03.16.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D941027C0054;
        Thu, 16 Mar 2023 23:13:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Mar 2023 23:13:52 -0400
X-ME-Sender: <xms:8NoTZOO5k028cHguxszDO3GhZvM4I4peTKSoBWKTtpBrT12YgiIkDQ>
    <xme:8NoTZM8zIkDH1PsW-os1KPZdTd8tcNk5u5p33YwdFXN8EmPylIE3ND_3KQ_GaElOH
    53PIl4Vz8uiaKf8qg>
X-ME-Received: <xmr:8NoTZFRhUEUhPs5PvHT9G1t6XDi3ZRv7ri_JlnFDqcgELsM5sOx4mcyaslk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:8NoTZOtU_pDYK7KujkKDBABOdwRfYf86kq0GRQtdvMacBSUF-b_RVg>
    <xmx:8NoTZGcOfYvoFwn8LiDjmBy-Z_Cmb9f1Xo4RV_SRgAc9Mk4t2F518g>
    <xmx:8NoTZC1ICtlw7jLJzKRPTuFMhvPD0C4xnsZzaDPm_Gjd36d5S6x_Rw>
    <xmx:8NoTZE9EXLe7NDONShRw-dY6BuzNewjPcwjVwIslW-yyxGVtD_Jk4Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:52 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 4/7] locking/lockdep: Improve the deadlock scenario print for sync and read lock
Date:   Thu, 16 Mar 2023 20:13:36 -0700
Message-Id: <20230317031339.10277-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317031339.10277-1-boqun.feng@gmail.com>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Lock scenario print is always a weak spot of lockdep splats. Improvement
can be made if we rework the dependency search and the error printing.

However without touching the graph search, we can improve a little for
the circular deadlock case, since we have the to-be-added lock
dependency, and know whether these two locks are read/write/sync.

In order to know whether a held_lock is sync or not, a bit was
"stolen" from ->references, which reduce our limit for the same lock
class nesting from 2^12 to 2^11, and it should still be good enough.

Besides, since we now have bit in held_lock for sync, we don't need the
"hardirqoffs being 1" trick, and also we can avoid the __lock_release()
if we jump out of __lock_acquire() before the held_lock stored.

With these changes, a deadlock case evolved with read lock and sync gets
a better print-out from:

	[...]  Possible unsafe locking scenario:
	[...]
	[...]        CPU0                    CPU1
	[...]        ----                    ----
	[...]   lock(srcuA);
	[...]                                lock(srcuB);
	[...]                                lock(srcuA);
	[...]   lock(srcuB);

to

	[...]  Possible unsafe locking scenario:
	[...]
	[...]        CPU0                    CPU1
	[...]        ----                    ----
	[...]   rlock(srcuA);
	[...]                                lock(srcuB);
	[...]                                lock(srcuA);
	[...]   sync(srcuB);

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 14d9dbedc6c1..b32256e9e944 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -134,7 +134,8 @@ struct held_lock {
 	unsigned int read:2;        /* see lock_acquire() comment */
 	unsigned int check:1;       /* see lock_acquire() comment */
 	unsigned int hardirqs_off:1;
-	unsigned int references:12;					/* 32 bits */
+	unsigned int sync:1;
+	unsigned int references:11;					/* 32 bits */
 	unsigned int pin_count;
 };
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 36430cf8e407..dcd1d5bfc1e0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1881,6 +1881,8 @@ print_circular_lock_scenario(struct held_lock *src,
 	struct lock_class *source = hlock_class(src);
 	struct lock_class *target = hlock_class(tgt);
 	struct lock_class *parent = prt->class;
+	int src_read = src->read;
+	int tgt_read = tgt->read;
 
 	/*
 	 * A direct locking problem where unsafe_class lock is taken
@@ -1908,7 +1910,10 @@ print_circular_lock_scenario(struct held_lock *src,
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
-	printk("  lock(");
+	if (tgt_read != 0)
+		printk("  rlock(");
+	else
+		printk("  lock(");
 	__print_lock_name(target);
 	printk(KERN_CONT ");\n");
 	printk("                               lock(");
@@ -1917,7 +1922,12 @@ print_circular_lock_scenario(struct held_lock *src,
 	printk("                               lock(");
 	__print_lock_name(target);
 	printk(KERN_CONT ");\n");
-	printk("  lock(");
+	if (src_read != 0)
+		printk("  rlock(");
+	else if (src->sync)
+		printk("  sync(");
+	else
+		printk("  lock(");
 	__print_lock_name(source);
 	printk(KERN_CONT ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
@@ -4531,7 +4541,13 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 					return 0;
 		}
 	}
-	if (!hlock->hardirqs_off) {
+
+	/*
+	 * For lock_sync(), don't mark the ENABLED usage, since lock_sync()
+	 * creates no critical section and no extra dependency can be introduced
+	 * by interrupts
+	 */
+	if (!hlock->hardirqs_off && !hlock->sync) {
 		if (hlock->read) {
 			if (!mark_lock(curr, hlock,
 					LOCK_ENABLED_HARDIRQ_READ))
@@ -4910,7 +4926,7 @@ static int __lock_is_held(const struct lockdep_map *lock, int read);
 static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			  int trylock, int read, int check, int hardirqs_off,
 			  struct lockdep_map *nest_lock, unsigned long ip,
-			  int references, int pin_count)
+			  int references, int pin_count, int sync)
 {
 	struct task_struct *curr = current;
 	struct lock_class *class = NULL;
@@ -4961,7 +4977,8 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	class_idx = class - lock_classes;
 
-	if (depth) { /* we're holding locks */
+	if (depth && !sync) {
+		/* we're holding locks and the new held lock is not a sync */
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
 			if (!references)
@@ -4995,6 +5012,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	hlock->trylock = trylock;
 	hlock->read = read;
 	hlock->check = check;
+	hlock->sync = !!sync;
 	hlock->hardirqs_off = !!hardirqs_off;
 	hlock->references = references;
 #ifdef CONFIG_LOCK_STAT
@@ -5056,6 +5074,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
+	/* For lock_sync(), we are done here since no actual critical section */
+	if (hlock->sync)
+		return 1;
+
 	curr->curr_chain_key = chain_key;
 	curr->lockdep_depth++;
 	check_chain_key(curr);
@@ -5197,7 +5219,7 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 				    hlock->read, hlock->check,
 				    hlock->hardirqs_off,
 				    hlock->nest_lock, hlock->acquire_ip,
-				    hlock->references, hlock->pin_count)) {
+				    hlock->references, hlock->pin_count, 0)) {
 		case 0:
 			return 1;
 		case 1:
@@ -5667,7 +5689,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	lockdep_recursion_inc();
 	__lock_acquire(lock, subclass, trylock, read, check,
-		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
+		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0, 0);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
@@ -5700,11 +5722,6 @@ EXPORT_SYMBOL_GPL(lock_release);
  * APIs are used to wait for one or multiple critical sections (on other CPUs
  * or threads), and it means that calling these APIs inside these critical
  * sections is potential deadlock.
- *
- * This annotation acts as an acqurie+release anontation pair with hardirqoff
- * being 1. Since there's no critical section, no interrupt can create extra
- * dependencies "inside" the annotation, hardirqoff == 1 allows us to avoid
- * false positives.
  */
 void lock_sync(struct lockdep_map *lock, unsigned subclass, int read,
 	       int check, struct lockdep_map *nest_lock, unsigned long ip)
@@ -5718,10 +5735,9 @@ void lock_sync(struct lockdep_map *lock, unsigned subclass, int read,
 	check_flags(flags);
 
 	lockdep_recursion_inc();
-	__lock_acquire(lock, subclass, 0, read, check, 1, nest_lock, ip, 0, 0);
-
-	if (__lock_release(lock, ip))
-		check_chain_key(current);
+	__lock_acquire(lock, subclass, 0, read, check,
+		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0, 1);
+	check_chain_key(current);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
-- 
2.39.2

