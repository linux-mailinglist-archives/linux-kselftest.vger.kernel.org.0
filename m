Return-Path: <linux-kselftest+bounces-8133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014C8A6D75
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1656C1F23081
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909712C530;
	Tue, 16 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJLw0Xh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAF12E1F5;
	Tue, 16 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276602; cv=none; b=uo/EtkEphWfPXXioKFs30ARadwEDMyd1Tpjth/rOKKVQJt1bope+0PYwfJyF5HHfPNYtUtRG5SIwf6jt+0NDmlLbgQ0JZJCDaymQ+IdpWV2Ig5nHboRNBlgkqiDpAoYgGJEVkKSooW3vjzFTyjJXicNKWmlGBCrhxnQgrfFWVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276602; c=relaxed/simple;
	bh=EqDSHYXSuauocbkK3UeYk6FohwrTmrLQYrjZAzvk/UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTYPhXEWu6k1IPGktpLY/9vpTr2Fz0og3qP1GCw7F/mRMexZXuj/XLsxHytAkb/DAJSzxD/c7dHhONKlRnvnXK3kaWYfGwW60x7M6V9C8/nQshuIJg0drs77pWDS3+/mm5g9rMvmoCfFxuRoLEQfSlz0G9M8K1eprd0dMu7mOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJLw0Xh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1592C2BD11;
	Tue, 16 Apr 2024 14:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276602;
	bh=EqDSHYXSuauocbkK3UeYk6FohwrTmrLQYrjZAzvk/UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cJLw0Xh4d+TehtvzP4HNnxbb/4CdD37XZe8ozJR/0qGGqMte9uve80gAMVYlTPRzX
	 iGLWgPuzsRxXS44mPfSrEWPq0HJsJ3BW0cnqRATVdTHpVbBmvRohgv4YvANHfkO0mB
	 IRgRQVDJE+D+nyebt7rFOkpIADqlcPuEUfFYsSb8ALpBftSstZBl6nkTxTho8knn3d
	 nixz7LjsJPEhLnuUP7yW0OKlv5nLMF/iYFXwrSiIICJGHL7qeEQveM0CGG66yx+1t8
	 3SIofX/0SNovldZwMgFK+tRIOCwOsiqyNGf2lesWU//HQSovhP0vx3whewFng772dN
	 0VjKBDDTBTUcQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:14 +0200
Subject: [PATCH bpf-next 01/18] bpf: trampoline: export
 __bpf_prog_enter/exit_recur
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-1-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=2335;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=EqDSHYXSuauocbkK3UeYk6FohwrTmrLQYrjZAzvk/UM=;
 b=JSkEUA6eeIT82u3qdJEkQBERbwjvE93oqsMRp+A190eCAgA9aO5pHSa6wNnvw+jnDmSX/l8/h
 8Wvp+UtRcltAheyvx43kZfEqkjY127VHrKLRgxj5BvogIF7mSo9sL0Z
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When dealing with workqueues, we need to also use
__bpf_prog_enter/exit_recur().

bpf_trampoline_enter/exit() is not suitable because we are
dealing with async callbacks that are set sleepable or not
by the verifier, depending on how they are configured, so
we need to rewrite our own test "if (sleepable)..."

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 include/linux/bpf.h     | 4 ++++
 kernel/bpf/trampoline.c | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..551445c47779 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1124,6 +1124,10 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 					     struct bpf_tramp_run_ctx *run_ctx);
+u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog,
+				   struct bpf_tramp_run_ctx *run_ctx);
+void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
+				   struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
 void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
 typedef u64 (*bpf_trampoline_enter_t)(struct bpf_prog *prog,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 26ae703d3c3b..c6a3e0280993 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -858,7 +858,7 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	rcu_read_lock();
@@ -896,8 +896,8 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	}
 }
 
-static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
-					  struct bpf_tramp_run_ctx *run_ctx)
+void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
+				   struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);

-- 
2.44.0


