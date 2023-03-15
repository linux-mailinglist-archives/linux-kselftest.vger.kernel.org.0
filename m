Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479406BC1D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjCOXzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCOXzT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007215DC83;
        Wed, 15 Mar 2023 16:55:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d7so42776qtr.12;
        Wed, 15 Mar 2023 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rSHayc8txC7fJhfYpILWnHp5swdD7fCpVaDyZx3Qg94=;
        b=Ud0NGkuFtWs9+/PMrXuSEV9LIvHfkUP+QDzDmUsV3TFJhF6IgDVbFQizll6KCf6nWk
         I36WbOarzxbk1sOHmaV5dyariMmKgNeK2OqsOeGFNznMKbC8CQHSEmUrOb2WkCX9J2cl
         GppJ/QiihhVSHMnGcppX+nCONPs6jvzm9XYWdQpTOKgLNK3LlkwsDjTO2MdATLoqlwBM
         u0ZsN4rEjOWCSdxMt+cNTSdH9OwEwtUrHmU9cPRjUgL7TxBkh18mX1YD9soDGgB+ZPH9
         FVcUhWdqmLgJD45QUYBt4VW4ba9+hTWYyGkqYJIrglRH8gQgG1XJ2BhrMH1Bf0BIagC7
         9T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSHayc8txC7fJhfYpILWnHp5swdD7fCpVaDyZx3Qg94=;
        b=SGxZIrja1KLoJOXM1jKlNDoutaVw3fzb2juHvpg3DxCxeWa7zs53tS0ro7HKJI2bWA
         IDwu55J1zdcTO5WWtrBNfhoioZE/HQOYP+tydv2yrCxFBT8TssAuV9YrmTYlVewYL1CG
         neTuAByu1AMNrsY6E8vK5Rzy/1fi9xOQyEPJ4QwV4pUwVdSrIlabFBnjkW/PcP73lCvq
         CKen5rMVQAwvmRmV1yDvnMR3l5dU/7dPvZtd6GlVQ5E9YXUDaXGj26jp1seDmIodcCNl
         VDksqK0TqaknDbmAXhIJkO8ejtQDco8Z65gLBF6TzWxMZTI2OaQIL/8PqduhlZMOGC52
         k3dg==
X-Gm-Message-State: AO0yUKXlbPyZhpoDFwdgKp2MFu3B+4Uh952tNZy9t6CyBKkbtK9uZx5v
        rOtvjgf0SMm9e0U0MAiMMXY=
X-Google-Smtp-Source: AK7set8Sy6Mv0lo2dHKPCgtM8eHmRLywg2Zo3R59wAS/2/HGSZ9CjVzX8/eiQA/dyTspyb5t0on4cg==
X-Received: by 2002:a05:622a:8:b0:3ac:fba0:cde with SMTP id x8-20020a05622a000800b003acfba00cdemr2454753qtw.22.1678924509531;
        Wed, 15 Mar 2023 16:55:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a135000b003d65e257f10sm1267858qtk.79.2023.03.15.16.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 74F5527C0054;
        Wed, 15 Mar 2023 19:55:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 Mar 2023 19:55:08 -0400
X-ME-Sender: <xms:21oSZOBfFGrpbvR1f8ZdOguYTIvCUYUCJRfLOZgsqW5JNRWqtWZGmw>
    <xme:21oSZIguRmNWpzGQb_51SfdfpZNkmLk6LFuLajfo6asR3CQUGYg53oBNsqHarOmFz
    0_jfdc6A_6QxhmX1Q>
X-ME-Received: <xmr:21oSZBlYcB_jGNaM5rOuj_fG4yiEXZ4kFT9vyARY_Iye5jwfDnHadMGexRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:21oSZMxk63skqQVuoiGG3_pII5xSk0UvXHeTzX3pTp8SyCXptOB8lw>
    <xmx:21oSZDT3HFDmwUCmQtkJon_FD854CyE_ZVn3BiaqVY44J9OJCKowQQ>
    <xmx:21oSZHaVRJ_H290ov-sc9L1XL3o3EDA4_3aowg7F-7lnb1YOK63aSg>
    <xmx:3FoSZBAgl2Njz6LgTseP6CYOE2refiVXBaV67-XLaOTB683WAnjQZA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:07 -0400 (EDT)
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
Subject: [PATCH rcu 0/8] RCU torture test and tool updates for v6.4
Date:   Wed, 15 Mar 2023 16:54:46 -0700
Message-Id: <20230315235454.2993-1-boqun.feng@gmail.com>
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

This series contains changes for rcutorture and rcu-related tool, which
are targeted for v6.4.

This is my first time helping prepare PRs, so please take a careful look
and yell at me if there is something wrong. Thanks a lot!

You will also be able to find the series at:

	https://github/fbq/linux rcu/rcutorture.2023.03.11a

top commit is:

	015d88635382

List of changes:

Bhaskar Chowdhury (1):
  tools: rcu: Add usage function and check for argument

Paul E. McKenney (5):
  rcutorture: Add test_nmis module parameter
  rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
  rcutorture: Make scenario TREE04 enable lazy call_rcu()
  torture: Permit kvm-again.sh --duration to default to previous run
  torture: Enable clocksource watchdog with "tsc=watchdog"

Yue Hu (1):
  rcutorture: Eliminate variable n_rcu_torture_boost_rterror

Zqiang (1):
  rcutorture: Create nocb kthreads only when testing rcu in
    CONFIG_RCU_NOCB_CPU=y kernels

 kernel/rcu/rcutorture.c                       | 49 +++++++++++++++----
 tools/rcu/extract-stall.sh                    | 26 +++++++---
 .../selftests/rcutorture/bin/kvm-again.sh     |  2 +-
 .../selftests/rcutorture/bin/torture.sh       |  6 +--
 .../selftests/rcutorture/configs/rcu/TREE01   |  1 +
 .../selftests/rcutorture/configs/rcu/TREE04   |  1 +
 6 files changed, 65 insertions(+), 20 deletions(-)
 mode change 100644 => 100755 tools/rcu/extract-stall.sh

-- 
2.39.2

