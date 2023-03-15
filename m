Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02C6BC1DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjCOXze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjCOXza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F35D77A;
        Wed, 15 Mar 2023 16:55:18 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c19so38668qtn.13;
        Wed, 15 Mar 2023 16:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5gFGRe+GR4tL6TIQSCOd5oG4daoxg1w8734Bp22SUG4=;
        b=fwDoMYTUnrr/6bpQUlS3ZXIm6xKdYnCT0KTjDsHJjimRd5fPusYUlOx1MQpIFGsvhl
         QsqHsmzjMoqSdacSUcZKFLQOVlUMyPuu+937Zt7h+a6rBUiQ9kWzuQBG5odvQmbc6Mf0
         iIqDqwqUbOh/vIx/d94K3YsK+rOOBKalEJRDsl/LOFzVOqaSCud3CC7/ots3etcKSnLz
         I+Vt40XTE3TwfIVd3Va1Aol5H+FetbZ5OQsJliUit0mlDEatw7khbHb9BHT2pVJQuZJe
         8tbk3d/R1zckMvD6Z6/GmcgSIj0R51QkkSkiZQ4iOvUq1fyEY27CVLcmq19dC3Y8h3mB
         7xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gFGRe+GR4tL6TIQSCOd5oG4daoxg1w8734Bp22SUG4=;
        b=PBR14u87734qSuuwda8WBxQyvYUy0q8HZraDu+AnSNLMpae16Gd5FwfacCaw1ysh1C
         NHaDw+wBAY1y/ZpxPqNIx7Yu+VZXKEIP5VRKmhCI9g8ccKmgH/2W7LvD1oIJk+O+4qJj
         8Hm3Y1L9BERKCRBP5s17Nn20xuQvr60lqHsURCW/A2UxR6VyvuMketnBFUOwz0IVmxBV
         99M5/MerghWm2A4Nxv6gd7+9Ea/jV1G6HgHgV6xETonQQcjgKRJkjTg4x1JUM3xrGztS
         7wuBosQZfq6kUEt4SrZd1Fh/lYrN6x5B89rWSWvVUyyfUXj0CR8q6MMdO5Pejyf53er5
         hc0A==
X-Gm-Message-State: AO0yUKWFuCZZPQZtMlrz4QK1/Gxor4/6YTeCSHR9XXyKLlexTxl4bqG2
        CG4C+Dg0BBYZIywO65E2XXU=
X-Google-Smtp-Source: AK7set+j1Nw0S9NpSL9eBIsKPAzHLa5p4exbKDP4SgzH+ASExp11FqDCVYg4XKo91GyOWzHsjLq1bw==
X-Received: by 2002:a05:622a:1393:b0:3bf:dbb4:3bcc with SMTP id o19-20020a05622a139300b003bfdbb43bccmr3217063qtk.4.1678924517711;
        Wed, 15 Mar 2023 16:55:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o7-20020a374107000000b00745c4d90aacsm4316401qka.115.2023.03.15.16.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id DC51927C0054;
        Wed, 15 Mar 2023 19:55:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Mar 2023 19:55:16 -0400
X-ME-Sender: <xms:5FoSZIeYZiG5S0RrT3qWGlygsIXWVkfyMLIhfROZEsF-u0MEQJcbtA>
    <xme:5FoSZKNXIlxbnK3b_38KnuGqtEPd2gOOupC6VY53GFLxL_SitZoUz-yET8VYrKJGc
    _ssFT8oO0h6l0ieBw>
X-ME-Received: <xmr:5FoSZJgaADH_roGzscPYhtix7YAfoTqOVW9bw4syqdWM54j0Q8GrBUNk5pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:5FoSZN9O842_HHDRLXSK0by_mGN4mAPVMusYiT_l7an8AqmRoIEk9Q>
    <xmx:5FoSZEuzTF3zt4gnjeSly2zESPwWf5dN3kaafdzk4J5EvDLyohobKw>
    <xmx:5FoSZEFVyHbJD7olH6Eid2GEKa3D3Ku13e6ocT5tO0tyHmitofZT6A>
    <xmx:5FoSZEE-n6shZKReUQQv_V9XsLdsWi3xIdtELUZ581S746xJtGugBw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:15 -0400 (EDT)
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
Subject: [PATCH rcu 6/8] rcutorture: Eliminate variable n_rcu_torture_boost_rterror
Date:   Wed, 15 Mar 2023 16:54:52 -0700
Message-Id: <20230315235454.2993-7-boqun.feng@gmail.com>
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
2.39.2

