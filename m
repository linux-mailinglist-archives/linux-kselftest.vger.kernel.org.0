Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801163FD15
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiLBAbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiLBAbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:31:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0A167FF;
        Thu,  1 Dec 2022 16:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2dY3JAbIiIjuuMcx2DeNesb+NeuIsA0QCjpBYCCfdElLT4hW4nITNytfS/7kw8o1aNF4eSon4zKptAmM4VZBsf/IqO1E95p07MM9/eCVHrZgDrRXnekq662rpl0I7d0p9cQMGWoJssSIEJwzWOTsqtYacYVuPfsud41qzqihsUc1yOt702EL7CjS3RUVwS9JVLmLjYZjfPK6hxXGcppsE8NyEvjnxWQn1LMwkSJIXx2QgCR9iG2EYHOxWJVqFeuWXbW/PWPPtLzCNM5d3ERxINbHHlO1KyiTSew5S7333Kiq9Ox2Ur3AldRRebCNm9+KIvNWuQFgPM8Q36NRmdaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3AeYI3Jwn+HDz/2sUS8t5Z5+0tdUvkDPqtG1PVOo04=;
 b=MtjlY2zd2KzTVeqJWJIjLG5i3SuTmGekh98MKIoWkVyl9aBXBeJvN3aC0RvqRkjxx/pnvN33aEDLAfSj3r3WMprOF/zcxT4sY2Z42ok5Yrzaq8TCZyhKBs1D4N1T7OIXcFHNTzT32tsd4AwSbc3DX/UUVsOZ09y3IxXPmXserJm+vyafIpzio8uxehxiarUav61/OQWEXIoVyDIZbSr5IMmp7QcFe9qp84PocZVWkCOqK0DTeOqZMv1Y90yLv1uF6yOnMhFjCo3B+zbHMtdj5Gvq4Bavrg2gIL2wWptVa+ItOvsd9DzFZIeZqFGsqOPRL94F97PJCDf0xDOw6Nswig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3AeYI3Jwn+HDz/2sUS8t5Z5+0tdUvkDPqtG1PVOo04=;
 b=u7iG3eei/XJe49F8raFF/ZOeu2CJ9LAE0rrgCT92tw5yo3ap4smJQiuHiuLrbt6f7p07lkDERsrVXCi1u+3HAUIVOlASFotlwRNbzK2hyi3xH9F4V+Us9zM1oyUVZr7sULKx5wRXdhra72vQK4LEzNnBEW2Qnli2UaFpkcvK2lw=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 00:26:55 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 00:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 00:26:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 18:26:50 -0600
Date:   Thu, 1 Dec 2022 18:26:35 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>, <x86@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        <vkuznets@redhat.com>, <wanpengli@tencent.com>,
        <jmattson@google.com>, <joro@8bytes.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <shuah@kernel.org>, <yang.zhong@intel.com>,
        <ricarkol@google.com>, <aaronlewis@google.com>,
        <wei.w.wang@intel.com>, <kirill.shutemov@linux.intel.com>,
        <corbet@lwn.net>, <hughd@google.com>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <akpm@linux-foundation.org>,
        <yu.c.zhang@linux.intel.com>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <qperret@google.com>,
        <steven.price@arm.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <luto@kernel.org>, <vbabka@suse.cz>, <marcorr@google.com>,
        <erdemaktas@google.com>, <pgonda@google.com>, <nikunj@amd.com>,
        <diviness@google.com>, <maz@kernel.org>, <dmatlack@google.com>,
        <axelrasmussen@google.com>, <maciej.szmigiero@oracle.com>,
        <mizhang@google.com>, <bgardon@google.com>,
        <ackerleytng@google.com>
Subject: Re: [V1 PATCH 1/6] KVM: x86: Add support for testing private memory
Message-ID: <20221202002635.bkhs3h7skd7igtpr@amd.com>
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-2-vannapurve@google.com>
 <20221122100705.GA619277@chaop.bj.intel.com>
 <Y30rqWwDRbH7nQaQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y30rqWwDRbH7nQaQ@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: f05f1855-ab26-4cc8-b41c-08dad3fbea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2xTWzJUZJNKiRpihyPypvxmM87Yaaj2BatnFnHIm+jxlZImNxUUFW3tXyLddx3twUYahI6VWZUzsh48apzq/G5yOJ32HlK0n5pepoBOFljjA/1WwP6C28RtuulyYLH49IIt5gFk6HGvY5BU+1+H+NSoCAz4vM3Roigvwd7QDr7NVvLEv5qEYIZCS2t5yWbTQljxIvDlLSZ4HjyH8CvvbbRKn1cqQRVhb4/Bp6s3AtCtNz9iLeRYQ8dgGDwJMXHCspoBNu2sVvnna8xs+XbOXDo37TuBb/dYusSY972Xp7iREGZ02hGP+qEZh34PO4D/ejZRdJg/3OomMNCHhnT/4uA32rj8CwaKz2+Uvi1gHkFjHg9PugGbES0acHPc4oAGX6IHL5hOnQ3WkaN20eKvAPMKRb18choWL+h6awH3JSKGMQEzrtKj0hBuPnDZWkTG6cmf3jTSzN3bQ8MGJ8ziL6Gi3MvfP9dEfvRQaEZkFtDq/R4ab1KdBSrY5Lza5QcT3YxsphMsLBtXy+Pq05iTmeHVO3XUpRQcnE2CR4DTLwFHtG6ZJwpoxtbZR8Oc6cSUkf/ERFaA9YLLlq4AmgHI8v28GUe3A2L0dJcqI/OeLugfmyxfwJVH6DZWVAQGD2E9QXgjRu4dplEY8ojLZmQqf1zDVSfhTs00yfCpF35grChwim0qA0/EVViJpaZaW9+fZ8pJdTReB+eRqjV0yesfUjlDFMnhg909fXBhlOLKGPjFQNUUazeVNufJ72+D9NnRUMC/ZUs1DJgAUt1jSEQe7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(478600001)(316002)(70586007)(70206006)(1076003)(40460700003)(356005)(81166007)(45080400002)(36756003)(54906003)(426003)(82740400003)(26005)(6666004)(82310400005)(40480700001)(47076005)(16526019)(36860700001)(2616005)(86362001)(966005)(186003)(336012)(6916009)(7416002)(44832011)(5660300002)(7406005)(41300700001)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:26:55.0937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05f1855-ab26-4cc8-b41c-08dad3fbea96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 22, 2022 at 08:06:01PM +0000, Sean Christopherson wrote:
> On Tue, Nov 22, 2022, Chao Peng wrote:
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 10017a9f26ee..b3118d00b284 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -4280,6 +4280,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > >  
> > >  	fault->gfn = fault->addr >> PAGE_SHIFT;
> > >  	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
> > > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
> > > +	fault->is_private = kvm_slot_can_be_private(fault->slot) &&
> > > +			kvm_mem_is_private(vcpu->kvm, fault->gfn);
> > > +#endif
> > >  
> > >  	if (page_fault_handle_page_track(vcpu, fault))
> > >  		return RET_PF_EMULATE;
> > > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > > index 5cdff5ca546c..2e759f39c2c5 100644
> > > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > > @@ -188,7 +188,6 @@ struct kvm_page_fault {
> > >  
> > >  	/* Derived from mmu and global state.  */
> > >  	const bool is_tdp;
> > > -	const bool is_private;
> > >  	const bool nx_huge_page_workaround_enabled;
> > >  
> > >  	/*
> > > @@ -221,6 +220,9 @@ struct kvm_page_fault {
> > >  	/* The memslot containing gfn. May be NULL. */
> > >  	struct kvm_memory_slot *slot;
> > >  
> > > +	/* Derived from encryption bits of the faulting GPA for CVMs. */
> > > +	bool is_private;
> > 
> > Either we can wrap it with the CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING or if
> > it looks ugly I can remove the "const" in my code.
> 
> Hmm, I think we can keep the const.  Similar to the bug in kvm_faultin_pfn()[*],
> the kvm_slot_can_be_private() is bogus.  A fault should be considered private if
> it's marked as private, whether or not userspace has configured the slot to be
> private is irrelevant.  I.e. the xarray is the single source of truth, memslots
> are just plumbing.

I've been looking at pulling this series into our SNP+UPM patchset (and
replacing the UPM selftests that were including with UPMv9). We ended up
with something similar to what you've suggested, but instead of calling
kvm_mem_is_private() directly we added a wrapper in mmu_internal.h that's
called via:

kvm_mmu_do_page_fault():
  struct kvm_page_fault fault = {
    ...
    .is_private = kvm_mmu_fault_is_private()

where kvm_mmu_fault_is_private() is defined something like:

static bool kvm_mmu_fault_is_private(struct kvm *kvm, gpa_t gpa, u64 err)
{
        struct kvm_memory_slot *slot;
        gfn_t gfn = gpa_to_gfn(gpa);
        bool private_fault = false;

        slot = gfn_to_memslot(kvm, gpa_to_gfn(gpa));
        if (!slot)
                goto out;

        if (!kvm_slot_can_be_private(slot))
                goto out;

		/* If platform hook returns 1 then use it's determination of private_fault */
        if (static_call(kvm_x86_fault_is_private)(kvm, gpa, err, &private_fault) == 1)
                goto out;

        /*
         * Handling below is for guests that rely on the VMM to control when a fault
         * should be treated as private or not via KVM_MEM_ENCRYPT_{REG,UNREG}_REGION.
         * This is mainly for the KVM self-tests for restricted memory.
         */
#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
        private_fault = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa);
#endif

out:
        return private_fault;
}

I tried removing kvm_slot_can_be_private() based on your comments, but
we ended up hitting a crash in restrictedmem_get_page(). I think this is
because the xarray currently defaults to 'private', so when KVM MMU relies
only on xarray it can hit cases where it thinks a GPA should be backed
by a restricted page, but when it calls kvm_restrictedmem_get_pfn() a
null slot->restricted_file gets passed to restricted_get_page() and it
blows up.

I know Chao mentioned they were considering switching to 'shared' as the
default xarray value, which might fix this issue, but until then we've
left these checks in place.

Just figured I'd mention this in case Vishal hits similar issues.

-Mike

> 
> Then kvm_mmu_do_page_fault() can do something like:
> 
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index dbaf6755c5a7..456a9daa36e5 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -260,6 +260,8 @@ enum {
>  static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                                         u32 err, bool prefetch)
>  {
> +       bool is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault);
> +
>         struct kvm_page_fault fault = {
>                 .addr = cr2_or_gpa,
>                 .error_code = err,
> @@ -269,13 +271,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                 .rsvd = err & PFERR_RSVD_MASK,
>                 .user = err & PFERR_USER_MASK,
>                 .prefetch = prefetch,
> -               .is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> +               .is_tdp = is_tdp,
>                 .nx_huge_page_workaround_enabled =
>                         is_nx_huge_page_enabled(vcpu->kvm),
>  
>                 .max_level = KVM_MAX_HUGEPAGE_LEVEL,
>                 .req_level = PG_LEVEL_4K,
>                 .goal_level = PG_LEVEL_4K,
> +               .private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
> +                          kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
>         };
>         int r;
> 
> [*] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FY3Vgc5KrNRA8r6vh%40google.com&amp;data=05%7C01%7CMichael.Roth%40amd.com%7Cc65b2b9b200e41f189ff08daccc4ffdc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638047443786540517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Oajn46ulTFXBh0nIx61YmbbMAqW64EqKRniZJwLfXLs%3D&amp;reserved=0
