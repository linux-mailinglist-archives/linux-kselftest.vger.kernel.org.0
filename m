Return-Path: <linux-kselftest+bounces-21936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3B9C717E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258BA1F235EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938072022D9;
	Wed, 13 Nov 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WvncKeB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E628201035;
	Wed, 13 Nov 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506046; cv=none; b=g0VtgdNyi24h/02Sck4cBH648YN3cKR5qop+VhucmokczC6OV6YDk+en9nDHw0RvGUww+qaD7AY0iB1QSwaE621DROMmEdNuYeYlBKj182A0iTkbUVp/5cuQQN+DAtBeo04ni5tHkuzrCYREJnz3urP/SoXyIj3rxWxffMFeNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506046; c=relaxed/simple;
	bh=RVc7soD/PJ8Oa8IRpVC+KbqCyR27bgvJqs9/ZWQ0HXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG95rOciU6t16K/CTM+TVHrfOEa/beIY34KpmwU97GEdwHPPOiD+f4QCmAQ8IMFM74tW5mXCLkOnsT/aezmXmxTU4cNuzPvD7bccxDlhESzRuo10X9dHUdw56EbMhQWFj/J8azhJDuiA9sOoGCjI6J97t7Ck0r1v+SfyPJGjE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WvncKeB6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 960F320009;
	Wed, 13 Nov 2024 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imSdRuTJg7qdXsmbI1hDld3b3dFK/CmGe+t4q6hSFAw=;
	b=WvncKeB6iVqU4t6ZpCk9dLhEIg7w5zlexhKjIa9W+mIi0ac1hL9q3u8qGhOX9Frr1h5ts5
	MdWEcaKTUdTWzvr7HU5GuY6pf/Wgve/6OwJjgosiPZUeclTkB22iU15yT4xl6aBNFTkhnl
	DLCB3mm01JkxsQLKOakmgPzY+X9w2sZKWhL9l2Dh9man2QIZCdu2Jiw0xaPOKvGvhSwQGW
	sFU4Etrx4y4YDi1F7QFXXozlu5rMRoVrdeJt0gwB9DZx5RvfyOVS3BhFqPMrOVJyTlX/ot
	TsLXlc0A/QetrDREcY/u6nvDblDUaUiDXUFKlhzjIxRrGCFy89NCzNCx/PxqFw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:27 +0100
Subject: [PATCH bpf-next 04/10] selftests/bpf: re-split main function into
 dedicated tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-4-27c4df0592dc@bootlin.com>
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

The flow_dissector runs plenty of tests over diffent kind of packets,
grouped into three categories: skb mode, non-skb mode with direct
attach, and non-skb with indirect attach.

Re-split the main function into dedicated tests. Each test now must have
its own setup/teardown, but for the advantage of being able to run them
separately.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 92 ++++++++++++++--------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 6fbe8b6dad561aec02db552caea02517ac1e2109..c5dfff333fe31dd55ac152fe9b107828227c8177 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -549,63 +549,101 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 	}
 }
 
-static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)
+void serial_test_flow_dissector_skb_less_direct_attach(void)
 {
-	int err, prog_fd;
+	int err, prog_fd, tap_fd;
+	struct bpf_flow *skel;
+
+	skel = bpf_flow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
+		return;
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
 }
 
-static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
+void serial_test_flow_dissector_skb_less_indirect_attach(void)
 {
+	int err, net_fd, tap_fd;
+	struct bpf_flow *skel;
 	struct bpf_link *link;
-	int err, net_fd;
+
+	skel = bpf_flow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open/load skeleton"))
+		return;
 
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
+		goto out_clean_ns;
+	err = ifup("tap0");
+	if (!ASSERT_OK(err, "ifup"))
+		goto out_clean_ns;
 
 	link = bpf_program__attach_netns(skel->progs._dissect, net_fd);
 	if (!ASSERT_OK_PTR(link, "attach_netns"))
-		goto out_close;
+		goto out_clean_ns;
 
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
 	err = bpf_link__destroy(link);
 	ASSERT_OK(err, "bpf_link__destroy");
-out_close:
+
+out_clean_ns:
 	close(net_fd);
+out_destroy_skel:
+	bpf_flow__destroy(skel);
 }
 
-void test_flow_dissector(void)
+void serial_test_flow_dissector_skb(void)
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
@@ -635,24 +673,8 @@ void test_flow_dissector(void)
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
 
-	/* Test direct prog attachment */
-	test_skb_less_prog_attach(skel, tap_fd);
-	/* Test indirect prog attachment via link */
-	test_skb_less_link_create(skel, tap_fd);
-
-	close(tap_fd);
 out_destroy_skel:
 	bpf_flow__destroy(skel);
 }
+

-- 
2.47.0


