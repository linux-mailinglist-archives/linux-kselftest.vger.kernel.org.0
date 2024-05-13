Return-Path: <linux-kselftest+bounces-10138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0D8C41FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 15:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E7EB2188F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE46152E14;
	Mon, 13 May 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVjjEYo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DF1474BB;
	Mon, 13 May 2024 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607282; cv=fail; b=skp/kOlRmaR0Yc5NzgJsnaH4m8XvyOvlvOENnN71egZovvb+e1mEJyXMTQ1D93d4SG7WMnMVTPVDquAntVn5FBDj/fHF9Fikkyr3HioCA9ypkW1PFLUvqzSvaJeKv95oFP/PxF0zxYpfmoqnqCTEmew3CVTFz5jYTqlSooVP+Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607282; c=relaxed/simple;
	bh=cR2tvGCfekbzyzPrzC7U3tlu261eK3GFhQQoUw8PMLY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pb+0YFoyUOkOkV1nReNHzueTAexDVOjW2P6mvf7u00vNpmUoD9sHqScT77Enatnk3CADrBnTSqmUNSCtigPYR8RF1Yj0QUvY3/CLCW0x7xdj49Hy3zGBuumaIOAj6hAk14vGElFtFs0VFLDxb42aMLJ2kQXMGTWI43H4FHywRDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVjjEYo1; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUdzrGqSsmYObgGGPtc5VAzkZht3kc9H+6Kbc4o5wcvZHCsXJaSmyl+/alu9oxVL3UkT2qqyxdwcvyZHTF4LfA+9emL73ql8trtgRn0aa5JlKbPmXoxzWkXOBOtlYLsP3pOB97Bl+tk713yn5wVaDQ1DowEyPcZrhqStFX5AOow7bxFRJiV8ZlTIlqJ3gvxGvjQNsnLD7JGpAspw7NBh//lVyimRhNLuZK+SiWfUjBJGkxqRwnjlT2ut6LRbQnNoGmlW9GXFbF1abJIGnvblvzCVrfR8gpmfefdjYCzzEuSwgUknqEoVq9luL9f3DXTJStdfT2rxLvpjqsoY3PtxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJDBgMBNSIjV9p58fbr9Gs4eNaEyBdvJQfuZP1E5mOU=;
 b=mFVq6Kjli5ZrdOrcTU+5KrXCgoBYluOSyVxMq++SugtOMjZEUiUp4DjM8UItcmjI4ctDO1quHDinLkk5bBWAUw/l/d9bNz0UKpir2CtR6IxqHSmMsVYTIJRFhSvdaFaHf8xTOBrzGvpKxaYvoMY+HeOMw6muA+cmFdYwaFVMBnKt3hSuaEDiUGd7LTJaymtCaAKrISOKV7jDS6pGqUxzZzren2Vm6DXkU5Ta7x5amw6CrS9eKEVsb1m85HH7QG32hQr4SVKWS8QCH69EM7NIEzc5f7W5lJpeMzPojFPBv8EvQlKi94zJLbaPeE1KhzZxnIm5WHSih57DKFurrjXLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJDBgMBNSIjV9p58fbr9Gs4eNaEyBdvJQfuZP1E5mOU=;
 b=eVjjEYo16aXN29wV3ExLhLrxQG63AQU8+RZSfqhW8W2hFkgfwLXQYa2xQbdr/aFV0rftjKltKKhuwd+FsCpXFo4alOa9WykLQf0J8ZeN8DL35aPq22OqCfFiycYFcQ3ZJ0aIdRnQ1hCyg0AT1AIsCHeDhgd4lLX6F3MHQj3X5Iq7YFYmUPGOI6WyBPdk2j4Krgmzeg6zf86PKZgCry7+bbv5v3tc8s10Z2vDrvlYR73lgmR9Qy9Vx48MIbFZ2URp6tOzB5MuytmlHhlSBaA78lF66eFnxD7TG1M9n4VcasQbX1H923mm7HbUeU3QBD9rQchZcfp5zIVhkyMBHz3YZA==
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:34:31 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::c5) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 13:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 13:34:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 May
 2024 06:34:24 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 May
 2024 06:34:20 -0700
References: <20240509235553.5740-1-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <shuah@kernel.org>,
	<petrm@nvidia.com>, <liuhangbin@gmail.com>, <bpoirier@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Date: Mon, 13 May 2024 15:25:38 +0200
In-Reply-To: <20240509235553.5740-1-kuba@kernel.org>
Message-ID: <875xvhu97r.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: da6c0264-fb88-4296-517b-08dc73516b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4zCepL26mj2hF62H9yt07Heli6iFLSZzKUFR26UhsmUkzO/uRW+PUhdwcGC?=
 =?us-ascii?Q?dscXhX9vECmvBdr96P/S1CZyLKs5qRyNfFG3Ajzs+5vyrW+pRZjeYtEzhySF?=
 =?us-ascii?Q?urHr/uuHXb4PodyZCwLIRuT21rUtLbqLXZ6oRxt+i/hXF1Moa2Hu7E76a3hi?=
 =?us-ascii?Q?gdqRNEk9tJhwb7XNmp6AOPZ97DiEdmqbHWQ65XKbNLW9IPOIBeX7va87waBM?=
 =?us-ascii?Q?h2fXmBZI/48xa8z0DpNt1amLR7eWSK2uROEolQOHCrvSrIj6tKO3cwCO+xw2?=
 =?us-ascii?Q?CZjG6iK1Fw0V/edFbDtMo8sAfXAW0eBIPkyXenE3a+pCPYNr762v1shWBHko?=
 =?us-ascii?Q?U19EnSLo70Zni3fZWtbfMEFtEDM4SJoIZExEjoXRRsDBl9h64tf64096kHIC?=
 =?us-ascii?Q?jUAYZut4V5ClIJwCNyD9gP9Bwkxv8u2ArikCY9bXIgmtbsgtpzKiSCUVddS0?=
 =?us-ascii?Q?MfI09BFm03VORwczDjF87ujyMVzCSl28Siu7uXG19aFDfEzeisSqL96qTbAD?=
 =?us-ascii?Q?meSVmCAFchuyNbKtSkAJJHz0NpZg17NSskCThVWaCEYMWHoa8Y9jAbX/lp3T?=
 =?us-ascii?Q?12MzRqN3RzUlnNFDz6RA+vSjmcsAsLJB5AaWNKVJwOlIO+nqQZ5j/91jAN2e?=
 =?us-ascii?Q?ZSJGxRERRu2wc6fEvFaqHvGdX0GJ9MnoPssEVUJQ0eunDVsd4/n6Po/ufh3H?=
 =?us-ascii?Q?2DLPLcwL3iuPeX4kNMqaOn89+IunjVdeE+myhZHEKqjJmyJHRBTBpV9CJr+v?=
 =?us-ascii?Q?pL7Lj04bi939F6Ge7aRmDn9hh3yqq8wifS73xFvfBESYnqV9BOnWPiFgvJ9V?=
 =?us-ascii?Q?HeUOlvniHNRWROSP163NYOIjKM+n+xRet1Yh0gnkLy6DhXfBRzOss2MUiJyv?=
 =?us-ascii?Q?0gKc4HJwFcsR5X12bvvaW9805sbxKeUyfcUHlsRgqWbVtR5WHTe/iMxPNjRX?=
 =?us-ascii?Q?RM+YwoUo+mGIEpfQi1fBZ370K9DMyQnBz5TvcKdnGif1kMjmqagtzmv5LDH+?=
 =?us-ascii?Q?vPavlavjXI6mc6+uh2l4Mkz/sLaGrOscMq7LxpxIVr/ojTdyFpawpQoEu5Ms?=
 =?us-ascii?Q?oY0V6GDspCMYNAYTiWwXu5zvKvcWRSMxKbeE1EAZOcstnERfglJc5F9l4JBc?=
 =?us-ascii?Q?VXXxCQey4qddE4/tlxG38LgIgPF5/2mJvdqmQiQVgsxBx3yxRCEdKK9m70JZ?=
 =?us-ascii?Q?ggdlPICTLhr7v/Z6SEdN7yX8eYUYLKv8Rzmitmr7vV6Lp6Darv9H0AB1Y1Va?=
 =?us-ascii?Q?dOlqDJYs+7alyaGItNrZm5bsPaRym4MnH4KoYRSfT92pEnDw6/gn4MDUCDd2?=
 =?us-ascii?Q?SOSVYpYwqKXi7hm6hAQW9vB5InYl4CgPGlGQk0oucTX7gg9SodePYwitWP7b?=
 =?us-ascii?Q?1jfJXEE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:34:31.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6c0264-fb88-4296-517b-08dc73516b8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487


Jakub Kicinski <kuba@kernel.org> writes:

> @@ -157,7 +168,7 @@ run_test()
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
>  		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> -		false
> +		false true
>  
>  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
>  		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \

For veth specifically there is xfail_on_veth:

xfail_on_veth $rcv_if_name \
	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
		  false

Which is IMHO clearer than passing an extra boolean.

Not sure what to do about the bridge bit though. In principle the
various xfail_on_'s can be chained, so e.g. this should work:

xfail_on_bridge $rcv_if_name \
xfail_on_veth $rcv_if_name \
	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
		  false

I find this preferable to adding these ad-hoc tweaks to each test
individually. Maybe it would make sense to have:

xfail_on_kind $rcv_if_name veth bridge \
	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
		  "$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
		  false

And then either replace the existing xfail_on_veth's (there are just a
handful) or convert xfail_on_veth to a wrapper around xfail_on_kind.

