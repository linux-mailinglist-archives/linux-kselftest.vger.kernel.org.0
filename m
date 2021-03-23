Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B567E34538B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 01:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCWADB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 20:03:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:46546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhCWACl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 20:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C969ADF1;
        Tue, 23 Mar 2021 00:02:40 +0000 (UTC)
To:     David Rientjes <rientjes@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>, glittao@gmail.com,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20210317083612.GD22345@xsang-OptiPlex-9020>
 <a389a8fb-2043-3b13-5180-e1f87e4d4a66@suse.cz>
 <a3f6261b-22b-89f1-ec24-7516f0fa1d4c@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [selftests] e48d82b67a:
 BUG_TestSlub_RZ_alloc(Not_tainted):Redzone_overwritten
Message-ID: <7789b386-bddd-37ba-fccd-370f1340e698@suse.cz>
Date:   Tue, 23 Mar 2021 01:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a3f6261b-22b-89f1-ec24-7516f0fa1d4c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/17/21 7:53 PM, David Rientjes wrote:
> On Wed, 17 Mar 2021, Vlastimil Babka wrote:
>> > 
>> > [   22.154049] random: get_random_u32 called from __kmem_cache_create+0x23/0x3e0 with crng_init=0 
>> > [   22.154070] random: get_random_u32 called from cache_random_seq_create+0x7c/0x140 with crng_init=0 
>> > [   22.154167] random: get_random_u32 called from allocate_slab+0x155/0x5e0 with crng_init=0 
>> > [   22.154690] test_slub: 1. kmem_cache: Clobber Redzone 0x12->0x(ptrval)
>> > [   22.164499] =============================================================================
>> > [   22.166629] BUG TestSlub_RZ_alloc (Not tainted): Redzone overwritten
>> > [   22.168179] -----------------------------------------------------------------------------
>> > [   22.168179]
>> > [   22.168372] Disabling lock debugging due to kernel taint
>> > [   22.168372] INFO: 0x(ptrval)-0x(ptrval) @offset=1064. First byte 0x12 instead of 0xcc
>> > [   22.168372] INFO: Allocated in resiliency_test+0x47/0x1be age=3 cpu=0 pid=1 
>> > [   22.168372] __slab_alloc+0x57/0x80 
>> > [   22.168372] kmem_cache_alloc (kbuild/src/consumer/mm/slub.c:2871 kbuild/src/consumer/mm/slub.c:2915 kbuild/src/consumer/mm/slub.c:2920) 
>> > [   22.168372] resiliency_test (kbuild/src/consumer/lib/test_slub.c:34 kbuild/src/consumer/lib/test_slub.c:107) 
>> > [   22.168372] test_slub_init (kbuild/src/consumer/lib/test_slub.c:124) 
>> > [   22.168372] do_one_initcall (kbuild/src/consumer/init/main.c:1226) 
>> > [   22.168372] kernel_init_freeable (kbuild/src/consumer/init/main.c:1298 kbuild/src/consumer/init/main.c:1315 kbuild/src/consumer/init/main.c:1335 kbuild/src/consumer/init/main.c:1537) 
>> > [   22.168372] kernel_init (kbuild/src/consumer/init/main.c:1426) 
>> > [   22.168372] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_32.S:856) 
>> > [   22.168372] INFO: Slab 0x(ptrval) objects=16 used=1 fp=0x(ptrval) flags=0x40000201
>> > [   22.168372] INFO: Object 0x(ptrval) @offset=1000 fp=0x(ptrval)
>> > [   22.168372]
>> > [   22.168372] Redzone (ptrval): cc cc cc cc cc cc cc cc                          ........
>> > [   22.168372] Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>> > [   22.168372] Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
>> > [   22.168372] Redzone (ptrval): 12 cc cc cc                                      ....
>> > [   22.168372] Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
>> > [   22.168372] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.12.0-rc2-00001-ge48d82b67a2b #1
>> > [   22.168372] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> > [   22.168372] Call Trace:
>> > [   22.168372] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
>> > [   22.168372] print_trailer (kbuild/src/consumer/mm/slub.c:737) 
>> > [   22.168372] check_bytes_and_report.cold (kbuild/src/consumer/mm/slub.c:807) 
>> > [   22.168372] check_object (kbuild/src/consumer/mm/slub.c:914) 
>> > [   22.168372] validate_slab (kbuild/src/consumer/mm/slub.c:4635) 
>> 
>> Hm but in this case the output means the tested functionality (slub debugging)
>> is working as intended. So what can we do? Indicate/teach somehow to the bot
>> that this is OK? Does kselftest have some support for this? Or silence the
>> validation output for testing purposes? (I would prefer not to)
>> 
> 
> Unless you're familiar with everything that CONFIG_TEST_SLUB does, maybe 
> this could be inferred as an actual issue that the test has uncovered that 
> is unexpected?
> 
> I don't have a good way of silencing the check_bytes_and_report() output 
> other than a big hammer: implement {disable,enable}_slub_warnings() that 
> the resiliency test could call into before triggering these checks.

So Oliver has implemented this, but now I got a different idea that should be
much cleaner IMHO. We could add a per-cache flag SLAB_SILENT_ERRORS (similar to
SLAB_RED_ZONE etc) instead of a global bool. The test would just create the
caches with this flag.
The flag should be added to the SLAB_NEVER_MERGE, SLAB_DEBUG_FLAGS,
SLAB_FLAGS_PERMITTED macros as well.

A similar suggestion is that adding the errors counter parameter to all
validate_slab_cache() and relevant functions is tedious - there are more that
had to be modified like this than initially expected.
Instead the error counter can be added to SLUB's struct kmem_cache definition,
incremented by the various checks and the tests can look at that after validation.

Thanks,
Vlastimil
