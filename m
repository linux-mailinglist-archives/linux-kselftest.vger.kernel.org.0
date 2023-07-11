Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4274E38F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGKBjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 21:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGKBjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 21:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C4F9
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 18:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689039498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgrK8riab39mc/l4RMQ9kP4UiPJ/E6e+0z17cQMh7m8=;
        b=Z2hQxymUoOClm5r/gfGad4RAjxEA6pNK07R/d3tqSZ6O3i+dYrBTp/tGW4cjsc+bOhl5x7
        0L3w8fu/F8cJG67h3m/11xFhPo7Cx2/K6apouMkMURkVUWHMTJBRON0dPWMbjXEXi3qZsw
        aHJXhxPZkoKPTHvmxVWszBcgDLU81lM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-Nc2M2H8GO4WdFDGoVYDBIg-1; Mon, 10 Jul 2023 21:38:14 -0400
X-MC-Unique: Nc2M2H8GO4WdFDGoVYDBIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4390680269A;
        Tue, 11 Jul 2023 01:38:14 +0000 (UTC)
Received: from [10.22.18.171] (unknown [10.22.18.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DAF92166B26;
        Tue, 11 Jul 2023 01:38:13 +0000 (UTC)
Message-ID: <c0fb6438-8d19-9d75-d717-68f047465332@redhat.com>
Date:   Mon, 10 Jul 2023 21:38:12 -0400
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
 <305038a0-1db8-3d0d-3447-48be1f03d41c@redhat.com>
 <ZKypl8cr3jxiZ6bo@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZKypl8cr3jxiZ6bo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 7/10/23 21:00, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 10, 2023 at 08:33:11PM -0400, Waiman Long wrote:
>> I would like to clarify that withdrawal of CPUs from cpuset.cpus.exclusive
>> is always allowed. It is the addition of CPUs not presents in cpuset.cpus
>> that will be rejected. The invariant is that cpuset.cpus.exclusive must
>> always be a subset of cpuset.cpus. Any change that violates this rule is not
>> allowed. Alternately I can silently dropped the offending CPUs without
>> returning an error, but that may surprise users.
> Right, that'd be confusing.
>
>> BTW, withdrawal of CPUs from cpuset.cpus will also withdraw them from
>> cpuset.cpus.exclusive, if present. This allows the partition code to use
>> cpuset.cpus.exclusive directly to determine the allowable exclusive CPUs
>> without doing an intersection with cpuset.cpus each time it is used.
> This is kinda confusing too, I think. Changing cpuset.cpus in an ancestor
> doesn't affect the contents of the descendants' cpuset.cpus files but would
> directly modify the contents of their cpuset.cpus.exclusive files.
>
> There's some inherent friction because cpuset.cpus separates configuration
> (cpuset.cpus) and the current state (cpuset.cpus.effective) while
> cpuset.cpus.exclusive is trying to do both in the same interface file. When
> the two behavior modes collide, it becomes rather confusing. Do you think
> it'd make sense to make cpus.exclusive follow the same pattern as
> cpuset.cpus?

I don't want to add another cpuset.cpus.exclusive.effective control 
file. One possibility is to keep another effective masks in the struct 
cpuset and list both exclusive cpus set by the user and the effective 
ones side by side, like "<cpus> (<effective_cpus>)" if they differ or 
some other format. What do you think?

Regards,
Longman

