Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D37435983
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 05:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhJUDuG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 23:50:06 -0400
Received: from mail-dm6nam08on2079.outbound.protection.outlook.com ([40.107.102.79]:36576
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231612AbhJUDta (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 23:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUfAJxT49IZ8+4FaqbC02lZCac0nyApbniR9r9ctnTdEfye8xoxHF/0ZXsdKeDpM7oaCPZVhB0j9JWhcKmVxCaXmMZHs9x53U1zFukKln7U+W40a7NulnqXypF2KJmZXdHvery4ZfnU9igiYfwMvkZ2JwudKs9zo11jw92ZnNHrumfAOutHQtwAx1n/VVtopTAJtc8vQNBwjVH/5R2VGVD69vsf6yFkqJIAct0s8j3VtYelLZWNj0TUgjY4tr+r2H4ceivLKwQkaLDp9Cs05QaPl2O6ETwltsvqNezmGu5t1yrskPDzlrX+ojCRcZsEvfN00wEkh7REbybxl1S775w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0iTruFr2fkzx7N+E+Ny2DK1Os/7WXVlDpRRRyJ+sIg=;
 b=RjgVIzzxPwBOzFvxT69F3tIUI4ZHJxyI6GIFud3lyEaprfZeB3uSRlYGvng9R2dLJ27pFOnPDTafoR43ZT/We7owk7QdOe0O3oG8p2ue453SZDQsIVAUNkM3kyV9YMssJpBcw0VTDxkX8Ftqgf6+QB3BV4X4Mpm5tkqI4rMMbqmsTXH3YvCYHOzH1qYzYPZaNYhFeix56iZ5//syjpDxTuysOwnsC2Pc5nJ3F66HF6ywcEaFOaEZ7LEFPkt1gY0Mng5YPBG/R64QthJheHDQJcCdtTsM8AvD56PiaAb4qqOe6ZmHMHHLJMldWL+Ckcd4ag9jMG5xwoii4wOh2yb8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0iTruFr2fkzx7N+E+Ny2DK1Os/7WXVlDpRRRyJ+sIg=;
 b=RBvhC500bMYcWgEZ+FkhXUVx0td6DokW/d5tYpdUe9Q92HyM/rEUp8VDE14HOC7z1ZRPhavKOo49/xyNJzmDA+tvFYo75cr6Z6HaH0vmxBYG3t50uLELFgSMyGhHcIhwl36iOWPwHOCjSeJklvVKhSVtrP/TYL9xQZmYTgwUoVs=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by MN2PR12MB3182.namprd12.prod.outlook.com (2603:10b6:208:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 03:47:11 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::82) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 03:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 03:47:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 22:47:08 -0500
Date:   Wed, 20 Oct 2021 22:45:29 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Mingwei Zhang <mizhang@google.com>
CC:     <linux-kselftest@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Varad Gautam" <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Ricardo Koller" <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 01/16] KVM: selftests: move vm_phy_pages_alloc() earlier in
 file
Message-ID: <20211021034529.gwv3hz5xhomtvnu7@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-2-michael.roth@amd.com>
 <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a55ce423-2f24-4b33-fbff-08d9944575a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3182:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3182174E0F60FB3958FBEBB895BF9@MN2PR12MB3182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7BFIXCPQG2v2It5GwG+xBwnR7gglRvItyRiBIRzTRkTkiVs2OrjK+pp37YpDSR+aDuB0/Y370vIN4y/CdBU7YcgVefeQN0JAQ4GPbZ3WwksUWojHKHGyXpJJ07qY2JrRn5UQDXJtBytEBmBuxQICZI4QOJRRxFcP0uoZMmA3vntu2pvk8fnHJ0cWavvTFQpzWmRcyOISIn8aH928t50JTYjTeEhYvC7kFvyjfG+d+ybbEwskvWu4KjYGXSkmOq4QoJrdqVul3or2OuL4uRDkJ8ei1i6Ypz4jKip7rWS2I++CKYUxxaI1uiHvEBOnvqQ2PHz+Yjc3y1DyCPBxhzhQdtodaThNDVOYbKXaGBywXMl0M5q5V6GN48Ahod53bDL07gTCR98beoJmECp+ggAIT28VvZCrtucxICO2fiGBhz6zdiaZ/wJEuINrpKEUGj4tGG0gYD6ji4CR58XJneYz7Ga1+5R7ntis+ACwz0x4XbOt+mmFsTqL8vLNZ6SGxX36fff8dvvk7Y2nt/6utCJIS2HkDhpN5KNDXiGuFe1Bx1rBm6t3Sf+8SwSg5tXD742a+41sXRH+8+tUofYdAUS5TaVOF7l/eeqtBag37H063x5O7mJ2FrncpaSrKQgTAe0uAc2SlYGO+1zwUPhhy6qAbwUzFBq+28xx4k+olYh/VrjMGz++pEcoATeQckV+wFMbJHCk4lC9r4tVW85qbQheMQy/TmqGYneMPI7YTYhpn0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(81166007)(6666004)(26005)(36756003)(86362001)(82310400003)(36860700001)(2616005)(53546011)(70206006)(8936002)(70586007)(44832011)(2906002)(7416002)(336012)(8676002)(47076005)(426003)(4326008)(54906003)(186003)(356005)(83380400001)(316002)(1076003)(5660300002)(16526019)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 03:47:09.5774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ce423-2f24-4b33-fbff-08d9944575a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 18, 2021 at 08:00:00AM -0700, Mingwei Zhang wrote:
> On Tue, Oct 5, 2021 at 4:46 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > Subsequent patches will break some of this code out into file-local
> > helper functions, which will be used by functions like vm_vaddr_alloc(),
> > which currently are defined earlier in the file, so a forward
> > declaration would be needed.
> >
> > Instead, move it earlier in the file, just above vm_vaddr_alloc() and
> > and friends, which are the main users.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 146 ++++++++++-----------
> >  1 file changed, 73 insertions(+), 73 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 10a8ed691c66..92f59adddebe 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1145,6 +1145,79 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
> >         list_add(&vcpu->list, &vm->vcpus);
> >  }
> >
> > +/*
> > + * Physical Contiguous Page Allocator
> > + *
> > + * Input Args:
> > + *   vm - Virtual Machine
> > + *   num - number of pages
> > + *   paddr_min - Physical address minimum
> > + *   memslot - Memory region to allocate page from
> > + *
> > + * Output Args: None
> > + *
> > + * Return:
> > + *   Starting physical address
> > + *
> > + * Within the VM specified by vm, locates a range of available physical
> > + * pages at or above paddr_min. If found, the pages are marked as in use
> > + * and their base address is returned. A TEST_ASSERT failure occurs if
> > + * not enough pages are available at or above paddr_min.
> > + */
> > +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > +                             vm_paddr_t paddr_min, uint32_t memslot)
> > +{
> > +       struct userspace_mem_region *region;
> > +       sparsebit_idx_t pg, base;
> > +
> > +       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > +
> > +       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > +               "not divisible by page size.\n"
> > +               "  paddr_min: 0x%lx page_size: 0x%x",
> > +               paddr_min, vm->page_size);
> > +
> > +       region = memslot2region(vm, memslot);
> > +       base = pg = paddr_min >> vm->page_shift;
> > +
> > +       do {
> > +               for (; pg < base + num; ++pg) {
> > +                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > +                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > +                               break;
> > +                       }
> > +               }
> > +       } while (pg && pg != base + num);
> > +
> > +       if (pg == 0) {
> > +               fprintf(stderr, "No guest physical page available, "
> > +                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > +                       paddr_min, vm->page_size, memslot);
> > +               fputs("---- vm dump ----\n", stderr);
> > +               vm_dump(stderr, vm, 2);
> > +               abort();
> > +       }
> > +
> > +       for (pg = base; pg < base + num; ++pg)
> > +               sparsebit_clear(region->unused_phy_pages, pg);
> > +
> > +       return base * vm->page_size;
> > +}
> > +
> > +vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > +                            uint32_t memslot)
> > +{
> > +       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > +}
> > +
> > +/* Arbitrary minimum physical address used for virtual translation tables. */
> > +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > +
> > +vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > +{
> > +       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > +}
> > +
> >  /*
> >   * VM Virtual Address Unused Gap
> >   *
> > @@ -2149,79 +2222,6 @@ const char *exit_reason_str(unsigned int exit_reason)
> >         return "Unknown";
> >  }
> >
> > -/*
> > - * Physical Contiguous Page Allocator
> > - *
> > - * Input Args:
> > - *   vm - Virtual Machine
> > - *   num - number of pages
> > - *   paddr_min - Physical address minimum
> > - *   memslot - Memory region to allocate page from
> > - *
> > - * Output Args: None
> > - *
> > - * Return:
> > - *   Starting physical address
> > - *
> > - * Within the VM specified by vm, locates a range of available physical
> > - * pages at or above paddr_min. If found, the pages are marked as in use
> > - * and their base address is returned. A TEST_ASSERT failure occurs if
> > - * not enough pages are available at or above paddr_min.
> > - */
> > -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > -                             vm_paddr_t paddr_min, uint32_t memslot)
> > -{
> > -       struct userspace_mem_region *region;
> > -       sparsebit_idx_t pg, base;
> > -
> > -       TEST_ASSERT(num > 0, "Must allocate at least one page");
> > -
> > -       TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
> > -               "not divisible by page size.\n"
> > -               "  paddr_min: 0x%lx page_size: 0x%x",
> > -               paddr_min, vm->page_size);
> > -
> > -       region = memslot2region(vm, memslot);
> > -       base = pg = paddr_min >> vm->page_shift;
> > -
> > -       do {
> > -               for (; pg < base + num; ++pg) {
> > -                       if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
> > -                               base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
> > -                               break;
> > -                       }
> > -               }
> > -       } while (pg && pg != base + num);
> > -
> > -       if (pg == 0) {
> > -               fprintf(stderr, "No guest physical page available, "
> > -                       "paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
> > -                       paddr_min, vm->page_size, memslot);
> > -               fputs("---- vm dump ----\n", stderr);
> > -               vm_dump(stderr, vm, 2);
> > -               abort();
> > -       }
> > -
> > -       for (pg = base; pg < base + num; ++pg)
> > -               sparsebit_clear(region->unused_phy_pages, pg);
> > -
> > -       return base * vm->page_size;
> > -}
> > -
> > -vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > -                            uint32_t memslot)
> > -{
> > -       return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
> > -}
> > -
> > -/* Arbitrary minimum physical address used for virtual translation tables. */
> > -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
> > -
> > -vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
> > -{
> > -       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
> > -}
> > -
> >  /*
> >   * Address Guest Virtual to Host Virtual
> >   *
> > --
> > 2.25.1
> >
> 
> Why move the function implementation? Maybe just adding a declaration
> at the top of kvm_util.c should suffice.

At least from working on other projects I'd gotten the impression that
forward function declarations should be avoided if they can be solved by
moving the function above the caller. Certainly don't mind taking your
suggestion and dropping this patch if that's not the case here though.
