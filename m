Return-Path: <linux-kselftest+bounces-13214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF50928086
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A841F2308E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401D2BB10;
	Fri,  5 Jul 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcHtFyiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C612B87;
	Fri,  5 Jul 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147137; cv=none; b=FvqPzYflMHC2TVggwCeK+pG4bUB9QWoCA/B0Hc5DeuBqtT8SqTeVFkg9vEGkSoBAvgMhc9AHljWPKGUpmm3nKG5A0SC37YPgKBeHaws9nExIa3/JOCM5dX90ig7Pp8iX9QgXplYMHlnqFXLfo38ASn9iSDE2NCdXr5bh2XwmkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147137; c=relaxed/simple;
	bh=dKjXYrjBHTYDa4TZU2xrDDcJ7V8V4cU0S61NnuA1hYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVjkOBtowa5R3ZZynsHP7b0heeapNiFD1nCHbLU3v9c6XxWf0zNRLYXOMw/D1jVsE6zoRdvtoDgUlaNQsx21fFAhqx+AZxWpQLoH3UkMfh39YREJfKpYZK5H2FznqxyppR+6iHwstTEEb+f2+58z1C9uFfNIbdC+wFG/4RJMRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcHtFyiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0AC4AF0A;
	Fri,  5 Jul 2024 02:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720147137;
	bh=dKjXYrjBHTYDa4TZU2xrDDcJ7V8V4cU0S61NnuA1hYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcHtFyiDwv3qp7YyYVyQjvhuzVxG2C3plv/TRqgKYUML6cU3dG9Eg+RcDwGLsiGSD
	 RG7C/qDPeHC/z0QASnwshXvJMpkvvCJAwwTbPmdopKGVoxZGEXAIDNJNes9VLlYo93
	 UFTspDU95rWHLnwoJhIb78sPTHqpQi1is7qlhiDqn3TI+m8Ic+AFTJ2+/VB/n16hrT
	 ZFduEkI5KpPntTZ7DDocHQw75AmA94FYTM2ELcrjkDyi2KpIYJOcXPXOZtGEC5W/xB
	 5mjaEDVwxlF5am0CweTMOf2SqHfqeYUrF5/4wuRKnQ9VFLDAj+zHC4iukvYna4yNLh
	 aa14nW+dO1d1w==
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
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Skip ENOTSUPP in ASSERT_OK_PTR
Date: Fri,  5 Jul 2024 10:38:23 +0800
Message-ID: <786005b19c3700f531bf998cdd75dd8a3a3f2aa7.1720146231.git.tanggeliang@kylinos.cn>
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

Just like in ASSERT_OK(), this patch uses test_progs_get_error() helper
to skip ENOTSUPP (524) and ENOTSUP (95) in ASSERT_OK_PTR() too.

With this change, the new output of bpf_tcp_ca selftests look like:

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
 tools/testing/selftests/bpf/test_progs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index d1d77785b165..8ca6cd970676 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -383,7 +383,8 @@ static inline int test_progs_get_error(int error)
 	const void *___res = (ptr);					\
 	int ___err = libbpf_get_error(___res);				\
 	bool ___ok = ___err == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %d\n", ___err);	\
+	if (test_progs_get_error(___err))				\
+		CHECK(!___ok, (name), "unexpected error: %d\n", ___err);\
 	___ok;								\
 })
 
-- 
2.43.0


