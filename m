Return-Path: <linux-kselftest+bounces-23949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B63A02DF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C371886451
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0571A8F79;
	Mon,  6 Jan 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIpeS1XH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7017799F;
	Mon,  6 Jan 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181702; cv=none; b=MJtaHQDQm451xJPp4UA5U9UffndxoY2gkxolAvoibYOjh3FupeuEWSQVb7OG55AhX9v75yOAkVh2nJkuUG0J701VMC5zRA2/7I9HQlpCTW3AeUcusQQBMKCwTHm/+F25QJp0Hkfphho4jUjIF8bVEtPEyPO1tYFbyRT3MGWkoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181702; c=relaxed/simple;
	bh=Vd31vh72JZzmb0OCpOhRKfJuAKEAajOW9JNN4rk7ceg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WRa4jNUXCu0nXQeL9FNgqs6ec7bg4ygrDkjY+yIo2wZlJSMegQungbX1GvdqoSjkgsS7h57eD0Q7Cda0JCva0eU1gpGVt7jjUV2TVZU7zU0S5R2Jfomq9oFKnu7v4Ar+TBFP4A1xPt7/X2SZRzO1dR4aphSscgCJgB6d0VsmtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIpeS1XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEF8C4CED2;
	Mon,  6 Jan 2025 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181701;
	bh=Vd31vh72JZzmb0OCpOhRKfJuAKEAajOW9JNN4rk7ceg=;
	h=From:To:Cc:Subject:Date:From;
	b=mIpeS1XHr2oQIjpL15xeoTzWmiyfVfdCZSahNiN16CFt7jebz+bLkuG2Zix9LZS2V
	 8Ej8zl0zFRVai6+PgWCYBgsFXGEJuqbi29YzRXaEtEObSeLSwZMl8W0/KcQYGvDYGS
	 OOzWxK05qHdh8gJxnMjeu1J9Mzfrae4rB4JEUwReDcva+eM7xAHOLbqUbni+HpGv1m
	 Y+OamurWoBz28JcWNmgTV9TLoQOEOTJoHyGf1uqcUHb1EQpdJHV0vjvG1Pm8uza2If
	 K9zFXRySICYtbcytULV8LaS77XtCHVPGS7AnjR4/7pHDZu5UxZqRo+1d/ICydiFCzF
	 k6VkU4DL7APrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrea Righi <arighi@nvidia.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	dvernet@meta.com,
	vishalc@linux.ibm.com,
	haoluo@google.com,
	brho@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 1/8] selftests/sched_ext: fix build after renames in sched_ext API
Date: Mon,  6 Jan 2025 11:41:01 -0500
Message-Id: <20250106164138.1122164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Ihor Solodrai <ihor.solodrai@pm.me>

[ Upstream commit ef7009decc30eb2515a64253791d61b72229c119 ]

The selftests are falining to build on current tip of bpf-next and
sched_ext [1]. This has broken BPF CI [2] after merge from upstream.

Use appropriate function names in the selftests according to the
recent changes in the sched_ext API [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=fc39fb56917bb3cb53e99560ca3612a84456ada2
[2] https://github.com/kernel-patches/bpf/actions/runs/11959327258/job/33340923745
[3] https://lore.kernel.org/all/20241109194853.580310-1-tj@kernel.org/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Acked-by: Andrea Righi <arighi@nvidia.com>
Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c | 2 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        | 4 ++--
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c      | 2 +-
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c        | 2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c              | 4 ++--
 tools/testing/selftests/sched_ext/maximal.bpf.c           | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c    | 2 +-
 .../selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   | 2 +-
 .../testing/selftests/sched_ext/select_cpu_dispatch.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c  | 8 ++++----
 12 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index 37d9bf6fb745..6f4c3f5a1c5d 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
 		 * If we dispatch to a bogus DSQ that will fall back to the
 		 * builtin global DSQ, we fail gracefully.
 		 */
-		scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+		scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
 				       p->scx.dsq_vtime, 0);
 		return cpu;
 	}
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index dffc97d9cdf1..e4a55027778f 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -17,8 +17,8 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
 
 	if (cpu >= 0) {
 		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
-		scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
-				       p->scx.dsq_vtime, 0);
+		scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+					 p->scx.dsq_vtime, 0);
 		return cpu;
 	}
 
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index 6a7db1502c29..6325bf76f47e 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -45,7 +45,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 
 	target = bpf_get_prandom_u32() % nr_cpus;
 
-	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 	bpf_task_release(p);
 }
 
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index 1efb50d61040..a7cf868d5e31 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -31,7 +31,7 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 	/* Can only call from ops.select_cpu() */
 	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
 
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index d75d4faf07f6..4bc36182d3ff 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -33,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
 	if (exit_point == EXIT_ENQUEUE)
 		EXIT_CLEANLY();
 
-	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
@@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
 	if (exit_point == EXIT_DISPATCH)
 		EXIT_CLEANLY();
 
-	scx_bpf_consume(DSQ_ID);
+	scx_bpf_dsq_move_to_local(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 4d4cd8d966db..4c005fa71810 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -28,7 +28,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_consume(SCX_DSQ_GLOBAL);
+	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
index f171ac470970..13d0f5be788d 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
 	}
 	scx_bpf_put_idle_cpumask(idle_mask);
 
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 9efdbb7da928..815f1d5d61ac 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -67,7 +67,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
 		saw_local = true;
 	}
 
-	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
 }
 
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
index 59bfc4f36167..4bb99699e920 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -29,7 +29,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 
 dispatch:
-	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, 0);
 	return cpu;
 }
 
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
index 3bbd5fcdfb18..2a75de11b2cf 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -18,7 +18,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching to a random DSQ should fail. */
-	scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, 0xcafef00d, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
index 0fda57fe0ecf..99d075695c97 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -18,8 +18,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching twice in a row is disallowed. */
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index e6c67bcf5e6e..bfcb96cd4954 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -2,8 +2,8 @@
 /*
  * A scheduler that validates that enqueue flags are properly stored and
  * applied at dispatch time when a task is directly dispatched from
- * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), and
- * making the test a very basic vtime scheduler.
+ * ops.select_cpu(). We validate this by using scx_bpf_dsq_insert_vtime(),
+ * and making the test a very basic vtime scheduler.
  *
  * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2024 David Vernet <dvernet@meta.com>
@@ -47,13 +47,13 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 	scx_bpf_test_and_clear_cpu_idle(cpu);
 ddsp:
-	scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
+	scx_bpf_dsq_insert_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
 	return cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
 {
-	if (scx_bpf_consume(VTIME_DSQ))
+	if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
 		consumed = true;
 }
 
-- 
2.39.5


