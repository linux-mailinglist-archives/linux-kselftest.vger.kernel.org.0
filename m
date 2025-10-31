Return-Path: <linux-kselftest+bounces-44501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DBC23B17
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDEC3A4604
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195163346A6;
	Fri, 31 Oct 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MeWN5r2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42A3321CD;
	Fri, 31 Oct 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897914; cv=none; b=AuA1w7Q1yuhv5+E6oh09JgTmSV2jroEeNTjqY2wnaxXXhK/26ufCmGoPCA4itiU3ugaCUHKkK2pox/JuUHEVnSV4Gz0r9pQju3VpPBu7OnUsc7r031cZNqGk2zPPQG7uymxeiM9u9UuDdgm07alLU5UIyluRmFz7PsgnXHnQw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897914; c=relaxed/simple;
	bh=gF9eLDsdFl0MFtqsAFZWcBEyY4Q/iUjVarktp2n/spA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPT/3vumzAg7176c4jiTgRxx556m2eUz26H54lGCLqeg42IvGmwWdJFj0jjTH6+4/8pHcysTxDguDKQ0iKSy/C+wa2BFSgvCqnPvBY4Y+zHurz3LTcdnL1Qvdz+5tRVj9bjr4thFTU22rX7BC8x0tVMsp4XJyb2W5QjiTx7GzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MeWN5r2m; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1142FC0E94C;
	Fri, 31 Oct 2025 08:04:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BEA860704;
	Fri, 31 Oct 2025 08:05:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAF171180FB5D;
	Fri, 31 Oct 2025 09:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UceLpeKVjdxHZmkAym7kcj/ErVu2YZm4GdUaf7zWckE=;
	b=MeWN5r2mIjtvwmUOhwEQU/Fx/6FwA9RQg4yqq5zXhwG+NWjDcO/1P/Er/t6BdskfjDjD81
	02v1ui8nVcowyg+KrJ+Z9yXpBIfHhsZ2f/laP4m0T0uH3GL9sKXg71PHDb3YcLS/VnmYmo
	qmAzjDvZTv6NyJ6Tt2AOqlQXcsSfDh591uBcQ47fYMXtStntuyNe6p5IwDqhntngG459is
	OF0ZTdRpxZfNg+M2ZemDCc2RWXySa0Z7UMrbrapFxlMrFYs36KttCxi5ob7lyx4CctgIBK
	2OXfYHY50hnbKz7T4b5AbvWv29MG0G2Yqyv7ZWwgdOk85X3Mm/q9iOBmqAQktw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:44 +0100
Subject: [PATCH bpf-next v7 08/15] selftests/bpf: test_xsk: Add return
 value to init_iface()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-8-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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


