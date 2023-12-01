Return-Path: <linux-kselftest+bounces-982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641980145E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 21:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78A5281CAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0F57868;
	Fri,  1 Dec 2023 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EHAr4rCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDBWQLOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25F10FE;
	Fri,  1 Dec 2023 12:24:03 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.nyi.internal (Postfix) with ESMTP id 40599580996;
	Fri,  1 Dec 2023 15:24:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 15:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462243; x=
	1701469443; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=E
	HAr4rCgShLNZZ4O/7TNayEf9oOKO4GXYDh3ZOePutwcEIvReaAQcyQxASQqhSqj/
	BY9Ywbiz59KGIUN7eT88YwhLmIlEvm2SFOhFMSn30mRL00iRu6wrC5BEl/5azSVV
	2RJceiUKGAmWVIYFWg1+przrpLhm3v1f29s1hmyPaTzSAwGyu+L30MLHJnFn+HHF
	ISf3POIQOyA3voHkM4goE+HPtqd5hOIhgmZHXi6VPRpW0gqITajsGnLd2sGNf6LC
	oyWRhEa9STdmUAikinlFOfLho3HZGolrzHBi+Ex0r8YFOL2etle0zz0SNKTHZzOw
	+Arqn2dpk96LvZTdxC69g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462243; x=
	1701469443; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=M
	DBWQLOYFMi8R6XPEcWeb/joAJYbPqAt0dP9wpyRd7fzmvHPa7VPbsoEB/Rjxnggj
	VbrW6/TLi8376FLUEZbOKGEsQNu6X1q2K2WuJDMzZPkdZLOTqcoZRAemRApoaS/z
	4lUBZMSfIOrFDfYT/rN92xb8O8/b0k71H8A6tsTPQfEq8jeoDcWPGX3A72mGioPz
	b9+Qq4sqM6A81UfI12vO+8rKWzGOWcF8AcaJmFre1QhIonGsjwv+TnGpq0iRqSLV
	JBRESn5Zg/+rGvqwbsIkIzH5uNYUdaBxyw46v87jLJEOYiI0wqfeQMK4HAynyvRX
	YJe5AumJq90e0gT8j+z/Q==
X-ME-Sender: <xms:40BqZTGaoJMYtokItYZhuHrcgoxS238baUwjCt5Ku1SlHUPUC_8RKQ>
    <xme:40BqZQXJCxF8KZKdFXsc1XzrELRPdymeshjnep8Kyc93naNB2i56YGokFo21Rlz1d
    tMtX5wy4nrBlI-aeQ>
X-ME-Received: <xmr:40BqZVJtm3bNe-qrkzhbrfTuDFgof0gAgvg9F-rtqdnGYm6dyhSi4-TOwrKnLLwLtvbrryQtaRKWkNZdtXKo7RVXCCNZnMoZPBLwv8FqNlkDqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:40BqZRGk4EyTBikRWi0Va3IIy1iAhIJut3ymeIvtIqnsQdyiQCYpPg>
    <xmx:40BqZZXl_MgNa5eco6wZBgJesU2HQKV1UhGcWjxUBBzubhWlTDK9dA>
    <xmx:40BqZcM6NCYAXuDQnz8tBb8fGFU-0Wci6-vxqYFQ2elXPSnH5wn4ug>
    <xmx:40BqZW0T4tXrj40Oke_ZEiD9hWsia1PEfvmxhh3EFj6lebUF2qXTeQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:24:01 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v3 6/9] bpf: selftests: test_tunnel: Setup fresh topology for each subtest
Date: Fri,  1 Dec 2023 13:23:17 -0700
Message-ID: <0441399633380f6ac1bd34ae6e5bf668fb7b83ce.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
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


