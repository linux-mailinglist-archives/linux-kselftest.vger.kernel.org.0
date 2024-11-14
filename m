Return-Path: <linux-kselftest+bounces-22051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C39C94B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266BE1F23362
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B781B0F38;
	Thu, 14 Nov 2024 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n5/KWV2b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B281AC444;
	Thu, 14 Nov 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621078; cv=none; b=T/GP0n1NOD5MWU8K08C8HhCFuH8ICWtI8nUSrSi+i2Ph62kQaNCQSUGmEcLhNBW0WdRr2fBNZoNpVyJ5X0WQircUwRigYmL9VS/rr4CwtwVlh8wz2HMy+2OHJcOiKfUk/QeWy8Ss7pBqIoTYpDM92UKmiVseGRo5+CC1LG+cz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621078; c=relaxed/simple;
	bh=7LQ3sRe9KPRrDSt0aVts+fljiqnBKcRZiqxa48tBwao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2mDmQl/w6QZH/vyBAEdwVpNSBAjWcZtJvz7c0QkeM/5HjODcCv1yTm+nYc/GFby2YiyFFrF9eBp9c+Zhb83fD3nWOcMFyC5P4smiRZzL1L0xhDnpmz2V3xeGepbFEBZuA011Zd6LMcceTfFeRnCZTexaAin5LkcH8G6ntut9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n5/KWV2b; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D451820002;
	Thu, 14 Nov 2024 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzgpZJtL6AQIpjzJhII2aKq1H2YQh+tDQ/EbQV9eSSM=;
	b=n5/KWV2b7eOyoMr+GCwuxIiqbJZdRt8jhyMJHtxED6McgtO5f9t7GAok16OPQzstB+9cBc
	dO7xPbgbW+DJq79p2jHwVi47y3nC3V4K3sNR6lJnnHiWXg5qHXK2WI5e20y1K3rQlOmxDI
	/d8MKVGshns0KWSktxNBYA1eQhVXd1uHaIaMFMYO7FW99k3ncvBkodnMz7v4MxGUkwJKXx
	d6d82m+NNoR5wAKF3tJ/Ob8p7eei3141Zl7NzIQdyHjwxP+7vlJDLOQ8SXzvTIMRqTg4Tm
	w5VJRAPrMVNRm18wg8fFWzSUnpH1izA4FYNznAZnYxqUZgCsCPW2pNCigkj9Wg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:33 +0100
Subject: [PATCH bpf-next v2 02/13] selftests/bpf: use ASSERT_MEMEQ to
 compare bpf flow keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-2-ee4a3be3de65@bootlin.com>
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

The flow_dissector program currently compares flow keys returned by bpf
program with the expected one thanks to a custom macro using memcmp.

Use the new ASSERT_MEMEQ macro to perform this comparision. This update
also allows to get rid of the unused bpf_test_run_opts variable in
run_tests_skb_less (it was only used by the CHECK macro for its duration
field)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fetch acked-by tag
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


