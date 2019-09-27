Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA8C06B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfI0Nwt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 09:52:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60697 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0Nwt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 09:52:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A9E9C804EA; Fri, 27 Sep 2019 15:52:31 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:52:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
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
Message-ID: <20190927135236.GA3557@bug>
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
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

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

Heh, I was always surprised that sound/ made it into top level... and no, I'd not
mind it being moved away.

> There's a few borderline ones:
> 
>  - 'block' could in principle move to drivers/block/core/ but it's fine 
>    at the top level too I think.
> 
>  - 'init' could in principle be moved to kernel/init/ - but it's not 
>    wrong at the top level either.

net would also make sense as drivers/net/core... That is what inspired sound/ afaict.

> I'm volunteering to do this (in a scripted, repeatable, reviewable, 
> tweakable and "easy to execute in a quiet moment" fashion), although
> I also expect you to balk at the churn. :-)

I'd like to see that happen...

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
