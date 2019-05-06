Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46E6155BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 23:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEFVnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 17:43:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36117 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFVnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 17:43:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so10796615oia.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94ZZFjAz8L6vodxrYz5ZCQ36NJZDWbAB/OOZ4duFwS4=;
        b=tLixckVpvUKIIP5RUjay0lZW7YNSS3dUAp/uUYFinYYsKHGVICkPCkOYGtF3sbBoWy
         WrEckQ4QP028zfHhbL5kBL+ohEGOP1dDKk+Bp5+VWfMsnb090NYGYzTdl/D4Y4BZg795
         E2qTT59iEGKQL66/nZu7o3rbn+PokHJnlfYdNIP/E2c/XuQzdE7pg9j0bvYzbCuwwxJL
         emPADFPM3ZOiA8e/GRITu0dcg4Os+e17Y3+CUGf4fPlweNagjJdF4OInhRnPReNkri5n
         LWQH1BOxdyyoBD4Yg62n/XVFQ/+F+SIAiTFtipiJC/QAUrtnzp2bJR8vq6aT+hCDGigV
         3HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94ZZFjAz8L6vodxrYz5ZCQ36NJZDWbAB/OOZ4duFwS4=;
        b=YkLm+5LnnORVZPUOjGBXywmhg5MEZR1Qv9i0H1v1fIrDaKNUg/AdO84lK56Msy8R6B
         qWrAUzaBJmzgT6u0y2hpXsT19rNQV4Fh3VD3egQVKrPG4bPaRq25Z9EGApZRYRZSL8qT
         AtEnrsDza68UfQICCkQoYlS8N5PC4xGnMtmatJFR8DSdkAGs9wyFbmot1mTRRC5peyWW
         Cue4SAFf3D9gKgQ7dcJuoIwlK7XItXlQu6dfb6fsANJIJX25iDZfdNIn6/Nk0Ey08fgI
         Lj+bEstSS8Nqf0lff1+y11R2LAVbZmE++N3mA95oiKqlL631bfrvxJg8F2qaViO9QdTq
         qgCQ==
X-Gm-Message-State: APjAAAXf5k1XN7q2s+cxFL8OOWmVW6ZUAjv1UDS9AfFKRHqFcb7K2acB
        Zwza0ErUUyzM9/HB9QQr7BPIcmvkwYaDDfVGvnMXWA==
X-Google-Smtp-Source: APXvYqyhYHswKnB+01odEGOhapU2d1ybkbO7OVGv0qMcxCiM57xMXMGlQ7Mu0aMV2CefJNmt9LchrL7CnYaGHRcRbVk=
X-Received: by 2002:aca:d4cf:: with SMTP id l198mr192007oig.137.1557178984528;
 Mon, 06 May 2019 14:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com> <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com> <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com> <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com> <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
 <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com> <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
In-Reply-To: <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 6 May 2019 14:42:53 -0700
Message-ID: <CAFd5g47d-e31NecDEbMud0rUH55EbhcS0wJpjB1PZZaX5Udqmw@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Kees Cook <keescook@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, May 5, 2019 at 5:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > You can see the full version 14 document in the submitter's repo:
> >
> >   $ git clone https://github.com/isaacs/testanything.github.io.git
> >   $ cd testanything.github.io
> >   $ git checkout tap14
> >   $ ls tap-version-14-specification.md
> >
> > My understanding is the the version 14 specification is not trying to
> > add new features, but instead capture what is already implemented in
> > the wild.
>
> Oh! I didn't know about the work on TAP 14. I'll go read through this.
>
> > > ## Here is what I propose for this patchset:
> > >
> > >  - Print out test number range at the beginning of each test suite.
> > >  - Print out log lines as soon as they happen as diagnostics.
> > >  - Print out the lines that state whether a test passes or fails as a
> > > ok/not ok line.
> > >
> > > This would be technically conforming with TAP13 and is consistent with
> > > what some kselftests have done.
>
> This is what I fixed kselftest to actually do (it wasn't doing correct
> TAP13), and Shuah is testing the series now:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=ksft-tap-refactor

Oh, cool! I guess this is an okay approach then.

Thanks!
