Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA1AC3BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfIGAoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 20:44:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32976 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393085AbfIGAoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 20:44:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so4462956pgn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2019 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq+ViY1LzTKSZu7bhAccIqZ/Vrzl8d1032PbomfEyFI=;
        b=n7/teM7m5aZbE1shei+cdfMkg1tdBR1zKLy2TcRf4qFA/v75LU483wyCY0kuW4fasm
         bN/U3dSFZ4TbNy62Z05NOELMTUHQavfaiZqchmgH9E+RL4jPMFy2VLEkyaq9ca9pr0+a
         ZtJVrhe+xaj2XOVmemaHzu4vlvc6I5+qzRPaNW9Qn/xqDysDhAG2o452neAD5n++i5pc
         w0dokgJeE+NPPJTcIyIErlfWZTS4yYfJQuO6qj6PftV/CI8Kl2mlEh5olkp8HBhpTCP3
         QSTPAsailtOOs1KCcL1ZhUdXYh+JQanFd19NbVdG3YvcKcqKaAwZFjD7MM+IsbXn+F4i
         fkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq+ViY1LzTKSZu7bhAccIqZ/Vrzl8d1032PbomfEyFI=;
        b=Bi85uJi63ftiMDci6V1tIVA52KCDTlfFLZCL8Q7qdbh/+rjnD73iIdh1iduWtYHcZQ
         tpdHQEWdozYPXZREorjL8QDHU2BhiKDrwoS5dx+HiW/t2oR99UcZU7hJhdJZgSGMjiBn
         OFoejZinLU6w0YMf4m1MMFEPquWfULLgMSSE+tigcHPp57N0R+X1WtHI9/r3N9ImpIh/
         i/8R4CBYJuqvAc9NYgoIuBaF1yHQjwctzm9lVgo/8lLYBlRIqBJ0O7BCbtIJTwASvlQS
         CZ8vwt8ymxJOhcCnBiLaWv9+0NAm0orFOEmUR9zI1KVfxmDmI68PaOrx3zBdKscgjb9u
         g7nw==
X-Gm-Message-State: APjAAAXClMxITJZLmjSM0N2H824sneyAh6P0q9Hda5vEUWEAqLPKnFoE
        5/IXAUXHg/sXTGcvmxYIw7BXcrz9eHndemp5oF1nig==
X-Google-Smtp-Source: APXvYqxNP6gWOyjr1acOuCGc/GdMi0xFXjEM4HZgQ5wAy7E8EJDZcEtr9GXcq4irNMIDrGsZSm1SJQndC627Tp7FRAk=
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr12133159pjl.84.1567817039262;
 Fri, 06 Sep 2019 17:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906152800.1662489-1-arnd@arndb.de> <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
 <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com> <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
In-Reply-To: <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 6 Sep 2019 17:43:48 -0700
Message-ID: <CAFd5g47uH-6Bn53Dd8VsFMVn7o26txY2rrUe_XmU3+E4VV_B=A@mail.gmail.com>
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 6, 2019 at 9:08 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/6/19 10:02 AM, Arnd Bergmann wrote:
> > On Fri, Sep 6, 2019 at 5:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> >>>    config KUNIT
> >>>        bool "Enable support for unit tests (KUnit)"
> >>> +     depends on PRINTK
> >>>        help
> >>>          Enables support for kernel unit tests (KUnit), a lightweight unit
> >>>          testing and mocking framework for the Linux kernel. These tests are
> >>>
> >>
> >> Hi Arnd,
> >>
> >> This is found and fixed already. I am just about to apply Berndan's
> >> patch that fixes this dependency. All of this vprintk_emit() stuff
> >> is redone.
> >
> > Ok, perfect. Unfortunately I only started testing the coming
> > linux-next release after Stephen went on his break, so
> > I'm missing some updates.
> >
>
> No worries. I am pushing it now - should be there in 5-10 mins.
>
> Please use linuxk-kselftest next.
>
> Let me know if you see any issues. Thanks for testing it.

Hi Arnd, Shuah accepted my version of the fix earlier today.
Nevertheless, I really appreciate you looking into this. Sorry for
wasting your time.

Please let me know if you run into any additional issues.

Thanks!
