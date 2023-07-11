Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ADA74E2D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGKAyN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKAyL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5529F197
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689036803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXHDaaTzSJPadcWtu/mPoLh+iNZCEntncKhGlBrnF84=;
        b=bKm9z/w03rNDRAQyuLBohISaGro1skCqxi+JrxbyUnY+CpiyHd+0MhqYF5VqfNgzm9jDCS
        VVAnaKARSnf5cuykTpMEzGIXJgHLzrXJZuaM9uPdy8D01vc4Xm52NZflCIEdIOdpUgxY2q
        vffEChkmJ4Zpbe0ErgJ6yJTuMtOBDpI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-DGbuhrNnNe6H7hBfy_gx5A-1; Mon, 10 Jul 2023 20:53:20 -0400
X-MC-Unique: DGbuhrNnNe6H7hBfy_gx5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E094B384CC49;
        Tue, 11 Jul 2023 00:53:19 +0000 (UTC)
Received: from [10.22.18.171] (unknown [10.22.18.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8F09200A7CA;
        Tue, 11 Jul 2023 00:53:18 +0000 (UTC)
Message-ID: <a429e60a-fc4f-60b0-3978-71596fed9542@redhat.com>
Date:   Mon, 10 Jul 2023 20:53:18 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZKyljsbJgLNpsBLI@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 20:42, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 10, 2023 at 08:21:43PM -0400, Waiman Long wrote:
>>> Wouldn't a partition root's cpus.exclusive always contain all of the CPUs in
>>> its cpus? Would it make sense for cpus.exclusive to be different from .cpus?
>> In auto-filled case, it should be the same as cpuset.cpus. I will clarify
>> that in the documentation. Thanks for catching that.
> When the user writes something to the file, what would it mena if the
> content differs from the cgroup's cpuset.cpus?

For local partition, it doesn't make sense to have a 
cpust.cpus.exclusive that is not the same as cpuset.cpus as it 
artificially reduce the set of CPUs that can be used in a partition. In 
the case of a remote partition, the ancestor cgroups of a remote 
partition should have cpuset.cpus.exclusive smaller than cpuset.cpus so 
that when the remote partition is enabled, there are still CPUs left to 
be used by those cgroups. In essence, the cpuset.cpus.exclusive 
represents the CPUs that may not be usable anymore if they are taken by 
a remote partition downstream.

Cheers,
Longman

