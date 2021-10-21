Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB3435964
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 05:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJUDtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 23:49:24 -0400
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:10721
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231370AbhJUDsr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 23:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO2MYdKwSefIe3bcx2ub7Yoybyn3jDKSY0vSwZOcrwu3tU8AVqhZFQI4VVPZEwnxTXTfbDT+u6fiuRjC2QSh3Ohrds+HtQk+Q7gI6a4lfuLKbQh0R9XPj6gFNJrsWAE1nSMS5iIXN4MBMmjybkoqNiCublQ/ruZk0nsBQp8oFLPT8pZ6wlm2xoJ9O5nzesSl8HfrQ2iRO+/8UIYUvS3WkPJ7Gnzv7671SWqsZfgf8I3arIdoYIr7K5ORY4VxeLeou3y0ibF6H27UKWa6vzlCUJAzWxnFIS6baVH6yVV4wIohzuzomVUNxRdMyZlLCrJmQnxGTm+0HARchl3LW+SGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33QigOX7rWImKSCQQ8crC1ZK2zsO+5j1/CfGNdITQxE=;
 b=JAarUG0DG2pA8auLrA/g+q3M3A9Np777FVqZlkGTfpEOUwwL4Gdo2yCMf/vAC2X69dEYpFZFXN4g+qC2jNyC7tqsQ8obxtCrhZ2wWDaASEBVyDqGzZYYvF/uzkHkqXzTbfOPZTSI6IhBW2NK2LBfqzhpDox7rG0b7IhCRIAa5yYlAKe/FcasFErZgFWxvH+Cno+3jC8XZlsSBA30YdCbIOWD8iLN1WguFmiSCuopWLFG3GgQm0weygsgFbvtWimJEbB9Dk66L3PujlBEoit9OksDPi/LDUCxXC6TRaEAG73RwJiWZy2AhRNyUeYwFWEIyf9VH7Zn7e9MzcwOPrDWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33QigOX7rWImKSCQQ8crC1ZK2zsO+5j1/CfGNdITQxE=;
 b=hpzxGXvovzfa4i6ioZnRAR28wiDWsBc51jjeW4fuT3oDLRfHE4G6RNbuyubXF2bn0hb6h7QJQ2ljnEHKii2dGHt3II+JOdUoc7uDolLG74gXAp40w7FHMsmCz3hSei1jTpWQF6ilMSU1PH7bnNQeLr/jzvqB5l6AWVwd9dqBwsM=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by MWHPR12MB1325.namprd12.prod.outlook.com (2603:10b6:300:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 03:46:28 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::b6) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 21 Oct 2021 03:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 03:46:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 22:46:26 -0500
Date:   Wed, 20 Oct 2021 22:35:26 -0500
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
Subject: Re: [RFC 07/16] KVM: selftests: add SEV boot tests
Message-ID: <20211021033526.uyxwb6dr22gpffoh@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203726.13402-1-michael.roth@amd.com>
 <4e3d8f38-f01f-c1aa-335b-2c248f512638@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e3d8f38-f01f-c1aa-335b-2c248f512638@oracle.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3ad12f-3986-4fb1-635c-08d994455cc6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1325:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1325BE2DBF733679B8F4E56395BF9@MWHPR12MB1325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gS2Jc46i7DjiHj84wu03TCZnnF858e1SUfcXrbzQ9LUn7zW0KRPTvIyy8SBgt6+8RUxNbsUJJqrUXMIi3Bp8LQM01t+AmSiS/PQG69pIqC8Moh/7dVo3xFLcx5suYyCp4plKBszSn1A4xOCeruHJB9lmCcr/MSljCyFs0lJNMwqG8UE4XD6PqRUCRyIxBmJys+WWFd5BW2rh7OY0gdf2NAn57rvXmyjfvKvQShypTOlaWHfvJNpTfXjaRWWVbrkzYbZJuKfV0xqlZpGFCKwF1BhGkmMzZSWW8hQXy9ZSwIu2hB8E9RqYUoIALynNJPt/5HeRN9mabyzpFVTwciYTGtpDNBdv+cuivYLLqx824ubbpDCFJR++CbkxurgUqhbyTYi4+kSrkL747e02Hvkx/79zf9Q4/9yHX0NgZvrif9eNgigk5mxuQCex+yLymHYhVDNX8JcI0frYl5ssongRKueFIE+TjiyOVWZOWBAYh5ykmN215yn9ZoOhI21Yvdbvr+QSI09f43cWtet7Lmj4GQCbTGbFHEJp3/dnDfYtSauCJedm6C2s299To1a3P0npVFPeLODkratLPJGsAWhFFhb9dA+K1ir9cNYUc8G4xl7qqhsLp/5ZEHYh3IIE43cKh2kJx6PTx9xOkF6Ir/DN2+x4fpbSdUrOwW/aI4/8eAdBdn70kn3BTzEyKLZSmXfecoCyWT2waZf8uFW0JkcGCicL98g9PKamCL1t/AgsJYo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(5660300002)(81166007)(30864003)(83380400001)(47076005)(36860700001)(70206006)(70586007)(316002)(54906003)(82310400003)(1076003)(336012)(86362001)(508600001)(4326008)(426003)(26005)(8676002)(6916009)(53546011)(8936002)(356005)(36756003)(2616005)(186003)(44832011)(16526019)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 03:46:27.8166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3ad12f-3986-4fb1-635c-08d994455cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1325
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 15, 2021 at 07:55:53PM -0700, Krish Sadhukhan wrote:
> 
> On 10/6/21 1:37 PM, Michael Roth wrote:
> > A common aspect of booting SEV guests is checking related CPUID/MSR
> > bits and accessing shared/private memory. Add a basic test to cover
> > this.
> > 
> > This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
> > subsequent patches.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >   tools/testing/selftests/kvm/.gitignore        |   1 +
> >   tools/testing/selftests/kvm/Makefile          |   1 +
> >   .../selftests/kvm/x86_64/sev_all_boot_test.c  | 252 ++++++++++++++++++
> >   3 files changed, 254 insertions(+)
> >   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > 
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index 0709af0144c8..824f100bec2a 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -38,6 +38,7 @@
> >   /x86_64/xen_vmcall_test
> >   /x86_64/xss_msr_test
> >   /x86_64/vmx_pmu_msrs_test
> > +/x86_64/sev_all_boot_test
> >   /access_tracking_perf_test
> >   /demand_paging_test
> >   /dirty_log_test
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index c7a5e1c69e0c..aa8901bdbd22 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
> >   TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
> >   TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
> >   TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
> > +TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
> >   TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
> >   TEST_GEN_PROGS_x86_64 += demand_paging_test
> >   TEST_GEN_PROGS_x86_64 += dirty_log_test
> > diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > new file mode 100644
> > index 000000000000..8df7143ac17d
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > @@ -0,0 +1,252 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Basic SEV boot tests.
> > + *
> > + * Copyright (C) 2021 Advanced Micro Devices
> > + */
> > +#define _GNU_SOURCE /* for program_invocation_short_name */
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +
> > +#include "test_util.h"
> > +
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +#include "svm_util.h"
> > +#include "linux/psp-sev.h"
> > +#include "sev.h"
> > +
> > +#define VCPU_ID			2
> > +#define PAGE_SIZE		4096
> > +#define PAGE_STRIDE		32
> > +
> > +#define SHARED_PAGES		8192
> > +#define SHARED_VADDR_MIN	0x1000000
> > +
> > +#define PRIVATE_PAGES		2048
> > +#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
> > +
> > +#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
> > +
> > +static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < pages; i++)
> > +		for (j = 0; j < PAGE_SIZE; j += stride)
> > +			buf[i * PAGE_SIZE + j] = val;
> > +}
> > +
> > +static bool check_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < pages; i++)
> > +		for (j = 0; j < PAGE_SIZE; j += stride)
> > +			if (buf[i * PAGE_SIZE + j] != val)
> > +				return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void guest_test_start(struct sev_sync_data *sync)
> > +{
> > +	/* Initial guest check-in. */
> > +	sev_guest_sync(sync, 1, 0);
> > +}
> > +
> > +static void check_test_start(struct kvm_vm *vm, struct sev_sync_data *sync)
> > +{
> > +	struct kvm_run *run;
> > +
> > +	run = vcpu_state(vm, VCPU_ID);
> > +	vcpu_run(vm, VCPU_ID);
> > +
> > +	/* Initial guest check-in. */
> > +	sev_check_guest_sync(run, sync, 1);
> > +}
> > +
> > +static void
> > +guest_test_common(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
> > +{
> > +	bool success;
> > +
> > +	/* Initial check-in for common. */
> > +	sev_guest_sync(sync, 100, 0);
> > +
> > +	/* Ensure initial shared pages are intact. */
> > +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> > +	SEV_GUEST_ASSERT(sync, 103, success);
> > +
> > +	/* Ensure initial private pages are intact/encrypted. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > +	SEV_GUEST_ASSERT(sync, 104, success);
> > +
> > +	/* Ensure host userspace can't read newly-written encrypted data. */
> > +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> > +
> > +	sev_guest_sync(sync, 200, 0);
> > +
> > +	/* Ensure guest can read newly-written shared data from host. */
> > +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> > +	SEV_GUEST_ASSERT(sync, 201, success);
> > +
> > +	/* Ensure host can read newly-written shared data from guest. */
> > +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> > +
> > +	sev_guest_sync(sync, 300, 0);
> > +}
> > +
> > +static void
> > +check_test_common(struct kvm_vm *vm, struct sev_sync_data *sync,
> > +		  uint8_t *shared_buf, uint8_t *private_buf)
> > +{
> > +	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> > +	bool success;
> > +
> > +	/* Initial guest check-in. */
> > +	vcpu_run(vm, VCPU_ID);
> > +	sev_check_guest_sync(run, sync, 100);
> > +
> > +	/* Ensure initial private pages are intact/encrypted. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > +	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
> > +
> > +	vcpu_run(vm, VCPU_ID);
> > +	sev_check_guest_sync(run, sync, 200);
> > +
> > +	/* Ensure host userspace can't read newly-written encrypted data. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> > +	TEST_ASSERT(!success, "Modified guest memory not encrypted!");
> > +
> > +	/* Ensure guest can read newly-written shared data from host. */
> > +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> > +
> > +	vcpu_run(vm, VCPU_ID);
> > +	sev_check_guest_sync(run, sync, 300);
> > +
> > +	/* Ensure host can read newly-written shared data from guest. */
> > +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> > +	TEST_ASSERT(success, "Host can't read shared guest memory!");
> > +}
> > +
> > +static void
> > +guest_test_done(struct sev_sync_data *sync)
> > +{
> > +	sev_guest_done(sync, 10000, 0);
> > +}
> > +
> > +static void
> > +check_test_done(struct kvm_vm *vm, struct sev_sync_data *sync)
> > +{
> > +	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
> > +
> > +	vcpu_run(vm, VCPU_ID);
> > +	sev_check_guest_done(run, sync, 10000);
> > +}
> > +
> > +static void __attribute__((__flatten__))
> > +guest_sev_code(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
> > +{
> > +	uint32_t eax, ebx, ecx, edx;
> > +	uint64_t sev_status;
> > +
> > +	guest_test_start(sync);
> > +
> > +	/* Check SEV CPUID bit. */
> > +	eax = 0x8000001f;
> > +	ecx = 0;
> > +	cpuid(&eax, &ebx, &ecx, &edx);
> > +	SEV_GUEST_ASSERT(sync, 2, eax & (1 << 1));
> > +
> > +	/* Check SEV MSR bit. */
> > +	sev_status = rdmsr(MSR_AMD64_SEV);
> > +	SEV_GUEST_ASSERT(sync, 3, (sev_status & 0x1) == 1);
> > +
> Is there any need to do the cpuid and MSR tests every time the guest code is
> executed ?

It seems like a good sanity check that KVM is setting the expected bits
(via KVM_GET_SUPPORTED_CPUID) for SEV guests. This is also a fairly
common example of the sort of things a guest would do during boot to
detect/initialize SEV-related functionality.

It becomes a little more useful for the SEV-ES/SEV-SNP tests, where cpuid
instructions cause a #VC exception, which in turn leads to a VMGExit and
exercises the host KVM's handling of host-guest communiction via GHCB
MSR/GHCB page.

> > +	guest_test_common(sync, shared_buf, private_buf);
> > +
> > +	guest_test_done(sync);
> > +}
> > +
> > +static void
> > +setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
> > +		  vm_vaddr_t *shared_vaddr, vm_vaddr_t *private_vaddr)
> > +{
> > +	struct kvm_vm *vm = sev_get_vm(sev);
> > +	uint8_t *shared_buf, *private_buf;
> > +
> > +	/* Set up VCPU and initial guest kernel. */
> > +	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
> > +	kvm_vm_elf_load(vm, program_invocation_name);
> > +
> > +	/* Set up shared sync buffer. */
> > +	*sync_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
> > +
> > +	/* Set up buffer for reserved shared memory. */
> > +	*shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
> > +					      SHARED_VADDR_MIN);
> > +	shared_buf = addr_gva2hva(vm, *shared_vaddr);
> > +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> > +
> > +	/* Set up buffer for reserved private memory. */
> > +	*private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
> > +					PRIVATE_VADDR_MIN);
> > +	private_buf = addr_gva2hva(vm, *private_vaddr);
> > +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > +}
> > +
> > +static void test_sev(void *guest_code, uint64_t policy)
> > +{
> > +	vm_vaddr_t sync_vaddr, shared_vaddr, private_vaddr;
> > +	uint8_t *shared_buf, *private_buf;
> > +	struct sev_sync_data *sync;
> > +	uint8_t measurement[512];
> > +	struct sev_vm *sev;
> > +	struct kvm_vm *vm;
> > +	int i;
> > +
> > +	sev = sev_vm_create(policy, TOTAL_PAGES);
> > +	if (!sev)
> > +		return;
> > +	vm = sev_get_vm(sev);
> > +
> > +	setup_test_common(sev, guest_code, &sync_vaddr, &shared_vaddr, &private_vaddr);
> > +
> > +	/* Set up guest params. */
> > +	vcpu_args_set(vm, VCPU_ID, 4, sync_vaddr, shared_vaddr, private_vaddr);
> > +
> > +	sync = addr_gva2hva(vm, sync_vaddr);
> > +	shared_buf = addr_gva2hva(vm, shared_vaddr);
> > +	private_buf = addr_gva2hva(vm, private_vaddr);
> > +
> > +	/* Allocations/setup done. Encrypt initial guest payload. */
> > +	sev_vm_launch(sev);
> > +
> > +	/* Dump the initial measurement. A test to actually verify it would be nice. */
> > +	sev_vm_measure(sev, measurement);
> > +	pr_info("guest measurement: ");
> > +	for (i = 0; i < 32; ++i)
> > +		pr_info("%02x", measurement[i]);
> > +	pr_info("\n");
> > +
> > +	sev_vm_launch_finish(sev);
> Since the above section of this function is actually setup code and is not
> running the test yet, it is best placed in a setup function. My suggestion
> is that you place the above section into a function called
> setup_test_common() and within that function you further separate out the
> SEV-related setup into a function called setup_test_sev() or something
> similar. Then call the top-level setup function from within main().

That makes sense. I'll try to rework this according to your suggestions.

> > +
> > +	/* Guest is ready to run. Do the tests. */
> > +	check_test_start(vm, sync);
> > +	check_test_common(vm, sync, shared_buf, private_buf);
> > +	check_test_done(vm, sync);
> 
> These function names can be better. These functions are not just checking
> the result, they are actually running the guest code. So, may be, calling
> them 'test_start, test_common and test_done are better. I would just

Will do.

> collapse them and place their code in test_sev() only if you separate the
> out the setup code as I suggested above.

Hmm, I did it that way because in the guest_{sev,sev_es,sev_snp}_code
routines there are some type-specific checks that happen before
guest_test_done(), so it made sense to have that in a separate routine,
and seemed more readable to then also have check_test_done() separate to
pair with it. But I'll see if I can rework that a bit.

> 
> > +
> > +	sev_vm_free(sev);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	/* SEV tests */
> > +	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
> > +	test_sev(guest_sev_code, 0);
> > +
> > +	return 0;
> > +}
