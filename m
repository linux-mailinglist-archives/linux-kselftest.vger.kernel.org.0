Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DBF8AE80
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 07:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfHMFGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 01:06:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35490 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHMFGQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 01:06:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so386458pfd.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Aug 2019 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
        b=Y+dmDbanwPRKrcGCv4/WQS9jtPyx6cpYSiNcTCluUKOVyeyn7wl8RZe0u1cf6FlML6
         wfRe3v8dcFvKIShJjXRgh8cEGNhzCFLCfZTUSJEGO2Ea0/S9/l8EIDzT2hfdmu4vYl3/
         XIR90pnuI3K4kV1d5Bm11Pn57c+GfE4dVDOOxOsnLShgWMYlA1pJcJoF7sOPZtexCwYP
         ELhxZQwrFnEmjZhgXx2mjuE3HiLK9TadecMdLzAo0eHIWgo1V1G1uOa5P7ZTv3NrW55Q
         IwxyHJePJisriyJmWo1d+yNh53aHnfmOSYFZCbC26Ph2JuMFkmU8c4wQttP2Gfux7zEx
         HKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
        b=pPFXPUlJdrGZUVImJsO/mR8YhjYHe8AR2137grdo9wTLZfJfBgtjLikH9yIH1fAuG6
         cqNIk+C/mftxUEykL6h7QSgV7L7eKw3OwhA4UFK+H4hLi0MFdTiprZtgvUrWldncF5ay
         GCjX/8P6B5KOW88habeexbCU37lZj2yv8sJFUCrPB5l0A4aMxAqb2J/Wtp1K/9b1+tUv
         oF6qqpr5FsYyW2xf0p1EMjbtoP6OPVsUbOKIw4348o6U0cXfOac4UbCTWPI0SKhbN5fK
         12RwIDaRYn+Q37+OHF1nXwmmZn07BiNLtg+NOrh89LDw7W9oorvAqyY0czTpuRfPdEZl
         98sA==
X-Gm-Message-State: APjAAAXnLMTguj0LAN5bgqHXqnsXEVqjyKXrgnuyEcRfxlXJ6u6DMzFI
        HDOZ1ohFoQ+sPw8D9rSOpIFw43nlyRq6RW2QD+C31A==
X-Google-Smtp-Source: APXvYqzlm/LZa7vLxmhuF4EQXYFyYKJYlrIat9BhnUUptmEmQR49KGysQZ4JhDoNNZWx7O5yEaH2e2yfA6hMO6s/qoE=
X-Received: by 2002:a63:205f:: with SMTP id r31mr30781941pgm.159.1565672775425;
 Mon, 12 Aug 2019 22:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-11-brendanhiggins@google.com> <20190813042455.4A04320644@mail.kernel.org>
In-Reply-To: <20190813042455.4A04320644@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:06:04 -0700
Message-ID: <CAFd5g46LHq1sQaio2Vj5jt54YN-Y2HuCT8FbALQhJoekkYJ-uQ@mail.gmail.com>
Subject: Re: [PATCH v12 10/18] kunit: test: add tests for kunit test abort
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

On Mon, Aug 12, 2019 at 9:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:13)
> > +
> > +static int kunit_try_catch_test_init(struct kunit *test)
> > +{
> > +       struct kunit_try_catch_test_context *ctx;
> > +
> > +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>
> Can this fail? Should return -ENOMEM in that case?

Yes, I should do that.

> > +       test->priv = ctx;
> > +
> > +       ctx->try_catch = kunit_kmalloc(test,
> > +                                      sizeof(*ctx->try_catch),
> > +                                      GFP_KERNEL);
