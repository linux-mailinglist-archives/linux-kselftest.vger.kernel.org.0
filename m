Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6AD3497
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJJXuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 19:50:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43195 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJJXuM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 19:50:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so5973638qtr.10
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R12PDGIhRvvQ7ClBmG9SlOzYyJTsL6m//GVyq2mM5ug=;
        b=Iak/SlBT7oGHHiVu/4BcUjEPRDhGNQLmW6SfvNMg2Ux3hjrsZ5Xlh0QPM8rywMl+UQ
         1GZgvV+9LfmjrJn4nLEwVT5aaAv4EHN5R28zP1FzWTyOQ3Yl8lmzEYvP8yK+KG8svV0J
         APTdkAtpxuBnExh3aw9A2procNca9/z29q9etvs1cj83SnRcR1g+BxJxbgZzLY4h0Z3d
         rbi2u0pdaw7M+9Fpmps3qOZuAyrJWKzkrAY7vEK395LAKGOUBI3+iq5faim9nBtdy2gU
         v/9aHvwSP0P1RxBZS9WJukdS7FechERkRN74fGHnd6vUIZjZlh+up8TYvDStk2MNQBpP
         qmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R12PDGIhRvvQ7ClBmG9SlOzYyJTsL6m//GVyq2mM5ug=;
        b=Fey/C5JrSxO9JT9OL8Az3PFkFB8Htuz288O1oaq4cXrclz0rN449uyUGkhicRAJoa2
         8W6zJcVW6K1ate7tMGUDrSVco/hedCpmC8iw4U1rYxulj4xMWSTsLfvOu6E8hABgsmwS
         r0Y+nPS5EFLCnTYpyu99Xb/daQriLzuc7MY2yYXxEO7FSR7jrurIA6KdacTEwh9soWqn
         dIidrOgaI/hX02CdjXF8gBglEJXtj7X73YHrNJd/ucUU7KBPyjiQPu1XxOo5HCcZzqQx
         YJletbdNSXuLBNq7JCzLgB5JmsyhgLyNsv6Q6CVAp2ReZWKBhc6mo95koJdzuxbTxL1t
         h7VA==
X-Gm-Message-State: APjAAAVLe4qfccMBWd/K0veovsXz7RIMkber18NraX57roOexcxzbLwD
        0/ZHiCJ/4U9L/d3wQsVMkg1otdK39pwsPYE2//C0
X-Google-Smtp-Source: APXvYqwoa5iecCYCeuSaQhIWu058zrdwowf/2NKolTAOFh3CgJ/dfEK6XN9o3e+wPKP4wVXkV+w15nQz9pO6ZR7heak=
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr13414505qvn.142.1570751410470;
 Thu, 10 Oct 2019 16:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <ECADFF3FD767C149AD96A924E7EA6EAF977C135F@USCULXMSG01.am.sony.com>
 <CAAXuY3rk8_Eu_09jGbE66irtnjFzz4=6RxmZ6eMpBLdqpo5xfw@mail.gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF977C172D@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977C172D@USCULXMSG01.am.sony.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 10 Oct 2019 16:49:33 -0700
Message-ID: <CAAXuY3qCFa1zKyAZo5Nq=DA2fY7ELFmK9c9r7jzDjmqrUMtXog@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 1:29 PM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Iurii Zaikin on Thursday, October 10, 2019 6:45 AM
> >
> > On Wed, Oct 9, 2019 at 8:47 PM <Tim.Bird@sony.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From Iurii Zaikin on Wednesday, October 09, 2019 4:40 PM
> > > >
> > > > KUnit tests for decoding extended 64 bit timestamps.
> > > >
> > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > ---
> > > >  fs/ext4/Kconfig      |  12 +++
> > > >  fs/ext4/Makefile     |   1 +
> > > >  fs/ext4/inode-test.c | 221
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 234 insertions(+)
> > > >  create mode 100644 fs/ext4/inode-test.c
> > > >
> > > > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > > > index cbb5ca830e57..cb0b52753674 100644
> > > > --- a/fs/ext4/Kconfig
> > > > +++ b/fs/ext4/Kconfig
> > > > @@ -106,3 +106,15 @@ config EXT4_DEBUG
> > > >         If you select Y here, then you will be able to turn on debugging
> > > >         with a command such as:
> > > >               echo 1 > /sys/module/ext4/parameters/mballoc_debug
> > > > +
> > > > +config EXT4_KUNIT_TESTS
> > > > +     bool "KUnit test for ext4 inode"
> > > > +     depends on EXT4_FS
> > > > +     depends on KUNIT
> > > > +     help
> > > > +       This builds the ext4 inode sysctl unit test, which runs on boot.
> > > > +       Tests the encoding correctness of ext4 inode.
> > > > +       For more information on KUnit and unit tests in general please refer
> > > > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > > > +
> > > > +       If unsure, say N.
> > > > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > > > index b17ddc229ac5..a0588fd2eea6 100644
> > > > --- a/fs/ext4/Makefile
> > > > +++ b/fs/ext4/Makefile
> > > > @@ -13,4 +13,5 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o
> > > > ext4_jbd2.o extents.o \
> > > >
> > > >  ext4-$(CONFIG_EXT4_FS_POSIX_ACL)     += acl.o
> > > >  ext4-$(CONFIG_EXT4_FS_SECURITY)              += xattr_security.o
> > > > +ext4-$(CONFIG_EXT4_KUNIT_TESTS)      += inode-test.o
> > > >  ext4-$(CONFIG_FS_VERITY)             += verity.o
> > > > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > > > new file mode 100644
> > > > index 000000000000..43bc6cb547cd
> > > > --- /dev/null
> > > > +++ b/fs/ext4/inode-test.c
> > > > @@ -0,0 +1,221 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> > > > + * timestamps in ext4 inode structs are decoded correctly.
> > > > + * These tests are derived from the table under
> > > > + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> > > > + */
> > > > +
> > > > +#include <kunit/test.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/time64.h>
> > > > +
> > > > +#include "ext4.h"
> > > > +
> > > > +/* binary: 00000000 00000000 00000000 00000000 */
> > > > +#define LOWER_MSB_0 0L
> > > > +/* binary: 01111111 11111111 11111111 11111111 */
> > > > +#define UPPER_MSB_0 0x7fffffffL
> > > > +/* binary: 10000000 00000000 00000000 00000000 */
> > > > +#define LOWER_MSB_1 (-0x80000000L)
> > > > +/* binary: 11111111 11111111 11111111 11111111 */
> > > > +#define UPPER_MSB_1 (-1L)
> > > > +/* binary: 00111111   11111111 11111111 11111111 */
> > > > +#define MAX_NANOSECONDS ((1L << 30) - 1)
> > > > +
> > > > +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x
> > extra_bits:
> > > > %x"
> > > > +
> > > > +struct timestamp_expectation {
> > > > +     const char *test_case_name;
> > > > +     struct timespec64 expected;
> > > > +     u32 extra_bits;
> > > > +     bool msb_set;
> > > > +     bool lower_bound;
> > > > +};
> > > > +
> > > > +static time64_t get_32bit_time(const struct timestamp_expectation *
> > const
> > > > test)
> > > > +{
> > > > +     if (test->msb_set) {
> > > > +             if (test->lower_bound)
> > > > +                     return LOWER_MSB_1;
> > > > +
> > > > +             return UPPER_MSB_1;
> > > > +     }
> > > > +
> > > > +     if (test->lower_bound)
> > > > +             return LOWER_MSB_0;
> > > > +     return UPPER_MSB_0;
> > > > +}
> > > > +
> > > > +
> > > > +static void inode_test_xtimestamp_decoding(struct kunit *test)
> > > > +{
> > > > +     const struct timestamp_expectation test_data[] = {
> > > > +             {
> > > > +                     .test_case_name = "1901-12-13",
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 0,
> > > > +                     .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "1969-12-31",
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 0,
> > > > +                     .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "1970-01-01",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 0,
> > > > +                     .expected = {0LL, 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2038-01-19",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 0,
> > > > +                     .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2038-01-19",
> > > It's quite handy if testcase names can be unique, and describe what it is
> > they are testing.
> > >
> > > If someone unfamiliar with this test looks at the results, it's nice if they can
> > > intuit what it was that went wrong, based on the test case name.
> > >
> > > IMHO these names are too short and not descriptive enough.
> >
> > The test cases are pretty much 1:1 to the examples table referenced at
> > the top comment of the file. Would it help if I move the reference
> > comment closer to the test case definition or would you like the test
> > name to have a reference to a table entry encoded into it?
>
> I think moving the comment to right above the testcase definitions
> would be good.  Somehow I missed that.
>
Done
> OK - I also missed the usage of the TESTCASE_NAME_FORMAT string.  This obviously
> handles the issue of the testcase names being unique, but doesn't help those not
> familiar with the test.
>
> What I'm suggesting is just a little bit of extra wording, describing in English
> what the test is checking for.  This is for people looking
> at test results who don't know the internals of the test.
>
> I'm pretty sure these are the wrong descriptions, but something like this:
>              {
>                      .test_case_name = "2038-01-19 check upper edge of 31-bit boundary",
>                      .msb_set = false,
>                      .lower_bound = false,
>                      .extra_bits = 0,
>                      .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
>              },
>              {
>                      .test_case_name = "2038-01-19 check first use of extra epoch bit",
>                      .msb_set = true,
>                      .lower_bound = true,
>                      .extra_bits = 1,
>                      .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
>              },
>
> I'm not pedantic about it.
Done
>  -- Tim
>
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 1,
> > > > +                     .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 1,
> > > > +                     .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2106-02-07",
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 1,
> > > > +                     .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2106-02-07",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 1,
> > > > +                     .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2174-02-25",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 1,
> > > > +                     .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2174-02-25",
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits =  2,
> > > > +                     .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2242-03-16",
> > > > +                     .msb_set = true,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 2,
> > > > +                     .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2242-03-16",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 2,
> > > > +                     .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = " 2310-04-04",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 2,
> > > > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = " 2310-04-04 00:00:00.1",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 6,
> > > > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2378-04-22
> > > > 00:00:00.MAX_NSEC",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 0xFFFFFFFF,
> > > > +                     .expected = {.tv_sec = 0x300000000LL,
> > > > +                                  .tv_nsec = MAX_NANOSECONDS},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2378-04-22",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = true,
> > > > +                     .extra_bits = 3,
> > > > +                     .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> > > > +             },
> > > > +
> > > > +             {
> > > > +                     .test_case_name = "2446-05-10",
> > > > +                     .msb_set = false,
> > > > +                     .lower_bound = false,
> > > > +                     .extra_bits = 3,
> > > > +                     .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> > > > +             }
> > > > +     };
> > > > +
> > > > +     struct timespec64 timestamp;
> > > > +     int i;
> > > > +
> > > > +     for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> > > > +             timestamp.tv_sec = get_32bit_time(&test_data[i]);
> > > > +             ext4_decode_extra_time(&timestamp,
> > > > +                                    cpu_to_le32(test_data[i].extra_bits));
> > > > +
> > > > +             KUNIT_EXPECT_EQ_MSG(test,
> > > > +                                 test_data[i].expected.tv_sec,
> > > > +                                 timestamp.tv_sec,
> > > > +                                 CASE_NAME_FORMAT,
> > > > +                                 test_data[i].test_case_name,
> > > > +                                 test_data[i].msb_set,
> > > > +                                 test_data[i].lower_bound,
> > > > +                                 test_data[i].extra_bits);
> > > > +             KUNIT_EXPECT_EQ_MSG(test,
> > > > +                                 test_data[i].expected.tv_nsec,
> > > > +                                 timestamp.tv_nsec,
> > > > +                                 CASE_NAME_FORMAT,
> > > > +                                 test_data[i].test_case_name,
> > > > +                                 test_data[i].msb_set,
> > > > +                                 test_data[i].lower_bound,
> > > > +                                 test_data[i].extra_bits);
> > > > +     }
> > > > +}
> > > > +
> > > > +static struct kunit_case ext4_inode_test_cases[] = {
> > > > +     KUNIT_CASE(inode_test_xtimestamp_decoding),
> > > > +     {}
> > > > +};
> > > > +
> > > > +static struct kunit_suite ext4_inode_test_suite = {
> > > > +     .name = "ext4_inode_test",
> > > > +     .test_cases = ext4_inode_test_cases,
> > > > +};
> > > > +
> > > > +kunit_test_suite(ext4_inode_test_suite);
> > > > --
> > > > 2.23.0.700.g56cf767bdb-goog
