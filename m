Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7E3F697B
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhHXTFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhHXTFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 15:05:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E11C061757;
        Tue, 24 Aug 2021 12:04:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q3so998131plx.4;
        Tue, 24 Aug 2021 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UA6BwC0CYO3Y/QhMBFUGVm/MkfIStQXJiA2tvHOy2E=;
        b=InWzEdcms5aFyJNybcPjVBSg4/YyHC4fs7zj6R3+Yv8npQ+KHDzLn7itVIJu+p0sHT
         Q6/AUyTgYzD4VmqdR9mT1dT/7tCLVlhkqQ/1fiIhbCTjlCBCkR0yPpVP4Ca8n7w2ruLK
         XWlTNoMagLkN9eGT4Cw2YtHTD8+Z3VwnEmanlqU5CZ0xTq6kvLeWtXHeIAqIeABYjt0f
         d3erx68+4v5ESugAEzgpSqPJvh3Y/ygsLs1WR4yWXbCmSqKrnG7ph4qWLPKhvlxAPqQn
         sKyLbd5GGKgF0NFzQJ/4M8M/eNrdTnpp2PZvqEyxbd5bFuVuIpnAOVFlYGR1lUTG1JJ5
         CFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/UA6BwC0CYO3Y/QhMBFUGVm/MkfIStQXJiA2tvHOy2E=;
        b=lS4W5pM2Wl0BBsmO52qQMvrliPU6rbS8gxrMsakpZONEcSGQcPqgserR6rOkgXmprY
         +/dmMVWjswUy83IcdTSVaG7JKe4H9l6QPJGOlftdakPHVAmPdMqw0kl8TB0tKjXP5oEf
         uDDj+W+IpnKauHAdbEpIY94nqIrgJXlo6MxGciKlLhCYZUhsRQ9phQZCW7JzqG/5TGDW
         jGeZS9bANaqUJwAVqwcL2gRIVnrPNlkOa0daunmXMROy0LKJTmajuesUoe05PTSvCdtT
         nBmocAlmLqo0nP+i1l06W2WBxR4GdgMzGtLj2RHuwPh3/vkd2gQPc2CaYQqWgnk2XZdY
         lUwQ==
X-Gm-Message-State: AOAM530vvaKQzfH/jFhSQZY2Yv8Btzl/TS5JfV2etjXK/wKGV3b3pM2V
        S9o4nawErxQR9SSaG8TAoAo=
X-Google-Smtp-Source: ABdhPJyhbBipA6XjYTSx4y0PY5Ht0XzmDWNUtPlnqLHfabUjvvNeTCPw9WKJzvTRd4sM/RPuAgOVYw==
X-Received: by 2002:a17:90a:3fcb:: with SMTP id u11mr6071898pjm.178.1629831873686;
        Tue, 24 Aug 2021 12:04:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y12sm19425378pfa.25.2021.08.24.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:04:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Aug 2021 09:04:31 -1000
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
Subject: Re: [PATCH v6 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YSVCv0WjTzwPUWUN@slm.duckdns.org>
References: <20210814205743.3039-1-longman@redhat.com>
 <20210814205743.3039-6-longman@redhat.com>
 <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
 <95b72d36-32a9-8356-05b7-2829e4cc29ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b72d36-32a9-8356-05b7-2829e4cc29ad@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Aug 24, 2021 at 01:35:33AM -0400, Waiman Long wrote:
> Sorry for the late reply as I was on vacation last week.

No worries. Hope you enjoyed the vacation. :)

> > All the above ultimately says is that "a new task cannot be moved to a
> > partition root with no effective cpu", but I don't understand why this would
> > be a separate rule. Shouldn't the partition just stop being a partition when
> > it doesn't have any exclusive cpu? What's the benefit of having multiple its
> > own failure mode?
>
> A partition with 0 cpu can be considered as a special partition type for
> spawning child partitions. This can be temporary as the cpus will be given
> back when a child partition is destroyed.

But it can also happen by cpus going offline while the partition is
populated, right? Am I correct in thinking that a partition without cpu is
valid if its subtree contains cpus and invalid otherwise? If that's the
case, it looks like the rules can be made significantly simpler. The parent
cgroups never have processes anyway, so a partition is valid if its subtree
contains cpus, invalid otherwise.

> > So, I think this definitely is a step in the right direction but still seems
> > to be neither here or there. Before, we pretended that we could police the
> > input when we couldn't. Now, we're changing the interface so that it
> > includes configuration failures as an integral part; however, we're still
> > policing some particular inputs while letting other inputs pass through and
> > trigger failures and why one is handled one way while the other differently
> > seems rather arbitrary.
> > 
> The cpu_exclusive and load_balance flags are attributes associated directly
> with the partition type. They are not affected by cpu availability or
> changing of cpu list. That is why they are kept even when the partition
> become invalid. If we have to remove them, it will be equivalent to changing
> partition back to member and we may not need an invalid partition type at
> all. Also, we will not be able to revert back to partition again when the
> cpus becomes available.

Oh, yeah, I'm not saying to lose those states. What I'm trying to say is
that the rules and failure modes seem a lot more complicated than they need
to be. If the configuration becomes invalid for whatever reason, transition
the partition into invalid state and report why. If the situation resolves
for whatever reason, transition it back to valid state. Shouldn't that work?

Thanks.

-- 
tejun
