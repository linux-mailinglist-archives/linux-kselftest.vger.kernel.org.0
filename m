Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14403E974E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhHKSJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHKSJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:09:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B3C061765;
        Wed, 11 Aug 2021 11:08:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so3748250pll.1;
        Wed, 11 Aug 2021 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XPgK+iyXy46IJH8Hj0istqzWfGCuBh53Hqdy3vFF5K4=;
        b=r7PopeTgrDc7n/bWwJ5e0f+BfBFRl6LtdflJvnIbuLrPKhqkoKkpxRUqoXMKOpzs0V
         Q4Gnet2Qeyd83m0rW2rhAHI1r3i6lVIitzHZcv//k30rtHw4yEevrtcr44drgCpAVOFa
         kEqekTBwmfWRuPmSupYTKQRxrPvxcABuszOiWjjJrZXnzWBI0HvEpD26C0FVOXhTr24+
         QJ2tHd2EfoMIJnZikWNESVpzCCC5dA+gbx+ix8M3McgtB/jYW3w4G5mHME7Ncr5oy09T
         zUmokknlszJGYu245+vvI3g6gp3mip3SjOKvWykSOL/xetEvmbOKOEfb1Rxi43R70IVB
         kubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XPgK+iyXy46IJH8Hj0istqzWfGCuBh53Hqdy3vFF5K4=;
        b=ftY6tcSrhnoh9AiA+lySnP4rdjq1OkxAKxXk4jgtLUwuijlH5UZoh6vGdUNC+pms8b
         fZyZK2Q2pgMHaNO2DqDu6MWLLVGYxpOkDdOk3kkiz+UvFHUj2Tpj0EYtwX+PuDZ57Ow4
         Zd1KW7cN5jJGvPv4yPUU1q/RJDI2613tCrJHCzqmDYlvjimsy1/Egk0rWzr9f3ydQJru
         eK86LalBHcnvvYiXXEdRXUg09LrUMKmj1Ur3L4T7Td84U3pPtpxFB8vkty6PeARaT/3f
         mUquz33Jmx3/r3/Q2ClMhAGBeaI8VCxF+ELGRAU4b6Hr8uUUMe7NzEIo+9oQlxig/LIF
         WjJg==
X-Gm-Message-State: AOAM530vwFfQBEUlRJpMHWeP8EgLbPNqrEJ4BtkHnyaLDScTHivBl/J8
        WH84MJR9ziKx4AiPyVy0bx8=
X-Google-Smtp-Source: ABdhPJyM4psCveusSAJW4HLpM4x36fW1ck8QCH6YAqzVzGyG0fLw56sU1y2hMvpPr33k8Nng5+yrZg==
X-Received: by 2002:a63:5c10:: with SMTP id q16mr10236pgb.128.1628705327189;
        Wed, 11 Aug 2021 11:08:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k3sm198429pfc.16.2021.08.11.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:08:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 08:08:41 -1000
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
Subject: Re: [PATCH v4 2/6] cgroup/cpuset: Properly handle partition root tree
Message-ID: <YRQSKZB8rQUsfF2K@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811030607.13824-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Aug 10, 2021 at 11:06:03PM -0400, Waiman Long wrote:
> For a partition root tree with parent and child partition roots, this
> patch will now prohibit changing parent partition root back to member
> as changes to "cpuset.cpus.partition" should not cause those child
> partition roots to become invalid.

So, the general rule is that a descendant should never be able to affect or
restrict what an ancestor can do in terms of configuration. This is because
descendant cgroups can be delegated and a system manager sitting at a higher
level in the hierarchy may not have much control over what happens under
delegated subtrees.

Given that we're promoting the error state as the first class citizen in the
interface anyway, wouldn't it be better to keep this in line too?

Thanks.

-- 
tejun
