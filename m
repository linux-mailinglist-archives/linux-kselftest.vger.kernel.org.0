Return-Path: <linux-kselftest+bounces-25843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A5A28B72
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46402168C7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F0193079;
	Wed,  5 Feb 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="bqMgTZAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B418950A;
	Wed,  5 Feb 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761135; cv=none; b=NhbF3wBit82lwBlUGDrm9Jp5r3uZgZPfRRkZa2Ax0eTfB8IWZODoIOHYRzts0GEjbrjAuyxhcRfVU3YY+KE66pEzBDuQJpc8u4sBjpnWlPdaF9tb8ZyYpnbZlIgbgMdArYnnaQP4sHPkh270tc7RQLbPGsj9uxxX6xziVsvbxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761135; c=relaxed/simple;
	bh=DfZwXemZ9uih4XCzdcvCsnG10zFKF5khlIfY0beDUtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJpwS6/7ysj/jn8uvj1NI+hOSGfPRAdM4im6PLa0I0s7KepueZG4vUfa2gM+DQMz62EM5ABfztyhKVZn105yENqdwH6p882W68DfbvP+GERa1BL1GNdek55UYbgj581SksDX04e+Q+pmhH/Y4EaU9AdkFUwhM9EJPUcDpbwJ7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=bqMgTZAH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761123; x=1739365923; i=ps.report@gmx.net;
	bh=DfZwXemZ9uih4XCzdcvCsnG10zFKF5khlIfY0beDUtc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bqMgTZAHsieG7C/RlOG9G3q3hxRqBJsW6Z/isuwgwM+24aJ9eJQH/ziijaYTNkhd
	 Bl8njn6DXbc5ZGhey93Ux/yI5GKD7yUS83fqBKjm2Iom9qUxxKjlVAH82DWwpXuNl
	 gEIlRDTZYSnpkSzoJ+WKL1dn6KOcicakblhFu60npIbIl33mYGIMqOHEGrjw+s/xq
	 3JKkWE+Kef8ZoYcBgUNnVOMEAGkIa+Z7XEL71DVBlHpJS4iBTaka2CB/nvAvN1urc
	 VQtKgLrs6p8yaSS5/SUfTBu1hhF6EvqMrlrJruJZSJjgQ28dwh3p3rirFH5HfBFLD
	 FV7zzrJ3GTqEF4JmYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1tHVX91SdE-017dKE; Wed, 05
 Feb 2025 14:12:03 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v4 09/17] net: pktgen: align some variable declarations to the most common pattern
Date: Wed,  5 Feb 2025 14:11:45 +0100
Message-ID: <20250205131153.476278-10-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:cVVKwbgSW1U4qdylOaxjJsN1FjtiCYxTGSxsdCVoOHLIkGdXSNk
 xjehj+K+aQJw0ahWfvk2qQgkhYwOmYeblSwAfUAEKMX7l6xWzn8Hu9dhLwNcV5BYPea2T/n
 C1TVpqdaZ3CHXQmbK4AKg3V0d55nprNIgO5lsLKDFUJ3UnkStzMvy4iv3ekuKvHQ27Bw3SG
 TYBdYR/5cXf7rTfaLG2ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KxFaNSczZFk=;zCEAKfLiXdJ9LxIsrWZCX8R6PB0
 0u0cBW8/L5NXTC49/VBzzif7dGLlxdvqVkm1Gf/3R20HV61PzUKvdtxU68b/GJW5NrXivCu2/
 SEbgSaJWgl/ipWzBOliZDr1tlg4ODTO4CEhew1WXP/g0NvaDjARuiRlYvAKkMOlVCakiGjxXd
 Vad2AeqOxAlkJGLrzzIOsWJEYON7z8A+t2Vlv/z1PT3Ynl90HRhcHC47DDxoejeAO9uVw4T0o
 CoESgXhfrgAI8BMxcwbTuepkCdUCnh39utsyDCzt84+vxBw964L8jp4xBYiO3jChtFfu+2pUO
 qxYyp63ZtFTSK+D6S1E9QznD+tnXc1RneI3jBy0fqMTl27AMufFL8A64nVbh0fRLE7ToCv/6B
 haDHmaDiPFm4sYAZJ9tSg55zsc5ifu6jc81dtlK0f7V/IDoOHymIGhgCeu39TzQdyRJviW95q
 ZU+8kWTNhndLkQjb9Oi7hzH2ZbffH5q+Mrq8Zp0LTkheNK8X4e1m+rIcTk9hK5+XUyAmcT965
 SiHhrVc6uXq6jqiwLV53FvtcT+Unn5j5KWpOgK+IbCcGTsUJ36+QJlXZBJGYpGmxApTZO5+le
 CMNeDVt1MkuwgbgHahNGgX/pLDsDrsg9kDDlmO1saxg4yIQswCiEGnlM+J9Wz4RAv9rBrQtgo
 OdNLGEQoJaLNGn8yWKOu3FLHZC/MmLQL+rX6wxIpCh98DRkND1t1ISUrP3LY6qsBzKSFkwmlX
 ADNzlRUucac9MmssVdRHe9x746Y6CfPU+nomFOn2H+S+IPyZvznNO+N6D6FJWn8nhURFxTtDd
 krL0YI8/HxappEW/87Xwn72lMYrncuBwYeq+sK9sCmp+AS6b7F8IS1ZJsPQpoNpOm7Tamslfe
 oU2O8VJDfTUj3XNZ5gu5Crg3GbVq+XP/2LEZ83SOLjJs+9RDqNT1cBTQxjY6d1QEuIZ+5FTHa
 NKOWuvb8xyiyL3fbKawPhhR6gQ8X1nJ72/DHKS7r+06PK4RHJifsZIAMlxRUA4VbeJEUfTbmU
 8YGZQQgI8S30AUNTDrWaD2AYgFuawzQG/g3px7OBZgZ64GPdYhfmcXA8B2JdgQUOY/fRB1mv+
 IRSLEHeqg/QhU8Qo0v+1yu3w7bFV5GmZ0un5I9jmOc2rwOwI2+0C2DhlW+pVPyHkYdvwdXk/8
 9rINhWBDiFhU0b+3KIHltP7Le2/HMlGzmts4ax3J8Yu70UQlyKkgvK1Ag+WNlwWo0+Z17R8uw
 0wrmb5LwT0Wf5ocBlIWikrbgNV7+cEfrnsiogb3q878INVhwWH6nyli2QspIdxAu2soHVVQWg
 bC5oiXKL8ofu1D4wTwfjT/TszkQG89wX1u/zg9MHF4rY/k=

QWxpZ24gc29tZSB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgKGluIGdldF9pbWl4X2VudHJpZXMgYW5k
IGdldF9sYWJlbHMpIHRvCnRoZSBtb3N0IGNvbW1vbiBwYXR0ZXJuIChpbnQgaW5zdGVhZCBvZiBz
c2l6ZV90L2xvbmcpIGFuZCBhZGp1c3QgZnVuY3Rpb24KcmV0dXJuIHZhbHVlIGFjY29yZGluZ2x5
LgoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0K
Q2hhbmdlcyB2MyAtPiB2NAogIC0gbmV3IHBhdGNoIChmYWN0b3JlZCBvdXQgb2YgcGF0Y2ggJ25l
dDogcGt0Z2VuOiBmaXggYWNjZXNzIG91dHNpZGUgb2YgdXNlcgogICAgZ2l2ZW4gYnVmZmVyIGlu
IHBrdGdlbl9pZl93cml0ZSgpJykKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDE0ICsrKysrKy0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXgg
NGYyMDFhMmRiMmRjLi4yNzk5MTAzNjdhZDQgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5j
CisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC04NTAsMTIgKzg1MCwxMSBAQCBzdGF0aWMgaW50
IHN0cm5fbGVuKGNvbnN0IGNoYXIgX191c2VyICogdXNlcl9idWZmZXIsIHVuc2lnbmVkIGludCBt
YXhsZW4pCiAgKiB3aGVyZSBlYWNoIGVudHJ5IGNvbnNpc3RzIG9mIHNpemUgYW5kIHdlaWdodCBk
ZWxpbWl0ZWQgYnkgY29tbWFzLgogICogInNpemUxLHdlaWdodF8xIHNpemUyLHdlaWdodF8yIC4u
LiBzaXplX24sd2VpZ2h0X24iIGZvciBleGFtcGxlLgogICovCi1zdGF0aWMgc3NpemVfdCBnZXRf
aW1peF9lbnRyaWVzKGNvbnN0IGNoYXIgX191c2VyICpidWZmZXIsCi0JCQkJc3RydWN0IHBrdGdl
bl9kZXYgKnBrdF9kZXYpCitzdGF0aWMgaW50IGdldF9pbWl4X2VudHJpZXMoY29uc3QgY2hhciBf
X3VzZXIgKmJ1ZmZlciwKKwkJCSAgICBzdHJ1Y3QgcGt0Z2VuX2RldiAqcGt0X2RldikKIHsKLQlp
bnQgaSA9IDA7Ci0JbG9uZyBsZW47CiAJY2hhciBjOworCWludCBpID0gMCwgbGVuOwogCiAJcGt0
X2Rldi0+bl9pbWl4X2VudHJpZXMgPSAwOwogCkBAIC05MDAsMTIgKzg5OSwxMSBAQCBzdGF0aWMg
c3NpemVfdCBnZXRfaW1peF9lbnRyaWVzKGNvbnN0IGNoYXIgX191c2VyICpidWZmZXIsCiAJcmV0
dXJuIGk7CiB9CiAKLXN0YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIg
KmJ1ZmZlciwgc3RydWN0IHBrdGdlbl9kZXYgKnBrdF9kZXYpCitzdGF0aWMgaW50IGdldF9sYWJl
bHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwgc3RydWN0IHBrdGdlbl9kZXYgKnBrdF9kZXYp
CiB7Ci0JdW5zaWduZWQgaW50IG4gPSAwOwogCWNoYXIgYzsKLQlzc2l6ZV90IGkgPSAwOwotCWlu
dCBsZW47CisJaW50IGkgPSAwLCBsZW47CisJdW5zaWduZWQgaW50IG4gPSAwOwogCiAJcGt0X2Rl
di0+bnJfbGFiZWxzID0gMDsKIAlkbyB7Ci0tIAoyLjQ4LjEKCg==

