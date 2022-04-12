Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80A74FDC29
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Apr 2022 13:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiDLKPI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355838AbiDLJT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 05:19:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDA237EA;
        Tue, 12 Apr 2022 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649751919; x=1681287919;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=wa0dgOa2bUIhS6s5MOqyz5XHWr88Riy5FGtqVsg0X1c=;
  b=X0DHIx6KhYh7SORGo/j/iTV+5MUNI4Pk/R6WjU9QHndUKMrtpaqRxdYd
   7gu4Crbk2bQ0ZAgJoj2FE9Dr1JFx/8+Zu4CNi7Jora4goadkyzoV+EtQx
   8H0pUzrN3i6+swButjW2gmmxgiyQttOW2wITU3a+ZTJ8kJJ9Fi6S+vVT1
   oeX0TDZ5sx4B3g/+eiQF9mLWK67UcgipMdk4JjOc7YSvBQCUyWar8P7xo
   +ngnAHAG4BbEReAUdkyOjcdEpA+VASjar4XoY6HT7jKdOfNlZKo6kS18w
   WvLVCc7ekjUP8QvIzJiKsYzIDVG9e2If8kEMiDsCy/L31DNFmQM/EyHLu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262495645"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262495645"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 01:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699728288"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 01:25:10 -0700
Date:   Tue, 12 Apr 2022 16:25:00 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shauh@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, seanjc@google.com, diviness@google.com
Subject: Re: [RFC V1 PATCH 0/5] selftests: KVM: selftests for fd-based
 approach of supporting private memory
Message-ID: <20220412082500.GA7309@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220408210545.3915712-1-vannapurve@google.com>
 <0790131c-95af-676f-c475-addd1191eacd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0790131c-95af-676f-c475-addd1191eacd@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 11, 2022 at 05:31:09PM +0530, Nikunj A. Dadhania wrote:
> On 4/9/2022 2:35 AM, Vishal Annapurve wrote:
> > This series implements selftests targeting the feature floated by Chao
> > via:
> > https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> > 
> 
> Thanks for working on this.
> 
> > Below changes aim to test the fd based approach for guest private memory
> > in context of normal (non-confidential) VMs executing on non-confidential
> > platforms.
> > 
> > Confidential platforms along with the confidentiality aware software
> > stack support a notion of private/shared accesses from the confidential
> > VMs.
> > Generally, a bit in the GPA conveys the shared/private-ness of the
> > access. Non-confidential platforms don't have a notion of private or
> > shared accesses from the guest VMs. To support this notion,
> > KVM_HC_MAP_GPA_RANGE
> > is modified to allow marking an access from a VM within a GPA range as
> > always shared or private. Any suggestions regarding implementing this ioctl
> > alternatively/cleanly are appreciated.
> > 
> > priv_memfd_test.c file adds a suite of two basic selftests to access private
> > memory from the guest via private/shared access and checking if the contents
> > can be leaked to/accessed by vmm via shared memory view.
> > 
> > Test results:
> > 1) PMPAT - PrivateMemoryPrivateAccess test passes
> > 2) PMSAT - PrivateMemorySharedAccess test fails currently and needs more
> > analysis to understand the reason of failure.
> 
> That could be because of the return code (*r = -1) from the KVM_EXIT_MEMORY_ERROR. 
> This gets interpreted as -EPERM in the VMM when the vcpu_run exits.
> 
> 	+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
> 	+	vcpu->run->memory.flags = flags;
> 	+	vcpu->run->memory.padding = 0;
> 	+	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> 	+	vcpu->run->memory.size = PAGE_SIZE;
> 	+	fault->pfn = -1;
> 	+	*r = -1;
> 	+	return true;

That's true. The current private mem patch treats KVM_EXIT_MEMORY_ERROR as error
for KVM_RUN. That behavior needs to be discussed, but right now (v5) it hits the
ASSERT in tools/testing/selftests/kvm/lib/kvm_util.c before you have chance to
handle KVM_EXIT_MEMORY_ERROR in this patch series.

void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
{
        int ret = _vcpu_run(vm, vcpuid);
        TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
                "rc: %i errno: %i", ret, errno);
}

Thanks,
Chao

> 
> 
> Regards
> Nikunj
> 
> [1] https://lore.kernel.org/all/20220310140911.50924-10-chao.p.peng@linux.intel.com/#t
