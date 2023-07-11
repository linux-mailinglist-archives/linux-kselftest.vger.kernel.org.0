Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0B74E2D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGKA45 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGKA45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:56:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F6C0;
        Mon, 10 Jul 2023 17:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3xwdSFSQC0wsETkthOZMW4p/Y2601BmKvZDCTTBCdSV1uWHnXaGYBU3UBDwuZ05kCAjN55aLhWjf7QO23LlDY98uiJr4STPtLNwNorbMveLqBmsI0I3TWw1HzBTO3AZ2aVykMUdniQC2TcyG7v61mjB8Fwiu11KbPN4N/PH99lPOs/gkX8s9fa6fmKNNLlzjF7BH5/KEmXcqpLd287tBe+jzz3kfo8GR5MdLTCczrUmVSu4D8bzlfocsgyhKyIitRgZeAn9sFc0ocblvMmr2ih5QT2OoAm1JE3Ty/qX7ymUULYFDgH1rKZDDOiVg7SP4cGJuEPXZfLfm6Yd05jvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmZ1jVrqOjRqClyarmEwyKWdtrRhqDcQqZ2Y7V65UA0=;
 b=Bvbb4NlyHcHAsaTMArMiUBEjlo8uLIksbvp8qg8lgC3NyMwwJgWbSsUnjGcryKuQCsi/q/U/oRinW8UC8rB2t576L8PHS0DeQ4UogvTAqAqkimbBSmMIU5kFKhXl1/1OcvX70AxhxQUEiIGxtq4AjhmTG2REj+41owqA9xKnGaXvug7rh5RbP7GMCF3SBoDOf9yTfmNpWN+aHrg8WWxF4BgXf03ahJfsu6uZKFY5pCj+TT+xQsI01PtC4Kh8Ya8+Y9eT+1Xhki0Pq5OW/f/Oni3Q9UydrB7ojdXIPUDO5i5wAS+vdVBiDd62fDKZn8geJiRuAt2DSSRr29SqNHCouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmZ1jVrqOjRqClyarmEwyKWdtrRhqDcQqZ2Y7V65UA0=;
 b=DBxMkCZAtfQ17kdEVj1dLa4Yql4ApXzFwLdbo4gA4xSzEiptViT25CwRqlkQFrjWPM9VmhK3h9tRlWr+fa19MmXkt6dOZX4yBVdPExv3Tiw/ao43BShdPxriAQGKCgl1uNIignhZt3YXNFEklhT7Yrq3CeoAuRUAlyINR+jXeVFfafsfNTAmPv11XhG4Qe0DDeydGzoLHTI2qH/rU3ezvfpfM3k3jctiSO+Z334Ag8yi2mstjmXzfRfVGntEPdRcW5ejlrCl86LGBgwd7DaH+E8RSco+e477+Vw81TZY7BTFIssohaL0aocTONNouNXJBpZ5622IDw3NGLUu/3qCQw==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 00:56:50 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::80) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.19 via Frontend
 Transport; Tue, 11 Jul 2023 00:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 00:56:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 17:56:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 17:56:31 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 10 Jul 2023 17:56:30 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests/arm64: fix build failure during the "emit_tests" step
Date:   Mon, 10 Jul 2023 17:56:29 -0700
Message-ID: <20230711005629.2547838-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: f123c314-302b-48d7-737d-08db81a9b593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qcuckRVWXjVrWb4XDzlgE+K8OknJTuIjzvwSWKMYbIRTVGQLbUx/+gzN5wpTGxVbuURfS2to72ZWBiVSDFWmDRUC+PvddPABQJxBefoRl6DM7mo3xo5Hxyw3Jgsw69NGwnFPOMgFtw2Vkz8NawNq+rwml3Cv+icGV26bI7on4mKQuNeXkjsC+ylvfx4kyvxVQg7/dkseqMJy13su5bz98fMK+j2K+BYcpwpu2nPt1Z8IJNhmxOLpEFHJjVeAZBBf4UIb4uEtyLD1Q/J02kcyLSv7OIXZcMYO9MNtIvPOXBW1RFCWfFditkJY3rOyITdJ1Dw51mFjiVrsNzXlyYAVy9ZHMXhVpiXyhcT1Er9HYXK6AJs4XgEKBSFzIPnQXIzYCBSWQTTPmxxGWWbUE8nuU5aHkudIKER3sGdeNdksMfKmgPsMzlFf7Wk7QzHXEVNFxJVIQm0e7HFJtxX23xMQet9ilU4v6iJlvjtQhoVb4+VqW5g2jvFNgeroW6jm3BZ8brbdKgf6vGa4x4KXAOSeABxd3eT0QMtHxikQ3zx9kVjZ+CRimSKvQnC4uYAp2JqX+H7Zxv4p0rg0l72Zig+WZX49dItNeCLRXxWclptkOjAKwA+/7Yr55bIICihldZJLqrLnoKknoa2nTCo2MM4+Tn4Xm6zrvZ2mTT/eO1jzxH/aUkMe+FaVAtDTL0miR2sRfiiX8Hi2tQjtNkubbQoY6HBd0CjmzP8U8L36HoipWnRLMokbTY0mi4s12GN1+7cAwetVKDV145M2NU+2e/ZppHvc7gv7vgvZgYrWIG1yc4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(7696005)(478600001)(1076003)(26005)(186003)(70586007)(966005)(336012)(2906002)(70206006)(82310400005)(41300700001)(6916009)(7636003)(5660300002)(4326008)(316002)(7416002)(8936002)(356005)(82740400003)(8676002)(40460700003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(426003)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 00:56:49.7290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f123c314-302b-48d7-737d-08db81a9b593
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

The build failure reported in [1] occurred because commit 9fc96c7c19df
("selftests: error out if kernel header files are not yet built") added
a new "kernel_header_files" dependency to "all", and that triggered
another, pre-existing problem. Specifically, the arm64 selftests
override the emit_tests target, and that override improperly declares
itself to depend upon the "all" target.

This is a problem because the "emit_tests" target in lib.mk was not
intended to be overridden. emit_tests is a very simple, sequential build
target that was originally invoked from the "install" target, which in
turn, depends upon "all".

That approach worked for years. But with 9fc96c7c19df in place,
emit_tests failed, because it does not set up all of the elaborate
things that "install" does. And that caused the new
"kernel_header_files" target (which depends upon $(KBUILD_OUTPUT) being
correct) to fail.

Some detail: The "all" target is .PHONY. Therefore, each target that
depends on "all" will cause it to be invoked again, and because
dependencies are managed quite loosely in the selftests Makefiles, many
things will run, even "all" is invoked several times in immediate
succession. So this is not a "real" failure, as far as build steps go:
everything gets built, but "all" reports a problem when invoked a second
time from a bad environment.

To fix this, simply remove the unnecessary "all" dependency from the
overridden emit_tests target. The dependency is still effectively
honored, because again, invocation is via "install", which also depends
upon "all".

An alternative approach would be to harden the emit_tests target so that
it can depend upon "all", but that's a lot more complicated and hard to
get right, and doesn't seem worth it, especially given that emit_tests
should probably not be overridden at all.

[1] https://lore.kernel.org/20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org

Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 9460cbe81bcc..ace8b67fb22d 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -42,7 +42,7 @@ run_tests: all
 	done
 
 # Avoid any output on non arm64 on emit_tests
-emit_tests: all
+emit_tests:
 	@for DIR in $(ARM64_SUBTARGETS); do				\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
 		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\

base-commit: d5fe758c21f4770763ae4c05580be239be18947d
-- 
2.41.0

