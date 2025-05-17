Return-Path: <linux-kselftest+bounces-33238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA48ABA78E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391D77B5821
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70B78F58;
	Sat, 17 May 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QpHF6Q2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic305-21.consmr.mail.sg3.yahoo.com (sonic305-21.consmr.mail.sg3.yahoo.com [106.10.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523D4317D
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747445301; cv=none; b=qJafTtd/jsdWDDI5Rylj2T/WxmO3E/jZ9HlNzIIODSRF0KeQ/7zW6boSDmSA6jXekZyUg2b9VrECarSE6Lwa2Ar5tPpAJvw4jGAhCQnY4YR4Mw81JBp7TBil/71AIjOVvTSmnPsH4bZ8qK2lRycSF4oRT5PJXaJrW5U3wWcpVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747445301; c=relaxed/simple;
	bh=d9yBeeUpCGVTHOgB2WX+dBsSPuifeRXix63rbhlEc1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=KJI0pjcLUgBOQb88AwN+AtNkiUBSROhmFpybK3YpJMv50C6JKxbvTEgMt3o9nN99A7m60BfQjGVaWCMd1AGKaDtADa54nebdmP3C8L/NZsd1IA2+h+0lsJWulmpoddLxxKURmRXiCEcG6NqvkGGaTSUS7k20Ml7iIFtdDwmc1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QpHF6Q2N; arc=none smtp.client-ip=106.10.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747445297; bh=Pqsp8h438sdZA8gyyeRcDw//7DDxdzHk1kJORjR2Yds=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QpHF6Q2NSORCVyPg3naDWFKjrhPqSIRVZp/MMr8BzNc6JuPj/yFROOToErXAimMIYkDQXY8rA/FRUjxLPj2sjGwsRh9KfKSs/AfeLdeA/2hpHiBYlBPUfE5JpgO9mLAb5VUeGIkDX27j6s200RC+6BSv2wo0T0fCmWfhWYRdOaykTQynfNKXFkzzeHldEx+afU0tLX/IhPH3lyCetwveYTwknKv3m59YtvfsIxK1Bu1vmRoeZu8B+ieevVV7UG1MCg07RlxZP0SDoiQ2hgGjsqKLcwfk8zjr0IyJfsE9J4khpRkeDn6yHJZN2VpUT/+zGJ4lJwe3STkxyz/L1RLE5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747445297; bh=+xJcFkagzXn/072nR5py4ag2gkh8RbuLLNTYO7awO65=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PAD26vq6XqvB2XoOPWPrw/FD2LFNDqABdcpiztgYzLxPDTMzu3seaLQAGybkMsiwYAKnQzZcYfhJy+KQNxNHtIj289WV1Dw2s4Iq2uHFUkFMdA00361Rt8Ci2qclD94q+I9pxoInwlK2/tGqjmvhlB6JkINWwacWnu1/HfmNLih/g1By0pAG+wrN8dKLJn9J/QwWonrRPcY0dARbj1fkYOI68thKtSBBVTYsC9G/3g6uIMk++CUS8pH7FUGJyG0+uQx4JMUOE0TIKiY5XuwmoYeWRTh93DJh9i6ECgQmtia8VGcCSf5lbPvqKCRSwEyybwBWyWi3rB8M9Y7WibOELg==
X-YMail-OSG: e6dsXxwVM1llLUXKclfvArj0UDKvaNs.fDZceUi9TKx0gjMtJ8F8yj4gJsbMbUN
 w42AbrvjrUm3YnM5qcxCOzIjImoyP98n0XwYLd1IsgFVmq7Vb0_GNRRmLuQ5uqFaW8V94FYdyhhg
 3AV2zTV7aWc6G2gZvAlLOuC3jEPbJQKuqG7yUVAPhEin80OzjUfJ8.GNRz1ts7HNHJSsqnpzrj0_
 vjb9LnkU_PgoiTxy_Kv30UcxrYLO9.b0XYfh02OZyR7Jy8eS5A2lkpkgXcU2B6Oqu.yHzh0wZApH
 .LjAT0DuXbjTWsXQjLk0ADj4w4cyUvz7_ZT7IyRURqcoT5n98IUzUHDdcTj24C2DkjsL3Y5J37d1
 IvXqIF7M5kULOuBDKAH_WMv416QZg4RIF.Yn2RiknR95Y751GQNVKSUS9VehEWb5i8NYWklR4J8O
 l2zZApuTyhvICV.JXPK4KJnvaphczah80gcTVyTNSSLBqg3ar3O.ifC0R7Kgu4SSBRGahf36dAr4
 GjkoZKhHKCRAO6v4lJiuUG546XUiyrSM9mzNEYJpyu7cFbOBtsjaDJ5FktogNX4tMNL.UnghIFss
 QsHyYDyTYaRfWo6Y0P3NGDnJBToz6WQN4WEFwtcraq.vfoxVkJq0A9d5Jm84w9MLH3xC5CO.aCgn
 xbQxJsBHB.9ebO5VpCZCRPRMJk3tlUB_oKAsGtirlfFLSX4vQ7sw6PqAgDTj3Z3dBHrGApkptwNk
 4l95Q_OoCA5DclFNWg_UwdYpezRkEagKAvYgD_tyxohwREjGendVXhXk_l95gWjJwGMfwzn1ngDH
 GMHt41.B9F.z7Bko7kWQ68iC4uibW4N0FdibclhObmjyz22E3Dz6TY.vj4Hep2C1hx_fphfDR07L
 QeQNTBiSt1vfswxM5iBiSC9aAQzVUsY6M_1FwGnArX8S6sayhLf8fSC6QpEiwNvcDv35OrtnS3we
 jWeDIRLuwjY_mXF3NGN9BRM8DGk6wVko1EKS5fUS10fw3aOHZshHyBUqMI0nZKoLOwXk4W.fJFw2
 kLSPH4DwEw97xzd1nAZhbGUsbqJhAuCfXm_hv6B8MEgFQHEYmLv0BtCly03996W5vVlTWKuYLff1
 HNMXjKPYirmOY9GKEhqG5g6.X4QZ3ME7AId.fKzIusiT3gqEin_665Qs4BMRkksR9D0s2rO93ojv
 cpoNCtJBmgffXcXUzHCEq.SGzEOIQkledfmEea_IQZqLinP8NUp9kpgMyKh1iXveLJWKPyGxcqyB
 rUuxYQOB8FWgBFhslv573JqddQUM5AaTU2IiyZMJzh6alUUZjzBVh1s9ScyAdb31ho3JJM20XFxh
 v8NZeJmLRbH8ZfMwfvth38c.jzYb2tzeo1UfLDXEvSFakgo.lq425Uenf1EtgBnV7qmD3rE4lTNy
 T6_E0pfOdbx0.m3IFzJ5MlyhWyX8U71aTXU6MT9l..jwAcKs4tmPTEaUGwV_GQpIu4WElUSpKgCF
 cNpKpnAbV_fo6dHMOsZPSpoKaweBbtlHXQTw2rLFPwuZ7fIlo45cKkl3euLCn8sY2fXwTB35bf6J
 3dbDokRY7JwBbQacei3BJCNE.cvLNtu8dVF8BP5DXbchAUpLdXlG2wl.zYkv0HFohutayAVJJ3Om
 .OF6l9I5Wv6bZOU6h7TdHslwbiGRROVc4l5oIcHKc6G.jaQGgufndJEfQbTfWe0Uz1F7htTbTo2L
 lKBLZ1i6TiVRvT5nuA6wC2aC8u419iX4ocHNlSAoBY7uzPgnQcSCuL_7NeKYSaBLjfDVwqSfLTkb
 O3r_A271t7bkan0XwYdkHzkWuVJVYx4xQSfe_MaFM7FImkD0u3U2Nwk_.t3wABtwaADnYR7jgU2x
 kyg9AYyX4mxwmPLMbsFIGpGs5efXRMk8CGa26AY9ujhn51s7A9QCNUONfj9_XkaVa.Va35Wwjb_Y
 mStlmGI00ZwlMIBM1eD6VAmtZ2IgSn5WtQxTfB8SV7yOcM3NX7rWDuZT09Xb6MUiWDvzVidAIB_t
 4QFopJtvHFir83_RchBZDdjEr88CWQru2yzKqTNs35cDlgzXQT5gKi6c3kx2.zOj5pqQ57u6NW.I
 QuGZb_zVI4xC_0titSJ4Ia1.g.Cw_JhQBs9joDjNnXwlKRkWgrkPaepg8_tvLQfl5x1vY3G717Oe
 nx9.aHHQxe_OjWOkLbRHytRCpLwQja3jSjDGoTKBO5m_UYdt.74rUKNpwKQc5Qs.KdpnumuWQSk4
 kbKKn6eDgasM-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 39c5416d-d905-441a-8389-d146e6afe8a4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 May 2025 01:28:17 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 22506f5cfb701406c748d40903521528;
          Sat, 17 May 2025 01:18:03 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: skhan@linuxfoundation.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: seccomp: Fix "performace" to "performance"
Date: Fri, 16 May 2025 18:17:22 -0700
Message-ID: <20250517011725.1149510-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250517011725.1149510-1-sumanth.gavini.ref@yahoo.com>

Fix misspelling reported by codespell

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 94886c82ae60..5822e25e0217 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -1,6 +1,6 @@
 /*
  * Strictly speaking, this is not a test. But it can report during test
- * runs so relative performace can be measured.
+ * runs so relative performance can be measured.
  */
 #define _GNU_SOURCE
 #include <assert.h>
-- 
2.43.0


