Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2059047C32C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhLUPk6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 10:40:58 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:48513
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234903AbhLUPk5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 10:40:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQZ4Xpee3b4+fYj0HUGznedUN/cIo4z+3tdC9PeqRn5R0lG4CDXSrltgomaKYmHOEt+wriLD95kPrg6q0DotyT4bCGxQQ+nk1Vl0IaD20vpxqxfd+hUH5y0nLNm1od8mWTvzUAeDTSABOFBQdiWw9TaLKvwIk1kn+L7IfYjYnL1Q7bk4pKuenzUn//5FvUV+AK64NpW8BDMVuXS062yxvooKwuEimqWhrklWaaJKptKvfB2EziL0pIVa12QFWiwTwB4fBvsCM8MnDFNxjWp3G5Qgc/rmo1onfcFLC53biAjYSe0ws9UqDiqLQ4JC294TPHZbC3kqDaby9BsHisqs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qRS/hlO90+YIwBI5WjZrnA7MKaWqylJlkwhpkYXQK4=;
 b=cioAepZLbm8UJm89/cNa9JuaAIx12dPXrrOhZjPWP/WsYsrmPfGGIXRmHn/KJkV9f/IBGh++t5EM/DKnKso5pN4geB6jeWgP/7Ml69Nyxzhl54Pb+9uhnFKz+Mz7cQV4QqqRbE0cip1FjIkzf/mh+d0+JKBp+qNkNrbP5Egv+Caxw08D/ViQQOg1QFUpQDUI2x/2dvtHGIpGKZgETSFVC8t8M3QqOqeGDPMnvD2G/JbkpzxAd/3ZnsIM34G0re2BNzJaRKpJqAA5ZaPFzWR0/Sm/UHx/OHfmiNzMF6WHZia3Xfn0AECYrwczsGU2ooOBxDTkr/FFmVwoep/YwJda2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qRS/hlO90+YIwBI5WjZrnA7MKaWqylJlkwhpkYXQK4=;
 b=ZHc423V3guM/OMfQx+5rONqPZdtWcs7T7uch3ejBp4biS+zMDi2pu99tZhKnEzhvHSZsHIn5yw0NMFE1bcwWpcKG5Z57TXVgvbamyj3KOCqlmENNAfLXIkBWZrVyBKj1jQoI8/I8v6EVnMRt8MxDOSXDhBzGYsra4sEcKmWHBNE=
Received: from DM6PR07CA0128.namprd07.prod.outlook.com (2603:10b6:5:330::20)
 by MWHPR12MB1565.namprd12.prod.outlook.com (2603:10b6:301:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 15:40:54 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f5) by DM6PR07CA0128.outlook.office365.com
 (2603:10b6:5:330::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Tue, 21 Dec 2021 15:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 15:40:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 09:40:53 -0600
Date:   Tue, 21 Dec 2021 09:40:36 -0600
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
Message-ID: <20211221154036.ivef7wuoblavlmsf@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-9-michael.roth@amd.com>
 <Yb/hGzeiRi0AwfV6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yb/hGzeiRi0AwfV6@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b63d3d-9313-4b2b-55e5-08d9c4984676
X-MS-TrafficTypeDiagnostic: MWHPR12MB1565:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15650EC7A33EB16D8CC51DD4957C9@MWHPR12MB1565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mYkJbm7DZ10Qr28+PIoWA6TicjNY0NIPl9IkbRwzlfvsyGM3SHzjdOPJHKSh2F1jToX4FSZXZx97RdZ5D/eTVe11cd6eNAUFZ6viURq6TNdCW/46o6FC963VS0J0R73nsJfLeeAuHLX5aWOOGs0TQI1ePBiTqI4w5UaLiXPoFE7gC7CX1OHNYhoeOnQzTjqaLB6Pl8kpz/M3zBDZfrJNIVSAxlGG+DD5gHRAv17Qdl0A740VzixECEde/tsps7sQnij8fQJbLvntKd79Pd+DQqtD95WZ5sDzPn8WKbAePKoEDpPUvOAqRIQklJs0jWF9xMoY/nPBStwg6i4dXuOOPCGT7hz7RhGWji8zuP4mo6lKDqsdkvrNk8pw97kQwCzYjJSCcLVjC5PGtctc/Rm93V1fJ+bEONE9dQMjMf3DUPjaP220a3UHmyCyhpojcRuscUe0/pRSEpN9wupFleq/+whucM8HWThOx5xvVmeaql2TeSTsPsvEffyLaPPBPq3eNB7XCZKOZicBxIFdfT68VnjQnj0ZAdvyR0QANGAEMw+SYeV2KstZrz7vOiLfHuXq+sWcgzCDnyOiIjVGjYaur1eDrzxPYdkcNDhDrXMQ+HeQkmo3KBfYMTgzSvdVn7cpj37fnLskPOdV/VbES2qOVC8dbpVsQ+DlsPmNNqtJX+gxKR8BrAME+5kPkZA7rMntQ3MiD7Ut3+OyHvU1TQ0ZHjraTCq7W0M33kZ7XDWjuBz7WDZCjRR6nlsFh+SrpHbbzJdf2bBVwuQrmPZ4RMT7WmEchr4rJayEwhTsBcROgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(2616005)(186003)(336012)(83380400001)(426003)(16526019)(6916009)(82310400004)(44832011)(26005)(8676002)(81166007)(2906002)(5660300002)(6666004)(86362001)(70586007)(1076003)(70206006)(4326008)(316002)(36756003)(508600001)(54906003)(7416002)(40460700001)(36860700001)(30864003)(356005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 15:40:54.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b63d3d-9313-4b2b-55e5-08d9c4984676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1565
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 20, 2021 at 01:49:15AM +0000, Mingwei Zhang wrote:
> On Thu, Dec 16, 2021, Michael Roth wrote:
> > A common aspect of booting SEV guests is checking related CPUID/MSR
> > bits and accessing shared/private memory. Add a basic test to cover
> > this.
> >
> > This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
> > subsequent patches.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  tools/testing/selftests/kvm/.gitignore        |   1 +
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  .../selftests/kvm/x86_64/sev_all_boot_test.c  | 255 ++++++++++++++++++
> >  3 files changed, 257 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> >
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index 4a801cba9c62..cc73de938a2a 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -43,6 +43,7 @@
> >  /x86_64/xen_vmcall_test
> >  /x86_64/xss_msr_test
> >  /x86_64/vmx_pmu_msrs_test
> > +/x86_64/sev_all_boot_test
> >  /access_tracking_perf_test
> >  /demand_paging_test
> >  /dirty_log_test
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index ccc382a827f1..6f250e190fde 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -81,6 +81,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
> >  TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
> >  TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
> >  TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
> > +TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
> >  TEST_GEN_PROGS_x86_64 += demand_paging_test
> >  TEST_GEN_PROGS_x86_64 += dirty_log_test
> >  TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
> > diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > new file mode 100644
> > index 000000000000..329a740a7cb2
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > @@ -0,0 +1,255 @@
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
> > +static void guest_test_start(struct ucall *uc)
> > +{
> > +	/* Initial guest check-in. */
> > +	GUEST_SHARED_SYNC(uc, 1);
> > +}
> > +
> > +static void test_start(struct kvm_vm *vm, struct ucall *uc)
> > +{
> > +	vcpu_run(vm, VCPU_ID);
> > +
> > +	/* Initial guest check-in. */
> > +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 1);
> > +}
> > +
> > +static void
> > +guest_test_common(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
> > +{
> > +	bool success;
> > +
> > +	/* Initial check-in for common. */
> > +	GUEST_SHARED_SYNC(uc, 100);
> 
> Probably, you want to use macros to represent those states which should
> make it more clear. Otherwise, it is quite cumbersome for readers to
> remember the meaning (or state) of 100/101/102.

I agree with that approach in general, but in this case it's a bit
awkward since, these aren't necessarily similarly grouped tests where each
test falls under a certain category of TEST_GROUP_x where a macro would
provide additional information about the nature of the tests related to a
particular SYNC() call, in some cases it's an aggregate of multiple
things, for instance...


> > +
> > +	/* Ensure initial shared pages are intact. */
> > +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> > +	GUEST_SHARED_ASSERT(uc, success);
> > +
> > +	/* Ensure initial private pages are intact/encrypted. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > +	GUEST_SHARED_ASSERT(uc, success);
> > +
> > +	/* Ensure host userspace can't read newly-written encrypted data. */
> > +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> > +
> > +	GUEST_SHARED_SYNC(uc, 101);
> 
> ditto.

...here 101 exit is both a checkpoint that the 2 previous tests have passed,
and that a 3rd test is ready for the host-side to complete on its end.

> > +
> > +	/* Ensure guest can read newly-written shared data from host. */
> > +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> > +	GUEST_SHARED_ASSERT(uc, success);
> > +
> > +	/* Ensure host can read newly-written shared data from guest. */
> > +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> > +
> > +	GUEST_SHARED_SYNC(uc, 102);
> 
> ditto.

...here 102 exit is for the "Ensure host can read newly-written shared
data" test, since the host is needed to complete the test. But prior to
that there was another test checking things in the other direction:
"Ensure guest can read newly-written shared data from host."

I could try adding additional SYNC() calls to get things closer to a
1:1 mapping between test/SYNC() so we can give each particular
test/SYNC() point a unique/meaningful identifier, but that's potentially
a lot of additional exits/SYNC()s depending on how tests are added over
time, and it's compounded further by the following situation, where a
conversion of this file would leave us with something like:

  guest:
    //set up some tests relating to x for host to complete
    SYNC(..., TEST_GROUP_x_READY)
  
    //complete tests relating to y
    SYNC(..., TEST_GROUP_y_COMPLETE)
  
  host:
    vmrun()
    CHECK(..., TEST_GROUP_x_READY)
    //complete tests relating to x
  
    //set up some tests relating to y for guest to complete
    vmrun()

    CHECK(..., TEST_GROUP_y_COMPLETE)

where it's easy for a reader to get confused as to where
TEST_GROUP_x_COMPLETE is, whether it's related to the subsequent
*_y_COMPLETE, etc, because they might be expecting the same sort of pairing
we get for guest->host with SYNC()/CHECK(), but for host->guest the pairing
is more like vmrun()/SYNC()/CHECK(), so attempting to write things to
alleviate that possible confusion, we need to introduce exits that purely
serve the purpose of helping the reader along, and end up with something
like:

  guest:
    //set up some tests relating to x for host to complete
    SYNC(..., TEST_GROUP_x_READY)

    SYNC(..., TEST_GROUP_x_COMPLETE)
  
    //complete tests relating to y
    SYNC(..., TEST_GROUP_y_COMPLETE)
  
  host:
    vmrun()
    CHECK(..., TEST_GROUP_x_READY)
    //complete tests relating to x

    //resume guest to it lets us know it is done with that test group
    vmrun()
    CHECK(..., TEST_GROUP_x_COMPLETE)

    //set up some tests relating to y for guest to complete
    vmrun()
    
    CHECK(..., TEST_GROUP_y_COMPLETE)

But what about TEST_GROUP_y_READY? Where is that set up? Take 2:

  guest:
    //set up some tests relating to x for host to complete
    SYNC(..., TEST_GROUP_x_READY)

    SYNC(..., TEST_GROUP_x_COMPLETE)

    //let host know we're ready to run TEST_GROUP_y
    SYNC(..., TEST_GROUP_y_READY)
  
    //complete tests relating to y
    SYNC(..., TEST_GROUP_y_COMPLETE)
  
  host:
    vmrun()
    CHECK(..., TEST_GROUP_x_READY)
    //complete tests relating to x

    //resume guest to it lets us know it is done with that test group
    vmrun()
    CHECK(..., TEST_GROUP_x_COMPLETE)

    //set up some tests relating to y for guest to complete
    vmrun()
    CHECK(..., TEST_GROUP_y_READY)
    vmrun()
    CHECK(..., TEST_GROUP_y_COMPLETE)

...which to me seems less readable that just treating each SYNC() as a
unique checkpoint and relying on comments to explain the individual
tests: 

  guest:
    //set up some tests relating to x for host to complete

    SYNC(..., CHECKPOINT1)
  
    //complete tests relating to y

    SYNC(..., CHECKPOINT2)
  
  host:
    vmrun()
    CHECK(..., CHECKPOINT1)

    //complete tests relating to x
  
    //set up some tests relating to y for guest to complete
    vmrun()

    CHECK(..., CHECKPOINT2)

Really don't mind changing things, but just doesn't seem like it would
make things more readable than the current approach. I could add
actual CHECKPOINT1/2/3 macros to make it clearer how SYNC() is being
used here, but it seems like a waste adding a bunch of '#define
CHECKPOINT1 1' etc.

> > +}
> > +
> > +static void
> > +test_common(struct kvm_vm *vm, struct ucall *uc,
> > +		  uint8_t *shared_buf, uint8_t *private_buf)
> > +{
> > +	bool success;
> > +
> > +	/* Initial guest check-in. */
> > +	vcpu_run(vm, VCPU_ID);
> > +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 100);
> > +
> > +	/* Ensure initial private pages are intact/encrypted. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> > +	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
> > +
> > +	vcpu_run(vm, VCPU_ID);
> > +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 101);
> > +
> > +	/* Ensure host userspace can't read newly-written encrypted data. */
> > +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> 
> I am not sure if it is safe here. Since the cache coherency is not there
> for neither SEV or SEV-ES. Reading confidential memory from host side
> will generate cache lines that is not coherent with the guest. So might
> be better to add clfush here?

On the guest side, the cachelines are tagged based on ASID, so in this case
the guest would populate it's own cachelines when it writes new data to
private buf.

On a host without SME coherency bit, there is a possibility that whatever
data the host had previously written to private_buf with C=0/ASID=0, prior
to the guest writing to it, might still be present in the cache, but for
this test that's okay since the guest has purposely written new data to
confirm that the host does not see the new data. What data the host
*actually* sees, stale cache data vs. new reads of guest private memory
with C=0 (e.g. ciphertext) are both okay as far as the test is concerned.
clflush() would probably make sense here, but if failure to do so
somehow results in the above assumptions not holding, and the test ends
up seeing the newly-written data, we definitely want this test to fail
loudly, so leaving out the clflush() to cover that corner case seems
like a good idea.

On a host with SME coherency bit, I believe (based on a recent writeup from
David Kaplan) each new read/write with a different C-bit/ASID than what was
previously written would force an eviction, so we don't need to worry about
the stale cases above, and the test should work in that scenario as
well.

Thanks!

-Mike
