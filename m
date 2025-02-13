Return-Path: <linux-kselftest+bounces-26529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FBEA33DBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE225188D659
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8B21D3EF;
	Thu, 13 Feb 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="li2AQ3Ln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F921D3E8;
	Thu, 13 Feb 2025 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445581; cv=none; b=EfW3vj2pLAqx3L5D+G8ewwU25sCVI4NU6nelBkl18KeEArhb6V2B8I1bzZUNOcnw9Kb+PF21cF5QT3A9Cozo4XAY/+YuDYvFMpx3VrjfDsetp2TmVkhUqpTzl1nzDC2tsTmyOc10R/j/UVGw6glPQteotaaBvuFmlCzbUwe3bSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445581; c=relaxed/simple;
	bh=PPRujci8tehuD+R56FULZVH8pZlNtu9IzdM/CxcRGws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIMLZ0pjfW753oDOONRHpyo+my+XT5Pxn1wa/lF4jM5ZH1N1YwHH4W9+AoFxotmNhva0y57YlhgNmMuHQt1NrG+JM0zL3mTgN8Th4dt2qsEnC9SD9uhuOLHs5QqBZIMwIAIOH6SC8UGtoGdo7YopMY7owap+BqtiRfwkk7cjU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=li2AQ3Ln; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445565; x=1740050365; i=ps.report@gmx.net;
	bh=PPRujci8tehuD+R56FULZVH8pZlNtu9IzdM/CxcRGws=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=li2AQ3Lnu2K2BqEupAnNIjYnHIF15uOWvTCWqBHeSCiO8ehQwpq7G2AlQAD4+xy+
	 kdahvmiN1OOwvcrXu3C5hMX/qOiRJt51ST4tKX4Bc/1JiAVj4q25vn99GfOjP36N3
	 cQ0Nj8eyJXwI+vjUMaIZMFDGU3uHyARhDP7ikwfWDQKO2rBrScrOM6PtdSwmXc8s5
	 5/b3KhBYOl5LpREZUpU8XNX15BxEufK9rlPYmoMAO9kQrxrLWi/LIl8/V4KCqCfTg
	 krWtNqxHP8bbohIfSgPwEEsuzRRAiOT//yFiZ+/1gTDL23JTH6vwu2RvQ3Ffz8z5s
	 oApVVMtHgn0dDUu+zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mBa-1tEfcP16aa-016c3T; Thu, 13
 Feb 2025 12:19:25 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 1/8] net: pktgen: fix mix of int/long
Date: Thu, 13 Feb 2025 12:19:13 +0100
Message-ID: <20250213111920.1439021-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213111920.1439021-1-ps.report@gmx.net>
References: <20250213111920.1439021-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:VaU+mn2E25mkSpJg8l+UeQBYipo3hq2Fw+UVGOWrdklO1R8Dett
 SLHWuHFLoQgPUv0MXY/3dPOVJUI+7pAQ2HWI2NNMgK1G7KtQ+pHtt8g4LbtuqpjW86Yyigm
 j00BnwDf8K+70pZbmIk42AHKkIX1bTY8UIybDbWfufNJ0vLk6DKJxeq1AiSsbCkzhk6YF10
 OYK1QpnBhnVX1ykAigJiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P0ApSs0MSjQ=;uCOnJJF/QvqPlD+n39NoqMXmVLS
 eM5EWb0Ud6xyEV3W8w/grya8xA9V41C45L4wdxBJCT2CuB1AylAxQED28stme8xWHu6Mm0kmG
 OpibkqglQPf01Ogn6u/hZq/XCKb1NHLIYsRFGuD0U0Hiwtw3xuFfXzVFw0ZVb6d2JpAUixNN6
 NnW4c7KLEErKDy0uz+nbU5cxOu6toJpTPs+TnDFf+XudgboDGPkPB7B/mjYBxOsPh5FgZQZSJ
 fF7JX4+pJQBUHgAl7J09Yis1ubqLHWazN6MJfHoysovULwxOE64TPJd+NDSqx2BlAYHvAGkDD
 1jezLWMAFsNQjjFcsYvDUTmK0ukU2MA6Y6s/i7bc83Sal8DnDzPWRU50IjNe8R7BEcreo8yKL
 FzmvAJJ47rM6vKfTrMDdLsjpZDp4mLC539eRLNYsfVGeMDWj07GhU1FSBVdQGfAZR0gsmhHcd
 1mK0lNeMm8bkVPJqM6irDjQNbeWiI6LvxECQUHusEf/FGX5QThWRKGEKPupkdnGfVtz+v0yTh
 yUixr8IIwn/H+7d97p6SluJKrbMuv92oJkyXltU7Hf4+QQbyl0zobqldJ3QQQkwgcqWQVeWsE
 6XsS5bypImJg+628k9D/hILPVQBVRMCh22DW4ttu+Dfft7vQiycEb/jfbfjHnPauBZj5ys+Z1
 7Qci0wxw3FNSVF14/jjihXgiii345SWM3gMhIyoM5HtBOlUuNWHGKtKEabn4iE56M+CtCdr36
 QNGmvgIFZuU7UBvgEmvlgasOh67X59Poskvr1AnWEl+E/NtoWtHHsRhpJWIhzbJogtJe8Iwdt
 GX1yYpAAN/tFm/hPU2c7WlOIKqML7bOESsuGKoRbFQtyuVCYwoSOaGxEtkODOWM6JcPY3yhv6
 pCzyfPaAPKr9os/FrsRG1DPw0xaZKbbpL9u2ZXP9U4ruoPC1+/QBnFaJankEpUUkYnXH/lP+7
 9DrcwdNzs3ISz5Plks3KqPIhP6kKnyc9E65OgW5ECMhgrrZ0rjHmteX34Mx0v5gV2HLlJvtvD
 obdruaQsgxkhmBy4fGPArauSXJOey3mIViIAVJohcUvMvC+uyHBh+bQkxmW1FVRUfpqW2Fnsj
 UstRLggHIsyVj/Fh9aHwDXqVSCKYWgHCt7xEz8MiyMP6Lcy53cmSaQtVbJmDixsP9rMYCrFCi
 xdRL5gkGqMaJnaB4A5qcC05pvM7V78KS68SU2dEjL48YPBad0zZ42qFFKvViRT7Y6naMjcBy8
 RuhECNp2BEbGRPjGPUvyuS0MM+VPaFodHtDY/8bsyXQInZg8Upf8B3Rbf1X/lO+9/Nn/Mw7/H
 An6mVSRfgHmbrv74iX2FMR8pAeuxfpYVQ0XmECTbxu3A9GL0S1aOveqb7GiZgDlQ3tsFwDxcG
 mx2FPFWRzS3zqEhMdiyY5/GYqcNXmKr7is5DZkPtrdzeZHdP7nuMLoC9kw

Rml4IG1peCBvZiBpbnQvbG9uZyAoYW5kIG11bHRpcGxlIGNvbnZlcnNpb24gZnJvbS90bykgYnkg
dXNpbmcgY29uc2VxdWVudGx5CnNpemVfdCBmb3IgaSBhbmQgbWF4IGFuZCBzc2l6ZV90IGZvciBs
ZW4gYW5kIGFkanVzdCBmdW5jdGlvbiBzaWduYXR1cmVzCm9mIGhleDMyX2FyZygpLCBjb3VudF90
cmFpbF9jaGFycygpLCBudW1fYXJnKCkgYW5kIHN0cm5fbGVuKCkgYWNjb3JkaW5nbHkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQpDaGFuZ2Vz
IHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVk
IGJ5IFNpbW9uIEhvcm1hbikKICAtIGluc3RlYWQgb2YgYWxpZ24gdG8gbW9zdCBjb21tb24gcGF0
dGVybiAoaW50KSBhZGp1c3QgYWxsIHVzYWdlcyB0bwogICAgc2l6ZV90IGZvciBpIGFuZCBtYXgg
YW5kIHNzaXplX3QgZm9yIGxlbiBhbmQgYWRqdXN0IGZ1bmN0aW9uIHNpZ25hdHVyZXMKICAgIG9m
IGhleDMyX2FyZygpLCBjb3VudF90cmFpbF9jaGFycygpLCBudW1fYXJnKCkgYW5kIHN0cm5fbGVu
KCkgYWNjb3JkaW5nbHkKICAtIHJlc3BlY3QgcmV2ZXJzZSB4bWFzIHRyZWUgb3JkZXIgZm9yIGxv
Y2FsIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyAod2hlcmUKICAgIHBvc3NpYmxlIHdpdGhvdXQgdG9v
IG11Y2ggY29kZSBjaHVybikKICAtIHVwZGF0ZSBzdWJqZWN0IGxpbmUgYW5kIHBhdGNoIGRlc2Ny
aXB0aW9uCiAgLSBmaXggY2hlY2twYXRjaCB3YXJuaW5nICciZm9vICogYmFyIiBzaG91bGQgYmUg
ImZvbyAqYmFyIicgZm9yCiAgICBjb3VudF90cmFpbF9jaGFycygpIGFuZCBzdHJuX2xlbigpCgpD
aGFuZ2VzIHYzIC0+IHY0CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0
OiBwa3RnZW46IGZpeCBhY2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4g
cGt0Z2VuX2lmX3dyaXRlKCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgMzcgKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIv
bmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNGYyMDFhMmRiMmRjLi4zNmVlMDQyMmM2Y2MgMTAwNjQ0
Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC03NTUs
MTAgKzc1NSwxMSBAQCBzdGF0aWMgaW50IHBrdGdlbl9pZl9zaG93KHN0cnVjdCBzZXFfZmlsZSAq
c2VxLCB2b2lkICp2KQogfQogCiAKLXN0YXRpYyBpbnQgaGV4MzJfYXJnKGNvbnN0IGNoYXIgX191
c2VyICp1c2VyX2J1ZmZlciwgdW5zaWduZWQgbG9uZyBtYXhsZW4sCi0JCSAgICAgX191MzIgKm51
bSkKK3N0YXRpYyBzc2l6ZV90IGhleDMyX2FyZyhjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWZm
ZXIsIHNpemVfdCBtYXhsZW4sCisJCQkgX191MzIgKm51bSkKIHsKLQlpbnQgaSA9IDA7CisJc2l6
ZV90IGkgPSAwOworCiAJKm51bSA9IDA7CiAKIAlmb3IgKDsgaSA8IG1heGxlbjsgaSsrKSB7CkBA
IC03NzcsMTAgKzc3OCwxMCBAQCBzdGF0aWMgaW50IGhleDMyX2FyZyhjb25zdCBjaGFyIF9fdXNl
ciAqdXNlcl9idWZmZXIsIHVuc2lnbmVkIGxvbmcgbWF4bGVuLAogCXJldHVybiBpOwogfQogCi1z
dGF0aWMgaW50IGNvdW50X3RyYWlsX2NoYXJzKGNvbnN0IGNoYXIgX191c2VyICogdXNlcl9idWZm
ZXIsCi0JCQkgICAgIHVuc2lnbmVkIGludCBtYXhsZW4pCitzdGF0aWMgc3NpemVfdCBjb3VudF90
cmFpbF9jaGFycyhjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWZmZXIsCisJCQkJIHNpemVfdCBt
YXhsZW4pCiB7Ci0JaW50IGk7CisJc2l6ZV90IGk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgbWF4bGVu
OyBpKyspIHsKIAkJY2hhciBjOwpAQCAtODAyLDEwICs4MDMsMTAgQEAgc3RhdGljIGludCBjb3Vu
dF90cmFpbF9jaGFycyhjb25zdCBjaGFyIF9fdXNlciAqIHVzZXJfYnVmZmVyLAogCXJldHVybiBp
OwogfQogCi1zdGF0aWMgbG9uZyBudW1fYXJnKGNvbnN0IGNoYXIgX191c2VyICp1c2VyX2J1ZmZl
ciwgdW5zaWduZWQgbG9uZyBtYXhsZW4sCi0JCQkJdW5zaWduZWQgbG9uZyAqbnVtKQorc3RhdGlj
IHNzaXplX3QgbnVtX2FyZyhjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWZmZXIsIHNpemVfdCBt
YXhsZW4sCisJCSAgICAgICB1bnNpZ25lZCBsb25nICpudW0pCiB7Ci0JaW50IGk7CisJc2l6ZV90
IGk7CiAJKm51bSA9IDA7CiAKIAlmb3IgKGkgPSAwOyBpIDwgbWF4bGVuOyBpKyspIHsKQEAgLTgy
MSw5ICs4MjIsOSBAQCBzdGF0aWMgbG9uZyBudW1fYXJnKGNvbnN0IGNoYXIgX191c2VyICp1c2Vy
X2J1ZmZlciwgdW5zaWduZWQgbG9uZyBtYXhsZW4sCiAJcmV0dXJuIGk7CiB9CiAKLXN0YXRpYyBp
bnQgc3Rybl9sZW4oY29uc3QgY2hhciBfX3VzZXIgKiB1c2VyX2J1ZmZlciwgdW5zaWduZWQgaW50
IG1heGxlbikKK3N0YXRpYyBzc2l6ZV90IHN0cm5fbGVuKGNvbnN0IGNoYXIgX191c2VyICp1c2Vy
X2J1ZmZlciwgc2l6ZV90IG1heGxlbikKIHsKLQlpbnQgaTsKKwlzaXplX3QgaTsKIAogCWZvciAo
aSA9IDA7IGkgPCBtYXhsZW47IGkrKykgewogCQljaGFyIGM7CkBAIC04NTMsOCArODU0LDggQEAg
c3RhdGljIGludCBzdHJuX2xlbihjb25zdCBjaGFyIF9fdXNlciAqIHVzZXJfYnVmZmVyLCB1bnNp
Z25lZCBpbnQgbWF4bGVuKQogc3RhdGljIHNzaXplX3QgZ2V0X2ltaXhfZW50cmllcyhjb25zdCBj
aGFyIF9fdXNlciAqYnVmZmVyLAogCQkJCXN0cnVjdCBwa3RnZW5fZGV2ICpwa3RfZGV2KQogewot
CWludCBpID0gMDsKLQlsb25nIGxlbjsKKwlzaXplX3QgaSA9IDA7CisJc3NpemVfdCBsZW47CiAJ
Y2hhciBjOwogCiAJcGt0X2Rldi0+bl9pbWl4X2VudHJpZXMgPSAwOwpAQCAtOTAzLDkgKzkwNCw5
IEBAIHN0YXRpYyBzc2l6ZV90IGdldF9pbWl4X2VudHJpZXMoY29uc3QgY2hhciBfX3VzZXIgKmJ1
ZmZlciwKIHN0YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZl
ciwgc3RydWN0IHBrdGdlbl9kZXYgKnBrdF9kZXYpCiB7CiAJdW5zaWduZWQgaW50IG4gPSAwOwor
CXNpemVfdCBpID0gMDsKKwlzc2l6ZV90IGxlbjsKIAljaGFyIGM7Ci0Jc3NpemVfdCBpID0gMDsK
LQlpbnQgbGVuOwogCiAJcGt0X2Rldi0+bnJfbGFiZWxzID0gMDsKIAlkbyB7CkBAIC05NjQsNyAr
OTY1LDggQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LAogewogCXN0cnVjdCBzZXFfZmlsZSAqc2VxID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwogCXN0cnVj
dCBwa3RnZW5fZGV2ICpwa3RfZGV2ID0gc2VxLT5wcml2YXRlOwotCWludCBpLCBtYXgsIGxlbjsK
KwlzaXplX3QgaSwgbWF4OworCXNzaXplX3QgbGVuOwogCWNoYXIgbmFtZVsxNl0sIHZhbHN0clsz
Ml07CiAJdW5zaWduZWQgbG9uZyB2YWx1ZSA9IDA7CiAJY2hhciAqcGdfcmVzdWx0ID0gTlVMTDsK
QEAgLTE4OTEsNyArMTg5Myw4IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl90aHJlYWRfd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsCiB7CiAJc3RydWN0IHNlcV9maWxlICpzZXEgPSBmaWxlLT5wcml2
YXRlX2RhdGE7CiAJc3RydWN0IHBrdGdlbl90aHJlYWQgKnQgPSBzZXEtPnByaXZhdGU7Ci0JaW50
IGksIG1heCwgbGVuLCByZXQ7CisJc2l6ZV90IGksIG1heDsKKwlzc2l6ZV90IGxlbiwgcmV0Owog
CWNoYXIgbmFtZVs0MF07CiAJY2hhciAqcGdfcmVzdWx0OwogCi0tIAoyLjQ4LjEKCg==

