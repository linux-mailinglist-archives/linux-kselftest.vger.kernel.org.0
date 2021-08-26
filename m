Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C83F8D24
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhHZRgI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhHZRgI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 13:36:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA72C061757;
        Thu, 26 Aug 2021 10:35:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q3so2249052plx.4;
        Thu, 26 Aug 2021 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZSEycsP4qShPCh1rVVDGzpSXPPGPKKt4tNdiEEa5Yo=;
        b=c94jOw6mYlRttgV/ELojAGblRHKn2cClqABKr0Rvj2jkxVok/L/2iBafzHm+g/ccHc
         W9R0GGnvBRh0fDrFaOgkTIcPtoaluXGUrLvFqa8Yh+KxKHeCQeSlkFA89mn3jvrRkRP1
         fGr97QjrUTLFCaEO12/dK154B2bAXnCGhCh8L32Kd7ZONxYdm1ispu+eBkW5si1Gs1uX
         hvMTI3drWfbpfGiYw9LRuL3xXT1FJVCW65JZm9q6oVQP9kSYO8mSg4NZXnHatM/tb+Z6
         /CKBO6g+WRERs1NDPKp4ymYaIWkU1hUNJVAVYLZWGW7xll6zIUiQSTuOLzVvzDsMFke0
         d9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EZSEycsP4qShPCh1rVVDGzpSXPPGPKKt4tNdiEEa5Yo=;
        b=nu+T1Gemzsc6NxTZ750jZll8cjG/8wkx/OiX9sul/I+OFLmY9QE+vIutnPq8Xb+MSQ
         +uoeOxoWNP/fLEx3AOyfLEVD+/Ydi1H6cfeGRdN4vdVHi6W82gaGa/6VnBgh4Y7i90Oc
         AzE5BGeNnuThMVcwSupGJnc+mkfvZIAxyDNmfxb6iyY9BGpi2b0VEKbX0kcfymzohl1u
         /cDqPRkHeSFf6fZsEaK+gHj6QRDZFtbXZIqRD2x4UVWKh5eaiAapkVShxVUTTrX7zyRW
         mwjAkMyBH/dmA5FRN9o2QRZYQHq731n3FfesdojjF3x0mCyVxrQIbwlL122ZsW4uG+TU
         mqSQ==
X-Gm-Message-State: AOAM530CwsJYYmVdf9qXbTO5YROOKdzL9sMoj5GQ7BYhkh9ZUBMA44FD
        QJ5SrvLfOIWtdq5mwxocL04=
X-Google-Smtp-Source: ABdhPJymWHDxxzJjTigGN5lvXbqmg6P7g6x2gzttSRV3Qkej8MJPiLPGWOPaqIExD/17GCx8Ab0eNA==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr9217042pji.149.1629999319833;
        Thu, 26 Aug 2021 10:35:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a096])
        by smtp.gmail.com with ESMTPSA id n14sm10441971pjm.5.2021.08.26.10.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:35:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 Aug 2021 07:35:14 -1000
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
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825213750.6933-6-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello, Waiman.

Let's stop iterating on the patchset until we reach a consensus.

On Wed, Aug 25, 2021 at 05:37:49PM -0400, Waiman Long wrote:
>  	1) The "cpuset.cpus" is not empty and the list of CPUs are
>  	   exclusive, i.e. they are not shared by any of its siblings.

Part of it can be reached by cpus going offline.

>  	2) The parent cgroup is a partition root.

This condition can happen if a parent stop being a partition.

> -	3) The "cpuset.cpus" is also a proper subset of the parent's
> +	3) The "cpuset.cpus" is a subset of the parent's
>  	   "cpuset.cpus.effective".

This can happen if cpus go offline.

>  	4) There is no child cgroups with cpuset enabled.  This is for
>  	   eliminating corner cases that have to be handled if such a
>  	   condition is allowed.

This may make sense as a short cut for us but doesn't really stem from
interface or behavior requirements.

Of the four conditions listed, two are bogus (the states can be
reached through a different path and the configuration success or
failure can be timing dependent if configuration racaes against cpu
hotplug operations) and one maybe makes sense half-way and one is more
of a shortcut.

Can't we just replace these with transitions to invalid state with
proper explanation? That'd get rid of the error handling duplications
from both the kernel and user side, make automated configurations
which may race against hot plug operations reliable, and consistently
provide users with why something failed.

Thank you.

-- 
tejun
