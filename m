Return-Path: <linux-kselftest+bounces-38914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A0B2560E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6611BC387C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D12F291A;
	Wed, 13 Aug 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuLjbs0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFB2D1931;
	Wed, 13 Aug 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122344; cv=fail; b=AjF0weYFvfvqVEV/WH6i1shrGKUvzx4zetOuXsRdMA5kArgkvp+bJXBTTUVi6azUM39RyWzDzp+IsdayFGgFu4VcmEG0G0ZKV94tSz//PpRltlZkdYVsggDADxGpUvC94At2MGO3iHFWBZwKNVjE29uv2f0feIUKyPBGkoix96k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122344; c=relaxed/simple;
	bh=sxV3l4vsrBbqCejdpQkhnYBXz19VX2sDM4xa1ZpRq7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQ5mvBNGsINuLGJ4gZOFUFQagJQir/S+fYtblzEhglWUtqLUXyX94mjYPbcqb2fwIG0ulPs/+alc7KM3jwhiop/NrcbMXbrrWnPlD/SMxjOO3JsocCwrShBMV0AKZ0dP1zMEj4VlK6f5UfbawVSPZsqNAHfyCuw5eieVKSqd7Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuLjbs0X; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJxbYLKZdB4A8PUI5Gw0Coa/6lVj/sECuzVphDq6+0nbXA7GdaaEKo64z+NjGyEZXZ3u7QHGmn8tYyQAd4n074/JZmt5FR9hkC5/GI6FTyKR88kzPF2Vbg3Nh9UIk/XLNiR5H0gwpzG/VA4Db5IJmDIUT2Ux4H4tp62Y0Aau5dRlxizjGNBQa0ZOypMNQ+VtsFVorLg0VfijtQMm5p/RSckB9FG0BWuUAtIXS/sWOpAPT9adR4QaBEfssBQdthBuBAyisPKOgSJ1KHXne3R2CXdncccdwSKtTBUvfSTQVLEUoY5ktqwCRKCSiw2wsJqososxd3D+1OaZsVishu31qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YQMqWqypbzImJevRAd+OajkM+o095f2467q4tvTpUI=;
 b=cLb7qoneGcFEfzPChADGiq8B5YCTYTIB8wmkb7qpi9g4YF5L2w+wBQNNFmWZKiU6FJrMa2nf/H7Jdvkq02qCNWr0YAcnRFcsT1iowhSvv7q90WmflXN3BED5q00nTKBeGzHlUn0wH1hWGHKpPAqmmJsFYr1knYqu8zE8DvrBp9pbu2pr2lJyZBOWKn+CmjqEoPA2YkWKHu8kA9tleebOcAeiBtQsToouaDlPdsmbby1M1Hm4H5poVs7kkruZGMJdaFSFPb8h+AN6I0fSNJOlXrLObzUFhph1nQn6WmL4WjmQ9OaSgrejf78yzuMkTKTmiRKV2div1v9o5BhA+eQcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YQMqWqypbzImJevRAd+OajkM+o095f2467q4tvTpUI=;
 b=AuLjbs0XI1ENXFlQ7mWnUZ4c7Ov7SF4FgPgWH1iq0s57auqgDMTnETh137xggpfwF/A+1Iqze/Hzv6e+TSWpMzXn34Bh54o6xPw+l6szsEhuu6Q2qb+J41ex7hZDb2b6zUCh9bH+7CoqY9e4bA078iYswiuNd4FtK73fwYH0ZsykFqfKR2kq0xBk65XcqYtWt+R/Zl5pIZvfhad7rppBT1+YW1eY1ONdokcSkGeLz7eFLqmBlfmmB+yNTvFvIVwNqMOi2iz8GeytZPLK1uPr1F6l1bh0pl4KZk7u+se3kKbSxyW9Sf3TGAuAdINxDYSUmCtr4BHGZo2qTJTKNm1Qpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 21:58:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Wed, 13 Aug 2025
 21:58:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Date: Wed, 13 Aug 2025 17:58:56 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <47433AB7-58A4-4791-9C40-431D8573E26D@nvidia.com>
In-Reply-To: <20250813214112.tarr5rbamtc6cmie@master>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-4-ziy@nvidia.com>
 <20250813214112.tarr5rbamtc6cmie@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 722a1e39-493e-47eb-c4e0-08dddab49b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ki7ii3QkMDCx2Sm9MUu4pgGwe5Fgl2vFKhQWwTScg7Bi5fM/VBZMiu7ZAhEl?=
 =?us-ascii?Q?laixqU5kGgZqAHLfEXIQD5PLXv+RoT1WTQ9Q8clFc7RLlVIVpnJsx14uA8Z8?=
 =?us-ascii?Q?Hw2mXhbIwRyE6ubSQ2qML3dnYICfcwCRmKdF+4EB2ezlxIF1LFnZUaa5DxFg?=
 =?us-ascii?Q?8/1U029Itidd5yQPE6NJVkQTjlHfxu2u/kPu88KIHBvZSQ4McVdTcDcGSqRN?=
 =?us-ascii?Q?sNtdMKSNsNjcrO23WN3Lh2JT59z+L/s/ATst8jnEl1hMbNRlSl35F+snHELh?=
 =?us-ascii?Q?6yWFAMeUnC3bYQLat5BHezkljvOY+8hQ71sHqtt7Kg91gDIQ3uDRw5tvPIRu?=
 =?us-ascii?Q?TTiU9ip5Y8Xfo/qSvYynNSFW1NxQLX1eqL5Hq+XFD/V2E89Cj/0/pD0YELeO?=
 =?us-ascii?Q?aX1/cXf0H5AEKOkD/8cu6rpJUHQdi3T1mkF9BaQfXzEtN9o8fWVOXPzWSMhP?=
 =?us-ascii?Q?N5XspHKkmuzhQNpPS4i/1Ny/qcdOXbbRGJCAEw1C9dAXPhRprOaCnM6NGE+0?=
 =?us-ascii?Q?YJRz7dRdJpb/Quxk6eoQqhRIX1TUyErbggxqHxsnxjXhzQ0Ygymx5puWSXf/?=
 =?us-ascii?Q?p3aaQnUiKJhZN61A4kdfbNd/Y2+QEXMdHbtHaFooXF1aspYNxlNxF/LKvph0?=
 =?us-ascii?Q?OxEmp9cb3+4mNBwOaFSxz+htJSjYW+LtAnv3BxHOj30AR5k4SQGqy/av7ERh?=
 =?us-ascii?Q?r63j5qsGN3JzzcUCBcfvBdRLyH+pMikTDCBtlU8mI2TokHXKekgDj6J4oixn?=
 =?us-ascii?Q?jNJR+GqgC44CO09S4hnJTDZMT8PJg8gbPVb0wDd9LR1T6ixOqAnH3mxjfg5r?=
 =?us-ascii?Q?9HqlTMOj6ifJeFhp/ARhRTnAXzVerXlEtpG0GC3D9btoNUtt3p0UZdg9pydE?=
 =?us-ascii?Q?Q1LcOusBOcQSpB3tiRe3AhjQpN5q8rzkJd2S8BOtLBvomyJWTACXtIvPH9WZ?=
 =?us-ascii?Q?q5LHmZQzZOW63iKaOVS+zISoqkgTLfAI2f6DcYha8ZaE5sB83qApGr3Q1hot?=
 =?us-ascii?Q?r5cDQLcy+/Vq31oYRCAfzXHB/x4YcNDms9BQQIqzFMm4FglKESR7w2iDMbF/?=
 =?us-ascii?Q?6fYsalJ7pbQqzEfdTRjyG3hIpntA1GzJErBHNy+jZ4c5pewbFATj35TigXWF?=
 =?us-ascii?Q?xgBOUW0n233sqwtptXHFA6+KK+/5Ty8JVaobu7ssjB6MUMwJBLJHIU+/82Qd?=
 =?us-ascii?Q?Qs27kxyX5McuLTjxVXpSqVcQ6biHIWkTH2OpEWUSKXdjIQOjNiLWVszAfnQF?=
 =?us-ascii?Q?FhkN0IZBkxprPFNdZLntxzjtyehwN/vQ2yJmBKzTf6J2ycaV/Y4n1Vks1STk?=
 =?us-ascii?Q?7U8PufD30Din8T87FaJGJOsrWPMfCKElUIhdcSz96XEPlA+eoGyV4gXKXtxL?=
 =?us-ascii?Q?tdvVYkTqJYFsfCjq2jqnUOcHCGfFThs9GX3VrJWeRoXKItFv/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1s7o2liJCKEWj7KCWfKmWHKu1hQmfWfn18scw7C30BngYQSKi3hLycQksxMc?=
 =?us-ascii?Q?ouYBXjJ7Qax5LPGSXJdjQko/UIxMKqCp7MWOQEoABP/YLk94PYu+IytSoTB9?=
 =?us-ascii?Q?yIAImDXehzNUBn+lbx1cyeL8cS+lV3WAbOc+FS2x13Q6ct4mJVWxbbXVD4Zx?=
 =?us-ascii?Q?k3BSryimfXzvtvCVnL19XLPTZ1upNDwOiswr+awTlKcJQSNsSSJO77dNPAnS?=
 =?us-ascii?Q?BoGNlhCqpP3evM4XXYtRXHxjoLCgSYZmnzqgbD89wzv2P+VwI+nHGU5r/gRz?=
 =?us-ascii?Q?AFoAOHOjmP+H4lS4HDkkbnId+oNW99rbrMFLtEn5wS9nxEi3sl7b/SGnhEqd?=
 =?us-ascii?Q?Vv2jX1kTp6finGK0RIhtdQ4rCoRyXvUHSMUsZhDsKNeNxWDG33jkGxoxqJL4?=
 =?us-ascii?Q?3NLJV8gNxcz0f6hcbdk1I1MGguGyitbSoqp3cShJhQllO3LsuI7wzWiilIay?=
 =?us-ascii?Q?jlF7CRewoos5JTFEzoAhG+lTCbOa4Yq+aJYKfGQH1YlMUmDmjpXWNEdIcTTV?=
 =?us-ascii?Q?W389jYblUthgmIvyZgXPjNXxyjNsvqmvrgkISWbovkKNZGFc1x2Tx2ZBdsri?=
 =?us-ascii?Q?arUaUXv9JxDWKFJpC7fG1X25mcQgDaWBDzpK9orSKsYTxgYyi86MSwTbzfAQ?=
 =?us-ascii?Q?oNO3d342A/P+fi+JoqDGBw8qKNejnpvC6vVkL3LbPmjWyeUtiY7xAfCVwKoW?=
 =?us-ascii?Q?lG7LEMh1U2c1OMetdmy9pk5MKjOLJpZfuVrNIG5+Pw+CIObAC1bMmcVkPZo6?=
 =?us-ascii?Q?tEGrdhbhydA4q+IrkCZcTPuAnp+UO9vJNFoquCIwJ4Hw0e86TJkTs2zJlR5q?=
 =?us-ascii?Q?SGYXlHVDNcmdDm7WWvwGQ1foFkeuY3lp4FHrCVbAVjXjRPQLbuheQwZCP2H6?=
 =?us-ascii?Q?22UlghR/cCIVGGDXsJcNuRpJvCwSCdKrRTHnn/Vi1ClIGK5k/7Aapb9Z746s?=
 =?us-ascii?Q?fVMMj0ivTT27EEHsaFEs37CzeqaP71T4QLK38JzhdYNkp00dwqwCpt71ZqhU?=
 =?us-ascii?Q?Zx0bxePhhqtHVn9rP2lTUIY2lp6HF0prAz+2iv8khpdtWo7mAURF6p/MxswE?=
 =?us-ascii?Q?jFrzRctYVhW5c9ycPFXYlW5GhWtXSVnFxAcb4+wlG/JUpvTfSeK66/COAj4N?=
 =?us-ascii?Q?3HVD0BpAH+YjhJa09PEhBmUk6rw6tNJ/mFUdzfcuLBehrandxfNvw33AhDxQ?=
 =?us-ascii?Q?5pGIl9Xqh8UgSOmQJFl3uEK0vTbVN7Mt/tWZX9DnfqbFSWRRwKw8g1EPdZP8?=
 =?us-ascii?Q?J44MELWpFpq6zxwhbC3DlsJRbK3hdpAgKdDiSn0dxFtqrHN7wZpw3MkJr7T7?=
 =?us-ascii?Q?arOlEf+6pM8a/HH/9FzU55+nlZssfZBw22JIwJbX3kdy7tnQwhfKcJDJpmS4?=
 =?us-ascii?Q?dPgCxp/dqkPby0zhwXHdmbv7XGJVb7SLihZ8GQXgcppfOwyX5xqD8v+a3sBV?=
 =?us-ascii?Q?+rIPOxhpdMD0k+Ub5UOB0MGMWVASeWwKIOf+hVyI2OWKDlIbP8L0h7RTlGjR?=
 =?us-ascii?Q?BWsK+QPJqU07mfEK1jLFaI2hyIRl2jQTWSdu/a+pDZhHKbo6apkjXjcdzbAg?=
 =?us-ascii?Q?pEvgCFLaPtJMIP1GsAu4pv+5lOqbdf2JvC1Q6rrd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722a1e39-493e-47eb-c4e0-08dddab49b75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:58:59.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRYiAE5yPub8W6zRBOH5aq1rYx+EjEQZnIbJY6JZ/MARev/4zqfxLeCbDTcV2N4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

On 13 Aug 2025, at 17:41, Wei Yang wrote:

> On Tue, Aug 12, 2025 at 11:55:11AM -0400, Zi Yan wrote:
>> and rename it to is_backed_by_folio().
>>
>> is_backed_by_folio() checks if the given vaddr is backed a folio with
>> a given order. It does so by:
>> 1. getting the pfn of the vaddr;
>> 2. checking kpageflags of the pfn;
>>
>> if order is greater than 0:
>> 3. checking kpageflags of the head pfn;
>> 4. checking kpageflags of all tail pfns.
>>
>> pmd_order is added to split_huge_page_test.c and replaces max_order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>> .../selftests/mm/split_huge_page_test.c       | 67 +++++++++++++------=

>> tools/testing/selftests/mm/vm_util.c          |  2 +-
>> tools/testing/selftests/mm/vm_util.h          |  1 +
>> 3 files changed, 48 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 63ac82f0b9e0..3aaf783f339f 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -25,6 +25,7 @@
>> uint64_t pagesize;
>> unsigned int pageshift;
>> uint64_t pmd_pagesize;
>> +unsigned int pmd_order;
>>
>> #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>> #define SMAP_PATH "/proc/self/smaps"
>> @@ -36,23 +37,48 @@ uint64_t pmd_pagesize;
>>
>> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>
>> -int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_fi=
le)
>> +int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kp=
ageflags_fd)
>> {
>> -	uint64_t paddr;
>> -	uint64_t page_flags;
>> +	unsigned long pfn_head;
>> +	uint64_t pfn_flags;
>> +	unsigned long pfn;
>> +	unsigned long i;
>>
>> -	if (pagemap_file) {
>> -		pread(pagemap_file, &paddr, sizeof(paddr),
>> -			((long)vaddr >> pageshift) * sizeof(paddr));
>> +	if (!pagemap_fd || !kpageflags_fd)
>> +		return 0;
>
> The same in patch 2.

Will fix it.

>
>>
>> -		if (kpageflags_file) {
>> -			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>> -				PAGEMAP_PFN(paddr) * sizeof(page_flags));
>> +	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
>>
>> -			return !!(page_flags & KPF_THP);
>> -		}
>> +	if (pfn =3D=3D -1UL)
>> +		return 0;
>> +
>> +	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
>> +		return 0;
>> +
>> +	if (!order) {
>> +		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
>> +			return 0;
>> +		return 1;
>> 	}
>> -	return 0;
>> +
>> +	if (!(pfn_flags & KPF_THP))
>> +		return 0;
>> +
>> +	pfn_head =3D pfn & ~((1 << order) - 1);
>> +
>> +	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
>> +		return 0;
>> +
>> +	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
>> +		return 0;
>> +
>> +	for (i =3D 1; i < (1UL << order) - 1; i++) {
>
> Do we miss the last tail?

Yes, will fix it.

>
>> +		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
>> +			return 0;
>> +		if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL)))
>> +			return 0;
>> +	}
>
> If this folio is larger than order, would it still return 1?

Yes, but it should be good enough for current use. Will add a comment abo=
ut it.

Thanks for the review.

Best Regards,
Yan, Zi

