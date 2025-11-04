Return-Path: <linux-kselftest+bounces-44754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB9C32C03
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DC1189F6E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB928FFF6;
	Tue,  4 Nov 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5ESZQ/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCA28488D;
	Tue,  4 Nov 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283993; cv=fail; b=N9AMOzA0yEabwlFBQ1pXuaWzJ4T52bGg+r1EEwAeMQP885OhmjO/wjUP7WQ6M8W2apZJRUzM11Ux9v+P0zPAK7nwX1+DLld7qqsovI5ghGvCRyG50WvN1zLXG7N1hjg7KXMW3sZbFeiZ0lVh3GR/txXe2nq+X9UBfdboHFlprug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283993; c=relaxed/simple;
	bh=lLVF0LB0lcxDex1sPh/0/w4KnO/ykP6ueWuQSRCb8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cs5POaJA1EIrXNPibRZqEeMH3iG66AXpoufn9Me2/CqLs/6DyVMJYmnDczMXhQkm7akcwLKva8n7IE/GgxQVmhpFZvRf+LSU2VP/S1VVVcjJBiIzD5kU+6jyOe/vjPa2Ye54yxdMLapsFcc/Q/jZPzwAmQ5m0ZvwR+GU6yueAGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k5ESZQ/W; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7U4we6s0YW2SaT2Yoh5KkIuYXNoLdxX9jTXQLLGvigbVqzbcteeMC1sycAtF8Iyo6ex6DmQfAsfnXvH1hl+dqQZuUTgevb0mIvQVe71fbC8nJYV5RrTNjNX4iiVZfMRCRzKyh2tTQPfuabUIAd65uKaW48OR4nDU/PHXDyDDhK6c7Bp2d0n6JTZ6G2t/WaKVP36b5qmRl+amqjV6GRaXzpm3OT/kaGA2YUhM6XqchhSF3VoAj54bOIKbkQuVfROmXScCkDNz08nA8jw5TWrbMbZQIakv+iulLxy3k6XTVwhBniTosSCV+LcZaWhSN0Op8o0PL9Bx510SY9zwO2KOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvuI8ajRkRN5btUCjoxXWleEK11sSj2CzeGc8l4fNJw=;
 b=SdryqnDrow4OUmbtvspjjL39I9uJgcpw5TtrG8l2Q1sDphKDzAIZI/XaugzDaLpLQIA1HBgZ7QvUQ5/PjpHF/QVMigj6pUoEkocLC6YcID4ppU0lPB3Eb88WnVRFzIBJOvGLSRNd3oESDJHWAjd6Td7n0FdF+Xx9ZjVw9wBIszG/HGy9FE697R1hwHSDdczjJF2SH5G1VEcgLH4Uf8jEhr9ws4JV1+unWasijfEoPayl/Hamqw4KKWhVUU+WRC+gHB12ZB1Qwyyn2PidLqWEcd191RGuraIYs2nl+X4Y7H9YwL8pWY5DJK9tnst57WVxP0qRIssSc20zeV5nyPz+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvuI8ajRkRN5btUCjoxXWleEK11sSj2CzeGc8l4fNJw=;
 b=k5ESZQ/WrGSwxtIRGCajkpCK/pZ81rU3vQ2I9gsoh+99tk0DWEF10FSfWKLIg6uHCYyZJDhHl0rCdwo5o+M5TDs/nlvXD8vkLLuzvfoG5gye/TY08GVLVo3n8XpJUIhu69s6rFJkG85HH5CfONnUWd0SlClT4v1OW5LUf4FUIqcPsH3obwTLtiqDpDUstFa9ZKGBSWEp09gePdq9MumO6EmzVdKCYYC4KQ/TenC18lyrQKDZri82OP8uhVQmOSUnpMD2PgBcjbuLyIGj6zFHEb8NuiZwZ/KV8dEf1b+wDwf0D12qgo6gggE6JNye62pEePl8BE4AMpqw7D0XrJNOMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:19:48 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:19:48 +0000
Date: Tue, 4 Nov 2025 15:19:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 05/15] iommupt: Add iova_to_phys op
Message-ID: <20251104191947.GC1678406@nvidia.com>
References: <5-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <d7ba7762-f398-4a7e-8e70-786ed9c4fa52@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ba7762-f398-4a7e-8e70-786ed9c4fa52@infradead.org>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d286abf-902f-4cee-4174-08de1bd71ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+iH5eWDPwM36JKIYfNDc6nlQLIrxbmHPTClvtvA6SnBRBjDWTIRIbRAQpX/?=
 =?us-ascii?Q?9hH6OGlqHul/NDzWpO4z5b8r30qCBBWSGIosaCs0wVxwyFHq7/gQGFfQgalh?=
 =?us-ascii?Q?iExotue0R0f2se5j/hEATaVh8PTEqI1bU4r5yS4x9TkjFAdYTtouBQ/Ucex5?=
 =?us-ascii?Q?Ds3rfSTA9KniwRZiCRIX/FXa83HVXpHoOLJAevPq7WSj5PmvOZQr+P5Qsm0r?=
 =?us-ascii?Q?b7DgNocLZUwSGiQ7Tf5qV4u04vHx83fUfwqc+0dhYLSxpFV8rxmy5JGQzPbg?=
 =?us-ascii?Q?0cSoHS1ol2WwCr7BTo6X7ClCJ/v5xofycACFI7TBCbR3cJLXehHLUd7yOX1y?=
 =?us-ascii?Q?2OEer+VLY7d0mjVoOJMC5NqtnqTI4nGoNJsXQCKCjUhhjn7jL3DHbNZXcvPX?=
 =?us-ascii?Q?8Ou9Y57j4Qz1fyALu2BF3qdcDP9wbXMj5i2UhhrAg90nRzgf1BaT/KJXe11O?=
 =?us-ascii?Q?5JwM4Nx/h4JgHE6u1id/FsQaADJmMC/wxPRpDJbkNkAUkI1yGkBgr2xqlnu7?=
 =?us-ascii?Q?p2tfPD/tMlzZrU2KG9Qwy+jhyEqyX+TXQb6HsK+ekAPP30OMsd4jMvAMXMeR?=
 =?us-ascii?Q?92mK9z94C1JMj9vtHXW3sXE4YZhxfwvvMgRILF+VhpEJGtf44qWylt7BKZlJ?=
 =?us-ascii?Q?Xo0dw0+1hhZYFYHWw79Ugx2dftyEQCPGc33lv/D1Ux0ncdNwqnfLN6asSowd?=
 =?us-ascii?Q?UpJneEiFOOJ1cZW59zTntFsn6UBim+dDi4AZ5pn7NLmnDoK7daJhuIW+t9iS?=
 =?us-ascii?Q?bWlvzlmp8eMYlDwOBBS6rAtCEaxVSb+Ja0BZsEEzGl20KQnWPkO5+ssXYbCk?=
 =?us-ascii?Q?1hX1sZFH7hdy7X2xQnlooEV8ORNU0mVx58zM79pacNknlW5Y86/xpCLse+XZ?=
 =?us-ascii?Q?9Ug6LtvNQq01rJMqJPv8IYQfj1LCwSe/NaMEwKNlCM+qTLcVN8Mj6cFV8qQn?=
 =?us-ascii?Q?96BHTBzgdRBlJOviZMKGJiFdzsSw1Ovm8f2q+hvjoy30wLL3baLOeWzlDW1V?=
 =?us-ascii?Q?UvyNq8Un3yDviSCfbt7jtnLewqlCc+2ba7SOzJ5Wb1ZhPzQRlL56f5IsMiMD?=
 =?us-ascii?Q?XWCUjLtcrwcwNALWnc9EgDtLG0aq4hHffeynWN4lszppVCYO7lg3sLY+rbTp?=
 =?us-ascii?Q?nKUq/MxAcBm/K0BxoKaHZ5QObymXc3NUzswdj6hZToOkLbGik3ypBBY3fuKM?=
 =?us-ascii?Q?jfYOQzXP4ucNuMFhazYEH779sLWI77nKUrMevzzqDUC/cT+lzhYrKbvIJt0A?=
 =?us-ascii?Q?Yq8graIbQAT3HjBtZgSCFgm1GqnuZ/SvY11mTTsnbvJTiONsb1sIqRihePDS?=
 =?us-ascii?Q?aG05Zg7gE1JnXHA6dUny/nW9DjVwD8b358Mz7eokQQ11/9z14tHDbQgxeh9W?=
 =?us-ascii?Q?7abmR/WUztr/HugMiTAkl4u5JUSYym//6eeLREXFmuX907P1ol8G4Hu1hG3n?=
 =?us-ascii?Q?1xZ1sp4prbZ331/sMK5yt3NcmvuXJ+qI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8jpwkRKo9vUK4AORu4zVbSUY08CK4bZaDlS+6l3XZ3p2d4LE5uHALyjlwev?=
 =?us-ascii?Q?sGN+m0iceMZRrwnacUKlcaNrm6mLHLFmieib/X5Q/RkjorzYRgyDpLz5VzMm?=
 =?us-ascii?Q?1U4/WzCcqagcmJiNHGdxaOilqRaIhjiHHkHdoLpVNSsUy4ri+0GH+qIi+W6U?=
 =?us-ascii?Q?+7M7rhfDSfABZVXiqmO67KF1MdFkbT0DoVKKEfUMyhy54zpzUyH9WFgJpK0u?=
 =?us-ascii?Q?bJ+89B5VKL55R+ILruK/FhNw21p8Z6wcc8wkmsMGtPgeF5oR147a0mM4foZY?=
 =?us-ascii?Q?MJFbNgymncWoAdmm3MZjq9iIPn6+/ap8msoGXKt54NhSuifAE1cIkU3V4ZxA?=
 =?us-ascii?Q?wfaWmj4c904YEapQsXTovg5Vi/I3ZhwkbkbSDEQwHBE9NCECV6+8EZtL4qxT?=
 =?us-ascii?Q?Rq6rkR1bMq+RJ99C2joffdiQ+26Sr97Ctwl9o8xzr/6vt/xmjjBRX6LrAqIV?=
 =?us-ascii?Q?8JJOy1GMuIAS2RKznK8Q6HQacAHHmgssySr2hFG+5yFPApfK04tUORQHATHQ?=
 =?us-ascii?Q?NREm7bT3jx2I4rcMnkIAXKnvqpFw8zZJyKv365wxmkxbXOtHCkVQZ/fbECey?=
 =?us-ascii?Q?90+iCbnSjrkF+XTQ+SI0ib1EsLU658U/XRvgCW1L66YTSiY1voSDFxFIX7GF?=
 =?us-ascii?Q?dCXjoVoY4xgDOR7t0gUgUfXrWW6mzTtiN8iITFVqD0Dz7h3dq71Ie0UjLk+k?=
 =?us-ascii?Q?/7CynPk93itXx+XftqoKC26+ZBtYjMLkoEdZjt3bo+TLn+9k/h+aflq/QPOd?=
 =?us-ascii?Q?KRBqxKCPsOzJrhWChYjN1HJYTsz5WpMgzbryqv+hBoHzf9uL6nn+irF6YWEm?=
 =?us-ascii?Q?Om+KssIb/xYsrlbppLYsfpnUHobzMtUuRFns+KxiO07iio9Q7gPrNllK74q/?=
 =?us-ascii?Q?D4ucPU90GRAvemQ5rNNjJ2ME4x4y02/NQlmEVQI/0EB82NpmXccYoLr03eUs?=
 =?us-ascii?Q?WGfkGJCskVVAndIGr7LVa15mEmAB9dYRO7937M0nhhEf8fpzOxrcagO0jyTe?=
 =?us-ascii?Q?XRniOJTsone+yf1jwwSC6sBXLsqpoLklsIQ4delHiOJibeR224gO2qBSg/Ty?=
 =?us-ascii?Q?8ZqTWtQA3AiiMTGKVxiwCmekCFrhyDGK1V9UW7TiPhMxL8E+es8ZO24oR9X7?=
 =?us-ascii?Q?aX0J3zKwwF0wko7lG365Ohgn264tF/KI+jOyWAsdJU66/RNamwlQKvrQyHhu?=
 =?us-ascii?Q?kZNHGewvgwnpFzy6/ALO+8Ig5sqRZlFMMGLv0jOuqomNGYJJigD31sz3aCyF?=
 =?us-ascii?Q?sQqUTiDbo9YemWtdTTYBl2TkqTCSehYQcrW2PRK8E3jqA7sz/AYeidScVb1N?=
 =?us-ascii?Q?ClFKtsvxhDdEuHoiEaGyIX48rJLx5WMoxQ8vBmEfHNOGobMwWxOwY1Zvgatw?=
 =?us-ascii?Q?z549Do4u7KoEekWiT7OMXVOd65U4kylPYIyNoa95tum4M6Su2tHfVHU26tI0?=
 =?us-ascii?Q?XFUtdC7zh8tc6yhpTXoBjI99sMDe/TJky1Nkyp86EBoKkvkT4hG9BYD5ZHs8?=
 =?us-ascii?Q?H0qGdd2OVpXiiNOahPxeU43ipP7v1cEeWVRI+0CzTb4hlWZFlrCqwfj+LaxU?=
 =?us-ascii?Q?p6DnfV30FB/BXo+q5E8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d286abf-902f-4cee-4174-08de1bd71ed0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:19:48.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SXc4/3lw97p5jgjx0+5fKhI9jGUXHyoKbzruY2J3w/IlLPRYwN+r1wjVNCvqcam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

On Tue, Nov 04, 2025 at 11:02:06AM -0800, Randy Dunlap wrote:
> 
> 
> On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> > +/**
> > + * iova_to_phys() - Return the output address for the given IOVA
> > + * @iommu_table: Table to query
> 
>       @domain: (as below)

Thanks,

I got this one and the prior one

Jason

