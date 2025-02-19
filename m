Return-Path: <linux-kselftest+bounces-26947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B402A3B5B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2E3BD8FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70C1F416A;
	Wed, 19 Feb 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="KsB3XDRZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C11F17E5;
	Wed, 19 Feb 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954754; cv=none; b=LcV+Lwps0Wgl9pPaC/VW8RHs50BMo9SpVQA1G22Vu6bGfFgse7I0KZ3cdvvr6so8EtMAjA8JXj+Q3HS1bwKxpUb1zo2MQQljdjFB0i97pIJzWYhrmXBLYGZX6/Jgxn6tUhhohFIfdpqb8dsjGvJzNIkgSGpKtPnFlJEoz5wHrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954754; c=relaxed/simple;
	bh=Ofg9u8W99aAgJgfVz6DTmnj36OdvUe2HVm+hqKXSobI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6I1nPeBknsrg02DiE+7gr0faTAQuMDoFbv03RWkjn7gir7qpeP/ymFIGkqNUo9xUDBZRLJNlOCNxnAVLH7L0V1GfKOY2ch/WzC1f8uYQ8GuzF8QnkiclC9Bdhq6HE/TqOc7nEFnQsgbmMpnQvuzNVv+JFl2PriWC0tYHwJZS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=KsB3XDRZ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954735; x=1740559535; i=ps.report@gmx.net;
	bh=Ofg9u8W99aAgJgfVz6DTmnj36OdvUe2HVm+hqKXSobI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KsB3XDRZ10pC1lwNfkvoTqP9VG9B4xEDQ4OvomGM29MSy1bUaDacX/QTaUfspawY
	 4A3gUjBa6CbiTFt/P7ditBkgNy5TYyLX+RfghTX7Wsu+dZGkDI9NsWxRjLba+bXDL
	 WAAHTKgxWMMuWTLP0DTb7QoM45nA0QuvfiWgE2am10XGMY7fnj5hHlThDay8SNS6X
	 y2GX3WBrc+59Po2pJBCUkMM59JJbp+FGfV++tUWmMG4n//WhINfCKgrRhQcxnozL+
	 kQcTl0MbALIlV13GqXv7Md9Ej/F16lwc5UPJFRG7oUQ2NEjEdyvET2sTQmipBK5u/
	 Lvuwyv8OXqZd1rM/jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1tVCDv0xei-00vysg; Wed, 19
 Feb 2025 09:45:35 +0100
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
Subject: [PATCH net-next v6 5/7] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
Date: Wed, 19 Feb 2025 09:45:25 +0100
Message-ID: <20250219084527.20488-6-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:9a4L28b3mjP5fc1EyEcgCGJ+ElBhJTM4xLfveLJuZzoVlthLQu0
 isqCKRHQyv6ovpF/47qxi4225rSmJbWmoebTURQzKMZFKJZvbTiksF3o+BQrBQKXlk1lRa1
 Jny3l37R9jw3yfkUuG7bVpWMoEiU7n/bEwdCH3zk4wpEykCHd8Q9s8A6QmHS70cBI6DP1Mg
 8JteVmVqwCLRLVavclOLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lCFPuVx8E7U=;JFvAe9ZfCf9ZJcdsFW2w7t2G9lS
 vHn2Dy3stxzKRkejm6MKUqvSFqmx07W3H+/GhfkB2dxvhsbA0e+SVpJxVfdGHOzaU0op7QfkK
 ZGISXjZGPjXTj8intHCENIncDH54uVOlTN9btr995J39bXyJ0nrfzxPw2T0nAZaTxLahPzM6H
 zR62aLHGRKV7WPspOa4hucvPO7CyxhoHCLPnAF+ateiRoPCQn+n7A3xG3FCW4lWDogm23M9ll
 ByUJ4SmnHgcqI9eTcO/17L7ruimdWcJRMkeVfPJrf6PGaY0NRAN70Z3xWPKnTC5L4Ku0Nc7tl
 tho9hV942j4/P21SQI4/eagwdNb5nPzzaKZX+jHcEsHcHu/VR4UeuyRZGuO+IHkfl0j+WPj40
 PyXXcLk4Se70Lsnz5hRZiQT476f8blR3PDpzEAVzYhwFP0s9cfa6jfRcdIrAAWZMCMnKtdrZ3
 2bLMooRa83gjXRSk4djMv9s5+odL/1D5ZNrQg4PCV0aFOZiPW+I1JvOF1FihFlppOvfNEUqR1
 ZyHblAj4EUa18BJtnYuK/7D4s2H4Dk3zYWtdNUnCrTS8DmeKIHdMr0DNWOOAlfvoDNio3F1Bp
 db976ltwkiXufuksgHR4xyegYXFE9Qim1ZDm5ARowKTnyhWHwtEmOznwlvGtDjVyCYKEvUf67
 +GxjliTjPqBtRlpuYDDh13q5cL2L1HED1UBReqFzeK7BDzEhm0b2OIvREDsAaMeOEeyATFSG2
 AmGgbGuLTOsJonu+v7BFsZ8IYQfIF8ugwJqeUdsiDIcxmRxLpob+des/IaZCI9f9STgcZicwg
 vF0Tg1sBB1QdRwF3w4qM53iMj7S7Otf7wy5djt1SLwDi8NJhyEpUqjJf+Dbz7yJFBtkOcXQuO
 HcH2NGAM4Lijx43BWMjYZeMAha60cH03jZPGpJyzzIBMXo219PiL2D/uLUDSljqo0zwxCR569
 emqBcHa72HCq7z6i5wNWbTVbKEbqrAscuaib9qor6fc3TyuPU7h/nhBHZQZ2AN8bc3J5KGZ9/
 orucnh20hDBH3GvOPWE6zV55M3ACX43v2wZUURaFN3Ee7BJYpzrSE2sHDQEMpRuzFae2RoW+t
 EDWxRES9t2nkOpP3YIbNrrC4RJB6bcrONMVYQ8xJarHnJGgHVBUuH8axOeMBlcArs8CPlq9TX
 1dZK0AMqK0ll2b6hyVbKD1LnmPxhFi38IsQLiiCmKwoe25bZNceb+BMlv7QFzUU2sV/Ppi5+O
 lGr3N5CdYpFMZf+cNaJarhkCKEjR7AU7HKsqnu/dJVigW2alJbdJq+0YhCZUlMkbDVMrOxYz1
 kYTWjuThzrJ3KqxFEN2/Y+zkrDBH3yDxbdqPmM4kF5veKJx4DKgKVVQgvR2urCXEGnLeqM9o9
 gxtyO4v+icOQ8Sh9MINBXL322PGrlPpj5aSXYtygNr32H59gOgHSIB59hB

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
ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFu
IDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NSAtPiB2NgogIC0gbm8gY2hhbmdlcwoK
Q2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1
Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5
IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMg
djEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNzVjNzUxMWJmNDky
Li5jOGE1YjRkMTc0MDcgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9j
b3JlL3BrdGdlbi5jCkBAIC0xMTMwLDcgKzExMzAsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5f
aWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAkJaSArPSBsZW47CiAJCWlmICghdmFsdWUp
Ci0JCQlyZXR1cm4gbGVuOworCQkJcmV0dXJuIC1FSU5WQUw7CiAJCXBrdF9kZXYtPmRlbGF5ID0g
TlNFQ19QRVJfU0VDL3ZhbHVlOwogCQlpZiAoZGVidWcpCiAJCQlwcl9pbmZvKCJEZWxheSBzZXQg
YXQ6ICVsbHUgbnNcbiIsIHBrdF9kZXYtPmRlbGF5KTsKLS0gCjIuNDguMQoK

