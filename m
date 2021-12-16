Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE968477A59
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhLPRRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:17:24 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:43624
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235577AbhLPRRX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:17:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go85IwwwBVGi0dEuRWs5l89QM3fPqu/ehOu3YbkG5Rdf6TyZFwt88yNVhQnVXecrkboqoFjc+zsRaVqxfLbWI0pG9rRaiH3xSfEGh5KG0ha9xgLJiS5Db7pevf8RF2cJoyy2I1r+BZFoj8PJX1QgODCGi3V6zP4TmI4Bm6toI5+zGPdEYAtGLOsvJt0e9u7sqagrmEK1PhraPpRneycIWgwL+FnA1aem80LsQGwDbExRa7hj9Ec7LjP4id19ONKxj6CFdygn2JmN47S6NulTXKPJiOAdF3OjlAukdSzaBADFIAy82gcZ/eYy7SQpW128DDdRrzD37GuXesY8xV8KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Ct4cXEKJf82YgjFKUlhGwkdp6eG/BfpKBkyRdkKXg=;
 b=fY56NNVsix7XcGn/Crb87SOB4MIFpAOJcbFktuhcJImqPkUJHAbozW69ZU+Am1RxKxB+WKibyDG8KphilB27WmAA42bw4kw2BMCe+/He+pWiZQIr67ZBjT9CJ7hj5uZbSZvsrySuPVRzAiS1pOAHz/XdwRCq+Mzm7WPx5MXEEm2hucgWcIXU5HJt9BxHEL117fTcLRAQo1DRCtWCEs/Q9WPLAI8J2RKRfiUfkBpjy+ATQDGmOGdtd2F/jp5sXRcRTYYsCMcrUIky8/SMZ9VcEauBUQwyIiRCb/fDEbUZ/k8zgACSW1EYR4jJPExFR/49vinaQ1d1QmouBZBtIW1iYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Ct4cXEKJf82YgjFKUlhGwkdp6eG/BfpKBkyRdkKXg=;
 b=A9sUWx8isGcTOvj0Z2XGevo9XIJzrDHRDkO+e5ZJmrj5rrHlwsX03XkAqdj2Lb1jl3pduaBP7hvbXcZ18BrZx0nBzoNuhhybhKlASMFh9Aa/WeAoJKD2RdqSk86gAHKAt9jzLYxUgKab96wDu8+R+hePHdZApCQEj/RkJs7nVvA=
Received: from MWHPR2201CA0060.namprd22.prod.outlook.com
 (2603:10b6:301:16::34) by DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 16 Dec
 2021 17:17:21 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::95) by MWHPR2201CA0060.outlook.office365.com
 (2603:10b6:301:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 17:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:17:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:17:20 -0600
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 03/13] KVM: selftests: add hooks for managing encrypted guest memory
Date:   Thu, 16 Dec 2021 11:13:48 -0600
Message-ID: <20211216171358.61140-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c73d17f-5117-4bb2-bed0-08d9c0b7ebc1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50407855D7AE722AB16CD1EB95779@DM4PR12MB5040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzVijF7XjZscgWFAfUf8FPuw1/XWgcYCwZTzTEktYbzjD5/vA5JPYT7kzdFjzRjn/jwNtwPvWqzOdbGV3hHw73aMlw2OewmKu/4+nyx3r4Qy0Q3bNiQbCiUE+dAV/79+0GWU6AKRQRnAyyALPwGHI5jnguW8RAYQLbFInIc6c3hU5cDlMJsXb6y4DOHFLHZP+DM04nAcY2+UQSXpE4eiBfhMzwntZm3Bc01kMtZTjN1Mbc3/8YProx1Dujh8RgVeJJLcy93lP6XmHCmimfW31Kn+UP9jd2mJjC8V+VglWoYoAuHLOVWYx2JlgxBikXwetxBmKp8TNU/PYh/BPWuMTHRSEGujMRztgJqbC5hddl0WLQVUGyS61HHm7pF/G6B4M4SixoRETx5aGdWdPZ02GERS34Zq1GPmcT6brHz7A5Pz0bwHZbg1sQfUl7RjOj4OI5k5VHUGfgggtLkzZK+TqIIMQHlUraiJCVZR+4jeGffwpd3gmlCqo3IaR3zxooz/XquU1GBd5qvXzNGyaEisfnbxwYFacyLJRyfsZAik3JYUo8DONKhbcmh1uTi9ure55SproM1N2/vOCYaWRLVhNou6K3JHQfA0eDqoJj03OM7MlvTOIRmU2jL9kq2HiKwmhXspWy+Z8CM4Zpq20Ffgfc9I3w4WXC4bYYjidbwL9aV5zATo7xeO/2iEs7S9gdKKdrZKLzQNP6HievScx6Awe/nKgKCUtRhwT+dVGJMCsCjNAm0GAqRS1iYebs1H7BHW52qF3QAUzHTojhNxOMIHxqaxzMHEQeAZv9qi32GGOZE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(16526019)(186003)(8936002)(26005)(6666004)(83380400001)(316002)(81166007)(336012)(70586007)(4326008)(47076005)(2906002)(6916009)(356005)(36756003)(54906003)(1076003)(426003)(508600001)(7416002)(40460700001)(36860700001)(8676002)(82310400004)(44832011)(70206006)(86362001)(2616005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:17:21.4808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c73d17f-5117-4bb2-bed0-08d9c0b7ebc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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

Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  7 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 52 +++++++++++++++++--
 .../selftests/kvm/lib/kvm_util_internal.h     | 10 ++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4e2946ba3ff7..58856339210a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -365,4 +365,11 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
 
 uint32_t guest_get_vcpuid(void);
 
+void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
+			      uint8_t enc_bit);
+
+const struct sparsebit *vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot,
+						   vm_paddr_t *gpa_start,
+						   uint64_t *size);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f0f0250847f3..dfedf82207e1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -626,6 +626,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 		    "rc: %i errno: %i", ret, errno);
 
 	sparsebit_free(&region->unused_phy_pages);
+	sparsebit_free(&region->encrypted_phy_pages);
 	ret = munmap(region->mmap_start, region->mmap_size);
 	TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i", ret, errno);
 
@@ -932,6 +933,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
+	region->encrypted_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
 		guest_paddr >> vm->page_shift, npages);
 	region->region.slot = slot;
@@ -1161,6 +1163,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
  *   num - number of pages
  *   paddr_min - Physical address minimum
  *   memslot - Memory region to allocate page from
+ *   encrypt - Whether to treat the pages as encrypted
  *
  * Output Args: None
  *
@@ -1172,8 +1175,9 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
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
@@ -1206,12 +1210,22 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		abort();
 	}
 
-	for (pg = base; pg < base + num; ++pg)
+	for (pg = base; pg < base + num; ++pg) {
 		sparsebit_clear(region->unused_phy_pages, pg);
+		if (encrypt)
+			sparsebit_set(region->encrypted_phy_pages, pg);
+	}
 
 	return base * vm->page_size;
 }
 
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot)
+{
+	return _vm_phy_pages_alloc(vm, num, paddr_min, memslot,
+				   vm->memcrypt.enc_by_default);
+}
+
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot)
 {
@@ -2192,6 +2206,10 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
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
@@ -2389,3 +2407,31 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
 
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
+const struct sparsebit *
+vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
+			   uint64_t *size)
+{
+	struct userspace_mem_region *region;
+
+	if (!vm->memcrypt.enabled)
+		return NULL;
+
+	region = memslot2region(vm, slot);
+	if (!region)
+		return NULL;
+
+	*size = region->region.memory_size;
+	*gpa_start = region->region.guest_phys_addr;
+
+	return region->encrypted_phy_pages;
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

