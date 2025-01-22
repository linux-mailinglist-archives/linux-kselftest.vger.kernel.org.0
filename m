Return-Path: <linux-kselftest+bounces-24940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C600FA19439
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C52188D9C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095521480A;
	Wed, 22 Jan 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="VYzHMR1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4E214205;
	Wed, 22 Jan 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556902; cv=none; b=uJlrOhyP7EYfqNkoJokQtZeB+PYpKyTZwlskWwHM9DCb3k/SkdxrGjvnhbO4oZoMaaxJcIkS5GE6+X8c5MKgp97q/hP7KCfVXdYp+iVgQLCbeBPdrm5iB6xdN6/M4vBZAV0z1xQ3jjThcIykwSRldrMVLFMld9lquyq3wh/VYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556902; c=relaxed/simple;
	bh=q+DeEF53Y/cb5V9LljwFbWurT4RT/qgfwLs4GI4NwU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwnIvFfwq0a6iyO1Ld3Oh2+KO/xtNCfwgoreuO8GHwBA7PIBGd229V13JhwwOU7Bwg7xhnHx3mFJtjTxdzy3dxBEjlSqPV99LUY3Pn7BkNbPDbVqoRUbdN/m90xVIp43do8/bKeg0dKM2aP6s3BgFNfEMNmAlMhCiZIEEdy9j2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=VYzHMR1F; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556893; x=1738161693; i=ps.report@gmx.net;
	bh=q+DeEF53Y/cb5V9LljwFbWurT4RT/qgfwLs4GI4NwU0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VYzHMR1FFcAvBOXpzl/wd99I2bF9vrlTo3u+31KbAcDg3HS+uNbcZeWY65wsMi/R
	 x5bLycmIwMZRRxV/imVe4tt6I+LNSrhTxq0o91SS/aaGIxrGhqjydUOAfr9BIMllg
	 PUtxZEOgxnsL32AsOTV2RoBdaAZO2nUuG2+L7J7K42isj2U9fqqEj45P5wUtv1HXm
	 /hnoVXUz7fOzehb/vH3PYxncA9dwLyxSdweFNImWAuUgvpeU4uR2vDXoZxwkdzayE
	 bJy28AKt4ZKwE3sncTo3IEDjUFHqbAU3+kUPTe9lKtMIBlBbyro4sBiRO6IbA/77L
	 QzNFykAaPIJ+M8aLoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1t7vwS0yz3-00cH7x; Wed, 22
 Jan 2025 15:41:33 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 5/8] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
Date: Wed, 22 Jan 2025 15:41:07 +0100
Message-ID: <20250122144110.619989-6-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122144110.619989-1-ps.report@gmx.net>
References: <20250122144110.619989-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:91nyc8Mk0+LSRJLOCCiqwDh5f4HOyh8aQNJS20GMLH7RYoh1W9g
 H9Q3jNVjw17Y8G55O4RD+k2qL9VP1A9+l5mIaHs/IbkiD6x/Dl2WkdXQCeQAN0h2iaIc71i
 1JntLAgLX6RKOCeSjtFk2xuWGifYF3MDpkoSM3oFdBB7iK9IpwTvjM/q7BYryZQxaxDYkoY
 ULpUPcdXH/vX7ndNdkhtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wBbKBw/Q5DY=;m4EOd4EHHmXp2eqYmDu0XITgk7i
 iKUNzrOz/YQ4LN8+QcXdZ+pvEp2TP+OuiKQWyQnUuGu5Ro1SXG2dcm6N37Z2FC7yApa/zOjIX
 srt2nJiK+KydBfhDXw//OijgW+qyOYDkH7D7PulVkOtIRR03hC/YEvdzdZ3O1+kDsta7kC+BL
 7eavYJ4r3UYn7Ml4hcuQo0AuDvob7gEoBsNQXWQiQRASvtKGIQo6FubbVT5qLaavYQ6hE5wz+
 zNwH4JKEWA7caJ96a95ZwBHOF1YsnoQBLj+irvgQWOR8TYktzIs2C89aG6tbb9Q5rSoU7qJ2J
 zcQLmZYxvVxNnWYlg8NFqo2RPKK4JNnE5Zp2Q+uRIqOzUHRpNuBRYKzrzv8Iv8A7ZD6N7HCRO
 gSAhPqTTTKYyImBC1QC8WgsPces0fS9cK2qBfCCxXHiFdj/BUAhffzizkCpwmlOLuqCw6PPZw
 ni8MqF+akxje6unfKMbGnTnqyA6iThukyRHJfy4c5m8Yf0Y7cict/kcOscvry4SSFGXurKSCX
 iUs4GSrSN8LT26RFYkNijxEoNv9Si51pxXmXqqTxuUIkZ8ct1XdScpAKbCs/T5FDOwkOO5pcb
 ooeX6HZX9FS9e/UwzM5yt6kzAMEu93eEaMMKLwYToALtSpU+P9i7ZVOQNfj/SrIwK6ISkdui+
 en7EsNO6FbMx2733bBfiUKYOMQ2VboE84Um4For0cbdwaXCEiT0arMj0bs50bmUX3zp8CpwAB
 fmcf7qiv5UgiTiz6LCz5jX40zy+KxZHVkyzsTXE0xQ2QhhpTfmpMPIU1gHkj3iKDRlK1IheuA
 2AqKL+rS3HpoPxpHCAEPBHGTmYOtPMNhRf0FIPoDv1y1zwguORTQOxJ1O91kolnsRpLJ/Jer1
 IUu+D84S1BsFu7WWJQO5f5XtK0K3Wufqh4i5Srr5RgUgcHa/Ar6ClI5ZDRNh5KPC8iS2raDDl
 /bgrftbY9R6BNznbw2QGzdvBk/PNn7opfUTLvVasB7XsDUvq8b8b2D8pz7NKnZ80kxakse3pB
 uk4wFFIJbsopCFWSRk9eriZ8RhAZMYPULXFKs/0nEfUQ2LGOKwR+qjEc2YLNQmlQBo3tA/B7A
 AWKPSIFn073m3mEII9r0yEAPEzmleluRMoQ92fnuWDF8HdK3lOj8QTfV6O3DsOgVEdek0/vG5
 yngMHluKNLfAmWZOpyUDOBWX+k8gGt6I/p9YULrLJyA==

R2l2ZW4gYW4gaW52YWxpZCAncmF0ZXAnIGNvbW1hbmQgZS5nLiAncmF0ZXAgMCcgdGhlIHJldHVy
biB2YWx1ZSBpcyAnMScsCmxlYWRpbmcgdG8gdGhlIGZvbGxvd2luZyBtaXNsZWFkaW5nIG91dHB1
dDoKCi0gdGhlIGdvb2QgY2FzZQoKCSQgZWNobyAicmF0ZXAgMTAwIiA+IC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0
OiBPSzogcmF0ZXA9MTAwCgotIHRoZSBiYWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVj
aG8gInJhdGVwIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMCIKCS1iYXNoOiBlY2hvOiB3cml0
ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudAoJJCBncmVwICJSZXN1bHQ6IiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCglSZXN1bHQ6IE5vIHN1Y2ggcGFyYW1ldGVyICJhdGVwIgoKLSB3aXRoIHBhdGNo
IGFwcGxpZWQKCgkkIGVjaG8gInJhdGVwIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJLWJh
c2g6IGVjaG86IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50CgkkIGdyZXAgIlJlc3VsdDoi
IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCVJlc3VsdDogSWRsZQoKU2lnbmVkLW9mZi1ieTogUGV0
ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MSAtPiB2MjoKICAt
IG5ldyBwYXRjaAotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0
Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA3NWM3NTExYmY0OTIuLmM4YTViNGQxNzQw
NyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMK
QEAgLTExMzAsNyArMTEzMCw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwKIAogCQlpICs9IGxlbjsKIAkJaWYgKCF2YWx1ZSkKLQkJCXJldHVybiBs
ZW47CisJCQlyZXR1cm4gLUVJTlZBTDsKIAkJcGt0X2Rldi0+ZGVsYXkgPSBOU0VDX1BFUl9TRUMv
dmFsdWU7CiAJCWlmIChkZWJ1ZykKIAkJCXByX2luZm8oIkRlbGF5IHNldCBhdDogJWxsdSBuc1xu
IiwgcGt0X2Rldi0+ZGVsYXkpOwotLSAKMi40OC4xCgo=

