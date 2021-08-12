Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341783EACCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Aug 2021 23:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhHLVv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Aug 2021 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhHLVvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Aug 2021 17:51:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDDC061756;
        Thu, 12 Aug 2021 14:51:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso17515710pjb.2;
        Thu, 12 Aug 2021 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jH45JI3TRK33maJqrgZXXznOLgIkQBFryW79S8eId3M=;
        b=Y9WHxm/HccEPeJfkiPBSqOtIQdiDsYdt/RUttWpOGC4h8GALHwr5TYVrcHS/FwHdAW
         brH64YsniZ1m2CNdrbrRALQs4yxFN228FlIYSp3S0S81J4b6QJOTWS/mu0gD20utmJ4x
         mB0yPjJdiz3mudogXhcCUvzXk7KEW3/afkG4GAVpFUIkWVh+DvpPNLLJu2S0RFYmI34h
         2l3Qd9IzJRZjgCQqH93U+FiFNpHfZT5x9yWgcHrcG+V3oXyZa/BN7M+FKmnG3winetMh
         U2i52F02EYfs7f0/kK4ctk7+orUAr3RLJDZxf9bOxVyu9FtRjPORwymlSEnsMzmX7cmf
         Rq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jH45JI3TRK33maJqrgZXXznOLgIkQBFryW79S8eId3M=;
        b=UFWcEwc9mxWTxTEaSSvaPoYTsHj7xK81KpEQxWx4erOuT064tSaaH25IIU49vhY0zd
         VTB8PdtxKw1WRDnGz31hBVTsN4pdR8F8LGratmYeImY2Nos3J1y/QZFrVTtSIXu3fNpe
         CKKpfxnMGX+HSkuwkixrUeDWI2wQgKZQVymIu9bzcDrnqzmzj0pGWBbtKKy8VxBZ5V4L
         S0d/CERgrefSODLEm0I+LPoYoGVJZUHjzBDvfARqAxWSMSwa/3cVMVYkTuS2lD0JtpGi
         BhntUgyLn/Eo+DU7RaZ8wKR5XDUaihi0UWaKpQIgBHzF5cInxTgccuixw9E2ak3rZMXp
         9/Zg==
X-Gm-Message-State: AOAM533uIbjFfDwdoI6KCqFZRp1Z2nepJZxARnLLydyA2z1SNOld9cdE
        fyfwhNt1kt+fYCxXKOF3hJ8=
X-Google-Smtp-Source: ABdhPJwEXO2THTKS4vvUuPSEOfOrBsgd6SOTklUjz6kq5d0glnm2/Fvo+k2qec0LQGwZrRypvtx47w==
X-Received: by 2002:a63:ef45:: with SMTP id c5mr5795654pgk.78.1628805089495;
        Thu, 12 Aug 2021 14:51:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u21sm5031925pgk.57.2021.08.12.14.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:51:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 11:51:27 -1000
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
Subject: Re: [PATCH v4 4/6] cgroup/cpuset: Allow non-top parent partition
 root to distribute out all CPUs
Message-ID: <YRWX3z6Nl41GsXR8@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-5-longman@redhat.com>
 <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
 <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
 <YRQVFkNX5DcKixzy@slm.duckdns.org>
 <ef02d96b-325c-87f6-a6a3-d840feefef24@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef02d96b-325c-87f6-a6a3-d840feefef24@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 11, 2021 at 02:46:24PM -0400, Waiman Long wrote:
> On 8/11/21 2:21 PM, Tejun Heo wrote:
> > On Wed, Aug 11, 2021 at 02:18:17PM -0400, Waiman Long wrote:
> > > I don't think that is true. A task can reside anywhere in the cgroup
> > > hierarchy. I have encountered no problem moving tasks around.
> > Oh, that shouldn't be happening with controllers enabled. Can you please
> > share a repro?
> 
> I have done further testing. Enabling controllers won't prohibit moving a
> task into a parent cgroup as long as the child cgroups have no tasks. Once

Should be "as long as there's no child cgroups".

  root@test /s/f/cgroup# mkdir test
  root@test /s/f/cgroup# mkdir -p test/A
  root@test /s/f/cgroup# echo +io > test/cgroup.subtree_control 
  root@test /s/f/cgroup# echo $fish_pid > test/cgroup.procs
  write: Device or resource busy

> the child cgroup has task, moving another task to the parent is not allowed
> (-EBUSY). Similarly if a parent cgroup has tasks, you can't put new tasks
> into the child cgroup. I don't realize that we have such constraints as I

You can't enable controller from a populated cgroup:

  root@test /s/f/cgroup# mkdir test
  root@test /s/f/cgroup# echo +io > test/cgroup.subtree_control 
  root@test /s/f/cgroup# echo $fish_pid > test/cgroup.procs

> usually do my testing with a cgroup hierarchy with no tasks initially.
> Anyway, a new lesson learned.

The invariant is that from each controller's POV, all cgroups with processes
in them are leaves. This is all pretty well documented in cgroup-v2.rst.

Thanks.

-- 
tejun
