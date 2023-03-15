Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9362E6BC1D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjCOXzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCOXzU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944465BCAB;
        Wed, 15 Mar 2023 16:55:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x1so61479qtr.7;
        Wed, 15 Mar 2023 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JCvB485GQ0XREMndIlrLRmgekVvCXd6HiowEyGZFy4o=;
        b=Ou0NnoPpifgW2UaPywVGXVz3jKjPBJWxsqhVOo/WYojsl5oVx1KF3tqixZx6Zv/D+g
         LBFXYGror1hh5gH9be2pD/N0TLIejIoJ61eLkf13MREI2TBpKPYjmsdT4k0SBs7y6nGA
         2Qp2PSYdIvrvCVVdCYnk5V9PKwFWFVSMTPeEmehdxLz5bEtrqZPUdQowdebyp/gy/76A
         XXaJXe7lxs8mpNG2RkQ1LyEDtrqmrkazA85ClhzrjJ+LyrjuunO0mvFAyjsfEG+l/ajn
         0Z5lWda/lR+zRZ1AwzZVLvpVr67lPww0/e24JgCQvCokEKrvL0izeI4SC1In6c4LYFRL
         NQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCvB485GQ0XREMndIlrLRmgekVvCXd6HiowEyGZFy4o=;
        b=SgpN6Sp/yDfWPqRpFNnT+3vNocokDrREdRGuSbhHXUTrfvZQUeGWOBmyq2EYnv/k6t
         zZJzBPj2i+E3Qh/xITWhZrwDeo6b/95ZKfzLTKaq4//DuoKnDHo5Q3PJ/EO5kR/EbEPa
         44OeHwv1yK3Co6qDu3LJpsfkgxxR39XZGswicE7Waha6dn9V3q87WRdwKYJHNRl7Ypk3
         XQmeTiSB074qAQZG+pQT0QTFR931ZMFOCBIdPLJTlhkI5EUK3lBlDz6PkujtlKO1L55r
         fcGx+OzB3Z9ezSUX/fxxuViAs3AyCeOjmEfz23kfi0Y1uhFkfWu7zB+sm7uoKR32i8Es
         mmPg==
X-Gm-Message-State: AO0yUKVDyUToBDgFy2eUz0kFEjdQ0G6CI6IGm76EqMHwv5mDVnfNTroa
        u9TCNVn4QhZEt88JwW6h2/U=
X-Google-Smtp-Source: AK7set9NKKzAVilHub3b76RDBTBtCkNheYs6ZY9GNVYFJN92hlvByHj+NdGGJHF2Fwydh5upgmEyqw==
X-Received: by 2002:a05:622a:60b:b0:3bf:d258:4a85 with SMTP id z11-20020a05622a060b00b003bfd2584a85mr2754375qta.66.1678924510572;
        Wed, 15 Mar 2023 16:55:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p19-20020ac84093000000b003bfaae103f6sm4778033qtl.89.2023.03.15.16.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B783627C0054;
        Wed, 15 Mar 2023 19:55:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 Mar 2023 19:55:09 -0400
X-ME-Sender: <xms:3VoSZLk3UcG710dymAZt5PQ10NLpeXkiyq3U1TyS98NJUN43UHT-VQ>
    <xme:3VoSZO0LJ1ywZv4GYr2GusB3oRNZmYq7RZFCsSkEwBa-OrsbEk9AUxzO6rxj5wUKf
    dHUeVsP9bSTMuxZKg>
X-ME-Received: <xmr:3VoSZBpaM81MbMi5PlyPRbl0zWVI0IiwfHtdQuk18KPeJzXP1nHUtFbpekw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3VoSZDklrGIf_nodWXS8-9MRLC6w890EOfWOV4q4zoTPs1799nhgPQ>
    <xmx:3VoSZJ3TjKdRwXtn21rzk-NftxSK6TSV4ks5dIg2BCF5CrO4bkXO7g>
    <xmx:3VoSZCvEt5hHtIYd7-BDi3xWeO5mb_6bBec4UZSyu7RZgDje81TxWw>
    <xmx:3VoSZI1j7x3NbA0-oV_CcYU8HVTRX6bv1tUEYtzSigjM4ya7dbnblQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:09 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 1/8] rcutorture: Add test_nmis module parameter
Date:   Wed, 15 Mar 2023 16:54:47 -0700
Message-Id: <20230315235454.2993-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315235454.2993-1-boqun.feng@gmail.com>
References: <20230315235454.2993-1-boqun.feng@gmail.com>
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

This commit adds a test_nmis module parameter to generate the
specified number of NMI stack backtraces 15 seconds apart.  This module
parameter can be used to test NMI delivery and accompanying diagnostics.
Note that this parameter is ignored when rcutorture is a module rather
than built into the kernel.  This could be changed with the addition of
an EXPORT_SYMBOL_GPL().

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e6c023212cb..480bba142e3a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -119,6 +119,7 @@ torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
+torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 
@@ -2358,7 +2359,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
-		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
+		 "nocbs_nthreads=%d nocbs_toggle=%d "
+		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2369,7 +2371,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
-		 nocbs_nthreads, nocbs_toggle);
+		 nocbs_nthreads, nocbs_toggle,
+		 test_nmis);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3273,6 +3276,29 @@ static void rcu_torture_read_exit_cleanup(void)
 	torture_stop_kthread(rcutorture_read_exit, read_exit_task);
 }
 
+static void rcutorture_test_nmis(int n)
+{
+#if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+	int cpu;
+	int dumpcpu;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		preempt_disable();
+		cpu = smp_processor_id();
+		dumpcpu = cpu + 1;
+		if (dumpcpu >= nr_cpu_ids)
+			dumpcpu = 0;
+		pr_alert("%s: CPU %d invoking dump_cpu_task(%d)\n", __func__, cpu, dumpcpu);
+		dump_cpu_task(dumpcpu);
+		preempt_enable();
+		schedule_timeout_uninterruptible(15 * HZ);
+	}
+#else // #if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+	WARN_ONCE(n, "Non-zero rcutorture.test_nmis=%d permitted only when rcutorture is built in.\n", test_nmis);
+#endif // #else // #if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -3297,6 +3323,8 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
+	rcutorture_test_nmis(test_nmis);
+
 	if (cur_ops->gp_kthread_dbg)
 		cur_ops->gp_kthread_dbg();
 	rcu_torture_read_exit_cleanup();
-- 
2.39.2

