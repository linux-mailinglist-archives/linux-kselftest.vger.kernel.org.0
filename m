Return-Path: <linux-kselftest+bounces-42197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B10B9A58D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08164E1DD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF830C60A;
	Wed, 24 Sep 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5TsXfjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAD30C113;
	Wed, 24 Sep 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725415; cv=none; b=jQ/N2GN97R4/06OGHDSC3R1hAXgo1xZGSWyeSsSHrQNIAeLvkXwAG1TNu5KFwdF7IWJRVuXtuKMyINAP/olid7PxcHMz9DyvWGiim7Kc68HWZDVgYn45Y1czkdxwJ1Yw6r2s3eGNIXDVEjz9jEhIwSXCweFgoHFOT3J3MF5vwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725415; c=relaxed/simple;
	bh=TZieB9lYTRDug/RT2WE0zKfhPR3/EVFWH3rMKlquW68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mF1bPJ/F5gGRp5nPDnvNbtcw2Z33DYEiU9l6SkaEKmufozYrTRRlh+gum7WfsAUdv+//rn4HkMtyEDjsKXUNlbN5pPd10qrAYB5JroJPQylux6MrItvGMFYdt8UT1Vm+LLFP/lUwPE+Zante03iB38g0E4kS2Ho/GukaNctijtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5TsXfjp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 05EA11A0F81;
	Wed, 24 Sep 2025 14:50:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CA66960634;
	Wed, 24 Sep 2025 14:50:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60B1F102F1973;
	Wed, 24 Sep 2025 16:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jkYcjm583dXSVSeZq1srRFe8I29KOIeE29N37oNBMvk=;
	b=N5TsXfjpr94309e0xIvefosKxSx+FDUVRJiG0GUIaSOflG9c9CqXR81vBYy0UK2O1VLRVo
	+zt2yudqC43Cuz2tSo0w+bgPrbLcnSNYfVS2fm/5ZD6RXLgBPPJhyVB1UHzDx50Z5cc4hC
	Uw/cd+Wwvu+Xd1qLSZlh0b2DGnx79A/R+VY+qMuLN834WjcaRh8rykRHs8Ybdv+SfVP5Ts
	RvvwXO4Jay/NVP8XlJHeZODdy1/J1a2m59Ksb1eC7QP3FCcFh33T4i0CM6HOnSMY1cwbA7
	7RIRcF5L5tPuco8e801tKasorc2p9CwUxXRzbb7SiS3wbg88wsQoNqvVmByUwg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:39 +0200
Subject: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory leak
 in testapp_stats_rx_dropped()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-4-20e57537b876@bootlin.com>
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

testapp_stats_rx_dropped() generates pkt_stream twice. The last
generated is released by pkt_stream_restore_default() at the end of the
test but we lose the pointer of the first pkt_stream.

Release the 'middle' pkt_stream when it's getting replaced to prevent
memory leaks.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
 	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
 	u32 i;
 
+	if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
+		/* Packet stream has already been replaced so we have to release this one.
+		 * The newly created one will be freed by the restore_default() at the
+		 * end of the test
+		 */
+		pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
+
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
 							      pkt_stream->pkts[0].len);
 	pkt_stream = test->ifobj_rx->xsk->pkt_stream;

-- 
2.51.0


