Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7D3F4BFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhHWN5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 09:57:31 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:56744 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhHWN51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 09:57:27 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17NC5o9Y014859;
        Mon, 23 Aug 2021 13:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=KM5oK4KKg0VX+5UqhzpDBBPlbDvEwPnU/ByoFkuqfeU=;
 b=oZi9SQX/a7bHg4VllY22dcBnB9CY5z1VMFrrmwSd5RWAb/MHeRuAZZft1is2xzzr1IXN
 AcPPBOhfCrw1NnyngnzIZdK3GtpivEkOEc8mvHkj2RGyexUmLcZzDq1rXxtmBBDpDsar
 qxFqTgglTQ9DQc0VHA7Zo6M32QVW24z64rAhlsYZ0nYiP4zY9OxYsDx6MP5Je9SKnisr
 uBcBC8puE5u0Y8MuaBOldC6B8ziiB0JTje2eaROXLM4c/W5YqZF/6MjFpLzs3YMy8mHt
 rCGQ8UHWORqJF5iOAC4eC75mdVMLQ2ssYcpyja6X5kS9V01xxuI70ctP50eW/JTz5VBC 5Q== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 3aknf88nhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 13:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNMZDP8lQ26uhKzl0zivMUqqYwqiPxxx6fHjqiLm168RJhmS7ynWtfnWeQyeLH0HMbJm5h2P4t21p6xbZEK4Zh0mPJHYizo8qfjm6P9+9BuLZi9fc5MWVSN159JBWAw1Xv8XOcwN6NDzTH0EIiPSg3pw9tJElx1/bNWpBycf3m1rolpNx+9gPyKrDhmWrEJmIGC6BWfoI2wKYtso6ceQ8e7FN7znUpua8BveaRRtBUaBfbaYoKLSXtlFXQyX+Uy9mzJj62KIJ/Gi/miruVhasoXPo4Wh5czTlKi4R8oyoSlKqBDxmiasMNWuQ1UFS/R06Vndfjr+2VUce7rMGAa/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM5oK4KKg0VX+5UqhzpDBBPlbDvEwPnU/ByoFkuqfeU=;
 b=LP2S2NpYnang1go9K1folK0wXYcx+Dizq+Obbot8AiD+0YxsVNa6gsZrFcHn8bYYzkk74FxX2ocCFKKze/mU3GVzRLWtP5a7ZsB2I9Zhg1PGjy23TOZ2CiAkmZu8LJ3O/KS0acU84/DWUNBHJc83+uEI28kMRuu0O6JUD4T4gyfnkP4KHIvQnZae3ba55aC8V1d+lXyA1ZiIlt5zv8yJYB1tZjnqrVL7JFaL2hvf1fgdc+/tiObYgsolguJgZhUruVeJAoqaR9Q7C7HOKDSU/ecZwfpJgAGjwg7gydlawlZcdwzfCEr7umoG86EMhw4dMaSKjT4RzHUETrVEskIV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM5PR11MB1804.namprd11.prod.outlook.com (2603:10b6:3:114::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Mon, 23 Aug 2021 13:56:38 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 13:56:38 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun.miao@windriver.com
Subject: [V2][PATCH] selftests/x86: Fix error: variably modified 'altstack_data' at file scope
Date:   Mon, 23 Aug 2021 21:56:26 +0800
Message-Id: <20210823135626.3926364-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 13:56:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f100289a-49f2-47a3-78eb-08d9663dd423
X-MS-TrafficTypeDiagnostic: DM5PR11MB1804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB18045FB610C699FE6E36A1788EC49@DM5PR11MB1804.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJdElJxKFbhrf6Fi/K2nUi78zsHnXZh8um9qE/Qm1UdgnMF1zS+Q/Ok/QNHJvqz6pU7pmWiq4Dw6sikmao/9xVBSecUX26EL7AJgw+ch279ykm0z8yRBcrjg+OfinH3WFnsMvPr7CjNzR5uKMwxmCIfVJhjI6861MUHBZX0qjdYXcsjsbXOAo/nIpyglLlYvO1+C05ZgSjPRU6ZNfx1xv+9lWWMOi/BfV59Olco5EpH0bKHomAfclkaYk16MzIfVtKKd6WjXvv8w3Jm3Ff7cqdqfOeOcNxw3N6FEq9/og7ucHG1hTSE/5TnOj+bDVANCebzWEif4eR4fSA+Nu7H3mXagzbyMsSa6oL4ZcTAr1hC3XFkPu7R+hM9f+FhxRjSLAYeRHF5K8++rIwj/gDdpVHfE4FqymWCnh3sPrnIQXIvpTXua7ZOqWJffkN5c0IFLvwl0EyeMYiqF/Eo1DQOrIfAG5dGtDvbzKUhRPnn5f0fICQVPFv3nqAq0nbReG2uYLvnmZedfOULDsD5gxrxfR8XkfTumbTMMgiD9M03eTNTt93DcomhiO6YRW8T63y1yPctx6+AM8bnwipZaHdRlvQAaMIQD16UzpzwBdQSLeNfGPKw48M4cO0ONZ8wrl53awVKOmV4xGUM1zw2pEv0jOTzXIEDAP0wMOCrzmE9wYirApx+jmoxskI7YL8IBw25mmhfEyNTcINqyFDtvGirZgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(4326008)(52116002)(6486002)(2906002)(107886003)(6916009)(6506007)(44832011)(8936002)(66556008)(6512007)(2616005)(5660300002)(66946007)(956004)(66476007)(316002)(508600001)(38100700002)(36756003)(38350700002)(86362001)(186003)(6666004)(83380400001)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uy+9Cq/SighOYM18cARd4xGRrt4UWYvohA43v6GYYC5997iDqXKyPBLZgRv?=
 =?us-ascii?Q?XfVPJYbUOC286hqwQIirF2pEmVmaK8eAnSY75uyau5hM/hstXJ1ntlgKBhFS?=
 =?us-ascii?Q?h87LWOsSV5x/YC3oSfr90w3d386fkAJzg2h2QA3TYezf8xMPNFU4x/a5Uf0f?=
 =?us-ascii?Q?NrtVnuBLNsCeY1g+Fix7qMUX44XVFDVw4HWTvbdjxax1bduFmTOEmWu0KZLn?=
 =?us-ascii?Q?hnL1Xv7heU8hNrA2lMt/H1s+wYpSr6EFzN6B0cU98UPg9dUX/btL6ypERRno?=
 =?us-ascii?Q?Jr50DtC+FgkB12m3GYdW20EAcI6c00ITK8lOvVcdv5ORNOZ5ncIto/UqhSKh?=
 =?us-ascii?Q?yJGa0itrYjC1Cis3VJuj/S91ztpBKUCHCyAGEGZDofY150sjCdys3PK43e4Q?=
 =?us-ascii?Q?lD6sCJASJGkmm0GK+EjJ5q4kM5Ig/A13SOWl98iF0gjkd/ulS818ZEAB9Qj/?=
 =?us-ascii?Q?OHjwQXi3DCQg1j+VIP38tWpgIOIr54EEJY5ySCH9yuRh2HuN01gzoIo/BWGS?=
 =?us-ascii?Q?NoGNbFSaN0OqGF2gCN6QavOEH4bQ8U//fo77Un3peU6BpVHpgk6xMxrqOOF4?=
 =?us-ascii?Q?BwO3xV85sQq0M6vKJS24rZmSHCnz72gw6xIH6wDanOjj0n3UbaiZKH9gDs8B?=
 =?us-ascii?Q?o992TxSPqE5MdYqWBgVsUCP4yQp5nulsE8/6wfDRiVILC3yWcpuh8Waizzgh?=
 =?us-ascii?Q?4Xm+robaKDFWA+bSmEWVAnlbtdGA7O4aCT5UDuVxRPueBvi9Yt/MCjRytSfA?=
 =?us-ascii?Q?Wa3019zHX0eSYtq0A5oOlG8nr552sKv3khgbX0GVyMiUoV5Ds6hOQzlJL5Ib?=
 =?us-ascii?Q?Yszk3W6mrYAMJKgUdiZI0rIfSigrze03yerA/ikbwH6wzVIuI+jJbBsNcxCU?=
 =?us-ascii?Q?CKh5R5upNkb0rWNYkpGuDHYNU+WCV2U+2PO40HJqS3aehZIJMySi7USNaaSB?=
 =?us-ascii?Q?OHHj/hsrodMmQ8LyQVtMaJZnGuJhClxTWyDP0jaM6l+ix4ezXmpuj6cSQB3f?=
 =?us-ascii?Q?1S0VsKEUOyEwp+YRIU0utayGN6eD2ZXnyvL3sIB/pdmbp/EigXpffFESHiWM?=
 =?us-ascii?Q?BeUJMDjqBWuGhT9MDD1R143Vufw/Db7UyOKl5c6YyfL4gZVtMH8uQNhlhnef?=
 =?us-ascii?Q?oWEVkm75O2LOiB1BDonKw0iLETCg1iNtp6ChO2l3VZgzMmJXaTiSb43x+V75?=
 =?us-ascii?Q?i57R/PvbbMPFIG3jnKhJUwHZC6QCtpC2yC6MsrnKhuhHtx/zhcCzhCbWk/Nc?=
 =?us-ascii?Q?XD6XwMEkayDlmFs8HdwVfDUKbMmla/ZZ+rcnZlZK8+oex+mQCkw7AFtA4cnL?=
 =?us-ascii?Q?tLk7agjPPD5PGD4Pe1P6Vj/t?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f100289a-49f2-47a3-78eb-08d9663dd423
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 13:56:38.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo/BzUCcbKxUt6SBRrBXQI26Z4bXma1wCsJm80CpvTTHsTJyEB0CjYdLfGyz0mz0+LgiBrkWlCuJvSXIIVZwAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1804
X-Proofpoint-GUID: Lgw3h8x3pPVO9zHprwQ4RBDtH8AqVoYX
X-Proofpoint-ORIG-GUID: Lgw3h8x3pPVO9zHprwQ4RBDtH8AqVoYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=954 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Based on glibc 2.33 -> 2.34, there is one new feature:

NEWS for version 2.34
=====================
Major new features:
* Add _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.  When _DYNAMIC_STACK_SIZE_SOURCE
  or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ are no longer
  constant on Linux.  MINSIGSTKSZ is redefined to sysconf(_SC_MINSIGSTKSZ)
  and SIGSTKSZ is redefined to sysconf (_SC_SIGSTKSZ).  This supports
  dynamic sized register sets for modern architectural features like
  Arm SVE.

Build error with the GNU C Library 2.34:
DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
|   150 | static char altstack_data[SIGSTKSZ];
DEBUG:	|       |             ^~~~~~~~~~~~~

Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 tools/testing/selftests/x86/mov_ss_trap.c         | 4 ++--
 tools/testing/selftests/x86/sigreturn.c           | 7 +++----
 tools/testing/selftests/x86/single_step_syscall.c | 4 ++--
 tools/testing/selftests/x86/syscall_arg_fault.c   | 7 +++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 6da0ac3f0135..1ebf5f3f0fcf 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -47,7 +47,6 @@
 unsigned short ss;
 extern unsigned char breakpoint_insn[];
 sigjmp_buf jmpbuf;
-static unsigned char altstack_data[SIGSTKSZ];
 
 static void enable_watchpoint(void)
 {
@@ -250,7 +249,7 @@ int main()
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		printf("[RUN]\tMOV SS; SYSENTER\n");
 		stack_t stack = {
-			.ss_sp = altstack_data,
+			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 			.ss_size = SIGSTKSZ,
 		};
 		if (sigaltstack(&stack, NULL) != 0)
@@ -282,5 +281,6 @@ int main()
 	}
 
 	printf("[OK]\tI aten't dead\n");
+	free(stack.ss_sp);
 	return 0;
 }
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 57c4f67f16ef..5d7961a5f7f6 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -138,9 +138,6 @@ static unsigned short LDT3(int idx)
 	return (idx << 3) | 7;
 }
 
-/* Our sigaltstack scratch space. */
-static char altstack_data[SIGSTKSZ];
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -771,7 +768,8 @@ int main()
 	setup_ldt();
 
 	stack_t stack = {
-		.ss_sp = altstack_data,
+		/* Our sigaltstack scratch space. */
+		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 		.ss_size = SIGSTKSZ,
 	};
 	if (sigaltstack(&stack, NULL) != 0)
@@ -872,5 +870,6 @@ int main()
 	total_nerrs += test_nonstrict_ss();
 #endif
 
+	free(stack.ss_sp);
 	return total_nerrs ? 1 : 0;
 }
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 120ac741fe44..158b2bb1474c 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -57,7 +57,6 @@ static void clearhandler(int sig)
 
 static volatile sig_atomic_t sig_traps, sig_eflags;
 sigjmp_buf jmpbuf;
-static unsigned char altstack_data[SIGSTKSZ];
 
 #ifdef __x86_64__
 # define REG_IP REG_RIP
@@ -210,7 +209,7 @@ int main()
 		unsigned long nr = SYS_getpid;
 		printf("[RUN]\tSet TF and check SYSENTER\n");
 		stack_t stack = {
-			.ss_sp = altstack_data,
+			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 			.ss_size = SIGSTKSZ,
 		};
 		if (sigaltstack(&stack, NULL) != 0)
@@ -228,6 +227,7 @@ int main()
 
 		/* We're unreachable here.  SYSENTER forgets RIP. */
 	}
+	free(stack.ss_sp);
 	clearhandler(SIGSEGV);
 	clearhandler(SIGILL);
 	if (!(sig_eflags & X86_EFLAGS_TF)) {
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index bff474b5efc6..461fa41a4d02 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -17,9 +17,6 @@
 
 #include "helpers.h"
 
-/* Our sigaltstack scratch space. */
-static unsigned char altstack_data[SIGSTKSZ];
-
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -104,7 +101,8 @@ static void sigill(int sig, siginfo_t *info, void *ctx_void)
 int main()
 {
 	stack_t stack = {
-		.ss_sp = altstack_data,
+		/* Our sigaltstack scratch space. */
+		.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 		.ss_size = SIGSTKSZ,
 	};
 	if (sigaltstack(&stack, NULL) != 0)
@@ -233,5 +231,6 @@ int main()
 	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 #endif
 
+	free(stack.ss_sp);
 	return 0;
 }
-- 
2.32.0

