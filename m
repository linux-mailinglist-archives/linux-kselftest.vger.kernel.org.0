Return-Path: <linux-kselftest+bounces-40597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7957B40185
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC0618936E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E82DE1E3;
	Tue,  2 Sep 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g9OvcK/J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE52DD5F7
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817648; cv=none; b=BztDKsZqKOb94xsWIJfNDz2Zj5pQa4rf22zmOqdqxWaSH1q0jVfrO6WrdDj9ilHDxZZnqCHFQIuUisqdaTTJPG3wGbfS5mCwYgRSO1TTYmmwWphHeRyFPuwg3BRDOjqdamqLCnQQw712wNPjIm0YQX/a1Zm6Pj1Iz2PV1fyG1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817648; c=relaxed/simple;
	bh=ZTbWD0p3LeAad7RzY7cPeQ4DMNg5Ioa+xEYeOfTOblA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5mlF6fNzk9C04Wf3hWJdYDUq4EapSUX736FVJ7U9UZjqVs8swF5MS8CqWWFINCv1zX9vBmZTmIuWohXZc7iBdOQ7ADRii/249umkUVEvxMEKDC2VL9i4Xbe+F/6nVVGCMxC4whUfaY2aDJuowTfLKJa/Bh6JcZioZXkxqAemC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g9OvcK/J; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 507C5C8EC76;
	Tue,  2 Sep 2025 12:53:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42A1760695;
	Tue,  2 Sep 2025 12:54:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CBD51C22D253;
	Tue,  2 Sep 2025 14:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y6OC0KlKri3ggVyKJQWtc/or6xq8M50Bxw3DLncJ/9o=;
	b=g9OvcK/J4NdiBl9ffa7nek+8/j3B4umcZuUtsJ3uxb013QjS7K6zoOmEzdZhrns4V0Ppa+
	iwZHnCqbRNfP3kmGeOo4yJGMxcwB9s4oACEQmwCToNy+smSN+I0NVVnXsD3w8tUe+Z4UAN
	Ynu7UlnXf09yrXbbXOzIU5V93zOnzLtaafYoJ0FsR957NcNSQA6BAWYOu4cDub0Nndsmmv
	SVkIFQrXoUrUjR4UBT1u9Zh2jIVtv2KaPGk7xjZTy+0toRjQEX1AW5KZedOxred6Y6lULT
	bHddo1UAFdBXRwwCR7eJr29i6Pa1liHIRu1MU7s1318q4LNIPqp59yc1L4gCSw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:56 +0200
Subject: [PATCH bpf-next v2 06/14] selftests/bpf: test_xsk: Add return
 value to init_iface()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-6-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
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
index 074cb8f9487e489834b4bd081cb58b51c73c3b75..5019172a5c5eeb32be4e5026b8a7f9e56997c10d 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -2210,7 +2210,7 @@ static bool hugepages_present(void)
 	return true;
 }
 
-void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
+int init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
 	int err;
@@ -2220,7 +2220,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = xsk_load_xdp_programs(ifobj);
 	if (err) {
 		ksft_print_msg("Error loading XDP program\n");
-		exit_with_error(err);
+		return err;
 	}
 
 	if (hugepages_present())
@@ -2229,7 +2229,7 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
 	err = bpf_xdp_query(ifobj->ifindex, XDP_FLAGS_DRV_MODE, &query_opts);
 	if (err) {
 		ksft_print_msg("Error querying XDP capabilities\n");
-		exit_with_error(-err);
+		return err;
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj->multi_buff_supp = true;
@@ -2241,6 +2241,8 @@ void init_iface(struct ifobject *ifobj, thread_func_t func_ptr)
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


