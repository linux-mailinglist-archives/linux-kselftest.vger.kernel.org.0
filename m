Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45C6BEC08
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCQPAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCQPAR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 11:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074FC8880
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679065173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YPRVQy+Pd/j5om95dzW9EJX+zmYVWMbcmqZaHwhRU0=;
        b=Fiq9NFlM73Pjce6ytzF/UamNVziKJayjjQJhdCBGr2MiQ2EJgUElgGqgiD0KNGu6+wBezx
        W5juWQ1SCoWY80AOzTUcnz9DeozBXys3z5/X9s8YU/ZDFHqAcjAhCyTkiH6cvkkSEXRVaG
        kHjTcNviEr/gQ87j6qRid8FoTdZqOss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-zQy0-OLHMeOhtnlpIQk9fw-1; Fri, 17 Mar 2023 10:59:28 -0400
X-MC-Unique: zQy0-OLHMeOhtnlpIQk9fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F7D88B77F;
        Fri, 17 Mar 2023 14:59:27 +0000 (UTC)
Received: from [10.22.10.238] (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B0A1C15BA0;
        Fri, 17 Mar 2023 14:59:27 +0000 (UTC)
Message-ID: <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
Date:   Fri, 17 Mar 2023 10:59:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
 <20230317122708.ax3m2d4zijkfdzjq@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230317122708.ax3m2d4zijkfdzjq@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/17/23 08:27, Michal Koutný wrote:
> On Tue, Mar 14, 2023 at 04:22:06PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Some arm64 systems can have asymmetric CPUs where certain tasks are only
>> runnable on a selected subset of CPUs.
> Ah, I'm catching up.
>
>> This information is not captured in the cpuset. As a result,
>> task_cpu_possible_mask() may return a mask that have no overlap with
>> effective_cpus causing new_cpus to become empty.
> I can see that historically, there was an approach of terminating
> unaccomodable tasks:
>     94f9c00f6460 ("arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores")
> the removal of killing had been made possible with
>     df950811f4a8 ("arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system").
>
> That gives two other alternatives to affinity modification:
> 2) kill such tasks (not unlike OOM upon memory.max reduction),
> 3) reject cpuset reduction (violates cgroup v2 delegation).
>
> What do you think about 2)?

Yes, killing it is one possible solution.

(3) doesn't work if the affinity change is due to hot cpu removal. So 
that leaves this patch or (2) as the only alternative. I would like to 
hear what Will and Tejun thinks about it.

I am going to remove this patch from the series for the time being.

Thanks,
Longman

