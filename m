Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C16645F2C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLGQn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 11:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLGQn5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 11:43:57 -0500
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D35E9D2
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 08:43:56 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id r26-20020a2e80da000000b00279e2a0f0e1so4553574ljg.11
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3UNgITk2mCHM+aO+s0l1dU1wLZipt6ouG5VCup5ogI=;
        b=Jz0dxAj0ez7bZFI3NVyATAAqCsijUj/bzAPgNXTFygZTZgQ7y23Uu5QmZcfivd00bR
         FmMEyREyeUPS7o3HvpZZNDrw54Yx1zKt/muSqK8Sr9e8cZTsd7f6bZQfVAaC02fU0qiA
         0qw7J4effoSo8816N1fDYWHLcMSFieumfGy3ZND2thOacnib8n+YHGL1sjtx6EpfGfEr
         QTcIeXFfHOcBZHwtWestLk7LrC1y/fORCxalyHJDqBzrldLw6w/iMyiFCikm4kqhtT9I
         rOWvSSGCgPzneb18q9SmmAWALdrGRojrscCR+hddi8noVtF232wCoXfsvNc3KvOrCHDd
         b6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3UNgITk2mCHM+aO+s0l1dU1wLZipt6ouG5VCup5ogI=;
        b=054ztEUIwKTdZ9QwnPzTzvOWXq4NhCGI4QLsnUnX0EBzUbtzWTMQIJigZzaXfXmxDE
         8abdhN4We69vXAnHWNdZcb/+PsU4d6CBhBvHua5GQEQfdWDrr9vQHU5ul2LbcPC6zf/+
         3Qe0cJlCs+AdJ4Vmab+1v80JolXNP954ADaZKFowl1h2qF6bcwdQlOEDYTNduwq92VJ9
         cTiLS0JkpUcw9DUVasfQ93OKypCKAbKJYPfTYJQPWdLvlaZ6Znq6f7cGQI9ZWNo1B7bk
         E+j4XSCH//H+v78AwKsRRQ7VV938fh28s5Wbi8ZkVDmToQ1ytbHgQ9ZdmFRfPzTaN7v1
         P2IA==
X-Gm-Message-State: ANoB5pn5wm8v1tix2q9svgN47+TKZg4by5fdNfRxS/bHHEDhIMDSccGv
        SDosyVMlv0dAr3rR7S+Cf4Vd/FlowdnbkAkY
X-Google-Smtp-Source: AA0mqf6hwzNXlz8mWqisoOstIk8lU431OMAtI0FDtAlpn3oNcMNpSObbMyM4FovQgMHkq/Xk99Z3UP2pVjMWxsbu
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:3d6d:f78e:bc73:df])
 (user=mclapinski job=sendgmr) by 2002:a05:651c:12ca:b0:277:a9d:9355 with SMTP
 id 10-20020a05651c12ca00b002770a9d9355mr21109826lje.102.1670431434519; Wed,
 07 Dec 2022 08:43:54 -0800 (PST)
Date:   Wed,  7 Dec 2022 17:43:37 +0100
In-Reply-To: <20221207164338.1535591-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20221207164338.1535591-1-mclapinski@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207164338.1535591-2-mclapinski@google.com>
Subject: [PATCH 1/2] sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
From:   Michal Clapinski <mclapinski@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provide a method to query previously issued registrations.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 include/uapi/linux/membarrier.h |  4 ++++
 kernel/sched/membarrier.c       | 39 ++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 737605897f36..5f3ad6d5be6f 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -137,6 +137,9 @@
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
+ * @MEMBARRIER_CMD_GET_REGISTRATIONS:
+ *                          Returns a bitmask of previously issued
+ *                          registration commands.
  *
  * Command to be passed to the membarrier system call. The commands need to
  * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
@@ -153,6 +156,7 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
+	MEMBARRIER_CMD_GET_REGISTRATIONS			= (1 << 9),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 0c5be7ebb1dc..2ad881d07752 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -159,7 +159,8 @@
 	| MEMBARRIER_CMD_PRIVATE_EXPEDITED				\
 	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK		\
-	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
+	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK			\
+	| MEMBARRIER_CMD_GET_REGISTRATIONS)
 
 static void ipi_mb(void *info)
 {
@@ -540,6 +541,40 @@ static int membarrier_register_private_expedited(int flags)
 	return 0;
 }
 
+static int membarrier_get_registrations(void)
+{
+	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
+	int registrations_mask = 0, membarrier_state, i;
+	static const int states[] = {
+		MEMBARRIER_STATE_GLOBAL_EXPEDITED |
+			MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
+	};
+	static const int registration_cmds[] = {
+		MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
+	};
+	BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
+
+	membarrier_state = atomic_read(&mm->membarrier_state);
+	for (i = 0; i < ARRAY_SIZE(states); ++i) {
+		if (membarrier_state & states[i]) {
+			registrations_mask |= registration_cmds[i];
+			membarrier_state &= ~states[i];
+		}
+	}
+	WARN_ON_ONCE(membarrier_state != 0);
+	return registrations_mask;
+}
+
 /**
  * sys_membarrier - issue memory barriers on a set of threads
  * @cmd:    Takes command values defined in enum membarrier_cmd.
@@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
 		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
+	case MEMBARRIER_CMD_GET_REGISTRATIONS:
+		return membarrier_get_registrations();
 	default:
 		return -EINVAL;
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

