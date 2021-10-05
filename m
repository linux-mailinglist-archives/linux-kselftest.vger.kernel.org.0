Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1042349E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhJEXsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:07 -0400
Received: from mail-bn8nam11hn2217.outbound.protection.outlook.com ([52.100.171.217]:8641
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237159AbhJEXr4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsrquY6FraHrzETT3XWuofKHvz049UcHvcQRfgS64zZcqQp14+FriQ2agcCVO+IZ/utBTVA1QtYoiirX7PEWjo8kXQZH57jg1TcjQ0au6yy8NnNhAJpOTyC+CjJTpaJVQVfOAzu80y+8s4ShOIMi/+Izpu+k5u/3P3d06SwFotlIlO92I+0JBuyNXwgL5jeB0iIQOw6ArJX7GjomOViX36SIKSYk19wE8zMRnoYcqsaW6hcD9ufOUFxgfkelKO2FqnV+D8LA2x3jE2UV0NrngsOz0LfuK8zzurqlhtpb45vpbDRfZiwMiGPQB07pJaxVC7ubVTiFNhgmxy7ZdUCC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1yt174BkP9mJg2zq1FVO4125cgDK7TQCy43M1tA0dQ=;
 b=RN+GiteUJPD6wjVhC3TG5t+gNRjNsSjxwuPGiv66A2tdPM6etnoMMSzzNuWd/YMq6Y4gZkv4IMirIBqAbcnfq7UbowyXlQmmS3nFucK/6qnl44Q9yUrMahIGgxyNxbt/hh8hX9hY4mb5I38ws8Rc4Ewky06LyUYzsd3HtRu9k5EGxkR69qG0Qfm/0kCn8yUEh0Yv8bC5JFm/rj/XmXHfJGCX9o8ST8jk6A/dnNxl+teqoYAh251ZaKQiqIMsu7A8p3S5ZDrv1Y6VQcDGFuFuvo3B/wvfak0p3lJr7+lAW07O3VWe2r2LvT8GxSNBuomK+Foguk8HC2Wy0vYZ4pUqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1yt174BkP9mJg2zq1FVO4125cgDK7TQCy43M1tA0dQ=;
 b=OdPsDhxksuMLN+M024/n9TvdjOJ6g01rhQXjMPdwu+cyHdifW/wO/Q6Pu6RA7N5nH/x/iczsrTMhZl5gx0lYBy++wA/PxYg7q1s/57PUSzTVuHGYpZCTldRRvw/AB9KIGBV9NQuH1BwKZYvZ/S04nAz1CwLPwsOpBgYWLEBwbE8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:55 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:55 +0000
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
Subject: [RFC 14/16] KVM: selftests: add helpers for SEV-SNP-related instructions/exits
Date:   Tue,  5 Oct 2021 18:44:57 -0500
Message-Id: <20211005234459.430873-15-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA0PR12CA0008.namprd12.prod.outlook.com (2603:10b6:806:6f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 23:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d518b7-110a-4923-d5e1-08d9885a4591
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB392501621E95C0E784B140DB95AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XOi0RpoIEyj2Ig8c14VGuaNm39r1AmZCYaNr5SUeC0BRmy891O6puwEe3u3W?=
 =?us-ascii?Q?MGHjOU4KDgBe46axm9HUwO5MnlVMPElh1I6o5Hwjh0xqxXXX0bw/i5kd6qMB?=
 =?us-ascii?Q?VKLHVL/fLxJs3TQ01R1U2YTqwcf3Ugf7SmIZIBCrhJbAEwuhz22oNGQvoNf0?=
 =?us-ascii?Q?HrnKq4eyX3ZkMK5XBkJvmrwM4YS10hCcmyDE8Rpl1IEN5qxh1isYtuUeULMP?=
 =?us-ascii?Q?NW1oxq+QEqOstvZDtHXvebfw36qblbiNewvo+3PUvawXXFgl+faqrpuDa/Fz?=
 =?us-ascii?Q?zN1XPr1CHBvdxP1PD8T2a/8ZspxPAtkpbqWfwKKFAlUuJw6mCm8wZHmJmcmq?=
 =?us-ascii?Q?NyhjHN6A99DbSK3csxaHSDE3vfTgWISDpOA6EsybDy/UjsaQJvEU08nXSC8n?=
 =?us-ascii?Q?T/RIH73XeEg/1cyQ45jJTCu60H70ZOoEHGPe7KeAPDv03EzsjqPMfRZ+nsVJ?=
 =?us-ascii?Q?PkLJIlIgRuaNHr3hD6zBogBGvqSnupqXWXdaKzj/95L/nIixlYSN4xONy4rD?=
 =?us-ascii?Q?D0wl0ByLUQxTskSjEw4Hr7bpgyNR5c0bcvLWJy6FoUiiJkPTFsYwo0EK6/6U?=
 =?us-ascii?Q?+UgO8MohXo/OnC3/dD8WoVJ3D9qa04D45OEzCXwGapfxQoa1+Ufg0vsQrlSO?=
 =?us-ascii?Q?eFGvK/GBdd6+nfU7T9J57mFr7PMlQF+6Xi3POwYbXpEt8U1TZcurQ8CY+C4i?=
 =?us-ascii?Q?3T/OU/XYIRHe60xpB3Icp+xlowdgCkQXc32sa97oxvorwMYu7nK9bsfg0H/N?=
 =?us-ascii?Q?JROWrEIvSQsf5GYdaJKklH8nzeJcxMTJ4MWruDADwS0NN4JtQIWqyPWq2tzS?=
 =?us-ascii?Q?gNfjJW9mqf/uetn6ceQTfFWXojdH9V8g9m6dAPcrEz5kyM/2PJIkUhmlW7cm?=
 =?us-ascii?Q?NsWpvv7sI24bu8Gmv4pytYGNxg9I5OjDYrgZi4P2V1kCYPsiJNUTbm75GOuo?=
 =?us-ascii?Q?khrK+1E/w2Z55LmtsFD/Q3IbLKH2HwquGyBjMDTHIqqVMUGTS2YNl5sCqz9J?=
 =?us-ascii?Q?LTyFr9XWT0Rzj6q8uzugFgC/7rW0ufgu1p1puLVdsHwy/DI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/oc4fZremX9mz4r8mFATbDIY3z1S+qJSCaaZx7NRYooKYxW3bpL6lo+81xmm?=
 =?us-ascii?Q?HhJ0wROQ8+PnI9yuhPDg4olVNVriNQ8Be+7YbindGlDCba3bayUyMdLyq4lw?=
 =?us-ascii?Q?ED7KyRd671tYwtDzL3JjXNWHKrDIx8XZ2bqupDuy6nRLBwstjzZyi8I6Alco?=
 =?us-ascii?Q?ZpO7hcedoiushJZNS6IlCRwjxWyyRlV2oJ98znOOSxXBGnaDF98s5SDnVrja?=
 =?us-ascii?Q?Ami/fM4O4qFI801dGznDQkooHg6rcq88eD5Q8CFNstCmKvrnVnOod+veg6b3?=
 =?us-ascii?Q?k7HFRF6anXutRJ4JetIzu6lKQPg2NBoA5tX3roalSRNrcaYvTT9ziYVh2P2I?=
 =?us-ascii?Q?jGlM/V6VbZlopUHV2Do+g/DYCSs7F95BpmL4TW608hquGfq+3ECF50ItnyfW?=
 =?us-ascii?Q?cU2tjy1PCLqdADSSCZflncwuNZRbmQZBUkBdwNl3K9lkf4syQL6zA7/I2Sgl?=
 =?us-ascii?Q?olIfcUaga4RyRqwmsg10w2Mwg5LYZyvHxRLKlOkLQa7qGjZBNoCeYtMw8XEc?=
 =?us-ascii?Q?wKJFQ0+hovA70TSOTJmZm2aVEHI92uWh7Leclqgej64MgyURLoVDU+laI9Xw?=
 =?us-ascii?Q?tdS/PODwPFJX+vkotxw8Nu8mbGiUQSaipu9Ok6D54B0PLefv81PZ9BRv+iHz?=
 =?us-ascii?Q?JB7ozRQ8b1wyEp22kLYxsNJAOBfScPwPT4YC4UTQ+LH9/BPCunGCktVRffnl?=
 =?us-ascii?Q?aCccPiRPMWVrB7Lu8ojY9j72mOjr8Hv2yLLRj84qp6u0jdjTHVJcUCsv3n5m?=
 =?us-ascii?Q?1AOXHEoBKZzv20KthkZgOQhWG8YWZmUdMir3Ro/tvlgZuy59lRnqSp4pvPWt?=
 =?us-ascii?Q?8mxCq9vHEV/hfRdtMGBg9DEgIGjQAwryUml6gDGRyat01Ced43+bAWRqBasF?=
 =?us-ascii?Q?Co7q9ch8VRAeCxPnrnw2jaqn14LenZlw9DQDE2ctUDw0+s1gba4UnSmbp00S?=
 =?us-ascii?Q?wIjPYBgj8olbR145o1ZXwDCcSWQ3WApqEFGQOR0s3LvxJHQFx7EfholK0g/C?=
 =?us-ascii?Q?kpW53PZkGfK714viLmG0RxT/3sEhQP1agSRnf+vLl9QOHNSE+eR8DhyfOOs9?=
 =?us-ascii?Q?IymOytrvpZQyoeFHMo7DT9/TlpgH8gOQnxIhSTsO7QfEY7VU7q7Haj9xbogB?=
 =?us-ascii?Q?cS8E9mZJHIICiC1rLkLEn0DY1ejCVhqdEKlWJ2wyJoEFgGSzYVkUpDSC/lnp?=
 =?us-ascii?Q?8e9zkoi9Ux5odlHtUgAA7CsSwkUNEFDFyooRl+14FvQoxhyKee17dzprgtTW?=
 =?us-ascii?Q?KMdlGNeCTYTmQFAlDE4RyAcweKRHx3Kl+Nbv4JzwECozG3eYXKBHZEOoWePH?=
 =?us-ascii?Q?0ktL0cJDIe2qPw9LUF2Wcu24?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d518b7-110a-4923-d5e1-08d9885a4591
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:54.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R08/G5LHXpIyOYxkHvVRycbhn48YUU3l0riiXy7OkdCdoGQIek5alJVC95SUHtYCyN8+xVXEKLwJJwZ3X7+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the existing sev_exitlib with helpers for handling pvalidate
instructions and issuing page-state changes via the GHCB MSR protocol.

Subsequent SEV-SNP-related tests will make use of these in guest code.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../kvm/include/x86_64/sev_exitlib.h          |  6 ++
 .../selftests/kvm/lib/x86_64/sev_exitlib.c    | 77 +++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h b/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
index 4b67b4004dfa..5c7356f9e925 100644
--- a/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
+++ b/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
@@ -8,7 +8,13 @@
 #ifndef SELFTEST_KVM_SEV_EXITLIB_H
 #define SELFTEST_KVM_SEV_EXITLIB_H
 
+#define PVALIDATE_NO_UPDATE 255
+
 int sev_es_handle_vc(void *ghcb, u64 ghcb_gpa, struct ex_regs *regs);
 void sev_es_terminate(int reason);
+void snp_register_ghcb(u64 ghcb_gpa);
+void snp_psc_set_shared(u64 gpa);
+void snp_psc_set_private(u64 gpa);
+int snp_pvalidate(void *ptr, bool rmp_psize, bool validate);
 
 #endif /* SELFTEST_KVM_SEV_EXITLIB_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
index b3f7b0297e5b..546b402d5015 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
@@ -51,6 +51,19 @@
 #define GHCB_REG_GPA_RESP(resp) ((resp) & GENMASK_ULL(11, 0))
 #define GHCB_REG_GPA_RESP_VAL(resp) ((resp) >> 12)
 
+/* GHCB MSR protocol for Page State Change */
+#define GHCB_PSC_REQ_PRIVATE		1
+#define GHCB_PSC_REQ_SHARED		2
+#define GHCB_PSC_REQ_PSMASH		3
+#define GHCB_PSC_REQ_UNSMASH		4
+#define GHCB_PSC_REQ_CODE		0x14UL
+#define GHCB_PSC_REQ(gfn, op)		\
+	(((unsigned long)((op) & 0xf) << 52) |  \
+	 ((unsigned long)((gfn) & ~(1ULL << 40)) << 12) | \
+	 GHCB_PSC_REQ_CODE)
+#define GHCB_PSC_RESP_CODE		0x15UL
+#define GHCB_PSC_RESP(resp)		((resp) & GENMASK_ULL(11, 0))
+
 /* GHCB format/accessors */
 
 struct ghcb {
@@ -247,3 +260,67 @@ int sev_es_handle_vc(void *ghcb, u64 ghcb_gpa, struct ex_regs *regs)
 
 	return handle_vc_cpuid(ghcb, ghcb_gpa, regs);
 }
+
+void snp_register_ghcb(u64 ghcb_gpa)
+{
+	u64 gfn = ghcb_gpa >> PAGE_SHIFT;
+	u64 resp;
+
+	sev_es_wrmsr_ghcb(GHCB_REG_GPA_REQ(gfn));
+	VMGEXIT();
+
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_REG_GPA_RESP(resp) != GHCB_REG_GPA_RESP_CODE ||
+	    GHCB_REG_GPA_RESP_VAL(resp) != gfn)
+		sev_es_terminate(GHCB_TERMINATE_REASON_UNSPEC);
+}
+
+static void snp_psc_request(u64 gfn, int op)
+{
+	u64 resp;
+
+	sev_es_wrmsr_ghcb(GHCB_PSC_REQ(gfn, op));
+	VMGEXIT();
+
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_PSC_RESP(resp) != GHCB_PSC_RESP_CODE)
+		sev_es_terminate(GHCB_TERMINATE_REASON_UNSPEC);
+}
+
+void snp_psc_set_shared(u64 gpa)
+{
+	snp_psc_request(gpa >> PAGE_SHIFT, GHCB_PSC_REQ_SHARED);
+}
+
+void snp_psc_set_private(u64 gpa)
+{
+	snp_psc_request(gpa >> PAGE_SHIFT, GHCB_PSC_REQ_PRIVATE);
+}
+
+/* From arch/x86/include/asm/asm.h */
+#ifdef __GCC_ASM_FLAG_OUTPUTS__
+# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
+# define CC_OUT(c) "=@cc" #c
+#else
+# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
+# define CC_OUT(c) [_cc_ ## c] "=qm"
+#endif
+
+int snp_pvalidate(void *ptr, bool rmp_psize, bool validate)
+{
+	uint64_t gva = (uint64_t)ptr;
+	bool no_rmpupdate;
+	int rc;
+
+	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
+		     CC_SET(c)
+		     : CC_OUT(c) (no_rmpupdate), "=a"(rc)
+		     : "a"(gva), "c"(rmp_psize), "d"(validate)
+		     : "memory", "cc");
+
+	if (no_rmpupdate)
+		return PVALIDATE_NO_UPDATE;
+
+	return rc;
+}
-- 
2.25.1

