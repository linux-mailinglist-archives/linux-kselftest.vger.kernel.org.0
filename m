Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25DC6BDF6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCQDP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCQDOJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA851CAEF;
        Thu, 16 Mar 2023 20:13:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i24so4358126qtm.6;
        Thu, 16 Mar 2023 20:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0IIu5Yi5LuAls+pJ/ShpvT4cQhYjefLMDzlyAtUzY2M=;
        b=m+zgzFjXwbdVq8oriwEEmqgtBN1LLiRL+9JjmhytNN0SF3YFVo2Vi8LlvYHglF50VM
         e2yN/UshjMiKk0Or3cWkHnHYvpWJuHSzPSozs71pP+QjiRkIAX5kxnKEpVhx1aUTcAQg
         OzOox798eW7VxQdIP313YmzIhXSWFfMrf639rrvvj2AINdeENb899UYdJAoZYtGWV0dg
         3hKoIouUO6YjafexNiisB6pdUbhjas6qu7NOk59J9+AzhbuNbR03+U+Ylp368aMWBDk5
         DtALnRnFDEdijM30ef1G3R5QF1O11V4QXQlwLn9JOb9TgJ5Liq20bqD9Gl9uea/j1A9P
         AKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IIu5Yi5LuAls+pJ/ShpvT4cQhYjefLMDzlyAtUzY2M=;
        b=zdfB+IgA7eXAGsTJSTAcqIEnIBcm3jBGKMt8LaJVelyx7T5R4XxSRJjim6qQ0TxANP
         70JtDMIPXqV09YGuEJCKLxuvU6CkUqZBp2z3kggA74YoItkLT63sv8TtW2yJtKMfdBjd
         5ng0P372z6oD1JX9j5slf2yDBgNiZjd6Hde7Sfef64CMonnztXcb21Cu73A/E0TkCQEB
         ACqLvVc3AzG2zMFHSnCVACxdrGIwQHyGLy78TXesfbLT5w+tdUkYDExCB+VitSqwk89/
         dcxAgifgkHWToee3qXMbP1ZDdXqNIchI01+5kiEbsQIaPCLjS6o2GgTy3vzSTO5jjgRd
         Lekg==
X-Gm-Message-State: AO0yUKVV6CHARZQSLxxUDowN64NLd5bytAuMzcF7vIDlyyaTqnCJqoMJ
        cbGueXFxbgEoK47LwxhoZ+U=
X-Google-Smtp-Source: AK7set/bz+3OIzw1dnNbFrUKZvoDlrzcBSmpVgyEfWc4/E6RcfAUuT7Uvnwt9sz6dLhl52Q8mqt/HQ==
X-Received: by 2002:ac8:594f:0:b0:3b9:bc8c:c1fa with SMTP id 15-20020ac8594f000000b003b9bc8cc1famr3055942qtz.5.1679022835153;
        Thu, 16 Mar 2023 20:13:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b0074357fa9e15sm829282qkh.42.2023.03.16.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 345CE27C0054;
        Thu, 16 Mar 2023 23:13:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 Mar 2023 23:13:54 -0400
X-ME-Sender: <xms:8toTZB7jZCXZwj36DNFrvw6gePT6M4GoLUIejUCzWn6CrXdiEF7Uaw>
    <xme:8toTZO7DnztCuv-a5FiT7cUhOQJTQJk7gmC6KyfX6M1vhqD5DeL6QOOXCougUwbO-
    mIY4qXtM3hlODb_jQ>
X-ME-Received: <xmr:8toTZIeY1uemKKbna27jzNQpFDK0cCpgk8mTC8G3rZy_IG_BgciwceOGEoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:8toTZKKnv3aIxfp68Xdg-5h-wDt12DNYe4nPPd-5l_1ZVNWMwSyRLA>
    <xmx:8toTZFKw0QGRaghQbYSZisz9OlaB7iYIfBUaowTs6sHlTktTE-d0YA>
    <xmx:8toTZDxbMFMyHtnriPcdRy7VWXVHNRctcxkfu4vn8RRqVVE094Bx2g>
    <xmx:8toTZNL76-OaaLhoDSgloZeKJ0vBbByYYODswkcPGqjdNWKnoXI0Sg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:53 -0400 (EDT)
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
Subject: [PATCH rcu 5/7] rcutorture: Add SRCU deadlock scenarios
Date:   Thu, 16 Mar 2023 20:13:37 -0700
Message-Id: <20230317031339.10277-6-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

In order to test the new SRCU-lockdep functionality, this commit adds
an rcutorture.test_srcu_lockdep module parameter that, when non-zero,
selects an SRCU deadlock scenario to execute.  This parameter is a
five-digit number formatted as DNNL, where "D" is 1 to force a deadlock
and 0 to avoid doing so; "NN" is the test number, 0 for SRCU-based, 1
for SRCU/mutex-based, and 2 for SRCU/rwsem-based; and "L" is the number
of steps in the deadlock cycle.

Note that rcutorture.test_srcu_lockdep=1 will also force a hard hang.

If a non-zero value of rcutorture.test_srcu_lockdep does not select a
deadlock scenario, a console message is printed and testing continues.

[ paulmck: Apply kernel test robot feedback, add rwsem support. ]
[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 151 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..80ff9a743d31 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -120,6 +120,7 @@ torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
+torture_param(int, test_srcu_lockdep, 0, "Test specified SRCU deadlock scenario.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 
 static char *torture_type = "rcu";
@@ -3463,6 +3464,154 @@ static void rcutorture_sync(void)
 		cur_ops->sync();
 }
 
+static DEFINE_MUTEX(mut0);
+static DEFINE_MUTEX(mut1);
+static DEFINE_MUTEX(mut2);
+static DEFINE_MUTEX(mut3);
+static DEFINE_MUTEX(mut4);
+static DEFINE_MUTEX(mut5);
+static DEFINE_MUTEX(mut6);
+static DEFINE_MUTEX(mut7);
+static DEFINE_MUTEX(mut8);
+static DEFINE_MUTEX(mut9);
+
+static DECLARE_RWSEM(rwsem0);
+static DECLARE_RWSEM(rwsem1);
+static DECLARE_RWSEM(rwsem2);
+static DECLARE_RWSEM(rwsem3);
+static DECLARE_RWSEM(rwsem4);
+static DECLARE_RWSEM(rwsem5);
+static DECLARE_RWSEM(rwsem6);
+static DECLARE_RWSEM(rwsem7);
+static DECLARE_RWSEM(rwsem8);
+static DECLARE_RWSEM(rwsem9);
+
+DEFINE_STATIC_SRCU(srcu0);
+DEFINE_STATIC_SRCU(srcu1);
+DEFINE_STATIC_SRCU(srcu2);
+DEFINE_STATIC_SRCU(srcu3);
+DEFINE_STATIC_SRCU(srcu4);
+DEFINE_STATIC_SRCU(srcu5);
+DEFINE_STATIC_SRCU(srcu6);
+DEFINE_STATIC_SRCU(srcu7);
+DEFINE_STATIC_SRCU(srcu8);
+DEFINE_STATIC_SRCU(srcu9);
+
+static int srcu_lockdep_next(const char *f, const char *fl, const char *fs, const char *fu, int i,
+			     int cyclelen, int deadlock)
+{
+	int j = i + 1;
+
+	if (j >= cyclelen)
+		j = deadlock ? 0 : -1;
+	if (j >= 0)
+		pr_info("%s: %s(%d), %s(%d), %s(%d)\n", f, fl, i, fs, j, fu, i);
+	else
+		pr_info("%s: %s(%d), %s(%d)\n", f, fl, i, fu, i);
+	return j;
+}
+
+// Test lockdep on SRCU-based deadlock scenarios.
+static void rcu_torture_init_srcu_lockdep(void)
+{
+	int cyclelen;
+	int deadlock;
+	bool err = false;
+	int i;
+	int j;
+	int idx;
+	struct mutex *muts[] = { &mut0, &mut1, &mut2, &mut3, &mut4,
+				 &mut5, &mut6, &mut7, &mut8, &mut9 };
+	struct rw_semaphore *rwsems[] = { &rwsem0, &rwsem1, &rwsem2, &rwsem3, &rwsem4,
+					  &rwsem5, &rwsem6, &rwsem7, &rwsem8, &rwsem9 };
+	struct srcu_struct *srcus[] = { &srcu0, &srcu1, &srcu2, &srcu3, &srcu4,
+					&srcu5, &srcu6, &srcu7, &srcu8, &srcu9 };
+	int testtype;
+
+	if (!test_srcu_lockdep)
+		return;
+
+	deadlock = test_srcu_lockdep / 1000;
+	testtype = (test_srcu_lockdep / 10) % 100;
+	cyclelen = test_srcu_lockdep % 10;
+	WARN_ON_ONCE(ARRAY_SIZE(muts) != ARRAY_SIZE(srcus));
+	if (WARN_ONCE(deadlock != !!deadlock,
+		      "%s: test_srcu_lockdep=%d and deadlock digit %d must be zero or one.\n",
+		      __func__, test_srcu_lockdep, deadlock))
+		err = true;
+	if (WARN_ONCE(cyclelen <= 0,
+		      "%s: test_srcu_lockdep=%d and cycle-length digit %d must be greater than zero.\n",
+		      __func__, test_srcu_lockdep, cyclelen))
+		err = true;
+	if (err)
+		goto err_out;
+
+	if (testtype == 0) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		if (deadlock && cyclelen == 1)
+			pr_info("%s: Expect hang.\n", __func__);
+		for (i = 0; i < cyclelen; i++) {
+			j = srcu_lockdep_next(__func__, "srcu_read_lock", "synchronize_srcu",
+					      "srcu_read_unlock", i, cyclelen, deadlock);
+			idx = srcu_read_lock(srcus[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			srcu_read_unlock(srcus[i], idx);
+		}
+		return;
+	}
+
+	if (testtype == 1) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU/mutex %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		for (i = 0; i < cyclelen; i++) {
+			pr_info("%s: srcu_read_lock(%d), mutex_lock(%d), mutex_unlock(%d), srcu_read_unlock(%d)\n",
+				__func__, i, i, i, i);
+			idx = srcu_read_lock(srcus[i]);
+			mutex_lock(muts[i]);
+			mutex_unlock(muts[i]);
+			srcu_read_unlock(srcus[i], idx);
+
+			j = srcu_lockdep_next(__func__, "mutex_lock", "synchronize_srcu",
+					      "mutex_unlock", i, cyclelen, deadlock);
+			mutex_lock(muts[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			mutex_unlock(muts[i]);
+		}
+		return;
+	}
+
+	if (testtype == 2) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU/rwsem %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		for (i = 0; i < cyclelen; i++) {
+			pr_info("%s: srcu_read_lock(%d), down_read(%d), up_read(%d), srcu_read_unlock(%d)\n",
+				__func__, i, i, i, i);
+			idx = srcu_read_lock(srcus[i]);
+			down_read(rwsems[i]);
+			up_read(rwsems[i]);
+			srcu_read_unlock(srcus[i], idx);
+
+			j = srcu_lockdep_next(__func__, "down_write", "synchronize_srcu",
+					      "up_write", i, cyclelen, deadlock);
+			down_write(rwsems[i]);
+			if (j >= 0)
+				synchronize_srcu(srcus[j]);
+			up_write(rwsems[i]);
+		}
+		return;
+	}
+
+err_out:
+	pr_info("%s: test_srcu_lockdep = %05d does nothing.\n", __func__, test_srcu_lockdep);
+	pr_info("%s: test_srcu_lockdep = DNNL.\n", __func__);
+	pr_info("%s: D: Deadlock if nonzero.\n", __func__);
+	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem.\n", __func__);
+	pr_info("%s: L: Cycle length.\n", __func__);
+}
+
 static int __init
 rcu_torture_init(void)
 {
@@ -3504,6 +3653,8 @@ rcu_torture_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
+	rcu_torture_init_srcu_lockdep();
+
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
-- 
2.39.2

