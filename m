Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFACC28F802
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgJOR7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbgJOR7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 13:59:46 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA7C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 10:59:45 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id h6so2954774ybi.11
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKh+0HzGrAAmsHpcRBa9cGPedjwN4QDV3FOpmLuMWLo=;
        b=nd45TYeMyASH3X2XxyTeQWZp5/vlwX5hzsc+o/t08Q0mcf3EzG7hfRG8B1D71kPDWv
         P4L/Y/FlKsu2tu7Hh7zScMTUyOH5KveObkxyPvPnTPo/3YQGSGWyzfTpdlC9qrqlWW80
         bU3Y+hf6NBmSUxGCm1Ea5ywrqXNTBbup7F7JrkVdmZ9fqWJaNqiiyv6oMVnxA0dD4DQW
         yvRptvHtkPZeT1eKFJzz8kFPSjeuXpok189ISDQrsKGL9r0maF+t4jH6/iC/BDeO+yfW
         0d/IgKhp2D1d8YfF4auBqFG/Y3OYKfTfzC5DI9/wE5eUDaA8XTJjRdP0Wmg7sWGTD/bd
         gHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKh+0HzGrAAmsHpcRBa9cGPedjwN4QDV3FOpmLuMWLo=;
        b=iaNeTteErLtg7xKbgy8Jsiph0er6PHoMk1jX4taroq7RBcFJrWtztNF7Vam3fRhR1+
         QxHr0V1e0T2GaE4GjNiwh0irGOnRVBCvs7fZShvzEgkUVp/W6R++HAlo4F4Y/03sTW44
         gmLx9+9mUNJJwRehW6KiaE/7uPY/czCU77F8Mzl/XW9E7gXYQFIr/f6PqoTUKmh7+PJi
         R7ccPxhyjqSJtvIzekWK13OvohudMyq5cNLa/4A9AfsAiXT0pSdUEt7YEe3uSwNmTw/S
         19KJK7XC9EkbhQdqqARlMK8bb77deLU1C0AKYp9Z1USwaVZ+5A7I4DQL+HYnlyTXJS9u
         eIuA==
X-Gm-Message-State: AOAM533yQF9lZKudOWbw7TS3RnZ9OH3BhN7kFVMMMyKZp2Jx+K82dtOK
        3akmIM7tdaN/XtEKBFOnAVdsyUuxTbsMzAND3dBMsA==
X-Google-Smtp-Source: ABdhPJwyxXAnCsEWQ2qq755UXIZ0LSyCvR1SxEYGrAYoLnYYwsalh/yzr9VPcTnFL7XmNsATtfKUXWEohcxiY4aMEDw=
X-Received: by 2002:a5b:1c4:: with SMTP id f4mr7199645ybp.205.1602784781497;
 Thu, 15 Oct 2020 10:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201015014616.309000-1-vitor@massaru.org> <20201015174823.GY4077@smile.fi.intel.com>
In-Reply-To: <20201015174823.GY4077@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 15 Oct 2020 14:59:05 -0300
Message-ID: <CADQ6JjVYiDQOJt1apsygEUK=530hfF9V+8QSZ_ntgvwYYoYqfQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 2:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_list_sort,
> > from `lib/test_list_sort.c` to KUnit tests.
>
> >  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)
>
> One more thing. The documentation [1] doesn't specify any name conventions.
> So, please leave file name untouched.
>
> [1]: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

This convention hasn't yet entered the Torvaldos tree, but it is in
the Shuah tree: [1]

+Test File and Module Names
+==========================
+
+KUnit tests can often be compiled as a module. These modules should be named
+after the test suite, followed by ``_test``. If this is likely to conflict with
+non-KUnit tests, the suffix ``_kunit`` can also be used.
+
+The easiest way of achieving this is to name the file containing the test suite
+``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
+placed next to the code under test.
+
+If the suite name contains some or all of the name of the test's parent
+directory, it may make sense to modify the source filename to reduce
redundancy.
+For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
+file.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=2a41fc52c21b6ece49921716bd289bfebaadcc04

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20201015174823.GY4077%40smile.fi.intel.com.
