Return-Path: <linux-kselftest+bounces-26515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F049A33D39
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C16188D598
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72A21323A;
	Thu, 13 Feb 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="UkHjtum1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B80213E92;
	Thu, 13 Feb 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444434; cv=none; b=W1uR4kqD8Xeda2JwpjBt79jLh/k9+ERBAAlOSJpGPILBtvwauz9PM2wl7pmbisluGtWvbK2d/F1VaCc7ZkDwGjEMxYhEHrDDk66wv7DMpP1P4wtXmgdNGMQGY5diSyqBJnSVmtEPXqXNby+cIJfUdUa1MnVhtVQDLPV8oHSg3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444434; c=relaxed/simple;
	bh=fFpk4exI2Hl0XAPMFw8kqpnzwTJGv5t2BLFzWsp5Rqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbluehTSkToOLFG4v6IweQStKQm5f1Cs31/TfiNoKzKbgIF6vRux0VhdHZbm5/MLTKcI1D3g7FZ4rzbFNQALmSu3Kvl8zdK6An6wOTpr2PT5RinG8FWUSSniLwniSFkcEKw2EJVlYkSMX6QKoRaMgXCmdSYHYATdjXm7Dh+GB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=UkHjtum1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444430; x=1740049230; i=ps.report@gmx.net;
	bh=fFpk4exI2Hl0XAPMFw8kqpnzwTJGv5t2BLFzWsp5Rqw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UkHjtum1doN3MYOU05o8LyobFv7vPqRIdNCDha6UbSfH1PssZ5MCZ6j741geJGK0
	 0jGckgIClnShqG2y/9fifvnhe0notklX/vPIek3UkMPEdFpqzT6oTmp4R7z1unatg
	 +edaRZjeUBjMiH8gWyNYoH9yGr+PVL1PYn+n3cJSsesx/V48a5Law2zZWM6TGi7cH
	 xq+mR7g++C4yUswpeCeh7kR767iY7DY8gQk3x31NQkv3NYMvvzN2q6nvD0fpCWgMD
	 bNyoJDNj6hkdW9XZ+82JXb4cGCo/S5k21hGpq1ELChC0E6FErpwoHIHIoPynuutGk
	 lxpvs7lu5foVlpaj2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1szc1x04db-00fYCz; Thu, 13
 Feb 2025 12:00:30 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 1/8] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Thu, 13 Feb 2025 12:00:18 +0100
Message-ID: <20250213110025.1436160-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213110025.1436160-1-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+rmbIOsuy+5FgYyLnPLZ6t2Dm/fmGbyhEYagHOsO6N3KVR77WYR
 wQ/e7oFMkPjlqTl1uVmaGhmZsfiaxQXllfghUy9oS5+eJIiK2oT4zMd7ndF2oWA4GOEGRW3
 SdWuFc1nmOgnZtTHnhMWlhWnS8flhoqfCjqR5v1XzgPmg25Mmx+/ix3tzHBJd9cXdFwrpKF
 mh6Ns4eT50dgjZRCOyFRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/yw+3XkZ0Qc=;9YsAN1UpY0vYzNvu71twadr0zI+
 MN88dRPS48rceV00ON9Gzug++rJbmUNi6uHruX8RqmQSUyQsIOHaez11UrBGplNXjRjtdqsgx
 ekpkiKQvXBtDmmNR/tER6nQzmdRpvuN9aKgovMT2N+BIQa9Hzkp45v/65gNtfMyNJ4DN0+FnT
 JSPYFc3C6cN9NjSpaoYt2rOH4G03UVk1hTMWbdrmt2NM5itQ+Y9eKN0w0mp3eqw+D+Kd2j2id
 Lo8FN5gWOT0AJnYk+6JpHSgWinh0zIU0paWUi05+7lJ3WR7nvwOZWrpK560HzeVPgWO6Nb3Zj
 8MymWM8fr6oxo4L+nDCM/EDq9vTwN+Y8j+q8fK7ep69rLSBjxHhLoXmNqXUCvRfLQvUmep9pM
 HDYtiVTyQQzKIt6wlWotlymSCRFRJmzxX/HOtqaTiA6NbMXDQ/ftQsGxW/hy7gWBvAjxGVt2G
 Ftpf6eZScqkkqVIWKL64uWVZng33Z8GD6uUvETrlXK+GgTsbqwtP4hV0zC2Y8VZPLHpJCDzF3
 If41xyQE6eSjohV0Tx2MO2ZHwNQ8wecpc9zgmMGyqBlBaEQ9zPjec57e79roGF7WMDteksv+r
 WVVh9M4QRgzYEZ9pU4jLkgASGGaY80rUwYdaGiMD2vZwQDYoU+YemKH/ZPR+ZeCLSZ6Yw4Z4I
 e13TN9ivUyCyRJG+HfqH9P+beLcJ2E1zfdy2OD7VHHUc7nGmspK+mKy/QZ0W0g8QaBfLVugEx
 9dR4dNtx6W+pHcFQ9sz01yi6i1PvzZm1XweRZ+IF0zbSioihtWIdbqQCFtzXy/s+Y3Wsxt3Yz
 38bDkf2QSAY19RIyUymwocRJNyUJl3r1O6ytBwN9YPw28WtodEWaUTJEkiOFX2ny+V0MaN7HD
 XNvXqpd49wWmpw45tPtBBlwLQccNSTH3v20Gx3V/XUTcG0c9g7hGWxuf7UAlpfOHnUBHWCZeF
 Vw37G4BadXBijLMYMHhWW0DmKPdnRzflsX2nXbOy74cduSVHmuv/cpArqWudSCPPI0I0s/nPv
 hFdBGKu8mEcDHamicbCCJMpyclnviLFoeqoO1TRD1x/x1LqmqkUTUa0muL6MmsPecI8QCty0a
 XqWo2UJceoXIxPdRvTufAW+DMZkffc7bRafci/bMI2Dqk1q7EUQ8Bz91VSv5RSPOxqf0RsvoD
 jxRoXooHpx6Ul+KPEbg+OqkDoGeJ7P+ahH+VQifp8fLpv+MgKF7QlwcFLR8X/n9RoHlp9jXsK
 /bVIkIKefFiLLWazusuRlfiCr1y7Q/6cdQzNQUsbLpyk47NptooxIEtQ9z5B2zeq8VwUzQKC/
 vCsfweb2Vav3PkJBxFc9AVJSTlktEfSl70XxHheN+9gMEmDMylQ0DEMfi7yO6qL4O2K90yOng
 fWYjIeu8HFEeLVv980a8gcSVtoC+O0pbsj8P0SFdxpEhOy7rbEtJsozNcK

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdl
ZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NCAtPiB2
NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1v
biBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoK
Q2hhbmdlcyB2MiAtPiB2MwogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MgogIC0gbm8g
Y2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUv
cGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA4MmI2YTJjM2MxNDEuLjQ5NmFhMTY3
NzNlNyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2Vu
LmMKQEAgLTExOTgsNyArMTE5OCw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShz
dHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKCh2YWx1ZSA+IDApICYmCiAJCSAgICAoKHBrdF9kZXYt
PnhtaXRfbW9kZSA9PSBNX05FVElGX1JFQ0VJVkUpIHx8CiAJCSAgICAgIShwa3RfZGV2LT5vZGV2
LT5wcml2X2ZsYWdzICYgSUZGX1RYX1NLQl9TSEFSSU5HKSkpCi0JCQlyZXR1cm4gLUVOT1RTVVBQ
OworCQkJcmV0dXJuIC1FT1BOT1RTVVBQOwogCQlpZiAodmFsdWUgPiAwICYmIChwa3RfZGV2LT5u
X2ltaXhfZW50cmllcyA+IDAgfHwKIAkJCQkgICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkp
KQogCQkJcmV0dXJuIC1FSU5WQUw7CkBAIC0xMjU4LDcgKzEyNTgsNyBAQCBzdGF0aWMgc3NpemVf
dCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCSAgICAoKHBrdF9kZXYtPnht
aXRfbW9kZSA9PSBNX1FVRVVFX1hNSVQpIHx8CiAJCSAgICAgKChwa3RfZGV2LT54bWl0X21vZGUg
PT0gTV9TVEFSVF9YTUlUKSAmJgogCQkgICAgICghKHBrdF9kZXYtPm9kZXYtPnByaXZfZmxhZ3Mg
JiBJRkZfVFhfU0tCX1NIQVJJTkcpKSkpKQotCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJCXJldHVy
biAtRU9QTk9UU1VQUDsKIAogCQlpZiAodmFsdWUgPiAxICYmICEocGt0X2Rldi0+ZmxhZ3MgJiBG
X1NIQVJFRCkpCiAJCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTEzMDMsNyArMTMwMyw3IEBAIHN0YXRp
YyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfSBlbHNlIGlm
IChzdHJjbXAoZiwgIm5ldGlmX3JlY2VpdmUiKSA9PSAwKSB7CiAJCQkvKiBjbG9uZV9za2Igc2V0
IGVhcmxpZXIsIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBtb2RlICovCiAJCQlpZiAocGt0X2Rldi0+
Y2xvbmVfc2tiID4gMCkKLQkJCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJCXJldHVybiAtRU9QTk9U
U1VQUDsKIAogCQkJcGt0X2Rldi0+eG1pdF9tb2RlID0gTV9ORVRJRl9SRUNFSVZFOwogCi0tIAoy
LjQ4LjEKCg==

