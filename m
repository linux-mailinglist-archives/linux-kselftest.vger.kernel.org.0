Return-Path: <linux-kselftest+bounces-32048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A89AA5590
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96DD188AD01
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC438299528;
	Wed, 30 Apr 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhO/nZtX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA32983FE;
	Wed, 30 Apr 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045267; cv=fail; b=d3vqXiNa+C62Xkg5kfsNTtIRtCmUDJT+9RBeOR+bAvj24c6S/3mIGejA7P5dQ/T8xc2NI9WfZ2+helybV45S4Nara8l6mchmbLWZezjpzTBR2Y+XLQRlTLdytzF3lsnjHXrfnT1aYVk20GrFQ7QCQH+yW2VCkCjDuVLOMjg0wTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045267; c=relaxed/simple;
	bh=ZHXYwUqV3f0Rtw8ob42+K7DXnVgukJxX8BEBgUpAPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYkOvOOJ02muYgp0sxqTxP6X7fcHL3Nii8rqoVtJvR2WVrol5ZW7JgYmhSS7vyluF5dhlBAjmXTCC1YwGDtHooNFh/3t+LpvujHOc02UFa+lDgXW0b9sMD/KABJAXtJfVAAosCQvIb/j9ODqQK5U2wy1/LNIx3bqffTIxD/i4vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhO/nZtX; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlCEVRBEsI1eLUCy6YKJaSjI1T9kxh6aLY0rip+qlttjVKy7PxXOSSNoEOzO9VhgAXbArX5yySW2jMIkCf7jgq+S67uY8sEjHYnhDshCnUyw0Bqv0UYfvQv/fnYVqHmxlj4SFzrzOGffccnBKPEi2ODg98y8+L0nGqncJzyODC1J+DHMeQe57fdMCsFlhEiEKZVA/Eb6qznjj0vzpfSNyFkhNfm5WqsB+8EMMnwhwBjTTfqzrvPudrU2CQ85U5sQIRZyOi/PqnuhZC3YXTguu37BISJVQrTbbnFqOr7Pd4mM1Ku6A8tU1AeYOaKVToy+dVhwt5CfAcr111Ul7SF6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoop7X2cmMyaPxGcHGL/Tl+8aC6ArXcmKaYk5qrjmvw=;
 b=Zu3vb2fbG1MST15SDY5HeapF9Dt6/lYiE+UPEB2LYISvldeTwk0I+KPQImZc4J8ATS58UQE0Reb5N6a/8EOtLrA5Q09w5vPMFR1hEGFe+Gm3EjPlG+OdK4LU0X33fK1Pun++FXLAU1+eSn30nruc1TQ+z9/lI1JHRmP+DB+qjw25D2Jy2FtMNKe/Novhl7ZuxvzJ1wtbBaJf1vLpzJLN7GHXe66fkTlTrnWvRc36GZ3t4NuD+MmpnJpegz0mAOpAvZTKO9WBEXUMsT9hAdQkhGa/sf9AbJ49eXb0ecOBm58jEaIi3Kubr4qx3xD3WYrGrOFmlSSkNqfx9C/hIxpqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoop7X2cmMyaPxGcHGL/Tl+8aC6ArXcmKaYk5qrjmvw=;
 b=qhO/nZtXmIhT2VGrdqHAddbRpiL01JMmkUumvb5LI5Y2P8CPcD5N9xL77Q11Huw5Eh51+VzZoZWK0DdKPkPMPBKeJotHoixQ5h/vZMJqxOhiwN4OrXHenIWfC8zQaVS5G9meW/WPRHy2ovfh3jfWUGQcUwSgBrCIRjQyws+Or0eUCUgShHpidCUhgWWOU8zsTUBpvX9pzsyOPjKE5eShqoTMu/uDPosZRIAyL1zZOIHUIEFAWBG9C4OR9H2783XTcLEyqdqP9khjAjIAvizjJbkQ3elJgDzxvHVqALVj71BBQMwWciaMcp/T6IcY3P3W/46FJ78596me9PlDrMJ5tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 30 Apr
 2025 20:34:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 20:34:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, shuah@kernel.org,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, hannes@cmpxchg.org,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 3/4] khugepaged: add defer option to mTHP options
Date: Wed, 30 Apr 2025 16:34:18 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <BE08D7F9-716B-4EE8-AC4E-2D9F4C5D4A05@nvidia.com>
In-Reply-To: <20250428182904.93989-4-npache@redhat.com>
References: <20250428182904.93989-1-npache@redhat.com>
 <20250428182904.93989-4-npache@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6744a7-b748-4dd6-028d-08dd88266382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6YXTdCW1iY1NH9b4wokXRKf0cvxq+U2HepG7gQjZT7pljOHx4bZZTpCi7JD?=
 =?us-ascii?Q?2FdBw7hjH1EBvXUKfY/msoWcPxmJcFH/W9iUojzU2Wj28Y5g6CMEfn/53n8H?=
 =?us-ascii?Q?wbbFsiD0ofR9m9Rj3MUgzgpnox+UMMN6JJGs5IGgDG5XhBzHNJkmXQSGqGZw?=
 =?us-ascii?Q?uLx9SV22J0wGmp3A5Isk4iyqn+zzIkBneStbBXepr/7agWpHc1o/ysA3Q9Yz?=
 =?us-ascii?Q?x/s76WBd7v+NHXikUsuKOa/yrxm6cpom185Y/DOMp1zfIQj5ZAWA4OQxQ71D?=
 =?us-ascii?Q?JB6StfCPbx/dbCDDDG5Uerq+QGGhEN1bm7kCgIuy4QTOSU4Y/wqTUXJqHXzV?=
 =?us-ascii?Q?0Q/pv2Cq3J89LRH2uIM1yF9hzRcbeZowmGJJIMe4x3h5RcEpeO1TWj7niIZT?=
 =?us-ascii?Q?dfjQBNv9b7xelJcWWBcZq7wo7XpQUm69DxjXE255VitfJbi2o4acLYfkxcu8?=
 =?us-ascii?Q?t7qtZBPt6Ug/aaurHnbbEe1TSlizfLN9ssTLBozV5q9khyzM1PggiOW791gR?=
 =?us-ascii?Q?lHPXIwyIuiLt1uDOAV7y+fXtMb2ExcgKqlbBWA63/9GL0X7gJSbdzq/3dWLi?=
 =?us-ascii?Q?EWQfbKndrpmI9OiRZRq48eUcHlhhsxqPkfkgaDcHzllurquFD7NE9YRcuKKT?=
 =?us-ascii?Q?uoQlH0zmJ8B4K8T7r+QkiDhsmbNiXxhTd4l6l3R9iVklqQKR8gjM2BcuOw+M?=
 =?us-ascii?Q?6PXdO+FLsEYlu+TRkKJsCs5IfwyfnZF8+VsiW1hXphyGSJanMedIyHmxpBJq?=
 =?us-ascii?Q?QLpSVYFIAZodblDqMIS7UGFE8Hhxb5zIpY/dhwKjyunIm6L55AU1fnk+BI97?=
 =?us-ascii?Q?5Qi02yt3/zYfCU3unukPzlthQ3K+CkyYf9vrWcAs4iYAY89cVx9QqC+OykrP?=
 =?us-ascii?Q?MzdnOUf6B9pSbOOr/vanlIq1MajMfHSjMbJB4p26paYSF199oXkPGlekVvGd?=
 =?us-ascii?Q?IHy1DQ1WiVPOLgqSJSPSezGxhmymrNWJG6APIoF7TJnqpBPDxmhMvES6dhig?=
 =?us-ascii?Q?2kp+one1/KRHVy4Sx5KP07CKPctlQ2MaU0yLhD2VtiJ9lId4/6CmO0t+xjVp?=
 =?us-ascii?Q?5rbkhY2dReLMkbIcZSoBSWby13UG9yllMACkdgr7gxedXAYgLeTGV19BuyVI?=
 =?us-ascii?Q?crP9t+tsq9qbchIDkx1iNaObiywTV0HXBQ5fsQ8G+LB+CpVhHazDnYu06Dqc?=
 =?us-ascii?Q?z6E6NNnC2vmC1Nuf5gznOH7wXIxxG8JCRVhV9L59v7B45c6jLoQSYQy5uqC7?=
 =?us-ascii?Q?swQ4Q3pV2qJhoWYGwHZXZPjEmth1Jsr+Og/hbrdpOo3JsilkgrBmUS0hmx5z?=
 =?us-ascii?Q?ZoSGqFiqfHrThaUzuKFTCE2AuFXEF2ZONsEWk2+7yVMWgr7iVwjamlfkvwfJ?=
 =?us-ascii?Q?HQAkrgjvCoMuCvn4qlldUH76nlUTqGXB7s7ch41Rjm6AnVQjTxPlVcKKTlsl?=
 =?us-ascii?Q?mh4WX42RviI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WO+G6PKnaPN/wgspLN1P4f3eo86Tasnj0mbPocb3YJ03d0zk/AZmri3/NgUh?=
 =?us-ascii?Q?L++zHcAy6epRfF+2E5PtZozoXTedouxx3wK3DLTtXvtZRaOGzmKMZntUVoKV?=
 =?us-ascii?Q?L84WSKvgoUAGZZtElFIa6H3hMcq0f6BmqTTbkHHfBCXdKbEj5hIl6pQ7w+Qm?=
 =?us-ascii?Q?++xnG1kT4zp3hjaPde+A0MsOyxzODQMKdyB8KWOtS8lD1IeOJ+W0iLZyWWf5?=
 =?us-ascii?Q?NB2HQK8Hgi6IadKTQSMTM3SHoFgDhgkDsS9sNr2Yfv3HQSBdnIYHtAaojm7t?=
 =?us-ascii?Q?m67+STNOcsbUrWqoSSaG0B8a2y5HICHiQC6g+z/vS0VA0l9qwTxDiyP476J+?=
 =?us-ascii?Q?pBrEV+2wahl5dUG25xw3TuQ5JmkmqxBsarAl1yHYvDFz5sXrLKRaNtvUFKPz?=
 =?us-ascii?Q?FXkHLIUrT9TzkkAU0+JQaiv1PYAjT1LrN1yKMG3Lgmw+ny+CQx3YGEtRiLUa?=
 =?us-ascii?Q?xrY/q6w5hQ3xow1MAnBqIC96kyxAvxgsgY2Q/FNuLt6mesZ15Hdeu2AZvcGW?=
 =?us-ascii?Q?P67RYwcTZ0ar2ChwawGjibD5vJJCzsHCW0ow/GR296BsyG5DWSwfu6elyAJ6?=
 =?us-ascii?Q?o2Fg+hnO58XxRkX3tIhdw7qB/vlRt+tKewug3iujtCiP5auYRfhdMst6RRJY?=
 =?us-ascii?Q?5KiMP5t1WY1/y3bzhd54VGCGSCh5QipeamXl7EUIdavLvlxZ2hOmlc5eYCV7?=
 =?us-ascii?Q?eiIJ1Q4/WhnvskEqGNY5FbywsWtnVnEpyk6aRVdK4Ojdb8fomOjefaq+jdnx?=
 =?us-ascii?Q?N+yEWXocNt8AXZjjh3F4470+Tjcw5/E5F6ssG0KD1WZ2ZHQqN88SdJT5UG8M?=
 =?us-ascii?Q?dHb9zSbkVqNZIrH4J/iFwBjQOpnmsz0Wwgn+UYqTbbxhfr6k3IauKoSfX406?=
 =?us-ascii?Q?3dUEbK127zD0XVEYS9SqwpRW6tn9A8/t3s+wMWCKBEOWR1Rm5X+2f3ZTUzUA?=
 =?us-ascii?Q?zTF+PXx79irb/OOwcD0Q6ZeTLYYKh+BKi+WhezZod1CnnWR8qidzej2UsGNU?=
 =?us-ascii?Q?2CLxziw/J0R5uRlpCIkUy7fAZvVO0T5DCe75h7p9AmaS6k1hMosEdvJMhhsL?=
 =?us-ascii?Q?5nCVhVo8zmDLs9ClriPr7LAmggAfNqCC88dB6W4kuGpzejHj45vwS2JyCRmw?=
 =?us-ascii?Q?n7SqkhseCFOC/BJPpPhL9zHbG4irRg70TnB5KNF8TWsxclFD+0eyxK+9zZrf?=
 =?us-ascii?Q?34q2Yg0EkS95K+JiPrIrvYKOTIezPwKOdXmoyQuS1CF6UUXz8FuV5y7W9G1C?=
 =?us-ascii?Q?qvIGeGa1/lYosbg/4/vIp0CRaxDOFlZyzdlEEEyLo7qk78Ei0HW2SzusBsO9?=
 =?us-ascii?Q?TtfpTMM9JWZ7gtlqooUH43xyMqU6boD8VXL5jFjnPQ24GYJbTEQQIeZW/O3D?=
 =?us-ascii?Q?fzkspkkDhq9AY9qnVcq4WvQGKFzoRsBC6XLJSGvbrkRher0PyRm8+iqapyaN?=
 =?us-ascii?Q?e5oTXKPisey9ueygDXuBxNZDyNM4sh4BXlslo+Q7/lTJqkdtyfbqmAV6jvQN?=
 =?us-ascii?Q?SMIT/tw1C5nXQl1CcFMtOA8BQ7HAC+N6PLxMWjQwXB29Q8jJmJ0sOC7vAgso?=
 =?us-ascii?Q?HNS4Ys1j70d2WaL3XzJ5ir2P1nf7cj30r7xXNmDY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6744a7-b748-4dd6-028d-08dd88266382
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:34:21.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRaD+unTTg9mXkPBSfY3rAP9raxwA1Y3qCqG4ZIMYI2LY407ONqXgFIB9C0S8pga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C

On 28 Apr 2025, at 14:29, Nico Pache wrote:

> Now that we have defer to globally disable THPs at fault time, lets add=

> a defer setting to the mTHP options. This will allow khugepaged to
> operate at that order, while avoiding it at PF time.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/huge_mm.h |  5 +++++
>  mm/huge_memory.c        | 38 +++++++++++++++++++++++++++++++++-----
>  mm/khugepaged.c         |  8 ++++----
>  3 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 57e6c962afb1..a877c59bea67 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -96,6 +96,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_at=
tr;
>  #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
>  #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
>  #define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
> +#define TVA_IN_KHUGEPAGE	((1 << 2) | (1 << 3)) /* Khugepaged defer sup=
port */

Why is TVA_IN_KHUGEPAGE a superset of TVA_ENFORCE_SYSFS? Because khugepag=
ed
also obeys sysfs configuration?

I wonder if explicitly coding the behavior is better. For example,
in __thp_vma_allowable_orders(), enforce_sysfs =3D tva_flags & (TVA_ENFOR=
CE_SYSFS | TVA_IN_KHUGEPAGE).

>
>  #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
>  	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
> @@ -182,6 +183,7 @@ extern unsigned long transparent_hugepage_flags;
>  extern unsigned long huge_anon_orders_always;
>  extern unsigned long huge_anon_orders_madvise;
>  extern unsigned long huge_anon_orders_inherit;
> +extern unsigned long huge_anon_orders_defer;
>
>  static inline bool hugepage_global_enabled(void)
>  {
> @@ -306,6 +308,9 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
>  	/* Optimization to check if required orders are enabled early. */
>  	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {

And code here becomes tva_flags & (TVA_ENFORCE_SYSFS | TVA_IN_KHUGEPAGE).=


Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

