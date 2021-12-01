Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6F465441
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhLARwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 12:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238830AbhLARwt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 12:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638380964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3IYU06NP1ap6vKovk21hhbdlMoBPkQcBNAwBXt/XDY=;
        b=OhsUsVUD/48gfapf93JSJAouyUgzw2OWmvoLlUFNw6aOSnxyRTb8xKVN6Dnd82y0xp0hjx
        hHtmQ4T5WSM6uKra4LWimh89MVXCMZU6Qyg92mqFWLNfg0K1mCUFzJkYN9tJI9hB1oAJyK
        IyMKtILcANm4LTh5mrnqYQR+kFkLfKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-_2o-w0GJO-SM_8Zn7NCLfw-1; Wed, 01 Dec 2021 12:49:21 -0500
X-MC-Unique: _2o-w0GJO-SM_8Zn7NCLfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DEA8F51F;
        Wed,  1 Dec 2021 17:49:19 +0000 (UTC)
Received: from [10.22.10.179] (unknown [10.22.10.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5C279459;
        Wed,  1 Dec 2021 17:49:16 +0000 (UTC)
Message-ID: <e16ccf4f-7302-8891-d9f6-081e0bc41c04@redhat.com>
Date:   Wed, 1 Dec 2021 12:49:15 -0500
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
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <20211201141350.GA54766@blackbody.suse.cz>
 <ec6e2b89-385a-fcc7-7cfa-7e9119fc34bc@redhat.com>
 <YaelRiqWOIzT5uRs@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YaelRiqWOIzT5uRs@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 12/1/21 11:39, Tejun Heo wrote:
> On Wed, Dec 01, 2021 at 09:56:21AM -0500, Waiman Long wrote:
>> Right, I shouldn't say corner cases. Having task in an intermediate
>> partition is possible depending on event sequence. I am aware that there are
>> code in the cpuset code to prevent that, but it didn't block all cases.
>>>> A valid parent partition may distribute out all its CPUs to
>>>>    its child partitions as long as there is no task associated with it.
>>> Assuming there's always at least one kernel thread in the root cgroup
>>> that can't be migrated anyway.]
>> I am aware of that. That is why I said root cgroup must have at least one
>> cpu in its "cpuset.cpus.effective".
> In that case, let's explicitly describe that condition.

Yes, I will. Only non-root cgroup can distribute out all its CPUs. I 
thought I said that in the documentation, maybe it is very clear.

Cheers,
Longman

