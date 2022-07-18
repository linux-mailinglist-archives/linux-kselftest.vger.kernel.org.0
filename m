Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51F57864C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiGRP0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiGRP0m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 11:26:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C9D28E3F
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 08:26:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x21so9325497plb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yt9oE0kz3TmH5FGxe6pEDCKgvRvBbOAA/ay7EMCbyEc=;
        b=Uff3ivfihawnDb3MVf5QlQ2jPMMai38C6bP4DepEErQNRp/Kc0gYVje6cUTN3mqgBa
         8e/i6cCNzLQRIo6XA6wMXV8Z208mTTLPAFevNS72jjatByWcRHbhRuXNC/PzoiNVlj0A
         G9sTexZ1nkBq8bHjUgqFI7BC1X8Fl1pf5ZeLZgS5QdWIqKzWIGGLSvIy/UwP2bykPTMR
         S0KDUdaMZvJIWXXz6SkPgu1okTxSS3xRe0n7hIARn0g4omp+/4Oqj1iwRKhLmSvwxOC1
         gHiiZYsDVdI0DS6/yoOU3d2IjW3kS0u9umKDtPmgnjR6gLoFlRAZm1r5c55NFjc5PcWF
         DbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yt9oE0kz3TmH5FGxe6pEDCKgvRvBbOAA/ay7EMCbyEc=;
        b=V5m6Eai80rK0baK/emqPmIwbfxFoSme9MXvPjIySNZ0JJhkDgZx/2FWWb3DUSLVS1+
         /6TWqC3eDNuGjVCjut/aLqg2c97nT6bpiXFF1ZzoPKuK+KSgZ/N/ZTGKQmlW8nxzcEBC
         CndlYOnZprcYyULDa3cMqMimyjZUsPT2sv+A/mlYtH+kr/TFEExn6F/X8HvZp3v4HyE4
         vN6ZlZebGCC6vAxL2/3pNI1e8cN+Y8g140VPJMWUQ9mkaTL6mpnbSi04PmVaBsLUwKPI
         NwF49bJMpeGHiovFB6PtZ6M2d4fkVbLEP6701gZK83PSR9ip9FqF48skniZd2qSkF8BH
         b2KA==
X-Gm-Message-State: AJIora+EcLef1VoRRTDEa9c9L7NDkLIcB+zPogPwGkTvPRfrcZhmS0UL
        s5xk4/wIev/VOodTNsG+7JAUgA==
X-Google-Smtp-Source: AGRyM1vgtGvBYkyh0ni5e/mqVLrnNK1+XKLqZyiT0UcMq2k28Wiwo9nZP6ot9un6Y/cxDUraL3c4cg==
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id l8-20020a170903120800b0016b81f6e992mr29233754plh.55.1658157998529;
        Mon, 18 Jul 2022 08:26:38 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id h14-20020a63e14e000000b004161b3c3388sm8342392pgk.26.2022.07.18.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:26:38 -0700 (PDT)
Date:   Mon, 18 Jul 2022 15:26:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 07/14] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <YtV7qpYZoT6jIKHQ@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
 <d480a850-601b-cda2-b671-04d839c98429@amd.com>
 <20220718132950.GA38104@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718132950.GA38104@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 18, 2022, Chao Peng wrote:
> On Fri, Jul 15, 2022 at 01:36:15PM +0200, Gupta, Pankaj wrote:
> > > Currently in mmu_notifier validate path, hva range is recorded and then
> > > checked in the mmu_notifier_retry_hva() from page fault path. However
> > > for the to be introduced private memory, a page fault may not have a hva
> > 
> > As this patch appeared in v7, just wondering did you see an actual bug
> > because of it? And not having corresponding 'hva' occurs only with private
> > memory because its not mapped to host userspace?
> 
> The addressed problem is not new in this version, previous versions I
> also had code to handle it (just in different way). But the problem is:
> mmu_notifier/memfile_notifier may be in the progress of invalidating a
> pfn that obtained earlier in the page fault handler, when happens, we
> should retry the fault. In v6 I used global mmu_notifier_retry() for
> memfile_notifier but that can block unrelated mmu_notifer invalidation
> which has hva range specified.
> 
> Sean gave a comment at https://lkml.org/lkml/2022/6/17/1001 to separate
> memfile_notifier from mmu_notifier but during the implementation I
> realized we actually can reuse the same code for shared and private
> memory if both using gpa range and that can simplify the code handling
> in kvm_zap_gfn_range and some other code (e.g. we don't need two
> versions for memfile_notifier/mmu_notifier).

This should work, though I'm undecided as to whether or not it's a good idea.  KVM
allows aliasing multiple gfns to a single hva, and so using the gfn could result
in a much larger range being rejected given the simplistic algorithm for handling
multiple ranges in kvm_inc_notifier_count().  But I assume such aliasing is uncommon,
so I'm not sure it's worth optimizing for.

> Adding gpa range for private memory invalidation also relieves the
> above blocking issue between private memory page fault and mmu_notifier.
