Return-Path: <linux-kselftest+bounces-7843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E28A3470
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE26C282887
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3814F106;
	Fri, 12 Apr 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fEi0sCf1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD314C59C;
	Fri, 12 Apr 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941605; cv=fail; b=MKMX9W0PKfoDQPRxhYaRWgrcSZ/SOgH+VaaxOpygWhaIYlCYaqGys9d6ABm2jq4wKYX+VDis6DKM8orok9/WTtxb/OWKotfffTMfsYdIj8qZADQQUjXXenlsMX9fjK1S5BbvzpqENEuf/gP5xf/3LRELl3jwATN6dxAh8uo/qKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941605; c=relaxed/simple;
	bh=YovImiEkCulziGNFgl7hZ6SCeabUorxWzJ5kjmeQyBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3YGC//VmX4cEelCOeBgQnnbQw3riMc3zce46jl9PlO5JgpQI9VgqbYaywf6wA0SNrp0vpP7S5ZmuQyuodOABRQvLCNtpODtmsgO1prb95hS9L1Da9XRC8ARogqJ+jpupb0DvuMwC8g4rosEUJoIdGbjD4F83A6vDpC3ziRR+b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fEi0sCf1; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgVjyEiUyvqGZC5LCRJATfcInmiT0eYGZlUOusLU4c7o0jG8WYeEJRJdydqUb7AKGk58Tet8t+dMtbw0/3p+WYZSgdVi5xU41p/11RshDg9iHkkjdp99+voYi3BztdlhNtJfT17fb4SzhFqSMZ+ohwdpvfGPUHhhkrDtoq8EIl0yPFw0HkWl3wvrdCoeOp3DQR4i3ILSVXd9dBy52+YgqSr6CqgzKHd+4vqGeZXWBKIDDX5E+fvqYO1BrCppVAkJzZF25gqOet6+vVAGPSyHKB8byRUCneYscMx4YDXca/5RWvJxGGdWFYoTvPShnhUbdguHr2FEcRhgFtUPVmqM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GmEzfCsAiZ0tyfsN3Gxle0b0D42N4u0gy75qqqTpo4=;
 b=JK36X06+YgWjqIlftQppzMTbriQhfSm8XnI6fKad5paa45Iu658fj0xncgqfeEnFUi1eGOtAJE5UC3h8Qe6EwlNY1btACcrqzyvIGV8IImiE/o44xqKe4AuCe/ZcBATZqngD84p2bP4YfhGyfZG2IBjqwzlCvDFc7suvyGNTG0BQMlIBnfurSeeTNlwT1Rms6d2iT/AbhGSADVz7VeKgooiXSMp3M46punS5EuxndMVm1Y55ZuMby+PoA0hf7amsrI68s5z6LWa/OlX61GxmKaL7Mw2kSQ67/7RWbg0oqIZN8HUi3XU4nLylcZC9zTY3LRsQy8eNj8cjszWZChcF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GmEzfCsAiZ0tyfsN3Gxle0b0D42N4u0gy75qqqTpo4=;
 b=fEi0sCf136HfKwVB60sCWQUJEpMA5fyHW+AceXzn5N0M7p+hBuPNv3ZwJuxw/m+jdf9300TWcbezCqP8r8cc4e4jxVtKf0fVaSD8h6hKXwDLSQNObrgGO5X+jr8flI6RPGaN+0x7wdqx8xd9Sj9BJRaZxfocGJMLGUBXjPbQ/R7C8GLHJSi4zFmVJCNDn2dLhJipTMjZwsVHqn+WAc8FnFsdPIywNbkg/tv1+WvUJHZGwtoCltEqfAkZeABjQj8MIVxe/yQz8IbUtBT9Rl8sMrtb4gmcbwXrgvK7LWSj9oKs6RjmF62tBuYFNa9XDwRM/0Vm2rcpLpZNLAe3FPMyYw==
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 17:06:40 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::cf) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Fri, 12 Apr 2024 17:06:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:06:15 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:06:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/10] selftests: forwarding: router_mpath_nh_res: Add a diagram
Date: Fri, 12 Apr 2024 19:03:12 +0200
Message-ID: <1a34016962a2678462c656516ad90d4c0b7ae258.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 396e08b4-aaf3-4504-f0de-08dc5b12eb6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/gwSb538ZIwfJSFSIgzi1GpJj5TLwsTq3EFADeydBGWikmiPU4WVs7rClYVFmzx6OfCz5UOm76XNAW3k+hAUWv9Sg1OjoURz2N3TaNnmIrBZEFgs2mnbUIX1hmgdHWnfn0fIqoGV/2Mgci3aStJI7V6ZrTxyPjV4RzAZ+8dKB4kI1J0U1ZwaGT9t0zaJ100ZvJMEkMgNdUWwiFMD9c6SkLarKCjvS9Na064bp97Bhk+XhM+VpwE8bNJsVzDYAySOS0GPQsdGHzJEX5ofLDoa+GLjSzCFflYHO8ztupfhh1ZlE/yn1nLFvJWZqRiBjXzLv5q9L8Z+21Xth3ySiX7PXzqLwJ6TlhWPAMpagbxhi52ny7gJHj1zgoSDW3bVf4LLUJetEjJh9Ii/49Uk07INlf5eaSlYknPHObu/yMdok9IjXEXO1FDu3hCPuURY3z2bljLSinSNghsU3JSWYBx3yRI3JWDOX8XiaIWMMCFF20l+J0+gsMVkFN0vRiEXeJCeGO+Gi+eO61ion5Y1NcNAovIYvQ3ZZtgorTFWBTuRRVqLpKrkfypocta1COZEuZF9XpjXWytY0xV+8SHpcOTCzgc12lX5g7uZ5L6Bvr2hcdxG0xBjzeqJ730DB9WGDvV4UhVJqZz/PEJ6q3825DLnLzNSnLCY2PVOVcWpiYjWqmnK6mgYtoAlJTvxjWckC4FhZIUj6bRJDu1/ihUd+z/zcvK2hJo1q/Squ7i4I02WUdhRvehBdWlhI9z1EFZ4KuPm
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:39.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396e08b4-aaf3-4504-f0de-08dc5b12eb6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469

This test lacks a topology diagram, making the setup not obvious.
Add one.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/router_mpath_nh_res.sh     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index 4b483d24ad00..cd9e346436fc 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -1,6 +1,41 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# +-------------------------+
+# |  H1                     |
+# |               $h1 +     |
+# |      192.0.2.2/24 |     |
+# |  2001:db8:1::2/64 |     |
+# +-------------------|-----+
+#                     |
+# +-------------------|----------------------+
+# |                   |                   R1 |
+# |             $rp11 +                      |
+# |      192.0.2.1/24                        |
+# |  2001:db8:1::1/64                        |
+# |                                          |
+# |  + $rp12              + $rp13            |
+# |  | 169.254.2.12/24    | 169.254.3.13/24  |
+# |  | fe80:2::12/64      | fe80:3::13/64    |
+# +--|--------------------|------------------+
+#    |                    |
+# +--|--------------------|------------------+
+# |  + $rp22              + $rp23            |
+# |    169.254.2.22/24      169.254.3.23/24  |
+# |    fe80:2::22/64        fe80:3::23/64    |
+# |                                          |
+# |             $rp21 +                      |
+# |   198.51.100.1/24 |                      |
+# |  2001:db8:2::1/64 |                   R2 |
+# +-------------------|----------------------+
+#                     |
+# +-------------------|-----+
+# |                   |     |
+# |               $h2 +     |
+# |   198.51.100.2/24       |
+# |  2001:db8:2::2/64    H2 |
+# +-------------------------+
+
 ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
-- 
2.43.0


