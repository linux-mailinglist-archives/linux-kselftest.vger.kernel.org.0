Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08736BDF5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCQDPQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCQDOI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C671199E4;
        Thu, 16 Mar 2023 20:13:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t9so4342717qtx.8;
        Thu, 16 Mar 2023 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFu2nJ/kDFjy9nqyBBnnV/lGTlGF4Iik/2gAIOS9wFc=;
        b=PeDKkb0bWFdP+vxrmnBVoOFvvuX8dLqoIgUIzFst41Odhh1tURjZDv+sp/iJ7ImqaO
         E/5o3UksTEKaIqCW0ToJoYr1bq66RLqG7KK52IZJeLvaSgZogeSlsL+1b4OhoLzai2RF
         eULC+VKyoF9hWbMUpU3tApg915c1a49oXc1L5tj5CgMLSRvJTIyryqZSVMOX60PDqPJX
         GMotkoULhkdDn5aCQfRZTdkEVK6RKxJZqBaYZgnAcVmOb/cemrwL56ZLI7rK70g3JXzL
         uL/exVYYcXSzODcRuBgTYpSS/e0p7eYjEu9xnbuNFb3ajdSl0DjoF8BYDE4VbGL6auUT
         lOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFu2nJ/kDFjy9nqyBBnnV/lGTlGF4Iik/2gAIOS9wFc=;
        b=PryxtU4BzFvzP/SEYtmQPBbd9Exjs+1lQtXyf03kOEVK3hFHD3/L6osEo5YdIj6VrW
         zt4m1yd3u2t/yaNORVHcuKaqS6mfQng/1I5MqU1QD7Qw697WDGmAxA1UfOQL97DOcC0p
         lK34Q2dd7abhKz4CNOshiFAz7CMja5kNSMVBQezNSH5XZXh3FpX0QTMQjR6gQYUMqVce
         YEDvOq1531doXpRw7dFrt7pU2ZbgPWbJno53DQo5FQunWIZe3VE79Ny4HBjzO19sYv9b
         QtFx5z6H/VMDzYxIv+WzC2FxP8Yjgn0j6Bpp4Px3piFvUTDdZYFIbXxXQClqGE2R70W3
         21MQ==
X-Gm-Message-State: AO0yUKXB52B6uCykJfxOqTXkkBUaAHxDnVh8ytU8vOPFzx1gpNiSQyOQ
        29QA/ua9+Jb+AMTFRZSWa0w=
X-Google-Smtp-Source: AK7set9jlEF0UNqCheoWT+BgNq3Oc0khKLZvofMB2I+Ik0uFsxoCNSVwVU9YUA3G8KLkw1pLtl+2hA==
X-Received: by 2002:ac8:5f4e:0:b0:3d9:6266:86d9 with SMTP id y14-20020ac85f4e000000b003d9626686d9mr4247033qta.10.1679022831237;
        Thu, 16 Mar 2023 20:13:51 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 71-20020a370b4a000000b0074240840c25sm810235qkl.108.2023.03.16.20.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 36F8D27C0054;
        Thu, 16 Mar 2023 23:13:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 16 Mar 2023 23:13:50 -0400
X-ME-Sender: <xms:7doTZLA_ZwnQzabtand_tczK6TaqVCSE8r4C2aI_Y1j0LnGGTEN8mA>
    <xme:7doTZBhaZGKtTxbqaIFJgq0CfIVWYh67yjuNGaVxtfRuGtvEQEWA1niLTfgCxJ6S7
    7KTnP0V4TmGc7samA>
X-ME-Received: <xmr:7doTZGlELOOxD2r19cVfWRQhLgLqdHxAIiqrmpgA9_L01dR7qL1vPcmUtvo>
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
X-ME-Proxy: <xmx:7doTZNzi_uIpK5feE2PPEIxF7G1Yt_FBWcYwGuUKoj30Fsh4FjTO8A>
    <xmx:7doTZAQEbM2Fgqt7IGMERlGs6ZTha3jHdmPMzBty6osuN0AQcEP-cg>
    <xmx:7doTZAbqLy8E0cNgP732LfKNBxX6E6NANyvCXt1GQTapiIuidLEMug>
    <xmx:7toTZJSWv1SZF8fpp12orbhMDRJnteyhbvSBA7gTUAGHfhUaC5t9Mg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:49 -0400 (EDT)
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
Subject: [PATCH rcu 2/7] rcu: Annotate SRCU's update-side lockdep dependencies
Date:   Thu, 16 Mar 2023 20:13:34 -0700
Message-Id: <20230317031339.10277-3-boqun.feng@gmail.com>
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
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h  | 34 ++++++++++++++++++++++++++++++++--
 kernel/rcu/srcutiny.c |  2 ++
 kernel/rcu/srcutree.c |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 74796cd7e7a9..7a745169b79a 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -102,6 +102,32 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 	return lock_is_held(&ssp->dep_map);
 }
 
+/**
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
2.39.2

