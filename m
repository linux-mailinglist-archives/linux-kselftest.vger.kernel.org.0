Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD46C5E1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCWEkl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWEkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:40:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796630B29;
        Wed, 22 Mar 2023 21:40:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x1so25328035qtr.7;
        Wed, 22 Mar 2023 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2eKmVKjQslDGUSFDeB71iLgQhY5mnH9+mfjAkHwLddk=;
        b=cQdr4XV2Eq7TBZvTX97/MtD3GkBTe7HSo850bFHa4RaMkHLplHqXHJcAIjfTVTiZ1g
         Le3232ttFxE++p1kpQK32Wzz7Zt6o5q3+OuoH9ieu8zLZwcQea074CxdkMiZq0WgP8Vr
         1fj396ReY5xeEoQfWYPZG6tA6F7pSUzETAQ7vcCg3FM8pJwj6rGCxvAW4le2UlvwAlJB
         LS039M+P/Do0luclFqa2yvYcFVrIxQ2pPjJ1/lBE2ZDbEf2meLEUqHU7yzSuzs9DOCE4
         jVsXu4D2/2iylKddPL1K9YQIu9u2oHXbAQCN0d0WIZYOmVHjawFW3/D25UZe1oO+Kc8h
         z35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eKmVKjQslDGUSFDeB71iLgQhY5mnH9+mfjAkHwLddk=;
        b=1RuOfcYG9EJcpg1bphdNjOPgHSF1ELV1WH7svdRGBuyfRoIA1nIRq6Y2tA7xgRGeIr
         njLL28uabfwqCUANsY5wmsJo3FZ+R4DOaKGIUDrmeBv6vm4YdAdkYI8LUOhE9Fc6Oq1R
         N3ci70lAevv2sKxacIEIZl6BJnR8bB3cBlioF4ujGTzTzXfgFeaKVcAW4zv3YKGgouQR
         T+ZhQt+VWjNTMX4ls0fwAqv+yHuOlmGbDYIweetoAUtVVIZD2dIdQ8UwoZSwg0jUWG6L
         V1/Naa0IIuth7upv+BVJisN+A4nnH0R0tMcV/Latb8rEyTMx5RQqtMpBYGlit9ZZcDFo
         B2Qg==
X-Gm-Message-State: AO0yUKXOPGuONlI+9jbF7WmHrOoqGESGxkYYaejkUStCc2obVry88mgG
        GOcVWAT7Afl/fIebKCJcuRQ=
X-Google-Smtp-Source: AK7set+nvPp9HapX8hErMkucpMWsU/jrsPLLDWvqTyPNIdQx1riUEseEqkVxprkJoe+qfhdzbRxv0g==
X-Received: by 2002:ac8:58cb:0:b0:3e3:824f:45f1 with SMTP id u11-20020ac858cb000000b003e3824f45f1mr6962454qta.27.1679546405211;
        Wed, 22 Mar 2023 21:40:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k3-20020ac84743000000b003e07c09cabcsm7230814qtp.4.2023.03.22.21.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:40:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 62E1827C0054;
        Thu, 23 Mar 2023 00:40:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 00:40:04 -0400
X-ME-Sender: <xms:JNgbZKCjR_xGWjRHCgJz4337wycLOKjbDuDYt1SvcnNaquKJsU3F7g>
    <xme:JNgbZEiH-KbOLXyi7l_tVnS-Kuq-V1E0Syw10OZsar9422DiCsLeDusZfBhn6OjZW
    x6K2IgpeKUUeU-ibA>
X-ME-Received: <xmr:JNgbZNmhHH9bnFklcTUJm42rHarzZRxj4inR-5IXu2Oys8UqYX1-huh4h3iJ8Xg89F6VLN-4Bpi8jiEwr4mIgogQ2agFkM7PYl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JNgbZIxLiX80v9txKD3clkUyb8tu5heopelIW_nX1jxGpN5GLTJNLA>
    <xmx:JNgbZPS2qPBf5Tb3aPvUF8dwa1W4xb5HCMpk0fqgqYr94knfJLA4MA>
    <xmx:JNgbZDa6C840NMlXFqtKqiaVJgjEMfOAiGTdLBXT2I9lkHqeVy2xgw>
    <xmx:JNgbZLrz3vDH0VklXv6965WyF5nga8K63Q5-EazFjQJMWvxoVy3obg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:40:03 -0400 (EDT)
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
Subject: [PATCH rcu v2 08/10] rcutorture: Create nocb kthreads only when testing rcu in CONFIG_RCU_NOCB_CPU=y kernels
Date:   Wed, 22 Mar 2023 21:39:33 -0700
Message-Id: <20230323043935.1221184-9-boqun.feng@gmail.com>
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
[ boqun: Fix checkpatch warning ]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c0b2fd687bbb..e046d2c6fe10 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3525,6 +3525,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+				    !IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+			 cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.38.1

