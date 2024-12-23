Return-Path: <linux-kselftest+bounces-23735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA19FABF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC761885C9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700F191496;
	Mon, 23 Dec 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LWg/3Qlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC4259489;
	Mon, 23 Dec 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946093; cv=fail; b=Ri6HfArwfHF2KIfFTEMEtjqfpZPZc7EUFxQL22xhNoBEHjaJmn75HBy1rcQ1TL4dTCrXtEb/NA68RrU2eEFwTTXLi/s+op6FiZ89e70mRg4orZdgxXLPkGgQRKpfhzca5k0w2uu9ujH/TDd+XfdkGJ8VZy7sYDHGwKE3MRE1Kyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946093; c=relaxed/simple;
	bh=TU/VbJV6OlSnQPelOrrb9NG4MPWHKTNJoumGsliTXRI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsdUq/1E0Or+1srjyOOz17z8EKSDrGfZLYUiE5LXY3PXeMASUO7HoUEOSsqmiuEgus6FuPPhzAe1/2o0GdVvPtvYYzmLsO7nUOXlYFTddHcntWo+rXEbtktxXfwx2XFRrTvDLS6mPFZ1h9ME9acYVGOeJp3OnOih4CkyCM1IaE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LWg/3Qlv; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVtLYErF0zNJwBq4dHGQPHkyOHYUs2R4GuZtsK1945oMoQUc43GoGN90I2Oaj0KS387s1AeNsayh0rPmNyy0LYKAPaw5DWbLsUPQwStoN9qvqycB6ZtNLxIKRk7P9BmbKoYKrI+48855+iGPhL6KqdfisYJ/1RmzwxV/Kg9OwFtyVQD8YxnpY5qKtvCkepjISM1tvf73OYnLU9AZu2i7MTKi6ft2EIf7I0ofAqr7As/YCK1q0N+ybhtdAPc2v8aSHE8Qy4oIBApJxaEQ+OxG0EI4/VdkLPpmv6jC6Qmt+MCLzTSDog5SIAvQpIIDqd4C1quj/NoX/Oby7Ct2ljl/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MrhfO20fQVa/eLzOs64VOtzd2eu/wpef0IrPwJ9otA=;
 b=eWK+2yobTtQKZL2BAvOruMX7WuU9v9BtGBARiotSc9j7Tt2QbJutzPKjPL43kEv5N24JWQCV7WryGcGus2SS87DYQhF9YJ9Js6YwpchmY99PEwqIc2MhUSee7fEi4Lt5Iu3ZgDOCaIhw29W26pf/XH+XGr1zGvHix50WbfosfeTCWM2dgyKSieAR+9pjAal3i9Af9nqOdM1G8/Car1AKmNsI0g7Sk7s3g3imfYpdkZQcY8KnGPNgG+A7QttiYem+2bgePiR++3BTOVmoHlw4wKwwnGq2ITGkOZLFm4O3c9q/bNYnQREpDR/wmmThNF4ks/xQy1Hjizn6VZM0EzeUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MrhfO20fQVa/eLzOs64VOtzd2eu/wpef0IrPwJ9otA=;
 b=LWg/3QlvSznR+jeRfvOA2KFYk37xCMUAxSV53B9ScenIffvukSZf1XClxBG+6fSUpPzRlWvVM5COGs/LTseORpOMGPKNVdF0fVY7ktOp/mPkMhdCgrLLBtOvMsK7etPYOxxdmJjmXWTK8A1vpK+mXkbTVwn33jltn3NY1Z2Kzrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 09:28:05 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 09:28:05 +0000
Message-ID: <ae033096-c596-460e-ba4e-68fdb5a3abf9@amd.com>
Date: Mon, 23 Dec 2024 14:57:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for the Idle HLT intercept feature
From: Manali Shukla <manali.shukla@amd.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <5331cf45-230d-4d27-abc9-e5d92e5a6c11@amd.com>
 <dc3a3dc9-c6d6-449d-a1ec-d6c6879eb8db@amd.com>
 <47700dc4-c194-4a3c-a1e7-3d5e5a6ea6dd@amd.com>
Content-Language: en-US
In-Reply-To: <47700dc4-c194-4a3c-a1e7-3d5e5a6ea6dd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f93abfb-4bf6-425d-7f9f-08dd23341ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVibERvM3ZOYVQ1dE00RVJ2QVE3T2c5VFNxVGw2bk1KbS9UMHZjSmxaV2Fz?=
 =?utf-8?B?R1MySTVJRSt4ZUk4NTRhQlZqcTlVcjdEOWRISkx1NVVJeXh6aS94dVFuL3NY?=
 =?utf-8?B?TG9DM1JjQnM2ZS92RjUreDVxUFRjZE02WXVjN1paSE0rdExRcmI3UUczMDNB?=
 =?utf-8?B?eTZTRks4Q2pXaUpQdkMwendXMXJFM3VKTEd2eVpENGkxVUJ3TEczMURYdWpX?=
 =?utf-8?B?dTJzWDRkWkRZNjJLZ3NnZXIzMjA1SmppUDJ2U1lydmQyc1NKZXo0UXNQWERG?=
 =?utf-8?B?VU1rWHdXOVVUNHJLbUJLVUZ2MHJSUWlNUFVCYzJBUEV0SktGcjRnb1JDd0dF?=
 =?utf-8?B?UWZtTWRCK3E4NENxcjJhTksxUzFFUHdaelg3Q0s5Y2hIcFpQcHl6WGs0Y2Vj?=
 =?utf-8?B?Q2RZdDB2bys1V2J2VHFPNFREUGVWb2pqWTh4QVRIcWM3Q0o4aVUyMzJXcnUv?=
 =?utf-8?B?dWtZRDk1YzdtTU5oQnNaZWNqSHZJdmNYZEdEWWZLUDhGc3ZQT2JNbzhqNGpw?=
 =?utf-8?B?SXlxTXdCbkNoR2NGTXVsRjNZbStXVXBYcFlJM2xZUlBwZm9oaFdSVC9PMUh0?=
 =?utf-8?B?Q016aFVKSFc3TGR4RS8xOVdiTGFLOE5WblNxb3EwUElYMEJUQnA4VkM4ZzRw?=
 =?utf-8?B?c3dvcXBweXpDOEZHa0tIVzdJQkR3TzJSSjdSeEVIdWZFWWp3b1pzUnVZT0VI?=
 =?utf-8?B?QXRLbk1ncmUwT0h0anNPZVZjc1lhd2pUN0pBRXFIS3lRV0g5MzFNNC8wLzMr?=
 =?utf-8?B?a0ZPVDg5ZlltVHNpMng2VlB3azJDVDg4RmVkSnJZM0hwM2JoVlhoSTlHNHA0?=
 =?utf-8?B?Qlo3c3dJY2t2RWlKWi9GNXVFSmprSFFndnVHLzlWblBiUVNXSTZ3OWszSUFB?=
 =?utf-8?B?TWo2aFNzcWNVM3RUaDhVOXdsbmkvN01YN3NhSG1DN2hZTzZYbTVjY085cFkx?=
 =?utf-8?B?b0EwTm9zUWtTZlNnejNCUVp1cEJzS0dsaURKNE1EVFU5U002Wis5QjlLM1NB?=
 =?utf-8?B?YW1zUnV5QkRDYkpwYUE0M1BFc0xsNkdiZzR1R2I0VXpsV1UrWlprVU9tTGlq?=
 =?utf-8?B?b3NRb2VuWHVaaVZTKzZ0ZkxMRkVPSkZad00raGYwaTZkK2FwdDV6ZU5TeEVC?=
 =?utf-8?B?MjFBbWdvYXFpT0ZZR1F4SitKYjVWeCtDWTg5UDdMQlByMzZrdHFpVk0vV2N4?=
 =?utf-8?B?dytxRmVQNnBBK2tuTjNHT3JEUXJaR25uM3JXWHJNR3hpaGtSNUwzWFpOc09a?=
 =?utf-8?B?RVR4NkJHSG8zRzN4cWtENzVid2ZpRGlHS1lmWFl1OTVQVHFzUFlRQWpZRmd0?=
 =?utf-8?B?YnY1OGVhVmtIYnFBc2hNcEY1c0xrWlV4TmFjbUVqZ3pGd1l3b3hBSzhxNnND?=
 =?utf-8?B?TVpKN0NjUGQ1MEc3ZU96d2hPOS9Vc0M5SVJ3KzIvbHk5QXFVNm41eXVQVjhw?=
 =?utf-8?B?V2RIdGJQalpsUWtDNGJEcTRHdGRiYktVN2loVEw3UlVxYUJsU3REd2luTjBi?=
 =?utf-8?B?OXJESUxCRFppcXcveDdzUGQ3aS9weVVRTUlFM0hDOEdnRTR0T2RHeTQzU01q?=
 =?utf-8?B?YzhUK2N1TE05aDhaS0RoQmtiSU9UZDNZZ3gzK0dhZmxzc0JuTzNLdEZvODcz?=
 =?utf-8?B?SDIwblJTcldqZTIvYnJFR0M5OC9nS0dLblZHa3ZuQ3BzSm9mcUQxanVIWHpG?=
 =?utf-8?B?SkRRQ0hUZGhFQ1I0SWZBL0ZSU0lMSlEyeWNkbjE2VEliSnhmczl4ampvNXFx?=
 =?utf-8?B?WUhxdjBMTXB1Y014dkRPWHNJS2k2OFh5M01QQW5KaEtsYm1IQ1JsSVZ2dVc4?=
 =?utf-8?B?bGYzM2lJVUhxZlp0VEFZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTl4UmhhNnRzbTU4TEU0S1hqUm04a3BkcG0rWS82eC9JOVo2SnJaQW9yY2xE?=
 =?utf-8?B?Y1VhVTUvV2V4amJmMjhMRXRsZzQyK0ZJVkNINkZZcStja2IwczVHT3ZhZVI2?=
 =?utf-8?B?NnlES243RlorYlNKWDVmZFZrK1RFcTh0OUhNWUl4OE93aVN0SzYrVzB1YS9G?=
 =?utf-8?B?WEN0djVwQ1JVSHVKb2pCOHJSMGhTUy9XY3lLcEVjSThJbGxKRWZhbUJ1bGV0?=
 =?utf-8?B?MjJKdG5ibGladS9aWXUrSUdTbVNvMFVLdk1EM3ptc2pjTWNmM0NFUWRZMmRh?=
 =?utf-8?B?UW9oaXNWU2FKOFhsUG5TR1M0K0oyTmtGTVI4ZkpQNERUMDRGN0NlamFwMzhG?=
 =?utf-8?B?V2xZMGV5cjZmcUFVU1FSQkYvWlYzYXpTemNXQU5ibDZUUktwQ3kyVVg4akZR?=
 =?utf-8?B?WFVYdTdjbngzRUdnMkRIeUxYZ09kelBHanZRajhYL1o4ZVYxR3VMN0tab0VW?=
 =?utf-8?B?MEdTVjhCcVZMcWdXV0o4RHp6VWpWMWJaU2pRSjdWZS9nZWR5TVp6aHVwZDN3?=
 =?utf-8?B?alpzZU5hT09jZFhZdnB1M05RWW82RGpGV3NBb0ZXWUZaWGxRM0JXY1dOMU9v?=
 =?utf-8?B?TjV1VHZLcjdMbFNNVW16QWt1cnpVTFVBT0NGTlZQOFpKYzVPNUxza1dkV1Ay?=
 =?utf-8?B?cndITWRUS21KRFUwNXVqNWhsMXJSRThGaGJEK2FVMzN6V1h6ZENjNWU0VjBB?=
 =?utf-8?B?MnNYRVRLalM4ZjAyaXdSOUUzRFF1Ti9WRUJhVW5YZG1KQ1k5NFZkVW0reXZK?=
 =?utf-8?B?cldTdnE5cUo2L1dlYkVhamtkbElqcFhrOEIySnFnbzBqMUJJc3VqMFVDUjdM?=
 =?utf-8?B?SE1GWVphWVBkdnJRWGRBV0piTjV6SzFIdElMbFAwdVV4eEIvQ1pRci9Zam5a?=
 =?utf-8?B?YVRsK3l3eUlsS2RoU1FvbExFZkdQUUxVeXBRVDh0ZXRod3ZIcGJJUmsvNHEw?=
 =?utf-8?B?OXFucXJON3NPa2RERGxzZWVyejUyRHlhUDRHdzV3OHJucVRTdnhnM2hnVktY?=
 =?utf-8?B?aFUzZmRsSnlIa3JOT3I1RDZXQ2F1U1BWWGhlMkdsVWIvTCtQa1hSWFlLOGdP?=
 =?utf-8?B?VEFLUGMwVnpoOElkMkZ4YTJNOHozMXVyTWFQSDNvUlRUbEMzRFdGampvZUky?=
 =?utf-8?B?TXIwOHEzT3ZGWE5pZU9MaGs2VitsNjBBSklkYmltakdPdElyU1J3bDhiTEQ0?=
 =?utf-8?B?cTFzU3REclp4UEhLMG9CKy84anBYZFRRUFFtcTVNL0RDbk9KOFVJT29IZmRS?=
 =?utf-8?B?VFF4NjlyQzJLRDE1KzZGM3Yzb1BXRHhqNW5uVkJaeHgyYWY5SXFIUUMzUVBx?=
 =?utf-8?B?OG1ZOXBsZ0NaUE0zdHpJdFVDaVkzSk9RNkpScUx6TWlDelU1dHhkVmFJVm9D?=
 =?utf-8?B?VnFmRm9vNXJSRTNPUEtIVmVRa0dqZzcrSkhpUjkrdm9DdVhYRUFXVi9rT2Jw?=
 =?utf-8?B?OVpwNzV0REovUDMvUzA0azh6TU8ycUZWYi9lVWJzVnNRZHRYZUtHaXJSd25V?=
 =?utf-8?B?bEhpRjQwV0xSa1hraUZoUWpFSTMraE80WUloWU5JS2sxbC9URUdWTFZiZkdB?=
 =?utf-8?B?OG0wanAzOTZoanJ5aTJ0c1dSYnVEdzlvVEdzbXYxM1dNb2FjYnBSOStVcVA3?=
 =?utf-8?B?d3RGZzFFREtwU3kzL1p6OFFCeUhmd0xVcjRDaFRkZm1sUUpJb3BxNHA1blhU?=
 =?utf-8?B?a24vT3dyL2hVT1NSTEw0UXBjc2J5dGQ2Z0JoMmJIeDFXZUY2TnYwUzJKNXA2?=
 =?utf-8?B?djJwaXRqaEN0OFpVQk11bTJuZm9YWktpQkd0Ukd3V3JOZ3A1a0tPc1BKbWdN?=
 =?utf-8?B?UjAwTlZqalQ2Q2Q4cGpIQ0c3dVBwM0pLcnFFTkNnWHVVRmRRT2xwNW9NRjJX?=
 =?utf-8?B?OHlDMGJRK2hKYXlTanBWTEFBUTFuRTZkdTNhNmRoTU1WNnJsN1Vkakxqa1pt?=
 =?utf-8?B?QklGRTBhSU9CZzE4c0IwRmN5aUlmNHRMVjRIMk05ZXdNeHVvQjdueWJSVURD?=
 =?utf-8?B?Tjdob3AwOXdMMTNxOTRsT2VCNVNIcnFoL042U2xISjgrUTFmeFVROGZGVWNr?=
 =?utf-8?B?ZHhtSXhNWk9wM3FsSGRnSndhTnBjTlRqYkdsZHB4dFowTVVielRybnFYVVI1?=
 =?utf-8?Q?og1/Y99dP3HdBRphsIc2shIrp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f93abfb-4bf6-425d-7f9f-08dd23341ae6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 09:28:05.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlUX6iDkCv/57zOc7EAt0lDcul7G8fvSeWNEPkzJUz1SCQB5tx4+X8NmHT8js6ZCUr20Fewk+r7B0qimNMhBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828

On 12/23/2024 2:43 PM, Manali Shukla wrote:
> On 12/12/2024 10:07 PM, Manali Shukla wrote:
>> On 11/28/2024 8:39 PM, Manali Shukla wrote:
>>> On 10/22/2024 11:18 AM, Manali Shukla wrote:
>>>> The upcoming new Idle HLT Intercept feature allows for the HLT
>>>> instruction execution by a vCPU to be intercepted by the hypervisor
>>>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>>>> When the vCPU is expected to service the pending V_INTR and V_NMI
>>>> events, the Idle HLT intercept won’t trigger. The feature allows the
>>>> hypervisor to determine if the vCPU is actually idle and reduces
>>>> wasteful VMEXITs.
>>>>
>>>> The idle HLT intercept feature is used for enlightened guests who wish
>>>> to securely handle the events. When an enlightened guest does a HLT
>>>> while an interrupt is pending, hypervisor will not have a way to
>>>> figure out whether the guest needs to be re-entered or not. The Idle
>>>> HLT intercept feature allows the HLT execution only if there are no
>>>> pending V_INTR and V_NMI events.
>>>>
>>>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>>>> function Fn8000_000A_EDX[30].
>>>>
>>>> Document for the Idle HLT intercept feature is available at [1].
>>>>
>>>> This series is based on kvm-next/next (64dbb3a771a1) + [2].
>>>>
>>>> Experiments done:
>>>> ----------------
>>>>
>>>> kvm_amd.avic is set to '0' for this experiment.
>>>>
>>>> The below numbers represent the average of 10 runs.
>>>>
>>>> Normal guest (L1)
>>>> The below netperf command was run on the guest with smp = 1 (pinned).
>>>>
>>>> netperf -H <host ip> -t TCP_RR -l 60
>>>> ----------------------------------------------------------------
>>>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>>>> ----------------------------------------------------------------
>>>> |         25645.7136            |        25773.2796            |
>>>> ----------------------------------------------------------------
>>>>
>>>> Number of transactions/sec with and without idle HLT intercept feature
>>>> are almost same.
>>>>
>>>> Nested guest (L2)
>>>> The below netperf command was run on L2 guest with smp = 1 (pinned).
>>>>
>>>> netperf -H <host ip> -t TCP_RR -l 60
>>>> ----------------------------------------------------------------
>>>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>>>> ----------------------------------------------------------------
>>>> |          5655.4468            |          5755.2189           |
>>>> ----------------------------------------------------------------
>>>>
>>>> Number of transactions/sec with and without idle HLT intercept feature
>>>> are almost same.
>>>>
>>>> Testing Done:
>>>> - Tested the functionality for the Idle HLT intercept feature
>>>>   using selftest svm_idle_hlt_test.
>>>> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
>>>> - Tested the Idle HLT intercept functionality on nested guest.
>>>>
>>>> v3 -> v4
>>>> - Drop the patches to add vcpu_get_stat() into a new series [2].
>>>> - Added nested Idle HLT intercept support.
>>>>
>>>> v2 -> v3
>>>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>>>   a way that each architecture can share the generic types and also
>>>>   provide its own.
>>>>
>>>> v1 -> v2
>>>> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
>>>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>>>   doesn't use string to get stat data based on the comments from Sean.
>>>> - Added self_halt() and cli() helpers based on the comments from Sean.
>>>>
>>>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>>>
>>>> [2]: https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t
>>>>
>>>> Manali Shukla (4):
>>>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>>>   KVM: SVM: Add Idle HLT intercept support
>>>>   KVM: nSVM: implement the nested idle halt intercept
>>>>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
>>>>
>>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>>  arch/x86/include/asm/svm.h                    |  1 +
>>>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>>>  arch/x86/kvm/governed_features.h              |  1 +
>>>>  arch/x86/kvm/svm/nested.c                     |  7 ++
>>>>  arch/x86/kvm/svm/svm.c                        | 15 +++-
>>>>  tools/testing/selftests/kvm/Makefile          |  1 +
>>>>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>>>>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>>>>  9 files changed, 115 insertions(+), 3 deletions(-)
>>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>>>>
>>>>
>>>> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
>>>> prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
>>>> prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
>>>> prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
>>>> prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda
>>>
>>> A gentle reminder.
>>>
>>> -Manali
>>
>> A Gentle reminder.
>>
>> -Manali
>>
> 
> A Gentle reminder.
> 
> -Manali

Sorry. I just realized that you have already reviewed the patches. 
Please ignore the reminder.

- Manali

