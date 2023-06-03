Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E7720D3D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjFCCQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjFCCQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCA0E58;
        Fri,  2 Jun 2023 19:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1SzSZX5sfdi8n+rRRJLOjrhDH0c5LsshUSc3SYgZ3bHJeg/G1GeQwAnfgWEaZPfazwMDadrQUROeCFNgxVWklqYZIqng2Qq11JwKe595/YYibxUt6A+h0sho2whBg5Hrjo9eGe72oXglB+lP3J6/F4Ek0EQyQdTPzimF8ngCzm2hqRk0pl9yP2JWOe3vcpaSz0NIucN6Yf1B++ZUUObhhmCUhMNJk8nvRYP2G6UKPx77KuQQqYtNy/OJgZFj7XCty+RCP0QSS2uFZJum9P7TswPtgMZuwTCYiONMmaBwlnCSfh678taCBX1Px/pYorvGj3tJrjZVua45RLJ+A6T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU6vV/sOpPEMMFpfhHsw3NPBeeRzKVMoxxxvmeZx6Tw=;
 b=D4N/T26p3jh6MKzX1D9cSs10+ycsjZJPrezsT0Z7smgfVQg4Tujl6IxfpKzYqCxe2gUA9ozwS421YMLovLjWooFg4qo4YfOQaHWtVRk7gNx0+WuXJ3K1qIf3SmgZ5WmO9k8HdG1MXve2TVSkmvOvvnGv8vaI5t6tk9cKoxSPayVzyh+5s0MxeJqxQVniO1i/02I5qMQ15VxVE+qSkqDWPR6RmwT8kpW8GPMjC9uPXq/HGYrWmkappS2z2gPpSeHbkMfU1Cry9TFjSCU22YWQJ3lNEnt7DoEEINm7qY9o0AaJsvPmq8xwyersHwbzE0lj/MBseBPXY5hkQi0JxNeWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU6vV/sOpPEMMFpfhHsw3NPBeeRzKVMoxxxvmeZx6Tw=;
 b=Y7yTiF/RPSSgZTzfD43O0Qg+zOeElK4MuXtBkqywR0tfiscDG6EDB2rVuN249LEbj/xri4KbBBWWB2w0Xl04UUoPYFdpIGMD9hWbr/hjY1mlHkOIPjuS9cvQMGn+n4M65VSwBEg2crNwosxe+hVmVVKjYkOAqX4lz4Wx7GaGEh4yagD6FPhLRPdTvvlzHeUGEIl/kj31sVXs7CxqVO47cjbVHyozAZS61C9NzX4Af7jU7pDTB0A1oMApKl0WAt0Yh7iO+CJyjnCV6hCNgGJIYPTj5qmfNpqxi16PFq6QmiipxAQIWWyT6TjVtoGZK5xBkRihaXl92lOl32Hsjce1yQ==
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 02:16:19 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::fb) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:05 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 00/11] A minor flurry of selftest/mm fixes
Date:   Fri, 2 Jun 2023 19:15:47 -0700
Message-ID: <20230603021558.95299-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: e394d163-831c-41b8-c725-08db63d88470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nh9AwJYEV6c2+4flDpr4l0g4dRs7cMXrYfVpvV1Cpx8v+2Do4AbyubIMmt8iceem2YDFWz0y0OXuDPhxeElrwPRpCs+7gIZcmHFqa7zHQGgbwRBAMUWrJgK0nLfpJ+kx9/83QPjo1MaqCoN8fB2Ertyd9l3K3tdoBtrhFOqMLJrqZOpMDe1JZLu07gaPhQR2gxXdDGIBgLph78YNNQYhbL/ju+s0jKDX0tsQTmDvEfTnI/4Wfvah3HgyN9MRxZ/Ty8a4auzJxd7SLf4AQWiM6pl+zv2f/ALQkCXuCRatRuKz+7NMBKYWpOmpdvcqgASaudSABogsd1qpPQBj1crUVU6HWqKmRQY6jefGGn0VB11nPPrVzgbrykk0GQPN3ZE3LL9qIwLR7emMgvBcloTRdF4B59RC07FHNtCjKIckBzeog67P9T28d1joYkTF9yIJKLt51nmk7MPR+fFqB4/LYK4a5FWVB5LSnIkUdpwelkwOvQqvGmR/1KtJCFvOSbMJNlI94krbDqL/lcOT8vWNbhF2lkbD/1k5xN36tnquR4MpqICtCzjUfbac5Zx25u9+NZ56N4ctWQ8n7mUGOOTzKIFuiiXyKtUYTXFBZr2uphCRLwLNBuQ9ZepNUVA0KyVNnbxZffY03lH8yYKH0zggCuvivVBU0uqHjQJs6FzOBOgI13b9pGmt0todkAB+vVoZrd1I9wLEK2s1pIhqgug69vpueN3I4BY+VZ2UGj/hVqJBdwrXWwjgmGdo6SJTIQ/sIB6/xisTaOFk3XzHDr1Tuvo0tZi0pFhRKmHS/PUic4Q=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(316002)(41300700001)(2906002)(4326008)(70206006)(70586007)(6916009)(966005)(54906003)(6666004)(7696005)(426003)(26005)(1076003)(336012)(186003)(36756003)(107886003)(2616005)(47076005)(83380400001)(36860700001)(7636003)(356005)(478600001)(82310400005)(40460700003)(82740400003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:18.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e394d163-831c-41b8-c725-08db63d88470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This is v2 of a series that fixes up build errors and warnings for at
least the 64-bit builds on x86 with clang.

There are lots of changes since v1 [1], thanks to reviews from Peter Xu, David
Hildenbrand, and Muhammad Usama Anjum. These include:

* Using "make headers", and documenting that prerequisite as well.
* Better ways to avoid clang's Wformat-security warnings
* Added Cc's, ack-by's, reviewed-by's.
* Updated commit log messages.

The series also includes an optional "improvement" of moving some uffd
code into uffd-common.[ch], which is proving to be somewhat
controversial, and so if that doesn't get resolved, then patches 9 and
10 may just get dropped. They are not required in order to get a clean
build, now that "make headers" is happening.

[1]: https://lore.kernel.org/all/20230602013358.900637-1-jhubbard@nvidia.com/

thanks,

John Hubbard
NVIDIA

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
  selftests/mm: fix uffd-unit-tests.c build failure due to missing
    MADV_COLLAPSE
  selftests/mm: move psize(), pshift() into vm_utils.c
  selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
  Documentation: kselftest: "make headers" is a prerequisite

 Documentation/dev-tools/kselftest.rst         |   1 +
 tools/testing/selftests/mm/.gitignore         |   2 +
 tools/testing/selftests/mm/Makefile           |   7 +-
 tools/testing/selftests/mm/cow.c              |   7 --
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |   8 +-
 tools/testing/selftests/mm/khugepaged.c       |  10 --
 .../selftests/mm/ksm_functional_tests.c       |   2 +-
 tools/testing/selftests/mm/migration.c        |   5 +-
 tools/testing/selftests/mm/mlock2-tests.c     |   1 -
 tools/testing/selftests/mm/pkey-x86.h         |   2 +-
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +-
 tools/testing/selftests/mm/uffd-common.c      | 105 +++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h      |  12 +-
 tools/testing/selftests/mm/uffd-stress.c      |  10 --
 tools/testing/selftests/mm/uffd-unit-tests.c  |  16 +--
 tools/testing/selftests/mm/vm_util.c          | 106 ++----------------
 tools/testing/selftests/mm/vm_util.h          |  36 ++----
 18 files changed, 165 insertions(+), 173 deletions(-)


base-commit: 929ed21dfdb6ee94391db51c9eedb63314ef6847
-- 
2.40.1

