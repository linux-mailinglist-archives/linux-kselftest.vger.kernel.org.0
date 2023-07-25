Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3A7624F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGYV4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGYV4D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:56:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27D1FEC;
        Tue, 25 Jul 2023 14:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKq96B4/MyF9kFDoV3FHYm1q2+qtj+9TPoZcWPoHcH8Kl45MQxfqR75pO+J22znut5yJkddnAMoZr/8RcRtaV3mAC3bYQspFX1rJj6XQwWlT7KfmJW+i8KOHu5PZHnmu9qQUy0jivYKxpRkyXibqtCwXimj4jLCItQKUIf5Au0C0eE4TVP6MCUW5njLsUOYDTjVUJpbXhQdgBL++1ca4Oj2UP11Sy6JUTNa4LS8pQs0OkDuHqLkQALBfwZW2R1k4wkWeKfxQ+oSh85XrOeQbf9Cb94GMV6ZuJVQeP/brND637zXtSvS9YnxNzYsXaiTEasd8fGEo2nhqYduEFCiDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hXrN1f1Vz1OSeEL8lNXKDNjQ45MdrrTgSD/OnpAYHc=;
 b=ix5gRs9QDn6N4SSiMwsEdfXB6uuXCzrcf4Sf3L8ZW+yvwmmyoRPDQAGRRnmmQdNS+Gmy4RJ39Bept44G7Ox8654gLLtpe8qOE3l53AK9n15Qouy+U5xt9pxGFBnZM8/IOtUsHmBOJFuVKk8AZrQImuTQvje8yQm1F0a6qvGrZL46sa/Eu8mR9aFXWPSpCtgyrRJ0vjCbzaZYV2c1KE4fqG77/3euVcrrnumOuBhYJXogleE4HeuLE308R0F5BOauzPQXH+5o26QFgXLDQ6m/OWHs169yk5SiWO41JLtnH/xRq++s7HqLYv2vZq1y4Y1VMWfAnemdHwOCgErlgAlyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hXrN1f1Vz1OSeEL8lNXKDNjQ45MdrrTgSD/OnpAYHc=;
 b=RBGEqCavhLd6bNraVVi+L0piUubIrKTo4XRya91I4I4ElsVL9rEHM8mSL93FwOuyMLo0ZkEOpFr+na7AkHvR3OKJEuXjx/GiuVwAC3qROiR188Al1aa3Ui2PiMTCM9RnerJExupJIjoFgiSIwMixKW1tk7I7vQZ9SrxNZ59I4JU=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 21:56:00 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ca) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 21:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 21:55:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:55:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 14:55:58 -0700
Received: from XCB-AMAFTEI-L1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 16:55:57 -0500
From:   Alex Maftei <alex.maftei@amd.com>
To:     <richardcochran@gmail.com>, <shuah@kernel.org>,
        <rrameshbabu@nvidia.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     Alex Maftei <alex.maftei@amd.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] selftests/ptp: Add support for new timestamp IOCTLs
Date:   Tue, 25 Jul 2023 22:53:32 +0100
Message-ID: <cover.1690321709.git.alex.maftei@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d3b26b-9e25-483a-e944-08db8d59eea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KRlNkTQ5FW3LiJmV5EeBn/BCZ7p1v6p2OI0v8aFCaRjozsWPRXlJZXM4O307LWDKp3ZSVaKpGNT8TKOIhqEyDyHa8V9A2jVNHMNGAalonXWcjLK2mHKQO+mHsaXigIrbyceK/XhkPSAxH/6CxDaGgVxnym72ggtkX3XDmJLYqIegpjoVd3YhagRwjTpyjVOuchjDSYyqvxRtIENu+OBbJygdjH7OW5xJEH47x+w3xUFyvSaYQJoSqcfh1JclctRlhGlJgV0nEfvTdalp5asbPLBNhR9+/MYQVSZbyFsEyLJ+oWslv6oyFL5skqBom1V/GHvgDiHXg0/EMZY5IpDE37/7zaiqeyXs/JgTthak0GIhWmr6tCRNWn/miZlJ1pQvGu2jvzanqRq0TNj56s+SD3tN8YQ3I8btNX0VWCgLz6ZtScVkfaNs4UIU36O4S0MG81cv2bpVlbaKUoYaMmDYZPbP/zKWJCz5z5lZU68laNnTKl0KHVmUg4uCL2JaWBYPgSqIl5HDY2S1RPT1UI3ovJV3Cn5v7oq/Ou37iN23d7EY6KCHFkOaogPEgr/QxMoxegSBD7TPQ0byqB2DdpBtbPnSRNt96SnxL7Ozz/G4J6Fh0v0n0zhwidrV8apkOzsnB0drUGIbo2T3qRmupZoPtd2E9PCTJXlCupIARmE3+iGjjUSymkJ4wvvqkHvBIiaI98saRL/CL1PZ21YjJFz9gALGqQmu/hQgIKyPJqAw1pnRGCXCunLLEVKWDvHKRk9ZCODpuczJw8GdAwgdDOpCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(26005)(186003)(2906002)(336012)(4744005)(86362001)(82740400003)(8936002)(36756003)(8676002)(54906003)(110136005)(478600001)(6666004)(7696005)(36860700001)(356005)(5660300002)(81166007)(4326008)(41300700001)(40460700003)(70586007)(70206006)(44832011)(47076005)(426003)(2616005)(40480700001)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:55:59.6951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d3b26b-9e25-483a-e944-08db8d59eea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PTP_SYS_OFFSET_EXTENDED was added in November 2018 in
361800876f80 (" ptp: add PTP_SYS_OFFSET_EXTENDED ioctl")
and PTP_SYS_OFFSET_PRECISE was added in February 2016 in
719f1aa4a671 ("ptp: Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping")

The PTP selftest code is lacking support for these two IOCTLS.
This short series of patches adds support for them.

Changes in v2:
- Fixed rebase issues (v1 somehow ended up with patch 1 being from the
  first manual split of my changes and patch 2 being from rebase 2 out
  of 3)
- Rebased on top of net-next

Alex Maftei (2):
  selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
  selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE

 tools/testing/selftests/ptp/testptp.c | 73 ++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

-- 
2.25.1

