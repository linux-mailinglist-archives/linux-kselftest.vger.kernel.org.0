Return-Path: <linux-kselftest+bounces-13215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF9928088
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8917282C91
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882031C2AF;
	Fri,  5 Jul 2024 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqyjCll+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616581B806;
	Fri,  5 Jul 2024 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147142; cv=none; b=MQzjHxjlmGWc3Ls7KouhmN115knkC/8vQdtVbGoEesK0pvYTWC4F0K8kWsA7WTyQPfU6I+CeWpMZuhCOqa6Q5/3aVazx3SP60TnNnkIA4xbyYfyXpwGncIWna+7qKdyzXz528Oiwg0cy4b6M0/chWaEaXF/YBnpLpjqQmMb3Tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147142; c=relaxed/simple;
	bh=1q0Y6eR9fPAn25xOW5l3zjA07KMqKEtZTGbvv/DMTLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5UiWl3+odHS2/i8/eVIoetPQTeNTemDkzt5ruj5m+uXm1kjwc6DRjqZXkv7si9h4wcmyTHRUUlA2RHGyT87b5k0suV8Hwgo8HQmJ1kVTnFZptZGJEXCCodw0lXI3EgBHwO24b96GerT2jtFmpP1VIpK7ZckanyiZDNFHVoafk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqyjCll+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D38C32781;
	Fri,  5 Jul 2024 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720147142;
	bh=1q0Y6eR9fPAn25xOW5l3zjA07KMqKEtZTGbvv/DMTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqyjCll+WaAHyuoder70ker4LSeYfwC83eraeoJTdAz0oyQjcvHqiXMtT1FsAi/9/
	 2LS7FUS0ljiD78uqFgpF5zJlnc/4Ig3xGyj1xXvZcgDOQNKtiRKNUN+kRa05d9XdHu
	 SH6VCAq6nI8+MeM+Tap9GYOD8dspml1Yu3In7woo0o4vrAm1iNFz4TNYmAfcjX2p8t
	 15TJRyYTXkYT09zoPnPQ8ytEPn3FypYJQsSg7xUaLekDYPv8W+yzJZ81jo4hTojGxT
	 Bu8p/Mz7790kP+gcAUMdiIBVwqIYJgrp+yOcIkmgJK6MMGkiIYY+tGWg2MlSSswRxR
	 YKrc7L0Crb9jQ==
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
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Skip ENOTSUPP in ASSERT_GE
Date: Fri,  5 Jul 2024 10:38:24 +0800
Message-ID: <6c02ba53501c3a9b6b160da49c62a0a1bbf25c8a.1720146231.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720146231.git.tanggeliang@kylinos.cn>
References: <cover.1720146231.git.tanggeliang@kylinos.cn>
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

Just like in ASSERT_OK(), this patch uses test_progs_get_error() helper
to skip ENOTSUPP (524) and ENOTSUP (95) in ASSERT_GT() too.

With this change, the new output of these selftests look like:

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
 tools/testing/selftests/bpf/test_progs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 8ca6cd970676..fe6e20df97d2 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -311,9 +311,10 @@ static inline int test_progs_get_error(int error)
 	typeof(actual) ___act = (actual);				\
 	typeof(expected) ___exp = (expected);				\
 	bool ___ok = ___act >= ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld < expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
+	if (test_progs_get_error(___act))				\
+		CHECK(!___ok, (name),					\
+		      "unexpected %s: actual %lld < expected %lld\n",	\
+		      (name), (long long)(___act), (long long)(___exp));\
 	___ok;								\
 })
 
-- 
2.43.0


