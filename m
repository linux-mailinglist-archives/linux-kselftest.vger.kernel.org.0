Return-Path: <linux-kselftest+bounces-25290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC7A20801
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B848164717
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FA1D6DB1;
	Tue, 28 Jan 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LASs0mm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060E1C07EE;
	Tue, 28 Jan 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058275; cv=none; b=Je31zqcLhLX0wrAvuqes0Yq1h6i2yBX9CX0MVItm6izyU1O10TM7KdpulMe/WgYTvX3MtPK7QfodcKI7v+6066fOj53Uo5tNyUEbMZqo+YNXxvlMMmE7mPfHud+4ksXUR6va2OuE7ISHuCZNUeEGrap9mqeT+kC89Uyk+WL0S2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058275; c=relaxed/simple;
	bh=86U/l1m/CouGUgONRqTQKqaHDfBrQNzYflhq8g+Syu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1husWfyi7F8Tq9DlLxLtcfquY8ej4ISD3GTRjtneu8YvynawssvlihJ4t+pDjHz/DSJCBaofQB1H5youeWNsYOajiBeyPuE0Y+NsQGMS6BbPHHMde5PF8rLCbNEa8f2mnPfafxGAJcv1gCb1mmAIBXU1LOutxBFNYrxn5UBTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LASs0mm8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F1531C000A;
	Tue, 28 Jan 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wsnm9/BvzLaGGIY+0ejMQA1DWG1ZTCiTCBbzbyqwQ6U=;
	b=LASs0mm8o3S5c+SseSO1OrQRVIq+tfvTVMEIhNxO/LgANnm6u1kYXDUsjpcrivp/PqHBcX
	YsdTOEHBSkZedYgbGDk3MxqMQCFbGsjOvMFK+BHb+eJsQGmEn7YurhdEE6WZz1DVa5E4qa
	6xtSDljhdNqg2ZNwmNjxWl1ch2tQfpi5nu+h7vOUK+JJ3XEExjIlfYSpkZbTM6MF4umewM
	k7Wl9x0mVk28IN6p6vKVwpYpVvS7HGxpkfd6xl9Sh9OjTcVD1y3N1F5rK9t4ZcbJctj6nN
	VS+/wUdmazmMzKO/+Mfw14UyAgVvqaXX89gdCjYe5PvN6+zNW/Sf1IWyUAJgcA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:34 +0100
Subject: [PATCH bpf-next v3 10/14] selftests/bpf: test_xdp_veth: Add new
 test cases for XDP flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-10-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index b609cff198e44f71815e4b13a4b7c907223403d6..64f72068a0100e05bfd327f8291cfc454bc6f518 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -33,6 +33,7 @@
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_map.skel.h"
 #include "xdp_tx.skel.h"
+#include <uapi/linux/if_link.h>
 
 #define VETH_PAIRS_COUNT	3
 #define VETH_NAME_MAX_LEN	32
@@ -188,26 +189,26 @@ static void cleanup_network(struct veth_configuration *net_config)
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
@@ -272,3 +273,15 @@ void test_xdp_veth_redirect(void)
 
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
2.47.1


