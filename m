Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4328075DE46
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGVTiM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVTiL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:11 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B7E79;
        Sat, 22 Jul 2023 12:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgV2YHTQQp7UEXSxk3Yu6gt/SzG/KmKWw3f4BmqK/7srLGUFPPIvT6N/0V019SeGYameLE2lXOWE2T2NxhFZsauGBEEfOa6uMVHNzS0zbx10spqIyvGGbe6ww+8cZFWm4OduNYskOGV9Z1EJrk5ffwujhr6nBD4BFYureATnzkBi7hh2oOVgqiC7IlhTjAQu6kTtVXd5gFT5nWA2vkXVF67XChUBAQLhlvO6m5WMIYcvg/7l9pQhXdveoaiC1+FKQ9GoSA61kMWpw5wlJJBFQQ7NjZhuMiOUmLQtX9ssCIEM6cY2Fgw1URKmk9s/XgFih45Z5EGqmQQDue4c7YKpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK/CPVX7KPPTFi9g8K7QxzUGBp438pRqJnXYdV6ILyY=;
 b=mXqpu/+F0xOrg/hPMssqrub3QiF+I/MiqPMMH373bUK3XMKzh4EsXSJq4yT0tw48l3k4hZV/to1NayPPE2QYxI2dd61/Was0icv7+5wgmL/xspRXGHaaYS+dxC79Lw5dFCNqzDMyizi2c4RxGGjZRclpENPtW10lyhUttg4tYBDiFOidZrZ+ncbdk3u4PwpALXGpPAkRGjxvSoMgEg/fT0HWgjajdpVKs/He5iK3PuGrJ5WanSpmbPv4qxmVS91KzwoKRcLnh28QI6EY+hdlVtmwIK7CEBC0M+Yx6nMgMJfxY/NA5+mPHi+TMfSMhTt3K83IseoWN8nWq7fgeJ0DFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK/CPVX7KPPTFi9g8K7QxzUGBp438pRqJnXYdV6ILyY=;
 b=NmDnBJA5ry5rrD2/ShpOkvNqRXiKqpOzkU5E9uJuEJgLUCH4XJNbwt8hoR8pdT9Kor79TcMYwaW3PBkdmBfuo2jj1hvxCaVjatf9Y80HXyJSgtPrBa/SmRixn+t1836SSrzdn7tFNrQmFbBp58yI8H+mOP0lb5rXBmylmtqq+uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:07 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:06 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 01/10] tracing: Require all trace events to have a TRACE_SYSTEM
Date:   Sun, 23 Jul 2023 01:06:56 +0530
Message-Id: <1690054625-31939-2-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb870108-8a49-4bbf-c230-08db8aeb2c34
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1W1sh+yRJaMuwKtdn/QqCHkiG6anGKBmfPNWai9AbYF2cudO0I1rB24zmFmOw46kflWQFEG6ogj+UbhbUdQCCawyoPqz7NpKVqAJxzdaxxedewLBZqj9P7JGwcpK46R8wr3F4+yykVoOJAUDFOVwGXQmBqsbJOm1M+oN3WwAMOieEQgflb4urJRJqbECea4IDTLNyNS/qAZ/wu1usKsRzOM2LNsi+XLeSfBsVbU+rRdqlHO8OB1/eu8OpDtZCGn+Qj2usua5oLicqeUb3HlATqOWL1fnq4FJOs0qY45CUkBjo6K494AQeGXppawcZeFoc6Jy5I5YVGN5NFoN3xtmWkgWO+JNoCTa8T7gZ/+XybSxwmNVq0URYniemcvDc5Rvx0m4yNM2i61QjLWzrpTt0+w21AtKJ7BqbAzogROxUoV/rNtK7Ej+rCeHbEgDLgdtv9CVCGScQXUtDBhlL1GcR7akNQgDyYp3k9/jJInMUMNLBCG8dLWc/4SvH5X8xyahqq2vpp6xHEW2OxuLLSfCOJDdmpxtL8wNwItKJE9lUJr+Bom7WV6sbRnhEMw7rhCR+8r8Ful0nJp/SE37PdxShvABNjGItm3KEknQYl+9a/whkCrzla2AZC0jMh6nFkl1vz7wfyJ/JgZ0OoH1P37G3SdHc05N2xbwEEhoup0sU2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIFcETJlYIgW97M4BouGSjwXvha9DocRLbq56+P7FrvVhkC84BKjtowSa1gH?=
 =?us-ascii?Q?XLGeFZhIlkpZGTx/0UMWUVacbbFe6wG03RvC53q3Gqii1YVVMxeUiY5ye74V?=
 =?us-ascii?Q?b0BPp0IEy/aTC+ANIqvMBfMrAlknnwFDCkhNjeb7OhB7TqpnGgNX3cqXOI47?=
 =?us-ascii?Q?QKPv5SqEy3A1mi2OpuVH1FmML+dpwfSv3LvRLDzUGGDsotBTMCN3oRiugH7D?=
 =?us-ascii?Q?N6O8QCH/mp14Tw3jCL/xTlCJSh49IOtJfu69LiT1707bT/QYPHojj1xoAM1k?=
 =?us-ascii?Q?tcCy/whSv65LMd8d2GsZ03hfTkTmDpUA6n2Q4Mwkhmy48nQDFALLBsBJPGGe?=
 =?us-ascii?Q?a+LC4uI/v6QvHgw5P5rB52ozXBlr5JRdF9STppFnIFt6lPBJRdhsP4L2mP2U?=
 =?us-ascii?Q?eNKVRRJvddLIExouVakN3OwPclC9OejcM91igQ1MmA6kngB8gk1CqScgWoXM?=
 =?us-ascii?Q?kQ4ooJrJNZf+UMI1KVCvDC9dTSEMqw01pHGwjKrBA/LPb2XVy6zQc7aHur6l?=
 =?us-ascii?Q?tm7piHiQDonkfrsJWUTuI5YMgzAaim1LGTjHq2usgtxPnV+21gHIcid1Oi06?=
 =?us-ascii?Q?GeXfiI74ndK/TGHJJsTPbCTnjuqenmBU2AGRywYXlVhbvhf33zeP/u+7F8b4?=
 =?us-ascii?Q?0U0nw5Wuy6uKVUHjAymD73KkTK1WSnDWXLak1RuRMEmWi6mAaOlc8/ftldvz?=
 =?us-ascii?Q?0a6GgNfgovjVdv/y2J3C1IDibHOlzjruaCsjTiJYeezVcLvKBv6iFIlAR3Lw?=
 =?us-ascii?Q?EI12u+cjyEunOEjrbhttyeg+WjfKg+7WS+WjkC1Ne0HcHPreCEUMUXsxWmGT?=
 =?us-ascii?Q?Ave+CefgDUW8eJD03gKcmG845+dO7nPTzqag9au998RKkTFVoeJZc+6c45Em?=
 =?us-ascii?Q?lvHlYLeVT5TqJghBlqgBZMMj9z93H4l8L6ZjR8yCYByzj+tinHt0meNO6sgj?=
 =?us-ascii?Q?kN+lA1RA6AZcNF65VpZq54kMDMog4KKHJCYrCgVx9eXbmGSzw3HELC1Hnvfv?=
 =?us-ascii?Q?kPXXRtMCoU7sLGL3zqtme9JDXFx8Zr9Y099HjC+8QfCnxnq2CybES+/9QcTq?=
 =?us-ascii?Q?w1+pfg+iHDglhnoWBLtkVQSK8BbAf+COu0OnrOAZK1iaSxdbNndmbgLhBK/V?=
 =?us-ascii?Q?eXIaeJlwYNu9EXBDX5QlJ1f8q5/QQwSpo1RumskBwTepuJ49MP1XeXVh/QIf?=
 =?us-ascii?Q?mEZJt7schamISzFn5cbR2GxsEyyChC2XZ6LdHq+ykuDUf8qTO2T5QUq/kuIk?=
 =?us-ascii?Q?L3sIsEYPGYKHLwT+jqYauhA2ABKJYbRwGIUtkdJs3C4lSJPiw1Fi3ijE2JCB?=
 =?us-ascii?Q?XPS2QkqqnKK9EEhGxsAT+0GANZUPR+Rn8xHR6Yx+P6xy/ljlVNNSQXNkT0s+?=
 =?us-ascii?Q?4uz/sJeS97b+0mEstDM6wvxmgWNEXknJq7q3MmYp8dTTOK2q1zUCDdjo16Qg?=
 =?us-ascii?Q?VWIKxya+stlksTD0NimY8cRF3SAhwThcivkij/guPupW+l9x3XbNcTnm3qcI?=
 =?us-ascii?Q?kgHaj+a96ReKYN3bINStrFw3wSY6HFSjW6qlkTAOXw3PX2XuH1lNASbQLyv7?=
 =?us-ascii?Q?UzZ6q4hxzkfd1xXzvf8CpF+TUtnPkyMWi7IkHiNK?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb870108-8a49-4bbf-c230-08db8aeb2c34
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:06.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86WNjMSSOJSO8pi2N8UyywuuOUf5dR/kD1I2XsIZq1vKkFw7iA+ikSpGCBO5zSmDuaJzMcPY2OLebmAAb7WLqA==
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
index 5d6ae4eae510..a284171d5c74 100644
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

