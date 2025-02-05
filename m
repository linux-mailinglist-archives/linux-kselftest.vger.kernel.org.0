Return-Path: <linux-kselftest+bounces-25837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E25A28B5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127261882ED4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144741632DA;
	Wed,  5 Feb 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="t65UzfxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0E156225;
	Wed,  5 Feb 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761131; cv=none; b=ZY1+YjhuzTXCB1aMP8Or4PYpzzMMFWdFA/HCm5XjhOJZcYjmqqG+KS2ydijX94vrQA5eVbbuKidUG10E0wI/JFfuWMEsl8SdA4LY8iRXOqvCA4pitt27/PlSrNw1xeiVe3fYsH8wH8cvJn5gS2ZqKZDWcggfNb/vEnCH2nXp52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761131; c=relaxed/simple;
	bh=UUKcn7FbQ6O0wPvsVojYNhwuSBxnf92oJVhabua09ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww6Pwa48b9B8hKQmwhh2DQxLlPRWSft3kxePV1pksFTzf5W9DChC/AOggkzCOiTQ8sHy8Gts/Tzmk8ZuyOhuwEkpUJVwfQjJOshHH5cqdxzCfd8fdpDHhgF71gBRLVXM6+k66z92s6GxRBQVPR7V1M3+GbnXgQCrPC+/Ok6DesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=t65UzfxB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761124; x=1739365924; i=ps.report@gmx.net;
	bh=UUKcn7FbQ6O0wPvsVojYNhwuSBxnf92oJVhabua09ag=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t65UzfxB53UMYb32BYCq/mUsdyElYk9pOOq/qFB3e8Wg/LHzyOtIy/DbGW8Da6hm
	 wVt0G+dZmknP/Ab8i3vwA7EyjfMfOpVqv3fvdqudUTEE2ifZmxML5KCGOLbt+y4MN
	 ORwuFxp+jTKaIU3GRow0cYw/XkEYh6cAusnBfdzvuwzyM1yj9lf46hQWzyZDFvGux
	 x+MD+/kbbyoaCrqHigwkQ1f6Xnxe5Z6chkYm8IJ86tCNFsrGcHOoOd+UIxueMJD0t
	 xkg9I5yqSRkgr/FLIkveGT0adTqDvwi79ei/Hh4JpInqGgOaqmOJ9YGbrLW6SExp2
	 0VGmzC3LZnyUAUdk1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1tbFLQ164e-00APxa; Wed, 05
 Feb 2025 14:12:04 +0100
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
Subject: [PATCH net-next v4 12/17] net: pktgen: fix mpls maximum labels list parsing
Date: Wed,  5 Feb 2025 14:11:48 +0100
Message-ID: <20250205131153.476278-13-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:PpaXsn8lsIIOMNUA5cQJ8FYX4oyLHivalE+OO85yp32Fl90jUWD
 Av/HZsF06wd0nPsTNWB9aFLOr97xtZZqXA3TKkTjf35b5cf0vCVnnWM/uVbooW3KcHGfTHj
 nPW2ybd0+pRyhQrg+E8Wh7pByg/ZBOZSe0Kb6nTNUsFwMICK5Jbb73sqvKUh5r8uT4hF0oL
 rNy0ly30JXDatW1sjMsWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v7Siu5Tv++I=;qqoMtqWqstPpW64vqNlCpNw3Ib9
 X0L1BpmRYWoCkZx1PQBfsRixVS6IjOR5dqPDB3ILpEvWlQ+e62QCXTOmIiLiz5aSEy+Zybv04
 dErPAG3f1fJy+O+02MwjHcmgA1a0K5K4EIo8JXoF+R+UWY5LN1KpSdgeFhaFDMPrh3jGhDgX6
 hD3jZN27a1RLR2bc7s9DKZqArAj4R/d+KpD7EU7Jybrrgblk1h7HNUapoSvU3HWxgGRrgZ7xg
 ZKZtN2oO005iOgLwlWa20yRMmOXcXKBFOnMfpg8I81qCyKlMNB+Mvv7bB1pc3flFbs3RUn/p8
 ljL7F9G8IhuCzfHsvZmb0HQ4HSmd7e5D2QbKi6GkJnzmRj6X71JUCZ7CPcnWPN3ybBCnsyaUh
 kZykSyEtxE3hlD/bMgY/9nKOE9zM3TVPdXUyWSbOFhfXp56XD347SP8qVSTt2BBPqIIvL6a+C
 SYdD7p5hFUW+1C3/yx06JPCv8XKQIHMqByEPX0Xp6XgefVT3Vp2fDdZ2jVY0EHafQM/0ZLpVa
 Nz1DvTizFsPwq5lRM6ofoeRNNc5CCJ4Y1LzHu6VfWitz6/6M++RdE0Gir0Qm/SuijKvAa+z2z
 U8KzAJtshN6gfhpRbHn3m7f3DGpgEtjXLWwCdW/dPnUR82WsEsSSQjGfVeK9hVt6CYNrcPPwo
 0SoobYDpTN23WsN7zNnPt80a+s+GoVZe+6swexsOD/KYaLpQA43xaTWyyQLRHlWxpI5AuCaK6
 6Cn1gHqSApZj4xouDzHUZWUKcvV+Klkhb0XsvN3NmXlBIEIt5opT39KcqiDRfXT5pYacC7Vvq
 /yJFbrpaDOTAIymuMKsLNPbF6S9+zflMDoQR0nK4SXFq3iVHaGqH53kRFZxmttS0fEQoTpkZH
 ZDdLPaZM5r1eXJzk1fOUR0Wr/F/3mtkXuCNGUaI/hOe67Wd0KuMe3lJHodeeMssiY8pv7Npm7
 koB7vjksjdzC/HYe/yj6VTOXGi2uBnrH0Y0u7X3XElc5y0uUdLRBiJqs0idgSZ/Inz+bLBwBW
 x0BnkpuJoOCqF5jyQD1GKhYCf9nzrc7iv7K/Mb23rjeMuAgUSWJZ6gqnCB8cnn2Nl6LWPAvKw
 8VaPgISJU6nFyB3hkpACxbRoA8bwWXentWM0jSOZfS43Pd/4Rzy3Te51jClXhem4Hl54hTMjz
 8OsUip90l6nDOcYdlXgwrTgZId5jjMpxmdAbAs3vA4Ms6fGDhHaj/fC44smrzlR7Gj9J2pBZa
 u6h3FsBek554ax212QNUgeXNuOoxDjfxAuO7JxIG72xZ+20YutYNex7c59HFKsSaDxIBIMIzu
 V++khY/fa5ceGwa9/mmJE9TTDkAeEKsuW3zrbpnwyVUDEk=

Rml4IG1wbHMgbWF4aW11bSBsYWJlbHMgbGlzdCBwYXJzaW5nIHVwIHRvIE1BWF9NUExTX0xBQkVM
Uy8xNiBlbnRyaWVzCihpbnN0ZWFkIG9mIHVwIHRvIE1BWF9NUExTX0xBQkVMUyAtIDEpLgoKRml4
ZXM6CgoJJCBlY2hvICJtcGxzIDAwMDAwZjAwLDAwMDAwZjAxLDAwMDAwZjAyLDAwMDAwZjAzLDAw
MDAwZjA0LDAwMDAwZjA1LDAwMDAwZjA2LDAwMDAwZjA3LDAwMDAwZjA4LDAwMDAwZjA5LDAwMDAw
ZjBhLDAwMDAwZjBiLDAwMDAwZjBjLDAwMDAwZjBkLDAwMDAwZjBlLDAwMDAwZjBmIiA+IC9wcm9j
L25ldC9wa3RnZW4vbG9cQDAKCS1iYXNoOiBlY2hvOiB3cml0ZSBlcnJvcjogQXJndW1lbnQgbGlz
dCB0b28gbG9uZwoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgu
bmV0PgotLS0KQ2hhbmdlcyB2MyAtPiB2NAogIC0gbmV3IHBhdGNoIChmYWN0b3JlZCBvdXQgb2Yg
cGF0Y2ggJ25ldDogcGt0Z2VuOiBmaXggYWNjZXNzIG91dHNpZGUgb2YgdXNlcgogICAgZ2l2ZW4g
YnVmZmVyIGluIHBrdGdlbl9pZl93cml0ZSgpJykKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDYg
KysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXgg
ODRmZDg4ZTQ4Mjc1Li4wZmQxNWYyMTExOWIgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5j
CisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC05MDgsNiArOTA4LDEwIEBAIHN0YXRpYyBpbnQg
Z2V0X2xhYmVscyhjb25zdCBjaGFyIF9fdXNlciAqYnVmZmVyLCBzdHJ1Y3QgcGt0Z2VuX2RldiAq
cGt0X2RldikKIAlwa3RfZGV2LT5ucl9sYWJlbHMgPSAwOwogCWRvIHsKIAkJX191MzIgdG1wOwor
CisJCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKKwkJCXJldHVybiAtRTJCSUc7CisKIAkJbGVu
ID0gaGV4MzJfYXJnKCZidWZmZXJbaV0sIEhFWF84X0RJR0lUUywgJnRtcCk7CiAJCWlmIChsZW4g
PD0gMCkKIAkJCXJldHVybiBsZW47CkBAIC05MTksOCArOTIzLDYgQEAgc3RhdGljIGludCBnZXRf
bGFiZWxzKGNvbnN0IGNoYXIgX191c2VyICpidWZmZXIsIHN0cnVjdCBwa3RnZW5fZGV2ICpwa3Rf
ZGV2KQogCQkJcmV0dXJuIC1FRkFVTFQ7CiAJCWkrKzsKIAkJbisrOwotCQlpZiAobiA+PSBNQVhf
TVBMU19MQUJFTFMpCi0JCQlyZXR1cm4gLUUyQklHOwogCX0gd2hpbGUgKGMgPT0gJywnKTsKIAog
CXBrdF9kZXYtPm5yX2xhYmVscyA9IG47Ci0tIAoyLjQ4LjEKCg==

