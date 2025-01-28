Return-Path: <linux-kselftest+bounces-25286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4BCA207F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4DB1617F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3F1AAE1E;
	Tue, 28 Jan 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qz9SUelH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54831A38E1;
	Tue, 28 Jan 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058270; cv=none; b=HR9dLnWfKS7l1hpv/8B8UJ0RF4l15ou1LZU5x8KMrur9A9ci0Tq32/YYmuYU48uNHluLSM6dtAc88eCDZRj3MKlsg08y3XfEeYUsmWrqjPSjOkdOI4OuLvSZFxIayZ79Kh7jmvJGR9C9bacedYVRT7XQwWYqwUl3Xv50dvBq+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058270; c=relaxed/simple;
	bh=nH2a1STc6abGGl/YDrF2OGyhY2x526eDTLLkXXUBEPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmflQxhgxJX3Nbo5Ff5U9pxmxVhHv6OlDTpBxNzjp1q/XqPLdTEtG7QyRoIVzCz/PE56HNOhZxrv+S00rmivlbtCFoVW1lLxZpFqUN6vZDSPYsKMxNnLXdxpN7ANDEKPphOw4bkvFpRL3/a5LiMR9gosANMnont7dm4w/tzPALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qz9SUelH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3C4D1C000D;
	Tue, 28 Jan 2025 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWTVAu4bJBJAtLxVBbHwO1a3D2Aj+4KSGvCLkFoPWcM=;
	b=Qz9SUelH6IYFqPxLiUe1CFrQk06GERuBL+zqA0hsygkVM2OymK8UeuH8bTxvftHJHbCk4T
	3A1FP29NNaEpVXB30AhyDpP2uAxyJT9zrngUZR4rW2VTmTdI/67urM3dJTQ6mAQ3JWNs5u
	eMFllppm2c91DziPQ6cyvZuQniIlLwF0+VpvGVwZKMgPv19Kc2XVxpsb23+b3fAVIQEckb
	bQK9LaH87qugnIQp9MGa1a0kSlQFdGgd8wpg3dUAvNiLU+9xskmQ9InqXoLvqXE2aCMnoc
	kWYrBLLT5jmgLNdRyBSEmTvi/+g6C2sJ7EYYV3cSb4HfQcbijKaDc6+KPvkDgw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:30 +0100
Subject: [PATCH bpf-next v3 06/14] selftests/bpf: test_xdp_veth: Rename
 config[]
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-6-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
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
is a bit too generic if we want to add other configuration variables.

Rename config[] to net_config[].

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 710136861bda7607dcaca6186b5acfe0082a870c..a214d5b479bea3008ebf71e0ba37bc50b9561f14 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -53,7 +53,7 @@ struct veth_configuration {
 	char *remote_addr; /* IP address of the remote veth */
 };
 
-static struct veth_configuration config[VETH_PAIRS_COUNT] = {
+static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
 	{
 		.local_veth = "veth1",
 		.remote_veth = "veth11",
@@ -105,17 +105,17 @@ static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
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
@@ -135,15 +135,15 @@ static int create_network(void)
 
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
@@ -160,7 +160,7 @@ static void cleanup_network(void)
 	/* Deleting namespaces is enough to automatically remove veth pairs as well
 	 */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++)
-		SYS_NOFAIL("ip netns del %s", config[i].namespace);
+		SYS_NOFAIL("ip netns del %s", net_config[i].namespace);
 }
 
 void test_xdp_veth_redirect(void)
@@ -190,11 +190,11 @@ void test_xdp_veth_redirect(void)
 		goto destroy_xdp_redirect_map;
 
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		int next_veth = config[i].next_veth;
+		int next_veth = net_config[i].next_veth;
 		int interface_id;
 		int err;
 
-		interface_id = if_nametoindex(config[next_veth].local_veth);
+		interface_id = if_nametoindex(net_config[next_veth].local_veth);
 		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
 			goto destroy_xdp_redirect_map;
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
@@ -208,7 +208,7 @@ void test_xdp_veth_redirect(void)
 	 * veth33 from veth11
 	 */
 	ASSERT_OK(SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
-			     config[0].namespace, IP_DST), "ping");
+			     net_config[0].namespace, IP_DST), "ping");
 
 destroy_xdp_redirect_map:
 	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);

-- 
2.47.1


