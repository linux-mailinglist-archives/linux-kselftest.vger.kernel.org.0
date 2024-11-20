Return-Path: <linux-kselftest+bounces-22321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A489D3468
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49504285267
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1517DE16;
	Wed, 20 Nov 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FSFys6hK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458215AD9C;
	Wed, 20 Nov 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088615; cv=none; b=T++wFVYVI/Hue8xWZz/sBYpSAlv0CZES0Q7jiRb0C8exbxIv4IEJjHMbeyexjyNyO5587JhE0/mtPnmbvhxVVAL+Rb4RP9UcbXHfLlaLlWmt30nPksyLy624jiRP+Eb7mjGahLkaTOYWafXsvf2cO35HsmsyA5PJ2emGyy0XSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088615; c=relaxed/simple;
	bh=mpWhuBD2KLhi2NHLXvTfC9HjqJDtduFYNQDd+smX8NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMXae3Zzn8bVmSq2sGPt2PnczX4SlH1DPEtU+0940QgriRtt4XVVK3+JbzTDxRzSLcsCmuoJS5RzfSKm6RgXxATcSTqJeA1+3FYIhAJyZdRDXIVY5hl4I5oIBDpfbCJKURf8tYZkuonXoNa0ZoRDnq7KjmkoadoEXalDSbLsoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FSFys6hK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 605F9240006;
	Wed, 20 Nov 2024 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3KTiA//CG35alVBMQfjeSbIrfLWxXEFCA/nyjtjyk0=;
	b=FSFys6hK+qcBEhtMEVdxc7XUdDX4U1lLKXmVGBRoOMPa/3OP/zATmJQB8/4KNAo4vnseWu
	b/LESBRO0TFISOrKkiX39on3rNkMdMrcf79qcGOD1BQRCI7Ah2go9csx7hnAvjR6DR58Dy
	7tA4ZX3Ms+ck2TuoB4lkZQ4lp+DeEmpyODqORD3q7CqgyDDvj2EzY/Vhpq0iseqD4xu+2D
	nuRHJc4uh8p6UvjrFFZbXxMJRl93xXAyjqP/eY+V1f9ZuloE5KPFMv8uZaMhH1TA///eCW
	TVPKPmrPWwWSymQPZ7G6Ppn6bQziTq0XaBaMYSqTMOwYpuU2SN2l95JbxpI4ew==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:13 +0100
Subject: [PATCH bpf-next v3 03/14] selftests/bpf: replace CHECK calls with
 ASSERT macros in flow_dissector test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-3-45b46494f937@bootlin.com>
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

The flow dissector test currently relies on generic CHECK macros to
perform tests. Update those to newer, more-specific ASSERT macros.

This update allows to get rid of the global duration variable, which was
needed by the CHECK macros

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
-none

Changes in v2:
- fetch acked-by tag
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 41 +++++++++++-----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 3ea25ecdf3c92959f56ba0819130b453fd2379f7..6fbe8b6dad561aec02db552caea02517ac1e2109 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -79,7 +79,6 @@ struct test {
 
 #define VLAN_HLEN	4
 
-static __u32 duration;
 struct test tests[] = {
 	{
 		.name = "ipv4",
@@ -511,7 +510,7 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 	int i, err, keys_fd;
 
 	keys_fd = bpf_map__fd(keys);
-	if (CHECK(keys_fd < 0, "bpf_map__fd", "err %d\n", keys_fd))
+	if (!ASSERT_OK_FD(keys_fd, "bpf_map__fd"))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
@@ -530,14 +529,16 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 			continue;
 
 		err = tx_tap(tap_fd, &tests[i].pkt, sizeof(tests[i].pkt));
-		CHECK(err < 0, "tx_tap", "err %d errno %d\n", err, errno);
+		if (!ASSERT_EQ(err, sizeof(tests[i].pkt), "tx_tap"))
+			continue;
 
 		/* check the stored flow_keys only if BPF_OK expected */
 		if (tests[i].retval != BPF_OK)
 			continue;
 
 		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
-		ASSERT_OK(err, "bpf_map_lookup_elem");
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+			continue;
 
 		ASSERT_MEMEQ(&flow_keys, &tests[i].keys,
 			     sizeof(struct bpf_flow_keys),
@@ -553,17 +554,17 @@ static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)
 	int err, prog_fd;
 
 	prog_fd = bpf_program__fd(skel->progs._dissect);
-	if (CHECK(prog_fd < 0, "bpf_program__fd", "err %d\n", prog_fd))
+	if (!ASSERT_OK_FD(prog_fd, "bpf_program__fd"))
 		return;
 
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
-	if (CHECK(err, "bpf_prog_attach", "err %d errno %d\n", err, errno))
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		return;
 
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
 	err = bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
-	CHECK(err, "bpf_prog_detach2", "err %d errno %d\n", err, errno);
+	ASSERT_OK(err, "bpf_prog_detach2");
 }
 
 static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
@@ -572,7 +573,7 @@ static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
 	int err, net_fd;
 
 	net_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (CHECK(net_fd < 0, "open(/proc/self/ns/net)", "err %d\n", errno))
+	if (!ASSERT_OK_FD(net_fd, "open(/proc/self/ns/net"))
 		return;
 
 	link = bpf_program__attach_netns(skel->progs._dissect, net_fd);
@@ -582,7 +583,7 @@ static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
 	err = bpf_link__destroy(link);
-	CHECK(err, "bpf_link__destroy", "err %d\n", err);
+	ASSERT_OK(err, "bpf_link__destroy");
 out_close:
 	close(net_fd);
 }
@@ -593,18 +594,18 @@ void test_flow_dissector(void)
 	struct bpf_flow *skel;
 
 	skel = bpf_flow__open_and_load();
-	if (CHECK(!skel, "skel", "failed to open/load skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
 		return;
 
 	prog_fd = bpf_program__fd(skel->progs._dissect);
-	if (CHECK(prog_fd < 0, "bpf_program__fd", "err %d\n", prog_fd))
-		goto out_destroy_skel;
+	if (!ASSERT_OK_FD(prog_fd, "bpf_program__fd"))
+		return;
 	keys_fd = bpf_map__fd(skel->maps.last_dissection);
-	if (CHECK(keys_fd < 0, "bpf_map__fd", "err %d\n", keys_fd))
-		goto out_destroy_skel;
+	if (!ASSERT_OK_FD(keys_fd, "bpf_map__fd"))
+		return;
 	err = init_prog_array(skel->obj, skel->maps.jmp_table);
-	if (CHECK(err, "init_prog_array", "err %d\n", err))
-		goto out_destroy_skel;
+	if (!ASSERT_OK(err, "init_prog_array"))
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_flow_keys flow_keys;
@@ -634,17 +635,17 @@ void test_flow_dissector(void)
 			     sizeof(struct bpf_flow_keys),
 			     "returned flow keys");
 	}
-
 	/* Do the same tests but for skb-less flow dissector.
 	 * We use a known path in the net/tun driver that calls
 	 * eth_get_headlen and we manually export bpf_flow_keys
 	 * via BPF map in this case.
 	 */
-
 	tap_fd = create_tap("tap0");
-	CHECK(tap_fd < 0, "create_tap", "tap_fd %d errno %d\n", tap_fd, errno);
+	if (!ASSERT_OK_FD(tap_fd, "create_tap"))
+		goto out_destroy_skel;
 	err = ifup("tap0");
-	CHECK(err, "ifup", "err %d errno %d\n", err, errno);
+	if (!ASSERT_OK(err, "ifup"))
+		goto out_destroy_skel;
 
 	/* Test direct prog attachment */
 	test_skb_less_prog_attach(skel, tap_fd);

-- 
2.47.0


