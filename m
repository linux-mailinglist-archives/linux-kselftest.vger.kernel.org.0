Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02D3F935B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 06:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhH0EBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 00:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhH0EBi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 00:01:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB23C061757;
        Thu, 26 Aug 2021 21:00:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 18so4561655pfh.9;
        Thu, 26 Aug 2021 21:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpRCOr3AO5VpkYHN7Nr0GT4x4AL433B9T05VC2iQWfI=;
        b=agLVZrQwXBCGPbao8KSDI/E8Y1tw6ek8pydIzdGVSl3O7JDMEhz0Q0ISX8FMIJyLPn
         zI+9sYe7L3R3ieWCUsCQYVidH+np+rVbmK2eCHc8pXts5C5lgAHoyGoY7sg7BmTJS27H
         OOiC1uOEXNnikYHTF9DauqdUUdPwNlKH7Zo0uM3swTAKAoTe67aqH1ilqpNqFgI6yw71
         hshTZ0n/3RjKUyA7V71I8mLkJ0SkTklSOehx8XA46kTNi24UU8Fw4GwkXr+yx+bXjloK
         mLQGcdQ0DnPcaACF68cpwBIhXSsP+uo+E48/N05ayicQ9anDwG/sVr7J+MPoCmg9f0vq
         Fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RpRCOr3AO5VpkYHN7Nr0GT4x4AL433B9T05VC2iQWfI=;
        b=aNiFMVy4Jl3+w4ZdYSpkyqEl6Ym2wS2NoBZ/QONzie3W/NhUoQVA6bZJVJfzbOIlQM
         dByNtJuycjPDt9q9WYPs4dGmbsE6E7ENftH0snMYSkLwTiTk+vaMMipk7zNSGLrZ+sJh
         tZ56PcpI1nFo8S1QDritIbGHEnC1S1Kl+wUVXonh1jUY8BA16vsKJew+TKVGe56iPzso
         ImIJS2uHF8GSXHCFQQLQydzZFdhEpMQvsnwGjiwagyP5xXFmOHkl4oxps1tmRn/08gIf
         DoceusE+WVeUtos2l7b4qLY5goiitdd6NWrgtmHGK8KvzUcpyWv2zSuMQYzt2M18L4KJ
         QQDA==
X-Gm-Message-State: AOAM532wXDSaWj0MTvJv7Oc76SnCjNUcg0jNDyBsWwTB06DnflPC8wt0
        d2OsrlJLGSPj8BwbdQdE3V8=
X-Google-Smtp-Source: ABdhPJzmGI5JoHBM8adBGwIfq7rgb6Tpz7/XdpLtiHUK2uAR+MF0Qmkrw9dipCxMettwYvcuKDc5fQ==
X-Received: by 2002:a63:f145:: with SMTP id o5mr6169427pgk.273.1630036850050;
        Thu, 26 Aug 2021 21:00:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b3sm4577431pfi.179.2021.08.26.21.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 21:00:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 Aug 2021 18:00:47 -1000
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
Message-ID: <YShjb2WwvuB4s4gX@slm.duckdns.org>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
 <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Thu, Aug 26, 2021 at 11:01:30PM -0400, Waiman Long wrote:
> What I am doing here is setting a high bar for transitioning from member to
> either "root" or "isolated". Once it becomes a partition, there are multiple
> ways that can make it invalid. I am fine with that. However, I am not sure
> it is a good idea to allow users to echo "root" to cpuset.cpus.partition
> anywhere in the cgroup hierarchy and require them to read it back to see if
> it succeed.

The problem is that the "high" bar is rather arbitrary. It might feel like a
good idea to some but not to others. There are no clear technical reasons or
principles for rules to be set this particular way.

> All the checking are done with cpuset_rwsem held. So there shouldn't be any
> racing. Of course, a hotplug can immediately follow and make the partition
> invalid.

Imagine a system which dynamically on/offlines its cpus based on load or
whatever and also configures partitions for cases where the needed cpus are
online. If the partitions are set up while the cpus are online, it'd work as
expected - partitions are in effect when the system can support them and
ignored otherwise. However, if the partition configuration is attempted
while the cpus happen to be offline, the configuration will fail, and there
is no guaranteed way to make that configuration stick short of disabling
hotplug operations. This is a pretty jarring brekage happening exactly
because the behavior is an inconsistent amalgam.

It's usually not a good sign if interface restrictions can be added or
removed because how one feels without clear functional reasons and often
indicates that there's something broken, which seems to be the case here
too.

Thanks.

-- 
tejun
