Return-Path: <linux-kselftest+bounces-25844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B589A28B73
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D441883131
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE6194A73;
	Wed,  5 Feb 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="f5A6tgug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8218A6C1;
	Wed,  5 Feb 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761135; cv=none; b=bT7i7Xf755PTYkcyRgzCN1MF7uWmvPp+xqK9VkIvgg7YGDSeIvPW9MY1Oj5Oh2Gxxrm90N4j2T8m2TjLNZyWXIclHXbQMIGFzGbEoVgU13c5926pEck6W5cHU55C0dQG00v8Vwb+J1TX62taiHiFP48ms7lVa8jLradjTZMb+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761135; c=relaxed/simple;
	bh=Zl69JU7TZOhUfHgNnJqZQy0D3V34iXH83rNPVu3yEio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2tkOzHhyBUVFkWEwEmAYFMYCUwtZNNiG44FExFvkmDPpNJJUkKaMLMIjr84ITzioeSdyymEczgUdpqmcDZYpIH3VIkjoh7My9rNUhaqdZZ425IHLC/7oV2ZaRKLzx/Ssc/5zpP+Y9n7EwSlcU8kTH60rE6HofF0V1u6e/bpWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=f5A6tgug; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761122; x=1739365922; i=ps.report@gmx.net;
	bh=Zl69JU7TZOhUfHgNnJqZQy0D3V34iXH83rNPVu3yEio=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f5A6tgugLlpSh6EnJOKVpOWSuRTVmltNYsGqWOHt7V5KlE0P6IN5mDq2WVlBXH17
	 auTJiz7cyUCkQkSwyurWh9J8A6z0M97fArvYePdbu8ZTEafp9G9RcHVf1Z7y1llZl
	 xoVAwq+IEa+TNEjVuR8BEYcRfaOjzSJYUz0JYiScWNcmJHRH39DVnbBEaUePjFrF6
	 9S4csEZ/4YdfkHj3VZ4JfFDuZl5R9rmrSxlA7pv1dMCHBd5d01PYnA9nyGgPIVkJb
	 LcXHvbdIcfjGlmuNqcDh5jGDlsMwHvE0nEqir1ra/2hd0RrmL2uvTMJOCE9pmnRYU
	 XEVZ+tjorW/JYbqKEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1tLN9c0xXG-013lRA; Wed, 05
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
Subject: [PATCH net-next v4 05/17] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
Date: Wed,  5 Feb 2025 14:11:41 +0100
Message-ID: <20250205131153.476278-6-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:arhmFYAq+Wg8cqJbRE6Rk820ZGAY90sRZtCnUSyXHCbxh4NtUSa
 lnrJI3qw9VgolKWzWYytUugTbHlawV18LX6RTyOvXcLB6XGI+wFN3PoE+H7WvZZJFs9DLoF
 kjT04reOLcW9f7JyJj23ZlcPNBiGPCxFpmtapmuyQJQJr/NnoxmXEPw0Rzidgv0Pfo9q7A8
 gqEkx4irkgRa/iZGAJFGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OGOqwqEQ6RE=;nnfr3pd5FHQNcqFJV0fX57A3sLE
 6JkrO0kPquVNTIgpzxiD7Od+HMVjMG1nUWcGW6IA3h2V54YrMllPeaozY73emkscfKUbL6hYe
 D2r7eHEAFzkI9JawJeOP/N117ZX+hR2uaU22M68jR4eRVbNNaCG1FFMtUbNzRN450ysTI01Xp
 jsk4Ckl764psFtQGC2BJ+bFZHszrp68GQtyLu2+7z3NjBb7e7rZXDtGGXF7vrXhC0Rrf/prMC
 wNKCy61YJszBdtBivZhrP0x1Hq2Tx14LpuPfJlbylt6Y9SQKjGR1fRidhgxyfzMgD3ivgAqjp
 FPBU78qgyMlfbNP1aPSmURv4e+nWRu6VPx3vs7Es9xL4Pgwa3iq1nWWYTJvFqQUgZe7Ngb+Ai
 2Ea8ODF0hbMbCfkqKfrNNpn66BnyBUb7e1Yvwxc3pOM4xiGXX5K374Y3LaZKCkPAkjHWsslvE
 Fk5RLtcf3yDhwmZLlrCMbcgkf+OvDePP8Adj1OEiottozdKEs9MaBpBlOsYAr+tKWHW7pIyqq
 I6IkzCG3F/aV2YfPT+g9+FmVCyupmH5OD9IBr2FO5qXhJ834Q1sS6bKlJppDsxFvLaLaFqFeW
 BfnW4auxgGA0Y1TjKcUcq5yW5ee7WEWmb/i5ux2+K4dZroVAyUrcH98doeCphd3nANau48DTl
 acRlcn+0RHQIdaCJZ0aEGkhHPXoPRTMkXXfPDYjv6Fqh+guuqj1onDesh0Rz+2WOqGUvi+PK6
 NQFhgZstie+IPaMfLdi7e9RGY65jduUd79qhGms0j59yvUsb6+YEgTX7yL24+pr2PJ0aA5aLq
 +zmPyQxHLCEdYYVUyzSM9UMrYalI5KguiA+GMUHBI20I3xJFfmJgaDCT8t/gKPhdLDv5+6Zgf
 6G7QKLj7u5FiGUG79INkMeEs1PW4DIOhWjWV20K8htz/RwH8i5FiV73mojuLuw/6gtrpPQb5c
 7D522slR3PdsiuRykouEB54ofveqzGBJAmM7UjuVamMstUpapxqLyCAS3O+WfnrocrteMe4et
 Mh6bo/QRyzpcqaGxTFYSCRcX9HTgscD8mtlhc/b2f6NKqaRVoT4pVo+4DkPMsflzd4xovoeUu
 l972IkmbMs4Hj41QL4Vuw44R99cezl7mRe1M+AEb8VTSAg9AzpixNaKY+pMXzzFjbY9WeEGYK
 v1DV8YsIXvfrObNy0K+CK57ywVSd6uu5Ei+jBvCVgbxTF3bz6F+mwOGKDe57hVIozHlhj/+Bh
 iUrPPKAPWoohqi1g9b/VycFqrGFHBd+9WwEaNWS/LZ0AgFJ08keXntdERHWz0XNxMs7qp60zb
 vaAqFosfeydeOdot5Wn8XWPodrFkk4TNn2OkLvZxrLMhMOSIYp1lwkiYOsrpkBk1i29jQuhwK
 sCS3li3nowQBAixaDyxW0pfXGnN7HhbxFw1KwfLADPYHCQWeIPTq/B8VsJDdSzz3VV3X3dTei
 AVY/9zQ==

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
IDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2MyAtPiB2NAogIC0gYWRkIHJldi1ieSBT
aW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2VzIHYx
IC0+IHYyOgogIC0gbmV3IHBhdGNoCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9u
ZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDc1Yzc1MTFiZjQ5Mi4u
YzhhNWI0ZDE3NDA3IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29y
ZS9wa3RnZW4uYwpAQCAtMTEzMCw3ICsxMTMwLDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lm
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCiAJCWkgKz0gbGVuOwogCQlpZiAoIXZhbHVlKQot
CQkJcmV0dXJuIGxlbjsKKwkJCXJldHVybiAtRUlOVkFMOwogCQlwa3RfZGV2LT5kZWxheSA9IE5T
RUNfUEVSX1NFQy92YWx1ZTsKIAkJaWYgKGRlYnVnKQogCQkJcHJfaW5mbygiRGVsYXkgc2V0IGF0
OiAlbGx1IG5zXG4iLCBwa3RfZGV2LT5kZWxheSk7Ci0tIAoyLjQ4LjEKCg==

