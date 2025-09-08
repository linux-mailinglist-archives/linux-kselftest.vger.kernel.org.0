Return-Path: <linux-kselftest+bounces-40963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A6B49636
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 18:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A362016EF29
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC130F7F5;
	Mon,  8 Sep 2025 16:53:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C930BBBE;
	Mon,  8 Sep 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350426; cv=none; b=X5L3412O/i4Uf+fdATOcfPgXZQEttj1im23Em5GK4MGiG/eqgVMZnKL3GRPq3TxouVErdAgKjTh12NPIEHSVvn+49YBHIKRrj+0t+mV2TRAMi9do/mmhQ+0f3Na0ebsmjLYNe1yS6KDhD1kT4UUKN4tx4RJIrS9z0kKN3wQz6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350426; c=relaxed/simple;
	bh=IQEhP6Ewpoe1sUPg5Y9dlP97w3+80wUVzmc9wskMYRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Btd9ds6cXlGBF1p3/VSefzJzkLM79HjWUhpS5rrlmkssLcuw6zyJOxlTPWvcXIjT0m+AdVelUGmOo6rNwUVRxvV9krIH3qGwi0Sr0+Zy1JqWMm+xU1d1IxyYyn2BO+kloDiOcJnM4Jj/SI8tH+ehfS84b/xXjaapyzTbwMuq+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-544ad727d19so3483201e0c.0;
        Mon, 08 Sep 2025 09:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350423; x=1757955223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjkBXLakCAW8SDkTXur5T0KLhtwghv0ugvjIac4M9HE=;
        b=IBMCr9iaPAQHYmubOPebfQlSDBQgfMRVcF7sSDOciF6ft3sonTzbmwMsQRGuwomJ6v
         9+lc9HtwhwDYYnV8cSZyoms840tIH8QTi7YVxTwZsJRNW7cGvmVKHAZRhQ4Lpxsu7TWW
         AY9sK/e+Zd4nAocSDKiwV+pqXDA+tGxse/tjuUQiEIKE+GSyK3QkWVB93hHzv6BUBmMQ
         R/MOq1zmbYdCSL3wurX6hsxOHtKv7mDTLKnvNgbMjpaxJCBOhuRpgm2ER8+43pUwQ0Gf
         A5FqvlGkzcOLst1dqvUQNN6pKLx3Bod+nUx9TqShg0bpIDTKRSzQ5Yp0+tH4HEYceurf
         z2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAypQQkMX1ZH/EJagKBA1ymz5SGaXZFK6YO6CYeYpM1tFLl5UTXNMCRiiWEjB8R9Ew8UQSu4XUO5IlYa0=@vger.kernel.org, AJvYcCVDmGG5LzMKEPg3G9TPwdgutWjKUieS5RSr+jttkIR0/YMRPYZr2ifWMCzCJdJlN6X1usOfgl296GDbO8SPHqtf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LRUOjYijySChE5dWLwnOZI4yZSZHmCU6cb3aemm0x8hpyA2R
	7lzhDBffCMywUXZGQRmHmpJceZwOVHCw050ImvfD8hdj46WrkbUQ62RIAsUUgeyx
X-Gm-Gg: ASbGncuSe4jwogzU000iMI6KP1hJLuscakPIZd74G+H72Ff5rw25PBplAwbuozFExf6
	hym/FLK/mGZOfgw+/po1sUY1LRJu9eGZ7VMNYG0powY1kv0OfKFs8F2srVAR03bxoOsbXU7iVCg
	6UZ3q8TSdJpfyxJBjz8qNrIgPWbvytUvM/a1UAyh7yI7Y9XtJ1YpDF+UMir8vINDcP8c6Tem+1y
	L5aSFiJjEBkgCiXCJkWsPJRJWPBqWuTzPBlgGiPkE2YhtSM6NNyk3nAr3I6xlWTj3J0pPcua2LK
	tEzRN145o3F7MzH7mXtvAC3kVvo9gNvlPb03ektEivzefZ3bcooIabji9twa6Na/klIMA6fTunL
	7zV7WNp8gRTal3DAuFbbva+BXQ9DeZCdXTwvQ1KPs/UTzs73kOuZPHagOQJ1ZYPLlFms3guo=
X-Google-Smtp-Source: AGHT+IGCU3pSQ5a20Mvp121BgsrOR0AYA4YibGM88m1hSi/Iqepm+x/xX/1LgeJ1dO0w4nLhG/96fw==
X-Received: by 2002:a05:6122:2a55:b0:545:af6d:1edf with SMTP id 71dfb90a1353d-547a724360amr2409975e0c.5.1757350423034;
        Mon, 08 Sep 2025 09:53:43 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491485a34sm12742437e0c.21.2025.09.08.09.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:53:42 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8900fcc0330so3573384241.0;
        Mon, 08 Sep 2025 09:53:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsqOZTYcghcqCq88SeG+L4cEofUm7eAHDTRT5orGdNhMXSmLx9FpkJetlwXXvlP8pm3h2Rp0ascQjx+K8=@vger.kernel.org, AJvYcCXEuSYhAzdgTyVPKhFpHcomegxOYM7VR2e3lpFWch7E/zuLx0U9hAhcQ+eu/XcNC8hzeRd49IsbBGkJXo1URvAU@vger.kernel.org
X-Received: by 2002:a05:6102:837:b0:519:534a:6c36 with SMTP id
 ada2fe7eead31-538ee110d66mr3147822137.14.1757350421953; Mon, 08 Sep 2025
 09:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 18:53:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
X-Gm-Features: AS18NWCOgGkOzhjvanqfDUP1q6zt0NU9rXDim1ALfm6PZrsbbVsOgLivd9-1uTg
Message-ID: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, 8 Sept 2025 at 09:04, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
> Various KUnit tests require PCI infrastructure to work. All normal
> platforms enable PCI by default, but UML does not. Enabling PCI from
> .kunitconfig files is problematic as it would not be portable. So in
> commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=3Dy. However
> CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() i=
n
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
>
> This warning is confusing when debugging test failures.
>
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
>
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for your patch!

> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>           If unsure, the default timeout of 300 seconds is suitable for m=
ost
>           cases.
>
> +config KUNIT_UML_PCI

Where is the consumer of this symbol?

> +       bool "KUnit UML PCI Support"
> +       depends on UML
> +       select UML_PCI
> +       help
> +         Enables the PCI subsystem on UML for use by KUnit tests.
> +
>  endif # KUNIT
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/=
kunit/configs/arch_uml.config
> index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486ef=
ff8898df79ee090 100644
> --- a/tools/testing/kunit/configs/arch_uml.config
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -1,8 +1,7 @@
>  # Config options which are added to UML builds by default
>
> -# Enable virtio/pci, as a lot of tests require it.
> -CONFIG_VIRTIO_UML=3Dy
> -CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> +# Enable pci, as a lot of tests require it.
> +CONFIG_KUNIT_UML_PCI=3Dy
>
>  # Enable FORTIFY_SOURCE for wider checking.
>  CONFIG_FORTIFY_SOURCE=3Dy

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

