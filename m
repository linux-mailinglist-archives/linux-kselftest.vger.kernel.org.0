Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BC6C5DEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCWE0m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWE0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6857D231E5;
        Wed, 22 Mar 2023 21:26:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hf2so21163050qtb.3;
        Wed, 22 Mar 2023 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x2c1z4Ifc1RIFheDNsSfkL82KlNLAYy41K1vaQbXLIo=;
        b=YSmy8ILmUmuToOS2Ao6Z1M+Ni6+duIhQsN2+cgwH/O8D0Mbb7jNZfmECZG6xVoqoDj
         vFTKk39EZVweKR71xMgeVsNvEb76Wlaa49+Qeeti4d4NwryHmK1Y62fEkKr4YAwTTlH/
         Zg/qc8y+oZBLsRcsIn/8odlma3k4UJQrYZAgHg5l1xRadZaAyVNWmbd84AptRT0aydRL
         o49+yqOmzGAY/gLzAgBl7gDqbBJu9S69sjIl/F1nht81bI869Qxbx3zlM5nQ8JP1AOpU
         GVcER7pamf7Ijdy06FQvlpxDiONA41OLeI8ZO6iQJq5vHnfkvdnBRCCU8BtVKKxYwet+
         sA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2c1z4Ifc1RIFheDNsSfkL82KlNLAYy41K1vaQbXLIo=;
        b=g0AupBh2NGU3I1COhFUMT3j2RYsMPLPIqVEbvbjosTgJSImQrO1D9GQDCd3T/czN0L
         /YAcwgNNpoDB2lmLAerzWIC68wPqHTawcMATDjkS87bG88r76y0WA3zt+NOLVQv7/osy
         jZeySI4GToSnZJCrEbboEPIuYYrPr4loA0BHUj6zRRKCCdbFLyyjMao6ub/Umm1vGfQP
         YtDRgUdQ8K5YmSeyRmJ7dpqV4qcpVAxfIl9fpJidexc3eAXGVDFq715txvuEXCxAw7rv
         6bACm21RsMEVcpjQQPfQE7vCoZ7S45owMy+R2wueoT3SgNauI6SaXet3aawWBG1DeZOB
         KdHA==
X-Gm-Message-State: AO0yUKVyQ4hefrKl07rhKl5GHEByX+E8oCzaee7686x1QIjnxjq0t2Dm
        SGIe32CAzhJdAEhNsfPJyms=
X-Google-Smtp-Source: AK7set9c3Xckjl0xGJEK1fR8OsYo0WfpAbjykH6JQNrppPUMBfd1o+WXgYj1MUM2Ug7Zt/gWgjpikA==
X-Received: by 2002:a05:622a:204:b0:3b9:173e:45de with SMTP id b4-20020a05622a020400b003b9173e45demr7722516qtx.6.1679545589511;
        Wed, 22 Mar 2023 21:26:29 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p14-20020ac8740e000000b003b63a734434sm11187831qtq.52.2023.03.22.21.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 86CA627C0054;
        Thu, 23 Mar 2023 00:26:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 00:26:28 -0400
X-ME-Sender: <xms:9NQbZOC3g1jAm46NLKHcVX-KfiF59ACiMozJWf1R5g1bkJNrTPNdvA>
    <xme:9NQbZIimvhENQOblXomjC7UTVDv44CI4teVQx6JABZG2aeeWpVJSMCUmQQ152bKn3
    KNOlGKgxjO4ZLLwbQ>
X-ME-Received: <xmr:9NQbZBlwi0QyzXl7TJYT_1nEO-vrbwzftrgyV_81x8g8lEM5RFsugPqj6ZZXZwLufhFAjnXsICUHvYZReG9y7MmVLp8hSwstdE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9NQbZMycBMBnTyKm3Fed_mYYmIHtL44QJqabaNvns80TyLxZ1tYZIA>
    <xmx:9NQbZDTPKZflaOFuq-cEZnAfPGo3mAIu2JFhE3DgKzVdUaZlPWndKQ>
    <xmx:9NQbZHaNzIlvMPxVoYW8Ax7HOQAlqhJwAHSYVjXLGbPq8O0hBK4IRg>
    <xmx:9NQbZER_BhTlsddiWlw1cKEqmfRt-lJwtrsQJ9JBNG5ENa3Nv31cyA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:27 -0400 (EDT)
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
Subject: [PATCH rcu v2 2/7] rcu: Annotate SRCU's update-side lockdep dependencies
Date:   Wed, 22 Mar 2023 21:26:09 -0700
Message-Id: <20230323042614.1191120-3-boqun.feng@gmail.com>
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

Although all flavors of RCU readers are annotated correctly with
lockdep as recursive read locks, they do not set the lock_acquire
'check' parameter.  This means that RCU read locks are not added to
the lockdep dependency graph, which in turn means that lockdep cannot
detect RCU-based deadlocks.  This is not a problem for RCU flavors having
atomic read-side critical sections because context-based annotations can
catch these deadlocks, see for example the RCU_LOCKDEP_WARN() statement
in synchronize_rcu().  But context-based annotations are not helpful
for sleepable RCU, especially given that it is perfectly legal to do
synchronize_srcu(&srcu1) within an srcu_read_lock(&srcu2).

However, we can detect SRCU-based by: (1) Making srcu_read_lock() a
'check'ed recursive read lock and (2) Making synchronize_srcu() a empty
write lock critical section.  Even better, with the newly introduced
lock_sync(), we can avoid false positives about irq-unsafe/safe.
This commit therefore makes it so.

Note that NMI-safe SRCU read side critical sections are currently not
annotated, but might be annotated in the future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ boqun: Add comments for annotation per Waiman's suggestion ]
[ boqun: Fix comment warning reported by Stephen Rothwell ]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h  | 34 ++++++++++++++++++++++++++++++++--
 kernel/rcu/srcutiny.c |  2 ++
 kernel/rcu/srcutree.c |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 74796cd7e7a9..41c4b26fb1c1 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -102,6 +102,32 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 	return lock_is_held(&ssp->dep_map);
 }
 
+/*
+ * Annotations provide deadlock detection for SRCU.
+ *
+ * Similar to other lockdep annotations, except there is an additional
+ * srcu_lock_sync(), which is basically an empty *write*-side critical section,
+ * see lock_sync() for more information.
+ */
+
+/* Annotates a srcu_read_lock() */
+static inline void srcu_lock_acquire(struct lockdep_map *map)
+{
+	lock_map_acquire_read(map);
+}
+
+/* Annotates a srcu_read_lock() */
+static inline void srcu_lock_release(struct lockdep_map *map)
+{
+	lock_map_release(map);
+}
+
+/* Annotates a synchronize_srcu() */
+static inline void srcu_lock_sync(struct lockdep_map *map)
+{
+	lock_map_sync(map);
+}
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
@@ -109,6 +135,10 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 	return 1;
 }
 
+#define srcu_lock_acquire(m) do { } while (0)
+#define srcu_lock_release(m) do { } while (0)
+#define srcu_lock_sync(m) do { } while (0)
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #define SRCU_NMI_UNKNOWN	0x0
@@ -182,7 +212,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 
 	srcu_check_nmi_safety(ssp, false);
 	retval = __srcu_read_lock(ssp);
-	rcu_lock_acquire(&(ssp)->dep_map);
+	srcu_lock_acquire(&(ssp)->dep_map);
 	return retval;
 }
 
@@ -254,7 +284,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_nmi_safety(ssp, false);
-	rcu_lock_release(&(ssp)->dep_map);
+	srcu_lock_release(&(ssp)->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index b12fb0cec44d..336af24e0fe3 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -197,6 +197,8 @@ void synchronize_srcu(struct srcu_struct *ssp)
 {
 	struct rcu_synchronize rs;
 
+	srcu_lock_sync(&ssp->dep_map);
+
 	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			lock_is_held(&rcu_bh_lock_map) ||
 			lock_is_held(&rcu_lock_map) ||
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ab4ee58af84b..c541b82646b6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1307,6 +1307,8 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
+	srcu_lock_sync(&ssp->dep_map);
+
 	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			 lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
-- 
2.38.1

