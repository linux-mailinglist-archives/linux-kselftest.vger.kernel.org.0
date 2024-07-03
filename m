Return-Path: <linux-kselftest+bounces-13142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0F9268B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3AF28AC58
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B0B1922F8;
	Wed,  3 Jul 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiC0l/TR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359B18754A;
	Wed,  3 Jul 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033108; cv=none; b=FO333DNa8+atFFxPeVtct9ljkO6rHcZlbJCl3NP/7bn47f3VSxNiBmInye2B6jPEDA2ADdBKN3amvPhOPHhFV6dpifuNVCiS0pspB58r5O7IGKWE1np83heyl6wZMlsiw+VKFSmgVXBTXeGGED+u3CC2isZ9D9+VkOgrUWFp0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033108; c=relaxed/simple;
	bh=6QPk+srK9z43lFM/ESJev1DJPcxAMk78tLELME0IaFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqwWvxZDJlavdFYHkx/I07oHZgnh0yy0bUe6gLgDfVLQbubP9OFcd16VTeklh5Dmi1l+hY5nDBf6PTyIfyO6vTSijajbEWSaCtiIq1Rqdn2F3iE+09cF+fN9KIgzT02Yjn/EauIn0H55KsU/f/kCWxvVk4tJJhEQlzNCDfNSbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiC0l/TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB95C2BD10;
	Wed,  3 Jul 2024 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033107;
	bh=6QPk+srK9z43lFM/ESJev1DJPcxAMk78tLELME0IaFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eiC0l/TRpCMRBrtvfOeDi3p/8cDj2nWflAsx4JX8ddL97LeQqjYhvmfvIkiM8rZ4A
	 u23JM6kkPpeY1DeCk5FAe86p7OKlyxaw5KD++tZSSk2S1zeAEi7TQ6jYQUuLOkGOTz
	 gVPVnuY86cVKYINzGH1jWbLUddV7+86Dv2PPnV0iOQtYCCk3OhTiZN2kdfoMS4RwjI
	 x815awVZThzfwuwg/r7SooS5uFXgrCnQ1p+Nd8cx3isyl7uqzHBZfjP/ERmO9d2q3p
	 lsbSN677l5nCoGl04JxBymBxPLGInNA2+ZL0ezlI+qVVuvyazjdQO+hh50+HaysDbu
	 TQZ5qdIxKcQLA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 03 Jul 2024 20:57:34 +0200
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add mptcp subflow subtest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-3-ebdc2d494049@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
In-Reply-To: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dH35MZ5rm45k9pWY9PE4QpIU29g4nqtSyv2YEmWbywA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmhZ89U47GykCQSwKXwLX/QpFcuJdORLCQz6qKV
 yEcqwneMUeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZoWfPQAKCRD2t4JPQmmg
 c3/GD/41hNnel2jqoiVyS8jZ7d7rRIkls5m3Ozj9tjOdYWR+Axw4/VqYLvAMcWcpBaDGK9d+710
 JPQSosre3iRyDZAx6WFvUI8D7BcUnZQsk6hkG8qPdTj2okrrOhFHTR68ITFVysjAxa1BYAcavtd
 7QeWa6pY/TdrXUrsx9U1ijdZBjLN5dWmoJo8oO3RgijwJd0LWcDyoxS5pJAiWvOn2dLbeT06+SO
 34MQsPIg0w8zo4suz66cS4U4T3QaKPzezBG6OYb0+qPRBXCkxM5EmSDInDlY7bD7ObJpw0Ki8FJ
 ke7KCVwvQ504F6pHgNIT7mluc91mnKUBbgbqJ0c50uC1GhJWSL7drMJ+K555AZEifTgEvUkY29Y
 mF5PPSW1p79OoiG03kWmS0l3W6vBqN60ZuJzM53FqVIRkSNA+/cKJbLH8KcHxFnIplobwPtwjwD
 p/pZ5aSjg5f2QdnnvPrrGts6ySTal2lqiOVBSgXw75MOnLe/ylkKepYEG5rbhRF+GzXK9HnuW+a
 6/WGxkykfkH3Edz4ar32WR0AOXJhiZjQC+pgseEcErkmQKEoAH/VREAWej16eaE4D361mq9Ne71
 qFKgCZ8T1GkGxoLlFUqyENuT0UcHJo+wjK4LS53PbqhDywLBWIz1XuKts3PyvmxvCYeUAvWZP2D
 Rys1JXaavlxRLaw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a subtest named test_subflow to load and verify the newly
added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
to add a new subflow endpoint. Add another helper ss_search() to verify the
fwmark and congestion values set by mptcp_subflow prog using setsockopts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2 -> v3:
   - Use './mptcp_pm_nl_ctl' instead of 'ip mptcp', not supported by the
     BPF CI running IPRoute 5.5.0.
   - Use SYS_NOFAIL() in _ss_search() instead of calling system()
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 104 +++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d2ca32fa3b21..975427b3c66e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,8 +9,12 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcpify.skel.h"
+#include "mptcp_subflow.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define ADDR_1	"10.0.1.1"
+#define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -335,10 +339,110 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
+static int endpoint_init(char *flags)
+{
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
+	 * but the BPF CI is using an old version of IPRoute (5.5.0).
+	 */
+	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int _ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
+}
+
+static int ss_search(char *src, char *keyword)
+{
+	return _ss_search(src, ADDR_1, "dport", keyword);
+}
+
+static void run_subflow(char *new)
+{
+	int server_fd, client_fd, err;
+	char cc[TCP_CA_NAME_MAX];
+	socklen_t len = sizeof(cc);
+
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+		goto fail;
+
+	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
+	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
+		goto fail;
+
+	send_byte(client_fd);
+
+	ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search fwmark:0x1");
+	ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search fwmark:0x2");
+	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
+	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
+
+	close(client_fd);
+fail:
+	close(server_fd);
+}
+
+static void test_subflow(void)
+{
+	int cgroup_fd, prog_fd, err;
+	struct mptcp_subflow *skel;
+	struct nstoken *nstoken;
+
+	cgroup_fd = test__join_cgroup("/mptcp_subflow");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
+		return;
+
+	skel = mptcp_subflow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_subflow"))
+		goto close_cgroup;
+
+	err = mptcp_subflow__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
+		goto skel_destroy;
+
+	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto skel_destroy;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
+		goto close_netns;
+
+	run_subflow(skel->data->cc);
+
+close_netns:
+	cleanup_netns(nstoken);
+skel_destroy:
+	mptcp_subflow__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("mptcpify"))
 		test_mptcpify();
+	if (test__start_subtest("subflow"))
+		test_subflow();
 }

-- 
2.45.2


