Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD26BDF5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCQDPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQDOJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:09 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717511D90E;
        Thu, 16 Mar 2023 20:13:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i24so4358164qtm.6;
        Thu, 16 Mar 2023 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzpystE5f2xfyMB/9fCi+PwaHIvX5w4MShveVrtuCQs=;
        b=X5Sz+v/fNG0vVi3vO0bLZM2SC6TQ0+U7GJrSnkaAGK9jnfb9Dl0MHPoMwSqLPqYRXz
         WAHeqSLZknFSWCqpcmpBl2s8OGoMv0U9ljNtgBGU9ogtRA+SqC5bxhk5RTu5odlTsyRM
         nU6WrB2tcJ0wN4DffRj0Syw6sFA3OprmCfF0Nu2Tp0ee82/zjLtJ/jnY5PsDGEfZoxQC
         xR84YWLu3fHgHfIlK1z2CW/hXv2ZONAY8V4fpyEcMjVEFFUTDTgKnOpmk2zgXeXH0h1+
         VWbKp/3NpH+tN5/WXp4tvsj6xjl3+xWciOeVjKgEGeAQ8poLKiMsjRIAZOZfwh7Rz2GD
         NCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzpystE5f2xfyMB/9fCi+PwaHIvX5w4MShveVrtuCQs=;
        b=nmCHm++cq76N6/r2XBEOb8hUkQrbgN6lXGat8zjymHL0IAKladH4USAjqMawtaapX2
         N33sigh4V4obrj8kWM4xJE+8uQfepf6z3Y0KG5UV3iDphR+YqQp3n3sdfLvvtgWUN62N
         489BHeNCWq2O8Rra4HvCS3JWjhwRk5PGtZFqdjpAdvvrCznk/Rjx+EqR7DSvmjtNwWaG
         GuMYX6nG4O7dR5yAyrVDQB1XlucLWM0+ESnjuaj7cBeN6LEZAOzOgneWvkhRBQ8AzkK2
         rqmCcp21HtvCdPNd6woWum8tOgkjSWWLleIwqzlwIr2EYY1okFtpCaWfDYgOMWxFMmKt
         Bexw==
X-Gm-Message-State: AO0yUKVfSNXXObGWSvnkWucwhMoX61tTGEmhZ9LlEcq4sP84vz6jkkhR
        Y/3ogKTSCHVbjxFaLOhNumo=
X-Google-Smtp-Source: AK7set96PBqkMRIk8uLFLfzPYpRz+K0P8rERhOXBavgCS+Kp5Ib6EGllJWSg5f6qUYLLG8P2y2Wb1g==
X-Received: by 2002:ac8:5807:0:b0:3bf:cf9d:ccbd with SMTP id g7-20020ac85807000000b003bfcf9dccbdmr9369885qtg.2.1679022836613;
        Thu, 16 Mar 2023 20:13:56 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i7-20020a378607000000b007422eee8058sm807711qkd.125.2023.03.16.20.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7EEF627C0054;
        Thu, 16 Mar 2023 23:13:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 Mar 2023 23:13:55 -0400
X-ME-Sender: <xms:89oTZASWAQ1BxsQZnAWl6qpY039mGGj5cwc1d0jxS0BjpGeS86PZiQ>
    <xme:89oTZNyTGgKLKweAftLzgtL0QLX_3gpwXZwb1_gcdyIGRwjYsrouJ1joTYjKwWG_w
    1eUPchVi2-w4vsKGg>
X-ME-Received: <xmr:89oTZN30WNQdFidv6sygMBvPE2QrZ6TlaxQzMTTor-hPA8JR7U2J5DJh0Cc>
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
X-ME-Proxy: <xmx:89oTZEA8fvxRu0esk9C4Vq_eG539Y61Vq_nNeU3aFi_gjrHKUy79Tw>
    <xmx:89oTZJjrJDMoQAYboIhHwfi4LUqVKkTG4w2qoLa46xUnu4aHqkV9gw>
    <xmx:89oTZAp8aXNamkXURWoRxoRzlDDn6awTYY_1OiEnFafNXTczWarB1Q>
    <xmx:89oTZMiRqUHRWPR87ENEN6L-OwQ3OLgyHrkfSlcr0G6xNKj7O43fzw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:55 -0400 (EDT)
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
Subject: [PATCH rcu 6/7] rcutorture: Add RCU Tasks Trace and SRCU deadlock scenarios
Date:   Thu, 16 Mar 2023 20:13:38 -0700
Message-Id: <20230317031339.10277-7-boqun.feng@gmail.com>
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

Add a test number 3 that creates deadlock cycles involving one RCU
Tasks Trace step and L-1 SRCU steps.  Please note that lockdep will not
detect these deadlocks until synchronize_rcu_tasks_trace() is marked
with lockdep's new "sync" annotation, which will probably not happen
until some time after these markings prove their worth on SRCU.

Please note that these tests are available only in kernels built with
CONFIG_TASKS_TRACE_RCU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 80ff9a743d31..9efb8258a272 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3604,12 +3604,46 @@ static void rcu_torture_init_srcu_lockdep(void)
 		return;
 	}
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (testtype == 3) {
+		pr_info("%s: test_srcu_lockdep = %05d: SRCU and Tasks Trace RCU %d-way %sdeadlock.\n",
+			__func__, test_srcu_lockdep, cyclelen, deadlock ? "" : "non-");
+		if (deadlock && cyclelen == 1)
+			pr_info("%s: Expect hang.\n", __func__);
+		for (i = 0; i < cyclelen; i++) {
+			char *fl = i == 0 ? "rcu_read_lock_trace" : "srcu_read_lock";
+			char *fs = i == cyclelen - 1 ? "synchronize_rcu_tasks_trace"
+						     : "synchronize_srcu";
+			char *fu = i == 0 ? "rcu_read_unlock_trace" : "srcu_read_unlock";
+
+			j = srcu_lockdep_next(__func__, fl, fs, fu, i, cyclelen, deadlock);
+			if (i == 0)
+				rcu_read_lock_trace();
+			else
+				idx = srcu_read_lock(srcus[i]);
+			if (j >= 0) {
+				if (i == cyclelen - 1)
+					synchronize_rcu_tasks_trace();
+				else
+					synchronize_srcu(srcus[j]);
+			}
+			if (i == 0)
+				rcu_read_unlock_trace();
+			else
+				srcu_read_unlock(srcus[i], idx);
+		}
+		return;
+	}
+#endif // #ifdef CONFIG_TASKS_TRACE_RCU
+
 err_out:
 	pr_info("%s: test_srcu_lockdep = %05d does nothing.\n", __func__, test_srcu_lockdep);
 	pr_info("%s: test_srcu_lockdep = DNNL.\n", __func__);
 	pr_info("%s: D: Deadlock if nonzero.\n", __func__);
-	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem.\n", __func__);
+	pr_info("%s: NN: Test number, 0=SRCU, 1=SRCU/mutex, 2=SRCU/rwsem, 3=SRCU/Tasks Trace RCU.\n", __func__);
 	pr_info("%s: L: Cycle length.\n", __func__);
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU))
+		pr_info("%s: NN=3 disallowed because kernel is built with CONFIG_TASKS_TRACE_RCU=n\n", __func__);
 }
 
 static int __init
-- 
2.39.2

