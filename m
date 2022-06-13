Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B36548F3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiFMPor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351193AbiFMPoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 11:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0970C6B
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655126345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5Lm2wWyGosZM6z8k7SEF9qOMpYtGM8nzWGhua6hIYw=;
        b=hWzo3hHkukXMZRoJak5RBbjt5RWia3MyZzcVFT/VzfgN28ddbZoEoa68ifOa/fqqXZ+pBy
        kj0EGvy6D8sJGyLl0gM2a/QCvQmdY/BPbhVEAnuDz9y2L9VfETEcCl0U4hHRys8rgjLw2e
        m5U5oM6h3hiYuMIXc+pu/gGaQb+Ppj4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569--wfr7ystMWKUEgkXXr7izQ-1; Mon, 13 Jun 2022 09:19:04 -0400
X-MC-Unique: -wfr7ystMWKUEgkXXr7izQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9B8B28224F2;
        Mon, 13 Jun 2022 13:18:56 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BF2F2026D64;
        Mon, 13 Jun 2022 13:18:56 +0000 (UTC)
Message-ID: <8d7ddb5a-0d0b-3f2e-e049-900360e95fc6@redhat.com>
Date:   Mon, 13 Jun 2022 09:18:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
 <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
 <YqarMyNo9oHxhZFh@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqarMyNo9oHxhZFh@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/22 23:12, Tejun Heo wrote:
> Hello,
>
> On Sun, Jun 12, 2022 at 11:02:38PM -0400, Waiman Long wrote:
>> That is the behavior enforced by setting the CPU_EXCLUSIVE bit in cgroup v1.
>> I haven't explicitly change it to make it different in cgroup v2. The major
>> reason is that I don't want change to one cpuset to affect a sibling
>> partition as it may make the code more complicate to validate if a partition
>> is valid.
> If at all possible, I'd really like to avoid situations where a parent can't
> withdraw resources due to something that a descendant does.

No, it doesn't affect parent at all. It just limit whats the siblings 
can do due to their mutual constraint. If this is what the confusion is 
about, I will try to reword the doc text.

Cheers,
Longman

