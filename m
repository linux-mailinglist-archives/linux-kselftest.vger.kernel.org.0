Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DF74E541
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 05:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGKDZ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 23:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGKDZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 23:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4FE3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689045885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bj1nFMlX6IrlygC3UiCib90ggxtKBa1bC1e3kuNGIGw=;
        b=XycduuXzbU4b2u/W/ZhPT/bBWxCO+rNegHU7WufLyrkO+lzRQornCG1KaK78e8sUvHrmIy
        QlZH1d3nWm5BY3TF1HUVwzSW6vbLCDwDTyNi+i3vOwWnhNYfqpPs+NaOZnXTSaXEZCQsBO
        BLbRAZPV6bzvBAv60QRydhi3zPx1Cqc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-ZWqJQPhYO0Gqnk1uTT0naQ-1; Mon, 10 Jul 2023 23:24:39 -0400
X-MC-Unique: ZWqJQPhYO0Gqnk1uTT0naQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17A01C07243;
        Tue, 11 Jul 2023 03:24:38 +0000 (UTC)
Received: from [10.22.18.171] (unknown [10.22.18.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DDEF40C206F;
        Tue, 11 Jul 2023 03:24:37 +0000 (UTC)
Message-ID: <82aeb5aa-7d69-78dd-bb26-60a51dc8a839@redhat.com>
Date:   Mon, 10 Jul 2023 23:24:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 8/9] cgroup/cpuset: Documentation update for partition
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
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
References: <20230627143508.1576882-1-longman@redhat.com>
 <20230627143508.1576882-9-longman@redhat.com>
 <ZKx4ZJowRhRtjZxB@slm.duckdns.org>
 <6d5aee58-f558-868c-76e0-0b58f8332110@redhat.com>
 <ZKyljsbJgLNpsBLI@slm.duckdns.org>
 <a429e60a-fc4f-60b0-3978-71596fed9542@redhat.com>
 <ZKyrP74UzVb4Ltwi@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZKyrP74UzVb4Ltwi@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 21:07, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 10, 2023 at 08:53:18PM -0400, Waiman Long wrote:
>> For local partition, it doesn't make sense to have a cpust.cpus.exclusive
>> that is not the same as cpuset.cpus as it artificially reduce the set of
>> CPUs that can be used in a partition. In the case of a remote partition, the
> Yeah, I was wondering about local partitions. "Automatic but can be
> overridden" behavior becomes confusing if it's difficult for the user to
> easily tell which part is automatic when. I wonder whether it'd be better to
> make the condition static - e.g. for a partition cgroup, cpus.exclusive
> always contains all bits in cpus no matter what value is written to it. Or,
> if we separate out cpus.exclusive and cpus.exclusive.effective, no matter
> what cpus.exclusive is set, a partition root's cpus.exclusive.effective
> always includes all bits in cpus.effective.

With no offline CPUs, cpus.effective should be the same as 
cpus.exclusive.effective for a valid partition root. Here 
cpus.exclusive.effective is a bit different from cpus.effective as it 
can contain offline cpus. It also mean that adding 
cpus.exclusive.effective can be redundant.

As said before, I try to avoid adding new cpuset control file unless 
absolutely necessary. I now have a slight different proposal. Once 
manually set, I can keep cpuset.cpus.exclusive invariant. I do need to 
do a bit more work when enabling a partition root to find out the 
effective set of exclusive CPUs to be used or make the partition invalid 
if no exclusive CPU is available. I still want to do a initial check 
when setting cpuset.cpus.exclusive to make sure that the value is at 
least valid at the beginning.

Do you think this is an acceptable compromise?

Thanks,
Longman

