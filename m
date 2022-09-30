Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B195F1620
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 00:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiI3W1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiI3W1s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 18:27:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B23E7424;
        Fri, 30 Sep 2022 15:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08C65B82A77;
        Fri, 30 Sep 2022 22:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A7C433D6;
        Fri, 30 Sep 2022 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664576863;
        bh=wbj2EuyuEfvvCPmCnhQhRcLiTuG3KqDQW8nUblaU46I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vevH6DP6eJDGLbbSOjYy9HCIsdOjsg4vu76xXuLdFPG4XdAW14lLKqq1XrNqNkaz0
         80lWnHQdv27Ov3zvp+keNsZVJiGdRl1RW364qdAKsJXdTL8fTj1Cw43emxXvqWbtod
         QYunY7aH7OvGMxSb9s3/pdrW2UDP18BHA2NUmRU4=
Date:   Fri, 30 Sep 2022 15:27:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
Message-Id: <20220930152742.55ee9c25b89ba483ec211be8@linux-foundation.org>
In-Reply-To: <20220930141931.174362-5-david@redhat.com>
References: <20220930141931.174362-1-david@redhat.com>
        <20220930141931.174362-5-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 30 Sep 2022 16:19:28 +0200 David Hildenbrand <david@redhat.com> wrote:

> Let's stop breaking COW via a fake write fault and let's use
> FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
> write fault, such as mapping the PTE writable and marking the pte
> dirty/softdirty.
> 
> Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
> page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
> will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
> The warning in dmesg indicates this wrong handling:

We're at -rc7.  I'd prefer to avoid merging larger patchsets at this
time.

Is there some minimal fix for 6.0 and -stable?  Or is the problem
non-serious enough to only fix it in 6.1 and later?
