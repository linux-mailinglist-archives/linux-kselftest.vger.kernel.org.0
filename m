Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E27467E37
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382809AbhLCTbN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 14:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382770AbhLCTbL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 14:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638559667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmMKiB3N4p3pnZNkTKPE5eWVpNIexw+a16FHU/X1k2I=;
        b=JzKi1EOtus5AARSFgVyzm079n5Lp4zzN20+UxSNIwPLfjzq2YiDnP+rlOzBlgebBZ7xC8T
        UnJaHQCEs3uFPSgRsvkvI7nSEYO1ESr843huzHY9W1+Sg+C/ALGOxKqZ9W+I5zeP/FKHRQ
        kutpPBOf1vCgukiWhORlnBZ5Maip3LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-JaaTEwooP-GuQcILlIVSxQ-1; Fri, 03 Dec 2021 14:27:42 -0500
X-MC-Unique: JaaTEwooP-GuQcILlIVSxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C495A81CCC8;
        Fri,  3 Dec 2021 19:27:39 +0000 (UTC)
Received: from [10.22.32.36] (unknown [10.22.32.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7CF760BD8;
        Fri,  3 Dec 2021 19:27:20 +0000 (UTC)
Message-ID: <583191c1-4153-cee8-1836-a4037b9ea304@redhat.com>
Date:   Fri, 3 Dec 2021 14:27:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
References: <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <Yaem+r/YZ9BNXv9R@slm.duckdns.org>
 <4a021678-1896-2d16-4075-f626c7ab8513@redhat.com>
 <8f56f7a3-1d4b-679b-7348-d8ecb4ef3d6c@redhat.com>
 <20211203182500.GD16798@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211203182500.GD16798@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/3/21 13:25, Michal Koutný wrote:
> Hello Longman.
>
> On Wed, Dec 01, 2021 at 08:28:09PM -0500, Waiman Long <longman@redhat.com> wrote:
>> 1) The limitation that "cpuset.cpus" has to be a superset of child's
>> "cpuset.cpus" has been removed as a new patch to remove that limitation will
>> be added.
> Superb!
>
>> 2) The initial transition from "member" to partition root now requires that
>> "cpuset.cpus" overlap with that of the parent's "cpuset.cpus" instead of
>> being a superset.
> That's sensible.
>
>> For the transition back to "member", I haven't changed the current wording
>> of forcing child partition roots to become "member" yet. If you think
>> keeping them as invalid partition root is better, I can made that change
>> too.
> I wrote I was indifferent about this in a previous mail but when I think
> about it now, switching to invalid root is perhaps better than switching
> to member since it'd effectively mean that modifications of the parent
> config propagate (permanently) also to a descendant config, which is
> an undesired v1-ism.

That makes sense. I will keep those child partitions in an invalid state 
then.

>
>> Please let me know what other changes you would like to see.
> I hope my remarks below are just clarifications and not substantial
> changes. Besides that I find your new draft good. Thanks!
>
>> [...]
>>      An invalid partition root can be reverted back to a valid one
>>      if none of the validity constraints of a valid partition root
>>      are violated.
> s/can be/will be/
>
> (I understand the intention is to make it asynchronously and
> automatically, i.e. without writing into the affected descendant(s)
> cpuset.partition again.)
Yes, that will be automatic and the partition will become valid again if 
other events cause changes that unbreak the validity constraints.
>
>>      Poll and inotify events are triggered whenever the state of
>>      "cpuset.cpus.partition" changes.  That includes changes caused by
>>      write to "cpuset.cpus.partition", cpu hotplug and other changes
>>      that make the partition invalid.
> -> that change validity status
>
> (In accordance with the comment above.)
Cheers,
Longman

