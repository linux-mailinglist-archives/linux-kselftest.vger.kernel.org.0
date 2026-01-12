Return-Path: <linux-kselftest+bounces-48778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDBD14680
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1DEC3007C1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22137C0EE;
	Mon, 12 Jan 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVQ8BGcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070937B419;
	Mon, 12 Jan 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239468; cv=fail; b=FU+p8CE0AunlkLnzjVXuWSIkxpp2CWfzmQtSURzCQnpQS5B+H0MaCGoz/vm/pCtZWREMONrsDvGfLqgtu/oQiyl5gCIsxKjH74nbTrdrpbS+3rNw9+Heu5jTNe6YQY21ZuJIS2VzTb9G5VXsO1Vog3zDgYkJXgl3C6rGQniZi+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239468; c=relaxed/simple;
	bh=DHdWw0hdezTB7yyD/Eok83DhxrB++41DlHdS+GY5bNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHvXo48jzhFDO0ht6oHdb1gzHwCjH08z85iT51qvu+SgxfMUrYS5YymeDPuLJ1o9nVOsHluCJ0agrNGlFjn9dY963sApQt4AdzWuza8o9NDdNqhdCy1RNedPviWpAzj2EfgKeFhLIXI2L43FNeJH/lSaOLlDAh267yOHK3aeLpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVQ8BGcR; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnWi9xI3mvTq/hysiAG/ztR2BycLesQXA6TvaTjx7uIXxQo/qLcy2Ucxi9CG824k8jU66opWQmXBs3Zoo59xIKUSQQfc8vNFfZb366sOsA599prxG6+Z1Mf3ZdtUyBAszam6nqpW45WSoKHFRlYjvtjpsfp6Mkq81mw94xzmx3qemxSOr4j1Mh8ix9UTbEWfl5sUmienmNvpiUJhhDReVLZ+WF9QjUi3YAoOjz0lkTQ//WXjYXOrKAaXeWyyExVSR5xOOeGCPVVPgF+N1kbnsqrqoKAy8iABB2tXEu1t7y0Tj9pAOWUewVbK72b6mbrOSvBcsU2A+OIqoPZT19OFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeG/eQwjEG6D2MsJC/5BFWhuub2ywtJgs+uuPKyH3X0=;
 b=ge9Rta39YgA31C/F+X+XiBxxt3X9rDenohgHK6kKYSjl6ZXGHeiKQGee3cP+Tbk9jUZj/Hauo7g9n7TP90uzul37PmSQf97JrumP/s7PVcTkQ7SWXHAzQtRJZEUF4xs8YbOOC4cJW+vwx2QJHzTW8IoLYZ+NQPirxwA+D6fA7CDSVvg9FE0+ki8Wc5YN1UeroswuD/onsd16LN0pZN9nF6e5dXGsRxRY9J98SnZsVvWM9J8w9o4qWCD9KMtY29sxpV08AI5iNy/z6lLz0MxaMrnD2fN2ev+cm1O0ZXgl5vOerMuBVdAdrWP990e2qdTWlRf1Tz4AvHZxUWhD/+lSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeG/eQwjEG6D2MsJC/5BFWhuub2ywtJgs+uuPKyH3X0=;
 b=lVQ8BGcRgde17Tc5Vslh5J0aHXyW+KC6kkKldIFzcMtTd5YMzndmlWHsCSxVDM96wy56ChaVy2Gt70uJuScGbO82WDrbJVDZb/QXfbB5EA+1uq/rt7fOf9uaTeTEDSODHuonXR5vSInlHBkW+X4h7DDfahNICOcGB+qAUvSfeRoFNb2Ctr4Dhlkj19rNji2U99XY89uAUhWuc0g099evAmpJkIqrAwwviuMD6IZN93AY0gvwU12z/7qE15GylDFAmJroNvTnJEZB6WsonxwTacEw5IJY6WAcg/xJyhqdnIgqyylNqPmojllsyqi3CU2UmhEzGgOJpSBbLUUyVjaXlg==
Received: from BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:37:41 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::6a) by BL1PR13CA0333.outlook.office365.com
 (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 17:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 17:37:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 09:37:19 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 09:37:16 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net v2 1/2] selftests: drv-net: fix RPS mask handling in toeplitz test
Date: Mon, 12 Jan 2026 19:37:14 +0200
Message-ID: <20260112173715.384843-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260112173715.384843-1-gal@nvidia.com>
References: <20260112173715.384843-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ef76bb-c881-4d45-bcc8-08de5201492b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8pZsEWBqBfbyKYr4KDOAFqhpz8fMjLsVkcAEbYL0gh27nTrtw5IhH8mauGIq?=
 =?us-ascii?Q?RhiIZ/4o8hN25/ItpdIUVIxKWa4tClZIOYc43k5+6+A2uSAU9QlCJCKi/4SS?=
 =?us-ascii?Q?9WWtaC6KDdzLJOHmf+I8WMc7kJAMNrKNl6GmhlfGav7zuiKocGdFecADguK/?=
 =?us-ascii?Q?1412VHvZDJkKTHqrHImSjRnYcl/CyBYwNqvKGlUGhcYQHKsZGpYkoXYjic3F?=
 =?us-ascii?Q?nKhTC/EeiRY7qr9x+WfL69gia9r5loly5A/JZ/H2w0GAvJnRN71yA4HlCMNc?=
 =?us-ascii?Q?lZdKzgTeEfjOiaJO456poi3kwruzr2easTGT+OdlJGjedzWPC1MVrZ3hxZyi?=
 =?us-ascii?Q?1wUyeFNLmk/R10uK8XJ5UVl40mWDi3VZ2zvpYmEuw4uvWdDaodCrlr8cWxD4?=
 =?us-ascii?Q?IN/oRuEKk4wVQlvEGIfRcfRhKZttsRbhtnghjfMoQAqjX+NgPyDBpyZF4a3Y?=
 =?us-ascii?Q?qEk7CvObWHFkixeHHHUezSHw5t7yEs+ldRb/zYuRpw38l9jF+FaO7NUL22IT?=
 =?us-ascii?Q?8gpKScaG8nZMbn7syDzAnPGPFvBZ2YG6t8m1e6a5DnzegwdLj8dvOP57qqvF?=
 =?us-ascii?Q?xX5r3IRkRqTYDSJeavLaJA0IOZuSUlbq++LQKT6ym0PQYP8wcJpipRhFwq3d?=
 =?us-ascii?Q?b+SzW6AWlt4XSf86Ax8Qd5aAWpa6+o9lhcdD2dEXk0qcSdtPF66Z2r7aAQZZ?=
 =?us-ascii?Q?Pf5Yvrvr1Q8fctoAu5nZhkJfs+rR2zY8Y5zaAVYj8L6k1pzelXkNzWEDj8UR?=
 =?us-ascii?Q?voW5PkRCzAmOhks533lb54gez1/foCn9IyNvW7Nzgeyfb03nFsIwybU/8Fcv?=
 =?us-ascii?Q?1/bX07utrH7d94NHK7zUH/lt/XjgZyXVLb3yTm0Y+mDfNuaueM6ClYeeLiGb?=
 =?us-ascii?Q?PBCCBbHpSiP6dGbnsySXOV4Fr9SqZifXnFVLMhiOpgZn1zr/dnXq/+JI7tWB?=
 =?us-ascii?Q?rWXielfPHxuJq3vQ65+v2uZu5qBNz63Kg4I0Tgodreq0V5wM5+/WlkQdwhfR?=
 =?us-ascii?Q?PNsvQYmR5R4ZbqbzUJpnfaYIrRtIVPw6Lx3bwF4NE0XAU9gblHToY08H4CvM?=
 =?us-ascii?Q?C4QnWs4WcerxOnugSIG4PcugTaeRGyDCmdMUhZpG9rYhyLBN8GyZQuzJZUlQ?=
 =?us-ascii?Q?RDvhne2+vsXh0HkjmuNy51j5fHAv9I/OvjYtBF4liJ9prqg/TZDODWImiKZi?=
 =?us-ascii?Q?HbFu6rPpg3HNDOqL+vWWYEI8CdM4ejcuYxIdBysnc6WggI7rJeZ9pYh3TNQm?=
 =?us-ascii?Q?LJQ3TEf1KWWr+mr3o47G5SehQAmugCvu/3f6QbJk6BEJQ60pVRiXR2kYb8cH?=
 =?us-ascii?Q?fcY16FXqALGmyxVJLbVVFs7jxouWKvH/LQ28O940y5Es4dMU5DE2kM/IUA49?=
 =?us-ascii?Q?WQFEKGYm6z6epn+EFfkEHPVPrjsMztIhIjxVL/glTapFx2SJ8C69sXk1/DgS?=
 =?us-ascii?Q?LCoqfddcQ+eFfz2DPUGwsq6F5nU9ZsGQ0O3qEeq1iNrZ6EakL7KQU0dx4/+j?=
 =?us-ascii?Q?QGgmCsM1XdAAyQkIJMdHlwtL0KwTOK2pj1jl9bP0csexwmBaW4hPtCCLL17U?=
 =?us-ascii?Q?IOA5amlNCdH6bgydNIY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:37:40.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ef76bb-c881-4d45-bcc8-08de5201492b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504

The toeplitz.py test passed the hex mask without "0x" prefix (e.g.,
"300" for CPUs 8,9). The toeplitz.c strtoul() call wrongly parsed this
as decimal 300 (0x12c) instead of hex 0x300.

Pass the prefixed mask to toeplitz.c, and the unprefixed one to sysfs.

Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index d2db5ee9e358..d288c57894f6 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -94,12 +94,14 @@ def _configure_rps(cfg, rps_cpus):
     mask = 0
     for cpu in rps_cpus:
         mask |= (1 << cpu)
-    mask = hex(mask)[2:]
+
+    mask = hex(mask)
 
     # Set RPS bitmap for all rx queues
     for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
         with open(rps_file, "w", encoding="utf-8") as fp:
-            fp.write(mask)
+            # sysfs expects hex without '0x' prefix, toeplitz.c needs the prefix
+            fp.write(mask[2:])
 
     return mask
 
-- 
2.40.1


