Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE61240E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 09:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLRICN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Dec 2019 03:02:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37645 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRICN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Dec 2019 03:02:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so1388967otn.4;
        Wed, 18 Dec 2019 00:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQqCUv7RKIwxsorFpwyUpfxIl9jds6e+DU9zk9PVPIs=;
        b=Gb5HqcDsMXKtb+95DTTnDL1xWILA5la5D9B0ajXGdoBC8HvkwtpNC7zKQZO9yM0PUR
         +/X89b+Ql9CG91oDKppLWoTZTm5HeE8QzaFGtOOs8bm46ePNPX4fD2f/2J9b8M2NOq5u
         hcabttw6dBArxbz0yplQAAjY94Lzjbsp+6u04f8jiFsdTHfWWwtIcWB0Tm8gQq3c6TJ3
         0agAGOCpKAIvn+9URzwV0UiYIWGU6v+z5W0+XQiaLAjle6k+flko1QhHaci7x61WiTNs
         BWQXNgDhFXGbmcF1vGHMSP9dwYMxNuN/V3IEhk7J+u97TkYQ0OCpyX7PKLEG/DLikyje
         DsRQ==
X-Gm-Message-State: APjAAAVrLCTyEY5npIhWpWlm0pLQAKdO0/C0qWZtbWswtn7FhbqeyLmn
        oo5FMRUuIHcItGCs0M/KSzEClA/ISLxZ9/0+rcDcwEhH
X-Google-Smtp-Source: APXvYqzUfNZ/rvrZwk3wwyL1jpu6Y00InJEF7jIq3BEr3gS2sXwq9ICRHCV3bOYHa11F/bhIR6qTWjscOP47Vu+a3Ak=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr1280207otm.297.1576656132308;
 Wed, 18 Dec 2019 00:02:12 -0800 (PST)
MIME-Version: 1.0
References: <878snajjh2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878snajjh2.wl-kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Dec 2019 09:02:00 +0100
Message-ID: <CAMuHMdUq6U0i_+Dg57jVNYM4iephuZ8k3QC6AyQ--W_qY5=q9w@mail.gmail.com>
Subject: Re: [PATCH] sh: use generic strncpy()
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Karl Nasrallah <knnspeed@aol.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Morimoto-san, Karl,

On Wed, Dec 18, 2019 at 6:22 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current SH will get below warning at strncpy()
>
> In file included from ${LINUX}/arch/sh/include/asm/string.h:3,
>                  from ${LINUX}/include/linux/string.h:20,
>                  from ${LINUX}/include/linux/bitmap.h:9,
>                  from ${LINUX}/include/linux/nodemask.h:95,
>                  from ${LINUX}/include/linux/mmzone.h:17,
>                  from ${LINUX}/include/linux/gfp.h:6,
>                  from ${LINUX}/innclude/linux/slab.h:15,
>                  from ${LINUX}/linux/drivers/mmc/host/vub300.c:38:
> ${LINUX}/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
> ${LINUX}/arch/sh/include/asm/string_32.h:51:42: warning: array subscript\
>   80 is above array bounds of 'char[26]' [-Warray-bounds]
>    : "0" (__dest), "1" (__src), "r" (__src+__n)
>                                      ~~~~~^~~~
>
> In general, strncpy() should behave like below.
>
>         char dest[10];
>         char *src = "12345";
>
>         strncpy(dest, src, 10);
>         // dest = {'1', '2', '3', '4', '5',
>                    '\0','\0','\0','\0','\0'}
>
> But, current SH strnpy() has 2 issues.
> 1st is it will access to out-of-memory (= src + 10).

I believe this is not correct: the code does not really access memory
beyond the end of the source string.  (Recent) gcc just thinks so,
because "__src+__n" is used as a parameter to the routine.

> 2nd is it needs big fixup for it, and maintenance __asm__
> code is difficult.

Yeah, the padding is missing.

> To solve these issues, this patch simply uses generic strncpy()
> instead of architecture specific one.

That will definitely fix the issue, as we assume the generic
implementation is correct ;-)

Now, I've just tried, naively, to enable CONFIG_STRING_SELFTEST=y in my
rts7751r2d build (without your patch), and boot it in qemu:

    String selftests succeeded

Woops, turns out lib/test_string.c does not have any testcases for
strncpy()...

So adding test code for the corner cases may be a valuable contribution.
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
