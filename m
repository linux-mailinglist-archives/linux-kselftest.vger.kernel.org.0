Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3963E439BA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhJYQiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 12:38:02 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:24161
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233257AbhJYQiC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 12:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlCKdONOAuobQa3gH5AJaS7KpLg5u5MKeSAFX7gnJc9QpBaDB0wsZ4PtzPmtQLndrdzaCUnsi6adsjKyx0vIpj4Oimqbyg/Wt+kg2rPuchYSnxF5LUsNLHDp77jv6UsoxVJEd2sGkaUSnb9ZJE7+SN733PVrv3y5xx1UUbM9Ur+TeMShsNMbIvoxwFTEQtnwiWGpXp1EnFNcNmWb3Y6R0yhCSAPYlRKB+sXExrBaec2cIsN71suGhDQUs/K4W132kB39v+OHfSIyQfj3lUct8tgG1IpX7gidwIhtzoPzwNJ3pphLKf/hnFsNjlc8tnSgykh7ROsuFL16Y0Twlqd1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXBs+uCQU5dRKV1r5LoCgbi/NTMnDSA4JMqtk/FNA6E=;
 b=OoNbAQ78AXHdssEmy3YZ8rgsEvAjIFhNM+RndaJa6hURl2SLa1Du8FtFFaGlWfNx6jZ4RcqLePI5D1fHCxaVQjkS8foB5Cp3dIsyxJDMrURceL3U1GDDlNDEJTUOaSS7goAJk23OghyTXiPkGKVxt1QiI0SNjiH8CiTzh2aU8XsBH/1rgb/RJ0E4j4YO2jWona+DGjKEo/67wES/F8wIv5i2RShRVAt90dZkIR6Nkrx1hyQiPmdcZGOGnuCtq3tYBttDdqiUofk5madUbsUearkjA7WUUz84Y36Z7+AT0LJm+J8HZ0/nqRCFt3cspmC4YmEH6x1ZmG+z2VUolXSzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXBs+uCQU5dRKV1r5LoCgbi/NTMnDSA4JMqtk/FNA6E=;
 b=4gu4LL0ZNaSBQwFtePuY6Y3nysl8V/B+q8dSXgHVhZxdc9IwxL2hpO7k36X7vdTnje0q/SAc6YuLr8z07holFLDIWeUtXiWurIjp5ABej0QkxZOb8bSlN8X6lXvMeZvUoOAyqRtdGD5HW0MJA2qi7KcrlCiixphxT6MCgbTt6DI=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 16:35:35 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::51) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 16:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:35:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 11:35:34 -0500
Date:   Mon, 25 Oct 2021 09:14:27 -0500
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
Message-ID: <20211025141427.u2dstri5ehgegryk@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-4-michael.roth@amd.com>
 <31db4c63-218a-5b26-f6ed-d30113f95e29@redhat.com>
 <20211024164945.mt62qjrld3dwssv4@amd.com>
 <9de44944-57c1-047c-8c66-94eee6369a67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9de44944-57c1-047c-8c66-94eee6369a67@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb5e2cb0-1c92-44e6-a458-08d997d5784a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00188BAD8CE96095C5743D5195839@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbXRfgP2dHq5wtMeDWaNWNWhyVbWMADNh8m6M7PgmZ10PGCjugpz4sv5SEIfMzOoOwV6iSBqN32ugeL7AJgzMcgOJ2ZI9CRTdljCHIz8GH57ZEWHkC/72Ct7p5SGiwR7+LkwkFrU7Lbq5II7rQjAhpTFRINoZzHRp8ktpPHwE/ydYYPpQPuWd/1p66OkGHky/cSeXUUlnbaBU+/sfau/bU7zrkkLXdHOI7kVW20wYB8XLjKxG6XruYXkw9A2ra/WWoswkZV3YohENEKj34XzBUNpTivivVMTA3L/26OOcbcflqI9VoQXOA6E+NMUG/GDJpdj/AiE1Dj1Kp+iJSnchRSCYpGko/7EO/IKJ/ttu5CU+4jMnHX5VynNp1BUkfPAw5vFtjWBw+dmh4wOxEaTRP7PHZxkSrCbM0LYIVUOEB4j0NHjv14ejR5BPw7NS7PHoKJfJJBFvAHMmkQisTJfZbVVp7Du/yAnk0oNzV82iNuncCJW0vixIGK1M8189ToyNyrvupMvOL1Yqz6wwnqK7rC2YGrbKTxrmcN02hgOcSr1ALxr/er5j49Ke70hASOr5DYhhqFC+ZcHUsjZPfmjf6J3oNFfXxrinX0Jmi3w9nQmPUKZ4Cusx/HayOgVOw9/D2smwjhUQxWm1ps4DMhcRu0xZZckR1ufnHacCzkU22yiDD6wGasg7qUU8eqNWkmxWRvO0pFjUhrCJrC0qvCPebXfjFKPts5QM+kwHtNokMM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(47076005)(2906002)(7416002)(508600001)(54906003)(36860700001)(356005)(8676002)(4326008)(6916009)(426003)(44832011)(186003)(336012)(8936002)(53546011)(36756003)(16526019)(70586007)(5660300002)(2616005)(4744005)(6666004)(1076003)(70206006)(82310400003)(86362001)(26005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:35:35.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e2cb0-1c92-44e6-a458-08d997d5784a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 25, 2021 at 09:34:10AM +0200, Paolo Bonzini wrote:
> On 24/10/21 18:49, Michael Roth wrote:
> > So test code would need to consider cases where addr_gpa2raw() needs to be
> > used to set the C-bit (which is basically only when they want to mix usage
> > of the vm_phy_page[s]_alloc with their own mapping of the guest page tables,
> > which doesn't seem to be done in any existing tests anyway).
> 
> Yes, and it seems like a more rare case in general.
> 
> > The library code would need these addr_gpa2raw() hooks in places where
> > it calls virt_*map() internally. Probably just a handful of places
> > though.
> 
> Either that, or you can have virt_*map that consults the encryption bitmap,
> and virt_*map_enc (or _raw, doesn't matter) that takes the encryption state
> explicitly as a bool.

That sounds promising. Will give that a shot. Thanks!
