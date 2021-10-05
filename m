Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404D442348C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJEXrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:39 -0400
Received: from mail-bn8nam11hn2240.outbound.protection.outlook.com ([52.100.171.240]:62688
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231373AbhJEXri (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2djrroHjmDfeAYuizppqHyqO2nB+uVBNelmNBsrno1fA0WO8a9l2qswOGvWJ5VOKD1gtpi9wPE6ObT80YjOABwKj5+GioASMp7qN84sEHkYfFtLcj1Utlw+b745yqmYOkvYBkRX53+KFrYIK/omQ+1zoL55TvYWxkjk0Taou/HaZE6ilpCSsgaYyL+3PSPgNaCrjFArZ7S7Dh2SZ59Sy9L3MTbGIpiIWxOtPi5n2//Etl0XN0wElvqXZhqZhhGBW3PKqsLLWhX6PgUSauVsVaayDX0ELxgLEDA1dxtLch0dMks3dIlRdOEZf6zVqPDTGg1dwjzhzsUZ9IJ//VBHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C61ZZ4VSDTm7gNgNtaN72QQgAXlZ5VHkw4OEdGMeqv8=;
 b=A5atAxXAs1S6VvkXEcuOQ46/8CNr1u8HeRQG1GPB65Oq6uclfFjafrBeg4TC8RVn9WoMFr3tk7Q5LOZ8UBjeLlM2BPbk5LTr5d5DkLKyrgZJKJFzghzCtiBnYHt7fAtRPgskn0je4vuRWVhrk/p/R6xywlZYUUS0rP55nesxEykwIoxUCdY0h6r7/BWdYFbLATjBWC8Dy3/SrIwfTqVu8b2SfIAi6NHHm0HZIIfSawhQ5/PBcLoNW5X1rbx+4BZC174OviEIPI8JVQiaeTmXxQTUDYFBy+4NkDiMLxKU8N/PoUm4YbSPUT0q2lLVcKY8c1W32fMb3HVX3CebPShDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C61ZZ4VSDTm7gNgNtaN72QQgAXlZ5VHkw4OEdGMeqv8=;
 b=Tl2c0peJGsNiy270hRTaURSn+1dcSN9QiPhqxCP1UHcW/5Irxs6UJ+Ian0FjsQj3pxTfG9xSaUbOjwPSAx6JhNCvX+1E09TykC2uOzMVW4cZDWYkiJ99Ax7hxFwRonFjVbOuf3kO1oSjyBrV4M1BvE2RyGMbCisHYtvPRwI/WGk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:44 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:44 +0000
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
Subject: [RFC 09/16] KVM: selftests: account for error code in #VC exception frame
Date:   Tue,  5 Oct 2021 18:44:52 -0500
Message-Id: <20211005234459.430873-10-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:806:125::6) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 23:45:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b60367-c8c6-4636-19ed-08d9885a3efe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925968D1C1B22F66668C5B095AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sO1XJlv2ZUJMsmv5w+AYNzB+8zLgjZkH/LFQnjXxhi4+ELt60mmy9dckzITL?=
 =?us-ascii?Q?IFSfqDVx0WJrVhgc8cBkBjVfgIHIAae5lrxnw6F65EN0TewsP2c2S8JTLz29?=
 =?us-ascii?Q?8MGONNSNu8IwrzB5jLWlfYRZFvXXfaohF0BAdknqvw0ODsLk0V9AycJ3yYbA?=
 =?us-ascii?Q?7047taQ6uiMV9Xc8iCjQvyjoHq5b6KIY+ZMZRjByT6fvTL+vsduvcPIKRToI?=
 =?us-ascii?Q?7xc84YHwzsmDXzIsOQHisTDCHIpx8yTvWEFsIL2cb6f0zxnsMpcVjowmsBhf?=
 =?us-ascii?Q?bvd3c6BYd9NDFnE2wUFsgHm/xlYSTshrDks9xXSywkTm4zadAdzDYZEIxCf2?=
 =?us-ascii?Q?MaekIx5IpMutUJiZ7lTaEFn8tZ3MX2+HS21NFUEM2YPuV/KJ8ZyxJA21qOpB?=
 =?us-ascii?Q?zbcW75enba7NbPMGljH6fodiCgTay9qwyuJlDntug2CFCcIdCwwNGvGKBOhC?=
 =?us-ascii?Q?ybT7bSMSUfDk1uLMaSQPapWM3ra2YZ9+1MvDVbfW+HiikxnGtqNAt1o5pPDL?=
 =?us-ascii?Q?OrnfFqcVGy1awPX0pyqpuR61dXEY71PNvynA2eRMQlbc+BP1YlmWivD5uMPu?=
 =?us-ascii?Q?CSSR7nXYsxZG869/yKVFfaDY9XF0bUMrl8bPn7Lm04B1Bz2Cb4gWkaGEh6mO?=
 =?us-ascii?Q?sPkXjypSP85gynsR9Ubx7XcDB0SMg0e8AWf/FeT4mWst5ySdJrnsHO+LWwrz?=
 =?us-ascii?Q?o7z5pGjYwHF7HSMx8+I6psMcA8XZNkXT73I4sr57dtFSSP1hTB+D1f/NTzcu?=
 =?us-ascii?Q?afwlj7EFaET4Lh2krcNtUEVQST/RrfIisT+ovsXLK2VXuBSJvn6Qnlu+4l/Z?=
 =?us-ascii?Q?y8XEG2CCNnqlu8+FwR7VNdY18OTNsDmp2pHcMr5Mnr1wZSlsqFvjhH5LEZYE?=
 =?us-ascii?Q?CvWJqfhrhbpATcyjmgAe7c3XigYzZSQMzpmJnBjEgtf/StsHoLwTypOCYamD?=
 =?us-ascii?Q?92t/XZ65chHSTeRQzB8EUWP1j51wPJGIorgo/wSvv5l8YE3ahZemsAWfhxZb?=
 =?us-ascii?Q?ZorT4cuy26n7kzqFSNLepz6pEPq8ErnaCjT1BeO7fdSalNg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(6666004)(6916009)(316002)(4744005)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(15650500001)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?frxBVqEK30Y06cCXLNNWqFkoEwUrOYavQQy+H+bsn3ifFuDU32XDL9VwvEGn?=
 =?us-ascii?Q?dB1h+2ZtjqQ/fG4dv4ZEEZo4Xrc32qOGl6XLdg65nmtxxe92iZWBxnxku+/q?=
 =?us-ascii?Q?h8cdeeCyO8l0adeqqA4yxvdQ8wRxLrzMF7DjgnRtewCZApdtS1SLpg82uIww?=
 =?us-ascii?Q?kKVJlP25kTi1Kl/CQrokexgeh7Jp4lJedhRx4Wf4fOi0uM1zY9vBAj6XARqm?=
 =?us-ascii?Q?PIHV3s8O4x9H+ZQ/6TjsdKyfk3yZNsg2S+Xr4qweA/MQ62/BUuURYwzlsBTq?=
 =?us-ascii?Q?WEMVqMhKyZa+MuErocuC0ptabI/pvoKWPZ3+W7vwPf94arolR7dwzKx5XAnc?=
 =?us-ascii?Q?41Lxl/ApN1mAMgLVDQFbodM1Mv9TNj6pOXwMYg8+eV3kEWdspAi+oTgDCmUH?=
 =?us-ascii?Q?D8L6bjPLfO3YpBlYycY+AHmi+quUuUI+X9oueFTYNA+qky7Ccvgq7NGjrq4m?=
 =?us-ascii?Q?ud4gRkwoshJYUu/IVWCrL6oWVf9AwKrVbVL6OxLPVpoie/Gfnb4P0DGAtiJG?=
 =?us-ascii?Q?7mfctucQ/saIu5D39BPIke26RSc5lSrHUGJ/mXGZOEhOTAO9BY1SqHtCbWtV?=
 =?us-ascii?Q?RcAJop3pVb45waW/sb+TxMKvyeeDoAvmB2eYO5wAHe4HsEFJ19wfCtrRBgob?=
 =?us-ascii?Q?e7jOkjgSI0YPFKg0x16XMGhqVNZsmcq7hKA0C82u0fZ15bxXyLO7U9HwNwmb?=
 =?us-ascii?Q?+x1K//8sSpfx0TBsFFuPoyycQ+UTyuiD2N8/2QawUMEvr9r4PNIMcfc5jF3f?=
 =?us-ascii?Q?oq5Rl8bgUes9P9lGYHCdmLsUEuGZjoVzHtKHRo2Tel3/JxN15mj+4bvqjZii?=
 =?us-ascii?Q?kgOl/0SNYvy/2NyIJKtJDRINzV/Nz3Wv55CHxJLdpDeqyZueOb708Fx1mEll?=
 =?us-ascii?Q?7yStmeDkGeSrW7AcRp3JFgmF5BvT7/9X1mgmjQqSXczMJyeEIzA1ZOCXXppy?=
 =?us-ascii?Q?+/L0iEf5Q6KsKz2tPtdogqz9cBVwRvz2JzsxAyF104LAEJf6TnjsUMbq0oF3?=
 =?us-ascii?Q?uEBotipvY8uYk4Kpjyx3YeqnABVmHpB/iopl++K5NoWLbafS3GASlfGC4+ww?=
 =?us-ascii?Q?VFEW0ygNgCt4wOwfTkjmjSnLuiM8cvUKgRH9b98S7mHlMnruQze4JguVieLm?=
 =?us-ascii?Q?ZVxmrVFNyoJ9g/msakAe906xrHPuMB5HE1eQu9zTSaHrYEPWUsxyTRnkE3Hc?=
 =?us-ascii?Q?iJi58Y+cIjLYBxo9+1ZS3/scx2jupKIEGdC8DLs8vtnrJyMXZbiUnLMTuUvz?=
 =?us-ascii?Q?zURyshxVJu+frY3EgG2avf0UZ6iSzKGh+77Z4Q3aAVmIA2xQf5XBtHwi19I1?=
 =?us-ascii?Q?J/xdMFFJnbRAYsFSnkux6c5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b60367-c8c6-4636-19ed-08d9885a3efe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:44.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQgY8zaWn4qpn3AT90WxB2l58I7bq9eLMo/lL0pPQAXRSSQ+V9ldXePdvgPNSgEbLtRmhzUXLHYUcP1/fVMfPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
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

