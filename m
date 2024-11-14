Return-Path: <linux-kselftest+bounces-22053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF039C94BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF24283819
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D01B3948;
	Thu, 14 Nov 2024 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ob4hhLAi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB671B219C;
	Thu, 14 Nov 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621081; cv=none; b=AZJ/HwrdrGY8xCfgnJTw2sm99g2zMdgGNi/0xPWcbIceV7FNz2Icshk1sIY1I7GMmThOWqL1PTfZXu7bubF0Pf/AKYdOPung4gmy6xjRcKZ0IHFdDAo3jzRiOnZUJCcOChc5SL6xPXiK8NClgKsvJEu/7cmMjwBm3OO9RM16i50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621081; c=relaxed/simple;
	bh=Uf2ftwqZFBZPYEiCY1b+3BPW417tY9VvyrnoSyv+7X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4+PmFOerLGUctvXrVv/418XTs394PedzP4z6d0n5bMzYvm8R1uIgM+EOavHlkyt8CjgCBanYsBNz90MINpdX3GWypGLlvm8VEmcAmZ2ATNiaFLfXRTzX/QmOE/dfuSdPSRjNQ3hvlkdYbnKm8mVfwR+aRKTY4aqKgUIrDSGt3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ob4hhLAi; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B38F720004;
	Thu, 14 Nov 2024 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xns7bOtMs42jVf8JSN02b39/wx5MnPpoTREl/EaA90c=;
	b=ob4hhLAixh2K/tZ+HKcMTKc90kXIdDZMHxmP8lGCBfbqv8AqEAIYIYV29MJmlSckI+UuhE
	005wK9XTEoHgKiuy8dYZA6N1ljMqvbai0ZDEqsbByZ9PsAfmHAtORGBaR1fO3r4oo5sexC
	pHVaryVKPZXFE2Ii9/z7n1Ck4sBSUmCA9OhnXMOAAM/Q1IVrDn+pG0E6qRBtTMWwnc+mFj
	/f/Oe+GGXajrLt+OxD9+exHzAZXYKlJYQRRknV4D5i/zT5f36r648QNXKsHWSHJ2BK3hZ1
	FbFI4zNzU34YPhWvdPbKl8CpMyEx7wL0UuSiHAFCYJyqlIfpbjkD6Edm/fTK3A==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:35 +0100
Subject: [PATCH bpf-next v2 04/13] selftests/bpf: re-split main function
 into dedicated tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-4-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
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

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
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


