Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2069945192F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 00:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhKOXPq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 18:15:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345070AbhKOVbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 16:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637011689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB9LIJ8wftWZtVC2tmoTuif+x3rpeL1vcMWkA0vO7Oo=;
        b=ixnw1mcTr19CdHQ0ch6Echv3BASAZnVEpZz0YjCPK9eKtIejvUoakitYWPPQVES4nM6EBK
        lk3l1ex7YCZJpwRdstvJlmwg2ksU5s+O7cmnjibbHb+BPc0ydoK8s5MB0jLOLs5g8Ez81s
        hrniOiO5d6CQB15ETzGKuLWEN0nELrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-2Dn2_3U9N7eoU0qXDNUoVQ-1; Mon, 15 Nov 2021 16:28:06 -0500
X-MC-Unique: 2Dn2_3U9N7eoU0qXDNUoVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9300D87D545;
        Mon, 15 Nov 2021 21:28:03 +0000 (UTC)
Received: from [10.22.33.148] (unknown [10.22.33.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0769D10016FC;
        Mon, 15 Nov 2021 21:27:57 +0000 (UTC)
Message-ID: <1426905d-f93a-7500-177b-a8e0fae467ab@redhat.com>
Date:   Mon, 15 Nov 2021 16:27:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
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
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz> <YZK/A43T+zvu89dl@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YZK/A43T+zvu89dl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/15/21 15:11, Tejun Heo wrote:
> Hello,
>
> On Mon, Nov 15, 2021 at 08:31:22PM +0100, Michal Koutný wrote:
>> Now to the constraints and partition setups. I think it's useful to have
>> a model with which the implementation can be compared with.
>> I tried to condense some "simple rules" from the descriptions you posted
>> in v8 plus your response to my remarks in v7 [2]. These should only be
>> the "validity conditions", not "transition conditions".
> FWIW, my opinion is pretty much in line with Michal's in this regard. Other
> than that, everything looks pretty good to me.

Yes, I am going to streamline the documentation as suggested to make it 
easier to understand.

Coding-wise, do you have other changes you want me to make?

Thanks,
Longman

