Return-Path: <linux-kselftest+bounces-27455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7DA4408F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D65A188A6D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185226982B;
	Tue, 25 Feb 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dT56dw5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905226980D;
	Tue, 25 Feb 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489476; cv=fail; b=e+Z2HvQe8I6k234/Pg86G4EehO03o4pxM+uLTrZH9eED9GzfiEG+5zCXx97u4hBfWY7idu4ODcW10Xa+jtoUpiOOmAza8t5Z7YDhRzrKnurbaos3mRj38b6QrNUDXvWaEd5VkdEcVAK8vsID7RHKbZ8O3W0EGXEP2ZyxJkX/jyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489476; c=relaxed/simple;
	bh=B7QQprOXrNujSLYufbrklxQPkoZ13tRgwS9CtAdyovc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bsoGix+m+uFCWdlMVcYVyqkcueuNkMdONQEpxZ9Hvd85PRFoFgWGyFUzg44dPVoNaZ0lDDnz9FLCWJ2uqA3JX5TDvMdHQFNHfmehJ754najuZbxC9HD3R9Cz3G67cd9cxLdxIOSmFl2uaHmLUNXKC7Xtqwio9hWjiABXg5lLkZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dT56dw5w; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+jdHEbEBaE+XViXws/oYmdLO4JZ1BXJLDjQ9A8QlqGuj1pGXtWvQStL9l02wzUE3Tq1nCIdz7wE+2o011GjTRQp5Tdwbj8GCXAQGrVKM7rmsTYK7ONDUt0C12d0QoOfp7aQ/IJcFlFskauI0r5v2tpqLl9nb7Vr1p/XSXaFV8oqFGp7FFnGdRiduqJrNksurMt4LxBox4IFL90lKp+pl0Gi8Y1zxXtk0xVKq+U9fgj5Dbwi/MtV2pKhPJRn/jW0jWz0r/RdDwuo/yYKS67lB45Dmf1isg+61VQQMUxuobHxVo6nHHCVfa3rTPAO7eItfqt8Xp5iYzLxKwArlNed8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOPxLHcYSVlscbMH6VFN+DxPDfh7qqVL30fx8sxPRTo=;
 b=G6NOwWs5mCZG6KgWEAhK+eqZoQerB051Pa7qRzYwwp/F2tNZvEYy53TziseOTGDmc88p84CSAnk5GHBdDFnZmxHlsZPZa+zpfZ0s9KlVH1Yd9d2SBrnvQ/B/ZyOiYy1SPK8MEo7/cQ3Up3bozMp0/p0m26HwshsbNNZPU47gYcUwRAtHccMb96iMtr9+jRNLJs+NSvX3E+RTKT/yS+kR6LkGYdQrOGmSiRqijmuV8lykdFIOkcyqRcrfInX8lRtHOsuBMvGxgV5LFn7V/dbCeJ/3DIrUci1+HFro6TV1E7zWa1xwRZXEKYNcCV+nkyZRSukJ4lKVqfLCHFiulEXMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOPxLHcYSVlscbMH6VFN+DxPDfh7qqVL30fx8sxPRTo=;
 b=dT56dw5wF5jTDL5H0JLm6BBl0UMcewX/V3iV303L1ubSiVLw8ffdQtQrC1RQ6RtEJBbLdzN1tA/X7M6L7IU9P3oKeGy3DlD5Dvd2owM0/HClhzbDS5VXRUV+Dui0EJsPK/ObQnv8Ye9ZbMOfSlsocsIpxAzN6M3Mu7IPVwu/IoiCFnJIFFftKd9ROyctZAJykCHrpWVoGlgvmNgM3oMh7nWaIg2Ot1E+tCwz/esBYMxvoNW5UmEyxTS6oVQCPIAgnrF1EgFNbtwWFNKmd9L594s9G4H6dojTVMr1o8/cOtpTC7W3MxnD4cgKhRF4dotitz0bPWHrjsiw3qGliEAwvA==
Received: from PH8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:2cd::17)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 13:17:51 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::cb) by PH8PR07CA0003.outlook.office365.com
 (2603:10b6:510:2cd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 13:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Tue, 25 Feb 2025 13:17:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 05:17:35 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 05:17:31 -0800
References: <20250218164555.1955400-1-krakauer@google.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Kevin Krakauer <krakauer@google.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Date: Tue, 25 Feb 2025 14:16:09 +0100
In-Reply-To: <20250218164555.1955400-1-krakauer@google.com>
Message-ID: <87v7sygo4a.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 859d32e7-87bd-4002-2efc-08dd559ece36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nuLv76BU1vHKsnJTy0866phwHp88O/Gz/dCCYhgcKxNlnJJgIbhjcIq6TI5t?=
 =?us-ascii?Q?BCgNdN6vw7kB0shGN6CtatOnUtgaKJ0zBlm3O+PMfL+oJ5YRuAFMnNIDRFIt?=
 =?us-ascii?Q?4a1pwWFKllbsBkF9Rb+9BOQbM3xyB2wkJiySmS5b2uHL1L8MeIM+YIrlgFAq?=
 =?us-ascii?Q?4eBoIkAPVkUJAp4vatI+Nz2pqz/PhnylUA0cdhg7C/bLvN71JDJmru0tKp6T?=
 =?us-ascii?Q?jHfAOPtbStll/vTNKKGdYunkYNM0hlr1suZuHlKF28jlAmrdEMmmyw5bO321?=
 =?us-ascii?Q?Ld5my53PrD7GGhfKZan9/Ay8bWPFJnngjbrcwbMs6aqG7N8nP/ls0LH14yAg?=
 =?us-ascii?Q?MXJ736FXC3SV5aOlDqGm39Xw9K9jZ/Ri26E0XDBinWJ8xUWpzuVnANhFghNy?=
 =?us-ascii?Q?tQI+4KxdlLw/Q2SgZ7Jt4I++L3AoQMHForJ5IlMCjrpxOk1XzijfoklpKpWh?=
 =?us-ascii?Q?G4wdzfIbyTf6O9r6Xky8pdwHJ8hnNvKLoCSvQYPgTViQUs6tmNYqOLtQJqdS?=
 =?us-ascii?Q?H5gfk3SOAJ6UgwikgFTT7JhaT8T2aEKcs9y2nqV0WWEy15W1sBS/0HkWVXCO?=
 =?us-ascii?Q?1rjEDEOD7h/H21sqnjn+ijjG29KGk/9cwOz8wofZ8LbOCgxDnn4Yz9R5Vcnx?=
 =?us-ascii?Q?7I3H2wdDBBotf+Iu2OCtf6F5kQASFY2XVwGLCCqCN8L2vHfZMx0H0cP+BSvl?=
 =?us-ascii?Q?2MMfgV8SEMMRVqBugwGtKJ8lEYAWzDJJnrveKDXbgp10rOVsjjG8jgmPJf/x?=
 =?us-ascii?Q?9WnMZ0PWxTzkdXCFddUn3qhwFN7ezsvoXv6ucTPaZdY+IMdhodgmTmksl5S+?=
 =?us-ascii?Q?Q6d9eu3qFQWEyQ9RVAg9RJoPrerQV3AhW1kPmOZLjKesN9pptlnVYGSnHbg6?=
 =?us-ascii?Q?abhE5N/3mAnom3WCNdD9ewjpCD6n1XnAvev9QoF/VzCxSTZcfjSwSPmCr7kJ?=
 =?us-ascii?Q?SjYhJscg6WKUFUkhkLarxwXR7c4rSRW2mo81A90LkewdIkuhUCHM2Far4ws5?=
 =?us-ascii?Q?+dc4XCGD2pLAmf8599ErQDh1X0g9WPb+ywzDdWHoWd50JSQryhxm8h/znvhE?=
 =?us-ascii?Q?JDDkd5sTezBVm950cYfOZLR2sqKCRidj1aeUABoxFq/TcHu6+11P2GPhZUWX?=
 =?us-ascii?Q?BbdaCSJN+ALhQlVQPvIu6M8XewyfhD8UD79z80x3XNZJiTlORr1co7nNh0Co?=
 =?us-ascii?Q?qhnN4/xyIlj0CQzM3+nTbR1PvG2BkgrfqWWOQkxtSTIrH4k/uHvah2zk2oid?=
 =?us-ascii?Q?qTTUMtkKaOjYMO6MTMmfSpW4G1zqzqYW2+LJbg9B/QjdCSISL1jiVdlH/AId?=
 =?us-ascii?Q?HsYARf36eQwzCJfsMeDN/RF9uR0YyTMP4Xx+zIdXvd3YrFXz54WFyrP5EJ/h?=
 =?us-ascii?Q?Ua7xOyZ4VF/Quu7UhHlZl/ZqhAmrf13qXRQKMaHb6svchUTifeFwj+w0ESWk?=
 =?us-ascii?Q?KaOEyIswc1xEHPbYMAr5DjbGdrmp91FN3rM/LnxN2f3l80izHYez47e1Q2gc?=
 =?us-ascii?Q?IENdS+UeVrt9a9M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:17:50.8548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859d32e7-87bd-4002-2efc-08dd559ece36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762


Kevin Krakauer <krakauer@google.com> writes:

> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index 02c21ff4ca81..703173f8c8a9 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -21,7 +21,7 @@ run_test() {
>    # Each test is run 3 times to deflake, because given the receive timing,

-    # Each test is run 3 times to deflake, because given the receive timing,
+    # Each test is run 6 times to deflake, because given the receive timing,

>    # not all packets that should coalesce will be considered in the same flow
>    # on every try.
> -  for tries in {1..3}; do
> +  for tries in {1..6}; do
>      # Actual test starts here
>      ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
>        1>>log.txt &

