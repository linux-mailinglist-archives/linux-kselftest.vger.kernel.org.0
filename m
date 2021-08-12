Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99CD3EAD04
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 00:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbhHLWTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbhHLWTJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 18:19:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EBC061756;
        Thu, 12 Aug 2021 15:18:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso12996855pjy.5;
        Thu, 12 Aug 2021 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zFCvlCdjE9f7sPEj6Bash+YWPaS4lcq1GCfTDwodeA=;
        b=R4yXwtdcvocwR/bdi8p+iX4Ffhyp8BtxcPTMUe3KaMmMcL1xZcLE1vuGp3F+9TdP8s
         dcdiW38YxfL7HE1FEOsByI0q89D59M470EtczPWxls4gAKkZCVpWm8S3vtG+tqrudv5v
         iHMG81t3Qc0Sf6N8VvoQqo5NhBfUb2x7FUlnJf5rwedYdXxYmNIEuOzvCV1rwq3AEtvl
         nWr8FlzZzZHYpft+FuA/4H7fvr3ch3zOHKlg6zcM9pAw4l+fz+850kwswV+B/kfb17Uf
         FrCh5S5NxORAqyS3QZTWFqQLNdxbEZJQBLHr3ILpsZfUO/WxiNpSd0slQY8bifjFOZLP
         XVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8zFCvlCdjE9f7sPEj6Bash+YWPaS4lcq1GCfTDwodeA=;
        b=M4Y3Ud0hv6RzbCYqqeMnfBSi/HSmsL0HYdfNEMRfGINMHg3vEUq7U4ERHj9rNS5FNH
         fxEFFE5vGjbOsmj6qXvA+jBVLQvzDc3oD0bHqfh6ySE+zIVDf5qZBGR3Cwx+w2lc5TME
         MZ0Z8dwX3Yhex/NYnZ6OrQKpyUZHtSe6Dlyh/TNhbnng53cyYVtiQMSKmMK5z8nSqfvP
         pBlE6poXBWMtkfIPEcV1y1/qW6FRBGiQ6waJAVXLhIiam8IJe+oRu/aiJN2TK1PxkAJM
         wF1k2zdu83xFPKjmj+PkJNC2SxBnvakrl6U/p7m7/F/ANaoNJEVEHuspvh024O3pbKZ6
         ucuw==
X-Gm-Message-State: AOAM5317KL+Jq7zIHjW2g+ct5IdopE/CQzEEtohlDZr3/EWp76lE7pUv
        8XW2GT1RBTsaeI8ekozU6oA=
X-Google-Smtp-Source: ABdhPJwq7UxbTK/xozt+a4+BFNvqsdHWNZO26y8utQHcyBcySVkk/2qjJLg3m5a1Mawi8kjR1cfZ9Q==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr5846997pgq.206.1628806722676;
        Thu, 12 Aug 2021 15:18:42 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x19sm5101642pgk.37.2021.08.12.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 15:18:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 12:18:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
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
Message-ID: <YRWeQH6gY5PqIanD@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-3-longman@redhat.com>
 <YRQSKZB8rQUsfF2K@slm.duckdns.org>
 <b7897818-8fe6-8dd8-3ff6-6b15401162ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7897818-8fe6-8dd8-3ff6-6b15401162ba@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Wed, Aug 11, 2021 at 03:27:20PM -0400, Waiman Long wrote:
> Disabling partition at the parent level does invalidate all the child
> partitions under it. So it must be done with care when we disable a
> partition.
> 
> How about we give some indication that a child partition exist when reading
> cpuset.cpus.partition and recommend double-checking it before disabling a
> partition? For example, we keep track of the number of cpus delegated to
> child partitions. Perhaps we can list that information on read.
> 
> With that information available, I have no objection to allow disabling a
> parent partition with child partitions under it.

This is a general problem which has always existed regardless of whether the
errors are synchronous or not. There are many different reasons that a write
to a cpuset interface file could fail and it has never been easy to tell why
a given operation was rejected. Making error notifications asynchronous
doesn't really change anything fundamental although it does make the
situation a bit more opaque.

I'm all for improving visibility. Now that we can consolidate most error
states into a unified failure state, this might actually be easier to do.
IOW, we now just have to explain why a given cgroup is in an invalid state
rather than additionally having to explain why a given write has been
rejected, which is pretty awkward to do as those failures are transient and
local to the writer.

So, if you wanna tackle this, let's do it right and provide something
comprehensive rather than explaining just one failure.

Thanks.

-- 
tejun
