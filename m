Return-Path: <linux-kselftest+bounces-30245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B5A7DF99
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA4D3B82AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB2170A11;
	Mon,  7 Apr 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NdQB5Wc6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E53594A;
	Mon,  7 Apr 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032989; cv=fail; b=IyxX8e668HcWoDrEfecmDBuJw7/pknRuOWQF/tgzjrf1blEz4JTN9RrBLJJxlUb+RaUfed00wkDluBCFCsyaNLvFAEh5evJyepznSG160tWiKbUBvdPgOIV1/6WA7HpVkPt37vqzO5ANcjImS4asVVhW9Tk03DbSGT6dP5Ajrjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032989; c=relaxed/simple;
	bh=Um2fWeTPYY6XIGCFMgwO0uKhGCKj4BcJtCgbAinNLJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RGRder1lz1yI3iUNIxbXxBTtcCEm9tisbhLQSOHvr1uw1zpBrD3fZz64xfRbRD8z+8zE6XsmDt0lMQx7OxOB31j4j38qgSbIqJcGJJHT+qHf/rz9vav1+120mJUwF6cDIhv79llHvJN8ZLotL7JDCJND98OeV5twJFoR/WcRDpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NdQB5Wc6; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFZf484ojE5NyI7z5BdxbpXW1vAf8IAKmKJjC0FgqlQGh0SUc6CFJs1o9aRyV2aT01EICFiblpprGYu3ysj1P1+E8z2EXJCHCfzuHMbMU0z5IoHk2dEQKvZ4mS4BIA1ssVOb2Lphfx65cpifo6mYDq8Pe3FoFEvPjxLR0koPs8Ex7IyBx+C6kr2YuDOrUbt67u4xiNDnLrvPyfuAbMMU+8MOrorMtmtrJ5isaJwfl/2vyouI0JG3LpMJYJFB7rD8xQlepwVMhRD0eg/mDGVdPoLlhmVnU7ubTzsemg2OVNfonX0/eVgF5nxES7Y3JfLIPgcXm1ylT/cpix0uCgWLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+C07nGKyCqBp7xAA0ipGmTTY6JcR+O+6HnFW/Rk5CA=;
 b=NZ826mymMh7ryhtADRVykNRvbo7t8SQVKWxCtSgwhMej/qQwUY2V8uChRajdNvUzawz/q963IG4V7DO+aeOw89AKihRY4BzuE6+Jsedsr0s0eYDxKV2TF8ys4t8WvCqLHqBG6SLcDfJOFC4c86vwYaNrv7fkZDwJmfQKEQFXYZE2Xr/7giGskfit9ECyZEcajiTrPSUChRVU8HdmXf5HOGJNpOvy3OKXwFEYhQMgFvj00/CoZqR/eskTydAgizoMzjNNlhn2su00TZ7bsg8H1+PMrIiddKqjG8N1qOD/HV1KtIQfX6SvevzTVkZthPpozkfN341xbCabtkQ1LxyHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+C07nGKyCqBp7xAA0ipGmTTY6JcR+O+6HnFW/Rk5CA=;
 b=NdQB5Wc6hRTPbeqF01o6aPHYvcBg2wu7r+b2ikbuoGhdsXd0MGI0eCVj0m39A965B9vX53eWLMVXuXomYmkwSxfiXFixdDbY4GHFbWVzqbs+ykuBc6OnWhZJwQT4MIfTHt47UuHkP9fb4Ph6BXG7KwCY1nnhbSuC0CIi/JA6BpaU2ozjecntpXEqxhfCHJwss9zzptlfr0idTa7Twh9ZyiS0f2Up5yuZyZ1J0oYTWjUSy3nTeTwCXIT/h3uUGLoULpbbZUnNcHuRPhyH68Ku/ZMEXIGv1dzgWAhGL1ZIFi4RDqQWf+ITYLJvUGMwbFwIdG157wkTUyYlyOa/eZ8NYg==
Received: from PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::17)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:36:24 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::8d) by PH7P220CA0101.outlook.office365.com
 (2603:10b6:510:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 13:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Mon, 7 Apr 2025 13:36:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 06:36:07 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 06:36:01 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 0/6] xfrm & bonding: Correct use of xso.real_dev
Date: Mon, 7 Apr 2025 16:35:36 +0300
Message-ID: <20250407133542.2668491-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: a99c7dcd-fdd6-49ea-8633-08dd75d9308f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzujRuAf11kCuvkoPE6kAGRjySsW1WsA9RpQDa282kXZOAb8IJYUTuZcoZxf?=
 =?us-ascii?Q?CVi/SWxXKQ/CZvwg1+yhY4DwDqMoM/U1U+k9pfeMJeKGrddJ9mQ9EiqOLwA9?=
 =?us-ascii?Q?qFuJnCJdEtBZcLaf/mYZw6j4DpEXng+GjOcg0BCYfVimWPuXd8OlKHZ04COC?=
 =?us-ascii?Q?3pbigAnqlHBsALXhiIWavgrY19oy73xtOe/3hHHMoCBxZw1uDkNUnSgxAi5q?=
 =?us-ascii?Q?mEDSl1Xq+BpWr8gJvrN2THGW1qH/49DySWUa5JpQ4RZPLgpdxdelFIgUrGCf?=
 =?us-ascii?Q?NWh8hS6njqFm1EwDVCfbOuLqOOs27lzNIZSWGUUcfnmn0P3TAZbqFVnAxrO9?=
 =?us-ascii?Q?iAOzA1sTwh90BgAXT/hpSsrClSProyzHBDPL2GCG4+HIKUkJTvRZA1q3O0Rs?=
 =?us-ascii?Q?A0cHbmGY5bymwmwYOMlMR8tQw4D1o3PhokE5a/MY8K3LPTLtGfLJqOA/6SQc?=
 =?us-ascii?Q?5X/upDTMnTRKZyBAsQj2Dur3f3ciFep6Dhglxom3grs1g43VJqgXDjgBpxrG?=
 =?us-ascii?Q?g0kTzPZZpYD9PZD+mqDp8hbX6DyVaCV7gJtjeOtoivODCk6u3YZXkvpPpYzY?=
 =?us-ascii?Q?r+1aa0QWlWkyplLFgqAm4kqfhjNcR9LAhHSsiKbHo1tibMLpfjK6GJx4R5zJ?=
 =?us-ascii?Q?k6vcXy30NLS68eqyhaLi4RhYkR4xVrD6Tn01sFC4ry8a2sCiTjBmkmIJGguU?=
 =?us-ascii?Q?El02HeBj8S1ejoQAbHaEB4+pmvbZWPPrYVB+clYI7rFNNPIgsUKnsygDNenP?=
 =?us-ascii?Q?TYm0dyNQTEQKaKvEvQViSKi0z4OOpyUYw/ZylBZnlPN3NTV8U8xHhV5KN9PQ?=
 =?us-ascii?Q?bAnVsbQ6gmiFv4SptBiHik3XhL5Y2CX2YMMG80+ea6pK6wZF5vrIC+hXomZ7?=
 =?us-ascii?Q?fyv3KxL4k097ujsD+/IktrmwQWdxGm/rs5amqk8kbJs4+tDEV4Xvncqogitg?=
 =?us-ascii?Q?ZYiV8+a7yDHcKnB4M5BaD8EIYpKc76dSRWJTSkw9Y4YVWXPWy9NvaYnqy1x8?=
 =?us-ascii?Q?8LO80tVYG5VcK6+jz7l0/2FHmbojjz4ntvnSVZW2gc73Mrq3q3PcdmxeEkR1?=
 =?us-ascii?Q?zXVsa3pZO6miJ8vXSrOORzZ+O0DYzAElPpL0HpWFefxIorPqq+u4C90z2BkJ?=
 =?us-ascii?Q?5DIDUH0dwd/xgzobgQWN+CzEN8DNDI5SL18W6vn2SY8zbdRytTtn2BnC7mcQ?=
 =?us-ascii?Q?hXTdH1YlpH4iCsRpJmYs6u8AB5whSB11vPJHfqecJvboKBUvlwB5kVnOcG6p?=
 =?us-ascii?Q?0EG9g2lUXKhA+lTe7HwCNOgzZyfdnnV70kazTV65rmyz/ZZwpAtCDidZM/0T?=
 =?us-ascii?Q?Eh7tUaPXhb2kY92T0YSHKn+irHBX7jkeBjsBelugy0lGvi5/mjTO3fgk6xwt?=
 =?us-ascii?Q?5W2zgr1dd00Ne88gPdy9dIpPHq2wt49w98WMuZSQrb5wjBM4dfrPyzaPqttI?=
 =?us-ascii?Q?U1z7pKrUAHedWW57xUk1yVmRy9UGpqNEARcJDR0S/xSeg2bXyPEVJhzu01mI?=
 =?us-ascii?Q?ERHepyqk7U4ntK8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:36:23.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99c7dcd-fdd6-49ea-8633-08dd75d9308f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962

This patch series was motivated by fixing a few bugs in the bonding
driver related to xfrm state migration on device failover.

struct xfrm_dev_offload has two net_device pointers: dev and real_dev.
The first one is the device the xfrm_state is offloaded on and the
second one is used by the bonding driver to manage the underlying device
xfrm_states are actually offloaded on. When bonding isn't used, the two
pointers are the same.

This causes confusion in drivers: Which device pointer should they use?
If they want to support bonding, they need to only use real_dev and
never look at dev.

Furthermore, real_dev is used without proper locking from multiple code
paths and changing it is dangerous. See commit [1] for example.

This patch series clears things out by removing all uses of real_dev
from outside the bonding driver.
Then, the bonding driver is refactored to fix a couple of long standing
races and the original bug which motivated this patch series.

[1] commit f8cde9805981 ("bonding: fix xfrm real_dev null pointer
dereference")

Cosmin Ratiu (6):
Cleaning up unnecessary uses of xso.real_dev:
  net/mlx5: Avoid using xso.real_dev unnecessarily
  xfrm: Use xdo.dev instead of xdo.real_dev
  xfrm: Remove unneeded device check from validate_xmit_xfrm
Refactoring device operations to get an explicit device pointer:
  xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
Fixing a bonding xfrm state migration bug:
  bonding: Mark active offloaded xfrm_states
Fixing long standing races in bonding:
  bonding: Fix multiple long standing offload races

 Documentation/networking/xfrm_device.rst      | 10 +-
 drivers/net/bonding/bond_main.c               | 93 +++++++++++--------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 20 ++--
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 18 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 40 ++++----
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 20 ++--
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 18 ++--
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 28 +++---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 +
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 +--
 drivers/net/netdevsim/ipsec.c                 | 15 ++-
 include/linux/netdevice.h                     | 10 +-
 include/net/xfrm.h                            |  8 ++
 net/xfrm/xfrm_device.c                        | 13 +--
 net/xfrm/xfrm_state.c                         | 16 ++--
 15 files changed, 175 insertions(+), 146 deletions(-)

-- 
2.45.0


