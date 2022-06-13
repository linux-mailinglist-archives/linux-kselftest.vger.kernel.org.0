Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68342549DA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350441AbiFMT1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiFMT0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 15:26:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4215AA6E;
        Mon, 13 Jun 2022 10:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkTifxIDtJegKV15Y+vAi33H2SihkVEY8+/Vt9oP7ep3lmwT5YZMkM2/M5DFk3xVqoKfGEs30mDTVkSXew0u9JiQPxMCpaEvlgaWTPr3DQqyF8oOibXzH5FfL+EXfXrOcR3UjGepQ6y73p/EmX6iRrt205F7YLoyxteQ7yVIZHajW+ep9s0Wq02lyE9ywF9QJ7ekbjYYUvEmRWNq7Ml+Vhe3XfcK6jIqpRdLnAfeHTIvwpCVgLv9jEv04FMFlVEBjU5gwaR8BmT7e3iPkbvhpcrIptpk12zEPvvJTUDq8vmfjUq7TaQx77E/M93VF/amyAWlIuGpSkdcR7iw/rlJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9iAepru/TMLc8m+RSnwuK/VHeQhBiJI1HaFiNxuBzw=;
 b=V6NtGChQCAcZi0+oDpQguNLYq31hQ7p2tamoDD/2SVikYPZ6kvTff3PGsT4u3HvwU3bLdh8wWPZaWbrXjc7fq6Xe8hRu9q6cDG8GL+vDkozz92PwuPULK4o/7DNIjoDUTNC35GEdcl4FcBNNF2lYFjCZaVQlcfh8F4AHooK3QB2/PgBAaWaXlR9KoB1+Hi3uiagNfzi0CtKshpeMckF/w6WsMMoDJG20lpQ9k5PX9zcicPmAatMxD51W/aCafFvvB1mrzGMKk5890gLDm3LoJrsoEYvA3rzyXW4bxnmbQqSt4zs8lths1JZyDzpAN9Hz/dIvv8SCtnG5OfFOy9zJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9iAepru/TMLc8m+RSnwuK/VHeQhBiJI1HaFiNxuBzw=;
 b=OHeQ0Svw1576b7lL+WQQgO77zC/tJB+jvZqH34lnaPGWRT54SvvbwUyw6UflDCTOPnyovC4mrhr522Mf74MOfuPHumQw0elFm3VnDCeQQpwXfCATYCVMMrSRXOQ/pt9y1BcWxucPjTXW2mNfBIFxU1xwjiibWnhhbQRrUXWfZp8=
Received: from DM3PR12CA0107.namprd12.prod.outlook.com (2603:10b6:0:55::27) by
 LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Mon, 13 Jun 2022 17:49:44 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::2c) by DM3PR12CA0107.outlook.office365.com
 (2603:10b6:0:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 17:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 17:49:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 12:49:42 -0500
Date:   Mon, 13 Jun 2022 12:49:28 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Vishal Annapurve <vannapurve@google.com>
CC:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        shuah <shuah@kernel.org>, <yang.zhong@intel.com>,
        <drjones@redhat.com>, "Ricardo Koller" <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>, <wei.w.wang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hugh Dickins" <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Steven Price" <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>, Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Austin Diviness" <diviness@google.com>, <maz@kernel.org>,
        <dmatlack@google.com>, <axelrasmussen@google.com>,
        <maciej.szmigiero@oracle.com>, Mingwei Zhang <mizhang@google.com>,
        <bgardon@google.com>
Subject: Re: [RFC V1 PATCH 0/3] selftests: KVM: sev: selftests for fd-based
 approach of supporting private memory
Message-ID: <20220613174928.f4yyvu45rliuuld6@amd.com>
References: <20220524205646.1798325-1-vannapurve@google.com>
 <20220610010510.vlxax4g3sgvsmoly@amd.com>
 <CAGtprH92PVtCDGrtwcvfrsKokFbYrqXqtH6D_aUrYXvHYyWpyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGtprH92PVtCDGrtwcvfrsKokFbYrqXqtH6D_aUrYXvHYyWpyQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878a940e-d0d2-471e-ac17-08da4d65195b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5750:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5750A6BA9B80ECD2565BC24095AB9@LV2PR12MB5750.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h//F0zPkyoad1Kw5Qed4PVEOHODy5MYHVNcL7oVx/MVdoYNqhyE+pHwHybk1zxXlC4u0ocyPFfzJg62W/TshuL6UUyIJmES1J29xSAkdouIR8C/ckjDl72BUhuqo7P7omzBFkuxg0wN6kQHwNX+g6r9xB0cGdjaaoLczgDXzoDPzd7v4kPH6EtSRtxhRfi73dSPP7nmrL7WCIAiNRBW9GezkXGP57fInQtoaAoXCCUgHx4FEbsJ/qLKpHJSH8HQBbnFeY64evSMJwmpZ6seT6rFJ1W3d25Vyrap/WB98NHdexUHrISVzDKUjbivo8CkwBZHuvQATkfgPP1L0g248vksMq24lHOGHPcqrYbau3aJG20yvT1LI2VKtspr20/sJQKA6DO2qyIhAUxSTjrDhiV5A0fzKcT3tDcOCWPEqSBK2QICwNKgmvX65zXSkb4boWUIa90P5YDTdFstp+FVTeFcNUiK1jLQWWE0ApAh9gyyOTHFF1t2dbTs5Fuc6amdCe7z6x7A41aDCOevWAU47yYbZBpZUPP6jFYz/vnI0e2ZHaof6YANTWS5mu/OV1Y0DAmXmGwi3LUaFMGag46iRG/mCpWEZoTcspAADtrF5Xt57mXL5XcI4urhAoTShcxQaZW692Owd4m09T5OEUSPlr4a5StwPv5k4T9HL69G6woKGIuevtNxGbKJqzFBjYxmJFfkw9DIySWW7U2PCAjJD4DB7c98YpgzjPx4tdgOMag76QXD0nVjwa19qDb5XItP41mSjRfppDyjwandukBrDdaiutZv8PVjheUSHj87ajkGC0f/cQqO3k+2WrY92Bqeaw6rFlStoyT299RYgeDc2Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(508600001)(44832011)(7416002)(5660300002)(8936002)(7406005)(45080400002)(6916009)(356005)(36756003)(81166007)(966005)(2906002)(40460700003)(8676002)(70206006)(86362001)(70586007)(6666004)(4326008)(54906003)(426003)(316002)(83380400001)(336012)(2616005)(186003)(16526019)(26005)(1076003)(47076005)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 17:49:43.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878a940e-d0d2-471e-ac17-08da4d65195b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 10, 2022 at 02:01:41PM -0700, Vishal Annapurve wrote:
> ....
> >
> > I ended up adding a KVM_CAP_UNMAPPED_PRIVATE_MEM to distinguish between the
> > 2 modes. With UPM-mode enabled it basically means KVM can/should enforce that
> > all private guest pages are backed by private memslots, and enable a couple
> > platform-specific hooks to handle MAP_GPA_RANGE, and queries from MMU on
> > whether or not an NPT fault is for a private page or not. SEV uses these hooks
> > to manage its encryption bitmap, and uses that bitmap as the authority on
> > whether or not a page is encrypted. SNP uses GHCB page-state-change requests
> > so MAP_GPA_RANGE is a no-op there, but uses the MMU hook to indicate whether a
> > fault is private based on the page fault flags.
> >
> > When UPM-mode isn't enabled, MAP_GPA_RANGE just gets passed on to userspace
> > as before, and platform-specific hooks above are no-ops. That's the mode
> > your SEV self-tests ran in initially. I added a test that runs the
> > PrivateMemoryPrivateAccess in UPM-mode, where the guest's OS memory is also
> > backed by private memslot and the platform hooks are enabled, and things seem
> > to still work okay there. I only added a UPM-mode test for the
> > PrivateMemoryPrivateAccess one though so far. I suppose we'd want to make
> > sure it works exactly as it did with UPM-mode disabled, but I don't see why
> > it wouldn't.
> 
> Thanks Michael for the update. Yeah, using the bitmap to track
> private/shared-ness of gfn ranges should be the better way to go as
> compared to the limited approach I used to just track a single
> contiguous pfn range.
> I spent some time in getting the SEV/SEV-ES priv memfd selftests to
> execute from private fd as well and ended up doing similar changes as
> part of the github tree:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fvishals4gh%2Flinux%2Fcommits%2Fsev_upm_selftests_rfc_v2&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2Bb3S2xOAWga8k5tsS2EHMQF5CXuKG60qy0ToeEhhQ4A%3D&amp;reserved=0.
> 
> >
> > But probably worth having some discussion on how exactly we should define this
> > mode, and whether that meshes with what TDX folks are planning.
> >
> > I've pushed my UPM-mode selftest additions here:
> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fsev_upm_selftests_rfc_v1_upmmode&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3YLZcCevIkuo5cw%2FpKk5Sf9y6%2F1ZPss6ujZtLYEbV3M%3D&amp;reserved=0
> >
> > And the UPM SEV/SEV-SNP tree I'm running them against (DISCLAIMER: EXPERIMENTAL):
> >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fpfdv6-on-snpv6-upm1&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mW8ypNWyREtoDJ%2BHNi20OT8Hzelqk5Na8eC8ihkfCjY%3D&amp;reserved=0
> >
> 
> Thanks for the references here. This helps get a clear picture around
> the status of priv memfd integration with Sev-SNP VMs and this work
> will be the base of future SEV specific priv memfd selftest patches as
> things get more stable.
> 
> I see usage of pwrite to populate initial private memory contents.
> Does it make sense to have SEV_VM_LAUNCH_UPDATE_DATA handle the
> private fd population as well?
> I tried to prototype it via:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fvishals4gh%2Flinux%2Fcommit%2Fc85ee15c8bf9d5d43be9a34898176e8230a3b680%23&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=QwP4JioniC06yFV7c%2BY35LtqJy9INGlcQ9Z6gn3nOrI%3D&amp;reserved=0

Thanks for the pointer and for taking a stab at this approach (hadn't
realized you were looking into this so sorry for the overlap with your
code).

> as I got this suggestion from Erdem Aktas(erdemaktas@google) while
> discussing about executing guest code from private fd.

The way we way have the host patches implemented currently is sort of based
around the idea that userspace handles all private/shared conversion via
allocations/deallocations from the private backing store, since I
thought that was one of the design goals. For SNP that means allocating a
page from backing store will trigger the additional hooks in the kernel needed
to do some additional bookkeeping like RMP updates and removing from directmap,
which I'm doing via a platform-specific callback I've added to the KVM memfile
notifier callback.

There was some talk of allowing a sort of pre-boot stage to the
MFD_INACCESSIBLE protections where writes would be allowed up until a
certain point. The kernel hack to allow pwrite() was sort of a holdover
for this support.

Handling pre-population as part of SNP_LAUNCH_UPDATE seems sort of
incompatible with this, since it reads from shared memory and writes
into private memory. So either:

a) userspace pre-allocated the private backing page before calling
   SNP_LAUNCH_UPDATE to fill it, in which case the kernel is mapping
   private memory into it's address space that is now already
   guest-owned which will cause an RMP fault, or

b) userspace lets SNP_LAUNCH_UPDATE allocate the private page as part of
   copying over the data from shared page, in which case we'd get the
   invalidation notifier callback going through the normal shmem
   allocation path, and would need to bypass this to ensure that
   notifier trigger after the memory has been populated.

Maybe some other sort of notifier to handle the RMP/directmap changes
would avoid these issues, but that seems to move us closer to just
having a KVM ioctl to handle the conversions and manage this
book-keeping via KVM ioctls rather than mem FD callbacks/notifiers.
There seems to be some discussion around doing something of this sort
but still need to get some clarity on this.

> Apart from the aspects I might not be aware of, this can have
> performance overhead depending on the initial Guest UEFI boot memory
> requirements. But this can allow the userspace VMM to keep most of the
> guest vm boot memory setup the same and
> avoid changing the host kernel to allow private memfd writes from userspace.

I think it would be good if we could reduce the complexity on the VMM
side. Having a KVM ioctl that instructs KVM to convert a range of GPAs
between private<->shared via private memslot/FD would also achieve that,
while also avoiding needing special handling for this pre-launch case
vs. conversions during run-time. Probably worth discussing more in
Chao's thread where there's some related discussion.

Thanks,

Mike

> 
> Regards,
> Vishal
