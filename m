Return-Path: <linux-kselftest+bounces-25468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC877A239E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66854188A21C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC050185B62;
	Fri, 31 Jan 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VA5Le65B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175E14885B;
	Fri, 31 Jan 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308113; cv=none; b=X2VF46TxzBRhmELBDsokL1byKvsyREYRnc6lNchrTXmza7Uf6Sy5TIxKUKVQZP/RBcZNvi/ZBJDC1jnGINJzJJJZ5A4pm5z0qxqp30bup+LSrT9LKE40raVmWXKviTbLhzz3dPcNr2QLrxoSaak2BTRTUALQvMGINJRtF+y0Fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308113; c=relaxed/simple;
	bh=sJaVvP4kbVU6P1X68AZE4lWf06TAqmFfdc3WzLArlJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXtBag9Y760iEvFudfv2u5jy5G3Z9CeSJdFDkbPVbChJqDXIgyyuQFwQeMnaYUiPsQnHGvLTbCVTUrmNLv9p5lN+eXdghXlczd5TtxZhbSCHz74wRMau5taEfuZ7HxxZbe5zpW45y+o+5GTRirflOmXlDE+GvFcjh4nyIfD1dDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VA5Le65B; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 978AA442D8;
	Fri, 31 Jan 2025 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1NChi98yEbxnmhAgRu04Opd5iFjxjgjjjp1xFyFDNI=;
	b=VA5Le65B1l7ds/GoIG1scRHvuSwUj+p+4IY0gKmtat1adaPSczgo4uUpaesjw7FY1CpZFP
	2I3SejNIjYc2pKYtyshHutx6eFuQGYU5i1kghx0F22bcHiVrHnnW1Io9EzMh/8DQYEOhV8
	kaRAdjCcuwnnZQ1BcJZP/FcfGx1EmhaV7BKDJJfEpyX7hVJ+FvfU7y9NiZBbSOkTUp/ZSw
	4X7sU9cFPfmtkZBhvOhK5naPnlJ9MpHPpFE20+lwR96GWJDZlMQKi4GTBtwLY4hYbEBb3L
	ZLF8mZcAJ4HHe73wp6qJu8hNAhdGKQ+tKAw/WNL55z5OsIsdkAKYpHnw5uTCJw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:42 +0100
Subject: [PATCH bpf-next v4 03/14] selftests/bpf: test_xdp_veth: Remove
 unecessarry check_ping()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-3-970b33678512@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

check_ping() directly returns a SYS_NOFAIL without any previous
treatment. It's called only once in the file and hardcodes the used
namespace and ip address.

Replace check_ping() with a direct call of SYS_NOFAIL in the test.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 95e1791ea7e0f950609607b30d35f78da82e058b..d41884fdc430f1ceed53f16b0dddbdbb34f83301 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -170,15 +170,6 @@ static void cleanup_network(void)
 		SYS_NOFAIL("ip netns del %s", config[i].namespace);
 }
 
-static int check_ping(struct skeletons *skeletons)
-{
-	/* Test: if all interfaces are properly configured, we must be able to ping
-	 * veth33 from veth11
-	 */
-	return SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
-					  config[0].namespace, IP_DST);
-}
-
 void test_xdp_veth_redirect(void)
 {
 	struct skeletons skeletons = {};
@@ -198,7 +189,11 @@ void test_xdp_veth_redirect(void)
 	if (configure_network(&skeletons))
 		goto destroy_xdp_redirect_map;
 
-	ASSERT_OK(check_ping(&skeletons), "ping");
+	/* Test: if all interfaces are properly configured, we must be able to ping
+	 * veth33 from veth11
+	 */
+	ASSERT_OK(SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
+			     config[0].namespace, IP_DST), "ping");
 
 destroy_xdp_redirect_map:
 	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);

-- 
2.48.1


