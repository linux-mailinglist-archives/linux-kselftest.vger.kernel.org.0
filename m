Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB1545973
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 03:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiFJBFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 21:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiFJBFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 21:05:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09EF126998;
        Thu,  9 Jun 2022 18:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESUrVXLQc1cTK38qWaXYRk4giy4E/5w8c4f+76RoZxjUWOQFQkfJnco8R2doalJdJgaWk91ZOpr+sa2rqRtS7fJZnt+eppSC7W7kLs6btiBb8zlutHybrYpcSWWxvVYGoI4KtQGBrnVETBp6rfFran92vJ3w081kibP91wd0OevG6JsVmbCg7zBWOUqHfw8nVYhfMNyVWoTVb5GW5Igy1vs6BvKu+wRSHNSfl74RA0w2fZZ3lOng7qzvEBqqExpTeEGskf5dlxGsuNZOe59USQ5qFZ0f/eC6xNEd2QKdKH3EYpiAo69dHnhiKsoorxRkEUt1n4RcyhhYKFO5ojxqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCcZDvasupbveQ8RbqnbUMijxNxxVetwncqEFJlFcm8=;
 b=TlBLDUyLGmDa74DlvEHbZdjVaqW9g7woFJzGXwQ/vxwMcSq7ptl7pKJyOV6FZLIyqhGQgQRIK0Hkv3tpE00vxKOM504ntLkQTdIvJmCeyqX40V5OXhX5t/UzkIvP0xBnfTJ3jhymJr5PBKtpA5TCjiIJBlfr56qvSNasDpUOfDem7uu3DZ9xiQmJjFc887sFGlwK4r7/pAQow9BsZHn/BQtqdlun8O8pUsGrDfAJ2/MMgoy+ihPvNssrMistAuz19I2lRu1u4BFgds0lPGNS21NsrPgQuXoCQWx1gQkr0xyd/8o/4rMBZg62hDTzIdaR2PERqlvUY1nvd/YGAjYqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCcZDvasupbveQ8RbqnbUMijxNxxVetwncqEFJlFcm8=;
 b=zWCX+hsz3b2ShrVyjTaehY4LNC/XtgQ8K1q5T+P4hJ4eNin7GCD3KzJsju8mVcWqowBaerFPSJTwrAUinZxxodkQLi94cX0srmK56XTj52tNBdfa2PgIbWfsIEHbsAj7X0m9OWeiV5tP53+U1inltUpQQX9n5AOoxfRmMsWZqWc=
Received: from DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23) by
 CY4PR1201MB2517.namprd12.prod.outlook.com (2603:10b6:903:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 01:05:36 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::a7) by DS7P222CA0006.outlook.office365.com
 (2603:10b6:8:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 01:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 01:05:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 20:05:35 -0500
Date:   Thu, 9 Jun 2022 20:05:10 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Vishal Annapurve <vannapurve@google.com>
CC:     <x86@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <pbonzini@redhat.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <shuah@kernel.org>,
        <yang.zhong@intel.com>, <drjones@redhat.com>,
        <ricarkol@google.com>, <aaronlewis@google.com>,
        <wei.w.wang@intel.com>, <kirill.shutemov@linux.intel.com>,
        <corbet@lwn.net>, <hughd@google.com>, <jlayton@kernel.org>,
        <bfields@fieldses.org>, <akpm@linux-foundation.org>,
        <chao.p.peng@linux.intel.com>, <yu.c.zhang@linux.intel.com>,
        <jun.nakajima@intel.com>, <dave.hansen@intel.com>,
        <qperret@google.com>, <steven.price@arm.com>, <ak@linux.intel.com>,
        <david@redhat.com>, <luto@kernel.org>, <vbabka@suse.cz>,
        <marcorr@google.com>, <erdemaktas@google.com>, <pgonda@google.com>,
        <nikunj@amd.com>, <seanjc@google.com>, <diviness@google.com>,
        <maz@kernel.org>, <dmatlack@google.com>,
        <axelrasmussen@google.com>, <maciej.szmigiero@oracle.com>,
        <mizhang@google.com>, <bgardon@google.com>
Subject: Re: [RFC V1 PATCH 0/3] selftests: KVM: sev: selftests for fd-based
 approach of supporting private memory
Message-ID: <20220610010510.vlxax4g3sgvsmoly@amd.com>
References: <20220524205646.1798325-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220524205646.1798325-1-vannapurve@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f3aa4dc-527a-4100-b128-08da4a7d53e4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2517:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2517D15AD88495FA5DA9E08D95A69@CY4PR1201MB2517.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dA75hRsAMw3E0zeoLrmwdGsIMc85TWLqKgO4yuWUbMFuTj9i1vuvHHGO4sEC20YLA9ZP5q/eUhr7WCbEdKvKZJb5zqLL0T99ROO6OqSqpMd5Q1sbcWk4dx4b6sBRSkOtWPV858e1ffvNeZxkNxKYD+M0q3+O1N1L10KbgkjSTC1P26lIo1KnYSmQuYBU78beOVJV1pPfhP9FTghUCzi3HREcnMgEb37FFB7UKVSk1uR96ZvGP5Gp9sTl8avYtccgUrqyFXfXyBhuaqFRF2Wv2J9PecSYK6LthKLwk2jVk5/6HrFkweEmUXxeaZj31jXgcNVIbTC56pvc6dO+mPg56EFvLTTDScGZOBX5JIRwcTcLQWe+wGQB8qoXRwZ4Pz7KpH6VVAanmsvAjMVsyGsKs9XQKP9tfzmRGL+1PlXL09EdToU+IXn7xfxw9Z69/efeWn4PXzR2EM042j80yKuFfCWN4/dftO+8SXwr31oQYtLb3zvx4TQx/vXwqWti6nR533hjs/agRQ3w3EFCW6CkZA4KviLZraRTZ/luLcix7qa9FbvV+9KVMLmSI7Q1Gv45TMxhuUX6sz70nqzfJuKCsYKV2gcRSOubLMefn1lS5/8fdJUfjYeEHMw0YFO9qfuSZ6uPPb4Xp7BSD+prUVQqt5heEQZSRC2JlLPVCrIT4fZWZIMmYi6knV3sh1AkFWRN5WJMTfgv6oQJDyy4NK90SaklKCwiT/6eBSQJ2Th8MD5Rrlhe11HvnsYFiqlxxx0Qq8aIv1DNQaVzLbfJQa33WgtsxESQ+mWGhI6OAn4PKZqVSpO4BOVZnNfcW7Pxufvk31aZ+PnY+WL40gNE8lG/Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(16526019)(426003)(336012)(966005)(5660300002)(54906003)(6916009)(36860700001)(47076005)(83380400001)(70586007)(8676002)(44832011)(45080400002)(70206006)(8936002)(508600001)(4326008)(40460700003)(7406005)(7416002)(6666004)(82310400005)(26005)(36756003)(356005)(2616005)(2906002)(86362001)(1076003)(81166007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 01:05:36.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3aa4dc-527a-4100-b128-08da4a7d53e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 24, 2022 at 08:56:43PM +0000, Vishal Annapurve wrote:
> This series implements selftests targeting the feature floated by Chao
> via:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-mm%2F20220519153713.819591-1-chao.p.peng%40linux.intel.com%2F&amp;data=05%7C01%7Cmichael.roth%40amd.com%7Cbe9cc77fc6ff4da6707808da3dc7f39c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637890226337327131%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=81aPsc4zGLgPZh5A4IwKuN7AB0LLc7sNH8LYrhNMgNM%3D&amp;reserved=0
> 
> Below changes aim to test the fd based approach for guest private memory
> in context of SEV/SEV-ES VMs executing on AMD SEV/SEV-ES compatible
> platforms.

Hi Vishal,

Thanks for posting this!

Nikunj and I have been working on a test tree with UPM support for SEV and
SEV-SNP. I hit some issues getting your selftests to work against our tree 
since some of the HC_MAP_GPA_RANGE handling for SEV was stepping on the kernel
handling you'd added for the UPM selftests.

I ended up adding a KVM_CAP_UNMAPPED_PRIVATE_MEM to distinguish between the
2 modes. With UPM-mode enabled it basically means KVM can/should enforce that
all private guest pages are backed by private memslots, and enable a couple
platform-specific hooks to handle MAP_GPA_RANGE, and queries from MMU on
whether or not an NPT fault is for a private page or not. SEV uses these hooks
to manage its encryption bitmap, and uses that bitmap as the authority on
whether or not a page is encrypted. SNP uses GHCB page-state-change requests
so MAP_GPA_RANGE is a no-op there, but uses the MMU hook to indicate whether a
fault is private based on the page fault flags.

When UPM-mode isn't enabled, MAP_GPA_RANGE just gets passed on to userspace
as before, and platform-specific hooks above are no-ops. That's the mode
your SEV self-tests ran in initially. I added a test that runs the
PrivateMemoryPrivateAccess in UPM-mode, where the guest's OS memory is also
backed by private memslot and the platform hooks are enabled, and things seem
to still work okay there. I only added a UPM-mode test for the
PrivateMemoryPrivateAccess one though so far. I suppose we'd want to make
sure it works exactly as it did with UPM-mode disabled, but I don't see why
it wouldn't. 

But probably worth having some discussion on how exactly we should define this
mode, and whether that meshes with what TDX folks are planning.

I've pushed my UPM-mode selftest additions here:
  https://github.com/mdroth/linux/commits/sev_upm_selftests_rfc_v1_upmmode

And the UPM SEV/SEV-SNP tree I'm running them against (DISCLAIMER: EXPERIMENTAL):
  https://github.com/mdroth/linux/commits/pfdv6-on-snpv6-upm1

Thanks!

-Mike
