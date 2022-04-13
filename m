Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461934FF80E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiDMNqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDMNqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 09:46:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A965FF0F;
        Wed, 13 Apr 2022 06:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc0gx4SsbMqSP4fkKFOlE774+rOzwZCL2j49V5/iQg685FNRrBy8/N4pBe8uQayRfmNCOS7y0iOyT5TMlL0qxHpc7lDpWBR7U7sSHYjPPr4m5JVfSiWM5wVg/zQQEIhVO70eHIJIqIwsahSzayRcBnD3/XPosy5OI6go3lrUVDytQPy0ifzU2kh7q1vV/FFR0G/mfn4PHeyxavXRiTt0N6Hg3/XtnF7kPb2mafSFxJbHAw431ClYsVl2a7Ma4SsvtSZMij22CtCYcJTE/FDWaaM3jg+VBDS9Ln7X2VQWfEt4XTrg07NBh4vfjKfElsMMRCD9GXYIsNFzPaB2G1Wsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUgyCqf9jjQVsK6031CBO3ppBfaESuzFT6nqxW2dt2M=;
 b=ll7FNcjX+/Uo6Ih46WRZoTRQK6wuTfX47iVvQqYgCrgtKZ830bhqATfxKSGpZI5a0k5cjlOZmO/n60h7fey920+nRQVLl9Y/LxDiLSKZj+I5q1SK6XD4MRDxpbDFNFz6wT+KcJ9XB4j032HhDfA93brKHSvhfF78PZ1kFFroDzn/F7lRhtclVXH2H9Jr9t1/NDULRUr4cMca7BvNTZfN/JZEEOwUA6LzsAZVU2C7Ujk1EbHqQTPuuu0HNirRBzALQ6vBGrsGxDkbEbfcXm+2791gygWBQBcLV8e1dABGJVNLRbANHccYSDgvb5Mau94I6sGKT1rhdJYcc1Lhhm5qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUgyCqf9jjQVsK6031CBO3ppBfaESuzFT6nqxW2dt2M=;
 b=3wf5qAtBY1v1p+/K1Sabge/qSYXYW8Q1RCjKePKlt6MYfD7X7ztdYHQnf7wGY46y5rrcqeA0e5NWpmReQxraTsegz1W/uQwTbmyMQDTrzOrZ1y0Vg4rvqGGXDBubm+VuUdOeG/XZkGMMJRkfqHMvys6EHK+O1+IKia8kFQ8dj6o=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by BY5PR12MB4002.namprd12.prod.outlook.com (2603:10b6:a03:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 13:44:08 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::3) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 13:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 13:44:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 08:44:06 -0500
Date:   Wed, 13 Apr 2022 08:42:00 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Vishal Annapurve <vannapurve@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <shauh@kernel.org>,
        <yang.zhong@intel.com>, <drjones@redhat.com>,
        <ricarkol@google.com>, <aaronlewis@google.com>,
        <wei.w.wang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
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
        Sean Christopherson <seanjc@google.com>, <diviness@google.com>
Subject: Re: [RFC V1 PATCH 0/5] selftests: KVM: selftests for fd-based
 approach of supporting private memory
Message-ID: <20220413134200.ms5lscs7lvvih7a5@amd.com>
References: <20220408210545.3915712-1-vannapurve@google.com>
 <e8a4cac5-bc5a-4483-9443-c0e5b9f707d1@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8a4cac5-bc5a-4483-9443-c0e5b9f707d1@www.fastmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d9c6f4-dcdc-4270-7fc8-08da1d53ae9b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4002:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4002AC22F31C0EF842A40D1695EC9@BY5PR12MB4002.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qcac+kkG/XGa5DTui9rPym6+VcsFLQaRQ63SBOLbOYdBftOduFCG58SzPOdKgnXpcJplAifahUrNjK5r9CtvUWPY9rpTUECxxnxpjxiS15x+F1wfJf2X1abOhHzWVIT25w431ex5A8UZmLPtr3Zywt1D0y8oj7NAh6asxiRIrLuXBaNLixAmCSgfy8OMNw9LtHr2t03csxgmKK/fWnBP6y8h180zFNkSRYEb6jrEvPY1bnR1E80/nfQhkCbZiMlLtunLwrA0GsO1a1vbuH2vX/bQT9JpsBacbAldtK2M1ZcyLuV3Q1uLKykue9eIUPTIg+s20OV/4pL/XdIgbNIGqbT/tmIbElSa6K7k8yJpva9Ol0znwTDG/oWOHkr2ztcKgN3l6F7YHWtq5WJ8mS2mdBlyuduvYIJE7taUavmaruYquibETA80GBYQjVM3Bq19hSUYUjMMo5iYDQ5hIYnQsxGxn0e8VI6BhrxxuhLvEvfec57QPt7s2trInPATcSDTflfKBqFrQKoNLPOj4nUrEFTMiGnDdd4V6KRqdmr/qZmlkoLQaVN+1Kx/8YRDJBYW1H2tZNH5y9tIW9NElhyXCzYKiz+svZQ91wx0FRVDYIZJA2RIAPS60BCRfzTOuzZkZNY841g+H3hL3g4kTKBNHfCSpjgTq1EqhZ7tC1MjePQLcNJbab+xgYnNfey3n98hpJmRr9sKIzm8B8W8aDxY8D0y5wXyPnWXxlyFrhKe197RV26PWDKZATyRlJG1SPZokF1QD9AMhVbErhe97Yhn0HUMZBY9nY+LFtJ+G4iiCEnQSyqixnsHSYJ4B5FXYnHWVQwmyqOrqIyNlfYWdJi+Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(426003)(82310400005)(2906002)(81166007)(36756003)(966005)(86362001)(5660300002)(336012)(508600001)(83380400001)(4326008)(8676002)(40460700003)(36860700001)(316002)(6666004)(47076005)(2616005)(8936002)(7416002)(356005)(70586007)(54906003)(70206006)(6916009)(44832011)(1076003)(186003)(26005)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 13:44:07.4638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d9c6f4-dcdc-4270-7fc8-08da1d53ae9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 12, 2022 at 05:16:22PM -0700, Andy Lutomirski wrote:
> On Fri, Apr 8, 2022, at 2:05 PM, Vishal Annapurve wrote:
> > This series implements selftests targeting the feature floated by Chao
> > via:
> > https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> >
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
> 
> This is fantastic.  I do think we need to decide how this should work in general.  We have a few platforms with somewhat different properties:
> 
> TDX: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  In principle, the same address could be *both* and be distinguished by only that bit, and the two addresses would refer to different pages.
> 
> SEV: The guest decides, per memory access (using a GPA bit), whether an access is private or shared.  At any given time, a physical address (with that bit masked off) can be private, shared, or invalid, but it can't be valid as private and shared at the same time.
> 
> pKVM (currently, as I understand it): the guest decides by hypercall, in advance of an access, which addresses are private and which are shared.
> 
> This series, if I understood it correctly, is like TDX except with no hardware security.
> 
> Sean or Chao, do you have a clear sense of whether the current fd-based private memory proposal can cleanly support SEV and pKVM?  What, if anything, needs to be done on the API side to get that working well?  I don't think we need to support SEV or pKVM right away to get this merged, but I do think we should understand how the API can map to them.

I've been looking at porting the SEV-SNP hypervisor patches over to
using memfd, and I hit an issue that I think is generally applicable
to SEV/SEV-ES as well. Namely at guest init time we have something
like the following flow:

  VMM:
    - allocate shared memory to back the guest and map it into guest
      address space
    - initialize shared memory with initialize memory contents (namely
      the BIOS)
    - ask KVM to encrypt these pages in-place and measure them to
      generate the initial measured payload for attestation, via
      KVM_SEV_LAUNCH_UPDATE with the GPA for each range of memory to
      encrypt.
  KVM:
    - issue SEV_LAUNCH_UPDATE firmware command, which takes an HPA as
      input and does an in-place encryption/measure of the page.

With current v5 of the memfd/UPM series, I think the expected flow is that
we would fallocate() these ranges from the private fd backend in advance of
calling KVM_SEV_LAUNCH_UPDATE (if VMM does it after we'd destroy the initial
guest payload, since they'd be replaced by newly-allocated pages). But if
VMM does it before, VMM has no way to initialize the guest memory contents,
since mmap()/pwrite() are disallowed due to MFD_INACCESSIBLE.

I think something similar to your proposal[1] here of making pread()/pwrite()
possible for private-fd-backed memory that's been flagged as "shareable"
would work for this case. Although here the "shareable" flag could be
removed immediately upon successful completion of the SEV_LAUNCH_UPDATE
firmware command.

I think with TDX this isn't an issue because their analagous TDH.MEM.PAGE.ADD
seamcall takes a pair of source/dest HPA as input params, so the VMM
wouldn't need write access to dest HPA at any point, just source HPA.

[1] https://lwn.net/ml/linux-kernel/eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com/
