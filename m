Return-Path: <linux-kselftest+bounces-13555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6A92E1A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724F41C2118F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30021156C71;
	Thu, 11 Jul 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nUb56iHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1F1534E8;
	Thu, 11 Jul 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685427; cv=none; b=UW3Htr2JpI5j2Ifl2dPARwEr9PLzlQyDsPnRsFJzuP299JuvTNAkeJqlod4IpfEwsadon6BVczDoN8lC+uIMUkpM9+VucEaDaufIkNPgkKL7IBmCDUTgsqxK6oFrECs0EdDCqYI6zIVatn2jBia2FfA4wcg58utTh0wofmkQCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685427; c=relaxed/simple;
	bh=x/iXNUrlHigefnNK/NL+TAEH29mguZmL2VPrwYKASZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hsizS+n8Rv+QE57t2G9m0QnSRuFP+ofIC+SU81UpHbvK0G8JCEDXaCDiQ18kAfiGwDJ1dDLIDLIIY6qf/6Od9SGLFoyszEdKzgyyAHgv0AoGsf9CAhBDEEUb9xfBbVMbF67aEV8VAPV95mIBiZESjmS/CgguG406vEZuNK5iVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nUb56iHZ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0170E0010;
	Thu, 11 Jul 2024 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4LuYXUG0cbHwXxvripiI1Fk7E2z3/mXVx6GX3wmY9g=;
	b=nUb56iHZ40o9qnw+AaWZmQNGPsZ61zgPZoOz37TH5jtvcQz8+Yz9xuAjgg73pOK8+lU+Vr
	IqYbZaXppSQxXDB4mcVorqoExOx7CB0h8z1pG9BL1M9VciAPJxqYV1RsMJjj14jTfZqvr1
	QYT6kHSvy+GPYhmknuGn/48HiPSf/vjNjTHEXwMT189hmQVhOFn+GHt8e1miwUphPlX0zU
	Adn0in28HDHpwzJ3E0MSNqeMbP4ZUEnFnMa/c7jKhgLDCWlTjTHKWiwOBVt+a6IGx+0Sko
	3+da0m0DdoM6HWRv6eQ5IaHU4WxfFcChVi10GIdgEHxaFFFEmbjIUmpDH/ZA5g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 11 Jul 2024 10:09:35 +0200
Subject: [PATCH 2/3] selftests/bpf: integrate test_xdp_veth into test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240711-convert_test_xdp_veth-v1-2-868accb0a727@bootlin.com>
References: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
In-Reply-To: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
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
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

test_xdp_veth.sh tests that XDP return codes work as expected, by bringing
up multiple veth pairs isolated in different namespaces, attaching specific
xdp programs to each interface, and ensuring that the whole chain allows to
ping one end interface from the first one. The test runs well but is
currently not integrated in test_progs, which prevents it from being run
automatically in the CI infrastructure.

Rewrite it as a C test relying on libbpf to allow running it in the CI
infrastructure. The new code brings up the same network infrastructure and
reuses the same eBPF programs as test_xdp_veth.sh, for which skeletons are
already generated by the bpf tests makefile.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
The new code has been tested in an aarch64 qemu instance:
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

I have also checked that some minor alterations in the network
configuration (altering the redirect map, or not loading one of the xdp
programs) make the test fail.

On my testing setup, the test takes a bit more than 3 seconds to run on
average.
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 234 +++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
new file mode 100644
index 000000000000..40d85aece984
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Create 3 namespaces with 3 veth peers, and
+ * forward packets in-between using native XDP
+ *
+ *                      XDP_TX
+ * NS1(veth11)        NS2(veth22)        NS3(veth33)
+ *      |                  |                  |
+ *      |                  |                  |
+ *   (veth1,            (veth2,            (veth3,
+ *   id:111)            id:122)            id:133)
+ *     ^ |                ^ |                ^ |
+ *     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
+ *     | ------------------ ------------------ |
+ *     -----------------------------------------
+ *                    XDP_REDIRECT
+ */
+
+#define _GNU_SOURCE
+#include <net/if.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "xdp_dummy.skel.h"
+#include "xdp_redirect_map.skel.h"
+#include "xdp_tx.skel.h"
+
+#define VETH_PAIRS_COUNT	3
+#define NS_NAME_MAX_LEN		16
+#define NS_SUFFIX_LEN		6
+#define VETH_NAME_MAX_LEN	16
+#define IP_SRC				"10.1.1.11"
+#define IP_DST				"10.1.1.33"
+#define IP_CMD_MAX_LEN		128
+
+struct skeletons {
+	struct xdp_dummy *xdp_dummy;
+	struct xdp_tx *xdp_tx;
+	struct xdp_redirect_map *xdp_redirect_maps;
+};
+
+struct veth_configuration {
+	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
+	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
+	char namespace[NS_NAME_MAX_LEN]; /* Namespace for the remote veth */
+	char next_veth[VETH_NAME_MAX_LEN]; /* Local interface to redirect traffic to */
+	char *remote_addr; /* IP address of the remote veth */
+};
+
+static struct veth_configuration config[VETH_PAIRS_COUNT] = {
+	{
+		.local_veth = "veth1",
+		.remote_veth = "veth11",
+		.next_veth = "veth2",
+		.remote_addr = IP_SRC
+	},
+	{
+		.local_veth = "veth2",
+		.remote_veth = "veth22",
+		.next_veth = "veth3",
+		.remote_addr = NULL
+	},
+	{
+		.local_veth = "veth3",
+		.remote_veth = "veth33",
+		.next_veth = "veth1",
+		.remote_addr = IP_DST
+	}
+};
+
+static void generate_random_ns_name(int index, char *out)
+{
+	int random, count, i;
+
+	count = snprintf(out, NS_NAME_MAX_LEN, "ns%d-", index);
+	for(i=0; i<NS_SUFFIX_LEN; i++) {
+		random=rand() % 2;
+		out[count++]= random ? 'a' + rand() % 26 : 'A' + rand() % 26;
+	}
+	out[count] = 0;
+}
+
+static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
+{
+	struct bpf_program *local_prog, *remote_prog;
+	struct bpf_link **local_link, **remote_link;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+	int interface;
+
+	switch(index) {
+		case 0:
+			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_0;
+			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_0;
+			remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
+			remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
+			break;
+		case 1:
+			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_1;
+			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_1;
+			remote_prog = skeletons->xdp_tx->progs.xdp_tx;
+			remote_link = &skeletons->xdp_tx->links.xdp_tx;
+			break;
+		case 2:
+			local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_2;
+			local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_2;
+			remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
+			remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
+			break;
+	}
+	interface = if_nametoindex(config[index].local_veth);
+	if(!ASSERT_NEQ(interface, 0, "non zero interface index"))
+		return -1;
+	link = bpf_program__attach_xdp(local_prog, interface);
+	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
+		return -1;
+	*local_link = link;
+	nstoken = open_netns(config[index].namespace);
+	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
+		return -1;
+	interface = if_nametoindex(config[index].remote_veth);
+	if(!ASSERT_NEQ(interface, 0, "non zero interface index"))
+		return -1;
+	link = bpf_program__attach_xdp(remote_prog, interface);
+	*remote_link = link;
+	close_netns(nstoken);
+	if (!ASSERT_OK_PTR(link, "attach xdp program to remote veth"))
+		return -1;
+
+	return 0;
+}
+
+static int configure_network(struct skeletons *skeletons) {
+	int interface_id;
+	int map_fd;
+	int err;
+	int i=0;
+
+	/* First create and configure all interfaces */
+	for(i=0; i<VETH_PAIRS_COUNT; i++) {
+		generate_random_ns_name(i+1, config[i].namespace);
+
+		SYS(fail, "ip netns add %s", config[i].namespace);
+		SYS(fail, "ip link add %s type veth peer name %s netns %s",
+				config[i].local_veth,
+				config[i].remote_veth,
+				config[i].namespace);
+		SYS(fail, "ip link set dev %s up", config[i].local_veth);
+		if (config[i].remote_addr)
+			SYS(fail, "ip -n %s addr add %s/24 dev %s",
+					   config[i].namespace, config[i].remote_addr, config[i].remote_veth);
+		SYS(fail, "ip -n %s link set dev %s up",
+				   config[i].namespace, config[i].remote_veth);
+	}
+
+	/* Then configure the redirect map and attach programs to interfaces */
+	map_fd = bpf_map__fd(skeletons->xdp_redirect_maps->maps.tx_port);
+	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
+		goto fail;
+	for (i=0; i<VETH_PAIRS_COUNT; i++) {
+		interface_id = if_nametoindex(config[i].next_veth);
+		if(!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
+			goto fail;
+		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
+		if (!ASSERT_OK(err, "configure interface redirection through map"))
+			goto fail;
+		if(attach_programs_to_veth_pair(skeletons, i))
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	return -1;
+}
+
+static void cleanup_network()
+{
+	char cmd[IP_CMD_MAX_LEN];
+	int i;
+
+	/* Deleting namespaces is enough to automatically remove veth pairs as well
+	 */
+	for(i=0; i<VETH_PAIRS_COUNT; i++) {
+		if(config[i].namespace[0] == 0)
+			continue;
+		snprintf(cmd, IP_CMD_MAX_LEN, "ip netns del %s", config[i].namespace);
+		system(cmd);
+	}
+}
+
+static int check_ping(struct skeletons *skeletons)
+{
+	char cmd[IP_CMD_MAX_LEN];
+
+	/* Test: if all interfaces are properly configured, we must be able to ping
+	 * veth33 from veth11
+	 */
+	snprintf(cmd, IP_CMD_MAX_LEN,
+			 "ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
+			 config[0].namespace, IP_DST);
+	return system(cmd);
+}
+
+void test_xdp_veth_redirect()
+{
+	struct skeletons skeletons = {};
+
+	skeletons.xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
+		return;
+
+	skeletons.xdp_tx = xdp_tx__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_tx, "xdp_tx__open_and_load"))
+		goto destroy_xdp_dummy;
+
+	skeletons.xdp_redirect_maps = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_maps, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_tx;
+
+	if(configure_network(&skeletons))
+		goto destroy_xdp_redirect_map;
+
+	ASSERT_OK(check_ping(&skeletons), "ping");
+
+
+destroy_xdp_redirect_map:
+	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);
+destroy_xdp_tx:
+	xdp_tx__destroy(skeletons.xdp_tx);
+destroy_xdp_dummy:
+	xdp_dummy__destroy(skeletons.xdp_dummy);
+
+	cleanup_network();
+}

-- 
2.45.2


