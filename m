Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BA74E294
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGKAeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKAeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FB1AC
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689035597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jCZmfZzjejGxfBXjkcFRYAyVQ6S1vH30csYuUaEOJU=;
        b=Q0+0xpVF4bxcmkNJk0fLm28lXt34jPN1Pjbl0gbvqbEIkGFz/Vv5IDFB5KZztFuI0qpuR0
        iufOvcIjb3ChTR6Zo+gydqwmc2R+xcEm3gwO3oqca0D6hni4uYm2mrx7TmOalB0AXkwIPr
        YzdwkYMJlhSi+P2SwkHGxXGIE7Y5wCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-Xg-6SuwfOz-NT9k5sHsGaQ-1; Mon, 10 Jul 2023 20:33:13 -0400
X-MC-Unique: Xg-6SuwfOz-NT9k5sHsGaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25E7E1C06904;
        Tue, 11 Jul 2023 00:33:13 +0000 (UTC)
Received: from [10.22.18.171] (unknown [10.22.18.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DF5F40C206F;
        Tue, 11 Jul 2023 00:33:12 +0000 (UTC)
Message-ID: <305038a0-1db8-3d0d-3447-48be1f03d41c@redhat.com>
Date:   Mon, 10 Jul 2023 20:33:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/9] cgroup/cpuset: Support remote partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
 <ZKxzTrN2yiKfXndI@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZKxzTrN2yiKfXndI@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 17:08, Tejun Heo wrote:
> Hello, Waiman.
>
> I applied the prep patches. They look good on their own.
>
> On Tue, Jun 27, 2023 at 10:34:59AM -0400, Waiman Long wrote:
> ...
>> cpuset. Unlike "cpuset.cpus", invalid input to "cpuset.cpus.exclusive"
>> will be rejected with an error. This new control file has no effect on
> We cannot maintain this as an invariant tho, right? For example, what
> happens when a parent cgroup later wants to withdraw a CPU from its
> cpuset.cpus which should always be allowed regardless of what its
> descendants are doing? Even with cpus.exclusive itself, I think it'd be
> important to always allow ancestors to be able to withdraw from the
> commitment as with other resources. I suppose one can argue that giving
> exclusive access to CPUs is a special case which doesn't follow this rule
> but cpus.exclusive having to be nested inside cpus which is subject to that
> rule makes that combination too contorted.
>
> Would it be difficult to follow how isolation modes behave when the target
> configuration can't be achieved?

I would like to clarify that withdrawal of CPUs from 
cpuset.cpus.exclusive is always allowed. It is the addition of CPUs not 
presents in cpuset.cpus that will be rejected. The invariant is that 
cpuset.cpus.exclusive must always be a subset of cpuset.cpus. Any change 
that violates this rule is not allowed. Alternately I can silently 
dropped the offending CPUs without returning an error, but that may 
surprise users.

BTW, withdrawal of CPUs from cpuset.cpus will also withdraw them from 
cpuset.cpus.exclusive, if present. This allows the partition code to use 
cpuset.cpus.exclusive directly to determine the allowable exclusive CPUs 
without doing an intersection with cpuset.cpus each time it is used.

Please let me know if you want a different behavior.

Cheers,
Longman

