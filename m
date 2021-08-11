Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2B3E973F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhHKSE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKSE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:04:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357AC061765;
        Wed, 11 Aug 2021 11:04:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so10891531pjn.4;
        Wed, 11 Aug 2021 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OiO20UHglT1NPC5OUbJaD10lEfkdZcWqGJoPTWQxoOU=;
        b=jd8jqbBx9YTWzOvvdMy5jg2ItpkiGKByB0gZfqiqlaARW76DkXmvqaRoGwQ79Jjkvu
         1KguaVTlcK8NDQFqc5bQ+gu3GX9ofT3kUKrMsMVwhJ+ZT2Ml8o/CYmARQXEvkIFiwMhZ
         k/eGDoEkLtJmBVFOdO+M+Wi9m3VG/BTPvWh075Xzsb25oGdsR2YBf3WdEL9FIKZ6l41H
         YSdcXTbTaW3yMF0OiUJTPG/n9zOadpO9ebDwe2HZfSnW8wHZO9E3eoS8wd3UsxmyXKMD
         +f8l7vo5ZilYaWchBBQxT1RfO/NcGKtSbwK5mgcfBidu4JMgafuRJ1Eo86nMU/lylfUu
         dzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OiO20UHglT1NPC5OUbJaD10lEfkdZcWqGJoPTWQxoOU=;
        b=NqDfyPSZpWK7iHlX5BgT+wL4+mAQqRQVmCf+BeujhnFHTnsQOv0OUbXWTi+WdHo3y6
         li86V00FBzjAE22bKR4+Sd8KPBAkMQgnGGDQ/ZOzGsbpDPZBBIlV2LfdpUa0GB7WHHJL
         D/1MsgGnQGnb+XeTQupz+iKrfNPvAB5OJue6LT2ngjQIr1w/M/fTbAeR41ugkwoa8YfP
         fsmaPkByzu1I9UG1QMHpRUHygV0FayG+kBeEiGwCHsbHKZq3QxRXMYaU1DntlAfJzj16
         m17cI0mk5IG3VgRg85/iIdkyJLvEakQYQplXVYkmitNxr0mx1/YO2c2AwaJNisVU2Abk
         LBSQ==
X-Gm-Message-State: AOAM531BjM7yyNC2yWXbHaobFIwRxHPG2IJhjMZMXQigVUPzk30AKpoB
        LpeHi6nqdrMqzHNUilgccEo=
X-Google-Smtp-Source: ABdhPJxNmdN6SPNK6ttpWpEps6y/muZWcUeT9JaqAcfxDLw/qA7GAxVt8LTKjYUKRs398wxE4PloYA==
X-Received: by 2002:a17:90a:8809:: with SMTP id s9mr11711271pjn.44.1628705073315;
        Wed, 11 Aug 2021 11:04:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j6sm170548pfn.107.2021.08.11.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:04:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 08:04:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v4 1/6] cgroup/cpuset: Enable event notification when
 partition state changes
Message-ID: <YRQRL0M5SAKugVQ6@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811030607.13824-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 10, 2021 at 11:06:02PM -0400, Waiman Long wrote:
> A valid cpuset partition can become invalid if all its CPUs are offlined
> or somehow removed. This can happen through external events without
> "cpuset.cpus.partition" being touched at all.
> 
> Users that rely on the property of a partition being present do not
> currently have a simple way to get such an event notified other than
> constant periodic polling which is both inefficient and cumbersome.
> 
> To make life easier for those users, event notification is now enabled
> for "cpuset.cpus.partition" whenever its state changes.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
