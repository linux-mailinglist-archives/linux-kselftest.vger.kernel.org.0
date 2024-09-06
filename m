Return-Path: <linux-kselftest+bounces-17400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C896F680
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DE9286BDC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D381D1F4B;
	Fri,  6 Sep 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="De5c23xW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDefjgfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7D1EEF9;
	Fri,  6 Sep 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632207; cv=none; b=ZYBymUilvzhk0wnC/asr5LWP6Tqtkv/GhRAppiSLp6IWueJsJhwd54gl2PBfXbnYDRAwcsRhjev7BIlfVTa+hk4dbXvSAGkgJaTX4zdzOGDlz8F8qyGogKLZgLv5AkdMEklPIPu9hWasMijYEMC84RW6UT0FG3rtGhaspyObflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632207; c=relaxed/simple;
	bh=5DPoF+h1EijAJWiofVUgPO7pld2cGAEtC+ql8P6zBx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwhUfaU3T1J+oevq9D5iHm4+lTL+0j/0eeZNmZ728nVWjdJToftq5qMdWOm/RKRvFimIbM+6MvU4j0Jqm13XAWnTR0NN64X8UJXbzFT6XkahITsA2rE4AhMYKpgTx1mhobLzStNAf+pXjFdCM6ZI+4k24fjP4aMYN07ln0cF/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=De5c23xW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDefjgfk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725632203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1z+D6rnTHlvixKu5XBWRY4qyLlh6HJytqd5jXsU3JM=;
	b=De5c23xWRzCTr9Dn9RLVUV/L8G2F4jWkSQ8pVvDnIJXYouFqKRDAh1l8toNabEjqyeQ5YY
	SiU0/Ikz7ECUr+E78qltK21CW4yh0aItVwijYDHpsfzSpXGn71MEIbNxcNaH4wfilEPF/Y
	Sb+tH7MNw30JNLxty/Mbd7KwLnmEtxJpfCKZ40hvC/qbEZCfcbCSOu+NYnAdgk/NYv1XAH
	6p+zZYZFPsyLG2sbW+/Y7QLeMnrrESpOfk3KKV96vWPloRY0Eyg9r0CbOTpVVTKaRimUPH
	WsSzi98g2juXQ706gjkRnujB/TArZuepwLgtUlfEpNVO34S1GNwbbr2ZOA7nmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725632203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1z+D6rnTHlvixKu5XBWRY4qyLlh6HJytqd5jXsU3JM=;
	b=cDefjgfkis0YCljz1gwj7x9pWPErwqsrRTtCqN63yGLP2mfmzwGXLHcQs4C7fADRp6C9Cm
	7kLlYZRZTg37rGCA==
Date: Fri, 06 Sep 2024 16:16:26 +0200
Subject: [PATCH net v2 2/2] bpf: selftests: send packet to devmap redirect
 XDP
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-devel-koalo-fix-ingress-ifindex-v2-2-4caa12c644b4@linutronix.de>
References: <20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de>
In-Reply-To: <20240906-devel-koalo-fix-ingress-ifindex-v2-0-4caa12c644b4@linutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6413;
 i=florian.kauer@linutronix.de; h=from:subject:message-id;
 bh=5DPoF+h1EijAJWiofVUgPO7pld2cGAEtC+ql8P6zBx0=;
 b=owEBbQKS/ZANAwAKATKF5IolV+EkAcsmYgBm2w7GwtWu7yC2TKTi5Y09ZIrOptkC3OgftiJCS
 zH5CekIrE2JAjMEAAEKAB0WIQSG5cmCLvpm5t9g7UUyheSKJVfhJAUCZtsOxgAKCRAyheSKJVfh
 JFo8D/9nPIN101HZhRoUJRyaBRqc1Fg5WD2Dk26WuBVHcdS+Uhbi9ouuZdIc+mPvKcjSseKwz86
 CKXYK68MG8nLUjlMwSu/gSvMQkVKugBXOTAPJbFfIAzEgAWaEuPP/z6TBdNUN3O8KMJIkMC3czB
 ATFDWkWldsdl4+ek8kFY36yeEjQUXj3tHUGsMY8uMuadIFXZUdOBpX4IcCFUwi/XDW/FcdL6KKd
 8S4NsJatzCVuRIR4ve6wSLdLnOMyslF6qYDAO4VxU18F5OOQbKM6lYgxFUv2TYeN8wrU5CUO4fL
 yG3NCgib87fXjY3heMNdBLRSz5lhG6j2zSMPMlI/41sltOmajYUQMPbrIRa+kZp5Zk2fAKlyT2r
 uX6eP/kBwhlDz+P7AEb5qIQTGAjwtm6w7FpaPxgFD/8I0kt9FbZ3Z+cLquKC+mUl6yQex48LIcr
 SlqFW86iybCnXMHyworkUN9xmsWF1fCwH0BQ/ns8LMRdz17rsy0zjCyFD/mfgfnADEvB65Y8txa
 dILUXE2zwVTQY5ULTuvYdFY83Xl8/p3otZk2CGTesurY7y6+oRiBco5OqN2wdTf2uXf7k9yhRnN
 vC6uKmQ+xLT2RHn0d0+Ng7lHJP3QiNhhPB2LGTBVqi1wRj2tNEoy+1+3s8kYNs/oKkoBORAAIIk
 DNSANF/ecc2BgcQ==
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
index ce6812558287..c9034f8ae63b 100644
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
+	struct test_xdp_with_devmap_helpers *skel;
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


