Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A696C5E13
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCWEj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCWEjx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:39:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA574265AF;
        Wed, 22 Mar 2023 21:39:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r5so25349553qtp.4;
        Wed, 22 Mar 2023 21:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OHEXryW8drMs0szaO1SbdhWAn9gZ8trTjV5hBTe6O2Q=;
        b=hkNGZ94znl1tuzWRYVzw1ITnJEklP5Rilyus5lgsEeJYv9pjTKlqj+vx/i1gGr4YAL
         MYBEZUlx+PNELIljEjB/gNmLqHP4VOEu4+x+/yWAJ2eFCJkEIa+WdMUf8VUsAt6rEq/O
         mc+98VZY3sNI69GqnTyQxE45b+a0MQzo/sl5BUz6kASCryee90N36/PdeZ5IieXZ/I4s
         Mnwnju7baUkBW5dlg8lXTEkipKjwjufTcvejsbXjLYGLC8KtRRV3w2GTUyiGVJiUb6Hr
         OjZpCnsEpPKig7v3tikhwWEo+MHuPynKKhlBX+n5JDwSlQt16VgJHLhJjFe4/1jfKgPm
         0Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHEXryW8drMs0szaO1SbdhWAn9gZ8trTjV5hBTe6O2Q=;
        b=3Aj4uUNVciaWXxgvLHozL24CyvuBYcDT7pyMQ2eslabV4/qUeDCXjVk7jAJGaO3mkr
         35b31oEJYBAPPbDChfWrWZeA8BiA681sFkIPvPzz6Wp9by5IEKT2U9jQJhOhadFDLPFG
         qaIaWSbGd/wIMuowgL+9uR2SaZjcNy+tZYEba6uD10gzpZ5EwkfiFUNuIzpD86c7aBCc
         wbpx3c4aGOAZHPj1Gr+hZ0k4Ampv5q52j+ZYWqo468g1aJ/5n/984Wb2HNUyW5PsZYPx
         XyV+TQpUo0vXCGF2eQpWBLHxSZsf8eVJKnXGP2vz+G5pVRCAKpBPlXYxEgXWZRjMGQb9
         9uqQ==
X-Gm-Message-State: AO0yUKVaqxAWiM3FkTnDZcghaE+9UAyDSbqdlhLti9aB2GCq7dD6M7/o
        D/yDDeOM4cdwEO4Sh1xpZDuLnHMUjHk=
X-Google-Smtp-Source: AK7set9ScnnZsk4iSFw8V04MF1xA4UVeHWBx1+wVrolhhCa3R4olqMjh1MPTLTdqZSsRSg/C3+ZCAQ==
X-Received: by 2002:ac8:5f4d:0:b0:3e3:87a2:e7f5 with SMTP id y13-20020ac85f4d000000b003e387a2e7f5mr9952384qta.11.1679546391823;
        Wed, 22 Mar 2023 21:39:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f6-20020ac84986000000b003e38f7e4562sm1316017qtq.69.2023.03.22.21.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:39:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC53A27C0054;
        Thu, 23 Mar 2023 00:39:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 00:39:50 -0400
X-ME-Sender: <xms:FtgbZIZVa6B962I7zTPebHBEGof2vLtmb_kE6IVI5vHlGuC1rOKqwA>
    <xme:FtgbZDbqBxC5jkPuVNFzz7p619KpJX6zzkLg68hoxIYO8icwi6gZJTjUAQ7041TSp
    89A2uYehr3ycIeqPQ>
X-ME-Received: <xmr:FtgbZC-V86RkxyfA0nQcwsilIhcvkuIKd9ZJyl9E2E4vLe1K0SoYFWZZvxqLq3x3-5Tg8csxeahirNsSuYpiLpl1uyeDb0QU7Vk>
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
X-ME-Proxy: <xmx:FtgbZCor9qFVRni5oYiv-73QmFx0EKXEa5UMvq7A4qjpCfV8aTSkEA>
    <xmx:FtgbZDrhk5NxmV6enZmTx-Lo7Ju2auIvPhr-MawNy3yjaCDzGnvAAg>
    <xmx:FtgbZASeryAFSYK8Qc4XgSaplDLJhTl2W6ViajUF_LeyA2DIPIu7zg>
    <xmx:FtgbZM45S3_PQqCwrvAS4wfTdfvttu4tmy34eJ1W1UdtdQIOnmYMqw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:39:50 -0400 (EDT)
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
Subject: [PATCH rcu v2 03/10] rcutorture: Make scenario TREE04 enable lazy call_rcu()
Date:   Wed, 22 Mar 2023 21:39:28 -0700
Message-Id: <20230323043935.1221184-4-boqun.feng@gmail.com>
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
2.38.1

