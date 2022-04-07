Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05BC4F7F0F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiDGMeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245173AbiDGMeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 08:34:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF5117C84;
        Thu,  7 Apr 2022 05:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnNMywWyJO8n1hsON8tnRz6dJ7aKcKrTDFgFnRp/mYxAyE3am0nSMWs1WLOjzopCEvHy2gXDhrC9EYxBCGJK3+YjYWRwvVWa2hLRo5Zkr6eEJm7eSapGQtrwHmrL+yVbxA9d0CGeIqGz+jMBkIRpyQEOOD1gdjpI9+VXMdVYIec1a9VV8VlNHgHE4iVJ2D2yT2lSgsxvrVKM7LQLWk28rYz81MYHgMq/89ROcctfxfg7KIVuhmM5Ozc/JFR9QxL+H3EUMkSoV02Pf+k03Kap45acDXjA6iv3iMpEWj49vrOSKRqKeIIPDb1YpbXQgVZ/hNHGfBTzv49Fz7N1du605g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6LT0Xoox5HHB2wCGOmO6/xdyKArQH/3Tpyiv40tOTw=;
 b=Z9J3/P9XGxyIHUI/wbTbJ0eY6diPNjpDomswwQ1zoXaTEntZjzkmDaG6jTzZi/Yy1ZQH42JLGPKELRWDUE+iNan6CiOVzueuBIygNb5CndBe3vEeSYeJuc9oT2GIdwQ+nACmdJiSeGYkciCDgaaN02A/E2/7BGBTOwHY0PCNxqBPqFE9fcOxsP85Wscn+Llq5ibh2PEmKt4HOqpcuIjTS8oWwOA0LVgiP8mqwELQbZcBe6kSRmFZ/RHSZSeuu6XekH0k6z/ArL8kGVDXMkNLovI6IfZmWq9tiaadrIsLsZctnN2gSXB/6Tqk9QcROBjucPBM8tgCse+Vml/DnJo20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6LT0Xoox5HHB2wCGOmO6/xdyKArQH/3Tpyiv40tOTw=;
 b=MvM1FCcDut6JF+P+tqr+hWYAyU1gcflIbFVKz9kUDEqOLn3SGfWwtdfSJKkQcKt2Myc8m3pYxp6YSpVefpJErGca6jTuRPIB/+87TIqVL/o9BXlMUIa1DPfrP/r4N5lQqon1iqQ8Hx2K8bVM6nhAZUFwphp8S5GDrZ4CBdsC/84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by KL1PR0601MB4404.apcprd06.prod.outlook.com (2603:1096:820:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 12:31:59 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 12:31:59 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] userfaultfd/selftests: use swap() instead of open coding it
Date:   Thu,  7 Apr 2022 20:31:41 +0800
Message-Id: <20220407123141.4998-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 609567d4-b105-4ea6-028b-08da18929c18
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4404:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4404FB9F6208EC9F95A4F8F6C7E69@KL1PR0601MB4404.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7e8IVF+AYoB24OU+i1kxNOsE8zTuMAb5FQYcwS3PoIpufLQcaoVM3/5XC1rdFGTfrK3+Kw7kqCrlw4D8r2w3/oXozKCZUXPBrymUwOGVCVTE8tOFY4jgLXX6sAY2PjgxQx5UDcHIIn/iW0GycmIgMIHWHwKBXo+YZCZt044q+b4LRFnEUSwEFgw6AFXgCj+YFsWkDkF0ReA5D4uWeRRMFZhOMHQRiv/3HhLTBLam7HKNVbTiU8wIgdrEcC24Qi3DfF0cDBtR/D4N7ptiQqJeUbETV3XndI4w3NO+zpnBeXQOCBn6Pn9Rab1E7lveMEwiy7/p9EEJ2pdf04un7Db04k1EbL+qVKu2A/iWj4oVydh/G0ltHaJtafu4j52zi2Vh6mfkjm0NxY8DDI3f4iy338xN57piQcZBXz2l2Ir1znYHZk6Y1geZjZBc4PP8VlToYuWYjXfj/xT9tiOthbKGJttzuVtqmi66EHwsBoC/Flnv/N4mSLPHkdUF8+gfTsvcTosCXDmVm1+gdUs0iRRNWmkfrN4WNPW+dTaXJQfN349S0ZXdtz0gVWT08G00tYzg6Nbvok5Z5mJD14QwdjAyn+OrPd3GAqKzcgKMFQy0CY5WeLi0+H5uEfoHoHAu7VeTyerApckUR9J+hMGK67d6Yioo7Kl7J8Qaidw1/jSgmU9vy9YNADZr1TuZpJ+U90FAh/TkHb7JakbTA7U3a1B+5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(6486002)(36756003)(110136005)(6512007)(6506007)(52116002)(2906002)(6666004)(38100700002)(38350700002)(8936002)(26005)(2616005)(86362001)(186003)(4326008)(8676002)(1076003)(66476007)(66556008)(107886003)(5660300002)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocL8PHDHVD7EHnxtQJk3ALfAReoAUg63E7yGNje6Olpre3d/zM+Ti4yevnJh?=
 =?us-ascii?Q?iwkoJGTC4aGxBdpKDkXNuB5AXcgshTeINrRv7S0YqSaCfyxPs9k5cgujKZb3?=
 =?us-ascii?Q?7ChMDOmTvU3xJHSukU8h0WJNUX3eHWhyqsCaMX0gpDn5NHLJGVCF1bAIbMhH?=
 =?us-ascii?Q?L7gtt3TSaqYqPVsvhO3T/U0fIuMYDYOGM0nrof155I5EOESv91B9qA5H1S2Z?=
 =?us-ascii?Q?qzaF2Uskdg0XkXQpzWTt6HoXrlUvWywQO4Gnk+nWR7z51vSmKMVQh3n0C3yf?=
 =?us-ascii?Q?We3KRNWc2Eq4xsf69jUVf56LmGZhiIxK8ISA85H5KZi0UWH1wE/vmAeurwcO?=
 =?us-ascii?Q?AsTEcj8DR3tHijaz7+AXwTm1ia9DM+omedcEjofU/zhYMyAKwYUom0i6Ctxd?=
 =?us-ascii?Q?7noXhRF1UQWhxkEuZ2B/oF5U07cwTJhz1J18ZBtCw5AX0ObJvhAXig+O60YJ?=
 =?us-ascii?Q?iwtf/XzDkByh9rYxbFLBYX3T3tEZWBD39as5whqYAq/fUcgqVAYPMqJEJaqN?=
 =?us-ascii?Q?7ASA3y/nNLXllpB69eamJDII4lNZnTnpOqTo/QcB2ASZcRlhgU50t3q4nE4w?=
 =?us-ascii?Q?bfFZnmdQHvVq/ATm1/hYJPivwVtDdkjN6Q+2XxhdKbXhtQrnEFeBsGackypt?=
 =?us-ascii?Q?73yS0uxzRYQMDhA3aflV2CmSx5IT/lVTdS4I0u2tUB2ZtmT3Ur0YCKB/HoLe?=
 =?us-ascii?Q?67VXAhy5H37mj83DXpJwqFCwyDg5dUHIyPOGn0K8RipKBRQMJ0/h+b6+yrfz?=
 =?us-ascii?Q?nqRdSw0gXcf0qw4jSh/05iOXP+SPE9YwNWTbm+FpLU70bFOTSDwWLrfQB3iQ?=
 =?us-ascii?Q?5e6laNR2NVOqcQma7rgcqZLFlUkmKIABXVFNZJZOU/uOEDRXFSUTCGleBk8o?=
 =?us-ascii?Q?GE+R26+DmG0ze7fmiLFrjhBW0BoPnWqhY7N+KuxN12C9LFVr3uysmtbp0cIe?=
 =?us-ascii?Q?Dw0h1RQi5LyNpQnZFBnivE1Lp7MyXPflCYckXbYuonenphq9laG53jeDuO7B?=
 =?us-ascii?Q?CcP5Y6j/Ks7cHfkfEm/UJl+X03MB6DMY+9SQ3tVtDRW4ly4v+8AHAIBkN2s0?=
 =?us-ascii?Q?q0JH2Yvz+KIB/TwZI2WTpSRnjqd3LULaSnlHUut5Ff0RyHA6667xJ1IaamA6?=
 =?us-ascii?Q?wiAK86U//W7F6c/6KIC5OVOX42cjsCVYpxCrL39Vjow7lylP3YAd0gamvEFV?=
 =?us-ascii?Q?lwKkLPhWbiC8uGXvkEav0BLk4b7OWbv/+ssIvrp93xnXLsH13V9Zkw9qca97?=
 =?us-ascii?Q?6E6p1u1Nm3qAJw0muVXAXgrlkA5ft97YSq/7l7v2hqQx11Pv5svceOPT4J08?=
 =?us-ascii?Q?yjm3/d59lgY2aOpwwaEvzF8juBnicMULHsgEL8ch9uJ41Jt0bxzNpy9Mygk5?=
 =?us-ascii?Q?irTDuZiT7skpkFC7qIrXP7cJFvB78m9UL+U+5NBRATfUqV3gN3NFQJb/iUtN?=
 =?us-ascii?Q?EbspEtmYu3ck6qoeZFbASFI4s+035iS2Pg00/0bwWG+0sCDI73fn5THcRnoL?=
 =?us-ascii?Q?308/wfC0H9omgKSguDI2gyjv/Pst5N0+dhhmTOzVYfxcaAB/blKirZGty/Hu?=
 =?us-ascii?Q?8JTL9hA9exG4/kBngpEyV7AYaub8Z5mtpmSy5pgAGIXOxtzdebCmoNL0ZwF5?=
 =?us-ascii?Q?pRlTevxAq07vaGw29qQlYcsKQJAspGMiOh0I+jGqLBGN0qqZsGiXafK9Vclg?=
 =?us-ascii?Q?xICqhPVcn9l4jDlIevAM6V62Fq+62XA4vYmE39AI4NdojIk3CqaBAbLHaWdb?=
 =?us-ascii?Q?+wRyEINAqw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609567d4-b105-4ea6-028b-08da18929c18
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 12:31:59.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWb7RnDF0K5wPC+6RWInczNrO6XQNAFGLy1PoOTK9mzex8PORZa56iiyQwlvr0y166dOhMBk2DXzyxMcOhqu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4404
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Address the following coccicheck warning:

tools/testing/selftests/vm/userfaultfd.c:1536:21-22: WARNING opportunity
for swap().
tools/testing/selftests/vm/userfaultfd.c:1540:33-34: WARNING opportunity
for swap().

by using swap() for the swapping of variable values and drop
`tmp_area` that is not needed any more.

`swap()` macro in userfaultfd.c is introduced in commit 681696862bc18
("selftests: vm: remove dependecy from internal kernel macros")

It has been tested with gcc (Debian 8.3.0-6) 8.3.0.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 92a4516f8f0d..7aba3ced7545 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1422,7 +1422,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
-	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1533,13 +1532,9 @@ static int userfaultfd_stress(void)
 					    count_verify[nr], nr);
 
 		/* prepare next bounce */
-		tmp_area = area_src;
-		area_src = area_dst;
-		area_dst = tmp_area;
+		swap(area_src, area_dst);
 
-		tmp_area = area_src_alias;
-		area_src_alias = area_dst_alias;
-		area_dst_alias = tmp_area;
+		swap(area_src_alias, area_dst_alias);
 
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
-- 
2.20.1

