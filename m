Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0664645A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 04:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbhLAEAK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 23:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345676AbhLAEAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 23:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638331009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYPz1TwK62zcw/lQOKlOkIWpT4m/iI29fxtGFyZ0JI4=;
        b=dN569vjXHJ0BObHYY0Y8Iw/JAJrXR1OZfqbbMTFz9JwEA0fB/1gDaivdOYz4W4ISJ5jwOz
        XJPr+5wSczdi4S+48SuaAUX6UV4f5qxkDVnvOUFsamUIf5X+1XjquQAc11CdJimqZfLNrR
        PFYXaa8QEaMyu53yzUTbhYiXuU3mM0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-CvQVTj-AP8Wl3lEo7wuR4A-1; Tue, 30 Nov 2021 22:56:44 -0500
X-MC-Unique: CvQVTj-AP8Wl3lEo7wuR4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF3C104ECE6;
        Wed,  1 Dec 2021 03:56:41 +0000 (UTC)
Received: from [10.22.16.172] (unknown [10.22.16.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C52EC19EF9;
        Wed,  1 Dec 2021 03:56:34 +0000 (UTC)
Message-ID: <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
Date:   Tue, 30 Nov 2021 22:56:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YaZbXArNIMNvwJD/@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/30/21 12:11, Tejun Heo wrote:
> Hello, Waiman.
>
> On Tue, Nov 30, 2021 at 10:35:19AM -0500, Waiman Long wrote:
>>      On read, the "cpuset.cpus.partition" file can show the following
>>      values.
>>
>>        ======================    ==============================
>>        "member"            Non-root member of a partition
>>        "root"            Partition root
>>        "isolated"            Partition root without load balancing
>>        "root invalid (<reason>)"    Invalid partition root
>>        ======================    ==============================
> What happens if an isolated domain becomes invalid and then valid again due
> to cpu hotplug? Does it go "root invalid" and then back to "isolated"?
Yes, the current code allow recovering from an invalid state. In this 
particular case, the transition will be "isolated" --> "root invalid" 
--> "isolated".
> ...
>>      Before the "member" to partition root transition can happen,
>>      the following conditions must be met or the transition will
>>      not be allowed.
>>
>>      1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
>>         not shared by any of its siblings.
>>      2) The parent cgroup is a valid partition root.
>>      3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".
>>      4) There is no child cgroups with cpuset enabled.  This avoids
>>         cpu migrations of multiple cgroups simultaneously which can
>>         be problematic.
> So, I still have a hard time justifying the above restrictions. 1) can be
> broken through hotplug anyway. 2) can be broken by the parent switching to
> member. 3) would mean that we'd need to restrict parent's config changes
> depending on what children are doing. 4) is more understandable but it's an
> implementation detail that we can address in the future.
>
The initial transition to a partition root has a higher barrier. Once it 
becomes a partition root. Some restrictions are relaxed.

>>      Once becoming a partition root, the following two rules restrict
>>      what changes can be made to "cpuset.cpus".
>>
>>      1) The value must be exclusive.
>>      2) If child cpusets exist, the value must be a superset of what
>>         are defined in the child cpusets.
>>
>>      The second rule applies even for "member". Other changes to
>>      "cpuset.cpus" that do not violate the above rules are always
>>      allowed.
> While it isn't necessarily tied to this series, it's a big no-no to restrict
> what a parent can do depending on what its descendants are doing. A cgroup
> higher up in the hierarchy should be able to change configuration however it
> sees fit as deligation breaks down otherwise.
>
> Maybe you can argue that cpuset is special and shouldn't be subject to such
> convention but I can't see strong enough justifications especially given
> that most of these restrictions can be broken by hotplug operations anyway
> and thus need code to handle those situations.

These are all pre-existing restrictions before the introduction of 
partition. These are checks done in validate_change(). I am just saying 
out loud the existing behavior. If you think that needs to be changed, I 
am fine with that. However, it will be a separate patch as it is not a 
behavior that is introduced by this series.


>>      Changing a partition root (valid or invalid) to "member" is
>>      always allowed.  If there are child partition roots underneath
>>      it, however, they will be forced to be switched back to "member"
>>      too and lose their partitions. So care must be taken to double
>>      check for this condition before disabling a partition root.
> Wouldn't it make more sense for them to retain their configuration and turn
> invalid? Why is this special?

Once an invalid partition is changed to "member", there is no way for a 
child invalid partition root to recover and become valid again. There is 
why I force them to become "member" also. I am OK if you believe it is 
better to keep them in the invalid state forever until we explicitly 
changed them to "member" eventually.


>
>>      A valid parent partition may distribute out all its CPUs to
>>      its child partitions as long as it is not the root cgroup and
>>      there is no task associated with it.
> A valid parent partition which isn't root never has tasks in them to begin
> with.
I believe there is some corner cases where it is possible to put task in 
an intermediate partition. That is why I put down this statement.

Cheers,
Longman

