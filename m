Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A76288F5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 19:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgJIRBa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 13:01:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59164 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389640AbgJIRB1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:27 -0400
Date:   Fri, 09 Oct 2020 17:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qa5BYAQ/xKA+kV57+AUnTiO/P44u/O6wIIY1Yvzzttg=;
        b=RY0DZp/jR4qFU2CsQ3SkU4CeCA7L9+U7TauNgFCu5/dc34SvxPKnF55BGnw0yU17c/mbca
        HbwtdhU0yeCOXM8x1Rdhm5CrfgapCIs1tlxPnA72pCAR9PAIxoBvnghTmQfQRlzq6M1vCU
        vAN1T4k+1JJrx6B4v4Q+QUvhOmm4FnC1PqbH2zppO4DkjDvHCOqgNDNtHHt2P4CTEb2mCg
        GrZAz8qP+O6IBdlMzlBQMm2PnXP7/rCKC0C8MdiLruE91jYXxs1n+p1ZNJ527ZgkN617Zk
        6PehEdCy9TAGpkZDOo48rvdZD/oaI4pab0YPq2og6/J36DaNtuPnQggoHG1cpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qa5BYAQ/xKA+kV57+AUnTiO/P44u/O6wIIY1Yvzzttg=;
        b=D48HoQUB7Ht5aqnr8tshiG4W7V5hgq04Ov0vSApG90sKUEk/Cwlg8RLyXH5iYWtMggGTNH
        N9AtH8SSYts8G1AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288348.7002.14672482612676279557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     27405ee98aee7a25bbca59b0aba04f33b6acc561
Gitweb:        https://git.kernel.org/tip/27405ee98aee7a25bbca59b0aba04f33b6acc561
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:37:36 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 01 Oct 2020 09:05:16 -07:00

rcutorture: Cleanup PREEMPT_COUNT leftovers

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
