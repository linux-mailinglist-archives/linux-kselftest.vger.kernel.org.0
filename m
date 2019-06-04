Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BAF35468
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2019 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFDXfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 19:35:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41672 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFDXfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 19:35:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so6174946lfa.8
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2019 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUmGpFNz6fygF8JqTGIH7xCmXTGijTn5zshzVeIRyeU=;
        b=n7729tdVd3jiiQzxyuAeBqRs5Gxta2lFj3c+5zHccv1uoJt2AmyWyIDUmg3JxWlagm
         M7C85QUZ1yXvYp4uRNAObTU5YeMqh3a1wo5N9AJPUoMbdbPZFo/1bO/N1rShEEWiWI/v
         Q5BI60V/NuZ52yrsR6VbaGcuc0c695fmqthfBEC0S0U3y4gF1Q08eneEUDigrRf9hMyB
         iQhbHsK661Yo5QjuEON5MQg+g2Pkp/H8jIb/fz9zGMrFKEuNEFNEvKupY/jJ8Vu91CzS
         9bZX4E1E7GESuDjTm/u2NlMe8YNUYbmht0QRBeMkkioK7eHniavWPW592kDJkctLp/+R
         YphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUmGpFNz6fygF8JqTGIH7xCmXTGijTn5zshzVeIRyeU=;
        b=FTli7kWumt3EAkw4Wi5C9LWV3HywY7p8Kv5/b7jl/PG00CNr7kGJHBq9GcNACZ4h/Q
         j7PvW12e85PMK6EZCZEHk/jBm3CAda+3G/MOkJjAb7HnH3sRaOaOrWqAjbQgVMAGMt56
         q19jK/unkiT4D/nsb8Vfcg1O5tVlf+nAHa09U7fVgy59PpjoqRuJgVsRuLzCO4J8ReBF
         UlwIGUwDHPAY6lVqkA7Uak9PZiZC41+B4dCZkXYjIJpOGdBSsdD5gNTsDwSvsWfmHoNO
         NYvgNX948YPOhUjGham1Pz7psiZtvxh7IWgcWpaG3qxKzdN5zvqNiDV4hxEr7OdfeTWC
         DPGw==
X-Gm-Message-State: APjAAAVxx7sQSpznFnW3Jgnq2xLXYIv+UOBDdcm4XKjepE2z76msiNI9
        dHpaVCmQkrUuLSA3b7oJU/oOpiShgidGOkju928vKw==
X-Google-Smtp-Source: APXvYqxFVfsY2uUyOvHDHQWsWPz6JVCPCIp44WWY+H6aJDJ/TaoNNgHz4dGto/MoXWH1ptk3ODVootrUgExaXb/yDLQ=
X-Received: by 2002:a19:7110:: with SMTP id m16mr18059760lfc.4.1559691310771;
 Tue, 04 Jun 2019 16:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-3-brendanhiggins@google.com> <20190517003847.0962F2082E@mail.kernel.org>
In-Reply-To: <20190517003847.0962F2082E@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Jun 2019 16:34:58 -0700
Message-ID: <CAFd5g45taSVNXSQJrXnHLG_Rtum650vFw1zccqv1Tyru5A5d8w@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] kunit: test: add test resource management API
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
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
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 16, 2019 at 5:38 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:16:55)
> > diff --git a/kunit/test.c b/kunit/test.c
> > index 86f65ba2bcf92..a15e6f8c41582 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> [..]
> > +
> > +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +{
> > +       struct kunit_kmalloc_params params;
> > +       struct kunit_resource *res;
> > +
> > +       params.size = size;
> > +       params.gfp = gfp;
> > +
> > +       res = kunit_alloc_resource(test,
> > +                                  kunit_kmalloc_init,
> > +                                  kunit_kmalloc_free,
> > +                                  &params);
> > +
> > +       if (res)
> > +               return res->allocation;
> > +       else
> > +               return NULL;
>
> Can be written as
>
>         if (res)
>                 return ....
>         return
>
> and some static analysis tools prefer this.

Sounds reasonable, will fix in next revision.

> > +}
> > +
> > +void kunit_cleanup(struct kunit *test)
> > +{
> > +       struct kunit_resource *resource, *resource_safe;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
>
> Ah ok, test->lock is protecting everything now? Does it need to be a
> spinlock, or can it be a mutex?

No it needs to be a spin lock. There are some conceivable
circumstances where the test object can be accessed by code in which
it isn't safe to sleep.

> > +       list_for_each_entry_safe(resource,
> > +                                resource_safe,
> > +                                &test->resources,
> > +                                node) {
> > +               kunit_free_resource(test, resource);
> > +       }
> > +       spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
