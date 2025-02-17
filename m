Return-Path: <linux-kselftest+bounces-26815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F1A38E78
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4201887C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206519E97B;
	Mon, 17 Feb 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUaoVdzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A397D3F4;
	Mon, 17 Feb 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829941; cv=fail; b=D0gfXi7ZtC4mPhLasc+nNUPWDVDNMYXisv/Ib4BlvtpLyLOBrcMg6gDvJlUWZkYDMhTu/JogzqBh4DBs8NuGHG6283ZrBPiLUd+5ckhid4he/dFq7sxhfLeGqljggk8oR2y/GlhhlKKjMbsqlzH1Auubx6L7SmsfZPU9lIPqTYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829941; c=relaxed/simple;
	bh=EcJviz60on1m7KEXKeq7CMCxZ20Jv+w5sfrYv0b7Qyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzP/RLxnidZUX5Ij9RDLnTNFc5N4uAE8xc08sX+2iBLv1V0RFrFE76RVnTPDp3sK4TcGtXkQW63M+ht9mBvchdkLMkPBpHgqmc0BtpNwR+CGCo88CW0XywBx2MhUxuHtGL+gDzSRNnuk752hQyUTWXPLwA23Ms2o6PuVECpBwAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUaoVdzf; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBtlLS8EwWhPU2PP9GFib7AEnVwg/UT8vs0ESGJEsD4bJCbO+3JbFNhbSjPLbdBhzjvue3+uJSsCWWSgv09jn3wH720uYj/bmqrBP44bb92cK5ctgUxGZ4nqMjj0XgOCSwJj30k0mNXlhqh3ortxaITqonnoRjoUroN+3B6M6rYvrX9XitDeLjCLvu5LnVqTFgGjYZcYQ0K9crD6LX6Gu/RidX3MGlXxP+lYv6Xc+08SlUXQQqAaH0+DIlR46zzIBrxH6aMuLVgidylrAbom2UKp9zjPL53uN581nQcjdpbMognx6UPgh1La7+ernmKma/IKHSsqQibEJPCHdT0XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJef3uoGDsqUKCCbISyOAzTDrIY9U44G4piYb/aDvPs=;
 b=TB3Ptz9+LeYf5mLLCLR5FH2tTTBmbZ7zA/PteH6Bb3Nrqh7zCtCnrFvn4zuednwnVV3zKeC01ZMcfmNOqH59vabj5SE/3cD2xJCIkyDRVBY3GurDaYSFzPNcqnGvP+u0cWiwLHfTd9lpL/aeKqTI3B+cfqXLu/m8Hb12gBTt9ZT590Wcm7QKIUJHrsY3gfSGTfwbybP24NyCh18vmBZsAW6K3dZ7Y5u+F2LwEptSyBAU4TjvP7Z9KbIpcPn8gO3GNW2UFzEB6oGXoO3ZjMPdSL9i0DSRFG0PHcnwc0EMtQNyouPmljB0pGBD6FY81X97buh6yFDlAo5Ru6w/C+PVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJef3uoGDsqUKCCbISyOAzTDrIY9U44G4piYb/aDvPs=;
 b=rUaoVdzfgyuPDQp1mjucLjW95n1Ucc4RhsN6Q9y5MKugGiA2KCBXE0umxyRP3N63UAnh+6meWnB/QuX5TpIsZmFRM72YewZkgI9am6jfAS5/hIgrjOhbR6hHRL+PMcpagzwFPK0mT5udJuy/Ml4C5D8yWOL/2av7SmqdHl9S1zcjXyAT/tVxHtI4guQ5Nx/+chJ0FFrVRulmIkPn1GfEcuYX8p66Jmkjun+hkG5nvnrcdKkxNWCXQkyzZdMHeDQf4oJiJfXPVJKp9NbDPljgiXGhQbRc2c3BHPBM/Sr0//WwjJWyN2EyJzGV7UEs8YpAXNAtWO9yDFBtUYQhR5kswA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Mon, 17 Feb 2025 22:05:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 22:05:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/8] xarray: add xas_try_split() to split a multi-index
 entry.
Date: Mon, 17 Feb 2025 17:05:30 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <F5D2A2F4-34DC-4967-A149-A4D5578B5DB2@nvidia.com>
In-Reply-To: <0bb75517-9418-4145-8aa8-b05373010711@redhat.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
 <0bb75517-9418-4145-8aa8-b05373010711@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:408:f5::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: d4df836a-f61a-4c69-e677-08dd4f9f32b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlXBDncNwoeg83gi++pOQLZhP1xlHb85hPnyxlqMtRj3vzBBtPkZGWb+tCTj?=
 =?us-ascii?Q?TTSVfRNe4Gpjwl5pecjTMOtkuQ6p/qDb71s+c4Qz3CLJqbeIFXoz/LcltUd0?=
 =?us-ascii?Q?rA8xIuEAPRc5eIOx+IoQ57Qwm+0aKLLYAyBc53ZXqx7XtmSrkfghyE0YjUdh?=
 =?us-ascii?Q?u0CmkOClEFF81/3bQYDTbHvEU0FOvbyOgoMbl1zJbVmX5ZmW78DaWnAeKziM?=
 =?us-ascii?Q?b45cQSCpOWTBcu/bOEsnDSl8CiJywMEM78Bc+iLc+c4Px9H51e42kj2c+1mS?=
 =?us-ascii?Q?/s1n5kA0oU3z6HQd+mPyVPk/1PJ4lS9HavVsK59iVou92ArYJ9NnfJ0CRKnt?=
 =?us-ascii?Q?OPC+tDmQv8xKZhbyZWTqdTePfJJWuLSMu3wOVO3bHysb4DwQJ4z79i4PVinR?=
 =?us-ascii?Q?rvHcdpT3G4Wu/0OVODt1/NCCEiw0mHkb496zFIGMxvPR3rLXx+NNStnd4gES?=
 =?us-ascii?Q?gNqmYd5hp2MD1dOJ168MPq3a5JvVxViKzet8BikeBqHUHDAVOxKbMPIouHFy?=
 =?us-ascii?Q?YQiStkwPYhJmR93A2HiVvVpqU1Obi7nEAq5Ea6c9Cz22aD4JGM1c3kk3R7WP?=
 =?us-ascii?Q?cSXEXlnuOfLceY4htDVhx3HVxNhMeLQAy8sy2vXHt1sfoVIs3p/iORMyGG+D?=
 =?us-ascii?Q?N1Jtr7Z4n7CjTCE8qon0Ncg4mdQ5pXD7131KNhjUY8v7PswlmLs1zFMYRYz+?=
 =?us-ascii?Q?/b7wgI152GqMTqje8HcwQzEb1PA3uSzbhowDJZ4r+Y8GG2l/MylKOGVJM9Nn?=
 =?us-ascii?Q?BYf8GKhxTW5gpaCaJBDwaB0qt1g/LXxOLp6GmyeS1QW/d4OF11iZ+ax2axRN?=
 =?us-ascii?Q?Rs4AOpw+jwoUtRDVsKxfSqvZteEr1CReWE34cwyZKdcs2kBnAKPir+pzcxP6?=
 =?us-ascii?Q?O2DRlCNcXLYL4zyEXEMGTO8ig2saCkSIDc2qp3j2+7suKNZN7ny3i5aEY3wk?=
 =?us-ascii?Q?FqgTvr32naXs0EsOWQJxsf1B6DYNZn+BpSYx6p95iWXEPebh/S1wFEhrGPfa?=
 =?us-ascii?Q?33NVUxQ7EMWivRgWMcxSX3W6GaOVYSvv1a5KqtE0Y89ckCzg+YXUaY6UzQ4M?=
 =?us-ascii?Q?HeM9PvCphBKWZjDFYAnf/wKkE4zKL3VuPXuPYXuOmP1HWPgOvqKm+1qnIeqN?=
 =?us-ascii?Q?VoDYCR0DoPuxfhRbxM7aTUmbtopzXgQMrf1Z3jvYOJrNg1E2nYRMFHKm4G/j?=
 =?us-ascii?Q?sA+zMJeridAmz0yP1HWunsJm88l18CFTFEkTf5nwcF5Sb8e0+FaOMTJheSge?=
 =?us-ascii?Q?pkFNnLENozVnlmZqUYHxAtnYZrrgpyfEz9wqP07Afln9NRaYvHAxihJ0o+VB?=
 =?us-ascii?Q?QjICgM231Vz0FXhZBldlpeESkDQcaWl9h96dmYWA1BfkHNIuu7H/TjxCJFaF?=
 =?us-ascii?Q?WW1LIYSLK22wWkBSGLl8V+ziETSH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9LQCq7GWzgk2jPyJ/hfDThN5MeJCLpdYkJJ4oO+ibYbMU2k2gEehZs9Wr40?=
 =?us-ascii?Q?u3BaBpuYe1cGwPuziKdC4nM/QV072DK0muRjUIbpGCKhwE7E1w4h+EHubqpk?=
 =?us-ascii?Q?MGAfxKdDigkrXawhIidM8d+1Q3OrNp6WBYhd8lxV3iXplHL2AgP/MLwkB8aL?=
 =?us-ascii?Q?pqZIjlnUxV/E6z8uCBq5FvkbKAzsLJOUmh0O5i/mIaKc1KoUqqZ5GSdod5Yd?=
 =?us-ascii?Q?FogdSU8em30t6CdRGtvkQZ0EYC3euqOFGyAOUmTXPRrhV1uDwvai7cSvHP8x?=
 =?us-ascii?Q?mqubcoAS5WtjrGGn6L9ZbieFThBpxM5G2ZhSvyinL9cEcLJwWrNK83LKDbFK?=
 =?us-ascii?Q?gUwpeVgbrDQsgElHP6ZW9TKZbhOebl2lRCi9Ds7xujTxLJ5qnGYIZ5yfzb5G?=
 =?us-ascii?Q?WoS/SK93AdhUIP0IrMM82fDpq+bwKb3hFGbg4mNoPoDnY3LMRa+YQAHsgDqD?=
 =?us-ascii?Q?MRGagsb+QIM7/f4g6I0Yz3gNe9TSYalxzOuP+ebJVT+4rI2+bgJKpqg9Vm3z?=
 =?us-ascii?Q?af21OhHFzGAhJXOGs5oRKBRNCqrz9z5O2itFmnqhhuv3vlO/Z0LltgXkhpm5?=
 =?us-ascii?Q?V8inQXJbX1dRhlR9vgR2YRdo1YmIjtGrUCypMqrHEGu3VVGMvctcgcKQcz7S?=
 =?us-ascii?Q?cpYLOWhNVrelvf878LZZJe13m5DcoA8QW5rnsjgmlcRU4KG3ye837L37YDup?=
 =?us-ascii?Q?M9LNsdgADsecOW0l+0Rz+C3SMtBXqJPN/dlBWiyj/bbvu7khVJjttYnVcsMS?=
 =?us-ascii?Q?qRaBWUHkvdTi8KM46JRI3+2loC6mRNDSfOkduv+cOccxBVdGX8F0fDdN85np?=
 =?us-ascii?Q?FeH7jWsHDo13VKyCzZaedorZt9gv8b8ANGB03YsWGRQHEzCJiqCD9gdNytIt?=
 =?us-ascii?Q?ruCaa28d4ZQHJO1Xm5rp7Z0GX6cEBrPE5nEjax64h8+YjqZ35QogktsBm945?=
 =?us-ascii?Q?Y1h7B/W9usbEwuuAwi0VkTMZrg+moHYNNsdKHu1J9BiseIufzjvy9qEjv1zG?=
 =?us-ascii?Q?Iop3bWVoBKls8ckjyt+5U1CcslJrzR0CW7k/cIR9gPHMWhOgCb+2IGodYn7J?=
 =?us-ascii?Q?gAZa5EuTGUi39lfs1130ZcEFLhAM1r5D8NwDwgI6sc9GP1hFBvRujBZWdEpy?=
 =?us-ascii?Q?pS8w6K88W4UCKW23nb+moBR2E/Ejerg9PSPlCNB81uqVkJeSnTWdV2vqtsDD?=
 =?us-ascii?Q?oWL/uMHzs38wi59kXhW5ocKOc9p8bpHRY6Xc0/zDfNHjaIfkt/X7mMDuBdTK?=
 =?us-ascii?Q?wYRdG6SWkdJ5zNH0NJNkKxfIPZa6gFfZwKnRgtOC9JJ+P2ZTx8Nli+NuQe5f?=
 =?us-ascii?Q?56FUDSfFd6mdvYUyHI7o3aqTAcAZjyyRp/YqJCviYGvA+WPUgEC1uG/9lsRI?=
 =?us-ascii?Q?O8bTPvTXQaeTMSZfO/gPnit87hRpfDs6dcCojLv6gFgqOdUbltTZT67uwgZ0?=
 =?us-ascii?Q?rrXXZMtXj+8ndKCMdglzpmeplXrweleGPfZaR5D2620tDzYcprmKm0AqSUZo?=
 =?us-ascii?Q?Hq930l+FinX3chi71EBumJCsPXIkGMstDcNPia2q02IE7brZzqOVtu9s94Wn?=
 =?us-ascii?Q?QjsGu+i1fVFzcu/Xtrw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4df836a-f61a-4c69-e677-08dd4f9f32b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 22:05:32.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfD1nNqOQsatvrrhMXfmPWapAvjuMJvKGKPT6y+4Pa3rhK9W3FxgVfQwUeYh9pcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533

On 17 Feb 2025, at 16:44, David Hildenbrand wrote:

> On 11.02.25 16:50, Zi Yan wrote:
>> It is a preparation patch for non-uniform folio split, which always sp=
lit
>> a folio into half iteratively, and minimal xarray entry split.
>>
>> Currently, xas_split_alloc() and xas_split() always split all slots fr=
om a
>> multi-index entry. They cost the same number of xa_node as the to-be-s=
plit
>> slots. For example, to split an order-9 entry, which takes 2^(9-6)=3D8=

>> slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node ar=
e
>> needed. Instead xas_try_split() is intended to be used iteratively to =
split
>> the order-9 entry into 2 order-8 entries, then split one order-8 entry=
,
>> based on the given index, to 2 order-7 entries, ..., and split one ord=
er-1
>> entry to 2 order-0 entries. When splitting the order-6 entry and a new=

>> xa_node is needed, xas_try_split() will try to allocate one if possibl=
e.
>> As a result, xas_try_split() would only need one xa_node instead of 8.=

>>
>> When a new xa_node is needed during the split, xas_try_split() can try=
 to
>> allocate one but no more. -ENOMEM will be return if a node cannot be
>> allocated. -EINVAL will be return if a sibling node is split or
>> cascade split happens, where two or more new nodes are needed, and the=
se
>> are not supported by xas_try_split().
>>
>> xas_split_alloc() and xas_split() split an order-9 to order-0:
>>
>>           ---------------------------------
>>           |   |   |   |   |   |   |   |   |
>>           | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>           |   |   |   |   |   |   |   |   |
>>           ---------------------------------
>>             |   |                   |   |
>>       -------   ---               ---   -------
>>       |           |     ...       |           |
>>       V           V               V           V
>> ----------- -----------     ----------- -----------
>> | xa_node | | xa_node | ... | xa_node | | xa_node |
>> ----------- -----------     ----------- -----------
>>
>> xas_try_split() splits an order-9 to order-0:
>>     ---------------------------------
>>     |   |   |   |   |   |   |   |   |
>>     | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>     |   |   |   |   |   |   |   |   |
>>     ---------------------------------
>>       |
>>       |
>>       V
>> -----------
>> | xa_node |
>> -----------
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   Documentation/core-api/xarray.rst |  14 ++-
>>   include/linux/xarray.h            |   7 ++
>>   lib/test_xarray.c                 |  47 +++++++++++
>>   lib/xarray.c                      | 136 ++++++++++++++++++++++++++--=
--
>>   tools/testing/radix-tree/Makefile |   1 +
>>   5 files changed, 188 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-ap=
i/xarray.rst
>> index f6a3eef4fe7f..c6c91cbd0c3c 100644
>> --- a/Documentation/core-api/xarray.rst
>> +++ b/Documentation/core-api/xarray.rst
>> @@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index =
entry will set the
>>   entry at every index to ``NULL`` and dissolve the tie.  A multi-inde=
x
>>   entry can be split into entries occupying smaller ranges by calling
>>   xas_split_alloc() without the xa_lock held, followed by taking the l=
ock
>> -and calling xas_split().
>> +and calling xas_split() or calling xas_try_split() with xa_lock. The
>> +difference between xas_split_alloc()+xas_split() and xas_try_alloc() =
is
>> +that xas_split_alloc() + xas_split() split the entry from the origina=
l
>> +order to the new order in one shot uniformly, whereas xas_try_split()=

>> +iteratively splits the entry containing the index non-uniformly.
>> +For example, to split an order-9 entry, which takes 2^(9-6)=3D8 slots=
,
>> +assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() nee=
d
>> +8 xa_node. xas_try_split() splits the order-9 entry into
>> +2 order-8 entries, then split one order-8 entry, based on the given i=
ndex,
>> +to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 e=
ntries.
>> +When splitting the order-6 entry and a new xa_node is needed, xas_try=
_split()
>> +will try to allocate one if possible. As a result, xas_try_split() wo=
uld only
>> +need 1 xa_node instead of 8.
>>    Functions and structures
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index 0b618ec04115..9eb8c7425090 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long =
index);
>>   int xas_get_order(struct xa_state *xas);
>>   void xas_split(struct xa_state *, void *entry, unsigned int order);
>>   void xas_split_alloc(struct xa_state *, void *entry, unsigned int or=
der, gfp_t);
>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int or=
der,
>> +		gfp_t gfp);
>>   #else
>>   static inline int xa_get_order(struct xarray *xa, unsigned long inde=
x)
>>   {
>> @@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_st=
ate *xas, void *entry,
>>   		unsigned int order, gfp_t gfp)
>>   {
>>   }
>> +
>> +static inline void xas_try_split(struct xa_state *xas, void *entry,
>> +		unsigned int order, gfp_t gfp)
>> +{
>> +}
>>   #endif
>>    /**
>> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
>> index 6932a26f4927..598ca38a2f5b 100644
>> --- a/lib/test_xarray.c
>> +++ b/lib/test_xarray.c
>> @@ -1857,6 +1857,49 @@ static void check_split_1(struct xarray *xa, un=
signed long index,
>>   	xa_destroy(xa);
>>   }
>>  +static void check_split_2(struct xarray *xa, unsigned long index,
>> +				unsigned int order, unsigned int new_order)
>> +{
>> +	XA_STATE_ORDER(xas, xa, index, new_order);
>> +	unsigned int i, found;
>> +	void *entry;
>> +
>> +	xa_store_order(xa, index, order, xa, GFP_KERNEL);
>> +	xa_set_mark(xa, index, XA_MARK_1);
>> +
>> +	xas_lock(&xas);
>> +	xas_try_halve(&xas, xa, order, GFP_KERNEL);
>> +	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
>> +	    new_order < order - 1) {
>> +		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) !=3D -EINVAL);
>> +		xas_unlock(&xas);
>> +		goto out;
>> +	}
>> +	for (i =3D 0; i < (1 << order); i +=3D (1 << new_order))
>> +		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
>> +	xas_unlock(&xas);
>> +
>> +	for (i =3D 0; i < (1 << order); i++) {
>> +		unsigned int val =3D index + (i & ~((1 << new_order) - 1));
>> +		XA_BUG_ON(xa, xa_load(xa, index + i) !=3D xa_mk_index(val));
>> +	}
>> +
>> +	xa_set_mark(xa, index, XA_MARK_0);
>> +	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
>> +
>> +	xas_set_order(&xas, index, 0);
>> +	found =3D 0;
>> +	rcu_read_lock();
>> +	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
>> +		found++;
>> +		XA_BUG_ON(xa, xa_is_internal(entry));
>> +	}
>> +	rcu_read_unlock();
>> +	XA_BUG_ON(xa, found !=3D 1 << (order - new_order));
>> +out:
>> +	xa_destroy(xa);
>> +}
>> +
>>   static noinline void check_split(struct xarray *xa)
>>   {
>>   	unsigned int order, new_order;
>> @@ -1868,6 +1911,10 @@ static noinline void check_split(struct xarray =
*xa)
>>   			check_split_1(xa, 0, order, new_order);
>>   			check_split_1(xa, 1UL << order, order, new_order);
>>   			check_split_1(xa, 3UL << order, order, new_order);
>> +
>> +			check_split_2(xa, 0, order, new_order);
>> +			check_split_2(xa, 1UL << order, order, new_order);
>> +			check_split_2(xa, 3UL << order, order, new_order);
>>   		}
>>   	}
>>   }
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 116e9286c64e..c38beca77830 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node=
, unsigned int offset,
>>   	}
>>   }
>>  +static struct xa_node *__xas_alloc_node_for_split(struct xa_state *x=
as,
>> +		void *entry, gfp_t gfp)
>> +{
>> +	unsigned int i;
>> +	void *sibling =3D NULL;
>> +	struct xa_node *node;
>> +	unsigned int mask =3D xas->xa_sibs;
>> +
>> +	node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, g=
fp);
>> +	if (!node)
>> +		return NULL;
>> +	node->array =3D xas->xa;
>> +	for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>> +		if ((i & mask) =3D=3D 0) {
>> +			RCU_INIT_POINTER(node->slots[i], entry);
>> +			sibling =3D xa_mk_sibling(i);
>> +		} else {
>> +			RCU_INIT_POINTER(node->slots[i], sibling);
>> +		}
>> +	}
>> +	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>> +
>> +	return node;
>> +}
>> +
>>   /**
>>    * xas_split_alloc() - Allocate memory for splitting an entry.
>>    * @xas: XArray operation state.
>> @@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void =
*entry, unsigned int order,
>>   		gfp_t gfp)
>>   {
>>   	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>> -	unsigned int mask =3D xas->xa_sibs;
>>    	/* XXX: no support for splitting really large entries yet */
>>   	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <=3D order))
>> @@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void=
 *entry, unsigned int order,
>>   		return;
>>    	do {
>> -		unsigned int i;
>> -		void *sibling =3D NULL;
>> -		struct xa_node *node;
>> -
>> -		node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, =
gfp);
>> +		struct xa_node *node =3D __xas_alloc_node_for_split(xas, entry, gfp=
);
>>   		if (!node)
>>   			goto nomem;
>> -		node->array =3D xas->xa;
>> -		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>> -			if ((i & mask) =3D=3D 0) {
>> -				RCU_INIT_POINTER(node->slots[i], entry);
>> -				sibling =3D xa_mk_sibling(i);
>> -			} else {
>> -				RCU_INIT_POINTER(node->slots[i], sibling);
>> -			}
>> -		}
>> -		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>   		xas->xa_alloc =3D node;
>>   	} while (sibs-- > 0);
>>  @@ -1122,6 +1132,100 @@ void xas_split(struct xa_state *xas, void *en=
try, unsigned int order)
>>   	xas_update(xas, node);
>>   }
>>   EXPORT_SYMBOL_GPL(xas_split);
>> +
>> +/**
>> + * xas_try_split() - Try to split a multi-index entry.
>> + * @xas: XArray operation state.
>> + * @entry: New entry to store in the array.
>> + * @order: Current entry order.
>> + * @gfp: Memory allocation flags.
>> + *
>> + * The size of the new entries is set in @xas.  The value in @entry i=
s
>> + * copied to all the replacement entries. If and only if one xa_node =
needs to
>> + * be allocated, the function will use @gfp to get one. If more xa_no=
de are
>> + * needed, the function gives EINVAL error.
>> + *
>> + * Context: Any context.  The caller should hold the xa_lock.
>> + */
>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int or=
der,
>> +		gfp_t gfp)
>> +{
>> +	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>> +	unsigned int offset, marks;
>> +	struct xa_node *node;
>> +	void *curr =3D xas_load(xas);
>> +	int values =3D 0;
>> +
>> +	node =3D xas->xa_node;
>> +	if (xas_top(node))
>> +		return;
>> +
>> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
>> +		gfp |=3D __GFP_ACCOUNT;
>> +
>> +	marks =3D node_get_marks(node, xas->xa_offset);
>> +
>> +	offset =3D xas->xa_offset + sibs;
>> +	do {
>> +		if (xas->xa_shift < node->shift) {
>> +			struct xa_node *child =3D xas->xa_alloc;
>> +			unsigned int expected_sibs =3D
>> +				(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
>> +
>> +			/*
>> +			 * No support for splitting sibling entries
>> +			 * (horizontally) or cascade split (vertically), which
>> +			 * requires two or more new xa_nodes.
>> +			 * Since if one xa_node allocation fails,
>> +			 * it is hard to free the prior allocations.
>> +			 */
>> +			if (sibs || xas->xa_sibs !=3D expected_sibs) {
>> +				xas_destroy(xas);
>> +				xas_set_err(xas, -EINVAL);
>> +				return;
>> +			}
>> +
>> +			if (!child) {
>> +				child =3D __xas_alloc_node_for_split(xas, entry,
>> +						gfp);
>> +				if (!child) {
>> +					xas_destroy(xas);
>> +					xas_set_err(xas, -ENOMEM);
>> +					return;
>> +				}
>> +			}
>
> No expert on this, just wondering ...
>
> ... what is the effect if we halfway-through fail the split? Is it okay=
 to leave that "partially split" thing in place? Can callers deal with th=
at?

Good question.

xas_try_split() imposes what kind of split it does and is usually used to=

split from order N to order N-1:

1. when N is a multiplier of XA_CHUNK_SHIFT, a new xa_node is needed, so
either child (namely xas->xa_alloc) is not NULL, meaning someone called
xa_nomem() to allocate a xa_node before xas_try_split() or child is NULL
and an allocation is needed. If child is still NULL after the allocation,=

meaning we are out of memory, no split is done;

2. when N is not, no new xa_node is needed, xas_try_split() just rewrites=

existing slot values to perform the split (the code after the hunk above)=
=2E
No fail will happen. For this split, since no new xa_node is needed,
the caller is actually allowed to split from N to a value smaller than
N-1 as long as N-1 is >=3D (N - N % XA_CHUNK_SHIFT).


Various checks make sure xas_try_split() only sees the two above situatio=
n:

a. "xas->xa_shift < node->shift" means the split crosses XA_CHUNK_SHIFT,
at least 1 new xa_node is needed; the else branch only handles the case
2 above;

b. for the then branch the "if (sibs || xas->xa_sibs !=3D expected_sibs)"=

check makes sure N is a multiplier of XA_CHUNK_SHIFT and the new order
has to be N-1. In "if (sibs || xas->xa_sibs !=3D expected_sibs)",
"sibs !=3D 0" means the from order N covers more than 1 slot, so more tha=
n 1
new xa_node is needed, "xas->xa_sibs !=3D expected_sibs" makes sure
the new order is N-1 (you can see it from how expected_sibs is assigned).=


Let me know if you have any other question.

--
Best Regards,
Yan, Zi

