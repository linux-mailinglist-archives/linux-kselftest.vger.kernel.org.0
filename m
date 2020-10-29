Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7229F232
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgJ2Qv2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgJ2Quy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B83C0613D6;
        Thu, 29 Oct 2020 09:50:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so3842879ljo.6;
        Thu, 29 Oct 2020 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTSH9iN3g7zwVkykMJEO2qxMaaVer3zAONHeDrkDF9o=;
        b=pVMEvVDVGNOR4zaH1cxyUr6wqrxPbEXyQgksWXyZxaaNL7pxUKa4NqX5tKRVPY9TgE
         Das12GHNHgLtA4Smtsx+dbpbz2XGQke8KTWluMx/AfVvBq1M41dE+HvCfKVunmhSMJNy
         1B3bHbh3UFWs6tPcgq/dQ0kUknjHVjyAePKBcKme4ZYBLmZ1T8pqBoDgcfmR6HEpK3yR
         dD+8SuviBECY5tfwT1rG4TfwGsGnnc51oFj9BINg+qu0VcK16uErg46p1bujmapcUqq4
         fbMQa09EndZJkI6CrcXGf3/ch1m/3T8iaZKstOWklMOeL/yeoJtx03scLW5ZZwezHpmH
         LOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTSH9iN3g7zwVkykMJEO2qxMaaVer3zAONHeDrkDF9o=;
        b=btg2QRMlXkQSDPfPZmFN+uzWKlZQwSlOYwojGQRUfRvXaVnlaKzoD3iRaQ9ehbjQMh
         YFgUzfk3r6NAbc3B5kC0KihZWwp1M6HhKeZpSYirY3Dbqgww69L2MrJ1PGG21sSYNSjx
         ODKPyy1kPXhqPAOJRU2x/rnSe0GLWzDPNnj32MfadjFAs6PJVLKLwedO60An5cGEtHGK
         Mqzk7bpOvPJM8EYSYra60MQ4yEkYpyD8lGxiOthHfLFZIwpRMmtl4at0tfb/ycsNAgIt
         vbNa6Y9kwtmaaHMsitMeMU9BFx7cIPy5bGOT4FYjWE/JULN7uh3rFutTh6/ZeSxNu8Wm
         /MyQ==
X-Gm-Message-State: AOAM533Uk/A2uHaZ0jLBoJm7GGjgL2wNcfGJ4RG3sc+sQAOF7zUMGmBF
        lQ+grAEIpUYdY8I2WihwOp0Cr4Zs0KXcgQ==
X-Google-Smtp-Source: ABdhPJyyzSuC4MZIMSc8wTlfMTiJrXKtTvtBvQP871XlHtTlB6ewBfcnvfFT6Ej2XfLZnH+ZUhJU6g==
X-Received: by 2002:a05:651c:30c:: with SMTP id a12mr1318723ljp.230.1603990252554;
        Thu, 29 Oct 2020 09:50:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 13/16] rcutorture: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:16 +0100
Message-Id: <20201029165019.14218-13-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t        | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u        | 1 -
 tools/testing/selftests/rcutorture/configs/rcu/TINY01        | 1 -
 tools/testing/selftests/rcutorture/doc/TINY_RCU.txt          | 5 ++---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt  | 1 -
 .../selftests/rcutorture/formal/srcu-cbmc/src/config.h       | 1 -
 6 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
index 6c78022c8cd8..553cf6534e67 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-#CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
index c15ada821e45..99563da21732 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY01 b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
index 6db705e55487..9b22b8e768d5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -10,4 +10,3 @@ CONFIG_RCU_TRACE=n
 #CHECK#CONFIG_RCU_STALL_COMMON=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
index a75b16991a92..d30cedf07826 100644
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
index 1b96d68473b8..cfdd48f689de 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -43,7 +43,6 @@ CONFIG_64BIT
 
 	Used only to check CONFIG_RCU_FANOUT value, inspection suffices.
 
-CONFIG_PREEMPT_COUNT
 CONFIG_PREEMPT_RCU
 
 	Redundant with CONFIG_PREEMPT, ignore.
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
index 283d7103334f..d0d485d48649 100644
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
2.20.1

