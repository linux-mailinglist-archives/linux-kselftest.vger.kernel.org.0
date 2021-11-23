Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591DE45A3BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Nov 2021 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhKWNcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 08:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhKWNcu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 08:32:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129DE61028;
        Tue, 23 Nov 2021 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637674182;
        bh=+WvvLxaG81J/ubcccOG7qUn/hsfRxAN45jRXpuXsL84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tl9UCwpXE1fJHsyctHRtKvhMSZOlWL7ESPn21C5M0kr9jnv/rxMPpVDM1TszcZHvW
         huxJxzSXbQLQ3fK+Oxei2ArpLUhfYIeEb+71GD+2DW+Hdnd8HHT4sH9Ygl+EFixZ9D
         f3srkp7jJ9gM/iEo7wn6ylmYGQ+3Pc8mNTyQpcC/GJ3ioNdmHTXOZS/vlEvX1fNVzj
         8JVKGLu5qqS1gedU6adKddtuwxsSbPB5idx2zkEcHJJUYvt4HXFzu7eM3Ejn+nWKas
         7f8oo8thV+F3sXCv8EoRPw+KQMoS88cjxswzL8chu0P2NMfhYNnxR9fYgInBfMlJfG
         OrKzkwKVeWNVw==
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 3/3] tests: add new PR_SCHED_CORE_SHARE test
Date:   Tue, 23 Nov 2021 14:29:07 +0100
Message-Id: <20211123132907.3138476-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123132907.3138476-1-brauner@kernel.org>
References: <20211123132907.3138476-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; h=from:subject; bh=O+FmXC8yetMDZoRlha2v/e4w+wLt2pWZylWpT6XRQSQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOeTN/9z+vg39v5/Pnmht/W/9yYufnzGc1s0TNK0w/Ncrn sKr3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk/gKG/5nVPbuf8h/ZOrPKRrt3ig 23/t97D01fpPCwfrVu4TRyTmP477Iv0Pruxeqrj1fJBKQW9emGyL68OLF7UaJD2seDF+fkcgIA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Add tests for the new PR_SCHED_CORE_SHARE command.

Cc: Peter Collingbourne <pcc@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Chris Hyser <chris.hyser@oracle.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Balbir Singh <sblbir@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 8109b17dc764..985b83fe7221 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -229,6 +229,7 @@ int main(int argc, char *argv[])
 	int pidx;
 	int pid;
 	int opt;
+	int i;
 
 	while ((opt = getopt(argc, argv, ":hkT:P:d:")) != -1) {
 		switch (opt) {
@@ -325,6 +326,28 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(pid) != 0);
 	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
 
+	printf("\n## Set a new cookie on a single thread/PR_SCHED_CORE_SCOPE_THREAD [%d]\n", pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PR_SCHED_CORE_SCOPE_THREAD, 0) < 0)
+		handle_error("core_sched create failed -- PR_SCHED_CORE_SCOPE_THREAD");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from a thread [%d] to [%d] as PR_SCHED_CORE_SCOPE_THREAD\n", pid, procs[pidx].thr_tids[0]);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE, procs[pidx].thr_tids[0], PR_SCHED_CORE_SCOPE_THREAD, pid) < 0)
+		handle_error("core_sched share cookie from and to thread failed -- PR_SCHED_CORE_SCOPE_THREAD");
+	disp_processes(num_processes, procs);
+
+	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
+
+	printf("\n## Copy cookie from a thread [%d] to [%d] as PR_SCHED_CORE_SCOPE_THREAD_GROUP\n", pid, pid);
+	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE, pid, PR_SCHED_CORE_SCOPE_THREAD_GROUP, pid) < 0)
+		handle_error("core_sched share cookie from and to thread-group failed -- PR_SCHED_CORE_SCOPE_THREAD_GROUP");
+	disp_processes(num_processes, procs);
+
+	for (i = 0; i < procs[pidx].num_threads; ++i)
+		validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[i]));
+
 	if (errors) {
 		printf("TESTS FAILED. errors: %d\n", errors);
 		res = 10;
-- 
2.30.2

