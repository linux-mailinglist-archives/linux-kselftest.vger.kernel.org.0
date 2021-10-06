Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28750424819
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbhJFUlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:41:31 -0400
Received: from mail-mw2nam08hn2249.outbound.protection.outlook.com ([52.100.162.249]:60640
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231593AbhJFUla (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNQL50gsNy6ikKgqT/KjBj2eq1+DoOZCdPXLTmenDu50TgHfK09XGSSYJEuZhVk5/DFCdng1xY2geAh2qen7PcAq29BRN0RfZLR5yrf3xhVNsLt9t2IH0oI9IP6EQghjclsjF12NIUvlMEau0iJf2LDbCqK6XYaEuNj4XOsqu2YyZ3drpxHhSgK5PacKaTL1ccFO4srPS8rSK6izQ/deatvr9q2CZGM4gdO7Oi2Ws9uqtXV5AFlaFcuUrgDfgRORdoQSszy7MhQPzclUUBGTlu5O/V8uL0SaI14FXbVT3GLNvjoAFhXRMSFEM6WLetRCFMsEzOhPTsbyzwqFJzvSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D387B+NlEEEejRnW3/0BUUr7gw6sXo5O6Sr8XdlG64E=;
 b=J+XSoFIC2qRakEoN6/5mOlu3evBuev1RUSSBfheVw0aVHryFDtN7JM22tOWwgI7dRpRvyYeXtRk9XZ4vm46OtLKOYhcknmmJtJPTVyf4A6uSqousWnyjCVmG8Crq3vUld5cMilaof4XVCiF6m8BdH7HdsVx0pngfdvyNSgs5UcPZz/Ph4iZXnUlVBoGi/qpppIxZkCcY9MemzVCTQDqtZL9FWED6/AWBODeLByEXVV9nTJWbRapPATxMG9MJwcxHWq3hXdxdRWdiN01DM0dqvNgXJXoHy90jBuay/uCXe+dCVsv4542edyEMY9qZm5sJKqKheIEBIX7qkSE9T1rWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D387B+NlEEEejRnW3/0BUUr7gw6sXo5O6Sr8XdlG64E=;
 b=uEThMktWb0nLQ4d4mbSYN3chuRsHUQyTpuK/pA1ohTimjXpqaKWlImmEZrDC028mq+HvbBXC8ahTYNAF5q1fG164Cfp8dIvxiEqVjlnhKehVuHwmNGjZMeMjocC9PiMoUDwIy0PfLI8NsWF3gvevD1RAbjEGRKKFpzdB00ecbqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 20:39:35 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:39:35 +0000
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
Subject: [RFC 05/16] KVM: selftests: add support for encrypted vm_vaddr_* allocations
Date:   Wed,  6 Oct 2021 15:36:48 -0500
Message-Id: <20211006203648.13251-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0010.prod.exchangelabs.com (2603:10b6:804:2::20)
 To CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN2PR01CA0010.prod.exchangelabs.com (2603:10b6:804:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Wed, 6 Oct 2021 20:39:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb6a0ee-9535-40f8-ad5e-08d989096886
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4264C88A9853D05DF335C88595B09@CH2PR12MB4264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MB1S1RxtKPvxI2DfWk4sgQj4ka4r7Wlxj/ZITbLPcAMOSH0uaVCbpEpEmGAh?=
 =?us-ascii?Q?k8i1KEl6FeZDmqtSOJmo1ZKtO5YG/YHeSlFYjFQkXQuNsMYo4t8NiE4A4ZwW?=
 =?us-ascii?Q?DedPCQOSbJmBBWb0PpM1YCQiiQ8cWJsFePu3/pqkjb/gmm/TjEZ+CIBJMxgK?=
 =?us-ascii?Q?MdKtZTkw0lsDzCY12nuhYibbdyL+cLgRAEQbCfmrJqxx7ae1JwjM+d2XBVma?=
 =?us-ascii?Q?0n2DVuDp+Xqcb29o6D5+LrUgHjy9o3pvzqgZP2kcCf6dqm6SALHIbOxP0wzD?=
 =?us-ascii?Q?Y3iZyrw6SLSkwvCCBMU6duohByumKYEKJn1VxtJpTjFPOB0gjulaMtXwg2ma?=
 =?us-ascii?Q?Hjfm7ePwJzQ/9djAbjrJK10WrMVaNy7YNBCv+3XrmX/UFQmMp/cioA00Q3LS?=
 =?us-ascii?Q?sSogzdhDcRiWxe8KQ6qBBjHbdFMsoT4q7UdXDiaxsCYSGOqBIFi183mitVGL?=
 =?us-ascii?Q?xsS0ukVoLtqMoKYmxVqujHlAkRVp85IVw70Tso/yW9d+b07g2/U3yH2Xbhjj?=
 =?us-ascii?Q?jaQn5kCQRcxYOG5CgVm6CbWRz5093+CJf4YeqGCRtrnzE1gXoq6QZfFD/ORO?=
 =?us-ascii?Q?RCaXu8zOCRyMj5ZKQNryt/36m0gzbaiiFci6VDgKHWDG7XWs38/QZH5Qlh+l?=
 =?us-ascii?Q?WqVvQblkf99jurm19jfgiIRGF7U479WwNnC/4R5nU+nMy4wvTo/r/tGePrvg?=
 =?us-ascii?Q?ChPiiSXiX4j1pB0VD0QOXbhJhV6Lq96VzOKGIaynnKVQd1imf4RCTCqsVvEz?=
 =?us-ascii?Q?CHRj8gymhfYLMQAeoB3ZDNdS0Kr6XumFWrRukC62r2Z6+Bn73514hi14kgnU?=
 =?us-ascii?Q?iKtyREaeziDuW9AZck0rRCIfScAr7obs+C+E6djIlVM4oTO1mDx/+52RA5V1?=
 =?us-ascii?Q?ipcoYNzfYqnTLQoypNECBu5Kzu5q2CWjYFBm045GEwtd8qDHpkvxJldmost/?=
 =?us-ascii?Q?g1Abksat79UJVJjuo2oZV8YDheOSTU7ZZdcp3KX6vWKV+eWwk3MuobaVZiZK?=
 =?us-ascii?Q?nhNwHdpGoNFQEFWR9bc5NX1cUnzWw7ALRtr8dyB9P1DaSa8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(86362001)(7416002)(36756003)(6916009)(1076003)(316002)(66946007)(66556008)(26005)(8676002)(956004)(44832011)(186003)(66476007)(4326008)(6496006)(52116002)(508600001)(83380400001)(2906002)(6486002)(38100700002)(8936002)(2616005)(38350700002)(6666004)(54906003)(5660300002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5ELxr97OEaNfa1y8n/WCKeQ+wrjN+4MUqW9Z4J4vBrn2oMbZkOXuTsdqAoN?=
 =?us-ascii?Q?Qc8CX3VZhLP4cqzQlaZlyca+ZIBTqAcgmKtbE/UbwQlur+pN/XIXh3CyyDOW?=
 =?us-ascii?Q?g/uDcC/ZjoOqXz3fFf1OaGUckufIXwFZQ5c279oNAkDM1e3jD5jmFzHK8dvQ?=
 =?us-ascii?Q?aOzNLZrUpOjY2ZZi+3dz/RsU4aMTiBcDf1aHpIjfCbIYbkurQ+gJpOaLtFBD?=
 =?us-ascii?Q?/lGjSZDCfhMtseeJNhraU2fxIYYa3/8QrhRqgmJv585x9sWYIbPyQ23wgB9I?=
 =?us-ascii?Q?Fl9IbT+8yID8texDLRFSqc5SUN6Vmqgm6OtTz+grxOHz/Gs0dBpQAF3vHL6N?=
 =?us-ascii?Q?PK/IN27JTw8+AuS8nZdaC9ksEAufNqGzyvMZUhjr/+FDHfdxDAhJrqDfXklU?=
 =?us-ascii?Q?k0APUTfr5s43SQeE0NQDHoACakmE6O62fZPbb2V/LMYnyMtHuxwdeUY/VL6+?=
 =?us-ascii?Q?JKSvc3afuXvlxrmxSiTy0v2j0vGCTooB049JetqOIl7BSfv1z4ApK0ya305C?=
 =?us-ascii?Q?8+tENIaiJs9TogK8/wQ2ZT28eK92LBESxPSfWVw7d1nchFVkXRyeQ6i5MIiA?=
 =?us-ascii?Q?Q8Bfb9rAdPGoCzrn+LP76T+xYCKhq8DTHHXIA8LbAhPIZRN1Kh0t+IiiqBip?=
 =?us-ascii?Q?utMwKGWztFK7xJbjXneyyb815WZqyHcTziqMWTkMxsGaqClXoLTG0WghcJA0?=
 =?us-ascii?Q?pM64qxA2hIXjMwG/7DJQ9WjiB8yUeH79hYlfGP1DFzHPXa0Sex6k2/SoWFtT?=
 =?us-ascii?Q?sC7WhZiJEUWRS2gItp9P3XWgfR6bRTt1Ztvv18TRljctlYS7m8S4O1SjGiRU?=
 =?us-ascii?Q?/b5KNoKavBePv2MjHdxntvO6ZcuiQXK9d/O7gbG02CX0NdmpTbqQR1d9MGpf?=
 =?us-ascii?Q?Lbsf+Arngs5uky6AaqD0qucNE6dgmKWMCykrH/MCRfRkDc+1HerXR0YyOX3p?=
 =?us-ascii?Q?9+fK9FdapdksepVFFMn26Kp+bZcmT27NOu9JxCctOg5SjzUAb6ssvBbLY+BN?=
 =?us-ascii?Q?IRB6Yy0T0uZwqrQRwf5l7Mk44JZ6Jj1gDdEe1dNsvvkwqqENHTc+267Yqal5?=
 =?us-ascii?Q?H+APc818a++q1RLvi+F19c+1hCaJ3CLdPRfyx7IUfIc/DBraItFg+sivOnfU?=
 =?us-ascii?Q?f3FBqNW7pXdi5CQIiC72S5HlaB5KWM8wC3gIT/eHKPZHJWrRTJum8sA4DLKv?=
 =?us-ascii?Q?F0bepiEbKX/lY1bf4maRaaZWW+g7HRi0Q5qcWxzVoekfdAo2OAhfTbeRlYwG?=
 =?us-ascii?Q?+v/pfuiEolDr/QLdGC7/XaxdIycSrYaKHeUMQzaG7HhB05lyrP8+oCh/5b/n?=
 =?us-ascii?Q?jiddOkqM708RJjS9p/ezYj0k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb6a0ee-9535-40f8-ad5e-08d989096886
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:39:35.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R6l2vWQAh3zQ6DIj0cfbtKaJSyk/l86XIFsqkDQJ0auzqkj3TdCN50rD/9gkm7kxP0+CPCVwBcdnrDO6QZITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default policy for whether to handle allocations as encrypted or
shared pages is currently determined by vm_phy_pages_alloc(), which in
turn uses the policy defined by vm->memcrypt.enc_by_default.

Test programs may wish to allocate shared vaddrs for things like
sharing memory with the guest. Since enc_by_default will be true in the
case of SEV guests (since it's required in order to have the initial
ELF binary and page table become part of the initial guest payload), an
interface is needed to explicitly request shared pages.

Implement this by splitting the common code out from vm_vaddr_alloc()
and introducing a new vm_vaddr_alloc_shared().

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4bf686d664cc..d96e89ee4f40 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -143,6 +143,7 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 646cffd86d09..f6df50012c8d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1325,14 +1325,13 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 }
 
 /*
- * VM Virtual Address Allocate
+ * VM Virtual Address Allocate Shared/Encrypted
  *
  * Input Args:
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
- *   data_memslot - Memory region slot for data pages
- *   pgd_memslot - Memory region slot for new virtual translation tables
+ *   encrypt - Whether the region should be handled as encrypted
  *
  * Output Args: None
  *
@@ -1345,13 +1344,15 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+static vm_vaddr_t
+_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size, 0);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
+					       KVM_UTIL_MIN_PFN * vm->page_size,
+					       0, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1372,6 +1373,16 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return vaddr_start;
 }
 
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, vm->memcrypt.enc_by_default);
+}
+
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, false);
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.25.1

