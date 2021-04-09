Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04BC35A35E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhDIQ3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhDIQ3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 12:29:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A5AC061761
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Apr 2021 09:29:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x17so6512298iog.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Apr 2021 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbUK7UuZXTiha9THCq0CsZWhhZsM7W4Qq19KgIJbtgE=;
        b=h+OjIaVgd72KP23hcGzaNnj5C6ltyypnWlViECgf37wsnHcmArWRt/QOBi8xO70/A4
         s+fj0rXFue25P2/TpbT9a+fYgEMEpHaIiKnB4t+1sMtyT75aNXTTlFGX7Zg5QaKG3Mk6
         8EsdWMwY5XdZciE89sLyZ8HOKhmtEiwl0qjSiXGZrVQ14tg+dnw4JeyjljEmrWCx8cvI
         BFLUx4x9lm6qUhLBzCDh1xlnTmEFtYCK/MZi/kSg9OTUlixz7isDqnhAoqBxjuNS4rKN
         s+f/KOnK2mMBy5S/THxYodNC0WbvsIw6mmWdPTCgcuV4/rZf5NjoYgVmfQYQP/ocxgDO
         KMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbUK7UuZXTiha9THCq0CsZWhhZsM7W4Qq19KgIJbtgE=;
        b=qWVs1ohBJGVqDqLEVCVY1aqcbmSqax52Ahqm40/44fr1KWgOsAhM3XPkpqRCQoHtAP
         yUMapCbj4R0yg66gUeIhqtOTCncJIkQTZxFlZZ6iqs/9j2GRrPQ4rmRfWne6EE2TATZp
         t66Y/DdkzGex8E7WLHERvfKbRnL18jyETY9LfVgq3amC9+0wj5+Vo4B3/94XfTJujolA
         227jpcVqDcxyMiiLrYZFKxk2b7U19qiIeIhVG2CnF/NNiAK1jwh7MnI9JIUXknoQB3a0
         j6XtRAF42snmJB4TomwdDggRZfdtFOarAsef2fVAGmVwgwzmBAE33tg2oPz3zYX2lrLE
         84OQ==
X-Gm-Message-State: AOAM532nPBueFnpWHVeg5ZIPYNFPNYkvNYuKChkkjYsWjL4NeafEZcFO
        7r3bA7BEF0q+37ZnJcx0cq1811+vn7j99wwrN9vbyw==
X-Google-Smtp-Source: ABdhPJxJ2yCk9sU6ZHRHklOXDyRUcgWoYnG2ga9U+unMLX61flbc5GB7IkxuugYQ+2FPNoKakQvNzLckD20LkzKsCnQ=
X-Received: by 2002:a05:6638:371e:: with SMTP id k30mr15362345jav.4.1617985762163;
 Fri, 09 Apr 2021 09:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210409014001.2946212-1-dlatypov@google.com> <YHBzA7SwH194ywRv@smile.fi.intel.com>
In-Reply-To: <YHBzA7SwH194ywRv@smile.fi.intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 9 Apr 2021 09:29:10 -0700
Message-ID: <CAGS_qxr0=nvQb787SURuVN7G-M9BdMR800FtwR3YAkFxQgPf5w@mail.gmail.com>
Subject: Re: [PATCH v4] lib: add basic KUnit test for lib/math
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 9, 2021 at 8:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 08, 2021 at 06:40:01PM -0700, Daniel Latypov wrote:
> > Add basic test coverage for files that don't require any config options:
> > * gcd.c
> > * lcm.c
> > * int_sqrt.c
> > * reciprocal_div.c
> > (Ignored int_pow.c since it's a simple textbook algorithm.)
>
> What about adding math.h test cases?
>
> We have some macros there and it might be a good idea to test them, for example
> that round_up() and roundup() produces the same output for the same (power of
> two divisor) input.

I completely overlooked the macros in math.h, sounds like a good idea.

Grepping around, seems like abs() and DIV_ROUND_UP/CLOSEST() are among
the more popular macros:
$ ag -s '\bDIV_ROUND_UP\(' | wc -l
2946
$ ag -s '\babs\(' | wc -l
923
$ ag -s '\bDIV_ROUND_CLOSEST\(' | wc -l
864
$ ag -s '\bround_up\(' | wc -l
727
$ ag -s '\broundup\(' | wc -l
620
$ ag -s '\bround_down\(' | wc -l
371
$ ag -s 'rounddown\(' | wc -l
131


>
> > These tests aren't particularly interesting, but they
> > * provide short and simple examples of parameterized tests
> > * provide a place to add tests for any new files in this dir
> > * are written so adding new test cases to cover edge cases should be easy
>
> Yes, that's why I think macros also can be a good example how to test *macro*.

Yeah, there's more to cover there since they have a range of types
they can work on.

On another note, the parameterized test arrays all use unsigned long,
so abs() sticks out even more.
I'm thinking of something like

static void test_abs(struct kunit *test)
{
  KUNIT_EXPECT_EQ(test, abs('a'), 'a');
  KUNIT_EXPECT_EQ(test, abs(-'a'), 'a');
  ...
}

and then maybe use parameters for the other macros but also throw in
an additional test case like

static void test_div_round_up_diff_types(struct kunit *test)
{
  KUNIT_EXPECT_EQ(test, DIV_ROUND_UP((char) 42, (char) 10), (char) 4);
  KUNIT_EXPECT_EQ(test, DIV_ROUND_UP((int) 42, (int) 10), (int) 4);
  KUNIT_EXPECT_EQ(test, DIV_ROUND_UP((long) 42, (long) 10), (long) 4);
   ...
}

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/YHBzA7SwH194ywRv%40smile.fi.intel.com.
