Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFF644F89
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 00:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLFXYL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLFXYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 18:24:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD41CB08
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 15:24:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c7so12598146pfc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 15:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovJCxHQc8+rS89BUXUtqUrFqrY//aBiCOIFL+tZQbfw=;
        b=HVrEOzqv7iDT/JOxfMs/WBt+oKr/cbFXvM++HKNyT6dOPN3cugGpkJ3yQyWQnmZ4ag
         4Kbdw/HvCA0qjI13q9bOhLnNtrZKFx0haHQ6tnR+eDSVRdh0sPSLVD3teiZYQEHyERMT
         A/r7biG5o6krK9DJyeHPh4P2YS8Mc6eBMytkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovJCxHQc8+rS89BUXUtqUrFqrY//aBiCOIFL+tZQbfw=;
        b=8Ich9qRVmU3O4sv6hWoZeV9C5cXivvCqAUOWIN8+q1ITHXMwyWVV7bKq31MkWDDDh4
         g4MFWrmLpUt+tuWyXYoFuGEp4i6V0yOR8oblvyRuB+7MdSMlHQdkZf+cjnZiJ0Ry4Cai
         2Uk9t4jCcTDi2eyBcKt8cmMg07HCivZvf/Tj0SxFA50MNZE7QjxLF15Lo04KChbzt/hu
         D89QkXlDDvWzRxgxakUEeQ2EXTucCPWF7oKw304EcoK50vSRzcDvzN89ofkSQbDRH+DK
         FbMNi9CtgMAxLrjYO83I8jwK4hH8dNtzoJYlPiSZElGJVt/P0xsL+v+Yo0kwE2262DIV
         yBuQ==
X-Gm-Message-State: ANoB5pkgrekjtCeN7kjZA4K7F4KTf55UbpCbz8ms9ni2FWhtzPKVdusr
        Mx31XQCV8o2mHErmq/unxndWFA==
X-Google-Smtp-Source: AA0mqf6Is1y/2rFNhFTvRk7tj3Kc77p/2qwRcRoY9gMN/fuB3B9m27qlvCroh6NLXyJ3BULuoBcP6g==
X-Received: by 2002:aa7:938b:0:b0:576:9b24:ca60 with SMTP id t11-20020aa7938b000000b005769b24ca60mr17599406pfe.7.1670369049127;
        Tue, 06 Dec 2022 15:24:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b00189929219acsm13212238plh.183.2022.12.06.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:24:08 -0800 (PST)
Date:   Tue, 6 Dec 2022 15:24:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jeffxu@chromium.org,
        skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212061521.2BD762D@keescook>
References: <20221206152358.1966099-1-jeffxu@google.com>
 <20221206152358.1966099-4-jeffxu@google.com>
 <Y49oIR6/ULTqlcwL@kroah.com>
 <CALmYWFvaEg84DYtjQtoQqsvaboX7mRS5dOqz8OJ0EYJTOCp4kg@mail.gmail.com>
 <Y49vUQKRVyquazJ2@kroah.com>
 <CALmYWFvO8kKGusv8_Jwevw5pS4LwbF9G12=RthWZeHYE++ZO3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFvO8kKGusv8_Jwevw5pS4LwbF9G12=RthWZeHYE++ZO3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 06, 2022 at 09:48:55AM -0800, Jeff Xu wrote:
> On Tue, Dec 6, 2022 at 8:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 06, 2022 at 08:26:30AM -0800, Jeff Xu wrote:
> > > On Tue, Dec 6, 2022 at 8:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Dec 06, 2022 at 03:23:55PM +0000, jeffxu@chromium.org wrote:
> > > > > --- a/kernel/pid_namespace.c
> > > > > +++ b/kernel/pid_namespace.c
> > > > > @@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> > > > >       ns->ucounts = ucounts;
> > > > >       ns->pid_allocated = PIDNS_ADDING;
> > > > >
> > > > > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > > > > +     ns->memfd_noexec_scope =
> > > > > +             task_active_pid_ns(current)->memfd_noexec_scope;
> > > > > +#endif
> > > >
> > > > .c files should never have #if in them.  Can't you put this in a .h file
> > > > properly so that this does not get really messy over time?
> > > >
> > > >
> > > Thanks for reviewing.
> > > It seems to me that checking for CONFIG_XXX is  common in c code in
> > > kernel/ path.
> >
> > Maybe, but please don't make it any worse if at all possible.  It's
> > tough to maintain code like that.
> >
> > > Do you have a sample code pattern (link/function) that I can follow?
> >
> > Any of the zillions of #if statements in .h files :)
> >
> Thanks.
> I will take the approach of having real/stub implementation in the h
> file, and the c file  using it without a compile flag.
> Please kindly let me know if this is not right.

Right; for example:

in .h:

#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
static inline void ns_copy_memfd_scope(... dst, ... src) {
	dst->memfd_noexec_scope = src->memfd_noexec_scope;
}
#else
static inline void ns_set_memfd_scope(... ns, ... scope) { }
#endif


in .c:

	ns_copy_memfd_scope(ns, task_active_pid_ns(current));


-- 
Kees Cook
