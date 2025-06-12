Return-Path: <linux-kselftest+bounces-34829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF2AD76EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B2216E9A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D129A327;
	Thu, 12 Jun 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpgu9rqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDE299AAB;
	Thu, 12 Jun 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743253; cv=fail; b=ZRCVotm14sXjJmArOT3LfRDJIsSHFXDXZ8UvnotVVdEPIBuBtxBWIHY+oHzZYNjioP3/Y09OZw3k6hJYd55VKW4tA2ivzgVxAg0uHdezFOzoZA7NVGuDT9Y6QwfuVn6vVeAoUuLGKu1CJMfUaO0qPfY6EgPXoZjS7YO3U8ufY7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743253; c=relaxed/simple;
	bh=3l9oPsPq2vQRYhyyIAejCyhPMXFsAhqSKc8y82GPjYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2gEJVC7VtuIIpDgZiSlyLOZNiZMUy2EiWnAXUFuCRGZL398JbgaYHoByOPgIHyrLjAl23cpRyoAO65UO7X8GDx1hBB3ejC0DDAsEZ2Wr66O/0C5NVOlrghPwg3XPPqaMyFZod2/sunhiA0s6YGCumthOuXols4Ews0hYgbChbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpgu9rqd; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HilY8Av0YA4MWWy5KrhjTn3fqTN3VowxQX8xUxv3RX13WlzJ+GHz+1VE6AggNNGmD+2LtO0SCJdhFduRIjLtIIu84iniX8tBYOxYjD0Rb3WJIIhxSXIMzRpBFgxgqy9O7sfK/lPKcW2wfh4RL+3U9ajvHqKs1GcNbwSwf0zE0B13vfc7yBKT4upahFsaQtrl7oUJt7iFH4Ceb4xzABn4yTPoPtxEcp+VZQkKCvjvPr666Nj1BeVbnGxjstv9jYj45NuIMx7k06FFyahuWAf55r1klcDiLqWdNludU6NhMsHX68Z1mLJlNotMOrer7A8xv9/OrjXkYeY8FJMaOdm5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYt9J4k+jtLFC1UhCmxZRORGxveXve9GGzHGlW5sVak=;
 b=lKRGu6ULs5V2DliCCHdaOe3xqP3QidE2P9M50s/axWBHmSO6mPcLHvtetGsOTJjugrc5bkxOGvk1xUdqWbNBxXsNaK5TVEsCkEMj4tolRuioTlVMPxV9g1uK9ZwnC/W59z8NlJwPEVicZJzSSIVj5Sd0QqLZhMvZDGmNAPF6A+yHRQ04UcX/F0EYYxnxy5DPc1VrEKspPck6CH3CP/Aba3c01pRi90ZdE/Q+SbdQs/ZupFz1bVMI2RtNwsA2n8EPUfd+JQDTvLrUyWzdDaj5QRS8GsGi3/TUX5Q1bOGNJAzN1h+Ihclq0fvIuuRqphgTQb+LW7B1kxElSFhqI6uVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYt9J4k+jtLFC1UhCmxZRORGxveXve9GGzHGlW5sVak=;
 b=cpgu9rqdiXilXppVtjcC2WmsqRZv4shsJTxb+tjPDyHREUIelaVPIQJLGRl04KGwMB7tc8DweqUYHbUv3I2dFmCDtzKKxIsc0JK1r9dwGiHoJSmE6f7OsZVIHGTUwEdWzApVxxf3fG97JGNo4pEZAIufvLoFRxhuDHWcWe1rIOShUfy0BII39eeWGqSNWQPhGPrIz870USjxQ1+IbcqPeOsHogWNKOosekQyqmHs3sbjImZPx3osgmhjdegjmq+FeDs6B+T9TaBkt7js+dPrbWESKIxFz7Ld4kGcnt/OseTbUPoBI07gIDOVf5U3wgx2954qlgM3PdXZLgj1w3vEyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 15:47:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 15:47:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
Date: Thu, 12 Jun 2025 11:47:27 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <2C789980-8C92-42E7-A697-BD791E58845B@nvidia.com>
In-Reply-To: <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0971.namprd03.prod.outlook.com
 (2603:10b6:408:109::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6502ff-5878-48dc-3818-08dda9c86ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COFdGVdr/88WBwXK1/lad7ONBBo75jFMzw7GkAyd8wvXWUKWKCK50UpdxLCe?=
 =?us-ascii?Q?JsrIg/naAzee1r7PFk0VmsbyIUw9/U+flYN0A4r8aubKjqJbCWo9zWHgAghs?=
 =?us-ascii?Q?+mWOd6c9jb16I4kAHCuigc9b98QxWAnthJc6QT6vPr1BjZ+/F+QU5uTPzT9t?=
 =?us-ascii?Q?HRHO/3/zTLclOl6/6e6q7U/xiHGvY+hSXq2WfKvBKcMs5IW3j/DR6wOJWOYj?=
 =?us-ascii?Q?EQwc0jm1w/Nya8mPfBYQLUxVv91w7h935qz2ZYE1Y+a0m++mJ/tCW/uFMjKO?=
 =?us-ascii?Q?5RbIiAQ22H1Lqllr0gnLVVzEWH5oiUYC+Wrwp2n0nX/EnXPOG3xN/jG0+A5Z?=
 =?us-ascii?Q?Pj5E1xFw08F+B253zErQu/3HwG7tnIrAcl4YqZM18gR39xe+m8TUkvpJRyKz?=
 =?us-ascii?Q?OM/hVHO3jB8Q4PxYYYQQNRgsUoGcgKTwhwTfvgFpH2XUb3nfE73PZq/Nj75V?=
 =?us-ascii?Q?Ys+DR2xYjyieHe30kP659uCaJGLy+TFDopzP0GNQ5VAfRbSdyhjab1Dc3GPF?=
 =?us-ascii?Q?+1AzAdPw4W9z0kBMXJCFJ7bX2RqdJgyF7t+bytWnFMXTvJlHexhxOU79rdU4?=
 =?us-ascii?Q?WMR93hU1P+pw6KhA6oOnqRIUVOnIc98nYmD9YmAdlTWo57yv35d8ewBeeUv4?=
 =?us-ascii?Q?aMIWV1qGqLyv2gvrpzL5dZqbPdGtfkiGt7CDrO1Jk7Hh0bf/xr/TbqLRs7Yb?=
 =?us-ascii?Q?mSr14aTTvA4LomnUwExoFl/b7f/LIJD7JrjgJtlRSr/4OzCW43I2prgjmKlA?=
 =?us-ascii?Q?7qQhuIFiarAuIFzb5jvhfDCNVLvw6LQPctnGK9Ri7URYvaOfovexzY5TbPFn?=
 =?us-ascii?Q?+BULPl3cBXDpI9S7zxhZa+ssyZagm3RTsiQERsOy0VV8SlYDdu4EnEA4xHaP?=
 =?us-ascii?Q?H6smA4sIaJxBq4s7nsiC7FrlPrOlBQMOR05nLahN+LVIIuAnAC25bx8rR6pv?=
 =?us-ascii?Q?bb4EqtbOpymbn2QraHJgOnT9Uc3udxur/QHvVfo29bX7H5ppo6Oxb5QLnvEO?=
 =?us-ascii?Q?iMyD0Ee+X1eO3XBVlRZ5KOT6vhtINh6w56dlpcoyWcx67p4u+uGOI+4dpbCW?=
 =?us-ascii?Q?ByPUjnm8Wcz8hZN7bjVzyQRPwAfKbz5U9vD0hfP5bKbIclPNUUGyMpVaEAHE?=
 =?us-ascii?Q?HLycCYEnt+P6WoJSOMALNJiMG11ece4c3MRPDmj0yYK0ge5O7ZtG+9UpO64t?=
 =?us-ascii?Q?8GPYh+LSviv73HAAxfyALWuXStod1ZARGvlXdjQw/WQ0W6VZFZ8gDJxXC7ZX?=
 =?us-ascii?Q?P5wx//kvH9BC6bF0P5Pv8XST+U+869yygXAp+eV+gvSB8HuTkF+pjSOWwZtU?=
 =?us-ascii?Q?aDDFAS+aFBTQ/jUaKQ4VS+OIJ7CCpzTA8vFN0lMiewmcByuzgztbmpNDZBMi?=
 =?us-ascii?Q?OzSWr1FvxS0tSrqwWYDygbFUPSQnFTAFqWA4AP1kHQA/bY3M3fwI3/Lx3/lj?=
 =?us-ascii?Q?622fi54ajus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ymp3gV/jMln7xKcfoous/CS8tAxulwcSDNCfsc3s01cjLl2E1qcJUN0xySTA?=
 =?us-ascii?Q?gqfCqah1/2drnQSQGAUyahTynwg7M7q19NoGK5nnzVhLJIFItM8NeOKEMHa9?=
 =?us-ascii?Q?YamM7kFMuZ29ISCB6VB3Fcnb7mY/KXD10ytoz1zu5kQRpu7ksliXGVtBuKwW?=
 =?us-ascii?Q?v5lmHguPZLTPG5yQU1A8Am7Ol7D/xpVqmG9EE5CN29P1fN6x+YoAWeyKJ+oA?=
 =?us-ascii?Q?l7fwupEl8+z5rGc5dxaNg2623IHpkeWTpW2FlcQ24nXxbmQ7jLk5VX6utDbm?=
 =?us-ascii?Q?36TcVrzAHQxYcJo6rnKBytFG7tvhDwrnDWKNDREMJe+zXFAF1XNNxpNesvEk?=
 =?us-ascii?Q?gV630WdS356fOimw1EFrhQUc7RXmAMQSMZvoy9IOuRYzrBXX6O3dHLVi6Ac6?=
 =?us-ascii?Q?pmMItktSWw50x2nG1Li7/FtK9X+QJCVDRLO0ccWPqoQ6eY+UzXEq/fHxbIL9?=
 =?us-ascii?Q?DXBeD9VTwk7W5YlIw25ZF9nWdnFBOpaPC554EZfkMMuo8OWUz0UQAVij36w0?=
 =?us-ascii?Q?X0LZe4ny1D1GVmaglZsmY9CldN+Kj1kL90FLWSzQaT0xv4l8ssr0niX844dX?=
 =?us-ascii?Q?XOJISOvvCBrUYbWG0Y8JdjoQjaMt3s9F4s1lbajb51WYLij3k4z8a8rCu2Eg?=
 =?us-ascii?Q?Q6oZwm/RoSII8khSelcB/OCDbjsH7ZqYqM2ng1Uk0dkoog32pwgMn0tAbeet?=
 =?us-ascii?Q?rBOS+2LvX3g2/t4ZQx6On+73pt8aXW+32Ez6oeupav5roeiYixxDAFl/tIyw?=
 =?us-ascii?Q?gyLaZpg0ysUz3Kid7j+LftkI1jQgq8oNcEEODrLPnQo5RdQvGnKuHWdQa643?=
 =?us-ascii?Q?NYE+v0DAdqoIXMcR484xmjgaX6DhlOTtpCZpOK1iYjOBBqt1VJpZuNOidFFW?=
 =?us-ascii?Q?nDkgQyRdj/F2rW7e70ATQVfmxe4dkdsLpVlZZqTgoUOPNSRW/ugRhOP8ob89?=
 =?us-ascii?Q?m6Szf+tsV2TlR7bqqRo8yZZmFkmmJAwmNom8M3M0YZzXWlh2P3spAhbMZpJt?=
 =?us-ascii?Q?FT2pmacvmgDxR77PSRCUg0LhmHZ/8+G19X8BpcqsqujNZlceSXgJhZht4yoN?=
 =?us-ascii?Q?Ks+Jaee7xRoDQxTFqBHSZovGVJiNNcZhzd4I8ETncXJHxHi4sjRfO7Mr3RiP?=
 =?us-ascii?Q?/Ct6p1j63lXw60jH6pDQMkJ+fG0TG3wd9ro2l7HqqK1ckgfqbmn+eUuW0ynJ?=
 =?us-ascii?Q?XcBwbaiF4To19k36fPEfANVA5DCHE+Zp7O0hD+CZ8dcmegbXY8hHy6RGNGrG?=
 =?us-ascii?Q?ZgWReS8zLM48n8EuiFucpaFMMGgOFjkHJ6jKxYROgfbtknntPHsPv6dk0O/+?=
 =?us-ascii?Q?VZT0dQoKT47AnLVgUfsseOIAiJH69tRwVu5/qhHm+yv5e5Duk7PJ8PedGU7T?=
 =?us-ascii?Q?fh92GlUyAQBvI5eTCHG/nTYr0t0bOZE0iHpxogEa/OKMpGqAzH72uRttNUKG?=
 =?us-ascii?Q?a/h1l91uZ0WTcjjFv95rjcVOniGdqePwWN6VahXJpCJqA3KlghaS+nZaYJKR?=
 =?us-ascii?Q?2XkzTi6jzc15M0ardavsO5luD5LALHmcP8N1uatcaaHbbi2GNtTmRpCeH4GZ?=
 =?us-ascii?Q?sTXVgKr11+om1XqLknY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6502ff-5878-48dc-3818-08dda9c86ff7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:29.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiVneTHqQpD4JRl0pRD62ntGLKDenKFxo2plyzYkqW1JnhEYzCWPffTUTA/kf7KN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On 11 Jun 2025, at 23:54, Baolin Wang wrote:

> Currently, we only test anonymous memory collapse by default. We should also
> add shmem collapse as a default test item to catch issues that could break
> the test cases.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>

Acked-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

