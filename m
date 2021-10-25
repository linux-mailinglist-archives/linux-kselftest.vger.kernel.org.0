Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F0438E58
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 06:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJYEcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 00:32:01 -0400
Received: from mail-sn1anam02on2089.outbound.protection.outlook.com ([40.107.96.89]:62965
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232316AbhJYEb5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 00:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Q2NjZPcb+IYsH9FKfrOn7aSuWNvrJaUcwnwhWN5E6Dj+2jffr4t08Vv5E23kjR4CjmdlpD8CBMVwQVu7UwCOStDWPj5aBfAKJUlFkR3ds/ZIvzrl5xnjRMwlkHSXUcQ3bnQJNXtZirwUG62mNPP6sktNolugnGBQLEzkn/60t4tJZwv/QZIv3bBcqiwq/tkrnB3jC68rRuou2ti/kUIx1wBy712NeEBYMtVVLN3eHAIR6USiAq2odHe5qEa9q4pu9ypcL2w7GrJWcGqPxX17ar9IIyljPYohR+FpTY+iHtRyuU8M7uXSs2rCSkDAl8DsFB2cmtQ2PhRJkGv9xISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGtUfCTZaYYZl2wlbw+mnvmyA/397jLgJ/kFpw6dh2A=;
 b=ZdW8sVAzZLdua1DTscNzqBM74Ck1qlF8K/Jpky76wzm24XtAGTQcFzTn/JdbjEHMIRMcHKL/DFri/YPrN57zuMdA4ADAPY9r9PQsCMj60JT7xhzf0NN8nCttZDd9KM0gqYYKrQCcSJujlviyAChU/aqIZrsAVkTQFFSlX+NdDeqgDxbqSj9avYixpS4C1hj0VZOIkBsa3NOpSQC/JIe4LJjClUbrtdqXL8lav6MVxPE9w4Cum0SYakbMZo6RqL/LMbxf3ulnutzr7jd9QB+FaGrumO/wHHoOU0jgPxxQkDcRlo4qLHL9visqbdgsoQ6s86ymg5XNVQi7kQYqsJMtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGtUfCTZaYYZl2wlbw+mnvmyA/397jLgJ/kFpw6dh2A=;
 b=niSa6rrpC0kU0Ikg5oDic9QJimntnhtWw+osPgHPmpON2K4hDZwyGxx1GcAxPaAfWwIP01TdM2pKYQDoeJVgnMxh0QulOEFjIUY90HepXFG95gtU2nVc3LovAt8pZTGj2JGF/sKQ897C+oXi9pXzY0K+YGcuP+GnuWsCdgc/yVI=
Received: from MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) by CH2PR12MB3671.namprd12.prod.outlook.com
 (2603:10b6:610:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 04:29:31 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::f1) by MWHPR2001CA0012.outlook.office365.com
 (2603:10b6:301:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 04:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 04:29:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 23:29:29 -0500
Date:   Sun, 24 Oct 2021 22:58:33 -0500
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
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
Message-ID: <20211025035833.yqphcnf5u3lk4zgg@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203710.13326-1-michael.roth@amd.com>
 <80a69f94-23ca-3ca9-4c77-14e09683dc7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80a69f94-23ca-3ca9-4c77-14e09683dc7d@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64c6624-e1f9-43af-f890-08d9977009d0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3671:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3671674ED9CE4434FF9A98D395839@CH2PR12MB3671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKH677WRuXAgU71BxXxQWgBY28jicXlR5ZReV5H3Syyh1kdtq+tci+eQ47mqA5VFNRrkobvcBTApn18VD+VebThWh+l30Y+HHtHERPx19kkToNTztod4fdp295C7Ac4NCKyrrodDcVX7pkeciGC5rH05z6G8nlQhdwkDWCcnbfkZbEvxYXzli/G2aQ1oyiEN5myf4C0whEk08UWNGQcbwu+r9o77H2YgXElofWW+5DJI8y0Vg3FewnAQ304mFv3a30hl0xYh7Pcb88sN4Hs8agYLinMbcSU2Q1I9zFYlh2sNRiIumGkOjfRI/JGqCKtojOuXaoRIhA9yPVY2/kpSRYlJrYK3B1/IA9pe8qcdflE26zRU6ca5jJCsIze0j4WY2XiOgOZ1rWGLI8K3ymQQCtyzU3xqSNwmZwY9+Cg01/aVTdFWyO8DN0Wj81C19yjn8zYhKMoqDS5opBApyo8UueThGjEl0vtkPxd47EzOMFdYX89RBIMJ6ZZzQzy1kksRM1bPV/1iMWzpuHzKRG0L98xMsYJARuZFC/17MVnvA+thEf6nYJaHP4ujrkzCYh6Q4g1HDTHT5aQXW8nANg3F2hPeSL3es9wlmnX0MHI7JmBVEbqe+3MHtcap06TEXZKodLIqs3mk2gwWlHVWl28cIDCJ/gY8+KKC8qVcglaWoDSD8lnKkSIKyq0U9CzXXtUq/av6eV/FSV1qtVIVhIOdlwQBs8ksnqBdD3ck5DM7Rg0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(1076003)(81166007)(356005)(70206006)(70586007)(8676002)(2906002)(336012)(508600001)(8936002)(44832011)(6666004)(5660300002)(4326008)(26005)(2616005)(16526019)(316002)(86362001)(186003)(82310400003)(36756003)(36860700001)(7416002)(426003)(47076005)(54906003)(6916009)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 04:29:30.4928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64c6624-e1f9-43af-f890-08d9977009d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3671
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 05:39:34PM +0200, Paolo Bonzini wrote:
> On 06/10/21 22:37, Michael Roth wrote:
> > +struct sev_sync_data {
> > +	uint32_t token;
> > +	bool pending;
> > +	bool done;
> > +	bool aborted;
> > +	uint64_t info;
> > +};
> > +
> 
> Please add a comment explaining roughly the design and what the fields are
> for.  Maybe the bools can be replaced by an enum { DONE, ABORT, SYNC,
> RUNNING } (running is for pending==false)?

That makes sense. And SYNC is basically pending==true.

Though since it would be the test code calling sev_check_guest_sync() that
sets pending to true after each sync, "RUNNABLE" might be a better name
since whether it's actually running depends on a separate call to
vcpu_run().

> 
> Also, for the part that you can feel free to ignore: this seems to be
> similar to the ucall mechanism.  Is it possible to implement the ucall
> interface in terms of this one (or vice versa)?
> 
> One idea could be to:
> 
> - move ucall to the main lib/ directory
> 
> - make it use a struct of function pointers, whose default implementation
> would be in the existing lib/ARCH/ucall.c files
> 
> - add a function to register the struct for the desired implementation
> 
> - make sev.c register its own implementation

That seems doable. We'd also need to register an opaque pointer that, in the
case of SEV, would be for the shared page used for syncing. The guest would
also need the pointers for the ops/opaque, but ucall_init() could
additionally set some globals to provide the GVAs for them in the guest
environment.

Will look at that for the next spin.

> 
> Thanks,
> 
> Paolo
> 
