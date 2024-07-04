Return-Path: <linux-kselftest+bounces-13167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC54926FF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36F31F241F0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380BE1A08CB;
	Thu,  4 Jul 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCW5BT8J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040C1BC4E;
	Thu,  4 Jul 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075719; cv=none; b=Jl58RxRCixNGPsUNullDeLiSPPEK1RLzshfDCvmoEPAztmWHRZnM6qa9SJ23AHJIzAQMI5r/JDOcBOfuB1n8xmHV1bEwgeKWF7W0eqgm2607pb9jwRU2bU7h1TBGMJfCk5zeSKCbESlQFduEOihwuy/+GAPaQwu6omjqJpenyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075719; c=relaxed/simple;
	bh=i1hi7joj/cR8gtdNdPAzFDk5iX3Vay2ss48OzQh+0WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6g+kovITxgPmJjAPiI44RT2AZyEIEaEsmDFY3XfxkLyZmI7ZSwaxCQuc1VOEWAjmrKm5D2PoA6HaumogaWeOW1o/siTrHEzw2740oWPtTo7tFu8vL5Mz4ChDzfTCTjhOzVYflpqkp7FL5YEGUcwYW07GdWvR7DgL6qOa8Df8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCW5BT8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECC4C3277B;
	Thu,  4 Jul 2024 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075718;
	bh=i1hi7joj/cR8gtdNdPAzFDk5iX3Vay2ss48OzQh+0WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCW5BT8JRx4+ykZAMrR6B3ppEkyzF7zvFKm5F6ayh6uqlygaju0/bT9RaM3zYqaZi
	 ArP33Xl9QqTANgyi3MMQ26ciTL4Ic8v0m9eBmk98m05hb3LpyIwASY++MFa6fVCq6T
	 CC2vhrNUGTGyHkOnV0iMlUKskEdZxZAvR+gDlv1gMx8Nns/BhS5WD5p3sA/gANBjRp
	 X2ckX4cfNk4euIogSgL1J12590BIEb0ANHRwRfXBtVvNfahhQ9PJAxUUNhWVd+24zA
	 BqCpe+HsVeIAg/HwQreM8aweldZNcgrC8K3H2psmS7APbXmpYYWmYPXlfT7B9Y4lCU
	 IduESX622BUxA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/6] selftests/bpf: Use ASSERT_OK to skip ENOTSUPP
Date: Thu,  4 Jul 2024 14:48:03 +0800
Message-ID: <da8ce034fbb6b60095076a1829af1a98e7f028cc.1720075006.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720075006.git.tanggeliang@kylinos.cn>
References: <cover.1720075006.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There are so many "ENOTSUPP" (-524) errors when running BPF selftests
on a Loongarch platform since lacking BPF trampoline on Loongarch:

'''
 test_d_path_basic:PASS:setup 0 nsec
 libbpf: prog 'prog_stat': failed to attach: unknown error (-524)
 libbpf: prog 'prog_stat': failed to auto-attach: -524
 test_d_path_basic:FAIL:setup attach failed: -524
 #77/1    d_path/basic:FAIL
 #77/2    d_path/check_rdonly_mem:OK
 #77/3    d_path/check_alloc_mem:OK
 #77      d_path:FAIL
 ... ...
 test_module_attach:PASS:skel_open 0 nsec
 test_module_attach:PASS:set_attach_target 0 nsec
 test_module_attach:PASS:set_attach_target_explicit 0 nsec
 test_module_attach:PASS:skel_load 0 nsec
 libbpf: prog 'handle_fentry': failed to attach: unknown error (-524)
 libbpf: prog 'handle_fentry': failed to auto-attach: -524
 test_module_attach:FAIL:skel_attach skeleton attach failed: -524
 #167     module_attach:FAIL
 ... ...
 ringbuf_subtest:PASS:skel_open 0 nsec
 ringbuf_subtest:PASS:skel_load 0 nsec
 ringbuf_subtest:PASS:rw_cons_pos 0 nsec
 ringbuf_subtest:PASS:rw_extend 0 nsec
 ringbuf_subtest:PASS:exec_cons_pos_protect 0 nsec
 ringbuf_subtest:PASS:unmap_rw 0 nsec
 ringbuf_subtest:PASS:wr_prod_pos 0 nsec
 ringbuf_subtest:PASS:wr_prod_pos_err 0 nsec
 ringbuf_subtest:PASS:wr_data_page_one 0 nsec
 ringbuf_subtest:PASS:wr_data_page_one_err 0 nsec
 ringbuf_subtest:PASS:wr_data_page_two 0 nsec
 ringbuf_subtest:PASS:wr_data_page_all 0 nsec
 ringbuf_subtest:PASS:ro_prod_pos 0 nsec
 ringbuf_subtest:PASS:write_protect 0 nsec
 ringbuf_subtest:PASS:exec_protect 0 nsec
 ringbuf_subtest:PASS:ro_remap 0 nsec
 ringbuf_subtest:PASS:unmap_ro 0 nsec
 ringbuf_subtest:PASS:ro_prod_pos 0 nsec
 ringbuf_subtest:PASS:write_protect 0 nsec
 ringbuf_subtest:PASS:exec_protect 0 nsec
 ringbuf_subtest:PASS:ro_remap 0 nsec
 ringbuf_subtest:PASS:unmap_ro 0 nsec
 ringbuf_subtest:PASS:ringbuf_create 0 nsec
 ringbuf_subtest:FAIL:skel_attach skeleton attachment failed: -1
 #277/1   ringbuf/ringbuf:FAIL
 #277/2   ringbuf/ringbuf_n:SKIP
 #277/3   ringbuf/ringbuf_map_key:SKIP
 #277     ringbuf:FAIL
 ... ...
 test_test_bprm_opts:PASS:skel_load 0 nsec
 libbpf: prog 'secure_exec': failed to attach: unknown error (-524)
 libbpf: prog 'secure_exec': failed to auto-attach: -524
 test_test_bprm_opts:FAIL:attach attach failed: -524
 #382     test_bprm_opts:FAIL
 ... ...
 test_test_ima:PASS:skel_load 0 nsec
 test_test_ima:PASS:ringbuf 0 nsec
 libbpf: prog 'bprm_committed_creds': failed to attach: \
					unknown error (-524)
 libbpf: prog 'bprm_committed_creds': failed to auto-attach: -524
 test_test_ima:FAIL:attach attach failed: -524
 #384     test_ima:FAIL
 ... ...
 test_trace_ext:PASS:setup 0 nsec
 test_trace_ext:PASS:setup 0 nsec
 test_trace_ext:PASS:setup 0 nsec
 test_trace_ext:PASS:setup 0 nsec
 libbpf: prog 'test_pkt_md_access_new': failed to attach: \
					unknown error (-524)
 libbpf: prog 'test_pkt_md_access_new': failed to auto-attach: -524
 test_trace_ext:FAIL:setup freplace/test_pkt_md_access attach failed: -524
 #397     trace_ext:FAIL
'''

This patch uses ASSERT_OK() instead of CHECK() to skip these "ENOTSUPP"
errors. With this change, the new output of these selftests look like:

'''
 #77/1    d_path/basic:SKIP
 #77/2    d_path/check_rdonly_mem:OK
 #77/3    d_path/check_alloc_mem:OK
 #77      d_path:OK (SKIP: 1/3)
 ... ...
 #167     module_attach:SKIP
 ... ...
 #277/1   ringbuf/ringbuf:SKIP
 #277/2   ringbuf/ringbuf_n:SKIP
 #277/3   ringbuf/ringbuf_map_key:SKIP
 #277     ringbuf:SKIP
 ... ...
 #382     test_bprm_opts:SKIP
 ... ...
 #384     test_ima:SKIP
 ... ...
 #397     trace_ext:SKIP
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/d_path.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/module_attach.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c        | 2 +-
 tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/test_ima.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_ext.c      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..78110075b485 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -129,7 +129,7 @@ static void test_d_path_basic(void)
 		goto cleanup;
 
 	err = test_d_path__attach(skel);
-	if (CHECK(err, "setup", "attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "setup"))
 		goto cleanup;
 
 	bss = skel->bss;
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 6d391d95f96e..4aab747ad202 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -62,7 +62,7 @@ void test_module_attach(void)
 	bss = skel->bss;
 
 	err = test_module_attach__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "skel_attach"))
 		goto cleanup;
 
 	/* trigger tracepoint */
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 4c6f42dae409..ee7deb76b60a 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -161,7 +161,7 @@ static void ringbuf_subtest(void)
 		goto cleanup;
 
 	err = test_ringbuf_lskel__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
+	if (!ASSERT_OK(err, "skel_attach"))
 		goto cleanup;
 
 	trigger_samples();
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
index a0054019e677..40a86a303c1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
@@ -88,7 +88,7 @@ void test_test_bprm_opts(void)
 		goto close_prog;
 
 	err = bprm_opts__attach(skel);
-	if (CHECK(err, "attach", "attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "attach"))
 		goto close_prog;
 
 	/* Run the test with the secureexec bit unset */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index 810b14981c2e..2a6c388fe29d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -83,7 +83,7 @@ void test_test_ima(void)
 		goto close_prog;
 
 	err = ima__attach(skel);
-	if (CHECK(err, "attach", "attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "attach"))
 		goto close_prog;
 
 	measured_dir = mkdtemp(measured_dir_template);
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
index aabdff7bea3e..d006c0b91178 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -60,7 +60,7 @@ void test_trace_ext(void)
 	}
 
 	err = test_trace_ext__attach(skel_ext);
-	if (CHECK(err, "setup", "freplace/test_pkt_md_access attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "setup replace/test_pkt_md_access attach"))
 		goto cleanup;
 
 	prog = skel_ext->progs.test_pkt_md_access_new;
-- 
2.43.0


