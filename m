Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913AA30667
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2019 03:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaBx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 May 2019 21:53:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:61024 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaBx0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 May 2019 21:53:26 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4V1rFht027501;
        Fri, 31 May 2019 10:53:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4V1rFht027501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559267596;
        bh=TAzkKjb1cjaG+PO9FYxGDKp6thyn/WoyJmFRnxsn0OQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gfn9wNThkeDALL6Uadl3scOG23a/N88Uq29JxPz2V5EpXytDVxLgRDh6hNSAyfVPq
         H+7W/Ez9iNs33z+GB21LTkejlIU1nOjKvhjN45OE4wCid/xyTz5GztBZFV2i0SQDZh
         qfxrshfDY2nX/gHR96bAkLJ1CmQqZf0OpUrv6au8IekBOEydqJNBT/PppclPacr4Jc
         sul951KiSEf5y6auNnJUTYj9ZQ3RqZs3t3cBIAxFPqH0KUrjDfHUcMKGLfJDqvEVPv
         YvpnOBMo53SfvE8Zgv4gRP0YJJsECL2XBl6NXWL8dYalRZ3pTnu0Phyi/m9OMFiisa
         c+A8Puf0Oz+Dg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id o5so5723420vsq.4;
        Thu, 30 May 2019 18:53:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVFE0HiTjhUCh4Qp2p+wkEdpk9QXbXoECRGTJGqa2YXET9nM5oQ
        9QxQz2Hbdm6JXPolbxWNoTrcTptlL8Q7rvToJU0=
X-Google-Smtp-Source: APXvYqzsbqLeraYDuQ5bjv2mx0vo+QNIfIpCxrZUJ+R9qbLwh8TQktjO/S62G2xb4GAqtHJ2oARMekmN06QPF77QT/M=
X-Received: by 2002:a67:b109:: with SMTP id w9mr3583253vsl.155.1559267594440;
 Thu, 30 May 2019 18:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190520151614.19188-1-dan.rue@linaro.org> <20190520175641.GA14339@kroah.com>
 <20190530190041.m6535ihflbgr2q3m@xps.therub.org>
In-Reply-To: <20190530190041.m6535ihflbgr2q3m@xps.therub.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 May 2019 10:52:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3kPXj4xHs6s3jACqYSdFLkUWFH30pLWtKUNF2G2wiLg@mail.gmail.com>
Message-ID: <CAK7LNAR3kPXj4xHs6s3jACqYSdFLkUWFH30pLWtKUNF2G2wiLg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: teach kselftest-merge to find nested config files
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 31, 2019 at 4:00 AM Dan Rue <dan.rue@linaro.org> wrote:
>
> On Mon, May 20, 2019 at 07:56:41PM +0200, Greg KH wrote:
> > On Mon, May 20, 2019 at 10:16:14AM -0500, Dan Rue wrote:
> > > Current implementation of kselftest-merge only finds config files that
> > > are one level deep using `$(srctree)/tools/testing/selftests/*/config`.
> > >
> > > Often, config files are added in nested directories, and do not get
> > > picked up by kselftest-merge.
> > >
> > > Use `find` to catch all config files under
> > > `$(srctree)/tools/testing/selftests` instead.
> > >
> > > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > > ---
> > >  Makefile | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > To be more specific here, the binderfs test is not catching the config
> > entry, so it would be nice to get this into the stable trees as well :)
> >
> > > diff --git a/Makefile b/Makefile
> > > index a45f84a7e811..e99e7f9484af 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1228,9 +1228,8 @@ kselftest-clean:
> > >  PHONY += kselftest-merge
> > >  kselftest-merge:
> > >     $(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
> > > -   $(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
> > > -           -m $(objtree)/.config \
> > > -           $(srctree)/tools/testing/selftests/*/config
> > > +   $(Q)find $(srctree)/tools/testing/selftests -name config | \
> > > +           xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
> > >     +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> > >
> > >  # ---------------------------------------------------------------------------
> >
> > is find run with $(Q)?  It isn't with other instances in the Makefile.
>
> I'm not entirely sure all the ways that $(Q) is used (it looks like it
> just gets set to @), but if i run 'KBUILD_VERBOSE=1 make
> kselftest-merge' I do see the find command printed before running:
>
>     find ./tools/testing/selftests -name config | \
>           xargs ./scripts/kconfig/merge_config.sh -m ./.config
>
> I noticed find used inconsistently (sometimes with @, sometimes with
> $(Q), sometimes with neither), so I picked the usage that seemed most
> correct to me.


I agree. Using $(Q) looks correct to me.



> Dan
>
> >
> > thanks,
> >
> > greg k-h
>
> --
> Linaro - Kernel Validation



-- 
Best Regards
Masahiro Yamada
