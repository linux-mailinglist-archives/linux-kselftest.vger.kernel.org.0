Return-Path: <linux-kselftest+bounces-8464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F28AB364
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF12E2842CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7212DDB0;
	Fri, 19 Apr 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WQVnycxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5585629;
	Fri, 19 Apr 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544341; cv=none; b=WbN1S88Ik5IJnWE8KueQ6iAa8Ul4dwZ5jr6ciikJ2fPLVd4WWnR2nfpDzpbo1F/LI3LEQg5ZaXogi6a/KUwbZ53fT1lBzGEHMDA8T+J1gSk18EDI8mX0gciJvd+kIzqBvDhpBQUFXkjcY+aCQ4vWCyaeV/fIZ7LliXR3W6c0gX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544341; c=relaxed/simple;
	bh=eIbxWlxAN7PmEn+bwco0CingzsHowjfYYbnjMadAdbM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aLueTYU9pnEYhtLfu48gL98a8yyemgcY9noGNLPikQncbIKFVZ+/5n8j3Q4wR/jBLU6kALZQSuUHOX6E6SzLxx2D+rGZinjXv1e2jsX6y6EgsSJSWaeWzLoDNSS89kJd7TKkA4J4P8s+A+4lz6ah6eJzQezj3wWJGXJZaKt5BNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WQVnycxB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713544326; x=1714149126; i=markus.elfring@web.de;
	bh=eIbxWlxAN7PmEn+bwco0CingzsHowjfYYbnjMadAdbM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WQVnycxB9+t5If4iKSq2luaQjPMqh2YTkUMSVmv08Kzykb2b8bH6AC18Rx/NYJ2n
	 Q3uiTmYE3z0Fqj9ovZgZDSmvXUK6/oG4sllc0Voe1GUA3NECqmxPwI5SKPLJpeQ8k
	 zsWHyfabjsO76vWYFl0WzryURrc20iBmHWXXeZRW5ODWCQ8G4X7iTJLW+vNcGdYMk
	 vw9ddwtPAR4TQE2WfwtIOeXpT40LEfG6ufCv+7ou+CWPGBmdtAhfHEddR0wltiJb2
	 tiaR2qPMERlAKIKR4VNTCa5Q2p6WJMyXAElmfxtXi3FxajVD/B7yGR37N2s4AnvUj
	 nz/S8ayMqBQnzcuGvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG9DE-1rwlEw2bBE-00GWVB; Fri, 19
 Apr 2024 18:32:06 +0200
Message-ID: <bf0dc8a8-d5e9-4402-8305-5b7a954e6382@web.de>
Date: Fri, 19 Apr 2024 18:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rae Moar <rmoar@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <2024041955-strangely-snack-b335@gregkh>
Subject: Re: [PATCH v4 1/2] kunit: unregister the device on error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2024041955-strangely-snack-b335@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:stRam5aVtIuDvHM21SJEdP2eyrk/2IhupOPWo77UJqEdZj0lMjM
 1kBBa93H53jLvhEicKH0EIcsnyhDgq4k/JqqZOj9b6fshRCXZaR5rJZys00OVaiA0FKlfp3
 7EQfm7LfrEDW79nZv5OHCkqQ3QTnxi4SEQ5+kKxY9C+hiobcb2ksKG0magbesWswLM8jISr
 N7tyWaBMkpDPxqXb/wcNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dcJDmLSpQmg=;62Zr0Xznbtsg2eO6SE5TOHi9U9k
 EIia6P4/Stl6JX5AVZ5ObMPZdBsdwQFnWufZkVILT3fH2w48svA46fi5Dbd+tV9oaWVHix27g
 lDJksMgY9nbBWvoLHu5yEbB4ZRzNg3KgOfqKYlWV12UCLCMBDkcfHJk4wLV9TYaVPx7x9PCD0
 rGXRAsyJWhFo08PQpg84NiIM/yu47C0KehRSgF9uDyn139bBU2D2Jiw6tzcUQCt5eyhl8WfTM
 dURD2bzAZbnUONgtTz35Q8DarjuNUITZ71MkErUf70V9pz/EHrJw9PLQTffB1W5fv+jlTLdeE
 Ge4zd5qaJnBJa/o33ZQbIsDvi9BJjGAvDU/87K0+h4MaK25Rbzur/QZRoHbh9RHm2zMRS7LCj
 PAaVxz+TapnOvfqqDGZb3O3q5NEweFCnmaBHxhDpFh4XqN4+zlQczLxcd1KlzW7ZzStZUskII
 bs8ux9W/an4L5AKeiuSUPlii0kgTRjIkzPCel16/6WsujStS21czAd0iMJ3tZugIepvloRSyP
 znQYZI2e+PeAOtTyPmhHgqzuqAqaI0IzSsoSa45WVMnZpu+etU+7gohQWiPP7XKw3dAbGPYOa
 Yt6dImJsu5PJPjf0v1KtxUmzHAheMEandRW65wSuIE/HEXU+8smR7xhmtPkHnaiX8x1jKc+WZ
 zJIL3KcvIPa28jWgnxHNSd1usQShtvlPLxg758btAEM2yQ7YzENUGIQnk0UigLHxLw8loMWZM
 WUEL2qV/CGkvcnPrHATkyjnecf6RF8lYvWViWnj7xAvHBWUf3c8OVxqM0SMcDU2EukdshvgQG
 IXfQr2fwsjo1ifi9UYtSv0P9n1rbao2TxXvNN+Yx71bdQ=

> > kunit_init_device() should unregister the device on bus register error=
,
> > but mistakenly it tries to unregister the bus.
> >
> > Unregister the device instead of the bus.
=E2=80=A6
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Would you ever like to distinguish hardware register errors from
item registration failures according to further improved commit messages?

Regards,
Markus

