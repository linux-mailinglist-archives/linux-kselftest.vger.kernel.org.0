Return-Path: <linux-kselftest+bounces-6642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974588C9FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545FB303D2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ABE13D887;
	Tue, 26 Mar 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHvKjGkb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1213D2BA;
	Tue, 26 Mar 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472464; cv=fail; b=UkvYlHDHXmYOfgkjqwl3mKMmN773F58lsipnYGKLeDY1J93kAIwsu6b0MoBrLTIEUONdJ59Aia/Fo5+Aifo9kefRixLLC+OrDqGqRCSsomHhOvbMZCrctbQAbqX30uXqu1N1UD5J+bH7Ej6w2IDRSNrtuX3LhTTQ09vrWVLVEz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472464; c=relaxed/simple;
	bh=U6IDXaxfmqSNGryMzeBJlZXsnDiUp5VBG59deIGI2Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC2tnbZCgkwAfPySMEv+zpC+iHCO0GZ0ZMB4lKFcogHgLg7I6n+F4oA3R+8ZaX0NdNzxTwTon3xH0//FD9o9P40EQBwXPbRhxy0aTQmJsEwZJ4KIgzbDVqHS/QH29/YF3pMUpxtoiiESBJZngSUcmXlV/x5p23BQ2YwcxMWLCyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHvKjGkb; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5mx4JInploP4RO8DKattI9aQw0W8BkidXLPmQMNQBSQyrMUH0PKA6yhqTbaqDylsX63sT2N4PUY/VJnZrUEsPA2UxqYULuuKxLDCYXWZnZ38o2UBfe4wWVh4OBWt089uaCAM5kOrfc4u+IvqyidteL8v8ib3XB33IEAF5Ro0kYxiSuU3mfPharKlk2guKt+fmS10IlwxNwinshWup98shgwLXTeSo6e3/26D5Jthd4HTP6TE9yan1OHYICM2gJq+27b+hDm1iG413WQDYZB2gAM/DprYP0SvVprrIdYBOs6FMWjqHFKjVFvwxGw3AkGj1HlmnvAGIN15sQt3eNHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZbHvSGkaPZIc+jXFrBUJrlxuSi9YeZoD9csuGvfi0w=;
 b=CXMqE4hkisQ3T2ebyMCjT6XWQ24xIo3F7jcHk2O50YcQ4QCmH7dumz13eP5qM4FOURlk7jSszGJ6ffBecV4n66bh4DyVayYUCytaI04ugndllZcdqisIecO6jFqixwksBnCnWvbTANw70qCqsVt8g+LmQQJtim5dXUsydNyqBiHUV06Sl8h43RDp2BsEllBCBZXceK30Vas3nCRG+KLdLo7uiMalV1GYm2snPOnj6xJNikmSMi/rXTYcuxPTTWm+xEaVCsUPWziYmQtvkV97METdO938CEn9VjuxIo2AVqAyWcYio3Mo6FiEpGBPk+yyoYSxY0Cm8QDmE8I5KeDOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZbHvSGkaPZIc+jXFrBUJrlxuSi9YeZoD9csuGvfi0w=;
 b=pHvKjGkbIq0RxPt7xJ9PJSGfy/CQAQ4f22oEmU8Ou13e+I6UUdORN9398zA26IlYg+Ng05+n9/TBnoqgeuW//KuHxXb05rVy4iamPsNLlS20slos/aLuw/COR378jj1otSMIv42qp5qURzRQZJ6+b9opn3i7e7sml2f4i3aKRS9RaL8Dg6QxD/LOlHhqKRvwNKL5U/jhlTmDnuA0cXw6JVFevUxS74k6EnahbI2V9rnjPM1xKdy+V5kM87jU8iQKjWiFpTAI+FF2uEY7YdMpeNG7/8VOR9uCNf6VYnsmF8UpQtZfG1UsE469RzUbp7PKk/CXv/IOcAXtST32QYRadA==
Received: from CH2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:610:50::30)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:00:56 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::55) by CH2PR16CA0020.outlook.office365.com
 (2603:10b6:610:50::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 26 Mar 2024 17:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:00:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:28 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:22 -0700
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
Subject: [PATCH net-next 04/14] selftests: forwarding: ipip_lib: Do not import lib.sh
Date: Tue, 26 Mar 2024 17:54:31 +0100
Message-ID: <a4da5e9cd42a34cbace917a048ca71081719d6ac.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdc6959-a48d-4b95-546d-08dc4db64d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dpqTmtCbjazW6inoJ1ItaoUFHejatWhaseijWDbwRb0LCF/Y1EM7R+QiYDzAECudeBzV4OqPFDtfqf1JYXvIpYLJjasm3NcU+yFR6lrWQ2dczM+zDsed1EfhZgqC6RMcd6rLXEOcfb84bq3FrlcdFRysuasq5i4xQQWjLiCJAYg7mnUocrEJ2oifwgqCV5t/Esr3S+FfkVG/3qi16EE7D9dMNoq2Qv1sDAKUVBrqf36XWe+HNaTNS1II1KABwJkcY3WA3m7NdnTe9NRojvV6GhhXytY949XLRfAVmWT9LrTg59ox8LU4hnSDabhAqooN0NXy5IRJwgW3P4yfw/mmHs/U+6hSWlSMwB3pr2M1Q/lmrF6lS5My1D+SOAsueW5Hbxa2E/AYTFbAj3l+mn0QmigPR5LzNel+dsfxJzjoOtlrSzXum/D1oH2VAME7NX+BHW0BXnE+7mrXbkVjQod7+CvU3siDsZGZeXcYfMYXbjfLFY0eQFTYKcNYw3Kp6q/Iz0gucZGG5H7nk6wzst4dRXqkpytmDuXZEPNAglQQOp5l4TyzUL0704TEYTFWH/yh+B38QDzgjycb68y4xiUVRwFqzNPJQlomFG73Ih5Oqwy17TToSkQ/n7cdo7VqWT8ExXgp8kcC+SnNO+aehDXKV/BglNACKXKFBGnS8aa+/5Tr/kkfeBO0xUPTAHTOy1ZS4o8ptiPwm2EL1c8O7hsnsSZ7pTAq7ufXEZzQW5t8JqWPO/BAPqMjBcPD0Qwem4yL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:00:55.2932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdc6959-a48d-4b95-546d-08dc4db64d35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

This library is always sourced in the context where lib.sh has already been
sourced as well. Therefore drop the explicit sourcing and expect the client
to already have done it. This will simplify moving some of the clients to a
different directory.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/ipip_lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
index 30f36a57bae6..01e62c4ac94d 100644
--- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
@@ -141,7 +141,6 @@
 # |               $h2 +       |
 # |     192.0.2.18/28         |
 # +---------------------------+
-source lib.sh
 
 h1_create()
 {
-- 
2.43.0


