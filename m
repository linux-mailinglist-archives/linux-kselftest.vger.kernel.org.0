Return-Path: <linux-kselftest+bounces-7933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D560D8A480D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40266B21D4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249129B0;
	Mon, 15 Apr 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhOUIsaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFA1CF8A;
	Mon, 15 Apr 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162702; cv=none; b=oVbG8+F9H0bPoSpGZAILMAt1ct6J2S9WX3A3PADUiZV80rwAUS+q4gGSyf1g8768YiDjP+zP31XAEr6a7u8OddtAt6wA7hOUjQR/CEDhekH0PnFElBtFoSZJzziEqo9p0WT3he4VaYQknWPrhwVFWTbFBfsnMba6EPi2zo4PeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162702; c=relaxed/simple;
	bh=fKbXIiKuYssY4VB9Gno3DXKEvI8risDYWZFnED80jcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryADD2ASKHlY08CcjF8kTs4+ivxQeq9idZZnk0SKWbrMUKxpkWi9JRriCcMWuLZhXN/Fd1LInJE/2wVYr1TKCggKebTKc8Z89TYR+ZiGYJh12lcCuDFkcD8k7KnwX26tORRadA8VItLPkFybWC2Nomr4D+cmnXggp935P8sX0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhOUIsaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C992C113CC;
	Mon, 15 Apr 2024 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162702;
	bh=fKbXIiKuYssY4VB9Gno3DXKEvI8risDYWZFnED80jcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhOUIsaWZfsRh6b0uWNP+V/46kLR+ImeFMIcGXkWCLz7nKT9avbw9zC4gMYUgpKXv
	 L09+gevU8DzXUklHalFBqgoRdhUuStesPiyoqDNSXjuDH72j8CWKBt4h/uyYFB9vS1
	 tgeg/bMbe7PKnO/T3EMoZy/NNzrjZ9IhJa9Gs2L6p/DF+DZ5SO2pTE2D4TIX391r+d
	 +5B9dLjQIf4htR0kFLI548Ut1oCyORy6CAUzPnNcsMY4OtOM8xc4wUn8iOau3EYiq1
	 WWRyXwLuoXhpFHeJhaiquxJdRAK1h32g/YVP8N6bUZ6tgNmUDoMVLb+Zc0vYdI67GV
	 KOWstHp3+8sNw==
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
Subject: [PATCH bpf-next v3 2/9] selftests/bpf: Add start_server_addr* helpers
Date: Mon, 15 Apr 2024 14:31:11 +0800
Message-Id: <b91517285bb6c53225d4b92f543b3e819d109113.1713161975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713161974.git.tanggeliang@kylinos.cn>
References: <cover.1713161974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to pair up with connect_to_addr(), this patch adds a new helper
start_server_addr(), and another one start_server_addr_opts(), which is
a wrapper of __start_server(), only added a network_helper_opts arg at
the end.

They all accept an argument 'addr' of 'struct sockaddr_storage' type
instead of a string type argument like start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 3759948439a7..92c980b18afd 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -185,6 +185,22 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
+int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
+			   const struct network_helper_opts *opts)
+{
+	return __start_server(type, 0, (struct sockaddr *)addr, len,
+			      opts->timeout_ms, 0);
+}
+
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = 0,
+	};
+
+	return start_server_addr_opts(type, addr, len, &opts);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ac4da5fdcc95..9e6fcc89a8d0 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -53,6 +53,9 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
+int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
+			   const struct network_helper_opts *opts);
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


