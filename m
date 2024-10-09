Return-Path: <linux-kselftest+bounces-19331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C39966C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F931281A36
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B1190079;
	Wed,  9 Oct 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EcYyMg4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AB18E032;
	Wed,  9 Oct 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468748; cv=none; b=Zdi2Rk1GOekmbLPHXdNjiQc6pQt4Ovkmb8j6zyaE+XloYszbIre1MBbW1uBnPXIUqdh2Ul7EgpjcT7KjoBu8npUP93KR1cInw8EJqvAP/gvMr96rPQ7lmVXwVfb/gjUV3QeMbgN9vL4jDXqaJWVON3rvZKHeLBxPUmrnQ6bqig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468748; c=relaxed/simple;
	bh=/MjG4vnVCYH/bL0Fpir5fybtc7DNNdbav0sj509sn3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyK/kjeA390b0bYg9KpHmhTK4Lo6JVlqsI+mOAif/TEEEE/vJu9b8m0zdkY3GUz/rwNvUmDB/5QWCV5g15nhe/sR+OxMWf/U6CH9+sSl0xUwagJvRMWA5i+miUcb3OajQyZ96NSJh//4ra1CFbgq196s3zu3a5W1JsNU+0kcmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EcYyMg4v; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A112FF802;
	Wed,  9 Oct 2024 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728468738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aFvx6YzdwynWAS6DUpsryuCGHx2eWE9Ff6QlQJ4FstI=;
	b=EcYyMg4vo0+feLXKUX+0EOPFaOZ5nwJ1FFrSexYv59X9JpPb7b/SE5XXjpem4/Ug+KMdy1
	PMNEClDRDFPSpP9WMECxPSHuMeUdWlZSnMGERlXlyKLV1TbZmjK2wjk2C+qXQcMoaurD5n
	87h2ynaQ0s7ZLPyP39+EJ+5xpvHHh3sM3V9WSH7E0Dy2d16Zrm2BZWfkvYa1svUlv48xcl
	tQX7VbDy45ua2u0lIK9P+5jabheZeURI65JUecz3eOikr8h5xZC4rzH/OcO5euK+tcjm8G
	1C+K+IS21LhYB4t/5NB4/L3DtahD5ZF1AYoGlQh+LgKSOocQr74OE93oziyxWQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 09 Oct 2024 12:12:08 +0200
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: make xdp_cpumap_attach keep
 redirect prog attached
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241009-convert_xdp_tests-v3-2-51cea913710c@bootlin.com>
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
In-Reply-To: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
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
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Current test only checks attach/detach on cpu map type program, and so
does not check that it can be properly executed, neither that it
redirects correctly.

Update the existing test to extend its coverage:
- keep the redirected program loaded
- try to execute it through bpf_prog_test_run_opts with some dummy
  context

While at it, bring the following minor improvements:
- isolate test interface in its own namespace
- replicate the test on a veth pair

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
This change is based on the similar update brought to xdp_devmap_attach
([1]) and then realigns xdp_cpumap_attach with it

[1] https://lore.kernel.org/bpf/20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de/

Changes in v3:
- new patch
---
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   | 124 +++++++++++++++++++--
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 481626a875d1c3db9c7bfe92c3cca6e967a6d45c..31c225f0239613f6b5adad36b5b0e6e85eeddd9a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -2,35 +2,41 @@
 #include <uapi/linux/bpf.h>
 #include <linux/if_link.h>
 #include <test_progs.h>
+#include <network_helpers.h>
 
 #include "test_xdp_with_cpumap_frags_helpers.skel.h"
 #include "test_xdp_with_cpumap_helpers.skel.h"
 
 #define IFINDEX_LO	1
+#define TEST_NS "cpu_attach_ns"
 
 static void test_xdp_with_cpumap_helpers(void)
 {
-	struct test_xdp_with_cpumap_helpers *skel;
+	struct test_xdp_with_cpumap_helpers *skel = NULL;
 	struct bpf_prog_info info = {};
 	__u32 len = sizeof(info);
 	struct bpf_cpumap_val val = {
 		.qsize = 192,
 	};
-	int err, prog_fd, map_fd;
+	int err, prog_fd, prog_redir_fd, map_fd;
+	struct nstoken *nstoken = NULL;
 	__u32 idx = 0;
 
+	SYS(out_close, "ip netns add %s", TEST_NS);
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out_close;
+	SYS(out_close, "ip link set dev lo up");
+
 	skel = test_xdp_with_cpumap_helpers__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
-	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
+	prog_redir_fd = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(IFINDEX_LO, prog_redir_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_OK(err, "Generic attach of program with 8-byte CPUMAP"))
 		goto out_close;
 
-	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
-	ASSERT_OK(err, "XDP program detach");
-
 	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
 	map_fd = bpf_map__fd(skel->maps.cpu_map);
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
@@ -45,6 +51,23 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_OK(err, "Read cpumap entry");
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
+	/* send a packet to trigger any potential bugs in there */
+	char data[10] = {};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = 10,
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+		);
+	err = bpf_prog_test_run_opts(prog_redir_fd, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	err = bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
 	/* can not attach BPF_XDP_CPUMAP program to a device */
 	err = bpf_xdp_attach(IFINDEX_LO, prog_fd, XDP_FLAGS_SKB_MODE, NULL);
 	if (!ASSERT_NEQ(err, 0, "Attach of BPF_XDP_CPUMAP program"))
@@ -65,6 +88,8 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_NEQ(err, 0, "Add BPF_XDP program with frags to cpumap entry");
 
 out_close:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
 	test_xdp_with_cpumap_helpers__destroy(skel);
 }
 
@@ -111,6 +136,88 @@ static void test_xdp_with_cpumap_frags_helpers(void)
 	test_xdp_with_cpumap_frags_helpers__destroy(skel);
 }
 
+static void test_xdp_with_cpumap_helpers_veth(void)
+{
+	int err, cm_fd, cm_fd_redir, map_fd, ifindex_dst, ifindex_src;
+	struct test_xdp_with_cpumap_helpers *skel = NULL;
+	struct bpf_prog_info info = {};
+	struct bpf_cpumap_val val = {
+		.qsize = 192
+	};
+	struct nstoken *nstoken = NULL;
+	__u32 len = sizeof(info);
+	__u32 idx = 0;
+
+	SYS(out_close, "ip netns add %s", TEST_NS);
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out_close;
+
+	SYS(out_close, "ip link add veth_src type veth peer name veth_dst");
+	SYS(out_close, "ip link set dev veth_src up");
+	SYS(out_close, "ip link set dev veth_dst up");
+
+	ifindex_src = if_nametoindex("veth_src");
+	ifindex_dst = if_nametoindex("veth_dst");
+	if (!ASSERT_NEQ(ifindex_src, 0, "val.ifindex") ||
+	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
+		goto out_close;
+
+	skel = test_xdp_with_cpumap_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_with_cpumap_helpers__open_and_load"))
+		goto out_close;
+
+	cm_fd_redir = bpf_program__fd(skel->progs.xdp_redir_prog);
+	err = bpf_xdp_attach(ifindex_src, cm_fd_redir, XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "Attach of program with 8-byte cpumap"))
+		goto out_close;
+
+	cm_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
+	map_fd = bpf_map__fd(skel->maps.cpu_map);
+	err = bpf_prog_get_info_by_fd(cm_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		goto out_close;
+
+	val.bpf_prog.fd = cm_fd;
+	err = bpf_map_update_elem(map_fd, &idx, &val, 0);
+	ASSERT_OK(err, "Add program to cpumap entry");
+
+	err = bpf_map_lookup_elem(map_fd, &idx, &val);
+	ASSERT_OK(err, "Read cpumap entry");
+	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
+
+	/* attach dummy to other side to enable reception */
+	cm_fd = bpf_program__fd(skel->progs.xdp_dummy_prog);
+	err = bpf_xdp_attach(ifindex_dst, cm_fd, XDP_FLAGS_DRV_MODE, NULL);
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
+	err = bpf_prog_test_run_opts(cm_fd_redir, &opts);
+	ASSERT_OK(err, "XDP test run");
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	err = bpf_xdp_detach(ifindex_src, XDP_FLAGS_DRV_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
+	err = bpf_xdp_detach(ifindex_dst, XDP_FLAGS_DRV_MODE, NULL);
+	ASSERT_OK(err, "XDP program detach");
+
+out_close:
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
+	test_xdp_with_cpumap_helpers__destroy(skel);
+}
+
 void serial_test_xdp_cpumap_attach(void)
 {
 	if (test__start_subtest("CPUMAP with programs in entries"))
@@ -118,4 +225,7 @@ void serial_test_xdp_cpumap_attach(void)
 
 	if (test__start_subtest("CPUMAP with frags programs in entries"))
 		test_xdp_with_cpumap_frags_helpers();
+
+	if (test__start_subtest("CPUMAP attach with programs in entries on veth"))
+		test_xdp_with_cpumap_helpers_veth();
 }

-- 
2.46.2


