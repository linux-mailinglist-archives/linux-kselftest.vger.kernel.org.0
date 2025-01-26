Return-Path: <linux-kselftest+bounces-25206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B121A1CC24
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A13B0F56
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834E1ABED9;
	Sun, 26 Jan 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtbu5w2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B51AAA05;
	Sun, 26 Jan 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904050; cv=none; b=tgWoSe6PVou3MOVRSKozjbFn0Uyf5l2zwknF2c1E6y8/hSdTbHkAI47ATX0ZcdsTaNTUvZ3wNg821VFhGmHYbxy672zp4odgDB4x2VbqesxALrwgeGGeb0i6DhjE1IZdUObFctkjvb69kE1NaKy28zsEKDynu64obWzFK2l/ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904050; c=relaxed/simple;
	bh=DZdHBhN5vrQUGPgRom9OpQ6H2A7CPhcke5kkFiT2FZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FduA4bdDVwg0dDkQeFsNUp1Gj0Vs05NTS0lpDO4UybHR4M9dwjqUC0AX9+bculWRTBXbzThwlgrkRqwBbpxv79qdatoh13k3dez/9d+GmVdY96eAeSLi/bc9MFB9Yvkak/PIvAdplaLKudgrS8jGK0PFwj6kJgLMajJS5WKYnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtbu5w2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CEC4CED3;
	Sun, 26 Jan 2025 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904050;
	bh=DZdHBhN5vrQUGPgRom9OpQ6H2A7CPhcke5kkFiT2FZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vtbu5w2EIc3mtnDPoPYd78O+/JygP14px2Gald6UVy3dvYZtOX4zUCVbSzgKYJLRz
	 qh+VTYdhe0SmCsw62iFSrz/dswV4SyeLY9W3ZURa5ddoLvhAhWbLvPpApCS75EilRI
	 FAtRKHWeWIo2hQYMJLeH/rUDGcnBT4qGosiwuq5pPzlKHc9s1c6BJXpYx/FC8QsOpC
	 ZHdluw0VsyrAUpX2wk7tU2RwS2xFm5h7SHlc1KivD6cqB/b8CKAvz+8ltuOtJcz1er
	 kaJtcMLMxsfIQF7lr/3oiu0byfGmBcauC2mvR4jaoF6g5wvdc1mrcDP4d3nitB5jY5
	 OOAN/eXctd0Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	martin.lau@kernel.org,
	void@manifault.com,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 02/16] bpf: Improve verifier log for resource leak on exit
Date: Sun, 26 Jan 2025 10:07:04 -0500
Message-Id: <20250126150720.961959-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit cbd8730aea8d79cda6b0f3c18b406dfdef0c1b80 ]

The verifier log when leaking resources on BPF_EXIT may be a bit
confusing, as it's a problem only when finally existing from the main
prog, not from any of the subprogs. Hence, update the verifier error
string and the corresponding selftests matching on it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241204030400.208005-6-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                              |  2 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  4 ++--
 tools/testing/selftests/bpf/progs/preempt_lock.c   | 14 +++++++-------
 .../selftests/bpf/progs/verifier_spin_lock.c       |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77f56674aaa99..4f02345b764fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18803,7 +18803,7 @@ static int do_check(struct bpf_verifier_env *env)
 				 * match caller reference state when it exits.
 				 */
 				err = check_resource_leak(env, exception_exit, !env->cur_state->curframe,
-							  "BPF_EXIT instruction");
+							  "BPF_EXIT instruction in main prog");
 				if (err)
 					return err;
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index fe0f3fa5aab68..8a0fdff899271 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -131,7 +131,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,7 +147,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 885377e836077..5269571cf7b57 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,7 +6,7 @@
 #include "bpf_experimental.h"
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -14,7 +14,7 @@ int preempt_lock_missing_1(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -23,7 +23,7 @@ int preempt_lock_missing_2(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -33,7 +33,7 @@ int preempt_lock_missing_3(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
 {
 	bpf_preempt_disable();
@@ -55,7 +55,7 @@ static __noinline void preempt_enable(void)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -63,7 +63,7 @@ int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
@@ -72,7 +72,7 @@ int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_preempt_disable-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
 int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
 {
 	preempt_disable();
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index 3f679de73229f..25599eac9a702 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -187,7 +187,7 @@ l0_%=:	r6 = r0;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: test6 missing unlock")
-__failure __msg("BPF_EXIT instruction cannot be used inside bpf_spin_lock-ed region")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_spin_lock-ed region")
 __failure_unpriv __msg_unpriv("")
 __naked void spin_lock_test6_missing_unlock(void)
 {
-- 
2.39.5


