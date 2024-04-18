Return-Path: <linux-kselftest+bounces-8343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2608A9E46
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7391C21CED
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395116C69F;
	Thu, 18 Apr 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="he8nYJjF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2C161935;
	Thu, 18 Apr 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453896; cv=none; b=BzbBVE/0nB0GMLiqEY20qoMKmHWWsaLJY6NgZumIn08G4CLvjuYa3YYSHGHatcNeP7sjrt5Shl7V9235K2YX0so2ytSr6bjHUFaaI8wjegyji4bKQqyYzRwseZWZLj0CIZd8Shlyqkgj5GTn2Sdc4zvVLVDvEpoXn2MbSjTbUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453896; c=relaxed/simple;
	bh=K6si/qWNSSEtfjq7a1SEzSelcRddlzdgf8u7W2c9iVw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ide1gCuZmhqz9ilRq+akFd2qTMrdqnsclvRCigCxZzVZlJcakCEmGGkzL2Fz8XbrX59UVDgFqHK3UuOtrZHeINRFgrHcGM1B5C8EFTN/dZR5iDo0OBxs4coASUPHo+cNINlCGceSSTnOyHf+zgJ9DKwm8sS2HqSQL4we+pM3CUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=he8nYJjF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713453888; x=1714058688; i=markus.elfring@web.de;
	bh=Vq9VWrH+gFfZimn1lXPfohIhS0gZTVPNGthLTor5jMs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=he8nYJjF8NSkYh7XVLsTbYt46l2oJtjrf7sFBEZI087XsHoijwCi8SYflOC5S93i
	 oMhyfqoTtyFw1N+LevQ8O6PaHdplLpvhhGvgCQ72vbALXvqA2PjJ3NpiCqIhX9xfF
	 P59EoYB4Gjn41LvycD3FkWHGAvrafh1rzC2YY2vUKAxVTHj4v++/cV7T8SnEOJMFF
	 4kz0SgAUv/BJqoWXrOCqYNvcEnpxUXs5+szlWh418GNU1aSh6dcs4VVV9/fLJjI6R
	 lNROEawpPyXDiWszg2NeHJA+LnFOEnW/gZRt0SeR4OsfYp+6mOamj22AWiZA7zE0N
	 aNnTiHfLSFH/EYUC6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1sdvze1UwU-00dp4F; Thu, 18
 Apr 2024 17:24:48 +0200
Message-ID: <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
Date: Thu, 18 Apr 2024 17:24:47 +0200
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
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240418131754.58217-3-wander@redhat.com>
Subject: Re: [PATCH 2/2] kunit: avoid memory leak on device register error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240418131754.58217-3-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18nIa5u5Z6yCz71VW5nr+AuTvLfOR5QY3AKj//R8Y/Oo6/3krry
 w1YOHjzYkwn4FfejR8lTSWBz/3UydDAgMyIUgBAKBqnAKL4FCkRKsJ+479V3zLa/USpSBby
 FLbnIHJmC/Ar/AhmHrVapw3NTVc7a0pgN0Xg9MrHxaRE4jNqudCHNH4GwzRlWocpDLgLxxc
 FG7pD6xuD/cIfev6+yqXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bv2N6UDqpNk=;q+yVHgJcfitJbCwRSNQKvalCrrl
 IZYAYamBlDjlWvVcnOizvwlPw+NxUcyMOspNOoS2UyZwweBn2AkLnJsVWgUqysNBvDViwk9Fn
 nWwS38GPvESSAwElOVg8JhdaSOxyb4VFrAfiVMmnVZbfpsNf5Qwzg6VAh0nRugpHhlpN0JF4d
 fBC/5Gjgax30/DmJI1LlML5/H3SPfEYhHt/7r4LFv5CHB716p4eQLWi9sfTjkHCHfkzLTd4BF
 tKYDeSho6nIVLGdSHmvFKI0Hdcw3OyGwkYrB7kW+hSeSzrVwYZqVCJR8RmggBHXLu6DVlKAu3
 sMAEwKXiANQ/jvP4AwRXXuKthFK3H+urBcAZc4W8BVREKD7mfMvheD/kjfeFFHyZRFrcs/mXt
 Q8UxoC5g5ni2a4fqqVoXVfjG5qc+HGSFdrXdQIUBUOvXGodk/Pjyx5jd3G487OBiGavX1Vg2R
 nSyKGQEYK/ZCTOLfr+H7Zcz/l2DoqqSYsDAVmFfOTle3kJy6d/H9705q2gL1Y+DyR8qSaFons
 7s4RxSji2dky2zs08/keO09kiFT4abU5fArXvtxGOTSJOLcqAHFqJ71wG98vrHEE90VrGcom1
 enXJeOvyqN0U5P1vJcWwKb0nij8iIpTIBLFXd9tXZ4G22jxfgDsVGAZTjFyM7chhRLt7RoiVQ
 HUQkcm1AX6aO4/JDl0YwDy1tzC+2I1v+vUSCSDJ4D7ZWWUHFH6gPK3G0LvF+jrS5MEPDUFHO7
 gZwFss9kH77P7ARAeUPXsZWN2x8rhvmg8Wkmx2s0J+YJuLZt0RbZ7VoHnjhUZvtOi5jC+n0OL
 8DHXPjUYxrtlqjTGBf9T62XfAhspE4KMmFizrhSQ4cIDM=

> If the device register fails, free the allocated memory before
> returning.

* I suggest to use the word =E2=80=9Cregistration=E2=80=9D (instead of =E2=
=80=9Cregister=E2=80=9D)
  in the commit message.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


> +++ b/lib/kunit/device.c
> @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_in=
ternal(struct kunit *test,
>  	err =3D device_register(&kunit_dev->dev);
>  	if (err) {
>  		put_device(&kunit_dev->dev);
> +		kfree(kunit_dev);
>  		return ERR_PTR(err);
>  	}

Common error handling code can be used instead
if an additional label would be applied for a corresponding jump target.

How do you think about to increase the application of scope-based resource=
 management here?

Regards,
Markus

