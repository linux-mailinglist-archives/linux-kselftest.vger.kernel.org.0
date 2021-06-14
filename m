Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F483A6C88
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhFNQ7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 12:59:15 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43677 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhFNQ7O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 12:59:14 -0400
Received: by mail-io1-f42.google.com with SMTP id k16so40306642ios.10
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUwZeZE9lThBqFXb/d9fj89iQq04OGqPFkP7zLQbmok=;
        b=J0gH0UkmMve3krqAjAkspun6nf5wq4F//O0dtEdW9N/88dko1cyFjwOmyXfa+U20li
         pn/kvINOR047jANzZsVLWiej/mU8Vyryu8jKb8STEMlLUwcpdOROnN0glUFZv7akj9M8
         BThICd1j/Ib1jEZZvHHj+0o+n+q/ehe1ReF4RPlude2tRcaRvoiPBh4vg4UyfgM7qfi5
         eWzVzhWdv0HcJR4I08WamCoQlJyYTaZ3zarHCvqvrzaqf3jqzqHuuNwkfkOnUbiQqLLX
         xQ8Vh6gw8HfKtl4e8G/sPjGnClYrgoQUntYZoyPx1nzBLvk28kJ3lLKEngl4NCGbCVnY
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUwZeZE9lThBqFXb/d9fj89iQq04OGqPFkP7zLQbmok=;
        b=BP2qri68CJOlaOwow2sQzh6LqT6UFNm5aGbiLONUDBf9f7ojxBRjAG1V9ChJUJa9Di
         pywzazEu6wyyB7TMWXCCL97wKVbR0O3Yh+JFkUHeVMoWkA4bUp8VHy5XsvltLTd1/UKo
         xZIOBEt8gaaiW3mVfS+t3JWlY/15pQ6oavcHGddaZOWe6M7TbY6JKCECNGfvhlfzrpOb
         z7ieS8vDtUxsm+UI6bSWs4ycO82o8GryBXV02aOQliyf3RSOPPcza1PH7F6u3nVjDJXD
         xsWmfkT2thKVC5PnXbYBR15oAEUlEqbxAG9HSuzbuP5NR8TLqqBI8OQ1GEuOYmYL2wq3
         ZQZg==
X-Gm-Message-State: AOAM531eF/zTtBuwimTXN7L+DAxOjgKMW6n5Pi3lrFO5GFGt6rR6T1iH
        B68V6pPhRzXns2Y5T8JaSPCQCXw2Dzb4vFZLpI/k5g==
X-Google-Smtp-Source: ABdhPJwNgv4Ga4KB8pS713tbMNqTCzUAbOG9sxI5zGLcPiye/zMDZm6OnzjATpD0ZBsC08MMQxDUcWX2G9MGDb57Q9Y=
X-Received: by 2002:a05:6602:1810:: with SMTP id t16mr14797059ioh.48.1623689760679;
 Mon, 14 Jun 2021 09:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210610163959.71634-1-andrealmeid@collabora.com>
 <20210610163959.71634-2-andrealmeid@collabora.com> <20210614064205.GA29220@lst.de>
In-Reply-To: <20210614064205.GA29220@lst.de>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 14 Jun 2021 09:55:48 -0700
Message-ID: <CAGS_qxrj3S-OccPj3-7MOeR98+RASN5MGOAUXeMR9jSkSkiXXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] lib: Convert UUID runtime test to KUnit
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 13, 2021 at 11:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +config UUID_KUNIT_TEST
> > +     tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       This builds the UUID unit test.
>
> Does this first help line really add any value if we have this second
> line:
>
> > +       Tests parsing functions for UUID/GUID strings.
>
> ?
>
> > +       If unsure, say N.
>
> Not specific to this case, but IMHO we can drop this line for all kunit
> tests as it is completely obvious.
>
> > @@ -354,5 +353,6 @@ obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> >  obj-$(CONFIG_BITS_TEST) += test_bits.o
> >  obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
> > +obj-$(CONFIG_UUID_KUNIT_TEST) += test_uuid.o
>
> Another meta-comment on the kunit tests:  Wouldn't it make more sense
> to name them all as CONFIG_KUNIT_TEST_FOO to allow for easier grepping?

But putting them in a "kunit namespace" by prefixing them as such
would be misleading, IMO.
The tests live adjacent to the code they test and are owned by the
same maintainers, or at least that's the intent.

And if the goal is just to find configs, then I don't see much
difference between "config.*KUNIT_TEST" and "config KUNIT_TEST.*"

>
> > -struct test_uuid_data {
> > +struct test_data {
> >       const char *uuid;
> >       guid_t le;
> >       uuid_t be;
> >  };
> >
> > -static const struct test_uuid_data test_uuid_test_data[] = {
> > +static const struct test_data correct_data[] = {
>
> What is the reason for these renames?  Is this a pattern used for
> other kunit tests?

No, this is not a pattern.
The structs can be renamed back.

>
> > +static void uuid_correct_le(struct kunit *test)
> >  {
> > +     guid_t le;
> > +     const struct test_data *data = (const struct test_data *)(test->param_value);
>
> Overly long line.  But as far as I can tell there is no need for the
> case that causes this mess anyway given that param_value is a
> "const void *".

There is no need for the cast or the brace, yes.
This is my fault.

The documentation has both since I had thought that would make how it
works more clear:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#parameterized-testing
I don't really understand my past thought process...

>
> Same for all the other instances of this.
>
> > +static void uuid_wrong_le(struct kunit *test)
> >  {
> >       guid_t le;
> > +     const char **data = (const char **)(test->param_value);
>
> No need for the second pair of braces.  Same for various other instances.
