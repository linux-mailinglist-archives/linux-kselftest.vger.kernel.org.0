Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1914C14A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgA1TyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jan 2020 14:54:01 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51630 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgA1TyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jan 2020 14:54:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so1532464pjb.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2020 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/f5zRc++UUEl2oF7a/v6c3iW8+A1FaOUHgeSr1YnVs=;
        b=V3FY0oe6cawkXOzECXYXusqM1m9RESvFiJ318Zd1jyxpfbejY+CSUTAG0yDVae+gh7
         pYc3vMUzJ+h98Raq2Mf3MaJlkPS3Tq1kTEaVxRYxNtvNYvMIFeOQhAHA2IdylHb12t4O
         /Xyz1C6esVXDMnLz/jxMeZ051W5J+xMFr/TVseT7PIJ1Ykuj8JtuXkbEyg471Cv3xiyo
         IBdrZrDnfkkfbBfGnUduk8UZwMsrIx5XW2N13A4UEIBDsoED3fGtcpdZwubSJZPxsIvU
         K2iZbZPxbx7ZMoe/+aDnxn5RQhf9IVAHuYIr3D6N8L7T+IJ1VEFDze2+++I3nOi8MZ31
         WG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/f5zRc++UUEl2oF7a/v6c3iW8+A1FaOUHgeSr1YnVs=;
        b=TfUmMFBJflyU5Ig0zfd/sIf50QuPB0cv4v9wzRb+cVBJoK8tJ2UFdVnnJRjOoaZ4Vm
         gL/21KhnHggCFho5ahX395fRERbmIdGPK4OZHajV0ZpiAdrBsJbTdJ/2Dp1Sz56//wXB
         cp8K71mQlOJ/+Qm6k5SP0q7GXekKH3fL7LLgR1k9ILvxgucxx+ce3TgjVx5Z1iWxRPUI
         PtRAa4pAx1NKCbO0MT+PIbiLP8AjnPLvpJGfnbljaes7RtGwu++xEtiM5r/mkwUt85ON
         SYNhOZB6MrxVdcF341KCoknFHU3R8aptxOAKyy03Auwqdfonvp0H2/81UyH2Q80WuclI
         W3jQ==
X-Gm-Message-State: APjAAAV/s5MBIIVtkMHN9KMsgqEoan8sl84ll9Y/kEmYw5kDdkLXL8CL
        7di2N7irf5sGu87BgfBR1tjvXZTlJrADBvhl801uPw==
X-Google-Smtp-Source: APXvYqwsSX23sWF/7Cv3Xx+gB6ffHVSnTl6Sr/scnY3zT8fQnBaaunzuRNN1mXGoW9KHCLqS7PSV7ksn+8m5qxFFXXI=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr6625852pjn.117.1580241239520;
 Tue, 28 Jan 2020 11:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com> <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 28 Jan 2020 11:53:48 -0800
Message-ID: <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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

On Tue, Jan 28, 2020 at 11:35 AM <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From:  Frank Rowand on January 28, 2020 11:37 AM
> >
> > On 1/28/20 1:19 AM, Brendan Higgins wrote:
> > > On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> ...
> > > we could add Kconfigs to control this, but the compiler nevertheless
> > > complains because it doesn't know what phase KUnit runs in.
> > >
> > > Is there any way to tell the compiler that it is okay for non __init
> > > code to call __init code? I would prefer not to have a duplicate
> > > version of all the KUnit libraries with all the symbols marked __init.
> >
> > I'm not sure.  The build messages have always been useful and valid in
> > my context, so I never thought to consider that possibility.
> >
> > > Thoughts?
>
> I'm not sure there's a restriction on non __init code calling __init
> code.  In init/main.c arch_call_reset_init() is in __init, and it calls
> rest_init which is non __init, without any special handling.
>
> Is the compiler complaint mentioned above related to  calling
> into __init code, or with some other issue?

I distinctly remember having the compiler complain at me when I was
messing around with the device tree unit tests because of KUnit
calling code marked as __init. Maybe it's time to start converting
those to KUnit to force the issue? Frank, does that work for you?
