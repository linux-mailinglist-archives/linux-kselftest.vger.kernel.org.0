Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B429C6E2999
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDNRnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDNRm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 13:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BAA262
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681494121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YShER/83lVY8rjvwP0DGbgGKGuajPMgVY3SrTBvwiQg=;
        b=ShtqYcVOexYvxplIvzi2LqBsgjJQStcvCTkzS/vsWaH22BVwANZRdH+tNnUiCaHxl0FuaV
        7MskSre5LAlb8twMxIHyAiccYOHdrG7Z2B21PWIEpC8JxdvC887lAF1gzUmNZoj5u7sRgZ
        hAobfmNIrOhXQgcGM8/3IBjhFtA6mwc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-S2cIwDP4MLWRPH72GQb-OQ-1; Fri, 14 Apr 2023 13:41:20 -0400
X-MC-Unique: S2cIwDP4MLWRPH72GQb-OQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2CFE3C184EE;
        Fri, 14 Apr 2023 17:38:49 +0000 (UTC)
Received: from [10.22.18.140] (unknown [10.22.18.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32B53492B01;
        Fri, 14 Apr 2023 17:38:49 +0000 (UTC)
Message-ID: <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
Date:   Fri, 14 Apr 2023 13:38:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
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
        Frederic Weisbecker <frederic@kernel.org>
References: <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/23 13:34, Tejun Heo wrote:
> On Fri, Apr 14, 2023 at 01:29:25PM -0400, Waiman Long wrote:
>> On 4/14/23 12:54, Tejun Heo wrote:
>>> On Thu, Apr 13, 2023 at 09:22:19PM -0400, Waiman Long wrote:
>>>> I now have a slightly different idea of how to do that. We already have an
>>>> internal cpumask for partitioning - subparts_cpus. I am thinking about
>>>> exposing it as cpuset.cpus.reserve. The current way of creating
>>>> subpartitions will be called automatic reservation and require a direct
>>>> parent/child partition relationship. But as soon as a user write anything to
>>>> it, it will break automatic reservation and require manual reservation going
>>>> forward.
>>>>
>>>> In that way, we can keep the old behavior, but also support new use cases. I
>>>> am going to work on that.
>>> I'm not sure I fully understand the proposed behavior but it does sound more
>>> quirky.
>> The idea is to use the existing subparts_cpus for cpu reservation instead of
>> adding a new cpumask for that purpose. The current way of partition creation
>> does cpus reservation (setting subparts_cpus) automatically with the
>> constraint that the parent of a partition must be a partition root itself.
>> One way to relax this constraint is to allow a new manual reservation mode
>> where users can set reserve cpus manually and distribute them down the
>> hierarchy before activating a partition to use those cpus.
>>
>> Now the question is how to enable this new manual reservation mode. One way
>> to do it is to enable it whenever the new cpuset.cpus.reserve file is
>> modified. Alternatively, we may enable it by a cgroupfs mount option or a
>> boot command line option.
> It'd probably be best if we can keep the behavior within cgroupfs if
> possible. Would you mind writing up the documentation section describing the
> behavior beforehand? I think things would be clearer if we look at it from
> the interface documentation side.

Sure, will do that. I need some time and so it will be early next week.

Cheers,
Longman

