Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965A542349B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhJEXr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:56 -0400
Received: from mail-bn8nam11hn2217.outbound.protection.outlook.com ([52.100.171.217]:8641
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237101AbhJEXru (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdWIclDF6YfAbv6KvIkVCc4vHpoed5hFiom+nAbnUoJvlJ8l4hs3EwcaQGNWNDwji5EdSBa1Mg4zC3BFTp6MsoI+tOZt6fT4nW0gLlbdmjOfJxz+XT9lEyL+m5wapYsoOKStYZ6ruJqJyH7rySY66rEmVA7ZnzzsH4QBKruZvLLbjYMFOJHeSJqRWEINvxvgEBQPV7MT1MK6py5BR38V9br899RIQEPkKtzpgOnIY5wb6yGJPL3xpcvJAbYu1u84zeQhy8t/sncir+rQroQlYH4Nt68Nq/q7Q4S7+e3l0UzDAZLq0sDlFnesWJkkm2doBPYIQVZ9VaaxHF9wcW8jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad7xBnwHZqqbp+Spvucmt1/DsIcgno9wjq9UBqWKFWA=;
 b=VMRcJeRrYp3ALeTc1pvo+ZpcaWgptzFRyYKcnII5DwkcLA8e4Gu5NZSCbmcozLuRIuvTEGZSEtakqdKe9KMk7l1tW9bKzd7FPUtQMqowbYGSbDs1iSUFc5QY5WYXuyxBSYhpZm7URo9AibqwJNbXfNzSnlKJ9BhBuDBcXDkz9GWAleu8Ro7ggb3gt1TsoISKlr7gRcmxViLu02eZN4B28RgOnY3VOaANGHwpCH7GkxFRSGV+DI8Mf4kAuvHl+3iZJYK6aq7hp0AwPefO1cGqtmi4Jl4OfFb62eHfCkFtOT1j3uaWNU28Q+b0UZXpGqn0w4uYdq6wy5UuWpBsn83XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad7xBnwHZqqbp+Spvucmt1/DsIcgno9wjq9UBqWKFWA=;
 b=3B7rXD++mJ1Fg4nqgNEzG9McZKXZnqPQkpjCIYfcdA6cLuKRkI6OCePA1dr01x/8KlVny0ez3GNcE28ppGZz+BwihiTjonC0gT3lePX2xFLKlZJM+NHPKFVt8spZwIMekZrDYoYHa4dh5S+VoPAMsQRkczg90fNtl/ONZ7hBUE0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:53 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:53 +0000
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
Subject: [RFC 13/16] KVM: selftests: add support for creating SEV-SNP guests
Date:   Tue,  5 Oct 2021 18:44:56 -0500
Message-Id: <20211005234459.430873-14-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA0PR12CA0028.namprd12.prod.outlook.com (2603:10b6:806:6f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 23:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c16ed738-1981-428a-6ad0-08d9885a4483
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB392568EAD0264E68557E996395AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sc/4dFjqL8A+YZ+S+IQSh/vfMIrDQ02/jRFsGWoBoW2cSIVGZrYto4jNbKNo?=
 =?us-ascii?Q?kiv1YBlyLecSO/CymNlMmTpuAfkNodlOkEi9dl7+qsi6e8dtIwo+6cmubwr8?=
 =?us-ascii?Q?oqICEfgX4Oolz+Y44QrKjcdOJaN0w3TVhVzCpDxXS1OOs5n7gBeXSF7sGHam?=
 =?us-ascii?Q?7LC90aXQI7jw/m8xMHFoL7NOlusSlb22Za4lfldiWO4TqctXXyUZUalEQ9Mj?=
 =?us-ascii?Q?BnStMWbd/qrgMG8D6JAB8ncv7y36iJ0O66Z6eEfLN/37FKT/K3ZPaHqLQs21?=
 =?us-ascii?Q?KlkKzOiwveW37WUS6FXefXziSf0gckqKku3a12T0PmbdzFtAYggrIXrnzyWj?=
 =?us-ascii?Q?lbS8cvQkKrIl3IBF43ECGWi78gzkuxQM3+UZ/Z9ktlPyL5A2pcVXZHTSoww2?=
 =?us-ascii?Q?ZJIo7CH9Fk6yQQAliyv6wLonkVjkpN96py6JV4YHIrrL44O605Phl6FAoBBn?=
 =?us-ascii?Q?tDCiGGH7pv6qsmcsN88gW5OQTNKyKVgCLEq08tYKCLnMrPcFE0U3B5Rw7sBT?=
 =?us-ascii?Q?SUl6yblHHoYxMtioCdo5jrjifiOZ1VNFOsOR49rMRBcijFLXuybp2GquoqDc?=
 =?us-ascii?Q?UPnFFSLmQg0Oq8qhgTR4T++34g/B79bppUGqw18zTHCRA4r0Jdh/ivgEiZB5?=
 =?us-ascii?Q?4fL7M1Ye07fl7rcjUWxc/RTyrmyz4NVUl7AaLwny7asiO7pFmw4LoCe2t9TQ?=
 =?us-ascii?Q?0PUY/WDERDL1pVSIRvJYLOAkExSbt1AA1uehQurhNtOm0PWHJ7ZNF40386UK?=
 =?us-ascii?Q?y8Uu0v4Qph9yJp0mCmivsrQHcDRDn5dMZ+n156CzlJ9/HEvNHT3sCZSyIaUg?=
 =?us-ascii?Q?nB3Hi/j8rm8Febm7rlYH7lMbef5HkNpkD39P51WQCoj6fIlvnxST7i61w8s5?=
 =?us-ascii?Q?eVY8/gwWXFKyLjUxI3yJWYZ5B6L3hteGI2IgSRBpq+ROhxINE7dgjuf+DDu9?=
 =?us-ascii?Q?oRHhkeiFtQp6DB8NkLHBEXKxyvKkoRxBmq4UKUCnKP9EqFp7IGZz/CYaV9gH?=
 =?us-ascii?Q?ld+/JZPgnO3Dq2Wl6/JpgU9BOf2RCwmfV5cukAOmnkvBZlM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2XjJuItbHKSbhvYuQEP5d23DESRji8cSsh5yeMz+o5H6g/2nms8r9TrVXhpJ?=
 =?us-ascii?Q?hx28H2il8SgI5hkU4k8PfZsRlDWcz2ZT/Mdc59arx9wCqQPeyrGltA+Kxyuz?=
 =?us-ascii?Q?Q1XuNUsdQazJCWRfnhDLJ8jvIDlLKmvydVyaF3bK3sobb1r9KikkqPPm/8Yp?=
 =?us-ascii?Q?Ci+NctPz/LPxacZCmFjbFBMSOAkEb+iRUcTWS2Upk3+ervSEIogYGH8r6fey?=
 =?us-ascii?Q?R+OnVDSSmGxRMab/lzk4eBCVekZtpS795NOKZHUbiMKo6FJrPYYayihNvXYY?=
 =?us-ascii?Q?A4OGgxlA6HlYNHhGlhMTz855WDKrrVgfeouBJ5k/QuIJWeQ/pYqALxTq8X4n?=
 =?us-ascii?Q?zhhyPuYVziXHm2rD7sjzOOzv2Glgac3Jdi0aKzES2LdrSbOTYw1Pli8XzH5z?=
 =?us-ascii?Q?RWqOOfRVSXoqs31baXU82APykHKk53CibFTQyxL2dYB7zyH9z4DDaYFHlF8b?=
 =?us-ascii?Q?dX/ha6Jc82U7hxkMGEUjb5PUsSZSh/P6ttUY38hxF9kfNHeLoqu7C57qZ2J/?=
 =?us-ascii?Q?1bEjaJCPYz+DcgSI133Q8BB6j192maXkHa1PZEgfR0O2Em/aRiqw49Ee5gYn?=
 =?us-ascii?Q?hLyP16iure7rptsJvVqin+v6eIcIRL+dYa+qSCYZpI1fyYqqrgBePIrDeRzN?=
 =?us-ascii?Q?65wUsDuOe2McnsMeHAyHGdnJjwZEwTYANYL/EZ/fMh268vBy+XEamN4U/K1l?=
 =?us-ascii?Q?wCAWryc7auaAlJAobbMV50KZZR+f7fRWRnkIC44P7KBmkDFTXlbygbhDlrhE?=
 =?us-ascii?Q?YpiJLI5u6bxTqHdWMt9YKOjxayGVOyoGMOZzUodVOP6k0+CtgM0hhZA4tJGX?=
 =?us-ascii?Q?LCfcsATy05tMOm9PLn9S57BP11rHPbGIJdTjlqBeZ1I+Nhy/zr4iIIMaxMNf?=
 =?us-ascii?Q?uBfbu66OPk4dWsVnORIrtS9ci+fpd9x/I45tZkJWAs5bYVlhk9KHhW4IFzsk?=
 =?us-ascii?Q?37ryBGfYOydErjZ9Ye/ZLiQYESmi9fd3eWM+Rrfy235+Bd22oah4bM4zEmEt?=
 =?us-ascii?Q?WuvzMr/f7JisM5IxSmAfMEq62y3NmQr1sMVAu7VHfqSCHT+e7YY2mqyULRjm?=
 =?us-ascii?Q?AwmMr5YzfZgIsRVzj8LQ05IwpXDGf2yCSPmmLGkf8ysxRDprxHaocnksTp7i?=
 =?us-ascii?Q?pep7Bt4QTrhSwp1xh/WvGbw/NrfS6UwVE+bERukpBOdC+4Y5Pl6kcNp4OYkh?=
 =?us-ascii?Q?Wr+41n/5PKUyRwALQM0cCvaco2V6UIGGQbpHkRNRoIRfVnHgs3URnrE1OHk/?=
 =?us-ascii?Q?0mCSwP3LAtr2GSz7E/cY64fKofjh6KumHagx6j5h+JOmfMy80nRjW7RRp1E4?=
 =?us-ascii?Q?wPK7BNaF+NwMX0HZqoxBvxN8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16ed738-1981-428a-6ad0-08d9885a4483
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:53.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1lOS6WBwJ/hHoSKxIVD19B68fpDX+zF+dB8D02HeKi/2O+kS3JyGt7Fi7YK94iR7vQd4Kzf9JbITrtCie+aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SEV-SNP uses an entirely different set of KVM_SEV_* ioctls to manage
guests. The needed vm_memcrypt callbacks are different as well. Address
these differences by extending the SEV library with a new set of
interfaces specific to creating/managing SEV-SNP guests.

These guests will still use a struct sev_vm under the covers, so some
existing sev_*() helpers are still applicable.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/x86_64/sev.h        |  8 ++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 77 ++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
index d2f41b131ecc..f3e088c03bdd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -18,6 +18,10 @@
 #define SEV_POLICY_NO_DBG	(1UL << 0)
 #define SEV_POLICY_ES		(1UL << 2)
 
+#define SNP_POLICY_SMT		(1ULL << 16)
+#define SNP_POLICY_RSVD		(1ULL << 17)
+#define SNP_POLICY_DBG		(1ULL << 19)
+
 #define SEV_GUEST_ASSERT(sync, token, _cond) do {	\
 	if (!(_cond))					\
 		sev_guest_abort(sync, token, 0);	\
@@ -59,4 +63,8 @@ void sev_vm_launch(struct sev_vm *sev);
 void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement);
 void sev_vm_launch_finish(struct sev_vm *sev);
 
+struct sev_vm *sev_snp_vm_create(uint64_t policy, uint64_t npages);
+void sev_snp_vm_free(struct sev_vm *sev);
+void sev_snp_vm_launch(struct sev_vm *sev);
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index d01b0f637ced..939d7d5dff41 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -20,6 +20,7 @@ struct sev_vm {
 	int fd;
 	int enc_bit;
 	uint32_t sev_policy;
+	uint64_t snp_policy;
 };
 
 /* Helpers for coordinating between guests and test harness. */
@@ -119,6 +120,12 @@ void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
 
 /* Local helpers. */
 
+static bool sev_snp_enabled(struct sev_vm *sev)
+{
+	/* RSVD is always 1 for SNP guests. */
+	return sev->snp_policy & SNP_POLICY_RSVD;
+}
+
 static void
 sev_register_user_range(struct sev_vm *sev, void *hva, uint64_t size)
 {
@@ -147,6 +154,21 @@ sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
 	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
 }
 
+static void
+sev_snp_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
+{
+	struct kvm_sev_snp_launch_update update_data = {0};
+
+	pr_debug("encrypt_phy_range: addr: 0x%lx, size: %lu\n", gpa, size);
+
+	update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
+	update_data.start_gfn = gpa >> PAGE_SHIFT;
+	update_data.len = size;
+	update_data.page_type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
+
+	kvm_sev_ioctl(sev, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
+}
+
 static void sev_encrypt(struct sev_vm *sev)
 {
 	struct sparsebit *enc_phy_pages;
@@ -171,9 +193,14 @@ static void sev_encrypt(struct sev_vm *sev)
 		if (pg_cnt <= 0)
 			pg_cnt = 1;
 
-		sev_encrypt_phy_range(sev,
-				      gpa_start + pg * vm_get_page_size(vm),
-				      pg_cnt * vm_get_page_size(vm));
+		if (sev_snp_enabled(sev))
+			sev_snp_encrypt_phy_range(sev,
+						  gpa_start + pg * vm_get_page_size(vm),
+						  pg_cnt * vm_get_page_size(vm));
+		else
+			sev_encrypt_phy_range(sev,
+					      gpa_start + pg * vm_get_page_size(vm),
+					      pg_cnt * vm_get_page_size(vm));
 		pg += pg_cnt;
 	}
 
@@ -308,3 +335,47 @@ void sev_vm_launch_finish(struct sev_vm *sev)
 	TEST_ASSERT(ksev_status.state == SEV_GSTATE_RUNNING,
 		    "Unexpected guest state: %d", ksev_status.state);
 }
+
+/* SEV-SNP VM implementation. */
+
+struct sev_vm *sev_snp_vm_create(uint64_t policy, uint64_t npages)
+{
+	struct kvm_snp_init init = {0};
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	sev = sev_common_create(vm);
+	if (!sev)
+		return NULL;
+	sev->snp_policy = policy | SNP_POLICY_RSVD;
+
+	kvm_sev_ioctl(sev, KVM_SEV_SNP_INIT, &init);
+	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
+	sev_register_user_range(sev, addr_gpa2hva(vm, 0), npages * vm_get_page_size(vm));
+
+	pr_info("SEV-SNP guest created, policy: 0x%lx, size: %lu KB\n",
+		sev->snp_policy, npages * vm_get_page_size(vm) / 1024);
+
+	return sev;
+}
+
+void sev_snp_vm_free(struct sev_vm *sev)
+{
+	kvm_vm_free(sev->vm);
+	sev_common_free(sev);
+}
+
+void sev_snp_vm_launch(struct sev_vm *sev)
+{
+	struct kvm_sev_snp_launch_start launch_start = {0};
+	struct kvm_sev_snp_launch_update launch_finish = {0};
+
+	launch_start.policy = sev->snp_policy;
+	kvm_sev_ioctl(sev, KVM_SEV_SNP_LAUNCH_START, &launch_start);
+
+	sev_encrypt(sev);
+
+	kvm_sev_ioctl(sev, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
+}
-- 
2.25.1

