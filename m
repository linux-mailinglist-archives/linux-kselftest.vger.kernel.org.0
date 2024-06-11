Return-Path: <linux-kselftest+bounces-11637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E52902E59
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455C628242F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B8215AAD7;
	Tue, 11 Jun 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5XvMSB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5748C04;
	Tue, 11 Jun 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072877; cv=none; b=tA3w1FturxqwAXetQLZf+ZN7UzI57GrYMzKVWA2qs1xUhmKz0U6dCHQqMB8BogloYOAnGJhQhuIoghOCZBr3AHK6PS0qbEeVTdGPyHkeeWXpQZAxwXSjo4sRUlE8DeDAuI7sgOw9YI3eScifePpfe3rctgSPuQskB6MmlR8isYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072877; c=relaxed/simple;
	bh=soo8O23hvdU9RFLYaLJElksgq2fkfTRKU7M9abjFpM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG9nDA0g6aScH4JzTz1+KwFSaos3levQInszDKA2JO7Vqepl47g3EFKCrpAcCrUPhxFZob4egRkdh75d0Jb/BKsvajm4piVofMBpk52nHxiO84wmCc4+wkcy7xR75iEg7KaSWXS7oWmFxUQGss98arhRFH5B4EBxnJ8ONI3kaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5XvMSB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA175C2BBFC;
	Tue, 11 Jun 2024 02:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718072877;
	bh=soo8O23hvdU9RFLYaLJElksgq2fkfTRKU7M9abjFpM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5XvMSB654yYtH2oIG8Dj+aLokfPKpehgjlyrDNLUbQkekdYVFrjMIGcdJBmIhGNT
	 1ovX8mSheMvJfnlue84JruMedDlUeJsyEmW37eTJJqaqW43e500uJDGrvbYl/jWX8i
	 q3hIYH+02Tc7nbvu7gL+1QmwbcZvZ8Anm6Yvl0PELG+PEtRD0rb4879RMEjEe3Nj63
	 0dDbI4GFU/gn2jE9sRQtrw5D10cz059KCsxICIE4n1x09y2quMbISL6xp66Y6tMqSt
	 1u8M24vc4j2js7b5Lz+DmR/p9SV0ZrOfpiqB4yiafLHlhvYhPOP81eNz+86I12UOBt
	 jWMhi8m8wR4PQ==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Close netns in error paths in test_tunnel
Date: Tue, 11 Jun 2024 10:27:28 +0800
Message-ID: <cf6b9ac760c91d58078243e27be31ef811308296.1718072698.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718072698.git.tanggeliang@kylinos.cn>
References: <cover.1718072698.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

netns created by open_netns() should be closed in error paths in
test_vxlan_tunnel(), test_ip6vxlan_tunnel() and test_ipip_tunnel().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cec746e77cd3..f19e8177bcec 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -448,14 +448,20 @@ static void test_vxlan_tunnel(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	ifindex = if_nametoindex(VXLAN_TUNL_DEV0);
-	if (!ASSERT_NEQ(ifindex, 0, "vxlan00 ifindex"))
+	if (!ASSERT_NEQ(ifindex, 0, "vxlan00 ifindex")) {
+		close_netns(nstoken);
 		goto done;
+	}
 	tc_hook.ifindex = ifindex;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.vxlan_set_tunnel_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
+	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd")) {
+		close_netns(nstoken);
 		goto done;
-	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
+	}
+	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd)) {
+		close_netns(nstoken);
 		goto done;
+	}
 	close_netns(nstoken);
 
 	/* use veth1 ip 2 as tunnel source ip */
@@ -521,14 +527,20 @@ static void test_ip6vxlan_tunnel(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	ifindex = if_nametoindex(IP6VXLAN_TUNL_DEV0);
-	if (!ASSERT_NEQ(ifindex, 0, "ip6vxlan00 ifindex"))
+	if (!ASSERT_NEQ(ifindex, 0, "ip6vxlan00 ifindex")) {
+		close_netns(nstoken);
 		goto done;
+	}
 	tc_hook.ifindex = ifindex;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_set_tunnel_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
+	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd")) {
+		close_netns(nstoken);
 		goto done;
-	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
+	}
+	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd)) {
+		close_netns(nstoken);
 		goto done;
+	}
 	close_netns(nstoken);
 
 	/* use veth1 ip 2 as tunnel source ip */
@@ -615,8 +627,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	if (!ASSERT_OK_PTR(nstoken, "setns"))
 		goto done;
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ASSERT_OK(err, "test_ping");
 	close_netns(nstoken);
 
 done:
-- 
2.43.0


