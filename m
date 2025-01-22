Return-Path: <linux-kselftest+bounces-24942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C757A1943D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4902716BEAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DB214A89;
	Wed, 22 Jan 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="AY8kJAGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340E214805;
	Wed, 22 Jan 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556904; cv=none; b=ltx2qisKxOmBtG4a1abtSikLpHymh8IEvUGjO+MNKvYxS1UNm95IFIC+ZBPT8DJrphtm+XOEtZsbqrdNCWF8niy6a+9ldhb9Rt/XCWogkds4AV4Q0bkiOt0ckp1BfDdpQ2pcKuTnDN/feyR0wMTTUyp8VK5v60ETPnZlsjB0+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556904; c=relaxed/simple;
	bh=lUzNxOeGI0LuccPLT80V3d8mFbkoLYfx1I9UgEERrPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtDaSyMPPOQMvIbOSB27D0m3ztRKcfp3rNJ+bGs576FpvHBNps1pX1DwHNUO0jYdks21X4LREjsUAG4+/Ne/R5OFhM/dz+356ZCmhWNXB1pwiy4vfpI0xhRiht2tX5TkYyN94MlB+DFR2PNzEWgKBHrXatd4ttSIns+n0z7Er48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=AY8kJAGw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556887; x=1738161687; i=ps.report@gmx.net;
	bh=lUzNxOeGI0LuccPLT80V3d8mFbkoLYfx1I9UgEERrPY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AY8kJAGw0g72kwm7t9PAq7wJwzM6pvAHh1rAnzi4MavoUnfYaqywX1WtdsJFJDON
	 Gbq7g9KmjIfwLp/2DByRiqfVrN9SlBDFg1qdz/U17K6aZVLqQBJxFoOu+U3qaz91u
	 uiuoWA8C3xias5lqItvdv20777YoexH6wN056g8H80/Pufem5KiZ0xds0SnH778Jo
	 jsdepKpOTsbRylS1h/WDGZQ8bxOqnLulXrejHnKXj8hflZbM52isL4Nrvj952bphf
	 AL0oOvzwgdlD5rLvh+JlJRhQnlbi76ukIMip5dtdOWSe/1W308rwoIv8hBHWHIgSG
	 SqIP3/bzIp6peNOl0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1tt6fq2QKL-00WwbV; Wed, 22
 Jan 2025 15:41:27 +0100
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
Subject: [PATCH net-next v2 1/8] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 22 Jan 2025 15:41:03 +0100
Message-ID: <20250122144110.619989-2-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:nLWXdbhIuNeJfjk1QrJ3BJLUr8VKVD2O924VQHvWNSy7BB7Dl2L
 67cEhD1+nRmK/hYCnmk6sZ8O+d0Exx+WDBgfxVErDU6vZcMlTRMfwyjAMUFI102C+Ds+zCW
 d5NASfVTBt/tw53Ayz9VNN8Z+UbRaGKC2edHkPGN7jWN3aWMT2YPjzvlCj9cUOV5wgxA1rv
 eRUyEEJ5CO2XmYEZhtexA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NAfkfSU8IN0=;6tIJuGhJguqVl1CeLWYQ+7xr/Y9
 OBE+qkDy9egaa79Qq+HNybT6Gs6n+ABOVkKsXnATBx0XfE7R6t88ICWhvp0+C+Uvr82MDI0Z3
 VUuAt6RfnhgyKStGhG60XqmSQZW8pJLp82GSYEMhnkY+qLgLrNWGH1o9o66GNfH827sMVS2Tc
 j1SLFUtgfDBPsT2aUZyETCGqjCL0O/01Nuy8yH2cSsmml3JLuUHWs4AaT6noEYlYmK4W0qxZ/
 rowMFuG1Xpe+3+Sz2v7Ku1uiEJW5+V0OyGHAB0hRokm5NyfbpDkRHa21aiF1Qzv8Aun0e4LsH
 ACBEvgccwit12jNpnebgEibpfy4VHeF6Hi3PEyNS1LvWX9sW9TjnY6/vzLgK99j/oKy01JLr4
 PS0v97n/E3DuP0vZE2w7QV/kwswLs0peINcYXCucGlkSVnTODPd8LOIJ7i7fbw8G1YYOj7XnJ
 2dcM4Z4TDh4m3cnpbbl30Exa1IJvSW6pr/1uaQO1HlZEzkJIrWA+r3xPXJgrJSUkBgWkg/AG+
 zBgtPR3BfSXSDUK7ujciOV0QNMlQo2bQFeQaTDSVZIm3mNQBdcWtoRpMPWEZayw+q3LugIkGg
 /gfFkmU2fbteMETwHmXWaOmm2O9iYkLCKAww8K4Cu5or5inEJv1C8WxjCHlZgJ5tmimv7l4QT
 4Nih3GTXvKJRWv0txj7VsooPdC2Gj72ieI45nuB8+CvErw0yXuwwdcmdNq/4TCnED+XQD5k/4
 Wh/wq5vX1D+PnjQ0kblMCJVvmvdeIrMHVRbtys0JGobTxN8voASEsgE16mUSSfqFCJ6UwSAHa
 FTrx6FfpdG4k/ENlAJB8WRj8YL1lzcJzqWAIVJ1izc5uPsU0dx1yoJNWfZgW+Z4oxLD/PSy5W
 7n+udGmKqCdZvNI7HL4ocmLU7xQjHHH7x8uJ4rsIORyCEmMjkijNF7AwyvQcynJ6KFlMob6RS
 b9wgtSq0ZqEOEcyJ7XhP8uxujTfR2kRjAVKr9YsKr55gkFYZlEh47v6LIynCajh9xXFMvFKzd
 HyILoixSPa1Za4PRTj1ZgXSYpuxa+liJp2nHHRVLtjehEqOSnfDX/4WrjheWE7f1kkBRS7IYG
 nxRKGdoGmDthLRGGwVLWlbof0/qY9W+NezQvzYJrgoEVWUI8c+uREjUR18K3hyQ4HsDodCLUb
 SJFrTa13KukySbnaZKW4/RKLCvmFiPSSXemUU8/3HvA==

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hh
bmdlcyB2MSAtPiB2MgogIC0gbm8gY2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNiAr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA4
MmI2YTJjM2MxNDEuLjQ5NmFhMTY3NzNlNyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMK
KysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTExOTgsNyArMTE5OCw3IEBAIHN0YXRpYyBzc2l6
ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKCh2YWx1ZSA+IDAp
ICYmCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBNX05FVElGX1JFQ0VJVkUpIHx8CiAJ
CSAgICAgIShwa3RfZGV2LT5vZGV2LT5wcml2X2ZsYWdzICYgSUZGX1RYX1NLQl9TSEFSSU5HKSkp
Ci0JCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJcmV0dXJuIC1FT1BOT1RTVVBQOwogCQlpZiAodmFs
dWUgPiAwICYmIChwa3RfZGV2LT5uX2ltaXhfZW50cmllcyA+IDAgfHwKIAkJCQkgICEocGt0X2Rl
di0+ZmxhZ3MgJiBGX1NIQVJFRCkpKQogCQkJcmV0dXJuIC1FSU5WQUw7CkBAIC0xMjU4LDcgKzEy
NTgsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUs
CiAJCSAgICAoKHBrdF9kZXYtPnhtaXRfbW9kZSA9PSBNX1FVRVVFX1hNSVQpIHx8CiAJCSAgICAg
KChwa3RfZGV2LT54bWl0X21vZGUgPT0gTV9TVEFSVF9YTUlUKSAmJgogCQkgICAgICghKHBrdF9k
ZXYtPm9kZXYtPnByaXZfZmxhZ3MgJiBJRkZfVFhfU0tCX1NIQVJJTkcpKSkpKQotCQkJcmV0dXJu
IC1FTk9UU1VQUDsKKwkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCQlpZiAodmFsdWUgPiAxICYm
ICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpCiAJCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTEz
MDMsNyArMTMwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmls
ZSAqZmlsZSwKIAkJfSBlbHNlIGlmIChzdHJjbXAoZiwgIm5ldGlmX3JlY2VpdmUiKSA9PSAwKSB7
CiAJCQkvKiBjbG9uZV9za2Igc2V0IGVhcmxpZXIsIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBtb2Rl
ICovCiAJCQlpZiAocGt0X2Rldi0+Y2xvbmVfc2tiID4gMCkKLQkJCQlyZXR1cm4gLUVOT1RTVVBQ
OworCQkJCXJldHVybiAtRU9QTk9UU1VQUDsKIAogCQkJcGt0X2Rldi0+eG1pdF9tb2RlID0gTV9O
RVRJRl9SRUNFSVZFOwogCi0tIAoyLjQ4LjEKCg==

