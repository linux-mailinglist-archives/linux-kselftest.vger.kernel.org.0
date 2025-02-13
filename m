Return-Path: <linux-kselftest+bounces-26527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D81A33DB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B08E188DD1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70721D3C5;
	Thu, 13 Feb 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="muW3smP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5E221563;
	Thu, 13 Feb 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445574; cv=none; b=GHnEUsPdHCTxkMWMcAjiKQ+zGhSn5OUxF8MoJGv6qM1s8eg382pDofdLp1bkfPOfym1ZA8BbFRxwNpNSkWtw46qSdMtFZQSjIdn+3VooJu9DkjV5ikr16k842fo05+vDU9jd8frH0mtJz87CYM/9A7RUW5ewDmkAWC9vISGmfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445574; c=relaxed/simple;
	bh=WBHymyYl/xHTKiR/7M7BV3X9wuHtayASAmHXzsQJio8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6Q+mL6YQZ1U3wK4jJOa1iDmcX9euYEydsji5CQneztsTeXuSCwomPbIs3eSw3ANJMPsYzCTiRAMtwKWA+8RNNSCTipRvo1JhrTnOWkDF/jFLpu+pvuQ4L/aiEYwcm0sMnHPwqojlydCWvMWNvZ1z/O0M/IAatDxHB9vmyJx5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=muW3smP2; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445566; x=1740050366; i=ps.report@gmx.net;
	bh=WBHymyYl/xHTKiR/7M7BV3X9wuHtayASAmHXzsQJio8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=muW3smP2wC52cI58Eef3y3Dq2HwAwutq1HA4/IlrcQDFD37/DX7g3FcIl6hC8MCk
	 qxQmXrugQ7xnBVYR6Y+ZDQR6f9NXzs9ZS/tT6dOe6USbeLUpCMFD7W/UrNh760OT2
	 SAnoeIbK7300k8LGgNbwqtVKoU8cXdxzWYRY8a/6AciV3619c9Jzol7WP3MwADn+T
	 TRAWAkPYGvbK4T1r8oyC1Oge2pwB4E1dzGvRkhCwshZ0WcuskitqWsOcvUtT4HKDr
	 Kx3OoqkPPQ+GpRux2I5MkhQiaAksQCNFx7LB/h1wPlIncoAznyP7C1Zr5VAdnt2/b
	 p8PSoTGGGo0ab1Dr7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1t9TcD27lL-00fUvY; Thu, 13
 Feb 2025 12:19:26 +0100
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
Subject: [PATCH net-next v5 4/8] net: pktgen: fix mpls maximum labels list parsing
Date: Thu, 13 Feb 2025 12:19:16 +0100
Message-ID: <20250213111920.1439021-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:rZohbrT/94omkfb9gHvJ5Cq9DKJCfwJcYDXIx7VMMAnltyRH6r4
 OTA390AdBuOxf/hyAjmvIdUzdUz+iqNdE+X5P3asabSaF9O+AjHWXsLNfHuaJ6ftNBS8Q5w
 nZAdmoTAnsNlUM4rlpgOYPk2zV6HxbPB6oD2yzqdkKz0VP5B6z0yLhF0tAaRWS0Psy/OcJT
 ZPm5DJEenc5DFqLyCbcfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uErfn1VJ54A=;MAUGuRLocDEeyqtFHVM4hNyTIbM
 EtXsd8fp/4GRlLLqjEhjNGh1OJLr5/5DQg3laTPV2F5Nu84qxgFGnWV/Fw9NteSyIjpsq1Qm0
 ptrh/vxHmO31KpLJwP5tstX5DEAHmK93ARVXLCEh5LX1GZwp6ayCJP2owvRsVvEhpOpQEhIgD
 PwDYWYHY5BtKiyhJrHVj3iAZ4W86C38dh3U44cnvaZFnN5ymOYdcxdC9LCJj5UaxizQ5MTKm9
 iJC7vWeqYXDecQbSeVKUXPf9K/T1Z2Wh66X+2H51wt0xzNW0AskShVhPMhsdbWQ4NqRe7IFdh
 lQproClYpngMDtZSp8okrApyxYi/9IFWBWfPqr9aCXy+aZBPuvcs1zZ/wDyZm37Cthv+lldJE
 wWYtgE/D7tHAE4U1P1BcD8rI04+MvUYdEoCAmkcsPtg16iJYJCezlpWZcebdkeP/T9d/yS9Wd
 AenzyaUa0iDtmNMmc6/LDAqG2TB60zGMYadXj+MWZQKudvaE2FlWg2bWx2SBqVw9Dp/r8iumX
 J8SNhz2FEV8dYmTnMptO8kEzgDspywlaQtL1LAbYi9uh8wVUBQszVn+FnDSGpnIkUtg4BxqoS
 yg5jrLgr/2SJPQYyrPD+1LE7PGlduJV/zClBu5EJ9UssKO04iJbBSXlFTgv6FrxY0QUYB2g5o
 jZPIJRNOoxxMN4cu2EQP99bzATQaAd/tpKsmRGQgQfbhtmc8xOaUaCZTe/jN5t40cimziesZ8
 vUyah4bt8nF5AssPGMEGW/Zg/frAwqhh/ytLbsyrXIWhaujLHbcS/H3ywA7XUXi4iyh1slpJP
 oiPioXUc/cSg09HqWOrWHzf+mG2KC5nIY1iUKnTdlNVyS6jEBx1W9ddiTG7HCKNlZ/YYeeeFV
 /4rBB6Tz8zfoC3qtNCWDGYXFp7VEZd/UdxNvD7+SnglWFlWOCCDjN8p4rUivX15dFqXDGKQd0
 C0Oj9tDDebgkZNhfh9grLvsJVpAZIWE6Q2LHzaLGajc4TfIJuvOm9/uNoIyM5W46ylMWXQdRo
 rHpAwfhdPHdzKRwG5SYZ65cV9BXQcS+r9ZuOO5XHGJTbeNJlI7t4alBxlsPx/+fGY8iFiaZeV
 B03EXRYysYYcVr/tpZxoi5B876uB0+wB8JQi3/bzg8bnjPqqhX1mjtPqJDJmI1d23rNMFylk7
 7/NmdMOzIftU0XaM4JOp/YwVEsmP852Pfg2dV5EZD7mUC72CVDPa9ku8Vvwr5C0GXeApyRq+a
 2FIZlR2yNax7ezpUTeP6on1Z+O6GdICL6N4h0ay5Jw3Lwu/roim5X38oDneAtuGDKF/0bX/f2
 OmnA6SXNJwOksp3lo0ZXsVYnty+y/PDJyp+DGrWZSmXzbFDHEg4n4LpQep+oMLtOkEfSZ/Aw9
 fBAbxpbLUBl/ZEsH+n6PGMI0s42Mm5mKIGBKyzgW05dAGbzq7/q2CXS7lx

Rml4IG1wbHMgbWF4aW11bSBsYWJlbHMgbGlzdCBwYXJzaW5nIHVwIHRvIE1BWF9NUExTX0xBQkVM
Uy8xNiBlbnRyaWVzCihpbnN0ZWFkIG9mIHVwIHRvIE1BWF9NUExTX0xBQkVMUyAtIDEpLgoKQWRk
cmVzc2VzIHRoZSBmb2xsb3dpbmc6CgoJJCBlY2hvICJtcGxzIDAwMDAwZjAwLDAwMDAwZjAxLDAw
MDAwZjAyLDAwMDAwZjAzLDAwMDAwZjA0LDAwMDAwZjA1LDAwMDAwZjA2LDAwMDAwZjA3LDAwMDAw
ZjA4LDAwMDAwZjA5LDAwMDAwZjBhLDAwMDAwZjBiLDAwMDAwZjBjLDAwMDAwZjBkLDAwMDAwZjBl
LDAwMDAwZjBmIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCS1iYXNoOiBlY2hvOiB3cml0ZSBl
cnJvcjogQXJndW1lbnQgbGlzdCB0b28gbG9uZwoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVy
ZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAg
cGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCiAgLSBj
aGFuZ2UgcGF0Y2ggZGVzY3JpcHRpb24gKCdGaXhlczonIC0+ICdBZGRyZXNzZXMgdGhlIGZvbGxv
d2luZzonLAogICAgc3VnZ2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKCkNoYW5nZXMgdjMgLT4gdjQK
ICAtIG5ldyBwYXRjaCAoZmFjdG9yZWQgb3V0IG9mIHBhdGNoICduZXQ6IHBrdGdlbjogZml4IGFj
Y2VzcyBvdXRzaWRlIG9mIHVzZXIKICAgIGdpdmVuIGJ1ZmZlciBpbiBwa3RnZW5faWZfd3JpdGUo
KScpCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3Rn
ZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDQzNjA3NmEyY2NiNy4uOWI2M2ZlYjhhMzNl
IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpA
QCAtOTExLDYgKzkxMSwxMCBAQCBzdGF0aWMgc3NpemVfdCBnZXRfbGFiZWxzKGNvbnN0IGNoYXIg
X191c2VyICpidWZmZXIsIHN0cnVjdCBwa3RnZW5fZGV2ICpwa3RfZGV2KQogCXBrdF9kZXYtPm5y
X2xhYmVscyA9IDA7CiAJZG8gewogCQlfX3UzMiB0bXA7CisKKwkJaWYgKG4gPj0gTUFYX01QTFNf
TEFCRUxTKQorCQkJcmV0dXJuIC1FMkJJRzsKKwogCQlsZW4gPSBoZXgzMl9hcmcoJmJ1ZmZlcltp
XSwgSEVYXzhfRElHSVRTLCAmdG1wKTsKIAkJaWYgKGxlbiA8PSAwKQogCQkJcmV0dXJuIGxlbjsK
QEAgLTkyMiw4ICs5MjYsNiBAQCBzdGF0aWMgc3NpemVfdCBnZXRfbGFiZWxzKGNvbnN0IGNoYXIg
X191c2VyICpidWZmZXIsIHN0cnVjdCBwa3RnZW5fZGV2ICpwa3RfZGV2KQogCQkJcmV0dXJuIC1F
RkFVTFQ7CiAJCWkrKzsKIAkJbisrOwotCQlpZiAobiA+PSBNQVhfTVBMU19MQUJFTFMpCi0JCQly
ZXR1cm4gLUUyQklHOwogCX0gd2hpbGUgKGMgPT0gJywnKTsKIAogCXBrdF9kZXYtPm5yX2xhYmVs
cyA9IG47Ci0tIAoyLjQ4LjEKCg==

