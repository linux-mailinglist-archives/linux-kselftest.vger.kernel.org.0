Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7C724DBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjFFULt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbjFFULr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 16:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838710FF
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686082267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzgqGsD7+CrrqOciLpvZvEV1lKYjsInQHGa9T++ytWk=;
        b=fC8/VZYHuQF/2S6LzR6Axg6egKvCADagD5/5I6RAhAo7+peBQMVD0hQw4ki7McPlMs8z7Q
        Fby9l8Cui9BztF9GVB+03XcNpaUGrFGdZd7Vg1IZgK7lkfUPRnx5mByxTOISZu+60yUbS1
        Mvm6G/bwgL5ruaLJrAkaZSgRayYg3sw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-7QNlY6cENyyi_C61lCve9w-1; Tue, 06 Jun 2023 16:11:04 -0400
X-MC-Unique: 7QNlY6cENyyi_C61lCve9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 843AE185A791;
        Tue,  6 Jun 2023 20:11:03 +0000 (UTC)
Received: from [10.22.34.1] (unknown [10.22.34.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5284C40CFD46;
        Tue,  6 Jun 2023 20:11:02 +0000 (UTC)
Message-ID: <563fd5e1-650a-e329-8aab-2fa1953a9f49@redhat.com>
Date:   Tue, 6 Jun 2023 16:11:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
References: <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
 <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
 <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
 <a2220c9f-7a8d-da82-ecc0-b39f3807408c@redhat.com>
 <ZH-P7X_yjnVfhy7b@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZH-P7X_yjnVfhy7b@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 15:58, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Jun 05, 2023 at 10:47:08PM -0400, Waiman Long wrote:
> ...
>> I had a different idea on the semantics of the cpuset.cpus.exclusive at the
>> beginning. My original thinking is that it was the actual exclusive CPUs
>> that are allocated to the cgroup. Now if we treat this as a hint of what
>> exclusive CPUs should be used and it becomes valid only if the cgroup can
> I wouldn't call it a hint. It's still hard allocation of the CPUs to the
> cgroups that own them. Setting up a partition requires exclusive CPUs and
> thus would depend on exclusive allocations set up accordingly.
>
>> become a valid partition. I can see it as a value that can be hierarchically
>> set throughout the whole cpuset hierarchy.
>>
>> So a transition to a valid partition is possible iff
>>
>> 1) cpuset.cpus.exclusive is a subset of cpuset.cpus and is a subset of
>> cpuset.cpus.exclusive of all its ancestors.
> Yes.
>
>> 2) If its parent is not a partition root, none of the CPUs in
>> cpuset.cpus.exclusive are currently allocated to other partitions. This the
> Not just that, the CPUs aren't available to cgroups which don't have them
> set in the .exclusive file. IOW, if a CPU is in cpus.exclusive of some
> cgroups, it shouldn't appear in cpus.effective of cgroups which don't have
> the CPU in their cpus.exclusive.
>
> So, .exclusive explicitly establishes exclusive ownership of CPUs and
> partitions depend on that with an implicit "turn CPUs exclusive" behavior in
> case the parent is a partition root for backward compatibility.
The current CPU exclusive behavior is limited to sibling cgroups only. 
Because of the hierarchical nature of cpu distribution, the set of 
exclusive CPUs have to appear in all its ancestors. When partition is 
enabled, we do a sibling exclusivity test at that point to verify that 
it is exclusive. It looks like you want to do an exclusivity test even 
when the partition isn't active. I can certainly do that when the file 
is being updated. However, it will fail the write if the exclusivity 
test fails just like the v1 cpuset.cpus.exclusive flag if you are OK 
with that.
>
>> same remote partition concept in my v2 patch. If its parent is a partition
>> root, part of its exclusive CPUs will be distributed to this child partition
>> like the current behavior of cpuset partition.
> Yes, similar in a sense. Please do away with the "once .reserve is used, the
> behavior is switched" part.

That behavior has been gone in my v2 patch.

> Instead, it can be sth like "if the parent is a
> partition root, cpuset implicitly tries to set all CPUs in its cpus file in
> its cpus.exclusive file" so that user-visible behavior stays unchanged
> depending on past history.

If parent is a partition root, auto reservation will be done and 
cpus.exclusive will be set automatically just like before. So existing 
applications using partition will not be affected.

Cheers,
Longman

