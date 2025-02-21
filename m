Return-Path: <linux-kselftest+bounces-27228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B86A401A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46D83B4337
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE2253F23;
	Fri, 21 Feb 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0DKSc/1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4D21E091;
	Fri, 21 Feb 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171795; cv=fail; b=oVsBs3OEoBmXQ8EfZ0Y8Y8Xq9TnDDqxOjqFye6WAx49ATWxQkSS+nswMaoZaMhB+wTdaRXgiLhqQTR24tBVU9k8gQzirS+e3o1frDvDbafHRPGgIG319FN24U3BoOfndH5b5n8oKUTRU6WvKucYQZuSXs5Q6sJcJEoXBQEd+Vb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171795; c=relaxed/simple;
	bh=kujgCUavp9UJCA59ZfDMqxQKqePH8eRvcxVM+CGNrts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF8KZyZeIEBwP7w7hIA0dUSGH5IoTV1L+gDnzdYnuMdFMjKRpq1gFp9zb4Y8Aw8vXRNYmgxZ+CVUjNi7oviXD59irm1uM8QUM7fecQ7VZqWMvOpPKgBwC8c2Pl72u2hLxiw4DOl2unP4P+6bLlZNPOJFJBEVHOwP+32uvPe0jyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0DKSc/1t; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7pilQlK9Tbad8WUE9zn/Heo1N4kDch2GH6k2z526usKoGK7G2vMam2+Od5HFYC0dYlwrFbOgDJdNOz3AbrSaE7gMWVuc+TLgTkY21CteEdwoG1FscZYB6OSc4DJN7cYSPSE7igDf2FlOXQWtOtEzUMEcwff0ldoYuq+0jtXGN3DJXxltRt/H8VISLl7HtHTnaMfJdUJyN4SC2VUaBmMSzMJ2oQlR8rUkzFF07e/cbZLzFcbF2cUGwmJTDvugg0LpJbq4pWL/lhxTaZMqJeoHwsQUo0ver8W851a/xOp5jsjOHxD0szkCGz275dKswxThEfxJ612JDFWAwxchBStzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRrzuhoOyYHYXh6Yhn3ipme9yNxYQMKACZV8513s6To=;
 b=dBJqfM2erPssvjGzzid/ny0n0fcHMTtyj/mj1qwTIFSxGG8eU8BXUjHmmA56JjN88hwi+h/1eR6Kw7Rt7nox/tEqcRe4d/Of1+S7x/YiIuNfKjGbSdIq/9fxJq8VrkxrhYm++90mzSFrL2KXDRVQ7j7AKe2UcEbnXu/a1eA5QSPmdByoLSdPw0SznzK2q8D1y7Z+9NxSvCWudL589nTJmi8h/EIKiFmT2nKAVsu+VePC+dnZPxw2wcs2pwj4lgIWSmxgHdgE55RjANQnZ21oF7gD/QAIpZZwuFkaSSJ1j8RiKeNWlvb3sV5TkEAU7O12DEyI82GBy+TBj2n5q9NrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRrzuhoOyYHYXh6Yhn3ipme9yNxYQMKACZV8513s6To=;
 b=0DKSc/1t0Lw5iEOCLt0mTrMVlJgUHE44Qj0TOm0ClxuMwVrWXqG1bTebf+JouAuu0OLu1GMb/SUCVIX2NXdhKnnPZACfZdzpPGalL6If9VCdxQiYAGoVC+lXnDR7bGDKTIRO8U5oO9DAUCCZaJ3Z3WYRxvk4c45UTIOTMy0qaPw=
Received: from BN9PR03CA0333.namprd03.prod.outlook.com (2603:10b6:408:f6::8)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 21:03:09 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::ea) by BN9PR03CA0333.outlook.office365.com
 (2603:10b6:408:f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Fri,
 21 Feb 2025 21:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:03:08 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:03:06 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 04/10] KVM: selftests: Add SMT control state helper
Date: Fri, 21 Feb 2025 15:01:54 -0600
Message-ID: <20250221210200.244405-5-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221210200.244405-1-prsampat@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 442460e5-d35d-414a-acab-08dd52bb250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WxdYCZtJ0TjZ3upt7uoMNmMhduI81ARmtPMq7wRTiLa8An4S43CHZlxChSN5?=
 =?us-ascii?Q?h8ZIlSk3/12I81UOZbf60ZD6wYq8ua9Q6LSWx+zvV6yxvXZvMNBtYsUUhI0l?=
 =?us-ascii?Q?Xi2iB+zhorGrgrGXworsxPxIl8IA+KgmoatWyIslyrY6RXFKxWllsD9xwn+c?=
 =?us-ascii?Q?EfyR6mOhSpfV0im6FSdf2aC3aVjJUr5DPC+1Ql8Y4Cjj01mHp7t/pkVncv77?=
 =?us-ascii?Q?gWaA1qjf55sb/4dWSjTg4exl2WDpnkzo7PEg650nkhsHZn28dAvINhKksriz?=
 =?us-ascii?Q?FuN1zBX96wkTEIV+lOrfzm/I0344lSdW9/Sfh0DiGJPsLckCl5enoZxXLiPu?=
 =?us-ascii?Q?Lt+JeHfOkYhH9Dhwe5GD+lRn6HUfcKxwYWSLM53cvZIZN9olwQy+RlFW/2m1?=
 =?us-ascii?Q?UIfD/V+j/YNk/V6mURiEc/MFDaMESN+oCiPCwcRksxL4RoJMx8GJQHaa9j3e?=
 =?us-ascii?Q?LgqoQNZ78j9+y88HyWf2cxHRHGEdLY99BOHaEd3/tAvp4Rmz2lqgruanGsAn?=
 =?us-ascii?Q?SUZIQRnYQ4RBXGUsPtSFzk+tcGi1j0jCpaB3euUF09PhDQe1CmocCoZUg8ex?=
 =?us-ascii?Q?zCAfMSvNOeWwSIAuQCNOCWp69uxncHT4DAJHvAzIhz9JCuS1iDWX3vDXe4L4?=
 =?us-ascii?Q?G+IllCSNjyHCc80YOHdQctcGqvBSlzQDChHWatTOP9JnRsnP7nfZU3qh0e2S?=
 =?us-ascii?Q?l9geYuiuo7x3PeA9nam9ggmhlRMLZHqKHc5fW8bRy7BYQR2Nf2ySVzKziMUg?=
 =?us-ascii?Q?9GOWUi9K0brsz404/fx1tRkdxIN1lMsJV/1eVkVW6EZjxC0OLMmuMW4SSx8k?=
 =?us-ascii?Q?zKUwtGdW6+pF0rMonKoDncSPPCCPQxHa4lWp81RT/s3G3pnV9m2KZCU1uIm/?=
 =?us-ascii?Q?8H5nXw5Fay7H/V+01pOhgoYY/xRD+vuD5jyW7EbSoZlZYSQI+xb/1ITjJH3O?=
 =?us-ascii?Q?mlvUvCYNXRVo4wHQ4vnfG2bM5uo4Q96yyRw8MAvdIY6NjtI3vwiOJ/4sD1x+?=
 =?us-ascii?Q?+mie0qnmoi4UIoNnzUCSstYDq4dbtELvHwL5fLV6x0B/12/ZQd8xMDpN6jiG?=
 =?us-ascii?Q?a7IBNdX5tXtv1y8mq/dOnBMngTzy6WV3d7Orcz3RECSb6xawjR7JpJlLVGf5?=
 =?us-ascii?Q?lFEi+/d3AIZBKhHilGMqr+56vQ5dWzRfqR9PMfvmFafvtI7FYkXre1Gr4zg/?=
 =?us-ascii?Q?/hOcgZtIYkjLlSYNO4OU408I2vkGbvzgNcmh/jqc3hJYQ3IqweRuPcmjij8U?=
 =?us-ascii?Q?HgNtXXsTBPW9LmKvS7e4syJTr6MAiOvp9Ikc4RFX/enIKrXSnp+Fz29KfBA4?=
 =?us-ascii?Q?WIC2K6vUTZaA+MK0dujGcp1YMy/C3StKcERmt52UFKoDv7oLL6dAEcwd7Avo?=
 =?us-ascii?Q?vReNG8P27v44UWlUB0OnBlhQL22Y426i1wNrWaydSp42Zy/adkG0zaAgEp5i?=
 =?us-ascii?Q?jar8SMHaKJgKYtXWdgRz7lPAAABjlI2oFYr58LV19A/V3yBjXbFlFmEjOk9O?=
 =?us-ascii?Q?2dSBvqmq4rq1v0g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:03:08.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442460e5-d35d-414a-acab-08dd52bb250c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068

Move the SMT control check out of the hyperv_cpuid selftest so that
it is generally accessible all selftests. Split the functionality into
a helper that populates a buffer with SMT control value which other
helpers can use to ascertain if SMT state is available and active.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v6..v7:

* New - Implement SMT control interface within kvm_util so that it is
  accessible to KVM KSTs and subsequently the SEV library (Sean)
---
 .../testing/selftests/kvm/include/kvm_util.h  | 35 +++++++++++++++++++
 .../testing/selftests/kvm/x86/hyperv_cpuid.c  | 19 ----------
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4c4e5a847f67..446f04b2710f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -542,6 +542,41 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 	return data;
 }
 
+static inline bool read_smt_control(char *buf, size_t buf_size)
+{
+	FILE *f = fopen("/sys/devices/system/cpu/smt/control", "r");
+	bool ret;
+
+	if (!f)
+		return false;
+
+	ret = fread(buf, sizeof(*buf), buf_size, f) > 0;
+	fclose(f);
+
+	return ret;
+}
+
+static inline bool smt_possible(void)
+{
+	char buf[16];
+
+	if (read_smt_control(buf, sizeof(buf)) &&
+	    (!strncmp(buf, "forceoff", 8) || !strncmp(buf, "notsupported", 12)))
+		return false;
+
+	return true;
+}
+
+static inline bool smt_on(void)
+{
+	char buf[16];
+
+	if (read_smt_control(buf, sizeof(buf)) && !strncmp(buf, "on", 2))
+		return true;
+
+	return false;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
diff --git a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
index 4e920705681a..1eb55d0b7297 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_cpuid.c
@@ -22,25 +22,6 @@ static void guest_code(void)
 {
 }
 
-static bool smt_possible(void)
-{
-	char buf[16];
-	FILE *f;
-	bool res = true;
-
-	f = fopen("/sys/devices/system/cpu/smt/control", "r");
-	if (f) {
-		if (fread(buf, sizeof(*buf), sizeof(buf), f) > 0) {
-			if (!strncmp(buf, "forceoff", 8) ||
-			    !strncmp(buf, "notsupported", 12))
-				res = false;
-		}
-		fclose(f);
-	}
-
-	return res;
-}
-
 static void test_hv_cpuid(struct kvm_vcpu *vcpu, bool evmcs_expected)
 {
 	const bool has_irqchip = !vcpu || vcpu->vm->has_irqchip;
-- 
2.43.0


