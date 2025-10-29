Return-Path: <linux-kselftest+bounces-44285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3AC1B2DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B35C08DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DA3451CD;
	Wed, 29 Oct 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZ6IuMO1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7F340A67
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745972; cv=none; b=DCK7GvBcZ1VDQC+7BII1QzLGQwyOYhLMyNnlkbBXC+/Rz8AC5LWOBeHZfkdXwQN3x8A7gqYjaRWFEhBHXcsgqT/66+U4gsM4dylNTh8fh3zoD89FlA3pinAA6ESaxCRiPZTIR3iAgimquoZH9iAVkeriNqXhwxkrsOR1RtXRh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745972; c=relaxed/simple;
	bh=ZwKe430WcXOk/3GiwCgeIjtMWKpX3sKwXSY1J1f6ucU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMvLLEE5MmjtlJun+yrXPDXtlmGtudPYgjeE9tt7AXJ36UkaLL3W3A4AMpRkIHbdfrQ4zokKNRmN8gj+tZZBs6eL23FNPMFOMykS2S+VieEn2cDy6T14QfVy0sYhPPqgbuwr8QAQ30HXH7vJ+OwPtXp92zvU3TtZzkuxPklQRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZ6IuMO1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 39A901A1748;
	Wed, 29 Oct 2025 13:52:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0EC6E606E8;
	Wed, 29 Oct 2025 13:52:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08479117F80F7;
	Wed, 29 Oct 2025 14:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761745967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wjSUqrmy8yTxpGwe8E8DxpLkivQqp7irxh7QJFAmi08=;
	b=KZ6IuMO1V3vChoAifeGM7Gz59IIg9H+Z17BemIuFi4MBd7ADXDH756o7IDiRsXExW/H6W2
	qIWQGA9TBvALoIi+PXawBKBfPxxV2b3bRHxIcxAV6TBfryPKuV1sGiSulHSNIxnWK6gOZG
	WEmFFB3UHCM0MrNVggoXey1qT9DnVrCw8zcaaHpzce8pyprSD3WZ5Uac8C288zp5gocZc3
	c51f39rtrkQCm4EiC9uR85v7Gl4rHMG6Ims62saknt3K+Eou8QoKUyn+GU+yQw01VrB18q
	H08xAWNy6CGoA+YlINgjdUhv2cntiBjvLG+fkSo9F/nmplW6szgpMsvtoLxjZw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:26 +0100
Subject: [PATCH bpf-next v6 05/15] selftests/bpf: test_xsk: fix memory leak
 in testapp_xdp_shared_umem()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-5-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
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

testapp_xdp_shared_umem() generates pkt_stream on each xsk from xsk_arr,
where normally xsk_arr[0] gets pkt_streams and xsk_arr[1] have them NULLed.
At the end of the test pkt_stream_restore_default() only releases
xsk_arr[0] which leads to memory leaks.

Release the missing pkt_stream at the end of testapp_xdp_shared_umem()

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index eb18288ea1e4aa1c9337d16333b7174ecaed0999..d7cb2821469c62abd0d532821e836336a2177eb5 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -570,6 +570,22 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
 	}
 }
 
+static void release_even_odd_sequence(struct test_spec *test)
+{
+	struct pkt_stream *later_free_tx = test->ifobj_tx->xsk->pkt_stream;
+	struct pkt_stream *later_free_rx = test->ifobj_rx->xsk->pkt_stream;
+	int i;
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		/* later_free_{rx/tx} will be freed by restore_default() */
+		if (test->ifobj_tx->xsk_arr[i].pkt_stream != later_free_tx)
+			pkt_stream_delete(test->ifobj_tx->xsk_arr[i].pkt_stream);
+		if (test->ifobj_rx->xsk_arr[i].pkt_stream != later_free_rx)
+			pkt_stream_delete(test->ifobj_rx->xsk_arr[i].pkt_stream);
+	}
+
+}
+
 static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
 {
 	if (!pkt->valid)
@@ -2043,6 +2059,7 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
+	int ret;
 
 	test->total_steps = 1;
 	test->nb_sockets = 2;
@@ -2053,7 +2070,11 @@ int testapp_xdp_shared_umem(struct test_spec *test)
 
 	pkt_stream_even_odd_sequence(test);
 
-	return testapp_validate_traffic(test);
+	ret = testapp_validate_traffic(test);
+
+	release_even_odd_sequence(test);
+
+	return ret;
 }
 
 int testapp_poll_txq_tmout(struct test_spec *test)

-- 
2.51.0


