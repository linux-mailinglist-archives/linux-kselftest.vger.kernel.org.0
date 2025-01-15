Return-Path: <linux-kselftest+bounces-24562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B3BA12123
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A3C3ACA7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9A1E98F1;
	Wed, 15 Jan 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="JdRklQNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EC248BCB;
	Wed, 15 Jan 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938365; cv=none; b=M7VC+Chnc7pSVRIk4Mmo5A+6Z3yYv6muO4paX1j3Z3jWKWSZtKpZPtIqAYgNjmCBIUCs69D+ij+uhhgYS1fLhFDt8zml5T0tF0XVtHdvtHA5xLFR8f2bapVJ8P+IjRonCzNh6P07JcTeUNQy36B/uB2A8p54khOJnMJgjC2rCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938365; c=relaxed/simple;
	bh=SchB+c2hMhcWnD510+6n34YKTHOVJ4nmQf/tY/QHnng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=biz0nRdu0zJDrimjQdJ9TwcdA7JTr+PLKL0Z2iXWtIMoYmawxORhRlBcvcsUv1IWBZN5qGU2WCsML662RGfcSl7WY7EhBcHAlxMVIFMHkSSdu6heq1Yujn3O5W0s2IiKD5Wyv08ZEyzbIM8Icbt+0zn+U7lCCePtp8wtXnGad90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=JdRklQNq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736938361; x=1737543161; i=ps.report@gmx.net;
	bh=SchB+c2hMhcWnD510+6n34YKTHOVJ4nmQf/tY/QHnng=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JdRklQNq0YmmFEsE3b/sTSoVoDBN/dLTNTSBrChYdw+EgzGTjJq/0mO6chIh0jfe
	 /a+REtPAd4DfoT+MSA6aWiU9pi9AV/cK49I7n+tXMRC3XchAeU5wj0ZO6XzVvoIDC
	 oceeYtVotC9os/fYpWrAfhPzyvMfvDOME18Mi7VG8ceTQEKGLoW8Vo/+9wFUjp8Cq
	 SYglDPJwtlOd+K2M7T9Fu4SI4VZw1pxF/eJfOdJ2QUVSW8HtNoYFd2T0d8RE8M33U
	 XrTbOZgiEbuxcqhEebzmUZlHa9wXOIYuVGjd5F/SIl4rI7Borm/27j8uRWqnfL5qn
	 HtvpzuDz/rNgmtmy3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1t7nb41KMJ-00cXFk; Wed, 15
 Jan 2025 11:52:41 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1 1/3] selftests: pidfd: add missing sys/mount.h include in pidfd_fdinfo_test.c
Date: Wed, 15 Jan 2025 11:52:09 +0100
Message-ID: <20250115105211.390370-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:k3Ag2EgowNONbBSS1MXcy+E7OWnn16a3u0OSpFfwMlPWqD7YKPD
 tbysRVIlcbpL52uq6YB3hf02f0hBkBLIDbdNhIXz/pekowYQ6Mn+7pDXfM9m0bMGebUrh1d
 gmZ96OwWaiHvV5wjYj4n8ZbwSlE5JHtmpC97PSb7RWZGUxCwuqslS9v6IkaTt7MWI6OYIZ9
 zH4Q6kCQoPoxo1UhRjRaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SiPVOE063ts=;VtG5pP9DHr2Jpu1LoL4fm2p/Xlw
 6l6IrwxZhljoZkQheQ3965KFzIdJTs9FHr1a6ruHDpSBBkpf9g8auElDM/gKyxqWIdLshzLE1
 CS329sJo3TvnctTnxcAwipkg4OE2ehyJPrmzQ0cT+NKGnDi74RQXEvO8awV9ViZxq6qF4YhNY
 eujj75fIXt6cG3oLUaePVjCp4UBuUlqCnH8M9s0VKiFMG4EXl+ZkCwwr02wK6hWyasb7Iw1se
 XUjKz7J24BnuI1L/3IjY6OB9ipbqIwTUr1dUX/LxsuO86IHMhyLCGw/XerTB/Jus4WB1h7INf
 iZ8Pm1IuyJHgPpzLUy2q7+EzxDwOsqBEw9Qx7n84t8mkrKLYUZc9ZSQVym+zRtTvtJH6c4PG1
 vrHa6NlqvDhtXJ2g4W2xUQpKTYN9iBJ5n7d8huQdbTIHKS0KQbVZVCIWdflqDAan1yI7T2utH
 MP8k6nUV5f4jVzqnbPpO2bz0VmiWc2un4yn41V484wH4Gl6nOXufsKEvYbJmhRO/cDFpvyVWf
 s2muLuA/xCJa4HA8pwkASkJXhuLlb8PtuVVEaEo8dC6Rviuz1wNJMlh04U3ExoxG6bUNxePlf
 2R8/7ji3Dz9Fp639sh3Uuymze0LJzM4EMhEGYa9DECVv2pNeaFFllsjA6PB7v44lcU1meiGQQ
 wGBza0gcaahbFQoKP6xaLR0EXZ+hWbmTaZxR0Uu8fSbnDJJupfQGz9SlgXfJer+pbUlLX/kL7
 bUG2v+dj03eHG1czdT+WbU5d0hQQEQ+j6nP/6zIDrKwZfa72SBbdLgosf9RJH5uph9K10/u4c
 naZDIzKTYQGkOuRpOz+JGMjOE/toAmUuYvTMyKC/yB52Dn6TSWcl2BDH4pIq0vmcSbQXB9sf8
 5l+lBVzl1rkoUQAVth3VqaXuLgUAeZJiuR4kLWgkx8a4jK5ChizBYle/+AgTL1cVN6pKZH9LG
 FsqOZL5lTQZWcQgPJ2kBboYT6mIqyxWX29a5d6VRzmw7RM1Nb6LIF83859LLSgIqElcgIRsix
 JThqXTllZ7wDhfp8zCGZQOZo2aeb/buZTQMCJcLMHTNcUdRrOzngGrfQAl1TNmU9MvSKZYVt6
 5WhIyHiW6mavfXItAu7q7lZolg2PcXNDiIz7X66m5miwseJxbf4F75tgdyRlJZx2N2ZUkuKQK
 cIdGukbrpKf5rZEp1qpv1nL5W3abAxR++02w0MEXiog==

Rml4IGNvbXBpbGUgb24gb3BlblNVU0UgVHVtYmxld2VlZCAoZ2NjLTE0LjIuMSwgZ2xpYmMtMi40
MCk6CiAgLSBhZGQgbWlzc2luZyBzeXMvbW91bnQuaCBpbmNsdWRlCgpGaXhlczoKCiAgcGlkZmRf
ZmRpbmZvX3Rlc3QuYzogSW4gZnVuY3Rpb24g4oCYY2hpbGRfZmRpbmZvX25zcGlkX3Rlc3TigJk6
CiAgcGlkZmRfZmRpbmZvX3Rlc3QuYzoyMzA6MTM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiDigJhtb3VudOKAmSBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KICAgIDIzMCB8ICAgICAgICAgciA9IG1vdW50KE5VTEwsICIvIiwgTlVMTCwgTVNfUkVDIHwg
TVNfUFJJVkFURSwgMCk7CiAgICAgICAgfCAgICAgICAgICAgICBefn5+fgoKU2lnbmVkLW9mZi1i
eTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bp
ZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9w
aWRmZF9mZGluZm9fdGVzdC5jCmluZGV4IGYwNjJhOTg2ZTM4Mi4uZjcxOGFhYzc1MDY4IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF9mZGluZm9fdGVzdC5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX2ZkaW5mb190ZXN0LmMK
QEAgLTEzLDYgKzEzLDcgQEAKICNpbmNsdWRlIDxzeXNjYWxsLmg+CiAjaW5jbHVkZSA8c3lzL3dh
aXQuaD4KICNpbmNsdWRlIDxzeXMvbW1hbi5oPgorI2luY2x1ZGUgPHN5cy9tb3VudC5oPgogCiAj
aW5jbHVkZSAicGlkZmQuaCIKICNpbmNsdWRlICIuLi9rc2VsZnRlc3QuaCIKLS0gCjIuNDcuMQoK

