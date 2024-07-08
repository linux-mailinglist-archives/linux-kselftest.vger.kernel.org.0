Return-Path: <linux-kselftest+bounces-13299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E97929AD8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A63B20CDA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A73803;
	Mon,  8 Jul 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbobls9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF676AAD;
	Mon,  8 Jul 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405851; cv=none; b=SEmtcfN7+FrJ1ewGsAgSgXzlIlgxfzTqfbgGmcU1BkA568WcOzypjEPlAiOKvUbzci/l63qrTJPni8eRiwZ2hMiwwtw2ksjAEKKBhrcn1OEr/iSywQnS4TByT1WkV3LIEfzSQimqxdVp9IwFSyjCQfyK8AgenC0UwyD990sUnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405851; c=relaxed/simple;
	bh=lWhh21S3N9IZn9P4yBZQ2+ZX9zmh3TrRV2vGlW4M73g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U44jNU3oFx3fyusyc00MnhOs3jwPuXVGQPu60IEmOYNOQuyWHFOgPmDXVd+xwYBzpi8LZvTzxlJEMMDvYermdJiyakWfQBCxbRyKAFss3qRJLa4SRjyi3q2LbU8fn+CDW9192vSBqF3x8eehkiMKeTNcN278Bn6XN2D70ztRsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbobls9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DC4C4AF0C;
	Mon,  8 Jul 2024 02:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405851;
	bh=lWhh21S3N9IZn9P4yBZQ2+ZX9zmh3TrRV2vGlW4M73g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbobls9CLf0uz2iw5QK/JT/gnGKBFgse7q2dLofHQlVxLa4NbHFqJynhFvu53NtB/
	 +7SFNwfrxD/QaAic96e9oA6TB8Yylx/y924mnyyhdLn9MR6p+v8btGcFV9NPEz7PRi
	 q+TqlJDSal9yrxZfnSWgaHw8chcrPLwF//Ol3CuExh+caLzJC69eOmpY2bAxo7BiyI
	 BQRPcmOYoZB8pGO1JR63W0aKnvnpAxE5rgjAcgzK6JrQIpoG61wD+jWsaWMP0zWYbU
	 gDE0luEnU2HydBkStU0HVlWXQmuGvcpufGrULbtD+8fDFuETfZ3BKsW5zlLYgevIeX
	 LoKC3QG02FvQg==
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
Subject: [PATCH bpf-next v10 07/12] selftests/bpf: Set expect_errno for cgroup_skb_sk_lookup
Date: Mon,  8 Jul 2024 10:29:45 +0800
Message-ID: <49c13acb05e74e13b1a20c8bbb89d26376ffbf11.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

EINPROGRESS is skipped in run_lookup_test() in cgroup_skb_sk_lookup
tests, but it is still showed in the log:

 ./test_progs -t cgroup_skb_sk_lookup -v

 run_cgroup_bpf_test:PASS:skel_open_load 0 nsec
 run_cgroup_bpf_test:PASS:cgroup_join 0 nsec
 run_cgroup_bpf_test:PASS:cgroup_attach 0 nsec
 run_lookup_test:PASS:start_server 0 nsec
 run_lookup_test:PASS:getsockname 0 nsec
 (network_helpers.c:300: errno: Operation now in progress) Failed to \
                                                connect to server
 run_lookup_test:PASS:connect_fd_to_fd 0 nsec
 run_lookup_test:PASS:connect_to_fd 0 nsec
 run_lookup_test:PASS:accept 0 nsec
 #51      cgroup_skb_sk_lookup:OK

To fix this, set EINPROGRESS as "expect_errno" of network_helper_opts and
pass it to connect_fd_to_fd(). Skip this expect_errno when must_fail is
false too in connect_fd_to_addr().

connect_fd_to_fd() returns "0" when connect() fails but "expect_errno"
matched. So "err" is "0" after invoking connect_fd_to_fd() in
run_lookup_test(). "err = -errno" is needed to get the real error number
before checking value of "err".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c                 | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 062170d6be1c..1403487c5921 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -296,7 +296,7 @@ static int connect_fd_to_addr(int fd,
 			return -1;
 		}
 	} else {
-		if (ret) {
+		if (ret && errno != expect_errno) {
 			log_err("Failed to connect to server");
 			return -1;
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
index bcf142779cc6..cce6ca45b2b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c
@@ -10,6 +10,7 @@ static void run_lookup_test(__u16 *g_serv_port, int out_sk)
 {
 	struct network_helper_opts opts = {
 		.timeout_ms	= 1000,
+		.expect_errno	= EINPROGRESS,
 	};
 	int serv_sk = -1, in_sk = -1, serv_in_sk = -1, err;
 	struct sockaddr_in6 addr = {};
@@ -28,6 +29,8 @@ static void run_lookup_test(__u16 *g_serv_port, int out_sk)
 
 	/* Client outside of test cgroup should fail to connect by timeout. */
 	err = connect_fd_to_fd(out_sk, serv_sk, &opts);
+	if (!err)
+		err = -errno;
 	if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd",
 		  "unexpected result err %d errno %d\n", err, errno))
 		goto cleanup;
-- 
2.43.0


