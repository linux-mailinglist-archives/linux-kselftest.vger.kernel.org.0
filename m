Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ADD6F42B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBLZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEBLZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:25:34 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216475B86;
        Tue,  2 May 2023 04:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c32n8RWlgLBOctTwXSzDnWh0V8HcfETJlgMUoslQjiMcS+1fLBiE18z73dF4T3YPhIcXoeJkaN7YDlZgetxjCiupFb3jxwkF3fy1QllkH5FcBZujirq2wmvn55Z1MnVNA5+KE/6RxUSXnjM7sZDRnV9O7P2SnmmiFsGSCCZUDzajBuebNpxUyl912L6qgRkNvGapDEsA+h/gVfoI1Rhf13ilV+heBYplSPYQMK4TyZJ5fxcDGdXRZ3CV+K2dtEyopzco/0nyP88KoOEFeVKLMEgl1IIpyA3lDHZOFb7Nc4VfSiOOKVY4UreW48VsdJNj8bxA6+AQ0mVcwyAbneeM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6LeVy+ZuzuUY3j8ve9mKvLGhEC8Cn/MDZMbvsf0rDQ=;
 b=ciqe70q92mSCPv5GPxuO2S/81hNRpO4mh20+4/3u2rbiGakjA4/t/rh2EBScqT9WvkNQvnfS75xVejtglyz90EElAFl0nQlc/KKAIrPidPA81OsAEC36PJOxzotGz0Hy44Wc/vaPWpiMM9n8YhpQD0QpQOqNBFKXOL2Tjir0W0zWcal1ZqF6Xc5Xef1NsFeWlBEejNwK05hDezxcOUmCwbgbqwDG4pbF3SY29oMhVO/b3EnxbClZ+bljE8LHNyvBdB0UVOI5gPRYngpFXThnRxAfGXDePhZcmE1QSI2xUqak493U+dTrdK/ZeDJa7yGH5hkb12/tSpT0G3yAxg0aQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6LeVy+ZuzuUY3j8ve9mKvLGhEC8Cn/MDZMbvsf0rDQ=;
 b=JMfQtMApgxU93CHDJxrXet69/vZ9rme8v8pzTZLbCrgB+BCPGRH/0e108rOQaCpU0VTtCgAE4aQuotrMnbeDM1c5AHIn5M9jxt9dHwCtY0iOgkCGOd2AmnJ+tY1PDent8ZAhl0A/skMGa3YB65YicC5M4S4yu/3Y0uX2Pjm3am0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:24 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:24 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 9/9] test: ftrace: fix kprobe test for eventfs
Date:   Tue,  2 May 2023 16:53:20 +0530
Message-Id: <1683026600-13485-10-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683026600-13485-1-git-send-email-akaher@vmware.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|BYAPR05MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6746aa-54c0-49be-ce83-08db4affc895
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs3+N0liCpU2sEOzRHftbriHjm54AQuyTkdkfg3+quMu5JuJlMh4NvHim5fuHnwHTgY67MILUmI9QilD6KICq3WT+sy2ICQ89B39Nlm5QQP3hUnPwgk8T6VpYS1IX+CtXaiHjD+1NpaTt+rHDzpqNXtbFtFSS+/ZK8A3hhuIEsI5F6MCCw3MkFpfNZmXtfDc5g0ZOrYymrxl+VhCGegzCtZa35NRqzeQgH7tQPHxe6UUMABHMk1knQ24TUa8hFBZ3nYF3mZWdS5E4F7Rq6dxeWPzq4oZrovetGGS64j3myPsV6kSl2Y77VCpQ0nlpiMpC8ew0mBFzGS8664HBm3/N8QRtCym5/ed7rkQ/wproblUK+dYjCt/HKy2cYQYd2g+rHiCoedP9VH5WnM7Hukq6EvWj7kIrdRnT8JgOxXYme93FOQMLpFfkfGDdveSPYT10RFqDAYxFRHJZhiR2Qr55T70R/3omrrY+wTnNNk1L5bNZRwlqqycFrGO3ppgcT42oefjHEqb3S6j2/tyycjdoX/wfMMdfOKLMgS5UKZ+G8wRe/Gcfgbwfh/i2hNl7e5HApQVIIS1ZCrak5Xq9U8qQDzu6xMDgg28XbBvn61NoflhH0x5KIDjuy22rdCKTGrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zek7Zunu5LU0cuDL8o33LlUYlFD4pGQoqdQDDzl9gzcRXKP3f7fF62h2hebh?=
 =?us-ascii?Q?V6r3U+U5JwgODmx6X9nqpZr4JOs4xQLwt7rMXnGk/wZa8lkC2en4pN41FFOE?=
 =?us-ascii?Q?9QWNPVCbKGg4ySkTKev0hDhkeRG/+dcc9xedY/lQWA+djTtozRuCAUvzRqos?=
 =?us-ascii?Q?0O32l/BHZkt9gbL/FqpHUJqa8bBUoBePOMR0ui53h69B0CNzrUUFNeh2tn7R?=
 =?us-ascii?Q?6GoZCb4GF0ZNIXrp/V3OQq9VpT43qLCDHqn+W4AbtmpS6D2gf74lLIb6xQsy?=
 =?us-ascii?Q?4IgrlVqhHAKZnouYHVKd/kpnSYzdObV0dS9Pl0ChPogFRuNvR//TJ7pjsveB?=
 =?us-ascii?Q?R8QvngZ+akCbanltCp5mzVpLUpgNEhy3uGuw5wd6Sn5gdgbd9H1ccdp/9FOn?=
 =?us-ascii?Q?ilnW2V4n8IVfS2j7oBavISV5CL8gwNrr/bVnA6BXSo8BqDwvRBWUf8qcCWyf?=
 =?us-ascii?Q?h0hEEd0duNjtCAS2XqahA6jQ0Q8+f1KljLn/SUYyr2xmrkSysG+edWKD3XS7?=
 =?us-ascii?Q?bsjkzoPm+YLPIK1INyCBeeVD1WLEVCXUj6NGzCAYeEgW/VpLdiXvqPrCO79e?=
 =?us-ascii?Q?t0qC4xX1SHynBSm9rprUy/c4UmeFNBzissMjAHzgD1knRBFysf9+GmArTeAu?=
 =?us-ascii?Q?FB5+H3wZQU0+So4dSI5pmYWQuh9Z1R6R8bv9Fk1twoTJu4m8flAFSQoWjilY?=
 =?us-ascii?Q?oji1gTrOz43mHi5imZq5ScfMELz4UZ9EXFXGDp4slHxKuWw73x2FonV2iJyt?=
 =?us-ascii?Q?uwZtDY7L72eIBKnOSrkLArdfWxRTIFZtIid+6l36lfZyInOAo3KlbRbqoLdF?=
 =?us-ascii?Q?RxW/q5elyKlHN80NPU7vM9NFF6QSoYGxugjVvM0WPZuZ4syI0f4ggYHxPje/?=
 =?us-ascii?Q?CzYZuOppPeVq1XDb3BYhYlTR8Nqrvx3HwOAjTuK5YyI51lkcVPsDk/WtcDJD?=
 =?us-ascii?Q?u0KV3YpCbzn6keNvjJSBjuvM/qmfmczPMjN5gVYH43iNEgR1/o8ADAlNBfo3?=
 =?us-ascii?Q?tg35sHolcOeIdvKFY+wSVec9hrDlihpxs8mNgDLrFykOVCW682ocndVTqcem?=
 =?us-ascii?Q?UrYduZRWCplu2ttGl46BDzOiQ4Cm6haukXngqn6NREVTiFsvh8JFDqGODCu+?=
 =?us-ascii?Q?NwOKq0N5tCC4dsVVA4YwuqpQxEi3/BoC2Mr6Ih00ULxR7gZNVJo52LhhaYXe?=
 =?us-ascii?Q?+LdoRLw6of3/UPJi6429R31Z8VESXKGbK/o7w3TcV7mbh/ReLo8p3w4Vf+B9?=
 =?us-ascii?Q?JuzMDpITra5v9JyRPI7jOF9IQI5ikSBH90eC1RgrfHITJY6r3kWyOrAG2A4I?=
 =?us-ascii?Q?xVLmALPsx73BO7AZ8+HuFBA5/BH8Y/1Xe/U+7LGN7/oGuGHBUn0/HWplQNFM?=
 =?us-ascii?Q?PDpPrfVFhi8us3BXxduP3YdQx3NxTI4L3poXpcw5SqZgCAaN4R6/R4HdIJwG?=
 =?us-ascii?Q?4NQpXavdwMd+4eZwyoF8B9DO2Fzhk2qiLghEangxIGmu8wdybvROix+oYe0P?=
 =?us-ascii?Q?YJrKxEe3I3pop6ivoSq8Eg6s/8w5f3LpPFewhAcYnLZhee59ZOIfnGFPs2Os?=
 =?us-ascii?Q?4s/WZnLOfYG9YOVLxBUX+6NRwBoT9fyE61jt5r2u?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6746aa-54c0-49be-ce83-08db4affc895
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:24.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggrkawaY3Kn3bYMabsXP4Up592d5MzrPNpyRTebkUbhu64W9dP8MEn4bFAZDxGwcriIEoDlgv3CdyZfJbRKzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6648
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 285b4770e..523cfb645 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -34,14 +34,14 @@ mips*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t'" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a4f8e7c53..b9f8c3f8b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -37,14 +37,14 @@ loongarch*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
+echo "p:testprobe eventfs_add_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
 echo "p:test $FUNCTION_FORK" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
-- 
2.39.0

