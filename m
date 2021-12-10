Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEEA47062A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbhLJQv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:51:29 -0500
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:63201
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244008AbhLJQv2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0acFJUId6weqZvWPAUm0du5kE9A2nDwulhL04xPb7JQyPqa4sCwJTEH8PgX9AEs7tKDM/Evcnml1+v1pKjhBWzd1l+nTf30lpl5a7e+5g8ESoi5htuFP/MhmvA+KNvur2MNRPq0QZnHbk9cDva02mhP2z1sWQB4IjuigqxMQhOFSZGwwUtZRg7yKTJH5cqnDKpiJn+kILkAUqX8tzSui3gcekSY/63jCxOS0MIXIcPLCiRkGFLkO9j7YG0gPjsWeKrp0csA+RVb7smtobE9u2aY+xJ/lEwQANXAaKOWP1mfYM0STrIXPIcVzI3W1LjGjhu/sCcPDqowwi+Zetf18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuQaYKCvPOEErmoktodgSJ1pfqms9WhM5PkpkYAk2AM=;
 b=QipYgUu/FooS1U9U9jasjNY6A2JYPf574SCMU/Ep4IBSdaXvBH8GZWBY4I03F+bI9vQxtcC1Gesax6iT4TFmbpCWvW0+Qp6hYLmT8Hu2mBMBIb9pO0KcGFIjOLAfDMO466O/iJ90OOALej7xuz8vTae3XbKQGPa1rnWKi+GlOpTCUaA5l70YpKpfLb8EmmhLL7Tiu6S/2A7M/Ioj7hKmhWDZkub7cYNFyXq19KWdmBCcpP1fJ/lPQmJzC0jfpH+1VNIIJcJnQsHDB6ejLS9WJfP5lJrDSXfQXnTsT3QsLXbbV+Gw8xArghw/mmC3UMBjA26ndjbqWLqvTLzy71iESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuQaYKCvPOEErmoktodgSJ1pfqms9WhM5PkpkYAk2AM=;
 b=2xXVFzKIT1Wbg2UdBHOZDOha2X2udzsQBlPUdi0AZl/5AYZ66l4tsyvgA/Erweq6+vmpC0pM1keo4b2yvAWUu9XJbiIGmmzY8QWjXdXCTNlE5NOoAAfoA+x2sjya7YwlL6ZfAXP9xjQdxgFm5I9AyUDVz6ZjHeEc0kFqYqav57g=
Received: from DM5PR18CA0081.namprd18.prod.outlook.com (2603:10b6:3:3::19) by
 DM6PR12MB3418.namprd12.prod.outlook.com (2603:10b6:5:116::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.25; Fri, 10 Dec 2021 16:47:50 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::f2) by DM5PR18CA0081.outlook.office365.com
 (2603:10b6:3:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 16:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:47:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:47:49 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 00/10] KVM: selftests: Add support for test-selectable ucall implementations
Date:   Fri, 10 Dec 2021 10:46:10 -0600
Message-ID: <20211210164620.11636-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41b73b3-d8c8-4a13-b21d-08d9bbfccd7e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3418:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3418E90A938A66D088AB9F0295719@DM6PR12MB3418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY05IGuiEYSEsMjqXtFcHmDTmaw1Id0kqHQAX3OjtXvWREvxOExrrjvnJD4tKQstYNl3OVjm9CbfBU2dxsc5WHW4PLYC5Qt8kN5ac5gW4vfQblU7oZah2jZbWL/d8vkt+U2JvyJ337SrkBfuZCosVq5uUoayYjAdmTMLvGnMNNWT6udPaRuHjL8vTv4VnHiGt8Vrq5L2Gc/pF2MSLg4Se/oHJlJS6L7Q6MRDAwtTCLtv0qcMAaOF9mz5g6Y9OSUOSjZpRbghO3jIhFmqVXv/T9aYOcyzpoSYPa24ACYd+FpoAaTvUKVIrp296qMwBrJwmUPgLqgkXrcJFPEaqy79tNfCYwhFDeQMAo08lid28766WmWij4MTu/lTlSa6Q64+/gYsIpMrdmf+733r22QutTMF+v52RQXnqxCYRtUmIPebmHOwQBsiDFPkK2rLvbUR27xI5jtuGffss521wc/xf0URuX41szWGcgxgEKsGkGIdZJl3M0Xr+SmQg0QTTU7yVf/sdosheoB8iT50Fu+j9NIEZAOQw4Nnwh/22AbGpfK7C1EDzp60gBc7w+1PaATtMSOU+Wfa2ceIadD3OrzLeIGVUZoDKx6bbvAwcXMYDfoZlp1/KMZRluvi045f21tgfxMabc2sSMHBsZb+Z2K6v+ldHNhEHFGS7o9CQecu0RMuJVdhy7Uz+Q4qFxmFFlu0NCn5W7WQg0Rzh9FqDybMjSW3kSgFZOyweSzSRwEo3wBOt2uKSaaTKQTeiYEgqb+2sYliHHvGQuSGhn4vWzI4JAlpL0LqpZHKENCVKwEADPgJ5bJgHtjoL9qRy2XL9ClDox7x5te9btgCVAHMyWRUmVO8DRquO1hS7Qq1SnAjuFvo7RYDuq4TD9gOFrcvK9F+V+NlZJ/fU0j3MgQApFgf4jFFZnKMRtcB2oC+kAqo+mY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(6666004)(81166007)(356005)(47076005)(26005)(36756003)(186003)(2616005)(4326008)(336012)(16526019)(508600001)(426003)(44832011)(1076003)(316002)(8936002)(8676002)(54906003)(5660300002)(70206006)(86362001)(6916009)(70586007)(966005)(7416002)(40460700001)(82310400004)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:47:50.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41b73b3-d8c8-4a13-b21d-08d9bbfccd7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3418
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches are based on kvm/next, and are also available at:

  https://github.com/mdroth/linux/commits/sev-selftests-ucall-rfc1

== BACKGROUND ==

These patches are a prerequisite for adding selftest support for SEV guests
and possibly other confidential computing implementations in the future.
They were motivated by a suggestion Paolo made in response to the initial
SEV selftest RFC:

  https://lore.kernel.org/lkml/20211025035833.yqphcnf5u3lk4zgg@amd.com/T/#m959b56f9fb4ae6ab973f6ab50fe3ddfacd7c5617

Since the changes touch multiple archs and ended up creating a bit more churn
than expected, I thought it would be a good idea to carve this out into a
separate standalone series for reviewers who may be more interested in the
ucall changes than anything SEV-related.

To summarize, x86 relies on a ucall based on using PIO intructions to generate
an exit to userspace and provide the GVA of a dynamically-allocated ucall
struct that resides in guest memory and contains information about how to
handle/interpret the exit. This doesn't work for SEV guests for 3 main reasons:

  1) The guest memory is generally encrypted during run-time, so the guest
     needs to ensure the ucall struct is allocated in shared memory.
  2) The guest page table is also encrypted, so the address would need to be a
     GPA instead of a GVA.
  3) The guest vCPU register may also be encrypted in the case of
     SEV-ES/SEV-SNP, so the approach of examining vCPU register state has
     additional requirements such as requiring guest code to implement a #VC
     handler that can provide the appropriate registers via a vmgexit.

To address these issues, the SEV selftest RFC1 patchset introduced a set of new
SEV-specific interfaces that closely mirrored the functionality of
ucall()/get_ucall(), but relied on a pre-allocated/static ucall buffer in
shared guest memory so it that guest code could pass messages/state to the host
by simply writing to this pre-arranged shared memory region and then generating
an exit to userspace (via a halt instruction).

Paolo suggested instead implementing support for test/guest-specific ucall
implementations that could be used as an alternative to the default PIO-based
ucall implementations as-needed based on test/guest requirements, while still
allowing for tests to use a common set interfaces like ucall()/get_ucall().

== OVERVIEW ==

This series implements the above functionality by introducing a new ucall_ops
struct that can be used to register a particular ucall implementation as need,
then re-implements x86/arm64/s390x in terms of the ucall_ops.

But for the purposes of introducing a new ucall_ops implementation appropriate
for SEV, there are a couple issues that resulted in the need for some additional
ucall interfaces as well:

  a) ucall() doesn't take a pointer to the ucall struct it modifies, so to make
     it work in the case of an implementation that relies a pre-allocated ucall
     struct in shared guest memory some sort of global lookup functionality
     would be needed to locate the appropriate ucall struct for a particular
     VM/vcpu combination, and this would need to be made accessible for use by
     the guest as well. guests would then need some way of determining what
     VM/vcpu identifiers they need to use to do the lookup, which to do reliably
     would likely require seeding the guest with those identifiers in advance,
     which is possible, but much more easily achievable by simply adding a
     ucall() alternative that accepts a pointer to the ucall struct for that
     particular VM/vcpu.

  b) get_ucall() *does* take a pointer to a ucall struct, but currently zeroes
     it out and uses it to copy the guest's ucall struct into. It *could* be
     re-purposed to handle the case where the pointer is an actual pointer to
     the ucall struct in shared guest memory, but that could cause problems
     since callers would need some idea of what the underlying ucall
     implementation expects. Ideally the interfaces would be agnostic to the
     ucall implementation.

So to address those issues, this series also allows ucall implementations to
optionally be extended to support a set of 'shared' ops that are used in the
following manner:

  host:
    uc_gva = ucall_shared_alloc()
    setup_vm_args(vm, uc_gva)

  guest:
    ucall_shared(uc_gva, ...)

  host:
    uget_ucall_shared(uc_gva, ...)

and then implements a new ucall implementation, ucall_ops_halt, based around
these shared interfaces and halt instructions.

While this doesn't really meet the initial goal of re-using the existing
ucall interfaces as-is, the hope is that these *_shared interfaces are
general enough to be re-usable things other than SEV, or at least improve on
code readability over the initial SEV-specific interfaces.

Any review/comments are greatly appreciated!

----------------------------------------------------------------
Michael Roth (10):
      kvm: selftests: move base kvm_util.h declarations to kvm_util_base.h
      kvm: selftests: move ucall declarations into ucall_common.h
      kvm: selftests: introduce ucall_ops for test/arch-specific ucall implementations
      kvm: arm64: selftests: use ucall_ops to define default ucall implementation
      (COMPILE-TESTED ONLY) kvm: s390: selftests: use ucall_ops to define default ucall implementation
      kvm: selftests: add ucall interfaces based around shared memory
      kvm: selftests: add ucall_shared ops for PIO
      kvm: selftests: introduce ucall implementation based on halt instructions
      kvm: selftests: add GUEST_SHARED_* macros for shared ucall implementations
      kvm: selftests: add ucall_test to test various ucall functionality

 tools/testing/selftests/kvm/.gitignore             |   1 +
 tools/testing/selftests/kvm/Makefile               |   5 +-
 .../testing/selftests/kvm/include/aarch64/ucall.h  |  18 +
 tools/testing/selftests/kvm/include/kvm_util.h     | 408 +--------------------
 .../testing/selftests/kvm/include/kvm_util_base.h  | 368 +++++++++++++++++++
 tools/testing/selftests/kvm/include/s390x/ucall.h  |  18 +
 tools/testing/selftests/kvm/include/ucall_common.h | 147 ++++++++
 tools/testing/selftests/kvm/include/x86_64/ucall.h |  19 +
 tools/testing/selftests/kvm/lib/aarch64/ucall.c    |  43 +--
 tools/testing/selftests/kvm/lib/s390x/ucall.c      |  45 +--
 tools/testing/selftests/kvm/lib/ucall_common.c     | 133 +++++++
 tools/testing/selftests/kvm/lib/x86_64/ucall.c     |  82 +++--
 tools/testing/selftests/kvm/ucall_test.c           | 182 +++++++++
 13 files changed, 982 insertions(+), 487 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/ucall.h
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util_base.h
 create mode 100644 tools/testing/selftests/kvm/include/s390x/ucall.h
 create mode 100644 tools/testing/selftests/kvm/include/ucall_common.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c
 create mode 100644 tools/testing/selftests/kvm/ucall_test.c


