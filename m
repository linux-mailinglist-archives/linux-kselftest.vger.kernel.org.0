Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE53A1564
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhFINXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 09:23:33 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:59554 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhFINXd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 09:23:33 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id A1995B0026B; Wed,  9 Jun 2021 15:21:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id A0782B000A9;
        Wed,  9 Jun 2021 15:21:37 +0200 (CEST)
Date:   Wed, 9 Jun 2021 15:21:37 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Oliver Glitta <glittao@gmail.com>
cc:     brendanhiggins@google.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: add documentation for SLUB cache kunit tests
In-Reply-To: <20210608084740.6282-1-glittao@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2106091512160.60148@gentwo.de>
References: <20210608084740.6282-1-glittao@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some spelling fixes below but it got a bit much when looking through this.
Maybe rewrite this again for clarity?


On Tue, 8 Jun 2021, glittao@gmail.com wrote:

> +KUnit tests for SLUB debugging functionality
> +============================================
> +
> +These KUnit tests are used to test some of the SLUB debugging
> +functionalities.
functionality.

> +
> +KUnit tests are used for unit testing in Linux kernel and easy to run,
> +so it is probably the best choice for this type of tests.
> +
> +There are tests, which corrupt redzone, the free objects and the freelist.
> +Tests are corrupting specific bytes in cache and checking if validation
> +finds expected number of bugs. Bug reports are silenced.
"in a SLUB cache"  .... or "in a cache"

finds *the* expected number of ...

> +In order to built and then run this tests you need to switch
> +option SLUB_KUNIT_TEST on. It is tristate option so it can also
*the* option
*a* tristate option

> +be built as a module. This option depends on SLUB_DEBUG and
> +KUNIT options. By default it is on with all kunit tests.
> +
> +Error counting
> +
> +To get number of errors discovered in slub is used test API kunit_resource.

What does that mean?

> +In test_init the reference to the integer variable slab_errors is added
> +to the resource of this tests.
> +
> +During slub cache checking always when bug should be reported or fixed function
> +slab_add_kunit_errors() is called. This function find resource to kunit test
> +and increment value of data in founded resource, which is slab_errors
> +variable.

??

> +
> +Silence bug reports
> +
> +The function slab_add_kunit_errors() is returning bool, which is true if there is kunit test
> +with correct kunit_resource running, to silence bug reports, so they are not printed.
> +We do not want to correct errors we only want to know they occurred, so these reports
> +are unnnecessary.

These reports are unnecessary because we do not want to correct errors. We
only want to know that they occurred.

> +
> +KASAN option
> +
> +Only 2 out of 5 tests are runnig with KASAN option is on.

running

> +The other three tests deliberately modifies non-allocated objects. And KASAN

modify

> +does not detect some errors in the same way as SLUB_DEBUG. So, these tests
> +does not run when KASAN option is on.

do

> +1. test_clobber_zone
> +
> +   SLUB cache with SLUB_REDZONE flag can detects writings after object. This
> +   functionality is tested here on allocated memory.

... can detect modifying memory locations after the object.

> +
> +   First, there is allocated memory with SLAB_REDZONE and then the first byte
> +   after allocated space is modified. Validation founds 2 errors, because of
> +   the bug and the fix of the memory.

after *the* allocated space. The validation finds 2 errors. One is the
fact that there is a corrupted redzone and the second due to the repair of
the redzone.

> +2. test_next_pointer
> +
> +   SLUB have list of free objects and the address of the next free object
> +   is always saved in free object at offset specified in variable offset
> +   in struct kmem_cache. This test try to corrupt this freelist and
> +   then correct it.

SLUB *has a* .... is ** saved in a *freed object* at *the* offset ...

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
