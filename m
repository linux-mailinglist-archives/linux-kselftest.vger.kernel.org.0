Return-Path: <linux-kselftest+bounces-29184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE040A64680
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BD167DFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE021D5A7;
	Mon, 17 Mar 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="G/8Q+QIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49402E3373;
	Mon, 17 Mar 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202256; cv=none; b=AZy5BTuQNfDsXiR7x0XR1ktiQAfuGqQqZ9cdQCvara9OFmIU36aofs33zn67Pme0wGqRE7V65S1NIR9Om6lpCtA6x91L+yssuMBxTkL/QR9lWtrxNVva9PhVCDPc8Vuh/Al5dFe2AS4I6dWQ11XPVWAFDgCtW6RpGH1FKKUIVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202256; c=relaxed/simple;
	bh=oE67VnnPzPtErL3eqYFJl9pKX265+/+OCrhbsLHynGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ouhf0w8A96ISJPM2ZJdNkpM6J7AfcNoLB4NgS+yMZ3z0JkPO2J9QWHO8ULEpB1u3jnrMC1l7Baq9JeNrlRoTEBfQWnTHmYzAup34CZMD/wVriCUK3y0TTAIqq75AzzrhVeppguU4fv0pr+FEZvQ5B8sAeJYk236vYmkGTm4J5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=G/8Q+QIg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742202251; x=1742807051; i=ps.report@gmx.net;
	bh=oE67VnnPzPtErL3eqYFJl9pKX265+/+OCrhbsLHynGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G/8Q+QIgfd3XsmW2Jh3o7vx+hKDjujbaJM1qNKM5/zY8h+PYnPPqoc1hSX7EkaHw
	 KNeRKUAqpiAvs4GaoukvXCa5KqUXdvDZCrlPla60jcVq+ScuMost8j7pp6Vn0mgY7
	 vCZHtp/4Yh8ipcjqBb30rhWIwWn2o47aXB66cnVyooN2GLL9OKiEIIXqBfqRbes21
	 Bj76vxxsLCwnUze76PU/98PR1xuSGlCRrv670ObWGNznTGjasMxm/u5GKe+a4l0fB
	 fyB6SCWAALHTyUhFKSIb0MXJ30N40/fe3K+NIURK2CvrjXQneYfuW6IVheqDFtuA3
	 B4dVwkzSbj5Uwt0fWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.158]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1tpRYw0tLV-00GY2A; Mon, 17
 Mar 2025 10:04:11 +0100
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
Subject: [PATCH net-next v1 2/2] selftest: net: update proc_net_pktgen (add more imix_weights test cases)
Date: Mon, 17 Mar 2025 10:04:01 +0100
Message-ID: <20250317090401.1240704-2-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317090401.1240704-1-ps.report@gmx.net>
References: <20250317090401.1240704-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:GrzvT6SMDnqf4mC4jV5KuATT+E4Gp7fSY7bIowucg7Tne5vcC/q
 t9zW41C1XxbgDu/o5UGyB0kd1NO+sjK8BT+nGuDeJkzSQ122QteybFv0WoiMmnoMKbqDxgU
 /WPYlyoCNj++wRF9K/qLrh4TrbGrpDnF7XsFQL/HTbYJOhZTZwGeetGY1igy3r+HBdOgnyq
 Vgm7W5NL8/KNz4p/TjW0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UoqJDHe4PqI=;uXzjHhPBrA8/GMVRD0C8wR67K2S
 dLvR7cTpoYt8Xt5S4Krty5wroYIYqh6/Q2KmRwDBls+w4CkZacsbpakTNcyvIdZ82c+tiYAJ2
 ZHsWdnX1l8b9New7D3LhFQzmRBPlKdsi3AT2mPB9U8dWVm4Imz7BfDfxex+n2VkPeIxfPxwid
 vxu9e8TyXtK7ewmhTO4jLvE6soo5suZoSin8rh147tY5aYMU4ULraS4We9Cq5eP1eSIeYrTeP
 WO9fdAsAUiHLsmAi7PHkKU/hruUBzd5hP2tVN5zLl3EI2+6dB4bN1CyP9p3qOyJ6HSQAsS27J
 6K/4Oaf7QvEe7kj2ejdp3d7N1G95CUMQVIqrpTGKEqS3QTiCZ8gaHicYYUrUnAxCU3laBZezT
 sHVEcc7m8KhPjuYBQWAna4/I1pbR4xpG6XPkzOg3lmUk+OX+NvZTpf0vDJ1vh0faG2Qo7d96b
 Qie6RMTRT29rdIjHoPrRjvJt9GM6Z9xXLpFetS6ZUoiwz3rdBMeULEGCOuOLJ52FqiLggKrd5
 bhQ8ufzr1Lf92s2DWpVEwptxeywpEujdWQFAjbt/uAmpvjquspf7rJrcZxgY++FiR6OhXrVmn
 B0fwShVLrvnIGQOPhXob7bcH24Nktr+6grlqDoDt+Tj8QydxH1ibHZGTW9E9g8uQV0xaA8WkP
 wdfwNLB9aJmhT2+DCoIQ7DPazb4WOd5Yqv7nCjViw1nTOyntxTbpb7AtkC790zc6/Ii3Rn2NQ
 /Zq0cTiBr4s2G6ZyN+r5mByEj11xOtbETnbdGxaUuKEZyZRWEq42Tk0ZqIH2fqRTNQ3y9EHbW
 2ff4fUXX6W0e2byHTJwbpGsGnHtS/gCERFL08AUuVKkXSltxMKw7frf+i1vWgMQtfYxgiIBsC
 iOVLQGl5QMpvZW8vQju1ydJxa6rXlfv7NtQCsIesLXmuF4yTF3mqcIQGQm5TKrqAp2a7/h990
 SdV2MkLyXa3F1puUcOyDHkSucibYyv5pNQXWVbguu7h0Q44yi5spqaoMMlmNIBtbIJO1VgeS5
 xaa6vgihLjC0Yg5I9oL/nLhIetUXIBt9xVn14fMO5+ZC08TN9y1Q4LgbVoQ93tf2DGM/G/kYe
 Kjb67L6023onPAMLIzPUGHoXe+0S+kYMCJOB1TDh9ltx31bP68hS2NIHR+lQEkKJ98+6d79Lk
 3IzBCEWxwOO0lX9tbxoZeUrMDoV4sbQ1JRfL2BIMRnwwrCLRfGpvUrYodABWRABlf7qgQSuGk
 3NcY+ZRPqL1KDJTwaiVFnGyFRdAovXflTEBhRwZT1ixWNgErOwuw8MXA/eei833x9iTi97YCK
 cY9JdqEpZO4Ac5z090nTig1Xg/1aRaNxg0STaUKonXHIUGrYm97StSrhzKVpLDBw7h6bfWhQq
 Ap+wEtVupxvjYUyEc6L9DJOVMaHGiLXz19lDihXq/ONuHfItfPmjz3RiYCAnSxjVJq7oWV70C
 +2ops3rnQq+P9OPsVy87iR5LZfn4=

QWRkIG1vcmUgaW1peF93ZWlnaHRzIHRlc3QgY2FzZXMgKGZvciBpbmNvbXBsZXRlIGlucHV0KS4K
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcHJvY19uZXRfcGt0Z2VuLmMgfCA0NCArKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wcm9jX25ldF9wa3RnZW4uYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wcm9jX25ldF9wa3RnZW4uYwppbmRleCA0NjI4MDVhYzE2
MTQuLjY5NDQ0ZmIyOTU3NyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
L3Byb2NfbmV0X3BrdGdlbi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9wcm9j
X25ldF9wa3RnZW4uYwpAQCAtMzksNiArMzksMTAgQEAgc3RhdGljIGNvbnN0IGNoYXIgZGV2X2Nt
ZF9wa3Rfc2l6ZV8wW10gPSAicGt0X3NpemUgMzAwIjsKIHN0YXRpYyBjb25zdCBjaGFyIGRldl9j
bWRfaW1peF93ZWlnaHRzXzBbXSA9ICJpbWl4X3dlaWdodHMgMCw3IDU3Niw0IDE1MDAsMSI7CiBz
dGF0aWMgY29uc3QgY2hhciBkZXZfY21kX2ltaXhfd2VpZ2h0c18xW10gPSAiaW1peF93ZWlnaHRz
IDEwMSwxIDEwMiwyIDEwMywzIDEwNCw0IDEwNSw1IDEwNiw2IDEwNyw3IDEwOCw4IDEwOSw5IDEx
MCwxMCAxMTEsMTEgMTEyLDEyIDExMywxMyAxMTQsMTQgMTE1LDE1IDExNiwxNiAxMTcsMTcgMTE4
LDE4IDExOSwxOSAxMjAsMjAiOwogc3RhdGljIGNvbnN0IGNoYXIgZGV2X2NtZF9pbWl4X3dlaWdo
dHNfMltdID0gImltaXhfd2VpZ2h0cyAxMDAsMSAxMDIsMiAxMDMsMyAxMDQsNCAxMDUsNSAxMDYs
NiAxMDcsNyAxMDgsOCAxMDksOSAxMTAsMTAgMTExLDExIDExMiwxMiAxMTMsMTMgMTE0LDE0IDEx
NSwxNSAxMTYsMTYgMTE3LDE3IDExOCwxOCAxMTksMTkgMTIwLDIwIDEyMSwyMSI7CitzdGF0aWMg
Y29uc3QgY2hhciBkZXZfY21kX2ltaXhfd2VpZ2h0c18zW10gPSAiaW1peF93ZWlnaHRzIjsKK3N0
YXRpYyBjb25zdCBjaGFyIGRldl9jbWRfaW1peF93ZWlnaHRzXzRbXSA9ICJpbWl4X3dlaWdodHMg
IjsKK3N0YXRpYyBjb25zdCBjaGFyIGRldl9jbWRfaW1peF93ZWlnaHRzXzVbXSA9ICJpbWl4X3dl
aWdodHMgMCI7CitzdGF0aWMgY29uc3QgY2hhciBkZXZfY21kX2ltaXhfd2VpZ2h0c182W10gPSAi
aW1peF93ZWlnaHRzIDAsIjsKIHN0YXRpYyBjb25zdCBjaGFyIGRldl9jbWRfZGVidWdfMFtdID0g
ImRlYnVnIDEiOwogc3RhdGljIGNvbnN0IGNoYXIgZGV2X2NtZF9kZWJ1Z18xW10gPSAiZGVidWcg
MCI7CiBzdGF0aWMgY29uc3QgY2hhciBkZXZfY21kX2ZyYWdzXzBbXSA9ICJmcmFncyAxMDAiOwpA
QCAtMjg0LDYgKzI4OCw0NiBAQCBURVNUX0YocHJvY19uZXRfcGt0Z2VuLCBkZXZfY21kX2ltaXhf
d2VpZ2h0cykgewogCWxlbiA9IHdyaXRlKHNlbGYtPmRldl9mZCwgZGV2X2NtZF9pbWl4X3dlaWdo
dHNfMiwgc2l6ZW9mKGRldl9jbWRfaW1peF93ZWlnaHRzXzIpKTsKIAlFWFBFQ1RfRVEobGVuLCAt
MSk7CiAJRVhQRUNUX0VRKGVycm5vLCBFMkJJRyk7CisKKwkvKiB3aXRoIHRyYWlsaW5nICdcMCcg
Ki8KKwlsZW4gPSB3cml0ZShzZWxmLT5kZXZfZmQsIGRldl9jbWRfaW1peF93ZWlnaHRzXzMsIHNp
emVvZihkZXZfY21kX2ltaXhfd2VpZ2h0c18zKSk7CisJRVhQRUNUX0VRKGxlbiwgLTEpOworCUVY
UEVDVF9FUShlcnJubywgRUlOVkFMKTsKKworCS8qIHdpdGhvdXQgdHJhaWxpbmcgJ1wwJyAqLwor
CWxlbiA9IHdyaXRlKHNlbGYtPmRldl9mZCwgZGV2X2NtZF9pbWl4X3dlaWdodHNfMywgc2l6ZW9m
KGRldl9jbWRfaW1peF93ZWlnaHRzXzMpIC0gMSk7CisJRVhQRUNUX0VRKGxlbiwgLTEpOworCUVY
UEVDVF9FUShlcnJubywgRUlOVkFMKTsKKworCS8qIHdpdGggdHJhaWxpbmcgJ1wwJyAqLworCWxl
biA9IHdyaXRlKHNlbGYtPmRldl9mZCwgZGV2X2NtZF9pbWl4X3dlaWdodHNfNCwgc2l6ZW9mKGRl
dl9jbWRfaW1peF93ZWlnaHRzXzQpKTsKKwlFWFBFQ1RfRVEobGVuLCAtMSk7CisJRVhQRUNUX0VR
KGVycm5vLCBFSU5WQUwpOworCisJLyogd2l0aG91dCB0cmFpbGluZyAnXDAnICovCisJbGVuID0g
d3JpdGUoc2VsZi0+ZGV2X2ZkLCBkZXZfY21kX2ltaXhfd2VpZ2h0c180LCBzaXplb2YoZGV2X2Nt
ZF9pbWl4X3dlaWdodHNfNCkgLSAxKTsKKwlFWFBFQ1RfRVEobGVuLCAtMSk7CisJRVhQRUNUX0VR
KGVycm5vLCBFSU5WQUwpOworCisJLyogd2l0aCB0cmFpbGluZyAnXDAnICovCisJbGVuID0gd3Jp
dGUoc2VsZi0+ZGV2X2ZkLCBkZXZfY21kX2ltaXhfd2VpZ2h0c181LCBzaXplb2YoZGV2X2NtZF9p
bWl4X3dlaWdodHNfNSkpOworCUVYUEVDVF9FUShsZW4sIC0xKTsKKwlFWFBFQ1RfRVEoZXJybm8s
IEVJTlZBTCk7CisKKwkvKiB3aXRob3V0IHRyYWlsaW5nICdcMCcgKi8KKwlsZW4gPSB3cml0ZShz
ZWxmLT5kZXZfZmQsIGRldl9jbWRfaW1peF93ZWlnaHRzXzUsIHNpemVvZihkZXZfY21kX2ltaXhf
d2VpZ2h0c181KSAtIDEpOworCUVYUEVDVF9FUShsZW4sIC0xKTsKKwlFWFBFQ1RfRVEoZXJybm8s
IEVJTlZBTCk7CisKKwkvKiB3aXRoIHRyYWlsaW5nICdcMCcgKi8KKwlsZW4gPSB3cml0ZShzZWxm
LT5kZXZfZmQsIGRldl9jbWRfaW1peF93ZWlnaHRzXzYsIHNpemVvZihkZXZfY21kX2ltaXhfd2Vp
Z2h0c182KSk7CisJRVhQRUNUX0VRKGxlbiwgLTEpOworCUVYUEVDVF9FUShlcnJubywgRUlOVkFM
KTsKKworCS8qIHdpdGhvdXQgdHJhaWxpbmcgJ1wwJyAqLworCWxlbiA9IHdyaXRlKHNlbGYtPmRl
dl9mZCwgZGV2X2NtZF9pbWl4X3dlaWdodHNfNiwgc2l6ZW9mKGRldl9jbWRfaW1peF93ZWlnaHRz
XzYpIC0gMSk7CisJRVhQRUNUX0VRKGxlbiwgLTEpOworCUVYUEVDVF9FUShlcnJubywgRUlOVkFM
KTsKIH0KIAogVEVTVF9GKHByb2NfbmV0X3BrdGdlbiwgZGV2X2NtZF9kZWJ1ZykgewotLSAKMi40
OC4xCgo=

