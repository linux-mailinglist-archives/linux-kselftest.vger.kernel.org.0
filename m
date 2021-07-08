Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA53C19DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHTgW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 15:36:22 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35590 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHTgW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 15:36:22 -0400
Received: by mail-pf1-f169.google.com with SMTP id d12so6493957pfj.2;
        Thu, 08 Jul 2021 12:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1x79IxgHWwXPlhnf35hTvQGJigxp9TB63be2mWFl8c=;
        b=QrFn1JViUFkMbdEARdeyHqs07tODk1uhSyiyp+mUgby1w6fnL2Bbucyrt+ltF3htLr
         yVef2NpiF9VosFECKZ39uNFnrHUawnh8BtYxLuBhIMAerB6Td0olqkhb0btEsNV+JduJ
         vxOpzd+oo7RjeMFu3v3AG0K282mSZcvLHyf8qhg3xc7a+ASpajZA/98lkNDoxLOLYtyH
         t2vpcURoa6M73UaZKCnGEvrzVBgRMZAAeJqKZpOOeVEydT81DW0heopi0wa1om9faMBY
         bgHZliOecxmO5I7H/83I7uAUCH74iqpTGUj7EKjC/5GlXiHVQqXKf7Oap/9ZPd5y2JsQ
         JAiQ==
X-Gm-Message-State: AOAM5325K8hUMQfh6nTA1ES6t3sKlSnn3w5yqtZUqfB3jGdCg2/7TwgD
        FolIOK3pvVYX6iiwdy9kL8A=
X-Google-Smtp-Source: ABdhPJxh7PA9JCdKwIvu5ezCF3wF82rwdLjP5exSZrmWt6CdickS5srFih5x2dIeKAf8p2nDIKmESA==
X-Received: by 2002:aa7:8c4e:0:b029:324:c334:59 with SMTP id e14-20020aa78c4e0000b0290324c3340059mr12500220pfd.56.1625772819282;
        Thu, 08 Jul 2021 12:33:39 -0700 (PDT)
Received: from garbanzo ([191.96.120.45])
        by smtp.gmail.com with ESMTPSA id o34sm4321039pgm.6.2021.07.08.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:33:38 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:33:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, shuah@kernel.org,
        rafael@kernel.org, rgoldwyn@suse.com, kuno@frob.nl,
        fontana@sharpeleven.org, Ciaran.Farrell@suse.com,
        Christopher.DeNicolo@suse.com, hch@lst.de, corbet@lwn.net,
        linux@leemhuis.info, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, tj@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <20210708193334.uyndyk6mxpylv2qn@garbanzo>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOaZohB/2Z3x5grc@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 08, 2021 at 08:22:26AM +0200, Greg KH wrote:
> On Wed, Jul 07, 2021 at 11:43:08AM -0700, Luis Chamberlain wrote:
> > This adds the copyleft-next-0.3.1 SPDX tag and replaces existing
> > boilerplate with the tag.
> > 
> > Luis Chamberlain (2):
> >   LICENSES: Add the copyleft-next-0.3.1 license
> >   testing: use the copyleft-next-0.3.1 SPDX tag
> > 
> >  LICENSES/dual/copyleft-next-0.3.1        | 237 +++++++++++++++++++++++
> >  lib/test_kmod.c                          |  12 +-
> >  lib/test_sysctl.c                        |  12 +-
> >  tools/testing/selftests/kmod/kmod.sh     |  13 +-
> >  tools/testing/selftests/sysctl/sysctl.sh |  12 +-
> 
> As we only have 4 usages of this license in the tree, we have the
> opportunity to actually remove it and keep the list of licenses that we
> use in the kernel source smaller.
> 
> Any chance you wish to just change the license of these files, given
> that you are the only one that has tried to use it for kernel code?

Since it is a "relatively" new license (2012, used in Linux since 2017)
obviously not many people would have used it, but one cannot assume it
is not because one does not want, but rather one is not aware.

I myself have used the license for all new projects, and the agreement
I reached with SUSE was I'd be using this license when I can for my
own projects and contributions. I'm not a zealot though, and I also
take care for proper considerations for such a large project such
as Linux. It is why I had the license vetted by attorneys at SUSE
in 2017, and also drew up a public discussion over its possible use on
Linux. My goal then, in so far as Linux is concerned, is to use it for
selftests as a safe place, which won't grow folks weary or concerned.

And then let things evolve from there.

Of all the items listed on patch #1 for which I prefer using
copyleft-next the most important one for me is an explicit patent
grant. Although GPL applies to Linux I do feel very strongly about
propagation of more projects with such type of licenses and I feel
we should be happy to help such projects grow by allowing cross
polination.

> As a follow-up to this, I do not want to see your "test_sysfs.c" module
> as a dual-licensed file, as that makes no sense whatsoever.

You can ignore the patch then, its a selftest driver, not a core sysfs
change. I believe it should be up to the selftest maintainer?

The changes I am making to sysfs are explicitly under GPLv2, and
has nothing to do with copyleft-next. I am using dual licensing with
copyleft-next only for selftests for now. I have support from SUSE to
use this license.

> It is
> directly testing GPL-v2-only code, so the attempt to dual license it
> makes no sense to me.

So what? I can have BSD licensed code testing GPLv2 code. In fact folks
out there use proprietary licensed code to test GPLv2 code as well. I
don't see your the rationale here.

> How could anyone take that code and do anything
> with it under the copyleft-next license only?  And where would that
> happen?

That's up to the users. In my case I am heavily involved with doing
automation of testing and so *I care* as I am building automation of
testing for all things kernel. My project kdevops, will soon be
relicensed to copyleft-next.

My personal development goal is I will embrace copyleft-next for
anything new I write, and only use GPLv2 or another license when
I am required to do so. I believe I am being reasonable also in using
this only for sefltests for now as discussions and awareness of the
license grows.

> I understand the appeal of copyleft-next in that it resolves many of the
> "grey" areas around gplv2, but given that no one is rushing to advise us
> to relicense all of the kernel with this thing, there is no need to
> encourage the spread of it given the added complexity and confusion that
> adding another license to our mix can only cause.

"Need" is subjective. I feel strongly about a need to have explicit patent
grants propagating in our community. So the more we can do this outside
of Linux and allow code from Linux to be used in such projects the
better.

The license is one of the only few licenses (if not only?) which is
GPLv2 compatible and also has an clear patent grant. I have reasons to
believe, we as a community face serious challenges if we don't grow our
collection of code with explicit patent grants. And so any new project
I create will have such licenses. It is simply my preference, and if I
can contribute code to Linux in a "safe place" to slowly build traction
of it, then fantastic.

> So please, no, I don't want to see new licenses added to the tree, if
> anything we should be trimming them down to be less as it makes things
> simpler and more obvious.

Too late. Dual GPLv2 / copyleft-next code was added in 2017 and I had
a clear community discussion over it.

I take caution and care about this. I do feel this discussion is worth
having and hence my contributions in 2017 and now adding the respective
SPDX license tag.

  Luis
