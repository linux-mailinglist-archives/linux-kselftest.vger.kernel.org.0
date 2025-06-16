Return-Path: <linux-kselftest+bounces-35142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE583ADBA85
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0287A5648
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF251F099A;
	Mon, 16 Jun 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfSrTt17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C61CAA62;
	Mon, 16 Jun 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104289; cv=fail; b=a0EIF5MCIVm0eU05E1JJwl5/E7ATtrlyo3hEI5dTfraD4lBWTRjILKNqtOx5p3PaDFWG6mSQPkSfI6/rAb4/+5L8h5hWqopcLpR1yKdIFmILzOcraPSspoEGKCINaZy92qMt8/hwVTGMKoMJmJekxYZmALEMb435mV/zfWpwQ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104289; c=relaxed/simple;
	bh=xDiY/xc15AqVJTg9q1TJdzn8G+bp9T8piCygvwftWkk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F36j0fh/nBAA/EjueK6oq3FmMUsblvTkZ4gGEdrYpTDcShBj7I68HtG3BbWUEJmyO13RtL4OuB6vcGEWq1MiduzxbgSmsGf9NyqY44TISCnU6pQO89ij2CxFm3TZ9QddLFnblyeUCtuqkSBool52i3AMK1ZBxuWbkgeaV9UNplc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfSrTt17; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnlqgHgP0tj5NblMkK9cMpyQH7I+HyMYZa10tRmbaWqLFbl/CzlpHicEWcMnFtTB6tNxMx8/Fak9dcm5BnR2jTFnGzrG1761KExAgMyUaAK43QB32A2GPVnf1GMshlJHtPOMYcd41XoYEy8EiJKpqLdfHTu8yicG+3IOOiOHbTzoJJVEOfgt61SHTze8a4O2pSx1Z+1y+1JYUlZ+D9oPkykAAcy/m7CKoq4omT5Kf/Q1NWVnBuiZjqb9wr6PMZSLVvw3O6l7G/7zok81N6IycraavkCCAo4RNSlT8/ggyYCJgmr067pg9teSHmHLZjlMP3x5PBR5AdoderSy1czY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XZXVuGFSaU4gYR/B/25jKWbZ7Q2YitZHgPBX2dpnMw=;
 b=ToSOA+V1gYiOTdG3IMHCF+lTXKLj8P/Gb8BfgwXnzrUXhTP9R6EjfG/5xcisR4VSJUuQ/Z9+BuSzdAF13vLMlGYmBwiaGFwuKVws8Nm9FRGha0U1XXpW4C6qFWpufdV6pnZZrw9I4mfVi/oxjhuhulF1syULKdeaNAL+nj1Px2GT36kYbsbtkJT5SCjwINo/e80tPwx1smXWrqKsEXKf9feHBYmQ7lSTBHnXlVGREL1/M9TqF+Fgd3sSN2SJXPCxjrjMU9jrxF5HIXOn27+VW2LxEsOf3RzdT7tZ5BaaBLvYxFBdaaZSjA6CuUpvO1cq8yTe9A0DkK8shB4Ey7r0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XZXVuGFSaU4gYR/B/25jKWbZ7Q2YitZHgPBX2dpnMw=;
 b=bfSrTt17oiY5fWCOaLJzMVkMRQgl4ZWoJ9lGWggG52sbZ7O5Qba+0cDhWWfIpZ3I42P+H3v/9BDF+aXtb5wvqijVLcZ+zBARqEda1Ewf06QNpaRNEe9ZG+c62bOsuue4LhgXFhM3eCYgxQY/lplfKyO+s8wijALOykBCK5CHRZVm5zwlU2NvOFHpHFRdallz73DzWc9TNjvH8rcTLIKAvDMLlgopALwmUBDA+hlcplFbG0WOdo0P7xmdvo16Q7OBVbUopJ92P/O2qs1DlthNRfjDU2Xib6R9ZpoNEB17kE9NmS51zQxAS1rEaunz9sT+FC2i9WKac0i6V07ZZB6DzA==
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 20:04:45 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::9e) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 20:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 20:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 13:04:27 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 13:04:21 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
 <20250613095755.54381628@kernel.org>
 <ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
 <87wm9bu13q.fsf@nvidia.com>
 <426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Matthieu Baerts <matttbe@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Date: Mon, 16 Jun 2025 21:53:24 +0200
In-Reply-To: <426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org>
Message-ID: <87sejztpvj.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: d014fb42-4b14-4298-8c57-08ddad110a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qxlr4MXu2X9NBTFrC391IW4RXhabPagN91CenQBt9mpVDWbQAq+wg3r9s7dX?=
 =?us-ascii?Q?bUL8BBBWjej/lUz3aapBO/6DR5flhlzAVMioLfYIKutnv/FkTVS5RW4ataUM?=
 =?us-ascii?Q?CUD7zTy+8hD7MNHudhJDPBAM9ri2umubck57o6zQ8VnAnxyuGicMPmDZ/kRx?=
 =?us-ascii?Q?NZYRvpC6Keg+7qIMliLqOTukqR66mtc7LLiIDTwk0wL5SsPaS0ZZJN+wa89t?=
 =?us-ascii?Q?sr9kqcT7sykc+T45AiH7cw5mVz4zOjwyatETFFSy2Esgs99JfN8RLi6w67Bb?=
 =?us-ascii?Q?ZdJOpAxGRi3NWNVwA+mROfdLz9jJ3x7EwRRDBjwTCVuKTLjMrBcnuvZBYrC+?=
 =?us-ascii?Q?ipZen1a8JHB5zZSvd01fCv+RcsiObaM9bMZLWLks6qWCprRGJ1ea4OW/E0ME?=
 =?us-ascii?Q?UXqpt2vHppbransQThC82lsmqzFxlIQH/JbOJDpjm11FZsK8nDiRl9BrOn/Q?=
 =?us-ascii?Q?mF3bAVCvlawQ9ZWlDP3ksH6HaicVPP805iMnQ0NciVSh6Ok38LufPGBvFmPb?=
 =?us-ascii?Q?HFVTmAMQQNDngAf/GGwIdwMiQQYEys0fSbm02jbX5APel1RR3XlZBKcnr/NA?=
 =?us-ascii?Q?MdbKU9DSR6usRQoIoAtgaI0udfxooa74U0kkG+tZazXD2RbR/pxu4WAME79V?=
 =?us-ascii?Q?u7IESUfP4vZCNO+EIDtHkFp3e1ls5MK8DIiQKZ8hfb7nB2Sgv5T7RLyZ86oX?=
 =?us-ascii?Q?ajWbuEISV50VRydw/Z+MuTWysjJ+U0VhDc7ZGZEp8XYdiex1fLNwV7w5Bpsn?=
 =?us-ascii?Q?rXRILeGydzjjSJteCDsahNPyPIxSxnlEuttH7eJ7ULQoFcEHyFPti5Zyx0WR?=
 =?us-ascii?Q?W3m4duuL4dzh9Amp0Ai+p/o8etz83/ZJFVEwtaKem0RCfCRK8vBLTmUfPY0q?=
 =?us-ascii?Q?VE4+2bWQStWbYSuQQoy0erY0BxzneCLXbLRBXbYILJByk7nJFbcDAQfiyY5I?=
 =?us-ascii?Q?YRdWfZ1xnvZIM+TD6kNxQDlVXIDyDGrri4gJ+9Eiso9tapcSBkKepqDpD65s?=
 =?us-ascii?Q?FmoJKTjdr25emkrMu4FeNu7L+2jOrbNvkvXC6N5B453YiTLCKItbprZoWPov?=
 =?us-ascii?Q?f24LdHs1z+BQeeiraRmVxchGkkOAPcc04/OFV8/7k8yIguBM4EY1KZIwbkMd?=
 =?us-ascii?Q?P9X82uyOjhqFmaTLh5FsLx5fFvcYXvQhVOom5kyRfkAlj0gXQpPRzQquEDaO?=
 =?us-ascii?Q?X2H0cxbT2MNjEJAFWKX3KluB/GQlA/dupAVtsXiHMnltJqdCyTGS71IYuJvy?=
 =?us-ascii?Q?k4w68AFPgGZCN/zym9KtmkNPZf0fQeCwA8tfUL7hALDEkfXyZInH7QoCqauE?=
 =?us-ascii?Q?e8HOkTzMlyiC7dcrAzLdVQU6k1r0EidzSWMV/3e7DZ88zkr5LpmhjBQQc7F+?=
 =?us-ascii?Q?N6vDXEaue22XDZbtEmB5HGNr2igAlNshwavyjF9/1rwx+A4+Tr9xYxjs/Snl?=
 =?us-ascii?Q?k4E1ark6bPq1F0j9Bb5yoJQQI9sBTWQ5YaQMVZnF5cyFHHd3EXoY3yDlvbIw?=
 =?us-ascii?Q?qZMIxMlO0YcfeO6LuZ09JPeLvdNLy2T7XZGi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 20:04:44.8756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d014fb42-4b14-4298-8c57-08ddad110a07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336


Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Petr,
>
> On 16/06/2025 17:06, Petr Machata wrote:
>> 
>> Matthieu Baerts <matttbe@kernel.org> writes:

>>> That what we did with MPTCP, see the top of the mptcp_join.sh file for
>>> example [2], where we have:
>>>
>>>> # ShellCheck incorrectly believes that most of the code here is unreachable
>>>> # because it's invoked by variable name, see how the "tests" array is used
>>>> #shellcheck disable=SC2317
>>>
>>> If you add this at the top of your new file, followed by an empty line,
>>> shellcheck will ignore this issue for the whole file.
>> 
>> The ALL_TESTS issue is not the end of it either. We use helpers that
>> call stuff indirectly all over the place. defer, in_ns... It would make
>> sense to me to just disable SC2317 in NIPA runs. Or maybe even put it in
>> net/forwarding/.shellcheckrc. Pretty much all those tests are written in
>> a style that will hit these issues.
>
> In this case, I think it would be better to add this .shellcheckrc file
> in net/forwarding. If you modify NIPA, I don't think people will know
> what is allowed or not, or what command line to use, no?

Good point. The question then is whether to put it to forwarding/ or
directly net/, which is has seen more use of lib.sh and therefore the
same sort of coding style. I'll experiment with it and should be able to
send it later in the week. I don't want to add it to the MC patchset.

> Note that NIPA's shellcheck reports are currently ignoring all "info"
> and "style" severities -- so including SC2317 -- except for new files or
> the ones that were previously shellcheck compliant.

Yeah, I know, but the result is still very noisy, if you want to verify
it prior to sending the patchset. It's a bit annoying to have to scroll
through the report trying to find relevant stuff. I could add
.shellcheckrc in my own clone, but everybody is going to hit these.

