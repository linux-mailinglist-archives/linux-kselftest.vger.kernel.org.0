Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4852542348F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhJEXrk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:40 -0400
Received: from mail-bn8nam11hn2240.outbound.protection.outlook.com ([52.100.171.240]:62688
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231481AbhJEXrj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2wL7Z9Lkfkn2oNZpm3EWCmCzIYsSebXG8DdbKnVRJlFte9vI4v+MVzHPTveSvqeo/kQNjJ7tUJjSAJzV7VAmZNtqjcPci1ZwKBKlDNH+o4CjSZfvkFeGLt8dEfKJszVFIM4LtYe8KzKxuIkFKiO/EvQhN7b5o6qqg0wsydMRF9QkFXGu5AJ3u7EbwFkn5yAoNE+Z/grRr57FghT2qqNVthm/EgyTjNgbVbOR5DX9jTO1xjeU0VzsQwBmxmh0cqG+jXHswRfwFTBA7NgPIHoTg47XxdQJtqUhghz7xLo7/wi1Bc20DCEIvHZcmkZUl/hGUyL4KEfWbiB/4PEMANEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OF4TOBpCh6AiCl0BdEUjKGtSMtvyPZxw/+eZ47So5w=;
 b=NX0e0Fym/rbrhaNyAEocQCBfWI0j87Af7+XG0S0sWr8xfnMIjlY4Zu1OXgMQE1NhI67wqytjT7UR5KveoolOwMZ5n5eHPwN/oSGv8WXMoxc1gmUVMTZKlRu7MJH50yZiun6Dxw2SZ+mGC/hQSuCIyy673x5CzRPc2o4HAKjiEbhXav3y6hyZ7u17u0TPZS4PjTXN+0zQbgUuMYU/Tiz2lMIyFRq5gLEHsRePdSvwJRjEO8XOmBatktEowr2aUqdHaCvSPCEK1vXTEAwC3IiMP9VM/2kHmoiLtGn390Dof8c2JsxKslVeMJg2BGt2QCdFkUk7I4dQOP+oRuH7WkpQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OF4TOBpCh6AiCl0BdEUjKGtSMtvyPZxw/+eZ47So5w=;
 b=ibgbOOe9Au+RlqUJ1x7YRtuQxDTRSQNrJbMBo1v5SLiteDb5zBsGcxxihGYr6fTTz7gIamtGhYBoXkPWXct3KARvyohCDgVgsyjGlAofJ1F0QpznkQIBx+74LGhF3fanr5BAljZDQ3DQNV2wN/O6IqrMJxwrCk+n7UhW/0/2zQ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:45 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:45 +0000
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
Subject: [RFC 10/16] KVM: selftests: add support for creating SEV-ES guests
Date:   Tue,  5 Oct 2021 18:44:53 -0500
Message-Id: <20211005234459.430873-11-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:806:22::24) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Tue, 5 Oct 2021 23:45:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f8e193-13bd-490b-13cb-08d9885a4011
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39250FE6E375215B31F7C86895AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2nODGEy7Pb6obB1igg7Kw0Ei+PLeQcYgkFZLYAL2kC9vzcm69AOcFefGb3A8?=
 =?us-ascii?Q?MruhneG2CDYBXhtUXsjvkg20aq5d7gosZn4DjK0GDCIpuoXcPYurHsuKSAFm?=
 =?us-ascii?Q?d8A/qIp11R3YzHYQW7cm7epa01nd0V1xd9KeE8Gd5Drh7Vnq3f5IOH6hwVPq?=
 =?us-ascii?Q?AaUMY3/lyKLPQduB7EaDPfudUFivOCm/fr0U1D/pPLfWdA3NYEUsovjGnr/A?=
 =?us-ascii?Q?3Wg8MdDLbGO6raX/Pxvg85CeLuL/DBf5j+t3NAVAsC+4/qPinHmnK3mHrOFN?=
 =?us-ascii?Q?PejPL91XeHG9kSR/HLc5qYnx52F1QYD136s/2QPUTKU5p04qxULB9PMvvra9?=
 =?us-ascii?Q?JeiPQaES1xon4O1tenM7GiZVkTuw3zFWdFWXNELDP/f+3IzV51NZ58Mj8+LF?=
 =?us-ascii?Q?91oXJj+8FYxh/+Dw2RnW8Uco7RaXP6JP2jJwCTn1ACENdCW7vfLsM3vbh3/B?=
 =?us-ascii?Q?++TAokyo/GBrMDHa+Kizb0ntmoPnJPYJTet2zrrbJN9LUi9nMFrwW84Yi5Vp?=
 =?us-ascii?Q?AYAKyH4dZHze/dArGJr9SXWP9H9DcisMpH/g7BwQY9BARLSJDxP6eew6k+Lw?=
 =?us-ascii?Q?snhvJGQ0sAZBCu2xJzwdifMUuT/ivj5PsNsOQPMHBwfJRRuu+cE1wdX3Pf7D?=
 =?us-ascii?Q?zgpcGC8BZrOU5I0T4HgHng/tAxT/T9VswD40Gf6VxNETR46rJnNoUrczYPs2?=
 =?us-ascii?Q?jNddfqIsZ1zccyJI6qEMsG5djkOaYVMa+K+8zqH20WiaQFXPvKFlNIZVO2dd?=
 =?us-ascii?Q?JnWDgZjg7FOVh3x7i09dGchdKXRa6zrM25qo3K5QuCp35jfDHv0XD/N2qs1N?=
 =?us-ascii?Q?0ubxbsfAE3AppPOHhjAPBOWadZlrpJLSmDQ1VhBCTNKvRaRATLuaf/H409lo?=
 =?us-ascii?Q?+a8JfeuTN7CvFxx7PokypAwsYjWmYe/8Dm2cMwVNAMnyOySe3Ewb4AyQB4OP?=
 =?us-ascii?Q?coE8f8i7WLTxg2m9MhqJvGV7hEsvFpqiBPc3PANhszZZnGnOvQVu3BPA3IG6?=
 =?us-ascii?Q?gpbzdRUWYoiSoTZ+Ls4a1AVtTfenKKDjJ2SuRa1KVlyjphI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Icq/zT7L/drfWR2mkYPc8h469C5XciW8ae8Op6eBdN87LAMXYCCgGpcIGDEO?=
 =?us-ascii?Q?2MzuogDfkYHYBShd5Mb4qfQqHS4s8rVUqXo9jUNFrKx70MR1ierQycYZGxNo?=
 =?us-ascii?Q?lZV2UFaWs7voZoGqJ18ovw8x1XlEYH8wi+CpqccsL9sUnRh8XlCO5+HvMZDO?=
 =?us-ascii?Q?H/NJIGNJ3SPOa3+/ZQg76FoJWRO9c5xgzdQg5n7ObWd4lUrQAOtjCDQ6Vwat?=
 =?us-ascii?Q?2GXdetLLtLoStl0PsvUEbUTRusL8xHNdW0G+79SGWUCTBKFEPFQnD2olWtu3?=
 =?us-ascii?Q?CzxBe4FxTqezNZhTN1wkjp1IpflE9nXpYs0aPWGcaUANmGHEjnKJhrAa7W8U?=
 =?us-ascii?Q?ZYrMhu3HFSmSuAvdJiY6PmgRe7njQ80Ep930UOqotBuvSYSmoxzORIxIHTU7?=
 =?us-ascii?Q?UQKpCJ+v6SXgbN4mO0h9L3vBrBE/QPf+w4yWs6Iq4xuppI6YqEI5zaxF4Upc?=
 =?us-ascii?Q?gEK8NimYfrjNaGp1bAJ5Xtsgfnvqo4GANIxw9s2QahXKqd/xcq39DfkhZ577?=
 =?us-ascii?Q?CB+xH4EPFxQ5PE7JRm/mtS4bBE0fEMPj9ezZj71vStIQ25J7NgSJXnG5ttaY?=
 =?us-ascii?Q?vOa/AXky2ZT3YrbltX/UMZpgnkUYazcb7pV5LpY13FZJlwUePc2L6HHPYOqp?=
 =?us-ascii?Q?0CShK40jBkVPfD3c0IY11y5gbzRcY27cCi2azx9j/wC4luUcig0ILciSuB3V?=
 =?us-ascii?Q?v7R7ypKle+SS5GihiScfScKtTnelk9uAzqqGWSmYjwMN6kZPD7RAqQVQAsDk?=
 =?us-ascii?Q?RlqumNnE0eIZiaKXVPqwnXwKIR6OIdoO75m1M59MDBLsZnNZ390CzQBTJaIo?=
 =?us-ascii?Q?7xdU52KYGkKuLll0KW6tqDDcFLuGy0wDMTwkqoLrygPuHHvsaAWVU+If1A/V?=
 =?us-ascii?Q?t40ErIeVeutl/qNOH9/TVXNLVnsR4JLbmhuoL9igyKaBb0iWV6fX1A98hMwF?=
 =?us-ascii?Q?kzXOuufmDYXReyt0JgUOXdiAKFNqLxghd/nNW+3uT+/ZBB1N++ZLOZhdCRgf?=
 =?us-ascii?Q?XyHFcWWRcRq6F8bsSm25YNYnUnvvCVkhdD+45gIKG9G4gaWkJ16k9xaHx37a?=
 =?us-ascii?Q?Br2molO2AtpxiJDm82wRqFYnUJG7SgWFPvuTFowYbrud/55efH9bbFtKOGzX?=
 =?us-ascii?Q?eUneRHMWjH531u2KNLm04PPoIifiM3UnQuh/ebK+5XS/1wIsV8+XqtLYFFs/?=
 =?us-ascii?Q?BJcKP0SsxCVq3NxgJVc9Npe/qRGE4PTQKK9aJXlzJE6wTHZGQBbi8seTbwuk?=
 =?us-ascii?Q?uwKYZxBeIajSRVFRExY0p/1zjmlVbbWWPF7cQlK4pQAY5P+uRSzTrY0myq+H?=
 =?us-ascii?Q?HVO//L84DGApyu3KQnsYu2r0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f8e193-13bd-490b-13cb-08d9885a4011
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:45.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za8UjBdcdu4BXXw66ZJDj9z1rcFz4iPcmPP1AzuMpN5VxvXwFwUJtiIs7mwyIAlK5SKRe0QXNlcIdBbt3Kakwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Only a couple KVM_SEV_* ioctls need to be handled differently for
SEV-ES. Do so when the specified policy indicates SEV-ES support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/lib/x86_64/sev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
index adda3b396566..d01b0f637ced 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -238,13 +238,17 @@ struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
 		return NULL;
 	sev->sev_policy = policy;
 
-	kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
+	if (sev->sev_policy & SEV_POLICY_ES)
+		kvm_sev_ioctl(sev, KVM_SEV_ES_INIT, NULL);
+	else
+		kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
 
 	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
 	sev_register_user_range(sev, addr_gpa2hva(vm, 0), npages * vm_get_page_size(vm));
 
-	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
+	pr_info("%s guest created, policy: 0x%x, size: %lu KB\n",
+		(sev->sev_policy & SEV_POLICY_ES) ? "SEV-ES" : "SEV",
 		sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
 
 	return sev;
@@ -269,6 +273,9 @@ void sev_vm_launch(struct sev_vm *sev)
 		    "Unexpected guest state: %d", ksev_status.state);
 
 	sev_encrypt(sev);
+
+	if (sev->sev_policy & SEV_POLICY_ES)
+		kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 }
 
 void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement)
-- 
2.25.1

