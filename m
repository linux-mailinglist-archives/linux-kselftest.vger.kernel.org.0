Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0927800F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 00:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbjHQWUd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 18:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355737AbjHQWUc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 18:20:32 -0400
X-Greylist: delayed 619 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 15:20:31 PDT
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB230C5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 15:20:31 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692310205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZWOzIrMKkpUc+BDEgZDeC3Wh2PXNMAFyhgvJslJ6wg=;
        b=xEIQ3L38jf6DxtO1AtG3hpWCWS4o0JBWtd/5QNnpQQ8aRxSbnxY4v7SXUtB9VAdbMk70+s
        FhPFrDoJEcJSGjRiQa+SxKT0G9po0KTB107NHjDgyq4AdJj9tJNPm5tWpeZZDQHUGuplve
        Br+JYDAsz3Kq/nwQ7l9HLUMnxJgoCjg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: cgroup: fix test_kmem_memcg_deletion
 kernel mem check
Message-ID: <ZN6apSESQA399VIB@P9FQF9L96D.corp.robot.car>
References: <bvrhe2tpsts2azaroq4ubp2slawmop6orndsswrewuscw3ugvk@kmemmrttsnc7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bvrhe2tpsts2azaroq4ubp2slawmop6orndsswrewuscw3ugvk@kmemmrttsnc7>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 03:57:48PM -0400, Lucas Karpinski wrote:
> Currently, not all kernel memory usage is being accounted for. This
> commit switches to using the kernel entry within memory.stat which
> already includes kernel_stack, pagetables, and slab. The kernel entry
> also includes vmalloc and other additional kernel memory use cases which
> were missing.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
