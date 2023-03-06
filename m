Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D36ACEEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCFULP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCFULD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C04B83A
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678133370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ/fbLiMTxYvcy4Xv+isuWXHLsrugKjziame8MLcKpQ=;
        b=KX1urgzxFrUEwyTJjbWqDRa+f7t3AYJfbrLIdvTLeoANczZ+yHsy0r1MK0tvckZsEOLBTH
        KH2fZTeLA2WxbgfLIYn+ojzDNUTD3Cxggl1m3TUxxP+f7Ar25/dW1Qs4DvL/uAL114DwuO
        qQrHwtykS29l6ghvy/WqlkOImzXGVCA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-5KLDa69LNIygZSqWcf9rbw-1; Mon, 06 Mar 2023 15:09:28 -0500
X-MC-Unique: 5KLDa69LNIygZSqWcf9rbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DEC93C20EE5;
        Mon,  6 Mar 2023 20:09:27 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABB940B40E4;
        Mon,  6 Mar 2023 20:09:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] cgroup/cpuset: Minor updates to test_cpuset_prs.sh
Date:   Mon,  6 Mar 2023 15:08:49 -0500
Message-Id: <20230306200849.376804-6-longman@redhat.com>
In-Reply-To: <20230306200849.376804-1-longman@redhat.com>
References: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

