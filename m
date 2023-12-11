Return-Path: <linux-kselftest+bounces-1611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A780DB7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93651F21894
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7B54BEE;
	Mon, 11 Dec 2023 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JVqifZby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFtJ6MH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7AC4;
	Mon, 11 Dec 2023 12:20:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id EB9BF58094F;
	Mon, 11 Dec 2023 15:20:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 15:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326042; x=
	1702333242; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=J
	VqifZby8iTVbIJr45A2Wmiev1aJW+TsXEbNf3yd8V+3ICvgJMw5d1B4byygvcxLV
	c1FPo5UbeLe2QSF2Tf/2LXqiH4sOK6LLQ4qKUOes/Cd/q7E5eskcjyYWEtPgOFFp
	zB9dTNw+Q9ZjCTSb0xOSS5iXW4jO2iybfVhM6jQSGryr6VL1LlRHYTfvhF8YxU2b
	FNlbRs+ThKMaX72/snNmnlIRFAYCD8g3vDOkWJbUVZBtwqd7HuVttlIrKXxpqau/
	BzYFweClaeTPHRBLpGqyMOEBWu+Cfy1j3VTGwAJPbLnMNK2yBrLGEDU6McATG5vA
	1nQwOKE2SsrnGVUVzlKWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326042; x=
	1702333242; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=e
	FtJ6MH/HBvNzW5tiPBaMHj5ijZy+tr5MyHVJPpUwTpndNfGQpVK6BaazSWw8Ajfp
	sGU7udWshLOgVHWy3ki3GrhLG+QRVWT5OTzJAj0YmFKSlPyCQPoG6cLRYvO3je6P
	IE02RnR5whrge+p4gReMs71SM/BSZNeefsqWN3eOYb0s8u9iFPzKep2mNg5iPS5I
	6X+yeunyDkvg8FPFFyYZ4YPrK9qIfUqvhmI52Zdlbu/MjGYqAHkssAKGKmDcE0w7
	K7bFCQ6wpaMmP/mYibHP/9dQDVr1jQrpFqGNRms9fRL/tThiWxmZAfw903D+cx5G
	LzRmsysIdIwQiOML+mrMA==
X-ME-Sender: <xms:Gm93ZfeV4qP3XjC3Z-Drbe6MhPeCBpmaWeE3nmFl48eFXiFvBtJRfw>
    <xme:Gm93ZVPg3xNGwLP_9LzkkCsykB7cNFt1qXj8mPboN1S2VVz6S2MOQjDaO8VOMPmQc
    AS-DC7zuWdCKeb7HA>
X-ME-Received: <xmr:Gm93ZYhtwVd1EtYIYGAYMx4Wnrd-SWrF9i7DSvZu6ldGGf01z2TryKKU8nE28G0vh5kYGFkNR0BvQposlFzbO8zujOW5uY0sw-o747eUROY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Gm93ZQ8_B1SEr_LwebdM8WjLcotOdPoPABLErIIOfdF0PpfajHjRgg>
    <xmx:Gm93ZbsX1amN0Bq_n7his-vxOR7wjYiL0qHFj64EJH6dOc08NrXlGQ>
    <xmx:Gm93ZfG4V06TAgeYVjrczPSoPGO7vm7kRHMbH74HoDqX_8eo_aIWcQ>
    <xmx:Gm93ZQU1LyV7zU3Ai8S0xrVHdH0T7ru6z1y1MbtLczy54ZnAw_iDcQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:41 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 6/9] bpf: selftests: test_tunnel: Setup fresh topology for each subtest
Date: Mon, 11 Dec 2023 13:20:10 -0700
Message-ID: <64d0eca46fb43b089262ec96c797f56c10e494a5.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helps with determinism b/c individual setup/teardown prevents
leaking state between different subtests.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index d149ab98798d..b57d48219d0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -535,23 +535,20 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
+			config_device();				\
 			test_ ## name(__VA_ARGS__);			\
+			cleanup();					\
 		}							\
 	})
 
 static void *test_tunnel_run_tests(void *arg)
 {
-	cleanup();
-	config_device();
-
 	RUN_TEST(vxlan_tunnel);
 	RUN_TEST(ip6vxlan_tunnel);
 	RUN_TEST(ipip_tunnel, NONE);
 	RUN_TEST(ipip_tunnel, FOU);
 	RUN_TEST(ipip_tunnel, GUE);
 
-	cleanup();
-
 	return NULL;
 }
 
-- 
2.42.1


