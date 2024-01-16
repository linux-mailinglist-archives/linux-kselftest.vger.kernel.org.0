Return-Path: <linux-kselftest+bounces-3106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680D82F61A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07180B2492C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8C25112;
	Tue, 16 Jan 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW9iiJiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21752510C;
	Tue, 16 Jan 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434229; cv=none; b=F9oVrXjYDiW+a/rhJOberFZxJjtHicC2Q0VgeoFPFBjxOLy9ZQHCkoVJOqMu3JXHka1PuWGGjN982RZ9shbjme43aK6feQLoLzkpwX6lt/DmxHc2Cps6r2ZvwWm7SWfzN5ghdCPMhHgHStmNaHPag811H4QFiAZRalhua927rF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434229; c=relaxed/simple;
	bh=mUAolhT90PS6HB4l7OMtqRqj16CKTUGvgr60pwrce5I=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WFWS9H+qdmcaqnM9HtJ0pVNPFk/Qp34C/FJEZfIRvMVjaBURBNGlevBmy1g09BpPsU/QxIeriHa8DKtIOtl83RnO7w7TiOLp8HneOQvfn4ZmFLqsdOtFi665vVZ1BaMp4Oo9ge07rLnAI/L6lLe6PzsITVdD0liL59MD/xEjyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW9iiJiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F91C433F1;
	Tue, 16 Jan 2024 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434229;
	bh=mUAolhT90PS6HB4l7OMtqRqj16CKTUGvgr60pwrce5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uW9iiJiqkajnVfvFtgsT74ahpKdkUhm+kse2tT/lrRRzWAYBtjbrCoEZJdFEt1z9w
	 ZY03P9mhiNT0MV8tjFoClR2Fs6YVcXZFeaBBz2TQM7Vo1WgeF4FaMxeXunmCFCBpxq
	 P+gLVxorzk7r6NMMqJd8L96e6IwpHuqLsNRL+1ksakpgHUH6+wAu9ME3mZ0V7YJTk7
	 ZyqSm3FAI0vzpawu6Q7ob0N32z3cNcw42hsLO79oP7uf3Ki79vxln5Kyich418xXuQ
	 NrAW0K21wAApvjK9FQiY3T7lOs2gO/4dmqk24BpmhDF8h6h6m3UqArvB9VdlFYmOlx
	 0zKDu6LWi+nXA==
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
Subject: [PATCH AUTOSEL 6.7 031/108] bpf: Fix a few selftest failures due to llvm18 change
Date: Tue, 16 Jan 2024 14:38:57 -0500
Message-ID: <20240116194225.250921-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index c9fdcc5cdce1..711cf5d59816 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -542,7 +542,7 @@ struct bpf_fentry_test_t {
 
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


