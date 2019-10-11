Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC1D3CF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfJKKF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 06:05:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40050 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKKF6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 06:05:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so4239971pll.7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNqtgthl8VyBRo/9SmMdv19JQkKzyWONQ2Spmwn+3yU=;
        b=TpWNF5FdbzsY5yjRyuNc/WX1V5aEmdKaz44+83keWD0C8QfuO6Z44Dw3G8Hl+1xU6T
         frLh1buCzNdEA+AxQVztaQtYHwxAYXe/yQQ9P6jMrTV7/yrXLpSNOgF5+f4dZE3FBQ0K
         JD2/OH9ivAAudfN1H1+1Y2b7SczXtAvAazzkx+DaXkeWdc/FzDaWPL1yML9ZQZBHIWTp
         cU+vS5x85lPN00MQFUfY4C3LWs/s/CD0oPl/blC2OJ5ZPXlqTFRR9ED5bzmy14HGXVBN
         dAZFqTUNhH3dkPvY1suY/Yl11ay2xQA45mZWTY3nxWJSgeugdv1Z8bv4nTNzY8KWJWQR
         s5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNqtgthl8VyBRo/9SmMdv19JQkKzyWONQ2Spmwn+3yU=;
        b=mjD3wY52xjjHXctAmOGJGi+nhiGlPdcIC6lxMo05gfo+ByrjmnlkMaN4YeB7DhaQAT
         GlRsFrH/UuF7GRrHV5MujR3TciYjqYPoZspbhxuPWzQwEoJOopRd3VdV0y2aMj86GrLd
         yc+LFcIFFdSZOP2YDnoqV45uajq1b6WBa0Zis2DZCaQQC5R8O6nPnHGmzFAwitChi6dC
         wnv6bydbFkDeAs1zfaHt/s9IUTHdx9aRYmPMYLdAUTK7hyUKR+dZ5+5cVQtwMuDMxXGd
         x/49xnX66hP7GYb8/tyNaQX/avnOgMP5xRQzWz2xIfYmQ1O/fGv8yS3Hh8G3QpvUcoZX
         aaQw==
X-Gm-Message-State: APjAAAXzW+JsXIpzVc5WSfdqTfvuP70bNuLxR6m58QbJc2WgPwR/p2kQ
        kEodEIjUV+y4cIjlgBtvH+B3e2t6GqNqtMFd0gdRWely
X-Google-Smtp-Source: APXvYqxhIQmPeGXTLzeWrNMxIcwwUTr92AZgC7VGQiwvsA2nwU9FbpfSMFZhp7hwLlVaFGqwgQOMCzyil5ZvpGaSSYw=
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr14492128pln.232.1570788355057;
 Fri, 11 Oct 2019 03:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
In-Reply-To: <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Oct 2019 03:05:43 -0700
Message-ID: <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the late reply. I am on vacation until Wednesday, October 16th.

On Thu, Oct 10, 2019 at 3:14 PM Iurii Zaikin <yzaikin@google.com> wrote:
>
> On Thu, Oct 10, 2019 at 10:11 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > On 10/9/19 8:39 PM, Iurii Zaikin wrote:
> > > KUnit tests for decoding extended 64 bit timestamps.
> > >
> > "Added the link to the ext4 docs from which the tests were derived."
> >
> > Document reference is great. I would still like to see summary
> > in the commit log.
> >
> > As you said below:
> >
> > "This builds the ext4 inode sysctl unit test, which runs on boot."
> >
> > Also include what should user expect to see when one of these fails.
> Will do.
> >
> > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > ---
> > >   fs/ext4/Kconfig      |  12 +++
> > >   fs/ext4/Makefile     |   1 +
> > >   fs/ext4/inode-test.c | 221 +++++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 234 insertions(+)
> > >   create mode 100644 fs/ext4/inode-test.c
> > >
> > > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > > index cbb5ca830e57..cb0b52753674 100644
> > > --- a/fs/ext4/Kconfig
> > > +++ b/fs/ext4/Kconfig
> > > @@ -106,3 +106,15 @@ config EXT4_DEBUG
> > >         If you select Y here, then you will be able to turn on debugging
> > >         with a command such as:
> > >               echo 1 > /sys/module/ext4/parameters/mballoc_debug
> > > +
> > > +config EXT4_KUNIT_TESTS
> > > +     bool "KUnit test for ext4 inode"
> > > +     depends on EXT4_FS
> > > +     depends on KUNIT
> > > +     help
> > > +       This builds the ext4 inode sysctl unit test, which runs on boot.
> > > +       Tests the encoding correctness of ext4 inode.
> > > +       For more information on KUnit and unit tests in general please refer
> > > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> >
> > Please add Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> > here as well.
> > Yeah. Especially after looking at the document, summary of what these
> > test(s) is definitely helpful. You can't expect users to read the
> > document before enabling it. Please write a summary of tests and what
> > they do and add it here and then in the commit log. Also include what
> > user should expect when they pass and when one of them fails.
> >
> I'm not sure this is compatible with Theodore's preference for having a single
> config option for all ext4 tests. If anything, I should be removing

That's an interesting point. Should we try to establish a pattern for
how tests should be configured? My *very long term* goal is to
eventually have tests able to be built and run without any kind of
kernel of any kind, but I don't think that having a single config for
all tests in a subsystem gets in the way of that, so I don't think I
have a strong preference in terms of what I want to do.

Nevertheless, I think establishing patterns is good. Do we want to try
to follow Ted's preference as a general rule from now on?

> all inode-specific
> stuff from the description.
> I think it makes sense to add wording that this option is only useful
> for devs running
> a kernel test harness and should not be enabled in production.
> > > +
> > > +       If unsure, say N.
> > > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > > index b17ddc229ac5..a0588fd2eea6 100644
> > > --- a/fs/ext4/Makefile
> > > +++ b/fs/ext4/Makefile
> > > @@ -13,4 +13,5 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> > >
> > >   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)    += acl.o
> > >   ext4-$(CONFIG_EXT4_FS_SECURITY)             += xattr_security.o
> > > +ext4-$(CONFIG_EXT4_KUNIT_TESTS)      += inode-test.o
> > >   ext4-$(CONFIG_FS_VERITY)            += verity.o
> > > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > > new file mode 100644
> > > index 000000000000..43bc6cb547cd
> > > --- /dev/null
> > > +++ b/fs/ext4/inode-test.c
> > > @@ -0,0 +1,221 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> > > + * timestamps in ext4 inode structs are decoded correctly.
> > > + * These tests are derived from the table under
> > > + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> >
> > Yeah. Especially after looking at the document, summary of what these
> > test(s) is definitely helpful. You can't expect users to read the
> > document before enabling the tests.
> >
> > > + */
> > > +
> > > +#include <kunit/test.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/time64.h>
> > > +
> > > +#include "ext4.h"
> > > +
> > > +/* binary: 00000000 00000000 00000000 00000000 */
> > > +#define LOWER_MSB_0 0L
> > > +/* binary: 01111111 11111111 11111111 11111111 */
> > > +#define UPPER_MSB_0 0x7fffffffL
> > > +/* binary: 10000000 00000000 00000000 00000000 */
> > > +#define LOWER_MSB_1 (-0x80000000L)
> > > +/* binary: 11111111 11111111 11111111 11111111 */
> > > +#define UPPER_MSB_1 (-1L)
> > > +/* binary: 00111111   11111111 11111111 11111111 */
> > > +#define MAX_NANOSECONDS ((1L << 30) - 1)
> > > +
> > > +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
> > > +
> > > +struct timestamp_expectation {
> > > +     const char *test_case_name;
> > > +     struct timespec64 expected;
> > > +     u32 extra_bits;
> > > +     bool msb_set;
> > > +     bool lower_bound;
> > > +};
> > > +
> > > +static time64_t get_32bit_time(const struct timestamp_expectation * const test)
> > > +{
> > > +     if (test->msb_set) {
> > > +             if (test->lower_bound)
> > > +                     return LOWER_MSB_1;
> > > +
> > > +             return UPPER_MSB_1;
> > > +     }
> > > +
> > > +     if (test->lower_bound)
> > > +             return LOWER_MSB_0;
> > > +     return UPPER_MSB_0;
> > > +}
> > > +
> > > +
> > > +static void inode_test_xtimestamp_decoding(struct kunit *test)
> > > +{
> > > +     const struct timestamp_expectation test_data[] = {
> > > +             {
> > > +                     .test_case_name = "1901-12-13",
> > > +                     .msb_set = true,
> > > +                     .lower_bound = true,
> > > +                     .extra_bits = 0,
> > > +                     .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> > > +             },
> > > +
[...]
> > > +             {
> > > +                     .test_case_name = "2446-05-10",
> > > +                     .msb_set = false,
> > > +                     .lower_bound = false,
> > > +                     .extra_bits = 3,
> > > +                     .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> > > +             }
> > > +     };
> > > +
> >
> > Is there a way to make the test data dynamic. Can you read from a data
> > file? It will be easier to if the data
> >
> > Maybe this is question to Brendan?
> >
> From the general unit test philosophy, unit tests must be 100% deterministic,
> repeatable and simple enough to be correct by visual inspection, dynamically
> generated test data runs contrary to these goals IMHO.

I 100% agree with this position on unit tests, Iurii.

> As for reading from a data file, not sure what exactly you mean here:
>  - Having a running kernel read a file in the filesystem, especially as early in
> the initialization process as KUnit currently runs is something I'm not sure
> how to implement reliably. Also, doing I/O in the tests will make them slower
> and require more setup from test running environment.
> - Having reading a file in the build stage and linking it as a data
> blob into the
> kernel image. This approach looks better to me since it avoids the I/O and has
> no noticeable speed penalty or test harness requirements. It would be up to
> Brendan whether he wants such capability in KUnit and based on the user-space
> test code I've seen so far, the number of test data points in this
> test doesn't warrant
> reading from files even in userspace which has far fewer constraints.

I agree with Iurii. I don't think that this example alone warrants
adding support for being able to read test data in from a separate
file (I would also like some clarification here on what is meant by
reading in from a separate file). I can imagine some scenarios where
that might make sense, but I think it would be better to get more
examples before trying to support that use case.

Thanks!
