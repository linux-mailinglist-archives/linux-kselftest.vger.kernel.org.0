Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C148E6BECB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 16:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCQPQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCQPQl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 11:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074831BD0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679066135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ/fbLiMTxYvcy4Xv+isuWXHLsrugKjziame8MLcKpQ=;
        b=EE30zdnXa4imFeCY54+AIDEPKPIha2s7E5PtIY15p+72PIByifqRo3MABdXSU24TnYaUQn
        TalxLnA3JDX/f0jtecWlpS4lyu2wDjuod1C/DsvuuDYH2wgTv1q2vH1ZQLhImxe6PFfHQa
        COR871feI6Bp+G77WCymWdt20CfL2UQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-60e1ciYHONuf3FhLRFxLKQ-1; Fri, 17 Mar 2023 11:15:32 -0400
X-MC-Unique: 60e1ciYHONuf3FhLRFxLKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9816C29AA2DD;
        Fri, 17 Mar 2023 15:15:31 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20780492B00;
        Fri, 17 Mar 2023 15:15:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] cgroup/cpuset: Minor updates to test_cpuset_prs.sh
Date:   Fri, 17 Mar 2023 11:15:08 -0400
Message-Id: <20230317151508.1225282-5-longman@redhat.com>
In-Reply-To: <20230317151508.1225282-1-longman@redhat.com>
References: <20230317151508.1225282-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch makes the following minor updates to the cpuset partition
testing script test_cpuset_prs.sh.

 - Remove online_cpus function call as it will be called anyway on exit
   in cleanup.
 - Make the enabling of sched/verbose debugfs flag conditional on the
   "-v" verbose option and set DELAY_FACTOR to 2 in this case as cpuset
   partition operations are likely to be slowed down by enabling that.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 75c100de90ff..2b5215cc599f 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -15,13 +15,6 @@ skip_test() {
 
 [[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
 
-# Set sched verbose flag, if available
-if [[ -d /sys/kernel/debug/sched ]]
-then
-	# Used to restore the original setting during cleanup
-	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
-	echo Y > /sys/kernel/debug/sched/verbose
-fi
 
 # Get wait_inotify location
 WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
@@ -37,10 +30,14 @@ CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
 PROG=$1
 VERBOSE=
 DELAY_FACTOR=1
+SCHED_DEBUG=
 while [[ "$1" = -* ]]
 do
 	case "$1" in
 		-v) VERBOSE=1
+		    # Enable sched/verbose can slow thing down
+		    [[ $DELAY_FACTOR -eq 1 ]] &&
+			DELAY_FACTOR=2
 		    break
 		    ;;
 		-d) DELAY_FACTOR=$2
@@ -54,6 +51,14 @@ do
 	shift
 done
 
+# Set sched verbose flag if available when "-v" option is specified
+if [[ -n "$VERBOSE" && -d /sys/kernel/debug/sched ]]
+then
+	# Used to restore the original setting during cleanup
+	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
+	echo Y > /sys/kernel/debug/sched/verbose
+fi
+
 cd $CGROUP2
 echo +cpuset > cgroup.subtree_control
 [[ -d test ]] || mkdir test
@@ -65,7 +70,8 @@ cleanup()
 	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
 	cd ..
 	rmdir test > /dev/null 2>&1
-	echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
+	[[ -n "$SCHED_DEBUG" ]] &&
+		echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
 }
 
 # Pause in ms
@@ -571,7 +577,6 @@ run_state_test()
 			echo "Test $TEST[$I] failed result check!"
 			eval echo \"\${$TEST[$I]}\"
 			dump_states
-			online_cpus
 			exit 1
 		}
 
@@ -582,7 +587,6 @@ run_state_test()
 				eval echo \"\${$TEST[$I]}\"
 				echo
 				dump_states
-				online_cpus
 				exit 1
 			}
 		}
@@ -594,7 +598,6 @@ run_state_test()
 				eval echo \"\${$TEST[$I]}\"
 				echo
 				dump_states
-				online_cpus
 				exit 1
 			}
 		}
-- 
2.31.1

