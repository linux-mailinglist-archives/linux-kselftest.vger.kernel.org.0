Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D433EF95
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 12:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhCQL37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 07:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhCQL3n (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 07:29:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F50CAB8C;
        Wed, 17 Mar 2021 11:29:41 +0000 (UTC)
Subject: Re: [selftests] e48d82b67a:
 BUG_TestSlub_RZ_alloc(Not_tainted):Redzone_overwritten
To:     kernel test robot <oliver.sang@intel.com>, glittao@gmail.com,
        kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20210317083612.GD22345@xsang-OptiPlex-9020>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a389a8fb-2043-3b13-5180-e1f87e4d4a66@suse.cz>
Date:   Wed, 17 Mar 2021 12:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317083612.GD22345@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/17/21 9:36 AM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: e48d82b67a2b760eedf7b95ca15f41267496386c ("[PATCH 1/2] selftests: add a kselftest for SLUB debugging functionality")
> url: https://github.com/0day-ci/linux/commits/glittao-gmail-com/selftests-add-a-kselftest-for-SLUB-debugging-functionality/20210316-204257
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> 
> in testcase: trinity
> version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> with following parameters:
> 
> 	group: group-04
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------------------------------------------------------------------------+-----------+------------+
> |                                                                                                               | v5.12-rc2 | e48d82b67a |
> +---------------------------------------------------------------------------------------------------------------+-----------+------------+
> | BUG_TestSlub_RZ_alloc(Not_tainted):Redzone_overwritten                                                        | 0         | 69         |
> | INFO:0x(ptrval)-0x(ptrval)@offset=#.First_byte#instead_of                                                     | 0         | 69         |
> | INFO:Allocated_in_resiliency_test_age=#cpu=#pid=                                                              | 0         | 69         |
> | INFO:Slab0x(ptrval)objects=#used=#fp=0x(ptrval)flags=                                                         | 0         | 69         |
> | INFO:Object0x(ptrval)@offset=#fp=0x(ptrval)                                                                   | 0         | 69         |
> | BUG_TestSlub_next_ptr_free(Tainted:G_B):Freechain_corrupt                                                     | 0         | 69         |
> | INFO:Freed_in_resiliency_test_age=#cpu=#pid=                                                                  | 0         | 69         |
> | BUG_TestSlub_next_ptr_free(Tainted:G_B):Wrong_object_count.Counter_is#but_counted_were                        | 0         | 69         |
> | BUG_TestSlub_next_ptr_free(Tainted:G_B):Redzone_overwritten                                                   | 0         | 69         |
> | BUG_TestSlub_next_ptr_free(Tainted:G_B):Objects_remaining_in_TestSlub_next_ptr_free_on__kmem_cache_shutdown() | 0         | 69         |
> | INFO:Object0x(ptrval)@offset=                                                                                 | 0         | 69         |
> | BUG_TestSlub_1th_word_free(Tainted:G_B):Poison_overwritten                                                    | 0         | 69         |
> | BUG_TestSlub_50th_word_free(Tainted:G_B):Poison_overwritten                                                   | 0         | 69         |
> | BUG_TestSlub_RZ_free(Tainted:G_B):Redzone_overwritten                                                         | 0         | 69         |
> +---------------------------------------------------------------------------------------------------------------+-----------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> [   22.154049] random: get_random_u32 called from __kmem_cache_create+0x23/0x3e0 with crng_init=0 
> [   22.154070] random: get_random_u32 called from cache_random_seq_create+0x7c/0x140 with crng_init=0 
> [   22.154167] random: get_random_u32 called from allocate_slab+0x155/0x5e0 with crng_init=0 
> [   22.154690] test_slub: 1. kmem_cache: Clobber Redzone 0x12->0x(ptrval)
> [   22.164499] =============================================================================
> [   22.166629] BUG TestSlub_RZ_alloc (Not tainted): Redzone overwritten
> [   22.168179] -----------------------------------------------------------------------------
> [   22.168179]
> [   22.168372] Disabling lock debugging due to kernel taint
> [   22.168372] INFO: 0x(ptrval)-0x(ptrval) @offset=1064. First byte 0x12 instead of 0xcc
> [   22.168372] INFO: Allocated in resiliency_test+0x47/0x1be age=3 cpu=0 pid=1 
> [   22.168372] __slab_alloc+0x57/0x80 
> [   22.168372] kmem_cache_alloc (kbuild/src/consumer/mm/slub.c:2871 kbuild/src/consumer/mm/slub.c:2915 kbuild/src/consumer/mm/slub.c:2920) 
> [   22.168372] resiliency_test (kbuild/src/consumer/lib/test_slub.c:34 kbuild/src/consumer/lib/test_slub.c:107) 
> [   22.168372] test_slub_init (kbuild/src/consumer/lib/test_slub.c:124) 
> [   22.168372] do_one_initcall (kbuild/src/consumer/init/main.c:1226) 
> [   22.168372] kernel_init_freeable (kbuild/src/consumer/init/main.c:1298 kbuild/src/consumer/init/main.c:1315 kbuild/src/consumer/init/main.c:1335 kbuild/src/consumer/init/main.c:1537) 
> [   22.168372] kernel_init (kbuild/src/consumer/init/main.c:1426) 
> [   22.168372] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_32.S:856) 
> [   22.168372] INFO: Slab 0x(ptrval) objects=16 used=1 fp=0x(ptrval) flags=0x40000201
> [   22.168372] INFO: Object 0x(ptrval) @offset=1000 fp=0x(ptrval)
> [   22.168372]
> [   22.168372] Redzone (ptrval): cc cc cc cc cc cc cc cc                          ........
> [   22.168372] Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [   22.168372] Object (ptrval): 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> [   22.168372] Redzone (ptrval): 12 cc cc cc                                      ....
> [   22.168372] Padding (ptrval): 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> [   22.168372] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.12.0-rc2-00001-ge48d82b67a2b #1
> [   22.168372] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   22.168372] Call Trace:
> [   22.168372] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
> [   22.168372] print_trailer (kbuild/src/consumer/mm/slub.c:737) 
> [   22.168372] check_bytes_and_report.cold (kbuild/src/consumer/mm/slub.c:807) 
> [   22.168372] check_object (kbuild/src/consumer/mm/slub.c:914) 
> [   22.168372] validate_slab (kbuild/src/consumer/mm/slub.c:4635) 

Hm but in this case the output means the tested functionality (slub debugging)
is working as intended. So what can we do? Indicate/teach somehow to the bot
that this is OK? Does kselftest have some support for this? Or silence the
validation output for testing purposes? (I would prefer not to)

Thanks,
Vlastimil
