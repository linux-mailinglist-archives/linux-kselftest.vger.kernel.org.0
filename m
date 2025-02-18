Return-Path: <linux-kselftest+bounces-26880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39BA3A3F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EEE166EDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E526FA61;
	Tue, 18 Feb 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SyvcYdFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC826B2A9;
	Tue, 18 Feb 2025 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899107; cv=fail; b=BtrGvETDsJiRM+rbN/g+VSbPb6aa0aFNDk0vHrIwyq18kUy+H4Gy6wlN0cH/1iGU5S8F5CvX15A/UxZi8/39MuNCPnnr3Rn6nItUxCuj3k7zP1F52Nnv1yquC3LY4gQfLq6rKJJOkngE3RbWKkwvTWZYo6ghA6GWEza80JbWYuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899107; c=relaxed/simple;
	bh=KWiKwYalPESskMxygYrqaSxvCB5XVmzfTd9SmkO70/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W3vFj38QnK62aFj0ezb4y/55wjqJVMqjvpG/NUcZEOPmIxoClwRLzrUSE0R3CrAUwc6pweE2QH1G4hI0pxH8CSPUDCi1WVZjWKSlGcwmObS9N2J3jFZ4EEU6FMU71UbUnviPJTW6K4cQAUiIrYLRklZGaPXHMiks9/E5iW+Ztyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SyvcYdFS; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfpZEU3Osyo3TAU+iKOuAUx2YNgeUeObYZ88jLa/as3S5HFhbCrj43SJUpZKVgy8kKrG01sjdECl7UPfNwcgbXd56TJWa2leAPfjWGvetCBVS/NkSIVlDI45vtY9mF9xppxr22Pr1otsbnfng76Juw0Y8hC21Zpe7JA0kLqSFInruVz5HCWHy00N5bwSQKkYHwaTtrukvZsrHHC/HzWAv5K7EO+U1DbNIVv9/1UZMutYUkzG3/5NYFudu1VVYX+XA4D2zks1pWMHyUn7Fm0KQOiiq3rj6H8e3TBT7sDo3jKxv6+GQyuSehU2S59UWZrk8hGgHiaRYq2I4/8tqtWpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gfLmke0nZtX2GLT8DLjLRR+XW5174lTxRzX6acr0GE=;
 b=JVINBn6RNzH7SMx3uKGZ7pBVCFtDrMhJ58KhmQFln6Pbqnl2MelpMm38ENXBRNOfdn/8wD6h5x9tlfm6dkPB96Kofy3zNb0GTQfaVj0kbWvkkU+WJT+Xe9uCTvtxbnH96vL9nOZEXlyjdf1umO6q0iVELi5u3qRz2YjnBeod1il3zr/ErZTGsGyqkOlY6aEhXWJOcyEDdnLW9iCnpeLbFykEgmZ9uYqmasYKfG2YwVSpq+L2a8Ece7CV/dAJE0Re4BZas8k+SggcNFbfWzenX0HYW+rvcyOrMomdJJIJKmczJ1fcCHjUd1FyDPJxEvspzRUyk6PmHaLZEDkXGTehaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gfLmke0nZtX2GLT8DLjLRR+XW5174lTxRzX6acr0GE=;
 b=SyvcYdFSYUpY+lBc3gDet1ZsafbcXWNrs6Q9XxZASC8eifqorbA6EhKiJDAYm4eBvopjVW0RK43B78knR991Bv8/Ec0dMoWyPxSu1Y+xNAQfq+XPulkJImNIpyATJw7yIPlprwPbwpmJt6giq/Cxz16LizaQxM05eIqS4f7vkNc6j2g6duoPr6mDK5Q7M0Vyd3msl56tXUK7AQ8LYWhbyXKvSoRtRRxkbtN4apvapRTU3/YoZD8j86+Wcq+ymTL+gB2yMYiVxmuigOw1zExzk5k7MLK+hP7bBldav7t2xCTgefH2FbqXpVyvPkAiAx9ZzrW9ve3MO7Mh0K1938xmXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 17:18:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 17:18:22 +0000
Date: Tue, 18 Feb 2025 13:18:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250218171821.GG4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:408:e3::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2b05c1-8cce-495f-635e-08dd50403f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Kkw9Tc/NIDm5rMfEIdMgifX1nWLh/WK1lYXPMxYH1n0Ug2Q4fgwAqEqN5tH?=
 =?us-ascii?Q?XK2U39GOyicPA8aHpLmasSrICrmQ6rOPLQanA9KAfg03KilmT56yTVESM8Fx?=
 =?us-ascii?Q?7CyoDaw6xC2Km8KD82tJjTkkkVuB9rWjc/MNqwfpvzw8KXRi/Zu+myg/zYwi?=
 =?us-ascii?Q?f0IT9C0x1diMIJqS9zbutrOqNQVtwbmDW9zz31GVHNqivsWTb8Qb3zbqkZ7H?=
 =?us-ascii?Q?brnN2qSlhdWo1bxqNLqAHuB37UkpEgKEzRe358JXo8y3d/xGqi2gmsG5wYB8?=
 =?us-ascii?Q?ZqtaQlTD5dG+Vv1J/qKgsSZBrDIOCnz2v6LQHTpzLLTeTHwV+iC+UIgBfTjy?=
 =?us-ascii?Q?voTp0eP/MNdJ2KCW1sLt2aqimtMNIpqLazfFQAjkpewFVlxbWYS9DeqEQ4uN?=
 =?us-ascii?Q?aywT1DTGNAP3NCvahCl919vkYcpGg5nwTllMYk4wJlDCAKBuLRrIGavjtLZM?=
 =?us-ascii?Q?rgtQOqX/tB8c/EcdQ396HTHs+RZ9Ar2HeDBD6j3fvEio45UL8dWucuSpF/97?=
 =?us-ascii?Q?lO5SYkD6ggBePBhhvspuJJMljmvuYWwUhPN2BnKDR4vH5wwqZLG5HqQA/o0j?=
 =?us-ascii?Q?4/lR5oBsJ0kCH/MeXfZr0CcpbSY3prb+c/8nw1RUZzqqaSQEe60YjJ/leU88?=
 =?us-ascii?Q?h6RBpu8x5yLJXHBUYdgmgpI16ktR2DM0dLL4C1u8Xf7/31ZuNeRO/pLb2wwg?=
 =?us-ascii?Q?ICfudC5iOlVaALkMiB7/NXguieVVz6b80WLlh/ZTUSTo4smopCuc/LlUWTOs?=
 =?us-ascii?Q?KrziYj1HizsDRJYgMVt185O4TJ3/x5Fnqm8z1WtYIP/gpYsgaKAlkRNXY25s?=
 =?us-ascii?Q?58MiWCUfLByf9iPprVcadiF8H58oRcaaidqFczkzZq3k/853avYGbR/qGAUc?=
 =?us-ascii?Q?XU+W5dcukx7UwvB/ANoqslraRmUfapjQtiKF5LEIhdPFHhizxthSsHVBFZ69?=
 =?us-ascii?Q?ObQ76UMD9TgPZjpBXHbZ+/AQYEnc0gvSZnPZewbHjbD/GozuP2L+m6h0XnLz?=
 =?us-ascii?Q?1CC/fM2Tim3N25ek6uGfiqrYgG0p49ynRpBzofrynIfhZ+QSnc4wFCS0RV7j?=
 =?us-ascii?Q?CkY56WnDpTwGF1GI3RcLmUA6o9rmGs3EXQFXgCOdwG8ckO9Q6ew2YG1OhZjs?=
 =?us-ascii?Q?0oh9KhDwTPY2Eto+L8q0ATUf0SXkthf+t1y5MV1vuxanwu0pQyOSina9jXdO?=
 =?us-ascii?Q?mD5q8U0ZvXEdMUwY6H2pKGdhTxW7WHJtvGcjjV/zSDfc0x4LNtQo7wa9fn/h?=
 =?us-ascii?Q?77Xk3A/gLhQ7D1Cn9h8hC2q2YBoHf4p2lKZbXIhOFnWGmySyN4/tuUevj1lc?=
 =?us-ascii?Q?kh+BremDEulIrfayqdQHuoiuwJh5M6F3qTL8BF37uC255x4N2EOeWKO3qdvo?=
 =?us-ascii?Q?UuDtZh+6i91NpcFmhV30BYwWXNqq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bstbRdZ7q0JdaclaivnedMWTi6Fiyyy/9bNBFO0w7Vgqun+8SE/eRBROPZMr?=
 =?us-ascii?Q?dTbGDz5p5BDlGpq5+Yy5Sl8Zk8oRJFWb+FCahsDV8Brkm5+2CeKC0Ykn4MZX?=
 =?us-ascii?Q?WgzZUtHicbOBlfc0qFnqdO4p2+pzBEj9s1H2Aef/s+eA64ln/BQt/Z6K0309?=
 =?us-ascii?Q?Sv9ALDRi/JZ85uaUPeO+IGKkPGC+ePOjNeosrJdG+c0Ti2domx7wlCcF9BJM?=
 =?us-ascii?Q?VZgmmWspx2UaXgoYDhCfDjgCLMq0OtnVP+GqIvzNGaD2Mezclo8/4/fVtmcU?=
 =?us-ascii?Q?zKghQiNyLRewGucmSZGIygS/Y7YXolxv1J5uD6WshsLa8vMgZjOCcrh3ykz0?=
 =?us-ascii?Q?hVdLb+r4Om1d4kX7gUDC1GoIzYV+Ob1kCodR0Qlrzmw4f7Sx5sjNYkOmMSgR?=
 =?us-ascii?Q?vfDwLxU4GsYHJfCBCsBp39LJnCmTYS6Qa5LoAVmWxzfCVbR/+IQr5GkYBsi6?=
 =?us-ascii?Q?XNLZ0b6QhnTBT1VYjjQeIfsWEAvVMjAGz0/laTvqCm3HUwderkLfudMjWsug?=
 =?us-ascii?Q?8pvYKLSjrUuJD/XE1SExLlj9RoLebrEgpiHPj9e2NjGLjlHFLkIJe52q3XJj?=
 =?us-ascii?Q?N9q+ghs5E6Je6Sw2X/8eNTn+PT4XttWvFFP891p9muKC8li4A7nTrJ0q25j/?=
 =?us-ascii?Q?F0/9D5/BnxrqBMXXra+a0334pdTa2Hkc9cXUBORNYIYQrmMafg2MABT7R7CO?=
 =?us-ascii?Q?dejx0+Xy9G+f8iSQ7VqAcjAoe9NllVpOWsnyQ+N6fAIDLmcFks7NAOLIh9If?=
 =?us-ascii?Q?fn+hNbfjTNNH6n2qNCUIdBBL9bkp++KMf/EmFWZlF/6CwzJF/3gN3i0w6HyH?=
 =?us-ascii?Q?BJa58Wqoqjub+shwjGwMeeAdevNpaMNtNetDlYURMIjHUikS2sIwfdPjrxqx?=
 =?us-ascii?Q?olqGJ2ZbLxu0GyBRvlsvQLXraUKvQNAOnJFwEHUgrgQ+pLnz0Z8zZHkHfZRW?=
 =?us-ascii?Q?ip+YKRtEGlL9Xp/Pllx3Igj89kkJmbdoG/BCUFnn56j32i327P0z6HGfTfxP?=
 =?us-ascii?Q?saPfDM78n8mvMmte2md7Xh9u5A+F6ik5fRNYYqyZl4JpTujWee/tt4zyFfR9?=
 =?us-ascii?Q?ofDjT7vGvJ+/kRMJSUEkqgaO2BYzAmZTUlIp6txsVxkhA7qu3LLnotMIqfUb?=
 =?us-ascii?Q?pGHe6Ii8SQYOh+H1KboREQURNQUqPxBa/XO0e7Kd1nDvao1IEkSeX5neUC4G?=
 =?us-ascii?Q?JxnWO9RFn9GQXCFzhEgYN0L4AzVIf6xEQahr53pH3ad7kKaX3XKTs8Ac1V/O?=
 =?us-ascii?Q?Znra1PolNWoy58vsTvH0PBYkTdldvdezYa20clW2N22RrQAYCRvEclc0z2jP?=
 =?us-ascii?Q?AyhwZxZaDc+FFMZxtwl1sAktGmoCsgycouX1HqkAn0ffqA53Ks1XzsC49sRD?=
 =?us-ascii?Q?o2NmrHJ3UYaV50VHaPXoT9ko/YWzM6k55ohbuzYP+UKYLCjWa0KZ4hbZ9GuE?=
 =?us-ascii?Q?F3zufBB7vnIWxGBbPzLoV+5blrp0MLHslcl9UMA2X1BCI1xXQN6ymOgq68yP?=
 =?us-ascii?Q?FFNWk0WwguE5QLoiYp1HJsNlFHD1UJ4yUqUhZ/uip0mkPKljzjz/qjtIUnAo?=
 =?us-ascii?Q?B5ZqGTxb5AH6HqiXT5A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2b05c1-8cce-495f-635e-08dd50403f3a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:18:22.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozsg+yGT8toa07QtimqYv5Ux2p1HBec7G2E5JYWtANYfmTOcAHKE4Eouozg/iKCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

On Fri, Jan 24, 2025 at 04:30:42PM -0800, Nicolin Chen wrote:

> @@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
>  		return -EOPNOTSUPP;
>  	}

There is still the filter at the top:

	switch (event->id) {
	case EVT_ID_TRANSLATION_FAULT:
	case EVT_ID_ADDR_SIZE_FAULT:
	case EVT_ID_ACCESS_FAULT:
	case EVT_ID_PERMISSION_FAULT:
		break;
	default:
		return -EOPNOTSUPP;
	}

Is that right here or should more event types be forwarded to the
guest?
  
>  	mutex_lock(&smmu->streams_mutex);
[..]
  
> -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> +	if (event->stall) {
> +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> +	} else {
> +		down_read(&master->vmaster_rwsem);

This already holds the streams_mutex across all of this, do you think
we should get rid of the vmaster_rwsem and hold the streams_mutex on
write instead?

Jason

