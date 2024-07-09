Return-Path: <linux-kselftest+bounces-13364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971DB92B5B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EA31C21C2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF5156F41;
	Tue,  9 Jul 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BukPSD85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871F156C52;
	Tue,  9 Jul 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521945; cv=none; b=EwvyPW5mpmJ+0Z3F+mbJxNnm8XDSMxF8ursk9HcSIIaVev8TGlx3s+GRawvo3iDN/DNvVmFpUdfsHT6qqET7UYvRxfDL7h89zhHLP1V3TmoDFpC0E3n3Yu1DB6HvSFd81gFWoXUSxyXjhtfePpE4eU79EqTXRRg4UxWI7vN1F/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521945; c=relaxed/simple;
	bh=hmjwmTe8b1GB+C1d/4hMo/lqfZJ/M0EEE8YnVa0/e5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQh0jH/9PlMx3TMtYpBAh7vYcbotScofBT017IUtlon/wG7lut+/ql6CZSTfgkTh9/bFL1AKqCy8/PzlZe1l0tfdpVHDix9X+/u+/QqFVxofYiye2hBqVaw1wNhi45vogkmlUtzp8W2zPL4vkBIZD881jy0BZaQczRLelMewKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BukPSD85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641D3C4AF0A;
	Tue,  9 Jul 2024 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720521945;
	bh=hmjwmTe8b1GB+C1d/4hMo/lqfZJ/M0EEE8YnVa0/e5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BukPSD854xBfKLSX6uCP3ZDbOfxQP6dZ7lcUBgfBR4+56CpW1C37G+FlIKHn8Yjm0
	 0Qt6xX9pwHIHdxm4jrqJCkgb1jFy6dr00FmHNuaqZ6y6b82ocmWWJK6ovmLiP8n6H/
	 9OZh3P2DOceU9ZorqsGc0OIFUAhXZ8s5qafrFcUS9LVyJccpalzaYpTmMbqVhk4oNZ
	 9pmkHAP2fYyrpRnZWHae6e8QlBrnAvR/VxF4M0ZPFcwyG4tykOjgzIfBbILvdKJeS+
	 n4nrimdXGNIHyixqckZzdz/5inzsDuJN2OacCZUc0Wc2rid14A0amrQ2kQdl+a/sWp
	 3MRy6q/qVYT8g==
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
Subject: [PATCH bpf-next 2/3] selftests/bpf: Check ASSERT_OK(err) in dummy_st_ops
Date: Tue,  9 Jul 2024 18:45:07 +0800
Message-ID: <21fbc0db764656805340085ef2a77c8a770ef1d0.1720521482.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720521482.git.tanggeliang@kylinos.cn>
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Run dummy_st_ops selftests (./test_progs -t dummy_st_ops) on a Loongarch
platform, some "unexpected arg" errors occur:

'''
 #78/1    dummy_st_ops/dummy_st_ops_attach:OK
 test_dummy_init_ret_value:FAIL:test_ret unexpected test_ret: \
				actual 0 != expected 4076074229
 #78/2    dummy_st_ops/dummy_init_ret_value:FAIL
 #78/3    dummy_st_ops/dummy_init_ptr_arg:SKIP
 test_dummy_multiple_args:FAIL:arg 0 unexpected arg 0: \
				actual 0 != expected 7
 test_dummy_multiple_args:FAIL:arg 1 unexpected arg 1: \
				actual 0 != expected -100
 test_dummy_multiple_args:FAIL:arg 2 unexpected arg 2: \
				actual 0 != expected 35423
 test_dummy_multiple_args:FAIL:arg 3 unexpected arg 3: \
				actual 0 != expected 99
 test_dummy_multiple_args:FAIL:arg 4 unexpected arg 4: \
				actual 0 != expected 1311768467139281697
 #78/4    dummy_st_ops/dummy_multiple_args:FAIL
 #78/5    dummy_st_ops/dummy_sleepable:SKIP
 #78/6    dummy_st_ops/dummy_sleepable_reject_null:OK
 #78/7    dummy_st_ops/test_unsupported_field_sleepable:OK
 #78      dummy_st_ops:FAIL
'''

This is because BPF trampoline is not implemented on Loongarch yet,
bpf_prog_test_run_opts() returns ENOTSUPP.

This patch checks the return values of bpf_prog_test_run_opts() in
dummy_st_ops to fix these errors. If error returned, goto the newly
added label "out" to destroy the skel.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
index d3d94596ab79..a208801f524f 100644
--- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -41,9 +41,11 @@ static void test_dummy_init_ret_value(void)
 
 	fd = bpf_program__fd(skel->progs.test_1);
 	err = bpf_prog_test_run_opts(fd, &attr);
-	ASSERT_OK(err, "test_run");
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
 	ASSERT_EQ(attr.retval, 0xf2f3f4f5, "test_ret");
 
+out:
 	dummy_st_ops_success__destroy(skel);
 }
 
@@ -115,13 +117,15 @@ static void test_dummy_multiple_args(void)
 
 	fd = bpf_program__fd(skel->progs.test_2);
 	err = bpf_prog_test_run_opts(fd, &attr);
-	ASSERT_OK(err, "test_run");
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
 	args[0] = 7;
 	for (i = 0; i < ARRAY_SIZE(args); i++) {
 		snprintf(name, sizeof(name), "arg %zu", i);
 		ASSERT_EQ(skel->bss->test_2_args[i], args[i], name);
 	}
 
+out:
 	dummy_st_ops_success__destroy(skel);
 }
 
-- 
2.43.0


