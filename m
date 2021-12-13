Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAACC47362C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhLMUl0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 15:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbhLMUlZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 15:41:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77508C061574;
        Mon, 13 Dec 2021 12:41:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z6so12027464plk.6;
        Mon, 13 Dec 2021 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=14Dwn7cQaB5yg3QXXz3HOGmIXUCfHUTFsdjkk6DpI/c=;
        b=HkXX2ZRDeFERmYakQz3KxfITmvUHxXbei6EVsg1xNl4SMDx7tdEX0sCbfY1vGo2MLx
         DB0K2/jcwikKcwcqxysyKs5c5/lGgUAv6xj0WDjU8Vs0WaVla4CxoB44BAVRWoZSQV7+
         7ZTFRBRx9WkLFtjaGKX5TMFC9obf/haau0n9Pwc7ymvBF5H3g1w/Eyh2ggT55jOuxJ94
         4AP6ggzko6rlYfv/w9IUjj9vjzj3pxWTUgOMHcRH8ICyvsvSCgwgntn78RwLo92lZMso
         /a5cJXMA1OIh0QVxvgQPxvB3CJNFlhbcUWIP6N8zCZBlhtbgNxy3m2DUjIiBr4qU95rU
         VLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=14Dwn7cQaB5yg3QXXz3HOGmIXUCfHUTFsdjkk6DpI/c=;
        b=WpLdJtSRAQjoT9sdudZz94eJVxHRebN5qWLd6u12K7zys/VUsD46aHc6Oo0thVK/l3
         lZQCyRHW5W5bF3EbpP+t0Y/ahSODD9/aXi7IPp4++dnI6oJjhAyplADuBFyUstcOaamL
         BxNyF7AZEVjjD0zJFoPmcZHljktDHwrBirsQY7JFVCSm09hP8zUbAdEi5JrG2T6e57MP
         djPygtuTK9EjkX2XfHn4KlgFY3Y25CZu9gIKvKRtMC+wpm0bAtSwnfLD/AephyBXXnwA
         xj9t0I4xFK9D0qbt+qQp5z0cQBvXFIUlCMbCn4KDnk5Y49MjpbUgYHfPPoYldM0ZXhFA
         ihnw==
X-Gm-Message-State: AOAM532O0efa/j1BoqJLzC9BeeFzBj+bjHs2bmqF7glJ1stRBWSnO+X1
        a/MqU5O2S10NPnsqQQanw/I=
X-Google-Smtp-Source: ABdhPJy8K6EIplh8EZHrI+8BVeJCnrDh44AuB2PYcVwdhy1z5gnnuaZtDOTyVmxK5UMQ+pGeR0zO+g==
X-Received: by 2002:a17:902:a40e:b0:143:ca72:be9d with SMTP id p14-20020a170902a40e00b00143ca72be9dmr795707plq.67.1639428084873;
        Mon, 13 Dec 2021 12:41:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m14sm11908643pfh.71.2021.12.13.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:41:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 10:41:23 -1000
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
Subject: Re: [PATCH v9 1/7] cgroup/cpuset: Don't let child cpusets restrict
 parent in default hierarchy
Message-ID: <Ybev80+h4JArgMDz@slm.duckdns.org>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205183220.818872-2-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 05, 2021 at 01:32:14PM -0500, Waiman Long wrote:
> In validate_change(), there is a check since v2.6.12 to make sure that
> each of the child cpusets must be a subset of a parent cpuset.  IOW, it
> allows child cpusets to restrict what changes can be made to a parent's
> "cpuset.cpus". This actually violates one of the core principles of the
> default hierarchy where a cgroup higher up in the hierarchy should be
> able to change configuration however it sees fit as deligation breaks
> down otherwise.
> 
> To address this issue, the check is now removed for the default hierarchy
> to free parent cpusets from being restricted by child cpusets. The
> check will still apply for legacy hierarchy.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
