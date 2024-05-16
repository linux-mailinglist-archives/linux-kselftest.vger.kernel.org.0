Return-Path: <linux-kselftest+bounces-10275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965228C6FEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BBB2840FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF1A47;
	Thu, 16 May 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeIcOo0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DC15C3;
	Thu, 16 May 2024 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822040; cv=none; b=hNQ/NJRTfhrmI+8MKllm6iAiwyeuzS0zbF7iQ2Csq1cuoVacxWl0bYT2pbz/cighqlNgHxNzsXj+KsmRlGYiwe0CUMT6Aw/VCFmeOxrITzi5WS7Hi9zo4xAPtR7A+m4g0texG2rlJwnycx3+fjASAVBwgmjz0NdyMB8HpW0viHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822040; c=relaxed/simple;
	bh=Q8CrCR/sNC50qbiUi7YHDx9SVsY8RVE8vsth9qrUnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJAtZCI4EjUXz9ifX91xDz/ED/5pm/Or6rbMvfs0uT1uuwZt7/TKA731EEcXws8QDpq86peXvsHLMpZ4Glmt6FWe9NUTvxZMUKQdcX3p3OjI3FUF8Rk9XAIep8KtD5+vAAfUaky6FfVpyk2MrG0sSipU0hEvT984s7ur3HoovMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeIcOo0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2820C116B1;
	Thu, 16 May 2024 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822039;
	bh=Q8CrCR/sNC50qbiUi7YHDx9SVsY8RVE8vsth9qrUnu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeIcOo0OduKM5WpyGBEGFby2wJbah8MEDd5p/I6ExGeepnCFZh93+ZVKBKe2/Si3J
	 w9wgXJOz8UzU0uaabyGkWNR1uL4Oku6MDjeoJ3O6TazZc9BtwQwk40Fq2ppkGWQr44
	 1PUEumNZ8ArFWwDLMfKM19yB64FO0MPoGL9Bjy9gup3GaI6LfgG3SW4HjQVN9/yOpY
	 nBrmb1k6MDumHCtnuTh358YRuxG5OIhjpiwPYr0ZK8UgqRDkEqlZsoZ12ewGOxgnnM
	 sqdDkdXTWOoQ3WzG0aagnReYk1uxo4NSRBPXenZpgjMpbPdfZ7Wa1W/Nt8QdbT3cW8
	 AwIrB2R/Woenw==
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
Subject: [PATCH bpf-next v2 4/8] selftests/bpf: Export create_netns helper
Date: Thu, 16 May 2024 09:13:10 +0800
Message-ID: <035102a383c461fe64514e37fd7a9dcb946185ca.1715821541.git.tanggeliang@kylinos.cn>
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

This patch moves create_netns() from mptcp.c into network_helpers.c, and
export it in network_helpers.h as a public helper.

The new helper accepts a string parameter, and uses SYS_NOFAIL() instead
of SYS() to execute the command, since SYS() deponds on test__fail()
which is defined in test_progs.c. SYS() is not suitable to be used in
network_helpers.c. Also using "ip netns del" command to delete netns
before runing "ip netns add" to add it, since the next tests run may fail
due to unable to create netns when last run tests interrupt.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 28 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 14 ++--------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 919bb2a0c6a6..5555b109899f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -498,6 +498,34 @@ void close_netns(struct nstoken *token)
 	free(token);
 }
 
+struct nstoken *create_netns(const char *name)
+{
+	struct nstoken *token = NULL;
+
+	SYS_NOFAIL("ip netns del %s", name);
+	if (SYS_NOFAIL("ip netns add %s", name)) {
+		log_err("add netns %s failed", name);
+		goto fail;
+	}
+
+	if (SYS_NOFAIL("ip -net %s link set dev lo up", name)) {
+		log_err("set dev lo up failed");
+		goto fail;
+	}
+
+	token = open_netns(name);
+	if (!token) {
+		log_err("open netns %s failed", name);
+		goto fail;
+	}
+
+	return token;
+
+fail:
+	SYS_NOFAIL("ip netns del %s", name);
+	return NULL;
+}
+
 int get_socket_local_port(int sock_fd)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index b087330f2861..5c0b082153fd 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -81,6 +81,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+struct nstoken *create_netns(const char *name);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int unshare_netns(void);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4472aa404da0..abb4372114b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -79,16 +79,6 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
-static struct nstoken *create_netns(void)
-{
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
-}
-
 static void cleanup_netns(struct nstoken *nstoken)
 {
 	if (nstoken)
@@ -228,7 +218,7 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
@@ -344,7 +334,7 @@ static void test_mptcpify(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
-- 
2.43.0


