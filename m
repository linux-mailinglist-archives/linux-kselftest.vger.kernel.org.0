Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355406E0330
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDMA1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 20:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDMA1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 20:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C861B3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681345569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=haXTThtMgpsseSV6p+uwEaprdsyUVtg4Cg56AUYX6Mw=;
        b=Fru4TinofvNNvYLJGEifCccSu6GxyG5+aIAzxOjiNOG48ltYwhxzIEG4ruPvBWt+Gvly3M
        OHVKIRupcs2ZYb+9CO26fFpentAFXR9tiLCA2TqRF1fWfXMEcexyIJyBrtTkXOySC+bk9N
        dSmFF6OJQgmRX5u/PCIC3NqKqoRswZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-xD8WZDrPMrumTqyXbLUz9g-1; Wed, 12 Apr 2023 20:26:04 -0400
X-MC-Unique: xD8WZDrPMrumTqyXbLUz9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8CF9185A78B;
        Thu, 13 Apr 2023 00:26:03 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7DE40C6E70;
        Thu, 13 Apr 2023 00:26:03 +0000 (UTC)
Message-ID: <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
Date:   Wed, 12 Apr 2023 20:26:03 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDdG1K0kTETZMTCu@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/12/23 20:03, Tejun Heo wrote:
> Hello,
>
> On Wed, Apr 12, 2023 at 04:33:29PM -0400, Waiman Long wrote:
>> I think we can. You mean having a new "cpuset.cpus.isolated" cgroupfs file.
>> So there will be one in the root cgroup that defines all the isolated CPUs
>> one can have. It is then distributed down the hierarchy and can be claimed
>> only if a cgroup becomes an "isolated" partition. There will be a slight
> Yeah, that seems a lot more congruent with the typical pattern.
>
>> change in the semantics of an "isolated" partition, but I doubt there will
>> be much users out there.
> I haven't thought through it too hard but what prevents staying compatible
> with the current behavior?

It is possible to stay compatible with existing behavior. It is just 
that a break from existing behavior will make the solution more clean.

So the new behavior will be:

   If the "cpuset.cpus.isolated" isn't set, the existing rules applies. 
If it is set, the new rule will be used.

Does that look reasonable to you?

Cheers,
Longman

