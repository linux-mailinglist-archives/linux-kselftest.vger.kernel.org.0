Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CD3FA1DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 01:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhH0Xgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 19:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhH0Xgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 19:36:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB3C0613D9;
        Fri, 27 Aug 2021 16:35:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w6so4904441plg.9;
        Fri, 27 Aug 2021 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prQGEZISCROhNVrZYgfW+RC/t0atKeeXslehrhwqbKM=;
        b=JVKQMqIk5zflT5U8YILqRhxIh0RbHGgU2gJ/VgQiRBTi+AYzDW0B+/RartoyZkUvtv
         0aIPVgKqWSag9KjmoSmL9tIWHn1wBjacgIraxFnfDb5qGOZIUWO89s/DReEueEyUwyCU
         xBvOq80P4g1ck6ZkFkbUuJXgJhQXW8bc4jx0W3R6bkzBf/GFgpdxXOI9qR3i3aZM7gd5
         k1QK34eoX7chwVUadq/Zz9w7KcoJP7gm1tTl686YBb5Wf7RXf5lNfYrYfB7UEh+SWZtl
         YKdr/zTz3TNPmZM45KKMPXB5YYh4yXEr6TJ8VDPPtbo+4L2n3eYoWYI/mfPVR3fadHXs
         3a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=prQGEZISCROhNVrZYgfW+RC/t0atKeeXslehrhwqbKM=;
        b=aNrFd0lBYtpLjnaB+Tl95tcX8/jTev+EWJUIe24+Q1fq4alqPHJqhW3BZrVAQahCO8
         lU97VFibutqea4xSFuXwl8skDACIKX4Rg7X72bCsYiTS0Y3d8Jm1NcThormu4x7rqIE1
         EPbCrG8OHChZBtKb8oC32CSi+mTkVUvJhlkQA25OUFouc/ayfZyjbaI1hjZS2N5krTKI
         QI8IAN3Fa9nnCw/oTzAGpvBkuEs/5vTKDkgYtscbMr0rvn3W1JFmM4p8LS+6hudujb5e
         ZPLY+0HIBwi0rI98tNHZQF6Sa8dZLjsG1BjAa2SmSY1SWMMVUO8/gvwZ4orOIKhGbMF8
         /3cg==
X-Gm-Message-State: AOAM531EW13cTGXbJIbZLNSpxmA5TLGdqndatJYgwjOmk4j1PEl3E4e5
        DAOPO0o5eUm5YSiik3tkRFc=
X-Google-Smtp-Source: ABdhPJzo7GAeRh/+rDxJrGaqKZmEyAUpP2yYvivtS9vTqfphRN1U2J0Hf3TZwmuAb4OjGHDeVSyHJg==
X-Received: by 2002:a17:902:6f16:b0:138:a3fa:1b7 with SMTP id w22-20020a1709026f1600b00138a3fa01b7mr3393031plk.60.1630107341560;
        Fri, 27 Aug 2021 16:35:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z3sm6973962pjn.43.2021.08.27.16.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:35:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Aug 2021 13:35:39 -1000
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
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YSl2yxEvnDrPxzUV@slm.duckdns.org>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
 <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Fri, Aug 27, 2021 at 06:50:10PM -0400, Waiman Long wrote:
> The cpu exclusivity rule is due to the setting of CPU_EXCLUSIVE bit. This is
> a pre-existing condition unless you want to change how the
> cpuset.cpu_exclusive works.
>
> So the new rules will be:
> 
> 1) The "cpuset.cpus" is not empty and the list of CPUs are exclusive.

Empty cpu list can be considered an exclusive one.

> 2) The parent cgroup is a partition root (can be an invalid one).

Does this mean a partition parent can't stop being a partition if one or
more of its children become partitions? If so, it violates the rule that a
descendant shouldn't be able to restrict what its ancestors can do.

> 3) The "cpuset.cpus" is a subset of the parent's cpuset.cpus.allowed.

Why not just go by effective? This would mean that a parent can't withdraw
CPUs from its allowed set once descendants are configured. Restrictions like
this are fine when the entire hierarchy is configured by a single entity but
become awkward when configurations are multi-tiered, automated and dynamic.

> 4) No child cgroup with cpuset enabled.

idk, maybe? I'm having a hard time seeing the point in adding these
restrictions when the state transitions are asynchronous anyway. Would it
help if we try to separate what's absoluately and technically necessary and
what seems reasonable or high bar and try to justify why each of the latter
should be added?

Thanks.

-- 
tejun
