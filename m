Return-Path: <linux-kselftest+bounces-13283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC692942C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A121F21F7D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517213A416;
	Sat,  6 Jul 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmoQHncS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A33811E0;
	Sat,  6 Jul 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277249; cv=none; b=tWuMnyVMdHamax4k0kd4RiiXWKuI/HH0B5jttA7T2Zn2szodCoXsFPo/0OhjwIbdrZLczWyd9sqQOJHqCKWpdKxcWcakrDpM+ZajjbWegoomgLwTt0O1ntbHovIr1r1Ll2Z8u1ORd1fTulLMvjTSwyRSOrOky1qarC573U1ZT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277249; c=relaxed/simple;
	bh=p/sQSZ6Ry7HCVEED0GCWFAhT5N2x1Y0pWGbUjY6YoeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmNhEkIWEdctOx3GSS1gXEbFdVTY5hF06I/Vpi1FzcqyOc+UuutRWrNWXgpdjA7Ah0dtZhhGtFzuxf/ydlfAtEkTSjzihHaGpRS8JReMxhYd5riM1i1OHDWFtYV10Y6LcccfzyWRzkMghgOJv6ie5g6qutGux1gz8rhbbo22qFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmoQHncS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E193BC4AF0E;
	Sat,  6 Jul 2024 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277248;
	bh=p/sQSZ6Ry7HCVEED0GCWFAhT5N2x1Y0pWGbUjY6YoeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmoQHncS3G6eOOs6kMq9Qt3P9feoahzE27ebgcvyAEjzWctestQm1O8XdNbi5KW5M
	 rBZxTn79+GluBXZZ//W1vcea7P8MPYJVfuWlgGRorZDbXFl0rlH0RMQvvInH7dd+SZ
	 ZbljCkd0urBeUdfO7uZ+wSjM9D0CucMpGbY6hidsd3P6F/P3imN623lZK6JSrdzClL
	 eTri2gAQJbagLhh/nTedkxIdhrlmF1QTx1drDzhhBusZ6gIEWDbyLcJptyWfNFdK+Y
	 GVmBOTqJnTtKwaxys3r3TmiHnamDqMY4Jy/Q1Zuu2mOhJTvC/MOOoByn9HnkBVxvme
	 FdY4zC2VSabmQ==
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
Subject: [PATCH bpf-next v9 07/11] selftests/bpf: Set expect_errno for cgroup_skb_sk_lookup
Date: Sat,  6 Jul 2024 22:45:52 +0800
Message-ID: <739486ce0d05a999c317ad6b21d3ef02cdca2a5f.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720276189.git.tanggeliang@kylinos.cn>
References: <cover.1720276189.git.tanggeliang@kylinos.cn>
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

To fix this, set EINPROGRESS as the expect_errno of network_helper_opts and
pass it to connect_fd_to_fd(). Skip this expect_errno when must_fail is
false too in connect_fd_to_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c                 | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_skb_sk_lookup.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index bcf142779cc6..0ef2e9a6f47c 100644
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
@@ -28,7 +29,7 @@ static void run_lookup_test(__u16 *g_serv_port, int out_sk)
 
 	/* Client outside of test cgroup should fail to connect by timeout. */
 	err = connect_fd_to_fd(out_sk, serv_sk, &opts);
-	if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd",
+	if (CHECK(err || errno != EINPROGRESS, "connect_fd_to_fd",
 		  "unexpected result err %d errno %d\n", err, errno))
 		goto cleanup;
 
-- 
2.43.0


