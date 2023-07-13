Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B04751FF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjGMLeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGMLeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:04 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B026E5C;
        Thu, 13 Jul 2023 04:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elu7YONTaAdsMDEBKL24+Z39qkP7jrtb67p6n6tatKMRXu8pFYMFpYOeF7mc23/NWiezCQjGFMmpYDdmnLWDooYvXQv0wxs+FwUmfnqWPyKyjcCT0gkTy+KVlB8a4J1Nln0GyZm+QPeLBBm1OTO9tVxo5JIHWpedQi2N7a82rdPNWyBMh1FQk83Ors++jRrmZyjw9j+kHUnzM6U2ReNArVKmIeDhlYwGAKAm/SoT3zXbkcsL6A/TLIEUFBEFHR++F3TcpG83eHOOcTjN4KEv3S0XqrnX9xHQYcX1QFoasE2oUtGUDyehyFxSUzzyg+Fn6oatiaB6CiR/vQ49ZB0cUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBiXm/KOAhcLgQp+cTdX+C38d/hUEhFUlc5b6OS7zHo=;
 b=Aqm75f6dJoHu/pX7UXIuqqFvgtbbaAlF0wSHMrhWhJ89Y6SPTouGocxxqZIBCLfPc0sZGWQzj+CFeJgT2kr2Zh8MAOduIvq8G3f6iRVV8xLLiYWQDXeMKdwSixAWDiVJ/MgZHm7+1k4ttyYPwGnINwVtbYjSZtZ+7YF9J2NXVJblo++jUF6HGPToyniR7wxmXFT0yH85JA7rKMikobxIAs8NXsQhCwM3R6wii1H6Fln/8pCnaK0gFnb9wmoA1j4xb7lP/wUT4I3djnPuVpCbtoNcYXBRT2Gyt0Xn5jm5c2HWLiBxBeWrkoKOH83Mv0MrkaN5FUxCxUb4t7udfuw7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBiXm/KOAhcLgQp+cTdX+C38d/hUEhFUlc5b6OS7zHo=;
 b=on6zZz4rA3KjK1lPbEOwpxboQSHHFxvPGThRXbvWnfkuq/6HnRQo6nXNdQY+ZbjmCVkAM7VKbyNDGQgCKnWmFU8jITb11fqW9V+OVRDc8+YYpsQkEKreEyvFwG0VFsbUzf10p/pkPIqVfeWuoC0nc9WmvUp6/4O3dLDG5XBVHnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:33:59 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:33:57 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 01/10] tracing: Require all trace events to have a TRACE_SYSTEM
Date:   Thu, 13 Jul 2023 17:03:15 +0530
Message-Id: <1689248004-8158-2-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9e4ba4-9e69-4942-2750-08db83950b7d
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCZwQfnSCJXEbq02M4H7s5Jjr0+oo7Wmk47hYjxBfrn5uNOiMgQam66CNrtbAVugiRHfj/0tIYm1zDHaZ1SoHcBa/pd5fr2PTZRVZLGrMGTnTL4Fh6DW4Urazeqvwp76P6NSSVw03CqCk0UBQGHe+WQ1hUhQn3rMk8z7CYhWxq9MhLkPPASYgaLexV7TEdQ3cwC9fQgephixUKcHVdIjBC7O/cKNFtNWU7LOxgqHL9tN7q9sXYZsLr2v7JPxxJvmDC5bX90kIqT/RwS9pM4e8EJRVmVdFa8VGZFi3qZPDEM1IdHZ4cum+EJpCzWrq2buNJxj3PxTOvIzEnsHjelTuokd01UF0uG7VlEhkrRE85DnWz81YvgZGP8/mptNsf10gZfiwVhJh2jICTsMKvtKFKv66JFZrwlpFOfmQN8k85IsvfFZE3zRVB2lpnZGiCNrPrUcGjD/1R0sRMS4+Ke6/RQI6GYrpAElKB/g/nvT651ubSosG31hhaKN0kV/98ciatzfW4kBt5NAHe7mGReJmAIq7irZ1PjlmFmMvOlrgNauAdeWDA4h415kfjHPxi1l6isLMfUzgFIxDbAhcG9+DmAe2KSElNp2YIYLxKHiQscl+5Kf54angCWan82QfO42houBU+7jAdMcEu8pEcPiCpOymGSK/0nUEDXqTuSdalc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhymFcnxW++7+3/AQLnOlGq0dtDdW2jBB/i8E+Y0DWzTprSZnK3Ec7kaIuS4?=
 =?us-ascii?Q?FuCCsLzHaPCxruQGQQP7G0NKNV76EFHD0j+BTLwCXIhjwBCbIkNG21ity0Ps?=
 =?us-ascii?Q?qB+icF15stuEZdI0fc/sFLeDpgz6QzSwfA0yFD1YZkbeGN6YDF8Lf6JMVFZl?=
 =?us-ascii?Q?VOqhBEeEQrW133TrQdRR/mzs0IyySsCmzb4Hje7Bs9RPvztfXXik3iO1JlO+?=
 =?us-ascii?Q?INIzTNQ1ZJystMXCR1u/fyA1JYP9bLZoAi7BTrBFekPYoBsZ54lIW46yrOpm?=
 =?us-ascii?Q?9pw2hYRORl7juruonm08apNn5T5aEiboUyZLmcUCz74jf9QyM5qaIAkKKbCS?=
 =?us-ascii?Q?pltGqVW8t0p1HoCgCmTIeHfikqlSJHrdTWSzv06pGD0zelo+5lTKo4SJiLDh?=
 =?us-ascii?Q?9g2/V3tegfOBeW3Qnde/vBJpuT+lX5kvDrknvqBz1vaz9q/bb6tubBmlt5jm?=
 =?us-ascii?Q?cPP6LZ8wXDBWDSMNlasyOBfAC1GLE05J/sJ8y/HcPKHbgm+p7HzWvAkp9Uqw?=
 =?us-ascii?Q?FkADXVfSp5AhAqZ2XpAfIjK7WDC9ypsTDV3iWIIkhXjwZXwtRGx7rLDjByg9?=
 =?us-ascii?Q?rrfEx8ieVaeE9dpzXXDKgZkr1yo2v+nt4JLuNozFpph/jkd4yusgVyqGFziq?=
 =?us-ascii?Q?Whb9Jx/B3Lz1ESrZKgn/EZdKsfzTxImWOWPUATmLwzoiAA6lKEf4Dk7YYP7q?=
 =?us-ascii?Q?WKn65NK7HQhPjv6aFrH1pBQg570mOSzUfDCEybMantSbijjKvOjrvWLtQg/A?=
 =?us-ascii?Q?POERN0PMLONlS6Rg2ebj+cJJWVsl24/tdhOWGO8XjwDI1K4QzA9IX7Bd4JCU?=
 =?us-ascii?Q?l59MGIlpFdIXSmVUPyAwtnks2qSB+/byac02P2kWzl83PJlYO0CPsH1Oxnmx?=
 =?us-ascii?Q?4mOpxaGJbmnCIyOYikeA5De7z5S+vWi3L3D8A0e1UmnU1RzhofUJFx7WR8ym?=
 =?us-ascii?Q?brr0V79rwm8qYO0c+bqpwYuolp2IcA8RdCVC6nRZbkZHMKj5N5a+VzQwWX+r?=
 =?us-ascii?Q?JZeE5YRYPXOrKIsw570gpQ6ykBxtXVsIJknE69KGMl2HDwJAlW5BaneuRAM2?=
 =?us-ascii?Q?DjN8ZzSuWsy4FQMR1z0+pRYzXaJmNHQpJeUjXYn43gCvwyrkjOSG0FlmvrvX?=
 =?us-ascii?Q?HdLrhamQaOOL4TA1zpHIymrn2Qqi3wkdWUk4Jr8XJ7zRSzk1yrbUvNJGmLv3?=
 =?us-ascii?Q?x2cfTIR7U5x08fN2IdL/H3Mhb8l3riQj4Ah5JS28440d4fVOZahSqa8avLFT?=
 =?us-ascii?Q?3mXibS3vM9SSzgKFROrmdmVfHoCpd7hWLYYYARzk12vp3ki1DadP6RLR2Rrd?=
 =?us-ascii?Q?T+OOWIo0DJo3NOEcOTJu1NuQWSkVfA74MOHoZtvZzfLhTgHvkzBaxbsIZV61?=
 =?us-ascii?Q?O3KpmbGnT5/FB/nn2kcO5RQoMYriK7XRPzA6mnqA9a4Lm2lLjsKhJLAA/zSp?=
 =?us-ascii?Q?RO+6fM8Mn+xpynAVh5M/qxcZELnTbXIWmhMdi5Foa/fkb56nVLIoZiv8z9zl?=
 =?us-ascii?Q?WAHUPkuAwOdOuPTyYwgtGc0ZOY0kMZIbGhn5uf01zcBG+Ek9Eybr5kfsffaf?=
 =?us-ascii?Q?lcFjGgHcnVaXHT/4/lAQJqH3s90Up7w8n09CBuu7?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9e4ba4-9e69-4942-2750-08db83950b7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:33:57.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr55Gt8rHTiApn7kuFSz1gl3/MOMtlZA4uyc9oQkrgd7DLqRoTc6fIgKYci+na64uL/2xMJxB+9mmIMWK6GaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 57e539d47989..12ed71428939 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2426,14 +2426,15 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 
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
2.39.0

