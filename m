Return-Path: <linux-kselftest+bounces-26520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B7A33D48
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AF169C67
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13C2153DC;
	Thu, 13 Feb 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="GEl+k/vv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827D215186;
	Thu, 13 Feb 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444451; cv=none; b=FsZkdB30k+TYhbIkq8GPWiVwepfTIQeBtZn/qDW2MWiE0nWDx+KTz8D+Qw0M+M54mbhNxeetHfTCP8nNt6rL/ARyq/IkXxiz8nJ9M+mbt0/8ZStCbuSuO0wNAcY9O227cRfTmCzIqnmOQ2E/z39TbuFXQR2tR9DHc0RPWS2K+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444451; c=relaxed/simple;
	bh=Nb+18u6dxzss73xiMuTmJSti9HZANdIn+npFY3bUP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxqpYi7XhdutmOfkSaJNTHRGmrhN7ZMMGQf+R/SHGArQeCDq/UAv/M4UDLVVvPWEYc4NoHWEF4wbrnLyuXE8Sio8AdwdlAxUMUBk0nAs38q6b9s2EePmtqrOH672Kg78QLgdXkjI9kHT2ntBfxq41qH6qCXXCjl16PI2inEnEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=GEl+k/vv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444432; x=1740049232; i=ps.report@gmx.net;
	bh=Nb+18u6dxzss73xiMuTmJSti9HZANdIn+npFY3bUP5M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GEl+k/vvjfDE6NFa/mx96XfKbUPnwgZAsW1dj6e95rk90Yw09gdju0trc4wSY/iW
	 D0LDsTnh/XOv9cBVIq+hBd/nuJoF92xs3+nfVTQ4Llb+4fHXdwKXNYe49lLyrvyRi
	 tmwcsp4higY/4G0BYSMOpUBVLr3x/x2MO40H1BOqP99r9Kdd7k5lW7Fm5+tiOzRNi
	 nq58l9DHVcNCAXuZak0levqY1wwEIXS2CKptHJGq0TqZoR/hhxJshjXXpFP7YOwib
	 gBRoCOLVEeFjK36GqJPb6yC/uBjBPUp8FPUMagcpp53oZHyklf6Qyywraf6OMqz+s
	 kExBMhyCM+/LL20gMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1u2ntl3FLW-00TOXY; Thu, 13
 Feb 2025 12:00:31 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 5/8] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
Date: Thu, 13 Feb 2025 12:00:22 +0100
Message-ID: <20250213110025.1436160-6-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213110025.1436160-1-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:lVE8N2XAZVFgPz8UKLFoc9+I3FMaP/sp7eC048MBIjExEnZD/Dk
 gJOsrBM4OipYfTbV82cQKwO3DFP0kdZpAJrn3nVhFaI7C/G+pdEbtflycz/3x4ir+mIiRQO
 6vlzgFgSfz9Un6UiefkNUweVA0Sup4QIsnDxWrqoEzq+8pGfmLYZ0M1AsGoQF3QW9pa/0z7
 orlyQlaTAesg46yi5NotQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ymBp67SIhqU=;XcvGe87EzsLwRr6fy50a3H3p5rX
 jIk6zcTVWiFKr0Qubmie/HqIK1VnVqX6ny7TxJrZ2ZzcmKbIAatx1CJz3PKDzkuiaTDMpiBSC
 dEUJ+om+PZx/yWigB98O77MPW+PL5nzTgjYyJ2+aq0wqMXhe3u84PrdFKIVMvnWLHaGS5HYWF
 dDVlEysfJmlQGqaHXQnEwO/ZI4WduHwKEFoFBfb8F9Q3DLhbN1Kqec+iAvjBov190kYehgKv0
 FA97yaIZQiQhTV9JEGbnJuMqJGELCxNdnGLeG3pqZH5VTvry2X4+lzp4kzwROjW3xlljMUEg8
 /MBqT2MSLVA2E5XUtI/J7vB5fzfW7CoB4V3fRvZ8mymr9KDoYgg9+UtnMYRjFL/mYHOgtDrGD
 wNlz0AJCMy2PT7U81/4X8fzh44ymNeR2vA/sPwIuhPSCMeEXUJs5aVhkrH8/HL/5s8F439PK6
 /ijvksyQiE7Vp1WPhZVQI9DPI1I7oiRDHOclNflFoqkUBkCT/dde2oLhOQpHt5rkhHgJGLrQ5
 TAsUtm8R9ggy9em/H0/RC1ahelBuP343356sXvmNk5/euzi4NeZsuf22ZrqgE+kg8Ubn2sSqF
 6hK7yv6J9Qnyn8A9IURztHyxT1tctUW8pd5legglxOz+8H6JkNBy0SuHEByWZLlTiC2+oQRKv
 tGJ4Ns+VZf+HVu+KZ/ztkduIAW8S3TcIenKVWKm2Wd48Ew8D1mS099vw5E7kSLvasl7Bb3VB0
 OuP2HCzwzhA9Z/vzh10D0Lu3yHat51wcsyUJiOErS9uHC3pdXlCy6z7umihCMiFHhzIqJuxRG
 unTZ7wJC8ophzcBqXuiYKnUaYdIHnJ7hq4to6Mie68vLvFhtiF3goBVfIn+sgFP3Jj33eSzZN
 nwU2kVao8OotwpPlE3eDUMJoE7jW3T9itR7LohTkP+sJ9dE+ZaG/vXcGnsysuIEj/jbzETzEP
 mQpZkas4BHgcebuYET36pD5zsopqnP+mMii6n5R+BLj/cg4Qe0imhWbEL7vPhxl/UQMnf20b4
 iwwb2cXGddcY3usqMalUbbMbG/ABc15sUjymcjLeA0dZt3gONCvuDA7raup6UkJ2pZ/aFuPIq
 l5WrR0AuHtzEWugWNrrj7Z42r7xin5ySINwGGosB8WCycat9FpbowUolVN3+bBVzfy5WGFDlX
 a2l9EvFnnPYHn2Kd9RHuyyhaOv9u9Re7Z9CDxIdEvQXClkaT6B9+IP9oHliz7EmaHEKIejfRv
 yiR/DzusfrsJ69OqufRN8v8/ewlMrv01Bw3yRM6FLUCioDC4y6mKbR555+ntt750zCW0v6H2n
 ZW5MewkApIj3uXfMRYJuFVXLKw7rwGaLYXNO6q+tIBylBh1wkQMO8h0U8g3GPl+hJ09hvxvMd
 Ix32uNUl31PnP8RBu/7MYMDRvWpyCKqATS8c3QwhmeXBHMaDpo4ThGjVXTQqN9qRUoGVLidLP
 ta2Z3IQ==

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
IDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0
Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2Vz
IHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoK
ICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQv
Y29yZS9wa3RnZW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0
Z2VuLmMKaW5kZXggNzVjNzUxMWJmNDkyLi5jOGE1YjRkMTc0MDcgMTAwNjQ0Ci0tLSBhL25ldC9j
b3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xMTMwLDcgKzExMzAsNyBA
QCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAkJ
aSArPSBsZW47CiAJCWlmICghdmFsdWUpCi0JCQlyZXR1cm4gbGVuOworCQkJcmV0dXJuIC1FSU5W
QUw7CiAJCXBrdF9kZXYtPmRlbGF5ID0gTlNFQ19QRVJfU0VDL3ZhbHVlOwogCQlpZiAoZGVidWcp
CiAJCQlwcl9pbmZvKCJEZWxheSBzZXQgYXQ6ICVsbHUgbnNcbiIsIHBrdF9kZXYtPmRlbGF5KTsK
LS0gCjIuNDguMQoK

