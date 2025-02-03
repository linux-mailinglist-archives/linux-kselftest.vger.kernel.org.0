Return-Path: <linux-kselftest+bounces-25578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BCA260BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3408B1677BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6420B7FB;
	Mon,  3 Feb 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="pgDvH1Tu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABA35956;
	Mon,  3 Feb 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602152; cv=none; b=rWxsBpv0N4G58aeLGNjJdvEGOIcVuMDF3pJTLR42o60fZ7nG2tnhPGCB8lLVkUoEFPRhNZ/l8dMcBjdtOlR75msoiCFDZxIUPnwYzV6yydNOfsZa0LipNvRMva39h6H/mSpn/kdrcvuZDrBAPOVKWUvlF0wV/HyL+OPibyjGJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602152; c=relaxed/simple;
	bh=n9mHnyQBpGX2PaXbfmTEexmi6lJrevaHr9yjIEWDFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRa6oCinwnYXmFlHdr2732syc+G9C+o+zvHH2F9pX2sJeNOgpuphDUeCFSb4raIphRSI54JcydK3R4iEbK1cl9neT8mj6EVatyLkOEPE5T75BYonLbJzfaB8qv2P8jJdWcdFT58YeD3egxJEGjusOSzAnJMF9j7UZo/2bXns2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=pgDvH1Tu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602148; x=1739206948; i=ps.report@gmx.net;
	bh=n9mHnyQBpGX2PaXbfmTEexmi6lJrevaHr9yjIEWDFnQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pgDvH1TuUxllvsKVdkXZTdaKPqZRFRa9XC5iiGld+0vJSN727IsNUX3bA9wzBm35
	 i+1Wj0bUJFOuv5KplpBxPPlanV/C46f//JbPtDtopmaDw97BexFB26H2+BaLI6o/j
	 vWS8vGc6OuPQxfj4a30mlLLrtf3HzZCggzSE7H6SxuM5BUfQriWJeZLpCkX7ffYoz
	 DgBzJgIu1OOb6sWf1Jkn/ijxSXTkCZoV67N+jx9ntYgp/378KmyZZ7fWOpT82dMCE
	 8DuZc7Kngen2n4tOjv3kzL9g69/6uOGKiredlUaJpG6ML9SZXMdGaVM3LbKAMmBwY
	 2LDkuogDs+PeKNVIJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1tny8T2yZ7-00N4O9; Mon, 03
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
Subject: [PATCH net-next v3 02/10] net: pktgen: enable 'param=value' parsing
Date: Mon,  3 Feb 2025 18:01:53 +0100
Message-ID: <20250203170201.1661703-3-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:hnOIbvEvZwfC4iEQwmqOb+GBzBpX1aSLGc3bBjMTaPMVmqEC5EF
 Amr0j3WMkFWM4KcYo7b4aJ6FqDLW4kbL+oWrkYYP/wb0yncOhpzZHO/Kxft9bTsKi1qf3/f
 gK0PDaNe7k5+/ZWp/Q82iC4/FY+G9Ry33LsAmm1oZ2U+CYq8MPRkL+WGEsrceLIS60dfFW5
 i1t3qzocxo1YiGODaFgFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZDaTkaW5IDE=;mmWaM3WnQ+io3fxvUf9tt1Pb35e
 RosCDt9wDZ/RX36lrhYte9ZX7+Y1pPN/E1BM86BoQpo4AEEYG93bZPBV31E6gJ+kTzLnE9AYn
 symL5S6K2EtDLHuTKfQ5efVkS0fB7mI/kCDQjam+qOYef5PexTnBSyJg1OoAipYGUzqE+GsPa
 tLf5KBwNkfubwMCTT+yXDU2YXLEXC80f6RQtsT8zFkvQy3EfNfJdFKxj93InctVoVj9US1ZZc
 iAHpDsLH05kvKaETcgvpOUf2NH/n8VbU7f7S/zcy8kBYD454y4vMAcLphiVn6uz1kTNua+G3C
 HGwU6oqrzCVCTmDaYaAXDa+H623hqWgXi+GbOf60n9NAHwcxihbx9Nbeg6pWXDkYWEDYkOxJ1
 qUIzvdrN9WlqB8VSYZNOYPJ2Wp+VpW1Krw9FnLwd+ht7CT6qx9Mtm0u28XYI4OU3/Q+Ur10ZF
 L7AqcM97KDUTuT5whK+lVwGKaxgr8r8evK2s4eFs7TOecOO4HOaqF1SRp6aUSCEnQOA8XPZlk
 SJeUg9x5EAqDwkK2weL3U2c+e+x7VJKRnh53Hd93BjJYdJ9bWYFHTkHoDouMie0iVan7sxheK
 YX+/FrMlUf48fGqXL9bPs1Q6FH4J7T+UD42warPl965pog3RrW7zotgsotQQvK79ulTUD1ORK
 cDOnQiy+mldub76ZTDBmbeUFUBhubWC1Ryg1ChvraO+AFUyJzlssvLdPjthUIfdvYvVDsrbvn
 7uf2SsqFbs6C2Hr2v2DCNc0PyJe59dlmVOCuGfM98i/fi72e0lrhIk2mpVQT7QclWaj9wRhHR
 9R+N1ddfW5Nfm+HHUUuFGeCzzJ3ntbGaUKOzgVPTnZ3TASeI+4tTszHcpqI5ZItULVFlbHHao
 hZAF25kvt4YQi4fI++F1Uo+p2AKWKsgQWopTfA8F3/HVr25NVlOz6r4r0LD19am5Fg0PATwdG
 G+ByfrQa+eiBXaurO4vePwX+KSXjRgJh1OCeXBhe65JHgeRlkWeqJcWAwgOUcE1+/kP20iEjP
 arFWXBh+bxWFBgtIPQFzfNOYZIH4LQ3LNZCoEWr58m3u6YH8lH+VdMtkZVSDFNsOG3+hSpcH9
 k4tb/InStxWIFkH0m1bYsx33ojPHPX8Ik59EJEmFI+P0DowsIb9We1Axls/7OuC7vZjkZI8Kb
 bWlUzQ93NFFhGgVRP2t7icwKH4ypChcvTLSR6TGljeVNyQaOleRDm/ZmMmpS/e3mWTxOqyeey
 ++b7i/c0wQ9XJU4auotwsZHcVci1xLAtzZotuSBhu+9hp4G3AT7cMW4QtEY+jhibTtrNASxi6
 Wy4Qzt7GwbQGiyy9rp5UJ2aN0oGpd8OeWmQkmcEzmVpC0Y=

RW5hYmxlIGFkZGl0aW9uYWwgdG8gJ3Bhcm0gdmFsdWUnIHRoZSAncGFyYW09dmFsdWUnIHBhcnNp
bmcgKG90aGVyd2lzZQpza2lwcGluZyAnPScgaW4gY291bnRfdHJhaWxfY2hhcnMoKSBpcyB1c2Vs
ZXNzKS4KClRlc3RlZCB3aXRoOgoKCSQgZWNobyAibWluX3BrdF9zaXplIDk5OSIgPiAvcHJvYy9u
ZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT05OTkiID4gL3Byb2MvbmV0L3Br
dGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2Vu
L2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9c
QDAKCSQgZWNobyAibWluX3BrdF9zaXplID0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAK
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCkNo
YW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHYxIC0+IHYyOgogIC0gbm8g
Y2hhbmdlcwotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3Br
dGdlbi5jCmluZGV4IDQ5NmFhMTY3NzNlNy4uNGY4ZWM2YzliZWQ0IDEwMDY0NAotLS0gYS9uZXQv
Y29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtODIzLDYgKzgyMyw3IEBA
IHN0YXRpYyBpbnQgc3Rybl9sZW4oY29uc3QgY2hhciBfX3VzZXIgKiB1c2VyX2J1ZmZlciwgdW5z
aWduZWQgaW50IG1heGxlbikKIAkJY2FzZSAnXHInOgogCQljYXNlICdcdCc6CiAJCWNhc2UgJyAn
OgorCQljYXNlICc9JzoKIAkJCWdvdG8gZG9uZV9zdHI7CiAJCWRlZmF1bHQ6CiAJCQlicmVhazsK
LS0gCjIuNDguMQoK

