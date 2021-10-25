Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8689F438E5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 06:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhJYEcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 00:32:17 -0400
Received: from mail-sn1anam02on2075.outbound.protection.outlook.com ([40.107.96.75]:6080
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229678AbhJYEcQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 00:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjCiK0SQuCaIMO2Inr04sdOBuhfFppe2Pu3wRiweUgSfK484zoQ/szNQKfDDgW+Kpq1Hp8C8myqv16mbitIMci/GlnQpf3UdkaU1tqiI7H7+e6PRA0B/PDyZKRQRWSjW96z370URaXthv1/J5v8G7mG17B6yaNmeVkhY1KhZCR/SJaTW/Dt4OLzxwpByRMOibCjrLRQ4yGygo9ZoO/LsVxlUbYrdWpFvyYoj1Yo+3F9eoW/tRtp7cedyHIzkEn/fvQ6owj6hjsgM1EeN3aAhJ773V47Bii1PWZ2bdPNASdAPVcOU9hdqDHrl7t6trMX6MlVdDKCMYPIIutFC33SaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVwu6j+g94krMFOJwr7T5nJEGbasWqpoNUORJOJ3iBc=;
 b=f95/+l7KIQBeEyEX+SmIR2JiyU1gqxXs3vF1ueQlcB7ZUCKgeCk+4hqwwNFqdglJ9KrrEopTtP7W7mxp7aUx+BYRdOqCANx54dvgW6SXRVAJPu3eMAPMBxJFRQglHZykbkNyUTJqqIJkTu7ge6Ljk5rCKzLqoXy2MbhzIE9lvlKbRC7nctAfP2rxBMFKEchdWVS4nYjANTh6fuDgpb+/qo5iDQvqyi81beFfjEhgWi1snplVfxJq24aUos+rU/Eg136XpfgRT1toCtc2OYAI0wrKG80xWXKVXGuSHvWyVYxcj0XGdP2uXJB5UCemI1Mil566pFvTkiuVW9MiPaVUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVwu6j+g94krMFOJwr7T5nJEGbasWqpoNUORJOJ3iBc=;
 b=sLRkt2h9ybyw+CzmWY2xtgwx2WMiVjnZEjZ5sNWGIK8RKDChEluCeFAwunC+dTns+2YvKYBH4MqbQgeLrgOMQWBHAVeVqaiue7BgsflF2Vgy+vus/jEG5Rfadz5rJuYz4dqnP7gARmBDZVZQ5s0aq+c26vzLmFINWvQx3olaHsY=
Received: from MWHPR18CA0058.namprd18.prod.outlook.com (2603:10b6:300:39::20)
 by CH2PR12MB3830.namprd12.prod.outlook.com (2603:10b6:610:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 04:29:52 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::fd) by MWHPR18CA0058.outlook.office365.com
 (2603:10b6:300:39::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 04:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 04:29:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 23:29:50 -0500
Date:   Sun, 24 Oct 2021 22:59:01 -0500
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
Subject: Re: [RFC 08/16] KVM: SVM: include CR3 in initial VMSA state for
 SEV-ES guests
Message-ID: <20211025035901.r3yxumcygvj22skp@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203747.13479-1-michael.roth@amd.com>
 <1661def3-45d1-9aab-aeb4-5b934179d3ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1661def3-45d1-9aab-aeb4-5b934179d3ab@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5f7a3c-5df5-43b4-d659-08d99770168f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3830:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3830C09266B3F2787B82C9C695839@CH2PR12MB3830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PaX8+55Bk49tHwvUvIPap3OSjUdv57XcXBg1BSi8jMrpIms8d8n17cGy7yGU5/fIonEYjDv8ZVK9HOtdztkqzhnb4MsCQ3gr/4BhzvThS3NmyuHCrMM2hECw2xBEDhJwQSBUWn4xExf1f633o2i7sotoeflPhYuYinkmWJDPd4qxKstjS1giA9AXuQOP8h3Cb9B2DPhkuoxitvrva8gEJ6jqKnMBE1P6hrLtyZbZzSy1QF/TsoGmcR/OxgcIB/9lKKVrbu9acWTcxwZ96Ri3v+uuEHvCEpRhXzRJVU2hKlxR+Ro3PW/HcbspOPWEIUEpEu2u/FLVP+j/vCoXTBegE5ob3s2s1lUOFkPoCZW72tmQUeVWfBjIGR6b6o/xMKCbFsnOUyppx3wCPtKE1tHmHyaHSiTYh6uwx/R/pQzFBkCFujOrRD9UUixSaYWk1iNClVW9Qd95K5Bcz4uzdubCqTun5pWVoprJAyVjsSSFEu49oPyr1QSLOmZKpFJ0ruZyq9HJ0FxQlsskFPbPa3KMSvzM2HH+CfTe8B6yVV/FMi0oeSblYtsf493ZH3IGJEiDkRFQJlqe6jRR+mcLRUL2xAjmFZaqWxx7agfd7hnvw5ZAcMqv9ncF5an7uKgt1PEy2EfdYDZ65fkilfJ6c9FTQ01j+UweeHy62iZ+tGHv06zRi3jB4FRF8YhaxOq60CN1D4+5d6Z0/gqmeDkx12FQMZLsdJ4l2v2dKEcxcB6qhA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(1076003)(426003)(2616005)(508600001)(356005)(36860700001)(6916009)(16526019)(86362001)(316002)(47076005)(4744005)(7416002)(8676002)(6666004)(186003)(336012)(26005)(8936002)(44832011)(36756003)(4326008)(81166007)(54906003)(70206006)(82310400003)(70586007)(2906002)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 04:29:51.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5f7a3c-5df5-43b4-d659-08d99770168f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3830
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 06:43:34PM +0200, Paolo Bonzini wrote:
> On 06/10/21 22:37, Michael Roth wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index c1a2dd0024b2..d724fa185bef 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10400,8 +10400,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
> >   	vcpu->arch.cr2 = sregs->cr2;
> >   	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
> > -	vcpu->arch.cr3 = sregs->cr3;
> > -	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
> > +	static_call(kvm_x86_set_cr3)(vcpu, sregs->cr3);
> >   	kvm_set_cr8(vcpu, sregs->cr8);
> > 
> 
> Can you instead make the hook "post_set_sregs", and keep these two lines in
> __set_sregs_common?

Makes sense. Will do.

> 
> Thanks,
> 
> Paolo
> 
