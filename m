Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD04234AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhJEXsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:50 -0400
Received: from mail-bn8nam11hn2217.outbound.protection.outlook.com ([52.100.171.217]:8641
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237129AbhJEXsc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M07DhvzqeVLnZQIYljCyUxp+axU1UYRxzovSXgswyLQws83AhsH2YHzwwRAKmPUWQ76z1qBJnYg662CFmLzB7oDCgwniWcNbBk83M7Mg4YldyBQ04OY/EmGpZAOAVaoFlP/rIK3bDTQ5Lp7sVO2bXeortVFj3OqQQ/KCnO3oq8Q0qXpD5IR7ls7nNGLFCGHijUS33Z5bza1WpQPvLpgookNBrB2plJCEcA5P0F7CMDhoNyZZ6NgcN17mO6/VhK1vpzEllKcyNcnZ759oCDcX9h6aqtjSkpNEj++5YUycYxxzurlxwuIWPTrHoUkSnWyuDxLYqiHJBvrd6pmps4Zwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SIZvFcjGmuBgM+NGicSg0h8HP4qi8Yi76JXDlGCe7E=;
 b=HRDmYOeNIV0X3GXgpUsw+jHshxCbZaxWcQRi5fRfoGwMXXABvPI3OtmJqnsuRdorBSp0PdprwbyOrs/xuR82l0DLFCqnRN3acfEC48xuvB9JbZuRqRE1x0g9QsVype9folP0frfRwgmKS9hEfGSAWl3RGAWWv6R3BIWkoSqXcU3cKEgLGrX1IJ9pNQP+Hi7e3prpjELigagZgU4aEwPuHGn80NNscrCdjPKPfY3czGX0t3S8D0l7+DvQpPa6Zh+60V74aDnBg2qI/pfQ9UK2A/2nOaHNPDEzm4bVK2h4zz5Hxx12hvUHwA+VIG6XNK59D/xuU4WGm3BA4FFyGdzunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SIZvFcjGmuBgM+NGicSg0h8HP4qi8Yi76JXDlGCe7E=;
 b=nalOvURB8L38LumocejYf7okYedX3UXdTxxVKyDLexkYieN3e5zUuDGC0kPwCbPm7rdNSozyIzCvnACwYMeU89ScE8lC61A42oP3P6Jz/D5QbJ2YP09QFo5qkoP1obonldl1qiBgGot/5Fv212+m8PdjKG1H77yEPPzuBWbcRMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:46:01 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:46:01 +0000
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
Subject: [RFC 02/16] KVM: selftests: add hooks for managing encrypted guest memory
Date:   Tue,  5 Oct 2021 18:44:45 -0500
Message-Id: <20211005234459.430873-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::16) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 23:46:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b5c93d-2148-40f5-42fe-08d9885a499c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925C6C4AD6D00ADE5F8F6B495AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/huW8s8o4wubo17upFyE8VjPWPWJNC2E/uxB3Z0gNvXBafZivbdU2/UgMaib?=
 =?us-ascii?Q?I5kLL03HHK7FezdABTDsOx7+mFwhgQycLL2g2Kkwqv3RqL08Yijt8bvzAAzx?=
 =?us-ascii?Q?3dctcwM+sGWuYOPfmEEkIgrU8mkiq3jXdbHwvxoeorZpyUKxSkdv2q1GyDFL?=
 =?us-ascii?Q?ncC03LiAV3jTue7VV22eVj638cTlwJVvYIdSjIuA44dg0AfMs+9xtafybqTF?=
 =?us-ascii?Q?Yi/ayyj8KuXuVCqyQaOQCOYYDeQgMlBwoEH/qIc2/2L7CdqQaBRJr+Ae7FnO?=
 =?us-ascii?Q?B+1DwVUFwLWTLYijIlM42UJlZx9sTvDV/HGRivPFOdgyoV8gItMza/th+4hw?=
 =?us-ascii?Q?u+Uw57bbupLAxCwjVZNOUrApynhJiIXQbjop3AGnznjc2qpcBEBlIoZws8+f?=
 =?us-ascii?Q?jYizsnx+PLlVfElXVnZ1maOLUAUPHvedRHK3PHMMo8/UWJGTev16TiGQyGH8?=
 =?us-ascii?Q?NK4IalVkaI8mAeCYUzWi2mDQx89Baxm/3v7husGtWbdwQNTZGQqVdi4OXVhP?=
 =?us-ascii?Q?uW6OZiP9lXkFVR7mFyLKEKOTERNDKMQbVgFd/7OJZH8bNzvQzX7GWGUnL0v6?=
 =?us-ascii?Q?JdOWXd7yFFtMsW5BWXc/XHDTpYVO+XMwdNO4C68mSxUYXDzgbL2IXiStpg64?=
 =?us-ascii?Q?PWKauFUbSWj8TZ6M+/qa09nspjL5m2Bbr8YMTN6Wf4wInmWac3J6ylYl32jk?=
 =?us-ascii?Q?TX5d1uNjwMPdjoXrSv8xKdPhb7M+dP3vMh/SO0NeE3OAXoxdEPJEd5GnTaH5?=
 =?us-ascii?Q?tVQ3p5G5UQcYQyta8VAJx+0jcivgk3WA5w+iz4WmM39+WOhXtzTghvoycA7C?=
 =?us-ascii?Q?dg4hYfklDMgOvTQshhvKk6vHJKWExmaMGwxY9TJ3HkZn5dEh83xL+ddtQxYS?=
 =?us-ascii?Q?G82JZ71PdrG/LOm+/seRtsi6CQM/I7U/oXhynNvW7v8VayXQOxT0ebTViEVi?=
 =?us-ascii?Q?ldzcuGr6ia1AgQnmWo0W/vo/k50xSVzdhV82yLHJMPoF38Dbe4rbva+1wztq?=
 =?us-ascii?Q?AuRj+1HF7AiAJXe/pt/vMVdwNTyfc9kOGhB+NejVWeZpY3Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlV7kvCTxLl/0oZAlZxLectgBBIxIAfVOWfRN9/SO0MPcdcYizvQJd7pHlcd?=
 =?us-ascii?Q?uTd9HC2h9KZZ5t6dRHCOqa9GT+u9MOO/6fssvCaBQuXDTC1RwrdJT0XAIJGh?=
 =?us-ascii?Q?/quXBSKQARLvZTswpRDhMg765/G+aU8zu58Z5aBA5eY79dTkV2eaNr22bl4L?=
 =?us-ascii?Q?K1zoPZHeQw5EmOnnr39Rvzs8cA4tfuxIBmrLdF1Bn9SrXMenJdDylniXS9sZ?=
 =?us-ascii?Q?42eG363bw8g0rX+IIpspZtsMrsCHs9lPLlZ4vMEYa/jzPF5GY2AsExCYhPLM?=
 =?us-ascii?Q?MOZoAvaxQY1sXE7GPX+FmlfmY6h+2Pqi4U1UPVaz1JEDnGyEhgcCON/gWwID?=
 =?us-ascii?Q?74NWjbi2CTpEPfZwUUeGZPaKLo/OHRST4JKBOezIQqFaus7iHpR01k7/BI4u?=
 =?us-ascii?Q?zI6bajWJGWrRfzodwANbIGl8YOZ48xkHv2wFiB15c5JonE59SdV7ksTbgxN3?=
 =?us-ascii?Q?ySKSS+xNI2FFLNdBACxhnIwLrFxSjtLEx7xdrd2eU5ns4ijggcQIhGyR3/5X?=
 =?us-ascii?Q?bKONtQepkpmih8ZOsw4exOYZshFr+vFI6wOPa+xvWT6460X5nJDcCuRQ/+cO?=
 =?us-ascii?Q?JLNEPVimq/Prld4Lo9r5FFcsnxtWarVZRthdmEjAn87+4CBPPwy0dHkLkjtp?=
 =?us-ascii?Q?LTgvCSWkykQJ9ZhIpPXcntxnttUAZA6kfGlTOjJ93O4UOF4kW4HUqkfbaR7o?=
 =?us-ascii?Q?CEQEbE60J0RBGmaezxv5vxwW0MN1qcvQBHQ/kxfRjDBCSF+/sNYtGDQK9pht?=
 =?us-ascii?Q?qBWqzC+JdV3+cwiUc9Hz20QqvxfHBRXEAoyEvnaDly3cmKLBOWujK0hJu0bE?=
 =?us-ascii?Q?JFW7w9TWFtWGxQhbriB7ShnTquYEctU9n89Ut2MbrA8PF1S+ENZKjygYL+YS?=
 =?us-ascii?Q?y4ayzMNhIY7uMFMoxEz9655isUTOZULT2y1dXD8MB8F3T1JuWDq0C0dU6T/U?=
 =?us-ascii?Q?ef1G92NJkpqMuSl1vweum9alZtHT9T0e5B5lXYY1nFxP6W405e8Ld30sL+Pf?=
 =?us-ascii?Q?dA8wXCntisx3nq5yRNiX9MXh5Up9k9eObbBNpe8DH6kEIE79t9IjxRt65Hir?=
 =?us-ascii?Q?NcQhPtT/E32t2SzDuVLqOnZ2ftNozOBSOtJiDVBD0Mr+m8D8ne2YJR5Zhl6L?=
 =?us-ascii?Q?woFmWtOPuR8FNdfM03/WsP0AasldCpWFZI9iBjYvu3C3Bs6MPiOK3yIwS+Xr?=
 =?us-ascii?Q?aTnCyNfi99Fa+n4+bfMZ4DqhwyeEQt9e7JmiXinAOBY2BudPbRn5ZDYUeD2o?=
 =?us-ascii?Q?JHo1hSfdyTHICTt66F/CPOHIb1BZy5suv7KnWKA3t6CkwI/o93E+1wmlm8Nh?=
 =?us-ascii?Q?rhQJpJqzMC9lXmriZa2bjg3I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b5c93d-2148-40f5-42fe-08d9885a499c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:46:01.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntsqX5hv3o5YDkPKinV5Az2D1yPlZqsPN4E0vxhQwT9BzrhTRtNv+NjPnxAUoKzrDAPLVFrXBZKVitzuxN6wQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

VM implementations that make use of encrypted memory need a way to
configure things like the encryption/shared bit position for page
table handling, the default encryption policy for internal allocations
made by the core library, and a way to fetch the list/bitmap of
encrypted pages to do the actual memory encryption. Add an interface to
configure these parameters. Also introduce a sparsebit map to track
allocations/mappings that should be treated as encrypted, and provide
a way for VM implementations to retrieve it to handle operations
related memory encryption.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  6 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 63 +++++++++++++++++--
 .../selftests/kvm/lib/kvm_util_internal.h     | 10 +++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 010b59b13917..f417de80596c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -348,6 +348,12 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
+void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
+			      uint8_t enc_bit);
+struct sparsebit *vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot,
+					     vm_paddr_t *gpa_start,
+					     uint64_t *size);
+
 /* Common ucalls */
 enum {
 	UCALL_NONE,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 92f59adddebe..c58f930dedd2 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -631,6 +631,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 		    "rc: %i errno: %i", ret, errno);
 
 	sparsebit_free(&region->unused_phy_pages);
+	sparsebit_free(&region->encrypted_phy_pages);
 	ret = munmap(region->mmap_start, region->mmap_size);
 	TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i", ret, errno);
 
@@ -924,6 +925,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
+	region->encrypted_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
 		guest_paddr >> vm->page_shift, npages);
 	region->region.slot = slot;
@@ -1153,6 +1155,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
  *   num - number of pages
  *   paddr_min - Physical address minimum
  *   memslot - Memory region to allocate page from
+ *   encrypt - Whether to treat the pages as encrypted
  *
  * Output Args: None
  *
@@ -1164,11 +1167,13 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above paddr_min.
  */
-vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
-			      vm_paddr_t paddr_min, uint32_t memslot)
+static vm_paddr_t
+_vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, vm_paddr_t paddr_min,
+		    uint32_t memslot, bool encrypt)
 {
 	struct userspace_mem_region *region;
 	sparsebit_idx_t pg, base;
+	vm_paddr_t gpa;
 
 	TEST_ASSERT(num > 0, "Must allocate at least one page");
 
@@ -1198,10 +1203,25 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		abort();
 	}
 
-	for (pg = base; pg < base + num; ++pg)
+	for (pg = base; pg < base + num; ++pg) {
 		sparsebit_clear(region->unused_phy_pages, pg);
+		if (encrypt)
+			sparsebit_set(region->encrypted_phy_pages, pg);
+	}
+
+	gpa = base * vm->page_size;
 
-	return base * vm->page_size;
+	if (encrypt && vm->memcrypt.has_enc_bit)
+		gpa |= (1ULL << vm->memcrypt.enc_bit);
+
+	return gpa;
+}
+
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot)
+{
+	return _vm_phy_pages_alloc(vm, 1, paddr_min, memslot,
+				   vm->memcrypt.enc_by_default);
 }
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
@@ -2146,6 +2166,10 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 			region->host_mem);
 		fprintf(stream, "%*sunused_phy_pages: ", indent + 2, "");
 		sparsebit_dump(stream, region->unused_phy_pages, 0);
+		if (vm->memcrypt.enabled) {
+			fprintf(stream, "%*sencrypted_phy_pages: ", indent + 2, "");
+			sparsebit_dump(stream, region->encrypted_phy_pages, 0);
+		}
 	}
 	fprintf(stream, "%*sMapped Virtual Pages:\n", indent, "");
 	sparsebit_dump(stream, vm->vpages_mapped, indent + 2);
@@ -2343,3 +2367,34 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
 
 	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
 }
+
+void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
+			      uint8_t enc_bit)
+{
+	vm->memcrypt.enabled = true;
+	vm->memcrypt.enc_by_default = enc_by_default;
+	vm->memcrypt.has_enc_bit = has_enc_bit;
+	vm->memcrypt.enc_bit = enc_bit;
+}
+
+struct sparsebit *
+vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
+			   uint64_t *size)
+{
+	struct userspace_mem_region *region;
+	struct sparsebit *encrypted_phy_pages;
+
+	if (!vm->memcrypt.enabled)
+		return NULL;
+
+	region = memslot2region(vm, slot);
+	if (!region)
+		return NULL;
+
+	encrypted_phy_pages = sparsebit_alloc();
+	sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
+	*size = region->region.memory_size;
+	*gpa_start = region->region.guest_phys_addr;
+
+	return encrypted_phy_pages;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index a03febc24ba6..99ccab86115c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -16,6 +16,7 @@
 struct userspace_mem_region {
 	struct kvm_userspace_memory_region region;
 	struct sparsebit *unused_phy_pages;
+	struct sparsebit *encrypted_phy_pages;
 	int fd;
 	off_t offset;
 	void *host_mem;
@@ -44,6 +45,14 @@ struct userspace_mem_regions {
 	DECLARE_HASHTABLE(slot_hash, 9);
 };
 
+/* Memory encryption policy/configuration. */
+struct vm_memcrypt {
+	bool enabled;
+	int8_t enc_by_default;
+	bool has_enc_bit;
+	int8_t enc_bit;
+};
+
 struct kvm_vm {
 	int mode;
 	unsigned long type;
@@ -67,6 +76,7 @@ struct kvm_vm {
 	vm_vaddr_t idt;
 	vm_vaddr_t handlers;
 	uint32_t dirty_ring_size;
+	struct vm_memcrypt memcrypt;
 };
 
 struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid);
-- 
2.25.1

