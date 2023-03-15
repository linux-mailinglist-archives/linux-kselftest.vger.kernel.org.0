Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C96BBA56
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 18:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCORAD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjCOQ77 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 12:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B11B32C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678899557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mo4/ufj5aP4JcG4WHWN3/PJ1VlRuoKnOT1MocwMtouQ=;
        b=J4N5cFfLr2jlvXuYByslcuUTpqJXoMV5U8+k+VBbpOI1MP62K7NMiBhbwAy0y402DQTwyc
        TRa1x+qs0szNBXK1qxmVf0jWw2kKhBxH1/iZAq376yv/eqxRnPSOtJGYbhmO8UsVBNqhme
        XB+Y/0DJyHXuzDxTplsOq8ukqgwCxHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-k0Oy4AX3PwuBr33IhirytA-1; Wed, 15 Mar 2023 12:59:14 -0400
X-MC-Unique: k0Oy4AX3PwuBr33IhirytA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E836A805F76;
        Wed, 15 Mar 2023 16:59:13 +0000 (UTC)
Received: from [10.22.34.146] (unknown [10.22.34.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FE4B492B02;
        Wed, 15 Mar 2023 16:59:13 +0000 (UTC)
Message-ID: <bba0ed25-1130-d272-45cf-b14c95aa991f@redhat.com>
Date:   Wed, 15 Mar 2023 12:59:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/5] cgroup/cpuset: Miscellaneous updates
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230315162436.GA19015@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230315162436.GA19015@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/15/23 12:24, Will Deacon wrote:
> Hi Waiman,
>
> On Mon, Mar 06, 2023 at 03:08:44PM -0500, Waiman Long wrote:
>> This patch series includes miscellaneous update to the cpuset and its
>> testing code.
>>
>> Patch 2 is actually a follow-up of commit 3fb906e7fabb ("cgroup/cpuset:
>> Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks").
>>
>> Patches 3-4 are for handling corner cases when dealing with
>> task_cpu_possible_mask().
> Thanks for cc'ing me on these. I ran my arm64 asymmetric tests and, fwiw,
> I get the same results as vanilla -rc2, so that's good.
>
> One behaviour that persists (and which I thought might be addressed by this
> series) is the following. Imagine a 4-CPU system with CPUs 0-1 being 64-bit
> only. If I configure a parent cpuset with 'cpuset.cpus' of "0-2" and a
> child cpuset with 'cpuset.cpus' of "0-1", then attaching a 32-bit task
> to the child cpuset will result in an affinity mask of 4. If I then change
> 'cpuset.cpus' of the parent cpuset to "0-1,3", the affinity mask of the
> task remains at '4' whereas it might be nice to update it to '8', in-line
> with the new affinity mask of the parent cpuset.
>
> Anyway, I'm not complaining (this is certainly _not_ a regression), but
> I thought I'd highlight it in case you were aiming to address this with
> your changes.

I believe it is because changes in parent cpuset only won't cause the 
tasks in the child cpuset to be re-evaluated unless it causes a change 
in the effective_cpus of the child cpuset. This is the case here. We 
currently don't track how many tasks in the child cpusets are using 
parent's cpumask due to lacking runnable CPUs in the child cpuset. We 
can only fix this if we track those special tasks. It can be fixable, 
but I don't know if it is a problem that is worth fixing.

Cheers,
Longman

