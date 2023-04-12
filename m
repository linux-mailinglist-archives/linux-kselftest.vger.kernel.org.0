Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFC6DFFEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjDLUeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDLUeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 16:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC76449D
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681331614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF6ZGxBbkIfjD9DhMutgQoIKoNocc290sfEndcP1qNU=;
        b=E3Es2yyWVOUrv2rwgb3OPmd58ErFAAchKqSo3fgQrZuC7jMEkGJiE/i/gYKUWAniVYUnu6
        v94Iyl4VByeoysjj/07nLJByVcpashZmO3k2LpW/jsHtnkFpntBAd45HUjb79edr328sY8
        l40s2ab4z2wUHP+jMDITwgge/8ca0hQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-9GjZ4rz5PjKDlNsYwPvDyQ-1; Wed, 12 Apr 2023 16:33:31 -0400
X-MC-Unique: 9GjZ4rz5PjKDlNsYwPvDyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7DA23813F31;
        Wed, 12 Apr 2023 20:33:30 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A10FC15BB8;
        Wed, 12 Apr 2023 20:33:29 +0000 (UTC)
Message-ID: <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
Date:   Wed, 12 Apr 2023 16:33:29 -0400
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
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/12/23 16:22, Tejun Heo wrote:
> Hello, Waiman.
>
> On Wed, Apr 12, 2023 at 03:52:36PM -0400, Waiman Long wrote:
>> There is still a distribution hierarchy as the list of isolation CPUs have
>> to be distributed down to the target cgroup through the hierarchy. For
>> example,
>>
>> cgroup root
>>    +- isolcpus  (cpus 8,9; isolcpus)
>>    +- user.slice (cpus 1-9; ecpus 1-7; member)
>>       +- user-x.slice (cpus 8,9; ecpus 8,9; isolated)
>>       +- user-y.slice (cpus 1,2; ecpus 1,2; member)
>>
>> OTOH, I do agree that this can be somewhat hacky. That is why I post it as a
>> RFC to solicit feedback.
> Wouldn't it be possible to make it hierarchical by adding another cpumask to
> cpuset which lists the cpus which are allowed in the hierarchy but not used
> unless claimed by an isolated domain?

I think we can. You mean having a new "cpuset.cpus.isolated" cgroupfs 
file. So there will be one in the root cgroup that defines all the 
isolated CPUs one can have. It is then distributed down the hierarchy 
and can be claimed only if a cgroup becomes an "isolated" partition. 
There will be a slight change in the semantics of an "isolated" 
partition, but I doubt there will be much users out there.

If you are OK with this approach, I can modify my patch series to do that.

Cheers,
Longman

