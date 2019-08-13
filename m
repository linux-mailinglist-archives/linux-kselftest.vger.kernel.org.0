Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1994C8AC1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfHMAlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Aug 2019 20:41:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42809 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfHMAlS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Aug 2019 20:41:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so48590980plb.9
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2019 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2YhU7ZI7zRBNkSqHEOZBShLAkxc14NOfVdnGmm5fKU=;
        b=jtHRbV2jvCMOrug1VL8DlniNesFQqe4mwKTZ3VzgssQ3VQs6b5LtUaNMVZsc5CuJDp
         Iw8whkhdXJ7rcwjGwBhO6bOb4R9HDy3aGxnSkB24MJ9hY0F8GUX42o4R2L5RbO1mHvNQ
         fgfZIIuryuM6MsMlE2FCQsFy9Ko0MwXC35YX0zFHFknsYf9vPZZbgUGmBgAsRIvp4Uqd
         60LKpvXh51SGPv9+hzg4POm9qQcvjpOv0jvCdTcXtAwCmnYW+REf4ctA9Xh3nN2C0Pk2
         Dfg6a9VXk1PXwpLh/pQidSNRP79rt83WW1lNCqDZaP/t4ID/ZKf6fmlxyUwdKcQccRx2
         iAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2YhU7ZI7zRBNkSqHEOZBShLAkxc14NOfVdnGmm5fKU=;
        b=LzNAfTWv0W+qz6cmOUj138cQMQ1RQqFOoi4JmhcvR+rVyF6X75bGSKHcQ/ss6jLUAj
         4FRhwXv4o5XvL+Cj5MSCzFxdyopNL2JD8tsJ01viuFfbEC5J+t9ohmUq2ENnxOp9dyrO
         hg+IjTqUe5TqdggZuVRP2fWQcgE8pZHOkrcI7ZMnnPDhvoswHuhQTIH48LL41Hm1xvpe
         a/8hqMH0Pf99vQbzNLU8c5EoKV1Fw4YaQNPNlQgaIb2SVvP12b+2W3I+Ez0r/9qygVtl
         fhH7bFgyWFi6Tt6vI8bgexomNJPfF7i39gTmWRQdp09KMtjUhmeCedKRYAWoZgezu8YI
         Je5Q==
X-Gm-Message-State: APjAAAU0JyZgDz5P9k6xyk59WP2aX20TRWWs+SsPIHfxJwxOtvmjEuyb
        o9bzpggz+7GarJ8cmpg19326Qtn5F/iJ/FlIg9wkig==
X-Google-Smtp-Source: APXvYqwMN7m1oxhncwRThnueyB+Cpwr7fkWXdNKhV0HMwJO6gvgJeykiY4kuCkE7DaZ3nG+H6w12tIuXT7ijhEgDApc=
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr25962931pli.232.1565656877406;
 Mon, 12 Aug 2019 17:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com> <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com> <20190812235940.100842063F@mail.kernel.org>
In-Reply-To: <20190812235940.100842063F@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 17:41:05 -0700
Message-ID: <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
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

On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 16:33:36)
> > On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> > > Quoting Brendan Higgins (2019-08-12 11:24:06)
> > > > +void string_stream_clear(struct string_stream *stream)
> > > > +{
> > > > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > > > +
> > > > +       spin_lock(&stream->lock);
> > > > +       list_for_each_entry_safe(frag_container,
> > > > +                                frag_container_safe,
> > > > +                                &stream->fragments,
> > > > +                                node) {
> > > > +               list_del(&frag_container->node);
> > >
> > > Shouldn't we free the allocation here? Otherwise, if some test is going
> > > to add, add, clear, add, it's going to leak until the test is over?
> >
> > So basically this means I should add a kunit_kfree and
> > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > devres_destroy) and use kunit_kfree here?
> >
>
> Yes, or drop the API entirely? Does anything need this functionality?

Drop the kunit_resource API? I would strongly prefer not to.
string_stream uses it; the expectation stuff uses it via string
stream; some of the tests in this patchset allocate memory as part of
the test setup that uses it. The intention is that we would provide a
kunit_res_* version of many (hopefully eventually most) common
resources required by tests and it would be used in the same way that
the devm_* stuff is.

Nevertheless, I am fine adding the kunit_resource_destroy, etc. I just
wanted to make sure I understood what you were asking.
