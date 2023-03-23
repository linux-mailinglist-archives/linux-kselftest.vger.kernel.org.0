Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E126C5E23
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCWElM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCWEkf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:40:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF62FCE8;
        Wed, 22 Mar 2023 21:40:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c19so25336384qtn.13;
        Wed, 22 Mar 2023 21:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYllBilcm/IU9PAnYZBdxmmpUrA5fngo1GjVc2mh9ak=;
        b=gK4Z85SY5rofkrqsycfLQWICb0UegdtSFH63NaVnIE1Fbrstw/+Qn9caJrMXuIqxf6
         Msa91WRovYRo+96i0TPbXAlor/gQjZ5DHwqI30W0l6c8s08u3C7iOM/qUediU3LTSZJx
         K2hnF6MqWQVNrZ8CrNi+N3enb/CYO0maR/WgcBThSYLOsknVpahI3P0BOXRWxAlLDVmW
         hijl+c2PtBFkvYmUgG+ssFIzTavxYJLWxhkNqmKJxOMru4BAwKZ/Ms/h9jsWyxhGjMtg
         A/DLFm5v1fcojqHmnFeZwEcA9XS4DQyUL+2n/iSB9fBe2UhDlgfX6F3kmTep7woQORSS
         i8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYllBilcm/IU9PAnYZBdxmmpUrA5fngo1GjVc2mh9ak=;
        b=oGGbgkoZqVpgjMvjY2rWhrYej/b5to/EtSotddqUVxOnDrmAEDC5eN+S7TQDeducrk
         +sOFQ/gTuq+pUHwUIPLjqqSWdQ8fZid4113VKv8thpmnul1Y4V0/jAU31juZu3PpjqsV
         2eWxrICqIwABlf4Y1RgbpCttjUVxF/oMoFdQ3aQEZEOg/gt8ZEMLP7OKJB0/y4AZf8FL
         qQxRHyLdqycK5wXJcET6sFskBo0j0p21IFZCErkHqVNvPG5StvKRRaRqMvkI5EzM0hQg
         EIQ7xvjQOsk1zgV1Hjghwkgu/Dzvm0iBMzgrpbbJcjO/pG1gvgTzWZkux831w9Br6UlD
         LQMA==
X-Gm-Message-State: AO0yUKXVNxlnIBCiENwVR+HMadVpl4LoNHLZBnDeNtRye1axLoYp/bNU
        gHm8s9QR1LgcydPEfcof+qBDqHPcE0k=
X-Google-Smtp-Source: AK7set9JZoOLmWjsTk9VrJC4XjbjRB8x/Y6SDKoZUWLeFUMd52uRuHrxYLwAQmPmxhSuQKjCribigg==
X-Received: by 2002:a05:622a:408:b0:3bf:d372:a5a4 with SMTP id n8-20020a05622a040800b003bfd372a5a4mr9720024qtx.50.1679546410329;
        Wed, 22 Mar 2023 21:40:10 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b00725d8d6983asm12559485qka.61.2023.03.22.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:40:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6753827C0054;
        Thu, 23 Mar 2023 00:40:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 00:40:09 -0400
X-ME-Sender: <xms:KdgbZPGf3L1509i0wf0gUmGxtqQQ-ULAJPZmemFgjtyVAFLRX22Fsw>
    <xme:KdgbZMW7xMZuIAmlDu_uodXtS6U-mKLKpEFSc2bG3cZmkHBl6bYsTEAtJfguleFMg
    hUbGTS-P2GycJQZrg>
X-ME-Received: <xmr:KdgbZBJJc0nO9xUl7l7Ha-8ioXHa1d8TEWjaOoIkKv6WE1TJ1QxTdsc7lTetjNpIWu2xL3BK3qeVyIg793CaSfE-67OidwtY0Ps>
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
X-ME-Proxy: <xmx:KdgbZNG0NxfELZ2d1h5CVamUa_Jzg-wBvfk_Li-yi-vd5YVySj2Dqg>
    <xmx:KdgbZFWHGxrsgKb7Mwt7MMh7DU70iwG50MUNFd_RJqYa7VLNSroXkw>
    <xmx:KdgbZIOZkdLHfjezdSEI932CLu3KLSacMyFMWQpDYnRPqpqWn1BULQ>
    <xmx:KdgbZKXK20GyCejFZtfjXwlhhybPrWPe-yhLr43Ml9n1SuDSSyNOdw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:40:08 -0400 (EDT)
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
Subject: [PATCH rcu v2 10/10] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Wed, 22 Mar 2023 21:39:35 -0700
Message-Id: <20230323043935.1221184-11-boqun.feng@gmail.com>
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

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index afa3e1a2f690..1970ce5f22d4 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1031,7 +1031,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.38.1

