Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416C4BF7CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiBVMIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 07:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBVMIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 07:08:04 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF509E57F;
        Tue, 22 Feb 2022 04:07:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5aebb8.dynamic.kabel-deutschland.de [95.90.235.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2A94A61E64846;
        Tue, 22 Feb 2022 13:07:37 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] torture: Make thread detection more robust by using lspcu
Date:   Tue, 22 Feb 2022 13:07:17 +0100
Message-Id: <20220222120718.17141-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222120718.17141-1-pmenzel@molgen.mpg.de>
References: <20220222120718.17141-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For consecutive numbers *lscpu* collapses the output and just shows the
range with start and end. The processors are numbered that way on POWER8.

    $ sudo ppc64_cpu --smt=8
    $ lscpu | grep '^NUMA node'
    NUMA node(s):                    2
    NUMA node0 CPU(s):               0-79
    NUMA node8 CPU(s):               80-159

This causes the heuristic to detect the number threads per core, looking
for the number after the first comma, to fail, and QEMU aborts because of
invalid arguments.

    $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
    $

(Before the last patch, the whole line was returned.)

    $ lscpu | grep '^NUMA node0' | sed -e 's/^[^,-]*(,|\-)\([0-9]*\),.*$/\1/'
    NUMA node0 CPU(s):               0-79

*lscpu* shows the number of threads per core, so use that value directly.

    $ sudo ppc64_cpu --smt=8
    $ lscpu | grep 'Thread(s) per core'
    Thread(s) per core:              8
    $ sudo ppc64_cpu --smt=off
    $ lscpu | grep 'Thread(s) per core'
    Thread(s) per core:              1

Note, the replaced heuristic is also incorrect for that case, where the
threads per core are disabled.

    $ lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'
    8

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 5cff520955e6..66d0414d8e4b 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -301,7 +301,7 @@ specify_qemu_cpus () {
 			echo $2 -smp $3
 			;;
 		qemu-system-ppc64)
-			nt="`lscpu | sed -n -e '/^NUMA node0/s/^[^,]*,\([0-9]*\),.*$/\1/p'`"
+			nt="`lscpu | sed -n 's/^Thread(s) per core:\s*//p'`"
 			echo $2 -smp cores=`expr \( $3 + $nt - 1 \) / $nt`,threads=$nt
 			;;
 		esac
-- 
2.35.1

