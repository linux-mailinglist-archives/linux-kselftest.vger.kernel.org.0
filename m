Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA25351CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 May 2022 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbiEZQEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 May 2022 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiEZQEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 May 2022 12:04:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853952E49;
        Thu, 26 May 2022 09:04:49 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hh4so2031613qtb.10;
        Thu, 26 May 2022 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fUDgPUJjoEyPa2k3rr2TdMtBiTmn1nIDnXpkDtFd7k=;
        b=J3kOhJ9pp7Wd/7HJaDzaI8c+RK2ZfmL1Fdlxpdz0jbZclGxGUmhGOlI7vReAapX+zy
         XPNqPhJ7gnBMo77bXOEQRr0POxCwDRdbPFuedattIzMurb8zAh0wCeBWJcZd0cX92P0l
         QKsJma4lCoV/4PGAzVOGKGSRES/iChnTJbsQZHUGm8NPwqnu2uG27FVwNUlQPKZM9TyK
         ZFeMP1FnGqNlxtfwANFYf290S5zPEjHghvLx+Y73ULmhlu3Zf04VDzHQgykSI2ZNXxZN
         JDMA333GJA8w2RBUgSBdM25DAhjIlaXFLJQXZpsUrUWQxxQfsEkmd7/gbTOoulbHsekd
         4XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fUDgPUJjoEyPa2k3rr2TdMtBiTmn1nIDnXpkDtFd7k=;
        b=uMZoC5g9fU9ld5dLN8phkYLs8tODyRp2mamvaHJ9s6escEppGgDd4eCxlMOGyPuR0d
         7LT+Z8BkKg2lp+BY1uPSgAi+9TCZsQUBHvertL3vdTE+TiD7j6X3lP+NB0yAj1hYLwbq
         6YvcHagCgkykPF2MD8p4TNnZgVqkOBNMOWuLEkNFWCRr3fq9Uqf+vU001N8QFWjyk39R
         OQYRyFq1L7nlsDn1nCeuJLNvvvEjHmQXS7sF4BUV2jpS3BJzohFeCdygpceok5snLBsZ
         YxaAIzMS/qpMWFB4jyW1xhKiSOKNYsNm8ErqFTEuqm7o8DogC5lwStd42XsHSvhWwcxd
         krOg==
X-Gm-Message-State: AOAM533FgT2YoCzEB+dfWD7BNdyACCR8bHS4/Pjj55QVxMDTTbTu8Tk7
        wxXb2ocA5R0RmtLuIHYNbVhbXLhHefDdHA5a
X-Google-Smtp-Source: ABdhPJyn43gA2NZBVmM/aZwaLmLM0L3zKJfWx5ctF3hev++cu9Ud5E6giZSMrNJLP5QO3cb+r85oCA==
X-Received: by 2002:a0c:f291:0:b0:462:5e34:70c with SMTP id k17-20020a0cf291000000b004625e34070cmr10525404qvl.58.1653581088390;
        Thu, 26 May 2022 09:04:48 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id m184-20020a37bcc1000000b006a323e60e29sm1359254qkf.135.2022.05.26.09.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:04:47 -0700 (PDT)
Date:   Thu, 26 May 2022 12:04:45 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Message-ID: <Yo+lHSmeIsx144cv@shaak>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
 <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Randy,

On Thu, May 26, 2022 at 08:36:34AM -0700, Randy Dunlap wrote:
> Liam:
> 
> Any comment on this?
> Otherwise I'll just send a formal patch like this (below).

Apologies for not answering earlier.

I wanted to look more into Masahiro's comment and try to fix the
Makefile, but that can be done after.

IMO your patch improves the current Kconfig, so I'd recommend sending
the patch. If it can wait a bit, I can look at the Makefile over the
weekend.

Cheers,
Liam

> 
> Thanks.
> 
> On 5/20/22 20:51, Randy Dunlap wrote:
> > Ok, one more.
> > [also adding Liam here]
> > 
> > On 5/20/22 20:17, Randy Dunlap wrote:
> >>
> >>
> >> On 5/20/22 20:08, Randy Dunlap wrote:
> >>>
> >>>
> >>> On 5/20/22 19:40, Randy Dunlap wrote:
> >>>> Hi,
> >>>>
> >>>> In March I reported that a randconfig build complained:
> >>>>
> >>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
> >>>>
> >>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
> >>>>
> >>>> I am still seeing this problem so I tried to dig into it a bit.
> >>>> However, I don't see why get_next_modinfo() and friends don't find the
> >>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
> >>>>
> >>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
> >>>> and with 2 different versions of GCC.)
> >>>>
> >>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
> >>>> strings?
> >>>>
> >>>> It looks like it is, because it appears (?) that modpost is looking at
> >>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
> >>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
> >>>> loadable module).
> >>>>
> >>>> Is this confusing modpost?
> >>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
> >>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
> >>>
> >>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
> >>> build errors, so that's not a solution, just some info...
> >>
> >> and that was due to not updating drivers/iio/test/Makefile.
> >> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
> >>
> >>>
> >>>> Is this a modpost error or is kunit messing things up?
> >>>>
> >>>> thanks for looking.
> > 
> > Does this look OK? It allows afe/iio-rescale.o to build XOR
> > test/iio-rescale.o (not both of them).
> > 
> > --- a/drivers/iio/test/Kconfig
> > +++ b/drivers/iio/test/Kconfig
> > @@ -6,7 +6,7 @@
> >  # Keep in alphabetical order
> >  config IIO_RESCALE_KUNIT_TEST
> >         bool "Test IIO rescale conversion functions"
> > -       depends on KUNIT=y && !IIO_RESCALE
> > +       depends on KUNIT=y && IIO_RESCALE=n
> >         default KUNIT_ALL_TESTS
> >         help
> >           If you want to run tests on the iio-rescale code say Y here.
> > 
> > 
> 
> -- 
> ~Randy
