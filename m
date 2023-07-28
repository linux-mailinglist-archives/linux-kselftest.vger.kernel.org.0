Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B3767466
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjG1SVW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjG1SVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:21 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E584232;
        Fri, 28 Jul 2023 11:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHvEXE8XKUnE8GvkG5RNdGMF4LQ0a9kd00ttBStdbVJfhPG8OF7DE999n294or9h3qgNfWxHBUCFrzFBgLPNJ+7fPbp8yaPxuS7RCFZyDZXIAKjOjZDqRUKNT0dH5JhPcudKAaYAaLduM/EBgS7JEYMiR4cOUeqMDeUkolxfWf9byNN9z9XBzC5llLD6nwm+pnMbGNf8RLtti7R8uaPorsVPDaZHCNqIYphcWonIXXe5iT/75mAnKaRDZlULO5ycO1VMX0bdfNktFxlp1QNkw1jMkik3ygrDsk+153WnsFTKcNIhUPOPbeVJ5b3Se5QQFMiUA3W9HivyhA/b6l4wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK/CPVX7KPPTFi9g8K7QxzUGBp438pRqJnXYdV6ILyY=;
 b=fEHgXBh5KzfjM3hEoWLUN6o50MnE40J53sMDKM+xXbmgtBMqcZ5NGymVI0n9C1nZPl987/W/HPnvfsMkveGFRGrW2ZYhXgGOvD7lTnDGLVL2T6go15y50sE4bFsjSlZcDR51sEIe25p/NCBFTBJ/DwTtKqMlb7Dp41v8npWzU8a7sRQeOa5uCv+rfuTEdjUfelMU79M8sGM8dOHq3MUwzCpMzJJqaUoX56ndxat30N6iHa319Xi38WCwU2E+RCoYohWjWiV7VItrPeCGWYEuxU78TLMUefnpkyW9skP9XLrcuNwwQQ6/94yA6iRzrh3EATOo5sVfdu3WFoMjokyiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK/CPVX7KPPTFi9g8K7QxzUGBp438pRqJnXYdV6ILyY=;
 b=brW9CYJXl7Yajaz8qlhskyByDsFQkl/N0nfiNdphIdwcKo3Ad5+ScMYdzD740oF64OFlTlnGXzxVqWOFX5dOlq8pkco5OUdExoVko35/1fOTEaOJiDoKtK3x87qNnyl7p+jogLm24rJbA17w1QUOv2cAQbY52TclL7nj7b3Ak+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:18 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:17 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 01/10] tracing: Require all trace events to have a TRACE_SYSTEM
Date:   Fri, 28 Jul 2023 23:50:43 +0530
Message-Id: <1690568452-46553-2-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690568452-46553-1-git-send-email-akaher@vmware.com>
References: <1690568452-46553-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SN7PR05MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: f408e033-3332-4898-5d9a-08db8f976f79
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gN591uSyccpGT0mHCEqXmHqNYCMEQ5X77fdS90duzqnCAs4qZkxxP41NTme2andRh1zscQSQwtFsVP5iL4wSWSppXxgGki1Xrni+AdDB6n3F5Db0UVXd3qR9W3inOsz57954BbYUaeOR9tPG9rtnkpYlrKAiLKt8YmaF7sf0+sxws80KIESxNQt1B+sNc9d1xMrgqB6PsXUWOKrkpbVPIjLiFlb9HYwUCz+JFwI25292ickCmKuuZVJ+NmMZhIDpZiT46FR8gHfZDVNQvgG+9ustZeAJZXwnwsFNnwjLOdzti1cJcAURZlwyDyb8sDI+pAytP0jUjIeXYHN49VDuKhEqjAuYAVbB46eb8Xc3IjDnLJO52iwJDOgNRIWOxm+xTVr3hd7qW5Yw1kGEHggHWyjN4eljtFA7rp/MG375gTtLXYg9DBM3htSh2qvjrDSpK+RfJ9WTEIYwy5w+vdrLS21C/VqUSmzzlNftke8ZXIiCTCpsqLFXr1kOba5B04Gjznr/tL2BcPdTORtdNao9g0vK4eKoSWURy/hZMAetVAJR0//xXLnmE/J0TWfUL6HguOkc7/VUrqB+EGrY0FEv+E2AHWAsMlEeNFbwbnJip5C6N/QpZpntJ2zn5eLyLxDLwTCiszeCUwtF+e69Pi0dY4w3fIucXaFdDqn8HXypBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/K19fYdBsU62UwjInrzm17bogzdTBWlTBlYrzTqbY4HaWP6LFp90F02cgSV?=
 =?us-ascii?Q?3hbO2hcSASYvv54ofvm1zX3nnRlKNpikyE81w68MTnMTPilRxt/aUUb7e0Ob?=
 =?us-ascii?Q?dHmCAqm5KzAwcaanyo9Myl93UkRPjcdVnvWaeVPiFMZ1sWOWKos32AyHgnoW?=
 =?us-ascii?Q?QqXMb6nDkWvowO20Jp8LJlQ+/8VaNQQqL3fe5aoH/XkcKzn0/Ff1DYq08okN?=
 =?us-ascii?Q?aYjYcRJpzbu4K9iGmiK6KKRbqjxBbcMtkciz0+h8VJOVA4DYa/yaWJ47IVBc?=
 =?us-ascii?Q?lGJIsMnCCD5IjGv4PeEt0FNg96WDNopa5q/+NLX6737S8ZjcT66JUuIQQkMQ?=
 =?us-ascii?Q?Ec2ZcHt9s9alAZZhIWmxxLGuJaN11MlwCv7s78RxyYdLXPOwTUPEvX+92Z1N?=
 =?us-ascii?Q?krKUsTUE6oygTNMNwG0k/pHBLSquWOTwW32ZQ0NJV25C0+Us+n9Zu3E1ITI2?=
 =?us-ascii?Q?lD+NBWw9Ial9IlgAridJ4aLuBThH2tAXtw37VCh5yPHRPuVPXFjumU84CFYl?=
 =?us-ascii?Q?hUfMa6+HVXtXQy5+gmfZtsnYU0/zz0p+jrmhzfGbuTjKaq4lDcW4YJsYenFp?=
 =?us-ascii?Q?g7p0/PqbHBNNI3XS4oHv8/+rsNpj1lviboJZOr/pPubCTqZs4ai4SJIWswvD?=
 =?us-ascii?Q?dux8ZqcfgwK6v4qKXrVBPylm24cp8+xH0E3p8CyLodXMUbbdi/ygQ8HvWlCX?=
 =?us-ascii?Q?4+ay8MeSvoGHuyECUFVkM0fGlArjOuWr1gcEqATHlp4esTWu76Sd1lW3xfme?=
 =?us-ascii?Q?GKyYZD3anj705Nk8GVYD7hLKwvF/9v01s2q4UkTsV3iROCm+3fydRb4j/+ZO?=
 =?us-ascii?Q?UvYyHvRDePe62ej0N20TL7SMKX6vKepCzwrI90kPIHVfSbFTEKyS71I2l5Mc?=
 =?us-ascii?Q?3m6mvhkuSPubhccUNlQ8vKRwT18H7p7IVOoG/LddoUrXzDPKeps/gXc75wvG?=
 =?us-ascii?Q?praVqB5kjpXfhEoEYmRc9qIh/k0+IOwV8mwXLGN80qoBOqR5aP91aN3P0UD7?=
 =?us-ascii?Q?q5IzBuQzjGtVcv+/DRkANHoKGULuTzALouhrrM427+Vo3jfRXzkG8f/rvPm7?=
 =?us-ascii?Q?DRbkGxygNXubqL8cIkkdj73ZS57oyr+xO7kb/FWbRMxx1ddGF+KmsTe8dnbu?=
 =?us-ascii?Q?2EoGc9huN3RQEyRiFLivKC/cucLEKFVh/q4tkwldrEfkNztTS0W+WWGLpasE?=
 =?us-ascii?Q?6rVhPqMYjKaeB791lYN6yqS3oc66JtgpWrOGxgsCiOWrQQPW+r/Q3T8hzaY4?=
 =?us-ascii?Q?ikHXBjp73q+E617792U403vHIkvDPh7CPOCin75GmLrgU/kz2kOaZgg4EyGi?=
 =?us-ascii?Q?wMVc1fLGECd1oyJwce4ec9srzzxWUgEdqudhGmCQCbrTaR8PPLsCwkn3o4tE?=
 =?us-ascii?Q?Q9kzDys1J2xeFh1lN3jg7QLKJXWRj2dw1V9zwPFSDkZPy93OzkgVbQH6ZhBQ?=
 =?us-ascii?Q?GUKN8s+x9FpGO05i8VuQip2LjTtYTJH+UHL9ZaEGXmS40txDV0pMOL56hZIg?=
 =?us-ascii?Q?FHUsDs9uyVCplwdOfZjJxfg3c0nanUJ+UcNrFcjovQKp4sfYCXkZg1+RUngS?=
 =?us-ascii?Q?Ey7e0fMQLwl4CcVESZ6XD/v8LyopQ0JdHadjTfCl?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f408e033-3332-4898-5d9a-08db8f976f79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:17.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTp7P4ogwOy3JUXVd2CsEhqdEi63gPT5WRS1DWq0HjXc/n2tmQqwzM7si2DqaNvKuB2rOZIhXLMlT4IP76K3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9264
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

