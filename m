Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14DE5743DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 06:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiGNEmm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 00:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiGNEmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 00:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFD46D9E;
        Wed, 13 Jul 2022 21:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9567561EDE;
        Thu, 14 Jul 2022 04:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A08CC341CD;
        Thu, 14 Jul 2022 04:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657772974;
        bh=fZjf6kM0D523BGGdK0aisyqfUcBCAbftTGPrzQxmYl4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=BCYfQniFbTmcpOoHE0lYCjN4DfF37sxERgNS1eP0Dqt0Lic2JfV5/LbeVXB317B4/
         yt5+I1TnOiCgNVQfsyJGbwJWCVtitdWUhoEyR7Cm42+LtO6yxIUPbYzspnRCaEAo3b
         IMqt9ZeR+nwjTsJvtmBYvudD2oNoba1Oz/mKShdjrRlKJrwLpkxcXiJfJLEDjiPTFy
         XWjlAPolLAQ9vKNDp/Dfpe2Szqj4gD3FBWtKZNid/8EBB594sPiFh/lK9QXnpeYCIM
         sq/2EVFrev/ePOmQOi0ri+ueMn91PEu42ZxGRWEMbHqyq65dolJRwGAjyXSYtttmbO
         i1R/XjwhXjg4g==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 27C2D27C0054;
        Thu, 14 Jul 2022 00:29:31 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Thu, 14 Jul 2022 00:29:31 -0400
X-ME-Sender: <xms:qJvPYii29dAPbs_NpMgLHxhVXc4L0Sjcg_lr5sRIkLTcZRf9JDcl5A>
    <xme:qJvPYjCbHJ_QG4ltuWLgayikUHS2XGZ29WM9MlidRbBTzlJ66vMUr9hVKmHef6O-R
    7PC-LsZVz_Mqjyz2fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:qJvPYqGLOxrAPwNk-220lDr2W5tpjR4mLXcTgdlR0gEB3i-gOYU2CQ>
    <xmx:qJvPYrSFHEaKpA3pRKzZg-iOSfXaA839zBgCzKjTiKzrkWYut0kmPg>
    <xmx:qJvPYvxpeBBe4a3rrdpEwgU1634k-2FWm0ADCA6yDIw3ZEVQtF_IyQ>
    <xmx:q5vPYkxOdsVoPeCrLR_3at-Za3z_dmEXWySUh5DAoyOM-51svN7zEhnbCfE>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A4A7431A0062; Thu, 14 Jul 2022 00:29:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <b0c726d4-2ad3-47e7-90cf-d67b36e7d59e@www.fastmail.com>
In-Reply-To: <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
 <20220713075738.GC2831541@chaop.bj.intel.com>
 <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
Date:   Wed, 13 Jul 2022 21:29:08 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        "Chao Peng" <chao.p.peng@linux.intel.com>
Cc:     "kvm list" <kvm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sean Christopherson" <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Wanpeng Li" <wanpengli@tencent.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Steven Price" <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        "Quentin Perret" <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Muchun Song" <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM guest
 private memory
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Wed, Jul 13, 2022, at 3:35 AM, Gupta, Pankaj wrote:
>>>> This is the v7 of this series which tries to implement the fd-based KVM
>>>> guest private memory. The patches are based on latest kvm/queue branch
>>>> commit:
>>>>
>>>>     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>>> split_desc_cache only by default capacity
>>>>
>>>> Introduction
>>>> ------------
>>>> In general this patch series introduce fd-based memslot which provides
>>>> guest memory through memory file descriptor fd[offset,size] instead of
>>>> hva/size. The fd can be created from a supported memory filesystem
>>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>>
>>> Thinking a bit, As host side fd on tmpfs or shmem will store memory on host
>>> page cache instead of mapping pages into userspace address space. Can we hit
>>> double (un-coordinated) page cache problem with this when guest page cache
>>> is also used?
>> 
>> This is my understanding: in host it will be indeed in page cache (in
>> current shmem implementation) but that's just the way it allocates and
>> provides the physical memory for the guest. In guest, guest OS will not
>> see this fd (absolutely), it only sees guest memory, on top of which it
>> can build its own page cache system for its own file-mapped content but
>> that is unrelated to host page cache.
>
> yes. If guest fills its page cache with file backed memory, this at host 
> side(on shmem fd backend) will also fill the host page cache fast. This 
> can have an impact on performance of guest VM's if host goes to memory 
> pressure situation sooner. Or else we end up utilizing way less System 
> RAM.

Is this in any meaningful way different from a regular VM?

--Andy
