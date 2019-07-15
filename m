Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7944369EC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfGOWL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 18:11:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40024 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfGOWL0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 18:11:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so8368579pgj.7
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHxJwZ65KY+3dlkcg53YlVURzFgCQ53x+CwfDq4SFas=;
        b=MvXH0Y8+JYN6ezlr5+hNCudCnof36BXSG2llvPNekQW2sBy9YI7G1SGXVvdpQ2yLlf
         lKmujf+vhO+TdWj9V4lOLI5HKJRwOFsNc0Z+HQAqQPNMJNZhG/XUbO9b48lY2JAe2PXf
         C8cLituJqcyPcWhWrYkyYHyARQmMnImIukUwVh64GRNchs/vVW+Y3sNTXsnP2KkMCYsm
         tWZq1xFfkUWrMfYRu8uiUj1FZHlJMuMIXnMs4JzAjkIMXT+CDsY4Zk4nzjtcIDvnC44z
         6Zz6d+u8+o54d/ZpHHJzzRw6Uhf6PoufrWply9sIpa7H/+/YZvqwkPQ/RonuXcI57X3X
         E14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHxJwZ65KY+3dlkcg53YlVURzFgCQ53x+CwfDq4SFas=;
        b=O6JlRFR/Ig56yKa/D5k/3WzQmooJYwtTkeDtwPHgrJr+8Y4TvA83iq7q7PYEwZ+iTN
         70agXZB/BG4L/6oNZCwHBEWGfm0tJdvX4LN38kPc4kGuX8++hjnGBZ1wovwpuJIVDw+m
         iHSiNQDFjOPKrRpAHQXPmT36DK52o8R0Xthp/lrLwxM4+1PqOmCFKkhLdgbUzS6ykVNb
         cldlzIkCHRBERHlMSTQ9xlWMV5rxBKZtB9dYToGn7PRfdGkyIM/qmPdoVyN4Ii7Tx93X
         ugrpAXkXnSCuGjLmLyEO93yGcuOJIyWnU5GEa8GKbIljJQqrXdKwLxLYbh6x67ZttArv
         5sWQ==
X-Gm-Message-State: APjAAAVwrNwHk4FD5LUXqmlqzkp7FlfCiucB1usoTTyfNS1Ej9dmAxU5
        ejR3Br4yIcIWSvz1KpDrZfVoV+trVdh1UIwF7G7SZg==
X-Google-Smtp-Source: APXvYqyfZTPL0o0YQnU93ejOaxOs5yytKYAJU2sUr1pH6F5nUAdPz6GwWoelLdf7eJ3sfRDvsdaJ2GYy9d2vy6rHMRQ=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr28473124pgk.384.1563228684913;
 Mon, 15 Jul 2019 15:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com> <20190715220407.0030420665@mail.kernel.org>
In-Reply-To: <20190715220407.0030420665@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 15:11:13 -0700
Message-ID: <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-15 14:11:50)
> > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > I also wonder if it would be better to just have a big slop buffer of a
> > > 4K page or something so that we almost never have to allocate anything
> > > with a string_stream and we can just rely on a reader consuming data
> > > while writers are writing. That might work out better, but I don't quite
> > > understand the use case for the string stream.
> >
> > That makes sense, but might that also waste memory since we will
> > almost never need that much memory?
>
> Why do we care? These are unit tests.

Agreed.

> Having allocations in here makes
> things more complicated, whereas it would be simpler to have a pointer
> and a spinlock operating on a chunk of memory that gets flushed out
> periodically.

I am not so sure. I have to have the logic to allocate memory in some
case no matter what (what if I need more memory that my preallocated
chuck?). I think it is simpler to always request an allocation than to
only sometimes request an allocation.
