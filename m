Return-Path: <linux-kselftest+bounces-21084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908719B5B70
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 06:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5ED282848
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DF1D0DFE;
	Wed, 30 Oct 2024 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL7pWLGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37152193402;
	Wed, 30 Oct 2024 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267149; cv=none; b=hE6eKNws4LmwYfuO/k6CY0SBbh6W6yT+myLE4AozkRcPXgvwmXdWU0STVeTpl5J6Wc5vWDZ6C6l1b9Y5dceQvrznShq0/3uQRqkPCkrh/K/tfNra09xDzcGJKbUhxD7IVusnaec+uNlgXWmQY/og7L6COW0naz/4gNqDwJy4cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267149; c=relaxed/simple;
	bh=nmYJaCm7uEXLwKIA6rFcBkFf3FoMgYkZMq0qidsFzPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLt/hn88buTj4p//347joLmpfieZMYSHzglo/OvV7+Pbk16jURHYzQ90Av7jiqPoXAIZtmUJejW7UYvc17n7GusN7m83Pk524+COCsK5X5V1vH0IvuJIwFHivw0ualj+46edjaIW8hK4Uw/rVZXr6+FInDmF2boxGHzzA0/Uyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL7pWLGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A149C4CEE4;
	Wed, 30 Oct 2024 05:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730267148;
	bh=nmYJaCm7uEXLwKIA6rFcBkFf3FoMgYkZMq0qidsFzPc=;
	h=From:To:Cc:Subject:Date:From;
	b=AL7pWLGchQpStOwdgLfKXl4qWfPcCsXtfTiBWxB+8xyF5B/ldPyuwaJXLym1XMtw6
	 UfX5B2CfjRUpdTzkywNDh5NsyqM2BdCso6q46pD5JAZ+Itp+biSAoVLqWRkTwRD0tj
	 rWzXJC0gMJcQ2WBVR6vH8XQdUkVGm7xpRjmN3jeuIST6lk5Ju7pTJMvk6WH5rcnsWB
	 nMHUqEkLGSFlcMiVZ51qZRlSjylsIdVkFWmSAGZtd+2CYf2NLqcbBgt0MBb5ZnXDuP
	 CE8UlGoYkq8TF9GTBuVJpkOWfXud+k18P94/ey1e2yL1jhUsk+ZJ53FlHJkXd+qDeu
	 kKzwF8XXV9oOw==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Drop netns helpers in mptcp
Date: Wed, 30 Oct 2024 13:45:28 +0800
Message-ID: <70c1f95bae8ec4884be50e08053364c1d152170c.1730262704.git.tanggeliang@kylinos.cn>
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
---
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


