Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF66BC1D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjCOXz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjCOXzY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C662B7A;
        Wed, 15 Mar 2023 16:55:14 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s12so46825qtq.11;
        Wed, 15 Mar 2023 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rhLt/LypW20+3edLrh/Swq7OLAp9k0UMSWEIG6huLHQ=;
        b=qT6ryvEwdZUsb/ixUvkXe7gx+xrqIrLiCGpQNLy6LjWR+UG/LAmYRmqxSCHkPScIZV
         tzO8TfBPzhKu8KHUhrWAnnAWOmNWR6pX/zD8NwjKxFteHKeQo5hS5ABCHHsQqnGTknSm
         nm0alfOWaZ8Fl8V7Xr0rVc1/OjJO9hxuyc86lsAvlGuAq3NE5q3+7WhXoI28OjtaGbAh
         VIgmWw8dBmU1M2LnIw0jGo1srGwO5JxH0Mw2gysgSXuHlP3ak8T1MnrobF9fQsJxkH2p
         fZWJVgB8lYRZsMHvOT2SFFEGRB0mdnTwWHEWDOowB0OzOtIcBQsmRmX014xBLY/qCOJg
         3LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhLt/LypW20+3edLrh/Swq7OLAp9k0UMSWEIG6huLHQ=;
        b=13Q4bVQJzPW+rZVr74Ddoy40tZnZPJ1ZYufZOev1Lk7qY9SeBH2xn1nGYkUzjaJKH4
         7fc13jKrRfiDEHjJz4USNCP2LF6Ie7LacL31Nr/JbtY7IBGyxOTPs3fpwNm3yOeFOlX4
         Ekif0xr/wVYh1ycKIZD0kZfKr2HVoYMvuMnEzpYVoyoup7UK8+0wxW2lhalxPfC+vUWz
         J/Ix/09HuA5+/xW/2kT6qEegoXl4mh2SKbkhbbM12QBCxm0jsPpfJM/w8LIehy1vKjWj
         NRf2sgG6NprWVWDQaUaA17XQmjo2xvoGLxP/SNdGNqGf2Er0KBW44xph4yrnClyoUvOa
         sWEg==
X-Gm-Message-State: AO0yUKV+MZD7zq4h334KnDbgA4rt1SoFASy0vYn1hrecEAiT4uNNgT6d
        FU+uKnhDJWRO6lInuavUEH0=
X-Google-Smtp-Source: AK7set+479pVexANE9V0g41ZZoiCSFUgEJzfnurt28MfLw31HXpwQ1kt7aTUMRrfKyRMvk8lHs3Jqg==
X-Received: by 2002:a05:622a:314:b0:3bf:e364:1d19 with SMTP id q20-20020a05622a031400b003bfe3641d19mr2546074qtw.54.1678924513394;
        Wed, 15 Mar 2023 16:55:13 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v5-20020a379305000000b0074235fc7a69sm4713983qkd.68.2023.03.15.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6406727C0054;
        Wed, 15 Mar 2023 19:55:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 Mar 2023 19:55:12 -0400
X-ME-Sender: <xms:4FoSZPB1Iab2KtWvR0tDgxTxbGskAVkgRer_yUE9aEFMm8mTtShmng>
    <xme:4FoSZFjzau0c-6ahXPBdc9Z-N2R8lFRsf_ADTLwPcS4X_VCh7HP0WYdYY_OEP6UB4
    GybpoH2Qsl4rMv6Gg>
X-ME-Received: <xmr:4FoSZKkEq8nLinUBpDGg_Eb9xc6p_FNUzTv5xcYKVHunPLW-CbJPJgDGNus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4FoSZBw-sKLxU5PP7A-jnSKkat6I8pGPguxTxT9s-NN2vk1aWrsQow>
    <xmx:4FoSZERe62JyyMT_QGaah5iHqrqulwXiE0TeKyoqb2WpI4lDNNq9cw>
    <xmx:4FoSZEbXfvQfmWZl3ngJFjdYxjDzHwxFbsPUqEdcOqrwwZ7j7OuTrQ>
    <xmx:4FoSZGByUpWlxw0xMZdaFiNLUHLRrpdd3RbMVhGXlzvkLSAYhsQQLg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:11 -0400 (EDT)
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
Subject: [PATCH rcu 3/8] rcutorture: Make scenario TREE04 enable lazy call_rcu()
Date:   Wed, 15 Mar 2023 16:54:49 -0700
Message-Id: <20230315235454.2993-4-boqun.feng@gmail.com>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit enables the RCU_LAZY Kconfig option in scenario TREE04 in
order to provide some ongoing testing of this configuration.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE04 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index ae395981b5e5..dc4985064b3a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -15,3 +15,4 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
+CONFIG_RCU_LAZY=y
-- 
2.39.2

