Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD1424815
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbhJFUlA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:41:00 -0400
Received: from mail-mw2nam08hn2204.outbound.protection.outlook.com ([52.100.162.204]:64352
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239360AbhJFUk7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoSuOFzvsA0lazbfjKK0qwKQgqy3QaYqxBe/Z6eDaXfsdbrmtb6C0BNFYd8KYJSLvpstrNM5gexhQfC3ltz7Ea1l5kloWuUyJeHnbyi5R3OHlxeKqx2kRhwsT5QQRl/8iacpwsQSqGwJTUj0b0FEqNHcV6A++k9RjlYCyCZi5D9t9/v5naLJ4bt4An+THygJF6XexfvzUl93YNdUZcE6QMp/pqqDIMb9uPtPA4EVFvxOb3OjyFGemX0Vc6S+Gin/iBaHVw8JnO9LP0jlzCNUNMNS2/5vYnM5yJwYH6Qx+urAvhnR0LMNHO1hMknE6F8c3Q/p7YOwOeNFDLudkw1Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilJfiH5DjmWj6SLLgPXgRMbdbC+7Us5FRZhN+RnM+Bw=;
 b=H3dYQcrd4NnuPOzvMb3mIHF1hU7tjc6T2UXtVQ5scgK0RzrIrs72uWK6DqRwJpU/b5BxtmLFF6Wv/XH33afwoIyOY9gCEGV5z/2m6SBRcSNuglu/Aga6126cuIhloDrRY0VDj1hbtyTSht/r7I3qvh34HfxgnLBFhuXNL/TPInORQ9Xe2VlhTrhmM94R+0FXXNxdHPGXvlAoGnINoK2Xxau6cHaOxQb8otyg8wddGAyoM8dyVLJFEneV1m91qFvkE5qgc1X//ZNrzSSw//hLkYBC15o7jeUELnVYlXgSEuAu+NABevHC8se2Pu5jUVNZ3wBJsYHpnLME9l85rdUFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilJfiH5DjmWj6SLLgPXgRMbdbC+7Us5FRZhN+RnM+Bw=;
 b=SWtdQAN54BSq+b0vsFbHdiphqqYv6O3Mcy9dMoejzC6DSluxVvg5P65p1Se5iFqCxPtMeJwtb5HoncQY2pazPsGLkgROncYJpy8kGRKxvOxmhS/KWxyg4wWfOLq+PFmKQ4MAHZuCz3jh0BKEVgxOs2ExCq+/549qlp89j6HQcmc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 20:39:03 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:39:03 +0000
From:   Michael Roth <michael.roth@amd.com>
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [RFC 04/16] KVM: selftests: set CPUID before setting sregs in vcpu creation
Date:   Wed,  6 Oct 2021 15:36:17 -0500
Message-Id: <20211006203617.13045-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN4PR0501CA0120.namprd05.prod.outlook.com (2603:10b6:803:42::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 20:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964be0a0-07e6-4faf-12e6-08d989095579
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42643B227181BBEA21741C0D95B09@CH2PR12MB4264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n6k1ZRsn74a91aQkReZnYlVVvbQMcu9CR4AqAGaRovxoER0CvsaSbJj3Kd7g?=
 =?us-ascii?Q?Y9PDT8MedfmMi9sRLVeP6Imyg6A7nQz1lFm4ifyZgEgFSTW/1H3eJoZ9YS05?=
 =?us-ascii?Q?3sDiC2yvdDW4VaYnj8wlBQNhhXdi9qg6pwA9UVc5x9sTJKLdQpEuk0BRsvIH?=
 =?us-ascii?Q?ORpfHib2667CXu1QKdNx0o+AqBPnOx5F5Y//4FPhaKgqCYp+FV+umUjcnOC2?=
 =?us-ascii?Q?uB//mSo6x6I/Z41r3n2wshrRLlYDbSCGDxyMt2Pnkc+kiZAbSEsuWzTSy7k5?=
 =?us-ascii?Q?brQXtrSGuN24qsZd8f2tVBOb4k1Ta1mEx266FiIDGnhNo/L1vUrdPHfrhFlz?=
 =?us-ascii?Q?fELAjJ79607uXTPczfCTbsqdwqnUtV9TSXor3LZpn0+zRILTtfFyzcWdcqKc?=
 =?us-ascii?Q?10ieJcz0XBFPu7sRM0Y6fDsJKN0nyyvaANQNJrZREr1aKTNbq5V/56Jke7KM?=
 =?us-ascii?Q?5//omlWP/2XjYT0f+Lmuyco82rrrmERGQILbxXbr+Js0h+chN208Xta82k1L?=
 =?us-ascii?Q?PeWNr0/Cx9wTVCv9c4J3ZB1pY1ndaEfSzVeOgQM+vCPxuxyiJpi3/dYOcxzC?=
 =?us-ascii?Q?vJrhc+9F40GPNVmXTT+yxg282ryq/7wKoX9tPKW1NMPzVB8v+OieExeDGsJy?=
 =?us-ascii?Q?mfMkSr76rdAiMk8SrDlIBYxL4vFRTY9GdPxC79X24p39ZYA7ZgB1VQZWR6pJ?=
 =?us-ascii?Q?tXvSqklthpjGlHwRFBbN5C8gU7ED77tqgzdf/d1m8s6h9OyqfYotXbumA8xZ?=
 =?us-ascii?Q?xX76USifApcs7tyMVOwInhIKdV76l2VdS1TQiTEkDDmG2nkgqblwfxRbhG9T?=
 =?us-ascii?Q?NTArp1HNd6ByOjNepLMT3XJ6m7NINYcdMJES+mT1psIoWjRaGfEGZ1wKDq1j?=
 =?us-ascii?Q?G+f7tMsCp/fvmaNmE9Bz9iC9QqJ+WBgI9xxWYiLlHNM/aMNPt8PT1DKi8X1n?=
 =?us-ascii?Q?pfWzBMSsLxXuUzShluy8lHDquLNy5wM0EJpQsZgMTA6HMB3a1VLSZPrC5Mwe?=
 =?us-ascii?Q?GFHyGjtb8iNrvgblfDvyk41AvWP+uSvA8Nx+QCcB6RrOqJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(86362001)(7416002)(36756003)(6916009)(1076003)(316002)(66946007)(66556008)(26005)(8676002)(956004)(44832011)(186003)(66476007)(4326008)(6496006)(52116002)(508600001)(83380400001)(2906002)(6486002)(38100700002)(8936002)(2616005)(38350700002)(6666004)(54906003)(5660300002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcTYwxXjP6Tf3p8E0riJIMrMo/6pQeSv4rEvLjQKFzfRT9T6tWFPD2fI/l3X?=
 =?us-ascii?Q?F6xL/FcQ9rRm+ILrQa1EWnMr5R3oZrJDtjg/OgKh3B3s9Y8GzjUM0xL/+3Xf?=
 =?us-ascii?Q?CI/Rc+U5dEB5Zb8qi1GyJ9OCcUR3hNpwYCK97RxxmnuXZz/KF2181860YMwD?=
 =?us-ascii?Q?1/t0IMKq7ti75R+4s8U4t332HCEmrzfQhQMc+pN8J+HqNUDXsA06R8d/T0iQ?=
 =?us-ascii?Q?CcpDGNb3SLiuYrzNH3O1a/bkxN8YJTLTF0pbvxMhKrBelrdnhBaO+rvYftK2?=
 =?us-ascii?Q?qZhFoOCBIpHc6HyZTut/LWLoLFwsi4hL7qKTJey7yUIzSxfSpgGxdQTjfdgm?=
 =?us-ascii?Q?176nh+w1bhx0T7q0P7lj6u8iGePWteHgYaB3664foPBkCA1zhj8ObWfWSUGz?=
 =?us-ascii?Q?csa77pEO5ZUWSiYazu4kYNNCpHGuURH+litBEMgMrTiDaoxqId6VVCe2sFRn?=
 =?us-ascii?Q?lor+pCap1gXctOAiL+evYyH1h4MduwoZ7OH3C9L/50z67U6y0juhXMLsP++i?=
 =?us-ascii?Q?egGQQiFRcJzVp94BzBLVrKUzhp/sPP3l4mHUiBwyQcJJYv9fMtfnPfKALMWB?=
 =?us-ascii?Q?nn/z6RYxrY+lfYEAyUzxt2mqhv+lFguJhbMXquxBHJ5cNVD5Q3LviXsKmCTw?=
 =?us-ascii?Q?LyT5PwG854us67tDiabLfSXA5Vo6nDMyvUfgshNuf9uP+ZVOMMq8R1Fuwn6t?=
 =?us-ascii?Q?kqe/DVl7EPcLPaa6IyO8PfH2RDRSNFljFBEjnlSHDS9+w+T2ewPOW9ZtriNd?=
 =?us-ascii?Q?RuzP0pGenEDAuXXwA3zln/aFIDYaDughK0O8jzdeARajfwYgZjWxrvHXuuYs?=
 =?us-ascii?Q?3NVOpcKGBcCx8wTb56KRK18QVhwBNneqSsVS/b8Ran6791YumsuidThhV+UP?=
 =?us-ascii?Q?3DsChemLP0zH3Qq/TMbhABiYG3Gua0jCtv3veb9cRDy6QCa5pS0oiAHM69iq?=
 =?us-ascii?Q?nMpfLCqRD/mM9LiqtAtmbAx07IjQ6GOmIHj/dbV0vL1/ZO0m+Z0UJstYkxgY?=
 =?us-ascii?Q?xIA58nrtwqb4SsvjhWPNK/NKjjdnp9wiMMZWTe9cGxynmwdsfSOvwKCPRcjb?=
 =?us-ascii?Q?sAASW/yFGVFIvx+ykXzELrpMmclQvOVaj3CQjb9STWci+4duJtjg6Rd0sfmZ?=
 =?us-ascii?Q?sm+35tSvvwQRD+dXGx2PuiTNcjm7A7rZLmWyyYNXgKBqH/4lKiwNdo1CB2UH?=
 =?us-ascii?Q?AX8NrIHhX/74g05ywinE/PFaNhcglBN1eZpELbNki9chE/hDbRFCfnpBomwD?=
 =?us-ascii?Q?jyhKOw2Dipe+hO5Up1mL8ITv+mhcg2Csf6f+wx+nVqjx/p+UQbCIZpmsRgr8?=
 =?us-ascii?Q?fYVrXIlv6q0QFOpuOT7i14c1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964be0a0-07e6-4faf-12e6-08d989095579
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:39:03.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRdJ9xVTwW/AURyOvAcN8ygfBBaalgVQAft2rLyVjJMmVc9hcRcbNq9sYjA+23DMdbnd5lveq/R6EhCRrvTuMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recent kernels have checks to ensure the GPA values in special-purpose
registers like CR3 are within the maximum physical address range and
don't overlap with anything in the upper/reserved range. In the case of
SEV kselftest guests booting directly into 64-bit mode, CR3 needs to be
initialized to the GPA of the page table root, with the encryption bit
set. The kernel accounts for this encryption bit by removing it from
reserved bit range when the guest advertises the bit position via
KVM_SET_CPUID*, but kselftests currently call KVM_SET_SREGS as part of
vm_vcpu_add_default(), *prior* to vCPU creation, so there's no
opportunity to call KVM_SET_CPUID* in advance. As a result,
KVM_SET_SREGS will return an error in these cases.

Address this by moving vcpu_set_cpuid() (which calls KVM_SET_CPUID*)
ahead of vcpu_setup() (which calls KVM_SET_SREGS).

While there, address a typo in the assertion that triggers when
KVM_SET_SREGS fails.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c         | 2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ef88fdc7e46b..646cffd86d09 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1906,7 +1906,7 @@ void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 {
 	int ret = _vcpu_sregs_set(vm, vcpuid, sregs);
-	TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
+	TEST_ASSERT(ret == 0, "KVM_SET_SREGS IOCTL failed, "
 		"rc: %i errno: %i", ret, errno);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 0bbd88fe1127..1ab4c20f5d12 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -660,6 +660,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 
 	/* Create VCPU */
 	vm_vcpu_add(vm, vcpuid);
+	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpuid);
 
 	/* Setup guest general purpose registers */
@@ -672,9 +673,6 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
 	vcpu_set_mp_state(vm, vcpuid, &mp_state);
-
-	/* Setup supported CPUIDs */
-	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
 }
 
 /*
-- 
2.25.1

