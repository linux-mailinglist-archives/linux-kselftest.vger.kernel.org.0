Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DF4E304F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352348AbiCUS6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbiCUS6t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 14:58:49 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31018C0D0;
        Mon, 21 Mar 2022 11:57:22 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:57:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647889038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/f628apkMpQsjSicVFzN0gWVenPYv3XtQ9ROsVjz1zw=;
        b=NLKvTkWVtIcr90tfxAO2XU/dNqfJbG6SpakXGsYu4nUm1t+IsyQ57Teq3ybpNZQL1sahsQ
        CbjbE+jOO3LR4Tu4y76Yxkw+BX+9uIhZFxOV6+BGKrEJiE7ReVDr5g7ZEjQGn7ivkPzlYF
        G7Y2bm7vKrmhEixspnA5N6snIVmDdDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm: memcg: make memcg huge page split support
 any order split.
Message-ID: <YjjKh2NoWGcq28Oo@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142128.2471199-2-zi.yan@sent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:24AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It sets memcg information for the pages after the split. A new parameter
> new_order is added to tell the new page order, always 0 for now. It
> prepares for upcoming changes to support split huge page to any lower
> order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/memcontrol.h |  2 +-
>  mm/huge_memory.c           |  2 +-
>  mm/memcontrol.c            | 10 +++++-----
>  mm/page_alloc.c            |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 89b14729d59f..e71189454bf0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1116,7 +1116,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  	rcu_read_unlock();
>  }
>  
> -void split_page_memcg(struct page *head, unsigned int nr);
> +void split_page_memcg(struct page *head, unsigned int nr, unsigned int new_order);

It looks a bit inconsistent, can't we switch to use either nr or order for both
arguments? The latter is preferable.

Other than that, the patch looks good to me.

Thanks!
