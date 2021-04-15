Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D799360749
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhDOKio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 06:38:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKio (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 06:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDB0CAD09;
        Thu, 15 Apr 2021 10:38:20 +0000 (UTC)
To:     Oliver Glitta <glittao@gmail.com>, Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Latypov <dlatypov@google.com>
References: <20210413100747.4921-1-glittao@gmail.com>
 <20210413100747.4921-2-glittao@gmail.com>
 <CANpmjNOOWuiR6Lb1igX+5Lp=PwcEE7Gx5co5KeGCnGz2WxbjNQ@mail.gmail.com>
 <CAD=R=qq9fUKnD7vxayigTPUF4E=_3w-4uZwM=ym4DfqXwP3QSw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
Message-ID: <23e27bc2-2f12-d65a-b3ac-8ecb7a37a8c1@suse.cz>
Date:   Thu, 15 Apr 2021 12:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=R=qq9fUKnD7vxayigTPUF4E=_3w-4uZwM=ym4DfqXwP3QSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/15/21 12:10 PM, Oliver Glitta wrote:
> ut 13. 4. 2021 o 15:54 Marco Elver <elver@google.com> napísal(a):
>>
>> On Tue, 13 Apr 2021 at 12:07, <glittao@gmail.com> wrote:
>> > From: Oliver Glitta <glittao@gmail.com>
>> >
>> > SLUB has resiliency_test() function which is hidden behind #ifdef
>> > SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
>> > runs it. KUnit should be a proper replacement for it.
>> >
>> > Try changing byte in redzone after allocation and changing
>> > pointer to next free node, first byte, 50th byte and redzone
>> > byte. Check if validation finds errors.
>> >
>> > There are several differences from the original resiliency test:
>> > Tests create own caches with known state instead of corrupting
>> > shared kmalloc caches.
>> >
>> > The corruption of freepointer uses correct offset, the original
>> > resiliency test got broken with freepointer changes.
>> >
>> > Scratch changing random byte test, because it does not have
>> > meaning in this form where we need deterministic results.
>> >
>> > Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
>> > Because the test deliberatly modifies non-allocated objects, it depends on
>> > !KASAN which would have otherwise prevented that.
>>
>> Hmm, did the test fail with KASAN? Is it possible to skip the tests
>> and still run a subset of tests with KASAN? It'd be nice if we could
>> run some of these tests with KASAN as well.
>>
>> > Use kunit_resource to count errors in cache and silence bug reports.
>> > Count error whenever slab_bug() or slab_fix() is called or when
>> > the count of pages is wrong.
>> >
>> > Signed-off-by: Oliver Glitta <glittao@gmail.com>
>>
>> Reviewed-by: Marco Elver <elver@google.com>
>>
> 
> Thank you.
> 
>> Thanks, this all looks good to me. But perhaps do test what works with
>> KASAN, to see if you need the !KASAN constraint for all cases.
> 
> I tried to run tests with KASAN functionality disabled with function
> kasan_disable_current() and three of the tests failed with wrong
> errors counts.
> So I add the !KASAN constraint for all tests, because the merge window
> is coming, we want to know if this version is stable and without other
> mistakes.
> We will take a closer look at that in the follow-up patch.

Agreed. In this context, KASAN is essentially a different implementation of the
same checks that SLUB_DEBUG offers (and also does other checks) and we excercise
these SLUB_DEBUG checks by deliberately causing the corruption that they detect
- so instead, KASAN detects it, as it should. I assume that once somebody opts
for a full KASAN kernel build, they don't need the SLUB_DEBUG functionality at
that point, as KASAN is more extensive (On the other hand SLUB_DEBUG kernels can
be (and are) shipped as production distro kernels where specific targetted
debugging can be enabled to help find bugs in production with minimal disruption).
So trying to make both cooperate can work only to some extent and for now we've
chosen the safer way.
