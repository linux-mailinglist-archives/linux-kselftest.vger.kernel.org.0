Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291F547DC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiFMCyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiFMCyC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 22:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50EF038BDC
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Jun 2022 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655088840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awNyHYB+B6d++/GUSUOZEZMC4V4Il/2xgLKKTfctnKo=;
        b=URL1TgGJ3jTcKiud/DqcYXwQahdjvE9xrFAZ+qeHNhw3xsoZCI+4sTNcbFNXh/ov+Szz+W
        QLTaPQkYua37BSEIhzV2QYnfIWep6Xm4URpZye4sSToDbiS14fmszgFabe0VKErOQyXRIM
        Q28UHI6H8xL32Gfvi7I4TMfJMGZqgz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31--GkFDRtPOaCAeJe8ZsfFcA-1; Sun, 12 Jun 2022 22:53:54 -0400
X-MC-Unique: -GkFDRtPOaCAeJe8ZsfFcA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2EF482407B;
        Mon, 13 Jun 2022 02:53:53 +0000 (UTC)
Received: from [10.22.16.100] (unknown [10.22.16.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B5FC492C3B;
        Mon, 13 Jun 2022 02:53:53 +0000 (UTC)
Message-ID: <ce3106c1-a3c4-b449-bafc-6940d672bd94@redhat.com>
Date:   Sun, 12 Jun 2022 22:53:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-4-longman@redhat.com>
 <YqYlCRywdgSYtwKk@slm.duckdns.org> <YqYlOQjKtQCBsQuT@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqYlOQjKtQCBsQuT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/12/22 13:41, Tejun Heo wrote:
> On Sun, Jun 12, 2022 at 07:40:25AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> Sorry about the long delay.
>>
>> On Tue, May 10, 2022 at 11:34:08AM -0400, Waiman Long wrote:
>>> Once a partition with empty "cpuset.cpus.effective" is formed, no
>>> new task can be moved into it until "cpuset.cpus.effective" becomes
>>> non-empty.
>> This is always true due to no-tasks-in-intermediate-cgroups requirement,
>> right?
> or rather, I should have asked, why does this need an explicit check?

Without this patch, cpus.effective will never be empty. It just falls 
back to its parent if it becomes empty. Now with an empty 
cpus.effective, I am afraid that if a task is somehow moved to such a 
cpuset, something bad may happen. So I add this check as a safeguard.

Cheers,
Longman

