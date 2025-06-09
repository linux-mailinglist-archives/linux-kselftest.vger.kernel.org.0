Return-Path: <linux-kselftest+bounces-34519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A1AD2820
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AAC3B3963
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889E221DAA;
	Mon,  9 Jun 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hhzQJHc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1921FF59;
	Mon,  9 Jun 2025 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502370; cv=fail; b=dLc8NXbwRf3XtYNxpCE9SDw8TRcnW4CMi+lhQIv/q499Z+uIt62ppjOebz+IlCG2dFuEHZouChmiNf+muxq3WVA80q5LRu3bzjqrFAH8gIyNT/ZHKoRMl1vge9PYp3fngM9j4grNP5KQKysOA5nZc3a0R8AUL3Uyc1u+OP5aZWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502370; c=relaxed/simple;
	bh=dYbgL3nwQyIY59oL/gPeygmvwaVubTAKQ9/+p2+pl+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCO1ME4n78hhljPvVgWCPGySfGwq/WZWoaEFXx0PyzI1iz0p3higH3aa+b6/pmd0iPZ8oTZ4YxXXkrKRZXy12N3fpd0Clk91HCyt4nQ0aY0AMRHnBzNVA0dHby6iTugg0oCyXI8/6jAWhQ2bwY+gPo4+MBjlPD5Ya0dBBkEbZhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hhzQJHc7; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSf5WsEkV09HQYMr/BXba9eqxiUaC7jg2GkCT/DrUy//6X6rFWH0/UDa0S4XJPJDHvitexQeH7cqV7tPntKELPDmyu7ScgNOVoxCOaQyiulrAtd5MoneuM9pWGm2kztjaOTa7Nd+Vxp9IXnSVGtd2cGLoDCQTKnBgE1skYSxzmXApPzX95ZKvGeC6IcG61qHjK61joJJC3q1WPoSXVw3HwmO55N2prHHnZKAYRLDE0cqmKjhf2ccz4OyDApaBowKST0oGOP3rPKVM07AOJa7djLoPzj9b6falG3KclBOKz1tNukfi2OwEHsrWAQZlt375WkMWA+7EL0mu63zpW/BEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlY+pAR43LsgkfWbCSlyCBdn94YLLr4S/b5zi/c5kms=;
 b=OjDoxsPAptJLGU8rthbOKhuCrcHQyp3f8R3OgzK8nVvrBcPlCNodMKQcG5G9MfFCDloAuzKj/mZA1lSSNQ9XFyMBbHtF3p+KNjyAOZ4mE25ZN5dxAFzvwbCnnd9hLPOo+00RUt4UpxZCxq2AwIMH7ajQhIL5mQwJPXe3hhL43iNhyBWQmQah/dVgyTMEYWr8t9YtTU9tKhVyrYsAF8hGEC28IbRDICC4SYvZ6bLt87PBiCNkpborqRp9wfVHwewRaD63/8MWYmlqMji7wjKoEDowUD38JUVD4MwEiP5qYovjHJVN1Zic/PR5DiQKn807+ZxfxEe6iCdP528KLVK48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlY+pAR43LsgkfWbCSlyCBdn94YLLr4S/b5zi/c5kms=;
 b=hhzQJHc7AyWaKFQAWO15DCEG56Ivb+31kKexGN5jr/h3xDg8WuZ4RO+v0hiFebJvGNyItVSfcQkg8rixTv3pO3QdxUdqZCMg0FxL6TcWjDAPZhvwEBs0Mf5rwMh2yEqwuJk7BcIMFnBS+boCcs0DT+sLjYg3j4jEEoHcsYxNmGdmyJ8E8uEnxGNXn0vnfdgy7fHh6p73FX3pWUhc0thMDHqB8GplOj8AuL2SXCKFSPwUYbvOZy4gIUUuQtB3Il3/0am96t9eKCSgMEQqCCDkuisv95K8k6IFKEYYgw/wO7N1nC3BVcd1lV6z0dP3rDWZE3At6z3HXWQRCgjNKo16Tg==
Received: from SA0PR11CA0085.namprd11.prod.outlook.com (2603:10b6:806:d2::30)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Mon, 9 Jun
 2025 20:52:40 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::14) by SA0PR11CA0085.outlook.office365.com
 (2603:10b6:806:d2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:24 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:52:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 13/14] selftests: forwarding: adf_mcd_start(): Allow configuring custom interfaces
Date: Mon, 9 Jun 2025 22:50:29 +0200
Message-ID: <29c1dfbb4882222661fa1546f125d55d72aa74ab.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: cb791225-4807-43ff-2d06-08dda7979290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmlY905dInd8oh+fN4rjH3FQ+2YZS2/fUIAMs9F9pqN4eCk9F9CyCrt6BsCi?=
 =?us-ascii?Q?kjBhHyKhj018GlWuEv4zgxYJjyFg5MX+fGY75Knfmhr2OO45ewAVTVMz0ZPo?=
 =?us-ascii?Q?jrjMBgGfqpsANkptHOZhOtlOx4K0Rhz19Aj+4l7W1XmvckFf05PPff3vyVLE?=
 =?us-ascii?Q?EmFREmsAf1OU9Er76s3SJN7LkRqhcQQBHZcHOpZP3CqkAgh2JaRIptsq0WWR?=
 =?us-ascii?Q?oF/ftkECAq4TVnIekFuFp2ElkVW/r8ki4Q3/1ukfyVTs682RlGA80SKChDpS?=
 =?us-ascii?Q?EHAD0IixGBC2qoOoyVHt05V0vzprK0dJ10SQ1cZlAGQ/dfw023HnoEFNfR0U?=
 =?us-ascii?Q?4GJdxi1pdaittsOZwH1yOn90U/Fy1AlZQcOYNFwYd9o1S0VT+CuTuE0KtfHM?=
 =?us-ascii?Q?r6T7FONKFz9vS8YJyIw/H55QIJSUnSAUALJalGNdrcKxq8r1EWcLSleGUGPK?=
 =?us-ascii?Q?p9KZfMxfRCb5laisixQ9w1Ha6Meht9vXUM0pfssRrABj0ycwZAwEh0TOVsVD?=
 =?us-ascii?Q?Brs5oZwR/z+y64sgPRHznj1Rc8UKPzu2HG+3ERlNPqKrpylPy/hyEAdm7yID?=
 =?us-ascii?Q?H/ikWc6pnzCzWXF+DLbMEphOQfDiguUju8ovZpsnX5QR6KlTrICBJom7cfOy?=
 =?us-ascii?Q?8YHoYPUmr1RbJ8hlYJVA/YGCg6nwYH/zm9E6I2gFEGF+z5o33lUfZIaKh9bs?=
 =?us-ascii?Q?UQpEi/VUj8HCoqDFKMEbOSkBys0CIMVJnR7bPiFu2a7NoGDzyToYgkeFdwU8?=
 =?us-ascii?Q?jrrxLZqak6S3/K3U9pfXvsQ/8C6NEApxC1l+jO3kNqLyRraMV8xDmh8O6jpa?=
 =?us-ascii?Q?pa+Ej70yNO/B+ETimotAEsbsRNoeCNNU8KEAmsotkI1qCO3Ch7yzzQMLQQux?=
 =?us-ascii?Q?eEff4+uMs8VG87yjT+GaKokfli0Jsss5DXXrDUx8fkSvtfqGMoYionBmCu0I?=
 =?us-ascii?Q?J/Lnebha4x4iQh/J7MkrMXUc0TY4XQ5mtVUo/kfUBD2lC1vHuyGq+q0o3sKD?=
 =?us-ascii?Q?0Xi7ybiOVikmgclY5uZr6S7IM/jDU2aLOVzVorDECuxBSDKxbQCjOggR7HdL?=
 =?us-ascii?Q?+EBfZ+OINJiVw+aCu5kRD9rYS+w7hWHYyHraAlRNQJdzhJ9qnUh54cXIaqeR?=
 =?us-ascii?Q?AH2APLSOHMsSiMHDCa4kZWOyxbqFjGIlUOjga5r2lDmxOTPLXrb4jKhveKP1?=
 =?us-ascii?Q?v8Iac6CL6YUxH/FyD0bjlut8lyMsGd04NVKXcep5q5VGtyabCDljo/dvBAjH?=
 =?us-ascii?Q?Q7bdOv91bGKAoh1hkOALX/s5AlGhdvazOJeMlpx8fsQexAKV2xDUBnQXERm4?=
 =?us-ascii?Q?mR+YijpgkULiQeBseYnz6mhlv/ycGb5zM9/q4tAWeuLKT1CJnWHlxIcJ70qE?=
 =?us-ascii?Q?QCxsA3sdsOsxAuY2ch8JYRH2GoT/V5wNb7nDxYg5FAR+puAycJ74vJrfTUYJ?=
 =?us-ascii?Q?+3pwRiULEQ7sV4bM2OGrodMhtN4LhyYWvVt4u/RuNetbNWajo2RO5Y+lqFKt?=
 =?us-ascii?Q?rFXs0QIIGEXYQRlh1cV+uC9SPr3Ku9mXXNME?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:39.5885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb791225-4807-43ff-2d06-08dda7979290
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

Tests may wish to add other interfaces to listen on. Notably locally
generated traffic uses dummy interfaces. The multicast daemon needs to know
about these so that it allows forming rules that involve these interfaces,
and so that net.ipv4.conf.X.mc_forwarding is set for the interfaces.

To that end, allow passing in a list of interfaces to configure in addition
to all the physical ones.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 88e63562f5c5..5f144d75167a 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1760,6 +1760,8 @@ mc_send()
 
 adf_mcd_start()
 {
+	local ifs=("$@")
+	local if
 	local i
 
 	check_command $MCD || return 1
@@ -1775,6 +1777,16 @@ adf_mcd_start()
 			$smcroutedir/$table_name.conf
 	done
 
+	for if in ${ifs[@]}; do
+		if ! ip_link_has_flag "$if" MULTICAST; then
+			ip link set dev "$if" multicast on
+			defer ip link set dev "$if" multicast off
+		fi
+
+		echo "phyint $if enable" >> \
+			$smcroutedir/$table_name.conf
+	done
+
 	$MCD -N -I $table_name -f $smcroutedir/$table_name.conf \
 		-P $smcroutedir/$table_name.pid
 	busywait "$BUSYWAIT_TIMEOUT" test -e $smcroutedir/$table_name.pid
-- 
2.49.0


