Return-Path: <linux-kselftest+bounces-21701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F039C2130
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758A3281B8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727521C167;
	Fri,  8 Nov 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMUe2XF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7221B452;
	Fri,  8 Nov 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081183; cv=none; b=N/k/mBRcT2a18gbwyRAO9bzErmouimwethxE6EtesrB/y+eIMUwNZtH5dzBuuBr19vfSWbJgJGfZ+bgtiXABIQSR2AG1V0Mj/tueur5MsYEi8LvRGIpeZtqO59S2aYdvsSSYJKqdpM9Qy3Od4ElJ2U8UTJ9QfIgCLfuauhf9vbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081183; c=relaxed/simple;
	bh=T33OFv4370vAaOBtPgJ8KJyDUTXlLxZgxMPvD468RKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHrkb4+Cldcd8vPcQoTpTcoE6qyGG/+26XnuvXEE6cctsJOyzks2u2slKgFmey0/7x13LoOkEqJNm3FfT/jeZFQDGcSsP5JRAGAZGaddA1/2u6jR6SoiI8+dUfcKTSPac1g07QV551B8nKV71H/Y90gIHe8wCKDevsiMzBUjVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMUe2XF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B04C4CED6;
	Fri,  8 Nov 2024 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731081182;
	bh=T33OFv4370vAaOBtPgJ8KJyDUTXlLxZgxMPvD468RKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMUe2XF1xBJ73XtdgruNL6Es58ahgFzrmDkwLrNUitsnhk+aIfyVq9hSJOBhIpGPp
	 thbriNThS9oAXAbIIBotHWui41o/evDPEJi64GY8TqDk63FTKvV2FqDJCJJks3mFHB
	 w92wnQohc/QqMC+wqMoBL4VnkCx0D6u4VOgGXjKcnQ4kVaZjz+1C9ERqZYsqCHvDA5
	 M1ZPVQ+iuXUxU0TFiBHRcR3lWI6isl3KDpLb2BG8u4dzgQ39ZqDvBl8Z3W10OvDwe1
	 sdR+Za4bwZDPtAYdqCVPhmnZiWwoSsKrr75v2fq82K9/3CJCGaxZT9QiS+cuctgXZo
	 uT9irF16xpr3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Nov 2024 16:52:33 +0100
Subject: [PATCH bpf-next/net 4/5] selftests/bpf: More endpoints for
 endpoint_init
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-4-cf16953035c1@kernel.org>
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
In-Reply-To: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
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
 h=from:subject:message-id; bh=Ru7NMIs9pH0EG9p8nIRT2i0k1cui542WqTRHPW1NGDc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLjPBvLS1F2fJL3rg1jMPPpVugTP/xmjodgM2B
 fsMevKBQgSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZy4zwQAKCRD2t4JPQmmg
 c34QD/90MAx9oKVjYEseuW9+lvXN9lUei6F7nNez0EUaOrADDt/rUCbrFxxuDkDHQamwOti1KLS
 e0batHCI9orTNcTFmoFtXgqw8Od2B8O8R8svJb/FA8NMtxu7yszkmdUJtSvmKZNC8EvjCvtCj9v
 TtcmNlXP0BEmifA2v7caGOlgeNGguHcrXlBAGBiPDpRAd5NZFlJ/yz7EEys8lC9PmRrr4e+XaVc
 wj7/p7EoP+oqeCVWqMvyi2R+LKsCZCd5ba7/5/meW6ypNVmUuIHrdcRVU1BxWywyu6nFNcJiW8a
 GyoQLgrH0DnRdSTADG/eloJTl6EsmOqYleVsxx3rqe1Hy8Et59GxjtHgLw7wgqFBIyIKLSQ98lb
 7fIzx5hxvot83M2sFVdGAi+90VZAe8XZyPThNofWOow7HmK3L2jZNG4COHaRAbt2mQAY/WtCcyD
 jqiRi+s0Rf6DP3Cc8D+MjWlN/K5NswptwuIZ9lIo/kJ9DLwpHNM4BiyM5PWS73Jtu0t8PEx5CB1
 ev7d3FoyhPhQoQxOyxpyem4qaO5zxiR5nq1Jl7dexZ2I89RZWyQe4INP+41bMrta9uO7f1kXs2n
 J46dC/QXTsltKSXC6vVxX0kd45YnCSnkoSs0XpCLDgBxIIVoEmcX6CdWLseq4BCSrs244nBHozO
 OSZayhBkDPCPR8Q==
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
2.45.2


