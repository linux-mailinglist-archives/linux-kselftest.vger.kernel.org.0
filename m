Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A263A6C5E21
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCWElL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCWEkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:40:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B559305FA;
        Wed, 22 Mar 2023 21:40:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t19so11256294qta.12;
        Wed, 22 Mar 2023 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BMyeLr4CYvtZBRAjiGMJ5JJr/oAapqR06wdAlXxInGo=;
        b=m+8buwNx8vPQYZKztHNzM1Q+MsWiGu0ZM9zXx/ChzhwD/B8q4NwOsLOTrOzqaAuexm
         Cf9jEpqHn/PWOVGiUgJUEiTlrhRpIYZJqT2pQ7Usuan8Dp0xstoKlzPx2+aFUMg1mnnW
         NT4tkjxRGMGfepRgV/39HuCecR+zj6E8VN4T/q1ypTlnTaENmJ8xp+SjBtQIyeNAE5Rx
         VFrsuF/cJfz6e7gTf687tY/moHEVOsRQlBtevcbOjZIT99NWXch/U+F1SzUJXS04vbuf
         +1U6QwxPP723W0kwJD2SAJFvzvv5fZLME17ulRl167GdTolJ1ri/7IO4OXf7NxKbJBI2
         W3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMyeLr4CYvtZBRAjiGMJ5JJr/oAapqR06wdAlXxInGo=;
        b=SGaJN/cZ2m2MIW2pDxUax4OM0eKWdkOU/YwD99Zml8D+UOhZszuote6iF2E6myA7ap
         5cg3ho1Gp0u7ZjV4nBQTPWwJ7de+OGWeeHA1LGYMAUcTQRRzQQupNx9mB1NwQKzxwQJi
         U6eajQ3z0CdnOEOCsau2Z1bHGUR6K/Qmifsi11TdnPyFqI1ajpV/SDo15EKQcQZXatOF
         rT9+TqaPgXXlBAEncua77Oub/ODiwmE689rElSYaqIktJSbq7uLuoSZESedGruuzZCoZ
         OR7Uim/dAEX2CZR7SbM45ASqzJyBdthxGavMVgGI1f6MZTCL7JcIPCQx79t7PJhDZf57
         vdsw==
X-Gm-Message-State: AO0yUKVWEUFuhdM+1yge/dZdO78BKlRgetYpuFYo8SnAFxEYWrql3jBv
        tZ0yflyD5W/m7Km7jW3OiTs=
X-Google-Smtp-Source: AK7set8HWxjxvGNXiX1DDamF1ASMj5Q4CMF5o8ush0fHZqJ95qH4TV+3Rl/oLP/PEcQs398tSlTbxA==
X-Received: by 2002:a05:622a:1745:b0:3bf:d193:1b0 with SMTP id l5-20020a05622a174500b003bfd19301b0mr9437481qtk.48.1679546407964;
        Wed, 22 Mar 2023 21:40:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q21-20020ac87355000000b003e387a2fbdfsm3245056qtp.0.2023.03.22.21.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:40:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 16BC627C0054;
        Thu, 23 Mar 2023 00:40:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 00:40:07 -0400
X-ME-Sender: <xms:JtgbZEM0zbxwaogLBmVyOUII81Qk0KmVkF0yGU1vNYWaehiKwGELhg>
    <xme:JtgbZK-ODVB3IoA-exaNjRURaUx304wUbN7ediDw-gOmYJXrigsGbLOfC8VFEgoY7
    kJFeNm1J1kQ1xr4dg>
X-ME-Received: <xmr:JtgbZLRSq4ZnlKfgSRAJ9VRlplT5oNV8kMQJhL0HoA3eHM7T1oP1Wyay1bHYxdVa5gzkKKuEhY8HT1OXKOIUkLjIbfCspJbH07w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JtgbZMtaE94CASvS3p2ORGZQL6hSMmXOmLqo_STv44Tmo_EGgfDoTQ>
    <xmx:JtgbZMfON-tQWKrC8xV5RLMdE6_HkRVhUiQkq0vjNZiv_1Hi6IXg9g>
    <xmx:JtgbZA1x5Pz-p8B4TCu2i1WUrSngOz5NA50BA5Aue66aqtyynFoLAg>
    <xmx:J9gbZA-55UEKi2EdQ9x_gd2Z1DSTbFg466UitmMOHnYUtBG2Tye2rw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:40:06 -0400 (EDT)
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
        kernel test robot <yujie.liu@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH rcu v2 09/10] rcuscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Wed, 22 Mar 2023 21:39:34 -0700
Message-Id: <20230323043935.1221184-10-boqun.feng@gmail.com>
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

The rcu_scale_shutdown() and kfree_scale_shutdown() kthreads/functions
use wait_event() to wait for the rcuscale test to complete.  However,
each updater thread in such a test waits for at least 100 grace periods.
If each grace period takes more than 1.2 seconds, which is long, but
not insanely so, this can trigger the hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcuscale.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..4120f94030c3 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -631,8 +631,7 @@ static int compute_real(int n)
 static int
 rcu_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_scale_cleanup();
 	kernel_power_off();
@@ -771,8 +770,8 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+	wait_event_idle(shutdown_wq,
+			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
-- 
2.38.1

