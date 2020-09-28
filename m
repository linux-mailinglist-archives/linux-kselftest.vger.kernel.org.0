Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1889627B833
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 01:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgI1XbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 19:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgI1XbH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D6C23A60;
        Mon, 28 Sep 2020 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335867;
        bh=9WDYSIgcM70ZSt1ogPogXsa7pZ4ZwMTDe/YOAI/QvvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsLNPIIuOtrZsZn0wLFPkQ2L1yhMM5Kt5hm1+rmq5oV0nxYTdPcr42BXPSyiGeR77
         Hqj1d9+Rh9gGp4uraNtqZc0W4mPdtoyNq8mkwbSyIT2O8E3XuBMomQdLyP9vLRdeLz
         hTmeQzMa/qbtCYjMacstfNiQa6Eu1ueZr7PFjITM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH tip/core/rcu 12/15] rcutorture: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:59 -0700
Message-Id: <20200928233102.24265-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t            | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u            | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TINY01            | 1 -
 tools/testing/selftests/rcutorture/doc/TINY_RCU.txt              | 5 ++---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt      | 1 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h | 1 -
 6 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
index 6c78022..553cf65 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-#CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
index c15ada8..99563da 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index 6db705e..9b22b8e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -10,4 +10,3 @@ CONFIG_RCU_TRACE=n
 #CHECK#CONFIG_RCU_STALL_COMMON=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
index a75b169..d30cedf 100644
--- a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
+++ b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
@@ -3,11 +3,10 @@ This document gives a brief rationale for the TINY_RCU test cases.
 
 Kconfig Parameters:
 
-CONFIG_DEBUG_LOCK_ALLOC -- Do all three and none of the three.
-CONFIG_PREEMPT_COUNT
+CONFIG_DEBUG_LOCK_ALLOC -- Do both and none of the two.
 CONFIG_RCU_TRACE
 
-The theory here is that randconfig testing will hit the other six possible
+The theory here is that randconfig testing will hit the other two possible
 combinations of these parameters.
 
 
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index 1b96d68..cfdd48f 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -43,7 +43,6 @@ CONFIG_64BIT
 
 	Used only to check CONFIG_RCU_FANOUT value, inspection suffices.
 
-CONFIG_PREEMPT_COUNT
 CONFIG_PREEMPT_RCU
 
 	Redundant with CONFIG_PREEMPT, ignore.
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
index 283d710..d0d485d 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
@@ -8,7 +8,6 @@
 #undef CONFIG_HOTPLUG_CPU
 #undef CONFIG_MODULES
 #undef CONFIG_NO_HZ_FULL_SYSIDLE
-#undef CONFIG_PREEMPT_COUNT
 #undef CONFIG_PREEMPT_RCU
 #undef CONFIG_PROVE_RCU
 #undef CONFIG_RCU_NOCB_CPU
-- 
2.9.5

