Return-Path: <linux-kselftest+bounces-21934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2529C72FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E5BB301DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33953200BB3;
	Wed, 13 Nov 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GhXQKfou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE41F471C;
	Wed, 13 Nov 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506042; cv=none; b=svw0ECHCEkNMFDP5Lyu33/+SwOs6Mk2aAiAyVml8rCjOanw1NeDLhq2XcyOHdTiwGzBduXqSnNiJbYXDbH7x1v2cYdcLNKg7vU8uN1Lmh1MG6qS/E64hQF0jOYZ+K+ZJK89YlIb6oHZETBJNF6jHHR4Vy+U3C+8qI0KHTLIbk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506042; c=relaxed/simple;
	bh=+bsF8Q19WiJw2BaFapwKfcNxFAPhv2CK1iSZb1Yrx3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHDI71R+yYDzZy6BzBVb1WugzzcldAoeRvwRBUr8Zb2qVlg+MuwLTlFyzpBHxfSf5kJLMoT7tps2Qi8MoQ+RWnbswysCL91BYiEnhUw8coroLrvZdJLzLLUEqG4gpiZMNqiuRKTNc4o657rlrowzXSV1uA1mk/6ps6d2UXJKxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GhXQKfou; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29AE42000A;
	Wed, 13 Nov 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731506038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6UvJ2/buZKEEaSqggCJiSeFKOFeEd9PaJWJ096vY4=;
	b=GhXQKfouA2O2VKSQuDEC8KeG2QrucR2yoz6xhpwxigKuP1gaUMdz53GGB7KVsdcIW+M32m
	oHf8uJoTefDYLhuvOhlau4W0m7E6kTORCSh0Nqu5+Vd5gMFRYNDorQ7GhNBZFNNv/N3+x3
	H8RngwXkC42r360Eq/USnJEpIGbC8ZbuZ4rlwzAPIpxRYr0TmQeNClk/SvJr5ilAb2WLgu
	ixnnLnhcuUWJMxkZA5U/RoD1ZYjLxs6bQlKD5wyh9nd1X8hh9kkMFsMoMNLPNmRoTn1HL2
	q41zU2Fr9+HkkpZN+klK9/FSRrP13VsTWlwSXdmTc/QS16H4qaVUnNoawYxoXA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 13 Nov 2024 14:53:25 +0100
Subject: [PATCH bpf-next 02/10] selftests/bpf: use ASSERT_MEMEQ to compare
 bpf flow keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-flow_dissector-v1-2-27c4df0592dc@bootlin.com>
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

The flow_dissector program currently compares flow keys returned by bpf
program with the expected one thanks to a custom macro using memcmp.

Use the new ASSERT_MEMEQ macro to perform this comparision. This update
also allows to get rid of the unused bpf_test_run_opts variable in
run_tests_skb_less (it was only used by the CHECK macro for its duration
field)

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c      | 36 ++++------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index cfcc90cb7ffbe0fb6a1c8c3b1357f7b68ebe923f..3ea25ecdf3c92959f56ba0819130b453fd2379f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -13,33 +13,6 @@
 #define IP_MF 0x2000
 #endif
 
-#define CHECK_FLOW_KEYS(desc, got, expected)				\
-	_CHECK(memcmp(&got, &expected, sizeof(got)) != 0,		\
-	      desc,							\
-	      topts.duration,						\
-	      "nhoff=%u/%u "						\
-	      "thoff=%u/%u "						\
-	      "addr_proto=0x%x/0x%x "					\
-	      "is_frag=%u/%u "						\
-	      "is_first_frag=%u/%u "					\
-	      "is_encap=%u/%u "						\
-	      "ip_proto=0x%x/0x%x "					\
-	      "n_proto=0x%x/0x%x "					\
-	      "flow_label=0x%x/0x%x "					\
-	      "sport=%u/%u "						\
-	      "dport=%u/%u\n",						\
-	      got.nhoff, expected.nhoff,				\
-	      got.thoff, expected.thoff,				\
-	      got.addr_proto, expected.addr_proto,			\
-	      got.is_frag, expected.is_frag,				\
-	      got.is_first_frag, expected.is_first_frag,		\
-	      got.is_encap, expected.is_encap,				\
-	      got.ip_proto, expected.ip_proto,				\
-	      got.n_proto, expected.n_proto,				\
-	      got.flow_label, expected.flow_label,			\
-	      got.sport, expected.sport,				\
-	      got.dport, expected.dport)
-
 struct ipv4_pkt {
 	struct ethhdr eth;
 	struct iphdr iph;
@@ -545,7 +518,6 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 		/* Keep in sync with 'flags' from eth_get_headlen. */
 		__u32 eth_get_headlen_flags =
 			BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
-		LIBBPF_OPTS(bpf_test_run_opts, topts);
 		struct bpf_flow_keys flow_keys = {};
 		__u32 key = (__u32)(tests[i].keys.sport) << 16 |
 			    tests[i].keys.dport;
@@ -567,7 +539,9 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
 		ASSERT_OK(err, "bpf_map_lookup_elem");
 
-		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
+		ASSERT_MEMEQ(&flow_keys, &tests[i].keys,
+			     sizeof(struct bpf_flow_keys),
+			     "returned flow keys");
 
 		err = bpf_map_delete_elem(keys_fd, &key);
 		ASSERT_OK(err, "bpf_map_delete_elem");
@@ -656,7 +630,9 @@ void test_flow_dissector(void)
 			continue;
 		ASSERT_EQ(topts.data_size_out, sizeof(flow_keys),
 			  "test_run data_size_out");
-		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
+		ASSERT_MEMEQ(&flow_keys, &tests[i].keys,
+			     sizeof(struct bpf_flow_keys),
+			     "returned flow keys");
 	}
 
 	/* Do the same tests but for skb-less flow dissector.

-- 
2.47.0


