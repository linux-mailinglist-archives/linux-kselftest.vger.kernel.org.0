Return-Path: <linux-kselftest+bounces-8836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C828B196C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339D2B21D2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267D1D6A5;
	Thu, 25 Apr 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ4d0rNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6421CA89;
	Thu, 25 Apr 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015480; cv=none; b=PjFf3KwKRkztjAGWiU5OPGRZX4Pwzqd9oGfBCvEjAT7iQHC6bq5PCUxtQEiXfDxxDqXBMkCYOEmYozA+Gm/MLlSFRXz1EYkLeEAOEOQNi5qdMedENsgrkc8fgB35cSXQw3dZw7sqdgjK4VqYyBtse1WvG8rrQZViDP8vaDYkP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015480; c=relaxed/simple;
	bh=ftlF6ggg6QPRW/a7JZR+Yl+pkGyisHVYkvLGCWEDrs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFGz4fRc9mZG8iWQXGSt8WjbWSwq8mKLR1Z8ozNDevyHt4Aihql5p8O8mJlqCa/q8KVjOw+DfpnMlJX4H6Ef0k1WO34kZ2ewDLET7JhVbolnA7WXcWh48+7P6c/G1N4Pve6Roy3uNaEhJQSU4WoMo5p7VZ1e8PW9dMtSYc7WOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ4d0rNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09956C113CC;
	Thu, 25 Apr 2024 03:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015480;
	bh=ftlF6ggg6QPRW/a7JZR+Yl+pkGyisHVYkvLGCWEDrs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJ4d0rNGHLzzEjZMGxbt+cG+2S19D5eDwXh/JdrTDRwJ+r/QOpqEos38YlWno0iZv
	 KH9oguB9utfSuE4xH8JWL5jWmlqM2OfIDKAOSra+D+AJOCzX3cLeqla/bd6HnVekeT
	 69Rmj9LHF5uajqfBLfmLk/pqJSjdT8b2rALlfLjerpc7NIZMvQHZMaLRBl2hOBd5zo
	 Imdf+G5f+1wkJDso5z2LfHJDwt1mHT4ilzD+Obg7Eq9Ry3jaK+yNzUuBedxLqWBUn+
	 gwevGQxcvN0VBBsq2PvyDofotZVS8qwXTXr9Gs2nxcl36nO/4J0qGQeeRYMcf7Vkbl
	 KeLqjVoQHK26A==
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
Subject: [PATCH bpf-next 2/6] selftests/bpf: Make start_mptcp_server static
Date: Thu, 25 Apr 2024 11:23:42 +0800
Message-Id: <50ec7049e280c60a2924937940851f8fee2b73b8.1714014697.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714014697.git.tanggeliang@kylinos.cn>
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

start_mptcp_server() shouldn't be a public helper, it only be used in
MPTCP tests. This patch moves it into prog_tests/mptcp.c, and implenments
it using make_sockaddr() and start_server_addr() instead of using
start_server_proto().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c  |  7 -------
 tools/testing/selftests/bpf/network_helpers.h  |  2 --
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b9d204a1a480..4f16f7d6ce3f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -142,13 +142,6 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 	return start_server_proto(family, type, 0, addr_str, port, timeout_ms);
 }
 
-int start_mptcp_server(int family, const char *addr_str, __u16 port,
-		       int timeout_ms)
-{
-	return start_server_proto(family, SOCK_STREAM, IPPROTO_MPTCP, addr_str,
-				  port, timeout_ms);
-}
-
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5a8c5cf4ec1a..c62b54daa914 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -49,8 +49,6 @@ extern struct ipv6_packet pkt_v6;
 int settimeo(int fd, int timeout_ms);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
-int start_mptcp_server(int family, const char *addr, __u16 port,
-		       int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f84c74b87d23..3629d17b08ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -104,6 +104,22 @@ static void cleanup_netns(struct nstoken *nstoken)
 	SYS_NOFAIL("ip netns del %s", NS_TEST);
 }
 
+static int start_mptcp_server(int family, const char *addr_str, __u16 port,
+			      int timeout_ms)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms	= timeout_ms,
+		.proto		= IPPROTO_MPTCP,
+	};
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+
+	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
+		return -1;
+
+	return start_server_addr(SOCK_STREAM, &addr, addrlen, &opts);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
-- 
2.40.1


