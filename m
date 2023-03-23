Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48586C5E1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 05:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCWEkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 00:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCWEkW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 00:40:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB42FCDD;
        Wed, 22 Mar 2023 21:40:03 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a5so3718265qto.6;
        Wed, 22 Mar 2023 21:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGpQAXZVjMhC7kP9GPuObfvBShBYQkr0qGROK59RoVs=;
        b=jGfdDGr6o66P0ZTe/setYhulypl773heym5C69xfz8sTi/mKBPui6Cy5CZsFlNN3ww
         yLuGjG8eJuW/EJRJAw/EAuGsl0oYMA/b6cdDAPb83zxPyCeBPWWB7FwCAqQNh+QeNglg
         tt9EU/WWonKA9zySZAFeLOF8Q7aFl91H7y3BncIXxhGI4I90WrDKeLYN//98sx2encGb
         B45hYw+y39M2B4K5RYfn+12UMMAgZ7p92jqCcEYgeS0Ssld7ECh685OMlKuh4A5yJOst
         MOyfKgL/GrmlFkM6p1yJqSjg3FgUWBS0/6r6Kj/urRhC/AojGVrLg9JqBcm1SjqN7RXv
         57Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGpQAXZVjMhC7kP9GPuObfvBShBYQkr0qGROK59RoVs=;
        b=vbGxK2cdE+P4ZqAvRQgd0QCg0gSRsUtfireq/as8LSmRZcyX/2kKrCMDPphjxZcrSB
         rlGmCBeOU4HAuZM9KA5ydbOOQSZe/fNFlbEPRHhaZagi6FbBhA/7lT1iQf6AI8Sc1fBI
         7JBk379VVRrFxNnunCobiAo9sOZ+QZXNf0G2om3Ou+GBt1tgFmepqvI05yaiqNe78DUI
         Ho4caprrCOZvdatrMG+tOoiZ/EdXAU7j82ILMPQOzoo8kPZOFVtFzAgsCxoi2bDc4H7x
         44FVTsQTeW3dIlGUapFRB5a9wLVgjxoZ2SERm1C/0z1rbb36Fu5jskK9NTU1miUAjSVw
         e6Xg==
X-Gm-Message-State: AO0yUKW19abzCVmk1iQijJYtQYTaSenbHVuFZfZkBZLIkcd0i2CUa7Cp
        o2CbUZsNKefEYAi9Kfojnqg=
X-Google-Smtp-Source: AK7set+TEfFRcdSv3QphXR44M1CcWSsupF9rJ0eyjJOFYrCKfAhrMZ9aVnWwjAXbjzpyla01zF5AZg==
X-Received: by 2002:a05:622a:1a16:b0:3b9:c889:ec24 with SMTP id f22-20020a05622a1a1600b003b9c889ec24mr10400507qtb.12.1679546402682;
        Wed, 22 Mar 2023 21:40:02 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w9-20020ac843c9000000b003d8f78b82besm3763003qtn.70.2023.03.22.21.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:40:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C0F4627C0054;
        Thu, 23 Mar 2023 00:40:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Mar 2023 00:40:01 -0400
X-ME-Sender: <xms:IdgbZKiGmEP_0tgLfJ1ztwETcfvLEQ1krQBaIaXgEIQTjSY283Wqgg>
    <xme:IdgbZLBhwutYy4gv1fGT7G9F0N_GkynpjPtxQUgAXVIsgPW7KJXfvCVL_4N29PF84
    3aeNxfE10tnm1yfbg>
X-ME-Received: <xmr:IdgbZCEQKKsqYvvUY7wfXzphMkQS70rHFN-ddbr_OfG3i5fnvxmqxAhYw8w6z_tgxlxsK02iooBi9hOJFyBG8PkATfqo4LlHsvo>
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
X-ME-Proxy: <xmx:IdgbZDTw259jRn4qnZzc-pRCJiUUwEzOKLEGIq80EfWIqSpAyJQb5Q>
    <xmx:IdgbZHzCp27vn6M_6F030tbXYi-kCgiYq9U6qg02iDw-0kq2szahkQ>
    <xmx:IdgbZB7TXylsxL9rgJ_7MM7ASqDOmV5MeSKHLA7X1MhK6c44sOQPeg>
    <xmx:IdgbZPhDNmTubeGhYMMvX0jCptWYZbK73A6626Vk2TU511S-miwd2w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 00:40:00 -0400 (EDT)
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
Subject: [PATCH rcu v2 07/10] torture: Enable clocksource watchdog with "tsc=watchdog"
Date:   Wed, 22 Mar 2023 21:39:32 -0700
Message-Id: <20230323043935.1221184-8-boqun.feng@gmail.com>
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
2.38.1

