Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F806D82EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbjDEQFd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjDEQF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 12:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBB59C9
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXprtrdZNwmMIamN3jClp0qbW3EwMnyGKppnACo59/M=;
        b=Z4EEbGDBqxs3D23NMOQckEMAHqZI1eHMYAs/wVwVRST7dfveSplnBmIsu49Bw/N0laymKH
        X7ypNgN5VbikyW8i0Yjcn2+2IWaol496OigGgzzxg2uN6FvvpzBbNUyHg9vRQ4hADte6Ob
        b3rp/3bxGMwnS1VfYlnqIpgOHYc+9RE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-VYjOfaw7OJS32fFQ9AoNRw-1; Wed, 05 Apr 2023 12:04:33 -0400
X-MC-Unique: VYjOfaw7OJS32fFQ9AoNRw-1
Received: by mail-wm1-f71.google.com with SMTP id o28-20020a05600c511c00b003ef69894934so15390124wms.6
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 09:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710672;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXprtrdZNwmMIamN3jClp0qbW3EwMnyGKppnACo59/M=;
        b=mfF9xKN1xihXy4n25TRwPQpyXSHyLm4f55qPFf1ijeK0jF99Gb34OJVFuPDtGJbGC3
         kYTtuQfeaNgT7JP/0A7i9fTdqc2j/BegZ1Qiq7SkznKPNQrhN7VRekVLYffhGMzToIc4
         qaqbBQA2TyW5VGT2i98xrNSyOif6HQVDlwp5sIpO39frEpBFmKhtH9TBxQxp/bN6ArZh
         e1ORWqgt/ZbRkYZkM4WZrIdU1rTXNv80stq6XUmXlM7H108b5eFiwq9smewfYP2XebQU
         ckxvAQpw14qCb0sZ+VhcZ6WYzTXu7XsFrMeUS0iF4SlxVASnn4NgGr40QP8lKbqB6zJi
         aSbQ==
X-Gm-Message-State: AAQBX9e8O4n47Ed9cJK20/Ipd2VOlOetMGtLiIqvp/IK8anc/rPobNMJ
        WUg/Uzen9eVkhsqKxPoYlG1qaIfo6ps7mvBf6ZJl340kqUN2qGtLiQ8HYuepwpvrsVpx4H9x3NX
        Scvj8QfhCZq3V4vL3f03jxTl8D+PO
X-Received: by 2002:adf:e30f:0:b0:2ce:a46f:bbc5 with SMTP id b15-20020adfe30f000000b002cea46fbbc5mr4755844wrj.34.1680710672120;
        Wed, 05 Apr 2023 09:04:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350bpqqYAO9+vgw+2aNkzVE7Ih5UrgncoSo5774gO0GkyGPfCkiwNGwlRmXOq/Q2lEJVCqAmpnQ==
X-Received: by 2002:adf:e30f:0:b0:2ce:a46f:bbc5 with SMTP id b15-20020adfe30f000000b002cea46fbbc5mr4755825wrj.34.1680710671688;
        Wed, 05 Apr 2023 09:04:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b002d431f61b18sm15194754wrp.103.2023.04.05.09.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:04:30 -0700 (PDT)
Message-ID: <d3af0fb8-64c4-fc68-0e8c-9bdab8706e02@redhat.com>
Date:   Wed, 5 Apr 2023 18:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-2-shr@devkernel.io>
 <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
 <e888871b-9f48-c01d-ce7f-f32ec3d79ef8@redhat.com>
 <2229abe0-b304-6ae3-5bda-d71387c645ca@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
In-Reply-To: <2229abe0-b304-6ae3-5bda-d71387c645ca@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05.04.23 08:51, Christian Borntraeger wrote:
> Am 03.04.23 um 13:03 schrieb David Hildenbrand:
>> On 03.04.23 12:37, David Hildenbrand wrote:
>>> On 10.03.23 19:28, Stefan Roesch wrote:
>>>> Patch series "mm: process/cgroup ksm support", v3.
>>>>
>>>> So far KSM can only be enabled by calling madvise for memory regions.  To
>>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>>> enabled / disabled at the process / cgroup level.
>>>>
>>>> Use case 1:
>>>>
>>>>      The madvise call is not available in the programming language.  An
>>>>      example for this are programs with forked workloads using a garbage
>>>>      collected language without pointers.  In such a language madvise cannot
>>>>      be made available.
>>>>
>>>>      In addition the addresses of objects get moved around as they are
>>>>      garbage collected.  KSM sharing needs to be enabled "from the outside"
>>>>      for these type of workloads.
>>>
>>> I guess the interpreter could enable it (like a memory allocator could
>>> enable it for the whole heap). But I get that it's much easier to enable
>>> this per-process, and eventually only when a lot of the same processes
>>> are running in that particular environment.
>>>
>>>>
>>>> Use case 2:
>>>>
>>>>      The same interpreter can also be used for workloads where KSM brings
>>>>      no benefit or even has overhead.  We'd like to be able to enable KSM on
>>>>      a workload by workload basis.
>>>
>>> Agreed. A per-process control is also helpful to identidy workloads
>>> where KSM might be beneficial (and to which degree).
>>>
>>>>
>>>> Use case 3:
>>>>
>>>>      With the madvise call sharing opportunities are only enabled for the
>>>>      current process: it is a workload-local decision.  A considerable number
>>>>      of sharing opportuniites may exist across multiple workloads or jobs.
>>>>      Only a higler level entity like a job scheduler or container can know
>>>>      for certain if its running one or more instances of a job.  That job
>>>>      scheduler however doesn't have the necessary internal worklaod knowledge
>>>>      to make targeted madvise calls.
>>>>
>>>> Security concerns:
>>>>
>>>>      In previous discussions security concerns have been brought up.  The
>>>>      problem is that an individual workload does not have the knowledge about
>>>>      what else is running on a machine.  Therefore it has to be very
>>>>      conservative in what memory areas can be shared or not.  However, if the
>>>>      system is dedicated to running multiple jobs within the same security
>>>>      domain, its the job scheduler that has the knowledge that sharing can be
>>>>      safely enabled and is even desirable.
>>>>
>>>> Performance:
>>>>
>>>>      Experiments with using UKSM have shown a capacity increase of around
>>>>      20%.
>>>>
>>>
>>> As raised, it would be great to include more details about the workload
>>> where this particulalry helps (e.g., a lot of Django processes operating
>>> in the same domain).
>>>
>>>>
>>>> 1. New options for prctl system command
>>>>
>>>>       This patch series adds two new options to the prctl system call.
>>>>       The first one allows to enable KSM at the process level and the second
>>>>       one to query the setting.
>>>>
>>>>       The setting will be inherited by child processes.
>>>>
>>>>       With the above setting, KSM can be enabled for the seed process of a
>>>>       cgroup and all processes in the cgroup will inherit the setting.
>>>>
>>>> 2. Changes to KSM processing
>>>>
>>>>       When KSM is enabled at the process level, the KSM code will iterate
>>>>       over all the VMA's and enable KSM for the eligible VMA's.
>>>>
>>>>       When forking a process that has KSM enabled, the setting will be
>>>>       inherited by the new child process.
>>>>
>>>>       In addition when KSM is disabled for a process, KSM will be disabled
>>>>       for the VMA's where KSM has been enabled.
>>>
>>> Do we want to make MADV_MERGEABLE/MADV_UNMERGEABLE fail while the new
>>> prctl is enabled for a process?
>>>
>>>>
>>>> 3. Add general_profit metric
>>>>
>>>>       The general_profit metric of KSM is specified in the documentation,
>>>>       but not calculated.  This adds the general profit metric to
>>>>       /sys/kernel/debug/mm/ksm.
>>>>
>>>> 4. Add more metrics to ksm_stat
>>>>
>>>>       This adds the process profit and ksm type metric to
>>>>       /proc/<pid>/ksm_stat.
>>>>
>>>> 5. Add more tests to ksm_tests
>>>>
>>>>       This adds an option to specify the merge type to the ksm_tests.
>>>>       This allows to test madvise and prctl KSM.  It also adds a new option
>>>>       to query if prctl KSM has been enabled.  It adds a fork test to verify
>>>>       that the KSM process setting is inherited by client processes.
>>>>
>>>> An update to the prctl(2) manpage has been proposed at [1].
>>>>
>>>> This patch (of 3):
>>>>
>>>> This adds a new prctl to API to enable and disable KSM on a per process
>>>> basis instead of only at the VMA basis (with madvise).
>>>>
>>>> 1) Introduce new MMF_VM_MERGE_ANY flag
>>>>
>>>>       This introduces the new flag MMF_VM_MERGE_ANY flag.  When this flag
>>>>       is set, kernel samepage merging (ksm) gets enabled for all vma's of a
>>>>       process.
>>>>
>>>> 2) add flag to __ksm_enter
>>>>
>>>>       This change adds the flag parameter to __ksm_enter.  This allows to
>>>>       distinguish if ksm was called by prctl or madvise.
>>>>
>>>> 3) add flag to __ksm_exit call
>>>>
>>>>       This adds the flag parameter to the __ksm_exit() call.  This allows
>>>>       to distinguish if this call is for an prctl or madvise invocation.
>>>>
>>>> 4) invoke madvise for all vmas in scan_get_next_rmap_item
>>>>
>>>>       If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
>>>>       over all the vmas and enable ksm if possible.  For the vmas that can be
>>>>       ksm enabled this is only done once.
>>>>
>>>> 5) support disabling of ksm for a process
>>>>
>>>>       This adds the ability to disable ksm for a process if ksm has been
>>>>       enabled for the process.
>>>>
>>>> 6) add new prctl option to get and set ksm for a process
>>>>
>>>>       This adds two new options to the prctl system call
>>>>       - enable ksm for all vmas of a process (if the vmas support it).
>>>>       - query if ksm has been enabled for a process.
>>>
>>>
>>> Did you consider, instead of handling MMF_VM_MERGE_ANY in a special way,
>>> to instead make it reuse the existing MMF_VM_MERGEABLE/VM_MERGEABLE
>>> infrastructure. Especially:
>>>
>>> 1) During prctl(MMF_VM_MERGE_ANY), set VM_MERGABLE on all applicable
>>>       compatible. Further, set MMF_VM_MERGEABLE and enter KSM if not
>>>       already set.
>>>
>>> 2) When creating a new, compatible VMA and MMF_VM_MERGE_ANY is set, set
>>>       VM_MERGABLE?
>>>
>>> The you can avoid all runtime checks for compatible VMAs and only look
>>> at the VM_MERGEABLE flag. In fact, the VM_MERGEABLE will be completely
>>> expressive then for all VMAs. You don't need vma_ksm_mergeable() then.
>>>
>>>
>>> Another thing to consider is interaction with arch/s390/mm/gmap.c:
>>> s390x/kvm does not support KSM and it has to disable it for all VMAs. We
> 
> Normally we do support KSM on s390. This is a special case for guests using
> storage keys. Those are attributes of the physical page and might differ even
> if the content of the page is the same.
> New Linux no longer uses it (unless a debug option is set during build) so we
> enable the guest storage keys lazy and break KSM pages in that process.
> Ideally we would continue this semantic (e.g. even after a prctl, if the
> guest enable storage keys, disable ksm for this VM).

IIRC, KSM also gets disabled when switching to protected VMs. I recall 
that we really wanted to stop KSM scanning pages that are possibly 
protected. (don't remember if one could harm the system enabling it 
before/after the switch)

> 
>>> have to find a way to fence the prctl (for example, fail setting the
>>> prctl after gmap_mark_unmergeable() ran, and make
>>> gmap_mark_unmergeable() fail if the prctl ran -- or handle it gracefully
>>> in some other way).
>>
>>
>> Staring at that code, I wonder if the "mm->def_flags &= ~VM_MERGEABLE" is doing what it's supposed to do. I don't think this effectively prevents right now madvise() from getting re-enabled on that VMA.
>>
>> @Christian, Janosch, am I missing something?
> 
> Yes, if QEMU would do an madvise later on instead of just the start if would
> result in guest storage keys to be messed up on KSM merges. One could argue
> that this is a bug in the hypervisor then (QEMU) but yes, we should try
> to make this more reliable in the kernel.

It looks like the "mm->def_flags &= ~VM_MERGEABLE" wanted to achieve 
that, but failed. At least it looks like completely unnecessary code if 
I am not wrong.

Maybe inspired by similar code in thp_split_mm(), that enforces 
VM_NOHUGEPAGE.

-- 
Thanks,

David / dhildenb

