Return-Path: <linux-kselftest+bounces-24865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53710A17E5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C07188CD17
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F731F473E;
	Tue, 21 Jan 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnJryEm1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047C1F3FD6;
	Tue, 21 Jan 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464497; cv=none; b=A0Y4O6MQArTTVJ2E18Lyl2SP+g5fIvDv2vrrJyn3xz2TsgXf1G+GQWzUl3DUMfJ9e3uMzWHfVc16AV9619I0mRDR47/tW7PLmEXIFvhYO3aYxOriQ00NVWBCn3AbKpXpfFc4KBKKCBfaHqcf/NDLkhKprv58haIXpup76ZvxFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464497; c=relaxed/simple;
	bh=lPF21v0QCf4TQJl06JOjzYaiGuIDd/wbm8HXl/8BZTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaozkUg6VG/unEVRyW6iopy23Is3+cnEURUUUweujzTVRh7rqa2DC8qAJOtZvdNobuqZzJMa56Ghiqd2b+irocnp8FGNLhkEYmR19Xv/7O5q8C1JtsccbttJ0RIp61pJkXhZRTfj4OrFqaRAfcfVjApeZvGy5fx0z77cnHid2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnJryEm1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C4291BF209;
	Tue, 21 Jan 2025 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBT+mxeaQwIc5Sp34PwBOPaxZFkUBRct8wsZOppLvVI=;
	b=GnJryEm1swSzhCeF2lZE/Nint/jNaOEF08H6cafsE54pS/vEy5BU6u1qNoWBhuoKoFbs1w
	EAfap+4w7FmznxUyHXKjQm9cDVTHaS84m88sfoZ0RDOfM+1AWPS6uRNeNsG+u6l3BEJMIQ
	an0gtRCANth5m9/xz/YanCJDD8KrTwVen1wxZyZ+5ctuNpeeXyd3HTnIAtW4d22c4WW4IJ
	GexB6A2Y6ZC595YSRbhTHBNRqMgBOb4D6v7P5xDqIFkeCMQ4UQrR4wK01EC60L9bStb5Gy
	RA1UaoI1fHXHwrSnd/BMmbxEmkpC/fVrP1OFAvQ7j47Rlgfn3JCS3QOSWldGLA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 14:01:28 +0100
Subject: [PATCH bpf-next v2 06/10] selftests/bpf: test_xdp_veth: Add new
 test cases for XDP flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v2-6-fc9cacabc6b2@bootlin.com>
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
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

The XDP redirection is tested without any flag provided to the
xdp_attach() function.

Add two subtests that check the correct behaviour with
XDP_FLAGS_{DRV/SKB}_MODE flags

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 0aa1583b741b15f573bbb979b2047a0109070544..62a315d01e51739a7f13dddda3d5a569eab24ceb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -33,6 +33,7 @@
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_map.skel.h"
 #include "xdp_tx.skel.h"
+#include <uapi/linux/if_link.h>
 
 #define VETH_PAIRS_COUNT	3
 #define NS_SUFFIX_LEN		6
@@ -185,26 +186,26 @@ static int check_ping(void)
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
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
@@ -262,3 +263,15 @@ void test_xdp_veth_redirect(void)
 
 	cleanup_network();
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
2.47.1


