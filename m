Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C414234A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhJEXsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:32 -0400
Received: from mail-bn8nam11hn2208.outbound.protection.outlook.com ([52.100.171.208]:38080
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237092AbhJEXsI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfSDdnckkKWBVhHgTyiJwygfSvYHY/g+DHcq3mDoRlLzzSBaX4DbhM+ppNbPaC7l801wDDVfWAAcrqirhZSXI57OT7j/6Ocbc7oHZelaG+kJq8TKLLBm1C5x9t4l+O5tjSHV5ipV1XNYmTQPc8icVtCDxedbXqVXtqxh6qhDaR/+5JFQNVYhNzvg/YzZAnWf76vzsBp82TNbA2y5I0j8Z7aFdIcWZZxe9g10Gp3CtlDh2Y9aVM0s2X1XFhVI2OjY+5J/O5EqGahFqVFXThVW+omXKhSAkUiYz3cBmXUgx08hzQhNY1IGYkydw62T6sLG5kcIotWllPA63ipJ4hG32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcjVDyz3y/g66ja5+h3ghdhJFWcW8t85X0OkjDCWEHs=;
 b=RhKOLBx6xC1eUwTaUmTes71msSxPJ61Y7lVlLRqQqoRGJO0eusUAF8o3YvEUqDQb0jU/zuendgDlBqrLtfZnSGFXqrix1nHIxHwBh1Fu3zRddzebAquB89LL6N4RzS08VyEqe7bXdAxfQuHL7xR+coVQ8qrY9LlMkmmo6vQV1NJJF6wACz5UXT2BIGpqMAWB55+i6ZwCnKJqAMEQtZkYZJmq/bdbbOw8aNDdf754tF8mAIHMEx7rjlP5KAp/1LX1o4TJ8lFe6+xCZB/cVa74uXCW5TLMaps/4ria5gDeRunamltOC7QIuZnskz3HCh96WBCL89ANyrJ5v/0++ITMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcjVDyz3y/g66ja5+h3ghdhJFWcW8t85X0OkjDCWEHs=;
 b=Pwz2uPbOSh5BjHqkk7CVlQpntN10TvgNLNU6aZYtacQutu8JqwXgPcA0k6ZCo/Qt8iE2vuTdJtRB2kCuvASZynMnRep+xdanFfQPaawDsWYeh8viMCHLTfd1C+TPnf3iTKSL5/SZy4QDmZWF2h7wUT69fnzO5VkKisRXbjXXLZ0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:46:00 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:59 +0000
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
Subject: [RFC 01/16] KVM: selftests: move vm_phy_pages_alloc() earlier in file
Date:   Tue,  5 Oct 2021 18:44:44 -0500
Message-Id: <20211005234459.430873-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 23:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d9e2f8b-76c8-4cd3-bad2-08d9885a4890
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925FB7DF54DCFA8EB41007395AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4B64piqwPcnQEeGdODAjeS0MfhCFXvAyfkBTXkc5izYQDChejfctPXeYy5iv?=
 =?us-ascii?Q?DJ8+OzPJ3BX8yjTTwv0o4ZeEveguqM7ZUWzzx8vd4UZjVL8cLunJGZgR57Lp?=
 =?us-ascii?Q?5EkgwhN+Lha29btrSfB6scykRAnCrK3z5+zgQkOkNifwIpFigV4VzxqedRBb?=
 =?us-ascii?Q?ZR0ez7J2x2J9OfCSoCBDkWAxTh1dIsJVUd+Ff7KxalPHEo1YgeMF9p3KgDw9?=
 =?us-ascii?Q?3xRmQZM6CfQmwCPsdkkJiH0gTJ6XL3LAjIWErsChIW6lGwv6BYU+eCN9vYqh?=
 =?us-ascii?Q?pfFDLJbVtrV/oa50dB9WLQhpqgmKAylJ8fdgvGbRnlXVH7vvMduIS1oh/B5i?=
 =?us-ascii?Q?S2tmuvhhdZ2aFNeV7CUS9ks9GHDeI5YgVZardPEQD8vVdkcDCoplU9vzO1x/?=
 =?us-ascii?Q?bR4GJY67O0mnxuBROXrEJgCUEL13ySfYwa9yeTBGUAoc6Uqp0wWesBikIsX8?=
 =?us-ascii?Q?4qei+FtiPURkX5wleboUdc2iqTLcBS/sj0aMqLJhTIbu+aMmmS8gnVLfi81k?=
 =?us-ascii?Q?fniPoPCWedT+ww4YkwmqfHqPzDGYJ4bZ/ynxbfLrXCboDafq43lloV9t4yFd?=
 =?us-ascii?Q?kapTVG1lCkL4thRECJF2nIcLaVFsI9ImSmfhjZmPhblDK9zTwLYh1hPIsLkI?=
 =?us-ascii?Q?L6bXVIu0ynBRjJdA3gnRbbwuuNf0pL0WHfmUTq0uUJM7xelUKe3vjBXPImkY?=
 =?us-ascii?Q?HP41999aH1FA2K/uks1YK49Q/scodnyvm0QQYLNHHzcXJwRypPSj2Igs6s6Y?=
 =?us-ascii?Q?P86fotoayDJl/tx4dUgzxymfDkCyu0xmHzNqOcvQWMGv9kGrJvjQuthietr8?=
 =?us-ascii?Q?ExFvgfmTyWbyfpg7wPKkSspZGk5rBOc1WfiIfMkn0CtZROhWO1nnQaPxK1fq?=
 =?us-ascii?Q?8lGc2HEmC6IpXF/aLctRzLtTY3zu32XK8MXD+48RgxGjsOZ+GZCL1KBJ7LiZ?=
 =?us-ascii?Q?zRQQfPysGYAbbQhESqg36elzduOI/otIYnj/NjMZQjZKbDtZXxEeZsypL84j?=
 =?us-ascii?Q?Pvj6OUrVH1zNjpKTiWj8tRPMuNsVpcQ2UGL3hgUuj0rnaZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oquza7/pfxnSGhTD7Tf7lt13JCkO83+vmihvUwkHeJxHE2si56rM8o4B4QJH?=
 =?us-ascii?Q?PskNQfc45eu3IOoUpu6DdjYCtaMrRQG4F0I59srFU38fv8jFUWL0ccRSrnFv?=
 =?us-ascii?Q?A7D1Ca9jXPQlFQcBc94weIy3lI11tuvRuiRE1fvJIeYyxMYtKB6I6v5HraeJ?=
 =?us-ascii?Q?Wqe/2ChD8rGX5veGORzjtUcla2/hT4gJRH47FtQlUtn6CLrebbHczAUjvsaJ?=
 =?us-ascii?Q?5WlFCqb71OsC/YPvVcbimIeDoaxw5CN2DQkEsEhJzla/hBVbMf5J/oIWILUm?=
 =?us-ascii?Q?AlnL3wF0ACdgINL6/NoZZD1QFS2yrt1yKBEF1WH1/KQDl4FzdgN/POqXxl3j?=
 =?us-ascii?Q?gRWyJ57cc8J0/Vbw4zZd7y8HK9ZWBgEq0xBx0BW1XuseI/sBGdS/XjMy68nd?=
 =?us-ascii?Q?mwCSYSyBmpRFFGIj0DdMbaNKuj0DZ2RpegoJQWQmqXKkMA1h7EUTu3HMEP5R?=
 =?us-ascii?Q?yXQzbraxo3M8a1YauIBK/XNj56qvmqcGr5TIGOLCIK6OWwFPGU4evdt4I5g0?=
 =?us-ascii?Q?Zcgts+3ZN+9jw4rcCxutYSP2ZJNg0DkwVu5cMSpgzHoAac1S4m86atEjS1qY?=
 =?us-ascii?Q?SVL3uxEoSRtwjJRpPhKt+axCnoG1x793lbF/pQp36Wn+ujZVwDAAbqmmtVqV?=
 =?us-ascii?Q?Caj5bO8g35ENuqyBJLcioO4DtIfPC4mX4jpXKNfhEE1Y929ONcC9wlFnYY5r?=
 =?us-ascii?Q?doqSVE3FmMqbI6FRrqx+Ss/PtHhNeRxoBDwpOeHiEd1dQllDH9PSpzM8GhNq?=
 =?us-ascii?Q?hJUJEmkieYgcilHfyze+Qg2jiKn0ad14Llq/Q30v2kwXVCIw2JUhZrNGydkP?=
 =?us-ascii?Q?pTH/s58Bqj7LefrIlDASmu+K3qFBN56+NSYIm5crsfgc+qQklZDv3t5wiDFi?=
 =?us-ascii?Q?uiZxeVog+ob6SO6lKm9wngmFWGKaUHOP9kKq69UzZpf3RxDhQqsMnd5i0he1?=
 =?us-ascii?Q?lHEFT1vTJr61E0FThF0NsKnqd700+Amx1t9o7geEtqSo7TprYrhyzRL6eI1d?=
 =?us-ascii?Q?cTi5ReGyJrFlDCTgokH5l/HigiQSC+aScUWaWCjtYjvqfT1UN2xhzlDTmA0d?=
 =?us-ascii?Q?PzDsw9Zw5DDoPUwZK4Ll1Xn+mdDtbhVLWWRADv18cpDFS1xOXPxPH1yvR67C?=
 =?us-ascii?Q?hOGfRQgWoQxJTjpQ/QTPj+4ad6YlEDmIzapWBbRH/cUVfnJeMQBb+C8wFnkk?=
 =?us-ascii?Q?g56l9Hv9yBQvFoihp1YvzPD2tuPQY/GrQJKAntAqf0yOQ2UKrdt8uJUhMfqc?=
 =?us-ascii?Q?cBMc11vBGdDs3fecwuZmJJ32JH3VGrWkNs4hp6yNlS+zLx4Z+LfHz4oDKCKo?=
 =?us-ascii?Q?Kio4noMFpO3lwJvwZaQRuxO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9e2f8b-76c8-4cd3-bad2-08d9885a4890
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:59.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA3KS8GQYhBeZT79GOn5bxkOsYHRminzHpr/UQCWjtdILSvW3ZUn+UjBxAPVDyn491rew83tVjfVwGz4XLYHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Subsequent patches will break some of this code out into file-local
helper functions, which will be used by functions like vm_vaddr_alloc(),
which currently are defined earlier in the file, so a forward
declaration would be needed.

Instead, move it earlier in the file, just above vm_vaddr_alloc() and
and friends, which are the main users.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 146 ++++++++++-----------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 10a8ed691c66..92f59adddebe 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1145,6 +1145,79 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	list_add(&vcpu->list, &vm->vcpus);
 }
 
+/*
+ * Physical Contiguous Page Allocator
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   num - number of pages
+ *   paddr_min - Physical address minimum
+ *   memslot - Memory region to allocate page from
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting physical address
+ *
+ * Within the VM specified by vm, locates a range of available physical
+ * pages at or above paddr_min. If found, the pages are marked as in use
+ * and their base address is returned. A TEST_ASSERT failure occurs if
+ * not enough pages are available at or above paddr_min.
+ */
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg, base;
+
+	TEST_ASSERT(num > 0, "Must allocate at least one page");
+
+	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
+		"not divisible by page size.\n"
+		"  paddr_min: 0x%lx page_size: 0x%x",
+		paddr_min, vm->page_size);
+
+	region = memslot2region(vm, memslot);
+	base = pg = paddr_min >> vm->page_shift;
+
+	do {
+		for (; pg < base + num; ++pg) {
+			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
+				break;
+			}
+		}
+	} while (pg && pg != base + num);
+
+	if (pg == 0) {
+		fprintf(stderr, "No guest physical page available, "
+			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
+			paddr_min, vm->page_size, memslot);
+		fputs("---- vm dump ----\n", stderr);
+		vm_dump(stderr, vm, 2);
+		abort();
+	}
+
+	for (pg = base; pg < base + num; ++pg)
+		sparsebit_clear(region->unused_phy_pages, pg);
+
+	return base * vm->page_size;
+}
+
+vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
+			     uint32_t memslot)
+{
+	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
+}
+
+/* Arbitrary minimum physical address used for virtual translation tables. */
+#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
+
+vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
+{
+	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+}
+
 /*
  * VM Virtual Address Unused Gap
  *
@@ -2149,79 +2222,6 @@ const char *exit_reason_str(unsigned int exit_reason)
 	return "Unknown";
 }
 
-/*
- * Physical Contiguous Page Allocator
- *
- * Input Args:
- *   vm - Virtual Machine
- *   num - number of pages
- *   paddr_min - Physical address minimum
- *   memslot - Memory region to allocate page from
- *
- * Output Args: None
- *
- * Return:
- *   Starting physical address
- *
- * Within the VM specified by vm, locates a range of available physical
- * pages at or above paddr_min. If found, the pages are marked as in use
- * and their base address is returned. A TEST_ASSERT failure occurs if
- * not enough pages are available at or above paddr_min.
- */
-vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
-			      vm_paddr_t paddr_min, uint32_t memslot)
-{
-	struct userspace_mem_region *region;
-	sparsebit_idx_t pg, base;
-
-	TEST_ASSERT(num > 0, "Must allocate at least one page");
-
-	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
-		"not divisible by page size.\n"
-		"  paddr_min: 0x%lx page_size: 0x%x",
-		paddr_min, vm->page_size);
-
-	region = memslot2region(vm, memslot);
-	base = pg = paddr_min >> vm->page_shift;
-
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
-			}
-		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
-	}
-
-	for (pg = base; pg < base + num; ++pg)
-		sparsebit_clear(region->unused_phy_pages, pg);
-
-	return base * vm->page_size;
-}
-
-vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
-			     uint32_t memslot)
-{
-	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
-}
-
-/* Arbitrary minimum physical address used for virtual translation tables. */
-#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
-
-vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
-{
-	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
-}
-
 /*
  * Address Guest Virtual to Host Virtual
  *
-- 
2.25.1

