Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF233BD92
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2019 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfFJUgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jun 2019 16:36:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbfFJUgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jun 2019 16:36:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so5137018pga.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2019 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIiaElKbYG7X2iRY6VXsdeM4+31zgx4vPIFfu4hUJug=;
        b=aypLgRrX0btLwkQ78UmSd30OW9UF0AUZJnAd3r2/5HqpTZB7t9pPjkr79taehwRSBe
         Uf3LjKJsRGeyWW7niEs4BHLmd/27Tp++YcV8xUIXVrHXkWkhfr39ad2bGk73/2ccXpRd
         Krrfs143htc/xGI+Ppm9VimNWGnjKhQyxh//k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIiaElKbYG7X2iRY6VXsdeM4+31zgx4vPIFfu4hUJug=;
        b=cOqYtmM5cPfu9Hjdb+Nib8OwddAXgBnQt5IxwpIcPKEyqKv6rX++nwGwwsa7aHjq3c
         29L0mGHtVrhiuTnYFlDCTiRNEloglk2/id0fvZ5RbFC/mFxR5bV65fbJYpBfwXm9SGAN
         +KaqTV8Q4Nc07PayUlJB38olLobahchQohayRkz6S1u05aTnJSo/W7y3HmcwBnqJoAGl
         cJ9kV4W43UcovpPLLZFgYtl18/AvEYQnePJhj3pXeDqpt0EJLpBFD4HgTyUrJuiB6FgP
         qqAgTvqFl/KAKkTj8/nqbOidnemhILusVFyEyBY3Iv/w1TzkK8qt+mZFWbvtxfD1XNXH
         H3vQ==
X-Gm-Message-State: APjAAAX6UQjSPJovy5p7yVn1XexHD7HgipLP2aJLqTaiHLrP4PUiV6CD
        m3SEYJ5PIygOiwzF1cypWqi/ig==
X-Google-Smtp-Source: APXvYqz36v1zCKX0GRWb534Z9an9udGHI/NESxPlvuGqVOMCrwC97gsWY6mXQoFhLwcNndoWLde2ZA==
X-Received: by 2002:a62:1b85:: with SMTP id b127mr76850297pfb.165.1560198965895;
        Mon, 10 Jun 2019 13:36:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k22sm11148457pfk.178.2019.06.10.13.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 13:36:04 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:36:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <201906101335.DF80D631@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com>
 <201906101106.3CA50745E3@keescook>
 <20190610185329.xhjawzfy4uddrkrj@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610185329.xhjawzfy4uddrkrj@mbp>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 10, 2019 at 07:53:30PM +0100, Catalin Marinas wrote:
> On Mon, Jun 10, 2019 at 11:07:03AM -0700, Kees Cook wrote:
> > On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index 3767fb21a5b8..fd191c5b92aa 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -552,3 +552,18 @@ void arch_setup_new_exec(void)
> > >  
> > >  	ptrauth_thread_init_user(current);
> > >  }
> > > +
> > > +/*
> > > + * Enable the relaxed ABI allowing tagged user addresses into the kernel.
> > > + */
> > > +int untagged_uaddr_set_mode(unsigned long arg)
> > > +{
> > > +	if (is_compat_task())
> > > +		return -ENOTSUPP;
> > > +	if (arg)
> > > +		return -EINVAL;
> > > +
> > > +	set_thread_flag(TIF_UNTAGGED_UADDR);
> > > +
> > > +	return 0;
> > > +}
> > 
> > I think this should be paired with a flag clearing in copy_thread(),
> > yes? (i.e. each binary needs to opt in)
> 
> It indeed needs clearing though not in copy_thread() as that's used on
> clone/fork but rather in flush_thread(), called on the execve() path.

Ah! Yes, thanks.

> And a note to myself: I think PR_UNTAGGED_ADDR (not UADDR) looks better
> in a uapi header, the user doesn't differentiate between uaddr and
> kaddr.

Good point. I would agree. :)

-- 
Kees Cook
