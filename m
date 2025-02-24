Return-Path: <linux-kselftest+bounces-27328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E5A41909
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C2C7A959F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8C254B0A;
	Mon, 24 Feb 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="GgwBqJgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77324E4CA;
	Mon, 24 Feb 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388994; cv=none; b=F7VmAOyP4Yu1Hws2pKjAyWDE5IC4PrCEPjqvTbVKoWZ1D5F5SNdoUyxGyv9JM057JVWUY6ochW6Iv5dNpDKymgX3AuGjlRsW+xZj4otazetUFIeIkKMG/X9Oe849u1j2E6kmUWGuIEdSLK6sK2lamQAgDoVT7jC6q+7+tRUTLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388994; c=relaxed/simple;
	bh=iHD6DYWLmYP4hxJV2dJ//Ylt03ABBIjqXDOxt7sZSkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMQObyij/zZ35ARB0BSkPkA6pFIPVYgD1tntJxkm3SIA0a+a34bQNeNRsQdyC1ABfYchYyvfiO5KJwvRj1BtJibifId2BdkTBCpnkh0ywneb4Ek4TDVw3QbfDpDMPYki9VjoydhAFYVHAhs6VSm0fTZmNBRP4EP+1Y0POdvre1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=GgwBqJgB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740388971; x=1740993771; i=ps.report@gmx.net;
	bh=iHD6DYWLmYP4hxJV2dJ//Ylt03ABBIjqXDOxt7sZSkE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GgwBqJgBN/DCF2fQEFTpQOF6+IhnpAV9m0j2Aa6gHMfBjQUSzmhSKvhblDLnwdyy
	 k8n8mkbWG0YlrJRHUWZ0xxZEGbOa4O9cot+0wH5orXbuSWMA92SOw+9gpMZhVAhFT
	 yPAU5RpdHhP6X/u7ZcpQVZKMh+yQT61yL5OX2BvOCwnoqkXjuLKhF4UUV2ftPeDgA
	 g0QuwBdREjBAmUtZGxlQqxvsb+IVSthZcRwMCykwU77Qax/m3k0nv5L0MgtpbbAjS
	 L37tiKIqLtBBHMu0B1FQGt9pi73MH8tbhgbBYaCsnxqc+/cC00T37vhqRozSrTmPp
	 MqXrPcR0P0tmENHe4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1ttfNp1mmI-00Uvo8; Mon, 24
 Feb 2025 10:22:51 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v7 2/8] net: pktgen: remove extra tmp variable (re-use len instead)
Date: Mon, 24 Feb 2025 10:22:36 +0100
Message-ID: <20250224092242.13192-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224092242.13192-1-ps.report@gmx.net>
References: <20250224092242.13192-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:0QDRXZQcxdd/AzJ6iFfiRuvOiEEDyW7PFH2B3WpfOxr52BT4UV8
 D8RokG70oPUXyfCYtgcoS+k3jzEHffXOsEaGgAwDU1cRaSUGGe/OaSx5ebecfPXBEJ42FUn
 GoYbc4nNj5UnmPW396YNiurkXWJKachiKu5wPq6k0MP+begcIt1D/LRd4fZuQpcartwpa8N
 dVhd+t6Tfn/IPBLqq3/7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkwWlap+HWw=;a0/VykgvS3jHtXif2P1BEjYDvMC
 Xk14ZIX1CfaW8DDmVGsh5pChOWMO21hpxKY+ZeN8CZ4xMEnfQ2YBuOLJoB2qN8C6SuydB4zbE
 a6n8uKIlXN9ojbduABjya4vbacHcLjPdFSOcE4D1X+VbqgID7NO0ud6Kqx2P7EuQnyReOy/gR
 C9xOgBkXaRonGqEsXMK+JZvTKLkM5dRzNhQGO0ng1HSZ0bNaL0qZI5HECU6cWwLB40Fe72gHa
 EksM9Aa+DItjBqTR5wuGSD+NBw0Q5H+SGpDWs5rLrPD3B9zfVoVZuPsckCY/2OBg9oJ0q25r/
 AgFegJs/MTQm1KAMrCdJu5jiLZHb8Mv8A5i4ECmA+CLJzdYRNu6OaexFBWczJpxC3k3mPtMoN
 qFJWocvRr+9pK/bUlB6QjicxU3YC9OsKTBjpT/Ioz6S7sfMPHMtMuHj+xMxTBYmGWdLHmlS2x
 WLd3E3QWjLiIim8Ov8JS2JV+JvJYdFzRA0dpaN9YsZwVV16njw6cV+52eSSj0qs7XKfBJikaa
 1vt67gZphSNCYM97Ysmsuc89sHdPWtiVms61siJlQce/ec9ZIlVONT2Hmhr90tLVYrq18cYtC
 mkbEbL/UNxU4wtMrG1a9Twawf0E72vEdkNv7I3nYiyyKysxhAYKLnjwcL2awstBYeQSaL+xha
 xsYLrIFElJtAKWVBeLYueCkII6o8RWUP7GWWkr8LB9YOH6pRF6k5AYfvzMsOPHsOlYNSEQ4uu
 ps6dHeuNUs0QHTfQuWyDP+77w+z+o6VTYaQKIun1GHUBoF1HN8lF//vorINdMmsEDXS0v57U+
 MfsV6Fw5oA2EA3saBARKjMozyugWHS7Glpy/pPcsfF5dDSnkaGkjKoH9Fo57fxYm7Oh3CsdYQ
 z1C0XooQidfhtF6XQ7dXz5YuihT15EfPiPZXfVZjc5ClPglj/KWxrPNReIumIEz4oWft2t9gw
 jbbf9MSxZjwcPLRaYCWaiKvk76ttPx5mA4iqtaV/4pSZbgGSXV1R8oZrZ+vFXr93oUc2hbcEc
 Qcs/outhJueZ7U53+KNIkc30pnRubX55y5JvhhJgnPmFmvJQOz6pP1U9SHj8CvWB454KfNzRx
 jwDZLu0LLQxO/zFPVmMO9dl1mQC44PP93yW2FHyE9k/9S5PDPSLqQmU+Ssn5QNbvs+QOGbA4L
 Gh9rIBU8gbhfvPrTcGCFxkZohJ60EV+zdpxww7s7E2lljX0mc/qekUXAVGjK2Z+kEKawcBmBc
 ulLAYZp0QdEqJso34t+dNWngn2he3cXr/U8SngQsVLVpYgmC2K3WotsR/2KcK6D/scxlayys1
 TEQhq8etVaLw5QyjTP9tgTmc2u1rKvNIBquB0meNL2vLEqujSX+TkGkaRrmRmArnyZHGVtULJ
 y6Z6+PKYBFqcGHn6S2Yq+q+uhBsXfhTCj1a6L6wJiHlVGrZnJfRRG0JU2x

UmVtb3ZlIGV4dHJhIHRtcCB2YXJpYWJsZSBpbiBwa3RnZW5faWZfd3JpdGUgKHJlLXVzZSBsZW4g
aW5zdGVhZCkuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5u
ZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFu
Z2VzIHY2IC0+IHY3CiAgLSByZWJhc2VkIG9uIGFjdHVhbCBuZXQtbmV4dC9tYWluCiAgLSBubyBj
aGFuZ2VzCgpDaGFuZ2VzIHY1IC0+IHY2CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHY0IC0+IHY1
CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVkIGJ5IFNpbW9u
IEhvcm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFuZ2VzIHYzIC0+IHY0CiAg
LSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nl
c3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCkn
KQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0
Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCBjZDZiNmMwZGMwZGMuLmI5N2E5NGNiODVh
YyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMK
QEAgLTk2MSw3ICs5NjEsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0
IGZpbGUgKmZpbGUsCiAJY2hhciBuYW1lWzE2XSwgdmFsc3RyWzMyXTsKIAl1bnNpZ25lZCBsb25n
IHZhbHVlID0gMDsKIAljaGFyICpwZ19yZXN1bHQgPSBOVUxMOwotCWludCB0bXAgPSAwOwogCWNo
YXIgYnVmWzEyOF07CiAKIAlwZ19yZXN1bHQgPSAmKHBrdF9kZXYtPnJlc3VsdFswXSk7CkBAIC05
NzIsMTIgKzk3MSwxMiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZp
bGUgKmZpbGUsCiAJfQogCiAJbWF4ID0gY291bnQ7Ci0JdG1wID0gY291bnRfdHJhaWxfY2hhcnMo
dXNlcl9idWZmZXIsIG1heCk7Ci0JaWYgKHRtcCA8IDApIHsKKwlsZW4gPSBjb3VudF90cmFpbF9j
aGFycyh1c2VyX2J1ZmZlciwgbWF4KTsKKwlpZiAobGVuIDwgMCkgewogCQlwcl93YXJuKCJpbGxl
Z2FsIGZvcm1hdFxuIik7Ci0JCXJldHVybiB0bXA7CisJCXJldHVybiBsZW47CiAJfQotCWkgPSB0
bXA7CisJaSA9IGxlbjsKIAogCS8qIFJlYWQgdmFyaWFibGUgbmFtZSAqLwogCi0tIAoyLjQ4LjEK
Cg==

