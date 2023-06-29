Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739DE742752
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2NZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2NZ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 09:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718632D4A
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688045111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i//cZqpn/yGjitEFiKBEUSmAX16ZZkd1c4DKwvAzqBQ=;
        b=UDQjj1YR0yK++ra1cJYfrh2PYhhVcneQytGWvIayCZKDD6ktCdljmW5DzPENRxX99R7wCt
        1r6HmjZxaKhjWTyl6QR8wDOBjIHnTV4bTpGMXg4XbJ81kSqlsOITWpMQ7vGaafNgAQd/Qr
        GJEISEPkwRa+4Z0bYL2jyizD7CCGXTY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-hUX3LOjfMmS3X1r6h4jrfA-1; Thu, 29 Jun 2023 09:25:07 -0400
X-MC-Unique: hUX3LOjfMmS3X1r6h4jrfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 756D23C18FE8;
        Thu, 29 Jun 2023 13:25:06 +0000 (UTC)
Received: from [10.22.16.224] (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF97B2166B25;
        Thu, 29 Jun 2023 13:25:05 +0000 (UTC)
Message-ID: <67d72bc7-a277-9210-6f40-d3d94f2643a0@redhat.com>
Date:   Thu, 29 Jun 2023 09:25:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cpuset: Allow setscheduler regardless of manipulated
 task
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
References: <20230629091146.28801-1-mkoutny@suse.com>
 <20230629091146.28801-2-mkoutny@suse.com>
 <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
 <4fowzgkh7yo5ku2fsrptyi7jzikynjtq4zpfcx7k26vk4k6zj3@ubnupp5jqgle>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <4fowzgkh7yo5ku2fsrptyi7jzikynjtq4zpfcx7k26vk4k6zj3@ubnupp5jqgle>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/29/23 08:26, Michal Koutný wrote:
> On Thu, Jun 29, 2023 at 08:11:33AM -0400, Waiman Long <longman@redhat.com> wrote:
>> So I think you should just use
>> cgroup_subsys_on_dfl(cpuset_cgrp_subsys) as the v2 check if your focus
>> is just to prevent problem when enabling cpuset controller.
> I thought the bare cgroup_subsys_on_dfl(cpuset_cgrp_subsys) is not used
> in cpuset.c but I was wrong -- yes, I'll change this.
>
>> This change will likely conflict with the latest cpuset change on tracking #
>> of dl tasks in a cpuset. You will have to, at least, move the dl task check
>> before the security_task_setscheduler() check.
>>
>> Another fact about cpuset controller enabling is that both cpus_allowed and
>> mems_allowed are empty at that point. You may also add these checks as a
>> preconditions for disabling the security_task_setscheduler check.
> Ah, I will rebase on fresh mainline (or do you mean another reference?).

Yes, those changes have just been merged into the mainline.

Cheers,
Longman

