Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6901B500AC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiDNKKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiDNKKe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 06:10:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F22716C5;
        Thu, 14 Apr 2022 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649930890; x=1681466890;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=P20Fj4tA9E/L+5qvKMH1XNKx+SrDuhwRpxgFnHGqyGE=;
  b=MsBbcgQnmOO0SkeWpOvVKlb5qXmpnJCQjzL6mCh1kN1yVE9PdehjNz5M
   D8A8+jmKRsnYVrp0frEmoYk2OE5c7kJSzGgRslrG5/1UNCmwrVJMHK0+l
   qAQpmRfx8Sxs+KLh6RCr5DV8RZkMRu9LZly5dIZvpF3PvngBImMxNktyl
   jgsb6Fx4xy0uMDW22eHu/MXESxVjkuavFO+VFuw/+HTsj8z+bvyyR8Bk3
   XmUfy4KiERhl0ocj7KqAtj9FgRsPTvbuilrZ9vjKFOw2gIwMGvwyhJUG/
   zQ3lXFtvSJtTwCSaIit1SdtJuTbU1shDDJvEhgQcugD1n2S5Bhe3nRFc8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243483601"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="243483601"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 03:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="526868481"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2022 03:08:00 -0700
Date:   Thu, 14 Apr 2022 18:07:50 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, shauh@kernel.org,
        yang.zhong@intel.com, drjones@redhat.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>, diviness@google.com
Subject: Re: [RFC V1 PATCH 0/5] selftests: KVM: selftests for fd-based
 approach of supporting private memory
Message-ID: <20220414100750.GA16626@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220408210545.3915712-1-vannapurve@google.com>
 <e8a4cac5-bc5a-4483-9443-c0e5b9f707d1@www.fastmail.com>
 <20220413134200.ms5lscs7lvvih7a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413134200.ms5lscs7lvvih7a5@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 13, 2022 at 08:42:00AM -0500, Michael Roth wrote:
> On Tue, Apr 12, 2022 at 05:16:22PM -0700, Andy Lutomirski wrote:
> > On Fri, Apr 8, 2022, at 2:05 PM, Vishal Annapurve wrote:
> > > This series implements selftests targeting the feature floated by Chao
> > > via:
> > > https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> > >
> > > Below changes aim to test the fd based approach for guest private memory
> > > in context of normal (non-confidential) VMs executing on non-confidential
> > > platforms.
> > >
> > > Confidential platforms along with the confidentiality aware software
> > > stack support a notion of private/shared accesses from the confidential
> > > VMs.
> > > Generally, a bit in the GPA conveys the shared/private-ness of the
> > > access. Non-confidential platforms don't have a notion of private or
> > > shared accesses from the guest VMs. To support this notion,
> > > KVM_HC_MAP_GPA_RANGE
> > > is modified to allow marking an access from a VM within a GPA range as
> > > always shared or private. Any suggestions regarding implementing this ioctl
> > > alternatively/cleanly are appreciated.
> > 
> > This is fantastic.  I do think we need to decide how this should work in general.  We have a few platforms with somewhat different properties:
> > 
> > TDX: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  In principle, the same address could be *both* and be distinguished by only that bit, and the two addresses would refer to different pages.
> > 
> > SEV: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  At any given time, a physical address (with that bit masked off) can be private, shared, or invalid, but it can't be valid as private and shared at the same time.
> > 
> > pKVM (currently, as I understand it): the guest decides by hypercall, in advance of an access, which addresses are private and which are shared.
> > 
> > This series, if I understood it correctly, is like TDX except with no hardware security.
> > 
> > Sean or Chao, do you have a clear sense of whether the current fd-based private memory proposal can cleanly support SEV and pKVM?  What, if anything, needs to be done on the API side to get that working well?  I don't think we need to support SEV or pKVM right away to get this merged, but I do think we should understand how the API can map to them.
> 
> I've been looking at porting the SEV-SNP hypervisor patches over to
> using memfd, and I hit an issue that I think is generally applicable
> to SEV/SEV-ES as well. Namely at guest init time we have something
> like the following flow:
> 
>   VMM:
>     - allocate shared memory to back the guest and map it into guest
>       address space
>     - initialize shared memory with initialize memory contents (namely
>       the BIOS)
>     - ask KVM to encrypt these pages in-place and measure them to
>       generate the initial measured payload for attestation, via
>       KVM_SEV_LAUNCH_UPDATE with the GPA for each range of memory to
>       encrypt.
>   KVM:
>     - issue SEV_LAUNCH_UPDATE firmware command, which takes an HPA as
>       input and does an in-place encryption/measure of the page.
> 
> With current v5 of the memfd/UPM series, I think the expected flow is that
> we would fallocate() these ranges from the private fd backend in advance of
> calling KVM_SEV_LAUNCH_UPDATE (if VMM does it after we'd destroy the initial
> guest payload, since they'd be replaced by newly-allocated pages). But if
> VMM does it before, VMM has no way to initialize the guest memory contents,
> since mmap()/pwrite() are disallowed due to MFD_INACCESSIBLE.

OK, so for SEV, basically VMM puts vBIOS directly into guest memory and then
do in-place measurement.

TDX has no problem because TDX temporarily uses a VMM buffer (vs. guest memory)
to hold the vBIOS and then asks SEAM-MODULE to measure and copy that to guest
memory.

Maybe something like SHM_LOCK should be used instead of the aggressive
MFD_INACCESSIBLE. Before VMM calling SHM_LOCK on the memfd, the content
can be changed but after that it's not visible to userspace VMM. This
gives userspace a chance to modify the data in private page.

Chao
> 
> I think something similar to your proposal[1] here of making pread()/pwrite()
> possible for private-fd-backed memory that's been flagged as "shareable"
> would work for this case. Although here the "shareable" flag could be
> removed immediately upon successful completion of the SEV_LAUNCH_UPDATE
> firmware command.
> 
> I think with TDX this isn't an issue because their analagous TDH.MEM.PAGE.ADD
> seamcall takes a pair of source/dest HPA as input params, so the VMM
> wouldn't need write access to dest HPA at any point, just source HPA.
> 
> [1] https://lwn.net/ml/linux-kernel/eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com/
