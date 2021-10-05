Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35243423492
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhJEXro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:44 -0400
Received: from mail-bn8nam11hn2242.outbound.protection.outlook.com ([52.100.171.242]:49504
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236985AbhJEXrl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1+q56RAnNYWKsFklYYGNa0fT7VS18VdBn/oYk8vBai+JkAMtIPYZWREMI4KbM7zBy9MyeU13A4uoqTzNgwGINI1Q/08J3kF1O4hqHd/sYqivBI4mydyJJ9MybmKd4lk/A4insqIT0/PQ3dNK17QwIOErgb7wKFb5VNWuv/Gb51ndx5WbF8zOT5Z/fULitii1l9N3Ne2MAArjOLtBC3WH+xrn8dpStqiP+PuhMIh7fRwtEaGS073DR5TtEaX+/4oJefkvPPTpQFbfHyleDO9qO6knPpygKsMKXN4PD+fMG9NVPCxNmh/5OC1tAjuCbzBe4tRQIZFZwP1UxR3DMigCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAnuBRzR2ceM0tT7haCE1FhKAVXKnUBDmPl+IX1VtSw=;
 b=AL7hIG/JUPXFH8IhWJbhQMC0dHW+mJJkm9Xephk6xg4RjtjDjljzspp2AIsiY/43fXYokweYiFSUtUcgBVqQDKH/HTt02hmh7ef8mZ///ity74MArY+PcOmXRYI9MJp8c10IlCHCFSfZ+ejlypjCSRQeXkglyhzkwASV3sWZjqP8jgB1yheHdkqfC1Iv9wKQYBPrhBXsmZrHru5w6JSRjraSpZBNUPI0YG+//E4yaT8IoL5apdhew+C3dPsIfDnD7JF4enSzCfW9u7c+0u6/6v4aSBvkwolE29Uu2yH1asrZKy4naBuZHNSDYWFipXSM7mwVK5DabB3ykZFFLysHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAnuBRzR2ceM0tT7haCE1FhKAVXKnUBDmPl+IX1VtSw=;
 b=VMsg4OgWJdIrm1VfFjXrcpiq4b26QDqoEm9JJiPF+eHRxFQOyb81vx5C+G3q+oqK1mWx0reIuagaN2ZIa/+LNb4zSgRdMK/e4tOsnoaNEDH6Gdo2l+b4TztgZNmw+fXUtGEsvPn307MWLGcQv9AegansU0gLKfR93ilBJeAjHpg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:47 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:47 +0000
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
Subject: [RFC 00/16] KVM: selftests: Add tests for SEV, SEV-ES, and SEV-SNP guests
Date:   Tue,  5 Oct 2021 18:44:43 -0500
Message-Id: <20211005234459.430873-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0038.namprd13.prod.outlook.com (2603:10b6:806:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend Transport; Tue, 5 Oct 2021 23:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c788bc-7ff4-40c3-bd50-08d9885a4136
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39255E443FE6A6DE465CD2F895AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EzhaQ+RN0H1ODULDdWnkOt49PBMvunAGaSVx8dZV7oe5qVyzLqwbmGoD9r9w?=
 =?us-ascii?Q?reZqXAmkd1c2JdpPbIg/ide+wZymXydgNN44tcLUFqlTd5BPI97hTr9qa2n3?=
 =?us-ascii?Q?v7t87bn2ohWCsWOgpcEb/w4HzjTiR0AljfoAhbdlgh47pHI54toRpuAFNXUm?=
 =?us-ascii?Q?YBUkYArNqi3uqvt5c2Kw4PlMRedruX070bbbkqvjDjeeGwDEdSwjomRr3rcL?=
 =?us-ascii?Q?Ws3oP7l+uGjXZtYs7GbBs6zXyAyCyO0KChtB6MQcdDBvSD7YByUl/VXdUWJY?=
 =?us-ascii?Q?6abb3W5yLmtm2luSvF5ad+ktAxl2FCvfjdgbdK0TAW0AVOpLHDh+IUAgFHxe?=
 =?us-ascii?Q?lf+pwY6ViBxl/Xjl+VoUA0dh0TxmUfoo7uInQiJXct1ZLpxyzA/D5WSrMLnC?=
 =?us-ascii?Q?2hBVWxxXDOkamk8tx1vvzAWG8EQr6hkt7bv2WPNVS1ElJoj498WM4wvqiOoc?=
 =?us-ascii?Q?GHdM+uE5ekN7a9JJR0df2rKz6GPfsF8z2vzzIDIQffXGRPEB7gimif9NVqd7?=
 =?us-ascii?Q?5WVTyMOPUFf6qtjrVBCAYG2WfCigrii6XJQaZ7KO5UBqFUGazTkNW1OcyH9V?=
 =?us-ascii?Q?gR3a+b/yhEChMu3rz9NxGpnkrk8Uksfdmem1llKOEQEfnhXTK51QT4iKNOYv?=
 =?us-ascii?Q?K8OhkyxdQXzX+6OOcu2rpDpChMae+q4IVX0f+4skS+MxOREg9b3kOHB0lqm0?=
 =?us-ascii?Q?0/LEaPfMV3/u+tMPBZlUohzdTkMduZCsLr1t6FzzE8CFnvc0pucc1xSlNEl5?=
 =?us-ascii?Q?pt9v4C8j2ozfSY30tPrRKDAMjbhPfqn0jsOv1OsAzkaH+Aoj2HgOJ1viEbfS?=
 =?us-ascii?Q?l2LGMJ+t8fx39tEN+jzc/bt8pVs3ewx5hkXl4DUTOt0uykE9AZr2QxuXkgE5?=
 =?us-ascii?Q?89w3zyt9T0cPC3favfNhOJArtTE+ymVxnGs9aRO3wmW20mv94Vh+Ea/qKBVm?=
 =?us-ascii?Q?L9TZaVnVc/rkYHWSHgEGW/0kz2GnSQoL21uSl4A2nxIDeH6+qnJudP+4H8M3?=
 =?us-ascii?Q?/OP4wsNq2suNGCq6/6MaJyu/owNzjrG3kmWibosWdyzeE7wg4f3H+VIGoTSD?=
 =?us-ascii?Q?RL39SwCMczvk1CNxUW3ZCsHubK4vi1VOSnc1afFd1Fxo9bf/UdtDW0e/lprO?=
 =?us-ascii?Q?WRxcEZ3Uvq0fmvykQKwbleceVd8B1rC5higuzgSvTsOtnb41BpOstsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(8676002)(44832011)(966005)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3JdowYl9Z/+Njvr7U4uTil5FC2EJ7zBtVj8NR06q4OjGgBT+13+Q1nrT8Im?=
 =?us-ascii?Q?4RV6ACdlXbd/dNfaT6GbRyXK+F9fH3rn11Hf8I0uEuKnxbn4uAEvfrmtYahI?=
 =?us-ascii?Q?XOQN+vm9I8yPxej8ULp245jy4S9SP9vIpt+3t136+GnjuP6p3LgzpZu7btJH?=
 =?us-ascii?Q?v63VlD+CQtTPZrX8Fv9gnyNnE2Oj/5yvOQjv2jMll2P8krAY8WvftN7PWlCA?=
 =?us-ascii?Q?IFc3yz1JvBbT/v3P4jLs1I6lPJKfBGbUUwY6ofd+O2R4jlekmgtZXJpIDS8U?=
 =?us-ascii?Q?dkSfgr75lK7t0aLhUwJrGEXbUB4ZUR24/WpwNh0KiEVRfDAaQQ3P+BDuOlVK?=
 =?us-ascii?Q?UTplJrqCZJwlH3LXPVjEZBv/oZl6wUCjBa103cGY5yPi8/Xl281Dl18wd0gr?=
 =?us-ascii?Q?Ao6NktNJMf9L3i9vdxiCksLo3bmLOPyvQMkuz7ptvBJ3HbbIwT+WEslbW6a2?=
 =?us-ascii?Q?YvX+FB33LzgusE9xw543AGhTEQOjXoZJnRcrUseMh9XMzxdJ4eJEK5+zClCR?=
 =?us-ascii?Q?g9mnWzkjVCAiGR+RtzUEFRbTKq1cNobNOmT/SWq33yt9elPCIuF0JZnc7l4P?=
 =?us-ascii?Q?JHter8zw18m7wOrT1xutoF22/9/wfqoUM3XgvF/ibLuKg+CWM5eV51Yh2/bT?=
 =?us-ascii?Q?jeBg9omEjhz2O6H/hlZx1JW/gLEml66m+HNsrEN2aOQJFS/0Ob0xM2RU/9en?=
 =?us-ascii?Q?H/sjnaZJ4Haj3MBHfHt3YGEiEAYklu1mnVq/RD8yva5BXGuY2wSE9jBGs5BG?=
 =?us-ascii?Q?MQDXEJSYok+aZHvflMn1OBMOlXJlukCMX67IAdwiEIxZiGt++rdGV8zZsmMA?=
 =?us-ascii?Q?0YFhDHwnXx3i9uJ9Cv2/Q9s6oU8TaludLwKcBxbMPUcFVlBTJyea5kOjMii7?=
 =?us-ascii?Q?ggXmlBGHy7aLqejcAj/W4RpbxiXwyUSRLSTKr9rb3cSQwYaX55maEBo+2szs?=
 =?us-ascii?Q?RU3LG5LCIZELwKV257cUlrzw89vO/TADupEw6Z17IYxfCuWNMzcjRwj6gCyl?=
 =?us-ascii?Q?LIrCEsWGR99LzO0MOa63eE8KczDXKgG3mpZxG795IN2kTpCb65PQ5TRkzZEp?=
 =?us-ascii?Q?34+KEphUHbzmsEaSZXAuCVujDN9xDsmW7HF3HrIhkg/WI6zixtUW2vwYNSFC?=
 =?us-ascii?Q?PqRBmbGyczucOqTJhGgNUSkbaBXjthybu5gXowl0JdZRtR6XFjP3NNnJN6MW?=
 =?us-ascii?Q?4Kb/WkzYHfBQvpYIhcR5iSrvwfuHSCfwLHILNEeZDQ3Wd6DnVjGFUthyfHCS?=
 =?us-ascii?Q?1d8of+hllZ5ic5wXW6rgiBiagDSB7iSFMkUPOb/3gTcgC469ybrqBTqFyxt5?=
 =?us-ascii?Q?rSOOT8l77ZOJ+X+ZcrdNCfDw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c788bc-7ff4-40c3-bd50-08d9885a4136
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:47.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3OmO7dLqd60MZHATwQ720iCBqm59zVeuIvPC/dqx8k9gdPR9JdU1LGil4LLG0vd3pyeEjqtX7WhtPvwmAI5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches and are also available at:

  https://github.com/mdroth/linux/commits/sev-selftests-rfc1

They are based on top of v5 of Brijesh's SEV-SNP hypervisor patches[1]
to allow for SEV-SNP testing and provide some context for the overall
design, but the SEV/SEV-ES patches can be carved out into a separate
series as needed.

== OVERVIEW ==

This series introduces a set of memory encryption-related parameter/hooks
in the core kselftest library, then uses the hooks to implement a small
library for creating/managing SEV, SEV-ES, SEV-SNP guests. This library
is then used to implement a basic boot/memory test that's run for all
variants of SEV/SEV-ES/SEV-SNP guest types, as well as a set of SEV-SNP
tests that cover various permutations of pvalidate/page-state changes.

- Patches 1-7 implement SEV boot tests and should run against existing
  kernels
- Patch 8 is a KVM changes that's required to allow SEV-ES/SEV-SNP
  guests to boot with an externally generated page table, and is a
  host kernel prequisite for the remaining patches in the series.
- Patches 9-12 extend the boot tests to cover SEV-ES
- Patches 13-16 extend the boot testst to cover SEV-SNP, and introduce
  an additional test for page-state changes.

Any review/comments are greatly appreciated!

[1] https://lore.kernel.org/linux-mm/20210820155918.7518-1-brijesh.singh@amd.com/

----------------------------------------------------------------
Michael Roth (16):
      KVM: selftests: move vm_phy_pages_alloc() earlier in file
      KVM: selftests: add hooks for managing encrypted guest memory
      KVM: selftests: handle encryption bits in page tables
      KVM: selftests: set CPUID before setting sregs in vcpu creation
      KVM: selftests: add support for encrypted vm_vaddr_* allocations
      KVM: selftests: add library for creating/interacting with SEV guests
      KVM: selftests: add SEV boot tests
      KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
      KVM: selftests: account for error code in #VC exception frame
      KVM: selftests: add support for creating SEV-ES guests
      KVM: selftests: add library for handling SEV-ES-related exits
      KVM: selftests: add SEV-ES boot tests
      KVM: selftests: add support for creating SEV-SNP guests
      KVM: selftests: add helpers for SEV-SNP-related instructions/exits
      KVM: selftests: add SEV-SNP boot tests
      KVM: selftests: add SEV-SNP tests for page-state changes

 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kvm/svm/svm.c                             |  22 ++
 arch/x86/kvm/vmx/vmx.c                             |   8 +
 arch/x86/kvm/x86.c                                 |   3 +-
 tools/testing/selftests/kvm/.gitignore             |   2 +
 tools/testing/selftests/kvm/Makefile               |   3 +
 tools/testing/selftests/kvm/include/kvm_util.h     |   8 +
 tools/testing/selftests/kvm/include/x86_64/sev.h   |  70 ++++
 .../selftests/kvm/include/x86_64/sev_exitlib.h     |  20 ++
 tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 ++
 .../selftests/kvm/include/x86_64/svm_util.h        |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c         | 249 +++++++++-----
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
 tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  30 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c       | 381 +++++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 326 ++++++++++++++++++
 .../selftests/kvm/x86_64/sev_all_boot_test.c       | 367 ++++++++++++++++++++
 .../selftests/kvm/x86_64/sev_snp_psc_test.c        | 378 ++++++++++++++++++++
 20 files changed, 1820 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c



