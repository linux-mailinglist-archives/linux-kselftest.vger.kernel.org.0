Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7578A209
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 23:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjH0Vq6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjH0Vqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 17:46:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C9120
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Aug 2023 14:46:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7927f36120cso82591539f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Aug 2023 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693172789; x=1693777589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mcwO+IbeJ6pSmZ/BjxjTTVqEmFcInv2K/OfpA2NMnU=;
        b=Az9zw+ATe3PlF3OhMMTM/WWPXUwi/94KCKAGjXJD7qM6Mr6OrjUiOn1sH+8o/EsaOn
         cdsc5A9xXnfw+YW2bjmLdScXX0nuHHoHS6oiYGmQAQVOSwLzL/56I4CuEJMsWm4tQFNy
         iS5GrBPzUdWHXbboY3hnu8CQNg2WGc4D72uA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693172789; x=1693777589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mcwO+IbeJ6pSmZ/BjxjTTVqEmFcInv2K/OfpA2NMnU=;
        b=C+bEnEaawrOLQd8BrsJrVRkJXLqwIWh12aGdRH7RRsvgJSfiaOrdF6QHGScWikzDGv
         3QDt6HdnhJHtwsuYkVn/ZuluzPyCbI+kf2+hzlEqpaDrEA2skQoIqYJgpJbY9X8WNwIY
         nXWyZJZnY2GoUeBAyTj9p+V9F6afFi+UaviwWB/SZ8gJmlhGGclHHacDKWCHjMCB9ofd
         KUU6K5dMNr0qe54qLW0MT2sNoEYBU6sIFaHgcrK+qgie5l5SfiE/j97kAo5VsNAqo3Qt
         GKRYGtIAjOfXQvpWbglBM9qNtwun6ifHytWCny0a3F/DDCmF61Ihs5MQ9w1MJzaMVVLf
         G6hQ==
X-Gm-Message-State: AOJu0YyX6DzFCj16kp+fSpMM3/cv0wCRpogPf5N5AMNw3HnfcoW/b8+j
        YeFMQtKV85J0NLDVG9mbOoJRgwlzQxMTIppZrbM=
X-Google-Smtp-Source: AGHT+IE2PDpFOgkg1eIeYAvpTEAZMfuuiEANqDy0KOpHgWijDj9rwgdkP6amMl/prwYlxtPA6KcOrg==
X-Received: by 2002:a6b:f214:0:b0:790:ff32:eb3 with SMTP id q20-20020a6bf214000000b00790ff320eb3mr17389815ioh.17.1693172788924;
        Sun, 27 Aug 2023 14:46:28 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id d13-20020a02a48d000000b0042b1cd4c096sm1992515jam.74.2023.08.27.14.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 14:46:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10 1/2] torture: Avoid torture-test reboot loops
Date:   Sun, 27 Aug 2023 21:46:20 +0000
Message-ID: <20230827214622.240001-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]

Currently, the various torture tests sometimes react to an early-boot
bug by rebooting.  This is almost always counterproductive, needlessly
consuming CPU time and bloating the console log.  This commit therefore
adds the "-no-reboot" argument to qemu so that reboot requests will
cause qemu to exit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6dc2b49b85ea..bdd747dc61f2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -9,7 +9,7 @@
 #
 # Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args
 #
-# qemu-args defaults to "-enable-kvm -nographic", along with arguments
+# qemu-args defaults to "-enable-kvm -nographic -no-reboot", along with arguments
 #			specifying the number of CPUs and other options
 #			generated from the underlying CPU architecture.
 # boot_args defaults to value returned by the per_version_boot_params
@@ -132,7 +132,7 @@ then
 fi
 
 # Generate -smp qemu argument.
-qemu_args="-enable-kvm -nographic $qemu_args"
+qemu_args="-enable-kvm -nographic -no-reboot $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
-- 
2.42.0.rc1.204.g551eb34607-goog

