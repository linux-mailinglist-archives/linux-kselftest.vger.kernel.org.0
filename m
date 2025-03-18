Return-Path: <linux-kselftest+bounces-29358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4936DA6774D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 16:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADF17AEEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46920E70F;
	Tue, 18 Mar 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="MFrv8UFF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10428FD
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310560; cv=none; b=UdU5RJtB6cGNU5E+clGIaD0gmLKED/z5UsvzIwDFMGphBbZRQYej6PdVv//1y59b2P9E0h+9WdoUaQ4DOuHjBwFFFTub9S8n9vsMr2YC0U6HFhFsHN+q2C+bEudLEYYBhIDQppePMSpuNVbA6oqH5iXvvmsCqD+hPldqsTGzppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310560; c=relaxed/simple;
	bh=kvKzSHONnbxeKuh4xk7eqbPkD5JTu/cIQNJrqAVWEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNjcg5kyATkzhuROdSV2tNwuUPqvfxNPhBywexzEd/wni2xs2cnPcGzMJ9OlIn+BTuEDf86o2K+040fVwVrhwrbJZhS3mHHkHAL2UqbCie50rVBGJ4QDXuHVYhyHieP4lyfZpA2flXaLrPl5+BW56npEMm9X00bVmmZlLZMlwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=MFrv8UFF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742310534; x=1742915334; i=ps.report@gmx.net;
	bh=Puebtc+AbPNDX2KBec0ZPyF0q0ncUNEYqLIXjTaorvg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MFrv8UFFeVrv/nT/t/mUzYf7tbpxBGKbkzsJdUHoTWaGfxWy1oBuh3CUJOn0uyCq
	 5yvt74h19NZkt/zZhVFxRzQ4vR5hHrMzSJr6cnj3WR2qyQ1oF4/0b1fop1o+knXb/
	 Fq+hHYu3bVrgWo4CzamBF4RVVI/OFt7TPLBV1fSfxg8FsCYhA7oE4BWyJia1cMQMV
	 BQ7CR/obscQgvWvnBgqjYb9omoIzlfldKPo6TsNi20GFPMJO4Nj0DecPGnyJBm07r
	 fHdqXe0SUfuyD/+Jp9Hz9UbiCpr3O86ff6byPUADbOe1HB0KvB3lWBYwEcXQ+R8WY
	 ZgmOc85P+XwekFpFwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.115]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1tP6yJ3wGE-00cERM; Tue, 18
 Mar 2025 16:08:54 +0100
Date: Tue, 18 Mar 2025 16:08:52 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] selftests/pid_namespace: fix building with clang-20
Message-ID: <20250318160852.2bc4ed52@gmx.net>
In-Reply-To: <20250311160706.75319-1-dmantipov@yandex.ru>
References: <20250311160706.75319-1-dmantipov@yandex.ru>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/K9Lmj77NKrVXTPcCfWzT00kOQ3HZSoR5K6K5LkewWw2ScuDmCC
 a9IqMq3MOJdRB7a8Yl517onl7pJmQ8YnXjJ1CfrX0onOnjpKR4aRkn2XrDwn90j3ZmOqSBu
 Kb/72lohsicCxCXyKtoLMGpj4CcPxw66g27YNRnaD42O2cvCBOTgupIiJWFLGRJQafSNgIj
 jstQZz72DXOVwIaLOeITA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6azXF+usDq4=;mjA5+JsNWMV3m3jaxaadLnTsB5l
 flraRQ1lCpxHx6h3S4fNoeKr7zHjHlE348DoXrUwah0eEQIYiRdT5RZ9XUO6Mf3zA3zZt8wiz
 0zOx5opsHC0v3qWKlFrKJHOEL8RqI2JsBfsCeN9bXXgPHMt1wH1p7mTtgrhuwbgcuBZPaXsNj
 Jg98RgDQWJFaLWRfziKItzzipJj+Z6iaAhMxUBS8hc1Qe09BpfPTIaLoUs5EGZdO46XRB2h82
 1tKgHyse7u6FvkPPD/NKrophlMlTWMvEWhiqtpHc3qGhfXENC4QKE9nW12/jKk+q8mV5LgfcX
 VF5u6zx/FDSAn6BH71t0CUnfkbgGaJQ/hR1+lxZzzeYf9VBjhCBhbIHEPVRxQgCkI1Uquhb8U
 23QsK3eLRids3r9o/R9Arojm5bXI8NnxuNGWmCxaLWQB5MTkQ4rviI3CmmVtc0MwMrX8uFJ4R
 /pKwBp2RzglNQPJc0PqZFJrAs0OcudkgIUJDOIBjcYehEfdjaxm0SPRK9fLqHqrnrQAkX+4rw
 l+KZxQgFFFNGIuoSrv30p04w3chyvQ8G+ep0bTaa7ApeaFvyoihgFJaxgv1rG1//H/SIjm9kC
 d6zLxhufWpUOAXJrnclMVFi80QSyCpGc8TacSvowb3CLlRxsp10Oz3ncjSJ90rqEyiWmnU6SB
 9YxIBmU9BUKYai1Tm115uJdouYiH0GUFy3yvqEafAG5ca0I4GGnkbZqvgvVwlGiWLIrY60BQL
 8s0SKrFmsdTrEQ1j/egDGmMPg54XFKqRXJspvO6J8SzzjTzrzfEJZOtW/c+GYqoTruFvDWWTK
 ajJJAu/tBeiNQCRxBskicT0kl49FHOQnnIpsY39WbVwdXrXxzwFf+MqYJugMPMPBrVEz9fBv5
 QZ0A4MXvNAKq68JKziw9V3/7IuXWtvBzGv7sqCO7GV4PoLOAWHimhj2EgXg5bbYiEOFcDI3L5
 7bVQS3GStR+Ep3xCk7oLjtsTZAsHbBr/ToZS9+K7JG0H7QfgoA+WCM3oQOQnJ75oD58hb47Em
 eDhtQarvp8/g0U5poSbzIPY4So4QFujhDea2LBmL2K5JvduOPecktPamhS6mnYhMo14aXe+JR
 4pFGKsA2rtEuFu41p9u5cRryx10mQ8AJZa6a7r/E/J236QeLNN7NCa5/DVO7tjMJli4Onew0A
 LdchXq0lNGqAcDn8CDKHtDBCQv/Elbo5lbD5jiGmhCdomi97q88WL0oluOQUYaf4CN0AhA/sC
 hSdCWKu78P8N/TG1XSB+iOWZ8dp4YA0shCdxHaT3JYAlsWM5QKEyMX6KOmg7PF3XwjAN6ejzK
 VrycdevTT4teWE/YHnAxtILLzPzxabJTxoH7jdKnlyic62ED+1Eu+P+izWNZkUE/ErS+laCUT
 La2Q8Cj5yLTx1dgyt3/EB9a3mCIcXAN8Mo5pnovi/C3HcnqGNgnT6DHRz7/dqN5Nkm2OffjC0
 FIthcnA==

Hello Dmitry,

On Tue, 11 Mar 2025 19:07:05 +0300, Dmitry Antipov <dmantipov@yandex.ru> w=
rote:

> When using 'make LLVM=3D1 W=3D1 -C tools/testing/selftests/pid_namespace=
'
> with clang-20, I've noticed the following:
>
> pid_max.c:42:8: error: call to undeclared function 'mount'; ISO
> C99 and later do not support implicit function declarations
> [-Wimplicit-function-declaration]
>    42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>       |               ^
> pid_max.c:42:29: error: use of undeclared identifier 'MS_PRIVATE'
>    42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
>       |                                    ^
> ...
>
> So include '<sys/mount.h>' to add all of the required declarations.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  tools/testing/selftests/pid_namespace/pid_max.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/tes=
ting/selftests/pid_namespace/pid_max.c
> index 51c414faabb0..972bedc475f1 100644
> --- a/tools/testing/selftests/pid_namespace/pid_max.c
> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> @@ -11,6 +11,7 @@
>  #include <string.h>
>  #include <syscall.h>
>  #include <sys/wait.h>
> +#include <sys/mount.h>
>
>  #include "../kselftest_harness.h"
>  #include "../pidfd/pidfd.h"

Predated patches already available, see

        https://lore.kernel.org/linux-kselftest/20250115105211.390370-1-ps=
.report@gmx.net/
        https://lore.kernel.org/linux-kselftest/20250115105211.390370-2-ps=
.report@gmx.net/
	https://lore.kernel.org/linux-kselftest/20250115105211.390370-3-ps.report=
@gmx.net/

Regards,
Peter

