Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44598752005
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjGMLed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGMLeM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:12 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013000.outbound.protection.outlook.com [52.101.54.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1E2705;
        Thu, 13 Jul 2023 04:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo9sfYO3oFr8OPAkPxMu7AxP4p0y3MCXZnbUByuHV+WSZ8VQuN8jSgxfCG7+otK78tv9YdMXY4OGLObUzkFm55RBhxSroSAJDwCWGS7jQ9DI2V4kdRM0nCwxgiv8xjP5g4qIi1pE8jrE2Pf4PacFfSNGvs4WCDfjgRZZvvYfM80EvQrAYbWQQlmZZKWuGGZV8JhU1TWPbmOYM2iq+8SM+v1lopmfnP0Nw0I1cTrhve24vdH90Al7/W+Cgge2xR72IPR5Pg2aACi1I5VZuJt0xDsql/KI81xGCeoaR9CiB4jxgu+AMbw0oU4kK0VCuVvmGNdhxPOffQuE2FZ2dwO7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR9LXRcDw1z+h0pPmQffRxqFI1NP1S8UEGCiEhbnhi8=;
 b=JODHZLOq/A38wud7zt/qesH9kDK1awf5eXoWO0v2+Xv/OuCZCeHR6oWE0OzeMhnbSl3coeOkZsYu/MWQ4aWiplMPCDMsRUHJHAGhoSxc8FKJn9ZMkmNXH3VZxrfexCY8WzfZLNtYdp69p8llGUP2iE5xjUZTfcb/XXL99WbqE7ov6QTWv45qzm2K02Kno54+CtmKw/0upeognQC/Cqy6vE04pHSmvT/CL8ADl4y5Gp6ALgcWWXBGwtZos5nKTSBmlrEL8DC5LU9haBkosXRmdSUKwa0thAWqUZ/zBB9+uadYhsS4aW0lLX6+aSxs1hXa9vXEa4IEAaJ3Il717md4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR9LXRcDw1z+h0pPmQffRxqFI1NP1S8UEGCiEhbnhi8=;
 b=ARTWjz8WkB4eSk7s16yhGzqPIiOiPka5fah0NMOoSSzWjkwox/KwWhud4d3GBiElhHyTz6xM4TYzzYbKqUxk8oyP9GnHs1x0ht1SOItLajdGXRff1PqrnEwZBFqB3yjDRZj6KNzmI6V73VYODqqs11FuMN17ir4sQ+l8mwYQ9a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SA0PR05MB7452.namprd05.prod.outlook.com (2603:10b6:806:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:06 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:06 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 10/10] test: ftrace: Fix kprobe test for eventfs
Date:   Thu, 13 Jul 2023 17:03:24 +0530
Message-Id: <1689248004-8158-11-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SA0PR05MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: b04d2070-25f1-4f31-3ec2-08db8395114a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0765TfaeCQQ508t2XZGzleT/HlC3YWGu1/1hG0pxQL6jeP04xoCfYtNU6YJcB+5TSTj+2MeE+lzLlpK6SCSg5f9WSbO9esra3O4iLd3RQYTpQQC1M0NnrFb6072QW9D5KiMfS/71Vmxivadw6TmMCcaUzrOlru1RiqeN2PVb9wQoT7v2N6a916zD57dJh/iEsEAzlnG5Lon1PtPUs9kYoKcBPyszMAWpf0vyFqSjTkRzozT63ctcaS0fL1pIuVnQlZLtsWguV6V6Bg2ug7D+5ErysvutRfSTRYIfrpFBkaA3+fVr7KYMZrtStjvmj+kCPW6xmAS3BcymEPPWV02EJY/FEWTBkHNWJ+wekIetKho+FEYsSEeyqUvWWFGg0HvHbODGd+Nosv1c0D/E5F+aJLHXEH3jzh6CU5jfIG0Mfy3ZGFS7SCe70gjfcuSXn8C0N8O56LyYOzm3HPPVZYdtB8k10ueJKmJwlJo/YYDH9BQbwdk0/bYzWqUTnJgu2YUU73uC7Zu16TomTI39ghLPBV0lzqrPrI5TFXTX1SJDnEDrjFBLzn31nzYE8xicrujh+5NSAOG538ZgrTYdQ76M0y2aq/gsxwJOSDByUk2Od7920AEZBRpx01ZBidKBu2/QLXKecig7SzPlIdp9qm80+QSz/oR3X0Bk5wLlsF7s2wU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(6666004)(52116002)(478600001)(8676002)(5660300002)(2906002)(36756003)(7416002)(8936002)(86362001)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(38350700002)(41300700001)(6506007)(107886003)(26005)(83380400001)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLrAgYRs4dmF7hXcbbwlOzcgidYFdnxdmAWfc0QK6UyUdTJ4ynkAEgbg4B3a?=
 =?us-ascii?Q?QshJVNSQPxOEPoOmDcmVs4UZ3NhFqd9Chg/jXlDXj+cErgErUxtsKIQmv62s?=
 =?us-ascii?Q?VR/nE6NopBiTRi06qWfUBoDjycqWbO7b2LueRIVIzlUm+E3YwOlFJbO9HwLS?=
 =?us-ascii?Q?/KTtgyu8P0h0W/KWFzqdE9iZmfNb2Ffax5/uwVeiXwhOrtBimU8Sv29Rame2?=
 =?us-ascii?Q?lsvGXd3OEfx1bxCNJ+A9CbWaYfzyCzh47QBpm9lVZ+JFY6W3oSs1G983XiqY?=
 =?us-ascii?Q?PcelfJRUHKsvVIW/mVVbCLKic9xuVuAjfuIMroUaIaguBKXAXA/OOXd6nMP+?=
 =?us-ascii?Q?0T9IVFS9+CWLf1p75dJzJAcgnHSXp6913YLLNxGuBiW/DpAuXrskK9R63SXw?=
 =?us-ascii?Q?qOyIhQpTc9toocr8iL/PsgVsAAqN2Oip/4C97okZ6R8407m19PW+1WSaJjaw?=
 =?us-ascii?Q?mACscmEhSM583LOSLLDEqDsitzoPtqnDBAS8ZTACfKhrANUFREhq/G3tQcxd?=
 =?us-ascii?Q?UlVhPWJZLEIfdAyS3Zcao7HjsNQ9reH9RmFR2s+VN8VxnLPI1+h8RyulKaWf?=
 =?us-ascii?Q?mzGIIj8UFYwDUdxvdt6O0GhTQYhMLFpdiwC20nDianbm1vO1YmmCkJdshLNx?=
 =?us-ascii?Q?VgTFwyUnGKnldZ2t1q0MHpGE3drzvUUulBXOYE/x67XcBR4nq0RexcJ/NGNQ?=
 =?us-ascii?Q?ckWdCTxwOCTIdAoxLjPzudKx6QVfnDwlnNM8DM1W2j2uB4j7KS94Z8heL22l?=
 =?us-ascii?Q?zmrFm3G17BJ73OeffumtqHYfOyfwUpcC7N5rX9ah5m/lfb34CaauXjBkynPz?=
 =?us-ascii?Q?MDAfupYTb62weHQnM4iaXCMoMN/w+nmPhF71+L7AzAvN9gDuLkFA3X7g8Bcw?=
 =?us-ascii?Q?f/1bk7K3vJfqTzh8kxyYK/ZSWHyVOrR2+vvNCAFG50v3kYc71/pT4yIc2JiI?=
 =?us-ascii?Q?oHbizZQku9pOIYzUtXJ6EgbiQOjPswXzpuHUV09hj9qCvZ3C+OKgtjtdpSJO?=
 =?us-ascii?Q?UWh2iHJRZ3L6wVOIxFXq7Tx6uvY20cK8/z/cnSsCT5Ro7mUmtVL496Vpx9kd?=
 =?us-ascii?Q?/Pe41VGZttvvJu7biDnLpo1zgUjiQ/3PeY0L47VHkSeRiJw/7uBk85k1t8Be?=
 =?us-ascii?Q?w8jDhImysVXLEFSzycScePrd4+yFyPykCdqeeOO02U8YPlB3l+3CjIyTr6AH?=
 =?us-ascii?Q?kHJ8KLzNvp59qK7ObBqwf8ezr7MVLVR29r+hD5ckgIxPU4NhH32L8w0wXh3Y?=
 =?us-ascii?Q?0UwAONrdBYj1FscGwo+eWq+bXJC7hKZttYjMKOSVu/QvtEYw4IVD8EnHkxJZ?=
 =?us-ascii?Q?NOuyxabrWpEsf1GkubKG8l/D+aoSDisSkp7fvD2egREBSG5Oh2uvoThGR+zj?=
 =?us-ascii?Q?lLInVSrNy2tqUt+hsTGOJlnhUzm4KgUDYH3T6cAyPWvsDgOn7EvdBHGCQPIS?=
 =?us-ascii?Q?hlqSucizJndkhn9JW+jUpivyiWwxl/zziyAlzRn4zA8ZAruO0XfFO/DYNm/I?=
 =?us-ascii?Q?uujp3eDZ9HeKtThcrex7k1JxcN0RH+tueXlb3+rLKQm2s3VqV6ZmuyNIXgvV?=
 =?us-ascii?Q?CYacDIT9yvziZWF56yQBIZ1uvbd4geYxMHyq+8UR?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04d2070-25f1-4f31-3ec2-08db8395114a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:06.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQZS3gxpg27KfnXTq3ymRINYc5hRXqvv1nAZyYAUEdXY4MIIUDh8u1nNVM3BbyIczetmGJAH4fPfAYagUvx/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 285b4770efad..523cfb64539f 100644
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
index a4f8e7c53c1f..b9f8c3f8bae8 100644
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

