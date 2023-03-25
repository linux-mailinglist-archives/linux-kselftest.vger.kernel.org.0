Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB7B6C911F
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 23:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCYWJU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCYWJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 18:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB23C0B
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Mar 2023 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679782103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfpzCVb7RjReIdPdxbxCD31KhV4soJYjxsJSs2syVzk=;
        b=XkXySQxTXOCDp/KTbZtXRLpcv7diNpNAJFLi21eYNbFD+OMSoW9GD9Cq83TCp17sSxz8Yu
        t5YAmnpwg3YrEJtK5RnZkKS6HClShX2FYf9dpwbWIyBeey1igGYRh2fWqNcZztS/mZnUPH
        3dtUyWILdrONrCOuHvdnEHPwlAs3xJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-Fy9X5VztN_yL8p2Hw40nmQ-1; Sat, 25 Mar 2023 18:08:19 -0400
X-MC-Unique: Fy9X5VztN_yL8p2Hw40nmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AC11811E7C;
        Sat, 25 Mar 2023 22:08:19 +0000 (UTC)
Received: from [10.22.32.82] (unknown [10.22.32.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8BC443FBD;
        Sat, 25 Mar 2023 22:08:18 +0000 (UTC)
Message-ID: <17e804ea-64b5-97e1-d5fa-571157e15746@redhat.com>
Date:   Sat, 25 Mar 2023 18:08:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Will Deacon <will@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
 <20230317122708.ax3m2d4zijkfdzjq@blackpad>
 <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
 <20230324143247.GA27199@willie-the-truck>
 <20230324181936.5sf6xjc5a4vacuku@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230324181936.5sf6xjc5a4vacuku@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/24/23 14:19, Michal Koutný wrote:
> On Fri, Mar 24, 2023 at 02:32:50PM +0000, Will Deacon <will@kernel.org> wrote:
>> So approaches such as killing tasks or rejecting system calls tend not
>> to work as well, since you inevitably get divergent behaviour leading
>> to functional breakage rather than e.g. performance anomalies.
> What about temporary performance drop from 100% to 0% aka freezing the
> tasks for the duration of the mismatching affinity config?

That can be a lot of extra work to freeze it. I will prefer something 
simpler.

Without this patch, I believe it will lead to a cpumask of 0 which will 
cause the scheduler to pick a fallback cpu. It looks like the fallback 
code may be able to pick up the right cpu or it may panic the system 
(less likely).

Cheers,
Longman
>
>
>> Having said that, the behaviour we currently have in mainline seems to
>> be alright, so please don't go out of your way to accomodate these SoCs.
> I see. (Just wondering what you think about the fourth option above.)
>
> Thanks,
> Michal

