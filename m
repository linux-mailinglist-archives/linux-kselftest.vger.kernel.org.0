Return-Path: <linux-kselftest+bounces-26745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48713A374AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 15:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096EA16B414
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727F18DB18;
	Sun, 16 Feb 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/MbeO5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532E2E64A;
	Sun, 16 Feb 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739715444; cv=fail; b=FdzXkmSbntnu9CZYKqAu4HU33PBJ8wmv7Cu8eUfwnT9eivFqhTXX9R8se2Q2H6CbhZWKVIpThqYb7827p+NNKAieCEyY/9W4wO0/HH2ew3xkb4txLlmoJAYHgjSw4KOj8xu2yHmRQoKJXQUsgVRyTKbql+RlaCHaZOSn/JKMLXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739715444; c=relaxed/simple;
	bh=B5WAoKuJAO/o/W0U1fKVGm8g1cpBWLuDz2Xy7vwFO1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEeJbfRpm/QNulECsAidyIRVXqQMZLR6RBVdbeLwOBSWUgbw5RoKlN3CwhMErl6a1gZLH1N4zG17iyLejCEc3Psb6I+2tjeOB3IT5noTU7+QAvJR5sxd3+uMI7qCxUCbQf+Knwrz31n+1HkGiieHdWt/1MnK1AxsDKbIJIZ6WcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/MbeO5t; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy6sJnTsPFStqhEaPrHVbKZo8jmoNeVM+a7QQG3zY+C/K31XNjbj+IL47IxOxqAl08fhidtyTZJT+fEPaaFQi2PDB1SULOpFV6e40iBp5ssgWDfCHTbwLCS+MlvUqwvDphJkq9i7jfiJ8+t+jin0BVnjhstuhB2oU4O5UtnQP9UVY0qWsXaxhNsS7IkkgRJxjyPXbd4XE0VSbAoM5QT7UdM873tqai0ZrRAkOsIIxrPedtMLXoiYQRpNAdW4skFVilrINkXjiZL7OrnChXHS5BIcDpZQxhYls2UPk6NRcoTY3PUFZi2eh85DZQl08C/nGb/8Fl1YpnrcgLu+YuWNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rdk6KOdowAxoYgHmxqFi58UPIPJpHV2RePrCiOmXthA=;
 b=c7zgSHb2Bh8Irn+2J+dLK73M0dwg4jCsp5JabkFGxUE/MP4LByrz1S5IYT1Zb5PNYDVezODvfOz1x7s3cK3dzVh2/UW8ZvuGd7QzhZ5JStjXnvGLs69eG5/shKEtT3/5wIU7+AQwlaLO33gmIManrtbQwAnLxjdkut9XNtDYJeYKjeCm6pS73XOGlX8mYJueJXPwEBhZiFJ9k2ia6AFM0lJwoPmuP4QW9FOilwaQT6XGiMHq5xdbKgyfrGDVh7bL0U+dU7NR1fkox29WKO4OWpOt6our1KjMBodoQmUsjaIcdeBp2c2xQrr53/x6j3H/JopbiJTM+YqcJjzyzF1dEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rdk6KOdowAxoYgHmxqFi58UPIPJpHV2RePrCiOmXthA=;
 b=I/MbeO5tgZ7LKLsaO1YYKYiQhaCvq4jtr4rbvOH+SPjHnDrpjigQ+Rk/dC8dEjSlmwmp+3dBJLUgPLUh2nwRHCDN+Jkjir1dK0f8aYb3XQD3UAB+Rwo2KxomUGK8g9Jq0lAdrmlw/ByQ5VYJG+UM9X5x5/l+gCyw0kNEc5eIKx9zBrve+R6VOA8z8xheP65Ogai/6nXjvo6FBW1oobhCT1/5IF2pom7k44UJWIZ+oVbjBnKKfgRXlASKLrMXeQPPsmn1owXuxIP6hrEGSIO4MuWA8MjRnFD+6OtLmboijtYGvHCnYi2EYy6hJ0wn9hXlsODu1hl+nYJBiZ1RN0oZNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 14:17:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 14:17:17 +0000
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
Subject: Re: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like
 (non-uniform) folio_split()
Date: Sun, 16 Feb 2025 09:17:14 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <4483B46A-FEAF-46D9-AFF4-F0DF34864633@nvidia.com>
In-Reply-To: <f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-5-ziy@nvidia.com>
 <f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 1969640b-2a41-4888-2392-08dd4e949e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35Suxc7Hc7JWYDm98gsnDexfOBvp0odwLKUOxlRDTy2kL6oemIhYbtJyqMCh?=
 =?us-ascii?Q?IiuDIepCFLBYioIjDkbCL38wFMkdiGkyG15OdAqFGtG/Iw93SHX9Ue/Brlqq?=
 =?us-ascii?Q?O36wNiAyQgAufNN1vtHSqGEujhT7t0tjLzXiFdWJKLbyu5wNiO2MQmnFJ7b/?=
 =?us-ascii?Q?opF6z8jfcOJhqZAMzK2iNPid40h9ZQ4KX3Ntv+GR4/9zrCJzCAOkYwZrfVnx?=
 =?us-ascii?Q?jQH95TdgCpLChXa/eRR9PR3POMeTsIN2L6X7zdGdOx9D1qP7DUZbt1DFSXir?=
 =?us-ascii?Q?S6NsIYj+1he0UZqpgFgMNjhC6YFVuXeqmjvEHJK6aHC2btHhKNrHRU4Rip5H?=
 =?us-ascii?Q?AWoQSjca0S695r/4y5XFIvJUQMulBmtClBZ7SmOqwFFMwVne/OSjinjYwLv1?=
 =?us-ascii?Q?+rUYK6MhSbkfA6f59QPDkZAC+dcV+ZiAz/ciBpEbPhpcaYai0GLGGDU7iCho?=
 =?us-ascii?Q?24usbgiq+QSguv4zYMaUz2p8ZZ52GJsdWBu97oD/XfKcfPoVYLDT7EUDewZD?=
 =?us-ascii?Q?29KZLZ4aL95r0K2SDSoWNyL50XF0sUJaFvslq6tgls2edMXEaCona66P4++e?=
 =?us-ascii?Q?3JNAdQ7YYObJS3LfRcvArxkteFAs7ld8YZq5nYi6cYZZsPlRntDRai9y9Q6X?=
 =?us-ascii?Q?mRpWep6+u86FJrmTMtKKNnUoeLiEKpk2dzcgsIrRlQqkp+ZPDeU8XzjPG4Ac?=
 =?us-ascii?Q?hvo4QA29Lhsjo6IUl9sWJs/WLfF6FA+dyGS2stRYzAP6l0cN74aiOULMQwzJ?=
 =?us-ascii?Q?iJkphOuxlusOAPSXf+eapa9z8ZIWoSmRaw+k4ikMBunZXDyF1Xbd4x03zaG6?=
 =?us-ascii?Q?P0L882jhsUKohl6etpYZDLc5tPYNnoKTMzC56vUsWH2XzCcWKDihSntCsACz?=
 =?us-ascii?Q?MGJf6+h3QhHy1yJhrZqelS/IjbILuURRHN9symVVtlmvNH70HsDFsd/OfIu1?=
 =?us-ascii?Q?C68TKCyTJM9iz/erbhsPLvKTFy8iDxxN9KxDxiyJUNU4sIywi2x6cfdRlwQg?=
 =?us-ascii?Q?I98LErd6wzir5bue0yzpPKoRW3YlgQQjOvW0wn2789HldyBs+paYgJVxVV3r?=
 =?us-ascii?Q?HEx5LRUB4o+Uk4N3wqWJ2h//DSkpdfDyHYt9RdHnHNUHjrqT7U9ZgRVP1+FU?=
 =?us-ascii?Q?Shu0fHLkRINuvsCuILMhZ/puYC5VJGsXbGKGog1FtqKPqJdj+yPd2itLMdYK?=
 =?us-ascii?Q?U4JYRoJYpmpxogWqXDkx+65dJMMajKSOC0srlwgJNM8IKFLWXZZ40qbeq1MW?=
 =?us-ascii?Q?ePt33b0YNDnnYpNZTAi0xL57zBqnPujYpx2OPqVQD3yVbavGdH6l8S1X6gvd?=
 =?us-ascii?Q?J4l956GkYDHEzD2lCA0bDMaIwU7ZjQpDmhBPFcLKspfsUoIiGQw/0dXkp67E?=
 =?us-ascii?Q?ovdJ+Vgc8Lpfk4x9lHLG0R7AVyx1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HBXFYW+433Mdwn+Q6jGuItvJpL0qbYtsDyW7F67Nfx0yHZAfa/olhV04QnSW?=
 =?us-ascii?Q?QlGnn3PQwxH9NHc98pUtQlsNsdfBw4APSxtZRWzqt2/49c6FR48nLe8d1ziE?=
 =?us-ascii?Q?T3My6yPsv7y3hfoU2IYIP+wrnT6m2O8v81LwyO0QAbLT0J11mMyuOsCqgdcx?=
 =?us-ascii?Q?ygqqtuFlwFxPh4m5LdWyPs2K3N2gV/5DpsKANNMVmoQmtVmUJdlQAjXYrDsI?=
 =?us-ascii?Q?8bKPlFuK58RXkr7GlUWa2T8WTgx2YqFzvig3fSc6oumQQvfyv7Dlh3lVch+m?=
 =?us-ascii?Q?8gUtNAEZkCMV7b8WzrvBwut8ha6HGBQYvPjGNRTQlSRQW6hgHGAX822Vgaas?=
 =?us-ascii?Q?s9G677VeDuGGk2o4MjhrGmdZImojL/NJt0a3RL5rnCIHsQdNvOQHQtVOODIx?=
 =?us-ascii?Q?NeNVhxRk7UAv/CmJr3ZoJhNEmy9H3x/2qUNfVtAF5lLkUB+6dc8iFR3bdED/?=
 =?us-ascii?Q?HnMgq1HKBzLxynaFUCTl4jgWuLbO3MNniNp7nvG+CGgd7ESfnjv75KYh67FR?=
 =?us-ascii?Q?FUNX/6IsAkStlmi1wY9adSGBJ8sA4hh09Hzs10AEQI2EXb+L2M7HwiYarnmF?=
 =?us-ascii?Q?1EWIQpBpeZdrTe/ECy/X7ewyg4jiMz9MSSkFGUwVOy2oq0hHvayhUy10Oh13?=
 =?us-ascii?Q?8fxNqoluwXZJiHXr2sDWXZfZswy8KVzRodwJoF3LNAPZRRZEaknwRUfdpvIi?=
 =?us-ascii?Q?xIFFRLsWY3YyK6mHmRoXAz8/XcGHgtiwDZ5133SSkoBWROkhG0Jtqg4UjvRT?=
 =?us-ascii?Q?ABWrqVzNWw+Ae4z04cmVPlN3RfaA9KPdS/ZeAoHiZWD4o2/mXVUTylex2XLm?=
 =?us-ascii?Q?dK4dsqwU4hTn7dN2nSaQ2R45c9VaepZ1rfhVi/H8+WpOStbVsrBn6vAAIkkd?=
 =?us-ascii?Q?AxALwOpto2BGq2bvgrQzSPQrw9k6zdMtiukEkukyI4NOwZZsZku7yxEQEnWO?=
 =?us-ascii?Q?HbGKqIk9VHqslYdju29X3V8RfCJiOltPCge1Wl/B+9IE+KHjS7NTKnBsrcv+?=
 =?us-ascii?Q?drsy+KBzU//fEe8h0vfmavWAMOOqPvkb9wTpsTTjw5FcW34PSAg19B88qMLx?=
 =?us-ascii?Q?EbviiTZINmgWtmBWeoLJLG+20e/V7BgncjUCeFBurWMzazJ1gaB5pKcyO+gq?=
 =?us-ascii?Q?0Qcu492MMAzu4lmU1828hbYozajlaPjWGYvb3f6gxY3U+oGnu6bN6FoC3qme?=
 =?us-ascii?Q?WsgT8neagqKJD1L0eXSPhuC01vgYMFNfp+Qp/dcCGGyx56HAYyx8aHA5XJ2B?=
 =?us-ascii?Q?uHjQnykL/GKvTN4ntKgfePhdkEU6bO+QZ37rMKfAX90Dbhc8wUBbEaFld+js?=
 =?us-ascii?Q?PJwub+YB/iSqDjgpIOa0OSIbG5j2N7HGOzBfTIt9QR9a5F/r2OBRZ9blPwy8?=
 =?us-ascii?Q?GEb4IndFkV1L5OERow0vrp8zk22j4YMT+ha9lQ8S6u/IDWvGXWxG9veOSlL0?=
 =?us-ascii?Q?cAjA0s/EShia4lFTkxhxxy2z/jJUwNogguPAmh7AAxluUZfaxuF6H0dOvr+s?=
 =?us-ascii?Q?QMPkDh38IYJM/LryMQM+IPDt5s5SouWUAWfKa996agJThzCPYAphlO6G1rvn?=
 =?us-ascii?Q?+/oV/UWIJuKT4JeBr3Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1969640b-2a41-4888-2392-08dd4e949e01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 14:17:17.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFl9WXyEMFTt2KGnIo2K/ywo2P7Ifo8I6Im6gxy/fTZd1QLKMGOkbC21I+NofX3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8

On 16 Feb 2025, at 5:32, David Hildenbrand wrote:

> On 11.02.25 16:50, Zi Yan wrote:
>> folio_split() splits a large folio in the same way as buddy allocator
>> splits a large free page for allocation. The purpose is to minimize th=
e
>> number of folios after the split. For example, if user wants to free t=
he
>> 3rd subpage in a order-9 folio, folio_split() will split the order-9 f=
olio
>> as:
>> O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
>> since anon folio does not support order-1 yet.
>> -----------------------------------------------------------------
>> |   |   |   |   |     |   |       |                             |
>> |O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
>> |   |   |   |   |     |   |       |                             |
>> -----------------------------------------------------------------
>>
>> O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecac=
he
>> ---------------------------------------------------------------
>> |     |   |   |     |   |       |                             |
>> | O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
>> |     |   |   |     |   |       |                             |
>> ---------------------------------------------------------------
>>
>> It generates fewer folios (i.e., 11 or 10) than existing page split
>> approach, which splits the order-9 to 512 order-0 folios. It also redu=
ces
>> the number of new xa_node needed during a pagecache folio split from
>> 8 to 1, potentially decreasing the folio split failure rate due to mem=
ory
>> constraints.
>>
>> folio_split() and existing split_huge_page_to_list_to_order() share
>> the folio unmapping and remapping code in __folio_split() and the comm=
on
>> backend split code in __split_unmapped_folio() using
>> uniform_split variable to distinguish their operations.
>>
>> uniform_split_supported() and non_uniform_split_supported() are added
>> to factor out check code and will be used outside __folio_split() in t=
he
>> following commit.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c | 137 ++++++++++++++++++++++++++++++++++-----------=
--
>>   1 file changed, 100 insertions(+), 37 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 21ebe2dec5a4..400dfe8a6e60 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3853,12 +3853,68 @@ static int __split_unmapped_folio(struct folio=
 *folio, int new_order,
>>   	return ret;
>>   }
>>  +static bool non_uniform_split_supported(struct folio *folio, unsigne=
d int new_order,
>> +		bool warns)
>> +{
>> +	/* order-1 is not supported for anonymous THP. */
>> +	if (folio_test_anon(folio) && new_order =3D=3D 1) {
>> +		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
>> +		return false;
>> +	}
>> +
>> +	/*
>> +	 * No split if the file system does not support large folio.
>> +	 * Note that we might still have THPs in such mappings due to
>> +	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
>> +	 * does not actually support large folios properly.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> +	    !mapping_large_folio_support(folio->mapping)) {
>
> In this (and a similar case below), you need
>
> if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>     !folio_test_anon(folio) &&
>     !mapping_large_folio_support(folio->mapping)) {
>
> Otherwise mapping_large_folio_support() is unhappy:
>

Thanks. The patch below should fix it.

I am going to send V8, since
1. there have been 4 fixes so far for V7, a new series would help people
review;

2.  based on the discussion with you in THP cabal meeting, to
convert split_huge_page*() to use __folio_split(), the current
__folio_split() interface becomes awkward. Two changes are needed:
   a) use in folio offset instead of struct page, since even in
     truncate_inode_partial_folio() I needed to convert in folio offset
     struct page to use my current interface;
   b) split_huge_page*()'s caller might hold the page lock at a non-head
     page, so an additional keep_lock_at_in_folio_offset is needed
     to indicate which after-split folio should be kept locked after
     split is done.


=46rom 8b2aa5432c8d726a1fb6ce74c971365650da9370 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Sun, 16 Feb 2025 09:01:29 -0500
Subject: [PATCH] mm/huge_memory: check folio_test_anon() before
 mapping_large_folio_support()

Otherwise mapping_large_folio_support() complains.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 87cb62c81bf3..deb16fe662c4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3629,20 +3629,19 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
 bool non_uniform_split_supported(struct folio *folio, unsigned int new_o=
rder,
 		bool warns)
 {
-	/* order-1 is not supported for anonymous THP. */
-	if (folio_test_anon(folio) && new_order =3D=3D 1) {
-		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
-		return false;
-	}
-
-	/*
-	 * No split if the file system does not support large folio.
-	 * Note that we might still have THPs in such mappings due to
-	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-	 * does not actually support large folios properly.
-	 */
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	if (folio_test_anon(folio)) {
+		/* order-1 is not supported for anonymous THP. */
+		VM_WARN_ONCE(warns && new_order =3D=3D 1,
+				"Cannot split to order-1 folio");
+		return new_order !=3D 1;
+	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 	    !mapping_large_folio_support(folio->mapping)) {
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
 		VM_WARN_ONCE(warns,
 			"Cannot split file folio to non-0 order");
 		return false;
@@ -3662,24 +3661,25 @@ bool non_uniform_split_supported(struct folio *fo=
lio, unsigned int new_order,
 bool uniform_split_supported(struct folio *folio, unsigned int new_order=
,
 		bool warns)
 {
-	if (folio_test_anon(folio) && new_order =3D=3D 1) {
-		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
-		return false;
-	}
-
-	if (new_order) {
+	if (folio_test_anon(folio)) {
+		VM_WARN_ONCE(warns && new_order =3D=3D 1,
+				"Cannot split to order-1 folio");
+		return new_order !=3D 1;
+	} else  if (new_order) {
 		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 		    !mapping_large_folio_support(folio->mapping)) {
 			VM_WARN_ONCE(warns,
 				"Cannot split file folio to non-0 order");
 			return false;
 		}
-		if (folio_test_swapcache(folio)) {
-			VM_WARN_ONCE(warns,
-				"Cannot split swapcache folio to non-0 order");
-			return false;
-		}
 	}
+
+	if (new_order && folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
 	return true;
 }

-- =

2.47.2



--
Best Regards,
Yan, Zi

