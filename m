Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C986C5E11
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCWEj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCWEjv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:51 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7A265A4;
        Wed, 22 Mar 2023 21:39:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o44so10594521qvo.4;
        Wed, 22 Mar 2023 21:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZ8d0flphaRlWC4V9l6VSChxJlOrP32J2tV42hg3zmI=;
        b=WEZffOpSypUyM1PMJ6jeMYw2Uhn+XGytX/ZgSnaeTW3A5HmzMccRO/A8Uhgdi3fde1
         Rz3EG5vBBEoTpdwa5/kxJfi1QsHGmJ2iX39k/5Pr+3vwTVeXW4BeSuyYx1QuWqCjrlaw
         +DhyxP+shEjh5Es5QicukvtDlmbv/TowWxBnkahQnHHm4s5NxsZRvE+SHZiCqwzdQEWi
         yxKbEpQQ9ikhr5zxBetxi4MBCd97s3IuRNjr1A9NJt0ZNoOJoVbnilhulIXRtjSx666e
         oRVBrZeMiJFHPwDIoh6fzSSYgTjwxBSwXjh/WCZ+wdYDhnH8OSXcBs7al7k6OD/wX/nX
         CFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZ8d0flphaRlWC4V9l6VSChxJlOrP32J2tV42hg3zmI=;
        b=KQiI7Z6T1/XMcD4iUocVGnM9zbTq4t52ZNvFIuQuLAE9EN/AzXpJr+1byRqVQh/aPb
         E3D5VVjdhJ+JosrOlAmnHcX3sHEOsc0mrr/zcF5JNb/BC/xQ1nzHEuz/ruoSMA9tdjVo
         M+uxDka5G/ocUSZ2OAr1ivnv64x4xJoqaGB1Ddt7AvOPexIb5xCpoJwCZaXpWCnx033O
         OWuQ1XPYSOGHP02l16/nrnE82Z7gUCqu0TPRGlByFREbJYsA/0UBsGociC8EvtsL39sL
         C3NjklbiMxRDiFEdvtpyZzYkd2CRasgvVLA+9CUDqtsEno8XtrGolPg8KaD+O+Ezb6cw
         /8GA==
X-Gm-Message-State: AO0yUKUc57QusjtdWH+u3JA0S2uKDBrlUeZa3lKplrt8csyhLd94g3nT
        Y4UggPDDSl6dVd5ruKqZzTk=
X-Google-Smtp-Source: AK7set/7u32PADWJOU5K3YLWfr92wgXwit3iahzDgPS6RggqAHZCqwCy/Rr24NqdQd6Jx9HNCKtX2g==
X-Received: by 2002:a05:6214:c83:b0:5c0:ef32:5656 with SMTP id r3-20020a0562140c8300b005c0ef325656mr9257230qvr.11.1679546389458;
        Wed, 22 Mar 2023 21:39:49 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b00746476405bbsm12538338qkp.122.2023.03.22.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 888BD27C0054;
        Thu, 23 Mar 2023 00:39:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 00:39:48 -0400
X-ME-Sender: <xms:FNgbZH8gcxXA2zMldNDu8vDqZVHgJTk3AROxQ-Y1fT4YJcR7LUSExw>
    <xme:FNgbZDsMQfCLzQfAJsSDfznKLB7XweLyZivK0H1LT_1vVdgpaKBE9_8uKxzPnWf0I
    8NGHNRT2r43KJQg5g>
X-ME-Received: <xmr:FNgbZFCPcyQ8S0hd8p7L7pJMo4PFUbBI28BGF2MFZxfJLnTRtUXU6_KsGPIga-9hwTd6xeUK2X4vJC4E0rQJ4qZtCDGs7LShxpg>
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
X-ME-Proxy: <xmx:FNgbZDdRmRqBWCt3sEPICXUWI_nOGXlRsln0hOVy4eNwKv_HGo5U8g>
    <xmx:FNgbZMPCNt9O0hjowmQSBSpPJWeeR9G8sPAkIea0fbjv8685w0aD7A>
    <xmx:FNgbZFm79mNDOmkaQ3R3CqsxBIDSLUjR4UhEwh3zDrAeSGny7XbSQw>
    <xmx:FNgbZDl7KWwjB_uQW2goypOdlUwsWq-nyaOkp74tUl0rePyE_sdd3w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:47 -0400 (EDT)
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
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu v2 02/10] rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
Date:   Wed, 22 Mar 2023 21:39:27 -0700
Message-Id: <20230323043935.1221184-3-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

There is now a BOOTPARAM_HOTPLUG_CPU0 Kconfig option that allows CPU 0
to be offlined on x86 systems.  This commit therefore sets this option in
the TREE01 rcutorture scenario in order to regularly test this capability.

Reported-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index 8ae41d5f81a3..04831ef1f9b5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -15,3 +15,4 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
+CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
-- 
2.38.1

