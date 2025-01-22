Return-Path: <linux-kselftest+bounces-24939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01512A19437
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132AF188D592
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7462147ED;
	Wed, 22 Jan 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Rf9k1Ya5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EE2144D7;
	Wed, 22 Jan 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556900; cv=none; b=DEhjNs4UStGFjYTmP5gaOdHApGTzlO/g6g6cMUtbRBLNQbd2Zm9lyplOLDNL1+BE7XomNmidW7Lkx+pu1ljKDzKTUr7N9AimFSRxEEmeyJcdGoVi8sIA+AYalnIJIBG+QvI0wky+pQ8BtfC+P/38w1y6DHYOl1xPbKwHGiTkmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556900; c=relaxed/simple;
	bh=QNioxeMF5QY+yfijWq8Oz+GP2w5KHG1Qp+4ZaEPJKKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCvI5uzdOlKY6rHiecGPhNEpxBJOvqIQ2mx5ckH4Fz99rKwU2kWSJcQmLVrN1x0Zoya9oGSJRNWxv9Csuk1H1dE/td7xoswg+rXfYORC89AS52gSILi2z1SCamiEKtfskbUfRV/+vyDi7NLO/qiTvP3hcNcL9QzCKAryAeT4Svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Rf9k1Ya5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556892; x=1738161692; i=ps.report@gmx.net;
	bh=QNioxeMF5QY+yfijWq8Oz+GP2w5KHG1Qp+4ZaEPJKKo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rf9k1Ya5CjX1eW/IQ4/DBm3alY+rup/KMDC3Oi7d57Qft+deelprPpYXbhC19kHD
	 Kv8RtEvgrXVnkLDmzMGQ1XKE3F3g8KZnf4pcvwA7YzD6TWFQD5yzrrH0bbdsRVvNw
	 prRcLdjujive4pGQpHNaVi9Wz0YvgiccoiRRQXJkJIbxVD4xej9KHO/Ma7KhDZKzF
	 T+h3NcFwYq/URLNUEH+ybAiCTeLCr8q2ZO5+sm5xAnQ7LSym0uTeboNtALvXhXP5t
	 4d0EVe1fZ71oFdEosesONkSwlxdbf0Q/EfHjfMW7o0OXMrflEMVQQKcOH6TnhcCKA
	 rzwLA0PZ4o0bMhRtLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1tgAMp3bJU-001r36; Wed, 22
 Jan 2025 15:41:31 +0100
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
Subject: [PATCH net-next v2 4/8] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
Date: Wed, 22 Jan 2025 15:41:06 +0100
Message-ID: <20250122144110.619989-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:MOlpTxhwS2bv8sL4JbpGptY7cZEIgDzucj7ui8UQaDMs2MjYHMD
 F8kRVFKMLcZnte8RIxKZ7FGgqhQSDjfUCISlmgE0KkMofyDJbrTeAVQh2oWylxxl2skXbHu
 lpx9XaRslaf3wuyW1ZGnTi/wkIIxfv3lFUJTez4pv0jPJzL/fwofyZlWLwTbk2Ss7Ea+kxI
 9Ja5CeUI+oxm7ZV+1NlVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OJyiNSrDKdw=;DSqCLDVhN9Rb3SLZaUQOnMpXjp4
 ybvonFkNAcv45FBedk4iJ5XzFWULf4OArnPwAuPtlU3W1RPzXTpmhsmrMoO5HWEbWMuNmShYX
 G9N3aSTqy+b4B3AqG5bSRuFDB4XUY86r8VC9R/vxfaFlhe6EtZk7yw/iFqoGsD0+jnlr4Glsq
 xRHwcPHk9oVFqU9DkLpB6CCNZbQxdhpjxBptQT2WEaM2+8/40Zy4VnMHfBBIhfloirzVz1dzU
 MjmIqezZxooemTP5b1yXhVhkfqQTby1PevhQJ3yyPsb9REyd7iakBDNLXGO4z/9kYhhsiBt9a
 0co+K2bv5oMBMyuxn+PzrZZdySMNrBDlTYYxOeOn434lZteKkIEbVZEx+yiVmaUpYDL3nX85x
 k8jKlNja5F5+6nkr2KxR1OhZ2Ka8vWkhFEo6sSizZdFX+G21Mz6Iur+WKtoZn6p8d1lCL3jDn
 0RndQhtc2HX4jnIPUbB7adKBYaxSDqdF5mlV7FZMGM1sS0bI8qzBt/G0e05xJAqgN8ZtWo74W
 KPFUHcr+Yizg2qg7+OPg7/LKL82mgU5hMKU5rUsj21o0byqy5A9Be/1PdtCCaeaTzssxk8CoJ
 gQjNxOEgUxUSJTD2Pc/GsDIkVAlD64WAC650epW2AUN0XVFG3t5wLvEuOMcwKRBYcvIMD3QW/
 ccwz6b68pz2jLa1cYrp6Pya5W7yXWG/UNPheyKLGHxc3UvSLK+s1Sew/2TOlWPvOWZYGwWcCY
 rLb05XFxHPFbzvSy/iPCY5A7gOYdL1G8T5nSFZp3UxxrUEuZO57nGzCJID2Qrtii126bJYgMr
 4wZguLUKYm9CFWPsvJ0X2KLUmzQ79Jhq/TW3l0UX8mDXyYgRl3/TAns+lFzKCDVAffDhoR07T
 U1gLHebC5VPXnLhYYA0l1f7U8Pp4v7p6vl4KlbNf0TBNpZsNFnSigpV9yRMYyJ3luI9QNMZm7
 K0ii45Jf6mkhKEGUBlUUu/ejkDJebrHNqnIQAA+vnsu5oWeWCZND9+FPdye2qEB128a7ySyuy
 0Cc2bCpXtUNyVlgljxR6VHW0dT+uq426v0c+EAw/gqe0foZSQKJdwtdvSATyRF2PRon6xbX3b
 i0g80p8gyCQNw/qk1Lb9fkpf0v+YhTKcevvRiwORwHa0Jom5m2Ya6Jf/5eBsAFSB31k+cJBDl
 PWqCKkw7uwWbBlNrSSOFMml7osISiiomMUIyUF+0xdA==

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
ZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQpDaGFuZ2VzIHYxIC0+IHYyOgogIC0gbmV3IHBh
dGNoCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBi
L25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDI4ZGJiZjcwZTE0Mi4uNzVjNzUxMWJmNDkyIDEwMDY0
NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtMTEx
NSw3ICsxMTE1LDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxl
ICpmaWxlLAogCiAJCWkgKz0gbGVuOwogCQlpZiAoIXZhbHVlKQotCQkJcmV0dXJuIGxlbjsKKwkJ
CXJldHVybiAtRUlOVkFMOwogCQlwa3RfZGV2LT5kZWxheSA9IHBrdF9kZXYtPm1pbl9wa3Rfc2l6
ZSo4Kk5TRUNfUEVSX1VTRUMvdmFsdWU7CiAJCWlmIChkZWJ1ZykKIAkJCXByX2luZm8oIkRlbGF5
IHNldCBhdDogJWxsdSBuc1xuIiwgcGt0X2Rldi0+ZGVsYXkpOwotLSAKMi40OC4xCgo=

