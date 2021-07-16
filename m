Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67E63CBDFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jul 2021 22:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGPUtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 16:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhGPUtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 16:49:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F3C06175F;
        Fri, 16 Jul 2021 13:46:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g24so7120431pji.4;
        Fri, 16 Jul 2021 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CcNFha5vgUcweegT4k/uNLuzQ/cieMwjGwt7INh2sMw=;
        b=V9jl6P3GvbA4iXwjdyXzx+zVSBWTXHMvy4BPlOaIhy+YXU3ZDZmyPD4P1Td8/rqdNS
         rQ59CYIarn3bQoia//d6o/Tkjb4S6+l/svi7EJER6d4bpC1mhOnC5pQGYJSP5yIMgQgT
         Dq5KlNB02W+b7KkfOMpo1CUrvEG9aEJ/AW1k+fI1SarpP1EBhVcTWDFIUtALtgsyaba/
         LfY2bvDAYkkln8F2uMqNk4jgn2bu/ymfRLtJIvgAV7HSIObuOApR9tP23FAbRC7dEDhk
         Irvae0p9FqA59iETjQxdva4lTiXKYDdwtco+YuYTQhvRYJj12/wOjWLcONpGEp1Xmr4o
         SmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CcNFha5vgUcweegT4k/uNLuzQ/cieMwjGwt7INh2sMw=;
        b=rlDIFTKoN3ZQy9E1Z6JaXAdL+FrqxNNS5mj8/s0OWdCQIKGXNLcmpTJ4UwBJamzi3q
         y4s7rXMXJCbCVpicXG3Z68+LxJEjFn11Yx399X0TZI+AndGmyN/n+rQ6PyOug5djEny6
         HJnG3OgFSkQm0Gw72dQowwClf8h5hx72UJfnRf8OFF5rRQB48pHNK8kQ87FVZZknr25T
         aVD1frpjWCRG9YAtdZDx3gEnYVahqjf0d1zSoBfdB6E/c48qyf+cIKxM+Ko8h3xHgkSq
         qvda19qIiCSFfErWNEqdbbnE8x5JToZ6YJT2npG3UTsP7yBbr4hvQ3duXZvQLxmmm9/y
         ulXQ==
X-Gm-Message-State: AOAM5310rBnkX1NQc1tS4RzhyJaD6cTIHkpLC5j2RcfN+b7gQqpqtj6y
        VmFK4BkTM2PF8yQvY2o8RIA=
X-Google-Smtp-Source: ABdhPJwuWtcN5PnLoy/5DKbZzAkJs2cS5G2WdpWRPdgEHqOky8qfivMQmg/J+wov+yNH0/wmTew3Ng==
X-Received: by 2002:a17:90a:d301:: with SMTP id p1mr16928955pju.220.1626468385096;
        Fri, 16 Jul 2021 13:46:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:37b9])
        by smtp.gmail.com with ESMTPSA id d1sm2179686pfj.24.2021.07.16.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:46:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Jul 2021 10:46:19 -1000
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
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
Message-ID: <YPHwG61qGDa3h6Wg@mtj.duckdns.org>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
 <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
 <YONGk3iw/zrNzwLK@mtj.duckdns.org>
 <c6ae2d9b-ad6e-9bbd-b25c-f52b0ff6fb9b@redhat.com>
 <1bb119a1-d94a-6707-beac-e3ae5c03fae5@redhat.com>
 <8c44b659-3fe4-b14f-fac1-cbd5b23010c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c44b659-3fe4-b14f-fac1-cbd5b23010c3@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Fri, Jul 16, 2021 at 04:08:15PM -0400, Waiman Long wrote:
> > > I agree with you on principle. However, the reason why there are
> > > more restrictions on enabling partition is because I want to avoid
> > > forcing the users to always read back cpuset.partition.type to see
> > > if the operation succeeds instead of just getting an error from the
> > > operation. The former approach is more error prone. If you don't
> > > want changes in existing behavior, I can relax the checking and
> > > allow them to become an invalid partition if an illegal operation
> > > happens.
> > > 
> > > Also there is now another cpuset patch to extend cpu isolation to
> > > cgroup v1 [1]. I think it is better suit to the cgroup v2 partition
> > > scheme, but cgroup v1 is still quite heavily out there.
> > > 
> > > Please let me know what you want me to do and I will send out a v3
> > > version.
> > 
> > Note that the current cpuset partition implementation have implemented
> > some restrictions on when a partition can be enabled. However, I missed
> > some corner cases in the original implementation that allow certain
> > cpuset operations to make a partition invalid. I tried to plug those
> > holes in this patchset. However, if maintaining backward compatibility
> > is more important, I can leave those holes and update the documentation
> > to make sure that people check cpuset.partition.type to confirm if their
> > operation succeeds.
> 
> I just realize that partition root set the CPU_EXCLUSIVE bit. So changes to
> cpuset.cpus that break exclusivity rule is not allowed anyway. This patchset
> is just adding additional checks so that cpuset.cpus changes that break the
> partition root rules will not be allowed. I can remove those additional
> checks for this patchset and allow cpuset.cpus changes that break the
> partition root rules to make it invalid instead. However, I still want
> invalid changes to cpuset.partition.type to be disallowed.

So, I get the instinct to disallow these operations and it'd make sense if
the conditions aren't reachable otherwise. However, I'm afraid what users
eventually get is false sense of security rather than any actual guarantee.

Inconsistencies like this cause actual usability hazards - e.g. imagine a
system config script whic sets up exclusive cpuset and let's say that the
use case is fine with degraded operation when the target cores are offline
(e.g. energy save mode w/ only low power cores online). Let's say this
script runs in late stages during boot and has been reliable. However, at
some point, there are changes in boot sequence and now there's low but
non-trivial chance that the system would already be in low power state when
the script runs. Now the script will fail sporadically and the whole thing
would be pretty awkward to debug.

I'd much prefer to have an explicit interface to confirm the eventual state
and a way to monitor state transitions (without polling). An invalid state
is an inherent part of cpuset configuration. I'd much rather have that
really explicit in the interface even if that means a bit of extra work at
configuration time.

Thanks.

-- 
tejun
