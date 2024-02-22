Return-Path: <linux-kselftest+bounces-5279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FE85F642
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F0F1F26BE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1293FB29;
	Thu, 22 Feb 2024 10:56:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B303FB20;
	Thu, 22 Feb 2024 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599396; cv=none; b=Fls+nbbTjWjvsEwr6Dwb4KlFrKqJHVMLv9WBkYYPP9J2PzIe860wuG0at7HCfwEc3Bqs7J/x6+CgxYkP8hQ5fA99z/xmzaO1J91/O4bPK5kel1I5cxaAo3mNxXP/2P9RFH8OCw0DiYygsQp7n1as7Z6x6S5UOU1CtFLD5qfSROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599396; c=relaxed/simple;
	bh=8g+lYpN8PpwWg0/O+aRDucx/TvK0rLYZ+SiW1gOuKe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvBpPs/94nTQV0/CYgQAyrrh63pmSoEPGWjgzJSgpxv/93/PyIqwvGPv13UmxK0so86l1/xKQp0FeNUGqUceksg45JVIU9Q0OmYuTp6LNdw2ubaIWiNLCgFbXZayXJV214Wy6ULYcFkwTL0EjoPOCBky1qEtiAHCK0+9opYJd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6087192b092so17504617b3.0;
        Thu, 22 Feb 2024 02:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599393; x=1709204193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6Mwqh7Sl6bufwbB2Ww13UZ/ncmsWLmvES2OI56tSlk=;
        b=ryICKrceQLTd5gSoO39lN9v/nDdf8HkU18sgFKm4cSeJH0Tl0RfgjGV2S9PgvtBzuz
         JKaDnwQmubuKUnIfClKm/PIubvMo4q3X25IwTzxLpLSKxY5lSYPtg8R6MNzKV73R/BzL
         mXd3rg8MFXjCk7GMOfDn2Pzop4bB4KxrtLf5Mzu2c0dhi1MkvlGr3OlGe7upx+Az306n
         22LYt3bj/8JC1jLnVAmlNIj/0UOlWl+EaVEBeh6T19r+xrAtEkOsHNpbGfHRyPUULres
         hddmm5yzxTz8MqWP8julAjcPk+2tH286pkkWNlBs6wxv5NMgW1l7WBVqip9xDm4isyFq
         HsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4L+7EqyniWRfiNyiBBCr3Kp45NQ/uscYIzkNs01Q7q/esahGUjoW7ouFSJHm3I4tnsgiU3YkaBjmJ4URjY6xUGlnD/k8M/kdFY8ELVVdJOXQDstC4M9e819OWMVVpEZW0GyZR6lrYwM21B+ilB6gHIQk1MpMGKIj0y9xD9eaAjAhCzwj/B6WY4dzOV164/M2aemm/rjkNT82IqCV/UJczzXrt
X-Gm-Message-State: AOJu0YzQDDpxbe/AGemyDJv+NaQZrLnEPrX8We6ns0zdVJLqBpJ1VA+f
	WJy5668PEbNJsfYwocgqDLsfs4xd5fxO4kvBFeR9rTeeO2q8N3aQt0rgzWFYsso=
X-Google-Smtp-Source: AGHT+IFuZhjL2WglPCgMJead0nQTTvgJizaaE4vI9V6/6UQESGu3ntQNF5P1ykGPZ/0gue7Drzsw4A==
X-Received: by 2002:a05:690c:d17:b0:608:4bab:8b06 with SMTP id cn23-20020a05690c0d1700b006084bab8b06mr11205956ywb.45.1708599393609;
        Thu, 22 Feb 2024 02:56:33 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k62-20020a816f41000000b006047d63bc78sm3016184ywc.72.2024.02.22.02.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:56:33 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso1892988276.2;
        Thu, 22 Feb 2024 02:56:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe7BQqRfQKXOoI96vL9021illL2thEgWHvUESPfMZrg7GKFVIlNEKRMaEAegwnJvVclKsnmlUs1TGh0ZvYXmXn6Qh6XJpB7uhYkkvxlMboArxO3vgzWQJBuRba/4fAi4XTom246NwKdfzKFdohPxk3PTamKXzMko51qqWSzc0UniTCDNKU0yUoSu4p0dBAmauaLpoHTHdid4g+W8c5psW0Yf6j
X-Received: by 2002:a81:ad28:0:b0:607:838f:8991 with SMTP id
 l40-20020a81ad28000000b00607838f8991mr18891390ywh.38.1708599393207; Thu, 22
 Feb 2024 02:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219223833.95710-1-zfigura@codeweavers.com> <20240219223833.95710-2-zfigura@codeweavers.com>
In-Reply-To: <20240219223833.95710-2-zfigura@codeweavers.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 11:56:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=aXYmUbVNOH9osDFB+nv7N=xpE76w_Ds190tV1-D9=w@mail.gmail.com>
Message-ID: <CAMuHMdX=aXYmUbVNOH9osDFB+nv7N=xpE76w_Ds190tV1-D9=w@mail.gmail.com>
Subject: Re: [PATCH v2 01/31] ntsync: Introduce the ntsync driver and
 character device.
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, wine-devel@winehq.org, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elizabeth,

On Mon, Feb 19, 2024 at 11:42=E2=80=AFPM Elizabeth Figura
<zfigura@codeweavers.com> wrote:
> ntsync uses a misc device as the simplest and least intrusive uAPI interf=
ace.
>
> Each file description on the device represents an isolated NT instance, i=
ntended
> to correspond to a single NT virtual machine.
>
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

Thanks for your patch!

> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -506,6 +506,17 @@ config OPEN_DICE
>
>           If unsure, say N.
>
> +config NTSYNC
> +       tristate "NT synchronization primitive emulation"
> +       help
> +         This module provides kernel support for emulation of Windows NT
> +         synchronization primitives. It is not a hardware driver.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called ntsync.
> +
> +         If unsure, say N.

Is it useful to have this feature on systems or architectures that
are not supported by Windows NT?

If not, this should depend on <something> || COMPILE_TEST.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

