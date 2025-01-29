Return-Path: <linux-kselftest+bounces-25383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627ECA22320
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB793167D1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905F1E04BE;
	Wed, 29 Jan 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUMJL7E4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96F372;
	Wed, 29 Jan 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172356; cv=fail; b=IT8I/Dtict39Ry1UOoOOCsDL7yvSLezY5sYg75GcypmTpsMyu0S1dUYO0c+jPdAOCQj08FhuqY/i6lXIbUuU3rJqbu7qW+p6KbhEU3HuSfXgU2VqvawzP2wQnxSeeTKfCHqp2aqJC398OqpORacO/75tr/lBqvQFDsXf+Jxzfls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172356; c=relaxed/simple;
	bh=IN4ZtsYuflahogSchSXw6ETvatavTeyxuNqEm/VlLGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JplSfGZyjKIk1WodSW0XiFC/t6+rMNk74D91iVCNwndqwn2oX7F+UmXdcgPDepNYcfg9jDqmDksk42PSMTWNk/DBb6Bk8r6ONVQwKvpu4uWQQEWRjJbpl+sF/3ARHgOH9AlncDY+ghb9WCddz6Eal7Y5IWR8HEFDF0Ev3/27xSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUMJL7E4; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0nvE8IRy86an/0xcVndmVu8T82ing0uIynWm0pP4GXomIClc8DJ63l448DhffUUEtGz0lG81DiOvupG3GvLpaXrW4nFKmbrw+S0+KsmIc1ZqSkK16y7yH8Cq+a/OU5SdK8FdmOI0uSvrd4F9LorgDghdMRTVnzmzATVuV6pp1NGjCHhc+JalPT7NuhILEK+CE2wW9xeHUTCugN3WnixSdPWENUfk1R9YJbkujPEcWq08h7yOvhjjBdDWWkFvtYdZXcl3FqZneeKH/olbQDaN7iBmJ2OdQWw6ncahOJy4/iV+caxpG2hvr4vVau3Ks2pehbmFWx/gkyaGET0Tk0bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHsUONaaX33Li1j7u4KBv4F37Vgfl/ab3Fw3qeTBPO0=;
 b=noLOzY4FmLH8C4XuuysGO5Vx5szNJlqHJN9+PRMfnc7mjb+/IMOuVyg0zQiAlRm2Q67E9raUtlYHeeHjgvsZYrjozppT5jVBEwJfCEjKAbHauzopUX8drOFoplPldx4RlfSbVMFRis/on6vGfcOQKj7NhqfhWhGHvxbaTrInSy/LxYgh+16xlYkATDz7CqoUmCLhweyKMHJ2LS5jXSW/Y+n3QNvpb7JwDhRst0mptDx8VBtAtGCG/Iv6w+jQOX3RMBvU1MhT95HgZafPcECN4HgZN4vONCx5SQq2I3knV6e7bLZs7MNTheL9WmeLg5vxoDXbimTPEqcjauUApC9K0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHsUONaaX33Li1j7u4KBv4F37Vgfl/ab3Fw3qeTBPO0=;
 b=dUMJL7E4G3FlxLZ0TaST56ILqiz1PgW+6RH29nNuVUXLOD9iR7W44IwUrcCMau67SShyg/DwXZ3NFpVws4e+HujOznkisX+aS/1DEkZ6qBeVORiWt8a86c6nsvkSHDSW7LMfEUJZIDq21nCJf8wRjB7U3+QP8FtshpHz0tho4uLHsDga/ZlTg/H0lUwSSNRcpnf2gef3tGCzf3m6spxxQQjMa8FoXXTeNyiS7fSt5GVIDuogbqIpxXA/17A0byX7MY8bsfizj9H5znL1zAu+3i4Y8Ih7K2yOT6Agb01X9NTsnrnBrEs+xmFIGs9CrircbM9B57HDzIxXG8L73RhSQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 17:39:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:39:11 +0000
Date: Wed, 29 Jan 2025 13:39:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <20250129173909.GI5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <21ac88b0-fe93-4933-893c-7ffb09267e7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21ac88b0-fe93-4933-893c-7ffb09267e7b@redhat.com>
X-ClientProxiedBy: BN9PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:408:fd::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc7bb61-b490-4798-5236-08dd408bd6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGE2UlNqOVRORVdhSXFmcThwenpUYWR2VUZ2VzBSRU43Njg3cE8vdVBoS3F2?=
 =?utf-8?B?RHdSNGpGOUJINExoYms0ckhpTlNmL0VYVzNqOEwwL3ZHTStPTGNXclc2UzFF?=
 =?utf-8?B?QzZsWGRPdkRpZm9lMHZZbHhidUJ6ZG9Tc0FTTVl6SEYwY1ZvOVBqVGt5M2x5?=
 =?utf-8?B?citWVjU4N21ncG12YmVHTGc4QUp6V2pML2lyMlNNWG9td3AwSHF4SzJmMko5?=
 =?utf-8?B?ZGhGNHFlSTVqNjQ0ams4K0lKWjV5OVNyWHEzNGdNRXNYMUpLcVhKSUtVbnhk?=
 =?utf-8?B?RmtVRDdLZ015THY5ejh5T1o2WmRNcGdBOVpRL1FmR0FhVzF6N3dpR3JXdmZL?=
 =?utf-8?B?QTlDS2ZnR05QRjhIS21mYk5qN1E1YlNqSllWdmVwUDdOVDcrM0FYaDMzU0ho?=
 =?utf-8?B?eDRUQVFPTlRCcHVFbENteHJZQk9TWTNTS1ZJNUx6MUZFTFYrVjl6OWZQbjN6?=
 =?utf-8?B?MWNoN3lCQUV0N2JxMnhoRGVJZGhYczFMS2pFRE0wTk1vTW1WNitubllESzkr?=
 =?utf-8?B?cW5JZjEwMUhPKytGbEp5Z0JWeTdqRUtGdjlINFhPS3lTby82YU1ma1RwQU9L?=
 =?utf-8?B?NXhSSXR2MHdLaEpsZlZLelR4b3RqellUQnlvUjk5bjZPd0xQYlpYR1ZYYnAr?=
 =?utf-8?B?MmtGdFkxTHB6anoyanJWQXYwRTJZQ0xNMmY3aENqNGVaOGU5ejZ4WUpmWDRV?=
 =?utf-8?B?NGxTMStaVnlpK1FCbGlCRUlGSEpEbXA4YmMxeGIrbnFFNzcrOG1sVVhrK0dR?=
 =?utf-8?B?RzlxaTloTStpMXY3RU8ycDcySGRyQXoxUW9sNytoUGVka0x2Vk1GakppYmxD?=
 =?utf-8?B?dm1ucU5oeUhjZ3BYR2p0N1dCcVZsck9ESm00c21FZHVScU1qYmxjSCtqSXRT?=
 =?utf-8?B?OENXV1BFL1VBYk1XOU8yUDM4bUlka2F6d2l1QXlkMzUrbTJZcFB2NXc5Nkl6?=
 =?utf-8?B?cHJoalNsai9jdzV4dWFyOGE0RzdtSjBFYU5jNlcyRGFMOWtNV0V1cFlSNkN5?=
 =?utf-8?B?WThaUlFDekhCdVV1WGMwa2xQRmt5aHhKY0JlUEh5U0tJeGlqRU9SeENObVEv?=
 =?utf-8?B?Y3BnNzIxN0taWlpvMEZUamVTcVhIVnkzNE5sQXVnMXRTajB3ZlNNclJjVytR?=
 =?utf-8?B?NzFoVzZzVDh0cGhGaU9OejlCZFdnTW0xTFV4eS9DVk5XV0VWU3llUlVNdmVF?=
 =?utf-8?B?ZHlKT2psaTBHbjVTWW9QalJuUGFPaFJ6M1N3aWVtcFhpSkQySVg0RXA4b2Y1?=
 =?utf-8?B?T2lmMGVNWjhRQkd6Sit5cFFqcW5YNHFYczJQREYrSEJTZHJiUnI0R0RuVGFV?=
 =?utf-8?B?OURLV3lUaGVVcC9VeGJiOFZjdUg2bWRyWXNjSnRwVmNPem9neXFUNXdOR3hk?=
 =?utf-8?B?ckRFTEdiTDBPQk9mYnVyRWROWHExVTI3RmV4aU9GYjhJMXZmVEVQUDAydmZM?=
 =?utf-8?B?NXhpaFNvKzNLcGp0Mmt6Umo4ekQwTXU4TmRNZittQ1JHc21IRWlNR1pzTW1p?=
 =?utf-8?B?SWpjWkpubUZxTkkyN2lzN3pjdVpMSkZvMTZrRmswemFRbnVjazIreVdpdFdj?=
 =?utf-8?B?S0NwWDErd01hbHcxaDE3ZkJ4MXRsVEl1WGhxZzYrV2xvQTVCR04yQ0FrckF6?=
 =?utf-8?B?aWJRL0k5YU5FNlByODhDa3FEaUZGeWVHNTIycUJWOWcrUmFmUWpxY0NkcnZp?=
 =?utf-8?B?UXF4Wkcvd2c4dWVFczlVN0J1K2ZtVUFuR3g3ZXB5dm9lZVhzQjRhZnltekh4?=
 =?utf-8?B?b1ZiRXQ4SGNuS0I3QnA4SVVYQ2sxdGUyS1ozR1U1SmhLaVJYZ2pIRVdWeGNH?=
 =?utf-8?B?SWo3ZmJYZU96WFoyVXl2NUhQLzJUZnp1V0ppM2pQRGlyRS9RNHZURndPQnRn?=
 =?utf-8?Q?xuA++BkGIGceO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzFwMmxaNzlwa3NDeHpmc29aYThLVUdxajVXdGdtanplS0hKd0x0TW55YzI0?=
 =?utf-8?B?cUFIQnVYcmpWSmVYQ2lYTnJCUkpOV29MZjRBZ0pJZmpRTmU0OHZQSy9STkor?=
 =?utf-8?B?U0J2ZlJLdFVnQ2ZadlR6NVUrRDlRUzhGMFRGaG9RNFhvaDJlU0YrY29icG50?=
 =?utf-8?B?TmNmcFI0a21DbUtJQW11Mm1RVmJVZVhzbkI2QXlMbFE2TE5pc2lmeFBWYUJr?=
 =?utf-8?B?OTZ2TGg5ZlQ4Y3lyOHJDdFdxZmV4WGJsSmRUV3BPWnlmMlo2cFViUGM0ZXJJ?=
 =?utf-8?B?ZnVGZmpQQUE2THpnenZtSW5ib3pyWU8xNkltWnJQUVVwWE5VV2pVZ01XQ09S?=
 =?utf-8?B?YUhGNnQwZGJkVy96aDgveEh3WlVJMTR4U1pQVlNmdkovTnJZL3ZpMjlHd1pI?=
 =?utf-8?B?TXBZN3ptdDl1S3puQjZFemtHcm93ZVVQOXhsdGp1STJRRUxxZFRuOVVKMk5O?=
 =?utf-8?B?Um4wRHNqRnNYeFkvSkliREhNTU8yZXlQU1NkZVRrY0pCMzNPaExVcVZuQ3dD?=
 =?utf-8?B?dGRpSExRS0FoWHdwL3BHb1V5V3ZsQWVHeU1vVHAveXdtQ1dUbFFZRm9kRVMy?=
 =?utf-8?B?TnhTdnBTTG9XWlBHL09Pc202YVREWmdiZkNCVmgxL2N1dy9KdEdzcVp4UnAw?=
 =?utf-8?B?aDd0TzVQczRnVUx0eGFmS2F5T2tmbkoxZExqNHVRemR4R1hmTDlzSkVIYXho?=
 =?utf-8?B?eWJOWXRjczNHT0o5Ymlla1Zoa2hGZmM2UVpIRUVFNy9LOFFTM1g3ZmNPS0Ux?=
 =?utf-8?B?cERza0c2RUYzTnYyTFZyZnVNQjRzWVA0YkhEWVYwdW9aS3JRemlIenpjc05Q?=
 =?utf-8?B?TlRSaFp1MjRKeEFrdnZuMkswTTZ6NW1vMDVxckVFQ3JHOEw4cHc4eTFvWG52?=
 =?utf-8?B?RW5YRFI0WDk2c1A4eWwwcjNFanhNS2NKM3RTSzBWTVJ4b3h2dXJCeFp6K1Ji?=
 =?utf-8?B?U3cyRXN2WmZFc1VyblVmL0JKNHFEMlJQYjFNVEJzNUE1R3NYUitHNTZScmkz?=
 =?utf-8?B?Mm9TYmVUd3N4YmZScTNvOVV1d25sMXhYOGI5cmQxRit5eTZiQmwzdWRGTlFQ?=
 =?utf-8?B?SVZ0STVhNjJBdEJ1RGs3c0Y5d3JsbExRQURkaGR1VENFNkpzRWpSY0FBdStB?=
 =?utf-8?B?TzFHbU1Nd0dBamo5dGxWSVRtWjlwTE41SUMwL2poWHBoNUxpWGN0dnBHbTBT?=
 =?utf-8?B?a21IZEdGSFpzWUhBT3VtTGRnK043cGpTMTFpeDNYVGQ4Y20rREg2ZldqUnNo?=
 =?utf-8?B?VGdVbXNjM3I1M1VUNXBzc1AydGE1NCtTZGh5aXMyd0xHcGVKZmF6dmEwS2dI?=
 =?utf-8?B?TTBLUXdYamJxS1NTWUdRVmdORFRtZGF2MkJWWU5sazhEc0h5S283ZEIxbDRl?=
 =?utf-8?B?ZU1qTXE5NlU4cVlweWVjaUhPaFhhNCtrQmdxQXJwMEFmZG1tRDFDbUVMclIz?=
 =?utf-8?B?bSt1cWo4WTd4Y0NuOVVVMUlQSW5COGhmbEg4VGhmeWRDdndaQndrQ3krZm5l?=
 =?utf-8?B?cXlmWjRzbVB2S1V4ZFBmTHF6Mlo1KzhQRHdjWFNKOFgxNDdsbU5qaWFJTmV2?=
 =?utf-8?B?Q0piQk5FWTVPMzQxNlVJdm1mOXptZTh6YmNHVzhFb0UvYnQ4ZXBiOUZXWm0r?=
 =?utf-8?B?Mnp0VHFvVDhTYU9qd2dYcWdCNE5VdWRKM3JFeFV5M1JTOEZiZWlzUnVxQmEr?=
 =?utf-8?B?WG1ZSmhaVHZIeU80SW9HQmRCL0ZabzVaQjFpNUF6LzYwcU1WU2wzODBBMG9H?=
 =?utf-8?B?TFBBZGt1cjhJdkYyMkRwc3RERm52aUVzb2RTenVLK3BZekNVZnZoZjM0clhj?=
 =?utf-8?B?VDRnRDNMQ1lpMG5EOU9QWVNnYm1pUndKOWRkZzRNR2lhN1BWTHRkSGl1RHVG?=
 =?utf-8?B?V3d6YS8wcGh4bzBBZy9vRjR0VXJUSFZoM2l2ZGhEZ2xpeFRRdUNYOEI0Z0Rw?=
 =?utf-8?B?NTBKNWFCQ0FCdmpYUGh6LzNiVEdLMUZORUQ3K2E0b2hUdGc2bzlsVnl1VTJy?=
 =?utf-8?B?cmNtN0VEN0lpd205VFZDbURrWGlFOGszY0pDWmpwaHBmaVA0eE5pb1pKd05L?=
 =?utf-8?B?eHVVSVdKT1o5Y2F1WHd3ZkwvOVZFTlVuay8yZXFjcEZ0cGFVV3NncXROU3pG?=
 =?utf-8?Q?2yIE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc7bb61-b490-4798-5236-08dd408bd6d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:39:10.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9mcrid+N7jEQ0umZhv1ASd89ZYEU0qF6Ka68ZaBicJpdybpvRec2iE7deEjVhVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

On Wed, Jan 29, 2025 at 06:23:33PM +0100, Eric Auger wrote:
> >> IIUC the MSI window will then be different when using legacy VFIO
> >> assignment and iommufd backend.
> > ? They use the same, iommufd can have userspace override it. Then it
> > will ignore the reserved region.
> In current arm-smmu-v3.c you have
>         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>                                          prot, IOMMU_RESV_SW_MSI,
> GFP_KERNEL);
> 
> in arm_smmu_get_resv_regions()
> If you overwrite the default region, don't you need to expose the user
> defined resv region?

If it was overriden inside iommufd then the user told the kernel what
range to use to override it. I don't need to go back and report back
to userspace information that it already gave to the kernel..

> > Nothing using iommufd should parse that sysfs file.
> Right but aren't you still supposed to populate the sysfs files
> properly. This region must be carved out from the IOVA space, right?

The sysfs shouldn't be changed here based on how iommufd decides to
use the iova space. The sysfs reflects the information reported from
the driver and sw_msi should be understood as the driver's
recommendation when you view it from sysfs.

The actual reserved regions in effect for an iommufd object are
queried directly in iommufd and do not have a sysfs representation.

> >>> + * @IOMMU_OPTION_SW_MSI_START:
> >>> + *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
> >>> + *    It must be set this before attaching a device to an IOAS/HWPT, otherwise
> >>> + *    this option will be not effective on that IOAS/HWPT. User can choose to
> >>> + *    let kernel pick a base address, by simply ignoring this option or setting
> >>> + *    a value 0 to IOMMU_OPTION_SW_MSI_SIZE. Global option, object_id must be 0
> >> I think we should document it cannot be put at a random place either.
> > It can be put at any place a map can be placed.
> to me It cannot overlap with guest RAM IPA so userspace needs to be
> cautious about that

Yes, userspace needs to manage its own VM memory map to avoid
overlaps, but from an API perspective it can be placed anywhere that a
map can be placed.

Jason

