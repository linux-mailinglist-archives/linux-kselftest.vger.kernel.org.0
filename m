Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4076CC127
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjC1NkR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjC1NkR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 09:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B295122;
        Tue, 28 Mar 2023 06:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0CA8B81CFA;
        Tue, 28 Mar 2023 13:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F30C433EF;
        Tue, 28 Mar 2023 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680010807;
        bh=icUy13Xzx8zHFQYe+wcW2EESbKwQa3rKnpkk5O1qqOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnpLXIuxAYnWll/36a77A70//tWgi7UQv5dZoVH7VSv2/a9EAsI0GZIPnCgkhA060
         VslmWbFGcWf79brWo36ELhrhE4YyMh5zn7QADHaduPRccfPGtc2gnmExolXu23WsLX
         BGzcIr3YSBMUrjvDqgeyz7MYhzYeT/fh9xgr7KOr2hiZ2/rZAY3b148Sw+k6mDWbt+
         19GUyK6xFRoVD0yvXTL2QRBWihNcViUPyY5kRqGUeNBin+6uiuKHKcmb7w40DPVFhS
         hwBCh79JIrz2NcJEj/7c3A9x97h6lXiSofq63UTTdgyGiV5iUm9rA1aihu3tuGL1m3
         0rCqqFWrsCoKA==
Date:   Tue, 28 Mar 2023 14:40:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 0/4] cgroup/cpuset: Miscellaneous updates
Message-ID: <20230328134000.GA1333@willie-the-truck>
References: <20230317151508.1225282-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317151508.1225282-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Waiman,

On Fri, Mar 17, 2023 at 11:15:04AM -0400, Waiman Long wrote:
>  v2:
>   - Add a new patch 1 that fixes a bug introduced by recent v6.2 commit
>     7a2127e66a00 ("cpuset: Call set_cpus_allowed_ptr() with appropriate
>     mask for task").
>   - Make a small twist and additional comment to patch 2 ("cgroup/cpuset:
>     Skip task update if hotplug doesn't affect current cpuset") as
>     suggested by Michal.
>   - Remove v1 patches 3/4 for now for further discussion.
> 
> This patch series includes miscellaneous update to the cpuset and its
> testing code.

FWIW, this series also passes my asymmetric 32-bit tests.

Cheers,

Will
