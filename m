Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7775114A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGLTfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGLTfe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 15:35:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA61FD8;
        Wed, 12 Jul 2023 12:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd/C1F0BTw9a1Yo/JLxBZ9PiJsmtfuqcva4Bhd6FpYVb9x+8gyxB/M8DFVxzNnusUuLEl7cJeZBpl3D6muNvCPY9mfznIeScrEWgZ9Kaj2CrbKjSVK2AsvGziZnlcqottMBzKXvEBqo2jIVXPHSGAKx4RRRuM+u++2Va5P3cfpb8UwRL6QNW6bJF4N3MSc/BKgy8VjvnqekgUgtaoGJQ1SKUhYFv9jTs6Zi1KNw9MJRmTZTmSDSt0YzmVtVJKz7gbgZGhO99J6i3siSwWEMGdDzoX53sXqDHij6tt6jUVRq8vEcQNH92q7abKuVc7U+NqAtsfFLTA5BTmwveZD8HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7g9yqWSyD9QpWJZe2mqT8VJLmRqALnaUXr73n3Rj9M=;
 b=WmOqlEsd/vq8uJlgs3sGFRx7bYdyLAwZ89AwRHeg6gSG+VOWFr2j0uzF2fH7twF44pA8x25+acn553s63oMN0I1XRjX+7NSvhTXMDRZBHxTSI1vvrsUoR6Aw2WF8n0vw+NNddjtypK5RvaGhgRH9bt9VSqRr4mjvDOrJ8KnosDQipL/hq5kRiPxsy4PUBNruCT6Aia+aWUjFdKNYANPnmcx+I4iUxE9iDSCPRnrtlBDUKd/BDJ+9t27JPpJbYCz2kCNSnltIwvv+emWP19KUTugX3BfldbaoKzZkTHTS8k/J9//oGN1WaoFsm92dbHjk1Kt8i+wWu2HoH5XVGZdAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7g9yqWSyD9QpWJZe2mqT8VJLmRqALnaUXr73n3Rj9M=;
 b=pTQQ13kYR00ty6+4DjHJrk/u9guYfFazGVDZeAfPVEAbCCZggi+oVatqI87oVrdgc8cG7kDFqgLTaIOSs9hfxEcjkY643iZJH9IK7KCmiWCyPhKlLTTKVXWfAVfwxX7cl1MOrBGBbtB6DHVoU81qa3Vbm8M8G73F4VdDo26ov4kB98iE/Sd1K/mYld2Qw2KE+5n3y+p+XCffWjzWP2ziTsxHBHMpHT/4deAj4xdwjjB71hVo5MlaHr8RIspJjRWxBeIWMO20q7x7EtVmUiM5xM3CZATd2iox/28GUm5gXio80LneLMFiW1hD+cl+3VvDZnIdp89vvlB1vaFQAoeEDg==
Received: from DS7PR03CA0111.namprd03.prod.outlook.com (2603:10b6:5:3b7::26)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 19:35:30 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::19) by DS7PR03CA0111.outlook.office365.com
 (2603:10b6:5:3b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 19:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 19:35:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Jul 2023
 12:35:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Jul
 2023 12:35:16 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 12 Jul 2023 12:35:15 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Evan Green <evan@rivosinc.com>,
        Hugh Dickins <hughd@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/riscv: fix potential build failure during the "emit_tests" step
Date:   Wed, 12 Jul 2023 12:35:14 -0700
Message-ID: <20230712193514.740033-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc69c84-6832-4994-755c-08db830f26c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhjoEsxlYhzCXROyo+npUIk6ujmEY2OfUMHzOA4/0Wvrhypmej8GnIHlrfD3Ev+NZ8SdOL/uu3cilKvtYlyr3viwRbSAcGbkbxkB8xU7k8Ei8Qp/1hdTdum7Al2zKyNpO3fKAa8KgkOCaq+nqM+lAAJIeDHK02Ss8W5JTUaJGOsA2xtmbwrn3ljGoREKp0+YTvYIk/zO3F9r4C88WKnNN33a1b+xQSqWDz/0ZuYX39+Dj/AYE8/pilyJAP3LCn05AB+e6jjz3FmkJoWgeJHGBf0x6YjNQPAByfPJmbmxRZCMUcC+KMct4PRTPE3/icXIxfsjfoNuPYhCuxO/N1WXb8WMGWZdATk7G2sZOwSprOavNEs5mHIYLXDdZ4XetbX3bgzTmGeeKx5J3uF416xri5p93GYMCS3OxyNbS+h2Cw4LUCuuzsPl1njgX3WJIFmZEyJeFOF2Yju6V0dg8Pvv7nVkKL3Kx124/JYyVav2uxmnSzhdf/OHx1bd+VHgTgft16S6rVutPGtNnJSezXFsg1B8SclxEmKksVSxioP3e/pVjxFLe96V0QRVXyoDB0EVu8srZktXTlSB6FjfH3NbtYyFIWkV3GYTDZlF86MfIggfcDm+oFKfWDLGNfy/fC1kGew/1Xuy7XGbyRMOb2byQY+sf0uqDi3HTtmj8StccMk9332tbtDXCXHHhF0vqr3bR5fDOaJPiHgl6tbcD7SE8WfbWiIx9CVg7JZXazBEa/1KePkvyJ3Yelns7471WOOuL+vskIbkgt4SwrDhswHRUINkGwfom320Sk2EIRigLy2lAHmZJiMspwRwsEOIF9xE
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(54906003)(478600001)(7696005)(36756003)(8676002)(7416002)(8936002)(4326008)(70206006)(41300700001)(6916009)(316002)(70586007)(426003)(83380400001)(336012)(47076005)(82740400003)(7636003)(966005)(356005)(5660300002)(86362001)(40460700003)(36860700001)(1076003)(186003)(2616005)(107886003)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:35:29.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc69c84-6832-4994-755c-08db830f26c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The riscv selftests (which were modeled after the arm64 selftests) are
improperly declaring the "emit_tests" target to depend upon the "all"
target. This approach, when combined with commit 9fc96c7c19df
("selftests: error out if kernel header files are not yet built"), has
caused build failures [1] on arm64, and is likely to cause similar
failures for riscv.

To fix this, simply remove the unnecessary "all" dependency from the
emit_tests target. The dependency is still effectively honored, because
again, invocation is via "install", which also depends upon "all".

An alternative approach would be to harden the emit_tests target so that
it can depend upon "all", but that's a lot more complicated and hard to
get right, and doesn't seem worth it, especially given that emit_tests
should probably not be overridden at all.

[1] https://lore.kernel.org/20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org

Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Andrew,

With this, and with my arm64 fix [2] that you've already put into
mm-unstable, you should be able to safely drop commit 819187ab8741
("selftests: fix arm64 test installation").

[2] https://lore.kernel.org/20230711005629.2547838-1-jhubbard@nvidia.com

thanks,
John Hubbard


 tools/testing/selftests/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 9dd629cc86aa..f4b3d5c9af5b 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -43,7 +43,7 @@ run_tests: all
 	done
 
 # Avoid any output on non riscv on emit_tests
-emit_tests: all
+emit_tests:
 	@for DIR in $(RISCV_SUBTARGETS); do				\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\

base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
prerequisite-patch-id: 37c92f7425689ff069fb83996a25cd98e78d7242
-- 
2.41.0

