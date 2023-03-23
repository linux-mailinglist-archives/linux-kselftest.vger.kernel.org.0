Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE86C5DFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCWE1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCWE0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C1305F1;
        Wed, 22 Mar 2023 21:26:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c19so25317338qtn.13;
        Wed, 22 Mar 2023 21:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WzsyULtazmFb2jKIFNYV9uE4W8xKZbiZDJOPAFxYjgM=;
        b=WhIMxPfgXxfuHsLzM9FcCFgkhjyF8sP8aj+v7gJdxFhN/RSlmsh2wy9HaP3axczsF3
         cy67zWTqaNnmuRAkISOnDAR6iIAVbW5zItHZsSefMuyJSxdmmV+N8rHmHok9cFSzDHO3
         zN/Q1rmkeNjSSfvA6Svu+FKQXfK4qghGJt7Ps0Nq2pCxGM5lKwb9/jjXnr4rAUXS3jZw
         LdThvFiDzjOSd/K8GSUos+Wjb59cCEJpE9v1b8/nujlC9/BgHpqZED+kCU4oi5GYTWJ5
         FqNHG6x2W/h3ZvwVW/eLl6S6T18gLnWSxxqhFFFk4Jq73gZRz7BLQVDA0En6K/dzH0MJ
         BHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzsyULtazmFb2jKIFNYV9uE4W8xKZbiZDJOPAFxYjgM=;
        b=ji75W33l+SbBkT5esvUx9EscRqK8u+qVu1fbtkr/prYnONbrdCRqlzzqprsSD20Dmm
         GBFg0QcnpZOfQZIrEiz7PWHCNDGaOAJCwv3uNvULzj3b/kRiEhiMPU1d+WIPXGvxJ+5u
         7RBt3vjtmIttLmMA65+/B20CG/JuCA4/IEhstuYU+NHUKpmOtduEdHKDvFgv6nlX7+ar
         1Drm9VSStvwhfqt3JsnXL8BgKOh+75WoUZimb7CfE7B10yt44IC99Ah5DBNbtGPsZc5r
         Gb23rbd/5BwiYKlfWdPtlwQoHDm76wHxSJL4TJGZ6FUFmpfJzgCIrYxUd1ZjtIfCgblT
         wacQ==
X-Gm-Message-State: AO0yUKURhErPZ1L/b3MmRZpSFvQY7UXiLCARvnoyr1VfpTpKATu1EyLh
        ROvum5e6ymkur9vHWJiY0h0=
X-Google-Smtp-Source: AK7set/raKqzjGHjunNvK5pLnQ0xax0GEFydogpsAe+KgbZy963pN3sZydhhbLrxGpoKbLtjwPpOzw==
X-Received: by 2002:ac8:5782:0:b0:3bf:d9f3:debe with SMTP id v2-20020ac85782000000b003bfd9f3debemr8686777qta.59.1679545599328;
        Wed, 22 Mar 2023 21:26:39 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b003e2e919bcf7sm5700880qto.78.2023.03.22.21.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5974A27C0054;
        Thu, 23 Mar 2023 00:26:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 00:26:38 -0400
X-ME-Sender: <xms:_tQbZIW5MOpLO3H-JLi7jRFOKw9lpSTR0ibxXgEWn5NifKRxqe-3AA>
    <xme:_tQbZMmX_iHTR4-N1_zmKOqggvboQzPpy0bno1rx_xHl0msaXaLDUg3bscsi2ND_k
    Tmwsz6LCEafhZzzzQ>
X-ME-Received: <xmr:_tQbZMaOcWg-ydpk_osHxgpzf4RHpJ0mecbe1917eM8JF_apUhilLowZqOXsYjUkMdts7zg2S3rxc0gFX09_J0ZHxaPlGox5LTE>
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
X-ME-Proxy: <xmx:_tQbZHUaCxb6610_a6sEKTOocRHTe1fbreBzSWiiss8Tw8R9u5XkmQ>
    <xmx:_tQbZCkmn3I4W2DUk7cEe5sq4TAfY0vZmyCxqMPCdH_BaHNXzdjNxg>
    <xmx:_tQbZMexvgbdwFJaA0Bchthx7CV9wZ9HRqo_-9Sx4szJ4YOPVtfv0w>
    <xmx:_tQbZKHv9MdqfLjjGYKGbapAg4RDRy4Tdj0rRi9K2FRjv2SLqSn42g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:37 -0400 (EDT)
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
Subject: [PATCH rcu v2 6/7] rcutorture: Add RCU Tasks Trace and SRCU deadlock scenarios
Date:   Wed, 22 Mar 2023 21:26:13 -0700
Message-Id: <20230323042614.1191120-7-boqun.feng@gmail.com>
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
2.38.1

