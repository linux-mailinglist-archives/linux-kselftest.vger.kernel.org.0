Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA13D33CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJJWOT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 18:14:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39426 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJWOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 18:14:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so7107259qki.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axqXitUpZQzPW9NNcvtsJ/Fag1zSuFDupbs5adqeHAY=;
        b=mvGXyxsF2hMezJhsi7moeSj8D+ZPCuql58FjUcK0kqkhSwILlRoIZv+ZsxEXJrYDtT
         jst4zvTFG01K7vEkAS1KgQR8i4+NLzxkvwEapssrORSwxM2THM5JPz2/+kQRBkoKt12w
         97nq43kXSV9ArWnFbLANlz2zSWfeI+F6o0r3RjfB5zK52wiFRYq5v8Pq0GxOlWCI/Ab5
         6dPnSTfZ22VmDmjizA356TU41fPFxFmnGBjA0tk6RtU/MbQDiV2EhPV3NTa/KCFMdnYI
         hXxgdG7ws8shrdB8098QL8w1KoS7MDNiXG0CUOpNQUzS4Fr6rRaEzveqhpTJNn48wzog
         5BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axqXitUpZQzPW9NNcvtsJ/Fag1zSuFDupbs5adqeHAY=;
        b=NtO/yMhA/uV5nlpIwkxZX5WZcVR3AOwkHWsxV0k3hQHv0OSuSvUA5yCPnuGXK4tLLx
         0lsx/bGquwrQ5nfXOTVLcjTDBb2BBOwD8DSYZDs9gVha4Lj3AdWCj3aErD3xa6D+FcBW
         /8mEgeycDa210swwhFuH4onIK6eesmdjDs7SjYLGDk7ToZ7bBTUyHkmTdDea9hi8ZauA
         fdKK2oj6gQiJ//FtfE/BoSwaLMopTqFWnNUPwf1fb5L74Kb57z8lyLjj66JgieGnc+CJ
         q4s9pnMFzg0gy6oG4VPv/SHsnez1lj8PcXAwdjxsqHZ2o1+2StiNhJkod5xf7l1x2rRI
         lxcg==
X-Gm-Message-State: APjAAAXd89M1YtVN0+AtmtO+Ap6jv8PnhJBtetmQ1Nitc4Yi5/dwL9k8
        pavd+N0T1qWHpFRZqvcVkXegUutEZva4PkSOYwuL
X-Google-Smtp-Source: APXvYqzeStFXF/rIjaxV9IGoXG9xmVSRwwbd8DHMoeoL3vhcAF7r8sqhrF+9rglt4no30sm21jILw9Ulj8m7XzrI0YE=
X-Received: by 2002:a05:620a:2193:: with SMTP id g19mr12739515qka.184.1570745657502;
 Thu, 10 Oct 2019 15:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
In-Reply-To: <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 10 Oct 2019 15:13:41 -0700
Message-ID: <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 10:11 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/9/19 8:39 PM, Iurii Zaikin wrote:
> > KUnit tests for decoding extended 64 bit timestamps.
> >
> "Added the link to the ext4 docs from which the tests were derived."
>
> Document reference is great. I would still like to see summary
> in the commit log.
>
> As you said below:
>
> "This builds the ext4 inode sysctl unit test, which runs on boot."
>
> Also include what should user expect to see when one of these fails.
Will do.
>
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > ---
> >   fs/ext4/Kconfig      |  12 +++
> >   fs/ext4/Makefile     |   1 +
> >   fs/ext4/inode-test.c | 221 +++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 234 insertions(+)
> >   create mode 100644 fs/ext4/inode-test.c
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
>
> Please add Documentation/filesystems/ext4/inodes.rst Inode Timestamps
> here as well.
> Yeah. Especially after looking at the document, summary of what these
> test(s) is definitely helpful. You can't expect users to read the
> document before enabling it. Please write a summary of tests and what
> they do and add it here and then in the commit log. Also include what
> user should expect when they pass and when one of them fails.
>
I'm not sure this is compatible with Theodore's preference for having a single
config option for all ext4 tests. If anything, I should be removing
all inode-specific
stuff from the description.
I think it makes sense to add wording that this option is only useful
for devs running
a kernel test harness and should not be enabled in production.
> > +
> > +       If unsure, say N.
> > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > index b17ddc229ac5..a0588fd2eea6 100644
> > --- a/fs/ext4/Makefile
> > +++ b/fs/ext4/Makefile
> > @@ -13,4 +13,5 @@ ext4-y      := balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
> >
> >   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)    += acl.o
> >   ext4-$(CONFIG_EXT4_FS_SECURITY)             += xattr_security.o
> > +ext4-$(CONFIG_EXT4_KUNIT_TESTS)      += inode-test.o
> >   ext4-$(CONFIG_FS_VERITY)            += verity.o
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
>
> Yeah. Especially after looking at the document, summary of what these
> test(s) is definitely helpful. You can't expect users to read the
> document before enabling the tests.
>
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
> > +                     .test_case_name = "2378-04-22 00:00:00.MAX_NSEC",
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
>
> Is there a way to make the test data dynamic. Can you read from a data
> file? It will be easier to if the data
>
> Maybe this is question to Brendan?
>
From the general unit test philosophy, unit tests must be 100% deterministic,
repeatable and simple enough to be correct by visual inspection, dynamically
generated test data runs contrary to these goals IMHO.
As for reading from a data file, not sure what exactly you mean here:
 - Having a running kernel read a file in the filesystem, especially as early in
the initialization process as KUnit currently runs is something I'm not sure
how to implement reliably. Also, doing I/O in the tests will make them slower
and require more setup from test running environment.
- Having reading a file in the build stage and linking it as a data
blob into the
kernel image. This approach looks better to me since it avoids the I/O and has
no noticeable speed penalty or test harness requirements. It would be up to
Brendan whether he wants such capability in KUnit and based on the user-space
test code I've seen so far, the number of test data points in this
test doesn't warrant
reading from files even in userspace which has far fewer constraints.
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
> >
>
> thanks,
> -- Shuah
