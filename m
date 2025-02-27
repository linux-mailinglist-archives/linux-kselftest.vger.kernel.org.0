Return-Path: <linux-kselftest+bounces-27740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E08A47F05
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71471888F43
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF223026D;
	Thu, 27 Feb 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ae9uZzAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFE22F38C;
	Thu, 27 Feb 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662671; cv=none; b=gKRRXyLyHsl2fV4IH8crhsek+HIQQiHKnMrUB6/I5o6JM3ah0zASTIvcLR44ysO47pREcSXPk0vfTRZprlqD50uh/vTTr8BaqxnjCl8/zvfcZN6PICkvGACK9d1RdpUYP46CaQYrHuLLCDwxMpUejZhEcdp+2fimSM8b8iq64EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662671; c=relaxed/simple;
	bh=2W9dOZXoRNx12SpUli2mtNwnqrwi/At1QplqzLluR7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0OolKbFD+s8xtSXeUtQ8I7ZuJ09bTy11kIKKvs+qcy+ihxP1u20WTXufdSgdS20Cyt/5333fqkAOnbqA3OeSJlonMPC1Q3oV5Pf3tWiK0sIQe3b9dDE5dWfQsOcda+z8C0ReibUEFmbvKucYOwh0AIT3rHzNGtrQTltaPtQbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ae9uZzAx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7778D4424F;
	Thu, 27 Feb 2025 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSz/xp+n1gsVES6H6jYJKoOnaPDePyKeyb/ARCNFeTY=;
	b=ae9uZzAx5aISzlFUavBOIP3MC3NsCGCnvjxy8kq1yR5QQVKtbaQJy9DzQSZ+wSWNhayx5A
	J+s4DepPew0DtIcpyj/UaHLf73/pyFXbhvnL1bO1dZ+8Shq/uIEDJ6HjGH4zj1lgsptmpk
	yusfI1xxP1/tD3vP/ltRoWBL+FHPBnfcSxs7t1hLSjYzVUzoAh+NJXEzUe2SH4REkToKf/
	bYi4dcaA/DHjCQvrhgFPwnPCoaTUaSCOacsaAYRXsy0MWLiu1ZTyve1t8uk3AYHxzpAYlp
	2cpOIviAhR/eIKmsH6b9xJStd6jAzIEKVxUw3Zm86I4PoYApMYICZaRt8h6/IA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:17 +0100
Subject: [PATCH bpf-next 02/10] selftests/bpf: test_tunnel: Add ping
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-2-33df5c30aa04@bootlin.com>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
In-Reply-To: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhug
 idqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

All tests use more or less the same ping commands as final validation.
Also test_ping()'s return value is checked with ASSERT_OK() while this
check is already done by the SYS() macro inside test_ping().

Create helpers around test_ping() and use them in the tests to avoid code
duplication.
Remove the unnecessary ASSERT_OK() from the tests.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 53 ++++++++++------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 27a8c8caa87e4c6b39b2b26c2aa9860b131a70a9..498822064218d4676a5adf1cdb2a33ab56688746 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -364,6 +364,25 @@ static int test_ping(int family, const char *addr)
 	return -1;
 }
 
+static void ping_dev0(void)
+{
+	/* ping from root namespace test */
+	test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
+}
+
+static void ping_dev1(void)
+{
+	struct nstoken *nstoken;
+
+	/* ping from at_ns0 namespace test */
+	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		return;
+
+	test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
+	close_netns(nstoken);
+}
+
 static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
@@ -496,9 +515,7 @@ static void test_vxlan_tunnel(void)
 		goto done;
 
 	/* ping test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev0();
 
 done:
 	/* delete vxlan tunnel */
@@ -553,9 +570,7 @@ static void test_ip6vxlan_tunnel(void)
 		goto done;
 
 	/* ping test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev0();
 
 done:
 	/* delete ipv6 vxlan tunnel */
@@ -569,7 +584,6 @@ static void test_ip6vxlan_tunnel(void)
 static void test_ipip_tunnel(enum ipip_encap encap)
 {
 	struct test_tunnel_kern *skel = NULL;
-	struct nstoken *nstoken;
 	int set_src_prog_fd, get_src_prog_fd;
 	int err;
 
@@ -606,19 +620,8 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	if (generic_attach(IPIP_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
-	/* ping from root namespace test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
-
-	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
-	if (!ASSERT_OK_PTR(nstoken, "setns"))
-		goto done;
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
-	close_netns(nstoken);
+	ping_dev0();
+	ping_dev1();
 
 done:
 	/* delete ipip tunnel */
@@ -631,7 +634,6 @@ static void test_xfrm_tunnel(void)
 {
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
-	struct nstoken *nstoken;
 	int xdp_prog_fd;
 	int tc_prog_fd;
 	int ifindex;
@@ -662,14 +664,7 @@ static void test_xfrm_tunnel(void)
 	if (!ASSERT_OK(err, "bpf_xdp_attach"))
 		goto done;
 
-	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
-	if (!ASSERT_OK_PTR(nstoken, "setns"))
-		goto done;
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	close_netns(nstoken);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev1();
 
 	if (!ASSERT_EQ(skel->bss->xfrm_reqid, 1, "req_id"))
 		goto done;

-- 
2.48.1


