Return-Path: <linux-kselftest+bounces-7844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A448A3472
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E3BB2262C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720314E2EC;
	Fri, 12 Apr 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHu9L6m5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD414C587;
	Fri, 12 Apr 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941611; cv=fail; b=dzyONIYps3G435oeynBigLUF5JXmLBTC01k29a1x5XHpwfTiGn22WdYS1FEEFltrpy1gKGvx44vmt4Nwbf/EwZt8Be+SsAU+sFRzSCvIoxpe9fGxQwvrC7EjV0DS0AtEEqQsltRAyhUK79bOhBvMD9DHj4p2eBaVgUks0N3hItk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941611; c=relaxed/simple;
	bh=SzDVnNiB8t4r0UjRH7hF5WyNf1yWrrvu6SpXAe50+YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/7A2WaZLVJdArGDw1KdeA4KDdFoFnp2QB0h71slk8ohYdBT5GFcEMcapRPSXbEa329Qgir5WyQdmG649dUKIuR1YP3TCdXWf3XxMUU7FoIpVN2xKqwjI+GARqIRAJPrRky3ZCmqzgGxM3qry6WUNG5SLnAHvud47reEIjdZD5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHu9L6m5; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvzQY7AhWSLzLPyxSVT1dtZTjZjLZtIT07a3kMkH1x4z7XmjNDBjyTTgqA2Xq5C31wWqwGUsAu7gbyW0/9aKiJKWJWoHt278KINZfHOwj+JdXhvLI10Zvo0+hhWVm9FzrGjlzatTOXKu5IBEI2d6idhKHxZbP422cdHNsraflwsEKYE6rreT9dSdYOJtfLzFBPC+KsSolc+sxoTtaJC4eMpvHozU67XKzVR9/LX6Gor5vsPR48lb5rPvskOpLD1Vwk9rL58lc28BRYF3FqgtcoxeIJ0nvSf49pNnQ4e9kUHlObUiM4mhvtAnzsaWug5PdbuOgIu3pxTvfT/+wl28eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyeiRW2en3GKPn7qjCXQ5mReksSqxo0OFqtRi8QI2HM=;
 b=GBEoudj2DtIDAL6NQQbWpt08LcS8HqZAOmm5aJRmFFWrpuoz6139/dEtRzJLvAuBfW/QhFbOB+4jlepi1rRzzI/v5x86JSgbMCpax1i9qckghpyWKJoFlBSOAn0JUCilHOK8PHiCJIJjcSc3me6Echw/6zb2eik9+sxbqwHyhqmvHKKgGMlSI5/UQOyq4+oif2aHrsCXHdweTHFEc/MGQqjiGBroxX3fkIX4tblSxSQIm9WCym0kqN4r88N7/CEMbIXqmbBs3WD1ftp61Ar/fTE7EaBdXJaxkZ5GP1IARKkDxW5EioR+xm6EHj+ErMoWs49hBZiYf4J7AaTT+1OfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyeiRW2en3GKPn7qjCXQ5mReksSqxo0OFqtRi8QI2HM=;
 b=tHu9L6m57PE9yGzGLrJxgcl43Yo+P6SSqUb24Q2ahV8AQzqWRgjP0TPQVRTS1L+KNBefArqZUIEY5uRst2mXiAB9Pi2Dp2ZsQhalCB3S/5yxZWFRbadsYk8VdXVlkT5B473pqm8lGC1vr0oOgZFP2XPhS+6zcynZUwN/NW6I/h1lOV6zzzyHPcwPyo5jHtIccoKkca5ZMdN956J151L4nep6vqoUnjb8kw7vex+aDnOjNDFqEkyrGvyj87+J8mKZxmgWoSJRMHdVnsHFxm2eRbxixEP84fLTHVz7EMIIGfIkZbZ7TrrNy1/sPUUbCsEmxcDIWdoIvch8heWuHTNO1A==
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:06:43 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::7e) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:06:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:06:20 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:06:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 10/10] selftests: forwarding: router_nh: Add a diagram
Date: Fri, 12 Apr 2024 19:03:13 +0200
Message-ID: <ec60c64b682c307d8db9c9cb1f35d6e43bebd1e5.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: f534df45-e038-440d-ec8b-08dc5b12ed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	baMHu1liQ6TUFk4yYVVTSRwKNlK8RIeTiL9AoWDHhhueVmferO0s91yvHk7m5mJlnXN/x4dJuEjwMZWtmHesTr3pD2RtsCKOJb8xQtGcSyxl3hsQy5Lh3JNL1eIDJB7QAGakcw3v8i1Uw0ocqr+NMGUZ6rTgPH4cueNKXrWjHk4i+zkccvfblB3VJQpMniiYu0H5Qa9SdKfwsPfISf7sWxUR6fPXYGPTpKmXcRnBVnPf9+y0/cXgDvv+MjgSptHFlr/uU0c6Jiqc6R2STntxhXmzwHolWDc22AiKyZP+OALciT3TV1Y/aXiQIoS7mNYoGOIxoTcx0GAm7Lwg6qnR8JBixeN/1iRPYUutm+J41TzuJq8u7Kqau4PHX35n7eh0zkXt78TqgiyV5ctSp27yMvFDAfDrPo/gAzKefKWNq07MgtdlpdJckEMU5Qawja7PMDLxmidt7vY/G2EqaeQAP+nfCs2wjv56oC615ZsxRp3L5NkZ6wjJi4v5Ho7dHX7V3PB7XTHR0rLD9LMreeRBnRVShaBnDkbwpRReVyBEX3Bp+oXs6DOk29c5uDXygbCQR6ZdmLMj3g0kHHzeJBSdWCosCUn+ewlwOMReOCKivef/4uzd/tqlFtqvA5cOZ+cRii+IfYS54RUGijQVWd6xWRwFl8wAdqSo8gEGE9bLjyqqsuaxjEr2r9MrxJdlAGBNUeCgbJ+zvn+FGH+YDWRp7AYHRrPscAtClIXbbuVzymlaZUvNevJl1ghthcQ66b+J
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:42.3915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f534df45-e038-440d-ec8b-08dc5b12ed16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719

This test lacks a topology diagram, making the setup not obvious.
Add one.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/net/forwarding/router_nh.sh  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_nh.sh b/tools/testing/selftests/net/forwarding/router_nh.sh
index f3a53738bdcc..92904b01eae9 100755
--- a/tools/testing/selftests/net/forwarding/router_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_nh.sh
@@ -1,6 +1,20 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# +-------------------------+  +-------------------------+
+# | H1                      |  |                      H2 |
+# |               $h1 +     |  |               $h2 +     |
+# |      192.0.2.2/24 |     |  |   198.51.100.2/24 |     |
+# |  2001:db8:1::2/64 |     |  |  2001:db8:2::2/64 |     |
+# +-------------------|-----+  +-------------------|-----+
+#                     |                            |
+# +-------------------|----------------------------|-----+
+# | R1                |                            |     |
+# |              $rp1 +                       $rp2 +     |
+# |      192.0.2.1/24              198.51.100.1/24       |
+# |  2001:db8:1::1/64             2001:db8:2::1/64       |
+# +------------------------------------------------------+
+
 ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
-- 
2.43.0


