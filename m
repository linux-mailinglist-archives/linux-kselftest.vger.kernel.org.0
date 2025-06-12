Return-Path: <linux-kselftest+bounces-34848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89828AD7C45
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B61898677
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AC2DFA28;
	Thu, 12 Jun 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2EBS575"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A912DFA33;
	Thu, 12 Jun 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759252; cv=fail; b=pTts32u+4Rz663bhZKqW2EdYFhhkyWQ49ns1jenSV3CLpeyhbZ6XHAu9rvTIOPikIFFxZ66Ee4bGcSGYTq7Y/JX7iFEfkGSTa0oSXOOaEC6hZ0yJAqtLzjO+ay8HyclYt5mCFEbY3lcPsUrHvAnhMwQ7IQ+UswAg31sQmnRqbg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759252; c=relaxed/simple;
	bh=hdTrJhLJVMh2KQIGcZuHGZXR1qhXlGlWJuZTJh7RUh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC0Um7MZFtj3pigg/Is/zzWcJmitxrvcHyHd+p07DOQbj+3doOFS9PnyzgDuc/8pT2Ec7lQS05XAbvrC9D9qL/scWx6O9GiALgR2gqzRcUETSYXHWRb7Cx2W4tIh8lslJLdsy82ro7Vsd3ygWMdQMvNfhYOXC/kNOJL2Odx2PkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2EBS575; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSSWJpjffIkjSl9ysYQU0qZYG6+GRfw14WyUNv5Dy+nEkjpQugDSyTTPjpOnAhnNcAFW4n9T2KPGAJDdZweeMcXECkvoW3t44Id4s7p01Sa/eRtTFk4MutPD3vMVkOj9X5DGlw20K3fxG4NS3nZu/3mafz0eOn0hd+pbzDi+AvHMnxLFtXiK2oZqfMIteWfWMHyjQ/3iv8zjbOjH62G3J3905iJLD5+1pPaaKXqHX7/i41KcbINq1a9lAbTCwsLzti2i/EwpdpeYexKTW7+c8tpY9TWjqTipBEDKZJEqPAspnB4XnZi3j9PcFgoOnZ9/3Wb7tjFzJlPUAYq+bnrBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dka0KWrG4msQDu+KPBbL0UErKvp06FwU+IPZ8VJw4dE=;
 b=tiLNgwRTNuieQod9q+5HnVMSA5pAR6RDc6OhtHmrwgssKjgwdItrna+fBaU9DzeLHioXH1BiGJ0xy0uI86wUHP0ZwKJeROAcplF1FwJN2n82fbFyJ9kucUZvgOu0hpG4BR7ybK4G43Phg9rhlv002BG8Ssaj0Xg2xe+dFKh5bOPN4QQxftD0KGS7VPIC3CILwx07mRg6xuvNjyaNJZ+JUMLbzGb9fU1nvX9YXGQQtkRi79Txy41oU/BfLsaC2HeXtkGH16AUnBgCo2Lkmf+cTN5F5UTyTGB7+JfOvTLZrQWOlGNx8DU9ZUiuB/LMn8+JaFnTHrM6vI/a+/nfFKN7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dka0KWrG4msQDu+KPBbL0UErKvp06FwU+IPZ8VJw4dE=;
 b=E2EBS575beFua1DlvFkpcP9QXMb9Ggo2SrS8zHtUIX/zuVyQCDMugUIE5Bcjwaqa8Rn09c+IvTelzUVnYZq7xB3TqLj3jDer+S9SIx4n9nqldf4ThzmldzN7aqWaaddIhcox6mfKNxuM6fOcJmYq/kliSi4OgF3Ugses3TZUNIb0ySHZEYR5UJON0DJ9y9Y7wfTyhi56JV3vsLFOkhJe0bosjHipW0NvpUtpJVMntFrask8NpTBkhxJhEJdZG76x4yiXlV7MxUBdY4zic1Bhzm0R9fdHa9K2nFPsqM+7GEpaEQOFSkBDFBYijrltPpN+LU23Gnbwcx4xoUmvWAroYg==
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 12 Jun
 2025 20:14:07 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ba) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 20:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:14:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:51 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 13/14] selftests: forwarding: adf_mcd_start(): Allow configuring custom interfaces
Date: Thu, 12 Jun 2025 22:10:47 +0200
Message-ID: <14af50000810ea489ee3bba831be2341faa10354.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 30366e79-3221-40e7-606e-08dda9edaef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XoEg/n8AITT1Ax3jLMBuF6mkerIrbrLdbFUu9GndJyAu4HVZJBlCKMsw3Zd?=
 =?us-ascii?Q?m6N5z17RgHsM+dtvYEFNw/zcKv/F0JQahhvncosnRDA9Twl5G6+BI4mi584Y?=
 =?us-ascii?Q?3P1gcOuIvTI+JMHCguWOG7MlH3ZWfIxytXbsQANdw4jGXlSsJcvQW/eqeFJY?=
 =?us-ascii?Q?UhFZHWJZ+Ahm5x12MSQUR2Dr7KuOnlFBNAuTWBOyoKL/GCIYlt4pGYyRhIu2?=
 =?us-ascii?Q?3ZKjB3tT7jy0gbHBx1eoTwyKOgMiLut+jKF7vxTkHxnUBML7WSslY7ECITwX?=
 =?us-ascii?Q?N/wel0T7IvKqZA5Jgpghz6hQHJT4rVDaD8WProINzOnRloz74VVt9Ta4f1tU?=
 =?us-ascii?Q?n+8S5m3+o6Dr7+2HlfM4jUuUi24ODufHLbc5jTh7MXdzOEVbVvmU6XarqrIi?=
 =?us-ascii?Q?7QE5IeyyDMLLcASkg3tFJj6Y+JU3DRRV/YxjJWGgIkbDa0Cs262BsPDOXTe1?=
 =?us-ascii?Q?nX1AKsIwnRHuHG3qloqZflZpa3iJWaHmbAAvxGKziiFv4CSKhz2wYo0vJ+yK?=
 =?us-ascii?Q?tKHbQBx1UKJZpXYGA+37tyqL0IVS1ZMW3Ok6uPz/b7bH2Go0cDILYW5rl1bY?=
 =?us-ascii?Q?+yjXDNS1AHtSCuebc3nzuYrSztb28+4jxAxa0DHGFaGQvc1KWMs2xkemfvDI?=
 =?us-ascii?Q?zft9jFr/HdUfg1Wc+Iz0IqjibAvD2TDChYfV8aTZ8uZ6n/z6xjWixTZBt1eI?=
 =?us-ascii?Q?nEAIkvVnC3qk40iem72U2EY1W66AD9JvK6iRrEQzVTgk7LPx+SNh/z8/8t/b?=
 =?us-ascii?Q?It0q3akF6Vs2HrRuCBG5AGiSuMwJj7WGNKMuam2BMcXzN4WRApmvJNq9rZKY?=
 =?us-ascii?Q?yQSsgnDqGgTMdgybYiRav++clJn7FJG+37ZCZGdzQtCvV8MBS8KZWgtQEhfW?=
 =?us-ascii?Q?JOBucKgb/tFT2gE1uiJTM3X9UPq5N6vft3bIXpFbGV4Atc+6NA2Bh0Rv3bGY?=
 =?us-ascii?Q?45T0Bljp0FVnVPdJQggX604dhlfAiD/DnSlBfpWroUOpcrUO0yW+8pT4YQBl?=
 =?us-ascii?Q?YwYJEyb/hgvCRZ9GD6fdBsy8pI5bWFALkoWvaT64zoVL1zrkU/gQMO4q2CX7?=
 =?us-ascii?Q?Ur6HmrRMzQCGiFUJ+cEarbg+SZG/EBgPrCp3sUpFeIA1UhhAYF9NlWDwAdaA?=
 =?us-ascii?Q?DM6WMvXskkD4MJR4bPNxnWnJTX9zIgyQBes8tLLy+udJ2pQ1ivFSH+Vfudsn?=
 =?us-ascii?Q?4fwVEz6nYJ9V4VY2NJZmsxww4WihY09GuewJcYCez+eO5xge8VoEVmSorsC0?=
 =?us-ascii?Q?Kfxn6OAnJ6vxT9yaNE9i4NXlzRMsnz4Nd/05Lus/dU970yxhiv1aQkaFmSHU?=
 =?us-ascii?Q?XEgK+g0IWv/GW5NyBi8p80z/ePHALmD30+VZdW1ONH2s1bnuzRH29JUp6nUN?=
 =?us-ascii?Q?T2pOav8Lmao+PYVuWlKOJ78REjf4HpVygomp0NhAiz5LIDGT6heG+dzUaA2b?=
 =?us-ascii?Q?9DlVHvcBq1fO1TsyMjX7geeNc4rx6eNZmMPMAO4xrVgn+Idgas0kvsKUhuqE?=
 =?us-ascii?Q?GahdpXF7vxli1TerQf5bXwbtF4ilGwkMzBLf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:14:06.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30366e79-3221-40e7-606e-08dda9edaef9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

Tests may wish to add other interfaces to listen on. Notably locally
generated traffic uses dummy interfaces. The multicast daemon needs to know
about these so that it allows forming rules that involve these interfaces,
and so that net.ipv4.conf.X.mc_forwarding is set for the interfaces.

To that end, allow passing in a list of interfaces to configure in addition
to all the physical ones.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v2:
    - Adjust as per shellcheck citations
    - Retain Nik's R-b, the changes were very minor.
    
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 253847372062..83ee6a07e072 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1760,9 +1760,12 @@ mc_send()
 
 adf_mcd_start()
 {
+	local ifs=("$@")
+
 	local table_name="$MCD_TABLE_NAME"
 	local smcroutedir
 	local pid
+	local if
 	local i
 
 	check_command "$MCD" || return 1
@@ -1776,6 +1779,16 @@ adf_mcd_start()
 			"$smcroutedir/$table_name.conf"
 	done
 
+	for if in "${ifs[@]}"; do
+		if ! ip_link_has_flag "$if" MULTICAST; then
+			ip link set dev "$if" multicast on
+			defer ip link set dev "$if" multicast off
+		fi
+
+		echo "phyint $if enable" >> \
+			"$smcroutedir/$table_name.conf"
+	done
+
 	"$MCD" -N -I "$table_name" -f "$smcroutedir/$table_name.conf" \
 		-P "$smcroutedir/$table_name.pid"
 	busywait "$BUSYWAIT_TIMEOUT" test -e "$smcroutedir/$table_name.pid"
-- 
2.49.0


