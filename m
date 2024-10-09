Return-Path: <linux-kselftest+bounces-19330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112459966BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D39281BCD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118318FDAE;
	Wed,  9 Oct 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PbNAs8+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05618E751;
	Wed,  9 Oct 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468747; cv=none; b=OBK838GUmFsdRz5psuVIYZp4XB9jMlaySeJr/kmBR31eLoazW03WlAUiK1Buk5xbZZCY4hECgHAulzdWPUmnLl7gZJuSwk6FJas3H3YxkhEcp42P1/JvyPdLnU/VJrtJrXbQ/Bo4YrD+iL18ER8eZRhazegyVPx7TAUZds9iEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468747; c=relaxed/simple;
	bh=+sARYNDXya94+YnYkLip8MAbxcbLt0ahvueDeRSmTro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcU7tDRFXERXV3pCX9dF+Y4yy8MwBOBxuzCTwECB9SPyXHP9bEIgdxlmkilu9AIh4a2igiUidVTS+fQxPKuDsY+tGC92oLf8GjJDvX9yX+dDMTVl+5tLmVuA/oew3dPNWCAL3ubBx5uKzUtJBQ2tLC+VRKeAHbSS8N+XES6hfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PbNAs8+Z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C980BFF805;
	Wed,  9 Oct 2024 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728468737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvGaG4iHniQKZT0Rk4g1io76BAEbe8ISZyb9QH08KlU=;
	b=PbNAs8+Z2DIETxeSLPLqmy15dh91DCTk0b1gZjFq3GVo/+GPi5K6hNAIba4ywTjwhV83Go
	qHaj2ILOA//oNPBuCSAtte70oumv0qpv1F7L3+StkBQKd8NNNeKkC9JtTmY3c6Y6L2q+Dt
	G/aBJWZ1gj+MqqyiYvn9q/quT93JlZFpAAyPwNsN/OBOrBUoe0FmjrnNFNIAMt5C6hmPLw
	z0R7FGLnFUxar6QG5ZauCibgg4aOosB/7tfdQF8Jcx6i9isxc95oe1JXlXx7+qjhSlcjEh
	FHYksVHknzDisArZ7xz3bcSohDFAUuTBmoeDBzVLrxZBh6anxQd4/cx9+kp+zA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 09 Oct 2024 12:12:07 +0200
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: fix bpf_map_redirect call
 for cpu map test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241009-convert_xdp_tests-v3-1-51cea913710c@bootlin.com>
References: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
In-Reply-To: <20241009-convert_xdp_tests-v3-0-51cea913710c@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_redir_prog currently redirects packets based on the entry at index 1
in cpu_map, but the corresponding test only manipulates the entry at
index 0. This does not really affect the test in its current form since
the program is detached before having the opportunity to execute, but it
needs to be fixed before being able improve the corresponding test (ie,
not only test attach/detach but also the redirect feature)

Fix this XDP program by making it redirect packets based on entry 0 in
cpu_map instead of entry 1.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- new patch
---
 tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index 20ec6723df18a6e8c036bf7754fbed83f2d2430b..d848fe96924e32a72e1e0327e3afffeb349b933e 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -15,7 +15,7 @@ struct {
 SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
-	return bpf_redirect_map(&cpu_map, 1, 0);
+	return bpf_redirect_map(&cpu_map, 0, 0);
 }
 
 SEC("xdp")

-- 
2.46.2


