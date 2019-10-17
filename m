Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124D9DB991
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441599AbfJQWNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:13:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37084 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441598AbfJQWNV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:13:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so3433362qkd.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGRp1NkdHcRw6WFg1pBJId47k16SUh3xOAnfmA59fiQ=;
        b=jQpr5VRhoEtmfQkJXhCkPKTC0ulLSz0LuLt+9IO5N2gL7LUgQYSg3hy+2GcSJKx8nn
         XzRDwDK/9ZeDK/CtPh8KVZfaotK/SeeAsJnaD/tgjgjU8jmzww33rnntyu1CKw1JNlY6
         6zDZKa6xbc8Z7zspfh9QxWtH1esOyWjBm8PZJN/xiwuFMfRKYCv6tBPeff1xJmJPwzox
         1bOvJee4HYKF2kP/IEpgF3moeZtTKY85sxWCt9UHF5wbnKHpcnOGE9k2WnJn+Mh18M4Z
         OUB+pwkpRmfN+pNjcAqy0yMMdq+uNycvkUnXUAcwzdPLpFdRybkAQwPErmX62p+nKFBY
         0ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGRp1NkdHcRw6WFg1pBJId47k16SUh3xOAnfmA59fiQ=;
        b=KGKdW9lHsh9gecj7bzypyChSXju7Fwn+LriXeKC/sF4vgOFaj06T7u4gG8evQ6O+gv
         1TXPeYihHHCklKxJr4uI8Ec7KyYOfnXPL8pL5F6+KOfoECGAxDzbQosCp3j34s6Rec29
         lD73NaKt4jIhHTE9GRY4+zRjh7Nn1PjN4nOdS41JSVMLLVBdWMA7iTEdWjScPZtmvie2
         8srJm9qxg8tl45Fbuhol2PjpyK9ycT1hPehgiwiSZATRKZCFuzBlNpT9PcKd7HUasbqo
         uDCWMnaYRd/1oLQR6LXI3WlJzVp5HMKn/hpv18GaCBqI9GesME0GIWfnD0sbio5otg46
         flXg==
X-Gm-Message-State: APjAAAWSrCKMWFU51HBz4ztaLLSRkW3bOAIUyjJZezDJLUd48S8HBiel
        hjbNkvBaLSxa9QtvmZABxNQbMh/qsMLdY10BJQcG
X-Google-Smtp-Source: APXvYqzWhYtL0s7teNh5ygvWVeW8I7sg2LBrj3MOVVpjUa38qS5XvDvi9Mx+nkjkbyUpHxvVL9vqpXa+OAFn6/LQnPA=
X-Received: by 2002:ae9:f210:: with SMTP id m16mr3075793qkg.121.1571350399772;
 Thu, 17 Oct 2019 15:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191016212935.215310-1-yzaikin@google.com> <f87c91bd-5ebb-d259-ff80-385e2db342b1@linuxfoundation.org>
In-Reply-To: <f87c91bd-5ebb-d259-ff80-385e2db342b1@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 15:12:43 -0700
Message-ID: <CAAXuY3oK-nZ39RSfaO8uR0=QZkkTTxSv0L8SWOk-9_1kDxzApg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v5] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 5:10 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Lurii,
>
> On 10/16/19 3:29 PM, Iurii Zaikin wrote:
> > KUnit tests for decoding extended 64 bit timestamps
> > that verify the seconds part of [a/c/m]
> > timestamps in ext4 inode structs are decoded correctly.
>
> Add a blank line here. Also can you make these close 75 char long.
> It will be easier to read the commit log.
>
>
Done. Went with Theodore's suggestion which incorporates your feedback.
> > KUnit tests, which run on boot and output
>
>   run during boot?
>
Done
> > the results to the debug log in TAP format (http://testanything.org/).
>
> Break this sentence here.
>
Done
> > are only useful for kernel devs running KUnit test harness. Not for
> > inclusion into a production build.
>
> I like the way you state clearly that these aren't for production
> build. Thanks for this detail.
>
> > Test data is derived from the table under
> > Documentation/filesystems/ext4/inodes.rst Inode Timestamps.
>
> Reads a bit funny. Please rephrase.
>
>
> Test data is derived from the Inode Timestamps table under
> Documentation/filesystems/ext4/inodes.rst
>
Done. Went with Theordore's wording.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >   fs/ext4/Kconfig      |  14 +++
> >   fs/ext4/Makefile     |   1 +
> >   fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 254 insertions(+)
> >   create mode 100644 fs/ext4/inode-test.c
> >
> > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > index cbb5ca830e57..f13dde8ed92b 100644
> > --- a/fs/ext4/Kconfig
> > +++ b/fs/ext4/Kconfig
> > @@ -106,3 +106,17 @@ config EXT4_DEBUG
> >         If you select Y here, then you will be able to turn on debugging
> >         with a command such as:
> >               echo 1 > /sys/module/ext4/parameters/mballoc_debug
> > +
> > +config EXT4_KUNIT_TESTS
> > +     bool "KUnit tests for ext4"
> > +     select EXT4_FS
> > +     depends on KUNIT
> > +     help
> > +       This builds the ext4 KUnit tests, which run on boot and output
> > +       the results to the debug log in TAP format (http://testanything.org/).
> > +       Only useful for kernel devs running KUnit test harness. Not for
> > +       inclusion into a production build.
>
> Please apply the same changes you made to commit log here.
>
Changed the applicable paragraphs to match description. Note that the commit
description is more specific than the config option description due to
Theodore's
preference for the single config option controlling all of ext4 tests.
> > +       For more information on KUnit and unit tests in general please refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +       If unsure, say N.
> > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > index b17ddc229ac5..840b91d040f1 100644
> > --- a/fs/ext4/Makefile
> > +++ b/fs/ext4/Makefile
> > @@ -13,4 +13,5 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> >
> >   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)    += acl.o
> >   ext4-$(CONFIG_EXT4_FS_SECURITY)             += xattr_security.o
> > +ext4-$(CONFIG_EXT4_KUNIT_TESTS)              += inode-test.o
> >   ext4-$(CONFIG_FS_VERITY)            += verity.o
> > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > new file mode 100644
> > index 000000000000..1f2c486bc1c2
> > --- /dev/null
> > +++ b/fs/ext4/inode-test.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> > + * timestamps in ext4 inode structs are decoded correctly.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/kernel.h>
> > +#include <linux/time64.h>
> > +
> > +#include "ext4.h"
> > +
>
> Please add a comment to say what these defines are for.
>
Done.
> > +/* binary: 00000000 00000000 00000000 00000000 */
> > +#define LOWER_MSB_0 0L
> > +/* binary: 01111111 11111111 11111111 11111111 */
> > +#define UPPER_MSB_0 0x7fffffffL
> > +/* binary: 10000000 00000000 00000000 00000000 */
> > +#define LOWER_MSB_1 (-0x80000000L)
> > +/* binary: 11111111 11111111 11111111 11111111 */
> > +#define UPPER_MSB_1 (-1L)
> > +/* binary: 00111111 11111111 11111111 11111111 */
> > +#define MAX_NANOSECONDS ((1L << 30) - 1)
> > +
> > +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
> > +
> > +struct timestamp_expectation {
> > +     const char *test_case_name;
> > +     struct timespec64 expected;
> > +     u32 extra_bits;
> > +     bool msb_set;
> > +     bool lower_bound;
> > +};
> > +
> > +static time64_t get_32bit_time(const struct timestamp_expectation * const test)
> > +{
> > +     if (test->msb_set) {
> > +             if (test->lower_bound)
> > +                     return LOWER_MSB_1;
> > +
> > +             return UPPER_MSB_1;
> > +     }
> > +
> > +     if (test->lower_bound)
> > +             return LOWER_MSB_0;
> > +     return UPPER_MSB_0;
> > +}
> > +
> > +
> > +/*
> > + * These tests are derived from the table under
> > + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
>
> Rephrase this please. Reads a bit funny.
>
Done.
> > + */
> > +static void inode_test_xtimestamp_decoding(struct kunit *test)
> > +{
> > +     const struct timestamp_expectation test_data[] = {
> > +             {
> > +                     .test_case_name =
> > +             "1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits",
>
> Please make these defines and use name here. Makes it easier to read
> and you can also avoid this weird lining up with {
>
Done for all test case names.
>
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +             "1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits",
>
> Same here.
>
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +             "1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits",
>
> Same here.
>
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0,
> > +                     .expected = {0LL, 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +             "2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits",
>
> Same here and all the strings below.
>
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +     "2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on",
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +     "2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on",
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +       "2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +       "2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +       "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on",
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits =  2,
> > +                     .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +       "2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on",
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +     "2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +       "2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 6,
> > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. ns bits 1",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0xFFFFFFFF,
> > +                     .expected = {.tv_sec = 0x300000000LL,
> > +                                  .tv_nsec = MAX_NANOSECONDS},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +      "2378-04-22 Lower bound of 32bit >= timestamp. All extra sec bits on",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 3,
> > +                     .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name =
> > +     "2446-05-10 Upper bound of 32bit >= timestamp. All extra sec bits on",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 3,
> > +                     .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> > +             }
> > +     };
> > +
> > +     struct timespec64 timestamp;
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> > +             timestamp.tv_sec = get_32bit_time(&test_data[i]);
> > +             ext4_decode_extra_time(&timestamp,
> > +                                    cpu_to_le32(test_data[i].extra_bits));
> > +
> > +             KUNIT_EXPECT_EQ_MSG(test,
> > +                                 test_data[i].expected.tv_sec,
> > +                                 timestamp.tv_sec,
> > +                                 CASE_NAME_FORMAT,
> > +                                 test_data[i].test_case_name,
> > +                                 test_data[i].msb_set,
> > +                                 test_data[i].lower_bound,
> > +                                 test_data[i].extra_bits);
> > +             KUNIT_EXPECT_EQ_MSG(test,
> > +                                 test_data[i].expected.tv_nsec,
> > +                                 timestamp.tv_nsec,
> > +                                 CASE_NAME_FORMAT,
> > +                                 test_data[i].test_case_name,
> > +                                 test_data[i].msb_set,
> > +                                 test_data[i].lower_bound,
> > +                                 test_data[i].extra_bits);
> > +     }
> > +}
> > +
> > +static struct kunit_case ext4_inode_test_cases[] = {
> > +     KUNIT_CASE(inode_test_xtimestamp_decoding),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite ext4_inode_test_suite = {
> > +     .name = "ext4_inode_test",
> > +     .test_cases = ext4_inode_test_cases,
> > +};
> > +
> > +kunit_test_suite(ext4_inode_test_suite);
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
>
> thanks,
> -- Shuah
