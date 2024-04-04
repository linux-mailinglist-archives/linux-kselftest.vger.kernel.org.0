Return-Path: <linux-kselftest+bounces-7171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C0F898531
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB867288676
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E597F7C8;
	Thu,  4 Apr 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukVUDuhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CC101E6;
	Thu,  4 Apr 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227171; cv=fail; b=lci6fcNnTQnXyge0YHnHNZEZzIIu+NLlRoPLod8BUaA1UyeQguunjrz8QBB3mFLmT2EWkNxg2ImQ5+ZZJy/Ma936tyL9ABg7W4UOFHW7G1UCYWjGnk9H9BcRPivjMmEqEDuIoisxOVBQgO66JbYn1S6XIiaEM2YVha+s3i3FnBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227171; c=relaxed/simple;
	bh=KEXa+FqIywG8GlqNCLNnTWg4rJLprk4KRDELpBlsV40=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Kgr4UDmnGWdnBrOTdCBJyugzxF74kI3ZUhU0vH7Ba5Dve2bu4CCGgfbCRtPCjq7hMfwzjz5+FaY+yFNiI5TT6Ni8hwFV5AqWK42oJLys4PHW5Mr8zBIYB51vedrc+HItAZhshfLIjxp46oHHldBJKHmvJ46T25vmufIctQ7gWi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukVUDuhf; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAoxAqBfshCm/AOShtqPH03RNsPsI2mQWn9Gq9aRIs/0SDILYgij+S04V6acXmwEOoo8ZPBoQ4Xv6HnGpHc9hSDpAF48gOQwg6AcO5b1WHI1VoWwECDhc8/eY3rJyTP+S4u8sNAgj/I1kmxN0nVIMvxt2+WqcYWEL6y8GpAFFuqT6/oDLISvCqO7SMxIJmJs2XvVxZgWOrgCCWKGO+SSUKrsc8Asnlf62oF9GvCDRfR+DVzfy87cnrGmCeGkrR887XRVXc3M+Qyny4VAmbXzAscVpjeyIXrXF19ggMq3FyZ3Oe9bZVZ8Loaz78y22CghFqMLatcDCSyVS5Rh0O6eaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaF1k1r87oA87FmjpM2v5zolwzmM/4ZzqpOZ5rIYXQY=;
 b=izDtenRu3B8WxCvOVmGfkhAjXEqiDGyqCKGs7eF5x9WfrN3MY7ZPwZODLzh//ZiPDZ6Ww3jUmyL4zaTz1/lRKXGFwVADQxDj0Q9eKcqTwbTiqSi0S3faAAicZQ2oTK3G12Pw9QftAYCSM4zxfLUO8vhJXjAfwD1wMQZIsVp2CcxxA9aPN4MYnjFWrS38PbOxxtnPn+0x1Sn0bgfDTkcZ4uwsUBQeJWf0/bijRZO5a9Puf+KUWYcyPFDeQuco23g67SGRbaFZggy9p6vgPPT2lOsSJkrHu7wD9ybhf1aeLeKYq3yRoU8v+4TrxVXqpZsAecvAIpVTxLp1rKTGdMoHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaF1k1r87oA87FmjpM2v5zolwzmM/4ZzqpOZ5rIYXQY=;
 b=ukVUDuhfV+ZlFIT0QWG01uZW72TH4qr1F1lrg7r0k1VPw/2+d0PaLyW+XXNm7k8OzoCIQBlEMsp2ctLNWeCwngWUdG47ExgK8xWPqIQYQMb1+LM5wi6Y74Pku/lL4gNNmeqZ8FT5Bmty80NwxSOQcD3ozXOWftBekKyjGaIWNJ9U0iniqKeqse1fSJkgERZ/7pQN6cnERwl4XmNHs0GOj14Pm7lDnoWsjtZcTCNT/nPNAdtxKM1hv6kghrhyVuQ+sSTLAIG3qpIa80mKKo/P6mhcBqnAHfs1LpIoDRAs3InUzoztUWtFS4woVIlP8hsrbeNL/hiGlnnjD712eKNINg==
Received: from MW2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:907:1::32)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:39:26 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::f6) by MW2PR16CA0055.outlook.office365.com
 (2603:10b6:907:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 10:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:39:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 03:39:02 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 03:38:58 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-2-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 1/7] netlink: specs: define ethtool header
 flags
Date: Thu, 4 Apr 2024 12:38:33 +0200
In-Reply-To: <20240403023426.1762996-2-kuba@kernel.org>
Message-ID: <87le5th0ox.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d00275-60a9-4303-02cc-08dc54938013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7BU4onPyTpVSekv/sdAnioviimtghxylfzz/cFMocexMTrZexl7taQ4q3ZaSqx6cx6DzJNVlMhBGznOAWdktbWpZYzoVS5UvAKOZxcg2jGIHLz5tM1c/Hfx4u2M0SF6jK1v+6HAY5/R9E2Nw+Y9rR5H1GOIGyBYx58Yd1WsAcrsx8HLN0yROxo3Ueprr9CAE6EoeUGV3pFQR1cTcprqLklJqxoChqC/RjQ56+aPZVY18MUl25WVkxw1M7eSdDClSdiez77/ZYSI1H4a1OfPvz8ko5l8VL039RO2C+l23ARhG7dPC702GwmtbarCNHZYHICJlkUceVRJkcmM81eAMAzKciejmgPrPXZ6/tH1XCpMUtNvcijBaRigNj9dbt287GgVq2GMmRMCUnXLmOufDF/2J/Q6cZ2Z3HZErUnvKL9Jk3qu3OECQ3mspulYb5Z/9/n5YrcB7AavEt/ZDTc4nYDe6zdMRK4dAjNO7fTGvb2ctECTeJUd/8bUZjuXw8zZOXUdnH2oFwoF/AsRElpZpnFmr4Hi//WhH/H8BHVv9xHwguiYHrU92atQct9k1j27E0blklVW+JAVa9/mZlNiDLeikebqO6pkK1hi/BKgTipzodfUUAxzSFs5eq4LJ8F8q5AHlDMp1UrjyuD/wCIoDlsgqIuX14IsnCZ2RiYkHtLLVTpEYDV6V9XA1KQzoV+AgXtPSsyr6ma8lGB9+Ii4w1oMvMZw9Vfxzfzn8O0OrMh3wbNsa1sJxdXJgzhwE2Q7w
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:39:26.4485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d00275-60a9-4303-02cc-08dc54938013
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813


Jakub Kicinski <kuba@kernel.org> writes:

> When interfacing with the ethtool commands it's handy to
> be able to use the names of the flags. Example:
>
>     ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
>                                 "flags": {'stats'}}})
>
> Note that not all commands accept all the flags,
> but the meaning of the bits does not change command
> to command.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

