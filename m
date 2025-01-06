Return-Path: <linux-kselftest+bounces-23951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269EA02DFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7CF7A318C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81E1DEFE6;
	Mon,  6 Jan 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnKNTvf8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26D1DDC3A;
	Mon,  6 Jan 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181716; cv=none; b=p1U3WvCkwpPopKtAX+US4MuRb/5PF9TESmCsHV6LNKWLzu9H9Ca2m2u6HJD/vgxSaw94C+yRbTItRnFh8oSUpFVUpNvXWoYU07wJuCsVW1ktyhcKVah7jJJxqkRB9peby+KlQzs7xtONwgUfnXI4a4J6H01Hh88tADrvkwy8KCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181716; c=relaxed/simple;
	bh=QbFbT//zDPiIzy5J3MmytHrSEmvbPNG9OKmJHznXZ8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WvOMKxq+G7bA9xU26IZKsWJb3So5Qz3xUWPcG9zeBjC49sidKTP7stpnYmJbtRYsOHzrwgSDDh2YuEb6vYCr52epiljC0rZaf1o/Z4eHFwmXc/5qcVCPwbv+iudy8g/0QTzqNiJOt3jNpREl3sb4mWA7qqOa4A7ecsRsizmYWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnKNTvf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815CDC4CED6;
	Mon,  6 Jan 2025 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181715;
	bh=QbFbT//zDPiIzy5J3MmytHrSEmvbPNG9OKmJHznXZ8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnKNTvf8QgzbsE0daif9rTksXA2VWGVmYE3V7cmGafJsAV07hvZWwt2bOZjwi+/1C
	 vSKwE/l6zf44Gy9hqNSiXge4xrSjpOpm8Za8TjBHunPiSKkD2Sg6tSoXQKHhHho5mN
	 S9DZXKS4QIoEJ5dd7OMFStvdXDnQiqA/TZpyGZXkt5NpDH0kTLcCPEuQcav1gXOClE
	 q5BFgmLn+pc32/PPUhGNn4mCALCqD4x1cBoffQFakarluB1P0DloLhsAA/1Nq8HCZh
	 99z6O5UuxnuL+QKvK8WQNOfqSz/DoANf0CmAK4WNuWwBJvNnjMBhhdEmgreDIM5Po0
	 U4QTPc7B/lT0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	dvernet@meta.com,
	vishalc@linux.ibm.com,
	arighi@nvidia.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 4/8] sched_ext: Fix dsq_local_on selftest
Date: Mon,  6 Jan 2025 11:41:04 -0500
Message-Id: <20250106164138.1122164-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit ce2b93fc1dfa1c82f2576aa571731c4e5dcc8dd7 ]

The dsp_local_on selftest expects the scheduler to fail by trying to
schedule an e.g. CPU-affine task to the wrong CPU. However, this isn't
guaranteed to happen in the 1 second window that the test is running.
Besides, it's odd to have this particular exception path tested when there
are no other tests that verify that the interface is working at all - e.g.
the test would pass if dsp_local_on interface is completely broken and fails
on any attempt.

Flip the test so that it verifies that the feature works. While at it, fix a
typo in the info message.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Link: http://lkml.kernel.org/r/Z1n9v7Z6iNJ-wKmq@slm.duckdns.org
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c | 5 ++++-
 tools/testing/selftests/sched_ext/dsp_local_on.c     | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index 6325bf76f47e..fbda6bf54671 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -43,7 +43,10 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	if (!p)
 		return;
 
-	target = bpf_get_prandom_u32() % nr_cpus;
+	if (p->nr_cpus_allowed == nr_cpus)
+		target = bpf_get_prandom_u32() % nr_cpus;
+	else
+		target = scx_bpf_task_cpu(p);
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 	bpf_task_release(p);
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.c b/tools/testing/selftests/sched_ext/dsp_local_on.c
index 472851b56854..0ff27e57fe43 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.c
@@ -34,9 +34,10 @@ static enum scx_test_status run(void *ctx)
 	/* Just sleeping is fine, plenty of scheduling events happening */
 	sleep(1);
 
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
 	bpf_link__destroy(link);
 
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
 	return SCX_TEST_PASS;
 }
 
@@ -50,7 +51,7 @@ static void cleanup(void *ctx)
 struct scx_test dsp_local_on = {
 	.name = "dsp_local_on",
 	.description = "Verify we can directly dispatch tasks to a local DSQs "
-		       "from osp.dispatch()",
+		       "from ops.dispatch()",
 	.setup = setup,
 	.run = run,
 	.cleanup = cleanup,
-- 
2.39.5


