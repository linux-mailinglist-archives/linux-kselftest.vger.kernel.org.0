Return-Path: <linux-kselftest+bounces-45991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F55C6F9BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA04FAFF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBF22C21EB;
	Wed, 19 Nov 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WGJRWTmM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3512D1F40;
	Wed, 19 Nov 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565009; cv=fail; b=Bt2aCWGG1jsfhVnlCXVn2UdCaOaCekxyrmKmqwh6+5qVlOrMidBKIGE3gH2/pWwzCS9RSQ1hnxi4nYEnUT6iXIdO5ljbB4q6T25TYqf0rVGHhYInPhhIpV/PFoK2lELP+bYAGDMm2hwdLPZKgZqhh4suLDV3RNz5578rTrh9zWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565009; c=relaxed/simple;
	bh=AoV6nC9v2qWbCD25m9K8U/Xn5JUzYf5zoe6BQYC/R4s=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sO6yYzk/YtdVdadbdzrufmAy1iT0gfx0bPJRFgscPfAwFBJYVYyC5xigezVTDLnJ/h+QxUcziL4YMJWRifnJwuhljK7AOYnKQbXjHOdtOBL1Hpbmu5A0zu8uuNiGYDpkjbv2GaImnFnQ+f80mgei+kfElpUpE3301UdpYWFSTUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WGJRWTmM; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1EcWOYd2ubNVguMd9olGwgjYwrWtuVnzY9m3i6QIbK5rM8w7rcQUpcLmfy7REBVF8aHSmtC0/GiWo79RwioX6CKdbejvUxFHuV8Xu8x5S+wMH0n7sm5vyUBIjj9ImQeDxs+h++Wb55Cl5AUSftz/z58YNZdWI6NDMu1H/f02pccO44LRgIk3I7jfDCDjNNTZj5KPm9qPiRfIVIeUmREOHBPobRboxABgMaNAqG6br4BAEXjEZyR1OzJfBu8/5dPuuephx2S8D6oHycgRo62NUsVBqzo7EuUwgqPQ/qkRQR1u3kIk7zrBM3UffTK76cHEqM9i2JnGNhhlef4hwCFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoV6nC9v2qWbCD25m9K8U/Xn5JUzYf5zoe6BQYC/R4s=;
 b=lCUHI5Bp1EwLBup+QxLRYGTXn5bztPsOX2tD98xIQLwpVclMKroMDH0+9B9ZmuFuWkL90Xs9nxW2AEoVAMMUDjWYz8Od+1/AKKmSnrUmAE7em7YD4Uz3OKdRnqqNNcKTGycL7HZbGE6Xnekm0cvTkKRqzfJ1y0bhPcmJFi52xJyNMcE49MSBxxDA6s8vuzI9aPilg/7Q4arHt//JQAgTvrCl77t4y9EJ3N3cGzk3WtHOh6Qihp7GDyQqUnLRwKV/wDc+2O+z/qrroTqQEykr5ybEE9ZLBjBCurKeErReQw0CHeJiUKOfu3aG4oP+zNn6VoYel0WoL9EUAg495msYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoV6nC9v2qWbCD25m9K8U/Xn5JUzYf5zoe6BQYC/R4s=;
 b=WGJRWTmMsua00cFvOJqNPI+4dR5Eg0OTnZ7K+UmqqNcUfYoIW9AXK1VPfzeRdTv/uYdUHIUwglwrGrQ+YWtA3AVkU8kUrXPzKwKxTzN4VUG0Sy62uIk7XzkuyFjatEmlUMR7nQI+kpdZdALUAujk1xSJ8MizPY+U+hfuMCt0mwHtgnAE0jSNbNui2XiWMTdbnz3/5zQSFxTARm+J+8wuFehoh2/t9S3pShqQq7P5G74VwlGlHwyUte7ns/VD9CdarG98HsnOSwikHApAbykjgqvbrb1+0GQlX1yPx5U2qdDOcHlTu5pMGg2u0MscM7pvMuPmjbnxhnglaBGF5YtWhg==
Received: from BL6PEPF00013E13.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:14) by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:09:56 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2a01:111:f403:f901::3) by BL6PEPF00013E13.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:09:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 07:09:31 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 07:09:25 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-6-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 05/12] selftests: net: relocate gro and
 toeplitz tests to drivers/net
Date: Wed, 19 Nov 2025 16:09:13 +0100
In-Reply-To: <20251118215126.2225826-6-kuba@kernel.org>
Message-ID: <875xb6cb4u.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e1fe15-3ed3-4eea-a783-08de277db2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?voME8cT8gsN6ITcetblwc9Dr+oPfVKixTT0T/43w9nmeheCRfJJlLwC/4G3i?=
 =?us-ascii?Q?JdfzAQM4SqvDx0zSW+KIcHzuVhpmXcBYclBixxjVfyyA11oQHseI4jMxzP2d?=
 =?us-ascii?Q?iN/3EufEbggXc+uSBvYgBL+Bow5rRpOb2xIWlCCs0v1T0k0b4laqTiTpOUYb?=
 =?us-ascii?Q?aeULFiKW3z3ThlOSc7xDsubHUmZODn8RNRUdTrqVS44lb4iN8Hl3oRyHx5PK?=
 =?us-ascii?Q?dxwjGbqDNHt+E4nFeGqxFIY+Td9v99mZONqxcvog8kuQJZluyzETUYFPLpBT?=
 =?us-ascii?Q?qwmJY1MRI+BKEvWup4elX2s+Ret9btGUgGGwXxueslc4gv+cyy0MhNEF8m7H?=
 =?us-ascii?Q?/qWilKE77VS+ipOf058V3mQ7VV+hSG5PM8QqEQs9Uffvh2b2+LvYIBAJBeck?=
 =?us-ascii?Q?U3Vcc/5b1Ym7fjtm4+DCBsqtzeLKWZwS72iQ0DryFdcZEx1fUr2VTD14FcI6?=
 =?us-ascii?Q?wWMT7zskISyvovrj1FWhemae/ZTthcbxgNkZo9W0M6R5Eh135KOH8pm+nJQV?=
 =?us-ascii?Q?CCYbCtgVOQ9wHgVryhnTViGZwqjW8EPMFxOkYpOHr71UKXBKr7asT2lxGqBx?=
 =?us-ascii?Q?cngCX2blmv4AAR+u6SRFbh0jcYXN81UMTklYFlW8j0eSadJN7BvTzg/zz1HS?=
 =?us-ascii?Q?QL4d66h7kCwqDdQ30DLSuxxDS5ZkOWmy57AqUcuUIdCuIXGd16e/5wc9kaMr?=
 =?us-ascii?Q?lMHVHn8HR3XEYDLWKhHVnq1pNaIpxeipuUR7Sv93JDubhPBGges9re5q7nnn?=
 =?us-ascii?Q?uiN5HMF3M1RghjToxmZP7EUSawyYKDMycOC6a34bdx6rBQSpAAbGP6mZmaxO?=
 =?us-ascii?Q?Dyef0Gpt0rjMUJ69aEXTkaTjNZ2L/wPkyv48pIbJ7eYBZy5PPWX9khCtf+aX?=
 =?us-ascii?Q?UcRme1W5GfLYBrWrPUaEg0O2JffDcDwRlbttWREGZpXQKUaauNJuJCGUJlYy?=
 =?us-ascii?Q?zpe3HxBFIqD3Qqzgwe8CZZItoDj6YXbL85OKRxEYlqo3uecz6A7iW6dJPxXH?=
 =?us-ascii?Q?GKlfsj4wQUg1OgWZky0AypSOoPSGeReAspffNr+LbA03RD2sNVs9Yivs3H/q?=
 =?us-ascii?Q?uVnwAfXrPay/JRKWyW/ACYSb6MYfIltR7WvQRjJdinsYlKhK/3QiX8/nwi9c?=
 =?us-ascii?Q?EoI1iooOneA7XSL/kVd7Uw12500dJfa31BKYjQsXbU+58nPGUcvPyVY6sOTa?=
 =?us-ascii?Q?JThOfIoSVp0oQlX0bWgafTAH2jTu9dsZKgaB9k7VOdbnXiy27WKTrYpFuwUl?=
 =?us-ascii?Q?npu8QZ4UAST9fA++e1UIBlB2f/SzhUVp+NyNfTnhewEkdf1OW3dMkI0DIcPi?=
 =?us-ascii?Q?2HOEmfvVKLHQ1/34dvjPD+mF3F60jwXRYsH/CGi7a0eJak5pNFQNakLBd2VW?=
 =?us-ascii?Q?zceXhx1HWMBeZN1P3loNdgJ+ccB9+lFt4C3vLVrhf9hHDq0XInhoPbO5BMXu?=
 =?us-ascii?Q?QQx3TjMVW8w4R22nFW0hLNykotAYolxE0cwWXkaBFQakkMJNFsUwg2WbUcxv?=
 =?us-ascii?Q?kVOhcPNmrrvVathjgm7/IK0RHRp3g9tuqfwv1wJcG5gJ+5dQGZ/7YxxRRhfD?=
 =?us-ascii?Q?giOONV/QG9+w0DjEObQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:09:55.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e1fe15-3ed3-4eea-a783-08de277db2c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A


Jakub Kicinski <kuba@kernel.org> writes:

> The GRO test can run on a real device or a veth.
> The Toeplitz hash test can only run on a real device.
> Move them from net/ to drivers/net/ and drivers/net/hw/ respectively.
>
> There are two scripts which set up the environment for these tests
> setup_loopback.sh and setup_veth.sh. Move those scripts to net/lib.
> The paths to the setup files are a little ugly but they will be
> deleted shortly.
>
> toeplitz_client.sh is not a test in itself, but rather a helper
> to send traffic, so add it to TEST_FILES rather than TEST_PROGS.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

