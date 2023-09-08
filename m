Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EF7986E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjIHMPA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHMO7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 08:14:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACE1BF9;
        Fri,  8 Sep 2023 05:14:50 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388CCJuq006069;
        Fri, 8 Sep 2023 12:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=iVBWL8lAlMaMpcm2FXnSaIhGC8FePZJTh0i9mZidK3o=;
 b=Devl/3hOfd1BGKQDAaOk3kEleS8OjRQReNVH4RD0gEHtoxpo1mNWBU2cGkmdGBakZ2Ts
 g+2SvF55wrNUCGM4Zo/Ghmi40S4qYCWD+v8thQlwMUcRCQfLBCixZvQIHpZBib8apD+I
 DN8B9OTpddXPxPYAuQ/s0cALaAULeirzuA7P4jiP7XMMcLoKsJsz/FLZCi/xtNoAnmBC
 MOszMdmlRfWZ5s3JH5HSE2FT9GokR968l7wF8pPG35cYyX9Ee6lrMrb2kI/y3HpJzViz
 YPSIHjAv86wtn7FH7lG/zBIY6AT8PRF5aexcL1K+H7AE6QE0RUynOMUabW3IUhJyX+IG Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t03dn01t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:14:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388CCwMC007204;
        Fri, 8 Sep 2023 12:14:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t03dn01su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:14:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388C3epi012232;
        Fri, 8 Sep 2023 12:14:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkkk4kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:14:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388CELBD15204930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 12:14:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88DDB2004E;
        Fri,  8 Sep 2023 12:14:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F143220040;
        Fri,  8 Sep 2023 12:14:20 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Sep 2023 12:14:20 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org,
        chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 09/10] eventfs: Move tracing/events to eventfs
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-10-git-send-email-akaher@vmware.com>
Date:   Fri, 08 Sep 2023 14:14:20 +0200
In-Reply-To: <1689248004-8158-10-git-send-email-akaher@vmware.com> (Ajay
        Kaher's message of "Thu, 13 Jul 2023 17:03:23 +0530")
Message-ID: <yt9dr0n8kgkj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gsIdsqveTkMd_T5tywpYEPDvHF6nBKcG
X-Proofpoint-GUID: HPGcfM2yM9r9AieK6j9xVx5OGseWhy9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=625 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ajay Kaher <akaher@vmware.com> writes:

> Till now /sys/kernel/debug/tracing/events is a part of tracefs,
> with-in this patch creating 'events' and it's sub-dir as eventfs.
> Basically replacing tracefs calls with eventfs calls for 'events'.
>
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/inode.c           | 18 ++++++++++
>  include/linux/trace_events.h |  1 +
>  kernel/trace/trace.h         |  2 +-
>  kernel/trace/trace_events.c  | 67 +++++++++++++++++++-----------------
>  4 files changed, 55 insertions(+), 33 deletions(-)

With this patchset in next-20230908 the following crash is observed on
s390 while running ftracetest test.d/instances/instance-event.tc:

(It also crashes without KASAN, just not on every try)

[   26.728436] ==================================================================
[   26.728450] BUG: KASAN: slab-use-after-free in __ftrace_event_enable_disable+0x56c/0x648
[   26.728460] Read of size 8 at addr 00000000107d3838 by task ftracetest/514
[   26.728465]
[   26.728468] CPU: 1 PID: 514 Comm: ftracetest Not tainted 6.5.0-rc4-00014-g27152bceea1d #958
[   26.728474] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
[   26.728478] Call Trace:
[   26.728482]  [<000000000262349e>] dump_stack_lvl+0x106/0x1c8
[   26.728490]  [<00000000009e3b8c>] print_address_description.constprop.0+0x34/0x378
[   26.728498]  [<00000000009e3f7c>] print_report+0xac/0x240
[   26.728504]  [<00000000009e42fa>] kasan_report+0xf2/0x130
[   26.728509]  [<00000000005c61c4>] __ftrace_event_enable_disable+0x56c/0x648
[   26.728516]  [<00000000005c6d02>] event_enable_write+0x132/0x218
[   26.728522]  [<0000000000a89598>] vfs_write+0x208/0x930
[   26.728528]  [<0000000000a8a148>] ksys_write+0x118/0x200
[   26.728535]  [<000000000010c5fc>] do_syscall+0x22c/0x328
[   26.728547]  [<000000000268e8b2>] __do_syscall+0x9a/0xf8
[   26.728553]  [<00000000026c1d28>] system_call+0x70/0x98
[   26.728559] 3 locks held by ftracetest/514:
[   26.728562]  #0: 00000000226addd8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x84/0xa0
[   26.728577]  #1: 0000000008f19440 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x118/0x200
[   26.728594]  #2: 00000000033205d0 (event_mutex){+.+.}-{3:3}, at: event_enable_write+0xdc/0x218
[   26.728609]
[   26.728613] Allocated by task 515:
[   26.728617]  kasan_save_stack+0x40/0x68
[   26.728627]  kasan_set_track+0x36/0x48
[   26.728632]  __kasan_slab_alloc+0x8e/0xb8
[   26.728638]  kmem_cache_alloc+0x1ec/0x568
[   26.728643]  trace_create_new_event+0x88/0x3d8
[   26.728648]  event_trace_add_tracer+0x13a/0x2a0
[   26.728654]  trace_array_create_dir+0x80/0x1a0
[   26.728660]  trace_array_create+0x344/0x700
[   26.728665]  instance_mkdir+0xbe/0x118
[   26.728670]  tracefs_syscall_mkdir+0xa8/0xf8
[   26.728678]  vfs_mkdir+0x454/0x6c0
[   26.728685]  do_mkdirat+0x24e/0x2a8
[   26.728692]  __s390x_sys_mkdir+0xf4/0x168
[   26.728696]  do_syscall+0x22c/0x328
[   26.728700]  __do_syscall+0x9a/0xf8
[   26.728704]  system_call+0x70/0x98
[   26.728710]
[   26.728713] Freed by task 553:
[   26.728716]  kasan_save_stack+0x40/0x68
[   26.728721]  kasan_set_track+0x36/0x48
[   26.728726]  kasan_save_free_info+0x42/0x60
[   26.728733]  ____kasan_slab_free+0x17c/0x1e0
[   26.728741]  __kasan_slab_free+0x24/0x30
[   26.728747]  slab_free_freelist_hook+0x272/0x3a0
[   26.728751]  kmem_cache_free+0xec/0x540
[   26.728757]  event_trace_del_tracer+0x108/0x1f8
[   26.728763]  __remove_instance+0x242/0x668
[   26.728781]  instance_rmdir+0xc4/0x108
[   26.728788]  tracefs_syscall_rmdir+0xd4/0x160
[   26.728796]  vfs_rmdir+0x18a/0x538
[   26.728802]  do_rmdir+0x2c0/0x358
[   26.728807]  __s390x_sys_rmdir+0xd2/0x138
[   26.728811]  do_syscall+0x22c/0x328
[   26.728817]  __do_syscall+0x9a/0xf8
[   26.728823]  system_call+0x70/0x98
[   26.728829]
[   26.728833] The buggy address belongs to the object at 00000000107d3828
[   26.728833]  which belongs to the cache trace_event_file of size 96
[   26.728841] The buggy address is located 16 bytes inside of
[   26.728841]  freed 96-byte region [00000000107d3828, 00000000107d3888)
[   26.728846]
[   26.728848] The buggy address belongs to the physical page:
[   26.728851] page:000040000041f4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107d3
[   26.728871] flags: 0x1ffff00000000200(slab|node=0|zone=0|lastcpupid=0x1ffff)
[   26.728880] page_type: 0xffffffff()
[   26.728889] raw: 1ffff00000000200 0000000005a2c100 0000400000891490 00004000006a89d0
[   26.728894] raw: 0000000000000000 0013002600000000 ffffffff00000001 0000000000000000
[   26.728898] page dumped because: kasan: bad access detected
[   26.728902]
[   26.728906] Memory state around the buggy address:
[   26.728912]  00000000107d3700: fc fc fc fc fc fc fc fc fc fc fc fa fb fb fb fb
[   26.728919]  00000000107d3780: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
[   26.728928] >00000000107d3800: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
[   26.728933]                                         ^
[   26.728940]  00000000107d3880: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fa
[   26.728943]  00000000107d3900: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
[   26.728946] ==================================================================
[   26.728955] Disabling lock debugging due to kernel taint
[   27.089717] Unable to handle kernel pointer dereference in virtual kernel address space
[   27.089725] Failing address: 0d896d6d6d6d6000 TEID: 0d896d6d6d6d6803
[   27.089729] Fault in home space mode while using kernel ASCE.
[   27.089737] AS:00000000046b800b R2:0000000000000028
[   27.089770] Oops: 0038 ilc:2 [#1] PREEMPT SMP
[   27.089779] Modules linked in:
[   27.089784] CPU: 1 PID: 514 Comm: ftracetest Tainted: G    B              6.5.0-rc4-00014-g27152bceea1d #958
[   27.089790] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
[   27.089794] Krnl PSW : 0404e00180000000 00000000005c4488 (trace_event_buffer_reserve+0xf0/0x3e8)
[   27.089804]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[   27.089810] Krnl GPRS: 0000000000000001 0000000000000001 6b6b6b6b6b6b6c5b 001c000000000000
[   27.089816]            0d896d6d6d6d6d8b 00000000005c4702 001bff80013cf170 6b6b6b6b6b6b6b6b
[   27.089822]            6b6b6b6b6b6b6b6b 00037ff000279e26 00000000107d3828 001bff80013cf208
[   27.089827]            00000000031669f8 00000000026c1c1c 00000000005c4702 001bff80013cf078
[   27.089843] Krnl Code: 00000000005c447a: 412080f0            la      %r2,240(%r8)
[   27.089843]            00000000005c447e: eb420003000c        srlg    %r4,%r2,3
[   27.089843]           #00000000005c4484: b9080043            agr     %r4,%r3
[   27.089843]           >00000000005c4488: 95004000            cli     0(%r4),0
[   27.089843]            00000000005c448c: a7740142            brc     7,00000000005c4710
[   27.089843]            00000000005c4490: e3e080f00004        lg      %r14,240(%r8)
[   27.089843]            00000000005c4496: e3e0f0a80024        stg     %r14,168(%r15)
[   27.089843]            00000000005c449c: 412080f8            la      %r2,248(%r8)
[   27.089885] Call Trace:
[   27.089890]  [<00000000005c4488>] trace_event_buffer_reserve+0xf0/0x3e8
[   27.089897] ([<00000000005c4702>] trace_event_buffer_reserve+0x36a/0x3e8)
[   27.089903]  [<000000000028979e>] trace_event_raw_event_sched_switch+0xce/0x430
[   27.089910]  [<00000000026a1cd4>] __schedule+0xba4/0x1f58
[   27.089916]  [<00000000026a4544>] preempt_schedule_irq+0xdc/0x190
[   27.089925]  [<000000000268f99c>] irqentry_exit+0xac/0x128
[   27.089931]  [<00000000026c1fac>] ext_int_handler+0xc4/0xf0
[   27.089936]  [<0000000000135a98>] __unwind_start+0x190/0x568
[   27.089944] ([<0000000000135a7c>] __unwind_start+0x174/0x568)
[   27.089950]  [<000000000013bb90>] arch_stack_walk+0x130/0x1d0
[   27.089957]  [<0000000000424198>] stack_trace_save+0xc8/0xf8
[   27.089968]  [<00000000009d3468>] set_track_prepare+0x38/0x58
[   27.089974]  [<00000000009df35a>] free_to_partial_list+0x1ea/0x2f0
[   27.089979]  [<00000000009df656>] __slab_free+0x1f6/0x3c0
[   27.089984]  [<00000000009e19e8>] ___cache_free+0x158/0x188
[   27.089989]  [<00000000009e6df6>] qlist_free_all+0x7e/0x150
[   27.089994]  [<00000000009e752a>] kasan_quarantine_reduce+0x17a/0x1d8
[   27.089999]  [<00000000009e3488>] __kasan_slab_alloc+0x98/0xb8
[   27.090005]  [<00000000009de3fc>] kmem_cache_alloc+0x1ec/0x568
[   27.090011]  [<0000000000ab1d8e>] getname_flags.part.0+0x56/0x420
[   27.090018]  [<0000000000a81244>] do_sys_openat2+0xc4/0x178
00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from CPU 00.
00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from CPU 01.
[   27.090027]  [<0000000000a815ae>] do_sys_open+0xce/0x118
[   27.090033]  [<000000000010c5fc>] do_syscall+0x22c/0x328
[   27.090040]  [<000000000268e8b2>] __do_syscall+0x9a/0xf8
[   27.090048]  [<00000000026c1d28>] system_call+0x70/0x98
[   27.090056] INFO: lockdep is turned off.
[   27.090060] Last Breaking-Event-Address:
[   27.090066]  [<00000000005c4702>] trace_event_buffer_reserve+0x36a/0x3e8
[   27.090077] Kernel panic - not syncing: Fatal exception: panic_on_oops
