Return-Path: <linux-kselftest+bounces-25283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0088A207E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28F216454A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A961A2567;
	Tue, 28 Jan 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aaW9OuD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105C19D8AC;
	Tue, 28 Jan 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058266; cv=none; b=gzEWtCEwcWOU/qra8W+kev6aGkD89Ml3msLxSvDDUQC6OH2nWtL09VdeccZrGJoM2Kzu8qS1R/+yEY3v3r3eJiPZ61Ik4SzJjILB44erLw0yl59F1rPilYb6EiLik4fbp8IZ3/bXliQfWkv763LYDwv54Xk6ihVUnH/pHxX61KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058266; c=relaxed/simple;
	bh=wq3u5u1r+qGA2NcGRruKTo+blKU149iNm0Xcpd8tCBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u45xogf9Zq7y7C156PRHSzMEH5L4dxiKDKzIukd7/XTlfy1xXl7HIsuounVV2aokMBAXPrxCrjpA2G5PogDKSmjy1zkJZJhz8motlbxsDeqyd7o5owop0KzVsteaXj8PtDJA2gXCIXanXz60SnbTEXCBVP2pSJKwaFBRFXWhf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aaW9OuD1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C47CA1C0011;
	Tue, 28 Jan 2025 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uou6lwSbSVHbeo2jIsQLbizMIB/EoU9fj/33YUz621w=;
	b=aaW9OuD1o/esj36Ds/Od4Rf6Gcc6+Lwyv8PsjNYxBnIqkj2sh2Cg3uFXQEJLbF9GYcOSyA
	F7T7WbqqBARRl2ohsiM5MGadaq7TI2qyiqAxri1WmJamKlP8GIZeCm6xBHEHbGDKiGB9RD
	9jqODROCErc1AoUY+96AXaL0xTO+EVX7OP9Tg5qKQplhNrbMDgGMxBfVPKnV2393LNSax5
	oXTwsGSIaVYQltyEo7vZpzYR+xKlDSq0ncOOVdafCqk/l4ktsQGzJPwTM2A5+zu2dvVNt5
	VP8KCvVlnTCLslCRdMpJ5qr5+T07Apr0GXVu/7oDLqzC3+taDWCfEQvzoU60Cg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:27 +0100
Subject: [PATCH bpf-next v3 03/14] selftests/bpf: test_xdp_veth: Remove
 unecessarry check_ping()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-3-c1ce69997c01@bootlin.com>
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
2.47.1


