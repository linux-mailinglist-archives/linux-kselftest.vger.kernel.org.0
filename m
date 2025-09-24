Return-Path: <linux-kselftest+bounces-42201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDDB9A5E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6841C1B274CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1553126CE;
	Wed, 24 Sep 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qf0/4ygD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29782311C10
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725427; cv=none; b=o+KOnvR1KSpT8WnAtWVgAoKZkRDWT6nwZhdXvM6HS5RbETanAM9z5xgv2vmkmYPZ8tVvfH9HHEOGD0N0ecHq989zi5Yc9WPyBfdY1pre4jCB3+BiQAl+0wBDDpjprgZDHQMFxnzrBUQLgj+hsYOVLIeGgYAjJdas8ycJL/+Y3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725427; c=relaxed/simple;
	bh=XlK93pgR1V4ENMQ1L1wbdIXNtETXitk355cTtwwbOME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/C6/5+GREdEszaVrqunSyo/0FocM9j53J/u6V/lDivIMAx9tql3CMUyV62XpQSRA0OSkFS5RL5TyWlwaxXz9snxws4MXcOsmzcfDVzKpTItvlZC8AMEDgOn6jjL0dGRCrKDjyMGVOHqNntSwvtD7SUlMxkAssLW9HiTvmJcHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qf0/4ygD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C8A314E40D4B;
	Wed, 24 Sep 2025 14:50:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C63A60634;
	Wed, 24 Sep 2025 14:50:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82F2B102F1916;
	Wed, 24 Sep 2025 16:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725422; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RSp3Q4mkJ46b3+5fyiaK2zTo2iqcaDAhtmMFM8OB9Xo=;
	b=Qf0/4ygDj1X3haEyYtSZ8cuZwp5FV53t0P7PODs3oSf72TsW1b5fpZW7ic9KEdbsZHBJtN
	43MoNqL7tN3gII7bXxTYsJYwoEmPa+0Of7ayn4rKtnfqRS9PRS/B4xhrCGyzoRsmckcMfR
	svRkphJcRFI/Csmcd16wMK5I0hK0lJtjPzxA35fJVjAll+1SNtJ0K5pOq3a0P3naqmLU4z
	MYWuZxIoQx+cPRUoWvjaEDPwhOCfgr2j2WjzgVVhMzs2bobUzvbw9Ff/oONthi9qzSUB6D
	dZETB4uSviNJFEqoxKRGAvP3dribGf3EohX1LDQMVG3etd8RwfAfcSKRr2/j8Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:43 +0200
Subject: [PATCH bpf-next v4 08/15] selftests/bpf: test_xsk: Add return
 value to init_iface()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-8-20e57537b876@bootlin.com>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
In-Reply-To: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
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
index 8fe75845d7a6aa5342229fa419fcbaa411ae9e70..7db1d974e31511e93b05bf70be991cee4cd444c6 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -2189,7 +2189,7 @@ static bool hugepages_present(void)
 	return true;
 }
 
-void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
@@ -2199,7 +2199,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
 		ksft_print_msg("Error loading XDP program\n");
-		exit_with_error(err);
+		return err;
 	}
 
 	if (hugepages_present())
@@ -2208,7 +2208,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
 		ksft_print_msg("Error querying XDP capabilities\n");
-		exit_with_error(-err);
+		return err;
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj->multi_buff_supp = true;
@@ -2220,6 +2220,8 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
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
index 8e108e3162695d5d50b3e3805672601024e385e2..a874f27b590d8ba615e16c612728b2f515ac8dff 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -373,8 +373,11 @@ int main(int argc, char **argv)
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
2.51.0


