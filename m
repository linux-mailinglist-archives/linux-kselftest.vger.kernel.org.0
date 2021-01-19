Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264DD2FBDFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391416AbhASOuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389090AbhASLV4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 06:21:56 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA305C061574;
        Tue, 19 Jan 2021 03:21:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so756062pfu.9;
        Tue, 19 Jan 2021 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DoSaOw4D6DcnY1MTubltmDQrBAAfXoso7EK/Rs/Vnr4=;
        b=IYwDdvEsV1PpeMjZriTbkWhRCxtHrm6TpkjsmU1IfWXanflkTqXiILDi7mgg4NshdO
         pMEalgbrjxhlhQEulDcbg4fkaWvd147W24rGtz8R465r0YvixvuuMJ7RdBXeL66oa9Wc
         sD/vKrOf2GasPBrdXyN4IgXo+AvLGdL6qmeQd47voaIiPXbTaEuCiebNtX3BHd/w9Nrt
         uoJJc1eWcYYH/H7873S2upqu9gR6hyxhQL5CnIi0GN+q8i/FIWlOROa9plYv5I5mB3Ti
         cnpNcfYpsL00Uv07EI7B+xNWCz3rTr0a5Y3ssPqXWbwrqMLRFaQqJiJ9/su0Tbe+O1iM
         ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DoSaOw4D6DcnY1MTubltmDQrBAAfXoso7EK/Rs/Vnr4=;
        b=XnE+uJVQi/bdFwHTwT3OSg+W17ia0GcDcAbRIkpzscapukQCvMcGHtYRLHklEq2faO
         nEQTipN0k9PfjKoFgAKwJyfX+rV72yk+hzcAw2r3vvVSHJF2bnIHbcLYQvkwB6PCb5G0
         krvW/ysgGtrVvLKD5PlxgdQ9A309szEaPjEdVXaA96fc/K4Y4Q7j5NGAMEWXTWqh2F93
         fyUaB+g//zaWOikOzmDQ1F/hKECWX6ufRe40d+1Snq7K1o3whH4yrTJit7wNYrt7uRw/
         l75xuapkUIGhGNBWIa513N2pNABJ0FI71Apnj0yNyi72OuXhokCBL6/yJPt9bFamZtEx
         P0WA==
X-Gm-Message-State: AOAM531IeUdJWPqb5lK1s/F77kAWXk4nEwaD9lrK/h7kAfFbhAtEJolq
        6cbZm16JCXskXweDS2iKUnw=
X-Google-Smtp-Source: ABdhPJz7AEx0xnRMkogVlqcexbIk3sxRxofJlQJ77jzbddOkoVWl9aE6aCHo3T2rFoDi1UJ7DqQPww==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr3935747pgl.55.1611055275048;
        Tue, 19 Jan 2021 03:21:15 -0800 (PST)
Received: from sol (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id w2sm18788453pfj.110.2021.01.19.03.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 03:21:14 -0800 (PST)
Date:   Tue, 19 Jan 2021 19:21:09 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
Message-ID: <20210119112109.GA23328@sol>
References: <20210107025731.226017-1-warthog618@gmail.com>
 <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
 <20210119003455.GB5169@sol>
 <CAMpxmJUkFL+w7afS2NKF-xiMR==HVR1Mk8uQm3782DBoG0qneA@mail.gmail.com>
 <20210119105933.GA21741@sol>
 <CAMpxmJWMQ2uVJ77MYPr3dhy0=-P8FtAfz3BSoKbxh33J0Gx=Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJWMQ2uVJ77MYPr3dhy0=-P8FtAfz3BSoKbxh33J0Gx=Ug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 12:02:13PM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 19, 2021 at 11:59 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Tue, Jan 19, 2021 at 11:37:46AM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Jan 19, 2021 at 1:35 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 18, 2021 at 04:04:51PM +0100, Linus Walleij wrote:
> > > > > On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > >
> > > > > >   selftests: gpio: rework and simplify test implementation
> > > > > >   selftests: gpio: remove obsolete gpio-mockup-chardev.c
> > > > > >   selftests: remove obsolete build restriction for gpio
> > > > > >   selftests: remove obsolete gpio references from kselftest_deps.sh
> > > > > >   tools: gpio: remove uAPI v1 code no longer used by selftests
> > > > > >   selftests: gpio: port to GPIO uAPI v2
> > > > > >   selftests: gpio: add CONFIG_GPIO_CDEV to config
> > > > >
> > > > > Bartosz I think you can just merge these patches into the GPIO tree, at least
> > > > > I think that is what I have done in the past.
> > > > >
> > > >
> > > > Could you touch up that Fixes tag in patch 1 if you merge v2?
> > > >
> > > > Thanks,
> > > > Kent.
> > >
> > > Kent,
> > >
> > > This doesn't apply to my for-next branch - there's a conflict in
> > > tools/testing/selftests/gpio/Makefile, could you take a look?
> > >
> >
> > Which is your for-next branch?
> >
> > The patch set is based on and applies cleanly to gpio/for-next 7ac554888233,
> > so I'm not sure which branch you are targetting.
> >
> > Cheers,
> > Kent.
> 
> Linus W is not picking up patches this release - everything goes through:
> 
>     git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
> 
> Sorry for the confusion.
> 

Ah, ok Michael Ellerman has been improving the Makefile toworkaround
the build dependency issues for some cases.

My changes supersede all that - a basic Makefile is now sufficient.
I'll send out a v3 shortly.

Cheers,
Kent.
