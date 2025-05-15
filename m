Return-Path: <linux-kselftest+bounces-33100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57AAB8D9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FEC16465A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEF258CDD;
	Thu, 15 May 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ly6alFl/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88A2550CF;
	Thu, 15 May 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329725; cv=fail; b=fwECUur6T87xO16tULAX5ExePTOqM/liZCKabuhQxOdODlICol+k9Ccmak/YkV1HbTKJtMSixPPrp9KoMY31IbfCEk7Ne4ZGd9Z0GPgPTPfM1bTpkVVEhkPfpsnD4pJ2X4CRa+blXTQ5CI2U2UYnkkhLOylz0q+do+FgA4cMWWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329725; c=relaxed/simple;
	bh=pT3sduX+70DaXkx5tWHuEedFP+CAhsQ9M2BZb+ZGF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyd810YC5lozLUh+Nz+RbDjh7VQf6HiKmSFApLLMiLkL5sm+mlBB15TW77cFJd3sa9tdUk3OhwPmxmZT5lcgNYZ4DrXcIf3SDZfPK/Dlsj9RTzi6VEiBGJdWj9wubV9EpCgEbz7zFZ0IGUntEFTF+KYPNpSRQKxZ/RwA0lGZgOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ly6alFl/; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5efdmlKJ72zxCT2YY/NQF43xS3kAVmuUjuzxnDOrQSKdxwFCsb8AM2b6BLLGdifF3BbJt4doaod4BLLJyw41WS04pjAnCp8e8Qit3VuonhcckeqNG36YpjKkfafU8HpdIo4OOKpZBDHWzwqIcOhBpTRkaBXzuxh07ax7hfXIdlsw32TxPY+Wt91GcKYj7A2gFvGQ6UNNAAibQNoGO0Zs9Rzd72NnpVd5f/50A4NKgDNh+HNOtaMMRMZkWYnV12P6ddg/YVGnTqvucqEWlR+rOKz+EGeCXjbU8ejhNExzEyQ8r4xWK985n8uX5Aw+VXONaj7LtgY/cbs/k8sto45gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFGio6Nh4ZHh1BLYupV4ANNGrv3bpEstsbyVEllzoas=;
 b=nGL01A9vFqSndW1gMNzBZMhZGAoON4j0Ri+d9042P1uM7lVOBetZE83xNpjWCtwqWxhnwjFzkmcWWiQPlNG3DGf2C9RPRO/uK0qb/xhTdqht7Ja59kDay1GVEacA+F1outSVeRlebfsDQMFkZAEU9oRJBNIB2SX/QpTUg+nnj/1KAG7dyERGsq95r2XXs/onEpNXK3yLHm7W+SCKLC8j1dTMKrKcwF7c5rR5U4KiGd85XSyx1Ty7iVfT5IYFWFJKgiMp1e/44L3H3tCJWuDcPU1908ixpfdsE0j+0ojQM74irBN7VuDCokwa0OF6ePObbwDh1YwV69q9ApihQ8WTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFGio6Nh4ZHh1BLYupV4ANNGrv3bpEstsbyVEllzoas=;
 b=ly6alFl/uIZqr46DoJvcp5Tp/URhkB9PFVrz/vqvnR6fLYojXQGy5mXuHFra3M5jbTsPBuZWyobSatKIYJD2DlDagdSddNuX4dj67jvY+LuvD0SBJ5Z9ZcxnazZugURxtmJYwtpFJpQQksYy7fgZheGpWjZyH+PNDzN3SroGNesv4mPKVi9/03vvzi8t1IADmU6DO+0OQibIavE3puAGz4Msx3mkBCjSW6oTWt+ymUa0p8kEV2rqk1HnroByHSKNxW3LBNFHKPzBGo7nkzyF9aIdHo03Rq/zoKgPb9TXOg4OUOcMpPaczgCDjbBHgE4DHtGEIg9QbjsvmtwF/HtGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 17:22:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:21:59 +0000
Date: Thu, 15 May 2025 14:21:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 19/23] iommu/tegra241-cmdqv: Use request_threaded_irq
Message-ID: <20250515172158.GP382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <e653cf3b204b97eafc40e40606ffdcfeec8a9837.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e653cf3b204b97eafc40e40606ffdcfeec8a9837.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ad5de6-8c94-4c41-0d00-08dd93d50031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoTfoNR8zjm9di6UT24myzP8ALonHKI0M2ow5c1K7bgr51XnuDWMRkyjWxd2?=
 =?us-ascii?Q?gy0jJbvp6O/RerNkaAv37yJ8qEmP5ce1pkq51V2YzD/Wf248JYWiiehw852g?=
 =?us-ascii?Q?Fh4oMdD8WC7TXYxo9yrkG9gSzv1ilV2AR4qr/s3IVXSU5mwitlwmuKyUiXPJ?=
 =?us-ascii?Q?URMlPi/l+F/97VGtFOkGsW35oMNHDs9SN0SzrzEsPHDbTsZMJk8Rv21+OWz1?=
 =?us-ascii?Q?awnkk7b+OdykRmn3t9MooXtxwhK8YMzcV5Kd82vjogFfNBwFj1TJbxPFUgwI?=
 =?us-ascii?Q?UXzsHuqw3otNdSHp7pnjVCpVF8diOqMWBN4cuuUwanv9AzYIIrIHjvE072s8?=
 =?us-ascii?Q?n6d3LQzLEreTkyLYEOzcDWbWi7HnwrGFj8kXJHBlqQVDwLS4fzHe9D34ds4a?=
 =?us-ascii?Q?VuDxlc2YMlgmdWbPuCLMzr65i3VPlcbRz+Ttkh/l8fxq4RkIYr5coRrcOMa8?=
 =?us-ascii?Q?S5ni7l6PFNOvWWFpzSy2JxC/bAsbemPpWMcMAVSf0ecpBwNM1Nj5qZKcXFiC?=
 =?us-ascii?Q?EOOVD/1Dxmn0Z4/FxVzuOHHDUJZP+4nuKYqixyrJulvvC9EF40z09A89Uu+k?=
 =?us-ascii?Q?3eG8hY4NP/TM81TPthRfoVwVRM2C2jS9W2tuys31wBXEfL9LFqZkiNELT1vo?=
 =?us-ascii?Q?GiI9hyHVC0xZFa6mTRqnDRu6Du6V+fcesILVz3+H0EemVpaoFpyhyTOzhoc5?=
 =?us-ascii?Q?RIsM1rM7Hm5Ta4EkHLBl3i/Qq/3oIxy/eYTo2+bn6SBdIv4yLzndiQTLM7HP?=
 =?us-ascii?Q?O6yK7E3Wd3c/03LYCDDZDtxuks4qGe/Uc9ElkjnV9lrTVmt8embX4kXCas8o?=
 =?us-ascii?Q?L7YdoMfevIJe3i7ZavMwIwXpzfvAGb/66SofjW4fP03SYtIpzq32AzFI9f7J?=
 =?us-ascii?Q?djpMQnpAnXBnVSkZii+zhzLevd5Ppej/UaaQb5NEQLCzp0cTIc9Eu+yjg8+y?=
 =?us-ascii?Q?4Hq6XZAWpgpHoMoMbS8+f4uwmAcj3MMX+c5B5MIAm1l4J9tsgLwOg+w+QJno?=
 =?us-ascii?Q?lRrhXeeRXTR0S/SEy04Hgmvt76u3IBXw+cLUJZ5T5NjWFMBInKmnRYcATv5p?=
 =?us-ascii?Q?ViTN3+E51D1KTRyzUAgdgHuUE9600SfX9Ut8gjmxWkaWVyf9vsBd+/BAwd+x?=
 =?us-ascii?Q?cAUTrkZN5EbpEaHnl5X9EyClIZk3xUJPTOS2Es/VDkvuNAo3DOzOOGdyHif8?=
 =?us-ascii?Q?3MEbB+MUiJ4mCdO++H/PAwvEBKxWHZdzmVMfOUlDLeUJPNDyoh5O7MVmbq1D?=
 =?us-ascii?Q?omWcRkFyUdQZHfQSbnxkznRD0j55k3CTpUjqxLS6uYv3lTdTkYaKFtrPQzoY?=
 =?us-ascii?Q?J2mBiX3lYIFHf0iHoRJU1gnmbnSZOQXy11MbVCtBuv+za3Unf8k6z3WOU74M?=
 =?us-ascii?Q?jSke/uFz9P1EXkl2i9j1r8LaBmbHYVaHG+eDWwCbIj+N9iQbrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p99Tr2YHlLkoZmQ7qVj5xg1LK2YK7RzEyuGRi0QvPQuOB/aNFX8HdCINFib4?=
 =?us-ascii?Q?di11daFq8P81MruW+mJ8suWkCoD0JYsHyqD6yB5bMiAsODzhTchNcbCyKQKG?=
 =?us-ascii?Q?kExm2GkkAasLftzO/YNJUcWSmon+dJRD4vQsvbqkXDruElZAMJOdwYD9a3p4?=
 =?us-ascii?Q?T1w7vpKf+E/w7rXLMtz9v/ToeXbGa9Mex4AFADKUI8O19HlS+Y5tXdec/djI?=
 =?us-ascii?Q?1DeSOoSxSu6I2ErAFlZrdF2Ra7Lxp0MIhGVfYonkK8LMGL6E5Iqy5nD4bykF?=
 =?us-ascii?Q?w2RYsx1/NU7kkDE4hE2OEREGwgiW3HJesPanwFqEpWD6IvNltUi0VuK0Y5xN?=
 =?us-ascii?Q?hDH92/MBxSqFLoZoNta19VdGFHfsDd122e5CchelprxIR7Mgbn4DDTWinaR2?=
 =?us-ascii?Q?HPspTHQuqGD/AgzO/xA1d8rmpChq2Zo4EhRJdt0MUteFM7dtKh/niRCpT73d?=
 =?us-ascii?Q?f/eNQYoFQJTQBiN6IcTOiyCFy2MJM3dxbForTBfVehwecIWKomPomJlaJgkj?=
 =?us-ascii?Q?fdmAPL+p1sBVxaF5ylRYB8ng00kWYzL6FaifMQCZyWNGUy1keA9TkWVgyZRL?=
 =?us-ascii?Q?DeCyuQRGjmz+AMGxThINMhSMFV5ctqEbMQu4yZkomJUi2GGJhq0YGhOmOZPA?=
 =?us-ascii?Q?xw+QvZ/wTd6aAEHRITFHnaDwmKK2c1DpH3KVfYcuLtlhESGY4eXJzmlzFpSE?=
 =?us-ascii?Q?2IdzylVqY/w76gpYwlhoml8raJXn2D4UcAg2JfRCJQikD2WpODkJ58bu6a0M?=
 =?us-ascii?Q?CkZ9Lj4JMumxCmVQixR/X4krlcCLgcmcp2u2hyHEf0pK4lvKoLYfm9GyJOa0?=
 =?us-ascii?Q?N2DBAKw4DX143i+uAw5mcCdcXn/H9KNfKRu4IuYr8OFKdkoz6aBuHVzQdQJT?=
 =?us-ascii?Q?JnPsuE54HmuUwV2bGCfO5gSuuxYDdpO0FCZcsmix8wsZQr4nK9BF5HUqUEhf?=
 =?us-ascii?Q?YKqkeHvj5sAxBQLRGnXsOAw0xS+OBei1JvFNskx7IxHgNftOR4luy1AOl+1x?=
 =?us-ascii?Q?njY7BOjrynyfEq/Y+in/GinHzX4i3VIOdnHBErA4eLQpjKbnqg097omJdD5/?=
 =?us-ascii?Q?k7SYNyUjzXJTHhmCYOiFXGxvj/AAsUPhjrsfNKDTzMhD7qZPoxkXcNakKDFX?=
 =?us-ascii?Q?psI4tHFfZRe43VSndKqqWXHlLPKFJfznY7YIRVL/Ldjy1AE3bl9HOcf1YXZS?=
 =?us-ascii?Q?vyJsrboXxzneGivcrNcETyl5HjgN7DmitBbMqvH6ykTmmv+HVNvO5lkQDktQ?=
 =?us-ascii?Q?3uhrhJ6E8F+UzjWgIyZzOtE/3zv3HXQMl9KkHmEOJ5y3cWSgV9zYNCU9yoX7?=
 =?us-ascii?Q?dafFvRlr6G1dpYadmmDiVBRz2jt1BLFk/vhkJcVFTu3keQuAX5qPFJ+XrNbh?=
 =?us-ascii?Q?nmDiWgQnnpbufpZuITRf6DTgjh5n4IPiCMugS9vYmbUnPq9HwTXS3fyfLYjn?=
 =?us-ascii?Q?z72WXiHatqLklLkwf0YlipoIGKQAffdgQJatox7DycGPp6qY8Gzt1b7lKCQL?=
 =?us-ascii?Q?Z4pDzFOYAkuSTh/2fLOgoOMQwHUv9ILD3WXxL1BT3AtKs7RvaRf323zaRqVq?=
 =?us-ascii?Q?dffsl3+xZxg2NphROE0jtAGF4Amj6eORmLgmM9uf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ad5de6-8c94-4c41-0d00-08dd93d50031
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:21:59.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/uTpBk6lPUYNf4brVLOGs19RdUc5foFmfKleu92KyDFItQ5teXzvhiZjkuohPKv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431

On Thu, May 08, 2025 at 08:02:40PM -0700, Nicolin Chen wrote:
> A vEVENT can be reported only from a threaded IRQ context. Change to using
> request_threaded_irq to support that.
>
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

