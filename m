Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7243E9777
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhHKSSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhHKSSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628705901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sdWMe6I8w2i60A4RZfVZLGm7Z1MFMDLriAO19Jv51I=;
        b=OWFDuSJEd6axoR49rdB1w7XTGmrTX1NxmOYalBKZzsEwukaD0xwLLmLPynGodZrpSDiPwU
        kid381Zk2qxgo4/pZO+atYXEEQh3V/c4qYZULqPOQL6mGENBSoB12BMvpO0n9oHKZEGg3d
        MbewhWHGQ1FgdUGSuBz1ZGNCV+fLXJ4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-lIvvKxcgMl6sn2UuKemZkA-1; Wed, 11 Aug 2021 14:18:20 -0400
X-MC-Unique: lIvvKxcgMl6sn2UuKemZkA-1
Received: by mail-qk1-f199.google.com with SMTP id x2-20020a05620a0ec2b02903b8bd8b612eso1844492qkm.19
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Aug 2021 11:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4sdWMe6I8w2i60A4RZfVZLGm7Z1MFMDLriAO19Jv51I=;
        b=PIy42CMhIi5EyE2Dwx1IpDMmegNaZGQgs4Tr5hVqM5u9nqIaLBJe/pJj0qkViseF5m
         2IVdbYpn6PU9AVjUDmmO8ezISIiNRomH7PZgLu80IkGHs+1bdc0qn/XcX+t8wh7B8rvi
         0FyQPGS4kVWR7YpZ/3Qute0qw/89zQOWGTe/JXiyYuKSLNNWDGAkFbWaYEwrYLp0d4Jt
         IUay7SWDoHp5fTBtDzhrBdM8P8oBnuzPICVEXcBBtjJlfavSOVaYpCayUaeIG5l0u66Z
         FqrwRX9szKgahP+eWS2aXMR/cQjDen2mYBVGeZCbDsKAHlLLjDo9oE38jeT8aAIRuPM6
         1Q4A==
X-Gm-Message-State: AOAM5300cfSOmrTphG8Dwsd9Fdz1wvUCk7lpy6odz2OndHl2flW5bmEy
        aUPmK/ZsDRP+8O43+TjkIEzoz5ygtzushhttuBrUfL7GF1iDP5oXNj6cShLR91df9fypY515CBE
        TsupxIGkK/o4JVXKvfm3QOUf0jg2E
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr24540283qvb.13.1628705899517;
        Wed, 11 Aug 2021 11:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMRVK++tAy3NAo+jUnQ3F2vejRbQTm+/+F0mBpaBHrAr6FPUsKJ8ztdb4qjZs9fOBOrjGeWw==
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr24540261qvb.13.1628705899355;
        Wed, 11 Aug 2021 11:18:19 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id e18sm18303qtq.16.2021.08.11.11.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:18:18 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition root
 to distribute out all CPUs
To:     Tejun Heo <tj@kernel.org>
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
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-5-longman@redhat.com>
 <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
Message-ID: <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
Date:   Wed, 11 Aug 2021 14:18:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/11/21 2:13 PM, Tejun Heo wrote:
> On Tue, Aug 10, 2021 at 11:06:05PM -0400, Waiman Long wrote:
>> Currently, a parent partition root cannot distribute all its CPUs to
>> child partition roots with no CPUs left. However in some use cases,
>> a management application may want to create a parent partition root as
>> a management unit with no task associated with it and has all its CPUs
>> distributed to various child partition roots dynamically according to
>> their needs. Leaving a cpu in the parent partition root in such a case is
>> now a waste.
>>
>> To accommodate such use cases, a parent partition root can now have
>> all its CPUs distributed to its child partition roots as long as:
>>   1) it is not the top cpuset; and
>>   2) there is no task directly associated with the parent.
>>
>> Once an empty parent partition root is formed, no new task can be moved
>> into it.
> The above are already enforced by cgroup2 core, right? No intermediate
> cgroup with controllers enabled can have processes. From controllers' POV,
> only leaves can have processes.
>
I don't think that is true. A task can reside anywhere in the cgroup 
hierarchy. I have encountered no problem moving tasks around.

Cheers,
Longman

