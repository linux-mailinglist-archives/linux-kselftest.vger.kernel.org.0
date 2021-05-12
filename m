Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B045E37BA93
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhELKcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 06:32:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhELKbN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 06:31:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5181CB0BD;
        Wed, 12 May 2021 10:30:04 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] mm/slub, kunit: add a KUnit test for SLUB
 debugging functionality
To:     Marco Elver <elver@google.com>, Oliver Glitta <glittao@gmail.com>
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
References: <20210511150734.3492-1-glittao@gmail.com>
 <20210511150734.3492-2-glittao@gmail.com>
 <CANpmjNNnS5FgPnNkGWG2ae_ybsr=Wa_bzNba7RruOM+1kgOzfw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <99d79722-ea94-7775-8ac2-5957b42060b2@suse.cz>
Date:   Wed, 12 May 2021 12:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNNnS5FgPnNkGWG2ae_ybsr=Wa_bzNba7RruOM+1kgOzfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/11/21 5:16 PM, Marco Elver wrote:
> On Tue, 11 May 2021 at 17:07, <glittao@gmail.com> wrote:
>> From: Oliver Glitta <glittao@gmail.com>
>>
>> SLUB has resiliency_test() function which is hidden behind #ifdef
>> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
>> runs it. KUnit should be a proper replacement for it.
>>
>> Try changing byte in redzone after allocation and changing
>> pointer to next free node, first byte, 50th byte and redzone
>> byte. Check if validation finds errors.
>>
>> There are several differences from the original resiliency test:
>> Tests create own caches with known state instead of corrupting
>> shared kmalloc caches.
>>
>> The corruption of freepointer uses correct offset, the original
>> resiliency test got broken with freepointer changes.
>>
>> Scratch changing random byte test, because it does not have
>> meaning in this form where we need deterministic results.
>>
>> Add new option CONFIG_SLUB_KUNIT_TEST in Kconfig.
>> Tests next_pointer, first_word and clobber_50th_byte do not run
>> with KASAN option on. Because the test deliberately modifies non-allocated
>> objects.
>>
>> Use kunit_resource to count errors in cache and silence bug reports.
>> Count error whenever slab_bug() or slab_fix() is called or when
>> the count of pages is wrong.
>>
>> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> I think I had already reviewed v4, and the changes here are fine:
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Others who had reviewed/acked v4, probably need to re-ack/review.
> Note, I think if you addressed the comments and didn't change much
> else, you can typically carry the acks/reviews, unless the other
> person changed their mind explicitly.

FTR, besides me and Marco, v4 had also:

Acked-by: Daniel Latypov <dlatypov@google.com>
