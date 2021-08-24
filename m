Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC13F55E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 04:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhHXCpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 22:45:01 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:33464 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233971AbhHXCpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 22:45:00 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O2dPc0012276;
        Tue, 24 Aug 2021 02:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=U0x+6c4EFJ1nAvsY064cfkaP07i62ZsqQI57T20pTQA=;
 b=Q1ALZ6k4j95bjZL4BNr43KR2hIbEXLXB3FHpM8ynzXv4PYsLhl9HPvsTDlIiJf6X1Z0r
 S6LUkEmw0jiUNTZNHHgvmwtbtfFYXQZGfiGM644xORMM3Tg83X5QNZAq7tu/JRdByE/c
 l8CWyR2FcI7VhBxzqgqqXIK/Wpo4M5tgv4tP19v5XF+1k/QjqLmvIlNGgwo0LUFSSO0T
 y9+lCZ3Ry71icvSjkJ3leN0/FXR7oq95N8tgjJPZM62O1uN+Rx9xjE+S7ULVgGBfXsgM
 g1UoQK5N2PbWMMB+ukCcxqWwBg/2tmP3w6NW5PuRTFjNS3Omf+P1zd0uMyLGLKQyKlKj 0g== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-0064b401.pphosted.com with ESMTP id 3amg3pg9qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 02:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXvuzSXTs7/z7x87U9KLxYcEBocjwPaMgdpVi56ix9mE/wo3zX/Y9f3zXlMjPQcz2KSUHlH9nCrz1S4wkWeVLfkkxtxjLS2uBE4PA6HI8ZJ/RcK7jU6fL36vADioSKtJY6CtXqpUZZ4glq8HODpdXG9zDNgg3UE1tejo5DvBSer/C2IdC86PW2zin7p4DCCqzBuO2uyzZ/wYw6lClzsDrYWAQ7BL1qSvncfjC83EhmbYckvNPQNckTJ89PTN+fgwYhia1aR2MtjuAc4LNZ4SWNuJcyZLEpXsE2Hrp9zU/g8tVg0hJirJXD00hOVk8hsfsWWCjjOLMPxWmdzBExBkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0x+6c4EFJ1nAvsY064cfkaP07i62ZsqQI57T20pTQA=;
 b=BcJ+Oz8UqrH0LPbJonlqh62+7yzp5SVXBvxKXVIcQQ9WvWhTCdCkqNTVwv2Mu5fSisW/VWKi6T5rpD7WOY3FNdwupDzA6wlMANdO/sNXJWB+clrn6Tb1DIkdVTEm+GuLcUqn01OOxjT+cf35hH7x3Vg20r2XY62he7Ijgk0+0knkjcKNpEidVZ0ju7HQDwId6bIDAOE8z2o6e2fXCwhLfz10yy45ZiurUBe8TZ2NgLZzkVZNKWT632F/XWWLoACBgyb+hD54tlwFfIMC4ueEa/69TO6fn1ouIthJpIn1EOJP6Oo0BUll2o8nHJ8w9anHA7/JAUFhXSldi5I+IzQiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB3739.namprd11.prod.outlook.com (2603:10b6:5:13b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Tue, 24 Aug 2021 02:44:12 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::1117:e08a:deba:2a45%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 02:44:12 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun.miao@windriver.com
Subject: [V3][PATCH] selftests/x86: Fix error: variably modified 'altstack_data' at file scope
Date:   Tue, 24 Aug 2021 10:43:58 +0800
Message-Id: <20210824024358.4183342-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:c9::9) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HKAPR03CA0022.apcprd03.prod.outlook.com (2603:1096:203:c9::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend Transport; Tue, 24 Aug 2021 02:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f342356-c233-4714-4a06-08d966a90e1f
X-MS-TrafficTypeDiagnostic: DM6PR11MB3739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3739B736F7807EA7EB64CCAA8EC59@DM6PR11MB3739.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Xva/ZhaQ1p3INWOtnJpaZnVzU7EDTgdwTt2aQih+1BZn6idzxj3/1jXIh8+ujcV4rE/tdaJLSO7Y9YM7BW9dGM/Rcv37IUTlKiSGMIF49UtzH7R3JVFTWQ6qdrie44ac+w/oxEy/QT8V8WWTBBDUy3jAYI8ILZbP1jpNukVAPl7p7m8DU5bVsp7UkR7ASDX7Jp87FPszrjEFo2GWtyJBygnw2H/ahZdbdmTZfZ0OxrUSIs6UETjRZF20negClvvAUlwPFQQjQfuQxaQt+fzaO2lwvSfF2e6A3ASlW0HQXj7eEhyXqpD/XsQpvXTHZIePR65rlDqN55LUQRC+QPc1ow/qLgUbZkeuyvu1OEUPAauWarLHJESRnYhPrqkwiP2Uctnyc/04XbjseOwXm2DKOQm1ChhD5OJjKOiJNtd2Zzs1pHi+Ozd7DIqZNlNAHOJbCuxwoHRO49yY4iV2LD+Ad8naCGuQzKBoZFE+8nhJLT7iKi4Yb4H/un23gs2psBTIulirstK0jnViimP8ZSsIrdx2F1w56c5ZvK807uEWeG9YgAgPSUTJHz80/uxSTWTpZraOef1+QvPJpJixKkkm2X+AXJdohT3nmxPugj8WRgJV5ebNQNIF1p9CwKVxz7c4MbBysECrnkW9s0L28YhbpGTA7clit5lbtlxvnn/K/ouCZOg9ye0OJWgegtVswSm7COF7pGAfmcKi3ysQydNGDyK1rDLF9tv7C1YGLjSTi0ly/MAe1FonoCtNkGHZPKxUcF4lIOZ54wMEtudHsr4mRfeP0rlKrEhStAodxB5bxyVcF68OizvCHlTcOdn+4oF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(478600001)(2906002)(966005)(86362001)(2616005)(5660300002)(83380400001)(38350700002)(956004)(8676002)(8936002)(316002)(186003)(52116002)(6506007)(36756003)(6666004)(6916009)(6486002)(4326008)(1076003)(66556008)(66476007)(66946007)(107886003)(38100700002)(26005)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1AjdnVt3dSiCS/L7tYpBloVhYuhWBq+c1hHhMmiv7EuC7Km7wDdpcjDNzqoo?=
 =?us-ascii?Q?NNiVtKjZVNo3Te/t40NJTEXg2PZeHNsahbIRTwoKQ4SDLb03OPzuI88qqW7e?=
 =?us-ascii?Q?qRHDtM/SwJq8lM+EJcIsrTeE5uyMk20GJXunujpnyPKkL9MdB5rU/GqHdbQS?=
 =?us-ascii?Q?NTM3DMQd4TzRcqGhQWluKPHZAcWXhIOtvoAmL0aT022xbZ7HvMtLR0QNsvts?=
 =?us-ascii?Q?Mb5Lon9u1Syxu0IHJgKYoHeepF5K5/sv9T5ZxWEBSAa+A7MIQ+6o2eOw8fo4?=
 =?us-ascii?Q?j1zMeImA8rxaQ8NEkqQnFAMBwpxlulEoO6GRSzbmIoMg67fBOlwQAziED3I1?=
 =?us-ascii?Q?aV811uveGfwTGJqk4sRUpKFTYbRU8pZ+WQLe1vD3dFtWObdbgF3pntXO7EaY?=
 =?us-ascii?Q?Up4DdMcI5gXFAp3RP/k54wW4BZrF42ssBGSp1cY2xX6xL3KXW3bR+IBZs5PL?=
 =?us-ascii?Q?nRrcMNBQO040X6bCbQy3OrN/26v6eOlhArwE7bn2xlX3451nLwTCo9B2yR/h?=
 =?us-ascii?Q?YMicnF2dYZwwnc6YFb2Xf8aOBW88I1hA6hS2WVsna+AXFf4b+BZFjTQJ4y+s?=
 =?us-ascii?Q?T53gmqI/a+KcH/Uo5aIoWH/o647t9yYeMG2Ag2Ni9NXFoIfcxrKHS3OZs9XP?=
 =?us-ascii?Q?gN3wIgYLldLNfuxPl3nQksS20DHla4sOylXFZHLuJXNSALOG3KiGZu6y+X0C?=
 =?us-ascii?Q?sIuOvbYeJTTg2o8hhsG6XKV3BfSR63GgT1ysourSqP+BW2tvvuOzeDxouzcd?=
 =?us-ascii?Q?rUByLUC4PoRbQOpZwnOtTIkxzClSMdxd6JH5fPtaIaQuiG7Iw0C/QopPPXwV?=
 =?us-ascii?Q?a3PVY5u8dft9hPalcfNIjYcbpgH61RTk/Kc25EM3s+MloEFwrTX7CL4xaQsT?=
 =?us-ascii?Q?1MrcloORGs+ytK/wsJIiHPFP91c3dEWz28McWJJvantolqXwQYskABZKB7kE?=
 =?us-ascii?Q?3QcuqmDr6efa4WrxRqolIxgE4fORyzZmo3bORT0zD8OZMBztgwk/VvZyxpzD?=
 =?us-ascii?Q?RtakBmc3YFuw8/OpnpU3Ayj6ctFNwG17KCZMKBKMey7NKXm1lLe9tp0vviSV?=
 =?us-ascii?Q?QsMqk68z2DE3CgLHo5mfbtdczHAvSrqXAbaQGnn4SQgLrlzPcsn7KaS6G6PV?=
 =?us-ascii?Q?33Yo6UgCVF1Nz17758a/dGzvZRz9Xed1PyLfIQySMp9/Uu3567LuaIrjRFV9?=
 =?us-ascii?Q?dbF5OicGhJmtZxdzZJgCtavcKxWbDUeY3JURWIsK2XXijPwPngWuyCrVHFmu?=
 =?us-ascii?Q?U3bsNj8Qqehnz7tapudXx2SCEc7zi/sHHfZJp4CtRmNgqO6OhgwzycBGtyuQ?=
 =?us-ascii?Q?/lPEOOpKeK673OSLD1CwZIAC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f342356-c233-4714-4a06-08d966a90e1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 02:44:12.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM+nW9B68p45d2kiYMQ+BsZrJbyLnED5QgJy+KAX8sBmHbUJNVmWnAP0EnxK6inGZDFzoGvCb+Z+P66IzlVg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3739
X-Proofpoint-ORIG-GUID: EeEcsl4j2mYo4ATP8S0DSfOzwVW7f4Cy
X-Proofpoint-GUID: EeEcsl4j2mYo4ATP8S0DSfOzwVW7f4Cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_04,2021-08-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240015
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
=====================

If _SC_SIGSTKSZ_SOURCE or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ
are redefined as:

/* Default stack size for a signal handler: sysconf (SC_SIGSTKSZ).  */
 # undef SIGSTKSZ
 # define SIGSTKSZ sysconf (_SC_SIGSTKSZ)

/* Minimum stack size for a signal handler: SIGSTKSZ.  */
 # undef MINSIGSTKSZ
 # define MINSIGSTKSZ SIGSTKSZ

Compilation will fail if the source assumes constant MINSIGSTKSZ or
SIGSTKSZ.

Build error with the GNU C Library 2.34:
DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
|   150 | static char altstack_data[SIGSTKSZ];
DEBUG:	|       |             ^~~~~~~~~~~~~

DEBUG:  | single_step_syscall.c:60:22: error: variably modified 'altstack_data' at file scope
DEBUG:  |   60 | static unsigned char altstack_data[SIGSTKSZ];
DEBUG:  |      |                      ^~~~~~~~~~~~~

Link: https://sourceware.org/pipermail/libc-alpha/2021-January/121996.html
Link: https://sourceware.org/pipermail/libc-alpha/2021-August/129718.html
Suggested-by: Jianwei Hu <jianwei.hu@windriver.com>
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 tools/testing/selftests/x86/mov_ss_trap.c         | 4 ++--
 tools/testing/selftests/x86/sigreturn.c           | 7 +++----
 tools/testing/selftests/x86/single_step_syscall.c | 4 ++--
 tools/testing/selftests/x86/syscall_arg_fault.c   | 7 +++----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index 6da0ac3f0135..cc3de6ff9fba 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -47,7 +47,6 @@
 unsigned short ss;
 extern unsigned char breakpoint_insn[];
 sigjmp_buf jmpbuf;
-static unsigned char altstack_data[SIGSTKSZ];
 
 static void enable_watchpoint(void)
 {
@@ -250,13 +249,14 @@ int main()
 	if (sigsetjmp(jmpbuf, 1) == 0) {
 		printf("[RUN]\tMOV SS; SYSENTER\n");
 		stack_t stack = {
-			.ss_sp = altstack_data,
+			.ss_sp = malloc(sizeof(char) * SIGSTKSZ),
 			.ss_size = SIGSTKSZ,
 		};
 		if (sigaltstack(&stack, NULL) != 0)
 			err(1, "sigaltstack");
 		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
 		nr = SYS_getpid;
+		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; mov %[ss], %%ss; SYSENTER" : "+a" (nr)
 			      : [ss] "m" (ss) : "flags", "rcx"
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
index 120ac741fe44..9a30f443e928 100644
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
@@ -219,6 +218,7 @@ int main()
 			   SA_RESETHAND | SA_ONSTACK);
 		sethandler(SIGILL, print_and_longjmp, SA_RESETHAND);
 		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		free(stack.ss_sp);
 		/* Clear EBP first to make sure we segfault cleanly. */
 		asm volatile ("xorl %%ebp, %%ebp; SYSENTER" : "+a" (nr) :: "flags", "rcx"
 #ifdef __x86_64__
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

