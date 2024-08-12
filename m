Return-Path: <linux-kselftest+bounces-15159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC194EA72
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE93BB21AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD316EB5F;
	Mon, 12 Aug 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJsOzCdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF416EB60;
	Mon, 12 Aug 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457067; cv=fail; b=Cse65rHxtG0kK8RqCDIGe2JOTAOZzwbbb2LIGKVHkLuLy4v6iLxTwtWkBVcmw3LTrNr4qcZIYFhTo+a0Yl6Q8OTtK5ZTfw1J+ENUSeZBFfuERjFfzDUYq6IJm7KVCTFl0KqviBGax/mcSulQLKtXwWcBY3pnfxBMyPb53uyMY0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457067; c=relaxed/simple;
	bh=g6IM5aUtlK9Vbl9KrMUUHqa1+OOIhaqMd2/kFqi15N8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eUPsHXOWAvigLd5mdOeoNMpfB8TCJ5ng08Oi0aGrNISqMIgAWjAAFg+lB0UCOXbwQvcnO347v3sAk5LC/NLhtMmu+4EwAxdPwfVd2qgaBLFTPFBKKDDZgchAWv1L4ia/2mhMLPl5uPuxPBtFVC+JC2SLAHwDEagXdh3MPq/5nxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJsOzCdO; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBN4/aMLnmAsZek6HbqMSVa/6mBsLivyk/cvbZ9HiUCc3RRdDu5QebARpqWxFhOajIJm0X4fRb+41HFgTfpY2nBlhD8bdpE0lHyaMiCRYY9Yy5T1VxskI+kAjdkCZYrLyhC1kGTLwx6l9+IHTbSwFVFuiaLiEbsxytHN41+x6kLlZbv9EaWrdvzdxrQ7W8wgc0p6SDKR5cZ5RDORUbqmnCRMzWpX2P/callHKabRX/Y9zSq+8FT2FSPajqWGGI/XXQlSuyebRSORYgA+9DCnmXAM6b/E8LPs2pKAw7i248oVn17NZ09wI8KkFZuY9bat85DEsZqOB53a4FPTwBT3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTlqVY9z/bQTb5/dq7wqWMT5nYzudc7GxWssuOkoOa4=;
 b=scelbvCsq2+8EzkGmsl6Rbf34d6l9HvxRlKa0pHea6TEYJ+7Id4hjVU42CaSMyL0xKw9/t+Qm7c8l79Ppaeq5c5SYCbc4fSJNq+0ool0xCWW9DV0Me6aepXfYH70GSGULjtvjs7wgp7ilSrUAS6PQsTpiHyxMXQH2KShTt8Mxos1l55ukYQGDWfBf3iNpBVWeCMaLcvMUwGOELOr1bbCY83QV5L7xnUxSN2/+mgawqCPefIM1quBG+tsKToi+62kbkJ1Gwl663Rf8Adwsd0PAmoTZN4u594tLVOrBRDO/OB8BT/887lPQ0Sv7k+r8J7efmLGSgXYWuYMbZlh2DtD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTlqVY9z/bQTb5/dq7wqWMT5nYzudc7GxWssuOkoOa4=;
 b=TJsOzCdOOJ29HwGl0/j3Jb6BxBqt3G7ltqqi2D0t/Vid4kdl1hAXH7XQEoCPrkptSLy5743mSrkk7rxnHGxeGfc48kBtvNwfiQreFQ5rTuiQGcZzqQJcM7383hJyPDdF/3+nYDNKbAF3aP8HHtTLHQUcUeX04twRIpynNVQMRyLnk/FzU5p+uxEtC6Gr9ztOzxAbU3HTHo3DAXyM/Dk4O3QaR7UdYCWeGVpO/bgcz6hDDSYPFHHQ8T+mTrzFtT9L2xrZYBjqjB9XqYBd1KvfFYqUMInuIo+MyLAc90VR1YKJMF2BidNSct/mHURMku+ehkXO3qYo+TJ+H3ZzOSDr+w==
Received: from PH7P221CA0069.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::27)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:04:22 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::ee) by PH7P221CA0069.outlook.office365.com
 (2603:10b6:510:328::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 10:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 10:04:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 03:04:06 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 12 Aug
 2024 03:04:01 -0700
References: <20240807002445.3833895-1-mohsin.bashr@gmail.com>
 <87jzgpna14.fsf@nvidia.com> <20240809210342.244413c1@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
	<netdev@vger.kernel.org>, <shuah@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <willemb@google.com>,
	<dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: py: support verbose
 printing, display executed commands
Date: Mon, 12 Aug 2024 12:03:38 +0200
In-Reply-To: <20240809210342.244413c1@kernel.org>
Message-ID: <874j7qm50y.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8bbf61-74f8-4ec7-a43d-08dcbab62361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWkV3yAeQ9Txf74J/N9bEU6u7+1nlE9abyAjbH9Ic+4dGiZrh3o0SB7bW6FV?=
 =?us-ascii?Q?Y/HxswUIzold/h61tviKOr6ajnzOcA8ksUhNh8gJ627ON881v4uG9XWdTBAF?=
 =?us-ascii?Q?IKTzbQ7UnfR1FUzowKIduNP5gFWipl2BCfVIf6Moji2x1ElZXOjbAUG7boEG?=
 =?us-ascii?Q?NH27y6Yzzeupp/qAXFpKodln0a2uwHf+BjYohZ+8xfylZVy6Gb1Fq5LbosNz?=
 =?us-ascii?Q?/2VntONITamLc80c7usIe+uyA6YXFEFW0C8Mt6QR5CZu6qeqitaoApN4zky8?=
 =?us-ascii?Q?fbDVPqd77fIv95U1CkWVStTa8mKW6755RHPUIEagu7lwyv2ByVd1wVvk43T5?=
 =?us-ascii?Q?/jjSWunuvsE8VDhmnCDYPQYZzOFO5LXIQ0kgA0ruqyf8h81MUOGO3vNZXLqI?=
 =?us-ascii?Q?sd9aHGugorJJ4NTuVTtrXU48soprTATH02xqv17A7zOtIMeNFIE8QX0PFyrA?=
 =?us-ascii?Q?MVqkSJ1eIWh3mpQ5Wnok47xEHXX+4GJTuo/M8CDCPOmu6glG47LEpLxDEmVU?=
 =?us-ascii?Q?TX8wpzMOw/ZVsXzkIvb4C2d+gpw/W1bTLvAjhcx5a+u/0fiFJVh/nLijArXn?=
 =?us-ascii?Q?UUqkFpVjSoLF2GJ3SxormEDOohcEMZ54lXgqG4qxdoR3GiMiMKNIuZcktTKj?=
 =?us-ascii?Q?Nw3LpfDFaA784mkfp1iiOEWnF+G4z8x1+xthkep9TgEyG9xiQrJc4pVpxmvK?=
 =?us-ascii?Q?RQzXMX4P47SfKeoeqmV9P28S0ssfVO94S7QMSCJqy+U1CJ6wKED8wq5QgO+P?=
 =?us-ascii?Q?TKzUN6zpaTNalr+btKOmyC1cva0xpa/plMdkqq5LBNUu/ZQrOA/O+nvI0ey8?=
 =?us-ascii?Q?Tau352hklATW9L6T2OD+m7athq3sl+7Zj3O5znVq8pzUQtFaeaYNLgiUSUIW?=
 =?us-ascii?Q?nRx4NUdh5nIFYr357wa6qtQ2dmujd7j9Wf3e+rG+JxdbNxp+AMtcMC315+A/?=
 =?us-ascii?Q?+vvQSfasdPTUv6wueZX+v/Am9QA0NPHLoT0yomCnht1wUlS1yHevGxKz2yiG?=
 =?us-ascii?Q?dnaJOn9By5WPEOQg6lAbJkjMggwPBLvaTstXHnO8pVjOE5cNtZc58ZfUKU6s?=
 =?us-ascii?Q?diN3JM2rg+3q3yuZ+bub0qqgM+c1tb3kfGDO3hDyIZHGKifhvxgt6UHXkOfR?=
 =?us-ascii?Q?6NhHWuyiSrcgtYWpZp1hEqV+a8rMtSPVB5HGBxoVik3WA6t7YvEizYsc5XN+?=
 =?us-ascii?Q?WY2lM0vIDABS6qFYTzvMuFRDhivPbrbUAv+wkLis7u7U5D7cJBAj95yJEYVS?=
 =?us-ascii?Q?k1dKOym+frOksVNkWBySHYdsZ5956XNUo4nLfgsqS3fr4uO0Un78036zp9zO?=
 =?us-ascii?Q?PJ6iYSw/5dHIIFrpLRRyd6wgRai228Y5+Mv3qUDD1Aaqfy177EwjzztlFpuW?=
 =?us-ascii?Q?2W8P+UNVxbhnTMA8ISoUksbslBJvPtfS9hSmwNREFq9pWWL5dRB8HV4FxtnQ?=
 =?us-ascii?Q?QyQefN4sRfwcvCCbf8UHqJKCNebQLHoa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:04:21.8464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8bbf61-74f8-4ec7-a43d-08dcbab62361
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 9 Aug 2024 14:36:17 +0200 Petr Machata wrote:
>> > +    env_level = env.get('VERBOSE')
>> > +    set_verbosity(env_level)
>> > +  
>> 
>> Actually, the ksft_setup() here was merged last week, and I think that
>> would be a better place to put this stuff. It already handles
>> DISRUPTIVE, it should IMHO handle VERBOSE as well.
>
> I was wondering about that too, FWIW, but the counter argument is that
> VERBOSE has little to do with ksft. It doesn't even include the #
> prefix on the list it outputs by itself (unlike ksft_pr() which does).
>
> Maybe we do as you suggest but rename verbose() to ksft_dbg() and
> make it act more like ksft_pr()?

That would make sense to me.

