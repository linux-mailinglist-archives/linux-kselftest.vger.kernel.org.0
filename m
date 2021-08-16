Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E283EDC09
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHPRJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHPRJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 13:09:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AFC061764;
        Mon, 16 Aug 2021 10:08:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so15189159pjb.3;
        Mon, 16 Aug 2021 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ezzl1wWnIMpMxrnM4W7DDVrnVpy6eCY3TnCdM56lXyY=;
        b=bz0Ae35bR0EHDskVbOAz6ZJTJsciOg38ggObJYVxbzJbN6FSJ2ga3D1fhPcm3CBqpu
         3K137eUco3rmgdvBI9wOWnRzVqJSHdIRWwzQRZVMq9CYCbapAYdanPceAefq2A03pnEk
         ScQnPxf2oxwtXTyjKIK2YI3gVybmud2L8ktcDPC9qxhthbEbk0zZQlIxeZhSeuwb5oYW
         9X2NF47UZc9uMfeoB5Wkg07GZfJzpqJDFJGhSzqy2xMdfwd2JTZXm6fOFfqwndB7PkVO
         ZXyVbhwHcMWgPdS0q0PU8vFbLywFpxrvVfNCdp9x+byGTE+82sJ4puxpdMTTOxtrG8/d
         OFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ezzl1wWnIMpMxrnM4W7DDVrnVpy6eCY3TnCdM56lXyY=;
        b=Fxy5dvJq4tNe7bhcGG+PFyDrANErL+Bk2Rzk0HxcGQrtey6TnJE1Xi+X9QtdVIGTMH
         fSQE4PU4GF7G2YnxYXXgfAvZ5yW7Nt5Clc3fhT+Be7aEGRAfkxrOGABGggW6A64f6cJ8
         /EusrF5XL6PxJ1Y2Hk+WhM3Jof78XiKYirBzS6qc9iHsqcdavG35NTPzBbTxZNQ/9Bbd
         EZn4Zh0el7Siu25f1aqP7Pbk0Kq8kkd4k2cvMFrwxvBJ19INSoeNo3GqW+p5eoAxuEbU
         I5KnvdfLcnrF9cFuOjW+H3ChNpYdho9WSotpm0zl8vwpcXV3wMLh7g363t4JExK2HOkE
         bFEg==
X-Gm-Message-State: AOAM533IBAjHkACXhJf7qXRjrVRK5LNzq0hl4cxf7n/n7PLs3ZleCAWC
        /kTgG0Pue6AtzIM+v5Dead0=
X-Google-Smtp-Source: ABdhPJxRuP4eiiPsWD4zzp6jNj7ax4FTsTMWJEepxl8GOYruGJOctgnU1X900LAC34J+DvA5dVvmsQ==
X-Received: by 2002:a63:f241:: with SMTP id d1mr16821140pgk.424.1629133713651;
        Mon, 16 Aug 2021 10:08:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n23sm13215976pgv.76.2021.08.16.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:08:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 Aug 2021 07:08:31 -1000
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
Subject: Re: [PATCH v6 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
References: <20210814205743.3039-1-longman@redhat.com>
 <20210814205743.3039-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814205743.3039-6-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 14, 2021 at 04:57:42PM -0400, Waiman Long wrote:
> +	A parent partition may distribute all its CPUs to its child
> +	partitions as long as it is not the root cgroup and there is no
> +	task directly associated with that parent partition.  Otherwise,

"there is not task directly associated with the parent partition" isn't
necessary, right? That's already enforced by the cgroup hierarchy itself.

> +	there must be at least one cpu left in the parent partition.
> +	A new task cannot be moved to a partition root with no effective
> +	cpu.
> +
> +	Once becoming a partition root, changes to "cpuset.cpus"
> +	is generally allowed as long as the first condition above
> +	(cpu exclusivity rule) is true.

All the above ultimately says is that "a new task cannot be moved to a
partition root with no effective cpu", but I don't understand why this would
be a separate rule. Shouldn't the partition just stop being a partition when
it doesn't have any exclusive cpu? What's the benefit of having multiple its
own failure mode?

> +	Sometimes, changes to "cpuset.cpus" or cpu hotplug may cause
> +	the state of the partition root to become invalid when the
> +	other constraints of partition root are violated.  Therefore,
> +	it is recommended that users should always set "cpuset.cpus"
> +	to the proper value first before enabling partition.  In case
> +	"cpuset.cpus" has to be modified after partition is enabled,
> +	users should check the state of "cpuset.cpus.partition" after
> +	making change to it to make sure that the partition is still
> +	valid.

So, idk why the this doesn't cover the one above it. Also, this really
should be worded a lot stronger. It's not just recommended - confirming and
monitoring the transitions is an integral and essential part of using
cpuset.

...
> +	An invalid partition is not a real partition even though the
> +	restriction of the cpu exclusivity rule will still apply.

Is there a reason we can't bring this in line with other failure behaviors?

> +	In the special case of a parent partition competing with a child
> +	partition for the only CPU left, the parent partition wins and
> +	the child partition becomes invalid.

Given that parent partitions are *always* empty, this rule doesn't seem to
make sense.

So, I think this definitely is a step in the right direction but still seems
to be neither here or there. Before, we pretended that we could police the
input when we couldn't. Now, we're changing the interface so that it
includes configuration failures as an integral part; however, we're still
policing some particular inputs while letting other inputs pass through and
trigger failures and why one is handled one way while the other differently
seems rather arbitrary.

Thanks.

-- 
tejun
