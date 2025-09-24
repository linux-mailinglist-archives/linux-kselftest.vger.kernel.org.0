Return-Path: <linux-kselftest+bounces-42195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DEB9A586
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF32917F09F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFC30BF63;
	Wed, 24 Sep 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F6D5gP4Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C930B529
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725411; cv=none; b=mvdirE79aaEn1n1mESajOkON9B2HBaHQ1U86GWzsXG2kiMxSodXI++g9WIeET6jGDRVpcsmHlxFdY6MnRNGBLyzlHW1mkx1UwArl36ZsNH7ChuVP6Pzv+xTaVPQ2RVjk+VrRSA/QakNipMUQVMJMRV6UNGs6mZo5DLRIH0hTztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725411; c=relaxed/simple;
	bh=QntO1gbQ2O/QD7BJzXedroNY+5AyUr6I8y1Tc2DnWpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcq4q5NWSnd223Q4fQ0E1D+5zPSCm1Len9BvMqcQtOVvpJa1qZnWHyoBz6SvACKwSsdtdbnbp8IaNjFtS7i92lbUvKrcrD+kWS797GKU80UlQLyUIf06lCsCvzp7WwacuTiM42SNEBRdqRogynTGsw84WH/XU5+swt0c+txTTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F6D5gP4Z; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6BF0A4E40D69;
	Wed, 24 Sep 2025 14:50:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41D2160634;
	Wed, 24 Sep 2025 14:50:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6D02102F1916;
	Wed, 24 Sep 2025 16:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758725407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r25cJKSJ2aGWddtaZ7/M8QgHMa9Wnxi3zbsK79tDlrA=;
	b=F6D5gP4Z8R00x6PcLAz9BBR7I2C6QEfXHApj9pUygMf9srO1z/DIzUZURM58nF/CBuY9LK
	jaroQXixgh9qyNAteeaGKG1gPr4tNPVsQloLZYH9pcxf7igGyQDRJ6uYIdMKQN2bRLlxEp
	d7bldqdtVWG9hZKkWVuDlyyKZxXKex6OJnVy9HsLEJOQfZrpcu9n8v/YVPJ433KcL6/rwD
	gQSjsMxnhSUBK/PTQzKMVDtx2Wu9TwiGpBAtF0X9cW+snHdxoutwoeNibXrpC6k6x9FdYZ
	mWHt2dB9/7xLAfkUJiiVtDOOlzvlW31jBtwoSC4uk3LZfnDH+STthZ9UQhdKhg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 24 Sep 2025 16:49:38 +0200
Subject: [PATCH bpf-next v4 03/15] selftests/bpf: test_xsk: Fix
 __testapp_validate_traffic()'s return value
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-xsk-v4-3-20e57537b876@bootlin.com>
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

__testapp_validate_traffic is supposed to return an integer value that
tells if the test passed (0), failed (-1) or was skiped (2). It actually
returns a boolean in the end. This doesn't harm when the test is
successful but can lead to misinterpretation in case of failure as 1
will be returned instead of -1.

Return TEST_FAILURE (-1) in case of failure, TEST_PASS (0) otherwise.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 679491b6b9dd80ccb2b92729141fb8715b874c6d..8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1725,7 +1725,10 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 			testapp_clean_xsk_umem(ifobj2);
 	}
 
-	return !!test->fail;
+	if (test->fail)
+		return TEST_FAILURE;
+
+	return TEST_PASS;
 }
 
 static int testapp_validate_traffic(struct test_spec *test)

-- 
2.51.0


