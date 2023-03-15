Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EE6BB9A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 17:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjCOQZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjCOQYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 12:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6F923857;
        Wed, 15 Mar 2023 09:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E4861DFC;
        Wed, 15 Mar 2023 16:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E6C433D2;
        Wed, 15 Mar 2023 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678897482;
        bh=rukzdJCI+tw+s5fqfJFihxS3X4oqBD7ma0Je+Y6QpCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvcMCkZvmy0xyYulnpAkGL249vbZumxIZ0gmXkUWaLHYTmhw1kp33kMRZlKUg5a76
         X44pZeW2eTX0mHmn2iwhbcGHa12xNEnuJertqUlxQxRTC8LM1winp7ziDhrja4Xo4V
         tKq84JCNasxgBzolzfo0cw+o2kc3rrFV4e+DJCpcevbiwn+vVedPEWX23oaWXkZKRY
         HgX7o5nl4rEs19UhpWrPMaZ42A++sXm7JfDVxHr0gmBnc+Dr23ZzeZU3TK2ZueGYYq
         lS07EIHkniiwkywE8VmoBG75ISitCjmfwdKKNkXh+iBKyxRazFcaGViCpbdGGXm6qr
         gVeSv56EqsbrA==
Date:   Wed, 15 Mar 2023 16:24:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] cgroup/cpuset: Miscellaneous updates
Message-ID: <20230315162436.GA19015@willie-the-truck>
References: <20230306200849.376804-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306200849.376804-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Waiman,

On Mon, Mar 06, 2023 at 03:08:44PM -0500, Waiman Long wrote:
> This patch series includes miscellaneous update to the cpuset and its
> testing code.
> 
> Patch 2 is actually a follow-up of commit 3fb906e7fabb ("cgroup/cpuset:
> Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks").
> 
> Patches 3-4 are for handling corner cases when dealing with
> task_cpu_possible_mask().

Thanks for cc'ing me on these. I ran my arm64 asymmetric tests and, fwiw,
I get the same results as vanilla -rc2, so that's good.

One behaviour that persists (and which I thought might be addressed by this
series) is the following. Imagine a 4-CPU system with CPUs 0-1 being 64-bit
only. If I configure a parent cpuset with 'cpuset.cpus' of "0-2" and a
child cpuset with 'cpuset.cpus' of "0-1", then attaching a 32-bit task
to the child cpuset will result in an affinity mask of 4. If I then change
'cpuset.cpus' of the parent cpuset to "0-1,3", the affinity mask of the
task remains at '4' whereas it might be nice to update it to '8', in-line
with the new affinity mask of the parent cpuset.

Anyway, I'm not complaining (this is certainly _not_ a regression), but
I thought I'd highlight it in case you were aiming to address this with
your changes.

Cheers,

Will
