Return-Path: <linux-kselftest+bounces-23950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1169EA02DF5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81CB160158
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05B1DD543;
	Mon,  6 Jan 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2v0K/M8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45417799F;
	Mon,  6 Jan 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181707; cv=none; b=qjpCIRkxh2wm/MX8noXnGt7PY7HZop/AhQH3WvT1EpAdDE9Yg6hPJicefrmf/Fr3O7+pUVspaEamNwqMTA6vH9wUqaNwAHNFNT+A7GQKkNpKgUl/dV3vG+JRd3seVc9A/xaf2dkg3xuCBf1tVaroPu6zioFAZfi1RB51iP4z4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181707; c=relaxed/simple;
	bh=s/GI9bVnn4LQqCwM0MxAhz73zr7JiTx7pgwq91tohf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ElzUVPzRdU4kdU2ETYwOZqMTnb+84tkI6LYF0J96QqC/BqgzWC7NrsbPy/Nf63FeSAaibQjD9x/uhCujkcjoKvwvIb9pJOieuchUqJrx/AyDWtBHAJI6GsT8Kts9ia8lB3kLJFtUXI3MpyW6dbVqi6t/yJcEYc27EFn8a2mSh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2v0K/M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA2C4CED2;
	Mon,  6 Jan 2025 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181706;
	bh=s/GI9bVnn4LQqCwM0MxAhz73zr7JiTx7pgwq91tohf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2v0K/M86O9a5OqmFwldcNAR2ctezIi7+i+NxyZb/g4KbmyJu7bb8i4fF5KcSMeEG
	 biXr81YETbU2uJB/Rsx/tuYaB0oUdMBZdr8iu4Mkotc+pXHh78ihbMYjLFfmdiwkkI
	 EZqDn/86mxQ5MnVYKLb7JVXuMOoo9OtDd/81sTDTtlQ/l5VhaA3F0etzNqz17y3Sr+
	 bO5uC2SVZjnZEIEDL7CXMmzvvLz/A9N2nuwCNA9cqjdoN9eYlk16mccj7xO+v45W7A
	 7PKDBRFUvNYwnVGYXT7SgpvGHa21S9cqxXwFluHEOEtlZodtMsHAkw1PWLe7AKD18n
	 LNATPQlCFfgUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	brho@google.com,
	haoluo@google.com,
	vishalc@linux.ibm.com,
	ihor.solodrai@pm.me,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/8] scx: Fix maximal BPF selftest prog
Date: Mon,  6 Jan 2025 11:41:02 -0500
Message-Id: <20250106164138.1122164-2-sashal@kernel.org>
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

From: David Vernet <void@manifault.com>

[ Upstream commit b8f614207b0d5e4abd6df8d5cb3cc11f009d1d93 ]

maximal.bpf.c is still dispatching to and consuming from SCX_DSQ_GLOBAL.
Let's have it use its own DSQ to avoid any runtime errors.

Signed-off-by: David Vernet <void@manifault.com>
Tested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sched_ext/maximal.bpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 4c005fa71810..430f5e13bf55 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -12,6 +12,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+#define DSQ_ID 0
+
 s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 		   u64 wake_flags)
 {
@@ -20,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -28,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
+	scx_bpf_dsq_move_to_local(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
@@ -123,7 +125,7 @@ void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 {
-	return 0;
+	return scx_bpf_create_dsq(DSQ_ID, -1);
 }
 
 void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
-- 
2.39.5


