Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68567BD807
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjJIKHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346102AbjJIKHK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5C101;
        Mon,  9 Oct 2023 03:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVadqHtty/Bjsaybik7fXGrzxwJBbLGlrqjeS/WSjbKpLq9JVMJWpl32xbmincXlbjyHuhwHkERsUmaM1GLU1WqeK2U256ssuaA54kRzRN3YfEZiEkQY3ofmiXA6cCMfmlI8FWAJwkbWpBueHgVfreQMtJ37ZHWGccYV7zBZB4LVHP8aSgRc9HRdC5dlVIhpAE6kYGnnq3DnyemOqzmiDdrCXyzIzAfHqVAeHSQxvL3O/8xM4uOnq6PlqZQNpWlF8xfiee1dkh/pHlalYbVxicR6HsvhPc6CozOTdc+HOnlBigg5K3lcQNVdHFVflt0FzwPO7jtBrgmzqBuTWTHorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgU32kMQJx+V3Xklh3fbskuhi5Xd+GA4Kqhc5xoDvuM=;
 b=U+DD0XjBbKZbDA2TyifDyKIOwKX2yFx6CbxAi0LkrUWdhb2np4AbrjOp0AuyGrNTH05C/Pi/3lf0/4LPwi6diNa861dDgZmCjcarM3FdB+raIQdQFNiA38VlLz+2XH1InO6FmUvTLeDyPwyMPnK41MYXOFvwWv0GAk/GqQwPwJviYf5FuBqefp8dYtJgsJ5wowsQ8XBvftHfsvwfGt5PoN5s6MCwdprBITsVCMrvrsKjrWFrRjbF94AilY8ATUJYZFYjbIf9HO+8Bhs1rA/aLsrX5YVxDWWFlfxkkTqMhB57pw54oAFDevuegk2qhT8z3Ys/yi3zDoHcY1bt1Iroxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgU32kMQJx+V3Xklh3fbskuhi5Xd+GA4Kqhc5xoDvuM=;
 b=J30yKq1y2v7cBEwxKY15KNaDVQI0WCtWrV+8c0RP+wKYl8bdecZh7dERZ86io41gSnOqGclJKhYKcE5xCKOWAnS4JANdUHJwcXQa/OzwYECNsvLVJrVM+IDo9S5fmXraipCVqToiLNtvjZ/TiXnTzPcFNhsN86hklvXur6qUqyndTKBWviNul1U5ECRsYJaDhSujYlQqnoOn2I44UxPsQ7UhT6DA2PoGsUFI9I81d0S0TV9ClXOyuBGwZqi6rugjAlYnDECEM9yHlecQq5KJ7+XEb2dXFPnnBtEJmB24RRNOzZLaINc9aZOeefWqavOp2c8GISE5J682ijJZXuwt8g==
Received: from SJ0PR05CA0182.namprd05.prod.outlook.com (2603:10b6:a03:330::7)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 10:07:06 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::d4) by SJ0PR05CA0182.outlook.office365.com
 (2603:10b6:a03:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.15 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:07:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:51 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:47 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>
Subject: [PATCH net-next 00/11] Extend VXLAN driver to support FDB flushing
Date:   Mon, 9 Oct 2023 13:06:07 +0300
Message-ID: <20231009100618.2911374-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c76b04-f939-4e9f-6dc2-08dbc8af7df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKkz3jnJYziJQys2mg4pOkdZmUXwCnirakjGx6aqGiSyVgn/WWKWRRcpVQxXo/eXl8qxCl9d3SNbKtlhsCMqYdVHtVaXoCJrAIT7I8vnoTqCIYnv4S5yEDvJsmdi/jDRn+Sn5yY1TtIpIJCy1490w08nLFCwjESkuyjsOBdHlEgDf5xQcZvJPdKwm639R4mjXFGxCS/MUJZV6MFAWvaij8L4bDTI4TiAW6tmOMuQo9s4ff6L7iRRtjh9lohptanbCR/pyx8MLjltQIu5ubYZotRKe5yavJpcqWmIqp8ckYGhE3Sjg/Pl38oka/BVfypJ6pWywK9bNnA4WK4p3nfapMah0/CyPYyY1TdRZ585PyOd3W7+s3kbzqUF3ev9jF9qS+iCjAVd/hglrdZFJnXxct0LoYsJQEqtP1eSCqUXYpQZVV936Sva6XslhfGcrD4enCKR1cICUmFlo9e8hDi37HAnM1DSvlsUrHIGrDcovygw/sNdRaX3n7c5g42je6Jv2AXInyLVjAjHXBJeQU/jTzprYOHa5XR5Sn8nEtv7b1XVb+ClKUhQomeK9Wk3JgDGSTX9/p6mUm5PniHMrZxzFkCRms9I2WUOVzIyYbgBMDv1JA5+cmnBoOdEnj5mSn4OBOMs4BFKA1lyF3lLi3XOVGStERDkwk/bvKPAfdD5fax3+FWFAUnG0jsGuoaIqC2qfzBZ+1wWv9/kRIp5rlGRcw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(2616005)(1076003)(426003)(26005)(336012)(16526019)(40480700001)(36756003)(86362001)(82740400003)(356005)(7636003)(107886003)(83380400001)(8676002)(4326008)(2906002)(478600001)(6666004)(47076005)(36860700001)(66574015)(8936002)(41300700001)(5660300002)(6916009)(316002)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:06.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c76b04-f939-4e9f-6dc2-08dbc8af7df3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
support for FDB flushing in bridge driver. Extend VXLAN driver to support
FDB flushing also. Add support for filtering by fields which are relevant
for VXLAN FDBs:
* Source VNI
* Nexthop ID
* 'router' flag
* Destination VNI
* Destination Port
* Destination IP

Without this set, flush for VXLAN device fails:
$ bridge fdb flush dev vx10
RTNETLINK answers: Operation not supported

With this set, such flush works with the relevant arguments, for example:
$ bridge fdb flush dev vx10 vni 5000 dst 193.2.2.1
< flush all vx10 entries with VNI 5000 and destination IP 193.2.2.1>

Some preparations are required, handle them before adding flushing support
in VXLAN driver. See more details in commit messages.

Patch set overview:
Patch #1 prepares flush policy to be used by VXLAN driver
Patches #2-#3 are preparations in VXLAN driver
Patch #4 adds an initial support for flushing in VXLAN driver
Patches #5-#9 add support for filtering by several attributes
Patch #10 adds a test for FDB flush with VXLAN
Patch #11 extends the test to check FDB flush with bridge

Amit Cohen (11):
  net: Handle bulk delete policy in bridge driver
  vxlan: vxlan_core: Make vxlan_flush() more generic for future use
  vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by
    default
  vxlan: vxlan_core: Add support for FDB flush
  vxlan: vxlan_core: Support FDB flushing by source VNI
  vxlan: vxlan_core: Support FDB flushing by nexthop ID
  vxlan: vxlan_core: Support FDB flushing by destination VNI
  vxlan: vxlan_core: Support FDB flushing by destination port
  vxlan: vxlan_core: Support FDB flushing by destination IP
  selftests: Add test cases for FDB flush with VXLAN device
  selftests: fdb_flush: Add test cases for FDB flush with bridge device

 drivers/net/vxlan/vxlan_core.c           | 207 +++++-
 include/linux/netdevice.h                |   8 +-
 net/bridge/br_fdb.c                      |  29 +-
 net/bridge/br_private.h                  |   3 +-
 net/core/rtnetlink.c                     |  27 +-
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/fdb_flush.sh | 812 +++++++++++++++++++++++
 7 files changed, 1049 insertions(+), 38 deletions(-)
 create mode 100755 tools/testing/selftests/net/fdb_flush.sh

-- 
2.40.1

