Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1A8B1C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfHMH5p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 03:57:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41425 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHMH5p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 03:57:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3964351pfz.8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2019 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxe9OCB0IqyHnARJf+JfT+i9JEoP4MCbV860ULsGU5s=;
        b=fWxvwQ8Jg+CWf05NnJCeSWeVicnOoXy6BXG5VhOfTHwJWFVTHFtRdcNqJwjLSDCsVu
         jiiP3AZW2TJ9Y27gYXlQWYVFyW9cOeHAtkBDWUX3YWHKBu/HS+LKFfPpeMSX6W2l72tZ
         BRhzYAO288V5DleisjNQBfRbcy/Mz40/cEOLiUMhsZ95Bxp04BvhX0q6796bywFqCBqp
         NSnYasYkCLB4Txnd4bsLfaw/UOxBpmRM2L4ZKLjuNJtySeAykDmMbqKDwEkFdZmfV7CY
         oOe6Xd9hvm7QvXiKG5lkjN3mPEgj0ajH3yxwTU51S77P9cnCG7u1CaWqpN7xPuHVgKBk
         pF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxe9OCB0IqyHnARJf+JfT+i9JEoP4MCbV860ULsGU5s=;
        b=V44KojWiL++R4a7aPv+NpjLguLmf6sEj7wgdqyXKErCfIY06+GEeeYaNcoL2Jmv/EN
         jUOzAhwozsXLRkHIYDiMEeQDZ6OpLX6fQU0rEQwa6PKab7n8wrxE9aeNwt+ZJcooQwBj
         AUWrFpeGGeNkfWR3pr6s2oD26Hzj4cOETelJdHooM83+ae1s6MoUdPrxfxD7LEFXGyH0
         eeakCm4Aww0ZNAh+biJ25zPrWCbdr+fjMSr+Flawk+IXGpoM303lD28GVhj33nSJKFei
         Yk6Lh8HBB/5/bQquAEprDD4Cf7msYyRTNe3AEn+TZWo2Pd/R8BMvCtYYETmhgtI5pOhF
         KgAw==
X-Gm-Message-State: APjAAAXHZoZRs/OTaUuxqgcLUHMMTxRS96ePMrHjtUcuiZE34OCMbhkS
        WTbWAjeI3j44XYGg+XH05SsN0Z1txw4zg6MUtdWTXw==
X-Google-Smtp-Source: APXvYqzWk2rxD82fR19g3JsVNBllToOJJzR2xQFo11AJZitYxxxUqNbN9+PHkwurw7oZzFeN69t+CYdvTXIlmBWBICY=
X-Received: by 2002:a63:205f:: with SMTP id r31mr31222917pgm.159.1565683064346;
 Tue, 13 Aug 2019 00:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-13-brendanhiggins@google.com> <20190813043140.67FF320644@mail.kernel.org>
In-Reply-To: <20190813043140.67FF320644@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Aug 2019 00:57:33 -0700
Message-ID: <CAFd5g44Es4emKyQSxUkqckGJ02_o3sAcDLwUCW8ZFGX14j5=xg@mail.gmail.com>
Subject: Re: [PATCH v12 12/18] kunit: test: add tests for KUnit managed resources
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Avinash Kondareddy <akndr41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 12, 2019 at 9:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:15)
> > +
> > +static int kunit_resource_test_init(struct kunit *test)
> > +{
> > +       struct kunit_test_resource_context *ctx =
> > +                       kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +
> > +       if (!ctx)
> > +               return -ENOMEM;
>
> Should this use the test assertion logic to make sure that it's not
> failing allocations during init?

Yep. Will fix.

> BTW, maybe kunit allocation APIs should
> fail the test if they fail to allocate in general. Unless we're unit
> testing failure to allocate problems.

Yeah, I thought about that. I wasn't sure how people would feel about
it, and I thought it would be a pain to tease out all the issues
arising from aborting in different contexts when someone might not
expect it.

I am thinking later we can have kunit_kmalloc_or_abort variants? And
then we can punt this issue to a later time?

> > +
> > +       test->priv = ctx;
> > +
> > +       kunit_init_test(&ctx->test, "test_test_context");
> > +
> > +       return 0;
