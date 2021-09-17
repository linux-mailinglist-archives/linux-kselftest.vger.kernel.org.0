Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959B640F364
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbhIQHjv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 03:39:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbhIQHjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 03:39:49 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4i7l-1mrMEX1B39-011fzs; Fri, 17 Sep 2021 09:38:26 +0200
Received: by mail-wm1-f44.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so2847100wmj.3;
        Fri, 17 Sep 2021 00:38:25 -0700 (PDT)
X-Gm-Message-State: AOAM5329Gb+ssnvXdH6heWdrpkJrTgtyGZf9WsbMqUt834XsUrgm+rxv
        hDbfhWuOcLY6tPc4svV17GmuQ/VYhu59DCu8OH0=
X-Google-Smtp-Source: ABdhPJzqEZb8uxQdpRwHZH0EmrNx3v2i+fVgS6Kr5ZrLrEswJ1yeHIrJXd93ArwHsVs0YujyejdmCw8mrsywRiSe6lo=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr8990196wmc.98.1631864305564;
 Fri, 17 Sep 2021 00:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 09:38:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a257cAgtPhT1Li2GnZ-UZW3LVZa3fWX1YUnWGEENvpqJA@mail.gmail.com>
Message-ID: <CAK8P3a257cAgtPhT1Li2GnZ-UZW3LVZa3fWX1YUnWGEENvpqJA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] kunit: build kunit tests without structleak plugin
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8igt7gSCPa6W3i8e60BRlnHtEl3QLqROvP2iyXqGUxh9JjbZsya
 YOaky9kf1Z103GywzFAUeR7J7/q3zN3dwsOIil6WaIJcddqZDBmpVy5lEde5P/6vdR9Ecax
 RAflHp7t6feK1wbEO3TbUmIB2JF1DXQzxa7nCxtD5gvuXtwzF3XCXyRaqFQJTMbL8BFi83B
 c+On9PdB6Mw3L6t3AL4Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MTx620soU1A=:zwxZqn0uhqEr29Vzm2xKd7
 HbGFGLmUB8Fyd97OaZAEvOLFES+LAkYe2uRiZ8JKz+VOoJcL9sjY07kk6u9Qw2GhZRLfR8khr
 OkhmDgxaiUrNA1eOkAQQtyS7wwjP3dxpN72SiXOxalJHdhn6Xp9QaUqes6OVgK6W8eslCwk1+
 0ws7QftXW71rdRgA6lE4yjfOMd8UXGoxfihA/HA8ZJMizMXUP7gxdXTCWUoMPyW+cWQe0viaY
 VAONw7BiGUGOg/Lab+ejI/XT2ot+JZ81tk51S1Np1H0meXOZza+nYm4MZQVpLMc0tUQ+rNaa4
 JogkHWN+ga4za1pm1qgYdaKTq32+MHCYukDc4M3IIRcvrveaF7l5fPEocmLHjp+D4PYVsuY/N
 +4WqCgE54w8cvQhlyPSoDtYmCu1vbROd1jNQXrv1v55bqaPuSPKZAmTX+a3Z5TTP2p39Aas5f
 JPUkM5fjJcawL395lRUylcbgXwY+BDc3wh1Dh0bf/FwFyf6SdIvFCbN6WHnjMvHPxA6zWc3sb
 o7OxFo0zrC7oQoTdTzGp5oWGokdXNF6PSlwq8mjn0WKvMzKAn1Y7SNm7gQeZCDjpwVMLhhKec
 xMyKhKqdHw30dmrEC5nSQMzVTkZgL/63jkDKGcopG6+NwcojOdjMJITp7p8oXSq4eC7ofJ7wj
 m43vCNnd1kJ+x4S7gU6ryr7iOJFwvIahFxpiBF4dURwIWFRBayL7+ObAWBwRbYLYgYk/lyvfT
 pYv2NaddWqsqr3gys9VpWZRk4RFQmimu4wrEsEFbDV4+MVNLdhyUkDBs2kfKiAeHFt5hpxEe9
 FX36ZULmCuk9K+BQhU5AUSNJSBIJUoLSFMr9js5G6SdiJEWFwvPcykykqdXINyTLTUPfhznCV
 2MP77ZLr7QbEOjoSHwFQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 17, 2021 at 8:10 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit; this is caused because KUnit allocates lots of
> moderately sized structs on the stack as part of its assertion macro
> implementation. For most tests with small to moderately sized tests
> cases there are never enough KUnit assertions to be an issue at all;
> even when a single test cases has many KUnit assertions, the compiler
> should never put all these struct allocations on the stack at the same
> time since the scope of the structs is so limited; however, the
> structleak plugin does not seem to respect the compiler doing the right
> thing and will still warn of excessive stack size in some cases.
>
> These patches are not a permanent solution since new tests can be added
> with huge test cases, but this serves as a stop gap to stop structleak
> from being used on KUnit tests which will currently result in excessive
> stack size.
>
> Of the following patches, I think the thunderbolt patch may be
> unnecessary since Linus already fixed that test. Additionally, I was not
> able to reproduce the error on the sdhci-of-aspeed test. Nevertheless, I
> included these tests cases for completeness. Please see my discussion
> with Arnd for more context[1].
>
> NOTE: Arnd did the legwork for most of these patches, but did not
> actually share code for some of them, so I left his Signed-off-by off of
> those patches as I don't want to misrepresent him. Arnd, please sign off
> on those patches at your soonest convenience.

Thanks a lot for picking up this work where I dropped the ball.

Patches 1-5 look good to me, and I replied on one remaining issue I see
with patch 6. I think you did more work on these that I did, by doing
a nice write-up and splitting them into separate patches with useful
changelogs, you should keep authorship, and just change my
S-o-b to Suggested-by.

If you prefer to keep me as the author, then the correct way would
be to commit them with --author= to ensure that the author and
first s-o-b match.

        Arnd
