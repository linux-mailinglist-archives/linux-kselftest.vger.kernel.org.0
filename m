Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19E4476136
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbhLOSzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 13:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344099AbhLOSz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 13:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639594526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6p2PMg3IHKSv9HJVSyU/jUSPqlHttS0kc0XgSmw+DTI=;
        b=hL68iMe+KCaaI1o1gbB/otOqyD42/yMUP8SToQcoga6xKNfBkcjm2VsyC2cf8uFLNVEj6f
        2a5cVdiVaY8xqOZR1Tx0M3p8ddtQJYZWKexlmSkCGSZOxnegGU0WxbbFhpy/Bq4YR/IHPd
        zvB/hCxaKLzINdCKAjLm3a0QQtsLT20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-eLARbfoFMtubSfuCb0DIwQ-1; Wed, 15 Dec 2021 13:55:21 -0500
X-MC-Unique: eLARbfoFMtubSfuCb0DIwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65A3C92502;
        Wed, 15 Dec 2021 18:55:18 +0000 (UTC)
Received: from [10.22.10.54] (unknown [10.22.10.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1357A19D9B;
        Wed, 15 Dec 2021 18:55:05 +0000 (UTC)
Message-ID: <58c06961-ffc4-27d7-01d2-4c91b0c9161d@redhat.com>
Date:   Wed, 15 Dec 2021 13:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 6/7] cgroup/cpuset: Update description of
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
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-7-longman@redhat.com>
 <Ybe0YWEo7Wp7wib9@slm.duckdns.org> <20211215144450.GC25459@blackbody.suse.cz>
 <96018978-6b7f-1e7f-1012-9df7f7996ec5@redhat.com>
 <Ybo1jmNvM6sblcJq@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ybo1jmNvM6sblcJq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/21 13:35, Tejun Heo wrote:
> Hello, Waiman.
>
> On Wed, Dec 15, 2021 at 01:16:43PM -0500, Waiman Long wrote:
>> Allowing direct transition from member to invalid partition doesn't feel
>> right for me. A casual user may assume a partition is correctly formed
>> without double checking the "cpuset.partition" value. Returning an error
>> will prevent this kind of issue. If returning more information about the
>> failure is the main reason for allowing the invalid partition transition, we
>> can extend the "cpuset.partition" read syntax to also show the reason for
>> the previous failure.
> I don't think it's a good idea to display error messages without a way to
> link the error to the one who triggered it. This is the same problem we had
> with resettable counters. It only works for scenarios where one guy is
> sitting in front of the computer but gets nastry for more complex scnearios
> and automation.
Yes, I agree it is not a good way to handle this issue.
>
> I understand that allowing transitions to invalid state can feel jarring.
> There are pros and cons to both approaches. It's similar dynamics tho.
> Erroring out may be more intuitive for a casual user but makes it harder for
> more complex scenarios because whether a given operation errors or not is
> dependent on external asynchronous states, there's no good way of reporting
> the exact nature of the error or detecting when the operation would succeed
> in the future, and the error conditions are rather arbitrary.

Thanks for the explanation. Yes, there are always pros and cons for 
different approach to a problem. I am not totally against allowing 
member to invalid partition transition. In that case, reading back 
"cpuset.partition" is a must to verify that it is really a success.

How about we allow transition to an invalid partition state but still 
return an error?

Regards,
Longman

