Return-Path: <linux-kselftest+bounces-3460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E983AF10
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A81F21E05
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD17F7F0;
	Wed, 24 Jan 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="enOdgA9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D17E789;
	Wed, 24 Jan 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115787; cv=fail; b=SKbz3hxtMzVmGNdNHXOVGvdoUXEMyqVIGocp57Ur75TpfZjsP1AVfk1pHOf8emQLr2dIPZjSONUa6mLU0MkWCM/V3mBG5E6ltgGKlnjlwIgACJ+rumJdsuApPBL9DKwJnS6lxRHxubaPxmscvT/D4aJl71j4jWXM6vNzLe66yD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115787; c=relaxed/simple;
	bh=Navva8HD5CFuUUqdCmRawabtkrHccePY+5woWFWtrNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diF6UHiOGsNLsJDig+Tiylu2wE1PUdEVPj3J8eE2sAdemAhsyRlCDpPA4X2XoHpxgZPUs6F9VAhp1B2SY0m7Fz356zm/xLNWy9/Hwi6wkvZWxSoFHbpo6KcZZJQ5xslXHPCyzyFpHq2vkKR2+/veA4wOQrjisjeP7Flf3ZcXTjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=enOdgA9q; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbdHzEvCodoX6vDEeh5N9XCGlJ/mqICUVkJhxsionBExZ4+Q/VeCrM2w61VfJDYmrkOngTKIMhIXXM3vRFnkiyPx4tLNn9jBA8bn1ncqy21eJ54DLqpDWmDQbJIdp+VXtQk3PzzoFW5/iaRSbJTaP7Rw0BaVkWTceP4c32/BNmL8CyTaTNLgOyLyji+bmEdEMYMESAj5NIJFlOTOixErThzyNdqE6zhdFnmwNjX2VcuUV9L6nFKgyE3ODu69DEIiFGbpugun1zBRtr5mK7GHyQT3reyJC+xdzbwKn8SZOxJq23IRI3VvVlPA5vxh0p69ma+bYmqC57VpEKbfoexGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v2TICNu80vHy6BTeREIvT13ft/HggZxpAwN5hYtpGY=;
 b=cB8+LTlWYx6vzPi6H+erp+2+FM9X7NApw4g2emG9HAD/ATnc9OD4ezCw8KKDG8krvpRpCnNvGkVaHDfpjSdq6IMYjczTJ4AjmLmrgenHKtPSw6VmDfB5Ag2QdJsTEEBHQYcNheUaAMYPiS+rpb4rLx67yCLhQ6Ac/MeXopQQKBQBOftVfJhiIYdwf7/Nsqcu6XAk7S7LSU1Z7LLUAaXBwev3hW5wVGC1sioBfoJXuYO17j5yHCngD+wTOcppA/Av4z9vIZ0C2nHxp+A49P6NrOZcT26JX61+w8ZjKA3yZ96S9yKnnYBgeh8+9KSTJlY5Jw10NZ9P7p4YGwHTvpRUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v2TICNu80vHy6BTeREIvT13ft/HggZxpAwN5hYtpGY=;
 b=enOdgA9qUVt8xcPT2+9veYLMPKDk4wmWAPWSJOuAgR1sGAIWJoOYKIT5ggFeOsd3jLqYJxxn818lIArSlL+g2B+gQjnyRE44fv/txB7AN25UEI+oxMMx+Tgny/guylRLmdQ3jMWZDjkOB4L6Dj2778FivKpfPD6KTLYpPQMBt21nCxfktTyUAzauz9S47AQJhaJqDWqLDl5NWQF/CT7T/aqrB3Jw6XcfdRo85arXXEFbidLDu+zyy+dZrARXMqPD2M5SOy+DNTseaIGlozO0cD/8+mi8al10XGMC6BRobM6yPHy+MFleY17J6vLQtvCbmezRkC5uWqm/OOmNY2o3hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:47 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:47 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 2/6] selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
Date: Wed, 24 Jan 2024 12:02:18 -0500
Message-ID: <20240124170222.261664-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fd54fc-dd0a-47e9-bb4f-08dc1cfe4a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mDrbCpP9wIOCt/v92EdtnliuqzPe1asNE4LehsHeMZOv3PeBYe9FNoQoru57HACK+2q1SzamyUiEEPWq/2P2+kkeGaFUBPhRCeLXR3+pOGcBTyOTXYcDpfmE7/M8PPw/hycD1OkIi4kPG2giNtucsjLMdElH03x969PIhvCf1TFWcInfZtfPq6LFJ1lhiVv8WbtjvyDre0LdCXzSpsGwZtL/hW3MCFHDQ5R6o+gB83cOmO/ynG00tkiEX3Y76j/LPwH6scjKmUGfNZunP9GGpH3YVdPWcmoqfuwdRkYWPvjVyZCALuBQSiTIAc0G9cQNdjp75sTGe/WsIwXr9T59CHRLIJxwN9AR2oILN2DfvACLf40oGwgI/YERX5Hz0aRA76VwqPypB0WefUAQuuOaUn1etY6HQk/lr97ZwWxKdMc4lkNsbQdGv8rfv5Ykp/f4Ggt2kIV2xLZ5wlkubCeklqGZMT1Q0kayII6eZd/bt7KTvN3uOJM/qXIhLJlhdnSPaTNs+CZNyx4O3ufTLs4635lHB495h2y2O4D7OyD5t+7ciUTuGCywSVGZMeyL3q8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9EAE7xB0vJepgynChy40NvE4S2fcdoLt4BuDCCrsEYw/hpXKmGMRybdg/Rv?=
 =?us-ascii?Q?wn/jYqKwrDIVDeq5p3nk957LQOZTqMkzdE1rNt/3yvkG84D5XVHaqojePofW?=
 =?us-ascii?Q?L64e9epw5YdH5vOIJw2rkWttZjmCzSW/6/QHoPITincWcFNTkqdvNBbJUv8l?=
 =?us-ascii?Q?Nvm9OQBRhd2MQiaoKN2VYajPRUoCnsQLMh4yue5aHeYZ5w8oy2G+sC+J8CYq?=
 =?us-ascii?Q?U2n8LFm9I5dErF98VHZFh1PJAh5fLmGaZFYbUZOsxCkXBKQccqyuqtpqyXH4?=
 =?us-ascii?Q?qTJwbLdMnm6IUj26owW2ScMBghadP+Us8L+y+EZ9Hn279nSilLVwjR+ScOMq?=
 =?us-ascii?Q?cwFSMrxUrK8Eomx4a4WupMh8Ebz9UHCwcnknPK5EwYldqj2Lq8CWdstx2mOQ?=
 =?us-ascii?Q?0FJ4IDZCzp02Q2nYvRXsHER78kbqNGc77kpbBQhS59fq01Y+wHRska2B0ouV?=
 =?us-ascii?Q?JafiFHuPvnzrY6D9/19/hepYpThatLj+5NPuPtXropHhDYVttHtyKt2eBgsQ?=
 =?us-ascii?Q?GzgMJGtOd9jV7RRrr89inGE/Etujb3/LqbMljeCdSqwxqvAsO66APAB6L8Lz?=
 =?us-ascii?Q?6iSaGabs0/StJBkF+tmqlfaBK9EZj9Mts9gsvv8tsZsJpjIFtxyvWVNjybDv?=
 =?us-ascii?Q?cCqz48UBLEYAoKCpEdPDymcGL6XHwzmsCquiFHrwSv+wsFCAueJNfY2QpvS9?=
 =?us-ascii?Q?+zJ2eQ4dhifCk6DHphh1/s50LagIupO4MKrP4dikJXpd2TgK9ZY6/hJhl7cq?=
 =?us-ascii?Q?IwAkAYPy3z/HHN0g/WrDi0sDUs5cB5I4g3EZS6ESLNzMi4T6J4a6XlnlbXGl?=
 =?us-ascii?Q?5CUfxEZ/tQsg0lKgVas6JhH0f1TklKqX7Df+OVn1kmjMsO/zmyhEyIJnco35?=
 =?us-ascii?Q?eagILEXhXZHF/6yyw+xhZP+M9E/sLxT2pG+3yuVV0dlzn2nrKn75TQh7KzSs?=
 =?us-ascii?Q?WXhr5AYSGozPrh3AajZdvnOn+YDjg4MMnGWEIiKzAxWtKhNn2bpu00PUFA9Y?=
 =?us-ascii?Q?BXiMft8gA6NaxfU0OmaDAjKgKZko4KGJ+ldEYu2wXNsh+RjnqjZhJaqzSphU?=
 =?us-ascii?Q?mDLxwr5t0+HzbXhU8DnBUktxQoaHdrMfjdhKdnp2TrWel4eJin2KliDJ5sQi?=
 =?us-ascii?Q?RSwNPTY8l2I4lW3fTDYEQzF0dVCbYV2mkuThFfo/GUCd+O2V2dxZw9IpHrBk?=
 =?us-ascii?Q?WzdFZOQK8Jg8EUGCHr3Y0gRBDs0D7Bk+DBxOgQz0eiCeBJ2214eVp1eZ97I1?=
 =?us-ascii?Q?aE5J5FYyxiyeH1oLU1XVY1n8wWZ7r8QpUot1DullX/04gLALJ10sz7AE8XKQ?=
 =?us-ascii?Q?M2GKE2S0eP4+7iWhhAANZA3eXVKHQECKqa1bcz3Vw/NJWFQOcSiz/2qffn5B?=
 =?us-ascii?Q?NJKRASgiV52j1FN0AqXkVKda5LnZov5nYK5mBxix4FIwM3/OGw4R33e7UF8T?=
 =?us-ascii?Q?u+2aGbUxWmgfqm+52pkT538pTtPtK13vp9J2c1bRSvMD4NGMK38a3rYKB28O?=
 =?us-ascii?Q?r+LJJ1OjFvriaTitJ0bRUG+7QkNsimfwf34cxhV0PFDXwgU0/YA4obVJjBUJ?=
 =?us-ascii?Q?iCrJA0UsC5k/mqyPyv+rUe7q7nFRUd5GkBo0kBQH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fd54fc-dd0a-47e9-bb4f-08dc1cfe4a20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:47.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ht44T038V+eHJKyOX8BUaBnre3WzPQi4LvI7StJnezkTEqrPVBJZc6O/7XxwDrJyrnYHk/JTQjBoF3G8g6png==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

In order to avoid duplicated files when both the bonding and forwarding
tests are exported together, add net/forwarding/lib.sh to TEST_INCLUDES and
include it via its relative path.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/bonding/Makefile        | 6 ++++--
 .../selftests/drivers/net/bonding/bond-eth-type-change.sh   | 2 +-
 .../testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh | 2 +-
 .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
 .../drivers/net/bonding/mode-1-recovery-updelay.sh          | 2 +-
 .../drivers/net/bonding/mode-2-recovery-updelay.sh          | 2 +-
 .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 -
 7 files changed, 9 insertions(+), 8 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 8a72bb7de70f..1e10a1f06faf 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -15,7 +15,9 @@ TEST_PROGS := \
 TEST_FILES := \
 	lag_lib.sh \
 	bond_topo_2d1c.sh \
-	bond_topo_3d1c.sh \
-	net_forwarding_lib.sh
+	bond_topo_3d1c.sh
+
+TEST_INCLUDES := \
+	../../../net/forwarding/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
index 862e947e17c7..8293dbc7c18f 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
@@ -11,7 +11,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 bond_check_flags()
 {
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index a509ef949dcf..0eb7edfb584c 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -28,7 +28,7 @@
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source ${lib_dir}/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 s_ns="s-$(mktemp -u XXXXXX)"
 c_ns="c-$(mktemp -u XXXXXX)"
diff --git a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
index 5cfe7d8ebc25..e6fa24eded5b 100755
--- a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
@@ -14,7 +14,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 source "$lib_dir"/lag_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
index b76bf5030952..9d26ab4cad0b 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
index 8c2619002147..2d275b3e47dd 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
-- 
2.43.0


