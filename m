Return-Path: <linux-kselftest+bounces-6641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308E88C9F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3110C1C235A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591413D523;
	Tue, 26 Mar 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OjLaLQ98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6B13D63F;
	Tue, 26 Mar 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472464; cv=fail; b=eKfrGEq5ckZrxvulJpwsGcj3jhUmADfHJJgPec7IhRjex/qBmykTxLPOfXDutNgQhV53VAz0cMUi3IueIcnT27qxWGVwIzSRbkvmDEkdjE8jE+TyBekPgFBuhtw7ofXNg4HCGZfZmcbPNWUYOhphdToAqQ3olN0A3nT6FXXg8Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472464; c=relaxed/simple;
	bh=uywpYYN0x0iP/lSNbJlCJe574vl43rsJel1ltb+my3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZZk/3uDOxsP47wplWRE3NpWZ4rSJ2Nv1sM7arYHWLHjaSOc5yffOHviAH72/pbth/bwPYTZDY39ekk6DphiTduLJpb1if3QnJPoac7l7ZnWHyVB8tm5eJhI438VtO19DLgQbJS6DGsqcvvPRpOvBiM5kFN3d2rGwwqGfM/u1Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OjLaLQ98; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc8/fGMBy7BYl5ZbUykq2ycEhPZ8rkc16fE4vuIG+Cp5zQdVb+YMa1Va9wIk4+qClFrj5g8P+UdFA72VBLa+n1skSkQEhE4XxpNIwoUjx8AWFiZVTIB1FL9whBx7ukljDktvydSeDkFu/YSvSpuA+n9TH8D7gH/4WslCwsH0uHLFJ/fmlRT/+ZIDKS7wNi5uCcwshmj/7XwHIh0V3lp+BO2kLetys4pxgtTOXA9GHAi/ZkyaCz7dYX9UGhMmUXNBhhAzUQP0cVVEJcF13wuWtPS8whkdpdXasfzk44jpXLhFp8Bdlp5mNR3rcInhqSaJ9nyE64kGCj8QLyUNpnJYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/26YhJhoq8oquNMJnrPirMlKkhfMwfNCKw0NnHLDcY=;
 b=NED2glLbhFI4unU53ZIg0GsPMV68W9iGVo/8kjc9fjMC0Ce5l9shV+zxlYvm7awHShc22GN1Jr71tD3B3m5AczuWSMcnQ8G8CN0tkG1L07N8KBYw+6TLL5B5u70zCja6UC+8L71l+IPO/PZK0iqVs98yzlAH9oZqMSV1W7J7GrROOTvt1x4D5Y/p/uMv3csA0sCd0jBI6vPiVl3c/myH+ql8KCYgwtraGpg/V2fPKAlw9LwTZtl3jmT3Rv9xlgR0GIkqXQHBX0W0oPgCLOljYT4xIZ1X48eWZFcySeUZcsCpnfQlaQTTp6axIdpjB+Skv1zrKEwViaEvpK0cU+eHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/26YhJhoq8oquNMJnrPirMlKkhfMwfNCKw0NnHLDcY=;
 b=OjLaLQ98AhqvKxhSNxXFGCHPx3g/taR3ojHwHOa348E3qt9b10/jcRW0Gtlh+VUO04FOSB/LpdwCkOfsaHySENEbyJC/Pg4KDcUxDY5jQMC2czeldtM4lTm3dtCN6Q/nOAKGrsb5VLDfDlWajM49IISSij9HI5TbamnidcYNnDf19gk6LSJ8Ny8+K/qLw7RPeOuopVCQr2AuBxzShyHwpsuHOO91LhGljWiJhP/Y3o1jJMfSoqx1CAXEWD1Ie9D2A18SxijVT0KQ+/ZZnklgMyYp26mVer5PYSRGFRfgfUp+0sz7MmFEWhd78k7CzFIaau7TyvqFajEijCT/Iz0BkQ==
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 17:00:55 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::a7) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:00:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:22 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/14] selftests: forwarding: README: Document customization
Date: Tue, 26 Mar 2024 17:54:30 +0100
Message-ID: <e819623af6aaeea49e9dc36cecd95694fad73bb8.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: fe26dd51-97d5-4211-ffb9-08dc4db64cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n7GxrDBR3gAfLEZNzrVRabWrl2Jfys9S39PJX+54tTmPqfs98fbacBf7CYtjJJtcY0DInq5E2MAm1eMat/Z8+mMZAEbx5D4LISaGDNvUXqe1rPbioFuhXhIvnjt3UUs3OFAUEN2AD3Vs1yh6nKa7z2edSg2wFJA3RuN6Vk05dMyjdYgoj1Z+9+GFr5oEIMTk3e/4s/VsqwO7o2hkZ/BSmwXsHMg6RmUQ+UEt2yGvN2y0kSj2Okzt4Trhg9LRLkX+5xtNAQ1Xe+7q8imlNyXqMGSlJpyFy3nhNu7BkBlIrSglv4kUNj08WE+j5Z/pzY0cyX2WdQmUUxPxLLTcW+Q8oL5MS7UihqTe+5+tm2ysfBXbm0x0SCFnB2037t0u0WqPvWo8Gbdh/7qEAA/NQdEzNlj97rZwMUof/fSYl6sIFG/hwZpkKitrCI6+ESMjal4Kt02JHHH3KSLJYVAUE3hKnKuRMkHiTcFkts50X5tMF8ZWwr0UHNYjXqMeIkIMiaKopVdNIGvo9qgKrQoBzMNAxkhENzpRwCDdgwG9rZWHO+X9gX2ZmvoYVzx/vMMaIe/R7J5CB9KDLttwg66N0obcD/h9ceEwEhyk594jyOO0SOeaWnjjA2hrMIn2fom8r52M4ja0nyN3Na7QNQos8xCBkeh8tI+66jO4nrqTDvhwnCVJ5pTrtsUGyxLHgeDCyZl+e23a+Kj9YVgESZv0/AVk33bP88S9JK2NmPghx2+KYf32csHM3w5hssm6/DVQMjg7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:00:54.3987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe26dd51-97d5-4211-ffb9-08dc4db64cb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

That any sort of customization is possible at all, let alone how it should
be done, is currently not at all clear. Document the whats and hows in
README.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/README | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/README b/tools/testing/selftests/net/forwarding/README
index b8a2af8fcfb7..7fdb6a9ca543 100644
--- a/tools/testing/selftests/net/forwarding/README
+++ b/tools/testing/selftests/net/forwarding/README
@@ -56,3 +56,36 @@ o Checks shall be added to lib.sh for any external dependencies.
 o Code shall be checked using ShellCheck [1] prior to submission.
 
 1. https://www.shellcheck.net/
+
+Customization
+=============
+
+The forwarding selftests framework uses a number of variables that
+influence its behavior and tools it invokes, and how it invokes them, in
+various ways. A number of these variables can be overridden. The way these
+overridable variables are specified is typically one of the following two
+syntaxes:
+
+	: "${VARIABLE:=default_value}"
+	VARIABLE=${VARIABLE:=default_value}
+
+Any of these variables can be overridden. Notably net/forwarding/lib.sh and
+net/lib.sh contain a number of overridable variables.
+
+One way of overriding these variables is through the environment:
+
+	PAUSE_ON_FAIL=yes ./some_test.sh
+
+The variable NETIFS is special. Since it is an array variable, there is no
+way to pass it through the environment. Its value can instead be given as
+consecutive arguments to the selftest:
+
+	./some_test.sh swp{1..8}
+
+A way to customize variables in a persistent fashion is to create a file
+named forwarding.config in this directory. lib.sh sources the file if
+present, so it can contain any shell code. Typically it will contain
+assignments of variables whose value should be overridden.
+
+forwarding.config.sample is available in the directory as an example of
+how forwarding.config might look.
-- 
2.43.0


