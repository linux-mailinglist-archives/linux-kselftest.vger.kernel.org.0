Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27F66D74C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjDEGxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjDEGxc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 02:53:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88D40F7;
        Tue,  4 Apr 2023 23:53:31 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3356hPbV019755;
        Wed, 5 Apr 2023 06:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r08tgvRQO15jrwvSRIBZIrfJm0K4iBf2MVhRW+6IRUs=;
 b=Kzs5fh0KGqgychdK3EWVRalYndC2s7cYoXTf4U1iE44XoGtnLdEU09xmTqD/7Io/H1Yk
 qlmBWRVUPHbL+Gpuv37fJF4EmbNgvktLadzQcecUjBtHDdSvjrb4XIqRORrvbIOhEXpH
 fqc7F1rBLxViKTaDKllzKH1e9CYr5i99HnefcptwE+I0PfzPk+u7fJqUdumdJ1NADqy+
 Gd4j/SJyLR1Pggrorza1MRhpqM3KL6KXFr0wIc/tc9Ny1VO2FEdPYU8adB8SKaiHp4o1
 DCr9F/XBSOMz0gHv6RsxvQ8ufvtbpKfrMnYUBXxmKjcCalHtuJtp7gUqfalaedL6W5DC kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps3ydr5bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 06:51:15 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3356i97B022143;
        Wed, 5 Apr 2023 06:51:15 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps3ydr5b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 06:51:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3344l3wD018686;
        Wed, 5 Apr 2023 06:51:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvftbkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 06:51:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3356pAQ443450910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 06:51:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C56212004D;
        Wed,  5 Apr 2023 06:51:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC8320040;
        Wed,  5 Apr 2023 06:51:09 +0000 (GMT)
Received: from [9.171.4.189] (unknown [9.171.4.189])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 06:51:09 +0000 (GMT)
Message-ID: <2229abe0-b304-6ae3-5bda-d71387c645ca@de.ibm.com>
Date:   Wed, 5 Apr 2023 08:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
To:     David Hildenbrand <david@redhat.com>,
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
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <e888871b-9f48-c01d-ce7f-f32ec3d79ef8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ShJopCrRpVEzBW-9z50IB5J8E99j3AFI
X-Proofpoint-ORIG-GUID: 7mzfY4TSQWq751ShcUqKfDdvDd9fpC9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=526 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304050060
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 03.04.23 um 13:03 schrieb David Hildenbrand:
> On 03.04.23 12:37, David Hildenbrand wrote:
>> On 10.03.23 19:28, Stefan Roesch wrote:
>>> Patch series "mm: process/cgroup ksm support", v3.
>>>
>>> So far KSM can only be enabled by calling madvise for memory regions.  To
>>> be able to use KSM for more workloads, KSM needs to have the ability to be
>>> enabled / disabled at the process / cgroup level.
>>>
>>> Use case 1:
>>>
>>>     The madvise call is not available in the programming language.  An
>>>     example for this are programs with forked workloads using a garbage
>>>     collected language without pointers.  In such a language madvise cannot
>>>     be made available.
>>>
>>>     In addition the addresses of objects get moved around as they are
>>>     garbage collected.  KSM sharing needs to be enabled "from the outside"
>>>     for these type of workloads.
>>
>> I guess the interpreter could enable it (like a memory allocator could
>> enable it for the whole heap). But I get that it's much easier to enable
>> this per-process, and eventually only when a lot of the same processes
>> are running in that particular environment.
>>
>>>
>>> Use case 2:
>>>
>>>     The same interpreter can also be used for workloads where KSM brings
>>>     no benefit or even has overhead.  We'd like to be able to enable KSM on
>>>     a workload by workload basis.
>>
>> Agreed. A per-process control is also helpful to identidy workloads
>> where KSM might be beneficial (and to which degree).
>>
>>>
>>> Use case 3:
>>>
>>>     With the madvise call sharing opportunities are only enabled for the
>>>     current process: it is a workload-local decision.  A considerable number
>>>     of sharing opportuniites may exist across multiple workloads or jobs.
>>>     Only a higler level entity like a job scheduler or container can know
>>>     for certain if its running one or more instances of a job.  That job
>>>     scheduler however doesn't have the necessary internal worklaod knowledge
>>>     to make targeted madvise calls.
>>>
>>> Security concerns:
>>>
>>>     In previous discussions security concerns have been brought up.  The
>>>     problem is that an individual workload does not have the knowledge about
>>>     what else is running on a machine.  Therefore it has to be very
>>>     conservative in what memory areas can be shared or not.  However, if the
>>>     system is dedicated to running multiple jobs within the same security
>>>     domain, its the job scheduler that has the knowledge that sharing can be
>>>     safely enabled and is even desirable.
>>>
>>> Performance:
>>>
>>>     Experiments with using UKSM have shown a capacity increase of around
>>>     20%.
>>>
>>
>> As raised, it would be great to include more details about the workload
>> where this particulalry helps (e.g., a lot of Django processes operating
>> in the same domain).
>>
>>>
>>> 1. New options for prctl system command
>>>
>>>      This patch series adds two new options to the prctl system call.
>>>      The first one allows to enable KSM at the process level and the second
>>>      one to query the setting.
>>>
>>>      The setting will be inherited by child processes.
>>>
>>>      With the above setting, KSM can be enabled for the seed process of a
>>>      cgroup and all processes in the cgroup will inherit the setting.
>>>
>>> 2. Changes to KSM processing
>>>
>>>      When KSM is enabled at the process level, the KSM code will iterate
>>>      over all the VMA's and enable KSM for the eligible VMA's.
>>>
>>>      When forking a process that has KSM enabled, the setting will be
>>>      inherited by the new child process.
>>>
>>>      In addition when KSM is disabled for a process, KSM will be disabled
>>>      for the VMA's where KSM has been enabled.
>>
>> Do we want to make MADV_MERGEABLE/MADV_UNMERGEABLE fail while the new
>> prctl is enabled for a process?
>>
>>>
>>> 3. Add general_profit metric
>>>
>>>      The general_profit metric of KSM is specified in the documentation,
>>>      but not calculated.  This adds the general profit metric to
>>>      /sys/kernel/debug/mm/ksm.
>>>
>>> 4. Add more metrics to ksm_stat
>>>
>>>      This adds the process profit and ksm type metric to
>>>      /proc/<pid>/ksm_stat.
>>>
>>> 5. Add more tests to ksm_tests
>>>
>>>      This adds an option to specify the merge type to the ksm_tests.
>>>      This allows to test madvise and prctl KSM.  It also adds a new option
>>>      to query if prctl KSM has been enabled.  It adds a fork test to verify
>>>      that the KSM process setting is inherited by client processes.
>>>
>>> An update to the prctl(2) manpage has been proposed at [1].
>>>
>>> This patch (of 3):
>>>
>>> This adds a new prctl to API to enable and disable KSM on a per process
>>> basis instead of only at the VMA basis (with madvise).
>>>
>>> 1) Introduce new MMF_VM_MERGE_ANY flag
>>>
>>>      This introduces the new flag MMF_VM_MERGE_ANY flag.  When this flag
>>>      is set, kernel samepage merging (ksm) gets enabled for all vma's of a
>>>      process.
>>>
>>> 2) add flag to __ksm_enter
>>>
>>>      This change adds the flag parameter to __ksm_enter.  This allows to
>>>      distinguish if ksm was called by prctl or madvise.
>>>
>>> 3) add flag to __ksm_exit call
>>>
>>>      This adds the flag parameter to the __ksm_exit() call.  This allows
>>>      to distinguish if this call is for an prctl or madvise invocation.
>>>
>>> 4) invoke madvise for all vmas in scan_get_next_rmap_item
>>>
>>>      If the new flag MMF_VM_MERGE_ANY has been set for a process, iterate
>>>      over all the vmas and enable ksm if possible.  For the vmas that can be
>>>      ksm enabled this is only done once.
>>>
>>> 5) support disabling of ksm for a process
>>>
>>>      This adds the ability to disable ksm for a process if ksm has been
>>>      enabled for the process.
>>>
>>> 6) add new prctl option to get and set ksm for a process
>>>
>>>      This adds two new options to the prctl system call
>>>      - enable ksm for all vmas of a process (if the vmas support it).
>>>      - query if ksm has been enabled for a process.
>>
>>
>> Did you consider, instead of handling MMF_VM_MERGE_ANY in a special way,
>> to instead make it reuse the existing MMF_VM_MERGEABLE/VM_MERGEABLE
>> infrastructure. Especially:
>>
>> 1) During prctl(MMF_VM_MERGE_ANY), set VM_MERGABLE on all applicable
>>      compatible. Further, set MMF_VM_MERGEABLE and enter KSM if not
>>      already set.
>>
>> 2) When creating a new, compatible VMA and MMF_VM_MERGE_ANY is set, set
>>      VM_MERGABLE?
>>
>> The you can avoid all runtime checks for compatible VMAs and only look
>> at the VM_MERGEABLE flag. In fact, the VM_MERGEABLE will be completely
>> expressive then for all VMAs. You don't need vma_ksm_mergeable() then.
>>
>>
>> Another thing to consider is interaction with arch/s390/mm/gmap.c:
>> s390x/kvm does not support KSM and it has to disable it for all VMAs. We

Normally we do support KSM on s390. This is a special case for guests using
storage keys. Those are attributes of the physical page and might differ even
if the content of the page is the same.
New Linux no longer uses it (unless a debug option is set during build) so we
enable the guest storage keys lazy and break KSM pages in that process.
Ideally we would continue this semantic (e.g. even after a prctl, if the
guest enable storage keys, disable ksm for this VM).

>> have to find a way to fence the prctl (for example, fail setting the
>> prctl after gmap_mark_unmergeable() ran, and make
>> gmap_mark_unmergeable() fail if the prctl ran -- or handle it gracefully
>> in some other way).
> 
> 
> Staring at that code, I wonder if the "mm->def_flags &= ~VM_MERGEABLE" is doing what it's supposed to do. I don't think this effectively prevents right now madvise() from getting re-enabled on that VMA.
> 
> @Christian, Janosch, am I missing something?

Yes, if QEMU would do an madvise later on instead of just the start if would
result in guest storage keys to be messed up on KSM merges. One could argue
that this is a bug in the hypervisor then (QEMU) but yes, we should try
to make this more reliable in the kernel.
