Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369D96D42E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjDCLEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCLEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 07:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EAD6188
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680519786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQkFi8pN49v364EdSnnTRUfRnb+lg1bb/1afwxowe7o=;
        b=C1pSAFBzJ7mx8Vx6K05hfnuuBNKp94SSWxOB9YgTSgdm+D8Vbxs2DLbVygMUhgk99kR2vj
        MNqrM4hj9js1pA4mp4ZcxmdEI4THlzmuGqVW1R+Wf7TlXVNKxJOk8a9jOCfRmC4G4eE1yA
        V0gvb9xLWwLo16KymVXKy497GorHVE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-z3ohpELANo-WJaYx8Ewe9Q-1; Mon, 03 Apr 2023 07:03:04 -0400
X-MC-Unique: z3ohpELANo-WJaYx8Ewe9Q-1
Received: by mail-wr1-f69.google.com with SMTP id t9-20020adfba49000000b002dd3986083bso3151817wrg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680519783;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQkFi8pN49v364EdSnnTRUfRnb+lg1bb/1afwxowe7o=;
        b=ujKIZDRar3V6S55FYmJGAu8ydknBFdql5iEq5/TWRnf3kM5ZWIwEvJQHDZKLuTjtPH
         bKHeKopSq//dQC2IeEWJ+JsZEE+z5e1vXjjeWDPNJX6NS6wQbGhr4+22aFe1/i0QkDI/
         lw0mlCiWORm5aiXyC3HOLz4Y/wZ5WFhLgzzJo/niduPYYXkyEZSsSHhZvVMXYJ/r8nHI
         9NTPaIfqO/u+rB+Uv+Q1X3Fc4CEAOhUyGtBD1Rou/L5wBLjXdkGSZuu56tdaLhPfvrJ5
         pFGObTKULt2ceuDITOeqQ/+HIZSUpr5ODvZFmeIszadY7mcYRRdUssgUZBLQ3bG+eZNN
         e/6A==
X-Gm-Message-State: AAQBX9eIWoLoFVxTMVI0mDncD4nmq/C9qKhdFWFewY5kTniCCknsvxb4
        SnjgihlAe/pfnc7xc1ST7lxSfyjSMoq6TtzR1GyH7lS4t00yZWKWvbxG8Xho0o/pRZplrtE3y33
        6cnBPetleSviLpCDs2VPQm32k8PF2mtXuGc2q
X-Received: by 2002:adf:ce8e:0:b0:2dd:3856:4dec with SMTP id r14-20020adfce8e000000b002dd38564decmr27424152wrn.61.1680519783551;
        Mon, 03 Apr 2023 04:03:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2oST8H5mGI1Iswt2xjz8GyMo1HkvGSAsOIq6xqlbT4sEKAEwC6DgPef4K+whDRfjGMWlQuQ==
X-Received: by 2002:adf:ce8e:0:b0:2dd:3856:4dec with SMTP id r14-20020adfce8e000000b002dd38564decmr27424136wrn.61.1680519783128;
        Mon, 03 Apr 2023 04:03:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b003ee63fe5203sm11736573wmj.36.2023.04.03.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 04:03:02 -0700 (PDT)
Message-ID: <e888871b-9f48-c01d-ce7f-f32ec3d79ef8@redhat.com>
Date:   Mon, 3 Apr 2023 13:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-2-shr@devkernel.io>
 <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
Organization: Red Hat
In-Reply-To: <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.04.23 12:37, David Hildenbrand wrote:
> On 10.03.23 19:28, Stefan Roesch wrote:
>> Patch series "mm: process/cgroup ksm support", v3.
>>
>> So far KSM can only be enabled by calling madvise for memory regions.  To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
>>
>> Use case 1:
>>
>>     The madvise call is not available in the programming language.  An
>>     example for this are programs with forked workloads using a garbage
>>     collected language without pointers.  In such a language madvise cannot
>>     be made available.
>>
>>     In addition the addresses of objects get moved around as they are
>>     garbage collected.  KSM sharing needs to be enabled "from the outside"
>>     for these type of workloads.
> 
> I guess the interpreter could enable it (like a memory allocator could
> enable it for the whole heap). But I get that it's much easier to enable
> this per-process, and eventually only when a lot of the same processes
> are running in that particular environment.
> 
>>
>> Use case 2:
>>
>>     The same interpreter can also be used for workloads where KSM brings
>>     no benefit or even has overhead.  We'd like to be able to enable KSM on
>>     a workload by workload basis.
> 
> Agreed. A per-process control is also helpful to identidy workloads
> where KSM might be beneficial (and to which degree).
> 
>>
>> Use case 3:
>>
>>     With the madvise call sharing opportunities are only enabled for the
>>     current process: it is a workload-local decision.  A considerable number
>>     of sharing opportuniites may exist across multiple workloads or jobs.
>>     Only a higler level entity like a job scheduler or container can know
>>     for certain if its running one or more instances of a job.  That job
>>     scheduler however doesn't have the necessary internal worklaod knowledge
>>     to make targeted madvise calls.
>>
>> Security concerns:
>>
>>     In previous discussions security concerns have been brought up.  The
>>     problem is that an individual workload does not have the knowledge about
>>     what else is running on a machine.  Therefore it has to be very
>>     conservative in what memory areas can be shared or not.  However, if the
>>     system is dedicated to running multiple jobs within the same security
>>     domain, its the job scheduler that has the knowledge that sharing can be
>>     safely enabled and is even desirable.
>>
>> Performance:
>>
>>     Experiments with using UKSM have shown a capacity increase of around
>>     20%.
>>
> 
> As raised, it would be great to include more details about the workload
> where this particulalry helps (e.g., a lot of Django processes operating
> in the same domain).
> 
>>
>> 1. New options for prctl system command
>>
>>      This patch series adds two new options to the prctl system call.
>>      The first one allows to enable KSM at the process level and the second
>>      one to query the setting.
>>
>>      The setting will be inherited by child processes.
>>
>>      With the above setting, KSM can be enabled for the seed process of a
>>      cgroup and all processes in the cgroup will inherit the setting.
>>
>> 2. Changes to KSM processing
>>
>>      When KSM is enabled at the process level, the KSM code will iterate
>>      over all the VMA's and enable KSM for the eligible VMA's.
>>
>>      When forking a process that has KSM enabled, the setting will be
>>      inherited by the new child process.
>>
>>      In addition when KSM is disabled for a process, KSM will be disabled
>>      for the VMA's where KSM has been enabled.
> 
> Do we want to make MADV_MERGEABLE/MADV_UNMERGEABLE fail while the new
> prctl is enabled for a process?
> 
>>
>> 3. Add general_profit metric
>>
>>      The general_profit metric of KSM is specified in the documentation,
>>      but not calculated.  This adds the general profit metric to
>>      /sys/kernel/debug/mm/ksm.
>>
>> 4. Add more metrics to ksm_stat
>>
>>      This adds the process profit and ksm type metric to
>>      /proc/<pid>/ksm_stat.
>>
>> 5. Add more tests to ksm_tests
>>
>>      This adds an option to specify the merge type to the ksm_tests.
>>      This allows to test madvise and prctl KSM.  It also adds a new option
>>      to query if prctl KSM has been enabled.  It adds a fork test to verify
>>      that the KSM process setting is inherited by client processes.
>>
>> An update to the prctl(2) manpage has been proposed at [1].
>>
>> This patch (of 3):
>>
>> This adds a new prctl to API to enable and disable KSM on a per process
>> basis instead of only at the VMA basis (with madvise).
>>
>> 1) Introduce new MMF_VM_MERGE_ANY flag
>>
>>      This introduces the new flag MMF_VM_MERGE_ANY flag.  When this flag
>>      is set, kernel samepage merging (ksm) gets enabled for all vma's of a
>>      process.
>>
>> 2) add flag to __ksm_enter
>>
>>      This change adds the flag parameter to __ksm_enter.  This allows to
>>      distinguish if ksm was called by prctl or madvise.
>>
>> 3) add flag to __ksm_exit call
>>
>>      This adds the flag parameter to the __ksm_exit() call.  This allows
>>      to distinguish if this call is for an prctl or madvise invocation.
>>
>> 4) invoke madvise for all vmas in scan_get_next_rmap_item
>>
>>      If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
>>      over all the vmas and enable ksm if possible.  For the vmas that can be
>>      ksm enabled this is only done once.
>>
>> 5) support disabling of ksm for a process
>>
>>      This adds the ability to disable ksm for a process if ksm has been
>>      enabled for the process.
>>
>> 6) add new prctl option to get and set ksm for a process
>>
>>      This adds two new options to the prctl system call
>>      - enable ksm for all vmas of a process (if the vmas support it).
>>      - query if ksm has been enabled for a process.
> 
> 
> Did you consider, instead of handling MMF_VM_MERGE_ANY in a special way,
> to instead make it reuse the existing MMF_VM_MERGEABLE/VM_MERGEABLE
> infrastructure. Especially:
> 
> 1) During prctl(MMF_VM_MERGE_ANY), set VM_MERGABLE on all applicable
>      compatible. Further, set MMF_VM_MERGEABLE and enter KSM if not
>      already set.
> 
> 2) When creating a new, compatible VMA and MMF_VM_MERGE_ANY is set, set
>      VM_MERGABLE?
> 
> The you can avoid all runtime checks for compatible VMAs and only look
> at the VM_MERGEABLE flag. In fact, the VM_MERGEABLE will be completely
> expressive then for all VMAs. You don't need vma_ksm_mergeable() then.
> 
> 
> Another thing to consider is interaction with arch/s390/mm/gmap.c:
> s390x/kvm does not support KSM and it has to disable it for all VMAs. We
> have to find a way to fence the prctl (for example, fail setting the
> prctl after gmap_mark_unmergeable() ran, and make
> gmap_mark_unmergeable() fail if the prctl ran -- or handle it gracefully
> in some other way).


Staring at that code, I wonder if the "mm->def_flags &= ~VM_MERGEABLE" 
is doing what it's supposed to do. I don't think this effectively 
prevents right now madvise() from getting re-enabled on that VMA.

@Christian, Janosch, am I missing something?

-- 
Thanks,

David / dhildenb

