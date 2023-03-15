Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28B6BC1E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 00:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjCOXzj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 19:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjCOXzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 19:55:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D595D44F;
        Wed, 15 Mar 2023 16:55:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id op8so178352qvb.11;
        Wed, 15 Mar 2023 16:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kufPj583zvhnR60hiZgolUHas9LXo1nZ8SV480VMsY=;
        b=cpAJaC25Bp1ha/2OvojWG2C45bYyNV5fmWZntXE0jktagtLR351+5tbxpMQlMSgjrl
         vNdoR+XIk3odEJc31Ek4XoWIUMG0Mppp3C3gyqiBrbpfv8arYcv6eU2pXpyQytGQE43Z
         i9lYWizr/DxCEjJRmApstq8UtQxBJAAepSFpNBU7vq6XRR7k9mABzAEqN3h6Za8jOJhs
         RAJPDhC8mr8CiWFE1y7wmM0/8kEzxok4vsc81m38m2Sm1LWJRErs1TUJCOiJphw1f4E9
         QcyCo78WhvdgcZk2re6vtbOkq1gppJSKWUn5DBJI0KUSGDTufGH2NMNXDL3DfJ5zmNDQ
         9gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kufPj583zvhnR60hiZgolUHas9LXo1nZ8SV480VMsY=;
        b=uBN4PvUoC2Z35OewU/PNcwh3JbL4MIli47Hyjmw19FSD2hER//9QjTJpvffzyFMbcC
         L6xXcsaftPcgPu6WS+ZwZToykAGSa0GZ68eZbdYSyWbUCskvGEAeYGUaPBKRtLNyQcF2
         03lHfO6WTh2rZyJIJ/7YTWXAvSUbKpE9LV/8b85n6VJ3g9Ae+ptF2EwGyk3jooMVTOxl
         R8ikKCVNJF8Hpo+blZ/fzvi0GhbGtrMXfRpGwEYRMPiX4/uTc0e5BeUhEy3KKya6AE2u
         KupexRHQ6qzk12FAfFs/DJZIS1jzvsDyvnti765nxbXpPzfNEtpNdsvC/ydZ/Lk5p3vc
         rW+g==
X-Gm-Message-State: AO0yUKV3E2WIGdfxVyAEQ8rSN7LfWNY066GqfLn5sfFiha1ft/vrnMsP
        K5T6YsoWS8i/NL3qfswQnRA=
X-Google-Smtp-Source: AK7set9mREvmWhZCDaqo8/LGPzWwqupY9sAeDnU/kmW6/AgjUaoYmDc5I8jQkn1Txyg5skoYaD1bTw==
X-Received: by 2002:a05:6214:2a87:b0:5ac:d489:9917 with SMTP id jr7-20020a0562142a8700b005acd4899917mr12174031qvb.23.1678924519095;
        Wed, 15 Mar 2023 16:55:19 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s81-20020a374554000000b007417e60f621sm4740462qka.126.2023.03.15.16.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:55:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 354FC27C0054;
        Wed, 15 Mar 2023 19:55:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 Mar 2023 19:55:18 -0400
X-ME-Sender: <xms:5loSZLI_P1aPrupbdHQHF0QpDtvtGlJRDiampAuimMqHFUhzxf6G4g>
    <xme:5loSZPImNuhME3hKSpEGRIttM8oLVEvXZ83dgTpoHegvkdWPHBefoB-RfB7UcIuC8
    e4IH_9w0v2Kjo_x9g>
X-ME-Received: <xmr:5loSZDtZhEB0XgzOsPvWa33DverdqcaS4vnFrVEAvJDzHF4VWP_3TczT1FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:5loSZEZszBHXFS1vFnIyhyqWUrRPdMCfSVIgDn44kULFg_xrxJ-5VQ>
    <xmx:5loSZCbCHP5f-Q0cR-XMLwv6OJy7e6981OLocXI6OYaP2YmSOXM1aw>
    <xmx:5loSZIBqm3hm8Y6zeHgwujcjvYTZKgsrKupTKyWAEbziqOFSZqa-AQ>
    <xmx:5loSZKpfinNgZ2FMlf_sHbyGXQ4tTlAgWVcdLqJfUIgX_pq8r-UryA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:55:17 -0400 (EDT)
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
Subject: [PATCH rcu 7/8] torture: Enable clocksource watchdog with "tsc=watchdog"
Date:   Wed, 15 Mar 2023 16:54:53 -0700
Message-Id: <20230315235454.2993-8-boqun.feng@gmail.com>
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

This commit tests the "tsc=watchdog" kernel boot parameter when running
the clocksourcewd torture tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 130d0de4c3bb..5a2ae2264403 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -497,16 +497,16 @@ fi
 
 if test "$do_clocksourcewd" = "yes"
 then
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...
 	if test "$do_rcutorture" != "yes"
 	then
-		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 		torture_set "clocksourcewd-3" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --trust-make
 	fi
 fi
-- 
2.39.2

