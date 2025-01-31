Return-Path: <linux-kselftest+bounces-25469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FDA239EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC390168790
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5FC1991CD;
	Fri, 31 Jan 2025 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kROhx3sE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C415CD55;
	Fri, 31 Jan 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308114; cv=none; b=Zee4OJkCRQQXLXV1v8xmb+2xd/NsAy5eMXQiySYPtyvKZB4h+ilE5vOM00CvNF0B1S1HRKTNRlItz/24uSFFotRKIJn91C6R5aA8L7TmQIOGZCn68ZTkqsQdL7zqpq/iR7QauVN+pZYd7jgJdlKvUICRCB7nArz9XAtTbomsQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308114; c=relaxed/simple;
	bh=RdQtvUzqHHMaOtcWMnKnBC5LGLV2YkUXHlz/MQtTvkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlJ96LFfZN/NHASMgdmeeiliFkNEOXHKTNDvnmgu45mROfOMH+TNbYl26cLBSVXe+9oXJSV7GPEXB6cdUTaKaflHdR8F+z+L1XJ2Yy+Kl0bulEDSEtlECTTzgLRGMQ5xTWVmJHdcv9m0M8wzeuMgtzIZaeCHg18q2WhYjJBiJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kROhx3sE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF8CD442DB;
	Fri, 31 Jan 2025 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCN3HJoPbdDbb234gSJkcqo6l8+jd+H7xIQyLfsKEk0=;
	b=kROhx3sESiVOci/KAoAJGBhrQ+vNAmHRX7l4gsMF2l3agdOc5Yt+Qxm5Yo5cMquZ659/bA
	gmAIN7nBdjPfCAJaskFU8orO6yv/cWta+QJ8xXbR2Z102Lwd6A4p7hR3xFIUoBjN51BIzH
	Y3GrmCJch3vydiRRtUHHUPN92fMBE37hlFADNt62W81GLoP+3rY80uxN6A5pdp9RwqQ2Bb
	+/TAXmDtpBpJvcBW4wT5UOi5pmpWBkpyD+gcGI8msPcww4a/wt+QxGgU9BhdLb45YOMbLM
	P8WkmDwskHwt8pYGMoowIGjTDeU5BXmqJ8fVvYiPSbvdheG4Jmou1S7A+Ttz5Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:43 +0100
Subject: [PATCH bpf-next v4 04/14] selftests/bpf: test_xdp_veth: Use int to
 describe next veth
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-4-970b33678512@bootlin.com>
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
In-Reply-To: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
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
2.48.1


