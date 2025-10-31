Return-Path: <linux-kselftest+bounces-44498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD3C23AE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E183BCF36
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908E330329;
	Fri, 31 Oct 2025 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="05MoPBNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584632ED52;
	Fri, 31 Oct 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897905; cv=none; b=Px/3zdb7QTN7fyjJcyga4XAuajlZaBn+51mXrTiF0EnOmV5q5aOpPit9ToxtIWdRd/EcBeISe7pZKTlcQTxlVu81EB+8J4JLrEzOWXEQi/dob1r0SpOEZdd5fHAhVoZy7RSsYMUxSdZdwNeqYqUY8DjpCDBZoB9Ovqvjwoaf8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897905; c=relaxed/simple;
	bh=ZwKe430WcXOk/3GiwCgeIjtMWKpX3sKwXSY1J1f6ucU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcZp8HMgb5y0Myo0RkAnFLSD13oZxhwOHgv08rKNkJI968x4baJjLwuX03RNJIodnMa3ddisZRuCwV4Sj9KFbIH9NgmvRu6/FE/cyJPvnyewJESGWyp5jLXKxZTWQPpT97+VsI7Wctp8VQ7S/ysAN0wk2tywUTmCym5dPzIWY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=05MoPBNq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C09BEC0E94D;
	Fri, 31 Oct 2025 08:04:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4772A60704;
	Fri, 31 Oct 2025 08:05:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F7071180FB57;
	Fri, 31 Oct 2025 09:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wjSUqrmy8yTxpGwe8E8DxpLkivQqp7irxh7QJFAmi08=;
	b=05MoPBNqggJhq9WNBXxCmidbJty7YJgMATkc7cynd5VDws/xY3P4EqQiTGLeUIRFmt41Yt
	y6b+E5FJX0HeIU6jLFCzoQh3yf4nO/m3Th123Rp8YiDl/xUDgr60kU6a1Wv6gcn/HmlZ4Z
	Jm64GfNd7lHnhYIgeZndYPMKeXZML2GrSFND6faKecAx5TAm79T+YluOvGSWRVwMup04Y8
	Xzu7Td62jDCVm2Ihq2gCkfunlRqoobezlv5aQZ+dfVCPn3uMQHx0VZDEHa6FTDQu4vlA+E
	wOsyHER96rnck4UP4A3ar5lGKTzEcAhhMBvxW2+MNSu/FdIGf+FMUTc5SmL7SQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:41 +0100
Subject: [PATCH bpf-next v7 05/15] selftests/bpf: test_xsk: fix memory leak
 in testapp_xdp_shared_umem()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-5-39fe486593a3@bootlin.com>
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


