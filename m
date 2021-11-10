Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15844C4EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhKJQTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 11:19:04 -0500
Received: from gecko.sbs.de ([194.138.37.40]:50079 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhKJQTD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 11:19:03 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AAGFiIM029239
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 17:15:44 +0100
Received: from [167.87.75.31] ([167.87.75.31])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1AAGFfna016041;
        Wed, 10 Nov 2021 17:15:41 +0100
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        "Moessbauer, Felix" <felix.moessbauer@siemens.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
 <20211110135653.GD20566@blackbody.suse.cz>
 <AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211110161020.GA20101@fuller.cnet>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c1e94031-a179-dc72-e5ee-3f8197bea492@siemens.com>
Date:   Wed, 10 Nov 2021 17:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110161020.GA20101@fuller.cnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10.11.21 17:10, Marcelo Tosatti wrote:
> On Wed, Nov 10, 2021 at 03:21:54PM +0000, Moessbauer, Felix wrote:
>>
>>
>>> -----Original Message-----
>>> From: Michal Koutný <mkoutny@suse.com>
>>> Sent: Wednesday, November 10, 2021 2:57 PM
>>> To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>
>>> Cc: longman@redhat.com; akpm@linux-foundation.org;
>>> cgroups@vger.kernel.org; corbet@lwn.net; frederic@kernel.org; guro@fb.com;
>>> hannes@cmpxchg.org; juri.lelli@redhat.com; linux-doc@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-kselftest@vger.kernel.org;
>>> lizefan.x@bytedance.com; mtosatti@redhat.com; pauld@redhat.com;
>>> peterz@infradead.org; shuah@kernel.org; tj@kernel.org; Kiszka, Jan (T RDA
>>> IOT) <jan.kiszka@siemens.com>; Schild, Henning (T RDA IOT SES-DE)
>>> <henning.schild@siemens.com>
>>> Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
>>> empty effecitve cpus
>>>
>>> Hello.
>>>
>>> On Wed, Nov 10, 2021 at 12:13:57PM +0100, Felix Moessbauer
>>> <felix.moessbauer@siemens.com> wrote:
>>>> However, I was not able to see any latency improvements when using
>>>> cpuset.cpus.partition=isolated.
>>>
>>> Interesting. What was the baseline against which you compared it (isolcpus, no
>>> cpusets,...)?
>>
>> For this test, I just compared both settings cpuset.cpus.partition=isolated|root.
>> There, I did not see a significant difference (but I know, RT tuning depends on a ton of things).
>>
>>>
>>>> The test was performed with jitterdebugger on CPUs 1-3 and the following
>>> cmdline:
>>>> rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
>>>> On the other cpus, stress-ng was executed to generate load.
>>>> [...]
>>>
>>>> This requires cgroup.type=threaded on both cgroups and changes to the
>>>> application (threads have to be born in non-rt group and moved to rt-group).
>>>
>>> But even with isolcpus the application would need to set affinity of threads to
>>> the selected CPUs (cf cgroup migrating). Do I miss anything?
>>
>> Yes, that's true. But there are two differences (given that you use isolcpus):
>> 1. the application only has to set the affinity for rt threads.
>>  Threads that do not explicitly set the affinity are automatically excluded from the isolated cores.
>>  Even common rt test applications like jitterdebugger do not pin their non-rt threads.
>> 2. Threads can be started on non-rt CPUs and then bound to a specific rt CPU.
>> This binding can be specified before thread creation via pthread_create.
>> By that, you can make sure that at no point in time a thread has a "forbidden" CPU in its affinities.
>>
>> With cgroup2, you cannot guarantee the second aspect, as thread creation and moving to a cgroup is not an atomic operation.
>> Also - please correct me if I'm wrong - you first have to create a thread before moving it into a group.
>> At creation time, you cannot set the final affinity mask (as you create it in the non-rt group and there the CPU is not in the cpuset.cpus).
>> Once you move the thread to the rt cgroup, it has a default mask and by that can be executed on other rt cores.
> 
> man clone3:
> 
>        CLONE_NEWCGROUP (since Linux 4.6)
>               Create  the  process  in  a  new cgroup namespace.  If this flag is not set, then (as with fork(2)) the
>               process is created in the same cgroup namespaces as the calling process.
> 
>               For further information on cgroup namespaces, see cgroup_namespaces(7).
> 
>               Only a privileged process (CAP_SYS_ADMIN) can employ CLONE_NEWCGROUP.
> 

Is there pthread_attr_setcgroup_np()?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
