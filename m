Return-Path: <linux-kselftest+bounces-42782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B0BBE02D
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 14:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B89B1895E78
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1327E06C;
	Mon,  6 Oct 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kvPh7Hhy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8516ADD;
	Mon,  6 Oct 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753277; cv=fail; b=nSipSZ6jMat59HH12ARIvZ5kJg9RVHXbH2MGFIQZaIJ9q6zthS+7YZRq9n+6S0oX1jIK7/etw42qw2PnMWcgdspYPKpTjnuaFdg+UGJDn8DFW7R3U4+s4KzMTrVCUVee8FcxC9qciN1uuXLFPALH5B42mr+ysvLnwLQVolixB6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753277; c=relaxed/simple;
	bh=0/A7Uiqq4xuiz6j/t5fyiy1ExRlE2/tJxFRZumIl5G0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o1gsGF+DvstlnNkv+4OzHjvbDd6z1heX2+c/7pHb+qpElBQL7T5sXcoycNwfliI4g6u1VRCZ7zGNpyninpFVWR/dmSs+c/V06dCKEKah8giD0XkmPj3Ldouimp3myNBL53ICDQ7N3/M79Pxi9TCi+UJl4bJFsO9bJ/4pWW7FWjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kvPh7Hhy; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZReQnkVfRQl8lijUSqaxOaDntC6MlHnJXKioXvl6PCNWcTcm2Rpa89yessYDMUa22OKm+QpCPaT89qMm5n7batw4iRfz13a8YzzwCORmCI9XKQP5LtufT8DRAERUigZd+F8/OjopP8vnHRlrRDgXCg92wmQyzcoDI2Mo1VHQP2kAT8brTj0QrfwguEkZBT953yvnPsmojH+QgXql/oOhdasGt/f60B0vb5zxPxHpjob95nFBuEJPUHgJsDhknMTMCayNc+9AjqdwnlBwSIPx1+VUZwQloih52WWLpYdguw9CgHWxesKJDfDJRnx+JK9rh2+t2Cg2vZn3dDUFFpacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5c+ZCHy0EcViEwVWFBkV346WTqIXVr6SQd5u+GtxyU=;
 b=nGkLHBgLa8icJaJAWoL6NxIr/jTbrjMLD3dMUQwRoDGu8Bkocp/GYQWmBWhIzdVGAKdeCiQIqL2yDBAMHq18Z2TrApJUSPctit1sBkuto3eKenYJU1EtdWrIOlyW9eUU4SWUdhkgP1y8ZyD8xMgt8IieghA3LE5+Tu27efUXbvaZcHLokxlmoMj0hZ5t3pZppV2nEq6TPKZy9U6VMW6mPDYjg3i6paoVgB84/73iNE+9ZdL6EQ577CXspqIQRfLRrAXGJATUYhkzcyBN29rR/Zyi4nBpqZaDQ2pvaYg36HeeDadXqOO5yNB6gtMKn9kDfXVFBNCKHE3Z2NSWGecgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=netfilter.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5c+ZCHy0EcViEwVWFBkV346WTqIXVr6SQd5u+GtxyU=;
 b=kvPh7HhyKb5PKq4LpzAaPSGs6kQcA+Lb0scHF1eWjxmWVxA54ELf+Pv8pC1MbsvJv03kI+qmqs4A5rWlix3GD7WXQKwM3929+IwJW4skQk4UQa4TC2U9JJ6wPoQdA9E96A7K/WI/0DiJN0RptSzfdf0AUiOkskLK1L5NaD/Xi2nn2lQVvD+kZ8/bSldCdSSZKXUT4CDc6LNq7IFVSQ5QKij7TJxx0aBGtroyQFQxLHrG9KiDKWSl1McE0DHAELqzk1szqmJ94Vr2avKUqgrZ9cGAH1tiAbv6z0jW9EJxD9QzDJ8hD8KwcQ2uzowOnGEOjdNrgXQT0fpfzUeHmB2MEQ==
Received: from DS7PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:3b7::10)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 12:21:08 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ee) by DS7PR03CA0095.outlook.office365.com
 (2603:10b6:5:3b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 12:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 12:21:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 6 Oct
 2025 05:20:49 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 05:20:37 -0700
References: <20251002013034.3176961-1-kuba@kernel.org>
 <aN7RTSbXDA32J8D2@orbyte.nwl.cc>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Phil Sutter <phil@nwl.cc>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <shuah@kernel.org>,
	<jv@jvosburgh.net>, <olteanv@gmail.com>, <jiri@resnulli.us>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <kuniyu@google.com>, <matttbe@kernel.org>,
	<martineau@kernel.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <antonio@openvpn.net>, <allison.henderson@oracle.com>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
Date: Mon, 6 Oct 2025 13:59:50 +0200
In-Reply-To: <aN7RTSbXDA32J8D2@orbyte.nwl.cc>
Message-ID: <87jz18cje2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: c16c9dc9-13fc-469d-7b4f-08de04d2d373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+beN59FCXO+vKgWXG6lfMCQkDjd4/XS5hmgZNNElllGt3T9s6WQQdU6cz4k?=
 =?us-ascii?Q?NdK3+UF9xuheGDJ14E6qpd9DSV6RP3vaiu1+6GFT4TvNWUFDmgHZemTz+Sn/?=
 =?us-ascii?Q?EPVHBoG4ivqb/m/22dKyuQsgr69HmHcCVGklEWn//fK/xFLpt5Et5sPkhBXv?=
 =?us-ascii?Q?08zCSwMGvO3IqVBmvWgjSLOkiWRusdYcG2m++Azu31SxBJ6bMFQz7AVU5Bkh?=
 =?us-ascii?Q?dzPYoJu3//26F3VcnHKa4gdtOvv2SVgz/Kl+QxsjzZkDDRkS3TPs6+QKRVNO?=
 =?us-ascii?Q?7yXgXOl1OWBHdkMa5hTmOVukKLBVtNvgfAl7CqdE/qxnA8aDJXQuJg2Na30I?=
 =?us-ascii?Q?p1DPUiamgbf1ZGUuZ+9E9RvXH2Kx6M2VllPztBmOUb3u0zKbUy9Rp0H6s9me?=
 =?us-ascii?Q?NhJ5tzK/gIW0hnGS9RDjbFUcVVVZplyX+OJgocBhk6DzlLN15JTXN26wz2Nx?=
 =?us-ascii?Q?ekEUm9UFepICS2eeM94FiWxOAA0nkqnrDivZeZsEdxc7Bl+JdoBpG3uv1yER?=
 =?us-ascii?Q?KQBdewiDcPmqXz2hZIQjEaoOI9bJXr1zlZNc2ovdgsnQq/6vwdVZ4MC9POKp?=
 =?us-ascii?Q?KrtcLQdtONLJhc+iJR+Z/BJXteHbxlNagnPxiLWxurQKUpx+nHMbOyZzUzLT?=
 =?us-ascii?Q?cq4IBHAzP9v9aKPsBU+CqfrSm1OVCRK697qc2b7GRimMW7ij/vBTiEXOGOvM?=
 =?us-ascii?Q?TW/j1/4DREDOBoyMXwe8asGfiHey+YJmd8kXVK0fSJT1p5BcNz2MMTpo6412?=
 =?us-ascii?Q?PLKGse89LIdsskdhT4Zj9EuNtzvptSmOH5MFjR2gL+GJJXAwoHuzJonLp7Oi?=
 =?us-ascii?Q?nVXY/8NRKw1O3l0j1sDlA1JtbB+g55HhkgB3OWcnSSPeE564R8ydH3L5V+HG?=
 =?us-ascii?Q?rz+gsWmuKg482WgQ71P2hiy7MkHUHeXnrqMwdbMTH28Ajd+0RVEAIjjS2YRZ?=
 =?us-ascii?Q?WbHWEZ0I6cDvNTcpNH6AAZ4FEQVn4lDQ8iHeksz5NRSa771V/BpH8boXLJzx?=
 =?us-ascii?Q?AI+FOLcHip8nm81SfPBOEFWCajeXjKTl+ki285PgJKqusLuFn76tLzX6oog+?=
 =?us-ascii?Q?+jn/mK4uXt7xm2+uZag9ExnhEhpbT0pPo7PF+du0K2uLIAshtedGwTWc2tH6?=
 =?us-ascii?Q?Pfr2JVp0oFxeBcqR8Jz1ZbUC+iLIwBjWsPbcEmEe0SGyMjYoXexnNfDOyOMD?=
 =?us-ascii?Q?UVKdYf9j/PdQMXOzGMGxABS3RuxfzBB8FhR+WUO3bFkcobu6uzYIf6FD9jfv?=
 =?us-ascii?Q?stTsJw2gtbozE14YRLesoUhuUSWihjDaclw4n1KYbTv1eML+lcv0kg9GFXcC?=
 =?us-ascii?Q?OvDALLFDGnepod5M71sZ/lv6OkbLRTHDg+0q+EUfSZYNzuTxKnh+TNQGrfVi?=
 =?us-ascii?Q?WHzfXYNBKqCYb3lwNVSjEUMeACo+nVviDMdCe+VHt84NFN8VCvSBf8agJ0OO?=
 =?us-ascii?Q?0ZHwIxTTQ4uq9LgUFAATXknMBZlcawjrBafgZeF3QBtdmvSVCMR7MTbjcoVr?=
 =?us-ascii?Q?saRj9Nb3kzQ6xJzaFzBho1LNZUvOPdR5Q3uqcaSNTRvYoXuxsE223JQGGb50?=
 =?us-ascii?Q?U948FXi93C2yNm+am2o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 12:21:06.9381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16c9dc9-13fc-469d-7b4f-08de04d2d373
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770


Phil Sutter <phil@nwl.cc> writes:

>> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> index 07b7c46d3311..daf51113c827 100644
>> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>>  
>> -TEST_PROGS = devlink.sh \
>> +TEST_PROGS := \
>
> Maybe irrelevant, but assignment type changes should be avoided IMO
> (there are more cases like this one).

AFAIK, = vs := differ in when the assigned-to variable is evaluated.
Variables assigned-to with := are evaluated at the time of definition, =
at the time of use. This can make difference if the variable definition
contains other expansions.

I do not think this patch touches variables where this distinction
matters, as most of it is fixed strings. There's an occasional patsubst
etc., but those ought to lead to the same results regardless of
expansion time. So IMHO we can freely use either.

In theory someone could use something like `TEST_PROGS = $(OTHER_PROGS)
foo.sh bar.sh' and then override OTHER_PROGS based on the target, or
reassign it at a later point. Personally I'd much much rather see an
explicit if-else prior to TEST_PROGS, and then an immediate expansion. I
think that makes things easier to reason about and debug. So my
preference would actually be to use := as the default.

