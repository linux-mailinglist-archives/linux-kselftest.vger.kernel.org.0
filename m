Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAF71F7F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjFBBej (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjFBBei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9ABA3;
        Thu,  1 Jun 2023 18:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdmsTIp3Ku5wkXCp4u67CQWEpdWlL/Sfkf8fGnSiYFaSkT0Fp7AFKTaXd/qUA+sMGTquzEGb8hlw4GyHA4LlU2BnoVBi0pMJvTaAtTM86cSTAPhs/CfnFSzsBKLiOYtE0HkMC2OqFXR8HnfSK55mvu0UGdraEGoRLNi3AsQo0AwZHZ0gsp9oRRmWDLXt5lYzzYZhKgYtFxFCwbdc2qdSFSAm92tLJU5zzFKSJFPWrOYbDnoKCGTf9pLcu7VZK1mGUtnp5ESVTKsamIyI7x48Ne/fHdexJPf50kP1liFGKgDzzSJiomA/59/cI6rRH1Q2/3+0pBL7SZLtobJ3EGX0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lZdK6mHi132tX56t9d+h5LPuubpgXyUrXIdYaIKPWE=;
 b=eAjKxAtYckykzvU+Pqz0tdb1rcDcP7a8vuP262aAlyX3kyKR+fBL++rUI3E9AX13LDnG5V8WARQUkWYez/bVXYEHmHtjfcIghnNF5CPkXMEEbgagur+c64hgRBnxP9/MBf+PideIbPpnR68AEYQbCtT1qEG3IKmc8Sp6BUJ+6NNG5uDDsLIcwidTuHyPLp7tguCACT2IMMUSKvYl3KW02bZV3TJq27oErP2ZKb3e6QI2OmELsCm8EoIPmusUFJRg3Jd4X/QRdbqFaSCVBI6FBXAu5T7NfKnV6L0OOZ03tl8NgtjJzjmOYb4rfZITVG3RbbzF3bmkxtVIqVgpP8E8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lZdK6mHi132tX56t9d+h5LPuubpgXyUrXIdYaIKPWE=;
 b=Y+M4updFW56XsjX7kO7loC9m6lhBmN7SYB2aKnXgx/k8XeUowARqIdNT+SZOMNRvQ+wUYELNnRN2hs0j/EfRnBRDZx9Wyvs/Zn0MluUwDvwall1yLnOmeyetyFRxFWYQ8L61wAknShXqTPiwZxRbpE4OY+37DKeBCpf/SvDzjXz9Mp/b29oG1dhK8VxIvEvAoQJZ1nFEngo4iqOesJ/C+6lv/L71tvDgTc5U8QmVSTTwJlJkZHU6abjJ0rVezKTG0bZ1fPOmGdJVmX5rzq7wrIUi2Ml8Wevu1WYm9ndP6cMCKeC3SWw8kuPbsdNL2LX4yke/FSegbbYJarNMYeSSqQ==
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 01:34:35 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::ef) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 01:34:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:19 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:19 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 00/12] A minor flurry of selftest/mm fixes
Date:   Thu, 1 Jun 2023 18:33:46 -0700
Message-ID: <20230602013358.900637-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: a93b5ab9-d267-4c5d-038e-08db63098598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gAvPqerot5zxwCJotiLzxj/9taVF27PmnD8Ys5vg0R/L8FXVsAvdmKyvmTsbWOH35st8FK9Ivx6Q+8AjJQsJrmALz0t2nowtETFFN96N459fizTmy278IOOIWmxDkpjtfZSZJ7i78zxJ4wOvzN3liys+otMAAxVBE45VGkfzVQz1vFUZW6y9I2Z4UHrqvEJrLKv3r47RMpoET+Eb/q9qBHAUE4KAvhJUzB9X01esEi7UEkMcHqbEvDuYNOqCKbqORFf6GIB4gjflaiUvSFOeHP/DNeSdNjNpoX/gJp9ARvU1FdOPgjn0c/RGqqm5cWCXv/aT94R/PRjqIUrT1GXRHDQDgMUrUkAosFlqE4u+KxtXiefs2J1JdCUQ3RwHfXMoQb57Igng6Fb5uCw8rsBkYi6mPmrACI9eMU7AiK+SkE7NtETcsly5AsS45PTAGLbN/VrvqA0HNaNEVLed0v9n/oESY6cC8ZtEmPxSpfyEurGuBBriXMKYECBUrW+t2Dw1SePW+U15sJGDgtmOBCFYEuhUVSIoN3GxjMGhIjGlmXKg2vB1UAdWn8Ky0Ob4dbsNOrM62aDBBpPYC4Zj+O1vBV0ZF28Cg+SB9LrFO3FQIEME8q7/TW+KkM9TfDstnxuAdI1GFzqz1i05hH0yOK2kkjAFghdmZoRMDPCgSOaf3Eoz7ZGIJfd9lXj6zKNwUHNt/Xy7q67zyrTRHHIHWndimAElaGzd6Ez8gxWkoHJYCpvOI9z2eOQC2uf0HUoiS0i
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(83380400001)(40480700001)(336012)(426003)(47076005)(82740400003)(7636003)(4326008)(356005)(36756003)(41300700001)(316002)(7696005)(6666004)(1076003)(26005)(6916009)(107886003)(70206006)(70586007)(2906002)(8936002)(8676002)(5660300002)(40460700003)(2616005)(54906003)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:34.8838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93b5ab9-d267-4c5d-038e-08db63098598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
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

It turned out that an even dozen patches were required in order to get the
selftests building cleanly, and all running, once again. I made it worse on
myself by insisting on using clang, which seems to uncover a few more warnings
than gcc these days.

So I still haven't gotten to my original goal of running a new HMM test that
Alistair handed me (it's not here yet), but at least this fixes everything I ran
into just now.

John Hubbard (12):
  selftests/mm: fix uffd-stress unused function warning
  selftests/mm: fix unused variable warning in hugetlb-madvise.c
  selftests/mm: fix unused variable warning in migration.c
  selftests/mm: fix a char* assignment in mlock2-tests.c
  selftests/mm: fix invocation of tests that are run via shell scripts
  selftests/mm: .gitignore: add mkdirty, va_high_addr_switch
  selftests/mm: set -Wno-format-security to avoid uffd build warnings
  selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
  selftests/mm: move psize(), pshift() into vm_utils.c
  selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
  selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP and similar build
    failures
  selftests/mm: fix uffd-unit-tests.c build failure due to missing
    MADV_COLLAPSE

 tools/testing/selftests/mm/.gitignore         |   2 +
 tools/testing/selftests/mm/Makefile           |   9 +-
 tools/testing/selftests/mm/cow.c              |   7 --
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |   2 +-
 tools/testing/selftests/mm/khugepaged.c       |  10 --
 .../selftests/mm/ksm_functional_tests.c       |   2 +-
 tools/testing/selftests/mm/migration.c        |   2 +-
 tools/testing/selftests/mm/mlock2-tests.c     |   2 +-
 tools/testing/selftests/mm/pkey-x86.h         |   2 +-
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +-
 tools/testing/selftests/mm/uffd-common.c      | 105 +++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h      |  29 ++++-
 tools/testing/selftests/mm/uffd-stress.c      |  10 --
 tools/testing/selftests/mm/vm_util.c          | 106 ++----------------
 tools/testing/selftests/mm/vm_util.h          |  36 ++----
 16 files changed, 170 insertions(+), 162 deletions(-)


base-commit: 929ed21dfdb6ee94391db51c9eedb63314ef6847
-- 
2.40.1

