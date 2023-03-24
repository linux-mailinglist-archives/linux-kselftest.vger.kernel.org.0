Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DC6C7FE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCXOdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXOdC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 10:33:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1814235;
        Fri, 24 Mar 2023 07:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C17BCE2401;
        Fri, 24 Mar 2023 14:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F8AC433EF;
        Fri, 24 Mar 2023 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679668377;
        bh=yxz8D2Zg0ZMCZt9HGM8J7hviWBLk56ggtJ1KZ+DkDGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TW4X/v31+XvxigTPEeFIQrSpqf1C0wg34BEJL4Ewk0hehRrW2ZKZsQjnGXXStCEQp
         5VkteDkPv+sdJn+wnCp00Q7ts0BXFvbvpUPoz/O9ozOkHdjO4LnSzaJvy2Lfehdi0r
         o0bbmMBhVD3QDLkFyY4APnSyWtyO3ymDaEdHiB8QpljXQXoAKlvYNlSVeZg+pwPPZe
         sPryW8AHtsYhf36NHIPB0QmnPAT7HBQXA41oQKclKF0ESgsa5b9KAsNfg7nYmJrsRX
         ucNevYIcTADp3ZgDhRMyA4mplhSlroJWECB9XeRhBSBgNHFndzP4dipMvgK5XNtnz6
         OfNZPsFUIN1Wg==
Date:   Fri, 24 Mar 2023 14:32:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Message-ID: <20230324143247.GA27199@willie-the-truck>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
 <20230317122708.ax3m2d4zijkfdzjq@blackpad>
 <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 10:59:26AM -0400, Waiman Long wrote:
> On 3/17/23 08:27, Michal Koutný wrote:
> > On Tue, Mar 14, 2023 at 04:22:06PM -0400, Waiman Long <longman@redhat.com> wrote:
> > > Some arm64 systems can have asymmetric CPUs where certain tasks are only
> > > runnable on a selected subset of CPUs.
> > Ah, I'm catching up.
> > 
> > > This information is not captured in the cpuset. As a result,
> > > task_cpu_possible_mask() may return a mask that have no overlap with
> > > effective_cpus causing new_cpus to become empty.
> > I can see that historically, there was an approach of terminating
> > unaccomodable tasks:
> >     94f9c00f6460 ("arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores")
> > the removal of killing had been made possible with
> >     df950811f4a8 ("arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system").
> > 
> > That gives two other alternatives to affinity modification:
> > 2) kill such tasks (not unlike OOM upon memory.max reduction),
> > 3) reject cpuset reduction (violates cgroup v2 delegation).
> > 
> > What do you think about 2)?
> 
> Yes, killing it is one possible solution.
> 
> (3) doesn't work if the affinity change is due to hot cpu removal. So that
> leaves this patch or (2) as the only alternative. I would like to hear what
> Will and Tejun thinks about it.

The main constraint from the Android side (the lucky ecosystem where these
SoCs tend to show up) is that existing userspace (including 32-bit binaries)
continues to function without modification. So approaches such as killing
tasks or rejecting system calls tend not to work as well, since you
inevitably get divergent behaviour leading to functional breakage rather
than e.g. performance anomalies.

Having said that, the behaviour we currently have in mainline seems to
be alright, so please don't go out of your way to accomodate these SoCs.
I'm mainly just concerned about introducing any regressions, which is why
I ran my tests on this series

Cheers,

Will
