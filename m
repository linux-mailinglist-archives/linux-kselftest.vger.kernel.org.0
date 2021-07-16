Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE673CBBFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jul 2021 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhGPSr3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 14:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhGPSr1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 14:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626461071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RoDupO6M1bVRrm6W8ZOvDrptNGSB7yFCE/hhZqmCP0=;
        b=RwDNRDvOsdUGbZ6Zfo4pFN7JYKQ6czviRweCPE2uYNRxkfI5K6AqHm8W35+yFcfpsNviIt
        7TQSeSDxHobZC3LFq63k9mx20gMpQo6Z0PhzPYC1bt0/cw4GvF/aJ4PbKCXx1727mOw77V
        MkHYfjVInL2WGvZyhwzKVksD5pIZ2IU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-8gcCDXdOMRmf-H-CmSCVAg-1; Fri, 16 Jul 2021 14:44:30 -0400
X-MC-Unique: 8gcCDXdOMRmf-H-CmSCVAg-1
Received: by mail-qv1-f70.google.com with SMTP id r13-20020a0cf60d0000b02902f3a4c41d77so7297053qvm.18
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jul 2021 11:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7RoDupO6M1bVRrm6W8ZOvDrptNGSB7yFCE/hhZqmCP0=;
        b=a/e3ZQK4IZBzGmM93LRWOU/A236Dsz89yKZEajDj/FOJb8x9UKth4UqHj7kF/DaAiL
         ufjvd/ESG92euvGOywUSGJp3SXRsLtSITR+AjwInahkKMdw5O9Ds0xr816eDsb0EFXUp
         9mZ17ATp6sFVT5LLvmQ0NsIuC9TgWlJyl5Ihpz+amzkxDdFFbGCrhibBpEQSefwVpIeG
         RekH+EkhI5+0zPPqXWwbUZpVBTlLYJH482Vf8AQVHO7vdgfqRl5uciG07GKw/rki5PgB
         rEvGmr7wXSfUyRoUO9QuxQOJp1ZW1m9JjBgQkCVBU0JZ+0IN6+WekySUYBGeMLlVcY1f
         j3sg==
X-Gm-Message-State: AOAM531zyEYFGcGc977tI9cCWAf+x4+MWZqUfP5FEInWy6g1iG2svYdh
        th1lAVuUoHNn5qbdMP3/LKkNpoVSMrHL9pj/Sr7vjUxottS4kTeWapZFJBJPixEHIjF+zsIoELm
        La8QXp79ExKTXkZfav/rip2YS4Mal
X-Received: by 2002:a05:622a:170d:: with SMTP id h13mr10563989qtk.264.1626461070120;
        Fri, 16 Jul 2021 11:44:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydn1Bq/Od/FhPPzfBC0XbXQPdklkUWDSUSQGqXvXC0USgTcignUQvoPYX4S8z7m7xo5sIAMg==
X-Received: by 2002:a05:622a:170d:: with SMTP id h13mr10563965qtk.264.1626461069928;
        Fri, 16 Jul 2021 11:44:29 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a16sm4177617qkn.107.2021.07.16.11.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:44:29 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
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
        Juri Lelli <juri.lelli@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
 <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
 <YONGk3iw/zrNzwLK@mtj.duckdns.org>
Message-ID: <c6ae2d9b-ad6e-9bbd-b25c-f52b0ff6fb9b@redhat.com>
Date:   Fri, 16 Jul 2021 14:44:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YONGk3iw/zrNzwLK@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/5/21 1:51 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Jun 28, 2021 at 09:06:50AM -0400, Waiman Long wrote:
>> The main reason for doing this is because normal cpuset control file actions
>> are under the direct control of the cpuset code. So it is up to us to decide
>> whether to grant it or deny it. Hotplug, on the other hand, is not under the
>> control of cpuset code. It can't deny a hotplug operation. This is the main
>> reason why the partition root error state was added in the first place.
> I have a difficult time convincing myself that this difference justifies the
> behavior difference and it keeps bothering me that there is a state which
> can be reached through one path but rejected by the other. I'll continue
> below.
>
>> Normally, users can set cpuset.cpus to whatever value they want even though
>> they are not actually granted. However, turning on partition root is under
>> more strict control. You can't turn on partition root if the CPUs requested
>> cannot actually be granted. The problem with setting the state to just
>> partition error is that users may not be aware that the partition creation
>> operation fails.  We can't assume all users will do the proper error
>> checking. I would rather let them know the operation fails rather than
>> relying on them doing the proper check afterward.
>>
>> Yes, I agree that it is a different philosophy than the original cpuset
>> code, but I thought one reason of doing cgroup v2 is to simplify the
>> interface and make it a bit more erorr-proof. Since partition root creation
>> is a relatively rare operation, we can afford to make it more strict than
>> the other operations.
> So, IMO, one of the reasons why cgroup1 interface was such a mess was
> because each piece of interaction was designed ad-hoc without regard to the
> overall consistency. One person feels a particular way of interacting with
> the interface is "correct" and does it that way and another person does
> another part in a different way. In the end, we ended up with a messy
> patchwork.
>
> One problematic aspect of cpuset in cgroup1 was the handling of failure
> modes, which was caused by the same exact approach - we wanted the interface
> to reject invalid configurations outright even though we didn't have the
> ability to prevent those configurations from occurring through other paths,
> which makes the failure mode more subtle by further obscuring them.
>
> I think a better approach would be having a clear signal and mechanism to
> watch the state and explicitly requiring users to verify and monitor the
> state transitions.

Sorry for the late reply as I was busy with other works.

I agree with you on principle. However, the reason why there are more 
restrictions on enabling partition is because I want to avoid forcing 
the users to always read back cpuset.partition.type to see if the 
operation succeeds instead of just getting an error from the operation. 
The former approach is more error prone. If you don't want changes in 
existing behavior, I can relax the checking and allow them to become an 
invalid partition if an illegal operation happens.

Also there is now another cpuset patch to extend cpu isolation to cgroup 
v1 [1]. I think it is better suit to the cgroup v2 partition scheme, but 
cgroup v1 is still quite heavily out there.

Please let me know what you want me to do and I will send out a v3 version.

Thanks a lot!
Longman

