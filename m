Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F26736E0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjFTN5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFTN5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 09:57:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D851A1;
        Tue, 20 Jun 2023 06:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHC2lQcCPPolW/D2q+FjtDlZ93K4zhRV2+A+Kdi8NGYW7/je3UwQ1X1U7PvKxWJoQRjb3s27U/FPoCeIKNMHOgF8EiQKP4qmLjjKhpOLxDs+rM8MaTHwAUByvJIrFJtKVGSPb5u0myTMVoKxWWefzKpSH1IstOzs2Yc9CaPqJp9/4wK7exnZA7V84CoqhhuGMj6KvjLTC0mXIPuDbPeRIf1uaZcnIwxw9t5fuC5wRqvAUEiXmvHyAhMTwFsNlPeQ32ChnF0a0bs+7X2ryAP29i5x4srYGHwUvFOskrq4MMZ7TAdBdECfHPCDKXW8bpqWhTmPSXt4/uORfMweFKHblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUPKEybirnewesInpl4Sl4fRvxDcu+CIvibkXh7BBkw=;
 b=O755ReesmBYdSHQXWNgLlg8rw0nW4LNUTxPhHxU5h8U+y12xiogRD3qzt7kIbLTt/4dFdx6vsr9rTIzvNLvmxRxLvjNTCArCNYIyyuFtUtOQEcdBJchsKTNP09aszxeHMV9mpzeCF9QEfRyKWLzSmu6F0cllJirxK5acPCAGOcPM6mCfW754j+i4Bx6qfER46wAk/RGBPqmtTkdsncCrMjYU33+yggsZvAj7UL5C3dx0iHAcXKFzpygV6F8N/20TEb9HDywsNq+tzpiAVgy7bSfakJ1N/f2kPIw/uWHmF0FxD5ma5LfRjfwhGCGwJw4lvNYWrxCfdy7BmjSGSjfU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUPKEybirnewesInpl4Sl4fRvxDcu+CIvibkXh7BBkw=;
 b=YV+WwXKkStD3CKG52D+7HjR2Fn7aFmy5O8H62ILBsz1iRT+3WAQ+3sG7nzVb3pFTY5CvC9BoB+n5sK++/6pFLpXmXCDGFATuHOQ+8mcT3NauqeE6rQR2s9OS8CA8uhdGFZuv+xelZbHRAbK9g4Jd/Tm6PUAqukrN1hcPcLpq+k09CcgKYeh15fMAMvOsWJNPB5Afj9J4W7CSS39npjSkRfp8+Ww5NWrpLqOhARGHtQeRvR2p8QgJrYuFsDQrrzTBhW9fSH3GbQKsjFoE5kw1DwKI0ds112i6b1IIiI7JI+kWscYf3rlkwybaqOm7blyEiHoI9wyO0J4iHUNxZDR9xg==
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 13:57:20 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d5) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 13:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 13:57:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 06:57:09 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 06:57:05 -0700
From:   Petr Machata <petrm@nvidia.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC:     Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 11/16] selftests: mlxsw: qos_dscp_bridge: Disable IPv6 autogen on a bridge
Date:   Tue, 20 Jun 2023 15:55:57 +0200
Message-ID: <0bb38b64a0e95bbd62f3cea0305491fe72d931c5.1687265905.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687265905.git.petrm@nvidia.com>
References: <cover.1687265905.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: f01dbb64-b399-4263-4f27-08db71964429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ak6JGv7z1PIqUx/P2GsFoR+FJ7Aak0BbysTrjqICwMMntqOuDwejVxKRlY0fTNxkwzGPKUroVJfDF8KFC/LhDcYw2WwY5aRQWW+UW52GtoNAykYULJ3rsjFUc+ObQ8l2+G5XKKWbV7NRHWMEHBb1/QN/rafyh977MJU7IE0h/Zs5qZCa8xwS7dR+YCziImpuO/oF+ymFDsai6EhYJoLf4wsfe31ufvf1olJ1kACdpCF+rjyV+ihhnofWfaZmerC21bHpDl3qlkqHZzwxJhPdgwZeAiMj3VnR4CmdhmPNhCdNj4x3Vg2L7IkwrnZbUgT5cRp4tg8yls1sI4P42H1vRaBCk9yaT5WpH4VBk7G01jdCwBYrojVcYOrYJgfwISM5NwdyF+1X+0+flrnYICQ2ouXvxMmxVDnNNHNBRa/I8bb+iHxkGBJoZTPCXs2argalyr7YTQ0++sLAO9Hy4WYr7RSIOMu76h1RxBvB9UvqDCUFzmDilg9jtrbqu07W+1FZHwG11OR3KnmsmJWaTkyzGlG5yaanAOCriQWazWvILvwxVrq5fJ6rEB2NSTIZb97OgSxteVJHpzhwNqqfGUVJqRaehOXPtX93w6U4lgNu7SAiNfTUTuMEk+r9ztYL8AdpGIuWRbhlFo0ekr+qId2Fl0DIyChKP5PePz/d4kbigIVpL8kquGe3HPgK1WU3v0mQDPfGvpwF8k+NuVwJ/nVT/1fVxAARog6OXGRFCbsqNW0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(8936002)(8676002)(2906002)(40460700003)(5660300002)(82310400005)(36756003)(40480700001)(86362001)(107886003)(26005)(54906003)(16526019)(186003)(110136005)(478600001)(7696005)(6666004)(70586007)(66574015)(47076005)(36860700001)(356005)(7636003)(4326008)(70206006)(316002)(336012)(426003)(2616005)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:57:20.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01dbb64-b399-4263-4f27-08db71964429
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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

In a future patch, mlxsw will start adding RIFs to uppers of front panel
port netdevices, if they have an IP address.

At the time that the front panel port is enslaved to the bridge, the bridge
MAC address does not have the same prefix as other interfaces in the
system. On Nvidia Spectrum-1 machines all the RIFs have to have the same
38-bit MAC address prefix. Since the bridge does not obey this limitation,
the RIF cannot be created, and the enslavement attempt is vetoed on the
grounds of the configuration not being offloadable.

The selftest itself however checks DCB DSCP-based prioritization, and the
bridge serves for its L2 forwarding capabilities, and does not need to
participate in routing traffic. The IP address or the RIF are irrelevant.

Fix by disabling automatic IPv6 address generation for the HW-offloaded
bridge in this selftest, thus exempting it from mlxsw router attention.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/qos_dscp_bridge.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_dscp_bridge.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_dscp_bridge.sh
index 87c41f5727c9..914c63d6318a 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_dscp_bridge.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_dscp_bridge.sh
@@ -65,6 +65,7 @@ h2_destroy()
 switch_create()
 {
 	ip link add name br1 type bridge vlan_filtering 1
+	ip link set dev br1 addrgenmode none
 	ip link set dev br1 up
 	ip link set dev $swp1 master br1
 	ip link set dev $swp1 up
-- 
2.40.1

