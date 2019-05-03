Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9E1273F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2019 07:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfECFsb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 May 2019 01:48:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36385 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfECFsb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 May 2019 01:48:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id b18so4310945otq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 22:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJk8vxgxnyREeORp3ZGYiUe4W63+mvTYx011g+D2w9I=;
        b=gVy2A/3xGfxoPlL5Ko9/iS3jo2EDVupQVAr70qs6RZrFHNgUtzEok56tjyUqT06FB0
         N61EUVCJQSGnIGYHynH3drr29YDViWxqPU9Sza34pLTsoxVh0uUM8E5CV1L0C/mIM9w0
         WGa5tKq18lnS81IMo5BcR1Ykh3Nl7b9ExnnVx27s6jE5lyDFV5nm2p2xr1/VPFBW2Ah2
         kgZSCZQGbf96we5F6/cwHf89KEU3jBrsGd1WH/gd1lUYccvZTH42q4V6uaQ3GXtHhroy
         5qgEL+EjcYwXRo906ivSwsvihl3a7m9bzISXOlTNYJMfYhl7JWVTEbNxfJuRwSUQRKBU
         kRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJk8vxgxnyREeORp3ZGYiUe4W63+mvTYx011g+D2w9I=;
        b=NQmcY/RXmEO7hIxJQPQWVCGBWKubPsFqjfRsRB+ysIS3fLE7y4VFCD4Zrhc8nPMPrt
         5RjgZM56k0uyeQZBHLcQlJv/aTJwTNBRh4AnlcG3VIbYank4iZ5xuGzxCItBa5+BmHd+
         t+SnyRHmgG+1/UdSpDetKGMCX6eW/L3I3BwX9myYruwXeSL8bApcootijPlEvIRBPHvq
         2p1LH2GYk3RkQHbCghDsoJ7cFMLT1Wwakz0URNb3p8DB4zSrne/+YbMH2QgR4ZKpKNqJ
         J7VIEpiGJ8nZfhe3xHS+MZttI5Kmna72x4wXo1QrZ5ARAwRFkFcf89zBWk3sHDqiSAnd
         yXGw==
X-Gm-Message-State: APjAAAUpE3wlQgiimZ/p01NzIpyKjkihHg3QsQpS7xyHHkuBmz35K/uu
        ZwcRGabDR0GAOo4AL2NkIj1Ny28tYoqk8I7H6AJPKw==
X-Google-Smtp-Source: APXvYqwsEAlSz/eNFlgajgo4Kt8DHISJN+MfNVQqCm9syohvOOWU5/fOAXzlAO0OoVTlNR0j/l6/cH2CfoUTavBQdJA=
X-Received: by 2002:a9d:3621:: with SMTP id w30mr5187084otb.98.1556862507760;
 Thu, 02 May 2019 22:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com> <ead23600-eecd-cf74-bdd1-94a6964e29b2@kernel.org>
In-Reply-To: <ead23600-eecd-cf74-bdd1-94a6964e29b2@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 22:48:16 -0700
Message-ID: <CAFd5g463PQGn3618Vo2Spu81zzL40jM6Skr1gSWtJqMx7Faj5A@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like logger
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 2, 2019 at 6:50 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:

< snip >

> > diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> > new file mode 100644
> > index 0000000000000..93c14eec03844
> > --- /dev/null
> > +++ b/kunit/kunit-stream.c
> > @@ -0,0 +1,149 @@

< snip >

> > +static int kunit_stream_init(struct kunit_resource *res, void *context)
> > +{
> > +     struct kunit *test = context;
> > +     struct kunit_stream *stream;
> > +
> > +     stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +     if (!stream)
> > +             return -ENOMEM;
> > +     res->allocation = stream;
> > +     stream->test = test;
> > +     spin_lock_init(&stream->lock);
> > +     stream->internal_stream = new_string_stream();
> > +
> > +     if (!stream->internal_stream)
> > +             return -ENOMEM;
>
> What happens to stream? Don't you want to free that?

Good catch. Will fix in next revision.

< snip >

Cheers
