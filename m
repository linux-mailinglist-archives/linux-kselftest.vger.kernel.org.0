Return-Path: <linux-kselftest+bounces-21191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0A9B720D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A71E1F24CD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF416F06A;
	Thu, 31 Oct 2024 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBxghj98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75145025;
	Thu, 31 Oct 2024 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338863; cv=none; b=inDNPA6RDo95Bod3IwI/7PnnpUhpirRkJM+dxYfTqEqBGzFa/S9MBvKh8/dVjJeMXMMaKx2PMPb6FsxhqYCNp02ZlmQPWJ/bLYeDGbfY+Tk6qtbaHRg2Z9JK0/gFUv0rNqWOXD2KL/m6vXFQeQhThS/grvrWreJRS7D+CwZcAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338863; c=relaxed/simple;
	bh=PruUELLs5uKbkikgD7DNfTVa6rqlhMSedYgBFpijzEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4B39vIazAyot8CpcqX32KIIPe6D9I/Ou02cMG1blrT/vZmE9UOMtXuNPvP1oMZ/sDMbVlX72n/Hp8wO2k7hEOTqQBgu5gu1eqEHaAwrNdBTdqGuA15xxaAmMdGW6vPI9nHk/KJb7idKURGHZ9nX0kFjU95dwW3CqR54ddAFHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBxghj98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0583C4CECE;
	Thu, 31 Oct 2024 01:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338863;
	bh=PruUELLs5uKbkikgD7DNfTVa6rqlhMSedYgBFpijzEA=;
	h=From:To:Cc:Subject:Date:From;
	b=tBxghj98kyqm1zlyAqSMRpfTJeXOiqUe8TOP3xp6jVLVDbpvHy6M0O6BcyF5snRPZ
	 hyIbnj/M6A3V2oGOOM7KwxU6JgEjwNKOAEOc69Or4hWXbMNFouyOQ51TT1F3bniYF/
	 8wOPIxWDo5ghAlJeP24x2k3lo/FwOVQ+PGrUpvxhg1OGqOyzjBRrFmn+3+beiyP1xv
	 Gq38w+40sZYQtJH+zWi5XaFTbn/GuS3qG/14tlGX9PxQnLPxb+/71tG9hy7Kfd+ZdY
	 ExzMPpTrHEUT1wuWpWYOmShrn7mVR9hzOt8UeEL/NkAG85XSKYJSjYAeak+zqLDY5B
	 iKquI++45LLhg==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH bpf-next/net v3] selftests/bpf: Drop netns helpers in mptcp
Date: Thu, 31 Oct 2024 09:40:46 +0800
Message-ID: <c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New netns selftest helpers netns_new() and netns_free() has been added
in network_helpers.c, let's use them in mptcp selftests too instead of
using MPTCP's own helpers create_netns() and cleanup_netns().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
 - No code has changed.
 - Change subject prefix as "bpf-next/net" since CI complains that this
patch cannot be merged.
 - Add Matt's Reviewed-by tag.

v2:
 - Use netns_new/netns_free instead of create_netns/cleanup_netns as
Martin suggested.

v1:
  selftests/bpf: Use make/remove netns helpers in mptcp
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 ++++++-------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index be3cad2aff77..f8eb7f9d4fd2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -69,24 +69,6 @@ struct mptcp_storage {
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
@@ -206,15 +188,15 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static void test_base(void)
 {
-	struct nstoken *nstoken = NULL;
+	struct netns_obj *netns = NULL;
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
 	/* without MPTCP */
@@ -237,7 +219,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	close(cgroup_fd);
 }
 
@@ -322,21 +304,21 @@ static int run_mptcpify(int cgroup_fd)
 
 static void test_mptcpify(void)
 {
-	struct nstoken *nstoken = NULL;
+	struct netns_obj *netns = NULL;
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcpify");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
 	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
 
 fail:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 	close(cgroup_fd);
 }
 
@@ -414,7 +396,7 @@ static void run_subflow(void)
 static void test_subflow(void)
 {
 	struct mptcp_subflow *skel;
-	struct nstoken *nstoken;
+	struct netns_obj *netns;
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
@@ -437,8 +419,8 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(skel->links._getsockopt_subflow, "attach _getsockopt_subflow"))
 		goto skel_destroy;
 
-	nstoken = create_netns();
-	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_subflow"))
 		goto skel_destroy;
 
 	if (endpoint_init("subflow") < 0)
@@ -447,7 +429,7 @@ static void test_subflow(void)
 	run_subflow();
 
 close_netns:
-	cleanup_netns(nstoken);
+	netns_free(netns);
 skel_destroy:
 	mptcp_subflow__destroy(skel);
 close_cgroup:
-- 
2.45.2


