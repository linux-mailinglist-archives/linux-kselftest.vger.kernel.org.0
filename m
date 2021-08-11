Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2A3E9790
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhHKSVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhHKSVh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 14:21:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2FC061765;
        Wed, 11 Aug 2021 11:21:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so6534770pjb.0;
        Wed, 11 Aug 2021 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HFDIoz8d7Mv9aa4YQB/vncboqcxrcGkzaCeqrt8Oa/c=;
        b=MS7b9dsp8zC6Ryob8fxICyK6KkSDR+X5AMd+2XpfBHkmhREj5PIpVfoOXNQiS4reRj
         0cTMvejH51bHkLHR2I8NMuhzRvYSqx3rZetceDQt90jdntsqtNvYKw2AmX3mJgVQVTVp
         z2mDnMbvykTMuDXEtX+r9TIEw51KrQ2r1vdwmV8+SGxf9f1Lvcxta/iq7gfj37x0svwl
         e4vZXTh5smg5nlsx1T8arrxCQbPfHtyfrGukGc8+cIZTm+WPKpAG1Nw5IWf0N1sAgXuk
         2ZZVKz5kEiCe86Ao+nx5cQxTIaWVAkGi8sLj53ubKE+jzK7VdMsym7KQZxTtLZ/Smn+a
         +HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HFDIoz8d7Mv9aa4YQB/vncboqcxrcGkzaCeqrt8Oa/c=;
        b=cUjjlGycQDSmQO1rKMPlc10PLFGoDZzYPRtPGn0OVO0pzx3j1B4xL+DLpvsKFf4HmW
         dzi+bNRrnRhqDmo80qkg5rSOJR8mj1caHzweu/f44ypaep/+ohyDy+sv0R25pr0QNcIK
         bNGuEsnhD3w6+SObyze1QZs0nOlsDvwjqgI84nUm0xnwId9vkCLK9YIb/fPAU7FpDmmL
         jznicQbCbcCTSRpFWFYGA4DiXwAYqy5Ijlzy0gSn6PUt1t4jJ38GBrF5LZpUand7NfEh
         TAiBlD18TXSGVuAq3YJYiK/ysDVpQwYjlqxM5s4M/1vNdi+bnlEjVWMxDG0hY2r0SOzK
         cWgg==
X-Gm-Message-State: AOAM530nB2gkAPRYAl3iyMFeOTLBxJtITTd9L+0OwWjDS6cIB7UQXcAs
        FxENxsNBTfBpFhTgmLvNoKc=
X-Google-Smtp-Source: ABdhPJyYkkRsojjCYY9VV9gfROKrwOXgrrIk3uvSgqtIgS/Oes3SMHamrQ9ox/9lxGtE+huBvUaCvQ==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr11894287pjo.172.1628706073517;
        Wed, 11 Aug 2021 11:21:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id jz24sm136447pjb.9.2021.08.11.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:21:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 08:21:10 -1000
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
Message-ID: <YRQVFkNX5DcKixzy@slm.duckdns.org>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-5-longman@redhat.com>
 <YRQTTf+bJZ8f3O3+@slm.duckdns.org>
 <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfa6f2f-aa13-f18e-5a16-f568082d07bc@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 11, 2021 at 02:18:17PM -0400, Waiman Long wrote:
> I don't think that is true. A task can reside anywhere in the cgroup
> hierarchy. I have encountered no problem moving tasks around.

Oh, that shouldn't be happening with controllers enabled. Can you please
share a repro?

Thanks.

-- 
tejun
