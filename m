Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3275192D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiEDAfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 20:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiEDAfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 20:35:15 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E741AF03;
        Tue,  3 May 2022 17:31:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B64C02C0C28;
        Wed,  4 May 2022 00:25:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7F9E42C197B;
        Wed,  4 May 2022 00:25:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651623923; a=rsa-sha256;
        cv=none;
        b=cEoPu6kERrPorAWzwKhl5iQYp2TOMXPNxO51fO7WY0aDZqpGO42Im9ssl9F0LsU+o2l7ZB
        rL8HixG9Q9YbddpjVjzIXJonePtmV4bmXyKBz0HGduR2Zk0s7XOpce8yN/BKJvH8LhCDX+
        7oTtHwWlYQ1MfWTPLffFpgZZV7DlrozWMy1hO99lMxY8w7thSqmvgC06fFYZDZU74ihxpv
        rJf59KsKOPRWnPQAe99w+aIS63SZWNqSV4/EEA6FEX6hbpV5snKVLMfgqXwKBoLmeXFvp8
        P/NQU3RZR20wVy1D0kh2eSLBcB87Cy5J1V+1hlxPmdixZusUQADc7EmpgWz/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651623923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Hdg6qiQIlirwga0S1D4eAt0+896iFphupiKzUuqyi/Q=;
        b=TAggbjMiNCTCeXU/LbfQrHxfiZMsJx6ACMrKwvXz/Zm6Xh+phKtkA0lG44TztFXnBBcpjY
        D6lSwBgiBT6VADeEU2UoZZwPd2z00HmBKaDasKaYhjHXHmpf/KquTrmCRZ5DI+TP0iqFCS
        gtxc9CRZb0iTnhc0gbPsPFuJhifTIVjE1qHO62NDODWT28mgU/4LwtQ8pKFXzGAekJ6IuQ
        KvijZ/DJnAUhHcq4AKTvXqYaC5Mn7l9+S0WF45luTwDjlttivVFfIGmyBVmyBST/Ig9jVe
        TGmCOorcyujog35EgGN6OSaHc/yis98UMxKyFaPD67NLQdmT4tF9q/PNutkqJw==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-kgpdw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Towering-Name: 7796fde944d0d166_1651623924363_2581278341
X-MC-Loop-Signature: 1651623924362:418608808
X-MC-Ingress-Time: 1651623924362
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.26 (trex/6.7.1);
        Wed, 04 May 2022 00:25:24 +0000
Received: from offworld (unknown [8.34.116.185])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4KtHfT5mZnz1g;
        Tue,  3 May 2022 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651623923;
        bh=Hdg6qiQIlirwga0S1D4eAt0+896iFphupiKzUuqyi/Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rgUIAvoTFpTkfb3mIEefutvc2YskV5Y59hB3NobYW57orXBSp86moSb5KsmPlkCEy
         4T/OCMcMwH3iZPPxh1h5nPyhB5fAoZvimb0PcS3XNJnjchUw+DQD/rmQpqIdf+f7uP
         HOImaf1V1Ac64X8bg7vcd8m686bCjLbNV7gKUzITd5iFTYPS8pEJeZNgalR+b6lVKW
         E9ssdneLShN65tkb6grnT8Z2jjV42h94o4otHpZ4KqnX2SpPKGJmHBu+SmOU9abMGq
         AahW7vdKwo/9qR48/jfMRq4blgJXsSGsGT/yQLzMmetNKmFwcd9rAwulvFe1OM/VSC
         vrBjviOfCrqyw==
Date:   Tue, 3 May 2022 17:13:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?utf-8?B?S291dG7Dr8K/wr0=?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <20220504001334.4va3c5ul33jbauti@offworld>
Mail-Followup-To: Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?utf-8?B?S291dG7Dr8K/wr0=?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20220425190040.2475377-1-yosryahmed@google.com>
 <20220425190040.2475377-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220425190040.2475377-2-yosryahmed@google.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Apr 2022, Yosry Ahmed wrote:

>From: Shakeel Butt <shakeelb@google.com>
>
>Introduce a memcg interface to trigger memory reclaim on a memory cgroup.
>
>Use case: Proactive Reclaim
>---------------------------
>
>A userspace proactive reclaimer can continuously probe the memcg to
>reclaim a small amount of memory. This gives more accurate and
>up-to-date workingset estimation as the LRUs are continuously
>sorted and can potentially provide more deterministic memory
>overcommit behavior. The memory overcommit controller can provide
>more proactive response to the changing behavior of the running
>applications instead of being reactive.
>
>A userspace reclaimer's purpose in this case is not a complete replacement
>for kswapd or direct reclaim, it is to proactively identify memory savings
>opportunities and reclaim some amount of cold pages set by the policy
>to free up the memory for more demanding jobs or scheduling new jobs.
>
>A user space proactive reclaimer is used in Google data centers.
>Additionally, Meta's TMO paper recently referenced a very similar
>interface used for user space proactive reclaim:
>https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
>
>Benefits of a user space reclaimer:
>-----------------------------------
>
>1) More flexible on who should be charged for the cpu of the memory
>reclaim. For proactive reclaim, it makes more sense to be centralized.
>
>2) More flexible on dedicating the resources (like cpu). The memory
>overcommit controller can balance the cost between the cpu usage and
>the memory reclaimed.
>
>3) Provides a way to the applications to keep their LRUs sorted, so,
>under memory pressure better reclaim candidates are selected. This also
>gives more accurate and uptodate notion of working set for an
>application.
>
>Why memory.high is not enough?
>------------------------------
>
>- memory.high can be used to trigger reclaim in a memcg and can
>  potentially be used for proactive reclaim.
>  However there is a big downside in using memory.high. It can potentially
>  introduce high reclaim stalls in the target application as the
>  allocations from the processes or the threads of the application can hit
>  the temporary memory.high limit.
>
>- Userspace proactive reclaimers usually use feedback loops to decide
>  how much memory to proactively reclaim from a workload. The metrics
>  used for this are usually either refaults or PSI, and these metrics
>  will become messy if the application gets throttled by hitting the
>  high limit.
>
>- memory.high is a stateful interface, if the userspace proactive
>  reclaimer crashes for any reason while triggering reclaim it can leave
>  the application in a bad state.
>
>- If a workload is rapidly expanding, setting memory.high to proactively
>  reclaim memory can result in actually reclaiming more memory than
>  intended.
>
>The benefits of such interface and shortcomings of existing interface
>were further discussed in this RFC thread:
>https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
>
>Interface:
>----------
>
>Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
>trigger reclaim in the target memory cgroup.
>
>The interface is introduced as a nested-keyed file to allow for future
>optional arguments to be easily added to configure the behavior of
>reclaim.
>
>Possible Extensions:
>--------------------
>
>- This interface can be extended with an additional parameter or flags
>  to allow specifying one or more types of memory to reclaim from (e.g.
>  file, anon, ..).
>
>- The interface can also be extended with a node mask to reclaim from
>  specific nodes. This has use cases for reclaim-based demotion in memory
>  tiering systens.
>
>- A similar per-node interface can also be added to support proactive
>  reclaim and reclaim-based demotion in systems without memcg.
>
>- Add a timeout parameter to make it easier for user space to call the
>  interface without worrying about being blocked for an undefined amount
>  of time.
>
>For now, let's keep things simple by adding the basic functionality.
>
>[yosryahmed@google.com: worked on versions v2 onwards, refreshed to
>current master, updated commit message based on recent
>discussions and use cases]
>
>Signed-off-by: Shakeel Butt <shakeelb@google.com>
>Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
>Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>Acked-by: Michal Hocko <mhocko@suse.com>
>Acked-by: Wei Xu <weixugc@google.com>
>Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
