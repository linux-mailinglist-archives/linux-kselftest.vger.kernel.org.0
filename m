Return-Path: <linux-kselftest+bounces-31608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0486A9BAD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 00:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA259A05EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484127F74E;
	Thu, 24 Apr 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JY6P7qnM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE914E2E2;
	Thu, 24 Apr 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534279; cv=fail; b=SixRlsqixvxHHOop4QSzxgqUk0B12Fga0M/VWB6ex9uVUTJRgSD1zpuwm5dAzx5obRTPJUQRgmxfpAj7TXT5WuaZQ/amIhbhYUxB+gUh1t/iTel4vmNwUaTlt/LTh8ZSLqh6XBqJKM4WJdzuPu8QhmYxBCiMrKOzI8/6q3/ou6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534279; c=relaxed/simple;
	bh=WUHZRMNPoUpswt4ry5Ap1yYOuKDitF55F0hjaLWm2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e73h66b3nJ7U+2cLV6td1sBipNzhrF3mmJgDT9oj/v2HyoHgijTW7Pu7MPeq4R44I5hmmJlJKqw3Zo8E21lAnoZ8nNB/oCpz+nlyYr9+gZgvmhhU+GrZsHzSI+QokKFquyeytb8++4lJnvQqPhmJUOURgnbevHzmwYuDIqNJRCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JY6P7qnM; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHE18wMJQ+CdFgBIidFf1GC9742DMoZodiEZeQmMQHtN0DiXyyw8kHnpv/crACyy3+Vct65y4fZNgo4y9a9I1ODUxke61cH2fY6nAqtz+039MVJ+RWVfzG/EFqksa+VqOFjZOWsjJV6lDReRXGfbpCj/kFECTFeF6D4mlXJIwGeoxig7LW+DuPYIdcNjWV+X/n7JF+6IXBO7s+IWYv7MnX/ePj0R8OaDXgP2IDKdPwATZRnYWgiyHF86Wn4R8KPd1ZYASIAzaVxt9umNDTeLxlCloabmd3o/lOIBheHgJhid7nQdTmhhgzQkbSIW8MQYMvWAfMtEbPu9d9fOnWa9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXB5E+wAtFrZnGG4K4agy2r4zvl1HOdzLniBwtSH5VA=;
 b=GtH44tzBkMyrNnief7nZyfwZ7IXq/8DNw4S2S4wR4Lx12OrhMF2SpSJ7PAX58KTTlsCo6wU1kpL5HCeGA49PF+NJCIe9T6+b3wli+YAGR0EPyNq2FrRH4L4uq0zqTbAWD5+kfKysU6Z38pqVpbMYWR4SbYA0sImshYsIycepOoMmOePGpTI0IIDBZ3smOFYWaxMZiOeY4PrDJigcvKgMo5yG+YSXEOC4rvBY/R6y2qdU9un03jjPs/zF/Lgss0KGgg6immEttYA0ytfZ5zBEWVDzTWgiQ0XD8Tzma3cg0l5FSphMXEutfIH4dfnXeWlmYWN5JPlm3VvIv/duif3/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXB5E+wAtFrZnGG4K4agy2r4zvl1HOdzLniBwtSH5VA=;
 b=JY6P7qnMACq9YhJXhFxf8POxSQ/N0v+EjCQu1lIyYyyYW28RdWL504gBk/zzbDkRVs7If8a9A4WJl/gDKRxNbjlnviQ7a96/GSzObhNzPdJ3dFNdRd2NZH0IVjPH9M6Fa0EC3luJIod9FysQhtZTrqDEOwSayvG6lckOP1X3PV5x86555esIfri8PbqLgZwB1ZzO4xLdpm9/3u/8kaQQ5hlT94mBTv6vJb2RrHKA9OOVOC7vlaeK7+TFNUccOc77jo/ShjFi8k01OedIWWH85LNvoni5Qg0poXGPYTCACSsRtZ+fcFZUh8w3Tm9MB3Ols8/sRXKVejN1AlPkpEWHiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10396.eurprd04.prod.outlook.com (2603:10a6:150:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Thu, 24 Apr
 2025 22:37:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 22:37:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
Date: Fri, 25 Apr 2025 01:37:33 +0300
Message-ID: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 8053ff62-53f1-4838-c513-08dd8380a5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHDIyfeqV4UPm5R7aAAZ25vaR7Wlpjg+c0YNhHCwcgP/5YfYINjpRelKbk6X?=
 =?us-ascii?Q?2HHyTn0mcL5esdxuQDXyxxpmgXvBU8cH4k438Qg6zNyCRrOzCNlyc0OxXJxL?=
 =?us-ascii?Q?VSA5lHn5gW6sSirAS1OOiSmlacsGKngYTNlIOzLk6avZiyVXCUKDmpXrCmqU?=
 =?us-ascii?Q?7IZqVrvCj173KOGvEjfzlfoU0pRbGmVwAPB6qBTejWjRbtBKkp4DYBmedKov?=
 =?us-ascii?Q?erjcZrgw4i+1TJkB9M+u3w9AXnelcV+u1Nua9t1uaiWxnE275mWJybRX8YUb?=
 =?us-ascii?Q?rqrUpivpX7P4J9wTAYNzbcMh/5cX1OeqSGdrjc6021+xRICLlxr578BQ0er/?=
 =?us-ascii?Q?bicdACr3IxrRLchwa6miz44O8GH5mFHRqRKcltTdN9sfzi8wIDCgteaVaRIP?=
 =?us-ascii?Q?7YtFS3JdpcZm7AQXkgVYI/4OsbT0/UmzDxM2nebhxBCBu72PHQ+vwQop4yeL?=
 =?us-ascii?Q?+BzP71qup3jzpGP6LUjjQhwx0MuxKWmDvvQ8mHCND7m9ij2T+uojPgTKDPgC?=
 =?us-ascii?Q?NZ3LZlj9lSfugwnxpNxxzWiOWScrLqBvL7Abw5PoRKChEoj0cPTsRXjdzk5O?=
 =?us-ascii?Q?C6JuIDyj8/Y5R76oSQ0bZjTtDNYXlKnTfyh0k+M4PLsAlUYVWRG3PzqwBzG+?=
 =?us-ascii?Q?51u6phs0Kxn/odzF9M7D7bgJ+h0Z7IFt/3YqUO66kHKxnfDswObHB8bTzmaF?=
 =?us-ascii?Q?QuZSIV/JVo6/F6ONsq/Idyt2ujvbYr9DlZQ7FqCfbg3/BDVm7fo9r3BwnTEn?=
 =?us-ascii?Q?ryYViNdjgz8S8lDp+1B4EBCWRNIqujwnjzqNhJWf7ULFo31lyIs5pldE1e+2?=
 =?us-ascii?Q?QSYDoz1el4nHNgwCubh55t6pHTpDc+rj/Wk06bbO6ekgUKXonblXsVRAnpKp?=
 =?us-ascii?Q?ZYuYv9Cdf9dxRqZ1zshDtIYirW+z8JmN3gO93QVBpmeT8sD4443DyAswZagN?=
 =?us-ascii?Q?GGOEm9cS0z6pTFlumEJqR9sg5UerAIhVN8DBQMdYg0NxCXSyk66iQM8g3heG?=
 =?us-ascii?Q?N6dv0rZVdhuAvA2gV70ojAFCRU/46RYf0pRLPE9Z18YocOTpl0NCsJ7WQ16/?=
 =?us-ascii?Q?eiJbeZUisUf3Fqh1WTlAUOANTOnA7JqsSvSA/Gan7mIjUJBZTlX83q8vJw/Q?=
 =?us-ascii?Q?h7HBnPNGFPKs8yVAi5Ikf2kewUS9Qz0KJw5oGmZso40Sm2FJ76EFnac3g5NF?=
 =?us-ascii?Q?wvdUFcRd34eQbgefWoOmEiNObtM8viGlXm3cescJumTjg4Ov5ZNUVrXgfl2K?=
 =?us-ascii?Q?5QlRvOGQxI+i+WKGE2DhXjk77R2/sxSMEv1cNNPTwu37rqAigfI8c58DkAah?=
 =?us-ascii?Q?OIZTXo6Vo3DlgrOqJWGah8qMpEwb+hedyIE0/6H3CiKYbr2hbVDARf2D+3UA?=
 =?us-ascii?Q?+ylRYSWLCRkVBCCv7E7tT0PLL/VRt4A6TEEF4sNBDAGQt6ewlXnFdxpuW/1v?=
 =?us-ascii?Q?fda2eDbh4W5IefoQfWX3pgd6DslfvFTG/UXq7j+1c93XVWFM/pvmLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qpuujjd6okwQJhi7UwTWYfYBKE0djJPyXE8eljNCEnDY7Bi4HYHrc3tTuiVQ?=
 =?us-ascii?Q?obsndLx/ponfHnKWisocrvdyYkK4uF4DtB+d2/clYoK+ItlxUW6Gi5ha4mf6?=
 =?us-ascii?Q?jiM3rvdZC6NO0p8DcIUc/+vPre9Gw1oBe+5gAYqabtU994rofHbynY0z1vvy?=
 =?us-ascii?Q?PyHHKKI5Js8bbdnKSvSdpvWEI1yq+BxYPfrmSdnoLZCvWNidxcaHQFXR25gu?=
 =?us-ascii?Q?Eh0HWYPx5tKnEGiAVyhSx5D9K45n0Zz989ZCHIYTHNlZFmfxzDApGE+i1N/b?=
 =?us-ascii?Q?6Ad9L5HnDObh1FFEXuh8auj+GfBtCOMOKts9WDVY9qk+ZxXn6tndadIxM7ph?=
 =?us-ascii?Q?F5l9PO8PGAyK4Iy5j5gVjCyWIHihOhUrUAowEBseqQCJBTdupX0CfZmm0Mx7?=
 =?us-ascii?Q?l1JaC5V+mE215nPjLCx02YD9IFtZ02L114FNIcnKsx8hUKidaIh4XNiWUwaY?=
 =?us-ascii?Q?/UDMO/aTh5F2OaqEetyt2K4hJbm4/d2DCDrVbbgiqJEp6mXznuSNd5u7ULeS?=
 =?us-ascii?Q?F842f7m+9AMJJNGV3ZBDlCaqmrUiyrPTQqzcaxKeWl1XHdF7BiAK0AAUlfNJ?=
 =?us-ascii?Q?LDtkPf4i8K55CPfvE/mzcy3PqwIgJzXbMVXLgu/OIOZKQRF6DfdgH8SoULT8?=
 =?us-ascii?Q?hKxI1ZnLSl30dI/Ad7iSlDW0AdWnBwI4ZnJYermCwf4UAkIc+MEoBPkwtS5z?=
 =?us-ascii?Q?EMCfqjcWfMb2h/nU7v8H4sqmnNoL/RWIdamDCPCpVuy1ntpULfDeWbTiqh3I?=
 =?us-ascii?Q?Mkw5EzMPTfqJcjjxgzlfeeRJDZSOPka/+gAsIPb7wVri6P2rIa/9pqIu6DqD?=
 =?us-ascii?Q?q21I9MHNdw7bkBQdo7YeWKz7ZBfXeVR69oiIhkkKqf+S0cQtyHzUtDpZ7f1O?=
 =?us-ascii?Q?VKJNPR4IRGYMxHFPfJYGFB6XdHVIqtNKgc1s4DF4SHm/KcFwSDdyN8d3JfIs?=
 =?us-ascii?Q?Ul2oaLgDfxMzi3ct/KWQSbLnM8SarIc7pU5CE011egNa0Cw/9by0hovXr7od?=
 =?us-ascii?Q?Tml9CsVvqeHvRVjPOi0rL4oXVk9PFl57RpG4tpk3gVg30ZfIflxnbKn49eS/?=
 =?us-ascii?Q?vxQJ3uRH+mBK5k8ARcFqkKe2O7n2Uu5Izsc/LMTE8Ca7U/l8Txh2P/iUcoS+?=
 =?us-ascii?Q?oZj7/CvLGVqy5EMT4OFhr1I6EqrgojH+s4Gf6d6UyLyclmXwimVp4gd5D5Pg?=
 =?us-ascii?Q?LlL7kaD53gLOElaHbkqw/sd8gxwFO+EGWC8ezQAdC/nEjD9NfV10VWx1Ss1K?=
 =?us-ascii?Q?ywX+Dylwk2/HwuV4BNilkjvwqVXITPc9HsX3HeWrcTlboOgT3goYFMQUMFY2?=
 =?us-ascii?Q?rJgEFDxudghVmaTZEDhdQdB9kv5PhRJjIWKIA4n5IMZdXgBvJt/s9Apsc9nm?=
 =?us-ascii?Q?LstfxnaqVfZY/ZEyI9ftlqpVPeiSHvPmoQni3AOqZkdrXbXFATWZV9Ev3YK8?=
 =?us-ascii?Q?TKuT9H//XRfZoYucEANeYzO0s5DEaGF1r64G6TaljgQfbrQt1ejp0a1V2Iiq?=
 =?us-ascii?Q?B0gEtMq2LGF3qPkbYEj5u0a6RWmg0K3JnVMKQilBppcecjV+2rHldV5DLXen?=
 =?us-ascii?Q?Keak2r4spHn7PzS60hOBbvOyRF/CISe2nwW724ZKwx6xX83H3mGLePuY3VuK?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8053ff62-53f1-4838-c513-08dd8380a5d4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 22:37:52.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IegXvH/2IrsUtGaHjBbYyfkQWn3JRIPyBFNEw94aEOfodbszVd8KggqGwWWqiNVuuwfCKMjku4EfEvUlDev9iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10396

The following set of commands:

ip link add br0 type bridge vlan_filtering 1 # vlan_default_pvid 1 is implicit
ip link set swp0 master br0
bridge vlan add dev swp0 vid 1

should result in the dropping of untagged and 802.1p-tagged traffic, but
we see that it continues to be accepted. Whereas, had we deleted VID 1
instead, the aforementioned dropping would have worked

This is because the ANA_PORT_DROP_CFG update logic doesn't run, because
ocelot_vlan_add() only calls ocelot_port_set_pvid() if the new VLAN has
the BRIDGE_VLAN_INFO_PVID flag.

Similar to other drivers like mt7530_port_vlan_add() which handle this
case correctly, we need to test whether the VLAN we're changing used to
have the BRIDGE_VLAN_INFO_PVID flag, but lost it now. That amounts to a
PVID deletion and should be treated as such.

Regarding blame attribution: this never worked properly since the
introduction of bridge VLAN filtering in commit 7142529f1688 ("net:
mscc: ocelot: add VLAN filtering"). However, there was a significant
paradigm shift which aligned the ANA_PORT_DROP_CFG register with the
PVID concept rather than with the native VLAN concept, and that change
wasn't targeted for 'stable'. Realistically, that is as far as this fix
needs to be propagated to.

Fixes: be0576fed6d3 ("net: mscc: ocelot: move the logic to drop 802.1p traffic to the pvid deletion")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index ef93df520887..08bee56aea35 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -830,6 +830,7 @@ EXPORT_SYMBOL(ocelot_vlan_prepare);
 int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		    bool untagged)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	int err;
 
 	/* Ignore VID 0 added to our RX filter by the 8021q module, since
@@ -849,6 +850,11 @@ int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 					   ocelot_bridge_vlan_find(ocelot, vid));
 		if (err)
 			return err;
+	} else if (ocelot_port->pvid_vlan &&
+		   ocelot_bridge_vlan_find(ocelot, vid) == ocelot_port->pvid_vlan) {
+		err = ocelot_port_set_pvid(ocelot, port, NULL);
+		if (err)
+			return err;
 	}
 
 	/* Untagged egress vlan clasification */
-- 
2.43.0


