Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D26BC1D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjCOXzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjCOXzX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38D61A95;
        Wed, 15 Mar 2023 16:55:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d7so42839qtr.12;
        Wed, 15 Mar 2023 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dXDYH8FjRjj8ivrQgv2T5n0d4h+aXiv+bXsNJ1LcT4=;
        b=lha7OIlC9a0DJrlduqH7O3SbwIOA/SButloLbUu9GJe3sA+IEMTuwh4drlilo7DNLv
         KtM+qNJFZekXDCj7eIqDp7dngeyU9PbsHrNR1Fi9kI1a+zk6Nhk7cnxyf2vFcwwEtCiV
         g1TOHsCREwcmXXRFKwe6dfBdLe3ENhQmfkmOXOshrN9aM7HC/ScPI4NKbezUyWwOBi5l
         xEC4/1rDXsnBV+ywVnx6720A0cbv7TQyCQGSst/G84eyrlneoBLnFBo0kr5lBQAJWJdU
         u3NLRoXFEUZqrn/zN5QclmHVegguksfVzalaral9hInzcljgaC2L2b0o1rB5FVoZr5wy
         3V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dXDYH8FjRjj8ivrQgv2T5n0d4h+aXiv+bXsNJ1LcT4=;
        b=DDNBDhAz/OIh/avbCkFkMSRUeboaL91x+dGQJ0RZj08Mg9IqH7N/Kgq01SHCTEH4/j
         aC/bu+XvqFYXl4EmU06RgKxRxuayudNakT41o2WiB5MfL5Jv24D/tvm2kxsD3Av80CPV
         8a1fplLWjyXdgv3XG5AgXv+vCBu08RQkWaQySyuHkIY/cf4l2JOMAczzgSErZGbYe307
         QqplTkQVGulQxkxZK0rgTsz1BIXjdr0/uEv7JvwS/PV7LytzKPHSIVcYvc5n9Jr8g79g
         IBYvhM8Gn/MVW7wlz1u7koMiGGFPn3qeFdqpgOge67e+BR+OJGDvDLDBlzJaY6kmKV5i
         HiCA==
X-Gm-Message-State: AO0yUKVld0h0RyQqGLebsVyakSHzWJFjHQIN4hlO9PyFBzEfMVr1Wj8L
        UhOr2Jsb+vyg/UDxSUjUqj0=
X-Google-Smtp-Source: AK7set9WcH9VotUZ1llfk+guVzJgXSnD72/JNcvA345ZQCkEhQeAIDyxz5UrhTBxvh9HMd6Szg4KWA==
X-Received: by 2002:ac8:5f53:0:b0:3bf:da97:87dd with SMTP id y19-20020ac85f53000000b003bfda9787ddmr3268273qta.38.1678924512020;
        Wed, 15 Mar 2023 16:55:12 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id fp15-20020a05622a508f00b003bfa66b7484sm4707782qtb.35.2023.03.15.16.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 10EC327C0054;
        Wed, 15 Mar 2023 19:55:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Mar 2023 19:55:11 -0400
X-ME-Sender: <xms:3loSZAlc4cv2SfmwYdnTlzlAizpPSvRw-zsYwrwfOucgcaU5hK23Ow>
    <xme:3loSZP1h5jUj6LeswHYfFCE2Aef3vn3KVQ-l5DdBEgwzJ-JpvFkzySjP_RJFGBQd9
    NltgrcYhUIBZ_SsQQ>
X-ME-Received: <xmr:3loSZOpevaFLxVvzsy3Ba8Os6DMX59NfGMxf27tJpU-yVT_KprtzbN78flY>
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
X-ME-Proxy: <xmx:3loSZMkRg7EAJFWFjowlit9Ni0zriSwCEB8jqVZBnHwRVdLGjoDa-Q>
    <xmx:3loSZO3sWEbN5zYHE0ZH-VqPr1JgdraKeOU4NW6db__jSUNwLw1U1Q>
    <xmx:3loSZDtrHEq6I0se_BovtQYHDedOJ58lr29XAfS1xQx661HE8YF0qw>
    <xmx:31oSZIMkMoliDV2bRXAqSiSswfKs0tfsWWYBHllsvo4bR5B1kzkVMQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:10 -0400 (EDT)
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
Subject: [PATCH rcu 2/8] rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
Date:   Wed, 15 Mar 2023 16:54:48 -0700
Message-Id: <20230315235454.2993-3-boqun.feng@gmail.com>
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
2.39.2

