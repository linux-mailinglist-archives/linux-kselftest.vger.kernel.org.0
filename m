Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF5D2EC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfJJQps (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 12:45:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42737 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJQps (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 12:45:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so6193212qkl.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nj4bBE3BvV1UZmyzEaSgOKADKX40E4zF9+r4XI1/Wek=;
        b=Os7EBDKXyoW+fAsiMGwPkWaJKN2cj791yXW0+gXvda4+hk83J5H5/ZcsiVWlPHzE8u
         OuR5IUq73yjlijc8EoLnLvfYRkNyosO8FqSmPCZiAE4m+JEk9UPy9AFxxgJBv/DyrsgU
         S/GAT1PB+FmZYVCC/JzXR4KeCc+N311tjGLqKjIKIUhdZDOM5iInPA1pPVsqCkUM6O6v
         xBEdrwKc/YLkutH+oTv+8w8vMEpeJPVJP61ws38FeL7W/NnruWKDjRvNw1nt/pCzg5WQ
         JGAFxKJeqGoLmTEFd1x8kPodcFsonn9FWsNvbzvbwNtkJgNy/woTYAZBPSLHiRE275jZ
         Bqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nj4bBE3BvV1UZmyzEaSgOKADKX40E4zF9+r4XI1/Wek=;
        b=QcX9GaG1dlmwQwNIY0Itt1PHI2nUM7UG6cdtlSrcmL6Md16q2oVmZwbLIDvBJ/295T
         7aCRcRPNp51BPqnzpa2ZI2kaOokL3c5MlyQkT+ngcrZLJYK3l5lXhMHtBSPDN5QLlbxA
         g1n9M3b2n7iT4yH1Ia1lHfrx4mZ4vtYeFA/ja2UkmaXHMqnRaLW9CsynKqsQQDIkeaqk
         Wy/AitNgjzITSeZRTEmzWE5JL/OOJcq9us/qpkblxFqJ90+LT+FkyIq5jlpUd0lksKD1
         XctfDOL+1q8EBEHv6JrA6iSoPr0LSGQLPW4P4ktGCpI3GGWjZU7wqXeN+jpBqQ1g47PG
         mYGw==
X-Gm-Message-State: APjAAAUUO5EKTKopQVYmnVo2tEDLYbzy/5Its8DwFE7fOM4KzUglk4tx
        hFMTXD2zi8D1aNOe9GNiQyZ/NIcF8pXtbI9x0xeLXVU=
X-Google-Smtp-Source: APXvYqzNNtlA3inul5Iqv5pB+oARi4Ks+TQRGWB0sy3UY/cN0R4wyNPc5/Z1sHW3QqssHcQt+uX4n2nD6C7DbKbXeR8=
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr10633675qkl.393.1570725947085;
 Thu, 10 Oct 2019 09:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <ECADFF3FD767C149AD96A924E7EA6EAF977C135F@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977C135F@USCULXMSG01.am.sony.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 10 Oct 2019 09:45:09 -0700
Message-ID: <CAAXuY3rk8_Eu_09jGbE66irtnjFzz4=6RxmZ6eMpBLdqpo5xfw@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 8:47 PM <Tim.Bird@sony.com> wrote:
>
>
> > -----Original Message-----
> > From Iurii Zaikin on Wednesday, October 09, 2019 4:40 PM
> >
> > KUnit tests for decoding extended 64 bit timestamps.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > ---
> >  fs/ext4/Kconfig      |  12 +++
> >  fs/ext4/Makefile     |   1 +
> >  fs/ext4/inode-test.c | 221
> > +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 234 insertions(+)
> >  create mode 100644 fs/ext4/inode-test.c
> >
> > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > index cbb5ca830e57..cb0b52753674 100644
> > --- a/fs/ext4/Kconfig
> > +++ b/fs/ext4/Kconfig
> > @@ -106,3 +106,15 @@ config EXT4_DEBUG
> >         If you select Y here, then you will be able to turn on debugging
> >         with a command such as:
> >               echo 1 > /sys/module/ext4/parameters/mballoc_debug
> > +
> > +config EXT4_KUNIT_TESTS
> > +     bool "KUnit test for ext4 inode"
> > +     depends on EXT4_FS
> > +     depends on KUNIT
> > +     help
> > +       This builds the ext4 inode sysctl unit test, which runs on boot.
> > +       Tests the encoding correctness of ext4 inode.
> > +       For more information on KUnit and unit tests in general please refer
> > +       to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +       If unsure, say N.
> > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > index b17ddc229ac5..a0588fd2eea6 100644
> > --- a/fs/ext4/Makefile
> > +++ b/fs/ext4/Makefile
> > @@ -13,4 +13,5 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o
> > ext4_jbd2.o extents.o \
> >
> >  ext4-$(CONFIG_EXT4_FS_POSIX_ACL)     += acl.o
> >  ext4-$(CONFIG_EXT4_FS_SECURITY)              += xattr_security.o
> > +ext4-$(CONFIG_EXT4_KUNIT_TESTS)      += inode-test.o
> >  ext4-$(CONFIG_FS_VERITY)             += verity.o
> > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > new file mode 100644
> > index 000000000000..43bc6cb547cd
> > --- /dev/null
> > +++ b/fs/ext4/inode-test.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
> > + * timestamps in ext4 inode structs are decoded correctly.
> > + * These tests are derived from the table under
> > + * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/kernel.h>
> > +#include <linux/time64.h>
> > +
> > +#include "ext4.h"
> > +
> > +/* binary: 00000000 00000000 00000000 00000000 */
> > +#define LOWER_MSB_0 0L
> > +/* binary: 01111111 11111111 11111111 11111111 */
> > +#define UPPER_MSB_0 0x7fffffffL
> > +/* binary: 10000000 00000000 00000000 00000000 */
> > +#define LOWER_MSB_1 (-0x80000000L)
> > +/* binary: 11111111 11111111 11111111 11111111 */
> > +#define UPPER_MSB_1 (-1L)
> > +/* binary: 00111111   11111111 11111111 11111111 */
> > +#define MAX_NANOSECONDS ((1L << 30) - 1)
> > +
> > +#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits:
> > %x"
> > +
> > +struct timestamp_expectation {
> > +     const char *test_case_name;
> > +     struct timespec64 expected;
> > +     u32 extra_bits;
> > +     bool msb_set;
> > +     bool lower_bound;
> > +};
> > +
> > +static time64_t get_32bit_time(const struct timestamp_expectation * const
> > test)
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
> > +static void inode_test_xtimestamp_decoding(struct kunit *test)
> > +{
> > +     const struct timestamp_expectation test_data[] = {
> > +             {
> > +                     .test_case_name = "1901-12-13",
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "1969-12-31",
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "1970-01-01",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0,
> > +                     .expected = {0LL, 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2038-01-19",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2038-01-19",
> It's quite handy if testcase names can be unique, and describe what it is they are testing.
>
> If someone unfamiliar with this test looks at the results, it's nice if they can
> intuit what it was that went wrong, based on the test case name.
>
> IMHO these names are too short and not descriptive enough.
The test cases are pretty much 1:1 to the examples table referenced at
the top comment of the file. Would it help if I move the reference
comment closer to the test case definition or would you like the test
name to have a reference to a table entry encoded into it?
>  -- Tim
>
>
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2106-02-07",
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2106-02-07",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2174-02-25",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 1,
> > +                     .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2174-02-25",
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits =  2,
> > +                     .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2242-03-16",
> > +                     .msb_set = true,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2242-03-16",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = " 2310-04-04",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 2,
> > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = " 2310-04-04 00:00:00.1",
> > +                     .msb_set = false,
> > +                     .lower_bound = false,
> > +                     .extra_bits = 6,
> > +                     .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2378-04-22
> > 00:00:00.MAX_NSEC",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0xFFFFFFFF,
> > +                     .expected = {.tv_sec = 0x300000000LL,
> > +                                  .tv_nsec = MAX_NANOSECONDS},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2378-04-22",
> > +                     .msb_set = false,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 3,
> > +                     .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> > +             },
> > +
> > +             {
> > +                     .test_case_name = "2446-05-10",
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
> > 2.23.0.700.g56cf767bdb-goog
