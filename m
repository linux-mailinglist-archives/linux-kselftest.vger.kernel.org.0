Return-Path: <linux-kselftest+bounces-24937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00445A19429
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371F71888E8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED093214216;
	Wed, 22 Jan 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="I3bYkoH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5742065;
	Wed, 22 Jan 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556894; cv=none; b=cnZo04RF0yx7srbxrm4JUFdTVpC6UXdUlY0mbTfl9jGfuSi9WJafBDLYLO28ve7+WpuJxp3Q/M4B9gJzmTQ3mCiCrqo1/0yIAAC5eJPwTT8eEak1Z//FlzUMP8Y+VNXhtPEpK4SdV77ho029zE/wXf/CE1qWOSRN4I+g71urXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556894; c=relaxed/simple;
	bh=hJpa3LFI+V2r5MNhTK9NUermXo1BXqvohCjsUbamfmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7HZvPYEcVp50IdCnuNdkClb2HffAd1444vi6DpxAdkT4+M9wWkUuQawBsTIHVw3UA8N8n4ytt8yQUd8f2arCwOffHtyVCtU/d4SevtUZkFOQzTsuY+4gsF+UD7ltTSDA8wcRnJymAXvqJZzfK1tk6kIYvbpEyPJXSx72zZnuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=I3bYkoH0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556889; x=1738161689; i=ps.report@gmx.net;
	bh=hJpa3LFI+V2r5MNhTK9NUermXo1BXqvohCjsUbamfmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I3bYkoH0YjQ2Rk+BpVVOqP2EWkpr2lgh8/VwTV6F0AG01LMWR9rTWTTtwtdrzPY7
	 iXJkF+qW2zhDk9UIXv4sDbPbldYP06ttA5oynEg2u4DoQPCmQ625RyQwh310tfIYO
	 Qp8tNF/EtUMM9+5sfhWAkj0z4OdNAFFEOQKSewcwh9/ODuGoicCUikQWHmNXz+TQB
	 H4iC2Sw1uCIT3VxODrkjDpvXx4kjHrzU6YuKVuZlVfG4XXraC+YuGgQdZQLIaacRV
	 7Mt3SlmUBl5C80+gPkvJQT7PfmOEIT8vF6YpEe/SoOfNIq5EaxnHQ9Ssoc4NLhb1G
	 ZPD3NtFZFR/dkF8ytQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1t76b71U9M-00auke; Wed, 22
 Jan 2025 15:41:29 +0100
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
Subject: [PATCH net-next v2 2/8] net: pktgen: enable 'param=value' parsing
Date: Wed, 22 Jan 2025 15:41:04 +0100
Message-ID: <20250122144110.619989-3-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:xEA2ancdL0uEYz5QzgEMV5d8silehZOpj9FntnijP7xuKu0zLhq
 BJHwR19cQvL1S3+djm9ORqG+J6z2BmtlCZvKS2iDSixS0P0QCQCen1ByjzCwmtfzCa1MA7g
 pdqooRik1GHqJJPMj2ewv1VSiWeX+gMDu2LsqB/apMvcWgFA8/h9cYJl/rypD3RxhSbWNXs
 RJRT72T7ZRN9tqIMgdt7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lh+3Kui+bqA=;EkzXMPaOmuRvI7hVRbnLnL92kES
 aYaq9tziU9jyJX2QQ7sD9O5bgkAQlQPTIut2JR5o+oW7UoR53nwD6e/FtzFhHkabWWzXqAhoo
 SVWvL0S2JY91Bl2QDh/Nku5wGAClrPH2YIswS8lEJ4X5D6Y0Q8SC6oPEqn16OfKuEG6nHcM65
 Sy3GfsU059+Y2fZaM48BG8d194uOCwrjYDsJ1iqjDU6o9Yw4lHozAKNUfnXHW/JqV9UooVTuK
 sEl8tjZx9lyiuTzl4rjPeMdKpMsDGT3+ZkyQoq3cGmEf98/gs5eNkE76WHyv6wqP/yWzS//mb
 hM449lSWkzH4VhfOVc4bqQXZGVbYhf3s7CKdcPNzbx2xgvjT+GgxmXHwdzkRE8KN/TACEXBDk
 TIL60ijj2eQMsE4JPhbo2Wqf4mVG8KH5iCvFLKA45vIv49Nfq1iXyZe9LC1Ns+B0I5rwnxbwv
 B4NheX6hbXs765xAnoi4KU3fYJ5xa3mz9jl/0IO0i2winhApxNpxd+vCGs5MB04eEwXqd7yOK
 /6QyMSZAF+6n07L4cw3ZdUoSxan8mddz6nhXAUkfJwACWx8ItdSekDkRmhmKwj6Ta3xBGwehm
 gm5pPbffmfgGUq/wK3C2DwIBgXMVxjI/MbFpbr6ZMrkgrLcvDJtyoOi3weROBMWOJzR7KHXGA
 6EXqC3ZJ0YEJDKQgnZpNR6cQg5XKMVN/B3AERR7N2o79bM3O1KyuaHNxGTYLGpc0oNKtdqmaY
 RvBYuCxHBP5kn8UhePQhqAyHuKmkWTVzICJFIlDjBTgusza1NkJXdK5Yhl9dTCqzRaZ/gohPF
 qaZ0V5LVMaVkHmP6uvQUamGjcZvq8gsZ92eUNXHjZFxi2ijqGmSLgIrAsN5H3fEWnzq0Z38kx
 MEsHrYSzfEnlXSnUGv25+/pf589IjsBVyHizRFD4h1tGG1T2j0j9QmzYMWvpfxLJBo4+yaHAR
 Q5z61K9EqzT9YBEWIw+bNbtYlaI3FdMpQjnwUArwphu4PsD8Yif6GUOBFw9VegHCUExlYCN4y
 8cc9ntbLeOmf7b6FnH2DxUA2MG3zMZPn1PGBdAzkMJLQADHyE/K0gvggocGoisYKFhKqBBLFP
 0tnNpvrDGQoorVd+bVh/dtA12JYxK4E2qZgun0fN8vMeA9lTw4wy6oapUEHFQDFZUWpu9bvBr
 tsE+3ldtxQF4lPCNRfpPyGDDaOVsRjGmZEFIn/+by8QNaJuJ39iqXOZLpEz7FbmdYa6B+Y4W0
 hzYYdqsyYoaR33wC0uL+Mi4KH/L9DlGaV0wtzEKZi9R4m9a5/JNUGj1WRlt7psdx7I5zsik8o
 gkaSvSnDxzcGi9tLDzUHBy5PWCjO/+kVh8ZEuOaimrucjg=

RW5hYmxlIGFkZGl0aW9uYWwgdG8gJ3Bhcm0gdmFsdWUnIHRoZSAncGFyYW09dmFsdWUnIHBhcnNp
bmcgKG90aGVyd2lzZQpza2lwcGluZyAnPScgaW4gY291bnRfdHJhaWxfY2hhcnMoKSBpcyB1c2Vs
ZXNzKS4KClRlc3RlZCB3aXRoOgoKCSQgZWNobyAibWluX3BrdF9zaXplIDk5OSIgPiAvcHJvYy9u
ZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT05OTkiID4gL3Byb2MvbmV0L3Br
dGdlbi9sb1xAMAoJJCBlY2hvICJtaW5fcGt0X3NpemUgPTk5OSIgPiAvcHJvYy9uZXQvcGt0Z2Vu
L2xvXEAwCgkkIGVjaG8gIm1pbl9wa3Rfc2l6ZT0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9c
QDAKCSQgZWNobyAibWluX3BrdF9zaXplID0gOTk5IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAK
ClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCkNo
YW5nZXMgdjEgLT4gdjI6CiAgLSBubyBjaGFuZ2VzCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL25ldC9jb3Jl
L3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNDk2YWExNjc3M2U3Li40ZjhlYzZj
OWJlZDQgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdl
bi5jCkBAIC04MjMsNiArODIzLDcgQEAgc3RhdGljIGludCBzdHJuX2xlbihjb25zdCBjaGFyIF9f
dXNlciAqIHVzZXJfYnVmZmVyLCB1bnNpZ25lZCBpbnQgbWF4bGVuKQogCQljYXNlICdccic6CiAJ
CWNhc2UgJ1x0JzoKIAkJY2FzZSAnICc6CisJCWNhc2UgJz0nOgogCQkJZ290byBkb25lX3N0cjsK
IAkJZGVmYXVsdDoKIAkJCWJyZWFrOwotLSAKMi40OC4xCgo=

