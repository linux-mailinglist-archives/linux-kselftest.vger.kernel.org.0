Return-Path: <linux-kselftest+bounces-3113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6282F812
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D71C24ABA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74A12CD84;
	Tue, 16 Jan 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fODjdGQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E824214;
	Tue, 16 Jan 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434625; cv=none; b=gpzEYLU0ov2EyWeRom9PBgknx3d3wvPUy+jXXRxDo55iB0MFVGGx6LOC/O0pIkfepy94ochKu1F7LQt61NVWCY3sgqDKnn1QS0PftQcCKfyiXZFy/1g33kp0YmSr+VeLnsIHwtvl1V99QaF2lZPqAgkv7m2jTgHxtelg2DUMJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434625; c=relaxed/simple;
	bh=W/wZE/1C8o+w7gHiW4PUYQXU0ahgzy3AaYoVFq7n96o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=fuShb12nysvYBQOCRs7f9cefbPce1/0UAqcouKHYc0sQT7isCdu7DA2zyiXR4CAjmVNlvNM9zuHj9+msyr08DyaoS+gHY47ZXIEW4PJxysLx8KIKnXaYgVvwTbI9LIJzAWIC7MlMbPcHGgieyf/Lq8b3H9wXjIXSgTCfL8mTx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fODjdGQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43093C433C7;
	Tue, 16 Jan 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434625;
	bh=W/wZE/1C8o+w7gHiW4PUYQXU0ahgzy3AaYoVFq7n96o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fODjdGQNaBmZzdqSGKoPNXHLhIlwj2wN1byM6h4PkpIOeV72dYly1BjZqPFFaJAnb
	 +2PbdIrZeGrKA4L5Le9i1CeGG5a5aTpvGgocBftsz/ShPheniuwXdxUQf9B7SKXIqC
	 ltTnxQU7CA6SlNySLZ56qU88lGcplnYGByimBxjI4tbpv9WzRtUDXpoNRGZEi1SjpV
	 yNTjym+mfMdSZo9rspq5fX0+bDKMBo8nwuHI2bzqBQzXgF+VlyNJAh0xfqQYoz4JvH
	 WMFLjvQAkwSQn2hKrVvt/3x77yOdM058Xkonztuf+jGhCd4Hsjg7tGMiKkayaj75Ug
	 fI59zZvFd4Stw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	nathan@kernel.org,
	sdf@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 031/104] bpf: Fix a few selftest failures due to llvm18 change
Date: Tue, 16 Jan 2024 14:45:57 -0500
Message-ID: <20240116194908.253437-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit b16904fd9f01b580db357ef2b1cc9e86d89576c2 ]

With latest upstream llvm18, the following test cases failed:

  $ ./test_progs -j
  #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
  #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
  #13      bpf_cookie:FAIL
  #77      fentry_fexit:FAIL
  #78/1    fentry_test/fentry:FAIL
  #78      fentry_test:FAIL
  #82/1    fexit_test/fexit:FAIL
  #82      fexit_test:FAIL
  #112/1   kprobe_multi_test/skel_api:FAIL
  #112/2   kprobe_multi_test/link_api_addrs:FAIL
  [...]
  #112     kprobe_multi_test:FAIL
  #356/17  test_global_funcs/global_func17:FAIL
  #356     test_global_funcs:FAIL

Further analysis shows llvm upstream patch [1] is responsible for the above
failures. For example, for function bpf_fentry_test7() in net/bpf/test_run.c,
without [1], the asm code is:

  0000000000000400 <bpf_fentry_test7>:
     400: f3 0f 1e fa                   endbr64
     404: e8 00 00 00 00                callq   0x409 <bpf_fentry_test7+0x9>
     409: 48 89 f8                      movq    %rdi, %rax
     40c: c3                            retq
     40d: 0f 1f 00                      nopl    (%rax)

... and with [1], the asm code is:

  0000000000005d20 <bpf_fentry_test7.specialized.1>:
    5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_test7.specialized.1+0x5>
    5d25: c3                            retq

... and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_test7>
and this caused test failures for #13/#77 etc. except #356.

For test case #356/17, with [1] (progs/test_global_func17.c)), the main prog
looks like:

  0000000000000000 <global_func17>:
       0:       b4 00 00 00 2a 00 00 00 w0 = 0x2a
       1:       95 00 00 00 00 00 00 00 exit

... which passed verification while the test itself expects a verification
failure.

Let us add 'barrier_var' style asm code in both places to prevent function
specialization which caused selftests failure.

  [1] https://github.com/llvm/llvm-project/pull/72903

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231127050342.1945270-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bpf/test_run.c                                     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0841f8d82419..478ee7aba85f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
 
 int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
 {
-	asm volatile ("");
+	asm volatile ("": "+r"(arg));
 	return (long)arg;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index a32e11c7d933..5de44b09e8ec 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -5,6 +5,7 @@
 
 __noinline int foo(int *p)
 {
+	barrier_var(p);
 	return p ? (*p = 42) : 0;
 }
 
-- 
2.43.0


