Return-Path: <linux-kselftest+bounces-46012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B0C704AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9E8992F21C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273753002B3;
	Wed, 19 Nov 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ExkCeVYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73362E8B81;
	Wed, 19 Nov 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571731; cv=fail; b=KK4r0/14g3uQnkjLTp2NQx+FURoPJPkxf1f+4Y6G+qXhruL3F2ucNVIqtqYy0lwwF007RbxgTIZD8X6O5As7JqH10phX0ZDxpf6vaX4q4Il5/fNVzUU0dpe18bekBe2rZlinCwG+N9Eg71RwEdhzT2oxb3Ei/qIW2NIF7Paq12A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571731; c=relaxed/simple;
	bh=T7mNt3YWnuOTvosIAf3Ef41qdl84H6Oy6jyGGmHuLPo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AHxZErlMPgm4Ugi3sLHCeyQN+YfdS+SXp2oCvPWzWg+ruqpVD5MYHJYHqh+uW8G6vcpxl0A2PYENexLlTKtfTlr5stWCTnKx5zOG0WoBffsYcQjGtZH78witbk0beM8P/ecgpV9nzmcHiUKKyX7PFWE0foUjOCDSE6CzhPhzhsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ExkCeVYm; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI4cf/oGbgOp5/cX7VTjnSItKO7ian2EFnYg1tVPI8VQE41nfLWDC87Koid1fJj/+JfE5vw75PG0RmU0nK+IsOpUboiWDgvfVri4IITb+E2Io31VrCLWfoJEr4cTGFJjMHxBLWDFUeGH5zJ3os9yjGewM1bE44+8P0hG7UaH11vOirvRuJ7LTPh1AdkNoCGswzKIBNGeapDdml78pYEllSUdFEk/04MejBuY5/DuVC6FSeQ+NTklHOr1VKXp4JE0J1vQP7NjTx6+JEHncud/eq8YuvkRVKZT0YUZBxEKASvOr9ZSXz+XgDS5QyQkc/CiU+LvnlafxJocU8Yq1nB7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7mNt3YWnuOTvosIAf3Ef41qdl84H6Oy6jyGGmHuLPo=;
 b=xV5e4DkJ5EE0Cjxb/Qz179E5QTSrcPl5rj/4cC3dLYYIIZnf1uyfHFiYbQW81s5wkBUFh6ij4bw2Vt/IzeQo2NDw2AWYSj2V1fGY8nEzX//NXgQ0q8G/zeimnt6BhrnzfGhVofknOr0/uBYc4txydLQALMaOjdmVUylnHaijM77Acke6y//EL0JeBQX0cC3/71clyjqkIj+jxVIRp6DCB0Zqk/G1tLGr+7B2qA2acxdxi9a8Yh6kf8zRZ1UY6AiEKPWBb+C5z10A00CKL0v+3ETFulMhKakS66ReCpUrMOHhKF0jrELgJarsIOsKHVR2OfKQwyjo7xas03MCaYCkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7mNt3YWnuOTvosIAf3Ef41qdl84H6Oy6jyGGmHuLPo=;
 b=ExkCeVYmmP0j0RGv9+fJGpGQ/h5uGSI54gSpdvfQMP7dFZzXD0/FWlKURzEGo7JB5XzJHsKWjD155i+fCH8KITQF8LUUzaiSKBcULtJUYpmWfNvS6fjHgNFAJa1TjuEmkiVbNs/s9lsyQOb4C63Wy3PExj91UAuW+JAdcVVVZsbtEPktnAN5z/68KdGW4rS12qYk91mtWkydG1jDDpoi9M+A8C0xZisE5XHXmFQebLu4rUB8VpkabvbMPv23kbb0fujr9BxPD8PUdu/4B4eJblS6+ptYt2K4htHO7jvtkXazC59ed68JdgJweiO0nqpeR+RJlA7TAwYtZUWG3zCWaQ==
Received: from PH8PR15CA0001.namprd15.prod.outlook.com (2603:10b6:510:2d2::13)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:01:58 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::8e) by PH8PR15CA0001.outlook.office365.com
 (2603:10b6:510:2d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 17:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 17:01:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:01:26 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:01:20 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-12-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 11/12] netdevsim: add loopback support
Date: Wed, 19 Nov 2025 18:01:08 +0100
In-Reply-To: <20251118215126.2225826-12-kuba@kernel.org>
Message-ID: <87bjkyardv.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dec0cd-2065-4d20-4db7-08de278d593a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DwdTTkwoTUV25xMEvNluEmPtgbPHGkMxfy4BwXinwn2a9mreLUcQQuc8AC7W?=
 =?us-ascii?Q?QApVbrtrajYZTDYJA4f8DRl/GuNXnKtO2Ks4g/H0LVRdcynw+eNO/ZtwEuc/?=
 =?us-ascii?Q?HQQisl5WMce04shUiNbmnMBTmLs9HATD5EO2PAUJoSMQz6go7nEeRAknOeAz?=
 =?us-ascii?Q?skYiRwffYpZpDOfkGTTiylGk07XxQP2tOZRCAqbQMZbWnzD6QTslZgnE0ycn?=
 =?us-ascii?Q?208StCFSlxBdDpbAdzmVY66ULeCYYjGUxJ3yKuEXxuX9tmJweiY60JSdXd0D?=
 =?us-ascii?Q?cq/mbJSdc8gl60GIOjQkARQeNz+VuxOos2p8Wt/1WQsxFn9DOP0dZVjmKzrF?=
 =?us-ascii?Q?B8FFSr6wL3fA3Fd4EI1xb72kOlAsbr+HKEcIS0hU3p8oJKP3a4m80zfCmBjJ?=
 =?us-ascii?Q?QsEg2s1K3T5+ly9so8BiwWGDk62h6UQENydzY1NN2tdQHSm+OYheTMBeItVi?=
 =?us-ascii?Q?6DwbtiprnMDeabRXHW8UMYla9dOcnbg23vIwQrZbVi8DgkASF5BoCAiX2kVA?=
 =?us-ascii?Q?fLWbH5ZmiqMe20NfWHGXvQaiG3Hpxt20C7iNpsTTRw7LV45uZT3KJgFrCEZX?=
 =?us-ascii?Q?iFTWxPtlYATETwtuOBW66VJazrCjoZVSED5OjGqNUyk50qSTku6TiBvkESpm?=
 =?us-ascii?Q?ZnIKCuAIUL3MA/lp1hvTvZN1VjKpzzCyduwH6GH1JtXh9tgUFZxM0vsjGzdE?=
 =?us-ascii?Q?/DjbHO1BJIdKoFJjuU8aQCnhB0awg3r9Z3Zv+9aDLlYxwaL4HpvPlMJwj1L0?=
 =?us-ascii?Q?7Yina50R6dg8TqWE+47LJy8fvwgMUb15zInDB/zY01BgExTQF4HkQA9wLuHH?=
 =?us-ascii?Q?yvxRao2ub3dDqysictdBHmVhXnOrXhPqccQI3fAy3YlzjFyGdf1XhW1rxDBj?=
 =?us-ascii?Q?ld9LwbVt/D9zHWD7CmR9sEF++GbqKvARMtzavV4t4Yd9akbdzMChbmcKvf8p?=
 =?us-ascii?Q?qx/aoGlv3u3MaDBRQvXvB/q7S5qb9H6M2zJp3Z0nGNSj2AurlDsxaHly/MBw?=
 =?us-ascii?Q?NgNSAlzckHaSYjjThRmKjBNQl/YT/Wja6QSQJNMlRum1flJ/dkz8eg/kh4nW?=
 =?us-ascii?Q?u2r3EzdyRei5gd1LGb3d2wUScSMWJ4g2L95ha6V3YQSwhlpA0MLYGzdrIxCv?=
 =?us-ascii?Q?cALpGzqPsEZuZdTxqfgYZoHU7ERGSVSQnKqNmv1C86Ubpnc0Aka0oE7jvIzo?=
 =?us-ascii?Q?SgwYXtd3X6JJ1MVBnk5LoGELulVAxVO7zM94wdsF5Cly0Iz7N6q7tYRZp5DJ?=
 =?us-ascii?Q?Oy5XC/83nTEVb3hpzz8wJyGxtw4PVhHxSVhElu+XFV+BezO7dqy6/4/cV/+2?=
 =?us-ascii?Q?c10ygnZUPmJ4SdHdeX6HrcD10Se2QXZqXIs5bXGC0f1GqQIQcYk/pH0tJNm9?=
 =?us-ascii?Q?k4uFdxuUjdoPW3Id9anY2MZsPXuw69yotVa3KI8KIN7n7OuvsScvSKq5jnQc?=
 =?us-ascii?Q?pIXhL+sWQOrrQudyayIifgd8nzBCTLVJ+oefy19PYQ1DpCRM9AcSRJEIlXsP?=
 =?us-ascii?Q?5sI7V9NdEwpPvBPVsGwDKHpv3Vog6M7Avf30oBn4HyPFBtyNC5rI+JAOgsV6?=
 =?us-ascii?Q?vC/VcTYKRzE+euB+0J8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:01:57.2578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dec0cd-2065-4d20-4db7-08de278d593a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413


Jakub Kicinski <kuba@kernel.org> writes:

> Support device loopback. Apparently this mode has been historically
> supported by the toeplitz test and I don't have any HW which lets
> me test the conversion..
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

