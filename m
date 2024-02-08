Return-Path: <linux-kselftest+bounces-4353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99084E482
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D5928A8A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBA7D41A;
	Thu,  8 Feb 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eD5EPxN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067707D41C;
	Thu,  8 Feb 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407791; cv=fail; b=qMtafNHSRAC5ZYwsqWUjpStX4HKcEQqH6rVxYFZoI2wMmCCrwG1tvoaNdoZdZJv6d4tE2/hptnFWHfF2fFJ3U/D6PGaqlI/CUuTImoPBQvFTPTH26BipmumTzKERaNiTbqDAR0+GWsJimp24HSbE63rNaJXP3WwDD1+fEGXTgM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407791; c=relaxed/simple;
	bh=DhqeG4woumYbwJaQqqKMnLD55c6wBaOfGckfPL7Vd2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khVoxMQnT9OLcQxHB1ULtpEutAc38colUftRXWGdol4Y3UwL6E6k7jZn0qQwidMXzEF6KBo3QS22N2ndmhziYZiCkwFsK2KbpUuchijLpooNodHxI6PM9cCVhAGmuMqjhisJZVx0vT9SaypvVCl/Z5/s1I88qFSr8LzjT6H5xfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eD5EPxN0; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deKaESG5WQU1SEOJrxYldCCUqQZHdH2WANxH11X2YoipgnnUH4K4SX8Dk6JqiuZGqKmmEcMvrfkcNz585KW6PpymNfjTxRMqinL0HUhDh0IuK3VfCxGcrmRMhIUIz8tjlTN8dPx64WHvf41whwbdGpUURgA5qg46XOSCOO+gH2Ks9A30bqt9BJ+Bo02tbR6ySPHuks7p+ykuI4oHs1WuS8g8r+mk0WefuV59gjZk0uBovwx0s+SPoZdQ9e7RnOEBPMYbWQpzp+xw51n7Aj2IXACIDsr46Fikbdh8o+No989P2DwkrssUh1ntBIFrnBB1oLHNUbqsB2zVzM3Ga3vfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxUxUE0ExgcJQeteEtQoDgHb1sKR7LDIIIOTtto1XmU=;
 b=jd8lo2wfA6pad6/LybqndXh2XhXDFd2Xt4+JhnLDvn9/U33qf06SnG6sH2/EiuchAe9rEYtmY/Dj+1L9K1vygUhaOPc4mVcSfFSFxUbQMydjQy6ZVF6q/wofj+3YPENK8ZAbk97FllRoFT28wZedmp6Woak7uvy+hwGUABBVXqiQ8ZbpCBPZa9vR/85SKgD60TW/hetIcKN3Htax2S/eAQNQsQXWCR+6mpHJy9OwxodhKu282BtI2Z6mKSXKrghPd+dp7keEPR/LPUz86JBIgJH6meGAkZXjQ33jC3ZGZZxv03F5G9og85ISveNu9ApfTeP/3bc4mKc+vv75RJGN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxUxUE0ExgcJQeteEtQoDgHb1sKR7LDIIIOTtto1XmU=;
 b=eD5EPxN0LpVx7+Zm2Vc6nHCcWezRhUxnDgYLfO1mwrnIWXSyFV32qkaNhTdjP/tKyUjxXIaEe4lFD96acE8wry4M1OnUDU4w5SfZJI7wB6pgOgVBfL9bgdXEjDMz1JZYe/IOicoaiwLv38B1vbk2HcC61ZFggZ492mgaBuy9gsTsx3aAHB9GKdDh+4QE0D8e2ASNzTyjB/pqE4HvfaQswqYoHWBAO1iHYiaTsMkTdpUWOi3cS/Jz3AUGeT+MmGNTNlhutz3PZHchKlyRoSWUhpog0IZo2Si29PTt1msOBiz2g8z2StAE+PpFQFYlmOzevWfjvZ08sB25uMsaTFfvSQ==
Received: from SJ0PR13CA0160.namprd13.prod.outlook.com (2603:10b6:a03:2c7::15)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 15:56:27 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::1e) by SJ0PR13CA0160.outlook.office365.com
 (2603:10b6:a03:2c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10 via Frontend
 Transport; Thu, 8 Feb 2024 15:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 15:56:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 07:56:09 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 07:56:06 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<razor@blackwall.org>, <liuhangbin@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 4/4] selftests: forwarding: Fix bridge locked port test flakiness
Date: Thu, 8 Feb 2024 17:55:29 +0200
Message-ID: <20240208155529.1199729-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
References: <20240208155529.1199729-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e66a87-bf4d-40ea-9d44-08dc28be81f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xWE8rHAK/vzn0CQ+7/QU5mCEuiFJsIY1qRXd0ix3YSvQsYTjCmYI1FUdSvp7yMTK5v+cUwGMc6usQw1k2g9SUvCnYIemQ/Mmiqmwi2ycCzAqZCADcGv6euG7Pmd97tBhRWRm+K4ek1bFTTeIJe5M9J14poI2FBmolcTUEjyjQIMZFcD1/yQV6BEYTvNLdOtnqBEB6TAXNxaJw9umB86UcxwFyNCajYmqUlnhbuhJIE0eM21vQzU7+Z0uUPPgLo4UFlgq2MQ41rRnrt4iDVX++0D/HTYUvmTQYJsybR81qpnXIoy2w5jWmfEuzhtWKu9TsVDZPncvuNeBMtoG3lWMZnzbw/9gkq4Vnf2TW/5gZjjxi6M14loWmA8GTpQnY38GtffEwd2YI5Zh5yqy01E0aC+8lhKdsJWmP4Vb7FofdaHC/rDJaZa7f2dUiEHV/vkiSd3zqjZB1VdXgVSaPj8VfG/EXD5kWwdyJ7PNAHcG/XNSrVdFiL9XfHgXcBnM+jUK0Z6lOF5HpKtme1ShfGNf29yY53oHxyOshCws/9XnV8SjqF5uK1tPj+jeeV698vz0w9oy3lStgqCKGqSisT974dyNBu/EzzqW7AM5JYjNF34=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(356005)(7636003)(82740400003)(86362001)(110136005)(54906003)(6666004)(316002)(478600001)(5660300002)(70586007)(2906002)(4326008)(70206006)(8676002)(8936002)(26005)(107886003)(2616005)(16526019)(1076003)(336012)(83380400001)(426003)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:56:26.7460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e66a87-bf4d-40ea-9d44-08dc28be81f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

The redirection test case fails in the netdev CI on debug kernels
because an FDB entry is learned despite the presence of a tc filter that
redirects incoming traffic [1].

I am unable to reproduce the failure locally, but I can see how it can
happen given that learning is first enabled and only then the ingress tc
filter is configured. On debug kernels the time window between these two
operations is longer compared to regular kernels, allowing random
packets to be transmitted and trigger learning.

Fix by reversing the order and configure the ingress tc filter before
enabling learning.

[1]
[...]
 # TEST: Locked port MAB redirect                                      [FAIL]
 # Locked entry created for redirected traffic

Fixes: 38c43a1ce758 ("selftests: forwarding: Add test case for traffic redirection from a locked port")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_locked_port.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
index 9af9f6964808..c62331b2e006 100755
--- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
@@ -327,10 +327,10 @@ locked_port_mab_redirect()
 	RET=0
 	check_port_mab_support || return 0
 
-	bridge link set dev $swp1 learning on locked on mab on
 	tc qdisc add dev $swp1 clsact
 	tc filter add dev $swp1 ingress protocol all pref 1 handle 101 flower \
 		action mirred egress redirect dev $swp2
+	bridge link set dev $swp1 learning on locked on mab on
 
 	ping_do $h1 192.0.2.2
 	check_err $? "Ping did not work with redirection"
@@ -349,8 +349,8 @@ locked_port_mab_redirect()
 	check_err $? "Locked entry not created after deleting filter"
 
 	bridge fdb del `mac_get $h1` vlan 1 dev $swp1 master
-	tc qdisc del dev $swp1 clsact
 	bridge link set dev $swp1 learning off locked off mab off
+	tc qdisc del dev $swp1 clsact
 
 	log_test "Locked port MAB redirect"
 }
-- 
2.43.0


