Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB2BA220
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2019 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfIVLwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Sep 2019 07:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfIVLwv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Sep 2019 07:52:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63E720820;
        Sun, 22 Sep 2019 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569153170;
        bh=OTbFl16kVgDlPYKOn3cAtdccCFyvjZkldfYvpFFrVww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNDtF8O6tygeQUPclcPJbrDC6t6x5c2fPIUJtXzCK3HyqbL8GlQm3wTU6pvV6NOSH
         9nRnVvDZRL6HadphoZPrgn/GEfM9cDoHQD7WDz/6fpogjwWqrLYq1tvLs330wD9ypu
         xLmk2Iyym7wfgDwJdnhe0aneU+YkUKg/owMg2Wuw=
Date:   Sun, 22 Sep 2019 13:52:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190922115247.GA2679387@kroah.com>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922112555.GB122003@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 22, 2019 at 01:25:55PM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Sorry about that. I am surprised that none of the other reviewers
> > > brought this up.
> > 
> > I think I'm "special".
> > 
> > There was some other similar change a few years ago, which I
> > absolutely hated because of how it broke autocomplete for me. Very few
> > other people seemed to react to it.
> 
> FWIW, I am obsessively sensitive to autocomplete and overall source code 
> file hieararchy and nomenclature details as well, so it's not just you.
> 
> Beyond the muscle memory aspect, nonsensical naming and inanely flat file 
> hierarchies annoy kernel developers and makes it harder for newbies to 
> understand the kernel source as well.
> 
> The less clutter, the more organization, the better - and there's very 
> few valid technical reasons to add any new files or directories to the 
> top level directory - we should probably *remove* quite a few.
> 
> For example 'firmware/' was recently moved to drivers/firmware/, and in a 
> similar fashion about a third of the remaining 22 directories should 
> probably be moved too:
> 
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    certs           # move to build/certs/ dir
>   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
>   drwxr-xr-x    Documentation
>   drwxr-xr-x    drivers
>   drwxr-xr-x    fs
>   drwxr-xr-x    include
>   drwxr-xr-x    init
>   drwxr-xr-x    ipc             # move to kernel/ipc/
>   drwxr-xr-x    kernel
>   drwxr-xr-x    lib
>   drwxr-xr-x    LICENSES
>   drwxr-xr-x    mm
>   drwxr-xr-x    net
>   drwxr-xr-x    samples         # move to Documentation/samples/
>   drwxr-xr-x    scripts         # move to build/scripts/
>   drwxr-xr-x    security
>   drwxr-xr-x    sound           # move to drivers/sound/
>   drwxr-xr-x    tools
>   drwxr-xr-x    usr             # move to build/usr/
>   drwxr-xr-x    virt            # move to the already existing drivers/virt/
> 
>   -rw-r--r--    COPYING
>   -rw-r--r--    CREDITS
>   -rw-r--r--    Kbuild
>   -rw-r--r--    Kconfig
>   -rw-r--r--    MAINTAINERS
>   -rw-r--r--    Makefile
>   -rw-r--r--    README
> 
> There's a few borderline ones:
> 
>  - 'block' could in principle move to drivers/block/core/ but it's fine 
>    at the top level too I think.
> 
>  - 'init' could in principle be moved to kernel/init/ - but it's not 
>    wrong at the top level either.
> 
> The remaining top level hierarchy would look pretty sweet and short:
> 
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    build             # new
>   drwxr-xr-x    Documentation
>   drwxr-xr-x    drivers
>   drwxr-xr-x    fs
>   drwxr-xr-x    include
>   drwxr-xr-x    init
>   drwxr-xr-x    kernel
>   drwxr-xr-x    lib
>   drwxr-xr-x    LICENSES
>   drwxr-xr-x    mm
>   drwxr-xr-x    net
>   drwxr-xr-x    security
>   drwxr-xr-x    tools
> 
>   -rw-r--r--    COPYING
>   -rw-r--r--    CREDITS
>   -rw-r--r--    Kbuild
>   -rw-r--r--    Kconfig
>   -rw-r--r--    MAINTAINERS
>   -rw-r--r--    Makefile
>   -rw-r--r--    README
> 
> I'm volunteering to do this (in a scripted, repeatable, reviewable, 
> tweakable and "easy to execute in a quiet moment" fashion), although
> I also expect you to balk at the churn. :-)

I for one would love the above changes.  And I'm the one that has to
deal with all of the backporting issues that arise with stable backports :)

thanks,

greg k-h
