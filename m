Return-Path: <linux-kselftest+bounces-20221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD79A560B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731021C2097D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452F196D90;
	Sun, 20 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X8/heZeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D87193425;
	Sun, 20 Oct 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452197; cv=none; b=LJHiJyyNnonRMP14Ygrw7EAWnHPF+94ADJe36sfYmPhwQf8y2wLNPB1UFrMRaLYQ5Sxot94ou8y2ZTKhXMJkMsodC+UsxNNZaZjRsSYFf/vEwbgbA6F+Y1zoTyeyefYc0FIEIKUusHzjxXsdVI21Z5TCbljjG+k5iAhzSo0LzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452197; c=relaxed/simple;
	bh=Cs1yhRGBKUQkFzsjOTlsbtgZyFNPf+Flz359arN5DLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1stbMTQ9kn1RKEeagJF7sXZlayl7MGRcEU3ISpxSfxwa13ULZF72NV9euaT4b1wJTzcpPiH4EPKIrwmnzHiBbJ1Q0m7nhUGefh440W49mfgjCFSa8SnPS2O+ilJxEe/aIDJEI+Dzpq4g+z+BgQs2Hrw4yn34FpGcUrIrrX3+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X8/heZeJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56AB4240009;
	Sun, 20 Oct 2024 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq+8dgER22ihdwu+MBouUCZkQ4Npy6jQwIBTp1hzB+c=;
	b=X8/heZeJ35yP8ABUVFuqaKr5Q+bKE7YcineHAWV2yMWWU+WELAEGCHZrZfo/HBCoOUNr9X
	EbcTgbsgRbjKqd/FqRxjotv61b8XPBPgiHliImS4UHdgFAvXzj9856QgBJm32nunOs3XCw
	a3THQyxRIMC+D+qww15ND3bzFqLFo2SZC/aDXhifYpUOZuf1mDBd71Rij9wYRQsev+ZpNK
	OmxSPszujpko4GVjcCFgJ+MK29rLp1cnikXWZVGJb/BKCXv1f9HKqkmOCobNi3y3SXRR6t
	RKccqG4dW3oaa6yxtzxrKJAFq3DHbK+HGrlcWzaPpralcKoTaZ1DUEUoAfq2fA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:57 +0200
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: test MSS value returned
 with bpf_tcp_gen_syncookie
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-5-2db240225fed@bootlin.com>
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

One remaining difference between test_tcp_check_syncookie.sh and
btf_skc_cls_ingress is a small test on the mss value embedded in the
cookie generated with the eBPF helper.

Bring the corresponding test in btf_skc_cls_ingress.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 7 +++++++
 tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 29b946d84816e41e87f11d2400f5c9a68f91a126..cf15cc3be49105db2a47d5c8686db7236ce9dd09 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -27,6 +27,8 @@
 #define SERVER_ADDR_IPV4	"127.0.0.1"
 #define SERVER_ADDR_IPV6	"::1"
 #define SERVER_ADDR_DUAL	"::0"
+/* RFC791, 576 for minimal IPv4 datagram, minus 40 bytes of TCP header */
+#define MIN_IPV4_MSS		536
 
 static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
 {
@@ -71,6 +73,7 @@ static void reset_test(struct test_btf_skc_cls_ingress *skel)
 	skel->bss->recv_cookie = 0;
 	skel->bss->gen_cookie = 0;
 	skel->bss->linum = 0;
+	skel->bss->mss = 0;
 }
 
 static void print_err_line(struct test_btf_skc_cls_ingress *skel)
@@ -183,6 +186,10 @@ static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies,
 			   "syncookie properly generated");
 		ASSERT_EQ(skel->bss->gen_cookie, skel->bss->recv_cookie,
 			  "matching syncookies on client and server");
+		ASSERT_GT(skel->bss->mss, MIN_IPV4_MSS,
+			  "MSS in cookie min value");
+		ASSERT_LT(skel->bss->mss, USHRT_MAX,
+			  "MSS in cookie max value");
 	}
 
 done:
diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
index b38ca3c35994ba8e36d5108fa5f2f4053384368a..1cd1a1b72cb5e8f515302d452ca17727d8e2f58a 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
@@ -15,6 +15,7 @@ __u16 listen_tp_sport = 0;
 __u16 req_sk_sport = 0;
 __u32 recv_cookie = 0;
 __u32 gen_cookie = 0;
+__u32 mss = 0;
 __u32 linum = 0;
 
 #define LOG() ({ if (!linum) linum = __LINE__; })
@@ -46,6 +47,7 @@ static void test_syncookie_helper(void *iphdr, int iphdr_size,
 				LOG();
 		} else {
 			gen_cookie = (__u32)mss_cookie;
+			mss = mss_cookie >> 32;
 		}
 	} else if (gen_cookie) {
 		/* It was in cookie mode */

-- 
2.47.0


