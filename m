Return-Path: <linux-kselftest+bounces-24862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00654A17E51
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084F416C045
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B21F3FD4;
	Tue, 21 Jan 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pSWP8vXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51141F239B;
	Tue, 21 Jan 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464494; cv=none; b=pLB2SWmK5gUVuowRVZjWx2Gugp5sRvrh10PHCUl1OFuXUtCVcKC7dYSVaPuilt4y4+E8iTShV+mtD4042gQeGShF+Dc2x6KwGao2CtRkxn+xx9TgggHfgh5d3WiZQ1o7D30xPjuQqBNH/OWkiXSc2tT6ACAkHz8V7aXgNIp4Twc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464494; c=relaxed/simple;
	bh=QKt4dmKv7mRaTHYOUZJ2Wm9CdweW6Djff/m9qQGh33U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUJHXTzSmuRVDcZzgD3aEqmpqU85TO/btgQHzzd885HOVzG6N3a2alV8ieopmqN43OKeHbCns6IVKf4HjfU4mMXuunY9xLafANQ22Np+lKqaeUMH9t/icKJGVgQ6c7GWmEGwEDdGGWNEENZIvyRIBei6zL8kaJKqqg1rHKt07BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pSWP8vXF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE4221BF203;
	Tue, 21 Jan 2025 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyS+qhqVxbOVojaX+vrZD17GEZ46OaunToVl5WKYx5Y=;
	b=pSWP8vXFQR/+ZZwqNSrmPhBqB6dEKgltx0m9Ywx7AYN/mnHWBtCGus4gs665wohC/ONwJc
	SXxzBHH7lrq6pIPaFah7zXmHwtg/cugHYK4VjVBMT68ab99bbCiJKLuEpZgMoI6MJbY9Yy
	67Q3+VX9O9cNEZ2zIVxcRTEvrRApY2EhRS8X8S8vTZ7+6gIgQ6Rq0K8FxEMO0m75ZOTwLZ
	ge5sN1OZkBTRhqYORBmvJDXty8aF2GqncMlvxw8fthB4AVlZPX/fZXluy8IELSMnYIrmXE
	V2UqdtLKifz5eT3II3y8u4QkoHxv02kMIZIE7yEX9OCoWN7Fjw+Lk122giLOPA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 14:01:25 +0100
Subject: [PATCH bpf-next v2 03/10] selftests/bpf: test_xdp_veth: Rename
 config[]
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v2-3-fc9cacabc6b2@bootlin.com>
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

The network topology is held by the config[] table. This 'config' name
is a bit too generic if we want to add other configuration variable.

Rename config[] to net_config[].

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 8507863e61bbea99c906c60ed4535e23d530588c..e84ff834736ddd35a787e5b7a7f20a48efba7649 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -55,7 +55,7 @@ struct veth_configuration {
 	char *remote_addr; /* IP address of the remote veth */
 };
 
-static struct veth_configuration config[VETH_PAIRS_COUNT] = {
+static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
 	{
 		.local_veth = "veth1",
 		.remote_veth = "veth11",
@@ -107,17 +107,17 @@ static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
 		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
 		break;
 	}
-	interface = if_nametoindex(config[index].local_veth);
+	interface = if_nametoindex(net_config[index].local_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
 		return -1;
 	link = bpf_program__attach_xdp(local_prog, interface);
 	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
 		return -1;
 	*local_link = link;
-	nstoken = open_netns(config[index].namespace);
+	nstoken = open_netns(net_config[index].namespace);
 	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
 		return -1;
-	interface = if_nametoindex(config[index].remote_veth);
+	interface = if_nametoindex(net_config[index].remote_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index")) {
 		close_netns(nstoken);
 		return -1;
@@ -137,15 +137,15 @@ static int create_network(void)
 
 	/* First create and configure all interfaces */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		SYS(fail, "ip netns add %s", config[i].namespace);
+		SYS(fail, "ip netns add %s", net_config[i].namespace);
 		SYS(fail, "ip link add %s type veth peer name %s netns %s",
-		    config[i].local_veth, config[i].remote_veth, config[i].namespace);
-		SYS(fail, "ip link set dev %s up", config[i].local_veth);
-		if (config[i].remote_addr)
-			SYS(fail, "ip -n %s addr add %s/24 dev %s",	config[i].namespace,
-			    config[i].remote_addr, config[i].remote_veth);
-		SYS(fail, "ip -n %s link set dev %s up", config[i].namespace,
-		    config[i].remote_veth);
+		    net_config[i].local_veth, net_config[i].remote_veth, net_config[i].namespace);
+		SYS(fail, "ip link set dev %s up", net_config[i].local_veth);
+		if (net_config[i].remote_addr)
+			SYS(fail, "ip -n %s addr add %s/24 dev %s",	net_config[i].namespace,
+			    net_config[i].remote_addr, net_config[i].remote_veth);
+		SYS(fail, "ip -n %s link set dev %s up", net_config[i].namespace,
+		    net_config[i].remote_veth);
 	}
 
 	return 0;
@@ -162,7 +162,7 @@ static void cleanup_network(void)
 	/* Deleting namespaces is enough to automatically remove veth pairs as well
 	 */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++)
-		SYS_NOFAIL("ip netns del %s", config[i].namespace);
+		SYS_NOFAIL("ip netns del %s", net_config[i].namespace);
 }
 
 static int check_ping(void)
@@ -171,7 +171,7 @@ static int check_ping(void)
 	 * veth33 from veth11
 	 */
 	return SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
-					  config[0].namespace, IP_DST);
+					  net_config[0].namespace, IP_DST);
 }
 
 void test_xdp_veth_redirect(void)
@@ -204,7 +204,7 @@ void test_xdp_veth_redirect(void)
 		int interface_id;
 		int err;
 
-		interface_id = if_nametoindex(config[i].next_veth);
+		interface_id = if_nametoindex(net_config[i].next_veth);
 		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
 			goto destroy_xdp_redirect_map;
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);

-- 
2.47.1


