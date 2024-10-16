Return-Path: <linux-kselftest+bounces-19864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B218F9A11BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772CA286913
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F61217301;
	Wed, 16 Oct 2024 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ovk5ZWmH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EC21644E;
	Wed, 16 Oct 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103755; cv=none; b=N5z3SimAD4E4NK3ZR1vwFxtkeH6xSwdeE5w7MsaXL87GwZcUlkfZgZRAmmRVeN1UU03IYVV1Nojb9C65LLlZkhL0sIZxnRSr6DPOWbV2hedpCgEuDpxleAR8oq5rOgknMBwHYGqecgQC2cF8j59smd20SVSy4Sr3mxQMVyD1uE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103755; c=relaxed/simple;
	bh=QZsB5U3o4fWC6OvJATGaE6hO0WbpzVDOgdrYIHKoeHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6O3ci46b0J1uixQ4G/8DjS/T2VjS2zWskKPzirkZPmskThtvNPsUH0ouEA8+4Wxm76+qvyuRGu29Il+wyfkCwENfjbH6t59wmsOBBsGD8VWcoXdTd1Ym3+DBtJuDGgiADVciC1BoRf/ckMODwDrzqai1aN4aqrxGoz84CfGlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ovk5ZWmH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD3B5C0008;
	Wed, 16 Oct 2024 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729103751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWDp6iTH1KhErdDyqNshDxyp3s+xlqWV7mCPKhFp6VU=;
	b=Ovk5ZWmHq8CCWlaVX+1MIp5oXtDp7QHx7TbQp9HVGsbVLO862l//G2DSFmYksVJz0YV9oe
	D/nhyOBPUt/kyLZRc9ZcJ9hst8TBe+3jQ7in+8yKCUkKao9MLEtkI6wvSrYx96oBnxZHXO
	hck9rOI0n/YfRBo9/iqD/O8n13aYQnMGnjUuJWM5lQALbxq3kDNhx260HaHsxJx+Wlj0Y9
	VxM5DmRDFF4hrouCijCxjm6MKI5psgD3KCM38h8xGq9MeIvTgZ/srvk+cXOlfUeqUhXWQq
	vvnFOxRv3gBbvQqN7ENP4Bb6Gq3Gzhvds3IGmlXUbppZlei3JfP/dVx6XF6kSQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 16 Oct 2024 20:35:26 +0200
Subject: [PATCH bpf-next 5/6] selftests/bpf: test MSS value returned with
 bpf_tcp_gen_syncookie
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241016-syncookie-v1-5-3b7a0de12153@bootlin.com>
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
In-Reply-To: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
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
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org, 
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
index e0f8fe818f4230a1d5bf0118133c5a9fb50345e1..64601bafdd23e7fb13ebd496ac914660685f1efc 100644
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
@@ -73,6 +75,7 @@ static void reset_test(struct test_btf_skc_cls_ingress *skel)
 	skel->bss->recv_cookie = 0;
 	skel->bss->gen_cookie = 0;
 	skel->bss->linum = 0;
+	skel->bss->mss = 0;
 }
 
 static void print_err_line(struct test_btf_skc_cls_ingress *skel)
@@ -184,6 +187,10 @@ static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies,
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
index cd528f8792ff2eb14683cbc13e8b0f3fd38329e9..3810ce98d3d54276f9a0130a887f59c79a21288e 100644
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
2.46.2


