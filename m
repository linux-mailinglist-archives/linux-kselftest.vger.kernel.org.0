Return-Path: <linux-kselftest+bounces-1968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F28813D87
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E941F2268A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6E6FCE2;
	Thu, 14 Dec 2023 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Uj5gJdC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cr2GauC9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372106E2BD;
	Thu, 14 Dec 2023 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id 1811F2B006D1;
	Thu, 14 Dec 2023 17:49:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 17:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594165; x=
	1702601365; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=U
	j5gJdC9rCeY1LKWg6b9hicDpA/zmiBIzY71FqFFLvQlx6DOD+MKVBYeZvovOE1Zx
	J5rOMvn/7nCxjNc5pKpLrm7GL8Cjholif/D8jga6365oDBKjNfkvejqyp1MO+1Uf
	Uny+iLMQRxTmF4/C/8tm9U/mztuo36uIAMTmfBvoC5MJPWFi9hGyROq/bjrbO/It
	8LhSP2Iz9lqk7R8uMTFqpxL+agepeVG6iN9Kh5mV1+aA/Pecz9YjZRE/b1OGKP6v
	i1WUH9gVAOL4uUIl0+3zEoFHAqR1LM/PL6B5Mx6hzPolMIPZ2l2PQ2KWxpYoH+bK
	s/WgC98ETOfrXVxMnomPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594165; x=
	1702601365; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=C
	r2GauC9xapi01LdsOwfk+mFgIrMjpN1xmCrGBaW0Ls0Lq65IiSGwZQ3H75JnEzS0
	O4iiwCPm3sYg21c4NZQC40avpOPGgg2Tj+o2VCvoJ8q3LCv+2TtzRzeurRvjj+gA
	jd2ezA/WR5yG2mlGuSx56j9Wl+RuKp48rMWSFde5clxPuy9yXDye0Yfn2WX8vhOP
	4cHRd/o9QZjRocYz+juumEyQRhVyC3evD3+d83TjJA7LF7HjTemyqJyxgcJiX+g0
	VTuH47E35VclRebmqf5vpYzaLsCw3NxihBR0VluCG4hvEAJ/tKO6TkLPsRW0fsn9
	q2H568ofdnrvojv9xpzrg==
X-ME-Sender: <xms:dYZ7ZdmI6R4A476T8F9Pvdcfxufqhd7-TY8g1YvlU77UHdfy4e5Fqw>
    <xme:dYZ7ZY1WZJjBG2XB4hHYvLJhInvRiPN5BSBF2LDU2d97UIErTmsSqwKCP5THWO3_z
    ASZbJguZ_cTFyUCew>
X-ME-Received: <xmr:dYZ7ZTrg1w87lwm6oPtW6YAG8ZB2XdzHmuqGvRhE1mjddCyiR2vGJZ8qaUVnX3HhlR76oM0Xcj9gnHuWGO-LJ3_t-MsIcXtBgvxTrpXB6ahheg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:dYZ7ZdkAuvjZX6A4bwzB4FOJ-3LyFpMhIM_zVACVn65RVkUGtfWLig>
    <xmx:dYZ7Zb0WRTaZExPXP5UfZa-JBQVGhquQXnRer7eVxKy3_n8plnBruA>
    <xmx:dYZ7ZcsY-4q_hY6eb_sIK56UokEL8UNeHkt6yvEw0zOAfI0FI5BhgA>
    <xmx:dYZ7ZS-rTyNfEcybqQULqIoWrOhhohZE1zWByzo6AzyQIlj2nAejzxI4InQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:49:23 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	shuah@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
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
Subject: [PATCH bpf-next v6 2/5] bpf: selftests: test_tunnel: Setup fresh topology for each subtest
Date: Thu, 14 Dec 2023 15:49:03 -0700
Message-ID: <0fb59fa16fb58cca7def5239df606005a3e8dd0e.1702593901.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702593901.git.dxu@dxuuu.xyz>
References: <cover.1702593901.git.dxu@dxuuu.xyz>
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


