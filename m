Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C228A6E036B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMA4n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 20:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMA4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 20:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2645FCF
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681347360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRJHLQRX436psVY4dEg5oBAGIW2fFsn/wgOTxNFdgEo=;
        b=NgRsBlDxw6tHXbbdP5ueghd1h7Ed8t62lD6HFOmt6YPDljhjkYbMRRbb7CY4a/O+/vovTY
        vPcbruKUG2ekiceAcHOFuVt3XMQbmofo0rgTigRa/B3oe8PdL+B8B2ffENFNUYY4YHFu7A
        FhkdfqmSJ9UZfOV9eocIs43XgvGq6rw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-uctjjZuKPamdwzs5oK2dTg-1; Wed, 12 Apr 2023 20:55:57 -0400
X-MC-Unique: uctjjZuKPamdwzs5oK2dTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D90471C05AED;
        Thu, 13 Apr 2023 00:55:56 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D25340C6E20;
        Thu, 13 Apr 2023 00:55:56 +0000 (UTC)
Message-ID: <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
Date:   Wed, 12 Apr 2023 20:55:55 -0400
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
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/12/23 20:33, Tejun Heo wrote:
> Hello,
>
> On Wed, Apr 12, 2023 at 08:26:03PM -0400, Waiman Long wrote:
>>    If the "cpuset.cpus.isolated" isn't set, the existing rules applies. If it
>> is set, the new rule will be used.
>>
>> Does that look reasonable to you?
> Sounds a bit contrived. Does it need to be something defined in the root
> cgroup?

Yes, because we need to take away the isolated CPUs from the effective 
cpus of the root cgroup. So it needs to start from the root. That is 
also why we have the partition rule that the parent of a partition has 
to be a partition root itself. With the new scheme, we don't need a 
special cgroup to hold the isolated CPUs. The new root cgroup file will 
be enough to inform the system what CPUs will have to be isolated.

My current thinking is that the root's "cpuset.cpus.isolated" will start 
with whatever have been set in the "isolcpus" or "nohz_full" boot 
command line and can be extended from there but not shrank below that as 
there can be additional isolation attributes with those isolated CPUs.

Cheers,
Longman

> The only thing that's needed is that a cgroup needs to claim CPUs
> exclusively without using them, right? Let's say we add a new interface
> file, say, cpuset.cpus.reserve which is always exclusive and can be consumed
> by children whichever way they want, wouldn't that be sufficient? Then,
> there would be nothing to describe in the root cgroup.
>
> Thanks.
>

