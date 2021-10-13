Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912F642C477
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhJMPJt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 11:09:49 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:50561
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhJMPJt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 11:09:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2n2c6nZZC/PbG+om6T2cYxJFjZe/pYESS/UsTkTQQ/U/dRUlakVlTqMn2lMqpgiQddWROuKoX8FHt44ryNs60oLoflHywXEtNZ1VUXkKF0M5V7gqcdcopmyjqeUeul8Dwztg9m9NnmioCsK3f6977R8DteC8TanK8R3FCzQq/n3ws1o8j4NxHQLyqEiGN+owM6x9tLNTscFiMpasz0720ODE+Hxedm5MDuJ6z+UshB8fSy279xk1nX62eFeKtb9PsEa/9TKVTBgjIsUOlBKXowvgHQk6GK6vnacBvDW6mH0DB6AsK7hpxRqGtieyjx3x+/3uURMbFtiWW49SMP4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ldgZxIAWC3AODXWTE0fGjkQfgmAICNqyRyDoxCEyUE=;
 b=PiMLCwqN5uR15+Pxj7L2jwTy/Pc0F+9mskgY7xmKR7Dl5nfNoqYNsQtS9/+uUwn+/uHY7JQxeHJ+OKoL36nBiqDzbe5c/d3VWubbupCrn/aUyBksZNYq/8x2uTQPFOpXi05iR+FIZpREzO/Wc0dHPG6yZlDHFP2mTph+UMjX26aUeXgIIo02SKrxVjj18SDGkHg9l7BLCXE1FBu53yuPF8drBvUQl1X8YdfRiEAqBKk9B3lzlmRzQUlxDRtI3IVpPForw5rFI/Dz4sggtcG9K8iTlKNgiOAIvzIsYNsmDFgzirc2VMRsr9WPWggIhuVWrabE8gVWx41SaWKjh9P7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ldgZxIAWC3AODXWTE0fGjkQfgmAICNqyRyDoxCEyUE=;
 b=x40ZCwBYGcG8QsItYp4AKtxzAJVTlfN03fnfqGr0KLwk3Lyfxu0DCWtLjrXl1fSMj85GpfXuTY5MjxPwvyHzsVQMsqHyVNrr1di3X6aN3HAKPG/+rhE56tqewKtsQC0xOyUAVG5mivqpRU+mr3nUGjvQw6kKnKvPYN46oah5638=
Received: from MWHPR13CA0037.namprd13.prod.outlook.com (2603:10b6:300:95::23)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 15:07:42 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::87) by MWHPR13CA0037.outlook.office365.com
 (2603:10b6:300:95::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend
 Transport; Wed, 13 Oct 2021 15:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:07:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:07:40 -0500
Date:   Wed, 13 Oct 2021 10:05:34 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
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
Subject: Re: [RFC 04/16] KVM: selftests: set CPUID before setting sregs in
 vcpu creation
Message-ID: <20211013150534.noxfgms66xkwvhxq@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203617.13045-1-michael.roth@amd.com>
 <29aa85d5-fcc7-bf25-dd04-2476dc7b6241@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29aa85d5-fcc7-bf25-dd04-2476dc7b6241@oracle.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda0b052-45c5-4342-bf5c-08d98e5b3456
X-MS-TrafficTypeDiagnostic: BN9PR12MB5066:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5066247FBBE0ACD5C7D1CD4095B79@BN9PR12MB5066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92+/QLmz00V2rL/XhtTAUevkXKsAfY4Kc97v3Dj3a40PdQBS/gyeavthmAid0RsbDzJmPYFP65qgVl5C4YdsY37VAgjtx0q5+i/hJHUKjdIUCPCH3toffFzNhcXNzQGP8Lglgyc6ku+E+ZyTE+Gduheskbf3enp9uHYyMcHeECYdj9Axw0RxtO4cGEDWPVBc3QffW2w5oKWLtanom08ZDBdlX0P8shmJ0E6zfW9+1fnU5coIpXmKawdztQ2JDskE94ybl+DaRllR90XYkfbZ9skwsvM7iSUaY1S32a4pPBskLdpSXYYSJnA2QgbB0kr33nkg1F+YlWx3zbpqtyKfQo+t3BMShLrkLMppcR5RXBOmj9cT803OGCxa8oTL09QfrjJiF3GGGUw5HBEcGQZ8ngenhzbiDBUfTM+Xh1h5a0ko/u7542rOUvM4MRUKFcqklvG0zSoaxQyxK5Bzt5lUz9vqcCEMTeYU654HUVXymwr6DfwDT5nkUNn7xv2xMHPc/h4Uoo8USawbqNK/P2Qnq3GZYyALqRE6igSZcaBQkOIP+LQhmyKz8mZpyP69JV1YtPQNLifp3FrjRZWkASV5l9J7sIe483VqKeI4cX1vVp7RabMQqSGc9Y1DiEU1SxmAMcjE4upGPvB0K15t4R2HfAPQRxsx6jGsVUcSZOmSD31w/HIymsKVr4Pjy03QQufv7YOw5DRAYbhZCby0TpL8G5N0eQC2FKwco3nUiDfoEYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(2616005)(54906003)(44832011)(26005)(4326008)(16526019)(2906002)(186003)(336012)(1076003)(8676002)(316002)(36756003)(70206006)(70586007)(356005)(82310400003)(53546011)(36860700001)(8936002)(7416002)(47076005)(4744005)(6666004)(86362001)(5660300002)(426003)(81166007)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:07:41.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda0b052-45c5-4342-bf5c-08d98e5b3456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 12, 2021 at 06:45:09PM -0700, Krish Sadhukhan wrote:
> 
> On 10/6/21 1:36 PM, Michael Roth wrote:
> > KVM_SET_CPUID*, but kselftests currently call KVM_SET_SREGS as part of
> > vm_vcpu_add_default(),*prior*  to vCPU creation, so there's no
> > opportunity to call KVM_SET_CPUID* in advance. As a result,
> In the current code, I see that KVM_SET_SREGS is called by vcpu_setup()
> which is called after vm_vcpu_add() that calls KVM_CREATE_VCPU. Since you
> mentioned "prior", I wanted to check if the wording was wrong or if I missed
> something.

Ah, yes, just poorly worded. What I meant to convey is that from the
perspective the test program the vm_vcpu_add* call that creates the vcpu does
the KVM_SET_SREGS, so there's no way to call KVM_SET_CPUID in advance other
than to have vm_vcpu_add* do it as part of creating the vcpu. I get the
wording fixed up on that.
