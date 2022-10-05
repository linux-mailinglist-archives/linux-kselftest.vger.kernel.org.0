Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323895F5B0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiJEUfO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJEUfM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCA1DA53
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665002109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Spyd4QK8zfzxDBXuoxBL/PDaUjw/dZKhbr0mZm9nT1c=;
        b=IT3JYaQE0shoPM2MiuRweSJVI1fp6j2WTnCYnN9ObBXuyQ9laY/n7/HhoRSBrSEITdJRJ3
        zoG5npKd0JtZOstpg8L5Gfon/3ZZOazQlmyXyVe/m+43EQX7S7hDVOMtW2pbaf2YxeBmL7
        +5gzJ4nkRUPl/m7C6+g2vPVU8RUu1ro=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-478-I4Ik0miXN5arHeCyqoDlpQ-1; Wed, 05 Oct 2022 16:35:09 -0400
X-MC-Unique: I4Ik0miXN5arHeCyqoDlpQ-1
Received: by mail-qv1-f70.google.com with SMTP id dn14-20020a056214094e00b004b1a231394eso4719323qvb.13
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Spyd4QK8zfzxDBXuoxBL/PDaUjw/dZKhbr0mZm9nT1c=;
        b=YpbEc0sDmzFwx3AMGe11CA0yWK6Wdth+kUZD5j5RtA6Fu4fDW90oTGmXsGhh5F/nwJ
         Lik+PCD72FyaseZFxHNVKibOkb8lxgvvjgC7Q8nIvmRXdmF+R3GmV2AfA5duS1C2L1df
         MHwrcMZsUKiPPfkuomF+nY5LRWtgJ2TuHXyzI4K0AMk/NYDc9wumznkkyCZQrLSYjU9y
         Lf8bW6PqbRrBjiJ7QccytyYsks/85hgY/nq54u7ZCarSrMMqXBO4mn/VSoMwHbP8Q0Of
         wjgpwKh+e8ivqwxqHAFVzRd4QYuDg1yGBNI4OhF1EQWxbXEUwWbwxLVe/QBIcuHrmqt6
         dpzw==
X-Gm-Message-State: ACrzQf03gg4alZIAjIxfEsXFlaKB5d0/AVv/z1FzWcoYz6MGrNH3N+cc
        RU2L+ZlgRMnObVc+hn9oyDP2o6sXCPvv8qgEeMpVtM/ltqvbIvnYj0yqyqOVP72QatzrMBbCtGI
        gbgw4N6cWviBMFmcp5WfYTvwPycnQ
X-Received: by 2002:ae9:e70a:0:b0:6ce:bfc0:f98b with SMTP id m10-20020ae9e70a000000b006cebfc0f98bmr935021qka.381.1665002108325;
        Wed, 05 Oct 2022 13:35:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XAXGxI08IXKU2+P8nxYIGcJ4Cjc/Q8ZELN25KxB1W3P8p9sLvCKgIKsx7ZggEAFUf6g9lCw==
X-Received: by 2002:ae9:e70a:0:b0:6ce:bfc0:f98b with SMTP id m10-20020ae9e70a000000b006cebfc0f98bmr935012qka.381.1665002108085;
        Wed, 05 Oct 2022 13:35:08 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a400800b006bb9e4b96e6sm18233280qko.24.2022.10.05.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:35:07 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:35:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
Message-ID: <Yz3qekna97ndP4FK@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-5-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:28PM +0200, David Hildenbrand wrote:
> Let's stop breaking COW via a fake write fault and let's use
> FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
> write fault, such as mapping the PTE writable and marking the pte
> dirty/softdirty.
> 
> Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
> page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
> will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
> The warning in dmesg indicates this wrong handling:
> 
> [  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
> [  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
> [  230.110124] Hardware name: [...]
> [  230.117775] Call Trace:
> [  230.120227]  <TASK>
> [  230.122334]  dump_stack_lvl+0x44/0x5c
> [  230.126010]  handle_userfault.cold+0x14/0x19
> [  230.130281]  ? tlb_finish_mmu+0x65/0x170
> [  230.134207]  ? uffd_wp_range+0x65/0xa0
> [  230.137959]  ? _raw_spin_unlock+0x15/0x30
> [  230.141972]  ? do_wp_page+0x50/0x590
> [  230.145551]  __handle_mm_fault+0x9f5/0xf50
> [  230.149652]  ? mmput+0x1f/0x40
> [  230.152712]  handle_mm_fault+0xb9/0x2a0
> [  230.156550]  break_ksm+0x141/0x180
> [  230.159964]  unmerge_ksm_pages+0x60/0x90
> [  230.163890]  ksm_madvise+0x3c/0xb0
> [  230.167295]  do_madvise.part.0+0x10c/0xeb0
> [  230.171396]  ? do_syscall_64+0x67/0x80
> [  230.175157]  __x64_sys_madvise+0x5a/0x70
> [  230.179082]  do_syscall_64+0x58/0x80
> [  230.182661]  ? do_syscall_64+0x67/0x80
> [  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Since it's already there, worth adding the test into ksm_test.c?

> 
> Consequently, we will no longer trigger a fake write fault and break COW
> without any such side-effects.
> 
> This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
> fault was always questionable. As this fix is not easy to backport and it's
> not very critical, let's not cc stable.

A patch to cc most of the stable would probably need to still go with the
old write approach but attaching ALLOW_RETRY.  But I agree maybe that may
not need to bother, or a report should have arrived earlier..  The unshare
approach looks much cleaner indeed.

> 
> Fixes: 529b930b87d9 ("userfaultfd: wp: hook userfault handler to write protection fault")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

