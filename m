Return-Path: <linux-kselftest+bounces-44445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AAC21620
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907713B78F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097436335F;
	Thu, 30 Oct 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xEoa1cLL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723212DBF75;
	Thu, 30 Oct 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844012; cv=fail; b=UhJt/6YKQv8gC39aYgby44o6OgrIoz2MUoBUvb6m2RbklDU7dLz0Doys23AvpK8+vzCRKtmHGFg06im3uLCyBzqZiCWg8pPuKTJPEH6Hbr0G65S6APxWtheRYpuhEmZrLfZo7JI4Yty3A85Cpno/Hu2TpvtjfFkg+5zR86kAoRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844012; c=relaxed/simple;
	bh=txewqRTKmkge/Dya9wBqYSZXd6RD8sdQC4zqyh1cXy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnRYp28xbBcRJQh2WTvS+MklPH9HHbGIqBooUTgXBK6AV+EKgaPjwwzNz56x6S3nTLWxgucRW0yZ/XEAbODJ/PKOaiRGQbSpC0xcvnJb0wXuKF6bOX/UDYHNHExmtSu0eOvlUCAzbaQOvc/ujB/bWfHPOWBYOWuOs+b4CAwAUqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xEoa1cLL; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlrLXwcONeBqp4+CIkOSKTRwosWWdQDSymTMOzj0PkuXPWd2+vCapYCurVmJMF2s7EykZdvX0G/bO8qB/iqb4imMoNB1N+j8EgXKqt0GATr3zsfkews163VCon7S3tIH6mwCP8WCkMRNclbZy7Kxgq7pO7Fzcer/edx/NNDVlp8EqEveIHkT6+HtkaEP6lr/zQVRUmxkicNs66XocDC8gaQnbUZTEB/MgnCzJpKHqb0h4Tav5boPy/OOaGYANG2iT+MkQ5idjOdA5SGW9W7F0Q/+m9Le8gQSYc1DMqgSYGnsX6ytEHDQJawuuZdp0sxpLLXcxljanzbKHBguQh3HFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNyZ2OzOR0B594BA3xi5XzLIvr7QzoPNVkBJu0Lss88=;
 b=oYnE3hp9vhAMrMBAeGeiUnK+SLGfoD/E+4E6cR/SOyOKpiORFIQGcxta6dwzCN7vAsv5QUDNV/fixH/4dURvoEeDzWF8EqRZbnWclKrq69clDlw+5w2rmpNPl3ZVCcNd6FZf2Dlot2u5eSYz4Rxn+yNoDk/7wOZxCwolLDg5z6wkPykLKADmhCcfrAhkqptborqkHdQEFlV/02iXIdsi0peAgzF8UcFwegHNX0MtsmRm9/u7tq3YW5Dh1u/ZmI2buPeRaQzrH3wxpm3g3fGLr0RqRhLRHhUUa4x6FtQjqpPDI5o3Wtmnw24MbQiWSUxzBj7bJDjF2uIAofMnXVJMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNyZ2OzOR0B594BA3xi5XzLIvr7QzoPNVkBJu0Lss88=;
 b=xEoa1cLLUQ73OXkLiTrFQKiJvcOWU6SWpaj4iTxhkATpc6dFImrk5o5ezXUKfPb80cRpVG7cbeZg1t6qUHQ9GtaJFB+Yrz+e4VH6leyfjM3SwB2XkTs51kk/VVbOhpp0n86PudEQ64wCeAXSPYChqhpxgZiYNz6j/x7kudsmmIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:06:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:06:47 +0000
Message-ID: <12586053-2ea4-4666-9cbd-dec6ff1d6bda@amd.com>
Date: Thu, 30 Oct 2025 22:36:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/15] iommu/amd: Remove AMD io_pgtable support
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <14-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <14-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: f70035ff-ac19-4a89-db86-08de17d6b537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNjZVY0WVZMYkx4UUdPYmg0TkR4OVhHUDNsM2R5MHh3YnZCYWVqWlNYMU9X?=
 =?utf-8?B?T2xOdVBxczNFVXVJb2N5RE1kL2hZOStocm1kdDNPWExodDgyZTloUEVoYXFI?=
 =?utf-8?B?VFMxSXd4bVVoMGRsMVdQWHNoMUpUMkk1Vm03em9INzU1aDZtUmZybERRN3NK?=
 =?utf-8?B?ZEplcTMrNlJHQ1VETGNESGRDVjYyL2JpeFJjN2U2c2Y1NGFmRHZtVnRqV1Rn?=
 =?utf-8?B?SU8vMFlOY0dEbXFXbS8xQ1VkN3lTVUtXVmF4SFVvZHpuTlFTSWFhZGF0NWsr?=
 =?utf-8?B?N3VpMCtVVytVVmNsSnpPa0szbnF3NS91RmFLbmFvRXpCYS8xanZiSnpkemgx?=
 =?utf-8?B?eDkyR3FYVzlUcDlYL01KS0xJTENmU1BTODZaRGN5MUVkdzVpWlF4emRXUTVB?=
 =?utf-8?B?eHk0dlhpRmdZam1MSVFUNFZIRnhkQnVkdm01MHA2ZGtjU3RiQm11dHFQS1FZ?=
 =?utf-8?B?cVdqb1k2SHdLMGtNSGNwRGxTYnVncjZuRzVjSThzOVRTTHhGbTlSaHlNVGRp?=
 =?utf-8?B?d00wZHpXWFdidGVGMWl3K0hwVWk1ZlduZ045eCs0UXc0andvMDJDY3VkQkEy?=
 =?utf-8?B?WnlXWGVUdXRxdThqU1ZEM0J0aytPZHJMSFBpeWFwWko0Z0Z4RnNoUjRRNVZ1?=
 =?utf-8?B?OTM2ZHRtU1FRY3g2TW9yK00rYnVxZk0xS3Y2YWpvMFJNTkdObENqWXJiYm5j?=
 =?utf-8?B?M1NGa3V5RWtUeGwxUHBRYlBmeWpIVkJvR1ZyZXpSbFdaclB1MmZsRGtIMzdB?=
 =?utf-8?B?K0ZNYmp0V2hlTkZ0UitmbU4xNkVBbHM5NUQyeUpWTVJ4WE9rYzFtQTNzdk14?=
 =?utf-8?B?akpBaUVDLzIxdDdocHpTK1RISFFsYWg4amNJN3A0dFUvbllhMWVtWEpITGdN?=
 =?utf-8?B?MG1mbVZuSHZwWkovQ2JHNmw3dXJGV0g3ZDhCb1kvV0tMODJEZGlYMjUya3gx?=
 =?utf-8?B?M1EwdU1BWUU1NHExdVVnWWxqSDhwS01RbmJJaUc0L2I5ckd0eFF4MENudjZo?=
 =?utf-8?B?TC9zM1N3UnNma3NXUlRXZkJrLzMvTnQrWHlTTXQyVm1HK2l4cGhpY0R5bXZp?=
 =?utf-8?B?UXpsRHFZbUVwVXZaQ0RTS0xyejNNRWJIRXFqVUw3T0VwOU4wZHM4M2JtVW9k?=
 =?utf-8?B?MEk2RlZObWpGbWVQSzl6TFVUdGd2MW12YzBwS1V6N0xXaVJWTTAvQzNBbm52?=
 =?utf-8?B?eXFPSVppZEs2UTFhWlFFTTZCNVNydjJySGFtR242Rlo1cnRIaWxEL1Rsem1B?=
 =?utf-8?B?TWZxMEl3ZmlXT1hXVjVyTUU4TTdLc3U5d1Z5b0huaHp6WnU2ZUNkdlNpR0VF?=
 =?utf-8?B?alZSSFBHOTVpd3Qrd1JXWmdWTVUvQktuUTRLZGRwTGd0cm9BV21MZ1Q5NXR4?=
 =?utf-8?B?bkhmQm1UREI4UWFPMVRjWUt6bUU0UkF6cXVxT2svWmxFMGZSK1BmbU5kUWZI?=
 =?utf-8?B?VjFYY29nTGdtZ21lY3FJaTdGV1VlRTNDdS9ZYi9RUmp1aUhtTVpibnhvNnBp?=
 =?utf-8?B?VU1KaHhwWU9JUGU1L2NsWWMzWE95ZlRaMkFwNFRsRVAxTXczeW9HTUVLeklM?=
 =?utf-8?B?TlNUSDI5cmUzYWtTS0NaQjR5MWlEZTUzb0RKZzVMZW04U2NHeGFJemU0RFdT?=
 =?utf-8?B?c2hXWmhldW9WMitXNTlnNUl4bFVGbU9Td1N4WmJkdTNleERjbDlHZ25kUnRG?=
 =?utf-8?B?MHlkb2xZMk9ncUw2c3ZvUy96bURqVlhEUEg4L1ExR0s3WEdnZUF6RnkyMXhy?=
 =?utf-8?B?eEtOaTl6TU9ZMjg5VzF3NVI4eC9QYjZxZkZjbzBEN2wvK0FuY3hOZm5aS2l0?=
 =?utf-8?B?N3ZTSnVJbGpiU0U1Q001UmpJZ2ZxMjlLV0pvczlRd0hvYS9ZdmhuMUVmNWE5?=
 =?utf-8?B?VnIxejRjckVRRk4wdE1FS3ZDbHlBQ0xpTktSOHFTRUkzZ0M0RFlrc1JrUWZm?=
 =?utf-8?B?RmxKT3ZnbDVlRFFEcnByN29KWUJTWU9zeDZMNjFPNjZPalcyNDFybVFpcTdC?=
 =?utf-8?Q?KyIVmfD5oMoqfJspB4EgUpcmFIgFzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFFhVnRnajRzVkJ1MkxWMEFmUVFNWEx1WSttanoxZmdiYURWTjdkbFZrdFhL?=
 =?utf-8?B?anpqRG12YUJucS9ISTFVWDZoSytHejFhcnZQbml6M0pIQnZmZkYyVWZBUWs3?=
 =?utf-8?B?d0c2NU1KM2YzeS9IYlNmRk1IMWs1Q0hEaWk4akNqOTVmV3d3QTV1Y3piVWFY?=
 =?utf-8?B?VHFqaDNSb2pwZkRpdGFQYnJaem9RSzlPVFRBSUFvdkJ0ZkF5U2I3Tmp2MW1S?=
 =?utf-8?B?MmFjUzRFRzBWSFJDUzJBbVQxVUhqN0RVUFNxbHRBaUExL3NnNlkwcmJCVlhJ?=
 =?utf-8?B?N21aQURrNEhnZ01XZUJKcWUyUloxeGFXcld2bW1sKzI0czVxaTJtSkx6ODBJ?=
 =?utf-8?B?aXoxM25DSGtTWC80YjNFd25BS2lSaG5pakxZQVRIV2lYS3NheWNJaEdyMHlw?=
 =?utf-8?B?RDR0ODJSVllxWXN3MmxBK0YzeFpZT3FPVU1RcnlzU21IeWl3eHRlZGJneDZC?=
 =?utf-8?B?YlUwdFJuQXJDYmp1RUpycGo1NUtBNWdIaEd5R1UyZzByclJEMmxXYmpFV2VV?=
 =?utf-8?B?dEFTa2FUdXNITVVVOG1DQWc2aXRvMjV5MmZIUVlqMTNHemFzUlBwNjVNWHJY?=
 =?utf-8?B?WnUwT3pkSEgzK0Z1SnhGOGUyRkxVaU9IUGJYeUFSZ3FpSFZKUHZXRVVEUk9R?=
 =?utf-8?B?cDRsclJHeUYvUC80OVFTY1cwNjM5SVpHOW1yM0FrYnZEanpsZlRXb3AwZUVH?=
 =?utf-8?B?OU5sRitnSnVqd3V6QStSR200UjF4ZG1KTEFRLyswbWJ1bENrUyt4NGFRUGRB?=
 =?utf-8?B?aEZrdjlBendSN0ltbTN1ZjVDVjFPTVVJaXp0WVVBajNhL2VYeS9NUnFTZ0sv?=
 =?utf-8?B?eElQT1c2VExaRGNYV3hhODZuc0Uxb2liY1ZaOWhFU1hsL05NQkJvaTh3c3Z4?=
 =?utf-8?B?Ukd2RW1UQldMempQblMvZmIvRFlvcFpkeVNnZkxpeDBSRlRCME0wdGw0WEIr?=
 =?utf-8?B?dVdRTHhRRTRmc2JLRTdCV09DSUI5cUUxT0MwQXZPRnlRWjBNb2xDd2F5OUlE?=
 =?utf-8?B?cU9Pc1FLZGF3UlJ2OGdTVGtWZEcvaGE2R1M3OFlVNm9CN3BnbTdHVldkellk?=
 =?utf-8?B?ME1zUFJLRGN6bkJLbnVYaFo1bDVablM4c1VpTFYrUWg2T2g5QkRsbm1PNldO?=
 =?utf-8?B?QTgwZEVmUEtOK0QvSDZoRjZrd1dpTUJJZlVPdlpCdC9rMU1YbDBJTlRMcmZY?=
 =?utf-8?B?TXE5SjdTbFRWSE9xYUk2WTlCNWNxZ2EzcXhZalh4a1dIYUFtL1JlaEJmclpC?=
 =?utf-8?B?NitoWXBXUERobTNQTnhBZWVXZDdqMUdFMFUvWjBIRVh4WC9YNzI5UEJDaUNS?=
 =?utf-8?B?ZEFUKzRIYVhTL3BrNUpsRlQ5MlFoZVZxMWpzbGR4Zyt1eHBJVlNqZldDbUZu?=
 =?utf-8?B?NVAwcW56dGNXNGR0M0hEZ0hNVVVOQUtNclovMmtNY2VXZTJpUHZUTTlyZ3hu?=
 =?utf-8?B?WkN6SHhOcnVFM1k2UlFyVXBnQ0tlK0RLUDhDYVdYWTdKNjhKUlVVRm41dFI3?=
 =?utf-8?B?ZDM0N0tqK1FTZVVaa3BkdkZDdUdNVmN5UU9NRDl4cjFPU0ExOExibkNLQjVH?=
 =?utf-8?B?WnFsVlJscXFxMEVaQjBTclkvTlMyQjh2bnFpZUxKc1gwVzFOQWozZ2F2Wko4?=
 =?utf-8?B?MWpNY0R1NXdHc2pFUkh6MmV3RW9pbzlVU2Q4NjVxYmF5blhCa1JRUWgxbVQz?=
 =?utf-8?B?dGZLeHdoSis3dHQxcmpVMGlYZXR6Sk40U3VTZmdPN0lHeWhjS0hSSFB5RmpV?=
 =?utf-8?B?RHJSZmRqTHNZZXp0U1hRejNQU3UwZGMxT2dtNjU0RTloVVpWL2ZTbDhDMWdS?=
 =?utf-8?B?YVNBcG0yZGtvTWZGMTFwSXhKZStmcGJoUzNRcEtpU0RBYkUyOGduSThxV1Ir?=
 =?utf-8?B?alFJOEJLb25xVXMyWitWQTdYVi9jMVVyd0VYUlpnRVhPelZwTDlFdnB4a3l2?=
 =?utf-8?B?bEpOU3NKbVhWOGhpZG1vbmdjQ0JrcmRBTDNUemtxODhRNU5MdTZrdVV3Zjd4?=
 =?utf-8?B?UXhEK011ZW1WSFNCVTBvK1gvdGxPWDNPcGxzZW9kWnNIRUVqbWVkTnpnTWFX?=
 =?utf-8?B?eUpuenh0ekVxejRIa2R1UVZ0Tk00Z2ZWSVVCZjNMRXBwYjlIZDVYMUhKcjRQ?=
 =?utf-8?Q?arbjoRpocKeffczl43VTZFLb8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70035ff-ac19-4a89-db86-08de17d6b537
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:06:47.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYAk57eoH/FScgRl2oMBNSQvXRWP4jDmtNqvMMgnuhMHIZiwOIwuBUehFOUaBUg/saAugjGc56Hp9Qw7yDXwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On 10/23/2025 11:50 PM, Jason Gunthorpe wrote:
> None of this is used anymore, delete it.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


