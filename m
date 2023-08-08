Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BE773DB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjHHQVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjHHQTi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:19:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA59017;
        Tue,  8 Aug 2023 08:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItcnI5DBTAPB8VAZis/ehmQ4ZwwlzoSJujEs9ZTiFXCNWMzgGE1II46Qe8LAcgj+9T8jHXzN2paOBmvpGzj0SBwzERRn1ZWKdMTfnh4tFtN6oF8yHmo3bqKg5+jVx+5ncmm7SoaBSVvQjGCtg9UUZ7vVIoUkhiqXV81gU+MK+yuUoS2cJA4Jgb/nJma76EzC/v024ismbLOs493iLeSTvesrlibvsxqL0TXAOHkKiXDI7toyDXX//EyX5XuHnPaGObXEGdJtpkv+bwYfHC9N0iumwaq8FpuQjurMrU387SgfOhVQJXEV4f3qn3a8s7rODhRWPhwQzY9EFr5hu39THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMx2KKiT3dSFcHX+bBVRXfXt2+3wZCMeid04NohlcJA=;
 b=TN1T+TJSEQAFN+eke79AaaQEoMsz8cB5N99ZIaBxFhRjqrBEhDNW8tWon8W8uaGO6tw6BsuAMhGpoiqqLeY0u2//zcnir4qP9FJ453MiisewJb0n95Ei/9D60O3HoNtYrnmo1GzAHOzFYQ+X762P+MiUVQjfqbwL4B1PV9zkqBCE50LkYbBXEyFU+KlBgACDkpZnR2Q68a9IQINY24Yc9lRfFOnMLVLOaqOhS0aQ6P/6ArkfpJsdkkOHL/bO9+PxCx94cA2Mhn45UUfTGhnhJj5WTKF7y8idMsxEbixAWrYxJrqiIW/5VQichoMCiojBddOpv8i7LEwsMT5v4NZQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMx2KKiT3dSFcHX+bBVRXfXt2+3wZCMeid04NohlcJA=;
 b=49MsYnqQlvKiY4md7dku7Bv1MnQGd7FhlAGXXPje8yRVT5VFSbuYqOk1x/6aKiJzQsEllIvSvfiF/haWq/7qS6byUgnaTsY6btrMItfvTzPZRIJL/8+YjUF34E6q5zBVcdqt9ajPzXyc/RjJLTzkwO4jadwHosfZp2856QBvVvk=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:44:18 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a4) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 12:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.16 via Frontend Transport; Tue, 8 Aug 2023 12:44:18 +0000
Received: from ethanol6a67host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 07:44:16 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <jglisse@redhat.com>, <akpm@linux-foundation.org>,
        <shuah@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bharata@amd.com>,
        <kalpana.shetty@amd.com>, <santosh.shukla@amd.com>,
        Ayush Jain <ayush.jain3@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [PATCH] selftests/mm: FOLL_LONGTERM need to be updated to 0x100
Date:   Tue, 8 Aug 2023 07:43:47 -0500
Message-ID: <20230808124347.79163-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9cbc63-0bf1-401d-37b5-08db980d2e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvEKkzZ44mhvYlxRfXcMiVGbhduYrQEQUzW+TtnYVMY6wUZHLVnYCDBnh20oLfkGYVPjOWFkfo7vlsmScPByPqC+Xb/IYuc71KemLtbnyA/moQwO23ToM/8vagUvEQSFBwOYOetxgSRJBIqzRI9Gy0M4B2rCPLYFPA9A8/6QV2RdI5470hBOhI6YwpJVS7fFc2w8PpaKpQS3GOJDrGpf9fccZYh9qUyeyVYVqiH9nFM0AD8gjsgJlcVBLPHZtVn/vE24oxuu2QeHJw66yGeJCLVICC2xs3l94QoZSUBnTNTLX89fVJ5MwUyf4KPMDqPIsPDJwhCIjyWikE/NwxLr6+nvqwfUVxYQwK/osobko0VmSw8R4RSMJl9HVG++36fAc8FJ/NfHJMUypaB2r8m9N4Jk+bqZ9frTZCjWj2wZokQE7V5u7OZiKMZm8hNntBw/FdoMTWCSP6mOa9FGxNAHs67aLbnMxx7RHzay5xGW9zcNCjJKU2JYbd8oWZG2NUsf1L7oPYubt7jp8FzSX8ZtDXC/SScSsKBu6dXOGfeGgJ5QCjcGuaG7Nx08fUFDM8I5uLUU/MHnP5K4wDZyYpHwRtvwOFZ4Hw8aWEw3sBeLDxHY0gFwddRgfMqgiU6XxRNwcONoNr76zfnBOYyKcCD4rivOjSXQu67XgmMYiNrhkBtOmI6KtnA5E6GbX7PPyv5Q4asb2lru/coWDDcB9qLByAoboILziJrakFbJcRpcFebiv3FebYtKemKFv/B36ZhzPk9vKBUhM9BfUljN1eTTbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(186006)(1800799003)(451199021)(46966006)(36840700001)(40470700004)(426003)(1076003)(26005)(15650500001)(8936002)(2906002)(5660300002)(83380400001)(8676002)(36860700001)(47076005)(41300700001)(16526019)(40460700003)(2616005)(40480700001)(336012)(81166007)(316002)(478600001)(7696005)(356005)(54906003)(70206006)(70586007)(110136005)(82740400003)(6666004)(86362001)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:44:18.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9cbc63-0bf1-401d-37b5-08db980d2e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After commit 2c2241081f7d ("mm/gup: move private gup FOLL_ flags to internal.h")
FOLL_LONGTERM flag value got updated from 0x10000 to 0x100 at
include/linux/mm_types.h.
As hmm.hmm_device_private.hmm_gup_test uses FOLL_LONGTERM
Updating same here as well.

Before this change test goes in an infinite assert loop in
hmm.hmm_device_private.hmm_gup_test
==========================================================
 RUN           hmm.hmm_device_private.hmm_gup_test ...
hmm-tests.c:1962:hmm_gup_test:Expected HMM_DMIRROR_PROT_WRITE..
..(2) == m[2] (34)
hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
...
==========================================================

 Call Trace:
 <TASK>
 ? sched_clock+0xd/0x20
 ? __lock_acquire.constprop.0+0x120/0x6c0
 ? ktime_get+0x2c/0xd0
 ? sched_clock+0xd/0x20
 ? local_clock+0x12/0xd0
 ? lock_release+0x26e/0x3b0
 pin_user_pages_fast+0x4c/0x70
 gup_test_ioctl+0x4ff/0xbb0
 ? gup_test_ioctl+0x68c/0xbb0
 __x64_sys_ioctl+0x99/0xd0
 do_syscall_64+0x60/0x90
 ? syscall_exit_to_user_mode+0x2a/0x50
 ? do_syscall_64+0x6d/0x90
 ? syscall_exit_to_user_mode+0x2a/0x50
 ? do_syscall_64+0x6d/0x90
 ? irqentry_exit_to_user_mode+0xd/0x20
 ? irqentry_exit+0x3f/0x50
 ? exc_page_fault+0x96/0x200
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f6aaa31aaff

After this change test is able to pass successfully.

Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 4adaad1b822f..20294553a5dd 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -57,9 +57,14 @@ enum {
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
 /* Just the flags we need, copied from mm.h: */
+
+#ifndef FOLL_WRITE
 #define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
+#endif
 
+#ifndef FOLL_LONGTERM
+#define FOLL_LONGTERM   0x100 /* mapping lifetime is indefinite */
+#endif
 FIXTURE(hmm)
 {
 	int		fd;
-- 
2.39.3

