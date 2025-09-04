Return-Path: <linux-kselftest+bounces-40769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E70B4382E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94839188F8F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76803002A2;
	Thu,  4 Sep 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eSMWnAIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BE2FF64F;
	Thu,  4 Sep 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980697; cv=none; b=D6gvWrB4hZjw4aq0yDZ0UilQlm0z5TacHpUGv7ZpndlKiDqFqzWyx3DlEqEf7u3lMRhv9Gu2E3ps9qtJz+xVucghDq1NZrfEE8W0lxBKG567dA1hZ537jkr5INeaFDjF192DM1YILiA6GZiOXBdb3ThY4WC87QChv9pu/Iz3kHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980697; c=relaxed/simple;
	bh=GtZd9JnSaHh2toNHR3dwXP7hqGB2PWdkpEoZSRqgCZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4zGBPZuaeUfAHo648qCm8t0uiKm+NmMuwPhgixDv2Hg0CIf9D2aBRvorf23ASzF1jBJqjInnn0VSvQXGogUplbiGaRZODNri8++1DIVfrlXPo3b1IJKA1rKdRPnZcO5ENSVSKA1Cr8Xuts9vWPYdw/Qm2yduA5LRRV2KKByw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eSMWnAIe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 20C401A0D4B;
	Thu,  4 Sep 2025 10:11:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E447E606C5;
	Thu,  4 Sep 2025 10:11:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50D9F1C22DAC4;
	Thu,  4 Sep 2025 12:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lEegFaKCsAJ9s2sCmHdT4z2VNK+w/L/YxPTGEUxtk4M=;
	b=eSMWnAIej6CHwG+i207zjTtYZ+N60xzgqJnmr14dKiidQX83QA544WlxboK1WrIekckivh
	ZcNbdnqj9Vlh0d8w4GzA8WGHml5fWjap71fT0g/+i+UAhR/3lNkz5Qi4ZvGJjbZwU9aVLo
	BEBB9QyqNRqiV0TC6cijrYscei4i+15Kea0e/E0D5oH1p3H4jsjiYFVDq42K4JwEqa4kVZ
	RtKp2AoFcg2KwSBVNio3gI3KDb8z52sNdCJHEMs0XuvcgQWhA6GAiK9kgfANftiuLXgBtV
	iqX+ZxF5zf0zcORX0PDfrQvMDx2uU4rIWfw+8EK5fFvtcV/Gebmr35DvtHQDpA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:21 +0200
Subject: [PATCH bpf-next v3 06/14] selftests/bpf: test_xsk: Add return
 value to init_iface()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-6-ce382e331485@bootlin.com>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

init_iface() doesn't have any return value while it can fail. In case of
failure it calls exit_on_error() which exits the application
immediately. This prevents the following tests from being run and isn't
compliant with the CI

Add a return value to init_iface() so errors can be handled more
smoothly.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c   | 8 +++++---
 tools/testing/selftests/bpf/test_xsk.h   | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c | 7 +++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 0805917eaa1a33469fef2f1ad0757975f39d3077..f622bf161b03407ada2db30b51c7c2d75abfa941 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -2198,7 +2198,7 @@ static bool hugepages_present(void)
 	return true;
 }
 
-void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
@@ -2208,7 +2208,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
 		ksft_print_msg("Error loading XDP program\n");
-		exit_with_error(err);
+		return err;
 	}
 
 	if (hugepages_present())
@@ -2217,7 +2217,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
 		ksft_print_msg("Error querying XDP capabilities\n");
-		exit_with_error(-err);
+		return err;
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj->multi_buff_supp = true;
@@ -2229,6 +2229,8 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 			ifobj->xdp_zc_max_segs = 0;
 		}
 	}
+
+	return 0;
 }
 
 int testapp_send_receive(struct test_spec *test)
diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index fb546cab39fdfbd22dcb352784a7c5ef383f8ac6..f4e192264b140c21cc861192fd0df991c46afd24 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -137,7 +137,7 @@ struct ifobject {
 };
 struct ifobject *ifobject_create(void);
 void ifobject_delete(struct ifobject *ifobj);
-void init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
+int init_iface(struct ifobject *ifobj, thread_func_t func_ptr);
 
 int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem, void *buffer, u64 size);
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index f4d0071a8f5c5b168d4ac7ac76dc46cb4cdda3cb..20ae62b7014427929e55e10b274757a95897ff1e 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -358,8 +358,11 @@ int main(int argc, char **argv)
 		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
 	}
 
-	init_iface(ifobj_rx, worker_testapp_validate_rx);
-	init_iface(ifobj_tx, worker_testapp_validate_tx);
+	if (init_iface(ifobj_rx, worker_testapp_validate_rx) ||
+	    init_iface(ifobj_tx, worker_testapp_validate_tx)) {
+		ksft_print_msg("Error : can't initialize interfaces\n");
+		ksft_exit_xfail();
+	}
 
 	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
 	tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);

-- 
2.50.1


