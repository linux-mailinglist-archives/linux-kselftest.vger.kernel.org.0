Return-Path: <linux-kselftest+bounces-30422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7AA8287E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C2C3B0DF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3330255E32;
	Wed,  9 Apr 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdW8lj+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD23595C;
	Wed,  9 Apr 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209740; cv=fail; b=Cn7iTP1i4nJ53ZhVgbEd6hQBWOYQC3zDDFhQTZnHIKnGzCOQt4x+oEwyyhzw1O+XYW0/PtXceMh6abfT5S60s8PrPyXmYoD3zheh4ugtzOVUzhbTtrtuCc88xFHyRNrl9AHOD4ov/TpzhxbOL45kHbeqYAG2Sd7PGHgtQ+BQOnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209740; c=relaxed/simple;
	bh=RMc2iacxCETYIc+KRz/r5JwZqp8nRCbBtS6nNjvZBfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sz2xuvFinHNYuIbFm04xZ6nweywCaGe6j5zdOrMemZirwAe+DuN79NRFfy9SkmKnDsdYp66ydM7l4E3ze4tCSSNfA9lrkLoE614th2/Qyce7t/j2UWgQ6cPDIwzjxLSIKqVuLQEkzr/sub1voyDRxuXV5rfW6MJ01uCy88Cm7mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdW8lj+s; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lst+zzxvQ8XoGdfD4m2d7G8mBMUx+hMPT1f2paeYh5wsr2Mvoo9PeVIMRO3anqn0ijN+NwlT8Jem5tljY7VHwCzvcNK9aD9BMK6GuyDdvNK+5nZ7QncKQ+Wq7Cf2Ow4sVcIh2IGHiFs6Z7CmiKUs4Kkip7+RRi8ole9yvFPfQroMLTJdp5j/Jh0S3PWGdozAiJ8QcQFXSV/vmCU9XWdccOE21xZ8nczvU25cWEiYfq5qZthb6gHvElMR8SwzHYBVFnavyTcfqcohjrU8N1HkusSuDSIy88DdBdYl41ND7zZWDyQxGqfJgEp/7xFIUJJv3OGLxjujjh+Q6ICC0GKLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C1nCNlXbrqmjj2PaKQDRphjbv2hikBwWuW/npGOjAI=;
 b=ybQd+xuxex1FYxcDkZZmUQaJWN7JcxN2/5O5sEH7tL146CI8AEJ0ZxnNBAFNPzan2lhKYkb29DCfUhq//3Gm0AnJn7+669cLpgHaWzJiP4rkiaMfERK8UYOWDK6L7vBYsIwHlAQ3UVrCWDlj8+Nnk9cqUPynGors2hkg0w9bRuZ1f1IqmL5bfzc1Bwwy9IqUVcKlfZSkBy8+gaGT5BUt2pc7f3df+klWW8tiJbSlSA62SKtRhvFzPlCkXCpGOnzJgWbUxRLX6kCTu5KvHHjWnHtCMDbqPZtrGYedRenoYvH9Oep+GyPwmyqwqOxWnSlS5Q+5YUN6HYLDs5H+OVlAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C1nCNlXbrqmjj2PaKQDRphjbv2hikBwWuW/npGOjAI=;
 b=HdW8lj+sYKJ6w/WB7vL8xUF13Lr/4HxyNjtQIvY2DhQWIU+h/7z0E+530jcH4lyTCimxKWUUa1cGeoYb4jg+Zs6Tlv72ofjHMvlB6gae0rplTbeOvUbLdiM9vpyBBMDCUp7p6RxIA15+zIPELCh0dIF4rhk9BQrVsWEe7l/AhHqeZe13Ebc3l7FMu3XC8ez/uc8Xa6vYlwAEM9DdFDH3kkhvCVhvGQ0EavLtKeqln/YRtq/jVlNJijHUuCuYrlGZFmzVgJQIN3Aj7Jmjbn9DVD8e6zUXR4EP/jLWf8ssDtRo2zzZmsPwmdZnp7pm5eYso27Y/cbrYK4QRKFySy4gYw==
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 9 Apr
 2025 14:42:14 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::b5) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Wed,
 9 Apr 2025 14:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 14:42:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Apr 2025
 07:41:52 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 07:41:45 -0700
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
Subject: [PATCH net-next v2 0/6] xfrm & bonding: Correct use of xso.real_dev
Date: Wed, 9 Apr 2025 17:41:27 +0300
Message-ID: <20250409144133.2833606-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: a33a9aa8-db73-4f41-fecb-08dd7774b804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D964k0Lh+UEMrb+L8yrdSt5k5oPeU8OXb8n1plkwQwoGv7GCYrk+81Y4H7mJ?=
 =?us-ascii?Q?bYYUGAEtaZmgQOp437ikEliNGTEW8f1joQxftO0JBDM8xRQ1SKvS3DrhXQ+3?=
 =?us-ascii?Q?kABzX2vBC062wTmyTrQ4rpmFEe9f6DoWtdlW1RN/jP9WIhYwr9eq8k5c+aos?=
 =?us-ascii?Q?7jr+6KBgGMstbLhPb3m/n+uO3hiECFhDIOvwrkr3YlQ6QMpTsEUhizNdHLUe?=
 =?us-ascii?Q?53Loc+9nnNzlPu+YzeQ5DPoVNZN/G/g3vUyVkZI96B4+1YbNR19Oe8oekewp?=
 =?us-ascii?Q?WNavTsCkvh4ylkRaXzXOTkX1ijnE830WPmCZUFA6dkquUT80ScAUCBB6PjWO?=
 =?us-ascii?Q?YiATF5nwtgpdpiVbIc/RcDtqNiEtD09pN5L5/cwYfxvggArQ5ZNgcna3vqfs?=
 =?us-ascii?Q?kHtINME8L31lxBF4scg24j7wxmXhnyKW0/kDrPuPDkhEbVVHrUZQzLVizfYu?=
 =?us-ascii?Q?716hqG/hiDT9zS8mGeSeXF4for3qRiLXPLAGcrJTUYufEvsQoFwzOok8xTwG?=
 =?us-ascii?Q?FU89N928efoa+6mqD2ooLQX0S9obaWp5FzSaR7LzjdszPwHCB+vQO1Jjtsgs?=
 =?us-ascii?Q?XTD//RD3/LF52cJpmGaNLAX7CmSQi/EDZq74OW3j2mTMKtFtFxrBv779YxVx?=
 =?us-ascii?Q?Z3TAKaPVxM8bIpz1JdBDBV9r+j2CyZ7vTGjRSMWzmavJx2Pn6cEKEp0omPo2?=
 =?us-ascii?Q?s7ZBzHPouPa5DgCTLS3gRdynGBBrn1wvAyf3HITk9lYNDZD0ajtT33AD+vsR?=
 =?us-ascii?Q?URa2lxOmqvHKxKvcrvBSOVvGuYF+Gmcz3cVIMaMubj+cr4/MyCTemREkwuej?=
 =?us-ascii?Q?4HY6CiACQsdcMyFJdj2hzH6W9asKPWlhL1X/WKfv+/cU7jA+emNJJnJuIRDo?=
 =?us-ascii?Q?cyutYnsE1+zaB3KmyuKpl9A3tCzdRvcmCqlTjcNRPD2uHzWNYyY7nM2efvqC?=
 =?us-ascii?Q?B2qNe4vmwpEOS7UvRUzlSoeT3QVHgr0QMaX1H5GQE1tv3DHKWmOO066RunDn?=
 =?us-ascii?Q?dQQqswjKXwCNwRgwryjmoguoT2dSxSgfaarnvnB6l64wjMLGlheTNLdp53xK?=
 =?us-ascii?Q?Ot2S5lp5lqWkJ7JgnKEWdxhNCYOr+JyP0xeRKQNvf7coAkLGjmqXoMfRatAb?=
 =?us-ascii?Q?KMdyjOIHKRfwqDlXzNvCIvr6yyK8kIhHa+TlUuqYrqf5X2rQjV+P2dH8PXqO?=
 =?us-ascii?Q?P/XtWyaOGXoMFeYGg25ONhJOvOHvKCManepG3RGCrOJmW2t7peR4gnii+wCL?=
 =?us-ascii?Q?+lOdRiCTSTMZfCMhoE7Yk5/ZnawhdwwV8zKe0TbmShakPHldL4NVr/EB2vaz?=
 =?us-ascii?Q?q1XDKEfJ8G9ITQ5uEeIxSScN029ODH19jEoqK5ygu1Nl9eKP39K79LN6ZpA+?=
 =?us-ascii?Q?9pUOvFQP0i7jQHoiPNAhh4F5Szk3aEOXkR73St1I/Q82cQnPGzgtZ2RXMpsQ?=
 =?us-ascii?Q?wWWdiCawCtWexoEQyyPGT8cwxfnb/u3Xq+wWtHJW4IXoegW3zz3UfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:42:14.2006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a9aa8-db73-4f41-fecb-08dd7774b804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

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
 drivers/net/bonding/bond_main.c               | 113 +++++++++---------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 ++--
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 ++++---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
 .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
 drivers/net/netdevsim/ipsec.c                 |  15 ++-
 include/linux/netdevice.h                     |  10 +-
 include/net/xfrm.h                            |   8 ++
 net/xfrm/xfrm_device.c                        |  13 +-
 net/xfrm/xfrm_state.c                         |  16 +--
 15 files changed, 182 insertions(+), 161 deletions(-)

-- 
2.45.0


