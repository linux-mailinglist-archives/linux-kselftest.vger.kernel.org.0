Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3686C5DE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCWE02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCWE00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:26:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C7231D9;
        Wed, 22 Mar 2023 21:26:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g19so179173qts.9;
        Wed, 22 Mar 2023 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679545584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m71zsVivzHPhz262MIZjHPWFUGOi4WzXmXh+VaxIc18=;
        b=EQ7QLeeZLlMbUuGH4tbDcR8oO3gMKAKXndJmeoi/zamjx6Q7lu6TOTPL/NyiWOvKf8
         9RHo2WaKrNHyEQmd4GU27KCfAZZ2eREglSsYislMDmVBT55AxmtqQkOTwlF2sAQM2KeN
         Hm0s61Qv6fxqwTD3vqP+PRS6h0Ksmpsqy6ow3pOJP7m6PfL7MxSzXl/L5eSOSuJIGYL6
         WyvtmW5r3e1QGs9KLnqcIq3z/NjnAfRp5ucZzn1WF0tmaqv5ANiPPRPfxzMSUYUfy+wD
         OMr7SvtzmtocGHZABYRMWVk34AVMXkQ8gQyXjS8jeT58XT3nU5SE3dms6w8/S0I+o6Zo
         oZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679545584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m71zsVivzHPhz262MIZjHPWFUGOi4WzXmXh+VaxIc18=;
        b=dVX7Z6VEUZ8yqFPVlF92WlQgKbS8T/XkVDO+CT9wtUQ1rIRcY964mxmAidE7oxJhc2
         tQ7V0NUcUpfWY8dc6GH4cIpoQR81C5BDLFC/l2i0DyUh5uPyEGgD4wR3eY5sKfdUYPwx
         zTPtlAxyZUIqCLk11vkKMPvH724vy77KEwx+OPcv66BzTh9DmANPOR0+A6/r8Rd7wFlq
         vH6bYqQQ3QKPTaIHvy3eAsow4XsP0ncX/36icf4giX5QyNCppsSku7jK2fzBCFfymkaS
         zj1trJ9wRUL9bVuObGMFipY/buaF2gWqqpz5GyICXGjowBkMip+gxUhOUE7maliZrNxc
         921g==
X-Gm-Message-State: AO0yUKVbtsJhbglw9TTscBfQbaSt81FOzBSksY9iFemMU8v01xPrTifB
        bH4+PYcmCeHNXAtNu6kMyUZIcXXtfEM=
X-Google-Smtp-Source: AK7set/hFPEBgjbu1OY/J8kGibdPA87T8WbPpJKO967sCI2Gs34meqq8uz8VOjyIRQ0syTkjxas1jA==
X-Received: by 2002:a05:622a:49:b0:3e3:7ed6:3db with SMTP id y9-20020a05622a004900b003e37ed603dbmr9925908qtw.29.1679545584311;
        Wed, 22 Mar 2023 21:26:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b0074357fa9e15sm12596448qkh.42.2023.03.22.21.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:26:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 016C527C0054;
        Thu, 23 Mar 2023 00:26:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 00:26:23 -0400
X-ME-Sender: <xms:7tQbZNm4H_vZ8ibV5yORE8QkYKcUhHk8ktwhm99aH0FNznVM-TcsXQ>
    <xme:7tQbZI3GlkrFAVsHUqVQoY4v_z8XPCu_2158m55yX8dblEaQ8_Ge9ByFrpdFjtwkO
    Bd62OMBB_rEFRtj7g>
X-ME-Received: <xmr:7tQbZDqQ8X8_qMHNCFDFlu4IEcmVf6OM2ZLNwIVurvVW2qMNxvN3n_96y1fWf8Lm-lrwq3YzJXq1u5dmqOGRNwpMZFVSGK_S250>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeggeeukeeghfevudektdevjeehhfekffevueefudeivdelteeltdekheejgfei
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7tQbZNnwyQf3QxDax3Eojlqyy0zuxO4U-p7tvocODglkP6PI5c6qjQ>
    <xmx:7tQbZL1GrjF9j_-zPUtyWA2wc2CvzCfBheZ7GkMeG2sJHcpK0VHZ0g>
    <xmx:7tQbZMuI5Ff-yvR9qIj74c8QigWZQv2597ZaI2x7YPDjYGT9WaKcmA>
    <xmx:7tQbZNWrQ14jmmG7-rOPz7zxObs0iSFXPBI9hdukbcTFibCYohnxzw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:26:22 -0400 (EDT)
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
Subject: [PATCH rcu v2 0/7] RCU-related lockdep changes for v6.4
Date:   Wed, 22 Mar 2023 21:26:07 -0700
Message-Id: <20230323042614.1191120-1-boqun.feng@gmail.com>
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

Another week, another version ;-)

Previous versions:

v1: https://lore.kernel.org/rcu/20230317031339.10277-1-boqun.feng@gmail.com/

Changes since v1:

*	Minor typo fixes
*	Apply Acked-by tags
*	Add license and copyright headers for srcu_lockdep.sh

Thank you all for helping improve this!

You can also find this series at

	https://github/fbq/linux rcu/lockdep.2023.03.22a

top commit is:

	450ef54e199f

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
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |  78 ++++++++
 8 files changed, 364 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh

-- 
2.38.1

