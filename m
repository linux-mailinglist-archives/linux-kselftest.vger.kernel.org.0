Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94BE6BC1E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjCOXzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjCOXzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74F6133C;
        Wed, 15 Mar 2023 16:55:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so47047qtq.11;
        Wed, 15 Mar 2023 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQk4FNj9cOXKf/N0Z5hVCFZioIfls/69/wUewAHZC/M=;
        b=naU5Ws3oqw/MkLMhTrA04D/YEuE7vXr2frvrjxwvzMIRypxyWkaf0NSdXHEe9qN9kc
         YT2+u8/rRu3qhrKlBgOO1gTk/lK18DBMMzoC24sRbWnb3cKUxk92EHdJ0W1P6O/GXpUn
         zREX2zNcsl80me6KgGxAumFSIG6Ttq2H9guZKDOZWaVNeLnUCPIpbOrCPQgzoQlcAN6l
         UhYxqpU8WwkkTIziztibY0LZ6+A5Es91ps4ED6+7YLFMOmk1RW5vYhOk5OXkfWPtYQCL
         b8v2SzNqnEMOJNOkqVHuoJau5pmRkOu+gpXz3CNYsQXZM9wJ7TbpWZln71YjZTfSfk4Y
         ammg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQk4FNj9cOXKf/N0Z5hVCFZioIfls/69/wUewAHZC/M=;
        b=gP4URi8zDWGEbipDdXcMCiBwPOCrDdfL7+hpqxajy+LhBI0QogV7ihRvCyBT7/PSMv
         T8I9HEHoZtaOyAnbP4hSq9UqKS7tgHB0wV7YNqhdq54BWkbs/0Z3MQ98VII882kueTIf
         jQ7w0v5ZllKVovIaEeDBvx+Y30buhBlM0NiyrIf3CnhVvJw3qIS1WSI2kiPP3osqWJ+6
         /9E3iqXm3/xqHq/qtHuV8MRQ8pBO0iz33FJRIqemc5FPr5q2furD3mjk0vFNPaMBEiCR
         QRw/byXxXNCVer58J0r/TFM+5jPzX2DjOWKbOnjVdQxxFEo0nm6SVd0cbmAbE7lHoFne
         PZtw==
X-Gm-Message-State: AO0yUKWxWHAqx7uFuxq3+EoXIWZBC3dK7sSscxLVA9MpuTunGXECtvWp
        2JkY0AfdyoCggN/lJmlhGNE=
X-Google-Smtp-Source: AK7set9O7a5+ONaI894j9lnNQHVWEM2zEhOG7CQhyZ66os9aGL+8ntoiOIq00QTyD0ynhze3jxYEKA==
X-Received: by 2002:ac8:57cd:0:b0:3b8:4951:57b8 with SMTP id w13-20020ac857cd000000b003b8495157b8mr3160892qta.15.1678924520385;
        Wed, 15 Mar 2023 16:55:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x1-20020ac87ec1000000b003bfb6ddc49dsm4608990qtj.1.2023.03.15.16.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7FCE227C0054;
        Wed, 15 Mar 2023 19:55:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Mar 2023 19:55:19 -0400
X-ME-Sender: <xms:51oSZB0Yp9rRGujxgX3wxwIupL6Ry0EmZHDi0nyR6KUr-NAXhQCpWA>
    <xme:51oSZIFugeF8YUrIGHPTaAX3YAqSnXeVfrdav6SnO3UkP0C87QOxDxl8-O_t9VHgf
    ihBMauDtEHrAZGCXA>
X-ME-Received: <xmr:51oSZB5LsAHEjlNQ24C2F1nU8qkxQp7i_FQ75y9uZ5_Qso2Q4HlHJtYD8EU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:51oSZO1bGKRfzyn_uCizR6-9tWSs6HCxRZA79G9gHq4uBSkO91pV7A>
    <xmx:51oSZEHWtUFDYuaBhVvI9Ef5V_FoVvC79R_70JIXx8UM2tGA6s5nTA>
    <xmx:51oSZP87vbu1qCnJ5Mz0rdKgUI8Px2hN_IAoZ1khwNMCj0g_LeOl0w>
    <xmx:51oSZBecM5bJJHwJhgMAQ5Tytc5IyMcxgo18G4c2VOWzhSlYP-AjWw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:19 -0400 (EDT)
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
        Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH rcu 8/8] rcutorture: Create nocb kthreads only when testing rcu in CONFIG_RCU_NOCB_CPU=y kernels
Date:   Wed, 15 Mar 2023 16:54:54 -0700
Message-Id: <20230315235454.2993-9-boqun.feng@gmail.com>
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

From: Zqiang <qiang1.zhang@intel.com>

Given a non-zero rcutorture.nocbs_nthreads module parameter, the specified
number of nocb kthreads will be created, regardless of whether or not
the RCU implementation under test is capable of offloading callbacks.
Please note that even vanilla RCU is incapable of offloading in kernels
built with CONFIG_RCU_NOCB_CPU=n.  And when the RCU implementation is
incapable of offloading callbacks, there is no point in creating those
kthreads.

This commit therefore checks the cur_ops.torture_type module parameter and
CONFIG_RCU_NOCB_CPU Kconfig option in order to avoid creating unnecessary
nocb tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c0b2fd687bbb..2d1c7e15cd72 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3525,6 +3525,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.39.2

