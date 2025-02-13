Return-Path: <linux-kselftest+bounces-26518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B6A33D44
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D3A188D5E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99272215055;
	Thu, 13 Feb 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="P4y8/7R2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A813213E72;
	Thu, 13 Feb 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444447; cv=none; b=YKgnf/oim1QT7aXnMI9X8v/JkPJOGJLukCOa7JoTNE18wJz0uQKIh9N/MMbI5e4sRemqd0Pf8LvwfIuhKRN4Ep6NityNii7k+mSmbp6aiVVzc/DpaiYMZv+HUZYUV1mRzg22rs3urpQUKgC5Cz32dUdWEUqLVeo8YS7sBm83FfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444447; c=relaxed/simple;
	bh=hxydDyBzZ4c6hD/NtkF9JrGOU+bj0TgfnijfxF+Vem0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9SeG7hTbQwmlHPea7bEf3ikES/nBqS8KHaH4oVOZNUckIBHBkCuww3tlW9nX1xR9fsH+8BsLORuZ/T4ZJo8ce5USazVMx31pugxZwWxNcHs+6VmlY2an7JcsJbh1wnsbprDJ/acKyhkiINHOMrUQusLA1NXUg/u5dboXylcFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=P4y8/7R2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444431; x=1740049231; i=ps.report@gmx.net;
	bh=hxydDyBzZ4c6hD/NtkF9JrGOU+bj0TgfnijfxF+Vem0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P4y8/7R28Eb1W/E2+bU/0s1VQQCycGVr/oKRKWeEQY8EdtUyLPdZcTbmQeFVS8pu
	 qzhd+s4LvkS4TzbriDXc6BfFsFWfTzjOvV1oLZMSVgieIR+rsuPPIKWtlxjJSm61f
	 ztbkcR9+sAY3o07QYFQJTe0iGwMKyLVWGP4Z30GJeP0X8YsSQNhkhsl52DpmKFUoC
	 atTqjFn7OR1IWf/uogGHZ56CBHPjksooelKD0f/EUwx3g0eC8y+aTfcd+TV289EoC
	 HvrG34IHYm0dm2VADT6EdKQWSwTJX6ukQnd3MAnDRwYwwVrgrARFZlVqVbsj9LYSV
	 mPWdsUl+mNO2hwlyUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1tDZrL1PXs-00i2mA; Thu, 13
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
Subject: [PATCH net-next v5 4/8] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
Date: Thu, 13 Feb 2025 12:00:21 +0100
Message-ID: <20250213110025.1436160-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:YzVQtYNQi61tbRkgzwDjInGaRF1YZI63v4VPiUMRjN7T9Tq5400
 sh98uq2nZl47ZTXw9XkAitFbORDaHwk5KX+EWJ8z9tapJY4XaR3OBh9jBO4KncAAqMZJG4V
 OF5iyfifYz3KtGNSfWXituTvdizSLwTrA9/ILEMrRiu2QoVonFT0Fmp2SqbRtKpKFr2fhv8
 Y4TXdRxXnm+Cze8jgTzAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0hGanSiS7S0=;a0EFhtqWFyutdOQX1jjs5XiyUuT
 DwTvQf0I7JkPZCrQGhrSY9APAezn84MtppW5+h/uvapxD/aIu3kp9v+qoP9j+qIi7nWCh/Abd
 FomQz6ugnLHAGpkVNnGAsa3jC9F7gaVhayO4zB3kuWbhHpkSqqoXFiC7rIkogi6wU3GflVI8F
 mT3/K5AulLfiWJmuMoFDySFJ2QnhFsCUJzdNZpLbmjfcGhb0d5LMXILeK4vqLoup7vDcPlC5g
 o0X4ckEl4LeLEyMYGxZhdBpeVeTK0SWWKS3MAZsREsCyltvWAy3tTIehqHL7tomT2t1OfIvZE
 0exFSS5eh5tMQNOh8rOtWyrARhD5cZd+vlI2b6Puu37hoIULAtBVTRhdEdknjk9dG0P/3NiaP
 QA6uhqUs4GfxUwYDrfaC77VRwIlTXho6JRdle5TRqZW+J1OoyCgoptjgFecjAaUFo8vwKkVlj
 NSNummzv0aZvlnHUfNbU7lQEOPlkmUHIWufZnaYMOwmrpixWfKcz9fiFd/oJVRE8EnjX3QWbj
 UxiBHHmAlBiuu9S+rnSu7H3jVrRa1m+UCsNf7WLUSsWFR8bnVG1CDiCBnaflsOkjSPx589/6n
 +03YazFvqiflMOYKoSAcoT879yAGGPnY/mUqQWrmF+zvmfgCZm0cudSUNRJl8Pe+0nTEGnLwQ
 TjWks1xws50c36lKHqU2/grxFsBKIdiP9J6n/S+uMLEayqGeG7JAftQMrHFgGXUnsEQnNUbxv
 BzJ1Bkd4KfB7omgD7ZNy4CYfDVl6Icvsmu3Zu870I2fdOQIBJvaGxXnh7KD8v4VIbvG0IM+oN
 /iVWAfq3eg/r/8BVXWvdAS8MEp3GpIUqk3N1Yy0nNShNbbzkofJwU0pciOIm77vfdmHhMR7Rx
 OOCdT13LgqnmOIoH5QZqvuyPPJP3vsBtFBCftqYSTE3oADiibgb5DuVll2vUnb+wk0yptildr
 ItuZw/ebSAVi5kzVyfjCcS1T9iqqaKC6aESFaXwmHiYIfkUVabO5OF0lKt/OEV2Ma08V4oNFz
 8sV4g/VWACjEP6ixLJL3E9uQKhOOocv4nf3AwJZMILWqOnsWMA+ODD1UjrcBNzcyALnmkg1AB
 2QLtqcyozLXrq5SCDJO/43OzSnyM5oIKjTnrr10Avt7RplDu3EtDyH8azYTEY3U8yXsWEqvY8
 y/V0oA8DEKH50ZBGDNUu/gdHjiSoqhvaNyrpo4qcxYQ7unuTg7TfpyunTBHVqdStSfLWt42/V
 nSnCvR9bDjZscIap9MrYSSo+spRQqj22d5er2atLgI9QAvCl3B6nB0+o0TgdDN91VXf5tpQ8v
 FR6dxWA6DfsbSto4OsT0JDiphPab/usDXiMKyhzs65zjaMMP/flNdbn8tk3Gp/Mamew80Oj0/
 o351rhfqdmEfKYZrOjTCeuSntjdzV3oyQ0wvOTPUmPaeMgHOVpWop0hOWO

R2l2ZW4gYW4gaW52YWxpZCAncmF0ZScgY29tbWFuZCBlLmcuICdyYXRlIDAnIHRoZSByZXR1cm4g
dmFsdWUgaXMgJzEnLApsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcgbWlzbGVhZGluZyBvdXRwdXQ6
CgotIHRoZSBnb29kIGNhc2UKCgkkIGVjaG8gInJhdGUgMTAwIiA+IC9wcm9jL25ldC9wa3RnZW4v
bG9cQDAKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBP
SzogcmF0ZT0xMDAKCi0gdGhlIGJhZCBjYXNlIChiZWZvcmUgdGhlIHBhdGNoKQoKCSQgZWNobyAi
cmF0ZSAwIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAiCgktYmFzaDogZWNobzogd3JpdGUgZXJy
b3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9s
b1xAMAoJUmVzdWx0OiBObyBzdWNoIHBhcmFtZXRlciAiYXRlIgoKLSB3aXRoIHBhdGNoIGFwcGxp
ZWQKCgkkIGVjaG8gInJhdGUgMCIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgktYmFzaDogZWNo
bzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2Mv
bmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBJZGxlCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlk
ZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY0IC0+IHY1CiAgLSBzcGxpdCB1cCBwYXRjaHNldCBp
bnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKCkNoYW5nZXMgdjMgLT4g
djQKICAgICAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAt
IG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29y
ZS9wa3RnZW4uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2Vu
LmMKaW5kZXggMjhkYmJmNzBlMTQyLi43NWM3NTExYmY0OTIgMTAwNjQ0Ci0tLSBhL25ldC9jb3Jl
L3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xMTE1LDcgKzExMTUsNyBAQCBz
dGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAkJaSAr
PSBsZW47CiAJCWlmICghdmFsdWUpCi0JCQlyZXR1cm4gbGVuOworCQkJcmV0dXJuIC1FSU5WQUw7
CiAJCXBrdF9kZXYtPmRlbGF5ID0gcGt0X2Rldi0+bWluX3BrdF9zaXplKjgqTlNFQ19QRVJfVVNF
Qy92YWx1ZTsKIAkJaWYgKGRlYnVnKQogCQkJcHJfaW5mbygiRGVsYXkgc2V0IGF0OiAlbGx1IG5z
XG4iLCBwa3RfZGV2LT5kZWxheSk7Ci0tIAoyLjQ4LjEKCg==

