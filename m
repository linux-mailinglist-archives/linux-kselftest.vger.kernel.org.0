Return-Path: <linux-kselftest+bounces-21935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA719C7446
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBCBB2FAE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15F2010F1;
	Wed, 13 Nov 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fRe8H1uP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D92200B9B;
	Wed, 13 Nov 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506044; cv=none; b=sDne9iXW1PCOWAWu68AR/bUeOBnveO21tCOEkq7LYVVIlwJOP2BFC8chJCIuEVUj/6F7s7Ys29oL+1cjLGY1qTYd3xSaC20h4GLK5mQNHKTLPP7eWqGlRrM9i/Zn8em+0pZsUqktXDrQYHwM4vU1xZYrjumJqE3nuRLSBleVEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506044; c=relaxed/simple;
	bh=rLcJ+cX9BqZlpAF0IQQtjGNkskgY7SYWi0F3oPNPpQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeM8AR+jJ+FlHXIZR6PlldF0APDKELrtjlyTUSZt49CexSDVPPha8GOz1l0ofnGR+W4WkliNii3X/MlMw1bh7LuinNUIxNCPyHU7PP9IPvWdFJViv0tmUt/L6OlbIiNjN4w7uqY+DNF4087ncfeytSlpvnVUhvOh7TNVODXhTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fRe8H1uP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5842020004;
	Wed, 13 Nov 2024 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlO6lRN5YYzw2IRxaDsoW3V1Ba0ygALR3wt5vY+Y/2s=;
	b=fRe8H1uPQ7WXWR/VfGnJHcxo7Pmk6I6PEspwMm9AV3W7Z7Qf56ZPx80ib76OnE1MyyhRsn
	SFGBdcemcd4t6DgIcOwYoyZC6Tv2c9yf/oM9Kpe+FwgA8VCRaZFoc3Z26YxY+lzRru7M+u
	4tgSYzQdKQLVQGm1/tiKG6pMISblLMQVKQCtuC82/jgyXsf1t4qUaDsTi3GKKaz1bSIztF
	8Sn79guo8wxk5kAJthlWpXtCdfPW/XxkGddqNkg6cAzmG5EXuqzLAeQ6d+tEEpOWSgHlQd
	6qIlXfiTvknQOxzw1HoD93M00f5RQpsml58dimjADlN0U9leRal3FhSb1rfk+Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:26 +0100
Subject: [PATCH bpf-next 03/10] selftests/bpf: replace CHECK calls with
 ASSERT macros in flow_dissector test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-3-27c4df0592dc@bootlin.com>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
In-Reply-To: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

The flow dissector test currently relies on generic CHECK macros to
perform tests. Update those to newer, more-specific ASSERT macros.

This update allows to get rid of the global duration variable, which was
needed by the CHECK macros

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
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


