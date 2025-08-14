Return-Path: <linux-kselftest+bounces-38966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD6B267FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA4BA2305B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBA301492;
	Thu, 14 Aug 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSv2pERd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35605301023;
	Thu, 14 Aug 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178518; cv=fail; b=ECNM9z2SBRj4aDLHWIhotfXHsOFxcLYyQKvuWIV0HScBhhYi+BC2unXVApzUDsuEDFeV3XQIfk7fLdqdQd1kUjsdKIpidxJmoUGgGrr4HnaHzoETZ4Q7EZ/62eIz/A/+iPumrZcpk8oECFFckFs7tG+klzRjz4NkejteDLcx2kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178518; c=relaxed/simple;
	bh=VMAsCDZBGCwBGZJ9isV1IiK+mwlctmZD76vTiGrshwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpEkQNyd1QuzvbXTxtwaacZ2E5Fdx4lKq2V03ofL2nNxm7yYOYmtHwdAuLgp7xXmI7BXHQMdtkWbYQcC+j32SeewN4H+vhBuPlUSPvdRO2BwxHO25yv0Er0Sv61NVNHcTW1Wm3WejU3gMZAzMhZE7yBatrFNXwcgANVaciKSkBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSv2pERd; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqaGQC6FEhmv1yqTA5B9VcT0ObBhRbLqJ+SGTC+5XTPB7Ixi6M4Vln7JVfMSdL9SYiyYOLcy/f7Et0SfLjIwY1nzQSZJT+UI51xA/xW04fOgJ1OtjxiE8ymrpwaVgSwrg/ZrepQQ4kHdKiUij2HncIjqOySjtgehaGUsnHaxUxGLsWbR3g+OhCnijlO4fsJyFqum8ZAECW5tlHZyZ+WDpXKJp8HAldG8J+wV0r5HJse/LgwmWq2PwEgrih5BU9mpM0v9PtXDSwnQw5Gl71K33wubx8V52bnGSIK5yW/CfrFbBMlXArMRKFXal5PXOs6RToPPyjD8jg7HO16OzNnOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/eftZ5/GujxBBroW7lrI/FdAq99dEmCGyoiyG5nrxA=;
 b=qM0uwjL/v2ZnDzn8FmyeUV06jpbOmHfg8U9ohYf4cvqqHyDC5M9B3h+9UkF4x7n4naIIPAYrIjSLmfdofP92sMCVWJUGHEmmm5Z+wuTzFZEusYw0GjIi2BuYEpHobOxH18ndGxFT1LBgoeOg00wQWFyv93X3fYLtQhAAx9tl5dMCArMqA+avbo8EOR2GQxdaBHm1b6uJLh+XcbvsvqWVwch+pPwLRREm6H13meP3lKNnXaj3vFB/5mjiXvDCyJlA3yf09fDko+4tdZWeTZ9GgVFaALnCiHPhidB6xU2rNKbKeQ3lzZ/MCcePuVq8NNEX8iv3W3oDk3oaaBf4SeRStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/eftZ5/GujxBBroW7lrI/FdAq99dEmCGyoiyG5nrxA=;
 b=PSv2pERd3Yk1CF7Z/dww9/091JwbVNjYK33VYOauiMiWJSdPjo7D+pCBV5qY2534x+cQKfTZ6eS7GKz914T99sg2dnIg8C+f78DYpLGPVooGgoHVHhtXvfVgRqAHhlzPJFlD0wYtbvo/Kuexg5/SDe03yHdogKIJTS9nLjKz6D+NpXZZvrvXI7aOYly3pcZnObQrFL31T8ujoetmDur315GNvxgPnC+KNXbspRaZTnwek9rzlXYkgSDdk2c7/2ufrif8Xai7WtjieApOu67QwBQ1eYj+8WuXiuwddHuB2HzEfGLilt6iQLxmA/Zf7ZODbzTReYmhZ4UxiU068gS/0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Thu, 14 Aug 2025 13:35:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:35:11 +0000
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
Subject: Re: [PATCH v3 4/4] selftests/mm: check after-split folio orders in
 split_huge_page_test.
Date: Thu, 14 Aug 2025 09:35:08 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5981F8F3-9935-4570-B5CA-DD8B0FF43EDE@nvidia.com>
In-Reply-To: <20250814091647.6prozsywma7qlugm@master>
References: <20250812155512.926011-1-ziy@nvidia.com>
 <20250812155512.926011-5-ziy@nvidia.com>
 <20250814091647.6prozsywma7qlugm@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa6f11-4594-415e-c3c5-08dddb37645f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MsPHsoJkqa3VUJPgE1SS1dBxG3KLk5K5/z5avLPjNga/4/pou+xNh7r6SL+R?=
 =?us-ascii?Q?gpqkKvpu4Mdj0ymhbdxBwqnhL8j8N3Sb1LLXV9jlPr7NsOeWuDYuFsFbpWMx?=
 =?us-ascii?Q?P9ManSE00JtsExURAaXG5JtZVWVJBMMrUwuD+6yEcGCXFvN+gff4tu+xPpoJ?=
 =?us-ascii?Q?7eshEjknE3EPlz6qLbf2WLARKZyMtKUwvwujwlURQqrd3U5JGJMu5BJK8m0d?=
 =?us-ascii?Q?apOut3qGo6Sm/HiPzwncX+MxsaXPeeXlzAPRscglZfeQZ0d+5uSUZ1RCyTgE?=
 =?us-ascii?Q?ZYagUb2HIVVdNqQ5oQzPDF/QEZFDEW8JOXAF7MpxeU0sZWASkzLEtUS1fSz7?=
 =?us-ascii?Q?/hRLwbIoyi5jmclyNOfhYxY7NK7Qybp3De0veJNT/IbAdpSWjXuo1FySrmnx?=
 =?us-ascii?Q?JW4P2K5tWsIqBuJF28KGOXAf+XJSVHdTkw3MqY0NsobfkwGM3tE9RZaIXxS5?=
 =?us-ascii?Q?809AFSHL+m2jYaVpucePJO9naDdY0yKt/o598zMzDWbMR+kHBe5evNzOlamy?=
 =?us-ascii?Q?yB+z3kajt/BtJMcHMGgQSa+SOi1V2yd+VgGHJenV6PA/QM8hE/7tvLG9B782?=
 =?us-ascii?Q?gUR68IQpLT7vZDb+GxUM9uu1WSJ3rzQSWjctWKg4EEkQ//J7mCuUdibUk4A2?=
 =?us-ascii?Q?dfq7qs/ToTmhw+k77BUnMO4jWPiLS2hR3UIy066VyB8mbaQ7/tvQHP7518jy?=
 =?us-ascii?Q?4sMF1CRrQA958fSiiVkrcBw29jBVWdUqKG/WFxfrwcifjDQ8LDHWPVx+H52z?=
 =?us-ascii?Q?Rd1YSTp7VzDEuzrfpFV1t0PPe6wU37fJGPoKWCwmyJKe+RcVdKVs7PRKxYG8?=
 =?us-ascii?Q?RXMajdep+uE/wrAx6AWFvYp5JSFjk2f4MxgwXcc1ivO30g6fLpy0gW5vI43t?=
 =?us-ascii?Q?duJIhzyXSsiCZeDl2ln4UDaVdHcOHpMAtCY6lKyT0Nwle+S1W53lFcZUgA5m?=
 =?us-ascii?Q?Ste5vL4gc2dTQMvEXE+6HJxT+2Vz+Rk9KrcsyFkpSov5nckzJDf2+LV3S06b?=
 =?us-ascii?Q?uzpe82whpOPtaAj/HHCBri6veIt6YDbwgaZewOrkKgc/WsLI+jPGnYqtLHNl?=
 =?us-ascii?Q?kR1nr6SSNBBZ1eB7v96xPJ0GlDSw8fHZ5GY1+qW2tLn+hNfe7aLr24DcOXvT?=
 =?us-ascii?Q?4c2FsUMNAG7YyigoonBYYBInbKCVGP8F0jVBxQTB10+ixbHQQ9MphA2mm3lO?=
 =?us-ascii?Q?BdK3UF+XXsYvaBTb979TjaOuy4+xWOwJbcoz+ddrWxww0h9vJjUkAbNjrU6/?=
 =?us-ascii?Q?3xJ2VOMc7KM+X+FvUFE3rinS13dFBOXx277AOyRSBvCJD8tMsFu50/C3tc5O?=
 =?us-ascii?Q?cDtuH6kAJwV48iTzNa8zVVgknp1/D1QUkViGBa9FYuvQaDvUVq0GWY0nUSpX?=
 =?us-ascii?Q?eAEqrU+py0XkSan8hG6ExJg1DgANzQIbF57xvsMp6kmYRNHJAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gnbmu3uKpQHgCGwZVqw8mCzR1JBdvtPqC1nwHa6LCXbzRsHSpvIpWjukc6oj?=
 =?us-ascii?Q?Gk150hFx6IDJp9ZisDJ4gMq9AzS6bPVNqdZuq/eHtcQd7FhYJ7mSkhxmvIKB?=
 =?us-ascii?Q?WmsX5Zmm0ElxuHrClfku666mb7ommesWzxNsl4BPb7cBKvL7Oy9zBUQ3v0yz?=
 =?us-ascii?Q?PVJTacnCkjSMSBl8LCKnPfcdpNUYF6MjFptWPxBRLlyrMs3D+x9/IgGPi4Vf?=
 =?us-ascii?Q?+b6LYYLlQbzarr1dgok+o7ykOKUTkMNoV4hapcZx4NM7VQnsTXoEMHIj9R9v?=
 =?us-ascii?Q?DF5jwqj3Ch62/9CtGInaOuzejVUVpe292kUuR7n7mhAlkMKTRfk+dvfdcLcU?=
 =?us-ascii?Q?nfZRvTIpZQ/HekOEJsxpxVcfvUX0wMHGXqV8BCF7Acoo8wE96ZiZflnYCWmY?=
 =?us-ascii?Q?Ax35ueAIxAkAzoKdk2DHu0zDgam1vEUJ172VoNMrnx85v50KokrvpL8vcOek?=
 =?us-ascii?Q?0XADw/s9NXFvCzSOyJqfkYOv019oO7T0AkFhw4DgtCo7PRBwzuoJplcDbprR?=
 =?us-ascii?Q?xRnZkP4rjqCoXjnt5xwChuzKlk66SExoNBPS2BMAJl18g1UJaalegMbEvHHf?=
 =?us-ascii?Q?ZVHsoSR7ymXicUqoLKJ4nYRorJ/D8fi8to5j44TN9q4i2ZphK4OmGEDeOggZ?=
 =?us-ascii?Q?R/Qi4dFJIzuTjt0Q5rznKg3Suout3QOzn+JqrrmAJf8MYL3zsgWmIZQTp1qa?=
 =?us-ascii?Q?i6NpSDV3G2DZMfNYec9RiwhIzjMP49ksqInbaDzmEJednqMWE9fVFzTcum+F?=
 =?us-ascii?Q?FGW5hWEyJJCFIjBo3aDAMNfUpgknZOyDJU8OULLNW9igfMRLcsdfrnNWug/7?=
 =?us-ascii?Q?cgOpdGdh2UNAo+fwcg/V+4NK7YUN4+2Q/XgybsOwWoSx+Xnt7ZXSgGMlQl5+?=
 =?us-ascii?Q?vaZhw2ZBCRq/URGWAlViwAQT+mIjfg8EyyKqcqfWraoTIMr3cZz5fSE4YFot?=
 =?us-ascii?Q?7IkX5z7w7r9i0X4ZzhtmQmlRybK+V6bvZWEcme3heEpMWlPpCaykfT5sHois?=
 =?us-ascii?Q?4thtmfk+iaEAVGhHr7sG+veJ/9tymvdEGGy+7iM/KjP02r2Dk5lyuramQYMU?=
 =?us-ascii?Q?85ySQ13AfNDCo5ijIfASttip1KlmQlpvxoIQJS4Um3W31XGrViHN09ivvy2F?=
 =?us-ascii?Q?4oD2GTplWramM3RY8NrffTDex3PGKYkz416GAiraAsNi+vfPoS0JMU4NHRum?=
 =?us-ascii?Q?z0o6eyZ0cvfNeMIlAVh+yQDLozalLJGIjMpX/lq/jAQHBeEpF0yMhF+IWZX7?=
 =?us-ascii?Q?h0aDG46KJKzRqX2dJAUNhAO8V+wYPkRPBVJwfKTYjb9F+Di+QR7nSX4vFzgu?=
 =?us-ascii?Q?02d0djtP0cKgOGAWd2X+v3nHgfofBOsqS4zwBJ/rzlzygXPbsLtU6uVuXUGh?=
 =?us-ascii?Q?bjT4ftFIPAZSvMDBs7KvOxYGMX+BuNn0aW3y8yyxLEEw3hu6Ygx+waRGJwul?=
 =?us-ascii?Q?MeVHNQ/WcGhxtO7TcPOQMyaa7Brc3xFuTW83dnQ8fkgyZ+BjwslOuwiFxOrB?=
 =?us-ascii?Q?UYVhyb/qyuoWH8gk8lzG8wM309rSkMJH4010FGZOJuK0HhUYPBzZHxd+TXp9?=
 =?us-ascii?Q?h8TzfmPOckQLHWhQWhNitQLtvgYuHd23n8a3Espf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa6f11-4594-415e-c3c5-08dddb37645f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:35:11.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB6JkeWVcvxWqkNbm3RdmOYjfXGEMRJ4aUUu/++HReKCicABomulMX7o4jaLcbdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

On 14 Aug 2025, at 5:16, Wei Yang wrote:

> On Tue, Aug 12, 2025 at 11:55:12AM -0400, Zi Yan wrote:
>> Instead of just checking the existence of PMD folios before and after =
folio
>> split tests, use check_folio_orders() to check after-split folio order=
s.
>>
>> The following tests are not changed:
>> 1. split_pte_mapped_thp: the test already uses kpageflags to check;
>> 2. split_file_backed_thp: no vaddr available.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>> .../selftests/mm/split_huge_page_test.c       | 85 +++++++++++++------=

>> 1 file changed, 61 insertions(+), 24 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 3aaf783f339f..1ea2c7f22962 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -26,6 +26,7 @@ uint64_t pagesize;
>> unsigned int pageshift;
>> uint64_t pmd_pagesize;
>> unsigned int pmd_order;
>> +int *expected_orders;
>>
>> #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>> #define SMAP_PATH "/proc/self/smaps"
>> @@ -37,6 +38,11 @@ unsigned int pmd_order;
>>
>> #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>>
>> +const char *pagemap_proc =3D "/proc/self/pagemap";
>> +const char *kpageflags_proc =3D "/proc/kpageflags";
>> +int pagemap_fd;
>> +int kpageflags_fd;
>> +
>> int is_backed_by_folio(char *vaddr, int order, int pagemap_fd, int kpa=
geflags_fd)
>> {
>> 	unsigned long pfn_head;
>> @@ -49,18 +55,21 @@ int is_backed_by_folio(char *vaddr, int order, int=
 pagemap_fd, int kpageflags_fd
>>
>> 	pfn =3D pagemap_get_pfn(pagemap_fd, vaddr);
>>
>> +	/* non present page */
>> 	if (pfn =3D=3D -1UL)
>> 		return 0;
>>
>> 	if (get_pfn_flags(pfn, kpageflags_fd, &pfn_flags))
>> 		return 0;
>>
>> +	/* check for order-0 pages */
>> 	if (!order) {
>> 		if (pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD | KPF_COMPOUND_TAIL))
>> 			return 0;
>> 		return 1;
>> 	}
>>
>> +	/* non THP folio */
>> 	if (!(pfn_flags & KPF_THP))
>> 		return 0;
>>
>> @@ -69,9 +78,11 @@ int is_backed_by_folio(char *vaddr, int order, int =
pagemap_fd, int kpageflags_fd
>> 	if (get_pfn_flags(pfn_head, kpageflags_fd, &pfn_flags))
>> 		return 0;
>>
>> +	/* head PFN has no compound_head flag set */
>> 	if (!(pfn_flags & (KPF_THP | KPF_COMPOUND_HEAD)))
>> 		return 0;
>>
>> +	/* check all tail PFN flags */
>> 	for (i =3D 1; i < (1UL << order) - 1; i++) {
>> 		if (get_pfn_flags(pfn_head + i, kpageflags_fd, &pfn_flags))
>> 			return 0;
>
> The comment in is_backed_by_folio() is more proper to be in previous pa=
tch?

Oops, these should be in the prior patch.

>
>> @@ -198,6 +209,12 @@ void split_pmd_thp_to_order(int order)
>> 		if (one_page[i] !=3D (char)i)
>> 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>
>> +	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
>> +	expected_orders[order] =3D 4 << (pmd_order - order);
>> +
>> +	if (check_folio_orders(one_page, len, pagemap_fd, kpageflags_fd,
>> +			       expected_orders, (pmd_order + 1)))
>> +		ksft_exit_fail_msg("Unexpected THP split\n");
>>
>> 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>> 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>> @@ -212,22 +229,6 @@ void split_pte_mapped_thp(void)
>> 	size_t len =3D 4 * pmd_pagesize;
>> 	uint64_t thp_size;
>> 	size_t i;
>> -	const char *pagemap_template =3D "/proc/%d/pagemap";
>> -	const char *kpageflags_proc =3D "/proc/kpageflags";
>> -	char pagemap_proc[255];
>> -	int pagemap_fd;
>> -	int kpageflags_fd;
>> -
>> -	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
>> -		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno))=
;
>> -
>> -	pagemap_fd =3D open(pagemap_proc, O_RDONLY);
>> -	if (pagemap_fd =3D=3D -1)
>> -		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
>> -
>> -	kpageflags_fd =3D open(kpageflags_proc, O_RDONLY);
>> -	if (kpageflags_fd =3D=3D -1)
>> -		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
>>
>> 	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>> 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> @@ -285,8 +286,6 @@ void split_pte_mapped_thp(void)
>>
>> 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>> 	munmap(one_page, len);
>> -	close(pagemap_fd);
>> -	close(kpageflags_fd);
>> }
>>
>> void split_file_backed_thp(int order)
>> @@ -489,6 +488,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_=
size, const char *fs_loc,
>> 		int order, int offset)
>> {
>> 	int fd;
>> +	char *split_addr;
>> 	char *addr;
>> 	size_t i;
>> 	char testfile[INPUT_MAX];
>> @@ -502,14 +502,27 @@ void split_thp_in_pagecache_to_order_at(size_t f=
d_size, const char *fs_loc,
>> 	err =3D create_pagecache_thp_and_fd(testfile, fd_size, &fd, &addr);
>> 	if (err)
>> 		return;
>> +
>> 	err =3D 0;
>>
>> -	if (offset =3D=3D -1)
>> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>> -			      (uint64_t)addr + fd_size, order);
>> -	else
>> -		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>> -			      (uint64_t)addr + fd_size, order, offset);
>> +	memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
>
> I am not familiar with split, you change it to split on each pmd_pagesi=
ze from
> 4 pmd_pagesize. Is there any difference?
>
>> +	if (offset =3D=3D -1) {
>> +		for (split_addr =3D addr; split_addr < addr + fd_size; split_addr +=
=3D pmd_pagesize)
>> +			write_debugfs(PID_FMT, getpid(), (uint64_t)split_addr,
>> +				      (uint64_t)split_addr + pagesize, order);
>
>                                                 ^--- here should be vad=
dr_end
>
> Curious why not (uint64_t)split_addr + pmd_pagesize?

It is in V1->V2 changelog. split_huge_pages_pid() always step in PAGESIZE=

to be able to split mremapped PTE-mapped THPs. Using [addr, addr + fd_siz=
e)
makes the PMD THP be split multiple times. The goal of this test is to
check the result of one non-uniform split,
so use [split_addr, split_addr + pagesize) to achieve that.

I will add the above to commit message and a comment here.

>
>> +
>> +		expected_orders[order] =3D fd_size / (pagesize << order);
>> +	} else {
>> +		int times =3D fd_size / pmd_pagesize;
>> +
>> +		for (split_addr =3D addr; split_addr < addr + fd_size; split_addr +=
=3D pmd_pagesize)
>> +			write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)split_addr,
>> +				      (uint64_t)split_addr + pagesize, order, offset);
>
> As above.
>

See above.

--
Best Regards,
Yan, Zi

