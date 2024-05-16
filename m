Return-Path: <linux-kselftest+bounces-10277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD78C6FEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF901C2145B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7CA47;
	Thu, 16 May 2024 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqnRpEYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562F1366;
	Thu, 16 May 2024 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822053; cv=none; b=HatPA7XzFvQuz43/+sGcXSFWwEjAELU6tRzTlMP3zZHWGHYpa7ExlojOK+7yn6mmEmCcWKDV7SV/yzue3g4aqgQ3Ds3+SW8DBvq7cC0BdFtfjwltF9HJPr38t59FoJD/HJdP0ntFZRvXifU/RAxVazlSzFHFbvFrMucitLWlKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822053; c=relaxed/simple;
	bh=sTsEXtYpJEks91ezB9zAnTDOubi6UMJkQfgV9scEPS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzBHU1NJjVviuE9IBXhNLgyO6dksWcFn8UAiVI+eLxRBWhLhxYooNUtCJqD4MzBYEigUGl4XzsPKWB4TZV5Ii3pu/TmFnJU+q8y9rOgtqcCYgW0uDerpl/MEG6Vb9d3B8FfduneUwXUQ6WcRu/Ddw3eG9E3/h0xZsCIg3naiV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqnRpEYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEFBC4AF0F;
	Thu, 16 May 2024 01:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822053;
	bh=sTsEXtYpJEks91ezB9zAnTDOubi6UMJkQfgV9scEPS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqnRpEYuG3rHjsLM1rOjiJaMM93YMU3XE0hTNGeDIpjwguV0X5tcZQ3LbyvCDAzFb
	 EDmdwUOIXRAyFLTysqcy0OHacjINqL4IVEcczK6fxHNKG13L1a4gfVZIZ6XxPJiniM
	 dpSOZwJKav6+IIhQyIBrnjB7ppmHjZBmXWJsLE0nh+NTWjzG1Q9wDEEaTM4H3GT2nH
	 Jp9BMYzcjTrM8fleDTCO6lx9Us5r1wlbd6LMKLmqRH3z3BUFIo5WTM82KmjFbPIyS1
	 lpBszEIT8XM9zRaMCsUp4q+wBhz7WCeYM9eZX/WiQlNRCSxiUFCHGP6HyCAyzri24a
	 H5d8rEeaQBqoQ==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 6/8] selftests/bpf: Export cleanup_netns helper
Date: Thu, 16 May 2024 09:13:12 +0800
Message-ID: <480a636e822c9bc86e20add4ca20f58855ab6578.1715821541.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715821541.git.tanggeliang@kylinos.cn>
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new struct member name in struct nstoken, to save
the name of the given network namespace. It dups the name string in
open_netns() and freed in close_netns().

Then move cleanup_netns() from mptcp.c into network_helpers.c as a
public helper. In it the newly added name field is passed to command
"ip netns del" to delete this network namespace. This makes it more
flexible.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  8 -------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 5555b109899f..2293eac2dcec 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -444,6 +444,7 @@ char *ping_command(int family)
 
 struct nstoken {
 	int orig_netns_fd;
+	char *name;
 };
 
 struct nstoken *open_netns(const char *name)
@@ -459,6 +460,13 @@ struct nstoken *open_netns(const char *name)
 		return NULL;
 	}
 
+	token->name = strdup(name);
+	if (!token->name) {
+		log_err("Failed to dup name");
+		free(token);
+		return NULL;
+	}
+
 	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
 	if (token->orig_netns_fd == -1) {
 		log_err("Failed to open(/proc/self/ns/net)");
@@ -483,6 +491,7 @@ struct nstoken *open_netns(const char *name)
 fail:
 	if (token->orig_netns_fd != -1)
 		close(token->orig_netns_fd);
+	free(token->name);
 	free(token);
 	return NULL;
 }
@@ -494,6 +503,8 @@ void close_netns(struct nstoken *token)
 
 	if (setns(token->orig_netns_fd, CLONE_NEWNET))
 		log_err("Failed to setns(orig_netns_fd)");
+	if (token->name)
+		free(token->name);
 	close(token->orig_netns_fd);
 	free(token);
 }
@@ -526,6 +537,16 @@ struct nstoken *create_netns(const char *name)
 	return NULL;
 }
 
+void cleanup_netns(struct nstoken *token)
+{
+	if (!token)
+		return;
+
+	if (SYS_NOFAIL("ip netns del %s", token->name))
+		log_err("del netns %s failed", token->name);
+	close_netns(token);
+}
+
 int get_socket_local_port(int sock_fd)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5c0b082153fd..42d503a9f55e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -82,6 +82,7 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 struct nstoken *create_netns(const char *name);
+void cleanup_netns(struct nstoken *token);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int unshare_netns(void);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index abb4372114b6..c7f61fd9e7a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -79,14 +79,6 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
-static void cleanup_netns(struct nstoken *nstoken)
-{
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del %s", NS_TEST);
-}
-
 static int start_mptcp_server(int family, const char *addr_str, __u16 port,
 			      int timeout_ms)
 {
-- 
2.43.0


