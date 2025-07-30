Return-Path: <linux-kselftest+bounces-38079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DDB1594E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE21887EC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE91DED53;
	Wed, 30 Jul 2025 07:09:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB54E55B;
	Wed, 30 Jul 2025 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859353; cv=none; b=YJfNSFq+mVvTKf/F6RrZ6C7wftRiDNGL3w8RTGuPJf6UEiLmq0guZGHEoigI9rr+gEaKsc66YzgXqZTx+Cj1UqX7B9VEBWx6xtwkyX95F56VsCt548esWnCSN/5svJUsrrrnkLiZWUrODD02pT/FwdkWobUH3Mu2UWWqDC5XyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859353; c=relaxed/simple;
	bh=cpyg7+SssmixBibNAAVlopRj2Yy2Zu+PVYzWZjWOg3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cC/IdWBE3hhAw5x/zrKihmBZqvDA8HB39z+dTTqLK1kFuORUK2GXRcjiZCyHmH5v5Tmbn50JpPEu+gy3bHT4Ps8mi//BJRnNy5FWPeZp4QG5gUPSma7Jsy8gW9tC9W97aHeWGd8f6W8SZA1azMShYDfo1ktBWueOpQUv+yw3otU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso2869186e0c.1;
        Wed, 30 Jul 2025 00:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753859350; x=1754464150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQSQokBnxqqY+8kUjyXkmv0h9LGdm7ljH7u2UnABSuQ=;
        b=JVcToM2wX5/kLkJ/+bpNON+uz4iVj2dknGyucb9QyovmjPDNQ7fvcjOJQTtrhMZvG4
         vPHbLZk5gESP91WpS5iABph8aoRnD4/baBV64h9JqViNSLaOd7RAf2fRHWVAS4pBkWDt
         mdiqMv2mTDNj50XytsEK9KONtscGy74jLyQl30MEVollBY57A2SOEzl+rEiJ9hb6JZye
         5ZpGkparNYB3N5z3HWUX6oudEonJ2Rld3uZ3SCgkqgUMRSL5ZZln05a0JNVtWpEdibRO
         KEK0hF4LkafpV8luHH62Xu6qQJY2iOGMd0SNVx+z1yYSBvJb94dtsbqKtdScTaplIx2x
         Mywg==
X-Forwarded-Encrypted: i=1; AJvYcCVAIYKonEnD9/H33d/lk+i1cK0jjLhpjkGrbXOO2Z9fctHcRKe1QJrZQP2SnPiXozJVDM8S5xPzG+6zR9M=@vger.kernel.org, AJvYcCXuwJpUccvlsl8rvvVU4wewEIZVK7a+TOTJaX7E8z0nnC1rFHgDQ8tdPYAQFn/7v8nTBW37fg/fxyvUjNTEhEFC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0EEAjdgOnk6TexEhC89hGEByj7T2RxraEyNKcL8+mRinVN/8
	NLU6y6MmDo/mw8Vh4791puCmBB/c12EHM8KBCYNpK/3lfTObmenSXoHfjkBJ+ejX
X-Gm-Gg: ASbGnctm+q+fjIzvNCzKPsKcOHRzlowv9oP95Rj6dwWRoxUIN2wCJEwEYCO2cfB22SC
	MrLnC8JSEFLTi91fxJX4M3ZDg4g0dD/qIXK/vUdB+UI/0kXluk7IKYMNFfc95m8acbo7ZQsKjmH
	rvl2n4if0XMU2alYNnySF6CcJO/6xbZswCYPig9vkwznlA/j4V6vckpBn9v7jBFrDfY3DqARJy4
	x1T2dJbpyUoTAfyqikQ8aX2K57tmI97bYFevczPfkNOfdYRDO7IgAN7lVsbqTYC49lUkpg7ebS7
	DE65rUazb8u1zY96CtRZt+b83uZbm0yHOyfR8NeMpZVnGt38OCPuCRi4jDetJOb3NW6S4U8YN2d
	zHqECE65yZfregtAzlVv4H+7CvvbX4qV4Jufh0Y3jtPdCqUHZuj8mRCELXTXL
X-Google-Smtp-Source: AGHT+IGof9faKmVMufJQK1Dq82H14MQTHR+KIce2/H+CmOj0/JrbdN2WtD0dusoRRXifONtJLn4myA==
X-Received: by 2002:a05:6122:d9e:b0:538:dd8b:666b with SMTP id 71dfb90a1353d-5391c9d0a70mr1545143e0c.0.1753859350129;
        Wed, 30 Jul 2025 00:09:10 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8d902bffsm2297506241.10.2025.07.30.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:09:09 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-88bc6f023edso493635241.2;
        Wed, 30 Jul 2025 00:09:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf3Wz13fLi58Z8OAotgfDwseIPlvQkHexVmLcXp0AEgIHhSHlpyvVNrNzjUxFjLOkHh+IjECO7BaCB5Gk=@vger.kernel.org, AJvYcCX+a2E9Wl0PFIe8CRRa1ZBXXOo/LJ2VRIdO0MayBsYbMA3pvU8RKTcScc7/Dhp9+qgvmLp5EI/Hho7ahZQuzeIW@vger.kernel.org
X-Received: by 2002:a67:e00f:0:20b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-4fbebe1869amr738719137.12.1753859348845; Wed, 30 Jul 2025
 00:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
In-Reply-To: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 09:08:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxTW-6Wpw6qDc_ZoSE-f21WvJ478j+0jQURL+SiM_n7A@mail.gmail.com>
X-Gm-Features: Ac12FXyVlivqeZdWusp45xQnWO6PiyOPHxe7Bh78pQOb6__ve0XIVM5je-ojSKQ
Message-ID: <CAMuHMdVxTW-6Wpw6qDc_ZoSE-f21WvJ478j+0jQURL+SiM_n7A@mail.gmail.com>
Subject: Re: [PATCH v5] char: misc: add test cases
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
	Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thadeu,,

On Sun, 15 Jun 2025 at 23:31, Thadeu Lima de Souza Cascardo
<cascardo@igalia.com> wrote:
>
> Add test cases for static and dynamic minor number allocation and
> deallocation.
>
> While at it, improve description and test suite name.
>
> Some of the cases include:
>
> - that static and dynamic allocation reserved the expected minors.
>
> - that registering duplicate minors or duplicate names will fail.
>
> - that failing to create a sysfs file (due to duplicate names) will
>   deallocate the dynamic minor correctly.
>
> - that dynamic allocation does not allocate a minor number in the static
>   range.
>
> - that there are no collisions when mixing dynamic and static allocations.
>
> - that opening devices with various minor device numbers work.
>
> - that registering a static number in the dynamic range won't conflict with
>   a dynamic allocation.
>
> This last test verifies the bug fixed by commit 6d04d2b554b1 ("misc:
> misc_minor_alloc to use ida for all dynamic/misc dynamic minors") has not
> regressed.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Thanks for your patch, which is now commit 74d8361be3441dff ("char:
misc: add test cases") in linus/master stable/master

> Changes in v5:
> - Make miscdevice unit test built-in only
> - Make unit test require CONFIG_KUNIT=y

Why were these changes made? This means the test is no longer available
if KUNIT=m, and I can no longer just load the module when I want to
run the test.

> - Link to v4: https://lore.kernel.org/r/20250423-misc-dynrange-v4-0-133b5ae4ca18@igalia.com

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2506,8 +2506,8 @@ config TEST_IDA
>         tristate "Perform selftest on IDA functions"
>
>  config TEST_MISC_MINOR
> -       tristate "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> -       depends on KUNIT
> +       bool "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT=y
>         default KUNIT_ALL_TESTS
>         help
>           Kunit test for miscdevice API, specially its behavior in respect to

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

