Return-Path: <linux-kselftest+bounces-13675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FD92FC70
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8528325D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E545171666;
	Fri, 12 Jul 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXtjQI9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443C13F439;
	Fri, 12 Jul 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794274; cv=none; b=V5f96nfkfe1w+Ch4nOlwXyklhSrcy0Gl9cwvXRESmGPVauUHNL8wVQnGcgBewJ+0oynf7aRCe2liC0cs4tUBtD0Ts0ZYaSRg9glFotjOyXgF9xTE6Uzk2nqDHx0N+fq7DPAkCGaNOs9GKD0mSBZL8z/WX6aWbnpDdurqW4l0vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794274; c=relaxed/simple;
	bh=uRAkMAu6p5BoCnsavdR/O4GrREdstMoQXHGClq1Bu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh7fLJwyqjOd8Zb4rBePvvwvbS3B7Ou5X56Mfwu9/KAJ+sHlc3SJ388ZgafquOYTIvdKAplV0APf9EGEFfx7R1F1L2Ri3PF7DBX1D3DvZqHlrEkDEe6seFc3P2o05Menunm5+pl5BvQdS0pqIHm2hBFi/xjfi9SHXLjNtsp7nRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXtjQI9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E9C32782;
	Fri, 12 Jul 2024 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794274;
	bh=uRAkMAu6p5BoCnsavdR/O4GrREdstMoQXHGClq1Bu7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXtjQI9j1fC5l5AoepYHH3RIcn5E56Ly3BrIzabbs08UVOumK3OIllm4RygGdgHkA
	 5MT7wv/kQYfkULfJhVopX8qxfuWP3HfVHlTqLEEahGWdwbG2imCGusfRo8bntRAlCT
	 zcPMHgFXE66iohF7N6GHjKoCOZ9lPaO/raagZMF9+IQHSUhhXE8kWxQ7jGhWzaad9y
	 iKKLYw6V5Wdxeqh8wjkiMnW+xeAciipbi7DwE96P/dEAgmFKozsKwBFX0EZ9sbM2mQ
	 JmQ7TXVHxxO8uXPH1qBkWuvxc9NipblhC2SjoacHLcPkrkJgmgr9PuuFcCi9bKH6ea
	 Y1Sr9cSXPuw1g==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: verifier: Fix return value of fixup_call_args
Date: Fri, 12 Jul 2024 22:24:16 +0800
Message-ID: <7f220cc167aac5a0a50b1e20da1390983d61b1f8.1720791489.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720791488.git.tanggeliang@kylinos.cn>
References: <cover.1720791488.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run bloom_filter_map selftests (./test_progs -t bloom_filter_map) on a
Loongarch platform, an error message "JIT doesn't support bpf-to-bpf calls"
is got in user space, together with an unexpected errno EINVAL (22), not
ENOTSUPP (524):

 libbpf: prog 'inner_map': BPF program load failed: Invalid argument
 libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
 JIT doesn't support bpf-to-bpf calls
 callbacks are not allowed in non-JITed programs
 processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
 -- END PROG LOAD LOG --
 libbpf: prog 'inner_map': failed to load: -22
 libbpf: failed to load object 'bloom_filter_map'
 libbpf: failed to load BPF skeleton 'bloom_filter_map': -22
 setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -22
 #16      bloom_filter_map:FAIL

Although the return value of jit_subprogs() does be set as "ENOTSUPP":

	verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
	err = -ENOTSUPP;
	goto out_free;

But afterwards in fixup_call_args(), the return value of jit_subprogs()
is ignored, and overwritten as "-EINVAL":

	verbose(env, "callbacks are not allowed in non-JITed programs\n");
	return -EINVAL;

This patch fixes this by changing return values of fixup_call_args() from
"-EINVAL" to "err ?: -EINVAL". With this change, errno 524 is got in user
space now:

 libbpf: prog 'inner_map': BPF program load failed: unknown error (-524)
 libbpf: prog 'inner_map': -- BEGIN PROG LOAD LOG --
 JIT doesn't support bpf-to-bpf calls
 processed 37 insns (limit 1000000) max_states_per_insn 1 total_states
 -- END PROG LOAD LOG --
 libbpf: prog 'inner_map': failed to load: -524
 libbpf: failed to load object 'bloom_filter_map'
 libbpf: failed to load BPF skeleton 'bloom_filter_map': -524
 setup_progs:FAIL:bloom_filter_map__open_and_load unexpected error: -524

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..aa589fedd036 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19717,14 +19717,14 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (has_kfunc_call) {
 		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
-		return -EINVAL;
+		return err ?: -EINVAL;
 	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 		/* When JIT fails the progs with bpf2bpf calls and tail_calls
 		 * have to be rejected, since interpreter doesn't support them yet.
 		 */
 		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
-		return -EINVAL;
+		return err ?: -EINVAL;
 	}
 	for (i = 0; i < prog->len; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
@@ -19732,7 +19732,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 			 * have to be rejected, since interpreter doesn't support them yet.
 			 */
 			verbose(env, "callbacks are not allowed in non-JITed programs\n");
-			return -EINVAL;
+			return err ?: -EINVAL;
 		}
 
 		if (!bpf_pseudo_call(insn))
-- 
2.43.0


