Return-Path: <linux-kselftest+bounces-30523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D21A855D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DB3B0670
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325528CF4B;
	Fri, 11 Apr 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGS9EfV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182727CCCC;
	Fri, 11 Apr 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357832; cv=fail; b=O010CQGX3GRBQLPwoAP4ur2HBYB2wGH/cIsLGSgCa0mMexD3a9bBpCDJd55b6EhlKrFNBY17067F+CK4lJ2SmfcCkx3TYwreL4Wr9RX5/j1HWxNBUvz8DN4uXBdXJgH9LuQsAsd9V6sIfnbe6eRjz38XoA8N9dMhx16YKvLiW7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357832; c=relaxed/simple;
	bh=Y2bAKtqxAX2CffcCzy/8d9TUfPr5fIa9VANuiJ0E9Cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kpd7wcnQVK6W9deLlGv8+ZegY6GrAH5MCkcti8LI2bOZJuEp23rJxCqNJ+RRrjMc/mdhVxuDdUEmtcFS2+vpUHHpwHrut1NKvGBfY8ea/QHM22MpMVhdRbVzXhP3GvaosF0vgNS7IdvxoJmgX7x3aUAGDp2P5lYwiXbzfPuewS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iGS9EfV8; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8t7uYsfj6cSSrOWwmffaJR8CU7S4vXWH/P7IVCIFfC23Y8e3zYk720/S0lwcvRnVHzySU00eNCM0hMBCyTiODAENt+qCyeK6lOR81xh3LOAymQKQ0MOAsOljw4v9DoMciRUq/gQWhnRwlaHGWnxzl9RDqrweGB89dRGdhWjbJGHgNpFjT+gI4wASVmzNLVzEEupZgcyBqfAb2utQkxvLZhbmwqceU0zX845B1V+LIweuQ2Vba2d6wIEq//ctJsbvF7jl8V9f88pTA1rvcws1EJpW+ImJeNR84X7/AXNoJRC0lOxP6YVa98UiP6J/wfRdm9KMrZHwlsh5IQayywiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohN/ZEsgJPogdFbIVtUJCUpt9JsM+TO7mhuGcSP7nrg=;
 b=Rbdw4+7Nup9wAIE6Me0CaDt6iUBGsbhEXXT9O2MQO8U9fz1815bZyUc6lnmfdMDa9AYvZCnXCvREd0/MzadtkBOfgqlNtV2A6LKD/gW7hlf22uUfM0idP/dBO20bzQ/6vVFXGCvOVt/jTKGsXHTWbD8ZOzjE47jcdIS0wcdU4OOFWGGpsmcP3bbvFQXix/66S7EyxVcAFd4Tumnu7WOj/Z9VIaUrq/59mSt5XBORnwmfuYbnHpt60OdYMXZwwRWAPjuuxT6y3vsW63BUag5FQriu6iiUp7HpcOH6I+NzsQCK1vEdv+4r9dDoRUoRNqvX3wl/+Li/q6J9JBVO1fbvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohN/ZEsgJPogdFbIVtUJCUpt9JsM+TO7mhuGcSP7nrg=;
 b=iGS9EfV8qSWmwueTJZEaAfT6lKevbRzF5Jq9rPmk161nMzFUwSEun+JAQoRtuar6ktBcPz3fllN5IiwxwedVg49/V6H6oxymuO/Ih+yton7evPmbc1pmopIbxPUTNrrWphg5xII40KvMT93YG+TfdtTv9F+t1amqUTB1d/jBb19CokHFrdGrHaGuevTD/+N7EqxW8z6bPbjVWDEj460vhfcCbg5dhbKHJYVlReTHOl295fpTGs4Yy1JJ/xGRZqpzmeRaqtgp9VjtAlerbRnN9X1E61fS10yDkwCLHeFFqWh5ayroZWQ+tlhaaJpiSfQA6ob8Wub916gsHcZzZZRHtA==
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Fri, 11 Apr 2025 07:50:26 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::d6) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 07:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 07:50:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 00:50:15 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 00:50:09 -0700
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
Subject: [PATCH net-next v3 0/6] xfrm & bonding: Correct use of xso.real_dev
Date: Fri, 11 Apr 2025 10:49:52 +0300
Message-ID: <20250411074958.2858496-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: afed23f7-005a-43fe-64d7-08dd78cd8576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vop0ePKdLYIlHfX2om8OuYRcKAQtevdQNEBEfUeF90TRDznQfW7H1TCuDc+Z?=
 =?us-ascii?Q?1G/6dICKvDcA1cknqkmPiW4TQCmUcGwQQXq2ujq7NYep00m/53ZlEEQMBCr9?=
 =?us-ascii?Q?XVsEHj62imOGpFD6m7Ipc07X7c5/Rc0Vhjo4wWXLA7s+iy5sWgYdRhpISfX/?=
 =?us-ascii?Q?iQKQSW6L9w2NZzqjwy/tM1ef3tYv+XoqW/sc3GMY+B2QzEirZQ78HxvHbaOc?=
 =?us-ascii?Q?4MDPRsnGZoSPHJH00W8ud0+SpF5XLNc+aFh1VboQNcWtblagkCtTEr39bLC0?=
 =?us-ascii?Q?wZUOtXlUJ0tNTBSQ5LDbDHxiNcGOyl6D62C6Rl4huW+gdzKVhx8U1jo7SxHj?=
 =?us-ascii?Q?bFzEL291UPfB5zfJy49h1ylD+rKCzbGrDOcZl12Zs3ftSEyf6uGzPnKkzp6d?=
 =?us-ascii?Q?PLBcTQpIB6vGDxb0E3dGu8f0+CC9dMdULBxNzdWMNT0FL1vhaWj0XXdwNNTj?=
 =?us-ascii?Q?yFqtH87+WkxSx1uVsCaDJ9XGFAmeOGdbd78y1yEXmYDlFkgjNkiqlfO5yCSV?=
 =?us-ascii?Q?gBohQNINfthbr992/4FFnsRJo5Qp4bEvQCVJT8/LfYx1VJkVIMw3jqCMfOrB?=
 =?us-ascii?Q?czzxWXprBAmyBA7c+wxeiaa9vXTiJUf9wkD6j/B9g+EvB248LfkCxHYSohhm?=
 =?us-ascii?Q?tAfJIf4QQlc2wbA7Rd6dYhaEgv02LB8Pkt0aaC7lSVV7BC9ahIHn/8uSao/1?=
 =?us-ascii?Q?wZR/TsOPUO/AhUBlihuo7wSYCg0hkmiGwOv7Pgk8/TMPtfFsoTtP5oUePaPT?=
 =?us-ascii?Q?JjhqFsQgvNdiE/Odq9kfCXI5KcJ5YImblNzkwQQs2NNyKCPKmCREmUEqfSVx?=
 =?us-ascii?Q?eUzs01nl0MSOkZK0EABNzeTEOM2bLGv7rCgyW2UoncteZXTvYMYCquuiXY8E?=
 =?us-ascii?Q?BABFpNWoXW+SIsEWyb+hAmmIOEQt5SLwBSBAbEPsDBgH6bPGjz4ls54sgRfZ?=
 =?us-ascii?Q?msr48MjvxdqVp1Ubeuma5rGDCu3VAjvPUS5FFU0YcNRJrRF7JnbTg25pFLUF?=
 =?us-ascii?Q?8Waqi9wn5SoLhHI62nFE/A7CqPkf24YnEyyzftZBZnsc0lIUBiUSiG/2rPZ2?=
 =?us-ascii?Q?q/RotXOrenf5Gty2L/X3m/NcewI8EgQFnYSicnbjFPqN9kl37loqFvZ0r7W6?=
 =?us-ascii?Q?KcJeTQXRUisSMiQsJiz73eOA70kCpDCMJ8tIybvU8DzSrnOsZ5CEb9GpakGb?=
 =?us-ascii?Q?7EszxSKxCQY3I2E7g/64fUupFDzmXNPZlmKAjCZfEGNACYJX354CLnpWXHkF?=
 =?us-ascii?Q?kUeDLrqIcpIVTM7+YkrPw356fONbUVGuVQAU8LEksd+2zYn51BD3/3u+45/D?=
 =?us-ascii?Q?CKZ34alQeetJhKFR/FuA6pnx2YsKaShrdLIiAEfYjT8bKRSLsoiyhxXNq6Sr?=
 =?us-ascii?Q?fJo/yjpsHfPnpSiQbghP4X6eBKvZVrOkBMMQbvDgK3p/PQHdJFxYhz4b+dqs?=
 =?us-ascii?Q?1vP8GPlUi8pZt/6J2htngWbGP+TDHokW9mV9ma1FX3LsQHuXdvRwF7weGuRi?=
 =?us-ascii?Q?xAIv4lbh83D0C8gDUBuLDpJhnLpXRgap5WHO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 07:50:25.7673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afed23f7-005a-43fe-64d7-08dd78cd8576
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

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

v2 -> v3:
Added a comment with locking expectations for real_dev.
Removed unnecessary bond variable from bond_ipsec_del_sa().
v1 -> v2:
Added missing kdoc for various functions.
Made bond_ipsec_del_sa() use xso.real_dev instead of curr_active_slave.

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

 Documentation/networking/xfrm_device.rst      |  10 +-
 drivers/net/bonding/bond_main.c               | 119 +++++++++---------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 +--
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 +++---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
 .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
 drivers/net/netdevsim/ipsec.c                 |  15 ++-
 include/linux/netdevice.h                     |  10 +-
 include/net/xfrm.h                            |  11 ++
 net/xfrm/xfrm_device.c                        |  13 +-
 net/xfrm/xfrm_state.c                         |  16 +--
 15 files changed, 185 insertions(+), 167 deletions(-)

-- 
2.45.0


