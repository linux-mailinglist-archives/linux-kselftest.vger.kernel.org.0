Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB65A14D25E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2020 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgA2VTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 16:19:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42722 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2VTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 16:19:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so293772pfz.9
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2020 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hDQAX34j2Scqm0cOO1CyUImmUew2WxU5247BGER7dY=;
        b=UxSawPEjuU8FcEVTFXeV+8fPyjejUz2O2GIiBAdoDAVFy9BgrpyDdwrWW/Qw/2J7ya
         FZ3Hx7C3W8oBpKsfbmp0gcB6UuG6HCj996xrlRomauFSWUUkw1WSDiYPt+gyeAvsDM8J
         KOcA9yUDtsyGqXt3j9CoaEHIZjsv5vX9WRJS+1BFVxd2ZZsKZ61Y5xn2O9TyueeSevNe
         3HynVm+hSZdJHxWhsiP6dcIrpF1AqWQTN1wm7n/YeICb9e29ywqkZW8GbIbfpGFKmKzZ
         fBgtZeeHipIaN5zsaA1KEPpdP38j6n64hmv3cpQViCU8n8pwKNaxkHJeeBc4f/NHQRvk
         NZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hDQAX34j2Scqm0cOO1CyUImmUew2WxU5247BGER7dY=;
        b=FneUdsVzXiDAudkRDGZAJf6JsKNxZcUvOQ9CBXumiq0EckrXTKczaAlyX/XPhhRcZL
         INtVwk8ZoxlV9FEqsVQTFW6p1juoJ7jiiRtRuuVBE/aN8+ZRizt7Q8e7dKJsJYmdm+yv
         iilCxV2BXk7DxwEoJ6ckH/OOMfZ6ybGLTXfi6pVpYSOMDF4ULaUdx/3f/2oM0qxJla2+
         hyJ/QXjFjEp9Uo7WHEGOvqvMfMRYAuN5JKYd/vIzgKvKVooL/Sh4BTYO3FxbPfz1roIh
         0qQXYEuVB9FNlirHfb0wnBewhupfs73o6YQ5lGk8O5kzo04RROCT0dZqQDj6A+1v5kZc
         ra3Q==
X-Gm-Message-State: APjAAAX/esseIUdwyXu6h2c75jFWSC/S1p0WazKmfz+ch0IhC8T+qeRL
        4m0DUMNf5pErzAKcqeweVBUl9q0v153v4QGWBzoGZQ==
X-Google-Smtp-Source: APXvYqz8Ek9aAZM7bbtF2TInvqPq0TxdAQovVbgPfNg0x3Ic53N8b+s11tC5qEwNcBJ6IzRzAQElzR1+afYbaPQH8+4=
X-Received: by 2002:a63:597:: with SMTP id 145mr1045907pgf.384.1580332747259;
 Wed, 29 Jan 2020 13:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com> <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
 <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com> <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
In-Reply-To: <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Jan 2020 13:18:55 -0800
Message-ID: <CAFd5g45g7B0HFpcxd-fjpj4h4gaxijSQ+LZb1=6v3t_u_=192w@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     "Bird, Timothy" <Tim.Bird@sony.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 28, 2020 at 8:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/28/20 1:53 PM, Brendan Higgins wrote:
> > On Tue, Jan 28, 2020 at 11:35 AM <Tim.Bird@sony.com> wrote:
> >>
> >>> -----Original Message-----
> >>> From:  Frank Rowand on January 28, 2020 11:37 AM
> >>>
> >>> On 1/28/20 1:19 AM, Brendan Higgins wrote:
> >>>> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >> ...
> >>>> we could add Kconfigs to control this, but the compiler nevertheless
> >>>> complains because it doesn't know what phase KUnit runs in.
> >>>>
> >>>> Is there any way to tell the compiler that it is okay for non __init
> >>>> code to call __init code? I would prefer not to have a duplicate
> >>>> version of all the KUnit libraries with all the symbols marked __init.
> >>>
> >>> I'm not sure.  The build messages have always been useful and valid in
> >>> my context, so I never thought to consider that possibility.
> >>>
> >>>> Thoughts?
> >>
> >> I'm not sure there's a restriction on non __init code calling __init
> >> code.  In init/main.c arch_call_reset_init() is in __init, and it calls
> >> rest_init which is non __init, without any special handling.
> >>
> >> Is the compiler complaint mentioned above related to  calling
> >> into __init code, or with some other issue?
> >
> > I distinctly remember having the compiler complain at me when I was
> > messing around with the device tree unit tests because of KUnit
> > calling code marked as __init. Maybe it's time to start converting
> > those to KUnit to force the issue? Frank, does that work for you?
>
> I have agreed to try converting the devicetree unittest to KUnit.
>
> Now that KUnit is in 5.5, I think there is a solid foundation for
> me to proceed.

Awesome! Last time we talked (offline), it sounded like you had a
clear idea of what you wanted to do; nevertheless, feel free to reuse
anything from my attempt at it, if you find anything useful, or
otherwise rope me in if you have any questions, comments, or
complaints.
