Return-Path: <linux-kselftest+bounces-26866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596DDA3A221
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB051897BB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE426E622;
	Tue, 18 Feb 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aG9e1PaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A044626E16E;
	Tue, 18 Feb 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894674; cv=fail; b=UO4ayTUVHoKKQGDsqhf84SyFnz9AKCIwLCooHQ9+7rzQP3fCfquH1qvKEbjFjA6un1sAviBktbvl4m0mgQtkkDMRkwe2amuW+sqaK3lOeJTtmLamhTCmFBOYvLnssn1MO+pjJkI/ihbi2k6dXWX6v8VXlpeUXVBKKGChrL6P3Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894674; c=relaxed/simple;
	bh=9vp0XwTEkzh+FLJwq5OvHHR3E+QzVvXaZSphqsPjcRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qeq8Ghncd8Z6c7O6NAn2h0l5cy0HrOZCuxE3TNi5MhFJ+LRphhhqbAm9snvGU6Q+nXg9iohmpJ89aAie6cUVPNUDzgQ2rpjl34kqQ0PrC2kLMAw3DLOp3LTaum+d8P2CJJ70JJNgQEpDktFXlK26W7aRUBd4r8eGiGpZ6W6BonE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aG9e1PaU; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlnANJtW+sp7V2DcFColWOl/lzj0eSV2CSPP+2LjceGHgU2Tj4ivG4ZTFMqleebkk/+rvxaJLthNC930VfJiHdRZ8aageWsMx9SBT0MB+WLdaSsrYDzs8OdDMeZhMOiDrfNxFVohw5dqGUD6hTlaCdor6J38wfLIz017nV0sXrgr0jw+DhI1ls5HH+K7izKMqiLIwaJ3ccDA4IqBQPveR4jEhfYmb0o727WgxkB0zcdKOv16ApmO/KwgPFi9Wt07v2IlxYSMgF0aam7af/XyHIhYjl5islZq4pxVCpvXKHTRQJzIhHhzENQda4fyaGBg2OQa/SVxB92WO2Wc2ijuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fafEkoR9SEnBGO9jFx6hKcfZlQpVoj50lEO5N+wrUCA=;
 b=U6ZEQSQbpStSK8dyIiMNknUt+xV+6yMOqUaq/XGOFcTOrsSl9aryTQtA+7OKSdQGTyhu8ojVn9tjCVKkvT0TW3xRCLgDZ0JH34/0OmGYlJZ+aecX+aIO1l8eNuwyqgVVhsmg/trW7ptYwsOai9XIKeCkhkwVvs7JzRdGqhXxnQjwcHBnp09nVyojcm9cjOuW2AMOqsT0g2oaE42AshvEuh3sEnsarvd+WvhY4gIIooPqk2D/+blULErheLjQ+YZBkURydKN+ihzd16KFAfmuAkDbg1UvvyOcV7nGYa+Wfs2L3xLUHAu69yAnea2Fq0rjX71f7T7RGUF/KZI4jFt7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fafEkoR9SEnBGO9jFx6hKcfZlQpVoj50lEO5N+wrUCA=;
 b=aG9e1PaU1uGl+jDCOlLganGeHJaRC1WQUbEuhQWN4XEjWCjLnt5zKSWl2mSpksmCGFf4W152hQXxL4swnfzv3xXFBp/re76ve0+ApfO/fB8w0G7Zz/puFtsP6bj2mZZhltWXYXCvp/yaKfE66sSfIH2Wjg8L2JNKIf077ih8fzb/z3BzyEe/RhS3jhoebrSo5/Mruu3iA9ikucj0QTOmNp1L4JfyYbgv9ahzrI7WICZkNNzycdBAcj0QXEJn2Z5gTE9RQb86/Q41SBQn6DLP9032IKyMaA+J55BKNW6BlImrUPaaIAarUls7qy8eeIhl3nO66Kaf0vUy2ID7MNSHkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:04:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:04:25 +0000
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
Date: Tue, 18 Feb 2025 11:04:20 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <DA7491B4-7794-4F86-AFBC-BB8BFBD1D9B3@nvidia.com>
In-Reply-To: <af3b230c-7aeb-44bf-8db3-3538dfb1b93c@redhat.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
 <0bb75517-9418-4145-8aa8-b05373010711@redhat.com>
 <F5D2A2F4-34DC-4967-A149-A4D5578B5DB2@nvidia.com>
 <af3b230c-7aeb-44bf-8db3-3538dfb1b93c@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 076f267d-a70d-4e11-05ff-08dd5035ea3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZA9Pcj3QTH+5wmfIHNdmbUemKJlTVFRK5BS6Sz9ZpZCGQlFQ8sM4htSl4c0V?=
 =?us-ascii?Q?qHu2I/hF+bW27S/NHocmbpGbbTdjD9JuAoCIZgrioeZ1NFlgXiMaQ9QintJ4?=
 =?us-ascii?Q?vy1IiUwSOknkDPZGLzj6+xhsoL4XbF6skeiw0h1ByRS+la860lbaN0oMu59b?=
 =?us-ascii?Q?7xFsWwMalBCmKW1FY7X05Fwzk5ax1kojpZ6D9cVi+97nmvxHeOy+L8DN17RO?=
 =?us-ascii?Q?8KczYK5O8FyKQM8wRidYZ7YJzYh03yrNMbUwBkpKAVqj+N3h8SfChjqzQ/nZ?=
 =?us-ascii?Q?wJ6RFPZwGtNyfTsg0L5zhzKvfg6RIkbMer94xZA8JojGXxaI5IcFpwzwfgst?=
 =?us-ascii?Q?hbxlOcePu18Putv609P/6RJB1eXbdFGVL5Mv0IOgSsbDIC20X2vksDAWfB51?=
 =?us-ascii?Q?FffEiKKmvQlpcG0Ed4ndXWH3NNby06UH62fQWM/RMMbdTDohx/XSDQjlXDiP?=
 =?us-ascii?Q?vBSzSqgiEzdSKXE8hCJXf09Bwm1gK9Vx82nMVnKN+tNFoekEx7r0P9fOHJvk?=
 =?us-ascii?Q?OPKWSiJejdMETvKga76FmAR/K/M31elqXaKy2FiemmT3dlf0YO20mCcucRyb?=
 =?us-ascii?Q?XMn+qN5UmOxjU6cDT43UWJiVf8eNuM+9Ir2t8U2Pl5waP4gl9jUTTIXp76rl?=
 =?us-ascii?Q?DzRLsqyQQQk2oajPk6OSF3aBMeZrvCy6rZEWCv8K+MvmzZs4WbZ4qSZZt+5w?=
 =?us-ascii?Q?QY4LwUsGYcFZa/nWwkVWmCHT/dj8Xlp3EsL1FC0LwgEIfkhRMnbTejHWsHpa?=
 =?us-ascii?Q?oDCv7WzA8k0mC0QbG7w6cxCyUoA+nPlmFfxt/gh4tQKKLcvBs1Ew39Hd/EUg?=
 =?us-ascii?Q?KWQmV/JXwmXFiIrkiVy/8+7ehLSrVwXsDnw0d23OhlZlBfl27k3i9JhN3TyY?=
 =?us-ascii?Q?IXv+VTwdy32j509F/y18t41Ffi2oJN5ErlMpGxowpdxaM17GJD5p5mBjq8Qb?=
 =?us-ascii?Q?FcOY8NgihaDF8pdTjNhwOBUR1Pr2ZZQFmpM7yNF4LXp+rqT4YYJ1mP6X5Yht?=
 =?us-ascii?Q?9gkWJY+HgL5xXBboFsVAA7ucueY5SVNHMsBpw4vnXTR2UTJMILgaVKzuqmep?=
 =?us-ascii?Q?W46bdkGaSTeJL6VUPAoKgBEjFyfeW5Bg/era+v1oKiGNzQ6Up4QY/LqqL88X?=
 =?us-ascii?Q?J8Ysu+zVwGCqPQ2dcirBkHyqFJNadvcWoUfAJaCVdiweqfpmsKhniHovjJpb?=
 =?us-ascii?Q?7ccuM39Kd/9xojqO4p7PWt4Tq2a+q6MUxe84v6idT/gUkJKo0cveE9EBKRfe?=
 =?us-ascii?Q?8PSy84ZHw0bMXu8yBabhSSNiLj1Y+M9OMGEAaiLTsnwCVldApAgk9PFlP7Dp?=
 =?us-ascii?Q?7wjgmd0hDO4O4829KcrQTx4zoSq0bTmyvvhHs8mfegIZ2XjHW+B+DmaQxjPM?=
 =?us-ascii?Q?qpLVGD5BEiIA2fBFyTLYdhiybbMU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20dTYe9pTHtMkrcG4/CCIet4KrPdXG7KV5C8UGguqtmL8BzVQLavU0L+NSbh?=
 =?us-ascii?Q?yJGU8mZhhEtuzCa7ogxZy2RRbBnGSj30fo70DSCnAWg/Jh7wZOjY3z8AXtwH?=
 =?us-ascii?Q?lmBxzG8yLqdR7nsi9kXPb2MRov55nmFQYG1lnZJQ8f58IYtIv5nE4kXEWSBy?=
 =?us-ascii?Q?EA8QRSWbX1ojd19CLV4jIKzH1yNc3clH/zJeIgSyaFW53wcZYwSo+DCl5Med?=
 =?us-ascii?Q?eue7uaKrJkAmahaoC7t9YEwqKtVb+mqvjHYrwIlHUxfyxjPyN3WkgUwlxZ8T?=
 =?us-ascii?Q?ccZ9sexRIKfNmu0E9lIjsmRlo3o7kNkWR3qmyHtKLLmOt0QOMLTEjgZucVnI?=
 =?us-ascii?Q?wOOowCKdpuHOJiNwRE9xQPmubH/JMA7GkEsZIFcU6VS9vGduUEUUjC7yUks5?=
 =?us-ascii?Q?3rvAW+BKnTVb19vDXAtAmrMhIXGsSMOmlkdcFS5k2kGpwKn2BREtrS1tmI7U?=
 =?us-ascii?Q?OtpcFrE5UYEpGxmUe1uqtjtMllbPMsHRRu8Dar1R9sTJPBV6pPtOlvciw2OT?=
 =?us-ascii?Q?05n0EoYTKetW6TQF893RGT1y19S8GlktJwGf1Lo/mkRXqnfH5y784Vg73iDu?=
 =?us-ascii?Q?H7dwQFHi4QvHqnKt6+TTmhkN+anAqZ0kX62ikdck1qMlAkJQntPEj9IoOhz+?=
 =?us-ascii?Q?ZGSxCCgxlK4xMsrtcRtLUTtptx2I3WaYxQADkOj0sHb5FUB/2Pdd37R2m/c/?=
 =?us-ascii?Q?H4lWZFKX/ryc87LWeJOt7eRliz4gKJYUWQrn0GVI1FynsentayJcOV/wkf7z?=
 =?us-ascii?Q?Dnf9gv08ofkxnsIY+QesWjZZoV+RExO8/qTYmxllGsbCrcT3fHLJaRUjDtsa?=
 =?us-ascii?Q?4RG2mAAa7fIyfdjA6rE8NMn090Ob8SK6Wkym3AQRWw+zK/pYtneLSJ7Qf//3?=
 =?us-ascii?Q?aMsqqFBz3KzSxylSjUZ25FvEZZ0zx7yJLqFZeKloQ04h99y3ZXNQreiieR9R?=
 =?us-ascii?Q?Y+xVB8hslUVFV+B/JTinuBA4EOwJXdc5soietvSwrPrYKEcAVjEMgDovqCSW?=
 =?us-ascii?Q?YtUKFb3cTswZ4SE1LLQuKRIWZpm0vZVq2beWEUjBugD+xGGPhCKZDVMriGxG?=
 =?us-ascii?Q?GDYWbiSjuULGJYUC23mYj3HEDwTPW/QjL8Z5lA7BsKt7GcqGbBZhkL0itpLv?=
 =?us-ascii?Q?/ijIhkUh8/Nl4CXQTvgcWjPbZnAbwoz3H//tNcL0cETb9CnP961k/ZH0IM2X?=
 =?us-ascii?Q?wMHAY4qIe4RmviS6aqKPtIODxYXO7xLCmQBLj1NEy0V16yjxE0/phldrFNVx?=
 =?us-ascii?Q?2+jQ/qSeuXBy9IyKGbl3Q8yuFGGJY4rxo53yZpqZmS0BYlUgXvLU5vMmExQh?=
 =?us-ascii?Q?QGqNe3qwvirJddSbAGvq9XPTJ1/W6S0Fb2EXSSJ60CiOhB1cWJ377fHmc2fG?=
 =?us-ascii?Q?sNp7qRfwOFrleJZRUsLJ/ATJKj4D3JJWFnAhE6Ec2D8RIIpTMwDwtIZZJC/r?=
 =?us-ascii?Q?v4QY+cQ/Q6q+YbBewNmkIZhx5HShGRXBPEUxYJpOMPe1uMw9/0rlPWHgoAuu?=
 =?us-ascii?Q?NPuoonysVgf/bu75CsUabOOTLMUD1pDb2LMt1IHha2xlBqj24zp486o54YDB?=
 =?us-ascii?Q?L/gujYGEXpovwFAjERiW5NLGninBozhc1cKuEXgz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076f267d-a70d-4e11-05ff-08dd5035ea3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:04:25.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IokZjpS+910EsqsMll/IjCWUTT4KD0POEN0N5lJLY1VqzbnaQOGocWt3T+M271uC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161

On 18 Feb 2025, at 10:44, David Hildenbrand wrote:

> On 17.02.25 23:05, Zi Yan wrote:
>> On 17 Feb 2025, at 16:44, David Hildenbrand wrote:
>>
>>> On 11.02.25 16:50, Zi Yan wrote:
>>>> It is a preparation patch for non-uniform folio split, which always =
split
>>>> a folio into half iteratively, and minimal xarray entry split.
>>>>
>>>> Currently, xas_split_alloc() and xas_split() always split all slots =
from a
>>>> multi-index entry. They cost the same number of xa_node as the to-be=
-split
>>>> slots. For example, to split an order-9 entry, which takes 2^(9-6)=3D=
8
>>>> slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node =
are
>>>> needed. Instead xas_try_split() is intended to be used iteratively t=
o split
>>>> the order-9 entry into 2 order-8 entries, then split one order-8 ent=
ry,
>>>> based on the given index, to 2 order-7 entries, ..., and split one o=
rder-1
>>>> entry to 2 order-0 entries. When splitting the order-6 entry and a n=
ew
>>>> xa_node is needed, xas_try_split() will try to allocate one if possi=
ble.
>>>> As a result, xas_try_split() would only need one xa_node instead of =
8.
>>>>
>>>> When a new xa_node is needed during the split, xas_try_split() can t=
ry to
>>>> allocate one but no more. -ENOMEM will be return if a node cannot be=

>>>> allocated. -EINVAL will be return if a sibling node is split or
>>>> cascade split happens, where two or more new nodes are needed, and t=
hese
>>>> are not supported by xas_try_split().
>>>>
>>>> xas_split_alloc() and xas_split() split an order-9 to order-0:
>>>>
>>>>            ---------------------------------
>>>>            |   |   |   |   |   |   |   |   |
>>>>            | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>>>            |   |   |   |   |   |   |   |   |
>>>>            ---------------------------------
>>>>              |   |                   |   |
>>>>        -------   ---               ---   -------
>>>>        |           |     ...       |           |
>>>>        V           V               V           V
>>>> ----------- -----------     ----------- -----------
>>>> | xa_node | | xa_node | ... | xa_node | | xa_node |
>>>> ----------- -----------     ----------- -----------
>>>>
>>>> xas_try_split() splits an order-9 to order-0:
>>>>      ---------------------------------
>>>>      |   |   |   |   |   |   |   |   |
>>>>      | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>>>>      |   |   |   |   |   |   |   |   |
>>>>      ---------------------------------
>>>>        |
>>>>        |
>>>>        V
>>>> -----------
>>>> | xa_node |
>>>> -----------
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    Documentation/core-api/xarray.rst |  14 ++-
>>>>    include/linux/xarray.h            |   7 ++
>>>>    lib/test_xarray.c                 |  47 +++++++++++
>>>>    lib/xarray.c                      | 136 +++++++++++++++++++++++++=
+----
>>>>    tools/testing/radix-tree/Makefile |   1 +
>>>>    5 files changed, 188 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-=
api/xarray.rst
>>>> index f6a3eef4fe7f..c6c91cbd0c3c 100644
>>>> --- a/Documentation/core-api/xarray.rst
>>>> +++ b/Documentation/core-api/xarray.rst
>>>> @@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-inde=
x entry will set the
>>>>    entry at every index to ``NULL`` and dissolve the tie.  A multi-i=
ndex
>>>>    entry can be split into entries occupying smaller ranges by calli=
ng
>>>>    xas_split_alloc() without the xa_lock held, followed by taking th=
e lock
>>>> -and calling xas_split().
>>>> +and calling xas_split() or calling xas_try_split() with xa_lock. Th=
e
>>>> +difference between xas_split_alloc()+xas_split() and xas_try_alloc(=
) is
>>>> +that xas_split_alloc() + xas_split() split the entry from the origi=
nal
>>>> +order to the new order in one shot uniformly, whereas xas_try_split=
()
>>>> +iteratively splits the entry containing the index non-uniformly.
>>>> +For example, to split an order-9 entry, which takes 2^(9-6)=3D8 slo=
ts,
>>>> +assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() n=
eed
>>>> +8 xa_node. xas_try_split() splits the order-9 entry into
>>>> +2 order-8 entries, then split one order-8 entry, based on the given=
 index,
>>>> +to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0=
 entries.
>>>> +When splitting the order-6 entry and a new xa_node is needed, xas_t=
ry_split()
>>>> +will try to allocate one if possible. As a result, xas_try_split() =
would only
>>>> +need 1 xa_node instead of 8.
>>>>     Functions and structures
>>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>>>> index 0b618ec04115..9eb8c7425090 100644
>>>> --- a/include/linux/xarray.h
>>>> +++ b/include/linux/xarray.h
>>>> @@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned lon=
g index);
>>>>    int xas_get_order(struct xa_state *xas);
>>>>    void xas_split(struct xa_state *, void *entry, unsigned int order=
);
>>>>    void xas_split_alloc(struct xa_state *, void *entry, unsigned int=
 order, gfp_t);
>>>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int =
order,
>>>> +		gfp_t gfp);
>>>>    #else
>>>>    static inline int xa_get_order(struct xarray *xa, unsigned long i=
ndex)
>>>>    {
>>>> @@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_=
state *xas, void *entry,
>>>>    		unsigned int order, gfp_t gfp)
>>>>    {
>>>>    }
>>>> +
>>>> +static inline void xas_try_split(struct xa_state *xas, void *entry,=

>>>> +		unsigned int order, gfp_t gfp)
>>>> +{
>>>> +}
>>>>    #endif
>>>>     /**
>>>> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
>>>> index 6932a26f4927..598ca38a2f5b 100644
>>>> --- a/lib/test_xarray.c
>>>> +++ b/lib/test_xarray.c
>>>> @@ -1857,6 +1857,49 @@ static void check_split_1(struct xarray *xa, =
unsigned long index,
>>>>    	xa_destroy(xa);
>>>>    }
>>>>   +static void check_split_2(struct xarray *xa, unsigned long index,=

>>>> +				unsigned int order, unsigned int new_order)
>>>> +{
>>>> +	XA_STATE_ORDER(xas, xa, index, new_order);
>>>> +	unsigned int i, found;
>>>> +	void *entry;
>>>> +
>>>> +	xa_store_order(xa, index, order, xa, GFP_KERNEL);
>>>> +	xa_set_mark(xa, index, XA_MARK_1);
>>>> +
>>>> +	xas_lock(&xas);
>>>> +	xas_try_halve(&xas, xa, order, GFP_KERNEL);
>>>> +	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
>>>> +	    new_order < order - 1) {
>>>> +		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) !=3D -EINVAL);
>>>> +		xas_unlock(&xas);
>>>> +		goto out;
>>>> +	}
>>>> +	for (i =3D 0; i < (1 << order); i +=3D (1 << new_order))
>>>> +		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
>>>> +	xas_unlock(&xas);
>>>> +
>>>> +	for (i =3D 0; i < (1 << order); i++) {
>>>> +		unsigned int val =3D index + (i & ~((1 << new_order) - 1));
>>>> +		XA_BUG_ON(xa, xa_load(xa, index + i) !=3D xa_mk_index(val));
>>>> +	}
>>>> +
>>>> +	xa_set_mark(xa, index, XA_MARK_0);
>>>> +	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
>>>> +
>>>> +	xas_set_order(&xas, index, 0);
>>>> +	found =3D 0;
>>>> +	rcu_read_lock();
>>>> +	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
>>>> +		found++;
>>>> +		XA_BUG_ON(xa, xa_is_internal(entry));
>>>> +	}
>>>> +	rcu_read_unlock();
>>>> +	XA_BUG_ON(xa, found !=3D 1 << (order - new_order));
>>>> +out:
>>>> +	xa_destroy(xa);
>>>> +}
>>>> +
>>>>    static noinline void check_split(struct xarray *xa)
>>>>    {
>>>>    	unsigned int order, new_order;
>>>> @@ -1868,6 +1911,10 @@ static noinline void check_split(struct xarra=
y *xa)
>>>>    			check_split_1(xa, 0, order, new_order);
>>>>    			check_split_1(xa, 1UL << order, order, new_order);
>>>>    			check_split_1(xa, 3UL << order, order, new_order);
>>>> +
>>>> +			check_split_2(xa, 0, order, new_order);
>>>> +			check_split_2(xa, 1UL << order, order, new_order);
>>>> +			check_split_2(xa, 3UL << order, order, new_order);
>>>>    		}
>>>>    	}
>>>>    }
>>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>>> index 116e9286c64e..c38beca77830 100644
>>>> --- a/lib/xarray.c
>>>> +++ b/lib/xarray.c
>>>> @@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *no=
de, unsigned int offset,
>>>>    	}
>>>>    }
>>>>   +static struct xa_node *__xas_alloc_node_for_split(struct xa_state=
 *xas,
>>>> +		void *entry, gfp_t gfp)
>>>> +{
>>>> +	unsigned int i;
>>>> +	void *sibling =3D NULL;
>>>> +	struct xa_node *node;
>>>> +	unsigned int mask =3D xas->xa_sibs;
>>>> +
>>>> +	node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru,=
 gfp);
>>>> +	if (!node)
>>>> +		return NULL;
>>>> +	node->array =3D xas->xa;
>>>> +	for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>>>> +		if ((i & mask) =3D=3D 0) {
>>>> +			RCU_INIT_POINTER(node->slots[i], entry);
>>>> +			sibling =3D xa_mk_sibling(i);
>>>> +		} else {
>>>> +			RCU_INIT_POINTER(node->slots[i], sibling);
>>>> +		}
>>>> +	}
>>>> +	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>>> +
>>>> +	return node;
>>>> +}
>>>> +
>>>>    /**
>>>>     * xas_split_alloc() - Allocate memory for splitting an entry.
>>>>     * @xas: XArray operation state.
>>>> @@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, voi=
d *entry, unsigned int order,
>>>>    		gfp_t gfp)
>>>>    {
>>>>    	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>>>> -	unsigned int mask =3D xas->xa_sibs;
>>>>     	/* XXX: no support for splitting really large entries yet */
>>>>    	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <=3D order))
>>>> @@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, vo=
id *entry, unsigned int order,
>>>>    		return;
>>>>     	do {
>>>> -		unsigned int i;
>>>> -		void *sibling =3D NULL;
>>>> -		struct xa_node *node;
>>>> -
>>>> -		node =3D kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru=
, gfp);
>>>> +		struct xa_node *node =3D __xas_alloc_node_for_split(xas, entry, g=
fp);
>>>>    		if (!node)
>>>>    			goto nomem;
>>>> -		node->array =3D xas->xa;
>>>> -		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
>>>> -			if ((i & mask) =3D=3D 0) {
>>>> -				RCU_INIT_POINTER(node->slots[i], entry);
>>>> -				sibling =3D xa_mk_sibling(i);
>>>> -			} else {
>>>> -				RCU_INIT_POINTER(node->slots[i], sibling);
>>>> -			}
>>>> -		}
>>>> -		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>>>>    		xas->xa_alloc =3D node;
>>>>    	} while (sibs-- > 0);
>>>>   @@ -1122,6 +1132,100 @@ void xas_split(struct xa_state *xas, void =
*entry, unsigned int order)
>>>>    	xas_update(xas, node);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(xas_split);
>>>> +
>>>> +/**
>>>> + * xas_try_split() - Try to split a multi-index entry.
>>>> + * @xas: XArray operation state.
>>>> + * @entry: New entry to store in the array.
>>>> + * @order: Current entry order.
>>>> + * @gfp: Memory allocation flags.
>>>> + *
>>>> + * The size of the new entries is set in @xas.  The value in @entry=
 is
>>>> + * copied to all the replacement entries. If and only if one xa_nod=
e needs to
>>>> + * be allocated, the function will use @gfp to get one. If more xa_=
node are
>>>> + * needed, the function gives EINVAL error.
>>>> + *
>>>> + * Context: Any context.  The caller should hold the xa_lock.
>>>> + */
>>>> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int =
order,
>>>> +		gfp_t gfp)
>>>> +{
>>>> +	unsigned int sibs =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
>>>> +	unsigned int offset, marks;
>>>> +	struct xa_node *node;
>>>> +	void *curr =3D xas_load(xas);
>>>> +	int values =3D 0;
>>>> +
>>>> +	node =3D xas->xa_node;
>>>> +	if (xas_top(node))
>>>> +		return;
>>>> +
>>>> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
>>>> +		gfp |=3D __GFP_ACCOUNT;
>>>> +
>>>> +	marks =3D node_get_marks(node, xas->xa_offset);
>>>> +
>>>> +	offset =3D xas->xa_offset + sibs;
>>>> +	do {
>>>> +		if (xas->xa_shift < node->shift) {
>>>> +			struct xa_node *child =3D xas->xa_alloc;
>>>> +			unsigned int expected_sibs =3D
>>>> +				(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
>>>> +
>>>> +			/*
>>>> +			 * No support for splitting sibling entries
>>>> +			 * (horizontally) or cascade split (vertically), which
>>>> +			 * requires two or more new xa_nodes.
>>>> +			 * Since if one xa_node allocation fails,
>>>> +			 * it is hard to free the prior allocations.
>>>> +			 */
>>>> +			if (sibs || xas->xa_sibs !=3D expected_sibs) {
>>>> +				xas_destroy(xas);
>>>> +				xas_set_err(xas, -EINVAL);
>>>> +				return;
>>>> +			}
>>>> +
>>>> +			if (!child) {
>>>> +				child =3D __xas_alloc_node_for_split(xas, entry,
>>>> +						gfp);
>>>> +				if (!child) {
>>>> +					xas_destroy(xas);
>>>> +					xas_set_err(xas, -ENOMEM);
>>>> +					return;
>>>> +				}
>>>> +			}
>>>
>>> No expert on this, just wondering ...
>>>
>>> ... what is the effect if we halfway-through fail the split? Is it ok=
ay to leave that "partially split" thing in place? Can callers deal with =
that?
>>
>> Good question.
>>
>
> Let me rephrase: In __split_unmapped_folio(), we call xas_try_split(). =
If that fails, we stop the split and effectively skip over the __split_fo=
lio_to_order(). The folio remains unsplit (no order change: old_order).

Right. To be more specific, in !uniform_split case, the original folio
can be split and old_order can change. Namely, if the caller wants to
split an order-9, folio_split() can split it to 2 order-6s, 1 order-7,
and 1 order-8 then cannot allocate a new xa_node due to memory constrains=

and stop. The caller will get 2 order-6s, 1 order-7, and 1 order-8
and folio_split() returns -ENOMEM. The caller needs to handle this
situation, although it should be quite rare. Because unless the caller
is splitting order-12 (or even higher orders) to order-0, at most
1 xa_node is needed.

>
> xas_try_split() was instructed to split from old_order -> split_order.
>
> xas_try_split() documents that: "The value in @entry is copied to all t=
he replacement entries.", meaning after the split, all entries will be po=
inting at the folio.

Right.

>
> Now, can it happen that xas_try_split() would ever perform a partial sp=
lit in any way, when invoked from __split_unmapped_folio(), such that we =
run into the do { } while(); loop and fail with -ENOMEM after already hav=
ing performed changes -- xas_update().
>
> Or is that simply impossible?

Right. It is impossible. xas_try_split() either splits by copying @entry
to all the replacement entries, or is trying to allocate a new xa_node,
which can result in -ENOMEM. These two will not be mixed.

>
> Maybe it's just the do { } while(); loop in there that is confusing me.=
 (again, no expert)

Yeah, that the do while loop is confusing. Let me restructure the code
so that the do while loop only runs in the @entry copy case not the
xa_node allocation case.

>
>> xas_try_split() imposes what kind of split it does and is usually used=
 to
>> split from order N to order N-1:
>
> You mean that old_order -> split_order will in the case of __split_unma=
pped_folio() always be a difference of 1?

Yes for !uniform_split case. For uniform_split case (split_huge_page*() u=
ses),
xas_split() is used and all required new xa_node are preallocated by
xas_split_alloc() in __folio_split().

>
>>
>> 1. when N is a multiplier of XA_CHUNK_SHIFT, a new xa_node is needed, =
so
>> either child (namely xas->xa_alloc) is not NULL, meaning someone calle=
d
>> xa_nomem() to allocate a xa_node before xas_try_split() or child is NU=
LL
>> and an allocation is needed. If child is still NULL after the allocati=
on,
>> meaning we are out of memory, no split is done;
>>
>> 2. when N is not, no new xa_node is needed, xas_try_split() just rewri=
tes
>> existing slot values to perform the split (the code after the hunk abo=
ve).
>> No fail will happen. For this split, since no new xa_node is needed,
>> the caller is actually allowed to split from N to a value smaller than=

>> N-1 as long as N-1 is >=3D (N - N % XA_CHUNK_SHIFT).
>>
>>
>> Various checks make sure xas_try_split() only sees the two above situa=
tion:
>>
>> a. "xas->xa_shift < node->shift" means the split crosses XA_CHUNK_SHIF=
T,
>> at least 1 new xa_node is needed; the else branch only handles the cas=
e
>> 2 above;
>>
>> b. for the then branch the "if (sibs || xas->xa_sibs !=3D expected_sib=
s)"
>> check makes sure N is a multiplier of XA_CHUNK_SHIFT and the new order=

>> has to be N-1. In "if (sibs || xas->xa_sibs !=3D expected_sibs)",
>> "sibs !=3D 0" means the from order N covers more than 1 slot, so more =
than 1
>> new xa_node is needed, "xas->xa_sibs !=3D expected_sibs" makes sure
>> the new order is N-1 (you can see it from how expected_sibs is assigne=
d).
>
> Thanks!
>
>>
>> Let me know if you have any other question.
>
> Thanks for the details!

Thank you for checking the code. :)

Best Regards,
Yan, Zi

