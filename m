Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06604438E54
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 06:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJYEbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 00:31:42 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:51838
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229678AbhJYEbl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 00:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rwjr7NLs7YKhsAkImTa9et5hG7nHL7opx+peuMKRfRKhTm+7NZZnUib+cv5ZiwGvIF6lmbWzQBjZgPwbYzoOkk0bgLBftGOu2AkzZ68RfMxTr4OxkZiPBPmjra5OY8iknCMjF0UKqD5TCA6i8s+VuRInCihKpxdEpBROkitxwM5Cm+OpQBvPb7y/ccVlXl4zfTGvfNksZdzX6ZfIy7XkpCQ5hRKfnUnzil8OEDY/5+b66MNic3yXIQIAL1k/SIkzfdc7jFAXhYh3zCH9vh2ywzGZ5HkZriJZTjoeXGRudhXGYa62hV2HKZxkD7tirx2mvjXHd1sx2m4ZnjcWvNZZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFQwzCUUi4Ow62H9r3xNbMMCshyv917I+iABjFSkjx8=;
 b=UEMT9oS5sin2ouSYzgx2dnMEeJqTHtl9VXjP2Bsdxaa3itxxdps4NCGiP2By1CKHDcC37Iafg1n6RGcGL9Ix8Bx635Srs7rkO0tv9N0m9IUcXrxmth571CsOUrWrYmis46CImcmmqCbQeyyRKD1zWcJXmYgejvzXJZ6/4IHqLDapuRpbMy/HfXHVJpac7h3SIt2KnEyrj1uq35PdWoVvnDuS0iK76vAqoxU4DWJ1ms9ERMwsKA5+FLS3dGlcKLCASa0TDACRD4GGegPXZMeyqs6ZgU/LR7ZYoABmpF3zomMLYaonetjYjkw77SexXl2xWD5V9WIVyI3Q4If+KOEwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFQwzCUUi4Ow62H9r3xNbMMCshyv917I+iABjFSkjx8=;
 b=ZFB3+bWyYvqoXE/M0M+WVOrlp24CKiR98QPJM/U95GndFLjPDeunfcAyyTEKhk2j9+KhU7rcNSTdWGwm/spV2OAu6mlrQLRx2MYdU4ltwJGX8zjGF8cvvSTL3Z2+bA/syPdO48KTZ8kpWxc0qgA9tyPQwnLtpxs6RBS6fxLZwvo=
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 04:29:14 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::99) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 04:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 04:29:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 23:29:08 -0500
Date:   Sun, 24 Oct 2021 11:49:45 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Mingwei Zhang" <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 03/16] KVM: selftests: handle encryption bits in page tables
Message-ID: <20211024164945.mt62qjrld3dwssv4@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-4-michael.roth@amd.com>
 <31db4c63-218a-5b26-f6ed-d30113f95e29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31db4c63-218a-5b26-f6ed-d30113f95e29@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d10289-8d23-4b7a-cf8c-08d99770002b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5314:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53146C76A94CDFE474C304AF95839@CH0PR12MB5314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PzfePc2g/d50Vxu7KZ9VtM1AGn1gSB2AjhcMjxLPWGhaiw6nIZPrCUf0f1t2MK2Y6OmW08JZQ7rTqNsiq543BUffNYQ+i5G8bnosVGLSYZF+jkJeo8PY0jW06SjpvQTL6ZKCAbSDJ9UusJPhjmlC38ZEGEydEieHkx6up0L5cZ9nn1Zvzs6r7rGzpPMl3bjpmIEX9UBCuoTr9Eg4UhgLyyvpg2QFCfNN5JO8WhgNxrMUqLTxHVlz4grXOgurqNFPyDJDZCvCv1hrO8UaOVh3aA/IWW8ivVsBz1cwEyAO2W/L/8my0KH68GXzbsDYlpPFxKAIfijXoSFe+XA3FrBa0uG2sWzVLwTe8WV2dHU0G/45Bdqbufia758rseMsR9cFfr4p7dk+WaKcFVPvTWyk6PblsSPcGHTQaaLpsn3045de5tDe5l3HLQ7gCnzG0D22rxBq3V3HnmUQNX+b7MSRtScXUqzyl7NU9S47Xbjzgw6U7grEBoJIg9e11hF0S0oXLspLv6r3GqU4fazhuHt1S9DnXYdTTyZ8FcmzOtMKlffnssWfElj0e+fPzJPO4GxjOZDEdTLO8toChBFzzZYRE/QiaiDz7hJpMzWf/ozihxJ3TlVVfssCZ8OD3/qxBo4XIlGNVMwD+FzMeE5rvaI8z+C8I+izePxaB690AL5ovFsUjz4+3XfQs5EW0FkijAQ2pjnuf7NALBB+vpNpdtrNBdchm6L11eih+AcJt1sy3I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(6666004)(70586007)(508600001)(53546011)(83380400001)(36756003)(4326008)(36860700001)(54906003)(356005)(2616005)(86362001)(8676002)(81166007)(186003)(336012)(2906002)(5660300002)(16526019)(8936002)(26005)(44832011)(426003)(316002)(47076005)(1076003)(82310400003)(6916009)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 04:29:14.3179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d10289-8d23-4b7a-cf8c-08d99770002b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 05:26:26PM +0200, Paolo Bonzini wrote:
> On 06/10/21 01:44, Michael Roth wrote:
> > SEV guests rely on an encyption bit which resides within the range that
> > current code treats as address bits. Guest code will expect these bits
> > to be set appropriately in their page tables, whereas helpers like
> > addr_gpa2hva() will expect these bits to be masked away prior to
> > translation. Add proper handling for these cases.
> 
> This is not what you're doing below in addr_gpa2hva, though---or did I
> misunderstand?

The confusion is warranted, addr_gpa2hva() *doesn't* expect the C bit to
be masked in advance so the wording is pretty confusing.

I think I was referring the fact that internally it doesn't need/want the
C-bit, in this case it just masks it away as a convenience to callers,
as opposed to the other functions modified in the patch that actually
make use of it.

It's convenient because page table walkers/mappers make use of
addr_gpa2hva() to do things like silently mask away C-bits via when
translating PTEs to host addresses. We easily convert those callers from:

  addr_gpa2hva(paddr)

to this:

  addr_gpa2hva(addr_raw2gpa(paddr))

but now all new code needs to consider whether it might be dealing with
C-bits or not prior to deciding to pass it to addr_gpa2hva() (or not
really think about it, and add addr_gpa2raw() "just in case"). So since
it's always harmless to mask it away silently addr_gpa2hva(), the
logic/code seems to benefit a good deal if we indicate clearly that
addr_gpa2hva() can accept a 'raw' GPA, and will ignore it completely.

But not a big deal either way if you prefer to keep that explicit. And
commit message still needs to be clarified.

> 
> I may be wrong due to not actually having written the code, but I'd prefer
> if most of these APIs worked only if the C bit has already been stripped.
> In general it's quite unlikely for host code to deal with C=1 pages, so it's
> worth pointing out explicitly the cases where it does.

I've tried to indicate functions that expect the C-bit by adding the 'raw_'
prefix to the gpa/paddr parameters, but as you pointed out with
addr_gpa2hva() it's already a bit inconsistent in that regard, and there's
a couple cases like virt_map() where I should use the 'raw_' prefix as well
that I've missed here.

So that should be addressed, and maybe some additional comments/assertions
might be warranted to guard against cases where the C-bit is passed in
unexpectedly.

But I should probably re-assess why the C-bit is being passed around in
the first place:

 - vm_phy_page[s]_alloc() is the main 'source' for 'raw' GPAs with the
   C-bit set. it determines this based on vm_memcrypt encryption policy,
   and updates the encryption bitmask as well.
 - vm_phy_page[s]_alloc() is callable both in kvm_util lib as well as
   individual tests.
 - in theory, encoding the C-bit in the returned vm_paddr_t means that
   vm_phy_page[s]_alloc() callers can pass that directly into
   virt_map/virt_pg_map() and this will "just work" for both
   encrypted/non-encrypted guests.
 - by masking it away in addr_gpa2hva(), existing tests/code flow mostly
   "just works" as well.

But taking a closer look, in cases where vm_phy_page[s]_alloc() is called
directly by tests, like set_memory_region_test, emulator_error_test, and
smm_test, that raw GPA is compared to hardcoded non-raw GPAs, so they'd
still end up needing fixups to work with the proposed transparent-SEV-mode
stuff. And future code would need to be written to account for this, so
it doesn't really "just work" after all..

So it's worth considering the alternative approach of *not* encoding the
C-bit into GPAs returned by vm_phy_page[s]_alloc(). That would likely
involve introducing something like addr_gpa2raw(), which adds in the
C-bit according to the encryption bitmap as-needed. If we do that:

  - virt_map()/virt_pg_map() still need to accept 'raw' GPAs, since they
    need to deal with cases where pages are being mapping that weren't
    allocated by vm_phy_page[s]_alloc(), and so aren't recorded in the
    bitmap. in those cases it is up to test code to provide the C-bit
    when needed (e.g. things like separate linear mappings for pa()-like
    stuff in guest code).

  - for cases where vm_phy_page[s]_alloc() determines whether the page
    is encrypted, addr_gpa2raw() needs to be used to add back the C-bit
    prior to passing it to virt_map()/virt_pg_map(), both in the library and
    the test code. vm_vaddr_* allocations would handle all this under the
    covers as they do now.

So test code would need to consider cases where addr_gpa2raw() needs to be
used to set the C-bit (which is basically only when they want to mix usage
of the vm_phy_page[s]_alloc with their own mapping of the guest page tables,
which doesn't seem to be done in any existing tests anyway).

The library code would need these addr_gpa2raw() hooks in places where
it calls virt_*map() internally. Probably just a handful of places
though.

Assuming there's no issues with this alternative approach that I may be
missing, I'll look at doing it this way for the next spin.

Even in this alternative approach though, having addr_gpa2hva() silently
mask away C-bit still seems useful for the reasons above, but again, no
strong feelings one way or the other on that.

> 
> Paolo
> 
> > @@ -1460,9 +1480,10 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
> >    * address providing the memory to the vm physical address is returned.
> >    * A TEST_ASSERT failure occurs if no region containing gpa exists.
> >    */
> > -void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
> > +void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa_raw)
> >   {
> >   	struct userspace_mem_region *region;
> 
