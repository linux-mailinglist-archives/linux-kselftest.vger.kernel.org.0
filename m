Return-Path: <linux-kselftest+bounces-39703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D84B32150
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76A7B068C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751622B8BE;
	Fri, 22 Aug 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F55aswAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDE2FDC40;
	Fri, 22 Aug 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882687; cv=fail; b=YNGbEoqivmlFX8jK9+A79QeBXY05s+CtUxOigNso9plRvT/Rq7cjzDAmanwTXo6IWl7dyz0anU3wcqi6E/0NHHWqt7v98h2t6evd2Ra9M54kHyx+YofV9T6KhMOAMjaRSe0aRR3jHsOgMl/HKWo8YoQuFj2iX8DcsS2qhG5PbEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882687; c=relaxed/simple;
	bh=1MYNvWb+JOsrSG0gKEVrTE+Ra7LRFTK0JaldUAoWZxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVDtBKBJjYY5aMHJDutE9fmUn1NaHBAMls1uRMaFi6gTEdaroj0cryupRy6m5oavuoXu9wcYai96hKzBExlkEH+H0Xhsb34E342N+anqHam/mHmF+kiF9DdIbVjbVgiWmijt3prZs3sdb8ZSlglZuyhoQzZvmE8SciJmgAobryU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F55aswAC; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu/FbQ3Qhv2wyepYot/MmE0corw4/QSx4SYq2tyScSriKghnL1CPpP+HEpMCbqil10T2T7oDNAtGx8+51+MJsdMf7vVDP4ONlyIYo6WweuqD/uuL7X7zIBQiJPCgfMIR7uBlvIr3g465yYvGi0nDLEGZ+nL/D5fEKMsv6ZIneBGYRVTJdhFVMTD6fahYxrx+BWrXJpeGrPi0kpRlmQT5agzXi42dZM6fh67UUDKwCVNkS9+vE1Hqv+RkmHRF3A3NxJ0iUIXKUHo5pvMB3Dnke28cnjrrK4wVT/Onuj+gFmrN8Valv5HX4kWsDnhcJbV0bE7KknjEc21itWoa1LbraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6rO5k2d7iqus8xx5LfiYGkwO0tj+CarENOjjj4ZxHg=;
 b=eUpNK6nvHH+d4+b/r1Tslm96BRXnnZXHbS8dO8kQf7HIPsMa2alYsX2fBOEgjzjioLXk9LmgMWewyfpb0+A8+Udw/z59wmPRgOHBG6slhWEgWrIobeJmFncjJdsl93a0Hq2OnIVKZCIUTvMv7t90tEj4nArU+knaYay6pBkTE3wtnPfX260tTMQBHUF7yE6lDYTYM6D18UtqomBytXt48uaod1MpV6EhS04kzrIOY/t5oF46CSeHmPbv/XAS+wKFomddWxeCyZk3U09ZGuj4EmdRBgjrivX2tziPTZGXzfD3DLVhy+WFEc3RSqKbVfneHzGIHEL1v+ICBo3AuqAnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6rO5k2d7iqus8xx5LfiYGkwO0tj+CarENOjjj4ZxHg=;
 b=F55aswACn+OLERP7wm4IKRBhfOTJMdAWEwO4V2G543ACBlmZXpvwNApgvUNCyxNdJL38eBnFyvDaqMToWIMksS6ifFsvUzxhaiWCsxS2iQH4dbblPBaBSVNifSuEVJjNt9DOLsaRhqSKfsek30cS4+5l8D9z8RDEkAryAWVnaUzCov1zF9dLRkAJts/KCL8CfjX17jtN9h0woAZipTvqMPNeujLG1H4HQHruG3wFZeJvL87pM6LmsUYqi2qS3nhCv88hxk3gTWUNWHtKnXBD4ZBomVanvhIcLupqf0Gcl6mvuUjaYyfY7ZuNnwBsc8Pkhsi4dEzl+x1R84cpZNzdHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 22 Aug
 2025 17:11:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 17:11:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kevin.brodsky@arm.com, kernel@collabora.com,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v3 2/8] selftests/mm: protection_keys: Fix dead code
Date: Fri, 22 Aug 2025 13:11:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <946BF413-2C8A-4EDF-8C8F-915997339BED@nvidia.com>
In-Reply-To: <20250822082145.4145617-3-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
 <20250822082145.4145617-3-usama.anjum@collabora.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:208:a8::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c543e15-34e3-4576-6fba-08dde19eea85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SCIFdSYVIn/BqJMH5CSSw/o5i3jVMJjJMfZVP80jnNeFeyYq+8Tif/j5GOEY?=
 =?us-ascii?Q?xEkoMgRDpcK3I5RPfQJ2XdWyDhp1E7fvwHm+W/Sh1z+9N0buKKfBaW3P+1yw?=
 =?us-ascii?Q?A21SZXwUyyS1XD6io3eQKvjYa0unUZ6PLn1MBZez94VmMaHG+l8YBcz3hUTf?=
 =?us-ascii?Q?hefwStgvGOvK0L2kEO5zOzGkTA2BzHwrefZs6gqZxcWCFHHryDcI1CK2+u3X?=
 =?us-ascii?Q?SvaC6rlSz6jhp9sRs2TyqNrJuht1BdkE1fDBKxZ2xeS4KgtKWKA9rcLPzyNp?=
 =?us-ascii?Q?4LH62Bp2DoAZBHNuxPVwPU0BnDMAVe9xwVvbnby0KeFNl3rNorj/lODLNif/?=
 =?us-ascii?Q?egxDPCZOgO8NNqUE2XFAjXCTZk0DHtANWSTtf9+pqKDbl5YK0IrO5+Wek/K6?=
 =?us-ascii?Q?IgBeUblEPBnCnkKJ/LkXqIag1A60x+ztm2Fl8dXeWoYnRonP1H5uXjlEwVyb?=
 =?us-ascii?Q?u/hkpYq/FpSr9pFsdN/qjXLii/fsHHcl8fnFBam2aD/AS9U1NhX0NKOvaltC?=
 =?us-ascii?Q?rD62wRxFHIj+48ghlN7iTnSSwewi2WSMqSaNlO8Y5JiRvUZu4HGvyzbdoTGZ?=
 =?us-ascii?Q?Y/mQ5nJbfqb/ufseTg9DP+6HKOSEwvOQ/iZB+ahjy6lJoSSVw0f6XDV/idKL?=
 =?us-ascii?Q?f9MiRH8uo+q8Pfku5eaW6U+wf8bUVy2JWXcsj7NkP5H6jlzYMj38xojwsCDQ?=
 =?us-ascii?Q?O4xkxVcWVGunU0FcyRya5xS/dohN9ytC/ShOCqGYcRxRtn+3C2dPxzfyg16M?=
 =?us-ascii?Q?EizkJ3AlzRy6hAQUYQ2YB51UQSP+hS43LbvwHDdGqgxbdseHvk/njsPBPcLc?=
 =?us-ascii?Q?U7xAy5D8JBniI4wstPiHdVi8BmlEqzGXivYsNZrcSLlVvCN3D5wWqsbXyLpX?=
 =?us-ascii?Q?ExyDfi/IcGdfGSJXPjqtI9kVRRk0Z3n6hRsjassD5GOJ5EtjanfcpjemiSdL?=
 =?us-ascii?Q?eaeksKIs3tXCI6R9FNeVjSckxFbOPPUkds+ecmA1EQLzldZliofhT5pm986q?=
 =?us-ascii?Q?iXIpVw9EctnXMlkcpit0KDit5BIqi/2JK3b5l4/861QFEMrgdYL1CfvEvvFw?=
 =?us-ascii?Q?z0NjfI11HKI4VWoLMLD6s0YLg1Z3ucBTD5Jsao15mSc/fIyqLWq7DtxFVC82?=
 =?us-ascii?Q?z3tYagfXJaxgeWaNfSoMuesaptdzkQv0ZivvXRO6fsnfLGxGDi6wgEkmuNUb?=
 =?us-ascii?Q?HCiMO//vyquY3ACdWwWdk5flLyg4dU0bUfFpIAWT3FoZHLfcjr4TqXaREamL?=
 =?us-ascii?Q?RXk4su6yJNQ4vIcNP9IxTFOoLJnTNvqbYumEJu6WF2grzo6xy2sPEulJ8Pvu?=
 =?us-ascii?Q?36eMJ5FQ7L9bFTaigYAYNTkZ3L6VUmTENwq4AkF1U74BCAcocZ9JnZqTXIlv?=
 =?us-ascii?Q?l4reUWcsEkmJ2XECC8EHH9lDCFW6HXeDBrAkuwr7N1Fmy6C7WeOiBhsUckVX?=
 =?us-ascii?Q?McgbNhP1Ekw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAdoG4n7AAhH2v+teq/4Z7UfqYhqnhoIuW/z0rQphzUCDTxxSS9TmP46ZptY?=
 =?us-ascii?Q?8iQstKg5Cs1UFYbz/gVZpmuoc85xolNh6WqSG71AVi+XkQRxEq4HvzLadtZH?=
 =?us-ascii?Q?LLkoYRmQ6WraXsq2WV3Iwng6k08JnuBIxMPLBKq1wP81p2n0cuRt510oN18g?=
 =?us-ascii?Q?EJpBuWzRWeWxKmJpMmjj4+Y6obeuh3YWZyx2/CZN0dU3/YrR5AFeFn/tPCMm?=
 =?us-ascii?Q?01O1C0ArifzI+zZfY/y7omnaVyQVoUGkt+n4fji+i/2IqVdmmjTg4HtWJlf5?=
 =?us-ascii?Q?it0DW9AaJJ6g1YQKbSzYZJrSrEpWcmoLTQQtqDWWn92PQH+H2WLfNF8fS+m1?=
 =?us-ascii?Q?BB1gqCr1bc3wEU1KkyI0dUaYzJ0Jon7EAvjL2oyXQZjCYyzKvDghsFlBOWm1?=
 =?us-ascii?Q?Pyz6dWLyLXef2oR75zG1bscJrbtVwkwVXYEm0YF+CCahJe3AfY0rD7sqG6kM?=
 =?us-ascii?Q?uE/cmNjVUcF6EoprlTpiXPQGYQmYyOAHaCFHnocpB+qIHT3oWozAJYA9R+5S?=
 =?us-ascii?Q?q0tB+B9U4dcvNw+DCjrdb9hGQoy/z41Jo12N3V9cfdbRp3ZTYLm7me248GYr?=
 =?us-ascii?Q?IbVjzbd/wUHWehPctk/8Hkj/jy8ffxRox/is9ZbKp7ftRJAtFRasdSg3dzic?=
 =?us-ascii?Q?LIa2gpJDGwcLiqw4DJuE4Aj6fHITU20N2Ius/HpCE91IMZIeZAxffujToHI3?=
 =?us-ascii?Q?CzYzxrT8DgPrQR1Rzip/Ddo03kfk35KxLDgmAMHRJISu9R+454cpcVuSoxgk?=
 =?us-ascii?Q?KTfkkxkx9K1+60P5UMy44o62JXO6iiOyTtDuyi3pkBsThntgsXGepl4E+Vh6?=
 =?us-ascii?Q?sNgoFmMbEFbkacl2NORMf35vzYBdLKMJYsat6d6rXGDOpiJudy6+Uymi2EkF?=
 =?us-ascii?Q?nwpjNI3ZEFyUqZQtlPdyNkbEg7gj6uOY+YptEKkcLI02/0Vf1bFs5ufTvJxo?=
 =?us-ascii?Q?W47MNGei1MB5bE1BEF5tmUCHnpL09BXRtsXMZxA/OkH4xpnq1I67niOgaBYE?=
 =?us-ascii?Q?Gt8CQu/VkHGfKRVbx2Q7lT/Tjoh+fruMV3NZfIDDCyDGZkbXEza7zSOR44hJ?=
 =?us-ascii?Q?LrGW7hP7WV2Yk/Hi2mJt2Wqwp2+NZe0H+oXj1L8ra3wvJDE4e+10tvD1Ih5R?=
 =?us-ascii?Q?gWkpvvd97mO8dlSHJ1GQ3P9tG0xYWTjmV9aVjVe86uXIg6sywWpVRg2agg8J?=
 =?us-ascii?Q?ULWdxuN7ipJWhcR0nsp71GtxmOHU9/GhivnyFhoitBi7nNOmIu9as0zVtJGk?=
 =?us-ascii?Q?eIn5zM6pzhn/8N6uJZ+fsMoBNnG07Z2o0yOXSTxQz3XJ1dw4waGoZfD5F+MA?=
 =?us-ascii?Q?7cyiiYKnV1vUcmDi1E2Hrkj0MXRNTjnPoDr6U9abJYUx1GaX4TRLPA/l2XLE?=
 =?us-ascii?Q?8sxdY131TMOLuGq6H+MqGfk19/XVzKS03ziL3aLFgf1++eSEauB0ocJaf+5c?=
 =?us-ascii?Q?y5Ai24HQNSBrfYnFJedp5nAUm9haTR5hRVzsk86wi7w1WOeoBw2w2W1aE0ho?=
 =?us-ascii?Q?CV9Bx6UH1VAuzk9q1h6SUQ1v0l2Uggv6iCS78IFfxsH6Jl1HnNwavtvYEhCJ?=
 =?us-ascii?Q?uHfNOzWkUUdlov3IlosF1/X0NmblX/waFamORsER?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c543e15-34e3-4576-6fba-08dde19eea85
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 17:11:21.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqakDFVdA65xW1Q63ka6Rt2cZFK/9urEuupVdLKWDeHmKU6Ylg032Jq96K6ps92n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

On 22 Aug 2025, at 4:20, Muhammad Usama Anjum wrote:

> The while loop doesn't execute and following warning gets generated:
>
> protection_keys.c:561:15: warning: code will never be executed
> [-Wunreachable-code]
>                 int rpkey = alloc_random_pkey();
>
> Let's enable the while loop such that it gets executed nr_iterations
> times. Simplify the code a bit as well.
>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/protection_keys.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

LGTM. Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

