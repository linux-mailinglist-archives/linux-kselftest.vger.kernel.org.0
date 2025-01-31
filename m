Return-Path: <linux-kselftest+bounces-25471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE8A239F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F90188A0AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA391B414A;
	Fri, 31 Jan 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="osr/Nw+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE7195B33;
	Fri, 31 Jan 2025 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308117; cv=none; b=ff0z0Zwy2oIbmgobEB5LB/RH+dAmbL173WQOWjIeUTNBvh+RNMICP/DZBYp6I9QMKXW76bpe1iqD07+Yf7ReO/RGCXAmWL9Qc/qAWEHIRebIvTInNALEppXi79QH0xi9kSlZ8A3n/Yxg5dkSLYyElgckm5VAqUZ3SLwhRt4bwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308117; c=relaxed/simple;
	bh=qP7/HNeafnOLIi9MlGE5GWjTCDTZaJFeloDwXgwQr7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBK75VQKLz4dM/hIvv69LyVUD+sh7hv7+2j33uZNV5POAorF+2Ive7Ovn+C/LPuR3QZC3+u62qJcvZkPapqmpZoPDmMsKEJX6KMg4BdRQiugRMoYewT3gyvoF9NT3CMp7T86wYhXvho1b6Kb6FvHKCiCPsM07PxRJpYi/wti3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=osr/Nw+A; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 468E6442DA;
	Fri, 31 Jan 2025 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujvJx1KeTXN7PlXkul92ULDuBkZjxlCJhksDzTLdxR8=;
	b=osr/Nw+AT8vcyr6vAhhyIoiOarnU49lAD6Qp4hGzkYJnP+VBBfenNtjDAMF0m6FpGoAB4x
	BWsTUP/S9TmfPygtUi7sbzPbSbiZSlqxYs9NEU8Z3937un6ORL9iTDo9t9HuyUfPIBDQ/c
	qw5q49Kv8GD0vSD50HbmGF8TvXaiGuZq7tByUSh+Z7jvBJPYrF5P0jmQSoa5iDnXHR0aW5
	N2eD1HZc+CWKcc5znEnLp4L7tXeewbKDw0hR5WGFW5NjEkles8ddEY2SVgWe5DjC5mZdAS
	221PzqlE6BjRjmUVn/39JdW+b6gYgHNkyYfe807g5LQ3tRnBC8av/iro0rmPMA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:45 +0100
Subject: [PATCH bpf-next v4 06/14] selftests/bpf: test_xdp_veth: Rename
 config[]
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-6-970b33678512@bootlin.com>
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
In-Reply-To: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
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
2.48.1


