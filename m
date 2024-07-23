Return-Path: <linux-kselftest+bounces-14108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5793A930
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F93EB231DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8F1148FE8;
	Tue, 23 Jul 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAmq3tY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A0148827;
	Tue, 23 Jul 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773382; cv=none; b=mdVE2FhWgh2FwlqUb8zy24IZW3RuI/XtY5/TIqcIiP0b4GgYFIerxqJKNpBtHm6X2U+NpSxz0KeP0cpxMuBVVCtJT4wfese9oRVPNfO44Hk/ovoBxkWeY8ZGuD7xhWAe+ummG+LYcy4OUGSkAGS2sY0K9WIbibhl4GLhbCMoXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773382; c=relaxed/simple;
	bh=bv3iZilP69LsdBfqj6UWFYuqdyB7jfED8iPUSdIaI7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCwm5HS/HO3b5R5uB1dEQRAhJHyUdB/aRe30j8ElDDuaVVrRxCqOIHqw/JUQo7NE4EUuyZc8jrmHpK67DoV13nx6yk9RVMN8njCPp/YmB5sHSLdzteZ+aY1nbVJI/kwZpIVLIzscsI1oAz7aetyF3tIHlaO+6jkvYVfORkQLVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAmq3tY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC396C4AF09;
	Tue, 23 Jul 2024 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773382;
	bh=bv3iZilP69LsdBfqj6UWFYuqdyB7jfED8iPUSdIaI7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAmq3tY1hzIeEAN6SHNybfemqmOBqutimROjEDHazhhcog2AfwWqdM9okvFmWK6uS
	 DZSnRL3IsUL2WoVamHUHfoGw/eROOye0CelGgXz+u4E6HZzi7XDwZt6CePhVglrVUP
	 p391zQQ3abuKOvFQGfhwgGTwBf3/soM9xqqrCPPJ3ubV2nID1pxPDUOif3pMzZ1mif
	 zagkonys8AskaIsUHmr24AMSGNDKZVihHnb8rTJLtIo1taoHb+pjdT/AqtlEHY/CVk
	 pXObTZqnj+Y9MXXbVb2+JqzJWJ+3sO4Edjh8obDYmGYn0qCKlcyb3APTe0hZr7ztVo
	 HchSUnYnGtS1A==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 06/15] selftests/bpf: Use send_to_addr_str in xdp_bonding
Date: Wed, 24 Jul 2024 06:22:12 +0800
Message-ID: <f342938d6a2615126e21c4486cf7207b8bd5133c.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first user of send_to_addr_str() is send_udp_packets() in xdp_bonding.
Use sprintf() to generate "addr_str" string from ifindex, sll_halen and
sll_addr, and pass it to send_to_addr_str(). Since IPPROTO_ICMP is used,
set it as opts.proto and pass opts to the helper too.

Use ASSERT_OK_FD() to check the return fd of send_to_addr_str().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 6d8b54124cb3..5c60268b805c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -206,6 +206,9 @@ static void bonding_cleanup(struct skeletons *skeletons)
 
 static int send_udp_packets(int vary_dst_ip)
 {
+	struct network_helper_opts opts = {
+		.proto = IPPROTO_RAW,
+	};
 	struct ethhdr eh = {
 		.h_source = BOND1_MAC,
 		.h_dest = BOND2_MAC,
@@ -213,17 +216,15 @@ static int send_udp_packets(int vary_dst_ip)
 	};
 	struct iphdr iph = {};
 	struct udphdr uh = {};
+	char addr_str[32];
 	uint8_t buf[128];
 	int i, s = -1;
 	int ifindex;
 
-	s = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
-	if (!ASSERT_GE(s, 0, "socket"))
-		goto err;
-
 	ifindex = if_nametoindex("bond1");
 	if (!ASSERT_GT(ifindex, 0, "get bond1 ifindex"))
 		goto err;
+	sprintf(addr_str, "%d %c %s", ifindex, ETH_ALEN, BOND2_MAC_STR);
 
 	iph.ihl = 5;
 	iph.version = 4;
@@ -237,13 +238,6 @@ static int send_udp_packets(int vary_dst_ip)
 	iph.check = 0;
 
 	for (i = 1; i <= NPACKETS; i++) {
-		int n;
-		struct sockaddr_ll saddr_ll = {
-			.sll_ifindex = ifindex,
-			.sll_halen = ETH_ALEN,
-			.sll_addr = BOND2_MAC,
-		};
-
 		/* vary the UDP destination port for even distribution with roundrobin/xor modes */
 		uh.dest++;
 
@@ -255,8 +249,8 @@ static int send_udp_packets(int vary_dst_ip)
 		memcpy(buf + sizeof(eh), &iph, sizeof(iph));
 		memcpy(buf + sizeof(eh) + sizeof(iph), &uh, sizeof(uh));
 
-		n = sendto(s, buf, sizeof(buf), 0, (struct sockaddr *)&saddr_ll, sizeof(saddr_ll));
-		if (!ASSERT_EQ(n, sizeof(buf), "sendto"))
+		s = send_to_addr_str(AF_PACKET, SOCK_RAW, addr_str, 0, buf, sizeof(buf), 0, &opts);
+		if (!ASSERT_OK_FD(s, "send_to_addr_str"))
 			goto err;
 	}
 
-- 
2.43.0


