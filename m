Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31859405216
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbhIIMky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 08:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354563AbhIIMfe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 08:35:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44033611B0;
        Thu,  9 Sep 2021 11:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188435;
        bh=NyYDkBj2exwUxrdJ3yy0kdAm2cAfu+ZrmkTsZjwhJdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjFkI9OImF76NPOJ6w1rPqpMsSB2XYjyR7nZlY3K4J26TiVAnE8eV4ZnEt9nxXKi7
         EzceLvhnJZRSz52lxY1UDKF9ic+6TRv6nailyE0mNTDsWXTEmpa4g/2A+R1CG4bkVF
         ry9jXIr2s0iDVVlEnoGTGjULJGTrMEmmhZ9gGkTdGMAGPwbcSCtS+bL+KBsgyDzmSq
         FVv09OsRTT5TGFy0HmRSGbDnWbOTvEtx8HmKmtyOOvnOPVO9hHyXc1PGg86JzKx5fP
         VOaudL4/mIbXEA4XeY7w5Okz+yWOGdpZ/q9ETZMeUrtRAazl9gfdy1jrKlfehXStOq
         /YjYS6NsF+1MQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 121/176] selftests/bpf: Fix flaky send_signal test
Date:   Thu,  9 Sep 2021 07:50:23 -0400
Message-Id: <20210909115118.146181-121-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115118.146181-1-sashal@kernel.org>
References: <20210909115118.146181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit b16ac5bf732a5e23d164cf908ec7742d6a6120d3 ]

libbpf CI has reported send_signal test is flaky although
I am not able to reproduce it in my local environment.
But I am able to reproduce with on-demand libbpf CI ([1]).

Through code analysis, the following is possible reason.
The failed subtest runs bpf program in softirq environment.
Since bpf_send_signal() only sends to a fork of "test_progs"
process. If the underlying current task is
not "test_progs", bpf_send_signal() will not be triggered
and the subtest will fail.

To reduce the chances where the underlying process is not
the intended one, this patch boosted scheduling priority to
-20 (highest allowed by setpriority() call). And I did
10 runs with on-demand libbpf CI with this patch and I
didn't observe any failures.

 [1] https://github.com/libbpf/libbpf/actions/workflows/ondemand.yml

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20210817190923.3186725-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/send_signal.c       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 7043e6ded0e6..75b72c751772 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include "test_send_signal_kern.skel.h"
 
 static volatile int sigusr1_received = 0;
@@ -41,12 +43,23 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	}
 
 	if (pid == 0) {
+		int old_prio;
+
 		/* install signal handler and notify parent */
 		signal(SIGUSR1, sigusr1_handler);
 
 		close(pipe_c2p[0]); /* close read */
 		close(pipe_p2c[1]); /* close write */
 
+		/* boost with a high priority so we got a higher chance
+		 * that if an interrupt happens, the underlying task
+		 * is this process.
+		 */
+		errno = 0;
+		old_prio = getpriority(PRIO_PROCESS, 0);
+		ASSERT_OK(errno, "getpriority");
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
+
 		/* notify parent signal handler is installed */
 		CHECK(write(pipe_c2p[1], buf, 1) != 1, "pipe_write", "err %d\n", -errno);
 
@@ -62,6 +75,9 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		/* wait for parent notification and exit */
 		CHECK(read(pipe_p2c[0], buf, 1) != 1, "pipe_read", "err %d\n", -errno);
 
+		/* restore the old priority */
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
+
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
 		exit(0);
-- 
2.30.2

