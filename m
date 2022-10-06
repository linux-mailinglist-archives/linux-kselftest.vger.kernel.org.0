Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F25F6DD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJFTFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiJFTE4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B843898
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665083092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWiYaOXLcLPovjcCyVZW8Hvnr9LXyElLmC25/eoQjh0=;
        b=TPWmpRspp54e1WM4Ris1iLQw3RNRFRChliJfsyTTU5hy67G3+N3GEYmbGK54tkPDN9rjgY
        xcweTQzlZxm7Z2jx9rhTy11GxiYUycaESmDQDc6psg4KDvFmvNok+6sFyaII9D3LZ//ADC
        KsQbBP+CU+3mhvKdO9CCKnmgQbH5TU8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-fOujaYGYPeCOQRXJfJinzA-1; Thu, 06 Oct 2022 15:04:51 -0400
X-MC-Unique: fOujaYGYPeCOQRXJfJinzA-1
Received: by mail-qk1-f197.google.com with SMTP id w10-20020a05620a444a00b006ce9917ea1fso2173512qkp.16
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 12:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWiYaOXLcLPovjcCyVZW8Hvnr9LXyElLmC25/eoQjh0=;
        b=s6LLBCZuN5WrInfB/0/Grzfm1L8cy1LWZ3Pw0lHrHB/TBi09VrPsSLSY6Igu6n2GhK
         ti0POGF7uGC7CABuAfnVI2mRJAVa1v+X4L4Vw4jDOWNxIS4ZFeD3QU9Ly5YjcMs1woa0
         7NZRf/6SKmOUX3CtOqTtKNbin5uvvAePCm+CNg2oxPwgDnlabTcZg4KI7GhGy8z/hf69
         hTjeDgFP5ny6ny9gNYrAgEvRH2aVdK3WvmGO9VsPmv2anZFgRYfTTWMgCTPVfITrjmSz
         mXT3tXm32YgDZSWCViJ+V6wzLgeUpCvsfqofXGxh/9AJtqjPRK7SuaOcW9Qq+zRsYlYL
         X4ew==
X-Gm-Message-State: ACrzQf2822F3ARb+nkTinCYIgqd+U4gOsfbS5zbX/uEsRbl6i5KjAPAd
        gft5WF4FCLvIw/jAMdzolGn02pW0uY71Y0URHHlinwc17atmF66v0B4ANIS6WpybWVesor/2wJo
        i0DxW+YmvOJtVwxdkAfl5jx/ZVCOx
X-Received: by 2002:a05:6214:21ea:b0:4b1:bc8f:b182 with SMTP id p10-20020a05621421ea00b004b1bc8fb182mr1268063qvj.90.1665083090679;
        Thu, 06 Oct 2022 12:04:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ktypX+Rn92Vi/FHAUQs+cZWsJiTq70J7qmscJNemTST4c+2LJpEm40kZ7k1cwD99PWk8Gxw==
X-Received: by 2002:a05:6214:21ea:b0:4b1:bc8f:b182 with SMTP id p10-20020a05621421ea00b004b1bc8fb182mr1268029qvj.90.1665083090378;
        Thu, 06 Oct 2022 12:04:50 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a444200b006dfa0891397sm8495177qkp.32.2022.10.06.12.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:04:49 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:04:48 -0400
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
Message-ID: <Yz8m0J+UV/O9K5Lk@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com>
 <Yz3qekna97ndP4FK@x1n>
 <bdddfd01-bc7e-2f99-21b9-2762a7041096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdddfd01-bc7e-2f99-21b9-2762a7041096@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 06, 2022 at 11:29:29AM +0200, David Hildenbrand wrote:
> On 05.10.22 22:35, Peter Xu wrote:
> > On Fri, Sep 30, 2022 at 04:19:28PM +0200, David Hildenbrand wrote:
> > > Let's stop breaking COW via a fake write fault and let's use
> > > FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
> > > write fault, such as mapping the PTE writable and marking the pte
> > > dirty/softdirty.
> > > 
> > > Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
> > > page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
> > > will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
> > > The warning in dmesg indicates this wrong handling:
> > > 
> > > [  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
> > > [  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
> > > [  230.110124] Hardware name: [...]
> > > [  230.117775] Call Trace:
> > > [  230.120227]  <TASK>
> > > [  230.122334]  dump_stack_lvl+0x44/0x5c
> > > [  230.126010]  handle_userfault.cold+0x14/0x19
> > > [  230.130281]  ? tlb_finish_mmu+0x65/0x170
> > > [  230.134207]  ? uffd_wp_range+0x65/0xa0
> > > [  230.137959]  ? _raw_spin_unlock+0x15/0x30
> > > [  230.141972]  ? do_wp_page+0x50/0x590
> > > [  230.145551]  __handle_mm_fault+0x9f5/0xf50
> > > [  230.149652]  ? mmput+0x1f/0x40
> > > [  230.152712]  handle_mm_fault+0xb9/0x2a0
> > > [  230.156550]  break_ksm+0x141/0x180
> > > [  230.159964]  unmerge_ksm_pages+0x60/0x90
> > > [  230.163890]  ksm_madvise+0x3c/0xb0
> > > [  230.167295]  do_madvise.part.0+0x10c/0xeb0
> > > [  230.171396]  ? do_syscall_64+0x67/0x80
> > > [  230.175157]  __x64_sys_madvise+0x5a/0x70
> > > [  230.179082]  do_syscall_64+0x58/0x80
> > > [  230.182661]  ? do_syscall_64+0x67/0x80
> > > [  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > Since it's already there, worth adding the test into ksm_test.c?
> 
> Yes, I can give it a try. What I dislike about ksm_test is that it's a
> mixture of benchmarks and test cases that have to explicitly triggered by
> parameters. It's not a simple "run all available test cases" tests as we
> know it. So maybe something separate (or having it as part of the uffd
> tests) makes more sense.

We can add an entry into run_vmtests.sh.  That's also what current ksm_test
does.

Yes adding into uffd test would work too, but I do have a plan that we
should move functional tests out of userfaultfd.c, leaving that with the
stress test only.  Not really a big deal, though.

> 
> > 
> > > 
> > > Consequently, we will no longer trigger a fake write fault and break COW
> > > without any such side-effects.
> > > 
> > > This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
> > > fault was always questionable. As this fix is not easy to backport and it's
> > > not very critical, let's not cc stable.
> > 
> > A patch to cc most of the stable would probably need to still go with the
> > old write approach but attaching ALLOW_RETRY.  But I agree maybe that may
> > not need to bother, or a report should have arrived earlier..  The unshare
> > approach looks much cleaner indeed.
> 
> A fix without FAULT_FLAG_UNSHARE is not straight forward. We really don't
> want to notify user space about write events here (because there is none).
> And there is no way around the uffd handling in WP code without that.
> 
> FAULT_FLAG_ALLOW_RETRY would rely on userfaultfd triggering and having to
> resolve the WP event.

Right it'll be very much a false positive, but the userspace should be fine
with it e.g. for live snapshot we need to copy page earlier; it still won't
stop the process from running along the way.  But I agree that's not ideal.

-- 
Peter Xu

