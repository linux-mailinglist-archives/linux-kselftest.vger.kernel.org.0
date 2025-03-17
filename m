Return-Path: <linux-kselftest+bounces-29185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2408A64684
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BCF168661
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83490221F0E;
	Mon, 17 Mar 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="JbL6XZe2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5E3AC17;
	Mon, 17 Mar 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202257; cv=none; b=B3RKawnS5P8FDJ8ReCel3KyOF3bvNRkT1AVFYOM5pN1SJ0ufBsSaXC5HfMzJ1R2bdcZ/wlobbQP13T+Kzn9HTPhX25b1vAQ0CoB/YBWQW3uxUetlFDPOX0o79Te2kKQpNAHJ4f1BdkmowOBAeFKQ+TpZJGrfiTM8Z1LSB5yutP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202257; c=relaxed/simple;
	bh=BtV7ZrSR7GQNLdQOsdCK9tMWgq9b8VO/0Qt6zIyM9Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXkpAGPtHTMCnPKOnPInwG2C5kA1SN4dgXdCE89PdXQnRDK3CP0L0g630z1hvuwavtiLNXcpGDyUv9+SktYClbJ1HWgyNhrVdATxQHMkRlHMGQhV7vw1EGb5mXg6Z8JU5Pr+oEeIT2avpx+qVxqjj5Qcfu1HJt/mKStvala4yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=JbL6XZe2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742202250; x=1742807050; i=ps.report@gmx.net;
	bh=BtV7ZrSR7GQNLdQOsdCK9tMWgq9b8VO/0Qt6zIyM9Z0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JbL6XZe2wChG9gJOTEEh90w8slWS0Z2DjOih2RZF4pmbgUuN2ZQQVczv7gg+zUWB
	 dUYMfkMzEKDK2FHCReQWaNkZOCiVCtCCNaF/13davsPEtU7Sw23iOamVonnieqIfL
	 mdUDTbRYpCjN5lduxZk/UWNCkbLXUTbPH8REJN30CiDVIqmmKE11iOlSPD37PAgsf
	 quGT1sWKoSf6HZk/Ka8/sdp2QbxUWDYO0z/7xlXUENFL2KhNYIjmLj5GFLlYIt/9g
	 rzjlxAMGwPkH4kzvR5JOuks0mBVZA5aNVVor5x0PM4gmAzHqvxDjpyNULoUdx3DdP
	 9N4OmiC8q0YbsmoAjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.158]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1tHDCp2L5Z-00mZOc; Mon, 17
 Mar 2025 10:04:10 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 1/2] net: pktgen: add strict buffer parsing index check
Date: Mon, 17 Mar 2025 10:04:00 +0100
Message-ID: <20250317090401.1240704-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:lKpMuL1MIjGDQau+Hv2X9RMq4jhxMkCqgfy01wvfn2E8wT0W1In
 GHHzdcf6d439S//6zXEJ/JIdFiJzKw4t04fZZElHr5zKGReW82Ni+sqxdTJojhYO6F1Wsub
 w5eqijzQX059VgyoyO3tuiqHaSC0/r7E4A4P2h387Z6LqF4xzkwoCn7U1wvYezynmpeVIZc
 LP+qwnY9gIGXl5pURQhfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jz0iReNbelo=;sf+zMQiNykp90OeFSNbQdB1R+k6
 Vd08mehPYF5x7xHFD/8wZBVOv3olvRReVFxUBWS8d7gxE9ch8T1vur++m3EbxRBrVTMlmM3PJ
 lbrnG6DBODrSodpE4706UzXbj5YEKWZRH79V/jxwTLkQF7msR7cCFKaRmvM/mTrhuNy26xPQs
 v+VTxAtgoCsKdTvTMWEI/QzRBWmojLPIvmrozQkoRgnIvkAz5bOdEuhJ1aGs1jo4tOLcltmAQ
 c6vwU7I2VxHrHpd+zplYzZ87wP/XJ6UwTSKh59ulF8urN2msdQj4IBSQeUGG5sRFCcjQzP3ps
 Vq3N2S1d8PtResuxHeSGrE3AGWKAiA8JHQWuz1JIYaheZCxzt3lCf8uzoqRnWsFD+b19cJ+W9
 88cKBx/FR3s/RWO24KYkXyJxO8XCOIb8x1upFmJahRIlbR/NlFalgxMpzbiaPHVyddwd5STGa
 CStIy5xRLecG2/Wp3iwcBDhTA7fpTW7VYIxWQKuR9yQsNiE7U3A4NTfxYkDijTyhYcOnzFAEq
 S9d7Oo/5ag/+2jtl2Ak2+pXZc35FpzyrPuDlR4jyPNcP2UwF3GUWwv/qnE9VKh167kXQZp89k
 FzvLYEJ10Pxb+SYDky1c9t7UfLifMZAO5oUmF+9V5OxVMWaWPq0YkMCqqWMOIWS2wlgDYLaKH
 9UsVT42efOSzuMxGxKfGwT/ZG1V5QlbYZXemNR1qD7AXRfKeYEsItOneM5z+gOCmS0q+BYt6Z
 Vh9VB8icp9PI/Jq+8UQtfZbtFeJhS4oQ5klrm+hAX/SmMZ2RKZ6pydDHzybcvVqarWSIuIs1k
 xyiOIRi9ejFmSuXhmVGfDqiOhkmrX+LEIjKA/gGXlIBwsh4N+FpgsJB8SrMtt3/NpmrBXuQwK
 lcmnG+XtnvdtepnFNQaiUK7WrLzFYWYMQmznEXgl+KcjTJ+mEW+orezXP//4Nz48wQc3HJqcF
 a5fT109XY4kQwqLl9Fx4ve71tEE2RaAnJsgoA09ZbuxC6ILlTUh5i5cW1qFWVvMy82EtWDKjG
 VGapzB3YMUToWAAXElv0PZJWYMARIisBBE3f3nKARh9JYqFKDNPHWoVonR3FeJjyC/KqFroTW
 41UZ4OEzmsLA15E1YKbazfqC/Eey5Jezsk9sAuqXtSqYLQTVGeWRxKYLmUDqMs73Sl/HEpM7h
 aJVGkcrsTDpRDB+Ls7TOBVGuT8Gs/Aylyt57bsShUsoXz54K78RlNTbyXutnGxsEMloOqlSTM
 Xkw1TkQpCP4zHa1JpGF/q4ClTlqEsWQrCKMc1RePQZCJiW3Hvzw3hzro7jW0mPUc5mMkDq44K
 JJ0yot0NBuHIHGZCgR35BNVpzgI3fI5KBoxdj7VkdKyXjY4L220EHt9IxqoQ888il6M1jBLzC
 I20aHDg8PWh4mmOfoWUc/nKce4koMhV1vTfWi3OmFFT9PMuppXDNnzQ8iwUEPPvF3Jwl/ix6/
 YA507OjRad21Yeqp/YDwfydwuJ7U=

QWRkIHN0cmljdCBidWZmZXIgcGFyc2luZyBpbmRleCBjaGVjayB0byBhdm9pZCB0aGUgZm9sbG93
aW5nIFNtYXRjaAp3YXJuaW5nOgoKICBuZXQvY29yZS9wa3RnZW4uYzo4NzcgZ2V0X2ltaXhfZW50
cmllcygpCiAgd2FybjogY2hlY2sgdGhhdCBpbmNyZW1lbnRlZCBvZmZzZXQgJ2knIGlzIGNhcHBl
ZAoKQ2hlY2tpbmcgdGhlIGJ1ZmZlciBpbmRleCBpIGFmdGVyIGV2ZXJ5IGdldF91c2VyL2krKyBz
dGVwIGFuZCByZXR1cm5pbmcKd2l0aCBlcnJvciBjb2RlIGltbWVkaWF0ZWx5IGF2b2lkcyB0aGUg
Y3VycmVudCBpbmRpcmVjdCAoYnV0IGNvcnJlY3QpCmVycm9yIGhhbmRsaW5nLgoKUmVwb3J0ZWQt
Ynk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4KQ2xvc2VzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMzZjZjNlZTItMzhiMS00N2U1LWE0MmEtMzYzZWZl
YjBhY2UzQHN0YW5sZXkubW91bnRhaW4vClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxw
cy5yZXBvcnRAZ214Lm5ldD4KLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDggKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3Rn
ZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IGU4NTA1OThkYjNlNy4uZmU3ZmRlZmFiOTk0
IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpA
QCAtODU2LDYgKzg1Niw5IEBAIHN0YXRpYyBzc2l6ZV90IGdldF9pbWl4X2VudHJpZXMoY29uc3Qg
Y2hhciBfX3VzZXIgKmJ1ZmZlciwKIAkJaWYgKHBrdF9kZXYtPm5faW1peF9lbnRyaWVzID49IE1B
WF9JTUlYX0VOVFJJRVMpCiAJCQlyZXR1cm4gLUUyQklHOwogCisJCWlmIChpID49IG1heGxlbikK
KwkJCXJldHVybiAtRUlOVkFMOworCiAJCW1heCA9IG1pbigxMCwgbWF4bGVuIC0gaSk7CiAJCWxl
biA9IG51bV9hcmcoJmJ1ZmZlcltpXSwgbWF4LCAmc2l6ZSk7CiAJCWlmIChsZW4gPCAwKQpAQCAt
ODY5LDYgKzg3Miw4IEBAIHN0YXRpYyBzc2l6ZV90IGdldF9pbWl4X2VudHJpZXMoY29uc3QgY2hh
ciBfX3VzZXIgKmJ1ZmZlciwKIAkJaWYgKGMgIT0gJywnKQogCQkJcmV0dXJuIC1FSU5WQUw7CiAJ
CWkrKzsKKwkJaWYgKGkgPj0gbWF4bGVuKQorCQkJcmV0dXJuIC1FSU5WQUw7CiAKIAkJaWYgKHNp
emUgPCAxNCArIDIwICsgOCkKIAkJCXNpemUgPSAxNCArIDIwICsgODsKQEAgLTkxMSw2ICs5MTYs
OSBAQCBzdGF0aWMgc3NpemVfdCBnZXRfbGFiZWxzKGNvbnN0IGNoYXIgX191c2VyICpidWZmZXIs
CiAJCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKIAkJCXJldHVybiAtRTJCSUc7CiAKKwkJaWYg
KGkgPj0gbWF4bGVuKQorCQkJcmV0dXJuIC1FSU5WQUw7CisKIAkJbWF4ID0gbWluKDgsIG1heGxl
biAtIGkpOwogCQlsZW4gPSBoZXgzMl9hcmcoJmJ1ZmZlcltpXSwgbWF4LCAmdG1wKTsKIAkJaWYg
KGxlbiA8IDApCi0tIAoyLjQ4LjEKCg==

