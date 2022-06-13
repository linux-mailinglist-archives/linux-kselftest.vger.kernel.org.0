Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F2549F9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiFMUkq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiFMUka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 16:40:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F465D644;
        Mon, 13 Jun 2022 12:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU7gs7UIoEC6a6kPLpKT+UQrKVUv/LUmnq5/UhO9HS6vtq3tw7i0osuis//fCyMG0jgy8qU+bdhEyz/yzgkYQs/Hn5bVwIOJgjszeSBYBaVtrw0xRRgM4PKuNtzkd0qLY8Esk/FuHHrxhX8sKmE2aDtrRegbJAYQwFZjDprqmoG/c6I5WgT6rnwG+sTOMr0K0FUC4/pN4hEe5+4wEtYVcJ1oF+tIM8ffG/OEWq60HZuglWyAKODI0BZH+FOVK6b6p7AEiJKOaKEPGZiUWx47D5Q4nyS1RiPw7z0RctLLlr4uBjZLD0ZyNCC8shrAwMxB+vNuvczmFpClgrgw3kx0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeOWkDpLtB5Djo4/7etMXzf2lg2zDLcwMRr+/WsIy5s=;
 b=X1fa+NUGzPLGnRFyn1IdD7Ke12xj0TmASIbENLPVgJ6pLTlXLiu93RbvmMniGNG3s6ZDFxvn70ZAopgZk7eN0juELm44y0hS1rTnhX5LdjxdUrr4QE0TYgTlnuUeYztuG3sbLqVwIF+tYbW/IvC92nXrG381L6XzdDCSmTukEw6hRd8yWtLmT3+9G91vGpIOsfxYUr1xI4OmI8nKTS64tIWAR6MkeafS0gh+EfLc5aiyVpcziq3F/4N6wK7wUs++RDUVTlsWVpjAUysH3EvBCOKSufzRJ2RTeJQhENqVcqyFe73tcs4Jwkw2Vd+pbccrhyrcOiIIOc/9iY+sW8mFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeOWkDpLtB5Djo4/7etMXzf2lg2zDLcwMRr+/WsIy5s=;
 b=SNawYvqe/rd8bmC6upVAH3G5LivediVVNpmzoC01F2L7TbO5E0fgynjh4uMfu492pgPBhCVhf3LKMSq8r/IEXTf3EihLeugJEKBZzvOeBMYA0BAtHKg8Tw6Wo0O4zq4V3nBMu2tZePqztdaFga0K+pqXb0A2mXizAOGB3WETuxs=
Received: from DM5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:3:117::17)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 19:36:06 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::80) by DM5PR13CA0055.outlook.office365.com
 (2603:10b6:3:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6 via Frontend
 Transport; Mon, 13 Jun 2022 19:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:36:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:36:05 -0500
Date:   Mon, 13 Jun 2022 14:35:43 -0500
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
Message-ID: <20220613193543.ilj2tv4se5emupix@amd.com>
References: <20220524205646.1798325-1-vannapurve@google.com>
 <20220610010510.vlxax4g3sgvsmoly@amd.com>
 <CAGtprH92PVtCDGrtwcvfrsKokFbYrqXqtH6D_aUrYXvHYyWpyQ@mail.gmail.com>
 <20220613174928.f4yyvu45rliuuld6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220613174928.f4yyvu45rliuuld6@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f4f73e-daf0-4dca-dc67-08da4d73f5ca
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678D906FCDE369DB1381DE195AB9@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+czUPVQqpfXnaz0SzDX/DLTUisyJYSBaBI7F1KHDZSDLKbCs7+3Js4sropqvV49iRzywkMWBspZQqq/2s0Rl3k1wMMuqJcgjH1MGQL1hHjgiqyxXl4HxZzPZrw7XfNjBOVTLw+dWfkb9SaQfm/mu64gFVXhd9+lRT0XkiWlOJA8mMc18AMWTFaCVp3hGbkrPmtq98MnxbrPP56CknrStmO5Q5obGZ1sMDdAFVqWMrNlLo8br1xckVcnP4NN+hIMPKhZ9ltLNtelODjj9L+PxCnw9PT0n7GavwZ9SD+z4jEnk2wRZ+/S6jIGEW/AbN1LRy9LoGm10CpWvH5FRswLAazTdwuN+hSNfbHlxCpoe+pqGVkN96uSVgJW+Y9GmqNEW9tUuqXIQWmyY9nVWeS7+vZo2TKdgCC0jlU7FOkG/ufVtlvVPuQ0A9yEk9REHzW1ZTB403uMYBXWRXT1JFrc0upMp8OQDbHH9EwzZeFDbLRCXrsFsLbY/6tuKDW1ceftJim+wV+ONuxWrdcZaWaCunPqHAc8v67pFOo45P1mjop0wNrymhzuplc56CtNPFr3J0jwSTqjNmZIUPwKDeFO+7v2hngo2yll3+Eyqt0xbG478Kokn/k8nnVDfJvNvFRaMDqnpoh5bjyDxMRju7JQXUezMmJEZo/OusaFjMx9O4HbHQAxo20R0rXXzOOI1YF7d+pL0cDysm5dKM70vZ14ABOBkXDGnUfxkKsGosTmVWMm5xLErSDKsEWFaUMSY8PGLkWJ4ucY8bZfh9m9uUGawvLwN/XHbB6sEj89TL72wQs3qxm6DV7YpEu2QmOw/U9W2+PJzc7svhTJqR2qQBtV8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(6916009)(508600001)(6666004)(45080400002)(966005)(2906002)(7406005)(44832011)(16526019)(7416002)(8936002)(316002)(70586007)(70206006)(8676002)(5660300002)(86362001)(4326008)(36756003)(40460700003)(81166007)(356005)(47076005)(426003)(2616005)(1076003)(336012)(83380400001)(36860700001)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:36:06.5699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f4f73e-daf0-4dca-dc67-08da4d73f5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 13, 2022 at 12:49:28PM -0500, Michael Roth wrote:
> On Fri, Jun 10, 2022 at 02:01:41PM -0700, Vishal Annapurve wrote:
> > ....
> > >
> > > I ended up adding a KVM_CAP_UNMAPPED_PRIVATE_MEM to distinguish between the
> > > 2 modes. With UPM-mode enabled it basically means KVM can/should enforce that
> > > all private guest pages are backed by private memslots, and enable a couple
> > > platform-specific hooks to handle MAP_GPA_RANGE, and queries from MMU on
> > > whether or not an NPT fault is for a private page or not. SEV uses these hooks
> > > to manage its encryption bitmap, and uses that bitmap as the authority on
> > > whether or not a page is encrypted. SNP uses GHCB page-state-change requests
> > > so MAP_GPA_RANGE is a no-op there, but uses the MMU hook to indicate whether a
> > > fault is private based on the page fault flags.
> > >
> > > When UPM-mode isn't enabled, MAP_GPA_RANGE just gets passed on to userspace
> > > as before, and platform-specific hooks above are no-ops. That's the mode
> > > your SEV self-tests ran in initially. I added a test that runs the
> > > PrivateMemoryPrivateAccess in UPM-mode, where the guest's OS memory is also
> > > backed by private memslot and the platform hooks are enabled, and things seem
> > > to still work okay there. I only added a UPM-mode test for the
> > > PrivateMemoryPrivateAccess one though so far. I suppose we'd want to make
> > > sure it works exactly as it did with UPM-mode disabled, but I don't see why
> > > it wouldn't.
> > 
> > Thanks Michael for the update. Yeah, using the bitmap to track
> > private/shared-ness of gfn ranges should be the better way to go as
> > compared to the limited approach I used to just track a single
> > contiguous pfn range.
> > I spent some time in getting the SEV/SEV-ES priv memfd selftests to
> > execute from private fd as well and ended up doing similar changes as
> > part of the github tree:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fvishals4gh%2Flinux%2Fcommits%2Fsev_upm_selftests_rfc_v2&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2Bb3S2xOAWga8k5tsS2EHMQF5CXuKG60qy0ToeEhhQ4A%3D&amp;reserved=0.
> > 
> > >
> > > But probably worth having some discussion on how exactly we should define this
> > > mode, and whether that meshes with what TDX folks are planning.
> > >
> > > I've pushed my UPM-mode selftest additions here:
> > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fsev_upm_selftests_rfc_v1_upmmode&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3YLZcCevIkuo5cw%2FpKk5Sf9y6%2F1ZPss6ujZtLYEbV3M%3D&amp;reserved=0
> > >
> > > And the UPM SEV/SEV-SNP tree I'm running them against (DISCLAIMER: EXPERIMENTAL):
> > >   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fpfdv6-on-snpv6-upm1&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mW8ypNWyREtoDJ%2BHNi20OT8Hzelqk5Na8eC8ihkfCjY%3D&amp;reserved=0
> > >
> > 
> > Thanks for the references here. This helps get a clear picture around
> > the status of priv memfd integration with Sev-SNP VMs and this work
> > will be the base of future SEV specific priv memfd selftest patches as
> > things get more stable.
> > 
> > I see usage of pwrite to populate initial private memory contents.
> > Does it make sense to have SEV_VM_LAUNCH_UPDATE_DATA handle the
> > private fd population as well?
> > I tried to prototype it via:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fvishals4gh%2Flinux%2Fcommit%2Fc85ee15c8bf9d5d43be9a34898176e8230a3b680%23&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cf040f8a9f98146f8008508da4b2472c5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637904917162115269%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=QwP4JioniC06yFV7c%2BY35LtqJy9INGlcQ9Z6gn3nOrI%3D&amp;reserved=0
> 
> Thanks for the pointer and for taking a stab at this approach (hadn't
> realized you were looking into this so sorry for the overlap with your
> code).
> 
> > as I got this suggestion from Erdem Aktas(erdemaktas@google) while
> > discussing about executing guest code from private fd.
> 
> The way we way have the host patches implemented currently is sort of based
> around the idea that userspace handles all private/shared conversion via
> allocations/deallocations from the private backing store, since I
> thought that was one of the design goals. For SNP that means allocating a
> page from backing store will trigger the additional hooks in the kernel needed
> to do some additional bookkeeping like RMP updates and removing from directmap,
> which I'm doing via a platform-specific callback I've added to the KVM memfile
> notifier callback.
> 
> There was some talk of allowing a sort of pre-boot stage to the
> MFD_INACCESSIBLE protections where writes would be allowed up until a
> certain point. The kernel hack to allow pwrite() was sort of a holdover
> for this support.
> 
> Handling pre-population as part of SNP_LAUNCH_UPDATE seems sort of
> incompatible with this, since it reads from shared memory and writes
> into private memory.

Well, no, it wouldn't be, since your code handles it the same way as
mine, where kvm_private_mem_get_pfn() allocates a page, but doesn't
generate a notifier event, so you can defer things like RMP updates
until after the memory is populated. So this might be a reasonable
approach as well. But still worth exploring if a more general KVM ioctl
is the better approach.
