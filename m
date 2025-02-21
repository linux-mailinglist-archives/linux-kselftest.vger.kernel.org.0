Return-Path: <linux-kselftest+bounces-27236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A075A4024B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791CF19C82CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB76254AF6;
	Fri, 21 Feb 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="hwjIY/jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630E17CA17;
	Fri, 21 Feb 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174778; cv=none; b=EPDrtvJ/GhHEjSKwKPlIzIT6NNnGSBINJS664STQIu0GhnBuYrX4ObohAicLjaBKjgRhSXTfP5CFqfwjkrWbjBgUvKnUCq2TdgA7BmSEcHSqlVf3s4fpM4w1xnRAIY1F9Ca5cHxloNO4ekhz2WgeISE3LnKS1T+T0ZEOA6y9vKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174778; c=relaxed/simple;
	bh=+v3owkXmWRQyHjyf2WyeFFI0j1d1tsQI4XKQ/SEq5qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMMniYyqia3to19/y1DubosDy5Wo+F0cZ6mMev9kjgtTrzedPjBlvkwpMimmsnKCJpJlU1z3AkDr+nBN3VL00sh+lltuN1CaCluNQp440rinGkkkVLLr6CbB9pmCAO52RYUeWNi5HAQr2KaWJX3IJ0lpx0fNEEXRd1bsV4Tgu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=hwjIY/jy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740174771; x=1740779571; i=ps.report@gmx.net;
	bh=+v3owkXmWRQyHjyf2WyeFFI0j1d1tsQI4XKQ/SEq5qg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hwjIY/jyT30ZVM/0KDRhDkxH0XJuiLq+ZKpAeT/jU67sNFNyq2cBXcjN3Z+OkIyv
	 rsiTZyrMgO8HlEndWdlRz98oH9mbOo16dFoMjARtihHTTyx41v8jGvclbdNXDvVC/
	 GA2+DDJBHkjHV8KX0NqbR9SxIoDfW8LluZ7asr/RLAjsGT/7m14FVJGTzGZLjvJpr
	 fLYZYhLJQMOnfZyS3+Lenzcbr4Dy7qO8zNfQOgdPZKu7zwkNzG8pAZ73xiUL3GvZD
	 9TrwQv35+emvC7ex6rpLlLlsOwi1Eus5C8hBl2w7G4UHKydS9SvBY2DI1lP/uxdcC
	 Gj6wzmMcsTfXjg7IuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMyZ-1tyyxu2nZZ-00IlH3; Fri, 21
 Feb 2025 22:52:51 +0100
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
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v6 4/8] net: pktgen: fix mpls maximum labels list parsing
Date: Fri, 21 Feb 2025 22:52:42 +0100
Message-ID: <20250221215246.383373-5-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221215246.383373-1-ps.report@gmx.net>
References: <20250221215246.383373-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ngtz56J2gKflZ3uR8gR2zcf7bmxMDUuDTOhend7Rllu4uv+8POZ
 zsbtqvp7juan4agOjEvvV2DfIjiGKbsPaWilgbO7SlujGdyZsyQSJBYYla4EaH+i/jljl14
 2260VeWlWdjGjH6GdziQyolPtWNmoU9i/7jzYYAx1SdQrLH9qIxqm/6rgGBZv18gIoU4Z/Z
 oCj9XkqV1myQrYJ+XLdRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qTzHgP7fCyg=;CrYBsbp9IYvyWOSxhnKVlRoYYaK
 V9Dl7o1IRqcPy5/ijitsaDhfShp0stOZvvreewLDnD+BjJbR37jLBveHNRMVnktD7nV8aWGCO
 0bsl5OOt9gknb3ypSIcg7/cbMsFiEIto4Dfa+h9MqLEy9OJA7ZCTqiHmJJQoyYWbLIRgMf4gn
 Z8IJlG5nClQcsP7S0H6+CkCAOaR65EVm+efUKi4ZVQe9lNIOav6fHsnB9qgi/Puq6Tt4AU214
 WlvQe0V9vcr43UWsFWJzpdxW1eJ0RfCwnnvhSDrKouEZohxYLSfe+3N2o3MnPb/y6T3BCA0vW
 5pJ/CphHnXz16kXosiGmfgOgFqbbJ2aM9lmwj9ekQXph04zdvknOhd+NLQAf+L9jh97h4uU/C
 9MufH3DuXmO/KW4U29liigXF44wfHITc3RT2nGdSCPixJtRO05ERsx590Tu4tQ4wLFcoVpv7j
 ifZTCoERbsvON6y/Ba01sbtVMLx3EnBgAKqd51yDQ0W8iQJazLWFOLG1854E8yF3L1LlzPtRn
 nZljurIq22XJwyYCPvbn5VGEEFGU/4j+nsu/NMCn18ejwifqEPTpOyWlel3o9J5Onuzec+Qq6
 uEyxZG2/fmbINqTVxRJipUHR6By7t7aD9wZXSgrRdekUdcthw941el9dE/mTOPm7Zl/8fczNE
 nTT86NEelY+VbLeNjPFlayee48ELWGaqqIx2etBNjcW9bBUaaH5TfiOG+kPUeB9XcN90aCO3J
 rQER3aQrC7lnxT6UqOHbUZBHdCQdeWa5jn5Ruu/oef0uGgAzFNZj5gnqaarNCCCyhSza8QtYN
 t10MBd3wUzFH2WP/eN7t11jhj4onUTFNgrGbFcm6nLQ/0pYc6TthUKlaMJCo4jNZ0CrZRf6ce
 CC8OpMHz65phognb/55WPdt9dsfjf14SCXeFtCakZ7WU4AjIai2KQD7HCULTTELcYEYhnJK/z
 W4FnUjajRwlsodSkFUD22srzzQFitNz03/NmbomuBqongrHk13ALtveaDHylgDkNvvEAA/7Ya
 mjwi/wbn+c1AaweAncV0fthOi/gtYoZj28Mva0iGglDWznuW7MJ2ugA23BYQQDmMSYaRw5edX
 yU/25PK/lbZdytN/Tu4BHa1VUE9wljMJWCVR+33pqcnw/iKdG+I0UudU1KNYQbSgtp5zHrpZe
 AZqFpeyW23X43pU2YfRpE1rvy+gDGnmCpEb0loOCx66I3j7CmKkVvBLag3fk0sG4wkKxju476
 BNGBUiwsucfHmsvSoLfFrg2alWFYxboMrakT+fkgC02r1BjwiKHaq8sk5o4AMI/kL8mzMbjQ3
 znvWgAdwWehBx4Bm8939Q4C6K1CyV1/Ve7dLbRXwJmDVTJHROQSi832FOZpFmuWmcRWA8+CE2
 YjGsoIEnKo+FnPYM1Zo1Xhvd6JB+aXULjl36MAc+rG0LVfZcD9PPJLmMbL

Rml4IG1wbHMgbWF4aW11bSBsYWJlbHMgbGlzdCBwYXJzaW5nIHVwIHRvIE1BWF9NUExTX0xBQkVM
Uy8xNiBlbnRyaWVzCihpbnN0ZWFkIG9mIHVwIHRvIE1BWF9NUExTX0xBQkVMUyAtIDEpLgoKQWRk
cmVzc2VzIHRoZSBmb2xsb3dpbmc6CgoJJCBlY2hvICJtcGxzIDAwMDAwZjAwLDAwMDAwZjAxLDAw
MDAwZjAyLDAwMDAwZjAzLDAwMDAwZjA0LDAwMDAwZjA1LDAwMDAwZjA2LDAwMDAwZjA3LDAwMDAw
ZjA4LDAwMDAwZjA5LDAwMDAwZjBhLDAwMDAwZjBiLDAwMDAwZjBjLDAwMDAwZjBkLDAwMDAwZjBl
LDAwMDAwZjBmIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCS1iYXNoOiBlY2hvOiB3cml0ZSBl
cnJvcjogQXJndW1lbnQgbGlzdCB0b28gbG9uZwoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVy
ZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NSAtPiB2NgogIC0gYWRqdXN0IHRvIGRyb3BwZWQgcGF0
Y2ggJyduZXQ6IHBrdGdlbjogdXNlIGRlZmluZXMgZm9yIHRoZSB2YXJpb3VzCiAgICBkZWMvaGV4
IG51bWJlciBwYXJzaW5nIGRpZ2l0cyBsZW5ndGhzJwogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3Jt
YW4KCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNoc2V0IGludG8gcGFydCBpL2lp
IChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQogIC0gY2hhbmdlIHBhdGNoIGRlc2NyaXB0aW9u
ICgnRml4ZXM6JyAtPiAnQWRkcmVzc2VzIHRoZSBmb2xsb3dpbmc6JywKICAgIHN1Z2dlc3RlZCBi
eSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVk
IG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAg
ICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdl
bi5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4u
YwppbmRleCAyMDRmOTNkZTAzYWEuLjAzZWE2YjVkYjE1NiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUv
cGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTkwMiw2ICs5MDIsMTAgQEAgc3Rh
dGljIHNzaXplX3QgZ2V0X2xhYmVscyhjb25zdCBjaGFyIF9fdXNlciAqYnVmZmVyLCBzdHJ1Y3Qg
cGt0Z2VuX2RldiAqcGt0X2RldikKIAlwa3RfZGV2LT5ucl9sYWJlbHMgPSAwOwogCWRvIHsKIAkJ
X191MzIgdG1wOworCisJCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKKwkJCXJldHVybiAtRTJC
SUc7CisKIAkJbGVuID0gaGV4MzJfYXJnKCZidWZmZXJbaV0sIDgsICZ0bXApOwogCQlpZiAobGVu
IDw9IDApCiAJCQlyZXR1cm4gbGVuOwpAQCAtOTEzLDggKzkxNyw2IEBAIHN0YXRpYyBzc2l6ZV90
IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwgc3RydWN0IHBrdGdlbl9kZXYg
KnBrdF9kZXYpCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJaSsrOwogCQluKys7Ci0JCWlmIChuID49
IE1BWF9NUExTX0xBQkVMUykKLQkJCXJldHVybiAtRTJCSUc7CiAJfSB3aGlsZSAoYyA9PSAnLCcp
OwogCiAJcGt0X2Rldi0+bnJfbGFiZWxzID0gbjsKLS0gCjIuNDguMQoK

