Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD72E8F48
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jan 2021 02:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbhADBwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Jan 2021 20:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbhADBwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Jan 2021 20:52:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E2C061574;
        Sun,  3 Jan 2021 17:51:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l23so9537520pjg.1;
        Sun, 03 Jan 2021 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1AL0gob55MTxZAza4QeD6DkjcRHthg4y8NwY/c0Om5s=;
        b=m+wOmn+brmVAZuJkULfAwK+1sB8yJEYEbp8KCIxvdv8o6BSmOWQcY/hy4cPMFn465d
         nkuqQ2E1WZMaKyUgbDe3MRuz2ntEbVlCVBb9zi5fCLSn3i50PTGLm5mHrF+acuMlpB7a
         0eIQJO2JTUMmxSEVvE7eRctjb6ujeeJflARMTk8kLfvJnkr/UUPW+vBEQcFEcGzQ2X07
         Pqpc5tUw1lSHAIOsUCwvrpFUmUELyMjRKhZUYNiUnDuYygk793YjAwPyoWsVb3F4boja
         LDXVolVzfnOT/eDQGX70bbfnA3UAWN2975oPxYwxEDUJ2S8CCTOWVhgmuvo41NrKhMyw
         BGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1AL0gob55MTxZAza4QeD6DkjcRHthg4y8NwY/c0Om5s=;
        b=Yy4Ri7HszNws9XoibyS+dnKZnpdr26b8ulaGPFi0Y4IIHlx3HJ9Rg+ja3VstD8rUlN
         kCduafGiz9QhDfUtg2/kb0YVE8d9wbdNeoF7m6Kfi5qtfMR4tHvY0Cx4P/UDOr/nAaIW
         1YBQc3Ebz6lI7Cpfftv/ELz4+oyCTiLPEKgGe71o5HD6A1e6MnRfOTNyBiMOPsUVOq24
         2yYTdrhsnGytNqAklKi3/+vspjcuUK1iy1IhIjMOWEGDQmuLYxuNDNt8YvgqYKvXcmiZ
         4rzR/FHYT9SW0++I7ewefKrltEeCAk/UNufbPt9K2osMdJome58qnkydIh8CcJbNXowu
         7wsg==
X-Gm-Message-State: AOAM532Vy62w00q7SwSVk9qR49hxWREZgyFgAQXyivPEZDzPc4A+8S7A
        xZUrrz7Rn1NIxnMLLiVWn5I=
X-Google-Smtp-Source: ABdhPJyGDYAK8fT2HPn1J5t4u7rkCEixCw5D5wmT3JkEUsURQUO+0oE56aYZZPAbMpftM38J6B8Q3w==
X-Received: by 2002:a17:90a:1bc7:: with SMTP id r7mr28551548pjr.33.1609725096193;
        Sun, 03 Jan 2021 17:51:36 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id y27sm54600750pfr.78.2021.01.03.17.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 17:51:35 -0800 (PST)
Date:   Mon, 4 Jan 2021 09:51:29 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test
 implementation
Message-ID: <20210104015129.GA4939@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
 <20210103021725.GA6622@sol>
 <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 03, 2021 at 05:10:10PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 3, 2021 at 4:17 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Sun, Jan 03, 2021 at 12:20:26AM +0200, Andy Shevchenko wrote:
> > > On Sat, Jan 2, 2021 at 4:32 AM Kent Gibson <warthog618@gmail.com> wrote:
> 
[snip]
> 
> ...
> 
> > > > +       local platform=`cat $SYSFS/kernel/debug/gpio | grep "$chip:" | tr -d ',' | awk '{print $5}'`
> > >
> > > Besides useless use of cat (and tr + awk can be simplified) why are
> >
> > What do you suggest for the tr/awk simplification?
> 
> You have `awk`, you can easily switch the entire pipeline to a little
> awk scriptlet.
> 

Baah, the number that I'm after is in the $SYSFS/kernel/debug/gpio that I
was pulling the platform from, so I can just pull it directly from there.

No need to go hunting through the file system for the base file - the
range of GPIOs assigned to the chip is right there.

In this example it is the 508:

# e.g. gpiochip0: GPIOs 508-511, parent: platform/gpio-mockup.0, gpio-mockup-A:

So I'll use that - unless it is unreliable for some reason?

Cheers,
Kent.

