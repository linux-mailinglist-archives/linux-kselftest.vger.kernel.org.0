Return-Path: <linux-kselftest+bounces-37804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218FB0D589
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8E0161011
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3BB2DAFCE;
	Tue, 22 Jul 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlXaujxc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4E2DCF6E;
	Tue, 22 Jul 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175658; cv=fail; b=S3If875FcNA/uTwElhUblaugMSa7VUYiQvkaseSxrXxtHro0q9o4+JzDzC4Z5tBpZX/eD9v8DRyxkkoplm1stNOTYr9kVliKbXuwRyky/XxsrByj2wd8MYetCjqEcmaIvzZ8rux0QnS9y7FKL+ANt81jrr+T+k0DrBCSpJFXrXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175658; c=relaxed/simple;
	bh=LsckLZX2+pwMt49/T5BSY27jwOA+gckcbGvRll2xOAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwItRycveNjzUr4SlXaf7laA/8vyR/wIhfKR0+U2F59RbTpOuiYvEjny5COxhOs+9fWnZ8Us8yi3dgJS4Str5fZjZeKd+DZLX3/x/TeJdQhWxbY8GFsL/4UrpC9FdYmFYlMKwZ9sgmR7tnBxOYuVBRvbYGfHP9tvIxr9eI37hBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlXaujxc; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRwStHlSvKfL5rHmsl1nIW/5CiChGSGlPJBQEH06+VvzSpDfRwsrOWuVg4JAJO9x1fFKk31ZNe8Yk+SmqnZMiAHg0yLtqBas7fiBSLjd7xSr7uOBZN/ZnGMcrwLWm7QzPWIgYCzdKI2g0Kn3FYLl4m0o5F0ri4LC/EIEiZlJt0fpKD+rTfhkQb3v4XrL36okZhk0v6EuOjtq1J3STAje5oyvMCx436VL6T7zCyfCZ6uyVwCbbc9ppN6hPUgHurJJ5O8yJGTh2y11kK8qb6gcYl9IcqtJRoeYuGVghQbOS+5iHmtYKVfTbF3VmisCZjmSb2n8tRWwAj2wZqZ3OTvLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqYOW2QzRCbACgEh/mlYEGIw2eEntpcruFrMJT5CxdI=;
 b=DHnfHc0EHKLbkWyMGpEeuUaX4E7vsIJglStLiIh88FP6jYqmO0hJlEBy669KL+YmrzHz1nDh84SgV1nNCl7Za6TuWULzpBhzcG1DvoWBCqg6N0ys+xgBqzCkFrJLg2nxKABNVDuhZxey5/XfpEhbywI9U61ed+bXuFXxI8z54Zij3ZMFBcCvfDwd8OLntnMysoRe2IoxKFdySbJHOfWboo0kp91fu7yA/3Ju9vs8I6T6uVvZ3hO6sVqLjVUBdi1lIiUCWLq76hjfJDEJiKpE9zez+5PsBId/L/K7yrFn0aaLfgXCbosshjfhqRjiHTccwJuLgCSDSST2xBIYczfLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqYOW2QzRCbACgEh/mlYEGIw2eEntpcruFrMJT5CxdI=;
 b=XlXaujxcfIm+K8agovbZ+96PBguy3K0UGhMDPk+JNdbrl7io9ts/eczYHv5S985fKdCTEW+vKGKLBDXVvGYqUz2rXxkMmOW4KVI9B4Eb7IZskxwkWdCQFSWf4TT9LGDOT+J5az4Vq/rl7GMq0nPrWL8oc5vqo+lBYojyr98YTYoTilAeKSDQ+FlG8Dpn/1Pmf7Q9fTL7RuSEksAI8PrFw114vKGxqDbtIJ7eB7iARbl4xo7/4o5G+8C2BFwxElIFMFNPACBhSVq/Bi2iYbqrNpgB5/Gkmuqc0jDXmuBoVUlQYs5CT7XrdllBy9mCatySWqnC+ZBBAVnYnzKpsCudGg==
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:14:11 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::70) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 09:14:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 02:13:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 02:13:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Jul 2025 02:13:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] devlink: Fix excessive stack usage in rate TC bandwidth parsing
Date: Tue, 22 Jul 2025 12:13:29 +0300
Message-ID: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb608bb-8022-4d7c-3dcf-08ddc9001f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5bvFjkwt9wo2DKJ6o/J2jHVSA4vVtNlql0GsDnpCo9waoZyXeVeSuif3Rm9z?=
 =?us-ascii?Q?fDk5AZPNqKxATnYdPocSzsGpdoOoOvoVdxcaImn6ZjbQ/VLO9EBTLfCX6Yer?=
 =?us-ascii?Q?3Fqm1MV8MOAD2E9aNnpRNPpI58kx2mMfM6IlRi22hzHqqyO6d0bn7Tvivj7C?=
 =?us-ascii?Q?1zYX1VYMWGDwXyPH/grMcY56csSbiLbkRS/b613iKOgqjX7PMrpF3e/oLlff?=
 =?us-ascii?Q?6UPUfwg9/G11PovxUAh0lPKNnll2bvlGJTj2A1yJKuU8iJkZkpT3jJ3ByD3P?=
 =?us-ascii?Q?XnVeiNgc7xm6V+wptaV10Q+pqmOOyQ8nxWrP59ot4H5/P7h+mJmoezlqYnmT?=
 =?us-ascii?Q?fjrhpXw/8K29wEnmMPghz16mEGf1wYTFmKnJ1nfCFpy2nJoMrzqEfyPIrQ7l?=
 =?us-ascii?Q?kOX5MFuP0VP5yYYioOdCK/F/lu9I8bWjupY61HjNf/Wgua+aIcEqHwY2EjPe?=
 =?us-ascii?Q?ZZFTvx0UHoWv+CAbuuysRmj09v+HpEiSXp9rZehqrP3qka8LhyfT7mC5iiFU?=
 =?us-ascii?Q?Se78yppIY3jdBdAMTTmta+w8X+bTEOT8sgYKmXpNEGvAeiKpjgSu0RnqE+2Y?=
 =?us-ascii?Q?sVJEj38s9jpC+tdTTdRoXGYmkeyU19RTv04bPFz782KKJ4j0fSMhrtmvMgC8?=
 =?us-ascii?Q?UrB4VjW/cFA50MQQGCS4nVWIY2h/FUwOuz6N55hgZ0+1L8IhOC5WeVjcfjHo?=
 =?us-ascii?Q?4TAxK7J6CkdwRrIBSE4DkbG9FcitvNGBMGhkvGFd/8qVVSnxqzE7lTxlVLFU?=
 =?us-ascii?Q?3HJlJ1BHTtV6m8hTx8olTStaToywqebjIONM4FefTwVmbYv2OTmJQYC4ilxd?=
 =?us-ascii?Q?rdvWh+NJVVxVFE8pbQn9YD+7ApDVsEdxfGyR8HPo4H476noil056X8RWL4T4?=
 =?us-ascii?Q?IQ0f9e3YI2xA2Cc9DjjEDPbJ+bW8lnBe1YFL6XcYwkOdNvbrdzN/fj+nLSQF?=
 =?us-ascii?Q?kYtc76r/0vfrJ5cEJ8viKUWMBt4Z0I+DlomR+GtS3DZTlB9ovN9ggUQWAPOh?=
 =?us-ascii?Q?x9yLtyvz3oIkbrdgxEb3kogu6Tt/o0v+84jWEK3VGFtMn7VR08vLxbniuEXh?=
 =?us-ascii?Q?OFy206UE9j1c8i2ie6ImZupO2Dh+AFw2p2exjaUicoy+G31GFGChjCKh4Sbc?=
 =?us-ascii?Q?++8gYjM6Ved95oOTNExi239hDG/6/oEme2MmAa+aGroy1ILVKATQTCd3f38l?=
 =?us-ascii?Q?8znR0O7cqMxUn01ga3+bQwHw06zoXhu9WXeupPwMKpSarmmOKSdcHY1KV1In?=
 =?us-ascii?Q?A3PcNaiKKSvRkX86hcmrNTvrftRuZ+OyMZkhrH43HAiIARlpu9wuO6kUmKpU?=
 =?us-ascii?Q?JLeIzZ748HMDQmsXunYk+2VieH/V+sK7GfcGOC5qUw5O2ksYNuZCA0xxO+PT?=
 =?us-ascii?Q?tIET12kl4sNRyaQO9w2wJj5VZYF2/QUqk01LNCGGcng80RU7kR2z+YUY62vH?=
 =?us-ascii?Q?u9dRBK1g+Ip+Z1RS4MtCnnnYYWNtxa+k7i5FGgaX0Wvt5hgWuy5atBfy+Usd?=
 =?us-ascii?Q?C8xQMkFkWOQhcKU6IXEVMq8Jh8X2sUY4f52SF09I8WM2xjK+RcAZhGBPig?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:14:11.5747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb608bb-8022-4d7c-3dcf-08ddc9001f2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

From: Carolina Jubran <cjubran@nvidia.com>

The devlink_nl_rate_tc_bw_parse function uses a large stack array for
devlink attributes, which triggers a warning about excessive stack
usage:

net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Introduce a separate attribute set specifically for rate TC bandwidth
parsing that only contains the two attributes actually used: index
and bandwidth. This reduces the stack array from DEVLINK_ATTR_MAX
entries to just 2 entries, solving the stack usage issue.

Update devlink selftest to use the new 'index' and 'bw' attribute names
consistent with the YAML spec.

Example usage with ynl with the new spec:

    ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
      --do rate-set --json '{
      "bus-name": "pci",
      "dev-name": "0000:08:00.0",
      "port-index": 1,
      "rate-tc-bws": [
        {"index": 0, "bw": 50},
        {"index": 1, "bw": 50},
        {"index": 2, "bw": 0},
        {"index": 3, "bw": 0},
        {"index": 4, "bw": 0},
        {"index": 5, "bw": 0},
        {"index": 6, "bw": 0},
        {"index": 7, "bw": 0}
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
     'rate-tc-bws': [{'bw': 50, 'index': 0},
                     {'bw': 50, 'index': 1},
                     {'bw': 0, 'index': 2},
                     {'bw': 0, 'index': 3},
                     {'bw': 0, 'index': 4},
                     {'bw': 0, 'index': 5},
                     {'bw': 0, 'index': 6},
                     {'bw': 0, 'index': 7}],
     'rate-tx-max': 0,
     'rate-tx-priority': 0,
     'rate-tx-share': 0,
     'rate-tx-weight': 0,
     'rate-type': 'leaf'}

Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/netdev/20250708160652.1810573-1-arnd@kernel.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507171943.W7DJcs6Y-lkp@intel.com/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Tested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      | 26 ++++++++-----------
 include/uapi/linux/devlink.h                  | 11 ++++++--
 net/devlink/netlink_gen.c                     |  6 ++---
 net/devlink/netlink_gen.h                     |  2 +-
 net/devlink/rate.c                            | 20 +++++++-------
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 16 ++++++------
 6 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1c4bb0cbe5f0..bb87111d5e16 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,18 +853,6 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: dl-rate-tc-bws
-      -
-        name: rate-tc-index
-        type: u8
-        checks:
-          max: rate-tc-index-max
-      -
-        name: rate-tc-bw
-        type: u32
-        doc: |
-             Specifies the bandwidth share assigned to the Traffic Class.
-             The bandwidth for the traffic class is determined
-             in proportion to the sum of the shares of all configured classes.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1271,12 +1259,20 @@ attribute-sets:
         type: flag
   -
     name: dl-rate-tc-bws
-    subset-of: devlink
+    name-prefix: devlink-rate-tc-attr-
     attributes:
       -
-        name: rate-tc-index
+        name: index
+        type: u8
+        checks:
+          max: rate-tc-index-max
       -
-        name: rate-tc-bw
+        name: bw
+        type: u32
+        doc: |
+             Specifies the bandwidth share assigned to the Traffic Class.
+             The bandwidth for the traffic class is determined
+             in proportion to the sum of the shares of all configured classes.
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e72bcc239afd..9fcb25a0f447 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -635,8 +635,6 @@ enum devlink_attr {
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
-	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
-	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
 
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
@@ -647,6 +645,15 @@ enum devlink_attr {
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
 };
 
+enum devlink_rate_tc_attr {
+	DEVLINK_RATE_TC_ATTR_UNSPEC,
+	DEVLINK_RATE_TC_ATTR_INDEX,		/* u8 */
+	DEVLINK_RATE_TC_ATTR_BW,		/* u32 */
+
+	__DEVLINK_RATE_TC_ATTR_MAX,
+	DEVLINK_RATE_TC_ATTR_MAX = __DEVLINK_RATE_TC_ATTR_MAX - 1
+};
+
 /* Mapping between internal resource described by the field and system
  * structure
  */
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c50436433c18..d97c326a9045 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -45,9 +45,9 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
-const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
-	[DEVLINK_ATTR_RATE_TC_INDEX] = NLA_POLICY_MAX(NLA_U8, DEVLINK_RATE_TC_INDEX_MAX),
-	[DEVLINK_ATTR_RATE_TC_BW] = { .type = NLA_U32, },
+const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1] = {
+	[DEVLINK_RATE_TC_ATTR_INDEX] = NLA_POLICY_MAX(NLA_U8, DEVLINK_RATE_TC_INDEX_MAX),
+	[DEVLINK_RATE_TC_ATTR_BW] = { .type = NLA_U32, },
 };
 
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index fb733b5d4ff1..09cc6f264ccf 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,7 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
-extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d39300a9b3d4..110b3fa8a0b1 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -90,8 +90,8 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 		if (!nla_tc_bw)
 			return -EMSGSIZE;
 
-		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
-		    nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, tc_bw[i]))
+		if (nla_put_u8(msg, DEVLINK_RATE_TC_ATTR_INDEX, i) ||
+		    nla_put_u32(msg, DEVLINK_RATE_TC_ATTR_BW, tc_bw[i]))
 			goto nla_put_failure;
 
 		nla_nest_end(msg, nla_tc_bw);
@@ -346,26 +346,26 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 				       unsigned long *bitmap,
 				       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	struct nlattr *tb[DEVLINK_RATE_TC_ATTR_MAX + 1];
 	u8 tc_index;
 	int err;
 
-	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
+	err = nla_parse_nested(tb, DEVLINK_RATE_TC_ATTR_MAX, parent_nest,
 			       devlink_dl_rate_tc_bws_nl_policy, extack);
 	if (err)
 		return err;
 
-	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
+	if (!tb[DEVLINK_RATE_TC_ATTR_INDEX]) {
 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
-				     DEVLINK_ATTR_RATE_TC_INDEX);
+				     DEVLINK_RATE_TC_ATTR_INDEX);
 		return -EINVAL;
 	}
 
-	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+	tc_index = nla_get_u8(tb[DEVLINK_RATE_TC_ATTR_INDEX]);
 
-	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
+	if (!tb[DEVLINK_RATE_TC_ATTR_BW]) {
 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
-				     DEVLINK_ATTR_RATE_TC_BW);
+				     DEVLINK_RATE_TC_ATTR_BW);
 		return -EINVAL;
 	}
 
@@ -376,7 +376,7 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 		return -EINVAL;
 	}
 
-	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
+	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_RATE_TC_ATTR_BW]);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index 820d8a03becc..835c357919a8 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -208,14 +208,14 @@ def setup_devlink_rate(cfg):
             "port-index": port_index,
             "rate-tx-max": 125000000,
             "rate-tc-bws": [
-                {"rate-tc-index": 0, "rate-tc-bw": 0},
-                {"rate-tc-index": 1, "rate-tc-bw": 0},
-                {"rate-tc-index": 2, "rate-tc-bw": 0},
-                {"rate-tc-index": 3, "rate-tc-bw": 20},
-                {"rate-tc-index": 4, "rate-tc-bw": 80},
-                {"rate-tc-index": 5, "rate-tc-bw": 0},
-                {"rate-tc-index": 6, "rate-tc-bw": 0},
-                {"rate-tc-index": 7, "rate-tc-bw": 0},
+                {"index": 0, "bw": 0},
+                {"index": 1, "bw": 0},
+                {"index": 2, "bw": 0},
+                {"index": 3, "bw": 20},
+                {"index": 4, "bw": 80},
+                {"index": 5, "bw": 0},
+                {"index": 6, "bw": 0},
+                {"index": 7, "bw": 0},
             ]
         })
     except NlError as exc:

base-commit: 3fc894728fb3a0d9282e81247b68c07468fe2985
-- 
2.31.1


