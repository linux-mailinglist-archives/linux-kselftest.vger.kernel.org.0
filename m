Return-Path: <linux-kselftest+bounces-12793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE091822F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D292838E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D9186E5B;
	Wed, 26 Jun 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sdgEjDhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DC186E59;
	Wed, 26 Jun 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407803; cv=none; b=aw4ODnZ5hSjJJZt8gQKcLytci+Bg6LJ01r/FAwIAKAUcA/gzMp0Ow152kKOazmmwgVEqrPvz7hr+sCvNqRcduRy91PWhTX/kSx9PgI9TVYo4IZm6Xi7t8qbLRVaReeOXvVPyrBgftpRtunv0lN43b6pTNf+WWhh/ypwcfWw+mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407803; c=relaxed/simple;
	bh=0zt2Mshqy3xM7zsn163AAnuGuA7NdFMql3ni/fh5584=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gNxFEsLxgEd/posQkeNPsBFgn722VN7lQiLxhnsOVafxLKg7rlaI8WNJanXnk8uQJQ1WuErRfjR3Xu9BPAhRhTSFnuV7kB0FG6CzqLtr31TsG1eJvb9sGeX8Ux6UyG1smYHOePXpRCGwHICx0hUZT/5N6LmfghZ2bC/kR1jDIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sdgEjDhY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719407773; x=1720012573; i=markus.elfring@web.de;
	bh=7Rv3yRVPC0olMS8yUHoaLVs9Do2dzCj/484IpJLGkqw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sdgEjDhYcjGDu3HEa1saleFTjFPZhgyzPVN/u5xSQrb16iBU9t7RhiiVVAUFg1vr
	 MozwLLoOSdm48+bkmoqbhRIZJYr7b8aOmoEJySu248/IskEnyjLwQ3Qr8D85+pLaE
	 vJ/IrD+TG3GzrlkcOQ8anh5DMTII2wqGytBiIHM+/1JMPEAqR0Nna+IXrEVs1v7f4
	 16GXZGlWcnq64EZEWDcvn1Z2LT5zpPMb/DyEU3PjNDJq1pU0Dw2Rmow5Pt17YidLH
	 ZYBzUd5lB7nz7VNSqEXKcMK/19RjklvbU24etGAKcJ8C6GqwaAQ12FrZvENVC4vZV
	 HJiXsK0VqPCt5fs2gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1sMBOE1vLL-00CCG7; Wed, 26
 Jun 2024 15:16:13 +0200
Message-ID: <d38a666f-a0e4-40ea-99b9-a3e645a6ea51@web.de>
Date: Wed, 26 Jun 2024 15:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-kselftest@vger.kernel.org,
 Amer Al Shanawany <amer.shanawany@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Kees Cook <kees@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626072024.2816986-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626072024.2816986-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mu/FQdtH40uRug15cwcGo2bfIE+PC94FP12BUA7TyXXtKNDbelu
 9ycSgBtep7sQFhl7aR/by3Qp9038fuW3pAhMm1cC3XHBPZ1sfq8i6Uy5v7LYDm00aODIKW2
 74NHv72JEg2RXampuhkvE/bsGWWMdrhlL9DkOEpRmjsjEise203wtLbcvUfLkliHhCuJ2Bz
 gwcHIw81fngK+rVQkJTpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LC+rmRT0tq8=;oYOYqivPZoGMkyUIdjLRIHOTr2X
 LgajUSs35QsnIZmNE5338zRZAZm7CC3J2vfBRn9PMLrMOc8E7NJEfK9LR1sdIgmSZoWFhdt4a
 xcz9aVLxfBh4LI2vE3rKz/t8O1Z/ZCX29ZmunwXUIeUrFABH29JhOxBca/o/ubMy+S052LIE7
 DbLizgjcaMqXESx8eNzDHOXShDe2zR4k8h3tzF4MMyLG3lC9VaPWcoQs3OlTQm3xB15WlxEzH
 SJb8A4lOIz2R/z9/ahPqAybe2iYJ7hTpaMSU8LDN20C3qsBBgcUxfUlx5L8KkyQ4DzlyRVTrd
 FktxSGZ6SOBFsb9E4loFM5GZhDa2vV05WqHjh/00C+m0YXDnQ8cIIgdkdkuW9n1dULzWsCCFf
 wrDzXj0ZMhV9UfyPFBX6+kslsTqy3RNBkkYRHgIprH7aRvRbrFLvCGAdjRHS56i6OKpcpQOAd
 63fBuPlBVa/Cr9qv2Skw7S3xmqJh4ak6JaVoO9FhWweduJh46owr9Iaeu64EBf0gaTv0wzSEl
 QaYqF/foz+JDhyTClcsOxOsjMCK812YyuMy2tOyubbFynZneyH79jfanuCNH9XbzwQ6Q/6aTd
 +7R3+aa5ZVoqj3fSTz/0UrY7SKy9aZ0lAr3rNURXZx2iqITANgy/147jUxQa9xI2GQOhMvIEj
 jzxMqtNwRRJBaWl7gGsVqY3dBELep9vwkRptgnvH7p69DsnTM+3Ey8YA+qCSLnXp8LTQQlRrF
 +i+iORKHmr5e33cmrnPfvT4G7MNomYNtsJXcK9vOXWYiFiUMl8fYFrwcCCOw28zMGiGnOzrot
 IhiOlOgNVZ/l6erAB9glupgXKkxSBfv/NmiK9wLc7dOwU=

>                                        =E2=80=A6 openat() and open() ini=
tialize
> 'from' and 'to', and only 'from' validated with 'if' statement.

Why do find such information helpful?


>                                                                 If the
> initialization of variable 'to' fails,

The variable assignment will usually succeed.
A stored return value would eventually indicate a failed function call.


>                                        we should better check the value
> of 'to' and close 'from' to avoid possible file leak.

Please improve the change description with an imperative wording.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94


How do you think about to use a summary phrase like =E2=80=9CComplete erro=
r handling
in copy_fromat_to()=E2=80=9D?


=E2=80=A6
> ---
> Found this error through static analysis.
> ---

* Were any special tools involved?

* Would you like to replace a duplicate marker line by a blank line?

Regards,
Markus

