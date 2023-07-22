Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFC75DE59
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGVTjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGVTiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:55 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5E2D4A;
        Sat, 22 Jul 2023 12:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkk40yO5q5S3nM65is2CLVR+lfFlLGGIKNHccwd6CJc+xg/nnpapMXN2ZS1F1VE6RQb0FDwktWuMjduDM34xdg9ZEcg+YOkftu7D8VtlJq3zbDI8i3kl56//mix5KFlDrbFZYKQdvkfgjV8j+q9FLzO7jVBO4WtrN1zNtmy+eR1Z3Y29lTjX8PRwjCiWAKyGhRkO2zZvULY7IAiVMvZii55cJhNW0qZ4jJcEAIJoBd0aL8Kbm9S0fNn6s6g1FEwVqo48aUCxZX+CWdbVMEJpSm3IeCpf16ykO7Xd++toGGUI8BwLY5O94P6h1XeYh9b+uuuF7jNWR5YlSUE1cDdqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD4e/LRWicfReGBTq2PmuuNab6VTlR+NonQSH7Pjua4=;
 b=Gu6tBcrLe1mXIsnZ09rppoHbJ0C/dNsmIChXZ8c7NwVPgPGgwIYAmWRc1AJszz7S7gHHuEv1N+7h6BamQ57Ty16HfX8n5CYr72XYFef50EALzbwWz4iOQsiidfBRwjTZp5LyJTtg2ai8ECXAgAoUfxsHNRp39mA9mRkC8nEDIdAEFJ+cqMamopFqc/Evx1juE8o4dWLt4LY2VrIbG/iJnYh4/Dj8BfnEHd+lRMHtIgHqtkGXJNquJ4aQOlX/DgiZke7iAztnfPDjsGDlOPFZOemxFi+eDMMQEu3oKnW/oEa4K9WkZTZdiL0EYNovrR0BxzxP1grlA04RSg0CJ8Rw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD4e/LRWicfReGBTq2PmuuNab6VTlR+NonQSH7Pjua4=;
 b=ZkC3TuTpvsYrF8TpZbi0wG0PhkwI29/+ExRImZ3mJJLiBPczzzWHd8kbhFGO1j0eJoCHkLp9lLhrAIgANe14OOsRp3HwRYTv7LI4VPUlkUnUX1GzgQ4LAYas9htoceCTEZ2osEfUXYlZYRbupDgo5XK+DwPX+R0rPLfK5bpvoWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:17 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:17 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 10/10] test: ftrace: Fix kprobe test for eventfs
Date:   Sun, 23 Jul 2023 01:07:05 +0530
Message-Id: <1690054625-31939-11-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690054625-31939-1-git-send-email-akaher@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MN0PR05MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b7927e-359c-4fa4-9070-08db8aeb3282
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+pcTmXboTrXxUTIBXFmzSAERLH1DmkMfTsBKp1uGmbVzJxU5XQCwaaKwEAqyfuZkSBYi+zxUqnst5vFnlYEfBkcYh7SAES637MSCYwn82Eowmsl2jKQQixvrnSAzanzFG3vwWS3IEt+qJ+EdNGHRg6GoRytNN5jkmVINViU/hNP9wqRUO7zUy12v3aIQ6DetSE1eun4aiSQAIKS5XzipMYoqx+eAMWQpvLZ5b7p/g52XKmQmrpHFRkHrDlp9EyDuyyTbb+qlR8MsSI1avE6+svqXrxf59XPDoKimPoNPpTJ7hpOW+Bi6hNIRV7bHU6q95E6q+jbPpGtQArl6/0xzelWB0KctEb3oOaYb/D5cWkrwul+lSH77jWFttdnHG7DhXxROHBgHDPKtJTt4r31tPonQOFG5LTmcZt6Ws0NgOfO20atqkiGmDRpWch4PiaIdNUn4IYgecD2x/qGaNmW3dfduIdDfGpoLbplYhXVF4A06lrgSdj9vY1Iu3t9u80dvOH1EVeQ+oDfaPPQcciGvYzggUIVDbbMKFJuWaDs5Ab8zkdRP88CXp7L+/lV+xSofdzXhhXs+whGQFilvIdLQkZhQ0u4tzwAGGFhNdtbvMSB8UnnZfoiTAPC2Y4edowmIfjeKHUCkgQafBidk6P7hGylg+n3tIDuZTckG9+PbJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vy5pRGFpvl4RbOvTl2358UoycPBffvB7V5kZfeugwKknteqJS4crsrP8Fwk?=
 =?us-ascii?Q?F9OyhLeNkOXGLbMDsFDqeeockYrf3jeSlWaGB9zw4/C9Gf5VVT+98XR9RrKR?=
 =?us-ascii?Q?osRt2KHW7lai4kX5lWenAxlmY8DbIR2ZPxxvfWIifwBkHb9DqCuIz3AUUwT6?=
 =?us-ascii?Q?1CJrDU0l5WRBXzoot8BO0/1L5ad3LfXvygyTRlAxIKywHhUBvlLj/Fzd2gBJ?=
 =?us-ascii?Q?rb9S+ZGsbPRb+JRlZmFDV2OpZo4ovSaXQonSd9HaY5sAbaYDjbi8T4YWtTfY?=
 =?us-ascii?Q?JA2FGiVuacc6AxT3G8LV+Y69C4SrUQx8eUdpRMHeRQnTDgbQ9AddItblsfIr?=
 =?us-ascii?Q?brQ1XfC2d7A2Gqi6HEp+dyfKoR2Qr0HvIR+P7B2eBpKtI9hhmVsHTYviR/+Z?=
 =?us-ascii?Q?7aRGG5WqC0LJNtagptWKd6WOtWGJTyKqFqB3GU1bW/d3FQ/jyGmnf6tdSZ7c?=
 =?us-ascii?Q?vyB7nWJ1oHrpNjD35EN3OrypcDiH3fVK59wiwShVY+mLbiAxPKWhONHl7kIT?=
 =?us-ascii?Q?ic2uJuhOYfDexbGYMfks6l979pzObv6D0oal1ne7RPdPX3DWLhy8Vaw2UI0b?=
 =?us-ascii?Q?IZ/ZnoyvhyH2O1dsMkGSjMqvyMw4hxdwMeqCjUq8cVb0yhphFEczTl1op6Sj?=
 =?us-ascii?Q?cI0eGVA+1Sl0ekbVnm20oic6j6stR3llT6Vzd3Sp9PHWB9L/DzU4O/e8LFEY?=
 =?us-ascii?Q?eesrl5BhWZ4JMt76/PwayUE1E51E8fRQyEiYNZk2LcxHMhyR25smafZSSoTi?=
 =?us-ascii?Q?oMWX5qdhzMXm1joah8Y+SPHQE58dTiw7UOgIfl6cm4QMA+cJNzHYydvKBlez?=
 =?us-ascii?Q?uxmgzwqXN+wT74uRgVursrXl9L4t16+S6P87zpFhUpBGL+91oJInDqDLeeIs?=
 =?us-ascii?Q?o063yJ/xMoWS7CdNWHBqdZ2aEJSx/EmQWH1QYAtmhyI+m9rmYQQiXkwT69el?=
 =?us-ascii?Q?ZpSjf9aKJPr71PTV8ssqHSb/iVcdeQU2dbxIv92zP/sHaulz40XpkeWaZtAm?=
 =?us-ascii?Q?EggXa4DBlEhJWSmG4fw+A7NhdxVItmZ1n2IOsXxL3DiV+b0f9rhU5mC5n0Eu?=
 =?us-ascii?Q?BYHyALpIRWwrQthRXjYiDIMLbMVXDIr3sE72QZMpS6RmktVCzf5fgRLmyW3R?=
 =?us-ascii?Q?M3sH6DQJj9ipul6OKUOjKb8ImeLXKxKnUQrItk5dTBtyRgOuVJIBB3DlaHnR?=
 =?us-ascii?Q?MEh0nc/99L7aNWQr5tzCwlVV4OYvtABSNh74wKPm/T8Wz2f9VEao3FCQ4UA9?=
 =?us-ascii?Q?CNfGNJS38CDQhNkBv8uoRmQ7gXQ4dnvchXNiS6JZNjiSS8EUidOk6tsBQdA7?=
 =?us-ascii?Q?9WeRKRnfjp9JQNnpBFQb+Ee13g6WjJ7ilG/5vB2HJTWm27f/9WvZ8IfQVjhn?=
 =?us-ascii?Q?ZeVBgmHYLnOmhe6yElydBW+hotQ2JIIMHwPpfA3w0zFHGVDppsmK5w8BT3l2?=
 =?us-ascii?Q?CiG9DZ5XDF03z+lJDvhrXDQ7bDpI1RW1SD9gqnzd72Oi4i5158o6tT+IPMiw?=
 =?us-ascii?Q?yokzapSNB7+YhMzZjVe5YLiUOVLym5G1w+2y8PxQi0gYsTSXluPrRxX3cMKk?=
 =?us-ascii?Q?KD6PoPhVd78xCiSyjlDfb8E7pDJNH08H/GbrO/+Q?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b7927e-359c-4fa4-9070-08db8aeb3282
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:17.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvoJlwS9Kb6ZfU3yaNpdtkVqi4g0gpZ5UF0ZtVxA4FAK8bU80YeGMLlyovX1/AaBpKxxoS/wmuxBeu+mWo2OCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR05MB9005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kprobe_args_char.tc, kprobe_args_string.tc has validation check
for tracefs_create_dir, for eventfs it should be eventfs_create_dir.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc   | 9 +++++++--
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 285b4770efad..ff7499eb98d6 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -34,14 +34,19 @@ mips*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
+if grep -q eventfs_add_dir available_filter_functions; then
+  DIR_NAME="eventfs_add_dir"
+else
+  DIR_NAME="tracefs_create_dir"
+fi
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t'" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a4f8e7c53c1f..a202b2ea4baf 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -37,14 +37,19 @@ loongarch*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
+if grep -q eventfs_add_dir available_filter_functions; then
+  DIR_NAME="eventfs_add_dir"
+else
+  DIR_NAME="tracefs_create_dir"
+fi
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe ${DIR_NAME} arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
-- 
2.39.0

