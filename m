Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B3477A3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLPRO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:14:58 -0500
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:62176
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhLPRO5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:14:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg7+aFva4fEc/60PpbAxePU86cWNccDszfCK9V6IPVtMpEzz224bhc6i4EnmQ9EBS+KaWFG2SyjaJ7FjbOtTDy++LyffjdKGYwxaFqZN77G3MX4dVQpPWiLmOIXijSqjDq4zZqNhSVL9DPldU8JGmGmfiezWco+N0RBC46yx/QfMfN+XiLduol2gINgXiiFpxoPgRQzV6GkoRrfWaIx6Gkr9ZeEwk88neYSNHMdg04NBud3ppme/CgvKObXIVTrBXPcGU6GT46mNN8tjFIsC37/xSYOGnk0M5X8KSVeeqmpa650jzoyoQclazsF3ZDRhNVkG/gFk439VxaNDpDkw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C61ZZ4VSDTm7gNgNtaN72QQgAXlZ5VHkw4OEdGMeqv8=;
 b=c3XVV+LrU+0CKhl49U1N5B5wcEm5voKo7CQc77M/IfPcYOcHOXc4WkDh8jpdqUAA8EhYGm5PbADSYNEPaMzhr8/qM/80Ymlh2/oOTR1PHGbrAPKIjYXjERZosoehZIhxZB3bgTdJze3VBMul0hK3YGLPMYz4VX/pNy6k2Sr+k2ZZ1OErGz+asCJn9CqcCLHdi+W7KOJ6B+D3HrpSCTgln0tisbjYBc+oUBosfnExFt66gR7I0f9ug4otTGguYkmCiNbzg/9fr5vqnpcEO0FOWVd7Ja4TtXOvHakwbUt61OSwxe9Mj8ITPIbowxzvLPEvkj9v/aNtaXqRVFGhoFb2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C61ZZ4VSDTm7gNgNtaN72QQgAXlZ5VHkw4OEdGMeqv8=;
 b=X9cUUL/h33Q0VBTpjxICvaVrv7gxkPxZGvUmG1GKgS3t0mKMa2BhheS3YT4QnGT2x+lw7T3ONlvXl8wCo3Gan9TttAcCYMRsVzi+LcpzafB50Xq27gR5Lhm8h5nzvJEg4PHr50mbrfQZAYvGxGO2hdV9+ywiiQklv+rCZFHhqF4=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by BL0PR12MB4740.namprd12.prod.outlook.com (2603:10b6:208:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 17:14:51 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::50) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 17:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:14:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:14:49 -0600
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
Subject: [PATCH v2 10/13] KVM: selftests: account for error code in #VC exception frame
Date:   Thu, 16 Dec 2021 11:13:55 -0600
Message-ID: <20211216171358.61140-11-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22a72b10-1241-4f01-b251-08d9c0b791cf
X-MS-TrafficTypeDiagnostic: BL0PR12MB4740:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB47408A431FF263FB82DD90B695779@BL0PR12MB4740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ra3pRQr6UyE7af5SQHY6buMBBs2sA8LNE/Yvtc3yRy1yLnpTwAQjN87E79RHBDtU0EQgo0fyeL0pty14F4BCOSnPaktFaZF/dPAF/nwHyGRG28Vm3ulb1Vp+Vnz6PSpvynEEFck4w1YrPRlVn/0ynzFf6C27sVYD1mNsnTmlyGOH/UXuOxTSAJx9JtHHGE8UpxZe0fel8ij79IKHnNifALIQUNBFI7V+wabcgtUnLEdiD+RbcahUCmW9Wvs/PvOKnbxeZX3EwsFnIP5GC1MdiYI5hIlUTWTLJL9MZeWYRIWuC+soKA4FGom5dyG/uuLF3KBVUjQHh/R8Tq6fjGVe+9q6yQmkPsHhi4JPH5ui1WtYMSl+0Yi+M3yZX9D/Ur8iR3axOp/Jb6r9F5inQS+C5zWiq6pANurVvdb3OANT2DFpbr8EzkE4sZhQaQLkxrwzPtLlNiW7Q7RnO+c7br+4x9wfipn0BBY2qrJyKGcTABuE0lsgt6nAxG43ct55deojOxXEkM0FtEc9vLL7OZ7IcF2hJGRcd7mdmPuigFfT1lXKUairvcbJCWPVW/ZzxIOLtGGxJM7C/FiariwZz/LYpaEESu3r79e/0leFOCWhtb7kNNLg/bms03iUBpJaU+aNJ50zYig89kpc/sTZpAM2HC0AjvyPsnDHeKmFRoWakDoAa0apkZdTwEVHW9AsK0StqV47rpM1hDNL5OW5M0tRwv8QklkCY9s9/9BjqTlwwtVSmd0LO6Kj1vAMGtmW32Ije7CfnMwsRQX2lLkmUMVHJnjagtvgTlh8Dzalm1bqnqA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(4744005)(36860700001)(6666004)(26005)(36756003)(81166007)(44832011)(316002)(6916009)(16526019)(2906002)(2616005)(15650500001)(7416002)(5660300002)(47076005)(336012)(1076003)(356005)(8936002)(426003)(4326008)(8676002)(82310400004)(54906003)(186003)(70206006)(70586007)(83380400001)(40460700001)(508600001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:14:50.6710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a72b10-1241-4f01-b251-08d9c0b791cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4740
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Exception 29 (#VC) pushes an error_code parameter on the stack. Update
the exception list to reflect this.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/lib/x86_64/handlers.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/handlers.S b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
index 7629819734af..19715a58f5d2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/handlers.S
+++ b/tools/testing/selftests/kvm/lib/x86_64/handlers.S
@@ -76,6 +76,8 @@ idt_handler_code:
 	HANDLERS has_error=1 from=10 to=14
 	HANDLERS has_error=0 from=15 to=16
 	HANDLERS has_error=1 from=17 to=17
-	HANDLERS has_error=0 from=18 to=255
+	HANDLERS has_error=0 from=18 to=28
+	HANDLERS has_error=1 from=29 to=29
+	HANDLERS has_error=0 from=30 to=255
 
 .section        .note.GNU-stack, "", %progbits
-- 
2.25.1

