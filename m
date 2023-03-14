Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335A6B9E2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCNSVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 14:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNSVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 14:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF425260
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678818060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZu0RzwIJilde3oJZLOmJNiQa9ScwZN4JDJCiFaDOu0=;
        b=b69Fdhn6TZlbDojqThBAO9qb6ahg7MgW+Rguo0RHVgAj9psbc10Yw4JrkFP7bGmtudQ14E
        91avBwJdoxNLUJnjwSK6rBiybpZiXH5JKGEqCAzoUxIG2t1p2HY+1pZeJy4MuzSmHGUc1g
        CJtIcGXCyAbDuGlO8mkrNPGCu/zdl08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-fXFSDEw8M8STJQQyKTOawQ-1; Tue, 14 Mar 2023 14:20:57 -0400
X-MC-Unique: fXFSDEw8M8STJQQyKTOawQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84036100F90B;
        Tue, 14 Mar 2023 18:20:54 +0000 (UTC)
Received: from [10.22.18.199] (unknown [10.22.18.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C84FB4042AC0;
        Tue, 14 Mar 2023 18:20:53 +0000 (UTC)
Message-ID: <176a4cfd-2902-16a2-b9e7-cb66e1c5b49c@redhat.com>
Date:   Tue, 14 Mar 2023 14:20:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] cgroup/cpuset: Skip task update if hotplug doesn't
 affect current cpuset
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-2-longman@redhat.com>
 <20230314165030.beu2ywtvqa3p45ta@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230314165030.beu2ywtvqa3p45ta@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/14/23 12:50, Michal Koutný wrote:
> On Mon, Mar 06, 2023 at 03:08:45PM -0500, Waiman Long <longman@redhat.com> wrote:
>> If a hotplug event doesn't affect the current cpuset, there is no point
>> to call hotplug_update_tasks() or hotplug_update_tasks_legacy(). So
>> just skip it.
> This skips "insane" modification of cs->cpus_allowed in
> hotplug_update_tasks_legacy() but assuming cs->cpus_allowed is kept in
> sync with cs->effective_cpus on v1, it is OK to skip the update based
> only on effective_cpus check.

Yes, effective_cpus is equivalent to cpus_allowed in v1 unless you mount 
the cpuset with the cpuset_v2_mode flag which will behave more like v2 
where effective_cpus is still the key.

Cheers,
Longman

