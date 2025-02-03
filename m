Return-Path: <linux-kselftest+bounces-25588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC46A260DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ACB3A04E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42305210F7A;
	Mon,  3 Feb 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="KNGxwasK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EC20CCC5;
	Mon,  3 Feb 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602172; cv=none; b=R0KCojyib1mZW1cNp1KukjwiYxI3dw8Gd2yYDOnb7Y8E27Ri8IdJ6ETF/ZTLrUGVKOFRXGL8US+Ame6JAQnFN7kO8pDgvtEHxJNwBNFLsQ9bLlc5dXGU8QXay7O5G/VOhKCYFdwXDwqXK8kIS85EYwl7g7mQvdwlD3+arMnGOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602172; c=relaxed/simple;
	bh=fH7kVesQm/RvIe2gp8YNloYPh2xmhW4qa1XSxX0eyWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swsvDwmV8oObY9CintamN4AFOynEqlQYDLs89un0anfN/x5mO8RnmM/gkSGypo2SX4YCq2l0OH4OKdGlv5Ad60AsjnAtO+UEysmyOnGEmoS6nwYWBRLkylXALyV5apSvCY5KUnMOMKs+gRXORTBJQTKKea9dxZTRhfaqgqLuY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=KNGxwasK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602150; x=1739206950; i=ps.report@gmx.net;
	bh=fH7kVesQm/RvIe2gp8YNloYPh2xmhW4qa1XSxX0eyWU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KNGxwasKsGNXAs1srbJhJW3jBw+8LzMQKE+fd+q/nk5C0dyVCVWBweMm0Y+w0DNH
	 aPgg/WzIuPZ/C+ZtV6FncWh5bM8uOtv4kYZm6f3g9NiiIKCTqn03q6QMsLOKDhMBP
	 /7cwsYOAkLB0h+lp4V4rd+U7ataCtsmJ2FPr3DWzaXIDcmwzny4yFZqBtkXpD3Umj
	 85H+EXVyYYH0ShLjWmcKJFLf13OhkfaNkBO4W4lS1nnqh+p40eIB13XjhUvIy7eSk
	 /5uJH0MOx7UNAIDEml5wnWkqKuiBZwDfLuFu9WMIxHqUgrm6X+juc/8WKCEIyp/dr
	 0iGyIsvlaBsV7A3Eqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1tjvWe22s6-008xVK; Mon, 03
 Feb 2025 18:02:30 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v3 07/10] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  3 Feb 2025 18:01:58 +0100
Message-ID: <20250203170201.1661703-8-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203170201.1661703-1-ps.report@gmx.net>
References: <20250203170201.1661703-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:38/oIZRTsFNbpJ/9sF5RfMdMc/V6FZRzbpAwRPEU6smRIMUWnRq
 jHZ0TckZH0eNGHPRM1mZE/U7oxSe/44owZSVqJacF44ZAXxa7N9aQR4yDvmce5MLF9/QZZe
 STsHumpoIO4rrqMivfQ+xtCEwxD6lG2UDCPyhKtVtTD66GesIx/Wr4lmidRbqVUdILpN5NX
 qrZRXjzUqEKoLVnZOgFIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:chBZIKyyCj0=;G1yDz/PWnuEy4blsr6bziIwRqZG
 yrWOX3hkpY/qGbrB0JSREOnuLMMNJn2MeVimSoVg5I9jIS2WLZ/cOvU8z1+lT35U39UfKkqWZ
 Iba6pDKjlxX5vHnLyMb8yk3C2sBBnab0dyS+qbXj5/px0Cq29lIFfsnOVDA6F+SDrFt+vGNCG
 hn4d0/aN7IzzleS7zZyyHIW7jBVAmt23dvbAP7ZTFdRn0lvS3CV3yH3zcBFqht2Q2UVL9wiZ8
 8v3M4UFg2fRuiGXinWeIFl3wmXR37uTlXAD58qdGggzq3O0etW1LW91CVPEFR6IOK2bDefu6c
 9NqRS5vCm8x7Mulf2UIfqdn89+hXy8ASu8Up5pUCN4hkDcAJV0Cki45LlYT8DYvKnw2uDKcYJ
 8i92VdJw8P17O1zaVf3OuRxTrj+7+oP7L3ig+IuHWE2CjX7ze/nfjNRSNZIczpRg3JmBPR5Mm
 KQVeLOH02Y84FkFJaiYN6ATCoCH295xhxlkndDQx8FsiYQYbArpjJ28S3gJHxQRp4yiHvhmXS
 g6E+41A/JED5J9JDfVWeqfuhH5su8mnsT89Ok6pu5p4QGbC38Ze3GG2TRVvYDW5hqT2xAOgAw
 MKBVrUIyVhK0F5aTCGKm4FyzRmOOiCb8r1lXm6zBBsxYrMzJ8LV9RVcl2bDCMxzvqz0qlSckt
 Aayez4ERivIRIArDerZxggc767CD1bLFwXrAsY1CzATf03dMLHlh/r+hdARaDWAavpshYFxSO
 +qAyf12dQy3NWEAnu1+AycuKTIaJQIgKURZLr2/iG2KE6MGitzVkhuZeeDYWC9ShKj2sWq3KZ
 Q++LONEYVZ4OGh8CILqoDvY2yldjW0dnOUuPMbLeEpMU/djGQQe/cBWT85X0PJ8dMQRZ3ZgOy
 MAfx+uPERO4XO1MTFxvmSBPVhZnxmQ7Bk5K0Ytb/HGX+HlXcKv+jyVFHebZh3U/FeygKVNqBh
 3oxB2qeKQRxg70uTuYZFMHl6J7wy4C6jX3v5b+T9dg+tirKfYfEKQ5Y67D5kUTH2MUoBvs/qC
 g+Re6MuD/B8K8GR+AiBqn74oXby79ObUiuSrIvxAxWuHO471rcg2nzYMFdKg0T2e8a8xhJ91t
 v4b6/3JtJSkKURlShGKB13Kh9KmPA38xBvGL1rtcDskU8c+D1ZA/iu+2YR2SsHWfsMCE4l/Yq
 GMf6yCONeipX+8xyEpWWVdPDF/e3WX5CdwifK7TXHHubqgIeJO3vJqZYYs1p/HlIAGjr+TznT
 jSHmC7QMjgJxHDlp52INBDeTZnn7NQZZ5oVI2FWHRBwgXvYaSa54MO8qTU4UkPZRNCi8w1itD
 CyNjfMnCzr/397yoYqiEWLAFuH5KHL/LPrbGOIJZ2cI1GQ=

SG9ub3VyIHRoZSB1c2VyIGdpdmVuIGJ1ZmZlciBzaXplIGZvciB0aGUgc3Rybl9sZW4oKSBjYWxs
cyAob3RoZXJ3aXNlCnN0cm5fbGVuKCkgd2lsbCBhY2Nlc3MgbWVtb3J5IG91dHNpZGUgb2YgdGhl
IHVzZXIgZ2l2ZW4gYnVmZmVyKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KLS0tCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFu
Z2VzIHYxIC0+IHYyOgogIC0gbm8gY2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNyAr
KysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXgg
ZjZlMzViYTAzNWM3Li41NTA2NDcxMzIyM2UgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5j
CisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xOTAwLDggKzE5MDAsOCBAQCBzdGF0aWMgc3Np
emVfdCBwa3RnZW5fdGhyZWFkX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCWkgPSBsZW47CiAK
IAkvKiBSZWFkIHZhcmlhYmxlIG5hbWUgKi8KLQotCWxlbiA9IHN0cm5fbGVuKCZ1c2VyX2J1ZmZl
cltpXSwgc2l6ZW9mKG5hbWUpIC0gMSk7CisJbWF4ID0gbWluKHNpemVvZihuYW1lKSAtIDEsIGNv
dW50IC0gaSk7CisJbGVuID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBtYXgpOwogCWlmIChs
ZW4gPCAwKQogCQlyZXR1cm4gbGVuOwogCkBAIC0xOTMxLDcgKzE5MzEsOCBAQCBzdGF0aWMgc3Np
emVfdCBwa3RnZW5fdGhyZWFkX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCWlmICghc3RyY21w
KG5hbWUsICJhZGRfZGV2aWNlIikpIHsKIAkJY2hhciBmWzMyXTsKIAkJbWVtc2V0KGYsIDAsIDMy
KTsKLQkJbGVuID0gc3Rybl9sZW4oJnVzZXJfYnVmZmVyW2ldLCBzaXplb2YoZikgLSAxKTsKKwkJ
bWF4ID0gbWluKHNpemVvZihmKSAtIDEsIGNvdW50IC0gaSk7CisJCWxlbiA9IHN0cm5fbGVuKCZ1
c2VyX2J1ZmZlcltpXSwgbWF4KTsKIAkJaWYgKGxlbiA8IDApIHsKIAkJCXJldCA9IGxlbjsKIAkJ
CWdvdG8gb3V0OwotLSAKMi40OC4xCgo=

