Return-Path: <linux-kselftest+bounces-25834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4606A28B50
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FDB3A78DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685214F136;
	Wed,  5 Feb 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="MT/VvVF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDE13D509;
	Wed,  5 Feb 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761128; cv=none; b=VcZ3IQC6zxthGHnNaOCyN/I6jsExlAuIvy/9mVKImTIB2LRWHN1X6sgpwLk4QkXloqeS6KDUagmShcv5cb4JoCy4v7zJPc9zQ6myvc5Bae1LurJUVrxtkvF2kL14RDLXkHgdFxf8I6Cao1AonJ1UPZYcxSbPry4cWDzx5TmjLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761128; c=relaxed/simple;
	bh=ySoD5uk4dTQ1BIVYf4nCjV0ocFzd477vnmhR9UR8pD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZgnbGhQnT0I12kFf7TpnEIHtmzLnGr+XgKf5kvyam1Vh1G6JTXpHA0HiKmn4Mt0iDxgtJc0lltP60xy+iyoS9j/Tk3gBN3lb/CwYUwTPFQ7zWGJkltqpU6wZWLYASOw52H48GaEJ5H/vGZWhi+AgqMPa9R7U5h6BDzrqMSaXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=MT/VvVF9; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761122; x=1739365922; i=ps.report@gmx.net;
	bh=ySoD5uk4dTQ1BIVYf4nCjV0ocFzd477vnmhR9UR8pD8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MT/VvVF90Q7RIyF3XWnlARFpu0JdMGpgUQhVni80aawV/iGszc4g3VNi5Fqn4d+s
	 SlZh8T119rwZJTLknCN7gZLwOfmfJSFi2EJdyHRmXax3JKvOrRYzkR29ZiWwjj3km
	 FatmP/8rd/VIpysOt/meDV3B9fgVBTAoP/BM19Ft302p8Tr9i24pMMQx/h10oRDv6
	 TK5TLm0/yn/IMPsoc5Zmn/NgK9AfmVqsUQfSdo9XbrCT8cnqHgb9TUX11Ik0OC2df
	 5kbCD49OvtF9Ffk/5QzMzfQPPaRhVCvJI44rDeUKfs41wHwISJ0KMlrp2/Qd9q0PI
	 CNxRoiyTbi3xgidPOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1teYjW284q-00BWxS; Wed, 05
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
Subject: [PATCH net-next v4 06/17] net: pktgen: fix ctrl interface command parsing
Date: Wed,  5 Feb 2025 14:11:42 +0100
Message-ID: <20250205131153.476278-7-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:H/vMqvknTrOKwdYIUTWwVwtlqy9397MufAra7x/UUpArpnbZitV
 CtGhVPA1OEuf2H9BDrE1DFuIb46zXK5z6X7YEDZQ1wlgMdjnEVq4vO10V5SoHBcCdaDUt9V
 dRdyJHb+18esrqkEHbZ6nTj7pDzX/Sgl38/We6FXxB7t2VM4pXERdgtjN82oh7Gx28B6z7C
 j5z5bVRqG8bYe/r/YMVlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XnaqEtoAsBg=;salnXrICS9T2k3nMDoY7O0kCE0E
 sbGM2XFOMpULjv/cZ4VLox6mMs/ZU2sSFyB1dHLtHw8b8HE18ZlZ2XjTjzLv7vPdAnEyqtw7z
 wFGIH1K/WmOypnIP1VthT/prKdxmVKS3v0M2wkwXPKMPElMiO+JAOx1Eas27r/a/pveFMtSXc
 Gk55pZ8Y98hDvNfyBAbrDydMRI4MtuBUfvuFEXBfZUQvprJz3s+W6ZHAeUWn7ASnFqOzGwYdV
 FOF75ig/3/d5zOm+hGIrSSu1himviLpWDQqsl9xkwTM5h0NuUPzOM50/dnhnLUEgrT3lHpKam
 lqAg6rsQ6TGlq/+hL/w+vTwSKQdlISqN5tJ2WRscF4uchYPHf6ojowwf/oV/KGk+CLD5nR3UO
 SF1eS96C/fBKEUfavG/7zgS5igoshLJuy6LQ0I1v+oRBuIayILSE665ItfpfoKAAC8VPkaxg6
 PsEB6dtAkHlWjOf0s/7E6grf4/ZQxqHybcaxvukSNvmCzUMv85lBMzvi6OihY/i/VUDHprnln
 Eo6zhacoCKtJiOr32jgZLz3pghqpdLDxkFO5Y7DA12hjDOb9s2/5qhmnAq0xRuFHKI9GxjLxR
 nMVcFrv447iQuHc+28s3RLunaRbQpf1DtHq9x/k0K+bpizO4rkDe3jQKZjElWODLiLQY4c5h8
 fHE8a3jUE4mk2C6GUF9b2ssJQ1lK+tFGUhjziZk1m2RMHtE7Qhjc4zSUIIqbKSmdlh/z+C1ZG
 zc7g/v0tJeYPD0IgFJa7A7WLz8CawAhekkb4/I+SXJghrRNOTP+hIzp4BwqSbttJmLYw9duQu
 WOsVo4vKUB1UnHFEeTJjHrfpwCWsuNw6zcogqSxHnII7VGJV/tN0A7loPW9VGpEDzSVY2OLcJ
 ZQK0uln+4GDQjh7GudH6qT/XSuSYNwxWcM+/6eMilr8XQZIBs2ywJ4TnU4kf5Lt6HGvduNdnL
 8y/fMaMzhu+uweJhH0v9tal0NINJ379hKrW5BxveUzfENN6Ree09gHgYopoM8Y7FLuB14Lq50
 WaNIZ6JsvrHYXdGuOUzKR4w7VmdxQct/IfsL/p3Vj/BIB0Wp9XhaFCfSO317fm3KvGIVsFDq7
 qUDfvbjotCAKoOWECteBq9sgalulQt3XbUCsvW60qmTYgguKdSYeRi/m6mQFA5wYtfmeQGqsV
 nog0QS97iCgz6P8czZ+fLjGGrdV9ixi417/Y+pVJV5GiLQMkoOFlN10Skc4JO/vHen1/zgxPJ
 B+NkwuwwKZHuCQ7qX2/9EyZo6z7E/OS1iVgPviBRXAM9EAOJN6HvRke3vjSDaYrV1mSVrOLlh
 iYdnvGyNWCGbQBDMNSMGm8tFaxYR9Sr1wkw9Z+gOcy0bic=

RW5hYmxlIGNvbW1hbmQgd3JpdGluZyB3aXRob3V0IHRyYWlsaW5nICdcbic6CgotIHRoZSBnb29k
IGNhc2UKCgkkIGVjaG8gInJlc2V0IiA+IC9wcm9jL25ldC9wa3RnZW4vcGdjdHJsCgotIHRoZSBi
YWQgY2FzZSAoYmVmb3JlIHRoZSBwYXRjaCkKCgkkIGVjaG8gLW4gInJlc2V0IiA+IC9wcm9jL25l
dC9wa3RnZW4vcGdjdHJsCgktYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1l
bnQKCi0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvIC1uICJyZXNldCIgPiAvcHJvYy9uZXQv
cGt0Z2VuL3BnY3RybAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBn
bXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0K
Q2hhbmdlcyB2MyAtPiB2NAogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIg
LT4gdjM6CiAgICAgIC0gbmV3IHBhdGNoCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAxNCArKysr
KysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmlu
ZGV4IGM4YTViNGQxNzQwNy4uZjZlMzViYTAzNWM3IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3Rn
ZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtNTE3LDIxICs1MTcsMjMgQEAgc3RhdGlj
IHNzaXplX3QgcGdjdHJsX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNl
ciAqYnVmLAogCQkJICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQogewogCWNoYXIgZGF0
YVsxMjhdOworCXNpemVfdCBtYXg7CiAJc3RydWN0IHBrdGdlbl9uZXQgKnBuID0gbmV0X2dlbmVy
aWMoY3VycmVudC0+bnNwcm94eS0+bmV0X25zLCBwZ19uZXRfaWQpOwogCiAJaWYgKCFjYXBhYmxl
KENBUF9ORVRfQURNSU4pKQogCQlyZXR1cm4gLUVQRVJNOwogCi0JaWYgKGNvdW50ID09IDApCisJ
aWYgKGNvdW50IDwgMSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLQlpZiAoY291bnQgPiBzaXplb2Yo
ZGF0YSkpCi0JCWNvdW50ID0gc2l6ZW9mKGRhdGEpOwotCi0JaWYgKGNvcHlfZnJvbV91c2VyKGRh
dGEsIGJ1ZiwgY291bnQpKQorCW1heCA9IG1pbihjb3VudCwgc2l6ZW9mKGRhdGEpIC0gMSk7CisJ
aWYgKGNvcHlfZnJvbV91c2VyKGRhdGEsIGJ1ZiwgbWF4KSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAK
LQlkYXRhW2NvdW50IC0gMV0gPSAwOwkvKiBTdHJpcCB0cmFpbGluZyAnXG4nIGFuZCB0ZXJtaW5h
dGUgc3RyaW5nICovCisJaWYgKGRhdGFbbWF4IC0gMV0gPT0gJ1xuJykKKwkJZGF0YVttYXggLSAx
XSA9IDA7IC8qIHN0cmlwIHRyYWlsaW5nICdcbicsIHRlcm1pbmF0ZSBzdHJpbmcgKi8KKwllbHNl
CisJCWRhdGFbbWF4XSA9IDA7IC8qIHRlcm1pbmF0ZSBzdHJpbmcgKi8KIAogCWlmICghc3RyY21w
KGRhdGEsICJzdG9wIikpCiAJCXBrdGdlbl9zdG9wX2FsbF90aHJlYWRzKHBuKTsKLS0gCjIuNDgu
MQoK

