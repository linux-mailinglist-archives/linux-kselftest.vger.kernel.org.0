Return-Path: <linux-kselftest+bounces-10238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719838C6083
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E407C1F23A66
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B73FE2A;
	Wed, 15 May 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUvxgOyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C83C485;
	Wed, 15 May 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752850; cv=none; b=RDRtZYMDjeA/HMrkCT7lq48nk5M+mDKS1F9+fzX9NLP9zrNquUnSTOOCILwKThiBGkylQsYEw91QAig4nc69QxuzUp6xGgKgBKOsh2T9ShMP4tQHyBvhdKuM/VOXYHf7chxzMpA2Epdg0cYjahbi7e2LTsp6GY3TokgrLx2c/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752850; c=relaxed/simple;
	bh=gFtH4vnhvrfgIng/oPWR939UW+4mcOZR1dqwqPB1/OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/tZYWMxG22O1fWzYOH6ih7OeMTvWyqqYiJzBkneWDGZP9b2KlcqfLf/Sen5D00Ps8xnySpBuoUbZUopU5N0lrnTErYXRXHV3krVks+R8zupQJLf5KH5OGBZzkxd+UngzSfqWxVgj8vUWlA8Za3WdoP3/4aHJuII2W0FgWgfHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUvxgOyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E165EC2BD11;
	Wed, 15 May 2024 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752850;
	bh=gFtH4vnhvrfgIng/oPWR939UW+4mcOZR1dqwqPB1/OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUvxgOyLLHPR+caBSyHmck15JG/v5z52QqNDZ5fH0b3kjMCegUH2U6Z7geIdCWQ0Y
	 ZLUw0mD7HW61egojkquUrsP2TLg6VExE8MeAEk8QNoXRNB+AOX9bUyMZULcoRCV5nQ
	 RUlQ0JhDMFQVOPRuvjW7AZvQ+So0/FPBKJluoxoOXkdHAxm8SgzzJM8MKieTyxbiI4
	 DHtvlAg2thTuDR852Xg3zgBIwccsVjEhOy9N5Ag+Qy3bJMXEOMQSB3EnrT/BSB7MeM
	 eZ4c+znMFM181OWG0OjYUIywNs01DZYkBcU/IaRd/P/FMs0JMRWXWdxy+Xnznn0QS/
	 DFTqo1mNFMKPw==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 6/9] selftests/bpf: Export cleanup_netns helper
Date: Wed, 15 May 2024 13:59:33 +0800
Message-ID: <c0eeecb2628a136bb23d9fa62d259e08fcddb26d.1715751995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715751995.git.tanggeliang@kylinos.cn>
References: <cover.1715751995.git.tanggeliang@kylinos.cn>
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
index c115aeca0a66..0b25b008f4f6 100644
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
@@ -494,10 +503,22 @@ void close_netns(struct nstoken *token)
 
 	if (setns(token->orig_netns_fd, CLONE_NEWNET))
 		log_err("Failed to setns(orig_netns_fd)");
+	if (token->name)
+		free(token->name);
 	close(token->orig_netns_fd);
 	free(token);
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
 struct nstoken *create_netns(const char *name)
 {
 	struct nstoken *token = NULL;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5c0b082153fd..7ed6d78b3744 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -81,6 +81,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+void cleanup_netns(struct nstoken *token);
 struct nstoken *create_netns(const char *name);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int unshare_netns(void);
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ae42ae41f4b4..11267f987e7e 100644
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


