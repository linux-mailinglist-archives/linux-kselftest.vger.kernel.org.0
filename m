Return-Path: <linux-kselftest+bounces-38702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B4B21486
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410EA3E361F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53922E2843;
	Mon, 11 Aug 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GuGb8VbN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC219F115;
	Mon, 11 Aug 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937612; cv=fail; b=e3eeoeFLgGlT4oHlsZqW4YnXyyKI6RNkMjXV+5C7Lvh/Z5xpLzphZUMlujvhGo2MxWMXGY4+IqokoYpDXVEA+u/x17ohp5RZwEV2irZRHuDX2fDwoC2VJeiekp5lNDLEVzh31lBSaPVWY3V5RnJnZMOwo52jq0sb6P7uPc0ct8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937612; c=relaxed/simple;
	bh=LkiAIAUJylxUueXEF4DlK46ySqJYanBJn0vEi2KVbBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uygJOmglnZ7H5qT4XQYHcmWVn0EIeMSdHNDOPgP3aDE5ZwX1jwDgIkWRziaK3HVwJx6b2bS2nLembF3PyleKO722T76NJkaPirFFQdVmEDT7R7+eA/Eo2idv6ghQzMFZaMCRKpHq+91A/O61wt4LdAS6UEXaGSFXUSedwuSLT88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GuGb8VbN; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7PKHibECT+3F572/l4JctqYBCHnZ+CrzYAANpPhz4WSFcvg2OAKZKpJTEPPCyO09jE53luIh7XiqjuPXoANWMldtMNjcDnty05aX0e5pe0ymx72aGj8E87hTZ3+1FSoBpv5WguENVs0weSPKau0/1apo+yuIa9cXPmePLE7WsPx8y0NQFWpgxSKV6eWG5vrzNNuRKoFrtKCy9nBR7UB5jr0INibEuVzA+1NoGpZVUHE7f8ucZyx/vxdWq1uB2ZTHzy8dRIXrn+W4snhzbmacrBRxPWs+870c2HQ/UHBam3Anyp9LFTf8VDc1XftIRQWQ6T2PlJg8cCjNzwOhQx9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1Cb0k2KzHe0tkqfvH78m1mNwtlrvkIn/EWea4/I2+g=;
 b=HMM4jxQaUSuPf4CgMM/XOKXgoyptPHHA7CwHsFykyunaHo+E/seykuXRBrLXwwLjt3AKJVG7+JXqirUTit+qautxrj8a4fGaMjWigABxJvBjpJwzCCGRYUOetR2+bhg4oCQH5He0ACCXwcKTqCLv6HBc5yKNNQ1Sz20UqDqZHTmgyPjTfE5+y/y0KcJTDEHgI8Jnvm0sYPQtq1ZiYeab1EMljLq1UWzZRR/kOPhbF9WoBQUGeSkJkNxfQ0b3H3U05SKs6KSDCKUpPubFsMrxvoeqOkbiyIKustbDerTNavUblw5zcdnWNy/0Mw0kHc3Y0/9lqnZ3NJGshnuNdjCj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1Cb0k2KzHe0tkqfvH78m1mNwtlrvkIn/EWea4/I2+g=;
 b=GuGb8VbNplC5McKAYLakY5PdxdkFHxJl3Cfi3x2X5cRxyE3LAb3hxJUyZws0OLXSxrmRDfR9aatURSkS9yI9J0/4KmkMVd8Wk/A1SVhUvi23M2tgeacZZGyxbHbLeSlJGlGIc7JgUpm4WPgdmoITyItHOdT23aP739DNwqPQE3xuEJQJ0u4hPCdqeMAgIRzvib1SNgeFUMlzQblXz05HfAm9xJzutX7nbLMAA0Aac60iCChHcxprO7C1sUGuW8Z4LMjDDYAQHqIrrtN0dgq+lDGNM5axiNegt4F/ng4Az7umj+JP46Cj075lvKqj3NY///agdinBIH4ETQEufFKuVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 18:40:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:40:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
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
Subject: Re: [PATCH v2 2/3] selftests/mm: add check_folio_orders() helper.
Date: Mon, 11 Aug 2025 14:40:03 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <AAB35EEE-D506-4DE1-9AD6-534EAAE68EC0@nvidia.com>
In-Reply-To: <f7cbe7ee-35e2-4659-ba52-62b6b932c192@linux.ibm.com>
References: <20250808190144.797076-1-ziy@nvidia.com>
 <20250808190144.797076-3-ziy@nvidia.com>
 <f7cbe7ee-35e2-4659-ba52-62b6b932c192@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR15CA0044.namprd15.prod.outlook.com
 (2603:10b6:208:237::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 148a5356-db97-4b49-772b-08ddd9067dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWruDIdw39mvdq7quvZ9ReLmGic5Ko/W5B0fcvVh7hFGT6bQ+GvpKwiGClkq?=
 =?us-ascii?Q?fY/KYWMW7KZnNV+y8oLpqRu83tTZKiAd55O1p257ja+8C/p4lhOAE1h/lmQE?=
 =?us-ascii?Q?s+K7sUIy2XC+GRX5Eej0RyHSWUjSiyO7VLi5pBn4trdsDAvz77OR8g81HuNA?=
 =?us-ascii?Q?h8Pw1Vnzx/mpfFATkDc7EfJ/YvmFXqiyG1FBWThStzQ0u8XGT/vxmVXFqQky?=
 =?us-ascii?Q?D8IEYu+UyK4mMwW8E/zSGkuFmIoj0IXy/vMqFqDWjniNdKN15GpTDUl2BqyH?=
 =?us-ascii?Q?Qja79kSJJUZejmtH5lYUVS34As28uiqpVapQLhlXaK3ub6L/OnrRI015mwqS?=
 =?us-ascii?Q?Lntdg4nngu5q/qZrxf9Ur3S4CpP0ORD76d45byzeiq0s/5cYlnWuJp2GKRAu?=
 =?us-ascii?Q?Ohcpm4kwg2bAW+Yrsizl+9emjlBxuT5dq34kTBAcwu/TCBAh1gxYlWhO0Acx?=
 =?us-ascii?Q?SQTdSLHy8F/n6C4SNBTyR17pOG2Yz2iqyWNKNcN+cFvO/2OsITXgI8qDunJ6?=
 =?us-ascii?Q?5mQ5ZNzIHJ7CiTniQQ1p/BZRIfE+ShP5De7KMvfyOZRHpuHN0Gcfaj6usq1M?=
 =?us-ascii?Q?pwLk7zd62VA0e0wDcx7583g4L8sdFDBDuJdqRjkufg01AvQZ7DE8MOAMAoP+?=
 =?us-ascii?Q?ElEgQnVhHRbGK55IrX6A6cSmx362Kp/0sYz8nLfyxHbo20+JdkE6x1N4MXxG?=
 =?us-ascii?Q?2LjwIenOIeM1O/ybSyR59sfmBgHuEI9LDRsNf+iO5fMNReNgW+H0srIJukyi?=
 =?us-ascii?Q?nO8fFi3Pfz9AZMsJO43aRw7FdGfVvUY44mB3r/nC/cUt6JoqBQVTgUUNWDJV?=
 =?us-ascii?Q?GeUZE2SgbXRfYj7yOvJ114jH0YQ7nod9bhM5lFzC7SORwO5qxQUrFD93safH?=
 =?us-ascii?Q?1VCm3k11QeH1zXCrv9gRRYKv6PtsKF9Ljqd+BTdyEqNWgdfmYpEz4f6XTFh+?=
 =?us-ascii?Q?0NngljIzwo+/m2tOj2AFR8QRFuIrbRtVVYHkbhPFrNF87SiPLiJUKNP6wSs8?=
 =?us-ascii?Q?JepI/kgzU7lLMd8X8p2HlbOsu+0UVvJyiJDrKGQ85DPjiAlhGufdAvlt7KG3?=
 =?us-ascii?Q?FaA9E3a+MmQNfil27ZdGIQMolRJJU4jYIBlgS2A70pLJXAZitdtH9GuMxb55?=
 =?us-ascii?Q?CAO6Zr2Z8K+oopRGAo+lFSkOXOpeb3r5FAWS2On/ztgeKMrkSpooL3L+64bJ?=
 =?us-ascii?Q?pjM5tRU9AJw6gWPgFllZc68vUdker+6NqQJoeuKt1nIbCAWsYbLoad5rbCEl?=
 =?us-ascii?Q?2gryZsLG3El66ig/cF7AMXJYKMhrGqJqcH8P65uRZjUwKwue9me71g3pyQKx?=
 =?us-ascii?Q?wrx/jpPLWO7A+Oa7no5CslH8k4/1v+DejIHMhubS+F4pVQSj0GwJQ3+CNblZ?=
 =?us-ascii?Q?H/HQD/9tslpx8bNFCddbldJ1OubLAwhL526GOjbvgQfg7pYfDgtBuvxnWPPE?=
 =?us-ascii?Q?W4wkh6IdGdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZLlkGTIjkXzaYoQ261qvDGofKIKPizpXq0JDJtrA6j/VyN+wW3/Odmu18qy?=
 =?us-ascii?Q?fol4LJvbbT9RuZ3nrW8ssUqVoWwroHAOILUKN6TRVSl/+W6SgWZ80gWLM8bS?=
 =?us-ascii?Q?lBqSY1hrW39tEwAO0g9ktLsSUDCQRPmmbyrFIUkuvyztp6VUQirxfbg1+j7U?=
 =?us-ascii?Q?VDcxNeqqU/iA1oS8XZl4jquWwVVrhh1hP2BvWjVnvW+wxyiKpmbO9KI9a8kl?=
 =?us-ascii?Q?tlLBaxNvvNIr/4uQr2wxRJlXZMWUWLEe2sdMvB1hJLJNoCEOD4YVZuMAdByV?=
 =?us-ascii?Q?R4t0yTkxaM+UJqHQ2yRcSV8HgjR/TfRI6PTxYX9q344Cacb5zE7vqy+1wyfm?=
 =?us-ascii?Q?VTtTaGNVatHY89JMU032DOqBJJ3s/dm6M9+8zegpn00vSuDgkfH6kL73uWce?=
 =?us-ascii?Q?scV2VizSsfOw4Cs3YNpDT4nF0gGHNw22gw3FDIrFu+W3KUF7hkT3ftA0zeha?=
 =?us-ascii?Q?6h0IqRw00ntdePJ64ZuxKURR0O8GxFJZJE6H+hKoMTxjjQ2Hcb/IZHTC/zk0?=
 =?us-ascii?Q?bK9IA2Juob8q4HEne/PnxE5F/2BUi6gSNSr6FzI7o5hnOJNm/XVkFKFPHUAw?=
 =?us-ascii?Q?rkbXMSzR0WmqII2VpHMM1pOg6EeHjvZIXtkr5lM63hw2p5738nq7go4Q8G/k?=
 =?us-ascii?Q?zOmy9EjY4+Jrmc0ZFHhSybVRW+oYUcl3XSjeRt0pxPLZG/o6KwQwitpkdtKI?=
 =?us-ascii?Q?xI1FEHkTRaJHz33bq6Qkngl3Og38zmjQSHK/7XSmiH6auzhFoiRcM7LvRBzx?=
 =?us-ascii?Q?51mlZ+3nHkfodDDIw26Dnr5zgDONnE5vlUFWoBG8MgiOdvuKsD7ItYrtZlfM?=
 =?us-ascii?Q?pnhKapmlrI9MkGMzyDo6R4HJAMpHS8GBB4+EtlteSA54gDv6fesxzLi/+x0r?=
 =?us-ascii?Q?BnkeUPYt/JhCMNoEpZCl2ii3a+QxU8IoUGmlIM8yk52gvqzACjzg7+H+AzEZ?=
 =?us-ascii?Q?wZqEw628updSwMt9x0tqcX8QwBposSCEzmb26so/Qp3oL4EH56kkGQnAaGDq?=
 =?us-ascii?Q?M573nFBI8egBTKWjJiepLDk87cSGQ3Gh4dnUttjDmJW/hXvnIXBJsFnfJ327?=
 =?us-ascii?Q?oszdIjzqRQN217Arynl+XWqf+iYORZR5qk/b5ZWJLEcCzqXrfUB63nMWlB9n?=
 =?us-ascii?Q?HNZQCU3PKH4qACkTMOodiWKj6ovlrCSyjREOrndT2KYOCnA4+r6I3LyR00LQ?=
 =?us-ascii?Q?BTGDPw7XULpataSGqBTjTVFvi4K4b+REzccPovrTFV5oahpRH8hCsPq/IqoK?=
 =?us-ascii?Q?qpdO9DjLfx3TrCiIG9D5oe0ljkZXYZ3Bm4ECqKueDvNVjK0Ydpwahr07v+AP?=
 =?us-ascii?Q?s8tNTbc2Np3FjrpWsPs/cWuQKsuRv0xc/J4JOHJ7eQuRZx1Z3+94U2B/D2Nr?=
 =?us-ascii?Q?uA8PGnQLTJwurgyar3+tteKgWkZ/Fi5sGXAzdFx5yHNgNlK4jCrcEcdnCVqL?=
 =?us-ascii?Q?H7vJHhfl5TWgSkvFAgdsYhaCl+EXfwMGc6FOFORbbzozxnAWmh7+J++27cV/?=
 =?us-ascii?Q?GaKdIpw58YYejJJBXm7RXtkecHDvIUBTUGqLI23jm/mvvAaHaO4Be5TxtJ+Y?=
 =?us-ascii?Q?Zi6MpWFzMZ6Q6lWFvTFNMVlfJkjDDAbYoZeuUuVA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148a5356-db97-4b49-772b-08ddd9067dbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:40:06.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+Hlhe24fXQoT5pAZGtgKMnbgG/k6ydxhVg50SFp//FtJwYU3hV4RJRu85aQTTEa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

On 10 Aug 2025, at 12:49, Donet Tom wrote:

> On 8/9/25 12:31 AM, Zi Yan wrote:
>> The helper gathers an folio order statistics of folios within a virtua=
l
>> address range and checks it against a given order list. It aims to pro=
vide
>> a more precise folio order check instead of just checking the existenc=
e of
>> PMD folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       |   4 +-
>>   tools/testing/selftests/mm/vm_util.c          | 133 ++++++++++++++++=
++
>>   tools/testing/selftests/mm/vm_util.h          |   7 +
>>   3 files changed, 141 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index cb364c5670c6..5ab488fab1cd 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -34,8 +34,6 @@ uint64_t pmd_pagesize;
>>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>  -#define PFN_MASK     ((1UL<<55)-1)
>> -#define KPF_THP      (1UL<<22)
>>   #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>    int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_=
file)
>> @@ -49,7 +47,7 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, =
int kpageflags_file)
>>    		if (kpageflags_file) {
>>   			pread(kpageflags_file, &page_flags, sizeof(page_flags),
>> -				(paddr & PFN_MASK) * sizeof(page_flags));
>> +				PAGEMAP_PFN(paddr) * sizeof(page_flags));
>>    			return !!(page_flags & KPF_THP);
>>   		}
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/self=
tests/mm/vm_util.c
>> index 6a239aa413e2..41d50b74b2f6 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -338,6 +338,139 @@ int detect_hugetlb_page_sizes(size_t sizes[], in=
t max)
>>   	return count;
>>   }
>>  +static int get_page_flags(char *vaddr, int pagemap_file, int kpagefl=
ags_file,
>> +			  uint64_t *flags)
>> +{
>> +	unsigned long pfn;
>> +	size_t count;
>> +
>> +	pfn =3D pagemap_get_pfn(pagemap_file, vaddr);
>> +	/*
>> +	 * Treat non-present page as a page without any flag, so that
>> +	 * gather_folio_orders() just record the current folio order.
>> +	 */
>> +	if (pfn =3D=3D -1UL) {
>> +		*flags =3D 0;
>> +		return 0;
>> +	}
>> +
>> +	count =3D pread(kpageflags_file, flags, sizeof(*flags),
>> +		      pfn * sizeof(*flags));
>> +
>> +	if (count !=3D sizeof(*flags))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int gather_folio_orders(char *vaddr_start, size_t len,
>> +			       int pagemap_file, int kpageflags_file,
>> +			       int orders[], int nr_orders)
>> +{
>> +	uint64_t page_flags =3D 0;
>> +	int cur_order =3D -1;
>> +	char *vaddr;
>> +
>> +	if (!pagemap_file || !kpageflags_file)
>> +		return -1;
>> +	if (nr_orders <=3D 0)
>> +		return -1;
>> +
>> +	for (vaddr =3D vaddr_start; vaddr < vaddr_start + len; ) {
>> +		char *next_folio_vaddr;
>> +		int status;
>> +
>> +		if (get_page_flags(vaddr, pagemap_file, kpageflags_file, &page_flag=
s))
>> +			return -1;
>> +
>> +		/* all order-0 pages with possible false postive (non folio) */
>> +		if (!(page_flags & (KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))) {
>> +			orders[0]++;
>> +			vaddr +=3D psize();
>> +			continue;
>> +		}
>> +
>> +		/* skip non thp compound pages */
>> +		if (!(page_flags & KPF_THP)) {
>> +			vaddr +=3D psize();
>> +			continue;
>> +		}
>> +
>> +		/* vpn points to part of a THP at this point */
>> +		if (page_flags & KPF_COMPOUND_HEAD)
>> +			cur_order =3D 1;
>> +		else {
>> +			/* not a head nor a tail in a THP? */
>> +			if (!(page_flags & KPF_COMPOUND_TAIL))
>> +				return -1;
>> +			continue;
>
> If KPF_COMPOUND_TAIL is set, do we use the same vaddr, or should we adv=
ance to the next vaddr before continuing?

Yeah, I missed a vaddr +=3D psize() here. Thank you for pointing this out=
=2E

Best Regards,
Yan, Zi

