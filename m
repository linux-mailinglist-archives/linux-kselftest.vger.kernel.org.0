Return-Path: <linux-kselftest+bounces-13169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4990926FF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847DC28216F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C701A08CF;
	Thu,  4 Jul 2024 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5vZodhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900018637;
	Thu,  4 Jul 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075730; cv=none; b=RrC+xZVhALA9OBeP0YoIsOf6Ss45i64PwuFQ3Q4ABS7A+lkjtIfRcEWN21Zy/BqpFK8SlUIcOkB4lx/WwcESpG42AEqJ7XSFkbrZ400AHrX8zOiFqbKCCsKpDLSoLjf04o3L35drAzzfjllIRwcStwkNejLJZKC1CtjFc5SgFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075730; c=relaxed/simple;
	bh=LkRPX3ra3F+F5EKKI+sEIgNO5JK+F5Sff8fCHyJQoYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quuc6OY1RchAYKfCxD6pKCtXe97QhaNUiOI8OBppJQL8Ilde9adOz2IT3dUMn8SqhyXa190YPhB5bicmWQB1Xb6Nuwg5OqhymK1bTwMQ4JV8uFJYaOjCXdro5d8w2kK8wz7UsiAsnknsDVVvR2UFd6LrqnGwLexk33q2ikdV01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5vZodhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BEFC32786;
	Thu,  4 Jul 2024 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075729;
	bh=LkRPX3ra3F+F5EKKI+sEIgNO5JK+F5Sff8fCHyJQoYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5vZodhCSfdb2eeclOG61GjK/cOMW2JhOvXmUDPUY1UIPygePKTA7jgIgsXCoVaCD
	 HrbyBaYIbGxAqCZywTfYus50I/RLm10bs79gXKOnREamWSFRjULg4l/vHTuJ7Pi5AV
	 A5jhiT7f4TNDgFpbvinyVUj0kUkwvgIz/b39+bI5TRcLuabXuTY1AUvfGJBWQ4VPV2
	 ep0AzXYxvmosbqtcYiD2AHwbt4pc2HZlod8p81cVNOifdSU+Wl9/VgQOQC4+OO98IV
	 JJp1V8YED1SuiEDtxvO+s08u+EghwuE44DqZTbQQx8bfEkmxbslNMWD76sSUchGCdu
	 AaUFkTEZVFzyA==
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
Subject: [PATCH 5/6] selftests/bpf: Skip ENOTSUPP in ASSERT_OK_PTR
Date: Thu,  4 Jul 2024 14:48:05 +0800
Message-ID: <9f722006ec00357ecbc1ecfa02e7fcefbf297f90.1720075006.git.tanggeliang@kylinos.cn>
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

Although the "Segmentation fault" errors are fixed in the last commit,
run bpf_tcp_ca selftests (./test_progs -t bpf_tcp_ca) on a Loongarch
platform, still some other "ENOTSUPP" (-524) errors left since lacking
BPF trampoline on Loongarch:

'''
 test_dctcp:PASS:bpf_dctcp__open_and_load 0 nsec
 test_dctcp:FAIL:bpf_map__attach_struct_ops unexpected error: -524
 #29/1    bpf_tcp_ca/dctcp:FAIL
 test_cubic:PASS:bpf_cubic__open_and_load 0 nsec
 test_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
 #29/2    bpf_tcp_ca/cubic:FAIL
 #29/3    bpf_tcp_ca/invalid_license:OK
 test_dctcp_fallback:PASS:dctcp_skel 0 nsec
 test_dctcp_fallback:PASS:bpf_dctcp__load 0 nsec
 test_dctcp_fallback:FAIL:dctcp link unexpected error: -524
 #29/4    bpf_tcp_ca/dctcp_fallback:FAIL
 #29/5    bpf_tcp_ca/rel_setsockopt:OK
 test_write_sk_pacing:PASS:open_and_load 0 nsec
 test_write_sk_pacing:FAIL:attach_struct_ops unexpected error: -524
 #29/6    bpf_tcp_ca/write_sk_pacing:FAIL
 #29/7    bpf_tcp_ca/incompl_cong_ops:OK
 #29/8    bpf_tcp_ca/unsupp_cong_op:OK
 test_update_ca:PASS:open 0 nsec
 test_update_ca:FAIL:attach_struct_ops unexpected error: -524
 #29/9    bpf_tcp_ca/update_ca:FAIL
 test_update_wrong:PASS:open 0 nsec
 test_update_wrong:FAIL:attach_struct_ops unexpected error: -524
 #29/10   bpf_tcp_ca/update_wrong:FAIL
 test_mixed_links:PASS:open 0 nsec
 test_mixed_links:FAIL:attach_struct_ops_nl unexpected error: -524
 test_mixed_links:FAIL:attach_struct_ops unexpected error: -524
 #29/11   bpf_tcp_ca/mixed_links:FAIL
 test_multi_links:PASS:open 0 nsec
 test_multi_links:FAIL:attach_struct_ops_1st unexpected error: -524
 test_multi_links:FAIL:attach_struct_ops_2nd unexpected error: -524
 #29/12   bpf_tcp_ca/multi_links:FAIL
 test_link_replace:PASS:open 0 nsec
 test_link_replace:FAIL:attach_struct_ops_1st unexpected error: -524
 test_link_replace:FAIL:attach_struct_ops_2nd unexpected error: -524
 #29/13   bpf_tcp_ca/link_replace:FAIL
 #29/14   bpf_tcp_ca/tcp_ca_kfunc:OK
 test_cc_cubic:PASS:bpf_cc_cubic__open_and_load 0 nsec
 test_cc_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
 #29/15   bpf_tcp_ca/cc_cubic:FAIL
 #29      bpf_tcp_ca:FAIL
'''

Just like in ASSERT_OK(), this patch skips ENOTSUPP (524) and ENOTSUP (95)
in ASSERT_OK_PTR() too. With this change, the new output of bpf_tcp_ca
selftests look like:

'''
 #29/1    bpf_tcp_ca/dctcp:SKIP
 #29/2    bpf_tcp_ca/cubic:SKIP
 #29/3    bpf_tcp_ca/invalid_license:OK
 #29/4    bpf_tcp_ca/dctcp_fallback:SKIP
 #29/5    bpf_tcp_ca/rel_setsockopt:OK
 #29/6    bpf_tcp_ca/write_sk_pacing:SKIP
 #29/7    bpf_tcp_ca/incompl_cong_ops:OK
 #29/8    bpf_tcp_ca/unsupp_cong_op:OK
 #29/9    bpf_tcp_ca/update_ca:SKIP
 #29/10   bpf_tcp_ca/update_wrong:SKIP
 #29/11   bpf_tcp_ca/mixed_links:SKIP
 #29/12   bpf_tcp_ca/multi_links:SKIP
 #29/13   bpf_tcp_ca/link_replace:SKIP
 #29/14   bpf_tcp_ca/tcp_ca_kfunc:OK
 #29/15   bpf_tcp_ca/cc_cubic:SKIP
 #29      bpf_tcp_ca:OK (SKIP: 10/15)
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 25f6976c08b5..464aa12feada 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -369,7 +369,10 @@ int test__join_cgroup(const char *path);
 	const void *___res = (ptr);					\
 	int ___err = libbpf_get_error(___res);				\
 	bool ___ok = ___err == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %d\n", ___err);	\
+	if (___err == -ENOTSUPP || ___err == -ENOTSUP)			\
+		test__skip();						\
+	else								\
+		CHECK(!___ok, (name), "unexpected error: %d\n", ___err);\
 	___ok;								\
 })
 
-- 
2.43.0


