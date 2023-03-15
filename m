Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4C6BBBE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCOSTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjCOSTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2517E7B8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r16so17191537qtx.9
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSsc7hzk/lL5hF/xvXJ1JSJwgr8pnxi74tQwwkfBkI4=;
        b=PqxQOwNl8FLQlZ0wb/ZC52nN9ZdX6CCNAYQcZPAXaYrpYU0hoWExe1OhVcwOi1H5n/
         tohphBPoVr0QvcXjNSUxMn9KZ7gpbKM+U6MnHgj/YBjDbP7VpaVzoTMaQ6DzfIFXxWKt
         s150z+ZCa5wg6JrUs4FzWZglQlefFPSLnrV6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSsc7hzk/lL5hF/xvXJ1JSJwgr8pnxi74tQwwkfBkI4=;
        b=8BFnGu64EE33OltTx59dwz/Rohxh8YoSU2FxLkzOwb/zdM+2Iq2gKu3kNqManVAU9G
         Y8tQf+852kflFXMWZfPXWNkOg3ndb7HJehYmjiIVVrd3eA6L1f9WPzn7q5C0E+7xtBIh
         3wlczEzUI6ESgV3RMcXcF3NZlpUaw/ZVUuxN79e2WPROUeVXCY1QtkbFRU+A69TodNpX
         ryESz7C72d8WP8x6CQPwTa3u/QmVE+8LhmU9pNRJCm/0kriXhKf93W3zrbZnuV63RJmS
         pokoMz+ASStFsyVgmWUKq97YfQLcYh3ZpqSQ+ookgPSnEkp+nFqpZvw42XtTzZKnOsr2
         C/zg==
X-Gm-Message-State: AO0yUKUslSEWXI18sCJjPqkDhoxau/rjY62L5EGnGyKWsrR9t57CnlfG
        o8WuRs3TXEQxyovOZTRW5V3e1g==
X-Google-Smtp-Source: AK7set8JXw73dwtTVWf2o1rrh79neNXmuiIN9SfzBb2Ehts755m8MFms900eo19kDXSQnwjRKYHqkg==
X-Received: by 2002:ac8:574d:0:b0:3c0:3b79:9fb0 with SMTP id 13-20020ac8574d000000b003c03b799fb0mr1372546qtx.47.1678904374217;
        Wed, 15 Mar 2023 11:19:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] torture: Enable clocksource watchdog with "tsc=watchdog"
Date:   Wed, 15 Mar 2023 18:18:56 +0000
Message-Id: <20230315181902.4177819-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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
2.40.0.rc1.284.g88254d51c5-goog

