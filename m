Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF33FA114
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhH0VU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 17:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231949AbhH0VU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 17:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630099176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1joG16srsSQx+ASNF6WUB8jVFgT0G7DpTPaFt49UTk=;
        b=IiVlZ5hrZjk/El5+X2fYBivxEuPoqmen8nx2xxFUXiSnNNIvJo8vPoVrng3pHrwHMP090z
        jIMfP/0NteL4eAJqCeW2g29O3dSLrUY8/KymEVI22shxLZug0IM70Laf9QIHoE5oLHneT7
        8qQg9GZb27YJq6PgSKd0lbQxJpOOg9g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-MomvVddJMiqTGppAygwSsw-1; Fri, 27 Aug 2021 17:19:35 -0400
X-MC-Unique: MomvVddJMiqTGppAygwSsw-1
Received: by mail-qt1-f199.google.com with SMTP id c11-20020ac87dcb0000b0290293566e00b1so365932qte.15
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 14:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U1joG16srsSQx+ASNF6WUB8jVFgT0G7DpTPaFt49UTk=;
        b=FzIk1nyMr0CxaSgaIVIuxCPiiBYUGiywc+P+QIPA5sLCxXcUIHLWxUc0Ry4muDOtUk
         Q5SQflul2VRsH4cwZ2BltTcPbdDBrsVp8DXkPwNSrOVWeuuhOuy6E5J7iw5u2bAVNegu
         sYftkDiwdsbOtGfTkoB0hQUpf2cKlFQFcAeoFYrdBx5qaS1XmdFKsZ7A8CBmn+jfDsgu
         SNvfGyfUNFlozgwqOkiwSaN+CJfFtMQpcZZTX1VM6cUr3JeCySJCFkrwRpESBHyLHPeD
         QzjoHmflVpAcmPf2dHwC5B/srMLZh+rBFEPNOoWn3BNJDTkhUZsTwXcnSN0IdiiERWRx
         QxHw==
X-Gm-Message-State: AOAM531czcuyXNj+U/zK2GRwNtGD54YECz4m4NYI+GRFRLM/aMoS8Qp9
        xD4w9bIg11u/M3MRtB4UuXm9JyrZhfTLAfvX4AF94omJryw6Tv1flR/2IP1SvXUUOoKeQo261Kw
        Uyr1h2UrCG0kUVp3nDITtCVyuMAxW
X-Received: by 2002:ac8:5905:: with SMTP id 5mr10126462qty.286.1630099174844;
        Fri, 27 Aug 2021 14:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSgcChWoGG7JzhgBHKTsf5bPMKevttJCBAb34KxbwiSpBx7V0ruD8rOHDWgSN7ARHcPzidpQ==
X-Received: by 2002:ac8:5905:: with SMTP id 5mr10126447qty.286.1630099174585;
        Fri, 27 Aug 2021 14:19:34 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 75sm5578360qko.100.2021.08.27.14.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 14:19:33 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com> <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
Message-ID: <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
Date:   Fri, 27 Aug 2021 17:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YShjb2WwvuB4s4gX@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/21 12:00 AM, Tejun Heo wrote:
> Hello,
>
> On Thu, Aug 26, 2021 at 11:01:30PM -0400, Waiman Long wrote:
>> What I am doing here is setting a high bar for transitioning from member to
>> either "root" or "isolated". Once it becomes a partition, there are multiple
>> ways that can make it invalid. I am fine with that. However, I am not sure
>> it is a good idea to allow users to echo "root" to cpuset.cpus.partition
>> anywhere in the cgroup hierarchy and require them to read it back to see if
>> it succeed.
> The problem is that the "high" bar is rather arbitrary. It might feel like a
> good idea to some but not to others. There are no clear technical reasons or
> principles for rules to be set this particular way.
>
>> All the checking are done with cpuset_rwsem held. So there shouldn't be any
>> racing. Of course, a hotplug can immediately follow and make the partition
>> invalid.
> Imagine a system which dynamically on/offlines its cpus based on load or
> whatever and also configures partitions for cases where the needed cpus are
> online. If the partitions are set up while the cpus are online, it'd work as
> expected - partitions are in effect when the system can support them and
> ignored otherwise. However, if the partition configuration is attempted
> while the cpus happen to be offline, the configuration will fail, and there
> is no guaranteed way to make that configuration stick short of disabling
> hotplug operations. This is a pretty jarring brekage happening exactly
> because the behavior is an inconsistent amalgam.
>
> It's usually not a good sign if interface restrictions can be added or
> removed because how one feels without clear functional reasons and often
> indicates that there's something broken, which seems to be the case here
> too.

Well, that is a valid point. The cpus may have been offlined when a 
partition is being created. I can certainly relent on this check in 
forming a partition. IOW, cpus_allowed can contain some or all offline 
cpus and a valid (some are online) or invalid (all are offline) 
partition can be formed. I can also allow an invalid child partition to 
be formed with an invalid parent partition. However, the cpu exclusivity 
rules will still apply.

Other than that, do you envision any other circumstances where we should 
allow an invalid partition to be formed?

Cheers,
Longman


