Return-Path: <linux-kselftest+bounces-20694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9039B0E04
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11DA1C21F79
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83B18D62A;
	Fri, 25 Oct 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWXEVyJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8354723;
	Fri, 25 Oct 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883427; cv=fail; b=LLQC0P55/d31MCJrt6GiMhDHtK+/42vCkHHy2u7T/jrc0X8wKv8mh+N2fpXJSYEwgguxY/5l3VpIpUscxqK4GpF8Bh0acKmLfTd9dLzIfi1rUHqsA5miCrq5wfzcoO5qrCTwSowVgHzxgmunXheeQkG7f4j2rjm/CUZlJHsdD80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883427; c=relaxed/simple;
	bh=MK9a4ws6BZ16IDJRz0y71+JOnHO39jYs6Dvd9WVkFfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFpQBbfxTedzGb1+Ej61PzNdlQ5LvGTupm7n/4z/nQ946Q3jaFf8pccHfPR0hgAi70gkNXFeeXQiU4mHrcYzEQTndrw5/96AvxCrE3W6BCF6MjP0i9GE6s3+MyCEakz0EOYGXIZVJ9fFQWNEn31KFGBWBkaLZZMIQcjFu/iInnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XWXEVyJ8; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXeGk8mACDt3X6Oq8pWTPuiyzt2D2LZBdd3bh/l3TnHqg0b9lSySf+OA80H0g6do8Icw4kwLARd0v7Bc+Rb+6gCOUIT1yLRRcCqxw44A8W0qBM8aqDUhqOEO/fjTmS5c86TVg4SpStEq9abCbjajMiREaAzozeFtfM11sM+qHCbN3Oh1QCfDsXHmbS/P4QfHASxNeulNiKy+ZXyM5/8b1gfqytYzoimFjjmIWxomuQXUXX9AI3uQDRJUsrNY6H1OZgAtaBwokIBj8E6CdagFoGYk7geQpIo9KYb9onEEyAreq58TgeDaFT2JqYp6OYSSKXCkRHLzQf916EcNokUZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMv6Q1V4ely3uiuPV71QGn1JQYASnHOTWLfQQ8KVexg=;
 b=h6uNtrUemZmx3J/B7f8ENVdLRordMPvU9hj96U3ix52bXZfOq4vsECP2Fs6CzLDgfKA142v8F/1o11HBk+n6qSyZkdeWNzJHPItxw/wo+svgmYnCNuDScQPHXU/ukH5VzUF3REwS7T0/FNLWgvDUtyyryjPCG3nqlpJ6388jbpVnWGpobtotl3TCEH2aweiBa3FOtosNN0HOLu2TeMsn+7vSYUR4QbQ8EF5Z5CjmApLE5h4rDOdlNDK0gmSAJeVIpzpGyHYEFj8MLhDMfZ/MBDIDs5M7G0SJxhUMaIEDsz3036xZHkrSRsqQCbFyj3Tq5QujTLOX8gmr8Epgii9eqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMv6Q1V4ely3uiuPV71QGn1JQYASnHOTWLfQQ8KVexg=;
 b=XWXEVyJ8bCy/lj3n8zimvO+t/MBtJ3AqUAwzgejBn0PnviwuPbYxgbKdn4KsgbpUkKTyZrzlqB18awNLguBBMcnoRGaNX/cPeVFmoJ8BaC/tQCT1EFrCYH23srBCd+i3lDGj3q9pRDadyTlcl+B0Vew8iYLGilVKpckYwxLAe2r+kbxVDbPVclqt913Hrfh1BbTCL3PGvDPS8sN5qrQ5OOKurKCVx0uk35UKK6D7/MsvegewbDkYEAQbB6K8TDLrxt41n8LScKErylSzuuVdPPMGV5Ls9S1x6pVmZRs5KqPG/VQkvc29zPilAMUWJT3nAmuWd4OPkf6Ti/5dlX8yoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 19:10:22 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 19:10:21 +0000
Message-ID: <4eada004-f3cc-448f-8206-cc893e1e3f4d@nvidia.com>
Date: Fri, 25 Oct 2024 12:10:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 3/7] selftests/mm: Add a few missing gitignore
 files
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Donet Tom <donettom@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
 <20241025014010.6533-3-lizhijian@fujitsu.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241025014010.6533-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: c409fe99-16ef-40af-c54d-08dcf528ac51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDljQWtId3NXRkgrYmt1eEd1bU83cWpnTEJaRmx4aERIZGpRMzJUMnVtMGlV?=
 =?utf-8?B?MEtsYjB1YnBaV2hENmtiZ3F1NkR3bmVQWFRVcXRjYkxRZTZ2cmptdlV3a3Jn?=
 =?utf-8?B?VlY3dHZuajZpcWtzYldjaVRPZ1EyZkNVSW42K241MExJSXBjK1FMQ2pncEw0?=
 =?utf-8?B?dmVvSjNFQXpKb0lra3Z6NTZwRGdJUFQrNjZoMjcyNDljWVgrQWxrZndSNW1E?=
 =?utf-8?B?eEhzTjBBTHptZllBbjh1UGkzdmFVNFEzOE1xdUJwbDJ6L1dpYWRyTXRaWmtn?=
 =?utf-8?B?OHgyWjJKUFkwbjl1cnViTzFsQTBKY2huVm1ONlJHVm5zb0dIZGEvZ1ZHYlR0?=
 =?utf-8?B?c1FMdnhrUVA0anc0ZTRHbS9lVlBkVDkxakV0a0xGWGpPTTJaUmlCMDRMWEdz?=
 =?utf-8?B?NXU0N0tHeGVJZTV3bWlCQUdjMFU4aGYxOW1XcnVqWWQyNzc3YjVjak5SREhO?=
 =?utf-8?B?VnU1M1RGRWplazFnOHAycGVTb3N3elEzdlRkQ2pPcTdORTViZ2RBbitRcDkr?=
 =?utf-8?B?NzBsK1JXa1YrVEJLdkFIOGFTL2NobUFRai9CbkFrczBhcFA4bmRKY0dnbmZ6?=
 =?utf-8?B?aXZJeFlSenViWjFYNGtGa1oreVpSZHdpaVJrOEtTVnJLaWMxKy9yekRYSjFs?=
 =?utf-8?B?cDhaZzlta0ltaTJIM0FXd2U3cUlvRzZSdkpiejZUNGtLcm8vL0JIQjlQaDYz?=
 =?utf-8?B?RVdmWEZZN0loWGduZ015NFpndFBKSktRVmZqY0VjMmU0aUdienZLVnh4anMx?=
 =?utf-8?B?OGpQM3A2NGQ1WHJxcGJKSm5teGVvL25rMDdqMTdlRU1tVi85S09neGdqdXJV?=
 =?utf-8?B?eks2cUE5Ym9ETHovakFwMDQ1YXpnWDdqdUxCZjhmQW5BTE52Qi9GUVJBOXZF?=
 =?utf-8?B?TUhMSmphOUovQjF4V3JZdUZqMHVIbEpzaEJ4VjU3VEZ1L1pPZkYvR3EzZTMr?=
 =?utf-8?B?aXlNSmdhNSswTDJMZHgxdXlFTDAvME45VCsvQ2h3T1czbmRCUXIvWCtsR3JW?=
 =?utf-8?B?SmUzNk5ETms4U200U1UzZ3F0ZGhhUG9scXdWSjVlcUtDSFYzd0lEVTEva3JM?=
 =?utf-8?B?QjBiY1crT2dxNlVVWDlsQ1Z0Z3V4OGFYVkFVVDhaS2NlVVR6NExtWUs5RnJs?=
 =?utf-8?B?UkJJS3NYWklSS0pQa2JGK1h3WlZCS1BNTEFtY09xMGhxMkdzOThDZUQySFBv?=
 =?utf-8?B?MFpVem5JdjIyR2FIYmxGdUQwS3ZRQS8rK25waStvVnpiQmwzUWg4eFBURlRz?=
 =?utf-8?B?UnkrY1JwdWlxYUVqMjVhNDJkZ3JzRzFqdG1hOGNtK1hrRG4yVk1MN3UxYkU1?=
 =?utf-8?B?SEI3ZDZFOWtEdEFHd0pYbG0wWERjRmFDQysyRUFKR3p6M3BHM01YVm9GWFVp?=
 =?utf-8?B?R1ZQdk41VFpIb01IRForTWZhTU5JODhNdTZaTGJvN2tvcnM3dFk2WXE3SURn?=
 =?utf-8?B?RFNOaUhHSEE5MFJsVUlVR2xJMGtrZDJIejNUM1U0UFNLTklxdkpHV2FERERD?=
 =?utf-8?B?TEVSczdPdnZpQ3crOW0zU09PdVZ6eSt6bTkrUW1kN3ZTS2Mxcks4K1RIWmIw?=
 =?utf-8?B?czdxT0xSZmdyUnZjcGtBTTEybEVtZXo5NThZUHFOSUlRTC9wdXlJb3hCWEdH?=
 =?utf-8?B?TDV5Y0pxd05MU0lqYTVwZ3FMWGJ2VDNjdGxuU3lCRDR3dStPL3VHVlgwQWhs?=
 =?utf-8?B?VWlIZUVhTjFnYmJ5YjNPSzVsbVFUajFKYnBBNEdTQ3d1N2w0MmltblduOUpE?=
 =?utf-8?Q?0slAm+z6vXLNfm+BypSHRevM7w+PQ+JkNAgPzUH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjhIOE10Y0tCZ3VhY0JDQXVxbDlLNUczM284c2s3ZURtN2pFUXBHZEJuT25Y?=
 =?utf-8?B?R3NESENPRHFTRXZtYkJNcEZ0dHBjYjFMeEYyRGdsOHl0Qy9KWElYcFNnNFc2?=
 =?utf-8?B?czdjN1hNcHFicEpmY3pNWnV0OHI3MlZicGJYbW1LcW5GdnhiSDZvSHEyLzVV?=
 =?utf-8?B?bG40OHQ0Y0FRTHM4M3VBQ1RJMm1zUWFncHJGMU12NkRoRXRZblNQYWlhRVc4?=
 =?utf-8?B?L3FkN3pPSndyV2cvM3VFcEtDVTJBdWQ3SEk2dUdMZVNLZUlqVm5ZTGcrNXZa?=
 =?utf-8?B?VjdCQkc5bTNLOERteDkyb2JOSVJkeUlUWDU0WS9RR0R4eXNueUxiUUtRSHY2?=
 =?utf-8?B?ZkJzZkt3NjdWMzJmQUhDT3NudGViMFh4ZkRwZXRNOVZTVGkxZkx0MTVXYjFz?=
 =?utf-8?B?am9ReFl2SExkb1YyZGZGOGRFSnp2YjcxNjR5YTV2QlJBbmZ5aDF1QTlxY2tV?=
 =?utf-8?B?Y0NldXBQQnIyYkVvNC95T3hDL2h5b0RiWElzdG5HUm1xWG5BYkdiNWV0ejJj?=
 =?utf-8?B?a1EzWHBVYmI4ZVluV1dRSXBPdlZYcVhBSVpVcURLVjRKc1pJcmU0SFhMMjNX?=
 =?utf-8?B?ZCtTV3VLcHkvQmRFRzZHWUt5Z0RNN2ZFQlJwakZWWWRzVXNWTHZIV3R0ZFcx?=
 =?utf-8?B?dTlXZnQ2QTVXUnRqWjhtc1hQRytCLy9aUUsweVgxR2U0TnJWaTRabW1mc3A0?=
 =?utf-8?B?cnJWb0R1NG0zOEM2WmVIUWx0K2JtdUtmbjEwZTdvUThCWFdDS25GbHpJWUZo?=
 =?utf-8?B?TE1DN0xRM3pvUnJxeSt4TzdMWk1uMWtaaTJOZ3VjUVBIRkpudlozRzh1cXVZ?=
 =?utf-8?B?M2hxSlFxUmlQVjRZeEcraWR0T1FCeGtNYXd1ejdzME81NzRERTlCTmRyTnJD?=
 =?utf-8?B?NnlCQ0p2TFRsenFyWkVJZjE3QXF0LytzVWo2MGg5ODY4a1poWkEyTSs4V3h4?=
 =?utf-8?B?TVlMQit3Q25pTGdLN2VKbk1BRlN3RndsbUZpenZNNHZoUUZ5bmdvaVZ3MkFt?=
 =?utf-8?B?UiswVUY4aEo5V0Y2b2VWMlNVU21GUG9mUU9uV3N6WGdySDhrM2pkWDc1T082?=
 =?utf-8?B?TFhURjdNN0ZGS1lEeHMrYXVzM0l0YllIY0hXK2p5NmErQlkyeEg3cFp5VGpG?=
 =?utf-8?B?czk2WEl2S3EwejltYkU3L0phS1R5a01Zd0FMNnNjWVBQeE9MZ2gxdldaNmRF?=
 =?utf-8?B?cUhNaEo2aXNqcnU2b015OEd2bS9aUU44WXFVSm5BMmVtUEd3SlEwTWJvM3pH?=
 =?utf-8?B?eUFWdHB3enZhQzVqMFhsbFZkQ0taenZYTDBDV29rWFVjdDcrajNYWEQ1aGhL?=
 =?utf-8?B?NlF3cXNMdlkrNlNNOEsyUmR6VFZjRnUvdDVGY1FEWk5oQ25vQ01NeUM1RCts?=
 =?utf-8?B?M2syQ0w3OFRVRmMwZ2svODNWY3VJVjNBam0ydm14REVCc1doeWUwQ3JYL3Fl?=
 =?utf-8?B?Sm5JZUtXNzJYbWEydkVhdkdLTDJ4ZCs1L3NVQTZORXRHQm9hOW91dzUxdUc0?=
 =?utf-8?B?cG9YR2FoYkMxaTF5UHA0V0lRMy9QR2E5ZkZoV3hZb1Zmc0F3TERJaXdTalVi?=
 =?utf-8?B?d3grcGxOa2N6N0JvNEFhaHB1S01MZGQxdWRTYnBKei95YjFZejV6a0pBOExx?=
 =?utf-8?B?aDJYY0xJVXNlK2lYR3Jrejd3OVRvU2xYUytVODRnbU4zSUN2SzJ6RXdpVFFY?=
 =?utf-8?B?cXZRUngvUXRDZW9za2ZkV0dLTjl6RVV3ZVBvbU1maEF5MUZCTGlvYTdEbUI2?=
 =?utf-8?B?UkN6VjZtK3krT21CVTNBOTR5VzdJckRyUHNpMWVDOXhZc1FKNFkxNEFqRGt4?=
 =?utf-8?B?SXlJdVhPMXdWNVRIVnNYNXdzNVZDUmJRSFhhei8vOW1JOTdFczdpSElPM0pJ?=
 =?utf-8?B?bSttazBqdjBwRXlndHkxclVhL3d5UWlRS3ZBVENXbi9PZVQ4L1pOV2xKa1Zm?=
 =?utf-8?B?djVYSDl4OE9aN1FZa3UyNE1ZQk5iSitJZGFsRWNiUUx4bjNCNXVHdlhtRjdB?=
 =?utf-8?B?NmNoR3RqdGpueU8wTWZ0cnlNd1NRSDA5T1liSTBiKzRha2lSNlBRc3Z4MEJs?=
 =?utf-8?B?UkpQUkpSK3pSd2lGMlYzbTNEc3NXZlhjc3I3NWtCNzM4OGRpRUpSTXZBRnpN?=
 =?utf-8?B?WTVnb3E3ZVdGSGFxclVhSGdNOUJ0b0Z1RTlNSjI3bnhNc2pDREkvcm9jN3NI?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c409fe99-16ef-40af-c54d-08dcf528ac51
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:10:21.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBOUYdbgKXj9kmzcDYt6UW1DbAse2wN95Zyma6HUAar41FAmq6tytz7q19Uv7xBraa0/Wl3CXvCTe7ACEzWy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On 10/24/24 6:40 PM, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 'git status' complains:
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>           mm/hugetlb_dio
>           mm/pkey_sighandler_tests_32
>           mm/pkey_sighandler_tests_64
> 
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Cc: linux-mm@kvack.org
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V2:
>    split as seperate patch from a small one [0]
>    [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> ---
>   tools/testing/selftests/mm/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index da030b43e43b..2ac11b7fcb26 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -51,3 +51,5 @@ hugetlb_madv_vs_map
>   mseal_test
>   seal_elf
>   droppable
> +hugetlb_dio
> +pkey_sighandler_tests*

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard


