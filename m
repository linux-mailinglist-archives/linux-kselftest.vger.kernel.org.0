Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7310F70C997
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjEVTto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjEVTtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 15:49:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AFA3;
        Mon, 22 May 2023 12:49:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2532d6c7ef2so2837679a91.0;
        Mon, 22 May 2023 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684784981; x=1687376981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ko/ib0DbbBIkYeF2ySdhWs5YudE4zxsP9MRqrw+BLoI=;
        b=BHPHExlQjMdC1v2AlWCLoTJz495eSqFbI+OF9by02n2sfozwxdUWrjSK+k5DNG+tFM
         0jXmVCZy15YjYtpqRupyHQWDzCgOMrfYB8x7fusFUnIIOy7OWv+0Ur+/tulnIG8ionbK
         5ACCwNe65d9/G8bQONpgwu7gPsz6di3IeHfd9NgbznMRGplWO/LSP66bzPAlIxFbTuhp
         l0EohHPfuCQsy8XwLElVEnFKB8GUXEZXoPVpbwGRG8kjSvspXtSzoW+59K8LbNccSI+U
         Zy8GgtoF7Ak+whIz33YDy2AXryq4EL7GgumSVCjXzPWRAWU/tu4xO1EHkrANlY42nsDJ
         T/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784981; x=1687376981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko/ib0DbbBIkYeF2ySdhWs5YudE4zxsP9MRqrw+BLoI=;
        b=gUQwOXGp3T4TtQzPgdNYBbIrN+O/J9td8y7Hkk8bI3ybJjX65wtwMW/bOruYgZml41
         inPZ4Vr6nzQT/wwKJG9sVA1k6pDDjIx74kfkHZiPA2lW9O3DMBEQM+tZjgnw0VanWNVb
         t6a1Dm2Ll6Rd63sFHJqMfP16JTKgU93jXG2xFzX0+cNsA0Mi425cNtmcLAQplBVXO4lg
         ktCybJKHPNmc6HbepjhkLddwfyUsRNmSYRrxUexvNLDTQzfdeEyUwEqknHDoX2oMpMMM
         U3F0HiW0pyTRMiS9NS3tOM36oFpUszwsjOQvkTTeA8ePq2YQPZ7skGzX+Q5AS6DzLFAB
         Ox8A==
X-Gm-Message-State: AC+VfDxvIlOhfERAB8sTrKIJCUcBUPlw+dlxmBOh0bAFR/iYXPbFQx/M
        UjX6n9aEAnZi69E5OeAEOvo=
X-Google-Smtp-Source: ACHHUZ5QZsEXUqRwS+75+b0XYbOYkR60j+9cNSvxOsTssb9PY6x40z/YDZ9Ic1uwFVbvFMQpA6XbIg==
X-Received: by 2002:a17:90a:3189:b0:250:648b:781d with SMTP id j9-20020a17090a318900b00250648b781dmr16653356pjb.23.1684784980565;
        Mon, 22 May 2023 12:49:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm6335848pjb.2.2023.05.22.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:49:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 09:49:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Message-ID: <ZGvHUjOCjwat91Gq@slm.duckdns.org>
References: <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Sun, May 07, 2023 at 09:03:44PM -0400, Waiman Long wrote:
...
>   cpuset.cpus.reserve
>     A read-write multiple values file which exists only on root
>     cgroup.
> 
>     It lists all the CPUs that are reserved for adjacent and remote
>     partitions created in the system.  See the next section for
>     more information on what an adjacent or remote partitions is.
> 
>     Creation of adjacent partition does not require touching this
>     control file as CPU reservation will be done automatically.
>     In order to create a remote partition, the CPUs needed by the
>     remote partition has to be written to this file first.
> 
>     A "+" prefix can be used to indicate a list of additional
>     CPUs that are to be added without disturbing the CPUs that are
>     originally there.  For example, if its current value is "3-4",
>     echoing ""+5" to it will change it to "3-5".
>
>     Once a remote partition is destroyed, its CPUs have to be
>     removed from this file or no other process can use them.  A "-"
>     prefix can be used to remove a list of CPUs from it.  However,
>     removing CPUs that are currently used in existing partitions
>     may cause those partitions to become invalid.  A single "-"
>     character without any number can be used to indicate removal
>     of all the free CPUs not allocated to any partitions to avoid
>     accidental partition invalidation.

Why is the syntax different from .cpus? Wouldn't it be better to keep them
the same?

>   cpuset.cpus.partition
>     A read-write single value file which exists on non-root
>     cpuset-enabled cgroups.  This flag is owned by the parent cgroup
>     and is not delegatable.
> 
>     It accepts only the following input values when written to.
> 
>       ==========    =====================================
>       "member"    Non-root member of a partition
>       "root"    Partition root
>       "isolated"    Partition root without load balancing
>       ==========    =====================================
> 
>     A cpuset partition is a collection of cgroups with a partition
>     root at the top of the hierarchy and its descendants except
>     those that are separate partition roots themselves and their
>     descendants.  A partition has exclusive access to the set of
>     CPUs allocated to it.  Other cgroups outside of that partition
>     cannot use any CPUs in that set.
> 
>     There are two types of partitions - adjacent and remote.  The
>     parent of an adjacent partition must be a valid partition root.
>     Partition roots of adjacent partitions are all clustered around
>     the root cgroup.  Creation of adjacent partition is done by
>     writing the desired partition type into "cpuset.cpus.partition".
> 
>     A remote partition does not require a partition root parent.
>     So a remote partition can be formed far from the root cgroup.
>     However, its creation is a 2-step process.  The CPUs needed
>     by a remote partition ("cpuset.cpus" of the partition root)
>     has to be written into "cpuset.cpus.reserve" of the root
>     cgroup first.  After that, "isolated" can be written into
>     "cpuset.cpus.partition" of the partition root to form a remote
>     isolated partition which is the only supported remote partition
>     type for now.
> 
>     All remote partitions are terminal as adjacent partition cannot
>     be created underneath it.

Can you elaborate this extra restriction a bit further?

In general, I think it'd be really helpful if the document explains the
reasoning behind the design decisions. ie. Why is reserving for? What
purpose does it serve that the regular isolated ones cannot? That'd help
clarifying the design decisions.

Thanks.

-- 
tejun
