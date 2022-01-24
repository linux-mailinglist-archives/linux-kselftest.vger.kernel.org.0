Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6189F497D71
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 11:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiAXKxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 05:53:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34414 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiAXKxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 05:53:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EAE7612F2;
        Mon, 24 Jan 2022 10:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8F0C340E4;
        Mon, 24 Jan 2022 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643021593;
        bh=ZMfQWUpk0eDWkXdZTigFyfC36ehh99jynZEFFZLSbok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMkT1h22frBQn/cTz/3is31icPq12OL/glW8xho0ut6HBfsVoHBMko82K9bGo0+tx
         tlcfD/x+m4USH16VRHx5S69dRXF/ei/i1WVuyH/FXulF1IblTar3w0LW98KcJr2ceg
         u3kT++IizLHxgYS/Y5aY6e04RZyk/mxL/8SPzgQXSth5dvf8PN0AkSi2e8o049RC5j
         i/Uhz6iH6mZVZ7tCVi1Y1TeSOuhVkhg4shN+avG+sWPtSJ4uKyDIo75HaSZ+Po7hgE
         FSpy69yHtrJ9AcLKsWBuFPsHefIiKTOLMjCdauaIoKqCydijPSIwqXH+8d/5y+JZBG
         7Pf1QIYrwHkmg==
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
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [resend RFC 3/3] tests: add new PR_SCHED_CORE_SHARE test
Date:   Mon, 24 Jan 2022 11:52:47 +0100
Message-Id: <20220124105247.2118990-4-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124105247.2118990-1-brauner@kernel.org>
References: <20220124105247.2118990-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; h=from:subject; bh=ZMfQWUpk0eDWkXdZTigFyfC36ehh99jynZEFFZLSbok=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS+a/nrsHpjTQmnzVYRq6/3Eg/6iSclPb25elvHJpOypz8m LJ4Y2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRE+0M/+N11D70tG7ccyFuwg5W3T fvIj5PW/L9YlHNxZ/vHospeeUz/I+T/bDRPidh4TT3txMrMmvab/unreA+5m1tLpP9viVRlxUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
Signed-off-by: Christian Brauner <brauner@kernel.org>
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
2.32.0

