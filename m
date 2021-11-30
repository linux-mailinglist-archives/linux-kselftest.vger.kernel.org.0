Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8274C463C90
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 18:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhK3RPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhK3RPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 12:15:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA24C061574;
        Tue, 30 Nov 2021 09:11:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so21257936pfb.8;
        Tue, 30 Nov 2021 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ONrE5/Qkw4zkh7Cw4Mc/Cvd1DgPGRMMe+Dlw1qGvx2E=;
        b=lpdHoZHC+hlX1FXzDNnODOfKuB01wlK9cDytInDrRCRM5d3sfeu8SIa+VNjEXczz0j
         Kdgx0UH7nlKa7P1zxooslo/0wQ4o1ukUWRAmG10vy3ESoetmfvl4p9HWMi92xbZeMYnT
         vIjw4wdIX/HCptVJCo7lF9oiI6NfKd3Z/DYQ3MhttwzjqKTuI2BPOHDJKcdkm1NrwGv1
         9W11Fc3bo1OurBtgoGvBJyIPAN3+88Kq+f1R9BOP/tMQoNN3CZxklVpF3NSAtICcQk9x
         /63gjcPTtrTdoyUBcKAhQ4nclxtO+zT/Fg4ZsEmIrvKlTZSWFFeMRbrVwEJzbojAZnF1
         N7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ONrE5/Qkw4zkh7Cw4Mc/Cvd1DgPGRMMe+Dlw1qGvx2E=;
        b=kMmQtAuS2/Ta9FV+dlSuc6Mr5LFzUM6FsUSxlbwiGaeG3wNKdSu12WaGq9zwkHyXG5
         ejnVMM2NK0HdyqwrOu2txvwWTnLMWqfFeBmJ08LAWQlJ/yueEXGNDMgFNnOSAyxvIZpS
         I2xBJyJdlaRDtI6pTM7ZqGBWGp4pYsj9cA/504GhaKylH9/FRLb/EjZfMIkgOa5Sd15/
         lGzvyDkK1hOSNvOxnUGKOdnqAJ+EcicTsEK1samQG0i9E6PZgeux7jlQU9kWrH0Ph59M
         StB8R9afBYha5B5qdmCnC8YxxWNUDwrZNuziruo8sWUHPt1lQVkDixxE6RLslebmuIAm
         1y3A==
X-Gm-Message-State: AOAM531a9SoRS4Nr3Kzfpm/8zJ1L/if1zF4Qd7c+Zswkz2QoyckBFnU/
        LLwbRQ5eX4Nfkekeb1Wcil8YxjxzMDoYyA==
X-Google-Smtp-Source: ABdhPJzTltZrAXhlp/9DAXKJXPxxdsqgylUo5rbnrEQJRj+rwSNyZbvo2vr+Un2olnmmNc1HCZyYDw==
X-Received: by 2002:a63:c:: with SMTP id 12mr355760pga.492.1638292318116;
        Tue, 30 Nov 2021 09:11:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id l6sm3538098pfu.129.2021.11.30.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:11:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 30 Nov 2021 07:11:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YaZbXArNIMNvwJD/@slm.duckdns.org>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

On Tue, Nov 30, 2021 at 10:35:19AM -0500, Waiman Long wrote:
>     On read, the "cpuset.cpus.partition" file can show the following
>     values.
> 
>       ======================    ==============================
>       "member"            Non-root member of a partition
>       "root"            Partition root
>       "isolated"            Partition root without load balancing
>       "root invalid (<reason>)"    Invalid partition root
>       ======================    ==============================

What happens if an isolated domain becomes invalid and then valid again due
to cpu hotplug? Does it go "root invalid" and then back to "isolated"?

...
>     Before the "member" to partition root transition can happen,
>     the following conditions must be met or the transition will
>     not be allowed.
> 
>     1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
>        not shared by any of its siblings.
>     2) The parent cgroup is a valid partition root.
>     3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".
>     4) There is no child cgroups with cpuset enabled.  This avoids
>        cpu migrations of multiple cgroups simultaneously which can
>        be problematic.

So, I still have a hard time justifying the above restrictions. 1) can be
broken through hotplug anyway. 2) can be broken by the parent switching to
member. 3) would mean that we'd need to restrict parent's config changes
depending on what children are doing. 4) is more understandable but it's an
implementation detail that we can address in the future.

>     Once becoming a partition root, the following two rules restrict
>     what changes can be made to "cpuset.cpus".
> 
>     1) The value must be exclusive.
>     2) If child cpusets exist, the value must be a superset of what
>        are defined in the child cpusets.
>
>     The second rule applies even for "member". Other changes to
>     "cpuset.cpus" that do not violate the above rules are always
>     allowed.

While it isn't necessarily tied to this series, it's a big no-no to restrict
what a parent can do depending on what its descendants are doing. A cgroup
higher up in the hierarchy should be able to change configuration however it
sees fit as deligation breaks down otherwise.

Maybe you can argue that cpuset is special and shouldn't be subject to such
convention but I can't see strong enough justifications especially given
that most of these restrictions can be broken by hotplug operations anyway
and thus need code to handle those situations.

>     Changing a partition root (valid or invalid) to "member" is
>     always allowed.  If there are child partition roots underneath
>     it, however, they will be forced to be switched back to "member"
>     too and lose their partitions. So care must be taken to double
>     check for this condition before disabling a partition root.

Wouldn't it make more sense for them to retain their configuration and turn
invalid? Why is this special?

>     A valid parent partition may distribute out all its CPUs to
>     its child partitions as long as it is not the root cgroup and
>     there is no task associated with it.

A valid parent partition which isn't root never has tasks in them to begin
with.

>     An invalid partition root can be reverted back to a valid one
>     if none of the validity constraints of a valid partition root
>     are violated.
> 
>     Poll and inotify events are triggered whenever the state of
>     "cpuset.cpus.partition" changes.  That includes changes caused by
>     write to "cpuset.cpus.partition", cpu hotplug and other changes
>     that make the partition invalid.  This will allow user space
>     agents to monitor unexpected changes to "cpuset.cpus.partition"
>     without the need to do continuous polling.

Unfortunately, my sense is still that both the restrictions and behaviors
are pretty arbitrary. I can somewhat see how the restrictions may make sense
in a specific frame of mind but am having a hard time finding strong enough
justifications for them. There are many really specific rules and it isn't
clear why they are the way they are.

Thanks.

-- 
tejun
