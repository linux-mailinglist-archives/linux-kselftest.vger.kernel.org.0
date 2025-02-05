Return-Path: <linux-kselftest+bounces-25833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB564A28B48
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC07167BA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B98632B;
	Wed,  5 Feb 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="kwR2v3na"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88774D8C8;
	Wed,  5 Feb 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761125; cv=none; b=ESWgOFYz3fw1HWL/Laj1mfABw72I8wvDGk5QUC5VthCN0KQFXKsHUw+irIMiJJS73nHbmOaI48A4pLYYYoLHEIy2uwAeYYeWfLVJny4GClF4wyZpPE7zwYgQQKYr4+SUYHhmaTYbSY6kL6xj7M3PUojb+ubyTt1J5kXizgOip1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761125; c=relaxed/simple;
	bh=m3aLIhLyvP29mQWbNEFuclTwYtEMnQZJ/T4J4oNy/b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAFDVPVvUUAZzaJ2PCVwft7Ay6djKyJ1H+VAVYo45W9mAkqphFfr/KIU38rEo1eYKUL5PGvJ6tW5XPSkkMen1CnpipHrEOLT1N7rRGblETk/CzEOdviCk/D68zy3uSAxkbmlrxKMo2KNAU4sW69WU39bcL+X9QB7kGuiXdTufCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=kwR2v3na; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761122; x=1739365922; i=ps.report@gmx.net;
	bh=m3aLIhLyvP29mQWbNEFuclTwYtEMnQZJ/T4J4oNy/b8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kwR2v3na9Pqe1L6DflmuPYiu3ezhBIiIVa1jksJNDVyxWiMViqvBIwqBYksTGQ5F
	 6Vsg03q+r+rRnPv5JEqt4n+Cr6G61U/YRJN35c/earnrGVfSltBWFEV7h3JhkVAh9
	 g2RV9u+zri9nVF/71tok08HeIgdQAIziRBN0dI9asWXrbLUos6sSNPY6oiNt1hgm+
	 FRBAPtvQ8p7SUWGde41FakzrvgLbZ+b1xXyDR2HnVZbbIjVVaYiY7hdN1RQecZNMu
	 imJdJoMx598M8y+hGIjQwioKmr5g97RRD/lDLY//e8JIadqPxxxdHLbwmTIiBpWo3
	 Ff98T3auzTwcLlxNaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1tz7tI3z1l-00PSot; Wed, 05
 Feb 2025 14:12:02 +0100
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
Subject: [PATCH net-next v4 04/17] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
Date: Wed,  5 Feb 2025 14:11:40 +0100
Message-ID: <20250205131153.476278-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:Q7c5+6HKFiN6IID+pbOJ6Pa5dw1pyp1hIcEtn1H6jc6DAPddywa
 2Sv868h86FJb89ePrOhoBLJiSLCgoVmP1Se/xvjmQzJcl2NbhzcwjP2ziJJbVZmMjmOwVeh
 SLK5bBdot/7X56YK3Bcs5UIl2z+rEvx6QF8099VVJOBR6wsUcol0+U48vTmJ4PzdKQOWaT4
 HD5RXqtMOWCaXzlzkl1QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7voIi10w/Nk=;eSmYHELXZK+7Oa3u5LL6luq6iIU
 5BO2GSfP70N2T0C7Dwv4lqY+AzkDLz6Bgz8eqiv0bkK1iRYQHsN2zAnVp94JP+9MoH2YxLUDV
 AyXz8ZP/2uO83ZOCLlPnMzOHQNKGwwz9Rxl8DGprzmi8xiF7kVnMVyqM167QDAoBWHLfx1r8r
 WvxjtMMObxtfwxt7JJROhFYGRiAnlDcgXATvRToEQwMLKuzt9CMBbevr6WKOUrcSmkntdt/pm
 eT0awe5VvvjWT4G8lXhuLc4Q0ZSwjZegjsyoRMxSm/y4hs4Ibyilw8b7NKomDTQyLirHUKxNR
 whxdVLHnzldDuo2TOI5c3AShWyr3g9a8IbdwToswfqLHSTCNUPVYDDNUNC19aj2db4znYr0aJ
 3XZUVEe6O+Xsf7AzoKIMA4vuE6Gqj3/Sr3Ogdegi4hbGUAUYLIJes455YBaAW4FWhhzUMfWXh
 NnKbbIVAulLmOZuO7L1MPTzexITcYPYikm/K0ya+0tPMWvW7gdgPCy2fu2D/5XP4ROoEGcM6L
 KAvEe4GHt8IRh8yFI8sNLtpwukncmoPh4VTtfF3uMWox3qcAohbZoH8ME8/4+3n5cuywL3rwG
 E/gEUH6BwLv9YMVyPzn4V0F2n5yUWk8eIEHD9v58qYmNfYIRKfwF1DXUdjKvSJQXgHm/qYNPP
 sKYtmdh/joKPJM4qs3S6z40qq/ZHB1gxV4pJdnoRObZfmqIn38PHlAnWgEhaZ2/kl47L4UOCc
 Vk4FhMA4YcnWRQ4hhw8Fhmyqys+7bMWXv7wYUwY1F6V80pMNtGlOZj6rJjX2F2ozXQJ3xLfHM
 RRllkgq5dYkfhUbjkl011AppAcCdgBGvbCcXGnRRQbUw8QdqBchEeTnsHO51vlOTZQv2gWBm6
 JyXq8nhR7SL5ipGo9HbdF+iX67QyD9lDe+rba5L2NqxK2ldp0ggmbsREuTtcY4iybjklfOZ9I
 JaeSDFSyOQudSDiP+Du/W5oxygIGVX4rnOJy8nYOLKHMj9xnoPjCV02WIgbkoeZ6OkZD0a9zh
 A3+mWW4zcgi35yX87/jSLGqvsheBqggqR1YsNRSVyhtMfpw/XUfQsX75HgVIv/+qRDxY1g7YG
 AAEqlytCFi7YL6Axha4vpjb8asgseyoOqp6vOWvaojSyzzIa7RszUoORXC0BrJQLmZRIv9NQD
 TdnqA2WY/ZYrJ7n+HFl3t5LtBkNi/FvxNjx+nWx0QloBUsSZbmjzZgesPdBGq03ia3n20hXIq
 ag14yYGE593mFxwqlNTmihVZ8c0mMVs4vRDR5/4zh+EzUhna4D8PeFi9rmH+D6cpZM74IUu6v
 aIEw9YAxmt7MQuj7OZUyKHK6N9HIoENfOuMEzbNz1UHPC0=

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
QGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHYzIC0+IHY0CiAgICAgIC0gYWRkIHJldi1ieSBTaW1v
biBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHYxIC0+
IHYyOgogIC0gbmV3IHBhdGNoCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQv
Y29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDI4ZGJiZjcwZTE0Mi4uNzVj
NzUxMWJmNDkyIDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9w
a3RnZW4uYwpAQCAtMTExNSw3ICsxMTE1LDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dy
aXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCiAJCWkgKz0gbGVuOwogCQlpZiAoIXZhbHVlKQotCQkJ
cmV0dXJuIGxlbjsKKwkJCXJldHVybiAtRUlOVkFMOwogCQlwa3RfZGV2LT5kZWxheSA9IHBrdF9k
ZXYtPm1pbl9wa3Rfc2l6ZSo4Kk5TRUNfUEVSX1VTRUMvdmFsdWU7CiAJCWlmIChkZWJ1ZykKIAkJ
CXByX2luZm8oIkRlbGF5IHNldCBhdDogJWxsdSBuc1xuIiwgcGt0X2Rldi0+ZGVsYXkpOwotLSAK
Mi40OC4xCgo=

