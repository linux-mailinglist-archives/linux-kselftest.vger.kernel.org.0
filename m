Return-Path: <linux-kselftest+bounces-8296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDC8A949F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4056B1C20444
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBD7CF2B;
	Thu, 18 Apr 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9/GJ7IO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618667C0A9;
	Thu, 18 Apr 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427769; cv=none; b=ltCXdNPjhorTDuJo9Xl1iqCgJqcU7FgIlQuZhgy4awD3ughhQPocT1yHHePuURFbCH/Iig2wrXs1Api1+0Cj2HrIQ6bKALcj8Y1JvWQOyPepj/EJZm/+GRQVmEG4FWFN/UnOe0v2E5jid58tzRViDGP0S9e/rjPjVRssiEJxsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427769; c=relaxed/simple;
	bh=WPm2h8eyE3bVx1N5ABzgZr9oeKDMOQvnoUrj86zfFTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oI6C0MV/CVNIpGvdjvaad6BT3HtIAZWmUl5tqrhD1Dx3OZZ6pdC8omZwMtF47UjO0eo2yMnE8rN2DfdmoGwqW0kFOHyOHFpSXb4cUjOzwKABNEqLhAlz1pZ3PHyl/KUcfnecWqx6myoQHBioQGwKdp+AhF638EdcBkwQWDNAjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9/GJ7IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C6C32782;
	Thu, 18 Apr 2024 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427769;
	bh=WPm2h8eyE3bVx1N5ABzgZr9oeKDMOQvnoUrj86zfFTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9/GJ7IO/M2+V1XjDEXrpkeOI4F+QEKIqutnTgE0p0wtN7hcW4gO+RmE6RoaTmWYr
	 tNzudWXSaP6CHU6UhzBQSj9+04uM2cpx0YpI1hXfAq5rVb6s7MWMAd1PmbS7ofCSIo
	 vQuFAeZdEUYND8jhdsYsbwZj0B9XWzbh9SGE+6GKiVchrp8e6vkQEfiMok8I/hdaSr
	 P2HzsEbxXpgmBhCQ8Ibo87K8uynbOUdbGZa9BUzWNP18TW42VFUC/2aXIdYaM4trRF
	 GdKLvlWhFmAeKYAFSi9vD9CJpwBrNXG8AIffrwaE4oH1Y+vYotBkiTqaerNZOuJ/J1
	 a/nV4+W17vnnQ==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v5 1/6] selftests/bpf: Add start_server_addr helper
Date: Thu, 18 Apr 2024 16:09:07 +0800
Message-Id: <2f01d48fa026467926738debe554ac452c19b86f.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to pair up with connect_to_addr(), this patch adds a new helper
start_server_addr(), which is a wrapper of __start_server(). It accepts
an argument 'addr' of 'struct sockaddr_storage' type instead of a string
type argument like start_server(), and a network_helper_opts argument as
the last one.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 14 ++++++++++++--
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index dc1fd7af9c7a..28fe8367451b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -52,6 +52,8 @@ struct ipv6_packet pkt_v6 = {
 	.tcp.doff = 5,
 };
 
+static const struct network_helper_opts default_opts;
+
 int settimeo(int fd, int timeout_ms)
 {
 	struct timeval timeout = { .tv_sec = 3 };
@@ -185,6 +187,16 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+		      const struct network_helper_opts *opts)
+{
+	if (!opts)
+		opts = &default_opts;
+
+	return __start_server(type, 0, (struct sockaddr *)addr, len,
+			      opts->timeout_ms, 0);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
@@ -278,8 +290,6 @@ int connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen, int
 	return -1;
 }
 
-static const struct network_helper_opts default_opts;
-
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 70f4e4c92733..414ea50bb3fc 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -53,6 +53,8 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


