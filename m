Return-Path: <linux-kselftest+bounces-38314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA1CB1BABF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423071697B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EB29ACE8;
	Tue,  5 Aug 2025 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbXvQxsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5A24728B;
	Tue,  5 Aug 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421004; cv=fail; b=qBcYHonaa0F8ym7UH2XyF6nUmLUrobnMgTaDQx9oRz9Ag49IopaNQ0IKpzRJg4evcEGAbV2k57DAOU7zCxpJOOEXNG36a2AqFTlofg3yDqtupDsqAqgcP8ZhPGENWYQoq8gbkcTXlUgC9tquJkHsJawuhPBgIkTusQ/IDnYlHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421004; c=relaxed/simple;
	bh=QKZKJ/OFJGseNnwe/lBg/qD8d8YBHxh8Zks2ZcafxQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Et/X7z60Sz4Jw5mS1xVBSMq99btM/mjVpBdV7Gw+MMdrRgxHFTOWdmtzLsu2lV4LXoF7curuslcBZGt/2cmXIu/0QaRTv+29Ko5sIEqDYTLfARsptbQO0/AXJsXusH51UZYA0PhcdSmdD/Cg92V8IOg8HGsdDEDcBzVBy5gR9p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbXvQxsH; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFT5nqWWHvH8i0EQVvUmS7C1N0o1P7DKycoXSXwi5HCbKLz78ltFXJFlNZyxs7JfOj+0hpdrwmlaHcw86oEL8MtvAYO0/YIHFeDq/64BFpWer2we2VvXzpF00MEOZsBg6pbCdyWN3qcHLwHmrKRu9wz6QlHTw9iD4cG39d9JzZ1j7PcqoHYb5ZLXkEovU3cIzE3fu+QSPJfg3QWe1G0eEJokaxXLGVWsef1SP/cewgNDs65+HoBJ7lquxo7sSo7H0cSA844IkLaTkw4Mgzxcbz/vPuvwjZJKvBC9gYP7zRk+tdYU7vcHCKeNuUk3Zt+cSK31gYNJMuwAtX65Zk3mXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OhtLH0NtxqoYih4hloMTIuu8XiUqoWbx3aYCsDsLuA=;
 b=MJ7YDhHbFhKrar3/zEATIKB0tHPOUrMemHqMMAmEI8fJCctV/eJOHpy9zm52JPO5AYaNusSJvhwLxYFH9eTpHfnewV+KmOKgDZpLs+09ptzlfVlV8xDs+D4vOhRvmd7qOqqtGyLw2S6aUeq8435bj9lxE1s5hRfoo1zJ7FqZdqYRWU9FxW2q6FiWIyBCse+pkJSWtl5GyHJ856ZSD/CK/Gat5Bb855zUctqGUR94KKVc03QM9H6JevZKEWEtOmtOMrglrGB5/hGkNXkzAjAsP1y3NGTw4XfTNVcQY4vonOKSse8bt12iCHeWRN8dQyUkvkm5XExNLV8xVio4RVw4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OhtLH0NtxqoYih4hloMTIuu8XiUqoWbx3aYCsDsLuA=;
 b=EbXvQxsHSh1NsuX4BmMxhqEk2Wp1NgLmodwfRO5a/RmW54SI5YPOYhF0NZd8914G/yOJuosrTKiPGINJyr/wmBeDBUjjq7mDllBfCCdg4p98gyeU6jPd/fVHgVXyJCLF7xAYeN7TtRm8NHs+7fx1AWTsSRUXwLjyc3tYLb7JTnxWcGM8+mBtzuu4E3s5TX85T8C7Gwt50xZcfjXv+R8Kf4oYdaoKyE9lhxfxyEcUfiyCffklK7TiwvxLWBrzEFsDuKdCsqLpEGofc54xDp2aszY7F5cbzaKSCa/FIx/qMm1L5ymNVF8ZRf6hMX3Nk9V9KgbUhgU1fNnKVtHVZJZd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Tue, 5 Aug 2025 19:09:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 19:09:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: wang lian <lianux.mm@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Date: Tue, 05 Aug 2025 15:09:54 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6E5CCF4D-CB63-4E4C-BEDA-6FE533E0DFCD@nvidia.com>
In-Reply-To: <7eaa1660-06d3-49b9-ba5e-28df1c35dcd1@lucifer.local>
References: <20250805175140.241656-1-ziy@nvidia.com>
 <7eaa1660-06d3-49b9-ba5e-28df1c35dcd1@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:408:112::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 2143beac-b479-408a-a140-08ddd453aae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WElfZbK8zj/BUK1K54r6qOCSPS/yg+HZsNenZR+7WVec4vE6cx9+iCN3zO0d?=
 =?us-ascii?Q?6CCgv0hfuiwzXz/3B1J9eWTM0NCKYbfEgJl6km5vFUtAUooLzOomaRR54UVz?=
 =?us-ascii?Q?CzwgFzN5OEoh+afmuG3H95IKax3RiTtTLrePJkVrPGsyA26nWkgsnUQtZCJ1?=
 =?us-ascii?Q?BHagkF0cDvg8n6DH+0MQV9W7ktpDapPymgOtO56powsOYZLmhI3Lpw+AziS9?=
 =?us-ascii?Q?yXpysjjQwVRkF3l1ZQbVocVT3ksoVMPYNmTo4PCPJbrOwtdlUorTnxb5V1NS?=
 =?us-ascii?Q?xkz1ZgHrgO9Q8svls1SnAMemCg0llEEWPU98tDNih7uJv0TGqKter52YoHvR?=
 =?us-ascii?Q?HWIWw9q47rPbRy3H01u9ysKYh4t9+iHiQTLrto9CAofRyJ5a+AsZbc9GqdAF?=
 =?us-ascii?Q?jYYhmkBH0bE74DMaaH3dJ2ltfz2XXl0/C+P+OnUsWCo9xejEH64cdLIH/tQU?=
 =?us-ascii?Q?IUdBr1/7j7omWiMrf0wxy3TtSJVo8MfYL37hrZWJdWpj11GyE0bWNcxwnSCR?=
 =?us-ascii?Q?9jZEOxPOBo2oM3PfMP6zoyczrB/7/x0F2oE7YdQnTUbs1BWncmY7DoEBBn8z?=
 =?us-ascii?Q?a0Mkhs+n2KgfIEpT51krB8ZMyYG8LHiE20xs5bysqfTJlOKsRBl+FkB4PzL5?=
 =?us-ascii?Q?M1FCM1pSDtmz9v3hJfmQ7g7iwDeBw+1Q86Xb54lQqlPhCwGVdKSCFPCCqJ1x?=
 =?us-ascii?Q?VqDN3SHPA3Cd9fKdlqDBHOF56U2693Y4qkb8SyDRhy0kJOrJ5v7dwzFaEaAO?=
 =?us-ascii?Q?QHKCfNNFuF8mzbbWp1BwRqYnLcB+9I3l7b/VaKBdvf3agO7vEmwwmSdlg9D7?=
 =?us-ascii?Q?y4HLUDsIOMhNQikRsxWqTrq9wG3lhwYB44sPr6Zj8Y0gU2YKmQ8NFK0eGnpZ?=
 =?us-ascii?Q?coM2BRRYSnXxymj0xe6XLXmCVC+n65zpej/EMmXZtQcs8eNjtV69EC2k/BPx?=
 =?us-ascii?Q?i+Wwa/2THVUdJSjmty78MRZRYJPXS8i48cozK0C7tmTM9cBoqAjv2xZERrrB?=
 =?us-ascii?Q?i8XqSOm384voewRdZY3COZoqwuzxJ2/OrGxD7HIJCSrno6inXoKPzc3Dbshk?=
 =?us-ascii?Q?1pWUGMDIBNwaszJZ/MKWqsgq3P+p7hRwx250jCgmc60g9ZvPvKki9xS4U2M+?=
 =?us-ascii?Q?iGsioKviL4LubV61CECCYWhezSrLmicvMKErinpTP6CahEt6/RJcu+mcEU1g?=
 =?us-ascii?Q?V/fcNvrezu4uZBQPLHaxSKiCHGuZTMG/XNgsPJ9Ypms0CGvYm1oO9IsI5kHC?=
 =?us-ascii?Q?GYOpj5LVQbKPyPLqwfIqxSGwW+9ZBIiZqLpm2M3lpSXd0e1ZIvsNn7PBoHJ7?=
 =?us-ascii?Q?Axb4gynCgjH5KjBy52zV3AsOP+aI/JBh2rkVvOthAW7TeiPgWvm93Jp8M6BD?=
 =?us-ascii?Q?cMRBaJZk6Gm5voCL/5pvn6hQFElIZjHEv23DX8MMgWoM3kFoUB9PIaw7PgxP?=
 =?us-ascii?Q?hJGMfoYEtLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+plDeuRe4uI5RZN2SqyLjv3sEgpvMX6YilnP9OLPWfvC2AoA8ub5pE4t7CqW?=
 =?us-ascii?Q?ElvYkCubvP/xwwffMFccANqKvlUH9TsJjZI584nenhO4UQJ70IFPRl7h4HjO?=
 =?us-ascii?Q?yxX4IM/gsiDLcDhu4x9Qzq4RO3EdMPUlGMua7ODmA93qxKeGxO7ZPpbV70Ed?=
 =?us-ascii?Q?QaJ/h4/4RN3faLo1DQKSPf76iKBQZkBNAyg5r11JvjPMfw4jbs58yzGn4TNq?=
 =?us-ascii?Q?wCbkvMx/k8GzwSvZ1I2gsRyz7674IIm9e/9pRRg7I0/8m1tGLTA3Lcr3KuZI?=
 =?us-ascii?Q?dlM5YLBst/UGV+XlLGzjCCSgiczAyplkfDDMa3QdfraWQhH50/Mb+oVFKqdn?=
 =?us-ascii?Q?Vsj74bvRsCy9OhHa0T5WLHxY6Q4m8f8c6herLI3iYLmZvgUmYmdH3GlkGNaL?=
 =?us-ascii?Q?gh0feJvyoIW2yYMz/DtclLAjV1fmw1ghcrZ6llrQE8aldu2TpGOhfSG/KAVZ?=
 =?us-ascii?Q?06gnvLPVbjb7Ib3AoLic6COBVoOItmCVI50FEOdCX/TsD+P/EmidBhYx6KrF?=
 =?us-ascii?Q?MFtVrA0BNKPQfApyAZzkeW4f9EVeufTxDn3QHtFwGdmAsQ8eFR7FYKP1KSWS?=
 =?us-ascii?Q?oZ2eQBdmU5t6RSLnhciReIv1+u7bRGCD/c2V3QuKld+jisBSHNRZ/7lYeVPJ?=
 =?us-ascii?Q?hE/hczkPGk976rY7T7IRfRj14b3eCPq4EFBOEemuS8RU8JxIoWmEkdedSkbv?=
 =?us-ascii?Q?NfkSp0k/scYjfc/DShRSexNyXYBdJKS50pAClVQoYVFyWuQgzhwEQRsWGIhL?=
 =?us-ascii?Q?4xGMbIw/uWiDEHRiHgnckgNY9DF6vA9aEyY+qzkcwE9/cgUhQvS3iD7obSnd?=
 =?us-ascii?Q?vSaxJProfmA8u1vfH1rX80xYlc8omm6IWX9uADRdUmajpFVSourQe/hKbSIr?=
 =?us-ascii?Q?TywP6PR6YWDVwtMElpwZQ6Km0U0cridB4AUUhxcMzh1v/e82VnhZGroFn8HQ?=
 =?us-ascii?Q?bOsOcagqWRj7HP3LN2V0dQu7uhHXUHBzUvjGaAhj3s3fbBtGXFepWMTWJlsh?=
 =?us-ascii?Q?Jt11a6FpTC+ITByEc3Y6PG4NpWMVvWyuPA/Jnw0+QL4SQqFW+Ai0VROellf9?=
 =?us-ascii?Q?rSzgQCSyUN6o337Gm8xQrigVa90RKI/6xPc1pJDVZ0VmbrVQHYSCD+2aUDJ0?=
 =?us-ascii?Q?NcTxXVGn+XPwxEbuQ39/SlNIYohU6XIUa6W2xYjxFDKnCD5oYHpDe9vUN8Ld?=
 =?us-ascii?Q?j/OfkbKfGlheU7TlCIE3al6JxQuJtJGnsa1sKfMltYYSKDR1kJqPIOoGGWxD?=
 =?us-ascii?Q?YDlJdZcft0j7bGIrEU40m7vZQ82aWVrc5dCDFkX62Fr+wo4XQNNz+u2cVjdF?=
 =?us-ascii?Q?m7XtC0E+2TGGU9PHJfeO35u0T3hzvxOJveBbnFO6sKUSS/jd1OyVpDCahU/t?=
 =?us-ascii?Q?ijay0TreIyUyjU4QnIF8jzryfkQSYKSI4Sy3MPjG0mo/tiyU7QhlGZSoAzUU?=
 =?us-ascii?Q?DZVsiNeJeTqp7Mq0AGLWhNe7j6YW2VRtkueB/Z8PW9jJ+1UrqXnVDwvyJnqA?=
 =?us-ascii?Q?pR4YFXcLQ718KiiJ3MOs1mdKMTie4GK+Za0fX3QUn+BhEQ7QTqCDrAhNTwCy?=
 =?us-ascii?Q?MHMp1lqQ9S9rXysQ+Pv/NyW/WPgj/R1nO8roBB+L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2143beac-b479-408a-a140-08ddd453aae3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:09:57.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pksdAdOLDHQ7F23miFn0OiI7f4pSYjHUedqtQUkzjh9n6wMrXttvUQoW81i4cBHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

On 5 Aug 2025, at 15:00, Lorenzo Stoakes wrote:

> On Tue, Aug 05, 2025 at 01:51:40PM -0400, Zi Yan wrote:
>> FORCE_READ() converts input value x to its pointer type then reads fro=
m
>> address x. This is wrong. If x is a non-pointer, it would be caught it=

>> easily. But all FORCE_READ() callers are trying to read from a pointer=
 and
>> FORCE_READ() basically reads a pointer to a pointer instead of the ori=
ginal
>> typed pointer. Almost no access violation was found, except the one fr=
om
>> split_huge_page_test.
>
> Oops, sorry about that! I had incorrectly assumed typeof() decayed the =
type
> when I wrote the guard-regions test code, and hadn't considered that we=

> were casting to (t **) and dereffing that.
>
> And as discussed off-list, if you deref a char array like that, and are=
 at
> the end of an array, that's err... not brilliant :)
>
>>
>> Fix it by implementing a simplified READ_ONCE() instead.
>
> I sort of intended to make this easier for pointers, but the semantics =
of
> this are actually potentially a bit nicer - it's more like READ_ONCE() =
and
> you're passing in the value you're actually reading so this is probably=

> better.
>
>>
>> Fixes: 3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm v=
olatile("" : "+r" (XXX));"")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> LGTM, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> But see nits below.
>
>> ---
>> FORCE_READ() comes from commit 876320d71f51 ("selftests/mm: add self t=
ests for
>> guard page feature"). I will a separate patch to stable tree.
>>
>>
>>  tools/testing/selftests/mm/cow.c                  | 4 ++--
>>  tools/testing/selftests/mm/guard-regions.c        | 2 +-
>>  tools/testing/selftests/mm/hugetlb-madvise.c      | 4 +++-
>>  tools/testing/selftests/mm/migration.c            | 2 +-
>>  tools/testing/selftests/mm/pagemap_ioctl.c        | 2 +-
>>  tools/testing/selftests/mm/split_huge_page_test.c | 7 +++++--
>>  tools/testing/selftests/mm/vm_util.h              | 2 +-
>>  7 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftest=
s/mm/cow.c
>> index d30625c18259..c744c603d688 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -1554,8 +1554,8 @@ static void run_with_zeropage(non_anon_test_fn f=
n, const char *desc)
>>  	}
>>
>>  	/* Read from the page to populate the shared zeropage. */
>> -	FORCE_READ(mem);
>> -	FORCE_READ(smem);
>> +	FORCE_READ(*mem);
>> +	FORCE_READ(*smem);
>>
>>  	fn(mem, smem, pagesize);
>>  munmap:
>> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testin=
g/selftests/mm/guard-regions.c
>> index b0d42eb04e3a..8dd81c0a4a5a 100644
>> --- a/tools/testing/selftests/mm/guard-regions.c
>> +++ b/tools/testing/selftests/mm/guard-regions.c
>> @@ -145,7 +145,7 @@ static bool try_access_buf(char *ptr, bool write)
>>  		if (write)
>>  			*ptr =3D 'x';
>>  		else
>> -			FORCE_READ(ptr);
>> +			FORCE_READ(*ptr);
>>  	}
>>
>>  	signal_jump_set =3D false;
>> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/test=
ing/selftests/mm/hugetlb-madvise.c
>> index 1afe14b9dc0c..c5940c0595be 100644
>> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
>> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
>> @@ -50,8 +50,10 @@ void read_fault_pages(void *addr, unsigned long nr_=
pages)
>>  	unsigned long i;
>>
>>  	for (i =3D 0; i < nr_pages; i++) {
>> +		unsigned long *addr2 =3D
>> +			((unsigned long *)(addr + (i * huge_page_size)));
>>  		/* Prevent the compiler from optimizing out the entire loop: */
>> -		FORCE_READ(((unsigned long *)(addr + (i * huge_page_size))));
>> +		FORCE_READ(*addr2);
>>  	}
>>  }
>>
>> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/se=
lftests/mm/migration.c
>> index c5a73617796a..ea945eebec2f 100644
>> --- a/tools/testing/selftests/mm/migration.c
>> +++ b/tools/testing/selftests/mm/migration.c
>> @@ -110,7 +110,7 @@ void *access_mem(void *ptr)
>>  		 * the memory access actually happens and prevents the compiler
>>  		 * from optimizing away this entire loop.
>>  		 */
>> -		FORCE_READ((uint64_t *)ptr);
>> +		FORCE_READ(*(uint64_t *)ptr);
>>  	}
>>
>>  	return NULL;
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testin=
g/selftests/mm/pagemap_ioctl.c
>> index 0d4209eef0c3..e6face7c0166 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -1525,7 +1525,7 @@ void zeropfn_tests(void)
>>
>>  	ret =3D madvise(mem, hpage_size, MADV_HUGEPAGE);
>>  	if (!ret) {
>> -		FORCE_READ(mem);
>> +		FORCE_READ(*mem);
>>
>>  		ret =3D pagemap_ioctl(mem, hpage_size, &vec, 1, 0,
>>  				    0, PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 718daceb5282..3c761228e451 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -440,8 +440,11 @@ int create_pagecache_thp_and_fd(const char *testf=
ile, size_t fd_size, int *fd,
>>  	}
>>  	madvise(*addr, fd_size, MADV_HUGEPAGE);
>>
>> -	for (size_t i =3D 0; i < fd_size; i++)
>> -		FORCE_READ((*addr + i));
>> +	for (size_t i =3D 0; i < fd_size; i++) {
>> +		char *addr2 =3D *addr + i;
>> +
>> +		FORCE_READ(*addr2);
>> +	}
>>
>>  	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {=

>>  		ksft_print_msg("No large pagecache folio generated, please provide =
a filesystem supporting large folio\n");
>> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/self=
tests/mm/vm_util.h
>> index c20298ae98ea..b55d1809debc 100644
>> --- a/tools/testing/selftests/mm/vm_util.h
>> +++ b/tools/testing/selftests/mm/vm_util.h
>> @@ -23,7 +23,7 @@
>>   * anything with it in order to trigger a read page fault. We therefo=
re must use
>>   * volatile to stop the compiler from optimising this away.
>>   */
>> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
>> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))
>
> NIT: but wonder if const is necessary, and also (as discussed off-list

I just used READ_ONCE() code, but it is not necessary.

> again :) will this work with a (void) prefixed, just to a. make it clea=
r
> we're reading but discarding and b. to avoid any possible compiler warn=
ing
> on this?

Adding (void) makes no difference, at least from godbolt.

>
> I know for some reason this form doesn't generate one currently (not su=
re
> why), but we may hit that in future.

Neither gcc nor clang complains without (void). My guess is that volatile=

is doing something there.

Best Regards,
Yan, Zi

