Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED94C55B6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2019 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFYWlm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jun 2019 18:41:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFYWlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jun 2019 18:41:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so236473plt.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2019 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZHzVm2a7c7UL6Qa6OAs8GEjMqpVhQyW6fXdYgD38tg=;
        b=WD+/u8ZZNxnSkIT8uW5k3AjwCTR/8Rul0p24/yrVxO5s2EytGRajAgq/3lh2tgJCoM
         vOOrZEi6S9bPRtEV0sQ50TTo+svFRl+vB4anHgBOhwDOhj/sKAavGpLkR9ZW/+8ZlccU
         UdMs6Z8Ga9hdSotzdUPEFVwI6IZ9G3K5novTFltGAZnxEjjToD6xbWblx/HifwrkfVwk
         hJ5e4XwNevJKRgf4O7t302ViaxWNKj1aXsprvBLH4sig979oKbLTzjrYSQpuQWmWeZ6j
         dP5tx4S2eAu98MeIeDuog/S9j0E1psO/k6tGCkOvr99nidb5QryIDQhLc5bRofLMt0FA
         FrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZHzVm2a7c7UL6Qa6OAs8GEjMqpVhQyW6fXdYgD38tg=;
        b=AeE+PxARvepCBu4KbyOCx/j0eG1sLDTAW/SKvoyPIZBAxLIVa2QxWEYGjPmdlpPnOh
         EFTwzJHIgZJaB2J+aEGhj4ZoTcb1nDBkHbEXVKGF/1Uf+1UUgxnrb13XeD37MVYJujzw
         nJAxLmLRp2OOJ9THFnL7QaFxGwXzmiRuiv9e+MsWOjWlQIGrQTj01M4VAwZ+zxmhhm6q
         TxHrYJOPTOs9ErmRPcUXp2lqEKJRUM0H/Vs0x1u7zpZD1jYYkoeyTwNt1i321G8wxlNj
         zcCrNzwWE4pQ+HfkfsPertTE7gyl1nvxax5mEjsY4hTp/NRSt+RLmnsQcOYsaSIOobZq
         8vEw==
X-Gm-Message-State: APjAAAVDQ27I1xYhLo8IQP+ShT6UV3pDlW6ybN1l1RwSMQM3PEQwtxj9
        RZxyNJwGovcZGu80dQm5fBrc2b37WOEZ3uJcwu0diA==
X-Google-Smtp-Source: APXvYqy+cT1ZyNb5dbS97li+J3swfp3mEaFo87MllhiLnOnKUdNsGvjik4FBRsZ5dS4sFwdr9UIg/0trivOUWFuNZts=
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr1155831pla.325.1561502500720;
 Tue, 25 Jun 2019 15:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com> <20190625221318.GO19023@42.do-not-panic.com>
In-Reply-To: <20190625221318.GO19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Jun 2019 15:41:29 -0700
Message-ID: <CAFd5g448rYqr3PHg0cfoddr70nktkWXcRfJoZHmuPJjTW53YYg@mail.gmail.com>
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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

On Tue, Jun 25, 2019 at 3:13 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
> > diff --git a/Kconfig b/Kconfig
> > index 48a80beab6853..10428501edb78 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -30,3 +30,5 @@ source "crypto/Kconfig"
> >  source "lib/Kconfig"
> >
> >  source "lib/Kconfig.debug"
> > +
> > +source "kunit/Kconfig"
>
> This patch would break compilation as kunit/Kconfig is not introduced. This
> would would also break bisectability on this commit. This change should
> either be folded in to the next patch, or just be a separate patch after
> the next one.

Maybe my brain isn't working right now, but I am pretty darn sure that
I introduce kunit/Kconfig in the very first patch of this series.
Quoting from the change summary from the first commit:

>  include/kunit/test.h | 161 +++++++++++++++++++++++++++++++++
>  kunit/Kconfig        |  17 ++++
>  kunit/Makefile       |   1 +
>  kunit/test.c         | 210 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 389 insertions(+)
>  create mode 100644 include/kunit/test.h
>  create mode 100644 kunit/Kconfig

I am not crazy, right?

>  create mode 100644 kunit/Makefile
>  create mode 100644 kunit/test.c
