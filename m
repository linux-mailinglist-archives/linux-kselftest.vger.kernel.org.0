Return-Path: <linux-kselftest+bounces-35791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A56AE8C6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7507AED92
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274272DAFDC;
	Wed, 25 Jun 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ri/dTuIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B82DAFD9;
	Wed, 25 Jun 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876267; cv=fail; b=eMbtTZNjiTLxyEvZmnZIGRIfwKQdU9A/51cmOhiKXobNK+G+ElkbUi6uJM9N2LPXpHcDsQkuEIEi0f6qeOQLbVfg1XG3AUgD8DBQVqaIRLKCLk++AFQ9TcKJBR8VgPU1rjraxccg72gf4DxNpJlzEKWWSNSkfNObeis9J37YjbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876267; c=relaxed/simple;
	bh=GcBbb8pk4OG/XQsvcb6fVOlP0s7SY2LsJD03LIbUgIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiUyH3VWdEewslopXSdwUDZTcoHNZogY7VhY0MUVuQc33dX90VNjswenN70T2fLhkqKz0IEv09y4nPv7lvqsWWUFBxPk9ZrDDCsNMh/9praRkgQPRX3W2Sk55VtV4WNDmsot2qz58L+YS1ziORBo60LpMDdCVmA5ggjpzYTTXIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ri/dTuIU; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVBbxhet66HMIf1V1QjZ9j6a/Ekcw5SxIWmUtBl0cCICD+JHSQWZHWHSLEVbnOQRlFfQW5+Mw+IiyvZhwYTfjfoCSmCd13KZ3pSjD8zvoPDZVjz+Wvc4OHmZHE9RKBrz8iBswJ2803tkb4Q5AGPc6aR8O7NtO/npcLsT4m6b9SZ6UvqRqBRhnOlDJzaotfpMIIFFFtHFnVkjPDHVCxXkSwp3x5TVgQfO//ktTMRL4RF9QNvq9Zx4ilyDL1Ga3ixBAvi8NB27+1dDCi0P1vsABZGNCoQTiV7UF/layJfuZXX7bx99MQHfIh3XhkBL5BVxCSusB31Ngyk183SeVUfSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oym5ae8zhaM47C0eXlzR1P7bpwJqqg4mPNKRWlDm/Vw=;
 b=wJu4Zu4ZbuR97T50lFE1awSjg/cJMYi5bbjaoj6QVSTU38Dm5BvPSPG3ZGyvHY1Z8MEej3L7qmh1QPRVEbICiVCVAWC4Q3VTQcK5mjQwFsAPPxea0QP6M4VcwfmrNCdBLG9eG1DOuQ+yayfBMAZVeU0TEJKLeXC0TjlSP0M7GaO/K3aFeT5i3xIZ9Cn+JppT/ZHnTNsHcv5wW7CxAkSNtxlEdZnvKSRgymXxYucOtrNTsEoA6397oOp2Qma3xLZCfqRjI3XrNs9sbo51/tunxDtjOh1E5TZiaXjp9RdG3IvIzTcp1EHCY5pzkKTIzEtGhkOuvBEUo4jsZRkaK4LS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oym5ae8zhaM47C0eXlzR1P7bpwJqqg4mPNKRWlDm/Vw=;
 b=Ri/dTuIUKAk2iWtHxKb1h0tyO/VDd2LSPVY5sPtze+b08v7AtFIF/TZ1/4ot5H9AjNq1BKsmVOExgajF63wTk2t4WcYuUhN/9gu33mV44h0h+BL/z9n9X7ailbuafpGJZzV+tN9jFNJPCGeYgnrig4rusNG5lFHHrGWHtCALufyoFvEaX6xLIR8ALxsRdO32faBnVtHqhBlmB+5m/ZTV6K7B8ADIROUr/OCDObfd8MomMuMG6Oi/A0kENqQV4fe/IaAT2yp4en+4snysPBCwQr0YkDs4xO1+/m/qBhPiizOvtR+4UXUB1xhsxG08xwA9r58ywW5bO5ruENivzk7sZQ==
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 18:30:59 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2a) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 18:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:30:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:30:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:30:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:30:34 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v11 2/8] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Wed, 25 Jun 2025 21:30:12 +0300
Message-ID: <20250625183018.87065-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaae224-9ac2-4911-6973-08ddb4166e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAGw9qSJzfSKj2JLaxupg/5w/oyYLrfZmL9JKE8BppC8IJZ4ygrFtA7gUxKK?=
 =?us-ascii?Q?WzCOdddy75uPnc+CkhkS0JHQ4XUS6l81kZbmLgiNh0n+tVE6bGubtlVKKF86?=
 =?us-ascii?Q?1p+XZjjfEnB6+Awp+b+oCPXUDN32I7NOoCjzBYm4JaDyirggdwKrjIYyJesD?=
 =?us-ascii?Q?xvNPrdaSP3iVBraRjF5LtZNe+15S+6SegZr6YiA+LmKfdDV3rYF2j4wsu8/m?=
 =?us-ascii?Q?Qzlhe2B0MHW794Vp5kcYCEfrV647c6WX1zGPcMuJooZaWloDRZXxJ3buTezy?=
 =?us-ascii?Q?FNww85scTbPo2S0kq9RZoiGKNEp0FYDLYM3+2BrKTYVe+NRfGNg3i7ANljCf?=
 =?us-ascii?Q?mjx7ftoe1v2WiFu1t7BhS8cGdmHj9Zb2QTcevy5UVvKBea/4dWfJaGViwYgC?=
 =?us-ascii?Q?qaCWAi7SmOUuOlY+bTA5h3pU1e7kSC5+M9vAG/vXo7bdjETdHiOSDTIFuI1k?=
 =?us-ascii?Q?xQdwIwBE1fWi6wTxkUnSgBiRTU4BFIy6AOYM0zc+nnQMomBDavNck9BvAf5A?=
 =?us-ascii?Q?qllH/XcUYVNXM7ylHz1KbGVm7KHiWQMgG6/O5WXwL+Y3OyUJgJTsk564dU8B?=
 =?us-ascii?Q?UibuYW8c7GWjn2XBO2q9UuZsq5fdTVK0PqCE76oyHrxBvb+/VKpfCTfvCsRy?=
 =?us-ascii?Q?aBjROQMWT7mvFumrGEISmGMlzeJQTuNHg65PtYOhiaOWR8lDg2vvz9OCA+bk?=
 =?us-ascii?Q?tBj1Sb/uWxRQ6R7klAsImnYuzb+J6SMK4mm4hdQLKUdWOMhW8bBPA6ModxCH?=
 =?us-ascii?Q?KatzqhLTfkbq3fTRSJHQ09QKQDRzleGLleAN0sru9KhjNi5PctximtyB6BUu?=
 =?us-ascii?Q?Ej7KUEkoK/M4FTvD/cdvVP5MqK80VeXnY4V9j34ETsgoTw8vxprw8Fs/KvrU?=
 =?us-ascii?Q?fBtiMOeghkIlL6gBjF9FKu3219xMoF8LSKSRhrLQlpxpuQ6xJD2Nfaq7NUE+?=
 =?us-ascii?Q?IkFu9Ug2XJlpX1IQdIkfH42E2eXqSkGPAxUGaR2SrflJBu+36y+wEzeGpQ/Y?=
 =?us-ascii?Q?P9+9jqnYxTUYKEbXvYDTD1CY6EO49DrxztINXKa8o4rQNDWP72YD908FKzF8?=
 =?us-ascii?Q?BE4WyyKiZTXwqmx9hkF1Y1epab/jm2iiGlVheYh4O99/S+bmzwe6cy+vxK3A?=
 =?us-ascii?Q?/myNvGwKDFatM8FKuQ4IggtqdwHu4pylRtGYEUg4k2GprnvI+kEERHonaLcp?=
 =?us-ascii?Q?Cc3TAeWDdBLJwcZ+CzGfqdkR9NTHLQqLi2qh5nTHO+uy6XFIlH7vci7vVvHc?=
 =?us-ascii?Q?y/7XqKooz/tXxbucKJOUjIU9Y5pfEd0Pg1xdmv6iGwj1PXrU0P1xCoWIQvON?=
 =?us-ascii?Q?xPx4GQ9sW/CIZWNCi6kzAnTRlLIP+uZbTTavfSr3hhdL9v0QRM9IGu0JvBHN?=
 =?us-ascii?Q?mKQ0CnhoJ/ymE6qPDYHgdWgXKlUuV2RtDnTJWdsN41fFdPpueld9Z6xMRLxo?=
 =?us-ascii?Q?0MY/wmEmey/vSUx2j/C/6hOekEc4nXp5EITkvgvPQMkkZPIg4NrsYePxZidx?=
 =?us-ascii?Q?Hbx6sO7kfa5nTQTuFCDh1LJZCCZqccp8V5sJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:30:59.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaae224-9ac2-4911-6973-08ddb4166e97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for specifying relative bandwidth shares between
traffic classes (TC) in the devlink-rate API. This new option allows
users to allocate bandwidth across multiple traffic classes in a
single command.

This feature provides a more granular control over traffic management,
especially for scenarios requiring Enhanced Transmission Selection.

Users can now define a relative bandwidth share for each traffic class.
For example, assigning share values of 20 to TC0 (TCP/UDP) and 80 to TC5
(RoCE) will result in TC0 receiving 20% and TC5 receiving 80% of the
total bandwidth. The actual percentage each class receives depends on
the ratio of its share value to the sum of all shares.

Example:
DEV=pci/0000:08:00.0

$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

$ devlink port function rate set $DEV/vfs_group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0

Example usage with ynl:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-set --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1,
  "rate-tc-bws": [
    {"rate-tc-index": 0, "rate-tc-bw": 50},
    {"rate-tc-index": 1, "rate-tc-bw": 50},
    {"rate-tc-index": 2, "rate-tc-bw": 0},
    {"rate-tc-index": 3, "rate-tc-bw": 0},
    {"rate-tc-index": 4, "rate-tc-bw": 0},
    {"rate-tc-index": 5, "rate-tc-bw": 0},
    {"rate-tc-index": 6, "rate-tc-bw": 0},
    {"rate-tc-index": 7, "rate-tc-bw": 0}
  ]
}'

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
  --do rate-get --json '{
  "bus-name": "pci",
  "dev-name": "0000:08:00.0",
  "port-index": 1
}'

output for rate-get:
{'bus-name': 'pci',
 'dev-name': '0000:08:00.0',
 'port-index': 1,
 'rate-tc-bws': [{'rate-tc-bw': 50, 'rate-tc-index': 0},
                 {'rate-tc-bw': 50, 'rate-tc-index': 1},
                 {'rate-tc-bw': 0, 'rate-tc-index': 2},
                 {'rate-tc-bw': 0, 'rate-tc-index': 3},
                 {'rate-tc-bw': 0, 'rate-tc-index': 4},
                 {'rate-tc-bw': 0, 'rate-tc-index': 5},
                 {'rate-tc-bw': 0, 'rate-tc-index': 6},
                 {'rate-tc-bw': 0, 'rate-tc-index': 7}],
 'rate-tx-max': 0,
 'rate-tx-priority': 0,
 'rate-tx-share': 0,
 'rate-tx-weight': 0,
 'rate-type': 'leaf'}

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  32 ++++-
 .../networking/devlink/devlink-port.rst       |   8 ++
 include/net/devlink.h                         |   8 ++
 include/uapi/linux/devlink.h                  |   9 ++
 net/devlink/netlink_gen.c                     |  15 +-
 net/devlink/netlink_gen.h                     |   1 +
 net/devlink/rate.c                            | 129 ++++++++++++++++++
 7 files changed, 197 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index ad56093d6ead..c66ea7e325b7 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -224,6 +224,10 @@ definitions:
         value: 10
       -
         name: binary
+  -
+    name: rate-tc-index-max
+    type: const
+    value: 7
 
 attribute-sets:
   -
@@ -844,7 +848,23 @@ attribute-sets:
       -
         name: region-direct
         type: flag
-
+      -
+        name: rate-tc-bws
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-rate-tc-bws
+      -
+        name: rate-tc-index
+        type: u8
+        checks:
+          max: rate-tc-index-max
+      -
+        name: rate-tc-bw
+        type: u32
+        doc: |
+             Specifies the bandwidth share assigned to the Traffic Class.
+             The bandwidth for the traffic class is determined
+             in proportion to the sum of the shares of all configured classes.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1249,6 +1269,14 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bws
+    subset-of: devlink
+    attributes:
+      -
+       name: rate-tc-index
+      -
+       name: rate-tc-bw
 
 operations:
   enum-model: directional
@@ -2176,6 +2204,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-new
@@ -2196,6 +2225,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bws
 
     -
       name: rate-del
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..5e397798a402 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -418,6 +418,14 @@ API allows to configure following rate object's parameters:
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
 
+``tc_bw``
+  Allow users to set the bandwidth allocation per traffic class on rate
+  objects. This enables fine-grained QoS configurations by assigning a relative
+  share value to each traffic class. The bandwidth is distributed in proportion
+  to the share value for each class, relative to the sum of all shares.
+  When applied to a non-leaf node, tc_bw determines how bandwidth is shared
+  among its child elements.
+
 ``tx_priority`` and ``tx_weight`` can be used simultaneously. In that case
 nodes with the same priority form a WFQ subgroup in the sibling group
 and arbitration among them is based on assigned weights.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 63517646a497..d0ce5a7e984c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -118,6 +118,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
 struct devlink_port {
@@ -1486,6 +1488,9 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate,
+				   void *priv, u32 *tc_bw,
+				   struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1494,6 +1499,9 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate,
+				   void *priv, u32 *tc_bw,
+				   struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index a5ee0f13740a..e72bcc239afd 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -221,6 +221,11 @@ enum devlink_port_flavour {
 				      */
 };
 
+/* IEEE 802.1Qaz standard supported values. */
+
+#define DEVLINK_RATE_TCS_MAX 8
+#define DEVLINK_RATE_TC_INDEX_MAX (DEVLINK_RATE_TCS_MAX - 1)
+
 enum devlink_rate_type {
 	DEVLINK_RATE_TYPE_LEAF,
 	DEVLINK_RATE_TYPE_NODE,
@@ -629,6 +634,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index e340d955cf3b..c50436433c18 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -45,6 +45,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_INDEX] = NLA_POLICY_MAX(NLA_U8, DEVLINK_RATE_TC_INDEX_MAX),
+	[DEVLINK_ATTR_RATE_TC_BW] = { .type = NLA_U32, },
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -523,7 +528,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -532,10 +537,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -544,6 +550,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1191,7 +1198,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1201,7 +1208,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..fb733b5d4ff1 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..181d443ab3fc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -80,6 +80,29 @@ devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
 		return ERR_PTR(-EINVAL);
 }
 
+static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
+{
+	struct nlattr *nla_tc_bw;
+	int i;
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BWS);
+		if (!nla_tc_bw)
+			return -EMSGSIZE;
+
+		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
+		    nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, tc_bw[i]))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, nla_tc_bw);
+	}
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, nla_tc_bw);
+	return -EMSGSIZE;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -129,6 +152,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 				   devlink_rate->parent->name))
 			goto nla_put_failure;
 
+	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -316,6 +342,89 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	return 0;
 }
 
+static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
+				       unsigned long *bitmap,
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	u8 tc_index;
+	int err;
+
+	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
+			       devlink_dl_rate_tc_bws_nl_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
+				     DEVLINK_ATTR_RATE_TC_INDEX);
+		return -EINVAL;
+	}
+
+	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+
+	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
+		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
+				     DEVLINK_ATTR_RATE_TC_BW);
+		return -EINVAL;
+	}
+
+	if (test_and_set_bit(tc_index, bitmap)) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Duplicate traffic class index specified (%u)",
+				   tc_index);
+		return -EINVAL;
+	}
+
+	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
+
+	return 0;
+}
+
+static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
+				     struct genl_info *info)
+{
+	DECLARE_BITMAP(bitmap, DEVLINK_RATE_TCS_MAX) = {};
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	int rem, err = -EOPNOTSUPP, i, total = 0;
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX] = {};
+	struct nlattr *attr;
+
+	nlmsg_for_each_attr_type(attr, DEVLINK_ATTR_RATE_TC_BWS, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		err = devlink_nl_rate_tc_bw_parse(attr, tc_bw, bitmap,
+						  info->extack);
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < DEVLINK_RATE_TCS_MAX; i++) {
+		if (!test_bit(i, bitmap)) {
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "Bandwidth values must be specified for all %u traffic classes",
+					   DEVLINK_RATE_TCS_MAX);
+			return -EINVAL;
+		}
+
+		total += tc_bw[i];
+	}
+
+	if (devlink_rate_is_leaf(devlink_rate))
+		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv,
+					       tc_bw, info->extack);
+	else if (devlink_rate_is_node(devlink_rate))
+		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv,
+					       tc_bw, info->extack);
+
+	if (err)
+		return err;
+
+	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
+
+	return 0;
+}
+
 static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			       const struct devlink_ops *ops,
 			       struct genl_info *info)
@@ -388,6 +497,12 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			return err;
 	}
 
+	if (attrs[DEVLINK_ATTR_RATE_TC_BWS]) {
+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -423,6 +538,13 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the leafs");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] &&
+		    !ops->rate_leaf_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the leafs");
+			return false;
+		}
 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
@@ -449,6 +571,13 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BWS] &&
+		    !ops->rate_node_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BWS],
+					    "TC bandwidth set isn't supported for the nodes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
-- 
2.34.1


