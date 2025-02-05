Return-Path: <linux-kselftest+bounces-25840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A9A28B63
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39361681E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B45189F39;
	Wed,  5 Feb 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="DUOtE6u2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6115B122;
	Wed,  5 Feb 2025 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761133; cv=none; b=c/wTYKMx2Qf+q0u5jft5QxyXEsfcNOg98cnTdPOZmAbfeM5uaavU1BI32mBYILJeiYSxvsrhLbX9XqAf5qEUb7b6vQ67zj55FPHFPs9T0H0CWyDsFM7XO5OkBwZjcUyfpQM+f66QcEOLD68zs5CMmu3rMZw9Rl2EzKLy/V9WVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761133; c=relaxed/simple;
	bh=QRwX8UjSSKOhh5loLuyOOAnKngYgFCevybSUDASN4RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvTFWCcmmzmQmnfRWj0I/HDblyqTvsqMD99IZ/PRCmqVCVexJ4wujWaJZ1cfxZeqzrbZzN5gl/3p63AG1TDKKd5kX2r+5Ng1N9WFmWXTXbdKzSPWmIEdUuF8J0MB5EKBZKbVnFJ4Q0MyNh6EfeIaxbFl6DQ1kNIEs1F+N3lzjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=DUOtE6u2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761123; x=1739365923; i=ps.report@gmx.net;
	bh=QRwX8UjSSKOhh5loLuyOOAnKngYgFCevybSUDASN4RQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DUOtE6u21qmEr6DBDQv+klhR05btMZH/kZqfevF9VwVjsGn5jR7Dqj3fVhVsS5+R
	 RtNBxiqEU9ZvqhSnpBEJFNUvTZ2qplJHLWIdHrM+HSpqCKOGy7RlD2aTUhiFPZjSd
	 KihJnbtYiY8fQQRpUnn3lqxHIG0GbXkT1CBsL2ea+cJ6YoMwZKv1xMYj5iZRJsJdZ
	 6BaC7yaXQipxmnVmkvHR/A4TM/mmZ/eqifCh0CbyRVhpP13rTlP6fEuDjDU+ZkvUn
	 ttBgjFHt/zhZvzhz+UZKsJAhPjMYKvMsd/q+vkbXPVBbb40s0VzzPhBa9taMVLcPe
	 DeIvmnKvhKEvUsEBiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1tAT323JtC-00bBwG; Wed, 05
 Feb 2025 14:12:02 +0100
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
Subject: [PATCH net-next v4 07/17] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Wed,  5 Feb 2025 14:11:43 +0100
Message-ID: <20250205131153.476278-8-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:JpSFC3SX8/B8znaFp2o/iiUO/VkLN/DLJGqegSytyxONeqDDwpn
 eavPbTWoBz1LlCP9CXQrO20iIl5RLIyOKPg6WX2zDiw5fSzLv4ZnXetdIjM6twDLtYAXXU3
 yjiLOu2Kzw0fVDGN/ekzEp1EPvXharE9QTrwRjkt8/9AablIv50IM4DfMJj6KErBVUocMw4
 xYBoGKWHovneIHjSq2LVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xTifI/nrPBk=;UDz2fA7k86ngKEtw4RbxyMjtrI3
 5luWsZ1TjGZxBj+VlMAgwiA/Qg6WC84Ta4N9OAbmdTQOfKhc4HVgl+j/NV/M744s1bzq9cbI1
 QM7PMiNRbfpnqDaMWxRvIoPBg8H+Pdv8179+7U1LLDz0q+ynzsGFsEZGaLCkpgEpX0LzGx7cr
 Aq8/agPICCo8KtVYL5uPaFM8lpLUdXb+0PEK5u0IPz7ActGGZwf6epcIPJhzH2Ow55g3V5VMr
 cdN1XqAszN4mlYfnGliObY65yF+8qCOHhPp9Yu8zzU5E2yy8so1n0IPUBpXLT62z+qmg4Ou9Z
 P1wSMcKZc+BG/wLWJe9wlDFtwQBgEGxOnfUHipRNz+MQC0l35IAmbajav6wCqtJksa2/HuV4u
 qZ2I5ogopyxotpCkYeLaziLOY/8VeOlCRNYnLkfxCytENmln/UqxXd38m+zx7XZhs6II/CLOv
 ZVX7EUt9k0MeX45RAOhFb36wKowAKO6aRODBpQYQNAi10WdkIVRL4fqulRJJcyeMOghIIvYBa
 +Ws1l3n4ZRexOp3sjFft4zWlscMeqQ/nf/QC/extc/Lw2Mlrl4PKrL8amCQ07qmtKtO98uYSz
 n5B0NTs/NKyEyjgVkjB3pXM3ZSSWFlP2xWHiTTo8ggICar9Cl0EvvddFMG/gvKKYvWiB/jHf3
 XdKeGgRoBimO5qwSeFiyKEfO6T4a/WI3yg4yfAzQmWdfL/cwS8cYG/7A6EIT+7fL1m+C2gp8k
 rAcCNzrMZwSDz0DJMQo7TZvVzNfV6WxtAj2GgMztdN0dnRz4drw69B3XALDCuZeUf5z9Gs2Ze
 9Teq9Wn9c6OCYuO0DotSZIvEqnA6VFPdv7yITG0/NJZQRIQq7ED9XEnRkCqRIqHbbv+1816aF
 73QtKIWs8Lk4s9m6wYSvSV2lOJUASSIOURqx9CKO6sS88ICoqjeoRHAqjOt6TFqF01UusXmSC
 /3EmXy2v5D1Nau4dAuNoQQ78rfCCDHg/se5WyhPqCncLbqJyLzBf2lhji6gfNvJ7rrSoRytnL
 7ierGsxEAc6ovyFP4qJptqjcqO4DKHQZXESptx2ry9rUe7WJmSWKLoJG4m7nIEiPHfg1uDnQc
 CCRbnyyTyKco+BAfRa1fbJdm6H1zXw4yVQ6k7EdrTSNxyp1kVEf2AstR5uPcf37TQ2CrZ6VVv
 RQg7S7bxPQvSVEHC0m0KNYNVbvrd2dqiIfn033CUSCOtVfVUMbuTgjeI1R+lIoXTYY/lod6yQ
 PBEZP+w9MkFo24/4CYFiFttTPhlGJkegCP2kc6uCJF44ib9sonvrVI24DrC6OSs3s7cGyF4BG
 /x+ktcPz/esctENHyKY3IpPmM+l/iC2wbwA2NkMbgdHoEc=

SG9ub3VyIHRoZSB1c2VyIGdpdmVuIGJ1ZmZlciBzaXplIGZvciB0aGUgc3Rybl9sZW4oKSBjYWxs
cyAob3RoZXJ3aXNlCnN0cm5fbGVuKCkgd2lsbCBhY2Nlc3MgbWVtb3J5IG91dHNpZGUgb2YgdGhl
IHVzZXIgZ2l2ZW4gYnVmZmVyKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9y
Zz4KLS0tCkNoYW5nZXMgdjMgLT4gdjQKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFu
Z2VzIHYyIC0+IHYzOgogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MjoKICAtIG5vIGNo
YW5nZXMKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9w
a3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IGY2ZTM1YmEwMzVjNy4uNTUwNjQ3MTMy
MjNlIDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4u
YwpAQCAtMTkwMCw4ICsxOTAwLDggQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX3RocmVhZF93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAlpID0gbGVuOwogCiAJLyogUmVhZCB2YXJpYWJsZSBuYW1l
ICovCi0KLQlsZW4gPSBzdHJuX2xlbigmdXNlcl9idWZmZXJbaV0sIHNpemVvZihuYW1lKSAtIDEp
OworCW1heCA9IG1pbihzaXplb2YobmFtZSkgLSAxLCBjb3VudCAtIGkpOworCWxlbiA9IHN0cm5f
bGVuKCZ1c2VyX2J1ZmZlcltpXSwgbWF4KTsKIAlpZiAobGVuIDwgMCkKIAkJcmV0dXJuIGxlbjsK
IApAQCAtMTkzMSw3ICsxOTMxLDggQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX3RocmVhZF93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAlpZiAoIXN0cmNtcChuYW1lLCAiYWRkX2RldmljZSIpKSB7
CiAJCWNoYXIgZlszMl07CiAJCW1lbXNldChmLCAwLCAzMik7Ci0JCWxlbiA9IHN0cm5fbGVuKCZ1
c2VyX2J1ZmZlcltpXSwgc2l6ZW9mKGYpIC0gMSk7CisJCW1heCA9IG1pbihzaXplb2YoZikgLSAx
LCBjb3VudCAtIGkpOworCQlsZW4gPSBzdHJuX2xlbigmdXNlcl9idWZmZXJbaV0sIG1heCk7CiAJ
CWlmIChsZW4gPCAwKSB7CiAJCQlyZXQgPSBsZW47CiAJCQlnb3RvIG91dDsKLS0gCjIuNDguMQoK

