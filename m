Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529296C5DEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCWE0a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCWE02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:28 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7194CDCA;
        Wed, 22 Mar 2023 21:26:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t19so11236585qta.12;
        Wed, 22 Mar 2023 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKxPTZUACHHdc1pvRq4KfUqsAtZ1SCwmF/A0Vi1Xbek=;
        b=m+utpNOvLtMtLHZsOXVIDWi1sJ1iSKiWzIo/ssZgjQBXonuuP9OW5ryYge539kDj8R
         bCvyaY6fyNtXF8yELxGH9jWtW0LtbMDZbYb1Cv7DJUn0pmD8wyaIQw1caYbztPGaEBZ0
         yidCzTlps47PK/cNB8zTt1LUy5O/2L0t0F0+1CmoKiyqZmqAvkSCR3rGKKeokclBOcnS
         RiwjdSenU8fq+tAD6AbomJuZBYCOW4cM91h9wT3p7KIDctuhqJFrA8FSqCa0pXG9mBy/
         ZcR3PJECTvs4uYgr2hmVvm647eZK2i6nLETcojvOmh+YMXvJamZ8Ano4hMZ48nzjuMxV
         AYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKxPTZUACHHdc1pvRq4KfUqsAtZ1SCwmF/A0Vi1Xbek=;
        b=PEToDF/zuTn1dsCwkBRv11N/aXpxxAgwlDO6boH94mSaydbf/yWchJ1I9zSKR5zKSq
         xoppRwpry4WSSk5Mz/7wS/6LHBP9GlM+CqpGAkZ3INy7IW0IcfwueGOPIs14gcnGWA76
         uugU1CZCOdfAndz/xUChN/hv6nj3L/aHXo1bpC7kCqOi+djvde/0YPfoNl50jTItB8un
         AEIVX/uJxa1lsViTXemDoelpMsbQpgQXQL02GLWMkbZGhbXh5ewCmtvSdz0i/TTPrnBD
         Dh7zap6DLl+oqDO7Zh/erRwgG7JeA5xhLzJ3+qv2PBh/2R2fX0KsMdu6UnpOrHLu/vEx
         w8RA==
X-Gm-Message-State: AO0yUKV3dLDCr5jA0qYcE/kP9xQqCC9FLdS1nCgHyCrfApilL+CDoWah
        RpmHpI2qrvCeakiJnrjEgZ8=
X-Google-Smtp-Source: AK7set9RdDRQNSOIDut59gHr4I21Q/SHSi1PhwynBI2f6lXXe8D/CIGz48jpBNEayxF3xhR1txgN3g==
X-Received: by 2002:ac8:5bc2:0:b0:3d9:cb72:3653 with SMTP id b2-20020ac85bc2000000b003d9cb723653mr8890300qtb.25.1679545586769;
        Wed, 22 Mar 2023 21:26:26 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t10-20020a37aa0a000000b0074683c45f6csm7760420qke.1.2023.03.22.21.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id A760927C0054;
        Thu, 23 Mar 2023 00:26:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 00:26:25 -0400
X-ME-Sender: <xms:8dQbZPF7joTM2MFmT15AJl3N0sJ80CSPpxX2bn6_kpCfg8dYzAi5qw>
    <xme:8dQbZMVnJ_xjhKkpBL_VZa7y35ulqeQBUP0brymQkXl7t44d_WW083nwHw4F-GRiy
    rLayk4tM4hYG97b5w>
X-ME-Received: <xmr:8dQbZBKF_jqa9OcYifQvrj6VOUADPwKY1gjDwTpVKtqIT1TGGsECKYu8A7d1W1FOxcko3hxpdnGWDoPTIYlQg3FGk55gYhPKYaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8dQbZNFAaFezVzrRx5lSfiJA5tgcGMSq91wmPIRAKYFa4mgxbibO4g>
    <xmx:8dQbZFUjjxzASEKGoazmuk3wJkCW_HE-xe7vvBrsoFWuGYGAjyjWQA>
    <xmx:8dQbZIMF84sNeyl0ltZ8rW7tklU09Ztmnu2ExLJeVqrEd8me-HFZFg>
    <xmx:8dQbZC0PIA2c2XVRpqjumAbF52RrhYFC_HzZMY2xp2F7bMCb5mejIQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:24 -0400 (EDT)
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
Subject: [PATCH rcu v2 1/7] locking/lockdep: Introduce lock_sync()
Date:   Wed, 22 Mar 2023 21:26:08 -0700
Message-Id: <20230323042614.1191120-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230323042614.1191120-1-boqun.feng@gmail.com>
References: <20230323042614.1191120-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, functions like synchronize_srcu() do not have lockdep
annotations resembling those of other write-side locking primitives.
Such annotations might look as follows:

	lock_acquire();
	lock_release();

Such annotations would tell lockdep that synchronize_srcu() acts like
an empty critical section that waits for other (read-side) critical
sections to finish.  This would definitely catch some deadlock, but
as pointed out by Paul Mckenney [1], this could also introduce false
positives because of irq-safe/unsafe detection.  Of course, there are
tricks could help with this:

	might_sleep(); // Existing statement in __synchronize_srcu().
	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
		local_irq_disable();
		lock_acquire();
		lock_release();
		local_irq_enable();
	}

But it would be better for lockdep to provide a separate annonation for
functions like synchronize_srcu(), so that people won't need to repeat
the ugly tricks above.

Therefore introduce lock_sync(), which is simply an lock+unlock
pair with no irq safe/unsafe deadlock check.  This works because the
to-be-annontated functions do not create real critical sections, and
there is therefore no way that irq can create extra dependencies.

[1]: https://lore.kernel.org/lkml/20180412021233.ewncg5jjuzjw3x62@tardis/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ boqun: Fix typos reported by Davidlohr Bueso and Paul E. Mckenney ]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  5 +++++
 kernel/locking/lockdep.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1023f349af71..14d9dbedc6c1 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -268,6 +268,10 @@ extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 extern void lock_release(struct lockdep_map *lock, unsigned long ip);
 
+extern void lock_sync(struct lockdep_map *lock, unsigned int subclass,
+		      int read, int check, struct lockdep_map *nest_lock,
+		      unsigned long ip);
+
 /* lock_is_held_type() returns */
 #define LOCK_STATE_UNKNOWN	-1
 #define LOCK_STATE_NOT_HELD	0
@@ -554,6 +558,7 @@ do {									\
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
+#define lock_map_sync(l)			lock_sync(l, 0, 0, 1, NULL, _THIS_IP_)
 
 #ifdef CONFIG_PROVE_LOCKING
 # define might_lock(lock)						\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..3ee3b278789d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5693,6 +5693,40 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lock_release);
 
+/*
+ * lock_sync() - A special annotation for synchronize_{s,}rcu()-like API.
+ *
+ * No actual critical section is created by the APIs annotated with this: these
+ * APIs are used to wait for one or multiple critical sections (on other CPUs
+ * or threads), and it means that calling these APIs inside these critical
+ * sections is potential deadlock.
+ *
+ * This annotation acts as an acquire+release annotation pair with hardirqoff
+ * being 1. Since there's no critical section, no interrupt can create extra
+ * dependencies "inside" the annotation, hardirqoff == 1 allows us to avoid
+ * false positives.
+ */
+void lock_sync(struct lockdep_map *lock, unsigned subclass, int read,
+	       int check, struct lockdep_map *nest_lock, unsigned long ip)
+{
+	unsigned long flags;
+
+	if (unlikely(!lockdep_enabled()))
+		return;
+
+	raw_local_irq_save(flags);
+	check_flags(flags);
+
+	lockdep_recursion_inc();
+	__lock_acquire(lock, subclass, 0, read, check, 1, nest_lock, ip, 0, 0);
+
+	if (__lock_release(lock, ip))
+		check_chain_key(current);
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lock_sync);
+
 noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 {
 	unsigned long flags;
-- 
2.38.1

