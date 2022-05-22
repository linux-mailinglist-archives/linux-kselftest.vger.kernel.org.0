Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19339530050
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 May 2022 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiEVCkV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 22:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiEVCkU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 22:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA433EAA9
        for <linux-kselftest@vger.kernel.org>; Sat, 21 May 2022 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653187219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUBw8GFTyhDBg8PslsY0hFMfNEXHrEOXs4oed7UJ/6Y=;
        b=XVwdEgAD7aSrRD0jx2QJ+n+ugv548JalGghSxnBiSP7OedU18t7cdF75X8NVu3dtVANxKr
        GCL98/Ru6usZ7z7qZg21IMY9lqTJeGXtRkhq80y6KbhRY+/fGxgIZ+YhdTYCztXRLI+JX+
        aX+dSJCfH4wqQ4dmY4nMGP4nZyydMoc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-98KPwqGtOviqGQT_QgQmhQ-1; Sat, 21 May 2022 22:40:15 -0400
X-MC-Unique: 98KPwqGtOviqGQT_QgQmhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB86E1C05EA4;
        Sun, 22 May 2022 02:40:14 +0000 (UTC)
Received: from [10.22.8.34] (unknown [10.22.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 855307C2A;
        Sun, 22 May 2022 02:40:13 +0000 (UTC)
Message-ID: <ed130232-144e-9763-2602-7d8a71e41cb6@redhat.com>
Date:   Sat, 21 May 2022 22:40:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v11 8/8] kselftest/cgroup: Add cpuset v2 partition root
 state test
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-9-longman@redhat.com>
 <0ede5fe6-89c8-5e63-0c0c-265b57ea5ca6@collabora.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <0ede5fe6-89c8-5e63-0c0c-265b57ea5ca6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/21/22 06:24, Muhammad Usama Anjum wrote:
> On 5/10/22 8:34 PM, Waiman Long wrote:
>> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
>> index 745fe25fa0b9..01687418b92f 100644
>> --- a/tools/testing/selftests/cgroup/Makefile
>> +++ b/tools/testing/selftests/cgroup/Makefile
>> @@ -1,10 +1,11 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS += -Wall -pthread
>>   
>> -all:
>> +all: ${HELPER_PROGS}
>>   
>>   TEST_FILES     := with_stress.sh
>> -TEST_PROGS     := test_stress.sh
>> +TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
>> +TEST_GEN_FILES := wait_inotify
> Please add wait_inotify to .gitignore file.
>
>>   TEST_GEN_PROGS = test_memcontrol
>>   TEST_GEN_PROGS += test_kmem
>>   TEST_GEN_PROGS += test_core

Right. Sorry for missing that. Will add it to the next version.

Thanks,
Longman

