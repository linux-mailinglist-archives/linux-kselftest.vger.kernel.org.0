Return-Path: <linux-kselftest+bounces-25836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBFA28B5B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CA5168683
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B39161321;
	Wed,  5 Feb 2025 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="YidLCkgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004E155744;
	Wed,  5 Feb 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761131; cv=none; b=Z8FIp8+X3EHEob0+Kei91vsnJhgCCFl26aWrzAKJAta7f0FzOL3mPefbmxc6acdfXYdZouuyZHRJI7iR2QVgWBCkgA+9KzOcKEumJer2NhEwFxY8WV1G7Xm7Sh3zF2h8ku0OEQ+stUTotlnMtFaY302DTXKFRcaK4yN2WjHQsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761131; c=relaxed/simple;
	bh=7QZaHf/CYlNWEU18pei7TUReKsakGS4hi+m14IEnps8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7rotcElEA57a9e5xp0CyGn0bFO52dnCElMH+HwjO2kgMdTDdf39bNh24bfQ0TfJTYhoIfcNDBYPUj2FYgNCEsHn1cW3intvk1seCzOi7LyvvbLDDCj+Ty8a/tGLiLuBezVvw5bgTxUJZu8dvXdDh3zCIsO0yToZtwR0J9hqftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=YidLCkgZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761121; x=1739365921; i=ps.report@gmx.net;
	bh=7QZaHf/CYlNWEU18pei7TUReKsakGS4hi+m14IEnps8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YidLCkgZMCEObyQsY5UW4uJbEsgE+SGL3wyVoX/yiMrjJwZEK6xv/r11r3A3Wc5c
	 CKxDe/VSA+3zY+QhPjDqvf8Tl6CCpfCbPU4YuktdU8n+CKwU61jfK0je+zqdR9SxI
	 SZp3L1DRQTOTtdS1YXIcceH5uLX4QnferTQAh1b2xGgRsab7UsR7eve8HFKjk2aCK
	 LicVt5usOw+FVwRO4LkLzDLgfoFpea6jBKnLz7lnbhQcXqj4Y4Nr+pe8hpiAuXgrq
	 2emIAnGAk1gExYPXv2o2beYQ4NwEkYWDfuxXqitDGaiaJiQYpT349oUlBeDacnMBB
	 Gox+VduCazsoAAiaNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1tk5330GeW-001aGw; Wed, 05
 Feb 2025 14:12:01 +0100
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
Subject: [PATCH net-next v4 01/17] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
Date: Wed,  5 Feb 2025 14:11:37 +0100
Message-ID: <20250205131153.476278-2-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:IBhPBAOoqo99Y/75uYu459DKOWrK585/4s4eUkDuXn5MbymJS7Z
 hq2duso6O9jYw3QoVX4oy69dP47wUOEcJQY7SKFFHfw3Pfck6inRbenIt6JOsS/oq7jEGwm
 ZfMhYXaEJh1fCyz0ruqztukfkQf9UBg7ejYuRjfFiA6SfQ2fSlYxj6dbn7M8VIAVOjTa77w
 4bmLAh6mCKlZ2C6jER73Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MfsmF18LbUU=;Mvk3lVDu+duCQ/SH3nuszY2c7BL
 vJEYQGTy4Pmcz4G5Jlw2XyNjnVCQZWqfBOTlDC9CXosHVST7vNormg3mZyxy84e4qN6poj2Io
 YJECm4vTZvXfExchHKm/xEj5kJ2fnswR5XVRe6J1+d7oQxa+YyEOSBlcoTyTvtaOv2Beifh0O
 nHCzRxr1D+92W0A9WgP0AagoBelPb0Xlm1nWOJpPIt9JrcJaRU5E8cSyTG//lHUJFkX4Jxe3i
 QmARg5tiPPn5Tv57l3Gf7tSdb0qFwrebZnBfiTU/TJYKsmE0Qqx7lE4vg//6eyXRH59VhVKPy
 pmHDOdN0NYO0o01SRpMDinAtKH6lpYLC3zkq9jbydedMsP/dS30d4wXCP2ulp2ae5uw0ssBQV
 YPAf85ymvOPfWFrQ/kLEVT+CJZXB9xwWCtQNCJDtowgqokiXSqQp8p9Fj+M7HxRPGA10RY+2Q
 Fcv3HFhKqCZm42hotSF3skz5DzwvHWQ0k1KLHt9zNpo2fSZaPgJGc/OpXxN6xWFdPGkxSWXHn
 uA/Pv4nuHEtB4OVH/p8mJfAGoWTLId7ePSbkruMs8oEUtQc6d+RRkTNxuBhoUAdI8caouxPSg
 2tL6w8/lotjiyjFuGojYYrONjYljN3RQppnvov+azlnsFAMiDpEGn65JhRegvNWF660DlvYiJ
 0ZEb9+iTUTONIQW+3oBZ0v/JLWWY58C0TpV0QX+2/lGkiUtOl5CimQx7D68h/QIlE0HpmYAHu
 UbvL/2fKYd+drz/QKcvK5fA+iYOGdTLe/Nz+Ys7Rkv0LusfvyEImT/p+f0GuKAiMEtxNX9wab
 KfYnOyrTOYAM63w23zdWIt5/LTmR5YWtp7mUblwyYsvM94mIYaQZrWg3S1oLoFgH9Asbt1XAy
 QcHlZw/onH89eMBxjL0fMYHfFy0HYf8OXLkk5SWXX24UeFrxxVOQugIegUdSYajD4aAeTmreI
 qz4pppyP7s+QI+gkfiQLgHkLi8c3peiFloabEIIzExfzgHxcPdirI3uFe5txpZ1QbU2FDNsGF
 dUDwDjt6nDKdy0uiG1Is+AT119piJBqXsDl0uoeZxWRmV9ykt9VLK1HDDUYsI489v3rhb+1v/
 0BanrjYZ2eexTHkuLA//67hfHJK99A3RcKJh8wYu/ys3FGMAwFghxr/g2W83jabqW7feGM8l0
 kQ4PZvz+QtChfOJ6JI7L6CVndX7g/Sx3qvVp8n5VCKwVHR3TntXIaPtsNM7QA/48sfGtTBdHT
 Ge+v6AEg9oU/0vjXyTkzm7xlvoBKzfToCjeX9c2xjIvdZC2+khzH9K+T02byLbu4jEkQpYgMW
 aOsXmiZNrkXL1g9xBX6PUncKPkfhA/dEv2n9jrMjt2+bs47sMrxe3gKAwnuvXB+rHHWkDeztD
 a8Ozf0hVsehYKLDnpUMpVrsB1LyuhmbWH/ckxaLfr9xJEBe4m0lpQyewHU

UmVwbGFjZSBFTk9UU1VQUCB3aXRoIEVPUE5PVFNVUFAsIGZpeGVzIGNoZWNrcGF0Y2ggaGludAoK
ICBXQVJOSU5HOiBFTk9UU1VQUCBpcyBub3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9Q
Tk9UU1VQUAoKYW5kIGUuZy4KCiAgJCBlY2hvICJjbG9uZV9za2IgMSIgPiAvcHJvYy9uZXQvcGt0
Z2VuL2xvXEAwCiAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBVbmtub3duIGVycm9yIDUyNAoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdl
ZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2MyAtPiB2
NAogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjMKICAtIG5vIGNo
YW5nZXMKCkNoYW5nZXMgdjEgLT4gdjIKICAtIG5vIGNoYW5nZXMKLS0tCiBuZXQvY29yZS9wa3Rn
ZW4uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2Vu
LmMKaW5kZXggODJiNmEyYzNjMTQxLi40OTZhYTE2NzczZTcgMTAwNjQ0Ci0tLSBhL25ldC9jb3Jl
L3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xMTk4LDcgKzExOTgsNyBAQCBz
dGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCWlmICgo
dmFsdWUgPiAwKSAmJgogCQkgICAgKChwa3RfZGV2LT54bWl0X21vZGUgPT0gTV9ORVRJRl9SRUNF
SVZFKSB8fAogCQkgICAgICEocGt0X2Rldi0+b2Rldi0+cHJpdl9mbGFncyAmIElGRl9UWF9TS0Jf
U0hBUklORykpKQotCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJCXJldHVybiAtRU9QTk9UU1VQUDsK
IAkJaWYgKHZhbHVlID4gMCAmJiAocGt0X2Rldi0+bl9pbWl4X2VudHJpZXMgPiAwIHx8CiAJCQkJ
ICAhKHBrdF9kZXYtPmZsYWdzICYgRl9TSEFSRUQpKSkKIAkJCXJldHVybiAtRUlOVkFMOwpAQCAt
MTI1OCw3ICsxMjU4LDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBm
aWxlICpmaWxlLAogCQkgICAgKChwa3RfZGV2LT54bWl0X21vZGUgPT0gTV9RVUVVRV9YTUlUKSB8
fAogCQkgICAgICgocGt0X2Rldi0+eG1pdF9tb2RlID09IE1fU1RBUlRfWE1JVCkgJiYKIAkJICAg
ICAoIShwa3RfZGV2LT5vZGV2LT5wcml2X2ZsYWdzICYgSUZGX1RYX1NLQl9TSEFSSU5HKSkpKSkK
LQkJCXJldHVybiAtRU5PVFNVUFA7CisJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CiAKIAkJaWYgKHZh
bHVlID4gMSAmJiAhKHBrdF9kZXYtPmZsYWdzICYgRl9TSEFSRUQpKQogCQkJcmV0dXJuIC1FSU5W
QUw7CkBAIC0xMzAzLDcgKzEzMDMsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsCiAJCX0gZWxzZSBpZiAoc3RyY21wKGYsICJuZXRpZl9yZWNlaXZl
IikgPT0gMCkgewogCQkJLyogY2xvbmVfc2tiIHNldCBlYXJsaWVyLCBub3Qgc3VwcG9ydGVkIGlu
IHRoaXMgbW9kZSAqLwogCQkJaWYgKHBrdF9kZXYtPmNsb25lX3NrYiA+IDApCi0JCQkJcmV0dXJu
IC1FTk9UU1VQUDsKKwkJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CiAKIAkJCXBrdF9kZXYtPnhtaXRf
bW9kZSA9IE1fTkVUSUZfUkVDRUlWRTsKIAotLSAKMi40OC4xCgo=

