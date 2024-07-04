Return-Path: <linux-kselftest+bounces-13170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB9926FF7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82157B2176C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A01A08D7;
	Thu,  4 Jul 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/5m3n9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939451B960;
	Thu,  4 Jul 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075735; cv=none; b=tygyZ5js7IKgpeAic5hXrB+vLLxkla0Vwf70a4XrpQN3QjfQoBrCpk4IRvsVIWFoCpl8rfTa9byuUmalUdYOuoqFRBeirM5cGzjUFeMzAZf667nJwIv0weFytealD3oL5INCnSOrWxMIwww+yss6MG+n/anx0lkBkKiNe4GQfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075735; c=relaxed/simple;
	bh=2KyYRBPPd7WUDhqBRx2b+SOyUf0G1E0Hbgwa4AS/ZC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6L9GOt0rYrwm7PC49K8MasAE7CbFfto2SD7VkjhLVUIrTadI3Y2dw67xGHyvhxpX8vIL+Pu6dDpSKRoiBMQW40f372ZtL3vbf7M5HCrLOZH+jL6B7EoyjCjBk+kHSZJyhJ3B8VXA2q8ifvdffzjJH7juxJrLaW/RrfgjH6ilCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/5m3n9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5B5C3277B;
	Thu,  4 Jul 2024 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075735;
	bh=2KyYRBPPd7WUDhqBRx2b+SOyUf0G1E0Hbgwa4AS/ZC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/5m3n9FxrruGU7mWfhgHKx+XGzQTP6+BN5Ne4yUNROzXQfuSCAJdlL1QGxhq8u19
	 dLDXd/RpwinkpuglYdeEf7EGxOTi6zMJDRZeeiYAJdk2zoU7MuIOtcnclvb9mPzt2L
	 Q/+HxN6v2kq48kB4BYd3CvxjhVIEB1VvHbYmC1r4cnzM6w8uaUbt797EICm0EwIOoh
	 Z5+ETRSn7GtFk31rzOvMy3qupN/ocetzjXY6BbpfCbmIOEckJrY+snPjf3jcj5AW1V
	 jpZ4q7TgYld9FJPC7pUSZ+nmPjhb65jYQR6kKYs96J6DhiS4fSMfqu8r7qw2a0qc7R
	 tcR9DhGStEL5A==
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
Subject: [PATCH 6/6] selftests/bpf: Skip ENOTSUPP in ASSERT_GE
Date: Thu,  4 Jul 2024 14:48:06 +0800
Message-ID: <a4e9f830d9e10de3ce5c56d0e15fcc0f209aa089.1720075006.git.tanggeliang@kylinos.cn>
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

There are still some "ENOTSUPP" (-524) errors left when running BPF
selftests on a Loongarch platform since ASSERT_GE() are used there to
check the return values, not ASSERT_OK():

'''
 test_bpf_cookie:PASS:skel_open 0 nsec
 #17/1    bpf_cookie/kprobe:OK
 #17/2    bpf_cookie/multi_kprobe_link_api:OK
 #17/3    bpf_cookie/multi_kprobe_attach_api:OK
 #17/4    bpf_cookie/uprobe:OK
 #17/5    bpf_cookie/multi_uprobe_attach_api:OK
 #17/6    bpf_cookie/tracepoint:OK
 #17/7    bpf_cookie/perf_event:OK
 tracing_subtest:FAIL:fentry.link_create unexpected fentry.link_create: \
						actual -524 < expected 0
 #17/8    bpf_cookie/trampoline:FAIL
 lsm_subtest:FAIL:lsm.link_create unexpected lsm.link_create: \
						actual -524 < expected 0
 #17/9    bpf_cookie/lsm:FAIL
 #17/10   bpf_cookie/tp_btf:OK
 #17/11   bpf_cookie/raw_tp:OK
 #17      bpf_cookie:FAIL
 ... ...
 test_module_fentry_shadow:PASS:load_vmlinux_btf 0 nsec
 test_module_fentry_shadow:PASS:get_bpf_testmod_btf_fd 0 nsec
 test_module_fentry_shadow:PASS:btf_get_from_fd 0 nsec
 test_module_fentry_shadow:PASS:btf_find_by_name 0 nsec
 test_module_fentry_shadow:PASS:btf_find_by_name 0 nsec
 test_module_fentry_shadow:PASS:bpf_prog_load 0 nsec
 test_module_fentry_shadow:FAIL:bpf_link_create unexpected \
				bpf_link_create: actual -524 < expected 0
 #168     module_fentry_shadow:FAIL
'''

Just like in ASSERT_OK(), this patch skips ENOTSUPP (524) and ENOTSUP (95)
in ASSERT_GT() too. With this change, the new output of these selftests
look like:

'''
 #17/1    bpf_cookie/kprobe:OK
 #17/2    bpf_cookie/multi_kprobe_link_api:OK
 #17/3    bpf_cookie/multi_kprobe_attach_api:OK
 #17/4    bpf_cookie/uprobe:OK
 #17/5    bpf_cookie/multi_uprobe_attach_api:OK
 #17/6    bpf_cookie/tracepoint:OK
 #17/7    bpf_cookie/perf_event:OK
 #17/8    bpf_cookie/trampoline:SKIP
 #17/9    bpf_cookie/lsm:SKIP
 #17/10   bpf_cookie/tp_btf:SKIP
 #17/11   bpf_cookie/raw_tp:SKIP
 #17      bpf_cookie:OK (SKIP: 4/11)
 ... ...
 #168     module_fentry_shadow:SKIP
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 464aa12feada..8a5ce360aa1c 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -294,9 +294,13 @@ int test__join_cgroup(const char *path);
 	typeof(actual) ___act = (actual);				\
 	typeof(expected) ___exp = (expected);				\
 	bool ___ok = ___act >= ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld < expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
+	if (___act == -ENOTSUPP || ___act == -ENOTSUP ||		\
+	    errno == ENOTSUPP || errno == ENOTSUP)			\
+		test__skip();						\
+	else								\
+		CHECK(!___ok, (name),					\
+		      "unexpected %s: actual %lld < expected %lld\n",	\
+		      (name), (long long)(___act), (long long)(___exp));\
 	___ok;								\
 })
 
-- 
2.43.0


