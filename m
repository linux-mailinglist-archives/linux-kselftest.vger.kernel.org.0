Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09097549CF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiFMTKt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349365AbiFMTIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33EE950061
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655139987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7hhCYT7OGqCx5nH+qXS1ao3TYt75AzmKiJLPQv1MlY=;
        b=dN7XFuXy/NWHD2GALDrP/g+Tp4sT4W9Tv4HMrVJG6rUUtnNYuOkLd70ou+1H4i9IIEphie
        A8kaF705rtufmt6MmOPibuYCLTEA1qQj4oT3ThVchBnKt3CZo2DGW5qjvf9eX7Vd2uCnmH
        07Yxv6ZGdibYBrILf0/Rv5c+kgGsTMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-u9ZkP3_qMFWE3PS8XzGi6A-1; Mon, 13 Jun 2022 13:06:22 -0400
X-MC-Unique: u9ZkP3_qMFWE3PS8XzGi6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3825D801756;
        Mon, 13 Jun 2022 17:06:21 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A6F2026D64;
        Mon, 13 Jun 2022 17:06:20 +0000 (UTC)
Message-ID: <c91a8c45-123d-dbae-b07c-83772add082d@redhat.com>
Date:   Mon, 13 Jun 2022 13:06:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
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
 <8d7ddb5a-0d0b-3f2e-e049-900360e95fc6@redhat.com>
In-Reply-To: <8d7ddb5a-0d0b-3f2e-e049-900360e95fc6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/13/22 09:18, Waiman Long wrote:
> On 6/12/22 23:12, Tejun Heo wrote:
>> Hello,
>>
>> On Sun, Jun 12, 2022 at 11:02:38PM -0400, Waiman Long wrote:
>>> That is the behavior enforced by setting the CPU_EXCLUSIVE bit in 
>>> cgroup v1.
>>> I haven't explicitly change it to make it different in cgroup v2. 
>>> The major
>>> reason is that I don't want change to one cpuset to affect a sibling
>>> partition as it may make the code more complicate to validate if a 
>>> partition
>>> is valid.
>> If at all possible, I'd really like to avoid situations where a 
>> parent can't
>> withdraw resources due to something that a descendant does.
>
> No, it doesn't affect parent at all. It just limit whats the siblings 
> can do due to their mutual constraint. If this is what the confusion 
> is about, I will try to reword the doc text.

I am planning to make the following change to the documentation patch. 
Please let me know if that can clarify the confusion, if any.

Thanks,
Longman

diff --git a/Documentation/admin-guide/cgroup-v2.rst 
b/Documentation/admin-guid>
index 9184a09e0fc9..9cbfa25dab97 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2176,7 +2175,8 @@ Cpuset Interface Files

         For a valid partition root or an invalid partition root with
         the exclusivity rule enabled, changes made to "cpuset.cpus"
-       that violate the exclusivity rule will not be allowed.
+       that violate the exclusivity rule with its siblings will not
+       be allowed.

         A valid non-root parent partition may distribute out all its CPUs
         to its child partitions when there is no task associated with it.

