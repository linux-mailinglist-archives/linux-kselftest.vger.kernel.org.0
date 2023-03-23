Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADFD6C5E0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCWEjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWEjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:46 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35025E31;
        Wed, 22 Mar 2023 21:39:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ga7so6554983qtb.2;
        Wed, 22 Mar 2023 21:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ozDAL+VJG5JbtUPcH8lU4AsjI2MR1huOykicDfIYGwg=;
        b=LRuC1e0++HvluueViJgWpeTB5HD1o/xL6a2/FkR/E0cd++bSMgJ4ENKoHbCgLayOVe
         8wy//kqU6nXww2x2Whw9XQw5itHW7J1tZ/0rIC5887xOrVe9dBX2rTqZpJFWH/SkoEDD
         lxaTdmEPwBhV0AmHv7konPUoyIIs45tr1JfHaD2aY3br8AcPqe8ACYKShdJ6NoC+ZaWD
         a90+Shy52aDHL3dCEKAyijCXz3l2ZiA6EQlo5HFfuQ2FC6dGZevnYtLBHQtaZ7hdfEZY
         HdxCl+2QuXI/SLRhqnR38pzOjaYV9aWJyWQnZmTYSQYHQqXT0rksxLlOS3wU7WJWYw7O
         bG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozDAL+VJG5JbtUPcH8lU4AsjI2MR1huOykicDfIYGwg=;
        b=N+9VGc+JN6v8nTSXY2GT1mgrBiwlMeQaaWuKiTJFJP/a51rYK4SPLAfCbFEP20H1Ss
         ZWMUqwN58hyskJc14pt6Eue+Kae2pKgDcl5uHVL9FgTMgp/nnzuUTWh6QcKRHL6yzZpb
         EzEcOgynevGtCTmbi5YthqT9EdGutWovGh4r2rDZs8nCJGGxgCAikFWlX/+KrctSjHoK
         +vzwynlJCeAK9ivCVxjsBG2+OURuDhYCMBP7tUgvfxDPQHXv16S9l3l8AoBHxfbAAkOs
         z06OKBCxMn1pkCw+ebWaYcvHFjhqydip/tJ8ZUf1T0q3+v4KhxOs7VM1S48IcuABa2cw
         gWsQ==
X-Gm-Message-State: AO0yUKUhap5v5g0G303L1vSJEj+jCtD5kvaLcYQrmpUeWsRj99qd9dTY
        HZ2qxLlySf57c4e2KScwdkU=
X-Google-Smtp-Source: AK7set/Iykv7y2EPRtNXNJp27hnfbqOjip/0FfyaLvTaJQj2B1bXZRWKakgInUjG8Q5dixX+6vuAKA==
X-Received: by 2002:a05:622a:11d5:b0:3d0:7bdf:42c4 with SMTP id n21-20020a05622a11d500b003d07bdf42c4mr10256013qtk.59.1679546384697;
        Wed, 22 Mar 2023 21:39:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id fu48-20020a05622a5db000b003b9b8ec742csm11312179qtb.14.2023.03.22.21.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 89E6227C0054;
        Thu, 23 Mar 2023 00:39:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 00:39:43 -0400
X-ME-Sender: <xms:D9gbZM7AcyGOUMGA5dKZjo0iJsPNaUG3avVkBVOVfBn7XKKx0_TY3A>
    <xme:D9gbZN5HYOc4IwiA9BAXSvmfpbk8LijqEhLEf_f1U6ff1RJHiPXtnqTrg_u46czRo
    _l-oHA3ZuEJvQ8IjQ>
X-ME-Received: <xmr:D9gbZLdlmMCgmRrq2YGj2j3Ofydbt0skV39wzRd0dcqaEmItRmnQFKnxg5rxaIu-fMkcot7kAWCTc6cFISRqEP2pYKhlzJAL1Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetleeffedvgfffjeeggffhveevieeljeffudfhfeeigfelffefjeefueevheek
    jeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:D9gbZBIl3adXpawrNq9H2FM5mKYuVysd9aoR7uIxpRtAcKwJYMoIOA>
    <xmx:D9gbZAK5Ui0ldUPoO68bS6BN_XeDrTSEI3BuEo1M8sbjPU3KR2iqhw>
    <xmx:D9gbZCwuL2mZeT9AJfxA3tePmiXklMUMbAN2kRSRNcSXlPZzGMH90w>
    <xmx:D9gbZDbUq_kKWRdNKFDjDCvlgQAnEMA9Sb07h8djMpo0lGub8MayQQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:42 -0400 (EDT)
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
Subject: [PATCH rcu v2 00/10] RCU torture test and tool updates for v6.4
Date:   Wed, 22 Mar 2023 21:39:25 -0700
Message-Id: <20230323043935.1221184-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Hi,

I of course took the opportunity at my first time to make a mistake: two
patches were missing in v1.. please note that patch #9 and #10 are newly
added.

Previous version:

v1: https://lore.kernel.org/rcu/20230315235454.2993-1-boqun.feng@gmail.com/

Changes since v1:

*	Add two missing patches.
*	Fix checkpatch warnings.

You will also be able to find the series at:

	https://github.com/fbq/linux rcu/rcutorture.2023.03.20a

top commit is:

	6bc6e6b27524
	
List of changes:

Bhaskar Chowdhury (1):
  tools: rcu: Add usage function and check for argument

Paul E. McKenney (7):
  rcutorture: Add test_nmis module parameter
  rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
  rcutorture: Make scenario TREE04 enable lazy call_rcu()
  torture: Permit kvm-again.sh --duration to default to previous run
  torture: Enable clocksource watchdog with "tsc=watchdog"
  rcuscale: Move shutdown from wait_event() to wait_event_idle()
  refscale: Move shutdown from wait_event() to wait_event_idle()

Yue Hu (1):
  rcutorture: Eliminate variable n_rcu_torture_boost_rterror

Zqiang (1):
  rcutorture: Create nocb kthreads only when testing rcu in
    CONFIG_RCU_NOCB_CPU=y kernels

 kernel/rcu/rcuscale.c                         |  7 ++-
 kernel/rcu/rcutorture.c                       | 49 +++++++++++++++----
 kernel/rcu/refscale.c                         |  2 +-
 tools/rcu/extract-stall.sh                    | 26 +++++++---
 .../selftests/rcutorture/bin/kvm-again.sh     |  2 +-
 .../selftests/rcutorture/bin/torture.sh       |  6 +--
 .../selftests/rcutorture/configs/rcu/TREE01   |  1 +
 .../selftests/rcutorture/configs/rcu/TREE04   |  1 +
 8 files changed, 69 insertions(+), 25 deletions(-)
 mode change 100644 => 100755 tools/rcu/extract-stall.sh

-- 
2.38.1

