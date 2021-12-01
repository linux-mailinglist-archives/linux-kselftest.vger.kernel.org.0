Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCF4650A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbhLAPAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232627AbhLAPAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638370630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD9oVnkdNcgwBlZTLCOet/WJtrrHTgH+O1SlF9BlPpQ=;
        b=Hez8sG9JJQUueKmjZ8arfbIRbGBrmnNIAI8DOfChKDmy+yxRyim0nC5LcsKGmh7+Pc2Y3+
        tRxaG4R8ZK7UMkvBTQXGpxI3jh9w/zqzRGxZFxZ04ZY0ktT/p+ejXCgef3cC26o+ApgLUz
        kg07m+0Cio9PcjCMa1zzAlNlYdFd+h8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-3u8mdrDTOn6rm3VialThZg-1; Wed, 01 Dec 2021 09:57:09 -0500
X-MC-Unique: 3u8mdrDTOn6rm3VialThZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094FF8042F6;
        Wed,  1 Dec 2021 14:56:24 +0000 (UTC)
Received: from [10.22.10.179] (unknown [10.22.10.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C07760C05;
        Wed,  1 Dec 2021 14:56:21 +0000 (UTC)
Message-ID: <ec6e2b89-385a-fcc7-7cfa-7e9119fc34bc@redhat.com>
Date:   Wed, 1 Dec 2021 09:56:21 -0500
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
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <20211201141350.GA54766@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211201141350.GA54766@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/21 09:13, Michal Koutný wrote:
> On Tue, Nov 30, 2021 at 10:56:34PM -0500, Waiman Long <longman@redhat.com> wrote:
>>>>       A valid parent partition may distribute out all its CPUs to
>>>>       its child partitions as long as it is not the root cgroup and
>>>>       there is no task associated with it.
>>> A valid parent partition which isn't root never has tasks in them to begin
>>> with.
>> I believe there is some corner cases where it is possible to put task in an
>> intermediate partition. That is why I put down this statement.
> Just mind the threads -- cpuset controller is threaded and having tasks
> in inner cgroup nodes is a real scenario. I wouldn't consider it a
> corner case.
>
> [ Actually, the paragraph could IMO be simplified:
Right, I shouldn't say corner cases. Having task in an intermediate 
partition is possible depending on event sequence. I am aware that there 
are code in the cpuset code to prevent that, but it didn't block all cases.
>> A valid parent partition may distribute out all its CPUs to
>>   its child partitions as long as there is no task associated with it.
> Assuming there's always at least one kernel thread in the root cgroup
> that can't be migrated anyway.]

I am aware of that. That is why I said root cgroup must have at least 
one cpu in its "cpuset.cpus.effective".

Cheers,
Longman

