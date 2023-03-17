Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677336BDF68
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCQDPY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 23:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQDOH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 23:14:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7E1BAFB;
        Thu, 16 Mar 2023 20:13:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c18so4358290qte.5;
        Thu, 16 Mar 2023 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679022828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=98A9JSDdK68EP3muC4QWfVH1TQwNKNbY7UT9PV4lw+A=;
        b=YQMHQ1OsP0EdlubDPzv442u2bgCWNjY25DmA/nAQg9xskVJ1uo2sr3tFXMSrEWzG01
         8Vl5hD6IVBF/2oZSTDY7FecH9sH3A+UInfcCqUDJYO3JDZICAzgprK4fVrVkQYV+gzfL
         XU5eEbVf4jpOhF3/WBNIZoFxvIFN9llLgFdNyp0BJBneeCR7JRFiwVffuA4y3KQ/LPey
         ue6ghUEUJr7QwfzvtFYkwZs/6pPZ0QL+Mrk6O7bxwb0fmaA4FX+Djh1gHjSGBN+dWquL
         B0eFf7wAA39YEpghdEKHlsfmlUHZjLc2x88X/knSo4Zq1QBdi4vbopc4I8G58OC1oN5y
         t8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679022828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98A9JSDdK68EP3muC4QWfVH1TQwNKNbY7UT9PV4lw+A=;
        b=XkdZloPXkxoJfkIf0Ye5uo5bp/opl1ged67H0KjddKDgdbBq1IcmJAUq5TQxyclc/z
         m8Az5ySPgB5t5BBULr0DWPVMC77X/X+piRyvqrsdKcQ4zPpbpw+Omvd0TC1t/IJTwBv5
         HHaPkhISCxSckExtK/dv2QmN+Zu+rB+oMgORnuLNwYK4Hx0JbpuUuCLnkMIuP9gb+MjF
         3Z3m57Z+KxZDCy7KKbiga0HfZIGKbu59haumSmozWXkCjCR56ca5gW3QTuuGe87Uxqje
         Cx7TaoSvSvXYpUejBndM1cII4qm+UEXXVIPX98O5NXiovp72HuqAAyVWo7ShBcqi5fP/
         6Hww==
X-Gm-Message-State: AO0yUKWSXyMRhT0gbRiwZxKDdoDrYNPEZCbVGhsfWK83laAl3Gv1EQ8O
        J7bMi709Wl0+T1OFOFYMMuo=
X-Google-Smtp-Source: AK7set/0GjLpSmo0LzV5ad/wID4+PlO9csqnRKRTAbQ4MfhrHt3p+FsgY+YfCakrPNt49ZeqPWSOOA==
X-Received: by 2002:ac8:578a:0:b0:3a7:e2df:e868 with SMTP id v10-20020ac8578a000000b003a7e2dfe868mr10421797qta.41.1679022828769;
        Thu, 16 Mar 2023 20:13:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a281500b0074233b15a72sm788877qkp.116.2023.03.16.20.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 20:13:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3FC8027C0054;
        Thu, 16 Mar 2023 23:13:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Mar 2023 23:13:47 -0400
X-ME-Sender: <xms:6toTZBAnbY6af6sA6JTY-rslm4QujGTYUm_yJ9YspuZCmCX_BVd5fA>
    <xme:6toTZPgdSOCjk7fV_7bLYdA283hIInsSurlOZ5K2z81mSGaGQbJcqvljy8Xc-8PJo
    SdE9g0LlNuIHRi5bQ>
X-ME-Received: <xmr:6toTZMnqofHprQB8-tdarwdD5Rkr2jRI3QuCgGXx5Mn5Du9dHM6cPFWLDiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:6toTZLz5EF8k42hi5F_2SV3kwlwb23HV1ktmSNRHB6YvKgpjTwa00g>
    <xmx:6toTZGQBLThAU8XlPtsGQ--fn_D8ILOz8Dn0XI14RwXJV5IuP9ApDQ>
    <xmx:6toTZOYLgNvijKPqdbKU12CE8Pb-Eri9WfnRpFgIIXbntJch3sg5eA>
    <xmx:69oTZPRGWbOltaLPcvZqIh-FXa2sVv1voCgLdQBXHkh1p0l6tYrgxQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Mar 2023 23:13:46 -0400 (EDT)
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
Subject: [PATCH rcu 0/7] RCU-related lockdep changes for v6.4
Date:   Thu, 16 Mar 2023 20:13:32 -0700
Message-Id: <20230317031339.10277-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Hi,

This series enables deadlock detection for srcu_read_lock() vs
synchronize_srcu().

Again, my first time helping prepare PR, so please take a careful look
and yell at me if there is something wrong. Thanks a lot!

You will also be able to find the series at:

	https://github/fbq/linux rcu/lockdep.2023.03.12a

top commit is:

	24390de55773	

List of changes:

Boqun Feng (4):
  locking/lockdep: Introduce lock_sync()
  rcu: Annotate SRCU's update-side lockdep dependencies
  locking: Reduce the number of locks in ww_mutex stress tests
  locking/lockdep: Improve the deadlock scenario print for sync and read
    lock

Paul E. McKenney (3):
  rcutorture: Add SRCU deadlock scenarios
  rcutorture: Add RCU Tasks Trace and SRCU deadlock scenarios
  rcutorture: Add srcu_lockdep.sh

 include/linux/lockdep.h                       |   8 +-
 include/linux/srcu.h                          |  34 +++-
 kernel/locking/lockdep.c                      |  64 +++++-
 kernel/locking/test-ww_mutex.c                |   2 +-
 kernel/rcu/rcutorture.c                       | 185 ++++++++++++++++++
 kernel/rcu/srcutiny.c                         |   2 +
 kernel/rcu/srcutree.c                         |   2 +
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |  73 +++++++
 8 files changed, 359 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

-- 
2.39.2

