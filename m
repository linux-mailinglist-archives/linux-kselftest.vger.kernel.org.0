Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81B6DFEB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLT20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 15:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLT2Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 15:28:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AD1709;
        Wed, 12 Apr 2023 12:28:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so11412716plp.2;
        Wed, 12 Apr 2023 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327704; x=1683919704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJVB5ogjuRowz8vHiNaLNk0GIwsg2OONaPDtjebqjws=;
        b=lAE5KsnpHoUKow1r77yCi76DUHd9pEoglCRTUBFdO6kclN46JOwYWgeFSeLaig/aQv
         LSqZ7eMHXv7Aaioh2DpTRDexp3oWvfvUKmfBVUTfeRsT7WwhXv/di6nmxlfgzynasx8t
         ljUY1wChjepyBpaZAd4fRNLfmDnCS4WdWHps+WBgbF0xJfv00s5E1ROS1ENNMQKAakip
         UidVBcKd7vxusojPtQNG3Zkrr7YLPNRKQFFkzxPWli+aiAf3LCamusK2AUyPtEnfSsmK
         MI1tm3QwOQWPHQtk4iWARikXSj/hv0tZl8kwKtj0+3Gy/KqX41CVQxIQyDOavkD6JeFd
         fBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327704; x=1683919704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJVB5ogjuRowz8vHiNaLNk0GIwsg2OONaPDtjebqjws=;
        b=AZ3StrSx+FsW2P8QLhGnwgk+2zwo93m9egLwduA6O+JSF3+RLr9r0fzJ07me4CLPHl
         3V0qD95cRTG5YmKXjeL5cXTbSWMnE3U7Bo/i9vhgRbghs/LF+ciyn42Mm1+TlhskkePD
         QOUkRAhenl3fWXiSgmnhK/T9huXSEc1vuuIuaFdkLvsdXk8GOMKCw2EOUpI8fVW3OMvy
         STZnMkpW6yVCf0RRsAC+KfHDEZ8nAdyJjTu8DY+Ibne6krbrBora2Ht6Z1flEcgdWeq7
         yDWeVvdzf3Jae2n92Zx/N286d/tfBjPvJmMOmpi24UHwNjbPUeRc/FgGt/mBAYb8cwiw
         S4KA==
X-Gm-Message-State: AAQBX9dWXYnktJzw4l9K1Jf4QxzkwQhdCbh1OG4qWne2diaBKsZ6DXSV
        kP8wq1PavMLQC0ZMLG/agSg=
X-Google-Smtp-Source: AKy350YpMjWzZYcfRhGxoyXPWDHxuKFeMsZfObQ4iUXJoCoBLApHm5ApmGrVbBKANHe0pJq2CRqbUg==
X-Received: by 2002:a17:90a:17e8:b0:247:900:12db with SMTP id q95-20020a17090a17e800b00247090012dbmr2111523pja.24.1681327703448;
        Wed, 12 Apr 2023 12:28:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902b68700b001a064282b11sm11956710pls.151.2023.04.12.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:28:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Apr 2023 09:28:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZDcGVebCpyktxyWh@slm.duckdns.org>
References: <20230412153758.3088111-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412153758.3088111-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Wed, Apr 12, 2023 at 11:37:53AM -0400, Waiman Long wrote:
> This patch series introduces a new "isolcpus" partition type to the
> existing list of {member, root, isolated} types. The primary reason
> of adding this new "isolcpus" partition is to facilitate the
> distribution of isolated CPUs down the cgroup v2 hierarchy.
> 
> The other non-member partition types have the limitation that their
> parents have to be valid partitions too. It will be hard to create a
> partition a few layers down the hierarchy.
> 
> It is relatively rare to have applications that require creation of
> a separate scheduling domain (root). However, it is more common to
> have applications that require the use of isolated CPUs (isolated),
> e.g. DPDK. One can use the "isolcpus" or "nohz_full" boot command options
> to get that statically. Of course, the "isolated" partition is another
> way to achieve that dynamically.
> 
> Modern container orchestration tools like Kubernetes use the cgroup
> hierarchy to manage different containers. If a container needs to use
> isolated CPUs, it is hard to get those with existing set of cpuset
> partition types. With this patch series, a new "isolcpus" partition
> can be created to hold a set of isolated CPUs that can be pull into
> other "isolated" partitions.
> 
> The "isolcpus" partition is special that there can have at most one
> instance of this in a system. It serves as a pool for isolated CPUs
> and cannot hold tasks or sub-cpusets underneath it. It is also not
> cpu-exclusive so that the isolated CPUs can be distributed down the
> sibling hierarchies, though those isolated CPUs will not be useable
> until the partition type becomes "isolated".
> 
> Once isolated CPUs are needed in a cgroup, the administrator can write
> a list of isolated CPUs into its "cpuset.cpus" and change its partition
> type to "isolated" to pull in those isolated CPUs from the "isolcpus"
> partition and use them in that cgroup. That will make the distribution
> of isolated CPUs to cgroups that need them much easier.

I'm not sure about this. It feels really hacky in that it side-steps the
distribution hierarchy completely. I can imagine a non-isolated cpuset
wanting to allow isolated cpusets downstream but that should be done
hierarchically - e.g. by allowing a cgroup to express what isolated cpus are
allowed in the subtree. Also, can you give more details on the targeted use
cases?

Thanks.

-- 
tejun
