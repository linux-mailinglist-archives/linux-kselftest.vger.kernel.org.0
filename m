Return-Path: <linux-kselftest+bounces-49140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBFD2FA4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E61530319F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF44D329E46;
	Fri, 16 Jan 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndol4E9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3F28B40E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559713; cv=none; b=fneVydaPpEI8t5CV6NK3gDMXPDnMePb0IyUGWhi34UtwTgyOYOFEw2m6Ab+2UsLkmEkA82ArEZtSlHrb7QBE/oZb5fv+LKSOBfE/xKY4cj5LNfvJjP+sAI3BLkzYfJVmI3zQvsYhXstERR0O6Di1T3LxFPJ5WFYOaf4yk40SMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559713; c=relaxed/simple;
	bh=KSWdzg1gOF99TWW9j8m3/qPK4vSpI6A17JhlDPLJ2Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV1hl4+mrGLN+AeYvef0mazJoU1KH/LTXta1opwUxedFG34XnwEKmtvfkRr/fEcZn97SomztMqHU+nNywvcRPPyYafhutHeQwWkU1ygZ6+h72iiQIBCi9sy0ylhxr4jjeol2h+KkWvboETRee1TNHVNQB8IhHN/KVkQXdZ2rqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndol4E9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6372CC19423
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768559713;
	bh=KSWdzg1gOF99TWW9j8m3/qPK4vSpI6A17JhlDPLJ2Bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ndol4E9zjVO1ob4hrYysx78HhwXkjOZJFcbgg7kxOXZhCewB1CtxSq1IkIfEGN1TD
	 QSY2Bg5odi00tZNaQk9ghQBIr6tfn5qohAUjz0QfKk4w5yWlOjIBnlFtoEza67yMbW
	 m+ZN9kIoFxbDdbAZErN6tMERO0cHpCRpcvuJPI4olZaoUsO1TpY+AzRYKIg0Gkzr9y
	 s/p4chGdD4LSkQHzhE33zscjD5wytXNw2Mc4JUxwiNwP0y5sjZh0GusGaavTgPPsHL
	 a/4iWrbsCV8/AI252oKl72yFcbBz6T5c/j/XPwnrMasIxv7RjOPId+4VJa8vyp7R4k
	 aZRSLIyvTc0Mw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so1941002e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 02:35:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGGs1PHaALGm4LxWcfeqZ/Xs9aUwkjx/EUnGyepRKJw1SuJo6s9x3PBbns5fGu+Y1mthbV+rtZqmM/n+YnrIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQa6xfAzY9oIXWBikJYq7VCMr0r7Sfp0v91tLv2EL5e75tYewF
	KB94qnygpEQCTytzuW5SIyzl+0GXzzrW6Jw1ci4lXRTIzGC4lWJC7TJIF3aH17yTJ6uuwKLbuFJ
	uMcs5df3m+AZtzmtT89woLNnKSZQCrdHo1oWleb5LYw==
X-Received: by 2002:a05:6512:3b0a:b0:59b:707d:1db5 with SMTP id
 2adb3069b0e04-59baeef6ef6mr744298e87.29.1768559712051; Fri, 16 Jan 2026
 02:35:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org>
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 11:35:00 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>
X-Gm-Features: AZwV_QgMLckxVJmhlVGfz2mb8tqX8HZItwcSTfGc8Lsh6N3NsV87v74hAVT04jE
Message-ID: <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] gpiolib: Adopt revocable mechanism for UAF prevention
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 9:11=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> This series transitions the UAF prevention logic within the GPIO core
> (gpiolib) to use the 'revocable' mechanism.
>
> The existing code aims to prevent UAF issues when the underlying GPIO
> chip is removed.  This series replaces that custom logic with the
> generic 'revocable' API, which is designed to handle such lifecycle
> dependencies.  There should be no change in behavior.
>
> This series depends on the 'revocable' API, introduced in [1].  Some
> build bots may report errors due to undefined symbols related to
> 'revocable' until the dependency is merged.
>

Hi Tzung-Bi!

Thank you for doing this and considering my suggestions from LPC. I
haven't looked at the code yet but I quickly tested the series with my
regular test-suites. The good news is: nothing is broken, every test
works fine. The bad news is: there seems to be a significant impact on
performance. With the user-space test-suite from libgpiod (for core C
library - gpiod-test) I'm seeing a consistent 40% impact on
performance. That's not really acceptable. :( I will try to bisect the
series later and see which part exactly breaks it.

I can also help you with user-space testing with libgpiod, if you need
it? Some documentation is available here:
https://libgpiod.readthedocs.io/en/latest/testing.html

> [1] https://lore.kernel.org/chrome-platform/20260116080235.350305-1-tzung=
bi@kernel.org
>
> Tzung-Bi Shih (23):
>   gpiolib: Correct wrong kfree() usage for `kobj->name`
>   gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
>   gpiolib: Fix resource leaks on errors in gpiochip_add_data_with_key()
>   gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
>   gpiolib: cdev: Correct return code on memory allocation failure
>
> =3D> The first 5 patches are fixes.  They aren't directly related to the
>    replacement, and should be able to apply independently.
>

Awesome, I'll make them a priority.

>   gpiolib: Access `gpio_bus_type` in gpiochip_setup_dev()
>   gpiolib: Remove redundant check for struct gpio_chip
>   gpiolib: sysfs: Remove redundant check for struct gpio_chip
>   gpiolib: Ensure struct gpio_chip for gpiochip_setup_dev()
>   gpiolib: cdev: Don't check struct gpio_chip in gpio_chrdev_open()
>
> =3D> The following 5 patches are refactors.  Makes the subsequent changes
>    easier or at least clear.
>
>   selftests: gpio: Add gpio-cdev-uaf tests
>
> =3D> The following patch adds kselftest cases for some classic UAF
>    scenarios.
>

Thanks, these too look like v7.0 material for me. I'll try to review
these ASAP too.

Bart

