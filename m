Return-Path: <linux-kselftest+bounces-25582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966EA260CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79573A7B58
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CD20E32A;
	Mon,  3 Feb 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="K5GPxUqi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4A20E02E;
	Mon,  3 Feb 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602159; cv=none; b=cN6ExfmHJYqbfXYY98TXab4SZnv8Xqf+Gv0a0JoNobT0cy1KhscW/r9cVGGjqUq30wJSYrrDoD2xQlVLi4h9nePKe7MJvk8cq/iDhwGXBdTSVLcw73sCHJmMrdILT492mCxmuETLOEXQmb6t/w6uoqJaHtDi4zToTuQQwyXMSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602159; c=relaxed/simple;
	bh=UXbz6Ai0gDMSuOu08BJN+KssFkU7tBuUUXs9SFeOx/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueo5e6ho9yKjL2EjN78Z0DWs4yc23JRbYWIstu9uOV2tGqJYHETuydfMvjmKVXPGEpYPwJNqkAEkFmfrYnFWPUtDP+sA5IErwJim1bYXYJmH9TK2dYQV0nr083cvdlIgyqNu0zp0F901cecDKoR2czp0j5TmqDFqPkKBIj+iD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=K5GPxUqi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602149; x=1739206949; i=ps.report@gmx.net;
	bh=UXbz6Ai0gDMSuOu08BJN+KssFkU7tBuUUXs9SFeOx/g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K5GPxUqi1MZHV5WV8F+xjf3/ydeWnu4sCwfqV1Y9R2Bu4kxKRffQMqzHdZEshFmd
	 U11USaAf6J4z/55WImEzYL7IPHwCZRacVFTeIx5f1K9Fs3RKeS0Ok92MyBu/NpXkj
	 zOl98NRs+sW1RNGkfr0HkSVjYzX5oR7rad9m6kGATMjlyPIiT9BMxU3MhAjysEbfZ
	 bDLy4KvGhtrmd3ZtTXkK6UafJ/ziNbI5IHu0bJvcGyrJg1EkKRto9erT7h2hxw18q
	 KHL5P9yJlkbe1RbqGdbc/JiQTWOmB1BbjnA2J1GeYg70BUz1Jio3WVhZZcFjcTKTx
	 dztPk9RRQDiG3Ljcig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1tqRuZ0A5C-00OS6M; Mon, 03
 Feb 2025 18:02:29 +0100
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
Subject: [PATCH net-next v3 03/10] net: pktgen: fix hex32_arg parsing for short reads
Date: Mon,  3 Feb 2025 18:01:54 +0100
Message-ID: <20250203170201.1661703-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:z3DwsX+U4a6YF7HWvEX391xetb8Q+nhUm6/DpO2Hi/CJKm5OWsA
 DXGuoc/tcEidJuDzwnrQf4mechqqAf/epR01tXgA6KfE/Ntp78UbqILf3TAG8JDPno5wqdW
 JTiCJcibPkUxiTpp+7kIU3U8NEXV2Sxn8zx8BBvcAgZCUa6fUsedTaRWnY4h1i/52Ry59ph
 qCWbd848XVr+a1GM6id9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LSyhEPmOPY0=;mG6w55RJYHbkeE+FIaijcsK0mS6
 6ED2g52keLTfxi8k6PF6vnu+pLxYv7X57mgKYT/kAw5dazIm8k9w2280E58fvubYV5R5bnZr/
 63oaBXRdQjlixUReEN2uYzMm+Hx51p31oZRX+n3XcHK0G4skGrNMiQRiOWGkejfHK1L5bmZvv
 4yaYj829jxThraWJIiXgiYoEshJMdnY6+gm8i2lzjNZy2hX5kGNAFvA4K0yrKi9zkK4T954Rl
 1ik2Vn1JqrnP3Ca3yXfWcwJI4airZPuctLyJSVqnzuIZZRVdaX67TDpYVXPiWF/amBvmow81b
 Ij+Lg1+Jz5se0vWmgcqvFw0XrU2opN8K30MBeT3KSQRjbfEReP35YQGjoWrGXwMKY7TckI46G
 PNqgWZqtnBB5EIPQRqWCitVWnw1m7q6xvPI2sGNifSzNcj3xiy+UqaJL8lCbnNb5QRPT5FlVy
 5Ffc5ZmejaWsDS8Vma5Y+o0rvVo7m66l6BqG/kB3hUI+qfTZaLRKr3Pxe11xqpyhb1nvvhdOX
 spv0mRGlzqtfjeF+QIQTZNibtX0406YADPD4JrKNzVvp8JskHYdNPE0aeZ8f1We321ha/emLX
 5jW/yaZQ4MgBu1hUUySdFSS8pscAhAklV+x4cfh4RgU+XH/eQM6ysPJeGq2g92fzwyipKyXas
 RcVFhHNobDYvSVjKAQSF4R+PAiARJufjyyyK3Eza1e/1FdJ/nsz+Smife+0xVa+EqUfp8bhbt
 HHaf1PFM6yiohXr4mNXXDQ/4OZDYUDia2qopvnOFYfS/O+h+f/G4PEE60mC/W1ceG4bLv6Uki
 +q4qpzZSwWs8BgB1F2wxFEtn71imYU48+4CBqkt49giq5RDYDzRMmFoGjPkK6+x/fzpLlQZFg
 C+ZkUt7nWK4EOg+IfJZItK7mH9oXiIlv1OEaKL1SZ6jD8CYxSacI3QNrdvdNU9V77l+bxz0V+
 AUxAODylY51bylEM9vH2EAoq5iWz7RSkPJlyETSpuaM/FUygqxMOMaHs6a1obTBmEUEdq1yte
 F8CNjiWnCan53BiuzrRlHg4DBQe/ypH7n+f0nwjDztVeu21pHpWDhWS1W47yeNMOh+c7UdUr2
 5MXr44Een+WtFTWiCz6DBNco8JPG6FlC63QV2VLL+/BlwgLUFLQbS6Oh762+CHRX7ASj2HPGw
 FY48hRYNZ275u9j0hD/OxHckbMGlCpXFHyWViUn1pzH9WPA7BS189/rqny8AZqo0iJ5QXd5ym
 RUBlGtOiGf+JHydP7D1sLFFgZJjnoNBTplyyAj12hhZwdgYjL0BtzWxozETHobOWaBbc1C/66
 909dfpTN5Rt+NYBAY/mY3su4jcQ9r7XOI8uXkG/pC/RclU=

Rml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcyAoaGVyZSA3IGhleCBkaWdpdHMg
aW5zdGVhZCBvZiB0aGUKZXhwZWN0ZWQgOCksIHNoaWZ0IHJlc3VsdCBvbmx5IG9uIHN1Y2Nlc3Nm
dWwgaW5wdXQgcGFyc2luZy4KCi0gYmVmb3JlIHRoZSBwYXRjaAoKCSQgZWNobyAibXBscyAwMDAw
MTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZ3JlcCBtcGxzIC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSAgICAgbXBsczogMDAwMDEyMzAKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDEyMzAK
Ci0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvICJtcGxzIDAwMDAxMjMiID4gL3Byb2MvbmV0
L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBt
cGxzOiAwMDAwMDEyMwoJUmVzdWx0OiBPSzogbXBscz0wMDAwMDEyMwoKU2lnbmVkLW9mZi1ieTog
UGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MSAtPiB2MjoK
ICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQv
Y29yZS9wa3RnZW4uYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9j
b3JlL3BrdGdlbi5jCmluZGV4IDRmOGVjNmM5YmVkNC4uMjhkYmJmNzBlMTQyIDEwMDY0NAotLS0g
YS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtNzUzLDE0ICs3
NTMsMTUgQEAgc3RhdGljIGludCBoZXgzMl9hcmcoY29uc3QgY2hhciBfX3VzZXIgKnVzZXJfYnVm
ZmVyLCB1bnNpZ25lZCBsb25nIG1heGxlbiwKIAlmb3IgKDsgaSA8IG1heGxlbjsgaSsrKSB7CiAJ
CWludCB2YWx1ZTsKIAkJY2hhciBjOwotCQkqbnVtIDw8PSA0OwogCQlpZiAoZ2V0X3VzZXIoYywg
JnVzZXJfYnVmZmVyW2ldKSkKIAkJCXJldHVybiAtRUZBVUxUOwogCQl2YWx1ZSA9IGhleF90b19i
aW4oYyk7Ci0JCWlmICh2YWx1ZSA+PSAwKQorCQlpZiAodmFsdWUgPj0gMCkgeworCQkJKm51bSA8
PD0gNDsKIAkJCSpudW0gfD0gdmFsdWU7Ci0JCWVsc2UKKwkJfSBlbHNlIHsKIAkJCWJyZWFrOwor
CQl9CiAJfQogCXJldHVybiBpOwogfQotLSAKMi40OC4xCgo=

