Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7D52F107
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351816AbiETQrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351897AbiETQrB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 12:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76D3345ACF
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653065217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojbIKgxOqxnHAzNXDbRdq8vthjOu4oruqFZ3uDQUp9g=;
        b=gEDEfkUs+s/6+GSnn7bGgZPogCb4vwCbNgenlVvsfvwahsMDLL8aYaOjTcFrR2jsYLB1Ck
        QJGyQdp6VhL/2A7s2smmYheLqZY2GIHrG3wkCW/gl1k8c7iuFVUwATkkJS6TumHJrLNiui
        L5d1Rhh97sm2wStYxShdlovMiRF2rT0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-xn3Swnx1M9u2BvhAO2TVkw-1; Fri, 20 May 2022 12:46:54 -0400
X-MC-Unique: xn3Swnx1M9u2BvhAO2TVkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6976529AB3F8;
        Fri, 20 May 2022 16:46:53 +0000 (UTC)
Received: from [10.22.32.226] (unknown [10.22.32.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 677297AD5;
        Fri, 20 May 2022 16:46:52 +0000 (UTC)
Message-ID: <75d31caf-2d26-9fcc-13fb-e8be2f2ad8e5@redhat.com>
Date:   Fri, 20 May 2022 12:46:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v11 0/8] cgroup/cpuset: cpu partition code enhancements
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
 <Yoe7FOkZpUwwTTQW@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yoe7FOkZpUwwTTQW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/20/22 12:00, Sebastian Andrzej Siewior wrote:
> On 2022-05-10 11:34:05 [-0400], Waiman Long wrote:
>> v11:
>>   - Fix incorrect spacing in patch 7 and include documentation suggestions
>>     by Michal.
>>   - Move partition_is_populated() check to the last one in list of
>>     conditions to be checked.
> If I follow this correctly, then this is the latest version of the
> isolcpus= replacement with cgroup's cpusets, correct?
>
> Sebastian

It is just the beginning, there is still a lot of work to do before 
isolcpus= can be completely replaced.

Cheers,
Longman

