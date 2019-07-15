Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034FA69F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfGOWnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 18:43:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33189 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbfGOWne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 18:43:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so8107578pfq.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0dmaddygNqZgaGUDAa6cmxBvESBVDt3nRTuc2Ed70Y=;
        b=TvefYQ4CXwYECIE1DD5mMNTXSS5HYvyG/pzvPIWc/AcUeE000MlMBoQ+UnA0lQ1n5F
         J7msY35wgId7ntbvKXqQfoaqQ86v3mXkjix4KiLl4u6U93/fC5IaevmselacDdowCR/G
         iyLUy9PuUK6XnxYy7VDz4MJceIVqGDB7wOfFH9e4PAIu+KvegnYNT6RGkjvCG2CcAryr
         zNpIkVs0KHES2MAvXC6bkPoPCjnPfiickXXO58iW726KzLdfp/yLgSvrpmy/5Ix9KBQ0
         9sghkw+DYAjzdFPtaBU764DprOajqeRr5/CW8du6jhE57m3uscWi90TZpp/kvfYXdZoS
         /10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0dmaddygNqZgaGUDAa6cmxBvESBVDt3nRTuc2Ed70Y=;
        b=UeDs5+v7hmY+UngHxsCpQbm8BkXJhApxEWwNquyCs5B6iPepL2JDKVFWqu+0LmNl3j
         1p4aJ/9Dx69tqIXy0jm/L684kf2frn+TPOqhocugIpCYnT3Yp6FaQ/iN2snb0S7k/ltF
         NVMG4kJJ3R6a40QYCwGQ1/5J7zVXWXpA/YHlq5tSdu4+hxV6M3WzHamPRADvxZvkz3Xz
         QJTXQRQNaOepi4Oyg1ElnM53arCLN8AygcV3toY5DCXF8Lkrw/q1EgpOQTgM1TL2Gjqv
         NG38Lru/msYPUwo//6sEr5d+tm2QN3UthzSxBWeHQ/V+4FfPKfI8CTNYlwxGFw3teqbD
         j/vQ==
X-Gm-Message-State: APjAAAVmycWQZ8J2IMW5k6xbvbffd0pW49SXAfQ5yQU+l6vZwd8eEjfh
        uO6msakpMswW5Nt9j5l802sukAhJFwjPKg424RZamA==
X-Google-Smtp-Source: APXvYqwafDOiX+PiabduZWro+OOpT5RPBS9Ci2pxCrNN9UWVIxex8mHl/Rh2UWEvSxgoEZAT49mdKVcWgja67R7I7ck=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr28611693pgk.384.1563230612372;
 Mon, 15 Jul 2019 15:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
 <20190715220407.0030420665@mail.kernel.org> <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
In-Reply-To: <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 15:43:20 -0700
Message-ID: <CAFd5g47y4vDB2P=EsGN8305LGeQPCTveNs-Jd5-=6K-XKY==CA@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 3:11 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-07-15 14:11:50)
> > > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > I also wonder if it would be better to just have a big slop buffer of a
> > > > 4K page or something so that we almost never have to allocate anything
> > > > with a string_stream and we can just rely on a reader consuming data
> > > > while writers are writing. That might work out better, but I don't quite
> > > > understand the use case for the string stream.
> > >
> > > That makes sense, but might that also waste memory since we will
> > > almost never need that much memory?
> >
> > Why do we care? These are unit tests.
>
> Agreed.
>
> > Having allocations in here makes
> > things more complicated, whereas it would be simpler to have a pointer
> > and a spinlock operating on a chunk of memory that gets flushed out
> > periodically.
>
> I am not so sure. I have to have the logic to allocate memory in some
> case no matter what (what if I need more memory that my preallocated
> chuck?). I think it is simpler to always request an allocation than to
> only sometimes request an allocation.

Another even simpler alternative might be to just allocate memory
using kunit_kmalloc as we need it and just let the kunit_resource code
handle cleaning it all up when the test case finishes.

What do you think?
