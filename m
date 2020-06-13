Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28A1F816F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jun 2020 08:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFMG45 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Jun 2020 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgFMG45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Jun 2020 02:56:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD2C08C5C1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 23:56:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so9782243wmd.5
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFFZRUuwZyciolFutHUZy+k3hDO5IWFL+Mp7cEZTf1o=;
        b=TtPuXKAeBC4b7WRt8j5QlCvQ7mq3sQssnKqhuC8v1kjpfVTco+fsFkYswB9EdOATuX
         CAQ5eTEC7dTFj4dGzRkx4QX92FcQ0ZmMwQ220MlEnm5nXRwUf+c81iouibty9uX7iwSb
         AbCQ2Helzyo7TWlXliHGkSoX7ihF28qag1IFHomseE8hakNgDCZ9J5UC7O/UDdbN7WoL
         F/iLQGDVivhvyJx1U2pC9TkEvQbdby8dDNiuw6jiuPX7eaoDMfVR2PAE6hkkaVOBHVT9
         2NlNf2m5ByPos85L+6pKsBDYOdx/6fo+sDHHeeq5V9EGuw1pwoWtLAdt13n1wTRsWccC
         Fnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFFZRUuwZyciolFutHUZy+k3hDO5IWFL+Mp7cEZTf1o=;
        b=JNB+tmi5P6gmIkKz0Imhv0zvBCdsGptQbGrm001kwb9s0vZ26Ylvi5JKR8fHKD0JdB
         dbQJqFTsXPmm8RAJT/0TYoajKv0uyMUdNnyRA58Tgjkd3TOc5q95OL24esnrlhwjJC2X
         59xdPDO0tUs5UYhcxycW/iS//i+p3BrcD+zFv2su5wQLn5jvzJlTUfN7lkHalwHIG2oS
         jx1+OOeRUJwi1JyxENiqtcCl5kC/ll/c91K0DuqLLwOwDyvEaI7h8jrPM4HFi1cT3pck
         lKdhc7nCNkgsV9h+dw65WyJRAc+iwopNxtWE75nT3qcg7dbmjt2+aQ/05DUCfsNVPUWK
         9zxg==
X-Gm-Message-State: AOAM5316j/G7aw6n8gxQt3kmkEIW4NhelvRYA/N3nLgI+HOs1w554koJ
        jIPK6kpAEm0pBoZGkulQuWFYkw8TV/5VMZZRLloQKxNzs6XPXA==
X-Google-Smtp-Source: ABdhPJyXtTYSMyQ6wXdEQDy9VIp/SQ0LjE3BFblFW22MQ9kE0ZSsESdPTCKrAA1RGJrKDw9Ctu3dijpN+V/HBa0mMrE=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr2429963wme.99.1592031415287;
 Fri, 12 Jun 2020 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org>
In-Reply-To: <20200611215501.213058-1-vitor@massaru.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Jun 2020 14:56:43 +0800
Message-ID: <CABVgOSkMv22GDGin8GCqq4Vd=Bff7-VzEycmzKhUeKj9tErD7Q@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Kees Cook <keescook@chromium.org>, linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 12, 2020 at 5:55 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the convertion of the runtime tests of check_*_overflow fuctions,
> from `lib/test_overflow.c`to KUnit tests.

Nit: couple of minor typos here: convertion -> conversion, and
functions -> functions

> The log similar to the one seen in dmesg running test_overflow can be
> seen in `test.log`.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

I've tested that this builds and runs on my system, and it all seems
to be working fine!

Tested-by: David Gow <davidgow@google.com>

> ---
>  lib/Kconfig.debug         |  17 ++
>  lib/Makefile              |   1 +
>  lib/kunit_overflow_test.c | 590 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 lib/kunit_overflow_test.c

Echoing what Brendan and Kees mentioned, it'd be nicer to have this
replace the existing test, both because there's no need for redundant
tests (one will get out-of-date), and so that we can have a nice diff
showing the changes made as part of the conversion.

Cheers,
-- David
