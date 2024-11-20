Return-Path: <linux-kselftest+bounces-22322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A159D3477
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A04FB2397D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92218952C;
	Wed, 20 Nov 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ww4PHDC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850401662EF;
	Wed, 20 Nov 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088616; cv=none; b=DaAogCq4iJYUfx9X+O7tKqpDtMTI3MukWhA6b3vVwazyxfeu3TAhOk00Dl7sOOJEsf7NkpHxZYLgFewvdEAyUsBWZzbPC8h8ZPspzVBBBr2lqs20ReV1IZ7BH9sSy3aYMd+WQ1buY80U8i+gTXvNAu1ocG6uYJ3sFtW2Nfn+Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088616; c=relaxed/simple;
	bh=SHrNu+QRkvtmX28mCWs2McjVo10Z4pYUcjVFsIkSZIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxSTs+Pv62XMoCJM9PPzMD7RLYLz/0nFBi8C0Tffy3VCB/chleZi8pFGbIoTzNh+1brPqLlcsqknDVcnIzqvPBgu3+47/Q1pmF742nkWF0/8B5HBm6d36gPTNLWQm7YxgxDOcPl/YDJ8QzWz5LVuR5qajRAWhTZIgOHrhVHxuWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ww4PHDC3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A17AD24000B;
	Wed, 20 Nov 2024 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9sN0xUMQFvE81Z23kuBOqeFG+9pVDojihI+bvxU8jM=;
	b=Ww4PHDC34FJ3d9emH+9wBgpsRewzLLYNMvRVmarEVaGuDJLT/+mH7TlkVdpEltnyQR6Sbo
	wzbQNPZrDmRhZ2exJoI+Yfm9Wv35Ac4NP1YuUIVJsH+UQ2Dkrh/LGvUBjEJ2WOCgHb2JKs
	lDcskzw+z8e2pLUURyMfX3hT7qRFNCI+f0XKlWOQxECKmZkZvjXmo1vqtlv8NOuuhvpkme
	tEPlgf6Y+J3fEoSoahmMDb/YJw2N5oXWsyl1OxBmtJDjGjK6+9pswPOgOgpO6j7wlTYCsB
	W6ABSs7wYAUdcjqGb/ZH6liQn4ZtpReUurZdpFg6fCmAsgR5vTcD9kIQBcY6hg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:14 +0100
Subject: [PATCH bpf-next v3 04/14] selftests/bpf: re-split main function
 into dedicated tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-4-45b46494f937@bootlin.com>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
In-Reply-To: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

The flow_dissector runs plenty of tests over diffent kind of packets,
grouped into three categories: skb mode, non-skb mode with direct
attach, and non-skb with indirect attach.

Re-split the main function into dedicated tests. Each test now must have
its own setup/teardown, but for the advantage of being able to run them
separately. While at it, make sure that tests attaching the bpf programs
are run in a dedicated ns.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
-none

Changes in v2:
- fix some error path sequences (eg: closing properly tap interface)
- isolate tests in dedicated ns
- do not make the tests as "serial" tests
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 108 ++++++++++++++-------
 1 file changed, 73 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 6fbe8b6dad561aec02db552caea02517ac1e2109..7e7051a85be7410d4c636af8cd58206a76afe49e 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -549,63 +549,117 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 	}
 }
 
-static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)
+void test_flow_dissector_skb_less_direct_attach(void)
 {
-	int err, prog_fd;
+	int err, prog_fd, tap_fd;
+	struct bpf_flow *skel;
+	struct netns_obj *ns;
+
+	ns = netns_new("flow_dissector_skb_less_indirect_attach_ns", true);
+	if (!ASSERT_OK_PTR(ns, "create and open netns"))
+		return;
+
+	skel = bpf_flow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
+		goto out_clean_ns;
+
+	err = init_prog_array(skel->obj, skel->maps.jmp_table);
+	if (!ASSERT_OK(err, "init_prog_array"))
+		goto out_destroy_skel;
 
 	prog_fd = bpf_program__fd(skel->progs._dissect);
 	if (!ASSERT_OK_FD(prog_fd, "bpf_program__fd"))
-		return;
+		goto out_destroy_skel;
 
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
-		return;
+		goto out_destroy_skel;
+
+	tap_fd = create_tap("tap0");
+	if (!ASSERT_OK_FD(tap_fd, "create_tap"))
+		goto out_destroy_skel;
+	err = ifup("tap0");
+	if (!ASSERT_OK(err, "ifup"))
+		goto out_close_tap;
 
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
 	err = bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
 	ASSERT_OK(err, "bpf_prog_detach2");
+
+out_close_tap:
+	close(tap_fd);
+out_destroy_skel:
+	bpf_flow__destroy(skel);
+out_clean_ns:
+	netns_free(ns);
 }
 
-static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
+void test_flow_dissector_skb_less_indirect_attach(void)
 {
+	int err, net_fd, tap_fd;
+	struct bpf_flow *skel;
 	struct bpf_link *link;
-	int err, net_fd;
+	struct netns_obj *ns;
+
+	ns = netns_new("flow_dissector_skb_less_indirect_attach_ns", true);
+	if (!ASSERT_OK_PTR(ns, "create and open netns"))
+		return;
+
+	skel = bpf_flow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
+		goto out_clean_ns;
 
 	net_fd = open("/proc/self/ns/net", O_RDONLY);
 	if (!ASSERT_OK_FD(net_fd, "open(/proc/self/ns/net"))
-		return;
+		goto out_destroy_skel;
+
+	err = init_prog_array(skel->obj, skel->maps.jmp_table);
+	if (!ASSERT_OK(err, "init_prog_array"))
+		goto out_destroy_skel;
+
+	tap_fd = create_tap("tap0");
+	if (!ASSERT_OK_FD(tap_fd, "create_tap"))
+		goto out_close_ns;
+	err = ifup("tap0");
+	if (!ASSERT_OK(err, "ifup"))
+		goto out_close_tap;
 
 	link = bpf_program__attach_netns(skel->progs._dissect, net_fd);
 	if (!ASSERT_OK_PTR(link, "attach_netns"))
-		goto out_close;
+		goto out_close_tap;
 
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
 	err = bpf_link__destroy(link);
 	ASSERT_OK(err, "bpf_link__destroy");
-out_close:
+
+out_close_tap:
+	close(tap_fd);
+out_close_ns:
 	close(net_fd);
+out_destroy_skel:
+	bpf_flow__destroy(skel);
+out_clean_ns:
+	netns_free(ns);
 }
 
-void test_flow_dissector(void)
+void test_flow_dissector_skb(void)
 {
-	int i, err, prog_fd, keys_fd = -1, tap_fd;
 	struct bpf_flow *skel;
+	int i, err, prog_fd;
 
 	skel = bpf_flow__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
 		return;
 
-	prog_fd = bpf_program__fd(skel->progs._dissect);
-	if (!ASSERT_OK_FD(prog_fd, "bpf_program__fd"))
-		return;
-	keys_fd = bpf_map__fd(skel->maps.last_dissection);
-	if (!ASSERT_OK_FD(keys_fd, "bpf_map__fd"))
-		return;
 	err = init_prog_array(skel->obj, skel->maps.jmp_table);
 	if (!ASSERT_OK(err, "init_prog_array"))
-		return;
+		goto out_destroy_skel;
+
+	prog_fd = bpf_program__fd(skel->progs._dissect);
+	if (!ASSERT_OK_FD(prog_fd, "bpf_program__fd"))
+		goto out_destroy_skel;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_flow_keys flow_keys;
@@ -635,24 +689,8 @@ void test_flow_dissector(void)
 			     sizeof(struct bpf_flow_keys),
 			     "returned flow keys");
 	}
-	/* Do the same tests but for skb-less flow dissector.
-	 * We use a known path in the net/tun driver that calls
-	 * eth_get_headlen and we manually export bpf_flow_keys
-	 * via BPF map in this case.
-	 */
-	tap_fd = create_tap("tap0");
-	if (!ASSERT_OK_FD(tap_fd, "create_tap"))
-		goto out_destroy_skel;
-	err = ifup("tap0");
-	if (!ASSERT_OK(err, "ifup"))
-		goto out_destroy_skel;
-
-	/* Test direct prog attachment */
-	test_skb_less_prog_attach(skel, tap_fd);
-	/* Test indirect prog attachment via link */
-	test_skb_less_link_create(skel, tap_fd);
 
-	close(tap_fd);
 out_destroy_skel:
 	bpf_flow__destroy(skel);
 }
+

-- 
2.47.0


