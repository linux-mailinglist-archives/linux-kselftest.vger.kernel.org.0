Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DD719632
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFAJBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAJBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:11 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33846B3;
        Thu,  1 Jun 2023 02:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhvKQKcUWqv5o0Jy7Cm8AFn5ECxGdJys13f9DfsryCFGAkzA8q1qxq5J5PCAj4DrPWhQEHjkL2aQPsNJETRWDDPZBJIbEF/t5LnQ7eYHeSFuVGNXsI+XNjpdwRUlP4vEYSANBy0OmW+epbn3TnZQSjdogQYhlGTulsAbmnlv5Pc4bQ4/qSyzMa5dqlYlFtctAzb/LFqY26AiHTAkXY0Q40jHrWBP6YnuB0OiJ5tFk0yONZPZb56m6BvjjxUsv19wAqXRpU8XJzWZjfOQ7BrJ1uVd6RIlmnVcsuIe13eNRSsHJhtstoAu6vOvd0EyD3adjxBM12QAmOEp1NTKvu/6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odhXvJEkAt78N5rSyxi7b4WKu//jCy/HfoNyhQ1kxcE=;
 b=d5XHbFIHeZjQKdPKcgx9YwCTggufuLueubj5dKmFw/GuSZf/3SRce2u2AzDxvRoZfAaHhh8rRq+AJ9F9jtfxeRWoKcamAU0bbDGayrz27DrTsgcvAxWFWfimrpHPyc7GFViJTuTU6saiR91XInXLQrd3do8n8oqnJPvxHOPwc8mLN/ylewBgEblxW3MiktNEBG7OMv4SfOBKt3JdQUicDwZ+87iJiuoEUNvYAdWxN+p5dH8jHmmwa2Oh3u5TFPB5usTX0cD1uBHJG8B9dZ+5H6C9Cwun1uWb0j5d7x8A6kTTihBUjegn3xCvJx579X5HuvPDzmLIkjviVXHsVq5p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odhXvJEkAt78N5rSyxi7b4WKu//jCy/HfoNyhQ1kxcE=;
 b=tmNNKVZvg0v0M+4y5MYoZvsau7fNyTPPx5yJR2VB8xnV3vZo7qd4oNh5bSQtG1JJPw/94pXwRhVskyDJgjbBHSSyf3TuzOz/Rs7IAwJngucW1kFn4Bywe9cwXw7kuz3MsqrlKHpjkrgsfp7icWbCKjbwfZNWyVq43J04dRXhG44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:05 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:05 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 01/10] tracing: Require all trace events to have a TRACE_SYSTEM
Date:   Thu,  1 Jun 2023 14:30:04 +0530
Message-Id: <1685610013-33478-2-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a50397-3b12-4630-27ea-08db627ebb7e
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVxtnxS/cQHF1zTyqa9Xg4WzyaD5eIpkKIHlpjIjeLeCSUBVqTgIKmvm8SpYzmzXKnIHeAacx0Unp1fYPjEJVHVA9bKa4waLM4wcjZgZugu3T4z+O0n85s/oNT7lfCU5OuxKq7mYOLe02W6wfNLsG/Ro72/sOr6c63yEf5Attdk9FGyLlJhfaWBCUpDPOAmd9pMyMOH2RPbjLckaMe9oXuyRr+CZ+uVhW3DIQqNM1yURFKjbl16qtrnf13R8alh4lWgBv6In9S7QvIc2VuhdeYd8kWOIwGxcfXm5I4m4Jw4SkrGdxx99rziln6gbXKwyR4Ga7ge9WvuZ+eWSm8mQNeY0bbHxFWfBfJyb/GzRTXFkJtQ8mrLHvY5I71N5KEIl0JpX56EV0NFm8ZnFEUcNx86AC39vxEGG5Fja4MDnTD916jranwUwf88gRLvQ8VnUGUH/0FwSgwkMHp9vdrneZ8ZW9IyRHK0UIlB+g44XQfBXhtoM2C/UUN3/TnTKOCpfvX6ELxkSX7bLF9SuGPu8Z/Ut+xPpmlA856jSptwM7WsBxzJAQAvAGpCBRiUgqDMNV3VGfOI/QhJwkAU7bPmgXE6Hrod4+1T8fvCKusUJsPDJiD8HWQiWiYWScdVdIvFp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TKXRfn/QKf2VpDWQQ20CGNBy0thXzD4aqOxamPPmVrNZ5ksiyde+IFNRukBk?=
 =?us-ascii?Q?8JpV3tCezstetkzEMG5wQZIxQt4rbeyQOGNwfe2kxah+VH7X/7i7s0yet5U/?=
 =?us-ascii?Q?of2TBcd0fUu4DzntQhT/kye7hAfsgdKg79p9Re45mMswiZQ+ORzDZKFedeW/?=
 =?us-ascii?Q?4KoLH4LKbgQ/9GIUb9lo3qPxP0aasoSeN3OmVc7F+i5F8sfVUj4zHv4LtUeT?=
 =?us-ascii?Q?+6PNTEvRjDbywUL+w0zLYoBN5h+yEr9g6qt6muudLXQz4s7JM7+rAkcvRiVw?=
 =?us-ascii?Q?Ebm9HONWO5TqhZ5EbNR9/cLRgKVmipvK5iLGB9ZDQdBeJImiVqA5fF4sj2fr?=
 =?us-ascii?Q?RmB/lvS/OyEThR3xGPsXNdTjm4nfPkvNxx1Y4HToGkU35abFhWkFhfj3d4E7?=
 =?us-ascii?Q?agomMg9RkFKKf6YYJKNONAF+spk1uDWSUfip26gEuK4yXaoHMsoloZ/KjwDh?=
 =?us-ascii?Q?EiKjJiuWpSsPrBsTcJTI1XGDIHN/NxwWvu/jCrm62D6iPPVCMyLWCoh3UQ5z?=
 =?us-ascii?Q?6S+YJKQwXqgrWgi1WO0LDM4Lbxs4QEOhDhbnIQ3D9DSgAnohTzjjVSljvTJx?=
 =?us-ascii?Q?romo1oBQVKFiSmHissvMp19/Y9ateWyH3ZoW4sBYk0B6vsdzth6KSr/nV3mr?=
 =?us-ascii?Q?FasK22ID/HM8Q1+nvyKaFTzNlIpjG71eFQd7gg6GH064/AFLLSbzPa1gd5O0?=
 =?us-ascii?Q?qcYquIP/ryuzbmwEeT7uxf2lNTPx7xIVAJPCJRWblzhvPxiYAnhpmJJ8+n01?=
 =?us-ascii?Q?5s33tEI/EbaOqJDJ//qYrsa0nRnfh5qAa5cg5xsm/Xi2g37UppXUKOS36+Z0?=
 =?us-ascii?Q?lDIRE7mAZVH5pTSnjwPQ1+KKqjSnrEIVVGC4pJp5+oubwIygSRnD9MIy4hcH?=
 =?us-ascii?Q?GJ3pclsw4T1ammhIqpnrn5RZDsKwmev4BjPrp3IuCJYUP289W/0t/a6mSy7S?=
 =?us-ascii?Q?gdOVTANotFcNHgqsem0ZqA4A/4ftqQWVTrHRUFK+6lXthBL29NH7b9klj4+y?=
 =?us-ascii?Q?VzIDtYMD0d7hJjhT287EnifWAWH0YO757iwhH5tF99jbO5QI+u4WqFEGK5nI?=
 =?us-ascii?Q?tjvXCZ9kkUDMjykkjCL2+23xHqi7mMhgeyWTnZYD/FTz9QlxhK+DYbB/IK6f?=
 =?us-ascii?Q?kmKu8IpHPOvhTs0jop1wK9h+yr+8lONZrc5yv6Ff2Au028Z/E58cJ2Jr2Qiv?=
 =?us-ascii?Q?i/zMu/fT+pgbu2pD5CQWSdcoDiemdcEjfMeoFLin1C0pZ2HmcaE1FXltDUIw?=
 =?us-ascii?Q?Wwj/Tdj121O2LiJ1RAfUmcyqTUgeN230iElYL+6+n5DbAFzJzNGDPreLWDsJ?=
 =?us-ascii?Q?W/twSqku3xyydKc0DVwDHIvzDjifxhWFpPNtEaoAhhipCfmThfWZXkhsTIfe?=
 =?us-ascii?Q?XVprjAOPrDRLDkzNLK2B0htYqWrz7WPvmObdbKGIa+v58vDf3tfaeET79+W+?=
 =?us-ascii?Q?Xg7TgTEr347JPvLQYGYp/OpEmw4awhreUc877n6KvO2hKK0H2BH51w5TPF0B?=
 =?us-ascii?Q?FLPuzvWp0gku4MtDx+KrtrZxGoZQBypaNeVS6w0viU135GIP/QESPflwtOBw?=
 =?us-ascii?Q?rYs2uOyX+DfrWiGrPYr0QzkSknB5iV0/J/5zo/8a?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a50397-3b12-4630-27ea-08db627ebb7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:05.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yXTtUdSNZcUD/pW93GEcHJkpgotJF0bMpr1ZU4pCjbKZr2rbW//LyVmSOiVB88H4R47prD8nvi0qPRYzdHxxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The creation of the trace event directory requires that a TRACE_SYSTEM is
defined that the trace event directory is added within the system it was
defined in.

The code handled the case where a TRACE_SYSTEM was not added, and would
then add the event at the events directory. But nothing should be doing
this. This code also prevents the implementation of creating dynamic
dentrys for the eventfs system.

As this path has never been hit on correct code, remove it. If it does get
hit, issues a WARN_ON_ONCE() and return ENODEV.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 kernel/trace/trace_events.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 654ffa404..16bc5ba45 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2424,14 +2424,15 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 
 	/*
 	 * If the trace point header did not define TRACE_SYSTEM
-	 * then the system would be called "TRACE_SYSTEM".
+	 * then the system would be called "TRACE_SYSTEM". This should
+	 * never happen.
 	 */
-	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
-		d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-		if (!d_events)
-			return -ENOMEM;
-	} else
-		d_events = parent;
+	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
+		return -ENODEV;
+
+	d_events = event_subsystem_dir(tr, call->class->system, file, parent);
+	if (!d_events)
+		return -ENOMEM;
 
 	name = trace_event_name(call);
 	file->dir = tracefs_create_dir(name, d_events);
-- 
2.40.0

