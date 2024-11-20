Return-Path: <linux-kselftest+bounces-22323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434189D347B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE95B23D59
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E03197A8B;
	Wed, 20 Nov 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nv1H53Bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBD176FB6;
	Wed, 20 Nov 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088617; cv=none; b=ldLqCeIHh0Cv+61ZfMKyYYKWMdWOUbl5Wf7e16igidwTDBMSZiK5oN6C8P31xAu2ReyF1wO61t4F5hj1iR5EhrW2MVI48ZlIIiOVQnNjLwXNAMATyO9IvsYhoe1YmoCXI29N4ndwF4EZcmNvsHim6LATcWpFIoZcuyyVDBqg6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088617; c=relaxed/simple;
	bh=L9jHy2Tuqp5Grx/Vl2ubb5NVR+8yUQgD+llwB7SGg+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHFwFHWkrYCRDS9pO7X5lPk1l2s6IUtQ7XkmRm5Kr3wQ6aqRI5EqEpm2D2DgqxddjjfcqxeAZscBF9K+Ksdjs+dCV4zJn+TaD1rwgk69263rptkLCz52hXhftSV8rsT68JXMFPGNxXNo1o3iFB2i6nlPVgZqECKhB4sfWYWG2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nv1H53Bl; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED8CD24000D;
	Wed, 20 Nov 2024 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732088613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TURWEACi3HN+C/DUUSonoQ2s2GImTEEoCy0f3CnD5Y=;
	b=Nv1H53Bl/YhDaM/EsK0B4lb1JEB/oTyAdhNzC0PyVwlA85gfFnIHUE0eFzMgqArT2FrJnI
	ExdgH+Sc+OhuvYN24hD+Pk3ZFCliXgnRNil1SO/xB8Ym9QiHmxN2hAMcd76kHWLcCK5AxG
	of4iUist9uxJarKLY8Nx3rmYsVP/b8c1tVt9bdn1YY9WB6Xwi6vq1nYkcfuzbVgjHQx7Ca
	8ykUWj89eBhf+MNeWVKde7IdLlXFOwIE+D3tvLNN6bZRi7RGBG9VqZAs9LhE2w/4LeMUTY
	tmasQOstgrE3PbT9G3peLRWEoOR8HWdGmsvGe7AShqncZ4l5SK8RvxpeGyrgRw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 20 Nov 2024 08:43:15 +0100
Subject: [PATCH bpf-next v3 05/14] selftests/bpf: expose all subtests from
 flow_dissector
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-flow_dissector-v3-5-45b46494f937@bootlin.com>
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

The flow_dissector test integrated in test_progs actually runs a wide
matrix of tests over different packets types and bpf programs modes, but
exposes only 3 main tests, preventing tests users from running specific
subtests with a specific input only.

Expose all subtests executed by flow_dissector by using
test__start_subtest().

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
-none

Changes in v2:
- fetch Acked-by tag

This change resulsts in the exposure of 42 subtests with the current
content from flow_dissector:
  # ./test_progs -a flow_dissector
  #102/1   flow_dissector/ipv4-skb:OK
  #102/2   flow_dissector/ipv6-skb:OK
  #102/3   flow_dissector/802.1q-ipv4-skb:OK
  #102/4   flow_dissector/802.1ad-ipv6-skb:OK
  #102/5   flow_dissector/ipv4-frag-skb:OK
  #102/6   flow_dissector/ipv4-no-frag-skb:OK
  #102/7   flow_dissector/ipv6-frag-skb:OK
  #102/8   flow_dissector/ipv6-no-frag-skb:OK
  #102/9   flow_dissector/ipv6-flow-label-skb:OK
  #102/10  flow_dissector/ipv6-no-flow-label-skb:OK
  #102/11  flow_dissector/ipv6-empty-flow-label-skb:OK
  #102/12  flow_dissector/ipip-encap-skb:OK
  #102/13  flow_dissector/ipip-no-encap-skb:OK
  #102/14  flow_dissector/ipip-encap-dissector-continue-skb:OK
  #102/15  flow_dissector/ipv4-non-skb-indirect-attach:OK
  #102/16  flow_dissector/ipv6-non-skb-indirect-attach:OK
  #102/17  flow_dissector/802.1q-ipv4-non-skb-indirect-attach:OK
  #102/18  flow_dissector/802.1ad-ipv6-non-skb-indirect-attach:OK
  #102/19  flow_dissector/ipv4-frag-non-skb-indirect-attach:OK
  #102/20  flow_dissector/ipv4-no-frag-non-skb-indirect-attach:OK
  #102/21  flow_dissector/ipv6-frag-non-skb-indirect-attach:OK
  #102/22  flow_dissector/ipv6-no-frag-non-skb-indirect-attach:OK
  #102/23  flow_dissector/ipv6-flow-label-non-skb-indirect-attach:OK
  #102/24  flow_dissector/ipv6-no-flow-label-non-skb-indirect-attach:OK
  #102/25  flow_dissector/ipv6-empty-flow-label-non-skb-indirect-attach:OK
  #102/26  flow_dissector/ipip-encap-non-skb-indirect-attach:OK
  #102/27  flow_dissector/ipip-no-encap-non-skb-indirect-attach:OK
  #102/28  flow_dissector/ipip-encap-dissector-continue-non-skb-indirect-attach:OK
  #102/29  flow_dissector/ipv4-non-skb-direct-attach:OK
  #102/30  flow_dissector/ipv6-non-skb-direct-attach:OK
  #102/31  flow_dissector/802.1q-ipv4-non-skb-direct-attach:OK
  #102/32  flow_dissector/802.1ad-ipv6-non-skb-direct-attach:OK
  #102/33  flow_dissector/ipv4-frag-non-skb-direct-attach:OK
  #102/34  flow_dissector/ipv4-no-frag-non-skb-direct-attach:OK
  #102/35  flow_dissector/ipv6-frag-non-skb-direct-attach:OK
  #102/36  flow_dissector/ipv6-no-frag-non-skb-direct-attach:OK
  #102/37  flow_dissector/ipv6-flow-label-non-skb-direct-attach:OK
  #102/38  flow_dissector/ipv6-no-flow-label-non-skb-direct-attach:OK
  #102/39  flow_dissector/ipv6-empty-flow-label-non-skb-direct-attach:OK
  #102/40  flow_dissector/ipip-encap-non-skb-direct-attach:OK
  #102/41  flow_dissector/ipip-no-encap-non-skb-direct-attach:OK
  #102/42  flow_dissector/ipip-encap-dissector-continue-non-skb-direct-attach:OK
  #102     flow_dissector:OK
  Summary: 1/42 PASSED, 0 SKIPPED, 0 FAILED
---
 .../selftests/bpf/prog_tests/flow_dissector.c        | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 7e7051a85be7410d4c636af8cd58206a76afe49e..29182009cda944e617a26e450902e63c2f7787ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -8,6 +8,7 @@
 #include "bpf_flow.skel.h"
 
 #define FLOW_CONTINUE_SADDR 0x7f00007f /* 127.0.0.127 */
+#define TEST_NAME_MAX_LEN	64
 
 #ifndef IP_MF
 #define IP_MF 0x2000
@@ -505,8 +506,10 @@ static int init_prog_array(struct bpf_object *obj, struct bpf_map *prog_array)
 	return 0;
 }
 
-static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
+static void run_tests_skb_less(int tap_fd, struct bpf_map *keys,
+			       char *test_suffix)
 {
+	char test_name[TEST_NAME_MAX_LEN];
 	int i, err, keys_fd;
 
 	keys_fd = bpf_map__fd(keys);
@@ -520,6 +523,10 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 		struct bpf_flow_keys flow_keys = {};
 		__u32 key = (__u32)(tests[i].keys.sport) << 16 |
 			    tests[i].keys.dport;
+		snprintf(test_name, TEST_NAME_MAX_LEN, "%s-%s", tests[i].name,
+			 test_suffix);
+		if (!test__start_subtest(test_name))
+			continue;
 
 		/* For skb-less case we can't pass input flags; run
 		 * only the tests that have a matching set of flags.
@@ -582,7 +589,8 @@ void test_flow_dissector_skb_less_direct_attach(void)
 	if (!ASSERT_OK(err, "ifup"))
 		goto out_close_tap;
 
-	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
+	run_tests_skb_less(tap_fd, skel->maps.last_dissection,
+			   "non-skb-direct-attach");
 
 	err = bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
 	ASSERT_OK(err, "bpf_prog_detach2");
@@ -629,7 +637,8 @@ void test_flow_dissector_skb_less_indirect_attach(void)
 	if (!ASSERT_OK_PTR(link, "attach_netns"))
 		goto out_close_tap;
 
-	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
+	run_tests_skb_less(tap_fd, skel->maps.last_dissection,
+			   "non-skb-indirect-attach");
 
 	err = bpf_link__destroy(link);
 	ASSERT_OK(err, "bpf_link__destroy");
@@ -646,6 +655,7 @@ void test_flow_dissector_skb_less_indirect_attach(void)
 
 void test_flow_dissector_skb(void)
 {
+	char test_name[TEST_NAME_MAX_LEN];
 	struct bpf_flow *skel;
 	int i, err, prog_fd;
 
@@ -670,6 +680,10 @@ void test_flow_dissector_skb(void)
 		);
 		static struct bpf_flow_keys ctx = {};
 
+		snprintf(test_name, TEST_NAME_MAX_LEN, "%s-skb", tests[i].name);
+		if (!test__start_subtest(test_name))
+			continue;
+
 		if (tests[i].flags) {
 			topts.ctx_in = &ctx;
 			topts.ctx_size_in = sizeof(ctx);

-- 
2.47.0


