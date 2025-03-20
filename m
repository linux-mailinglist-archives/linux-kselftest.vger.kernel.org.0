Return-Path: <linux-kselftest+bounces-29513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F6A6AC6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432188A6DD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E5227EA3;
	Thu, 20 Mar 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjDyPlix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1371953A1;
	Thu, 20 Mar 2025 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492969; cv=none; b=qISjIcEUbvQdmkjwpENe891IlHhfGchaaL1/TxMnKCHpI3YAlKy9uznqPgFt88AjWutVeuSAHfS5dNdg8+ya9FUuh5F6l9/MzY3DbwZEVgAfyEnvvgjDkBwcQb2bAYpoMH0NbrtwTk+RzJdfQ8SEEQvHwmpXDb7aSJKQDgx5+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492969; c=relaxed/simple;
	bh=GOkeoac9zF5UwphOmI30vYqKl2yHQdqOpQl+3DcJc/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aE/B6zGmpitmaVH4ioRAYjHnEOUhFmBxL5rBWcBlqhusY2+kNpsUiCpS5GIZQ6KpFrRJogSCll/78l1wsleTP0GnSDSrAWiWtVs5czc+eD4fiN/nL0TH1mqWkZS+J7Gh3Y77rWiqMNvwOxRFfTTXGxBxQX5goubPDR7vgujZXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjDyPlix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1CFC4CEED;
	Thu, 20 Mar 2025 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492968;
	bh=GOkeoac9zF5UwphOmI30vYqKl2yHQdqOpQl+3DcJc/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SjDyPlixaoU+b+7NShbxwcKzyRq3zrrqOl2YMgNa0dP5UnuuQnvOsWM0rNkuaNV1T
	 PGUaTKXu8Lbxhy1JGP5toNn6DAI+1vhIJEAIo4PJxK/7q9AIHhgMQpK0J/LqA00c76
	 Rw3jdFaHG1NEaN0T7eWt+64WxFJaFPIn+dC+25vhz+LCu7auczA86LKIwLgxOLuXGu
	 HfJDphVDjGOfAFJffRAsMbaLoEfhLQtpz6ThxtvFqfCVgwSXX0/FbssVTLrE0cG6WI
	 Yi0eiyjheOTW3wB+9ITDKg79fQIbKDxElr3kiteoFEPR56qds6zO6hnmrsy1Fnufom
	 bn6AxqE8VkCdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 20 Mar 2025 18:48:42 +0100
Subject: [PATCH bpf-next/net v3 3/5] selftests/bpf: More endpoints for
 endpoint_init
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-3-9abd22c2a7fd@kernel.org>
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
In-Reply-To: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=If4YKb9XEEyEKzGUqvB/SdTC6RuwxkupRLaHoxCl3D8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FURCqx99mEKLzPSX5JDHMngw1UBD1v8PXuVh
 lxLmLHWRkiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 c9fPD/0WTRRArrN9BHeUO3FvmE5ajSSmJrK77XAE5MNfQBBjruh7Vg9YJrVzRoLDUBINwnEQliC
 9ld/0fW1cSq4NttgTvnfYQGeUi37wWowYf5uwc6A9WTWzBltDYylhzUWDmfpyxtQKOx3CGv4lSN
 yeOdQ+afNoxfocrVqtmbKZNam62POZRj4meiQ8jhqPMP4y38cth8SZ7cEK4qJslmI7d2MQ7gppy
 rkyZ19mCIbJrcx+C69KjLBhsLLH7dKfvplCNffHlNbZ2jTF3fqbZx+HqGZ2fFDKGzApQklcgLmP
 9ItJ4WyB/G/BhRiePo5CU9tgU28WVK05ffGGHojtU6SkpIjnTt8TgVAwo4U+63cgbLGBZQ+h5oL
 V/OhtcNeqj/mWg+yB0CVpsQZOE8vfoRVKF3ot5bss/saPs2SNmoGxKFn7oGauQMZBdbzC0wBlei
 0T0ARvYEych0Jky7U+e7NJSO2ZTLjopCMm1sMnIMW0gCZEUGEmbNdLMfo4kO9kiegynFExryhIS
 MWVlB00oM9bFYyKT4Ijt+k0K7Ram9s3RaNVIirBlouVz3hi5qNbCTNhvNDWJgui6CYuUBnKxnaq
 BfWNVbBwhw9oLKgsVotPsT8eK78BnXWdcrp7lrS7e/mQIA2I57aKRh7UdASsJN0vliQf3qPQ4x0
 IZwHLkXPY6iRvBA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch changes ADDR_2 from "10.0.1.2" to "10.0.2.1", and adds two more
IPv4 test addresses ADDR_3 - ADDR_4, four IPv6 addresses ADDR6_1 - ADDR6_4.
Add a new helper address_init() to initialize all these addresses.

Add a new parameter "endpoints" for endpoint_init() to control how many
endpoints are used for the tests. This makes it more flexible. Update the
parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 56 +++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f8eb7f9d4fd20bbb7ee018728f7ae0f0a09d4d30..85f3d4119802a85c86cde7b74a0b857252bad8b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -14,7 +14,13 @@
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
+#define ADDR_2	"10.0.2.1"
+#define ADDR_3	"10.0.3.1"
+#define ADDR_4	"10.0.4.1"
+#define ADDR6_1	"dead:beef:1::1"
+#define ADDR6_2	"dead:beef:2::1"
+#define ADDR6_3	"dead:beef:3::1"
+#define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
 
 #ifndef IPPROTO_MPTCP
@@ -322,22 +328,60 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int endpoint_init(char *flags)
+static int address_init(void)
 {
 	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth1 nodad", NS_TEST, ADDR6_1);
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth2 nodad", NS_TEST, ADDR6_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+
+	SYS(fail, "ip -net %s link add veth3 type veth peer name veth4", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth3", NS_TEST, ADDR_3);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth3 nodad", NS_TEST, ADDR6_3);
+	SYS(fail, "ip -net %s link set dev veth3 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth4", NS_TEST, ADDR_4);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth4 nodad", NS_TEST, ADDR6_4);
+	SYS(fail, "ip -net %s link set dev veth4 up", NS_TEST);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int endpoint_add(char *addr, char *flags)
+{
+	return SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, addr, flags);
+}
+
+static int endpoint_init(char *flags, u8 endpoints)
+{
+	int ret = -1;
+
+	if (!endpoints || endpoints > 4)
+		goto fail;
+
+	if (address_init())
+		goto fail;
+
+	if (SYS_NOFAIL("ip -net %s mptcp limits set add_addr_accepted 4 subflows 4",
+		       NS_TEST)) {
 		printf("'ip mptcp' not supported, skip this test.\n");
 		test__skip();
 		goto fail;
 	}
 
-	return 0;
+	if (endpoints > 1)
+		ret = endpoint_add(ADDR_2, flags);
+	if (endpoints > 2)
+		ret = ret ?: endpoint_add(ADDR_3, flags);
+	if (endpoints > 3)
+		ret = ret ?: endpoint_add(ADDR_4, flags);
+
 fail:
-	return -1;
+	return ret;
 }
 
 static void wait_for_new_subflows(int fd)
@@ -423,7 +467,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
 	run_subflow();

-- 
2.48.1


