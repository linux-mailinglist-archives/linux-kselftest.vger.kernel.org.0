Return-Path: <linux-kselftest+bounces-6556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34788AD1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7335325614
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC7131BAD;
	Mon, 25 Mar 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3FiRxAI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF412FF93
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387960; cv=fail; b=pLMHnZqHgry4XIn6pYU21yz2+q7a4O8DI2s/5LASRyLesK0hREvH3FWMrR4RppQtZxCUrZ798K18MXKJNWX0Yaun86oXa3V4/tr4o4XtqYAISj1hIaCoC2RtJ0qBHenlQU/9RlbLYydv1j4baLVK9qBK6zJ5ygvpu5ifKwA2GIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387960; c=relaxed/simple;
	bh=uywpYYN0x0iP/lSNbJlCJe574vl43rsJel1ltb+my3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFwXYdrFje/T2lBn9YbkX5GwLgA2BtLuNyvWEXiY4AfqZf9HM2yitz+NUZOXfAI17EPou4aF6usTBX4cR2xsIb0FxFxcUFBhYqxjfduNEa35lFqVMCMBh1GmJWEj+N05j8630OoBJOLskSunWdutrcg/AFWDVLwlNZ3Vkj1ADts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3FiRxAI; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLqwLyvTEXLursld2eQwkZAOd9Yo11wjkAKhIzQ9C4LsiSOE5A5XxXfrFcXJaCaxTglt2HrmPyCJAImkDreAAeXeK4Cy4+0ycEl6NifqjkMTeK76JBRbww5vn4oui0TGmN+vSkOLunQQTLdazHI1l3rRz+jHV/WEDWI3aMrtN72CUNvtJ8fGUelLWVfcWaUPJnb1lBHOGxZwksAEkyaGEzaYqbv77IsZLHp44GF88rq8TcMjSMdLXWgRLBU5kySB4r5BV/ZYklEiWB6knQ/r7CYA2UloFitAbw8ki9j/xk9RGAcOVMbE3OLPyDy//Guoaq1UQz1Q0e3lGImtUsiHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/26YhJhoq8oquNMJnrPirMlKkhfMwfNCKw0NnHLDcY=;
 b=OvmXW0V7zrWj2Yvnvzdo/e5UHYRIHtF5dQkHZ35THDGTt0a5YiYpnNsZgoI9XutktUInw//CFhm0dyYZBfD6IJys2EeDkYUkMlrFm3mgHp/qsKhuRHqzFyX665JmLi4/o43Lshvk4MOoONxsPNLsEqjrHQJyYcI2OX7kky9aOhKinZzJ0Mxx4zAGuS2qXzKFMWJYKiYOXpB3I3ghN0bqvFK55hAvHMbDVqNUIWCGgV57BZsu2IpK624lv95tBlAkjBOHkP/daAV1HK6LRe1750tBF/6HjWdtbzAl/Xf3IJ+3SX3/V1dghkrJh71drJWwg2dLBSY3ttLlPhwyV/JVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/26YhJhoq8oquNMJnrPirMlKkhfMwfNCKw0NnHLDcY=;
 b=e3FiRxAI1EGPBT4wmc6GJlGVsgSdSZLCRqrN2qlN/Uw1yb/blCwWcYykG2lzADewVy8MSyKI4vYbt+VnCMYuTo12VX4HJlX7ErGYDnNukwHnSpRkqY37xdWyDq7ThA3EfSsgQB2RWaeJCN3n9PM5WZk3ETtL0iI/IHRlmHHQqNhSnnv6LCvF8etNPuRPAhEVeTRTl1MF3f+2GrIy/jOUr5fEvCycP0QUWWZuQjAhQXV2u2U14K/VCjXcJxsVrwDj0mUDI3hnZKWfQZp7wtpP+4FQVsZsmec32F6mgQErqnsYRY4gSm1cu3D/cp+FVIJzWGeZ5O8NZHNF8Hut7zJpjA==
Received: from BYAPR21CA0001.namprd21.prod.outlook.com (2603:10b6:a03:114::11)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:32:32 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::89) by BYAPR21CA0001.outlook.office365.com
 (2603:10b6:a03:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:11 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 03/14] selftests: forwarding: README: Document customization
Date: Mon, 25 Mar 2024 18:29:10 +0100
Message-ID: <e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa004a2-a31e-44a6-f040-08dc4cf18d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XNQid8SWuHWh+pany9R9lA09TlOf+7GGFRlWA6buVOebkU/VOKhgcRgainJACE8f+wV37u6EUsIrLKhnGBaUXY3ajr3gp5+IE3auOvj+DHWcBouqcMi5S9n8NM9WP+xLBDeKBU/J6I65HSDpmcpj2J0hlGCIhbv1Kq2NpUMJnvhb+m/ZJEntZxU1dv5HVGSsGHsp7Fq1YV6VclYA7DAqYUPE7/yFJabq+RG3uwWb6zlJGhTZh5YAYoojOCA7edDAi3+Ada9PgIk13cFDbHOEw+q3kwbtYajmYp0YF8fgfxsmdHEsLZeexeBUQCLxEBBR0SpOe5iRhnwwGWBQzyWIyso/dQneE08LuKweazwhvNCO+m8gIqNVjqjPAFguNJA3LFDos5wLpVrzXFLrYf/31Z8YV9is2GsCy1FOIVCzGAMlWTKonFU1VxjTD2UGtpFmRY+2m4GfS+hKjKWMjFmvfhPTVpfIFgKbS/A/cY7SmaA82AlrlmvioC/bBg10k+1HK/zmFLbauBTCfPjImIAzOyc9yrWZCvLZaY44Xj2s9VCLfcYVl1v0ZXjBZIj2gYwNrZ3TrpggqJxZgBSiCoNGpLmGwYBeIrtbGSMUTgyPx+zW0yOUH/jI4LsPRXPxLxXz0f2YQED3NdneQ7yyNrArtixBav0kihTOHYuOIuQz9b5QHolQZ/8GHs8/Gqffeu/id49UnlIkg6zHalOJCRHKH2V/JOHSRggGCQTkkvjF5ZLyU45ISfTbftOZaQJM/vYR
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:31.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa004a2-a31e-44a6-f040-08dc4cf18d24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

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


