Return-Path: <linux-kselftest+bounces-17549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D69722E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7765C1C22793
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345918A947;
	Mon,  9 Sep 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wY2aDLJZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdVOgTA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5F18A6B1;
	Mon,  9 Sep 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910707; cv=none; b=QZJT3rp3rWm+3BP8cvNQJM+8WNUUPT+DhMFKVbnR4vskxVn5uMn9J/yz4SakSeNQnKjDwA9Ig596B/xeWBosLnSLc1MmrF3bQGYh5RguyHLZaSPMXK6cPrEY0+QZEZ+cP4yoXyBoE2O4cVcvKbuKdFqUyJiSAw/YKFQC+zggM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910707; c=relaxed/simple;
	bh=FoRzmTfWB/ubWW7w8X6rp310gV8eZN6pBJFbfTCb2zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsV17wCLeZt+MS9lbg/+6wePfnPjVepX5GRNwbJei/q5wYIkLGGy01KkyHf+Ar/1AEXKUgdMz4Hrrs0Gg8SruTUH0HV/KmMAIHBFuqCtLqNcS7Y2V9qcoUVG9a92Ir6CGCUhTxWvECPlF4XWBPn4+hsaUQj2oS/r/nxC+RiVpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wY2aDLJZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdVOgTA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725910703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/rVgzkeLwv0MCr5I/dWSSAStfGVTRozaQ6oIp100Tc=;
	b=wY2aDLJZFj5w2zwZ8IiLameO7mrJui+No8zIwHU/rUvayDl7KEKa2m1dKHyz7wdGi7QAt+
	EyPkWGJpvMLUM1sIJV+L2TSjpbz5QGNIPiX+YSU8cHe1MveSl/TqdLG3XZJU7TngtWjqIw
	rT/DmOAFUDy5RxYMpKv13+ipmkQvDs3xvnTSv0EYla/A9pelp991s2Oej7au3PX9/C6xL7
	5Io6kMtP4876+28HVdjgRjrzSbY52LTM+HXdOOl0XvP1E4whSj80IdtDqseLBFiRJuDfK6
	QQJOPuOK2Eg/zywsxCqibzhIPCff/6RAbc2+Awe7JXj0cGsesqNp4chLmpqgLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725910703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/rVgzkeLwv0MCr5I/dWSSAStfGVTRozaQ6oIp100Tc=;
	b=TdVOgTA9bZZlfbInePeh5Hw2iMzphnIJdnOsVcSk34C9lh6VEjC6DHk8hQ0aQVu0U47jcB
	J7BFzPSN6oOSYSBQ==
Date: Mon, 09 Sep 2024 21:38:06 +0200
Subject: [PATCH net v3 2/2] bpf: selftests: send packet to devmap redirect
 XDP
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-devel-koalo-fix-ingress-ifindex-v3-2-66218191ecca@linutronix.de>
References: <20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de>
In-Reply-To: <20240909-devel-koalo-fix-ingress-ifindex-v3-0-66218191ecca@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=FoRzmTfWB/ubWW7w8X6rp310gV8eZN6pBJFbfTCb2zQ=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm306qL7HJg+td3bzJ95v1kUjOFDR2QM8+Wlg2E
 +A3dp3Smx2JAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZt9OqgAKCRAyheSKJVfh
 JAuuEADGftuWw7ZzzEhGJwscBiGlQ7yB4Jo/h+tF8obP5sNXyKNdlKUQ/TVmixKh82NaRjmnYh6
 aiWEuR7wEK7s8SkyXWfhTG/O8wH9aqEwpA2vzi6C7UcztsH7J5GihOpXQJAIHM0VIXQdyAYfFQn
 G+AaMBTKJEwv54VNPCTls2QmMwUjk9IIi6vMZphB71k1TOJEZ9B3wiENpBHUf+ZfqrZOW3JKVTP
 5yjQS8upG1hef1ZVyq6xNGAsEIWY5N7AG04VV2w3SCRuVL+F9J5XXHXuv7XeIZcK+5pyeDIN9Ef
 tInzVNOVHJFaDhlaEfVEZ49HieEoQZqLH5RFoI0dyaoOCrC3F306Zy6JfE13ByCoRQADuRyXEVr
 kOsqQ3/M77r8+Hleo1DVeANGdeIStOjqQFodMeveKEhMxDkZsNQC/NrrBHvioQgAjVXeOVpGPgR
 Agc8Tg8oRC3ny7c3DlzDAFqK2bkT4HCKv+lszo1CY/UXTZREVa37yNm+mHnwGxiPHM8KyVgw73K
 UYs9gpCc31PsHmh3lAnFvfUDwCieVqdK+Tg31ABuzN+A8Cq7XUYTrtvK03yfST6kzQqX9x0Q9AS
 2v28SeSYGttiolwuheB0Jt5tSi2mPkKjeHDKMGhKqxe1xeWEoarpxoOp6z+wRp62fXcH9IO4Uab
 4+j2b9IpniGgYwQ==
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
index ce6812558287..3da45f719736 100644
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
+		return;
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


