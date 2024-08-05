Return-Path: <linux-kselftest+bounces-14792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FDA947CAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EBC1F22364
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70D50269;
	Mon,  5 Aug 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="srDs2Tff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E739FD8;
	Mon,  5 Aug 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867456; cv=fail; b=WiUt0/IJz8V+/H8xLW5h8MmULzqv9J90zSPvMopzzxZjuwCZCj8/lzqzxPHi+Sl9UG32K/oxJa3CRZ1egOMnLmvOxAIfpVMLCOkzDKGebL3+RRnJSj1BsEU2tsHLwNHP4TJ8z+aMNREJzJAwf9/UkXKh+6R7lJe1HHxkXbkhJXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867456; c=relaxed/simple;
	bh=stiYrxnifONXI+keQP1abwXzW2W+E1/adE5fVe2hXC0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PhDp6TIckfWBVYgRT3SZa+/Zhr7wJ2q/2trXHR5RNPTnmF1fkosiPxLjd/TN2wZr1AvWkA8X3vOemfR7kNeD+7CdesZSzNg8mfDNKuOwO5GLqWDVl0WnIF4z5YQ2H2ANui+jHyRyNP2Ai5cHrfHOlWYQ7sD4Hb1i/9Gx665adLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=srDs2Tff; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZmtD+EKBbjVNMozLB9KLWPA51UMBwywDultnFTh2XY8lOjvHF+t5pbp/Y9p3Xb6gcsF3t1Ay6iP4EztgSpshJwMKUe526tVFeuOnA5vqLQmEUSavvsaiVB1/Kwbv5FJBp4rN6yN5wghtZ2+1a6GUq+0escKEZDgVfQo9Go73J+44vImvuklB+EgxN5tKZ76Ao+xS2wevDhrOloJrOWyzgnneFmE7vgsdZ3uC/KnB492Z7eoeSJXDgIQpg/MY+Kb2eBbRMkITTyOh+G/x/aYEGCOh04HLs9poG3t7M3xnHi4AyDnSj050VwlhFhmNekGCrKwXCefjOA3VqIR/y5drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stiYrxnifONXI+keQP1abwXzW2W+E1/adE5fVe2hXC0=;
 b=WGVP5n1MRtQU+Ba7enlBhJsUvPRxklo4NvWj8mdQny+Q8VIzn1psnx7KrUxFhB0GW89d49/spcOrCOQ+rrGoY732Ed6HXFfpI5AzE9RTo4bbmiRkSfozsbt7hEVPNOnU1MWeRuni2A88I+5KP+f2rT7CO+02oqXJ0uDWC3H1vIycPvLCdRPT2IfCdC6J8qUoDpOaOkfWGFeSvsnzVZdT9EzC8o0SrXqGcQ8gus7+AcatNdBDkCa1DgF3hLhQqpZP/tNwQ9VX/RbbzvniFZPFQ81storlf+ojxp8h0q1/PAiwGvNx6QndFhpKpE9A5gCRCRdiA8YntqCOngjNMiSeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stiYrxnifONXI+keQP1abwXzW2W+E1/adE5fVe2hXC0=;
 b=srDs2TffwtxFLfvopttgwb4CgYuNGUBDoBsGRYSwfSqw5vA2MhKJ9HPt71Mu05QnCbfFGvxsP0PDtsaLrYvIrIKRKnn700lHfO7qFcLPLbG6op2BMAX+er3bNNMhTajsZkf49kub9LlLGb6p8+DOtY5ccLE9llkXpeqnUC8Kk9n1jx9pxE/daao8Gykyo3d42eJPkBTSWB+ooIqYfQSM6W+pbukvQcLeKzUe1YomdbhUllhRSgt+UVObC9sEcIRaF4SwFXPKG4zb27GD1EwC4qZr8DBBTNEFkhHH1Q0ewOpRMZzNfqEc07Cj3EwJOQDkAQ6LWjQ5ZrdZUdBlAduXjA==
Received: from BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:17:30 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::f3) by BYAPR02CA0012.outlook.office365.com
 (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 14:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 14:17:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 07:17:18 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 07:17:13 -0700
References: <87bk2yrkcs.fsf@nvidia.com>
 <20240803025809.674347-1-mohsin.bashr@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <shuah@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <petrm@nvidia.com>, <dw@davidwei.uk>,
	<przemyslaw.kitszel@intel.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: support verbose printing,
 display executed commands
Date: Mon, 5 Aug 2024 16:14:50 +0200
In-Reply-To: <20240803025809.674347-1-mohsin.bashr@gmail.com>
Message-ID: <87le1b3vh6.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ffd483-5b64-4ff5-649c-08dcb5595789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7UAd4CPrpkdJtU5oIGfiq8ZgVgvhK1c13ks6M6SonSmnJLPczMPxLQrcxqh?=
 =?us-ascii?Q?ArO0Y1zoauXHYvL859bZZSfOITVIx4MemmtcKjvcXD74uylmSIWm7G5/inai?=
 =?us-ascii?Q?fNXFDWwjUsoDb8jvEdItTPNmfimtXVAYy3sq7ib20KZnZp/M8m5VmLOvjQYj?=
 =?us-ascii?Q?OT8mHCyNFGNZEva4+BtY5z5a0Tz2Tox0a+lGXoVC3EsScO81Kn9BZgfXZEQf?=
 =?us-ascii?Q?9dn+g0q4cH2TNZtROWMVCz3o2z6Hb5GVctEKmiU652Jz3Al/O7rsvuQ5EBLd?=
 =?us-ascii?Q?wKoEvlo503cbH+a5L3TxeQW8mTlLKGxfsabpXrcKXY2LEYquDwEiEgxMAG+C?=
 =?us-ascii?Q?vsDs2cUykOcVpHnNweuY5AI012FzCvgQHK7UBRmaJR4v+3r271TZXKG0VfZh?=
 =?us-ascii?Q?PzYPF/fBS+Zx6vIWwVzORzI4vSW/pHQa7mS9KPAvoIMaosoNBtruuV6pP7ML?=
 =?us-ascii?Q?8NiZJN2rpGKEc0sJLhIJyhiGWI0n5d23ej2buYuRteXux1VP5C7837wMrlnx?=
 =?us-ascii?Q?yYnokk8IV8/lOtvFWB2DK42lR0af1YD5M9HwOzFQ62jwHtg64rHMfFzSvZ7/?=
 =?us-ascii?Q?/s4m3uFHmT3sCv86VTuHvbRZ5ZO5H35qb/c0F7ly8ffNGVp3UcGcNHQcXz+L?=
 =?us-ascii?Q?x8zWenvU8ibH1k4EYBgFrvrHXJ4weZ9+rPYrTx7mEjQxIExWQXR1Ju/HXdDO?=
 =?us-ascii?Q?j1gXOmoQtdDREQu1wszS8eTBXjWPPJm2enKxKjODujgb4sdZA4lajhJCCgD7?=
 =?us-ascii?Q?RGLo7viNMdhMOwCPTkfNxjeIYB86H9JqfqVau0ah8Oxvxs6ucuh7TINJlWTZ?=
 =?us-ascii?Q?kXZDO81CkJ2AoTs4cRo6vRcb370UdFYkkiz/i82ofmg3itWiCnu1Z4y4Hg3s?=
 =?us-ascii?Q?g3Mmnrm0PywrbbYiq92vTdGftOSE7iRvRRJOgUcKBMyf6Wqlk3aNrEQp9885?=
 =?us-ascii?Q?kTF0RLkfGW0h8xd3bXxolZRKvRXWh10+mwodWhL/Ud3NZ3QiNMy3Q/a9C952?=
 =?us-ascii?Q?V1lbTDqF9yit2tIpWReRA5CL7qfjprtpVK2RceP1pxzKTSnuYrcJDk9UorWf?=
 =?us-ascii?Q?o/YW+xzPIEdNvkGua8cIqm5oevrPhjO8UfWK0Kix1zuh7rI/e7nrRE8f6izr?=
 =?us-ascii?Q?Kgxd5Uqcqa65GIG6gRPtjjLSJVIsLD2+J390B9NU64/j18sFigM5NDqtDPmG?=
 =?us-ascii?Q?4j62GKIUnRpGG9tXAQ6TF/ynFaImEIs+U2Kbe6OD3unLPKR65Q5+XdnbRMV2?=
 =?us-ascii?Q?BHhJyrNc4wkKKL5wdVAEhj2n6NqQmec+VuGXDpGhnnrfLr3/RDGZifkcV9VL?=
 =?us-ascii?Q?if8d0tZe2PHjfcH9En76YrZLsDlnXB4M8+ZESo18Xmo7bAD+6DZMl/gMqWp4?=
 =?us-ascii?Q?PMuh68F621vd0KLl0Gn93bb7KDDBWMWPs/OquuWzhcZhyDIMWW06sEunAKSv?=
 =?us-ascii?Q?x9V0xcBr0UIgDFElH4tuW+a0gXbuz7fp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:17:30.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ffd483-5b64-4ff5-649c-08dcb5595789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574


Mohsin Bashir <mohsin.bashr@gmail.com> writes:

> Add verbosity support to show the commands executed while
> running tests. Enable verbosity if either an environment
> variable 'VERBOSE' is set to a non-zero number or it is defined
> in a config file under driver tests as discussed here:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests.
>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

You sent what looks like the exact same patch a couple weeks ago and got
comments from me. Please address them in some way before resending.

