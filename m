Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4126D4DD2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjDCQbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjDCQbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 12:31:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9E2686;
        Mon,  3 Apr 2023 09:30:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BEFDC5C01B0;
        Mon,  3 Apr 2023 12:30:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Apr 2023 12:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680539408; x=1680625808; bh=OI
        OsSOFpmWZkshwfP4APr12ORwkJEGK1I/Ih5Fr1hno=; b=RaeUC6Fe3m5Ks0v7fr
        nJVdJP2ZlnO4ClzF8FQCHdETWcezuie8Y7npSDRxODCOXUYSxHD8ElsCdMLPANb4
        pf0WO+LuFZ5LXYGeaWd52QP74sQkTm4uAFjyIIkntIwaWk1fK5nYzvQwP75Tpn9r
        Kvps3QByV47HiU/VKAUuHBa+SmWkxz7kNF9e5/q0pCS0I6YYw/9q6OSh3WddKcZE
        W2tQLJS3/bOGbndK5rFzfQ8VQofMBRy2RHVMRwrSVxgZ0aXUNwAlECMlmXxFi+LN
        5qG/QcPDZ+r6RnXGzjjc3SD88QCQBemdun7x6mhnjHHlB9nPlnkIrypF8GwA9Rbc
        FCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680539408; x=1680625808; bh=OIOsSOFpmWZks
        hwfP4APr12ORwkJEGK1I/Ih5Fr1hno=; b=TE7mdmvduUPYZKxxzW1Zkz+mnQ1JX
        duhZ1gzmJTNRuyFRQbG4emdGXxkBWl15xpMdBjTWSjOJu44LWYd5Cz2L5A/L6+Nn
        Pn5x5VBVCc+t48gAvaXiIiBdvsbxfnnOviT/ljhsR9eCppcO7NGv6dTrLfejWVwe
        VOut0Wpm9HqGIM25L0Zsy1dr74DCrumbcOOFxhiuFSQIWYkHWhtNNPFCoyEdKBnh
        U00tKAdSJTl9eVFEmwKpy5aANrOkkvi/0GlQCdEjpDg2/rszOLXMUL6R0SePT0mz
        0gfwUEJtUnA+5kIG6CJSMELQkFYATjvypUGuceknswhgMOm1GBPUC9RAQ==
X-ME-Sender: <xms:D_8qZGsLVTM54Py-Ru7bp9abOV_lbEHEbafcyxoQC0CJjEZYueNj4A>
    <xme:D_8qZLcaEtxoPSSvM9pImwu_Onx00Fi0LngqHA1v5uY8MbtWEZLkF4PvE_860IYKh
    adllrutjkbUTd5xhzo>
X-ME-Received: <xmr:D_8qZBwiykGdXKUIx740v5bapFPxGmRdo-F81o4TViWvauNEc1JwsmBq3OQJexMax0GZACAwdPrDAZp3Wa65rxTSHY6ZtpjNEWUfu3JD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpefhgfejveduudehvdduvefguddvffefgffhieeuudefudfhhfeijeefjeff
    heelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:D_8qZBMaaZzcm7HlFJ5D1oQ67lL4fZBoNiltSBSuHwmTKOb_8IuNmQ>
    <xmx:D_8qZG_w9MX4WGk7v17d_oRAKGJKX11FmufO74kSgx7WZp7a3oiVYQ>
    <xmx:D_8qZJW1iML67fuf6vGmvJ3KxqcOFR0DboMlxElOBy4YgibM0D66Tg>
    <xmx:EP8qZKTJ9XQgB1SJtaTi0f51RNoeeemy3Ofu8KGQmyBOKFzDxgSL3w>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 12:30:06 -0400 (EDT)
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-2-shr@devkernel.io>
 <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
Date:   Mon, 03 Apr 2023 08:50:55 -0700
In-reply-to: <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
Message-ID: <qvqwpm8ludx2.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 10.03.23 19:28, Stefan Roesch wrote:
>> Patch series "mm: process/cgroup ksm support", v3.
>> So far KSM can only be enabled by calling madvise for memory regions.  To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
>> Use case 1:
>>    The madvise call is not available in the programming language.  An
>>    example for this are programs with forked workloads using a garbage
>>    collected language without pointers.  In such a language madvise cannot
>>    be made available.
>>    In addition the addresses of objects get moved around as they are
>>    garbage collected.  KSM sharing needs to be enabled "from the outside"
>>    for these type of workloads.
>
> I guess the interpreter could enable it (like a memory allocator could enable it
> for the whole heap). But I get that it's much easier to enable this per-process,
> and eventually only when a lot of the same processes are running in that
> particular environment.
>

We don't want it to get enabled for all workloads of that interpreter,
instead we want to be able to select for which workloads we enable KSM.

>> Use case 2:
>>    The same interpreter can also be used for workloads where KSM brings
>>    no benefit or even has overhead.  We'd like to be able to enable KSM on
>>    a workload by workload basis.
>
> Agreed. A per-process control is also helpful to identidy workloads where KSM
> might be beneficial (and to which degree).
>
>> Use case 3:
>>    With the madvise call sharing opportunities are only enabled for the
>>    current process: it is a workload-local decision.  A considerable number
>>    of sharing opportuniites may exist across multiple workloads or jobs.
>>    Only a higler level entity like a job scheduler or container can know
>>    for certain if its running one or more instances of a job.  That job
>>    scheduler however doesn't have the necessary internal worklaod knowledge
>>    to make targeted madvise calls.
>> Security concerns:
>>    In previous discussions security concerns have been brought up.  The
>>    problem is that an individual workload does not have the knowledge about
>>    what else is running on a machine.  Therefore it has to be very
>>    conservative in what memory areas can be shared or not.  However, if the
>>    system is dedicated to running multiple jobs within the same security
>>    domain, its the job scheduler that has the knowledge that sharing can be
>>    safely enabled and is even desirable.
>> Performance:
>>    Experiments with using UKSM have shown a capacity increase of around
>>    20%.
>>
>
> As raised, it would be great to include more details about the workload where
> this particulalry helps (e.g., a lot of Django processes operating in the same
> domain).
>

I can add that the django processes are part of the same domain with the
next version of the patch series.

>> 1. New options for prctl system command
>>     This patch series adds two new options to the prctl system call.
>>     The first one allows to enable KSM at the process level and the second
>>     one to query the setting.
>>     The setting will be inherited by child processes.
>>     With the above setting, KSM can be enabled for the seed process of a
>>     cgroup and all processes in the cgroup will inherit the setting.
>> 2. Changes to KSM processing
>>     When KSM is enabled at the process level, the KSM code will iterate
>>     over all the VMA's and enable KSM for the eligible VMA's.
>>     When forking a process that has KSM enabled, the setting will be
>>     inherited by the new child process.
>>     In addition when KSM is disabled for a process, KSM will be disabled
>>     for the VMA's where KSM has been enabled.
>
> Do we want to make MADV_MERGEABLE/MADV_UNMERGEABLE fail while the new prctl is
> enabled for a process?

I decided to allow enabling KSM with prctl even when MADV_MERGEABLE,
this allows more flexibility.
>
>> 3. Add general_profit metric
>>     The general_profit metric of KSM is specified in the documentation,
>>     but not calculated.  This adds the general profit metric to
>>     /sys/kernel/debug/mm/ksm.
>> 4. Add more metrics to ksm_stat
>>     This adds the process profit and ksm type metric to
>>     /proc/<pid>/ksm_stat.
>> 5. Add more tests to ksm_tests
>>     This adds an option to specify the merge type to the ksm_tests.
>>     This allows to test madvise and prctl KSM.  It also adds a new option
>>     to query if prctl KSM has been enabled.  It adds a fork test to verify
>>     that the KSM process setting is inherited by client processes.
>> An update to the prctl(2) manpage has been proposed at [1].
>> This patch (of 3):
>> This adds a new prctl to API to enable and disable KSM on a per process
>> basis instead of only at the VMA basis (with madvise).
>> 1) Introduce new MMF_VM_MERGE_ANY flag
>>     This introduces the new flag MMF_VM_MERGE_ANY flag.  When this flag
>>     is set, kernel samepage merging (ksm) gets enabled for all vma's of a
>>     process.
>> 2) add flag to __ksm_enter
>>     This change adds the flag parameter to __ksm_enter.  This allows to
>>     distinguish if ksm was called by prctl or madvise.
>> 3) add flag to __ksm_exit call
>>     This adds the flag parameter to the __ksm_exit() call.  This allows
>>     to distinguish if this call is for an prctl or madvise invocation.
>> 4) invoke madvise for all vmas in scan_get_next_rmap_item
>>     If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
>>     over all the vmas and enable ksm if possible.  For the vmas that can be
>>     ksm enabled this is only done once.
>> 5) support disabling of ksm for a process
>>     This adds the ability to disable ksm for a process if ksm has been
>>     enabled for the process.
>> 6) add new prctl option to get and set ksm for a process
>>     This adds two new options to the prctl system call
>>     - enable ksm for all vmas of a process (if the vmas support it).
>>     - query if ksm has been enabled for a process.
>
>
> Did you consider, instead of handling MMF_VM_MERGE_ANY in a special way, to
> instead make it reuse the existing MMF_VM_MERGEABLE/VM_MERGEABLE infrastructure.
> Especially:
>
> 1) During prctl(MMF_VM_MERGE_ANY), set VM_MERGABLE on all applicable
>    compatible. Further, set MMF_VM_MERGEABLE and enter KSM if not
>    already set.
>
> 2) When creating a new, compatible VMA and MMF_VM_MERGE_ANY is set, set
>    VM_MERGABLE?
>
> The you can avoid all runtime checks for compatible VMAs and only look at the
> VM_MERGEABLE flag. In fact, the VM_MERGEABLE will be completely expressive then
> for all VMAs. You don't need vma_ksm_mergeable() then.
>

I didn't consider the above approach, I can have a look. I can see the
benefit of not needing vma_ksm_mergeable().

> Another thing to consider is interaction with arch/s390/mm/gmap.c: s390x/kvm
> does not support KSM and it has to disable it for all VMAs. We have to find a
> way to fence the prctl (for example, fail setting the prctl after
> gmap_mark_unmergeable() ran, and make gmap_mark_unmergeable() fail if the prctl
> ran -- or handle it gracefully in some other way).
>
>

I'll have a look.

>> Link: https://lkml.kernel.org/r/20230227220206.436662-1-shr@devkernel.io [1]
>> Link: https://lkml.kernel.org/r/20230224044000.3084046-1-shr@devkernel.io
>> Link: https://lkml.kernel.org/r/20230224044000.3084046-2-shr@devkernel.io
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   include/linux/ksm.h            | 14 ++++--
>>   include/linux/sched/coredump.h |  1 +
>>   include/uapi/linux/prctl.h     |  2 +
>>   kernel/sys.c                   | 27 ++++++++++
>>   mm/ksm.c                       | 90 +++++++++++++++++++++++-----------
>>   5 files changed, 101 insertions(+), 33 deletions(-)
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 7e232ba59b86..d38a05a36298 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -18,20 +18,24 @@
>>   #ifdef CONFIG_KSM
>>   int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>>   		unsigned long end, int advice, unsigned long *vm_flags);
>> -int __ksm_enter(struct mm_struct *mm);
>> -void __ksm_exit(struct mm_struct *mm);
>> +int __ksm_enter(struct mm_struct *mm, int flag);
>> +void __ksm_exit(struct mm_struct *mm, int flag);
>>     static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>   {
>> +	if (test_bit(MMF_VM_MERGE_ANY, &oldmm->flags))
>> +		return __ksm_enter(mm, MMF_VM_MERGE_ANY);
>>   	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
>> -		return __ksm_enter(mm);
>> +		return __ksm_enter(mm, MMF_VM_MERGEABLE);
>>   	return 0;
>>   }
>>     static inline void ksm_exit(struct mm_struct *mm)
>>   {
>> -	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> -		__ksm_exit(mm);
>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		__ksm_exit(mm, MMF_VM_MERGE_ANY);
>> +	else if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
>> +		__ksm_exit(mm, MMF_VM_MERGEABLE);
>>   }
>>     /*
>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>> index 0e17ae7fbfd3..0ee96ea7a0e9 100644
>> --- a/include/linux/sched/coredump.h
>> +++ b/include/linux/sched/coredump.h
>> @@ -90,4 +90,5 @@ static inline int get_dumpable(struct mm_struct *mm)
>>   #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>>   				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
>>   +#define MMF_VM_MERGE_ANY	29
>>   #endif /* _LINUX_SCHED_COREDUMP_H */
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 1312a137f7fb..759b3f53e53f 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -290,4 +290,6 @@ struct prctl_mm_map {
>>   #define PR_SET_VMA		0x53564d41
>>   # define PR_SET_VMA_ANON_NAME		0
>>   +#define PR_SET_MEMORY_MERGE		67
>> +#define PR_GET_MEMORY_MERGE		68
>>   #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 495cd87d9bf4..edc439b1cae9 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/highuid.h>
>>   #include <linux/fs.h>
>>   #include <linux/kmod.h>
>> +#include <linux/ksm.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/resource.h>
>>   #include <linux/kernel.h>
>> @@ -2661,6 +2662,32 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   	case PR_SET_VMA:
>>   		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>   		break;
>> +#ifdef CONFIG_KSM
>> +	case PR_SET_MEMORY_MERGE:
>> +		if (!capable(CAP_SYS_RESOURCE))
>> +			return -EPERM;
>> +
>> +		if (arg2) {
>> +			if (mmap_write_lock_killable(me->mm))
>> +				return -EINTR;
>> +
>> +			if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
>> +				error = __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
>
> Hm, I think this might be problematic if we alread called __ksm_enter() via
> madvise(). Maybe we should really consider making MMF_VM_MERGE_ANY set
> MMF_VM_MERGABLE instead. Like:
>
> error = 0;
> if(test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
> 	error = __ksm_enter(me->mm);
> if (!error)
> 	set_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>

If we make that change, we would no longer be able to distinguish
if MMF_VM_MERGEABLE or MMF_VM_MERGE_ANY have been set.

>> +			mmap_write_unlock(me->mm);
>> +		} else {
>> +			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
>
> Hm, I'd prefer if we really only call __ksm_exit() when we really exit the
> process. Is there a strong requirement to optimize disabling of KSM or would it
> be sufficient to clear the MMF_VM_MERGE_ANY flag here?
>
Then we still have the mm_slot allocated until the process gets
terminated.

> Also, I wonder what happens if we have another VMA in that process that has it
> enabled ..
>
> Last but not least, wouldn't we want to do the same thing as MADV_UNMERGEABLE
> and actually unmerge the KSM pages?
>
Do you want to call unmerge for all VMA's?

>
> It smells like it could be simpler and more consistent to handle by letting
> PR_SET_MEMORY_MERGE piggy-back on MMF_VM_MERGABLE/VM_MERGABLE and mimic what
> ksm_madvise() does simply for all VMAs.
>
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -534,16 +534,58 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>>   	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
>>   }
>>   +static bool vma_ksm_compatible(struct vm_area_struct *vma)
>> +{
>> +	/*
>> +	 * Be somewhat over-protective for now!
>> +	 */
>> +	if (vma->vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
>> +			     VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
>> +			     VM_HUGETLB | VM_MIXEDMAP))
>> +		return false;		/* just ignore the advice */
>
> That comment is kind-of stale and ksm_madvise() specific.
>

I'll remove the comment.

>> +
>
> The VM_MERGEABLE check is really only used for ksm_madvise() to return
> immediately. I suggest keeping it in ksm_madvise() -- "Already enabled".
> Returning "false" in that case looks wrong (it's not broken because you do an
> early check in vma_ksm_mergeable(), it's just semantically weird).
>

I'll make it in ksm_madvise and remove it here.
