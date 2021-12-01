Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD9464F9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349923AbhLAObC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349922AbhLAOae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638368827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXrqNOrDvSgD387N15SkHeYtKspYajLx2tWsnOoBWmw=;
        b=XFjjfA/qsAGgmpeK12okClbS5nnO648FvGoqH22hqbT5RfUaPFqbEDgmzKArObZljJw1DU
        kWFZH+hKH0efhNQoe7ZR7tvOU2GdsTE9mCvvUH/N4fah0WrNvloLESh6YwWDaBtS2MPUXd
        OIV/QNYNJnfHkfeD3pkn3boyMroDXvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228--osOsuLxOqizeWeuns8tUA-1; Wed, 01 Dec 2021 09:27:04 -0500
X-MC-Unique: -osOsuLxOqizeWeuns8tUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C18801023F4F;
        Wed,  1 Dec 2021 14:27:01 +0000 (UTC)
Received: from [10.22.10.179] (unknown [10.22.10.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A63910016F7;
        Wed,  1 Dec 2021 14:26:44 +0000 (UTC)
Message-ID: <0bdfb7f2-61ee-7b2a-fdb2-3c41f6d6ade0@redhat.com>
Date:   Wed, 1 Dec 2021 09:26:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
In-Reply-To: <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/30/21 22:56, Waiman Long wrote:
> On 11/30/21 12:11, Tejun Heo wrote:
>
>
>>>      Once becoming a partition root, the following two rules restrict
>>>      what changes can be made to "cpuset.cpus".
>>>
>>>      1) The value must be exclusive.
>>>      2) If child cpusets exist, the value must be a superset of what
>>>         are defined in the child cpusets.
>>>
>>>      The second rule applies even for "member". Other changes to
>>>      "cpuset.cpus" that do not violate the above rules are always
>>>      allowed.
>> While it isn't necessarily tied to this series, it's a big no-no to 
>> restrict
>> what a parent can do depending on what its descendants are doing. A 
>> cgroup
>> higher up in the hierarchy should be able to change configuration 
>> however it
>> sees fit as deligation breaks down otherwise.
>>
>> Maybe you can argue that cpuset is special and shouldn't be subject 
>> to such
>> convention but I can't see strong enough justifications especially given
>> that most of these restrictions can be broken by hotplug operations 
>> anyway
>> and thus need code to handle those situations.
>
> These are all pre-existing restrictions before the introduction of 
> partition. These are checks done in validate_change(). I am just 
> saying out loud the existing behavior. If you think that needs to be 
> changed, I am fine with that. However, it will be a separate patch as 
> it is not a behavior that is introduced by this series.

Of the 2 restrictions listed above, the exclusivity rule is due to the 
use of CS_CPU_EXCLUSIVE flag. I think it is reasonable as it affects 
only siblings, not the parent.

The second restriction was found during my testing. It is caused by the 
following code in validate_change():

         /* Each of our child cpusets must be a subset of us */
         ret = -EBUSY;
         cpuset_for_each_child(c, css, cur)
                 if (!is_cpuset_subset(c, trial))
                         goto out;

It seems that this code was there since v2.6.12 (the beginning of the 
git era). Later in function, we have

         /* On legacy hierarchy, we must be a subset of our parent 
cpuset. */
         ret = -EACCES;
         if (!is_in_v2_mode() && !is_cpuset_subset(trial, par))
                 goto out;

This is actually a duplicate in the case of legacy hierarchy.

I can add a patch to take out the first code block above which I think 
is where most of your objections are. Then I can remove the 2nd 
restriction in my documentation. I would like to emphasize that this is 
a pre-existing behavior which I just happen to document.

Cheers,
Longman

