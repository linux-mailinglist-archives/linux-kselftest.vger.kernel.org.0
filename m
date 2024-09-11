Return-Path: <linux-kselftest+bounces-17732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E28974CE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638EC1F28B43
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697791714C7;
	Wed, 11 Sep 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0y/KHYd6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="znAiGBFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C81547CF;
	Wed, 11 Sep 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044109; cv=none; b=hWw0JAHdCq2AosQxx2JKGUoFTrhcH4dYsjKsFyjgQGdl84DbpoaFaIaS5G7+hlxlHHjWg+D1Gv5ayk2tljB/0y52ju5AXY9i5v7eTSHU3zyGOqVAE/OMATsE4BXHJbIM7dLqHGcp/9ftDGNwAK4QZyfFQhmxrY0AjMfjI8+Rm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044109; c=relaxed/simple;
	bh=Tx4/pT8qFSodepQPWKDasNYG6F57zRV9CLJDkS7Vo6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K54PncNiJHK7Pg06ZgS3hnlABTtEAagw2c/iZRQ0Sxgx1MeijC4p4BNoJ7XYiQPpGms9bsyFmEdPNSglVFgAYP8c/17Ez7/Elzlinl3Gxv8EXjqDxm6DqbEo2YXJbe0WjgjEg9nAazF1fevoyUvHi5KwZN4LxIspcGU+eLBvA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0y/KHYd6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=znAiGBFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726044105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVxu958V8507cUbid7tMca8UQrmhre2RgIlcswCFXZM=;
	b=0y/KHYd6eL31QtaCLofVoBHCCNTZjp4GGUt2xkddH8E94D4/HNJH8f87O4v2B1lZngGo6w
	u0gdl9tjaCRTXRsXYRnIsnBJVsmEvkaf0U/0CIakKS33UI7udBnI9wBKUK/9TBeynqrfrb
	UGi6koDxFC+Hlj+ADqBNMmVRSTyIZuwlZup5GzAisJIW7vc43Zb99uCw5bKTkSofPb1wH2
	tgGHD6JxlNADDqEjsu4pZHWLF+tJSKkEzLAi7cgaRr2rJJ7302eJTzcHHaR8qpcvIp3j9V
	k48nphriOLtklBKMyevpkpaRNcLEWZvv5Ta0UbNuBVcl2aT39JyMggRiQ8UHbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726044105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVxu958V8507cUbid7tMca8UQrmhre2RgIlcswCFXZM=;
	b=znAiGBFrvXDxMThShtSpJRsee4RLO0O1d01pXPWZfw6t9uca41sdQrnDIHtaAIOb+08jve
	XZx7yUGDHW4e78CA==
Date: Wed, 11 Sep 2024 10:41:19 +0200
Subject: [PATCH net v4 2/2] bpf: selftests: send packet to devmap redirect
 XDP
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de>
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
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
 Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, 
 linux-kselftest@vger.kernel.org, 
 Florian Kauer <florian.kauer@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6428;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=Tx4/pT8qFSodepQPWKDasNYG6F57zRV9CLJDkS7Vo6s=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm4VfDjrVIdwzowFeCGWyOJilwgiz3LaBHH9Oe4
 km9RQ3PhV2JAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZuFXwwAKCRAyheSKJVfh
 JPdrEADTv/J5QaUU+9btNzGizLZ03zAO5etez+MpKfSj0sXsDLYWQHkjB9ERjVOi0gEYWUrf/dw
 ohISsRRknlyCucP/VVf8yK5VmibGeeiu53b2H406nvPZ8dT8LoqW3rH5AcFFNCM7V5Ed0cEl+jc
 Di0/pwdhUBp9OYfLi4vs1v0ssPBUYIJ9CnZihd52Jo/89fl1ZPFLHljzU2Kq3W9eGE9fjniHq/9
 5S3IgCNBn2jMk1sbx3McLEYX4f+AigCT3XNhHsdd3mVOrP6TTbV21eOihnC37mthaPFTCwIPsO9
 VrFQ9hHQhNFma400UhGSeJwKUs8QaTS5jiDxRMLw27fTnvaCqDkCOs2R6IBXZKeaoL8UuLXOcZr
 H8UYoF083e9uv2/n1aUFtqEULV0BXTvP3lDVW6gIyKJMHOzORK+pDtmO3pKmuobXrCQnSvzt6uQ
 UP9mqq8Mv06BrmW2fnvln0rlxVytx5SsIfdP7sGaOy1uguYcPtbUUY+3ZmSZaYAKNhO1Xx7sHCB
 WE2nCPAhUO9lymz4wlrtOG2Zp7PW+duXtOEJ+v45UjOODIFWc9JQt3g249ClIR41pv5pHzwsYAi
 ajpZ9DOQMyaaSDL4cdai0vCB4xKuh/LqVlFdD1B/dROHcFbNtAl5/8tAqsX3wqptAlzDW0E6MpG
 JAnhqZP2vbkX6kg==
X-Developer-Key: i=florian.kauer@linutronix.de; a=openpgp;
 fpr=F17D8B54133C2229493E64A0B5976DD65251944E

The current xdp_devmap_attach test attaches a program
that redirects to another program via devmap.

It is, however, never executed, so do that to catch
any bugs that might occur during execution.

Also, execute the same for a veth pair so that we
also cover the non-generic path.

Warning: Running this without the bugfix in this series
will likely crash your system.

Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
---
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
 1 file changed, 108 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index ce6812558287..b4f6718cf7eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
 #include <uapi/linux/bpf.h>
 #include <linux/if_link.h>
+#include <network_helpers.h>
+#include <net/if.h>
 #include <test_progs.h>
 
 #include "test_xdp_devmap_helpers.skel.h"
@@ -17,7 +20,7 @@ static void test_xdp_with_devmap_helpers(void)
 		.ifindex = IFINDEX_LO,
 	};
 	__u32 len = sizeof(info);
-	int err, dm_fd, map_fd;
+	int err, dm_fd, dm_fd_redir, map_fd;
 	__u32 idx = 0;
 
 
@@ -25,14 +28,11 @@ static void test_xdp_with_devmap_helpers(void)
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
 		return;
 
-	dm_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
+	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(IFINDEX_LO, dm_fd_redir, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte devmap"))
 		goto out_close;
 
-	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
-	ASSERT_OK(err, "XDP program detach");
-
 	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
 	map_fd = bpf_map__fd(skel->maps.dm_ports);
 	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
@@ -47,6 +47,23 @@ static void test_xdp_with_devmap_helpers(void)
 	ASSERT_OK(err, "Read devmap entry");
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
 
+	/* send a packet to trigger any potential bugs in there */
+	char data[10] = {};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = 10,
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(dm_fd_redir, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
 	/* can not attach BPF_XDP_DEVMAP program to a device */
 	err = bpf_xdp_attach(IFINDEX_LO, dm_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_DEVMAP program"))
@@ -124,6 +141,88 @@ static void test_xdp_with_devmap_frags_helpers(void)
 	test_xdp_with_devmap_frags_helpers__destroy(skel);
 }
 
+static void test_xdp_with_devmap_helpers_veth(void)
+{
+	struct test_xdp_with_devmap_helpers *skel = NULL;
+	struct bpf_prog_info info = {};
+	struct bpf_devmap_val val = {};
+	struct nstoken *nstoken = NULL;
+	__u32 len = sizeof(info);
+	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
+	__u32 idx = 0;
+
+	SYS(out_close, "ip netns add testns");
+	nstoken = open_netns("testns");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto out_close;
+
+	SYS(out_close, "ip link add veth_src type veth peer name veth_dst");
+	SYS(out_close, "ip link set dev veth_src up");
+	SYS(out_close, "ip link set dev veth_dst up");
+
+	val.ifindex = if_nametoindex("veth_src");
+	ifindex_dst = if_nametoindex("veth_dst");
+	if (!ASSERT_NEQ(val.ifindex, 0, "val.ifindex") ||
+	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
+		goto out_close;
+
+	skel = test_xdp_with_devmap_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_with_devmap_helpers__open_and_load"))
+		goto out_close;
+
+	dm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(val.ifindex, dm_fd_redir, XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "Attach of program with 8-byte devmap"))
+		goto out_close;
+
+	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
+	map_fd = bpf_map__fd(skel->maps.dm_ports);
+	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		goto out_close;
+
+	val.bpf_prog.fd = dm_fd;
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_OK(err, "Add program to devmap entry");
+
+	err = bpf_map_lookup_elem(map_fd, &idx, &val);
+	ASSERT_OK(err, "Read devmap entry");
+	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to devmap entry prog_id");
+
+	/* attach dummy to other side to enable reception */
+	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
+	err = bpf_xdp_attach(ifindex_dst, dm_fd, XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "Attach of dummy XDP"))
+		goto out_close;
+
+	/* send a packet to trigger any potential bugs in there */
+	char data[10] = {};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = 10,
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(dm_fd_redir, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	err = bpf_xdp_detach(val.ifindex, XDP_FLAGS_DRV_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
+	err = bpf_xdp_detach(ifindex_dst, XDP_FLAGS_DRV_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
+out_close:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del testns");
+
+	test_xdp_with_devmap_helpers__destroy(skel);
+}
+
 void serial_test_xdp_devmap_attach(void)
 {
 	if (test__start_subtest("DEVMAP with programs in entries"))
@@ -134,4 +233,7 @@ void serial_test_xdp_devmap_attach(void)
 
 	if (test__start_subtest("Verifier check of DEVMAP programs"))
 		test_neg_xdp_devmap_helpers();
+
+	if (test__start_subtest("DEVMAP with programs in entries on veth"))
+		test_xdp_with_devmap_helpers_veth();
 }

-- 
2.39.2


