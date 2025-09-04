Return-Path: <linux-kselftest+bounces-40764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB35B43821
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B201C81987
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790B2FCBE5;
	Thu,  4 Sep 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jf2FbUap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AF2F99A6
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980682; cv=none; b=QQ/UbHHFkcWx3+41ycCLwWae/GVw+tfai37vNAKfuD4IMElZifhnWCEpi9r5TK8R45irp334CaNjPl/pjT8R/boaeuOqA0gRNQFhaR2WcRsKG3E+D6dcSB5qLSRKyNqKrK1TbcsB47R1jlJ8wTZMRlM4Z+/NNEGeDBqh2ewPlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980682; c=relaxed/simple;
	bh=x/VbIzHXjgN1UGp6Xssf5Oy5As901Oj3zS6OgovVBz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIjUsKOcshADCTAsfIO7VkIQiI8NcCVntKtwDPQvfSamqj0svETEb8OzLH+X1n/3a+eF9MIE0icDfsexX0z5uCkul1j3/8Nhv4yfvwCCcN2E90M2wzOzYyoNzopqJzogkedZZ+7opRTcxUkZYoaXIuGf7kLZ8s5dF6kanYa0S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jf2FbUap; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5773F4E40C74;
	Thu,  4 Sep 2025 10:11:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3014B606BB;
	Thu,  4 Sep 2025 10:11:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D2A41C228814;
	Thu,  4 Sep 2025 12:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980678; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5w5g9wRyUW2u4izR+lIr7U3xnHKg5+eWc8QEQF5q/Xw=;
	b=Jf2FbUapFpCLkwo/VT3oLafliO80dLaD7TbKXu0Bs8aByavMVtlvYNBQaXZZTArNuXFNbr
	IpcMHRyFX6TZP+zmnesqCfOw2i2Gypow6TsSiCet/Z9gKvZxcxkjGHroEZ+lw9THV53DFo
	fr9rmnfkag7Bncj4UCcVb1gVBuy1Iu+SUUFJbnZuolFYRLhi7QwMH3ax1poLapgLAMCVyW
	m3FRzC3U3oX6EfN5NVBOHS2QHs0ENLIfwc5BQLCuomOmJ7X8Bek80dtMr6p/xs+ePu1SpK
	XJE/kCzgJaoicFSVSh32rwfhiZEL7+CddiD6u/olwXJQ7Sbd6vqsZWCM6pusMA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:17 +0200
Subject: [PATCH bpf-next v3 02/14] selftests/bpf: test_xsk: Initialize
 bitmap before use
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-2-ce382e331485@bootlin.com>
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

bitmap is used before being initialized.

Initialize it to zero before using it.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 9bcf7b5adbb35bc4f8f74bc24164291c3848d690..37752b2dad651b36d155051931d7b3b902fac403 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1079,6 +1079,8 @@ static int receive_pkts(struct test_spec *test)
 	u32 sock_num = 0;
 	int res, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	ret = gettimeofday(&tv_now, NULL);
 	if (ret)
 		exit_with_error(errno);
@@ -1269,6 +1271,8 @@ static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
 	DECLARE_BITMAP(bitmap, test->nb_sockets);
 	u32 i, ret;
 
+	bitmap_zero(bitmap, test->nb_sockets);
+
 	while (!(all_packets_sent(test, bitmap))) {
 		for (i = 0; i < test->nb_sockets; i++) {
 			struct pkt_stream *pkt_stream;

-- 
2.50.1


