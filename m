Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D27A1C87
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjIOKmI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKmH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 06:42:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D110D;
        Fri, 15 Sep 2023 03:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvq1GxSLFI32VQRVTcIH7Kb9nk11mwQMUfB345CpaaauhANaH5KoX/gcwMweqqG0eCM0QXSmY/1RxAv2GijjfsLO+5n+MxY7QzVcNYgF0H1Toxoxk04u7xY3YkhMDAmpmaPeMbrmx0S8Ky2uHwclzp16GDsqHHoeMJxMgYcV6ATMeuXrgvqZePD+TASOqxtw9jjT6AH0tL1jmTeUGqlQmXHQVxz2ZIvXNT8WcVvGNOaIKlTbTVvFIGVog9ilDEXFpV1lTR5O1JTpYm4K+heLPYBpgkOtpuhYqUMW18qI+cxHRR0aSolXv3qeJR7XdcxeOjMlzGCgsSEn6j8MTdo1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhVX5ig/vQeK1u0U6/SN8nsrOZAAn2FVI/ZQr0mCMfg=;
 b=Efw6rPvGXd3ef7R/loOXk+cwpslKl2/Uu7mNzZHJeHkbP6kSsSuC+Ep66CwSFB/NkQ/5kST8dw8Tm5ieTz8LtIOexS4GsGCZbb9sZHP9nRnkeGCKQrOqbHbk3yIWFAKVHXhpmKHEMxDhGy61r5ALgFJjOAJv5qNNDpuQss6UmsY3JzGKkIsfb7Z27NtoUpEYdL0ben+zzPTL+svuV9zrtMI+K7PMNk9R8vY1PXWaw8ZZWaTjGp6EJC4hynXv3Wax9zfYvmxdrJSJdxe0WQFbHXQtp/h62A4yEW3zCK3BCZLWuI3k+RxzFWfpFjdhbuZUFj/o8e9lNUYYbhvHO9uueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhVX5ig/vQeK1u0U6/SN8nsrOZAAn2FVI/ZQr0mCMfg=;
 b=Qab/RReS+pDr0jpDSupnfLI3kGTrXi2s8h1hyMe/XuQNhbdgxxJRhvlA9STezawAQ5W3GDyJqrzVubYIVJ27jN3yfnTA2YxdNEzQKgWFUcd3MGte24rQQA5kGKv/3dPDvH3sRQsgtSFSBGn35snzkjkpUNMf6yTMxQgnHEuq32U=
Received: from DM6PR11CA0046.namprd11.prod.outlook.com (2603:10b6:5:14c::23)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Fri, 15 Sep
 2023 10:41:49 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::a3) by DM6PR11CA0046.outlook.office365.com
 (2603:10b6:5:14c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 10:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 10:41:49 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 05:41:47 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Ray.Huang@amd.com>,
        <li.meng@amd.com>, <shuah@kernel.org>
CC:     <sukrut.bellary@gmail.com>, <gautham.shenoy@amd.com>,
        <wyes.karny@amd.com>, <Perry.Yuan@amd.com>,
        <Mario.Limonciello@amd.com>, <zwisler@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Swapnil Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot package for Gnuplot
Date:   Fri, 15 Sep 2023 10:40:57 +0000
Message-ID: <20230915104057.132210-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915104057.132210-1-swapnil.sapkal@amd.com>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f160a9a-0730-4029-083a-08dbb5d85daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2S8wg1hEiAqSlNuYCcI3mbK3TkypKOvJq7zgOUSMV/Pnsd9K4zzVWay4XxgQ6hpS3Ojp1/4Dh3cO+fOr33CMDK8WRxhq4d75f+SDjqm0v1lAmg5htB1BgXmzUn/VX56sOs6nftKYwUlNx1NK6E8cmsl0z75Zs3B5+357kzuzOobUu6yxjcXydmcfWZyXX4KaI/9IbRQFQ+/pNZ7DVa0lnzPSlyNQJOaoZ5tBfdYPPYEeEcLdtp5HWcohDrT1v8NT3f3MUwAXnfp/KsegWdAjRpe2zpgn4ZtE5+N2M4nQGb697APd2tgkGWFmD/WwFgwGIN94ortwjgwrxl5d9m17JFxkMsUcF9KoeeCHIWLR285Fv7uuA3qZosvzyq2lT6i8Zdk1NJhLN2pdFayCGoK5a//KatJXMArBvAW50NXp+864zo5hxPccMMvFstnEJWOS+dWg6IjrMTz9OMEeRc2OY1yXF/aqQZb4WEs4uXQVxUvWj36wgx8qvdTM4vxG4TZMsoSkDtx8Y9mPCMzYMw3orA9JsWduh+NCGxF3b/5uXdKvFE2gopYmsKYxafGCC488nsRuy79sDqIxyF7VKI6uwxULzU5A8p9/qDhKVOWd7HFiusH4CejfL4tayiCOqGnaJE7ukmj5SXdMvwJMbfzGDKX9pjn7FLJ/BDtU4ziRSEpTwAzfNPvVTYqo5L6vvJm7YGiWCub3IdkxwT3YiUsA9xTh6ecNaoljLqRWkHhtkjuDsIVf8QaaksFTm1vCXif3BzqbbbdtCM/m8v+kVngtxJp+YOuVBxmOJI6U1311mk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(426003)(40460700003)(54906003)(83380400001)(70586007)(70206006)(44832011)(316002)(86362001)(8936002)(41300700001)(336012)(8676002)(5660300002)(110136005)(36756003)(356005)(40480700001)(36860700001)(81166007)(82740400003)(47076005)(7696005)(6666004)(2906002)(4326008)(478600001)(1076003)(2616005)(16526019)(26005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 10:41:49.1107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f160a9a-0730-4029-083a-08dbb5d85daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In intel_pstate_tracer.py, Gnuplot is used to generate 2D plots.
In current implementation this tracer gives error while importing
the module because Gnuplot is imported from package Gnuplot-py which
does not support python 3.x. Fix this by using pygnuplot package to
import this module.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py      | 1 -
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
index 2448bb07973f..14f8d81f91de 100755
--- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -27,7 +27,6 @@ import re
 import signal
 import sys
 import getopt
-import Gnuplot
 from numpy import *
 from decimal import *
 sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index ec3323100e1a..68412abdd7d4 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -32,7 +32,7 @@ import re
 import signal
 import sys
 import getopt
-import Gnuplot
+from pygnuplot import gnuplot
 from numpy import *
 from decimal import *
 
@@ -295,7 +295,7 @@ def common_all_gnuplot_settings(output_png):
 def common_gnuplot_settings():
     """ common gnuplot settings. """
 
-    g_plot = Gnuplot.Gnuplot(persist=1)
+    g_plot = gnuplot.Gnuplot(persist=1)
 #   The following line is for rigor only. It seems to be assumed for .csv files
     g_plot('set datafile separator \",\"')
     g_plot('set ytics nomirror')
-- 
2.34.1
