Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C869D6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2019 23:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfGOVMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 17:12:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38237 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfGOVMD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so8005829pfn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CDzG2nmXC81q5V7RsyjpQsyLHi2FCKjkCzPjAyP/Nk=;
        b=WRG0F23qChjAaAEgVWxfTCyWoETWRuvlXf0OUFLJDpPNc+E2kBPo6Rnc2kO3CcSo8G
         U0ec28X2fqdXQFKacK77IxmmqWYW8YqJUqkgi+P1l8mi6KsZMO7OvwKgi6/xkszbduVQ
         hD/v9MTtep6h8K64P61TxJ9ZG8IgZhIuQrmmmz2ypp8V+U7ePGiNcVJ/X3TQ+VlGj4UD
         qlfFx5qTBL83iRJxgnoJ4zXz0vPxyqaLzf50gf9DQI2eLnJOCh4BAdDg80wO+2d9wdwF
         fLa8cxyJAimCEmw8TlDUBnkv1EHLEb2gwvdV+aaipr2FEQ6Dx/zbHufCUCF7kruKS4w7
         b2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CDzG2nmXC81q5V7RsyjpQsyLHi2FCKjkCzPjAyP/Nk=;
        b=IVECY7KnvG788dqPdIv462qFrH4qmaah2CxsrOKv1f7Nw4fiFKEOcjDMA8b1pTUZW2
         h/lW9NFNNzSMqLgj5laH32LzT31dGEIYOzlNwdAcxMsG+T4K+4rPa8PXBkxxxqkNXbET
         QqnsDQNqrdgkekmQ6h2x+eB3AJgks583V8stslC6dpHTiX5y1YNxxjk1fuZLtGOERiof
         cuAaF4HF8VxPDV+iVk9bmQdye/eMX6tbDab4kkUPoSXhZthxwe7DVTDyMQEOmtsco6MK
         cleykkKapnThmAyCAscbHpc34z4feSIaftgv1SorM8Ejy/RkYjKsi2U2PsnjamTQk0f6
         RnsQ==
X-Gm-Message-State: APjAAAX3Op1uS8zd3R+3mSxIVIrFtvl0TcNrernWwbVDxKfXJu+GAZV+
        bdDs/tIS+Ti+avH0rfrOR2TLlg+l+6mjgliwKXQR1A==
X-Google-Smtp-Source: APXvYqy2GD/ajXWafuN0ZtZDTDo+qnQ+zqnj+QLNdPkc/o2HQFKV7mN3zMJfjMYCcft5I0utJpW+dyc42Dwa4FsbkTA=
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr31423391pjb.117.1563225121828;
 Mon, 15 Jul 2019 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org>
In-Reply-To: <20190715204356.4E3F92145D@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 14:11:50 -0700
Message-ID: <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
Subject: Re: [PATCH v9 03/18] kunit: test: add string_stream a std::stream
 like string builder
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

On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:29)
> > diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
> > new file mode 100644
> > index 0000000000000..0552a05781afe
> > --- /dev/null
> > +++ b/include/kunit/string-stream.h
> > @@ -0,0 +1,49 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * C++ stream style string builder used in KUnit for building messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_STRING_STREAM_H
> > +#define _KUNIT_STRING_STREAM_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/kref.h>
>
> What is this include for? I'd expect to see linux/list.h instead.

Sorry about that. I used to reference count this before I made it a
kunit managed resource.

> > +#include <stdarg.h>
> > +
> > +struct string_stream_fragment {
> > +       struct list_head node;
> > +       char *fragment;
> > +};
> > +
> > +struct string_stream {
> > +       size_t length;
> > +       struct list_head fragments;
> > +       /* length and fragments are protected by this lock */
> > +       spinlock_t lock;
> > +};
> > +
> > diff --git a/kunit/string-stream.c b/kunit/string-stream.c
> > new file mode 100644
> > index 0000000000000..0463a92dad74b
> > --- /dev/null
> > +++ b/kunit/string-stream.c
> > @@ -0,0 +1,147 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C++ stream style string builder used in KUnit for building messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <kunit/string-stream.h>
> > +#include <kunit/test.h>
> > +
> > +int string_stream_vadd(struct string_stream *stream,
> > +                      const char *fmt,
> > +                      va_list args)
> > +{
> > +       struct string_stream_fragment *frag_container;
> > +       int len;
> > +       va_list args_for_counting;
> > +       unsigned long flags;
> > +
> > +       /* Make a copy because `vsnprintf` could change it */
> > +       va_copy(args_for_counting, args);
> > +
> > +       /* Need space for null byte. */
> > +       len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> > +
> > +       va_end(args_for_counting);
> > +
> > +       frag_container = kmalloc(sizeof(*frag_container), GFP_KERNEL);
>
> This is confusing in that it allocates with GFP_KERNEL but then grabs a
> spinlock to add and remove from the fragment list. Is it ever going to
> be called from a place where it can't sleep? If so, the GFP_KERNEL needs
> to be changed. Otherwise, maybe a mutex would work better to protect
> access to the fragment list.

Right, using a mutex here would be fine. Sorry, I meant to filter for
my usage of them after you asked me to remove them in 01, but
evidently I forgot to do so. Sorry, will fix.

> I also wonder if it would be better to just have a big slop buffer of a
> 4K page or something so that we almost never have to allocate anything
> with a string_stream and we can just rely on a reader consuming data
> while writers are writing. That might work out better, but I don't quite
> understand the use case for the string stream.

That makes sense, but might that also waste memory since we will
almost never need that much memory?

> > +       if (!frag_container)
> > +               return -ENOMEM;
> > +
> > +       frag_container->fragment = kmalloc(len, GFP_KERNEL);
> > +       if (!frag_container->fragment) {
> > +               kfree(frag_container);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       len = vsnprintf(frag_container->fragment, len, fmt, args);
> > +       spin_lock_irqsave(&stream->lock, flags);
> > +       stream->length += len;
> > +       list_add_tail(&frag_container->node, &stream->fragments);
> > +       spin_unlock_irqrestore(&stream->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> [...]
> > +
> > +bool string_stream_is_empty(struct string_stream *stream)
> > +{
> > +       bool is_empty;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&stream->lock, flags);
>
> I'm not sure what benefit grabbing the lock is having here. If the list
> isn't empty after this is called then the race isn't resolved by
> grabbing and releasing the lock. The function is returning stale data in
> that case.

Good point, I didn't realize list_empty was protected by READ_ONCE. Will fix.

> > +       is_empty = list_empty(&stream->fragments);
> > +       spin_unlock_irqrestore(&stream->lock, flags);
> > +
> > +       return is_empty;
> > +}
> > +
> > +static int string_stream_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct string_stream *stream;
> > +
> > +       stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +       if (!stream)
> > +               return -ENOMEM;
> > +
> > +       res->allocation = stream;
> > +       INIT_LIST_HEAD(&stream->fragments);
> > +       spin_lock_init(&stream->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static void string_stream_free(struct kunit_resource *res)
> > +{
> > +       struct string_stream *stream = res->allocation;
> > +
> > +       string_stream_clear(stream);
> > +       kfree(stream);
> > +}
> > +
> > +struct string_stream *alloc_string_stream(struct kunit *test)
> > +{
> > +       struct kunit_resource *res;
> > +
> > +       res = kunit_alloc_resource(test,
> > +                                  string_stream_init,
> > +                                  string_stream_free,
> > +                                  NULL);
> > +
> > +       if (!res)
> > +               return NULL;
> > +
> > +       return res->allocation;
>
> Maybe kunit_alloc_resource() should just return res->allocation, or
> NULL, so that these functions can be simplified to 'return
> kunit_alloc_resource()'? Does the caller ever care to do anything with
> struct kunit_resource anyway?

Another good point. I think originally I thought it might, but now
with the mandatory init function, the user has to provide a function
where they can do the init work. They might as well do it there. Will
fix.
