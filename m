Return-Path: <linux-kselftest+bounces-25473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54374A23A03
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A1D3A9695
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDB1BD9DC;
	Fri, 31 Jan 2025 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNRi4/9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2D1B424F;
	Fri, 31 Jan 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308119; cv=none; b=JMPBjC1zgG9ona0Uzo/7Bg/998p6yy5r1exooHL71/E18Dv7og5Wr738v55kwrBJF6OPuRUaP35Pm1s15OkZR9IZ9Sae6xo0/hZNdDbez2iaNP4vbx4hIX+nnDeTa+v80tOA3Zqv/sba6bWmc9UlW0E4mwo4duuZvyzl2Kja6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308119; c=relaxed/simple;
	bh=WvxTSp8qE2WpMaASTewr8FQimnUxlrp3KaUlBr3THQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0u6c1ba7oCicZm5Yfcr0vy77ERi5HVrq7K8Da/AZrcNDdiEhr9QM1UmXBLON1E9phK5WoUF5VZH0PLdJTfYTDx0vBWDRnnlnGCei25/gY85BHbDNj6nGUtQsyTZRa5FGSRqW5uJA76zkm/GOXTHMIXWnZOQg4WFSOr07g2N3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNRi4/9m; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98DC4442DC;
	Fri, 31 Jan 2025 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86graOTbHjO/WnW3+1xWI3riak8e0aRNV2FNmzyAQVQ=;
	b=iNRi4/9mguXZTT2+SUWxMZHOmN7hqAI/KjFovqWmyMZKfnqad/gpmkrhLH4uv711UShYn4
	SEOuoCm5ZFktvJh6BC7dy5sIleCo86Opw9EnZdQZoSezWNICf/tEU4XDD/bi2yMs04U5jm
	pCVKGiZW4vTLpLo8qE1T9lG3ULjf2WrnnQ7Amji5H9D8ttzBxDYSwCw+IHvMmBiZRWwT/G
	KXC8mGkkHGxh9o7Z5RCWOIQgPETAbKDXuZzBFzk1/DxuBWQn165XR/r+O14Yh38w6jMhLQ
	wWsVPsgSbdBOaeaqLMfHugBddSG33NXse4wZLb/Q2wiT0ukAEpeAhjJn71ibsQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:47 +0100
Subject: [PATCH bpf-next v4 08/14] selftests/bpf: test_xdp_veth: Add XDP
 flags to prog_configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-8-970b33678512@bootlin.com>
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

XDP flags are hardcoded to 0 at attachment.

Add flags attributes to the struct prog_configuration to allow flag
modifications for each test case.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index d1435490b96701a33236adc10dd1b120b95fda58..59fa742b16bd46853b8cfd0ea56a497351c7fb2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -75,6 +75,8 @@ static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
 struct prog_configuration {
 	char local_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to local_veth */
 	char remote_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to remote_veth */
+	u32 local_flags; /* XDP flags to use on local_veth */
+	u32 remote_flags; /* XDP flags to use on remote_veth */
 };
 
 static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
@@ -104,7 +106,8 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
 		return -1;
 
-	ret = bpf_xdp_attach(interface, bpf_program__fd(local_prog), 0, NULL);
+	ret = bpf_xdp_attach(interface, bpf_program__fd(local_prog),
+			     prog[index].local_flags, NULL);
 	if (!ASSERT_OK(ret, "attach xdp program to local veth"))
 		return -1;
 
@@ -118,7 +121,8 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 		return -1;
 	}
 
-	ret = bpf_xdp_attach(interface, bpf_program__fd(remote_prog), 0, NULL);
+	ret = bpf_xdp_attach(interface, bpf_program__fd(remote_prog),
+			     prog[index].remote_flags, NULL);
 	if (!ASSERT_OK(ret, "attach xdp program to remote veth")) {
 		close_netns(nstoken);
 		return -1;
@@ -176,14 +180,20 @@ void test_xdp_veth_redirect(void)
 		{
 			.local_name = "xdp_redirect_map_0",
 			.remote_name = "xdp_dummy_prog",
+			.local_flags = 0,
+			.remote_flags = 0,
 		},
 		{
 			.local_name = "xdp_redirect_map_1",
 			.remote_name = "xdp_tx",
+			.local_flags = 0,
+			.remote_flags = 0,
 		},
 		{
 			.local_name = "xdp_redirect_map_2",
 			.remote_name = "xdp_dummy_prog",
+			.local_flags = 0,
+			.remote_flags = 0,
 		}
 	};
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];

-- 
2.48.1


