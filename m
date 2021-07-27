Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE53D7A44
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhG0P4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 11:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0P43 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627401389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M3++Uh/orxff5EIZBKy/srZv4TUlnGzA4HSvE27QDsA=;
        b=A8b2TbZd0oiRs1et6u0tkufC8um05yBWjj1hy5MbxtGAvDGwvB5ZfzgMUZMZoQ6HbXqJlJ
        CilyZ55K2oTdXPWHb1EMNG9tfzbUUtSV9ni05BMmDwX2HfpNK4117XPt3NS/ErVSqENJlX
        IZnagZuSizTEwaWwelIC+i2PjPWhkK0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-ciE-PgH_Nbm_E5aMP6axYg-1; Tue, 27 Jul 2021 11:56:27 -0400
X-MC-Unique: ciE-PgH_Nbm_E5aMP6axYg-1
Received: by mail-qv1-f71.google.com with SMTP id j13-20020a0cf30d0000b029032dd803a7edso4999807qvl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jul 2021 08:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M3++Uh/orxff5EIZBKy/srZv4TUlnGzA4HSvE27QDsA=;
        b=YWisXMbo52lugc7sXEacQa77wvnqqrnbut0vubbOat7enUs9kYkZqq+JBnu1fPh/Z0
         Tjuy/reOtLaX56OQNbX/Ta6b5Y5xP3Qig+/Dh4DgSPzEvI84tVrcnQazof329KIZL/MI
         z4ukiniQ8evn3K8W6j/3F83mbeagYW9hx4oW4sW4nO7vu5KfmNbeCzCUZRcfLWTXhTHE
         ze2bQavkS4HwUYMKwUzvsFYXEw8mVbSmw/GpDZ/a1fKbSJtpuvqwdr2izOoa/2DJAKhc
         4xGOcne+oa7cPPT3Fbk8PbmBzRivJs4l1Pq9qUIQvIF6OeAVeTUAGUf7A1iIi/u5itQX
         gKLA==
X-Gm-Message-State: AOAM5330cW8P1HnblS8wwwrnGKt9J/YnYm6QfiuaHKqedSUMbZJOdJXQ
        PKHyVm5xEe62rcM9a0urdsIeTcwiMV7uP7ZX0O4IzTFI4FpLCzXbvL3i6glkTQkNQV3MEAVvtW8
        WUdBXc5ru5P5Igdks7dIxVw3fvXtJ
X-Received: by 2002:a05:620a:144f:: with SMTP id i15mr2554919qkl.141.1627401387486;
        Tue, 27 Jul 2021 08:56:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeSFpy0BYRIiUW3L3SoYPBsJAPD4HjQ8IIUy8HhXP2xL5mg/BQ8YvSLnsUaQvb4IAEoafshA==
X-Received: by 2002:a05:620a:144f:: with SMTP id i15mr2554890qkl.141.1627401387211;
        Tue, 27 Jul 2021 08:56:27 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 12sm1879417qkr.10.2021.07.27.08.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 08:56:26 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 6/9] cgroup/cpuset: Add a new isolated cpus.partition
 type
To:     Frederic Weisbecker <frederic@kernel.org>
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-7-longman@redhat.com>
 <20210727114241.GA283787@lothringen>
Message-ID: <fe3d9fcb-c3af-9214-c69f-00ef36521c5c@redhat.com>
Date:   Tue, 27 Jul 2021 11:56:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727114241.GA283787@lothringen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/27/21 7:42 AM, Frederic Weisbecker wrote:
> On Tue, Jul 20, 2021 at 10:18:31AM -0400, Waiman Long wrote:
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=TBD
>>
>> commit 994fb794cb252edd124a46ca0994e37a4726a100
>> Author: Waiman Long <longman@redhat.com>
>> Date:   Sat, 19 Jun 2021 13:28:19 -0400
>>
>>      cgroup/cpuset: Add a new isolated cpus.partition type
>>
>>      Cpuset v1 uses the sched_load_balance control file to determine if load
>>      balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>>      as its use may require disabling load balancing at cgroup root.
>>
>>      For workloads that require very low latency like DPDK, the latency
>>      jitters caused by periodic load balancing may exceed the desired
>>      latency limit.
>>
>>      When cpuset v2 is in use, the only way to avoid this latency cost is to
>>      use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
>>      the kernel boot, however, there is no way to add or remove CPUs from
>>      this isolated set. For workloads that are more dynamic in nature, that
>>      means users have to provision enough CPUs for the worst case situation
>>      resulting in excess idle CPUs.
>>
>>      To address this issue for cpuset v2, a new cpuset.cpus.partition type
>>      "isolated" is added which allows the creation of a cpuset partition
>>      without load balancing. This will allow system administrators to
>>      dynamically adjust the size of isolated partition to the current need
>>      of the workload without rebooting the system.
>>
>>      Signed-off-by: Waiman Long <longman@redhat.com>
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Nice! And while we are adding a new ABI, can we take advantage of that and
> add a specific semantic that if a new isolated partition matches a subset of
> "isolcpus=", it automatically maps to it. This means that any further
> modification to that isolated partition will also modify the associated
> isolcpus= subset.
>
> Or to summarize, when we create a new isolated partition, remove the associated
> CPUs from isolcpus= ?

We can certainly do that as a follow-on. Another idea that I have been 
thinking about is to automatically generating a isolated partition under 
root to match the given isolcpus parameter when the v2 filesystem is 
mounted. That needs more experimentation and testing to verify that it 
can work.

Cheers,
Longman

