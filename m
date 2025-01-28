Return-Path: <linux-kselftest+bounces-25284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA77A207EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9495C18896A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A319CCF5;
	Tue, 28 Jan 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YiXs8IbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BC19E7D0;
	Tue, 28 Jan 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058267; cv=none; b=J9Oj++fCKvLFfVQBUakLKBlWDRPYroAXCsHXGbo43vueBvGjlDvSVWF+U0ZgeQ/7mkeIbKRvaBNbp/deAispOP8A0+poFpe4AMcVUFmzq9R9uXrlGlsPk7jPG/G0tYbY87d+qbj+moKEju8dUG5fgQoMtkmIPtfMSdEgi2JdHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058267; c=relaxed/simple;
	bh=m04FlneCj/z8D2trL1H3pbdcqpm/qA9j3a89d1NfL/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQAXc5WXLyRneUCIfFDfj1/p6vLJ0OCmNbHBnbHxevukeN4zTSj7yByWc1CgcLuZSMkDrdWq/Coqle+svLeBfjBG0IDOs6cJ9aYh6iqj8k1DIipqJYeiwHZn9MUU0zJgwqkzMcX5+/MLS2Iw5MTwqE0Im5iRwM6C2YPhgsUrt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YiXs8IbK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20F3E1C0014;
	Tue, 28 Jan 2025 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvZ/snCTxuDRhkTJGvywmxe0sC5Rfiti0fKWCDm+Bg=;
	b=YiXs8IbKFPKcFzAlTfKoy1zk8SDu7WNAABsLqbI+CZziO6tOjYp8VtYCQUDoAf5a3pOQ4E
	RAsR9JR4M6WpH2riFckH9BNtR/u2YAzsYFaPTIKZQZOtVmpOI0oBnhphr0BWv10audX9tM
	ma7Pp6bLfRmP7eEskTJBYRz8I2KLOA5oYUggBCNmclLdx1IkrLZuYYSTHrVeva3RfWZAGb
	JGBT9qZwtN+HXamOHCOO8oldeCp+oyVGx3tizIfKQFuY9XUWhKY6mIBG58V5gbcvrkgyRi
	Fso1XF9QvX7kxA4Jc/YSNUgiRKFa7m1yo54cpRKDjtz30eXcbOolpY0BMtpMvg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:28 +0100
Subject: [PATCH bpf-next v3 04/14] selftests/bpf: test_xdp_veth: Use int to
 describe next veth
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-4-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
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
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

In the struct veth_configuration, the next_veth string is used to tell
the next virtual interface to which packets must be redirected to. So it
has to match the local_veth string of an other veth_configuration.

Change next_veth type to int to avoid handling two identical strings.
This integer is used as an offset in the network configuration table.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index d41884fdc430f1ceed53f16b0dddbdbb34f83301..942c6e99e15ef69003c033e7bc1bfc9bc9777557 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -39,7 +39,7 @@ struct veth_configuration {
 	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
 	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
 	const char *namespace; /* Namespace for the remote veth */
-	char next_veth[VETH_NAME_MAX_LEN]; /* Local interface to redirect traffic to */
+	int next_veth; /* Local interface to redirect traffic to */
 	char *remote_addr; /* IP address of the remote veth */
 };
 
@@ -47,21 +47,21 @@ static struct veth_configuration config[VETH_PAIRS_COUNT] = {
 	{
 		.local_veth = "veth1",
 		.remote_veth = "veth11",
-		.next_veth = "veth2",
+		.next_veth = 1,
 		.remote_addr = IP_SRC,
 		.namespace = "ns-veth11"
 	},
 	{
 		.local_veth = "veth2",
 		.remote_veth = "veth22",
-		.next_veth = "veth3",
+		.next_veth = 2,
 		.remote_addr = NULL,
 		.namespace = "ns-veth22"
 	},
 	{
 		.local_veth = "veth3",
 		.remote_veth = "veth33",
-		.next_veth = "veth1",
+		.next_veth = 0,
 		.remote_addr = IP_DST,
 		.namespace = "ns-veth33"
 	}
@@ -144,7 +144,9 @@ static int configure_network(struct skeletons *skeletons)
 	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
 		goto fail;
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		interface_id = if_nametoindex(config[i].next_veth);
+		int next_veth = config[i].next_veth;
+
+		interface_id = if_nametoindex(config[next_veth].local_veth);
 		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
 			goto fail;
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);

-- 
2.47.1


