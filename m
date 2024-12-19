Return-Path: <linux-kselftest+bounces-23598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F189F7E7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3614188E0C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02F228CBC;
	Thu, 19 Dec 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inodVxpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1F228CAD;
	Thu, 19 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623446; cv=none; b=hraqTbQEWTWI/xxd/HXlxoytiqpuzhrDVpxHjfs/u60xpIIo8lKgfCffMURxJbrKlBilkKyESehnrMJudkO2HZcdHlv0EYhZSVixIfeDUNONViAlWn1TWDNcNTWNOjm4a8o994k/b0DgfQYf5xmeuBzPWIAfVYNliIsiNVoyBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623446; c=relaxed/simple;
	bh=DszTJJw7BeF4Dq9illY7Eq+noW6jmff6HalMxhu2MhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfOfMzSKSWZI4nSrZPjO3x+6vGcKtPidKIYZmeayV7Dqiqe0IwAuR/U6radoYqL0TDprHkYSwb9HpaScFd+EZJDLjMlGTpIS8saA3mnSzrWCBFuF3ZpQnDTOpTZSaE7K8/sAD7nhzZPkREqMe6+poFG62dX4bFK2AbzOzZMQgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inodVxpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF1C4CEDE;
	Thu, 19 Dec 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623445;
	bh=DszTJJw7BeF4Dq9illY7Eq+noW6jmff6HalMxhu2MhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=inodVxpZX+tuUtf+60UKSQKZgyCvOEy0XUtcHRbfoD8WNUfAwa4iy2FB/+xgbF8Wm
	 eLq74MU34VcjVpanttNXc6Kw6omQ4KC4SY7NyoVt00Ht1MRVaeMZcJTA0X8lbWogJe
	 VV1HZc3z/wEEzk/ccSVb+PYxq0ZfGJqiHAijOVkxZd8gIrDEztPPhRLbtWfmnO27ne
	 NFz37WyWXuhsDIbJGhuweyoLLuQ/+vGrx/AGOSlPmlheg2sv4Y+UW0oTqK/2/RGxAL
	 AKFcCuYpURAzeAEBSVVwr9CdO1U6tVhxkgoa3zF8It7njixM6WoTpg+kRVk+PxLM0I
	 91zUyb1tdd97g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:45 +0100
Subject: [PATCH bpf-next/net v2 6/7] selftests/bpf: More endpoints for
 endpoint_init
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-6-ae244d3cdbbc@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
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
 h=from:subject:message-id; bh=Po09A6yg2QyWP12VFvj6lUg78RIYIk2YxWtr3rxOpQk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECuhP2z2ITaXuAOojzKD7j3pk1TEvcNJIfDR
 ycxmgA053iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArgAKCRD2t4JPQmmg
 c/VnD/9PhaUefizQp8URVACGbALKPMkyZ8UlEy1TfbG+K24rhewTdKY/i8OlueG88Gq06jARQR/
 S0rF7wMSkUF5nZw8wOP3OXSre+IJuNLC6ccki+4x/913nAYBgkyXPsY6p6XMT3iCGz14BAIxGE8
 f7gCN1quUxfWu+9xEocWCyuQDNU5higx0G66PDtVhkUDpWC/RlhfDuFEsEB8Vy6ev7F3OiOaHm4
 m/ObJweQYno8e73x+4iCDcsvu76GmuxOIOW2w+Mu3SGGEgrxZRvsxIIgpJgl5AXW3+yilO49AAV
 9LzuJHV3+unu0YByPqf0/pLdZdlhxVDDQCHRi8dnbFCGPbJRgZYpsuGbkW+4d/jo7YWifJA8hQJ
 w5GbKo9OBzjZ4mdgtyPqu1VbNkEujDVzg7GrTC+GPh7xrd5RUTTRSU3HNP3rJnCnVpReXINSDxT
 eNkD6zSnu15j2/cccCN51BLkji8mDjb75SskIXjmZ3Q3/OrAVXAv4J0bHTZuXL4UvRDn9s4jpJN
 4i2s1GP2+faXxFNJ4+CBrvTz0MllFb1xxzE5vaCboRNwJluSu2EQ35MVMO6lNeEiY5x1WWIuARB
 wnu53vcpbGcBoCzJJi+PKbW94caQdh9ZLU0kVxGxWWBkyQUbx1j682tdWOxJDw/56sQeXE2Agt0
 O36dLQSPw6udQGw==
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
2.47.1


