Return-Path: <linux-kselftest+bounces-25475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1AA23A04
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955BD7A40E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B91C3054;
	Fri, 31 Jan 2025 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PRIWa4Is"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277A1BD519;
	Fri, 31 Jan 2025 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308122; cv=none; b=mNQqSZUP7XGvB5qU/2c0nLbAsLmNlwOlb6XIOIwfLadKyCdYrX29SKa/6pStC54nMWNSgC8P+8uqhKJEqqSvacbv++fx000SZJfHv4Zb9t2foAq2aQEs68aFYfR6ZgvZyeKqwZKjJMrlrSZjGv3VOO5pxeZuYooHIAal/Z/gti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308122; c=relaxed/simple;
	bh=MQt5UhPJSysdDszUY9Vnm4F/R3FmpTtOmDOAtnTx9/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZ/3B17rOy+9GOmrivIbjgmO+dHyJQrqoMTlrCBoQiv85d0E1D9ulnUOKqCRXTgrcM+0ByeqSPq2+8LFPB9qIWqMBL+VygBq4x/nSxpJKtJ9SIitIvL3dfifyXxQigjVTU/nPhYrw97tni2NZsXUDVUqDrzsPdyGgU/Y1vnkN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PRIWa4Is; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B705442D7;
	Fri, 31 Jan 2025 07:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvOlohLp2V9SHIIKgS0nSHKUrL8qx4kqq2Xu7+7uXZg=;
	b=PRIWa4Isiai7l2qnOvL7Y0CXcoLA343wL7Q9D+8kclQMuyWlC2D0HzWrVkNIDOuq2Abj4a
	/Ufg0tD7p1Rn9J8e8fsQbvjqUmSGyvnu/yedxn0dkK1vzMwG3D8RnRdV/cooLdwhoT8VGg
	ywRHsMHsN0YFMWmnt5ijgycK4Tj9nWtOstrfgF7j4JOrHxSX6ou8M5CJlmMD367qah9buD
	aEtw7SFc4prrkkUmrk+vMz41GHvAsv8DdSVt6l4wvawbd9IYvwVFqsfOoTfMadr15GY8sn
	exByGrzEzlzh0OMrJ6JkfC8ARWLTUwry+LAN1+mYlxXDvBLJv5F8JnCZjdtSEg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:49 +0100
Subject: [PATCH bpf-next v4 10/14] selftests/bpf: test_xdp_veth: Add new
 test cases for XDP flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-10-970b33678512@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

The XDP redirection is tested without any flag provided to the
xdp_attach() function.

Add two subtests that check the correct behaviour with
XDP_FLAGS_{DRV/SKB}_MODE flags

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index b869d466ada1d2aa00b72013990e4e34fb0315b4..73a440e44d5287ae6246e074737483f31aa484fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -33,6 +33,7 @@
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_map.skel.h"
 #include "xdp_tx.skel.h"
+#include <uapi/linux/if_link.h>
 
 #define VETH_PAIRS_COUNT	3
 #define VETH_NAME_MAX_LEN	32
@@ -187,26 +188,26 @@ static void cleanup_network(struct veth_configuration *net_config)
 }
 
 #define VETH_REDIRECT_SKEL_NB	3
-void test_xdp_veth_redirect(void)
+static void xdp_veth_redirect(u32 flags)
 {
 	struct prog_configuration ping_config[VETH_PAIRS_COUNT] = {
 		{
 			.local_name = "xdp_redirect_map_0",
 			.remote_name = "xdp_dummy_prog",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		},
 		{
 			.local_name = "xdp_redirect_map_1",
 			.remote_name = "xdp_tx",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		},
 		{
 			.local_name = "xdp_redirect_map_2",
 			.remote_name = "xdp_dummy_prog",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		}
 	};
 	struct veth_configuration net_config[VETH_PAIRS_COUNT];
@@ -271,3 +272,15 @@ void test_xdp_veth_redirect(void)
 
 	cleanup_network(net_config);
 }
+
+void test_xdp_veth_redirect(void)
+{
+	if (test__start_subtest("0"))
+		xdp_veth_redirect(0);
+
+	if (test__start_subtest("DRV_MODE"))
+		xdp_veth_redirect(XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("SKB_MODE"))
+		xdp_veth_redirect(XDP_FLAGS_SKB_MODE);
+}

-- 
2.48.1


