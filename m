Return-Path: <linux-kselftest+bounces-26946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F05A3B5AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CBB18883A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A51F30DE;
	Wed, 19 Feb 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="O9EV6sUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723961EB1AC;
	Wed, 19 Feb 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954752; cv=none; b=ae0/SKG2BTJPmUZRk6BLRb/PLJa2hNGcDfIm1QBUiHnrayF/P5AH0nk50oO19VY4N6hWhUVhftyjWcoTg/uyn9PLUA9ImFLQPAFQmdyz6X8o2rAqAQeP4AMbSlXgAh/rkLmPB1zr3g70INE/xzVITeFeYfgQKKTkJ6UyqYvFQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954752; c=relaxed/simple;
	bh=b+o8oliSx4C99JhmKgDXrGvyBY0QzVEi/AJvfb97+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmp/0i9yUUQR38FPXaqq1Kz4VJ+PC+J0NzcDO3TVoLYdf3amojul5HarjQnk3ngOjeTb1McxIFhHd+FYJt8YjKtXXGuWXBSWB/qOXlADkxx3u1xbyDulkzFPOvMoGSFqFsh1FxLd2V3zNIDV/SlKMjh/6haFZtsKL2IGtgz06YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=O9EV6sUu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954734; x=1740559534; i=ps.report@gmx.net;
	bh=b+o8oliSx4C99JhmKgDXrGvyBY0QzVEi/AJvfb97+sI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O9EV6sUuFiL6Ieuzvp3XsDFn5WSarNtNnQJmlhn+D5AiZ+5+K0X3T6H+0W1spOOj
	 yWge+PSpqiEAxVGzNnZj/mFo68+XSTPjp60HxKUvGllX9Ja01xhPqWGllwaJoJsVm
	 JZ49fg06D29eo7lcg4TlIfR5j+IqwggyoOzEQI6dZhSf/SBzHNKa/Qsax9ZjC+Mag
	 mg4MawjuR/k968TvH30URju00XIPLjhK1c46DU+ROiqXoArN4xVpPf7CyAgrBURXS
	 1YxTJdEMV2Zzangr76it9+jjcjJN2mMURQwLn4quKJeQI81TPm35Gmenf3zisl2in
	 TizzDSxxNk0ho+BTmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1tBsvH3yqI-00fx6K; Wed, 19
 Feb 2025 09:45:34 +0100
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
	Peter Seiderer <ps.report@gmx.net>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v6 1/7] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 19 Feb 2025 09:45:21 +0100
Message-ID: <20250219084527.20488-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219084527.20488-1-ps.report@gmx.net>
References: <20250219084527.20488-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:vMN1tYqw9IoIWT+xrsvQp9a+YgRGxnN18oFFuYAwSiNYyq4RCyO
 s6vzZI5uI0ratJ6gtPk/yvPpJA8WVaOoLSrwgmS7Bsjgcwm0xztUGuSjWjdH2ri6Lqgl2hn
 7aDkyaXfqRI2gA8ggvkus2kmVSVkINPandLL5wmv0T4h9TkVmtq+XZm+3Yp7+TN6FMyFLfi
 3pQktRbNSDEKt2k8OXBWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M6J2T9fhYIg=;BcoOcjZTvZF2ACrD19fZ35nN0h5
 asqXAhPtBo636PeqlL/2pIZys5Ze4s9TxfNIY2az3kSsO5ZNpRWKz0qYXyvjjSXRqax2T6nQH
 N1oqjDpkdPNbDe9y1ge9xDOkwZcdk/JHq6TV3RAX/9DNQXZkVm4uwZokPESHajD+rKvcHfvD0
 NcnmwmrbARNjusuuYGbKLHlxuL38Mbr4pYFtN2LYrLv3wdgVyvsbVl6MfHqgRQMzc8nroKCZt
 ohw7Ytsjn9KQJEd+CZfpwctwAXgpMoZsWkVhdvbbFiOqDQYTkBKfz99hqqkqsYxQF6ESSjqU6
 t409N+ALVufHDsAxSJ8w9WV2qhIyiqJ/r3wafZEPflaIkWdrRPvbqo+PmfZdRACjCHyMxqjwz
 G7Moy0OZeZ9+7w2juxXy4ERdZPPiJ70+mp5nC1+/pXewIraxYZ3UGjOgJJEiux+0XGF21fNRh
 R3Q2G5WYZXYpvWFgr2ycK5+989jjZ/n3uFzZWIDR0ud1v5x3EUsLcojzcFkw4h4iZiqJwkZvO
 INsUtuQrk8V8cOJg8XsUqp84WIVBHFkPYdnFVCxKvTRmD18Ad4lH+IiKXWJ7Od5v2uhujbak2
 InSfPh2I7RtcGFT4JiBuMnD0zss8eEHhH6oGeFR2DffbSuj3hWfykSR5P3x8NBAUVry3QygLa
 y2z8MbkNThgCDr+W13qkTxt62zH5xrz3TXvZZIR+hyPqRX2Wo0o/u2kXrQ/29z9sQSPBPwca7
 81diTZiMR2pL8lpm8nj2hMvwTCR3BaysUZDTqEq9TRtWzLJpeDeZTM8Bp12GD39erKyL5TSZc
 zS2BhvDM4rM2aGmcCd4zHHAPxZ3xo95m0MwnyJIAO0m0FxylY2/SSa5gfHAd1SiDUZb7/qoll
 o/jlQJHjT5UDPXdE7EBpwFbVgLKc7oLlCePHcgg9wg2Z5N76eankRj7RN9fe/q78cAj6HUeIZ
 bDNrVtkxgyhgTzPGSWMP856U82OCRarz02tS2H247fahDxkai3D8CEe+dZYPw89EziLKJf5uL
 /ELMWF+6NbJclKkfLaWi9+yiBlyh0eIdkM5zbsxNNjzfDquzXJPMY1WbgiXwHMQNdHod8vfkC
 bAVTDJiudByAZqlUO1fQJuxA+9PAqF7JIPygyJ3vgib4s5yAneYdRy0OcDr+ESc7d8d1lSjJd
 UGMqrRaUySaBPFhXPqh1CDb0ioERo2nxyDeLqnWwVGQZGRBFn6NWUgNWrurAlJlLsaOu2CALz
 gSaW6zjWP1WFVlmTTZIuYDtvxQNIWFn0v4dFmQKigVmv+x5zC0WV5WKTRGjnM60ZkV9H5e7/6
 5Dy9wMl2vQvJVLs/dHnngzWsJNDhxZsoxEiGjUiisexdnCv2ZDDQjMJeIHSUBmz4m71hX8XJ2
 xLh92g840Yp95UB3sg5PB/5vBEy49Nck8NgJiQLIQx2qfM7lpnRhkbm93lsKFUlC8qUZpcNEj
 pvCgFDw==

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdl
ZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NSAtPiB2
NgogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQg
aW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+
IHY0CiAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MwogIC0gbm8g
Y2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MgogIC0gbm8gY2hhbmdlcwotLS0KIG5ldC9jb3JlL3Br
dGdlbi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3Rn
ZW4uYwppbmRleCA4MmI2YTJjM2MxNDEuLjQ5NmFhMTY3NzNlNyAxMDA2NDQKLS0tIGEvbmV0L2Nv
cmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTExOTgsNyArMTE5OCw3IEBA
IHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYg
KCh2YWx1ZSA+IDApICYmCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBNX05FVElGX1JF
Q0VJVkUpIHx8CiAJCSAgICAgIShwa3RfZGV2LT5vZGV2LT5wcml2X2ZsYWdzICYgSUZGX1RYX1NL
Ql9TSEFSSU5HKSkpCi0JCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJcmV0dXJuIC1FT1BOT1RTVVBQ
OwogCQlpZiAodmFsdWUgPiAwICYmIChwa3RfZGV2LT5uX2ltaXhfZW50cmllcyA+IDAgfHwKIAkJ
CQkgICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpKQogCQkJcmV0dXJuIC1FSU5WQUw7CkBA
IC0xMjU4LDcgKzEyNTgsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0
IGZpbGUgKmZpbGUsCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBNX1FVRVVFX1hNSVQp
IHx8CiAJCSAgICAgKChwa3RfZGV2LT54bWl0X21vZGUgPT0gTV9TVEFSVF9YTUlUKSAmJgogCQkg
ICAgICghKHBrdF9kZXYtPm9kZXYtPnByaXZfZmxhZ3MgJiBJRkZfVFhfU0tCX1NIQVJJTkcpKSkp
KQotCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCQlpZiAo
dmFsdWUgPiAxICYmICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpCiAJCQlyZXR1cm4gLUVJ
TlZBTDsKQEAgLTEzMDMsNyArMTMwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfSBlbHNlIGlmIChzdHJjbXAoZiwgIm5ldGlmX3JlY2Vp
dmUiKSA9PSAwKSB7CiAJCQkvKiBjbG9uZV9za2Igc2V0IGVhcmxpZXIsIG5vdCBzdXBwb3J0ZWQg
aW4gdGhpcyBtb2RlICovCiAJCQlpZiAocGt0X2Rldi0+Y2xvbmVfc2tiID4gMCkKLQkJCQlyZXR1
cm4gLUVOT1RTVVBQOworCQkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCQkJcGt0X2Rldi0+eG1p
dF9tb2RlID0gTV9ORVRJRl9SRUNFSVZFOwogCi0tIAoyLjQ4LjEKCg==

