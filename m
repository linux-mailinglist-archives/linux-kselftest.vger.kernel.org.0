Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C87238AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjFFHR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjFFHRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDE118;
        Tue,  6 Jun 2023 00:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXx53W0o4Lq3+4VjOXb1QILah/EfGSeI8zj1i3gMUBzmwtTyKbHkJMNCvJFaDnr3epRg743Ywq5jV/XOSblLpQqbKHwBlQcVZ2gjU2tjx8Qg6Z9EniU2rfUJNsq7++JR7h7AwucjTGTP0EIXTCm1JzFlTB5bRpD7ZeeLqmrUycMIue/bTDHljqKcIAiHxK0Lxjcqip+xCHvWnMpcWhwn8GH5G6VRSLbWo8LkO0NYGVdPCUmZGp1lE53QNYAoKajeTu2c6tySf2PFdBxz0D6zNLNqxx57FgcPpCn2dVW92pxuG58saq9p7hLBWHfgJ9cm9f+ZN7zCWL+h5GI4nxOFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=750xl2b8VCEes6MI8uBXpo1owZW+d9ejl8ZE8sO7MgY=;
 b=S7+9hDQqnde8b38Pq91m1ZdjsQM/VCaSQapS1EgKJSALsNTuxtK79P9nkGaizjghGWTYlQEXnrfYZW98JyWfiTTI4m2JplcBkecf0MaiWjorm0zOIhD9LwEZSVZjlCB9VuRHgA2soLuba+Q/yN3YnCL0n+db6oPbbSOgfMqghvwTPGRKSMsNcix0gZ5H2jHvyUhyEViz2XlJXAcwD/VakS+6Len3X9aM3SLcXwkqfRZtaW8mTxNrX7mWBGFd2e0W8M8v3J2o2ZpusRvtW2EwBdxwx4easRZV400fz74Om/K0B1SD003hzELYfuU2oJFnHPcdLfQMEEh38VCRkVhTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=750xl2b8VCEes6MI8uBXpo1owZW+d9ejl8ZE8sO7MgY=;
 b=IGoRIO2PhylHQKeiUaFxRGVkgbFgHdy8rlD/mf2qV+8eHDIflT7mlPk6rqr1YRMXm7GNeRiiKnC4cEqPKYxL5UYLsXLE5+v9MgAd3MV5r4Z1n7ZXfiSOkIASYKhV5hCtxtd3S5DQxlyHTNqW3Y27bVBUelE3QL/ELbS+yqwCjs8jlym865Xm6ENRXeHrzCAU5RvVmQjhiYbKeOFwvTIpEy6yRo8n9doi5LBmNduqewQtIHybG0JaI/q6Zr8A5MpBpfgjjcl0cbAQY/wakHMJPb/q+O7ClvQ0FwTfmAfwZ78aKmGOHmcYwY28OLTXc++1AacY43lsHqrkwUBB3+lCcQ==
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 07:17:21 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::6b) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 07:17:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:08 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:07 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 00/11] A minor flurry of selftest/mm fixes
Date:   Tue, 6 Jun 2023 00:16:26 -0700
Message-ID: <20230606071637.267103-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbb02d4-438f-4a2b-3fa3-08db665e11e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZAIhDIThkYPEgJvlolT/0ibKxcDkDAaDOtdmow8nppV4JGiYdYoQvdaRrMUwtqbj7h69IZDh9/ZgzzvHlx67HEoMxqecLFG6DX6elGReYEtk5OS2REM40+qkkFnR/lijb1gIpbYQC9KFlRh7gW7MGRqJYPXjo6igqmT4k0inzfXannmDqUDcb+DmR32MEaICypIjBsKU3nOhwGIrXDgNhMoqpA6akXHhUO1RFhRs/zB0E9N6xwg60wsg4xjMeMOGTRU9wLU8DwKtUC6em6HIY97NkgeFmTr6qK++5nRZaMwffKuumJ2mftTWnJ2AB8FxTiDY7His5pVfB9HjzVdKuiSYkYvgiGmxzsznEbL9yrGvontlyBW358zOFRCIPh9tQmEldiTkabv5SEArVMPRDm1PkoF10waLpDsB+HNIXCSyR59QA3dz3t7agm5Y8L/TpSdRSGsG5kJJDO2T82gVRXjhqrVDNqSlf+AFFZC//7c03cz9TDYS0Z2pHHM+2gSssoztieDmcpVtvdHHmbfYGY4nU62s4FbOybnmnTqlwLUmimRWRpd3DE/hhySq9uz4wrM2dQiS5iqpOxEFZ2KS6MhHbXb289kYsejQLliyHd/177Rq0AGTLiG/B9y/A2DtIK+I7Z0AoOPClHYem5jh2IHZSPrEmYL9Sg878D/SqKea6x/1g42Hn3hOg7Yukxz8xWt0sQEug26IbbM8vtvL1xEbqFEu1dK7CkncZ6kDs22RN3sh4ThFmR4c/h8Ecn8GiLu3CZA3AN8mE/5jCFlLPmp/a0ZwSIqkD5tPsy/Zbg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(83380400001)(40480700001)(86362001)(356005)(40460700003)(82310400005)(82740400003)(7636003)(478600001)(54906003)(41300700001)(6666004)(7696005)(966005)(8676002)(8936002)(70206006)(5660300002)(70586007)(4326008)(6916009)(316002)(2906002)(2616005)(1076003)(26005)(426003)(336012)(107886003)(36756003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:21.4977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbb02d4-438f-4a2b-3fa3-08db665e11e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Changes since v2 [1]:

* Added a new patch (sent separately earlier) at the end, to error out
  if "make headers" has not yet been run.

* Reworked and simplified the uffd movement patch. Now it only moves
  some uffd*() routines, not all, and doesn't have to touch the Makefile
  at all. This lighter touch also allowed me to drop the "move psize(),
  pshift() into vm_utils.c" entirely. I expect Peter Xu will be a little
  happier with this new approach.

* Fixed the commit description for the MADV_COLLAPSE patch.

* Added more Reviewed-by tags from David Hildenbrand and Peter Xu.

[1] https://lore.kernel.org/all/20230603021558.95299-1-jhubbard@nvidia.com/

John Hubbard (11):
  selftests/mm: fix uffd-stress unused function warning
  selftests/mm: fix unused variable warnings in hugetlb-madvise.c,
    migration.c
  selftests/mm: fix "warning: expression which evaluates to zero..." in
    mlock2-tests.c
  selftests/mm: fix invocation of tests that are run via shell scripts
  selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
  selftests/mm: fix two -Wformat-security warnings in uffd builds
  selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
  selftests/mm: fix build failures due to missing MADV_COLLAPSE
  selftests/mm: move certain uffd*() routines from vm_util.c to
    uffd-common.c
  Documentation: kselftest: "make headers" is a prerequisite
  selftests: error out if kernel header files are not yet built

 Documentation/dev-tools/kselftest.rst        |  1 +
 tools/testing/selftests/lib.mk               | 36 +++++++++++-
 tools/testing/selftests/mm/.gitignore        |  2 +
 tools/testing/selftests/mm/cow.c             |  7 ---
 tools/testing/selftests/mm/hugetlb-madvise.c |  8 ++-
 tools/testing/selftests/mm/khugepaged.c      | 10 ----
 tools/testing/selftests/mm/migration.c       |  5 +-
 tools/testing/selftests/mm/mlock2-tests.c    |  1 -
 tools/testing/selftests/mm/pkey-x86.h        |  2 +-
 tools/testing/selftests/mm/run_vmtests.sh    |  6 +-
 tools/testing/selftests/mm/uffd-common.c     | 59 ++++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h     |  5 ++
 tools/testing/selftests/mm/uffd-stress.c     | 10 ----
 tools/testing/selftests/mm/uffd-unit-tests.c | 16 ++----
 tools/testing/selftests/mm/vm_util.c         | 59 --------------------
 tools/testing/selftests/mm/vm_util.h         | 14 +++--
 16 files changed, 130 insertions(+), 111 deletions(-)


base-commit: f8dba31b0a826e691949cd4fdfa5c30defaac8c5
-- 
2.40.1

