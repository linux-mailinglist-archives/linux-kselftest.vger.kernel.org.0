Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE05B477A41
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhLPRPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:15:36 -0500
Received: from mail-bn8nam08on2069.outbound.protection.outlook.com ([40.107.100.69]:47105
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230032AbhLPRPg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:15:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhaQsIDKLfOsmdP0LXcer8ZcvM00ZnjyERr8O0hs2Eo9pzmw4EpAbUNHQL/VFeeqVZgXyOOCkb3l+pq10chkJBSzeIokcOiyBmC1acbfAJh8GbJidR8TV9SiT0rPyycoQatDEPAusEFgJ0xE4NNwn6Om/yrgoVHOayr/pQdEYGReLygIzCwnUNKKjhcTEhuUTBIcfinnilbQULbI7qGGJVNX+KBFoJqVOPI77yyrapqkeP/bRcCPK8tu5mZsR9Ug+5URAfFQY1rnoryI3tmXjzvNmWLW+1QmSrvAauNkcNHAwTgxZtrWztX49ElzsAomvlFbAWHUnRndtS3QelnNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO47yDYKDE4YhUHaKIZZDugHukeCeW9mdk+gvtYHVe0=;
 b=KRjBmd8Db9E29/TH0vViXWdYHLdjx3z/bYKaG+ysh9iySDQu9+v7/wbPpKMV+bV1KYdUl4XupwDIBWV3bpMJLyFt1/rlr/s4te1+u069SYIfNpseLr+T+c8Nh5JIzrPHSYKLKINFYPjFEtYteyPCYTKo26d3hg0B9mV3mH1KVg/kIRKkJW/Ha2pZ9LF1KLV4eooE81Yb2iQZDgLKxyen3tuuNnsKvbj7DgpOJoL4vUfPJP5L+FY0BQl/JRzMXVovzLr6MHAy1XDd/c2SCpdLjKZa3DvLKXQoyIUHA6DcevmrC6gDFq257aTSQXt+lczwBLMR9tlPHx4W2R4EoNUX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO47yDYKDE4YhUHaKIZZDugHukeCeW9mdk+gvtYHVe0=;
 b=TUC8keqwGvwpejIl5VtrHUIGKUqb2/nyg/+zg8UJ1/jqUfqtttfRKRubmzwPNKG4xDalL0Bm8pRhveNdnb6gcGOURMevW3nguspObshbhML/ytt4dyEH00n/Np/q6dZRHoFHgph9YxVbX7CMyGeAcQCPeBDWxpmllUm/564h1is=
Received: from DS7PR05CA0036.namprd05.prod.outlook.com (2603:10b6:8:2f::25) by
 CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 17:15:33 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::fd) by DS7PR05CA0036.outlook.office365.com
 (2603:10b6:8:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Thu, 16 Dec 2021 17:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:15:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:15:32 -0600
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
Subject: [PATCH v2 11/13] KVM: selftests: add support for creating SEV-ES guests
Date:   Thu, 16 Dec 2021 11:13:56 -0600
Message-ID: <20211216171358.61140-12-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea365090-423f-421e-6a9d-08d9c0b7ab78
X-MS-TrafficTypeDiagnostic: CH2PR12MB4071:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4071257F3D36A058C43901E495779@CH2PR12MB4071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjL+obMjaR/HFrAqRwHSt5ZmuRy54ENJLwnmwdWo2sw5n2yltVv+2acKt4oq1vqhy4fWs0zG8jgXzDPKwoWHIkxXJ4j0SBz8upE40Ub+SVKjkTD5TsQBlIUTCAMbtrQLg+unntr/JIeAHpOS50bFxMn/3bWRzQMrkChjaTST+AKxW9tI0uuVeKqotP0cWWdUFbBC8VemoPMft+douXfpbvGVRNUJm0nV8tgZDThzIfP2c59R5OkkAnAzT5Y3iSFAzOZ7TgpKwgTpDPKuxyO+sSVw1bS0lXomA/uTPCEsDdfGepUDWQcjKzUd653Zm4ifQX7xsPkVnETSpUj9RgMPbWEXofJVkNkV2enVwUotZSDewNcsUcuNuj0JdUIkFC6ZSDlNSDULSoiq/eh5JvAWeB0HkJ/Klx7wAE+xunzs7uBFUoEVa0jPgJvjp/nWJ6A0ORQLMvbcPiYj1pWoeODx3ww25TQ96k96EmxwOojiTfMArf3pHkXCWbwnsg/eHwo4Hs14DeXD5X522iZYtaChgKJuQWlNOmp93Aq3gpZRAyqKvRWwdnO3L8NcD+fRV34mctXxx0EOFKpgxKy/Gi424GS/otmLkOw7Nm8xl40ijvIGk8HyoP12Bu+BwayOILDyTVUiuGbB9QTOQtRms90zPbyMahB/+n6t218QC5lWV7C3OPtWYCDVuEqtF5Ybk1LBMacqLLtIneYJ+QtYYvKVw/JU/NP6FZ5BzszPWzS4S2C+15cXLrkVBktN5Gz6IOvEWi4QNpXk/4XXX2plBMnEXM5LUbLZ4fxXp8i6Rqwith0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(70206006)(426003)(47076005)(1076003)(356005)(6666004)(2906002)(316002)(40460700001)(4326008)(36756003)(86362001)(82310400004)(7416002)(81166007)(44832011)(508600001)(83380400001)(54906003)(2616005)(16526019)(186003)(5660300002)(26005)(8936002)(6916009)(8676002)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:15:33.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea365090-423f-421e-6a9d-08d9c0b7ab78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
index 4a99862d62e6..181be03f5a10 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -182,14 +182,18 @@ struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
 		return NULL;
 	sev->sev_policy = policy;
 
-	kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
+	if (sev->sev_policy & SEV_POLICY_ES)
+		kvm_sev_ioctl(sev, KVM_SEV_ES_INIT, NULL);
+	else
+		kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
 
 	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
 	sev_register_user_region(sev, addr_gpa2hva(vm, 0),
 				 npages * vm_get_page_size(vm));
 
-	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
+	pr_info("%s guest created, policy: 0x%x, size: %lu KB\n",
+		(sev->sev_policy & SEV_POLICY_ES) ? "SEV-ES" : "SEV",
 		sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
 
 	return sev;
@@ -211,6 +215,9 @@ void sev_vm_launch(struct sev_vm *sev)
 		    "Unexpected guest state: %d", ksev_status.state);
 
 	sev_encrypt(sev);
+
+	if (sev->sev_policy & SEV_POLICY_ES)
+		kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 }
 
 void sev_vm_launch_measure(struct sev_vm *sev, uint8_t *measurement)
-- 
2.25.1

