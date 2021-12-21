Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF29547C4FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhLUR0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 12:26:22 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:51425
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231187AbhLUR0W (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 12:26:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMALM00t1/mLMOnKgzGe00zmjcLq6FCOwZur4pN1Jgvax9nhiHA4zAe+AeqhYqALoflFo5TmDWzOlh2bXQNoRJYiFv35ut0Qd5fDhs51GfxPGrfVFH2boO+gFt1zjr2xK54o6XS4Vq94qlKRbROXj1/fm8gMjVA0hAnxhQfao2UFZ8jWlvCib4Bm4iYelcyXWm2pDC5olAkLKdu/mV32ptdd58I94hUVV1OGU6DHLpLQcOPW7B/+CYYiqqidSxkAJkuJ89MvJTRkngKma2Cdwwt4CvS5HzwItREHaqDVB3NLwlS1R0YwVAZoVVjFaJxyandOOjfolh8bM7KJRFX8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48BWeWiEYpRDwf67VAL3rzaBDDXCxf//2cZpnMFsXJ0=;
 b=UIaxf0hUAY3r6bSquJFcCcBXKUC8dNOxCa8geGhJwJslhtS5owjBOXhU8S+/in/4yAltokqx6mUSq+vRSZRRlN7GSnxDW4qKEsCg/maNE+dy0PzWipL1d1a/9oXMAUxipr8HOY5+ygV6e12AOWYBzHsuPKoMdC1ARamoPVQmgFEqk365faEyEdHuj/aXYc6vY0MDv9xp2TwCPssHyr3FdBXg57lypNxGLKKrjOAw4Qv+Nc+vuQ0TMZyFv0XGhEChzZkAATTiZGeHgBNzJwvvvM3+E4rwj8GxTZOYFZpKQT4e246SO09Nj91Z4wISyYL9LZQjd+p7vQR7igjHLTCESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48BWeWiEYpRDwf67VAL3rzaBDDXCxf//2cZpnMFsXJ0=;
 b=d6LeJUk5V8nnYRqlBBgwnAU6aXUOrGicvNRIiFJ4Ed9a0HMuR2VPL5Lu8PgWfN9VqCfEDmYVaUgRxE/llGNJoA02P/QYLFUEWWwHOetgBofaPZVGBVik2rlHasfq5SCDE5FRtoTn+I6NXsXnsvzjeh8mWPzpRD5uiquxCDDJ5vk=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 17:26:20 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::af) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Tue, 21 Dec 2021 17:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 17:26:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 11:26:19 -0600
Date:   Tue, 21 Dec 2021 11:26:04 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Mingwei Zhang <mizhang@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH v2 08/13] KVM: selftests: add SEV boot tests
Message-ID: <20211221172604.7hg4digpwp2mnidv@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-9-michael.roth@amd.com>
 <Yb/hGzeiRi0AwfV6@google.com>
 <20211221154036.ivef7wuoblavlmsf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211221154036.ivef7wuoblavlmsf@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38f8fb2f-1f2a-4e5d-31f5-08d9c4a7008e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2566AB65D89FC7C4EE94F7C7957C9@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAPptLGk1+0+22Kgup5btx+pkld4WNJwLxOHjV1fokZFxqi1n/drvgGkZ0apAiNMlTeQBn93FTaQdPF8yIUJ6grbCgfLy7lUD3/t7FAype2gqTWFOlf55YqLiIdJXdVSKLdxxCWNZeZcBtnGnv10mCsaX9QGhlcFOdx9l5mcQeW8ugN/FBccgUh2X7geZ2SEz7C/d+J1gNLZ8tCdjYrC7/TSLWsG2s31sW1VgmlWQEOJ/wA6QK45OtvwKfIheSdfCFz+HEVz+rHfrfkDdYF0ty7wkn+LD7HBLtk3faZCW9QqFiz0Utqcef6J03Zxkmee4oQGLjfiuRsSSifSjoPAMMrwAe0QLlVCsS6nqe64pP8DpxkcEFTtEKhTy2tLAQf/uPUOHzvtKnrWdcbL3p+nQvXFc3kB17P3j4+wv5z/XZmIFYni+TDGXsFeX7KUvPtXjfukREk/33PR47GgGdgoZXM66Da7bgwDlEV6e1HDvgnjdF9cKBRVL6YzlGDdvtWBrvMNHl635qWxgSWoS7y5rviE6cKArelRZMdURLXSQyjbK/SNoJHDmtPRwPV+9IhaVheRuxV4kPwtHFeOb+eA72soO0LQnTEGa9wcgNTYcTcG5dvM8iN0BOAvIU2k10Fvv66Km/ebTSpXWwFy3egol4k8a9+GL+X17yhOTSfRJxVdXtQc7ZR87HiZWdPBXrCIwODU62gseI5FzZWklwUknSdf+AxKAEOaX9QDiW+C1B9wrTFekzgk0ShCFXJiMQ1olA/E5Dt8XIoN/eVZVVNSCPw6OeXy47TB1CrP8vwOO4c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(47076005)(81166007)(6916009)(8936002)(426003)(1076003)(83380400001)(82310400004)(316002)(26005)(6666004)(86362001)(16526019)(2906002)(40460700001)(186003)(70586007)(5660300002)(2616005)(44832011)(36756003)(54906003)(8676002)(336012)(508600001)(36860700001)(7416002)(4326008)(356005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 17:26:19.7068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f8fb2f-1f2a-4e5d-31f5-08d9c4a7008e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 09:40:36AM -0600, Michael Roth wrote:
> On Mon, Dec 20, 2021 at 01:49:15AM +0000, Mingwei Zhang wrote:
> > On Thu, Dec 16, 2021, Michael Roth wrote:
> > > +}
> > > +
> > > +static void
> > > +test_common(struct kvm_vm *vm, struct ucall *uc,
> > > +		  uint8_t *shared_buf, uint8_t *private_buf)
> > > +{
> > > +	bool success;
> > > +
> > > +	/* Initial guest check-in. */
> > > +	vcpu_run(vm, VCPU_ID);
> > > +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 100);
> > > +
> > > +	/* Ensure initial private pages are intact/encrypted. */
> > > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > > +	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
> > > +
> > > +	vcpu_run(vm, VCPU_ID);
> > > +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 101);
> > > +
> > > +	/* Ensure host userspace can't read newly-written encrypted data. */
> > > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> > 
> > I am not sure if it is safe here. Since the cache coherency is not there
> > for neither SEV or SEV-ES. Reading confidential memory from host side
> > will generate cache lines that is not coherent with the guest. So might
> > be better to add clfush here?
> 
> On the guest side, the cachelines are tagged based on ASID, so in this case
> the guest would populate it's own cachelines when it writes new data to
> private buf.
> 
> On a host without SME coherency bit, there is a possibility that whatever
> data the host had previously written to private_buf with C=0/ASID=0, prior
> to the guest writing to it, might still be present in the cache, but for
> this test that's okay since the guest has purposely written new data to
> confirm that the host does not see the new data. What data the host
> *actually* sees, stale cache data vs. new reads of guest private memory
> with C=0 (e.g. ciphertext) are both okay as far as the test is concerned.
> clflush() would probably make sense here, but if failure to do so
> somehow results in the above assumptions not holding, and the test ends
> up seeing the newly-written data, we definitely want this test to fail
> loudly, so leaving out the clflush() to cover that corner case seems
> like a good idea.

Actually it might be good to check both of those cases, e.g.:

  //check private buf (possibly with stale cache for sme_coherency=0)
  clflush()
  //check private buf again (with fresh read of guest memory)

I'll take a look at that.

-Mike
