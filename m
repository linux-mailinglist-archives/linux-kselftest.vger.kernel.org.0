Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB33A048D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhFHThn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 15:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbhFHTfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 15:35:42 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDADC061795
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Jun 2021 12:23:02 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d1so17803461ils.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oo4r6NWe5hqiQe/8WtD+uPpZehlEoQKg56CwyOrMvuM=;
        b=uNeIedaRhdUNY+s7YulaUeZ1/gMCtWYGeiJE/2oR4yY4aP94kkwKxnOEQlWAq6ZSAi
         gfj/CYcl31klpfnJraTBSv0MBuZ7piXExYq18taa4VWqPon92cC3o9SL16Ln8fypG4//
         Yx5WSWGVQ802FKB/CBlTNewr7InB9xfPM98yu3B+IjehxZ6QxgfVyZgFu7gSTlZ5D1yn
         NrI4hfpzwUNPj0uafXOW2Zmyp8May33HY7JXJ1JpoNw/0dXrUY153hThJq14heh25x9a
         o/aSz0Cj9M54Lo7HoOmzW3y7LOUCBqzIRafFTgghYkjBaH6ckcFd7APhIuwCD8p2AJVM
         Cwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oo4r6NWe5hqiQe/8WtD+uPpZehlEoQKg56CwyOrMvuM=;
        b=b0/c951kaGgbza0PaxSwapsWu9HGz3L3MhqscCmvyC/yY+gBum6v8vXX3mkcdEJeWk
         wE/xvzn7LpoLvrY/pEWsMwrqe+epPixMWg2U2nrgbTRTfRhJB+oqs5FqbGs1HO3Hj3Vc
         Q6wxnEo60ILd51VPRcb3kCp1yGxmlBYk5pvp2kIKxIiaBj4aDl2qt7RavpunOGuoa6Fk
         SlOLYRWwlYsnxwU0scIfCvlmxTRDDL1kRbPnhwcojwMietQ9lQkmX0ES5XfphWmjQx9/
         YwqHfrug9FMbiqtDctbcYD8uWM/hiIuwqiTeoiXFD6u8bCyLQLMqe0LLSatGEiS6i48z
         q6Pg==
X-Gm-Message-State: AOAM532z/TUl6PqouYV1dw09L3a4H1uVTT1YWkb41LW9EU/AUcS8iVjc
        F4l90PWtPRKykqJqc5v9Nd88jiNwJGp5oV7mNyBwUg==
X-Google-Smtp-Source: ABdhPJwn+2U6fsz5Q7lRqLvYVMgczVTZ51xlck+7QrqKrTVCokK+Y3/qInxgdAo365FgwWz0p+uRfNKjvtQ6t8aJxAI=
X-Received: by 2002:a92:dc10:: with SMTP id t16mr19804907iln.75.1623180180558;
 Tue, 08 Jun 2021 12:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210608084740.6282-1-glittao@gmail.com>
In-Reply-To: <20210608084740.6282-1-glittao@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 8 Jun 2021 12:22:49 -0700
Message-ID: <CAGS_qxo-ddRcPbVW_iKJ6zuFUpRzx-coh1qq4xT9xK_gWr=qqg@mail.gmail.com>
Subject: Re: [PATCH] docs: add documentation for SLUB cache kunit tests
To:     glittao@gmail.com
Cc:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 8, 2021 at 1:47 AM <glittao@gmail.com> wrote:
>
> From: Oliver Glitta <glittao@gmail.com>
>
> Add documentation for a KUnit test for SLUB debugging functionality.
>
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

I'm not in the intended audience for this documentation, so I've
mainly just gone and pointed out some small spelling mistakes and some
formatting suggestions.

> ---
>  Documentation/vm/slub.rst | 104 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index 03f294a638bd..ca82fc1649ee 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -384,5 +384,109 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
>        40,60`` range will plot only samples collected between 40th and
>        60th seconds).
>
> +KUnit tests for SLUB debugging functionality
> +============================================
> +
> +These KUnit tests are used to test some of the SLUB debugging
> +functionalities.
> +
> +KUnit tests are used for unit testing in Linux kernel and easy to run,
> +so it is probably the best choice for this type of tests.

Note: if we think KUnit is worth explaining here, perhaps it's also
worth linking to KUnit documentation?

Something like
"KUnit (Documentation/dev-tools/kunit/index.rst) ..."

should work, or "See KUnit documentation (...) for more details", etc.

> +
> +There are tests, which corrupt redzone, the free objects and the freelist.
> +Tests are corrupting specific bytes in cache and checking if validation
> +finds expected number of bugs. Bug reports are silenced.
> +
> +Config option
> +
> +In order to built and then run this tests you need to switch

nit: "to build"
nit: "run these tests"

> +option SLUB_KUNIT_TEST on. It is tristate option so it can also

minor nit: s/is tristate/is a tristate

> +be built as a module. This option depends on SLUB_DEBUG and
> +KUNIT options. By default it is on with all kunit tests.

I assume this last sentence is about CONFIG_KUNIT_ALL_TESTS.
I don't think we need to document that here.

It could also mislead users as selecting CONFIG_KUNIT_ALL_TESTS=y will
not be sufficient to make the test run on its own.

> +
> +Error counting
> +
> +To get number of errors discovered in slub is used test API kunit_resource.

Nit: "To get the number"

Nit: can we use ``kunit_resource`` to format code-related terms?

Note: we can link to the API reference by including "test API
(Documentation/dev-tools/kunit/api/test.rst)"

Not sure if you saw, but this is that page:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html
Coincidentally enough, kunit_resource is the first thing shown for now :)

Note: it'd be cool if we could link to a specific section, but I
haven't checked if that's actually possible with automarkup.py, e.g.
like https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.kunit_resource


> +In test_init the reference to the integer variable slab_errors is added
> +to the resource of this tests.
> +
> +During slub cache checking always when bug should be reported or fixed function

Nit: "when a bug"

> +slab_add_kunit_errors() is called. This function find resource to kunit test
> +and increment value of data in founded resource, which is slab_errors
> +variable.
> +
> +Silence bug reports
> +
> +The function slab_add_kunit_errors() is returning bool, which is true if there is kunit test
> +with correct kunit_resource running, to silence bug reports, so they are not printed.
> +We do not want to correct errors we only want to know they occurred, so these reports
> +are unnnecessary.

nit: "unnecessary"

> +
> +KASAN option
> +
> +Only 2 out of 5 tests are runnig with KASAN option is on.

nit: "running"

> +The other three tests deliberately modifies non-allocated objects. And KASAN

nit: "other three tests ... modify"

> +does not detect some errors in the same way as SLUB_DEBUG. So, these tests
> +does not run when KASAN option is on.
> +
> +TESTS

I'm not the intended target for this doc, so feel free to ignore this
comment entirely.

Hmm, I'm not really a fan of the docs listing out each test case and
what they do.
I feel like this will get out of sync and you now are expected to read
another file to understand what the tests do.
I can see the benefit of a high-level explanation, especially if we
started having more tests scattered across multiple files, but I think
we should wait until that time comes.

So I'd personally prefer it if we converted these sections into
comments on the test cases themselves.

> +
> +1. test_clobber_zone
> +
> +   SLUB cache with SLUB_REDZONE flag can detects writings after object. This

nit: is there a missing word after "after object.", perhaps "deallocation"?
Perhaps then: "can detect writes after objection deallocation", or
more simply "can detect write-after-free errors" ?

> +   functionality is tested here on allocated memory.
> +
> +   First, there is allocated memory with SLAB_REDZONE and then the first byte
> +   after allocated space is modified. Validation founds 2 errors, because of
> +   the bug and the fix of the memory.
> +
> +
> +2. test_next_pointer
> +
> +   SLUB have list of free objects and the address of the next free object
> +   is always saved in free object at offset specified in variable offset
> +   in struct kmem_cache. This test try to corrupt this freelist and
> +   then correct it.
> +
> +   First, there is allocated and freed memory to get a pointer to free object.
> +   After that, the pointer to next free object is corrupted. The first validation finds
> +   3 errors. One for corrupted freechain, the second for the wrong count of objects
> +   in use and the third for fixing the issue. This fix only set number of objects
> +   in use to a number of all objects minus 1, because the first free object
> +   was corrupted.
> +
> +   Then the free pointer is fixed to his previous value. The second validation finds
> +   2 errors. One for the wrong count of objects in use and one for fixing this error.
> +
> +   Last validation is used to check if all errors were corrected so no error
> +   is found.
> +
> +3. test_first_word
> +
> +   SLUB cache with SLAB_POISON flag can detect poisoning free objects. This
> +   functionality is tested in this test. The test tries to corrupt
> +   the first byte in freed memory.
> +
> +   First of all, memory is allocated and freed to get a pointer to a free object
> +   and then the first byte is corrupted. After that, validation finds 2 errors,
> +   one for the bug and the other one for the fix of the memory.
> +
> +4. test_clobber_50th_byte
> +
> +   In this test SLAB_POISON functionality is tested. The test tries to
> +   corrupt the 50th byte in freed memory.
> +
> +   First, pointer to a free memory is acquired by allocating and freeing memory.
> +   Then 50th byte is corrupted and validation finds 2 errors for the bug and
> +   the fix of the memory.
> +
> +5. test_clobber_redzone_free
> +
> +   This test tests redzone functionality of SLUB cache on a freed object.
> +
> +   First, it gets pointer to the free object with allocating and freeing and
> +   then corrupts the first byte after the freed object. Validation finds
> +   2 errors for the bug and the fix of the memory.
> +
>  Christoph Lameter, May 30, 2007
>  Sergey Senozhatsky, October 23, 2015
> --
> 2.31.1.272.g89b43f80a5
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210608084740.6282-1-glittao%40gmail.com.
