Return-Path: <linux-kselftest+bounces-16284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E595F43D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1024F1C21E9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA341940B9;
	Mon, 26 Aug 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bu0W8ZzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BF189904;
	Mon, 26 Aug 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683505; cv=fail; b=TNbBnabO1N3gGE3Ohbh0jwwxj8SdOazCXIT4i8Por1XCDLiXj/rVl16EKCXBfRgVd7zOQdqVdBkQmNuojvNNIBV97L0bom524waBCgKwzjUJKQRV11z8oNC+F8799rL3ClTiPFGBvBSdVbCSnS/HUDvjReSzcmnuUQjqvxjtWeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683505; c=relaxed/simple;
	bh=0/1gCZTnCcIFICDdw5x67kkYqwWcyfnTaxefJeW8E4M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RFBlGDUbKp1wfZCZ86vJ/G5NkKrLUEUm/OM6v2HWw53cLf1ImMiAvjPkGEFLz7NAx50l0Q5xmETf6tVhc7WeIWW0he7ryjxnbc/a06JhhFUkWBGivmClBjBfEyVo7Vt6/qF+RO1c5WtSbcbaERZOa01R6goElwZY0hcFDVM5Ggc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bu0W8ZzG; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDGT6cywaIpnI2Dt1aZZ4CiD243oaiZ+n40r39HkY5Q4/FvrMSZV8eE1wUNCQYll41zjtHLAwoF8kUuOf7YoRNYoeW7DQwRIF0wl5IiB/o+fsKYCB9pyj1qXwEOCmRfVN3Yxo7c5il/1tAeJnx7fzJQds/hGQSGfrmFMrT1Lt5nxbHXaPMGrbc4CIEizIF4m5HS5dOK08iQOFtTD3xzbTnc3BqCQqiuLk87ucDxp9cpYtYCGA/g5Sd4v60JlcpnDxKMtotiiC1ky/Vit+0ZKIc0QdvOJ9H+jT8CGm+dZjhB/LH6yG5FNXlx30PXkeI67VTZcSHCQzA3eYqrP+dkMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/1gCZTnCcIFICDdw5x67kkYqwWcyfnTaxefJeW8E4M=;
 b=uuG++CzNBAHD0pcVtbRkAMLBmumvh2G7M3X0L9h6kKjZLYWVMIMg+6IqW1KLIJlqVQkFWq/J3BysB7kyVKShVCLHrLoSUCITMkAuPy7dSwf9O1WPiUPscuub0m4c0fwIEaVvMQJrF6sd6fGj9w1l3M0HMsKVVZnfaefKN+l1EKqQCZrprQmlBxjVaatTA1HKmqCQNL5DhvoiTMO6RIA29Dd9lRo5mqa7b79j0ezQ8DHoLwkGWkpjTKRSMQ4IERMZuE2YwarbgBomh3IqzQN6c/OqsdaBI6faYb8LcP03A+0wvAf+D3SOqHR7UgUJmfOVFk+iGKOf1YrgMOu2RCUjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/1gCZTnCcIFICDdw5x67kkYqwWcyfnTaxefJeW8E4M=;
 b=Bu0W8ZzGDVrQgv4HnUMgHCpJ9wGU3OUtWqap3wy94PR0aya3oi8g/ZjlZejSQoB3hF+NKso304PCHinIrtwBgO7w40e8bNMYGjlOjt7W8O/1AHK2S9OG5um10jePHVjFacd/mgO1prXEddxQudHGExvSDa/oeNsjFWl3yKKHSP/Bi0U/hZajJ/+gnLbUztPH7kVOsG1t6HO0wiR/PHMv58yuPzL/oSMioQnEOZScEuB5iNQC2nGW70KeZ2e3sDC86ZoPuI7j/oKCAYbzNLspUuF1o/jRBVPmO1ho3DsMG22Vzqdczs+C67nL2jRrnKh8GflgL6lyT/W0+dXhcQ/s7w==
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 14:45:00 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::cd) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 14:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 14:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 07:44:45 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 07:44:39 -0700
References: <cover.1724324945.git.petrm@nvidia.com>
 <7dac3bd8f776741a9816efb03c672c4887765ad4.1724324945.git.petrm@nvidia.com>
 <ZsxwHFMY4WMjbDee@shredder.mtl.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Amit Cohen <amcohen@nvidia.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 5/5] selftests: sch_tbf_core: Use defer for
 stopping traffic
Date: Mon, 26 Aug 2024 16:31:59 +0200
In-Reply-To: <ZsxwHFMY4WMjbDee@shredder.mtl.com>
Message-ID: <87seur8ht8.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: ba949b0e-d944-431f-4e38-08dcc5dda94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZtpJYNERAc26BVQEV5h+CgRz0fTwgTGTH4WhbR9DTeR1AoUtuO3E7rePUg1?=
 =?us-ascii?Q?cVebZbk//LtY6VIi73WX9UMIP5OMo0Tm45+o8l8XSuWS1wVGtH1+kdM+jW4C?=
 =?us-ascii?Q?vBNOWhj78sHbZvud7sqht8f5ZV2I9f/dcpNGYl3pTk8ZYW4ArMGaWCuufNmC?=
 =?us-ascii?Q?J57Z5CyHfsqCeUgSLlsL1JplT2idzeDjSnR56jaAdHSgmIBAPdBeSgOQamlX?=
 =?us-ascii?Q?c8EpYNWlO0Q9wVQkDYlYVCJXXXERnNRwqiURiMF9yQtl4t7wgHbEdC6R0KKX?=
 =?us-ascii?Q?02ZxTTWox2d3zzoek9AKUTHdkUDEZR5p1EIoW0hq8lSvLKH0X4rxjeo95xRS?=
 =?us-ascii?Q?ZxvaAtlvv++TELtKBkO/gjb8zwG530cBq/hMn+ORkTeZsRULW+n9MHeg0Z+e?=
 =?us-ascii?Q?EoOMCzFptva/oJHeengcrPmDeRilHQuKrOQZdZXhRzEvmLOyriguw0ZOM3T/?=
 =?us-ascii?Q?X9fC0WwHEtZXQA6VSblOXcyTv0vjUzsoj0UHSDh/L8feJPyrel6P9XOqhxhk?=
 =?us-ascii?Q?UDqH7IAm07EcEbv9ozA8q6/XD/YiNCc5i1HZvlryX90GHSAUtT3PChe7/qhi?=
 =?us-ascii?Q?guop+/1Aspu9f2KlkiFsEj9yh+ARUxSp9S3y3Xp1IhKcGtxslqUdaHdzgLCf?=
 =?us-ascii?Q?d87xZf80OtcGsWPtLFyRxRC41rV6o31grLVYkkUmAHavAUS93rk2pZ7eYk8V?=
 =?us-ascii?Q?sgWncdC0ZlL0X2dPPi05RsaycljCnTH7Rd7w9hZRBkdWzVTwb18VKfDlSB5C?=
 =?us-ascii?Q?kB8kwZcqBcLKrOsuYoiTVeoi2KW8A1gvaNBMbnaAbDIXHJWF84xV2NsuGi+g?=
 =?us-ascii?Q?Du2EipdsGu3uJ8Euk60F9bK9xwgqVRFlzc4zcYJx9IvLSEABT9Qp1AM19I8J?=
 =?us-ascii?Q?K6F1aXaKVoTXRd79bsHP0idBqev6MFonhoBEiOHcoFBP62DPFLxfSf6S7Qon?=
 =?us-ascii?Q?2uFhExN0u+Ocgaf1A2sqRGITKjgulugwYAcE5oY8a3BZ5tSWrAV+obW50uvD?=
 =?us-ascii?Q?RYXb5i8IPoRqdRwUyrM2HIU70JHUbngMDqwIFuBRjwuaR3HhRPjxw8cZyikd?=
 =?us-ascii?Q?tw2U7i8LTFYqCt4aAyjQmOL93cJoQB4Nqq6RcwDsvcueWi4+ErBQfPD+KCoV?=
 =?us-ascii?Q?EODFhQMt38u+FOD68ECencToMMug1wUaHLMOeoWuPn+2Dz8bFit0YCmCcjH/?=
 =?us-ascii?Q?ONQM4Q6lL8OJjDolRFaqIlAdZ7TPECXWk/LYWpTIhqVE9/cq9ej44Wu2vEPY?=
 =?us-ascii?Q?f1cqXn3/iwLaCKRs1fsVsgXwiz1uzTgGeLwAf7My6Lot8MZLlK9roc0yYyJP?=
 =?us-ascii?Q?a6xXsJGL/JXZMLYKlk7XlkjTDJtsv1TQ1G1BMeF9xkJyI1inSYJgI+Tgr9CL?=
 =?us-ascii?Q?G6CLDFioS2ADluAt4pX9IJXQXTdNCglbgZ+oebM7j9nFTU/8n7vZngXN2b8Q?=
 =?us-ascii?Q?Vka0F3phLbYkTxOcL3tiXWFXI235pu1T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:44:59.6465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba949b0e-d944-431f-4e38-08dcc5dda94b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661


Ido Schimmel <idosch@nvidia.com> writes:

> On Thu, Aug 22, 2024 at 03:49:44PM +0200, Petr Machata wrote:
>> Tests interrupted part-way through leave behind a running mausezahn. Use
>> defer to schedule a traffic stop after traffic is started.
>
> Any reason not to convert the setup part to the defer mechanism as well?

No. I wanted to see if it makes sense to have an entire test use the
defer mechanism, in addition to cleanups specific to individual tests.
But I wasn't sure what people would think, so just converted the RED
tests as a sort of a demo.

