Return-Path: <linux-kselftest+bounces-25579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B39A260BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D9E7A0550
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFB20CCEB;
	Mon,  3 Feb 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="KiPdGMOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF020B7FE;
	Mon,  3 Feb 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602155; cv=none; b=nhmd8sn8QZkMBD+fNls484O3JvZlfudknQeb3fWoBo/Bk8mUNKj+X8jq49/tv9mBSxGuHJmwZ6GBp+FFbyyUjzam+xw3DT6rvr7qFWd72R/RkkaJsHj7U/f7FFdk1Pwww3ry582LyN41rFv1hMiN+RZb5I2kg3vepjwwkgSMeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602155; c=relaxed/simple;
	bh=32+59aZbJd8IOqTe+dLYeCFxvL3Tk0xzDu5MRFtgWYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blT8JGnLYpgW10yB4VQF2haWrW95dbSoERmgyBJfe9SjnQWNq5PcfS1ZmgQ05ngedCIqUeHwhLwodfxpEdUArOjiqgeZwKXZnCtW2dOCAIgeWnEG55e/Ew8AKm9oPmPf6w40B9dymcCy/GBsa0BP72FnXoX5FYBwBnNC+CkmK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=KiPdGMOr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602148; x=1739206948; i=ps.report@gmx.net;
	bh=32+59aZbJd8IOqTe+dLYeCFxvL3Tk0xzDu5MRFtgWYY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KiPdGMOr1ieu6sYifUvQPMlZ6hKWHAqK86+Yt5V5pRSkDNmOPAvkSBPSd6VQqhC8
	 FcM/lcBC7S1TlOzFuB3Z6fRaBuk41+9V817z2nUUyN+8pbh3wQB37nyCsgqVuJpdQ
	 Dei4OuoGJAWVbCIK9TKjWVPI1WrR4Kcfy9sKhIXF9Ctn9eEFTrm/hX00AImz/FVh7
	 j2zrqgYxcWF7m7+7tt1hJ9ii9JAYJGrzkw7oitT8qMvjMK4Dj05DM3KROOnk2h+a8
	 2339XKhgikwUYPMP8BcT20BIx/5dashOIki2ZQzK1PHWsiuX85CK98ZNm7Ge0yrVG
	 VUDRBtIDLRvMw1CoZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1t4n0b1Tor-00dNuv; Mon, 03
 Feb 2025 18:02:28 +0100
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
Subject: [PATCH net-next v3 01/10] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Mon,  3 Feb 2025 18:01:52 +0100
Message-ID: <20250203170201.1661703-2-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:efFOmg+dqNpe4u3UGla4MV9XFWUj0tJLNRqUedq6zolUiCbHteB
 iB3AtOh3zU3zAwiVbUKyujVbSiU4hD+nq9zz+yu/S1ytJRi1CDI6MGmkC3ia7eiHTlepvd8
 pQV6Z4QDRsM7OIEX/iXXpc89Lqg/TkHP12b0qMPmFJrA2bMXB5afb0l9ePXtXXQ1yfdHOUH
 V0lblhzDXtbGPtzu1ncqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Lzg3n0qlGg=;e6PrcDw6e2LHlhfuOtRnk0J8MqS
 xngPifAxwuKlt3QFf1APsAw03ZhCSA9wHVEniprFYw8jCsg6VOMz2lFYl8/UtWjw8VC7TvklD
 2bDjehzoDB88bwG5awV6FrtMybbRCHzV2xrI/nrQJaFeRU5pnOjTLqabzrFMyoKQCmKj+bRYs
 /m69mU7Ot8UTyTZSHfPhFlc5m8goMWdjIrFdtiFc9JPJR6FCvtbOhQP1vAM7AuaegC2FdiQtV
 DoAGDW31up8R/lEusOeW3JDxuxFD3snaiY4mPcPlX0XlX7nOxrp1s6/m/pQMwjK6aBTK3nBku
 Yr82nvrOLHseoxZ1FNrR+MsMR52tmgzkNSmVHg2WhZEyxWRjDtBLlKbptqhn3ixSFCWHchbT5
 Co6CCR228KwBk8O1oPuzy8YmvsZTSL/JNvG6AGRoobmnhRESlNjEWaXBEnl0Xaz+nbSQ6fJ+y
 2DIZisLKLFKciGfPYu0Xrfv/g9RbWpK1UARX0pskwi0NhrWHulsvKXbrM0QWCn+ySM7td4g2M
 IgGUfdkQbyXYViIXIAj8frbal3CySgwj+Iw13BvZvxtbamuVSQahvNb7/rdI0gKNMPZt7lyOX
 1Cw3vajX9dvOnpSz/fr/H0IQQeZp7WS3iDSO4WswPG4fba4Wmfj6YrfZxjaq2AcBXkiueI2Zb
 AfuyiEjGR50TobqqKiu06Jxdj9zcnIPKiSeZtT7egE5n1HqQKyvr0H85+Dkden1u7O6SxCVPO
 xHZV3oTHZrXlxyWYjPJNDSklG0KorlHmy0V5BANCs+2YGjxC9pzSP9o3ysjtUMFyHB7kIsHzM
 EwbJ5itcMRUzxUbztDb3Ku6pKSA11EJ6z9rrngPYZaJh+yP9bTts7tsw0/nrQqfOXBzbNO5Pz
 /WZjGjsJuDKoBBQHVux9ehJ7V7OaulPkopxiPWnlYcDj/Rqhro7BUIMgNCpvZokCyJBTcOBoh
 c1p8BTeZL9mAbb70uLuNzgLVLK8rlFNY/wIy6IuJTi/4FWMSyxScvsL36Pa7qkWLViz5ehhU9
 nFtONff8hKv7s+zKQftZl8Y9kjMkbfCK+KLGbbJHu12dtjejyfrdW/CEObZy93BBiH0fhVYJS
 Bjz1E8Fx/RULdLM2FyBgvPLcA2HNFHOk9CQq09pvTWJP8WkLwXzagJsqeiJxPSi+QXd3j++Mm
 eHg7TEmOpqNRVMWUve3tBXoAuq7m/mewqDhk1QwkqcPF1kTktJQu/j/SY8Y+ntPwTTQu0u2J5
 RTHmKBAsvELA4XqfTqXdAKRlal+nTmDaqL3TXAKoe9Y9y3Ifyf0R1GzdvNFwo8uZ3m0Ee0780
 d4wXWnAtQjSXX8mdiByvzMJ80AIm8rm8XyaN9oTIyY8gwM=

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hh
bmdlcyB2MiAtPiB2MwogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2MSAtPiB2MgogIC0gbm8gY2hh
bmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0
Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA4MmI2YTJjM2MxNDEuLjQ5NmFhMTY3NzNl
NyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMK
QEAgLTExOTgsNyArMTE5OCw3IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKCh2YWx1ZSA+IDApICYmCiAJCSAgICAoKHBrdF9kZXYtPnht
aXRfbW9kZSA9PSBNX05FVElGX1JFQ0VJVkUpIHx8CiAJCSAgICAgIShwa3RfZGV2LT5vZGV2LT5w
cml2X2ZsYWdzICYgSUZGX1RYX1NLQl9TSEFSSU5HKSkpCi0JCQlyZXR1cm4gLUVOT1RTVVBQOwor
CQkJcmV0dXJuIC1FT1BOT1RTVVBQOwogCQlpZiAodmFsdWUgPiAwICYmIChwa3RfZGV2LT5uX2lt
aXhfZW50cmllcyA+IDAgfHwKIAkJCQkgICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpKQog
CQkJcmV0dXJuIC1FSU5WQUw7CkBAIC0xMjU4LDcgKzEyNTgsNyBAQCBzdGF0aWMgc3NpemVfdCBw
a3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCSAgICAoKHBrdF9kZXYtPnhtaXRf
bW9kZSA9PSBNX1FVRVVFX1hNSVQpIHx8CiAJCSAgICAgKChwa3RfZGV2LT54bWl0X21vZGUgPT0g
TV9TVEFSVF9YTUlUKSAmJgogCQkgICAgICghKHBrdF9kZXYtPm9kZXYtPnByaXZfZmxhZ3MgJiBJ
RkZfVFhfU0tCX1NIQVJJTkcpKSkpKQotCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJCXJldHVybiAt
RU9QTk9UU1VQUDsKIAogCQlpZiAodmFsdWUgPiAxICYmICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NI
QVJFRCkpCiAJCQlyZXR1cm4gLUVJTlZBTDsKQEAgLTEzMDMsNyArMTMwMyw3IEBAIHN0YXRpYyBz
c2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfSBlbHNlIGlmIChz
dHJjbXAoZiwgIm5ldGlmX3JlY2VpdmUiKSA9PSAwKSB7CiAJCQkvKiBjbG9uZV9za2Igc2V0IGVh
cmxpZXIsIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBtb2RlICovCiAJCQlpZiAocGt0X2Rldi0+Y2xv
bmVfc2tiID4gMCkKLQkJCQlyZXR1cm4gLUVOT1RTVVBQOworCQkJCXJldHVybiAtRU9QTk9UU1VQ
UDsKIAogCQkJcGt0X2Rldi0+eG1pdF9tb2RlID0gTV9ORVRJRl9SRUNFSVZFOwogCi0tIAoyLjQ4
LjEKCg==

