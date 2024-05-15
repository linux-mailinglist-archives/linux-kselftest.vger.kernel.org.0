Return-Path: <linux-kselftest+bounces-10236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBF8C607F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1647283C1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC713EA7B;
	Wed, 15 May 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmARngpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301993D388;
	Wed, 15 May 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752836; cv=none; b=I3p5HkIvvjTfx1fBKgQTzR0CEFZEwf4ZkhNATA9NMk8cYIQ6jH0k9vWFI96u9j398k8xJmVNfDRJVQ9soRjdLdktxfLWD8xdyFZXXtPx7nOzNDjfi/Tn8jf5+16I2CgsE5pqq7oitHdFI8SmhITKA1b9dH8tpQbropKN/byvwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752836; c=relaxed/simple;
	bh=buIc9dAsozt/z4H3V4yyy1DAHtlN4MAh/XNT1Hm9sYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfGTvw+N5KIUdhNSEfahNRbD8GCK/e+0QGKRA0pP8rMZHcxHoWjSAx9x+gQMTYPuupq43oIUjU2MJsSm0I7fh/ZKnaegGQHIctuH5YGivjZHreTSavxnZTY11caRAaBpIXPQTKcyN1g0ham1N9J74UXrBEh9h0U+7rnU32orbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmARngpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68997C116B1;
	Wed, 15 May 2024 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752835;
	bh=buIc9dAsozt/z4H3V4yyy1DAHtlN4MAh/XNT1Hm9sYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmARngppkh5iEJFbyMUIG/u7d9jncYY3n1caTGOSrDEhcixobx9UT0hv7dabeOocP
	 c+fBmtwByk2m3vEmAstfJZk85soGCfCLO3hiNzEOhrGmWlaUGtya3Xw8Sv+o/Ns5AD
	 QsvNvxILzQThEaLGyCRmRXjQj00+QrGX0WPLRq/BYDsWZYHdfKPmZPKCYK8G/8Xptl
	 woTMiQI1LW9WcPEsPq9qAuhy4i87wzzyAfjGXxpcRUp6pp+//PiVB8V3WXrbh80jBV
	 FBgARhozRtDC1r2zeSAADFxV446CFMDwFM/iQRiDR4vmBZvjreXjtsObl1T1y/Ka0h
	 0t9g4SrclvBcA==
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
Subject: [PATCH bpf-next 4/9] selftests/bpf: Export create_netns helper
Date: Wed, 15 May 2024 13:59:31 +0800
Message-ID: <659d1fe7e47b6c63f9648cf7c2433e29dadf458f.1715751995.git.tanggeliang@kylinos.cn>
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

This patch moves create_netns() from mptcp.c into network_helpers.c, and
export it in network_helpers.h as a public helper.

The new helper accepts a string parameter, and uses SYS_NOFAIL() instead
of SYS() to execute the command, since SYS() deponds on test__fail()
which is defined in test_progs.c. SYS() is not suitable to be used in
network_helpers.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 27 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 14 ++--------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 919bb2a0c6a6..c115aeca0a66 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -498,6 +498,33 @@ void close_netns(struct nstoken *token)
 	free(token);
 }
 
+struct nstoken *create_netns(const char *name)
+{
+	struct nstoken *token = NULL;
+
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
index 793b4b9c2bd2..ae42ae41f4b4 100644
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


