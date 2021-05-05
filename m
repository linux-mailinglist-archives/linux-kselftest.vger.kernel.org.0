Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95563747B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 May 2021 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhEESDS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhEESC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 14:02:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D5C061239
        for <linux-kselftest@vger.kernel.org>; Wed,  5 May 2021 10:44:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so2282540pga.11
        for <linux-kselftest@vger.kernel.org>; Wed, 05 May 2021 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obGxJOifXc8O1UmFRuQ9Y2+IOogHda0WcOdPfQSfwps=;
        b=pjLARA1GJw14DHiB+icqJxq8dOzk8zpoN9Uk7ZgzM6xWktE/WSxphlIGl1wNV7BpkO
         ba5Ob+ivvmSStYs6/9XSuVUVnepS6u5SZkkxMLyKDe6NOcfomeyofG96nIsWgyOVVHhl
         kDHGYtA0VHZX8eyuOwK88J9YI2A28LY/oazK6eB2KsdVvhGNS3uyI8PTZCuhP2nFaM/H
         m5M8NMpCYJabwUUUxGTQX0etROOg/LeoHpCpJ4X22BKHxXq+C9gh+2Ktyoj/hU/TTCa5
         1iy8m0W682jrxSkHBfPIgdxNaZp/FFhFwKmLWoUAPLI76XMIt+/2PdSjbXkesJ+NAfrL
         NScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obGxJOifXc8O1UmFRuQ9Y2+IOogHda0WcOdPfQSfwps=;
        b=k6YMA/CQlYjdJ1yqT7yMQQwj+zwfdvPNsP0ghhytF5ScdUIhBWrVgvoSx1zWNYSk7N
         M0TRS3WN0nx24ahvwA8x0CX025MViCqlkacClhU5cTppcsFk8S3WRDlK4GjLRPwZSASj
         lJ2fzoNvHZEyNuDifdtnSwZgQlhXuloHSex2kvNlD5dnfA/bejLGmRLhvCXM/0PIJl7Q
         ceOHYCv7v9U22wIDtJqIhw2z26fu1gcjSDudN73QfRrUzJ4Qu0Oc226tkC6m3KWayCdM
         W5V5oifY9cxAWXZ4obukQ9dcP2DRBKlHz9lhElUOTzv8qQ5kp4QSw55beu+NnzaXeACQ
         jk4A==
X-Gm-Message-State: AOAM5317KhGVlEzW/5czKhtGoxi52rSdWBCOFqsyuGJGOZDPfEgmvjT0
        dV937EIdg+Ir7EuYoIvKMzJzd1Qa01vl8+FXUJ7a0g==
X-Google-Smtp-Source: ABdhPJy0Ci7nMyjylGdOqTHf0rBu6M32HJjGd76reaDGpvyl4Y0m/boAcrTKs2TlphWAnNFY6zyVxQTWRpXczYHwTOY=
X-Received: by 2002:a65:6085:: with SMTP id t5mr79539pgu.201.1620236683926;
 Wed, 05 May 2021 10:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210416065623.882364-1-davidgow@google.com> <YJGUFrc8PJ0LAKiF@google.com>
 <CABVgOSnz2PhMeqXLz00U406Wn6cLiiHKmrUyB20A=zauwh2=1A@mail.gmail.com>
In-Reply-To: <CABVgOSnz2PhMeqXLz00U406Wn6cLiiHKmrUyB20A=zauwh2=1A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 May 2021 10:44:33 -0700
Message-ID: <CAFd5g46uEMNYxhUNTKce-8jAGB_c=Zme8yF3mc4rNKtU9niy4Q@mail.gmail.com>
Subject: Re: [PATCH v8] fat: Add KUnit tests for checksums and timestamps
To:     David Gow <davidgow@google.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 4, 2021 at 11:48 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, May 5, 2021 at 2:36 AM 'Brendan Higgins' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Thu, Apr 15, 2021 at 11:56:23PM -0700, David Gow wrote:
> > > Add some basic sanity-check tests for the fat_checksum() function and
> > > the fat_time_unix2fat() and fat_time_fat2unix() functions. These unit
> > > tests verify these functions return correct output for a number of test
> > > inputs.
> > >
> > > These tests were inspored by -- and serve a similar purpose to -- the
> >                    ^^^^^^^^
> >         I am guessing this is supposed to be "inspired".
> >
>
> Oops -- yup. This is a typo. I can resend a version with this fixed if
> you think that makes sense, otherwise I'll just hold it over in case I
> need to send out a new version.
>
> > > timestamp parsing KUnit tests in ext4[1].
> > >
> > > Note that, unlike fat_time_unix2fat, fat_time_fat2unix wasn't previously
> > > exported, so this patch exports it as well. This is required for the
> > > case where we're building the fat and fat_test as modules.
> > >
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/inode-test.c
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >
> > Aside from the nit above, and the *potential* nit and question below.
> > Everything here looks good to me.
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > > ---
> > >
> > > It's been a while, but this hopefully is a final version of the FAT KUnit
> > > patchset. It has a number of changes to keep it up-to-date with current
> > > KUnit standards, notably the use of parameterised tests and the addition
> > > of a '.kunitconfig' file to allow for easy testing. It also fixes an
> > > endianness tagging issue picked up by the kernel test robot under sparse
> > > on pa-risc.
> > >
> > > Cheers,
> > > -- David
> >
> > [...]
> >
> > > diff --git a/fs/fat/fat_test.c b/fs/fat/fat_test.c
> > > new file mode 100644
> > > index 000000000000..febd25f57d4b
> > > --- /dev/null
> > > +++ b/fs/fat/fat_test.c
> > > @@ -0,0 +1,197 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit tests for FAT filesystems.
> > > + *
> > > + * Copyright (C) 2020 Google LLC.
> >
> > Nit: I know you wrote this last year, but I have had other maintainers
> > tell me the Copyright date should be set to when the final version of
> > the patch is sent out.
> >
> > I personally don't care, and I don't think you should resend this patch
> > just for that, but figured I would mention.
> >
>
> Hmm... I've definitely heard this both ways, but I can easily update
> the year if I need to send a new version out.
>
> > > + * Author: David Gow <davidgow@google.com>
> > > + */
> > > +
> > > +#include <kunit/test.h>
> > > +
> > > +#include "fat.h"
> > > +
> > > +static void fat_checksum_test(struct kunit *test)
> > > +{
> > > +     /* With no extension. */
> > > +     KUNIT_EXPECT_EQ(test, fat_checksum("VMLINUX    "), (u8)44);
> > > +     /* With 3-letter extension. */
> > > +     KUNIT_EXPECT_EQ(test, fat_checksum("README  TXT"), (u8)115);
> > > +     /* With short (1-letter) extension. */
> > > +     KUNIT_EXPECT_EQ(test, fat_checksum("ABCDEFGHA  "), (u8)98);
> >
> > How do you get the magic values? Or is this just supposed to be a
> > regression test?
>
> This is mainly meant to be a regression test, and the values did
> originally come from just running fat_checksum. I have, however,
> checked that Windows 98 produces the same values (on a FAT12
> filesystem).

All the above sounds good to me. Like I said before, all my comments
are pretty minor, I don't think you need to send a new revision for
those.
