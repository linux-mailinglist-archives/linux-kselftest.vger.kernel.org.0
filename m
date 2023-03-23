Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427036C5E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCWEkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCWEkJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:40:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2BA301A3;
        Wed, 22 Mar 2023 21:40:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g9so13496797qvt.8;
        Wed, 22 Mar 2023 21:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aUFQW2WXfALj5ukiFKzp1+R094NGU0po6rD/6mapsrg=;
        b=jDJiw3NRGRoZ8yCkpG6dGJRFBmfjolxzWq88TSJIS9oKnz6k4wUYy2ldo3c5qmrl+G
         xbJsqsQ3c1V0bwg0dH2EZqMIraabjTqx1/diTTiILetOfxjE6GnqogGCRIm4hyyQXS59
         ORXtlrZBU6CBDF0FJFUIAgbvFSz7zUn2lO7tROAfr73xYnA8jrX3yPZa4OeI1D4YsadC
         R5wWRvUDPkWqWg0XeZDldkUfPn5p1Vu0qj8IOFsclC7ENCIMvhDX3jAERU7rDZxafx2E
         aPVLK7501fRBqSkh8/GM1REEC6ZVye57Jkfb0DBKE1MqHgyEtDh0llVU9kwj2QEpUfnP
         icfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUFQW2WXfALj5ukiFKzp1+R094NGU0po6rD/6mapsrg=;
        b=uTyDIpeJNvE2Fk5uX7+kZJ2nzb2CtuXoQyXJ54HkvyysqlHbJvLeI+moZFH48ZVFGn
         Mdwp3bRkQR/gVDivLfFlLeOuSxP6T/m1ZRpMEqRwkeNIo8mOZp8CGfB3UQawVo6vZ0hw
         o/gRfdpECh6+yjKDT3TQzrsv+6i2jweCfscNLIrp61L29re2Ko9F/ZG70R/4j191u+Lr
         H7wJQ3yDs0xJmwTYCmC2sDI2ROcgY7ZkuR2i8USnPE6Ol9WsOJuQcuEjVLJYeXckdreM
         mcmibu4wFQ0a3JtrCvS1qjtUbHvxNnQ/kWHsViprkaTyYxa4TW8h0OEc8B8FusT+I5qA
         K8cA==
X-Gm-Message-State: AO0yUKXBeTISBd5+tXokACVcLXBJVAxKJYpOLcaraqWmU3OK8eURFnZx
        tUqeulPMz+ozcTFYHDDyxRw=
X-Google-Smtp-Source: AK7set9PyFnnQnHZWuo4g26FzqCYMNznAv9GgNPBG2DH6WZhC7DKCTdyCH955LDl5Y/+n0sMg3hUoQ==
X-Received: by 2002:a05:6214:29c7:b0:5a3:2e65:69ef with SMTP id gh7-20020a05621429c700b005a32e6569efmr10424559qvb.49.1679546400031;
        Wed, 22 Mar 2023 21:40:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j185-20020a37b9c2000000b007465ad44891sm11548353qkf.102.2023.03.22.21.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D2BF27C0054;
        Thu, 23 Mar 2023 00:39:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Mar 2023 00:39:59 -0400
X-ME-Sender: <xms:HtgbZH_AAkzhVunYgcz-eILjGSImlnw2kDj-JmjdidnCimaOQHX8FQ>
    <xme:HtgbZDssKLXAKZh3WDi-79c5ZN2TJRF-kCl1KDicQqdjhGdQtsaCNATxgK5rFyNYc
    p6xqSrkd-4z8QioCw>
X-ME-Received: <xmr:HtgbZFAvnCFjxCl4QJrb8kUSqtWdGUDXvG_A-pEhtn9CQSZ7prXxf3M8ZjH2uu5cuLlwVJaZH3ufmim-ggJ9ymb3TiFRensVRtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HtgbZDdxpeTsAl7Yb-9_v_28O1urNE4sfiGmEno2U5aQKEh16wz1oA>
    <xmx:HtgbZMNiIEsljbAUxWeQ5tg9iWr8bHkyzht9OKSUOJZA5SIvJ4fQOg>
    <xmx:HtgbZFnbL7yNd-vL_Uaid31Nwq-Im7RCXgq8yyC-HTnH1HSW4uWbpA>
    <xmx:H9gbZDkbNUleUy0r-uZz5LM2KTi1SB7SUINitm-NdadrKf3pND4AaA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:57 -0400 (EDT)
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yue Hu <huyue2@coolpad.com>
Subject: [PATCH rcu v2 06/10] rcutorture: Eliminate variable n_rcu_torture_boost_rterror
Date:   Wed, 22 Mar 2023 21:39:31 -0700
Message-Id: <20230323043935.1221184-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230323043935.1221184-1-boqun.feng@gmail.com>
References: <20230323043935.1221184-1-boqun.feng@gmail.com>
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

From: Yue Hu <huyue2@coolpad.com>

After commit 8b700983de82 ("sched: Remove sched_set_*() return value"),
this variable is not used anymore. So eliminate it entirely.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 480bba142e3a..c0b2fd687bbb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -180,7 +180,6 @@ static atomic_t n_rcu_torture_mbchk_tries;
 static atomic_t n_rcu_torture_error;
 static long n_rcu_torture_barrier_error;
 static long n_rcu_torture_boost_ktrerror;
-static long n_rcu_torture_boost_rterror;
 static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
@@ -2195,12 +2194,11 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_alloc),
 		atomic_read(&n_rcu_torture_alloc_fail),
 		atomic_read(&n_rcu_torture_free));
-	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld rtbre: %ld ",
+	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld ",
 		atomic_read(&n_rcu_torture_mberror),
 		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
 		n_rcu_torture_barrier_error,
-		n_rcu_torture_boost_ktrerror,
-		n_rcu_torture_boost_rterror);
+		n_rcu_torture_boost_ktrerror);
 	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
@@ -2218,15 +2216,13 @@ rcu_torture_stats_print(void)
 	if (atomic_read(&n_rcu_torture_mberror) ||
 	    atomic_read(&n_rcu_torture_mbchk_fail) ||
 	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
-	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
-	    i > 1) {
+	    n_rcu_torture_boost_failure || i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mbchk_fail));
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
-		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
 		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
 		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
@@ -3568,7 +3564,6 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_error, 0);
 	n_rcu_torture_barrier_error = 0;
 	n_rcu_torture_boost_ktrerror = 0;
-	n_rcu_torture_boost_rterror = 0;
 	n_rcu_torture_boost_failure = 0;
 	n_rcu_torture_boosts = 0;
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
-- 
2.38.1

