Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706DC44C6CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhKJSd0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 13:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230340AbhKJSdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 13:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636569037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpX5BvbKEHNdXgGoPmln1SO/jawptVK+J9B4IT3zhNs=;
        b=YXLPHBwYwk0aZH9NUhJLaIokoqEU0ssukY/tUlVr9zWYJCyB428+0y2/dAh30Q59dT+8/7
        xMTZPelHdwn+zpqLT7lZOTHXFci3k70aBasEXRWIR6GFxfXfGOLS3ojhlihxA/4hHRbANa
        BKB3u92jDYn1CALa47tl+VNv0bgjs1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-1sbKNL0MP_Ka4HrBtgzDqQ-1; Wed, 10 Nov 2021 13:30:34 -0500
X-MC-Unique: 1sbKNL0MP_Ka4HrBtgzDqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C653F1006AA0;
        Wed, 10 Nov 2021 18:30:30 +0000 (UTC)
Received: from [10.22.19.24] (unknown [10.22.19.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97F0767856;
        Wed, 10 Nov 2021 18:30:23 +0000 (UTC)
Message-ID: <a6b9f5e7-3d4d-ba84-2c80-ba70187c3e10@redhat.com>
Date:   Wed, 10 Nov 2021 13:30:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "Moessbauer, Felix" <felix.moessbauer@siemens.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
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
 <c1e94031-a179-dc72-e5ee-3f8197bea492@siemens.com>
 <20211110172946.GA30250@fuller.cnet>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211110172946.GA30250@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/10/21 12:29, Marcelo Tosatti wrote:
> On Wed, Nov 10, 2021 at 05:15:41PM +0100, Jan Kiszka wrote:
>> On 10.11.21 17:10, Marcelo Tosatti wrote:
>>> On Wed, Nov 10, 2021 at 03:21:54PM +0000, Moessbauer, Felix wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Michal Koutný <mkoutny@suse.com>
>>>>> Sent: Wednesday, November 10, 2021 2:57 PM
>>>>> To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>
>>>>> Cc: longman@redhat.com; akpm@linux-foundation.org;
>>>>> cgroups@vger.kernel.org; corbet@lwn.net; frederic@kernel.org; guro@fb.com;
>>>>> hannes@cmpxchg.org; juri.lelli@redhat.com; linux-doc@vger.kernel.org; linux-
>>>>> kernel@vger.kernel.org; linux-kselftest@vger.kernel.org;
>>>>> lizefan.x@bytedance.com; mtosatti@redhat.com; pauld@redhat.com;
>>>>> peterz@infradead.org; shuah@kernel.org; tj@kernel.org; Kiszka, Jan (T RDA
>>>>> IOT) <jan.kiszka@siemens.com>; Schild, Henning (T RDA IOT SES-DE)
>>>>> <henning.schild@siemens.com>
>>>>> Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
>>>>> empty effecitve cpus
>>>>>
>>>>> Hello.
>>>>>
>>>>> On Wed, Nov 10, 2021 at 12:13:57PM +0100, Felix Moessbauer
>>>>> <felix.moessbauer@siemens.com> wrote:
>>>>>> However, I was not able to see any latency improvements when using
>>>>>> cpuset.cpus.partition=isolated.
>>>>> Interesting. What was the baseline against which you compared it (isolcpus, no
>>>>> cpusets,...)?
>>>> For this test, I just compared both settings cpuset.cpus.partition=isolated|root.
>>>> There, I did not see a significant difference (but I know, RT tuning depends on a ton of things).
>>>>
>>>>>> The test was performed with jitterdebugger on CPUs 1-3 and the following
>>>>> cmdline:
>>>>>> rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
>>>>>> On the other cpus, stress-ng was executed to generate load.
>>>>>> [...]
>>>>>> This requires cgroup.type=threaded on both cgroups and changes to the
>>>>>> application (threads have to be born in non-rt group and moved to rt-group).
>>>>> But even with isolcpus the application would need to set affinity of threads to
>>>>> the selected CPUs (cf cgroup migrating). Do I miss anything?
>>>> Yes, that's true. But there are two differences (given that you use isolcpus):
>>>> 1. the application only has to set the affinity for rt threads.
>>>>   Threads that do not explicitly set the affinity are automatically excluded from the isolated cores.
>>>>   Even common rt test applications like jitterdebugger do not pin their non-rt threads.
>>>> 2. Threads can be started on non-rt CPUs and then bound to a specific rt CPU.
>>>> This binding can be specified before thread creation via pthread_create.
>>>> By that, you can make sure that at no point in time a thread has a "forbidden" CPU in its affinities.
>>>>
>>>> With cgroup2, you cannot guarantee the second aspect, as thread creation and moving to a cgroup is not an atomic operation.
>>>> Also - please correct me if I'm wrong - you first have to create a thread before moving it into a group.
>>>> At creation time, you cannot set the final affinity mask (as you create it in the non-rt group and there the CPU is not in the cpuset.cpus).
>>>> Once you move the thread to the rt cgroup, it has a default mask and by that can be executed on other rt cores.
>>> man clone3:
>>>
>>>         CLONE_NEWCGROUP (since Linux 4.6)
>>>                Create  the  process  in  a  new cgroup namespace.  If this flag is not set, then (as with fork(2)) the
>>>                process is created in the same cgroup namespaces as the calling process.
>>>
>>>                For further information on cgroup namespaces, see cgroup_namespaces(7).
>>>
>>>                Only a privileged process (CAP_SYS_ADMIN) can employ CLONE_NEWCGROUP.
>>>
>> Is there pthread_attr_setcgroup_np()?
>>
>> Jan
> Don't know... Waiman?

I don't think there is such libpthread call yet.

-Longman

