Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96307D9C1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 22:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfJPU7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 16:59:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40418 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfJPU7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 16:59:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so150297qte.7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k203mYRk3o9LC/V1tcpExg7VLq73MMzCZRjo2DKcdiE=;
        b=j8P+QRwlhgCn/rBxDc9fRjmj0qi32inxvje1T+yV3nFnRFUMVoQxiMnXKI+KB4qQm8
         YUxzfQh1VNL86OJW8i5uJFf8sJOt8+2FHrMb1sRyhuzuW7Jau3wYnC/gSPjEOaV4A4f8
         PvVKyp+0cyeG8Ko+mt1bcKgek8le9I4//k/FjBLc30KKSPUNmB9Hgme6l/bBduRjm73o
         CocIPvaON9MMjWAfPtwVenpzJ8JfrCOKNAU4YHgxwWsMto1Vg3RGXkhkrnjm+1xP+LGN
         Aslub47mNck2NNtg2Ecd012oVfYvR1JgQFktx640Iz0dU+rQPeh+LfJq1vSn5QU3y14s
         JO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k203mYRk3o9LC/V1tcpExg7VLq73MMzCZRjo2DKcdiE=;
        b=JAjdqgbbDEoNgiFOGOiTa0BHJ+lvOoPddm0RWZK7KeMb0khlXtk3tQxupiUzcjNeIQ
         w93aG1uCOEAQFzpu5yadSb80S5wVDlCOQqWatmc5cmdA5jA9yAPmjR8A7d9SBFTnoGxf
         RirRm1ZtK/4aZoEWoFaXUhT0MJ/vEXZhkzQhV9L7AXoXo8ZEKVqfP34F3vvvjBeX7oqu
         m2HEOIpwUnnIJhEl0T5xfQjLOmj2bFQPb9TFycDdLOzwpjbuXFQyqlpHzgsvA8T4lVAQ
         z92r08JdkE0kD15u948CtLjrG2x9eKhvseV77NH/4PrSZLfrHCpSrZ78xODrb7u16QLX
         EXcQ==
X-Gm-Message-State: APjAAAUAt8R7sGJerZyL2VgiDhCm0hr0RVHo0AiTbIIhIwJQYpY6mH/5
        vTfKf/DhZiueFwAFDs056KHHbUexZR8uQLn/8Skr
X-Google-Smtp-Source: APXvYqwBTIcfKj8CF0thwGAmKK1S9mn5Xj68w7neq/9h7rM5X+DGdnYQwEVthXBgSt38/pVc4T3cYCq6e5gmsWBmb+0=
X-Received: by 2002:ac8:610e:: with SMTP id a14mr25734qtm.189.1571259549648;
 Wed, 16 Oct 2019 13:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191012023757.172770-1-yzaikin@google.com> <20191016200304.GA49718@google.com>
In-Reply-To: <20191016200304.GA49718@google.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Wed, 16 Oct 2019 13:58:33 -0700
Message-ID: <CAAXuY3p2cwTTB29+x7hG8Ae9XeSG0dTL=phsXdSXe96eSiOXZw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v4] ext4: add kunit test for decoding
 extended timestamps
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Bird, Timothy" <Tim.Bird@sony.com>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 1:03 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Oct 11, 2019 at 07:37:57PM -0700, Iurii Zaikin wrote:
> > KUnit tests for decoding extended 64 bit timestamps
> > that verify the seconds part of [a/c/m]
> > timestamps in ext4 inode structs are decoded correctly.
> > KUnit tests, which run on boot and output
> > the results to the debug log in TAP format (http://testanything.org/).
> > are only useful for kernel devs running KUnit test harness. Not for
> > inclusion into a production build.
> > Test data is derive from the table under
> nit:                ^
> Should be:     derived from ...
>
Oops. Done.
> > Documentation/filesystems/ext4/inodes.rst Inode Timestamps.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  fs/ext4/Kconfig      |  14 +++
> >  fs/ext4/Makefile     |   1 +
> >  fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 fs/ext4/inode-test.c
> >
> [...]
> > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > new file mode 100644
> > index 000000000000..3b3a453ff382
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
> > + */
> > +static void inode_test_xtimestamp_decoding(struct kunit *test)
> > +{
> > +     const struct timestamp_expectation test_data[] = {
> > +             {
> > +                     .test_case_name =
> > +             "1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits.",
>
> nit: Maybe drop the period at the end (here and elsewhere)? Otherwise if
> the test fails you have a period right next to a colon and it looks a
> bit off.
>
Done
> > +                     .msb_set = true,
> > +                     .lower_bound = true,
> > +                     .extra_bits = 0,
> > +                     .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> > +             },
>
> Feel free to ignore my nits if you don't need to send another version.
> Also note that Ted has given a Reviewed-by on an earlier revision.
>
> Thanks!
