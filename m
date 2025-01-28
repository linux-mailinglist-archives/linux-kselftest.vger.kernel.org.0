Return-Path: <linux-kselftest+bounces-25307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5EA20ABF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B587A13B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75419CCEC;
	Tue, 28 Jan 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dw/Ev9Po"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1718DF86;
	Tue, 28 Jan 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068593; cv=fail; b=Bigr0K129cNeakbYEtaqF7CoAYBgmxH6pnbN7+D23Gpxe3EPxF4nv7G5Sh8Zi+/rHmfi2TGOU5pD+w3SD0eT3N44ZCR1N2wgIFnAXBHBUjcs5ugQVuUYnghm/Vn1EnzOtKj8fqr5IZZSekIJoY7triceGlpMxdA9F8yfEB0+778=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068593; c=relaxed/simple;
	bh=XVg8CBcZsHjctrnJolupCsV38ciTCRYquNTllLs1EAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sf5hjSScD3b27WlicSMGHYS5ZgUQxLVO1lIYwMz1e/DaZpoUvydh3DsG1HiXOQbAoejXP/qt6ZQXo5mhMZ9dc6gVM/4brgWahmkLioP7PraWJHLBnO9uyULspsowlGqhn2fI2aiFef5WSTVGyYy3K+iQy+n4924KsKFVRIp/Od8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dw/Ev9Po; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4s7gRG1Be2Eiyc6cmo//1h8qEV0hG/fUT9Bwl19H+26vIs8U7ivbawkABql4ZoOJhlzDG87kcFcv/Xv7ohp/7ZfbzAgAjzOXsfy3MWVfVg/4/+WXCJD0s7UveiJrFz6Otq7BmlM9I35pzAgVyLP3PRZ6Fky/UzBqZyUrGDadhOcZ6FudbBlLza8dPI/Q2WW6VdjNJ0FA3mnILnnaZRCannKljgzzhF9+XluMCm09f1FhOkoBH0VxxlsOVphK/P+0JLjOfyXP4tBgACjhlVo6oOXVescwXqeq+FKtesAUyTWEg9iI+GpsQ2i++WTpZl2liuKLwg2te3MSQZD3OzyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riPxJBNKJy87FF8SQo84NcKL1fjlOIu1Jx/e/r2Wk+E=;
 b=HvE9VYizbK3jeAF4AB31X2kJsNZY2kl/wNczi227KKcTmCxfywq/yJa4Uv4io2unT8eIlPft3+vPL71zIuMrj5/wE4N3wThw/dJN4FWRYCusrZ7YOGseGd7kuqzk2PnthGW+SJz0umzQtUVqhsPhfCvqq7kaFUwdsy0fOV3EU4EtlKiRbFSoOsa7OMUWSqhbBgFKWdKsz+iWt6Djjqu8MKhK26nl5fbk7W75QzApbrQNx9K9isPwar0CXtlPCFZBd1I7UEk2y47ehvALpPzPGq7ttSHzOev+FPSJxlHbuEmsa+dZJ2Obw/oODThzPyGlm6oG2AHHLWKNWW/1H6DqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riPxJBNKJy87FF8SQo84NcKL1fjlOIu1Jx/e/r2Wk+E=;
 b=Dw/Ev9Po2dysvseNlIE/zslrYlaXHZxXVOqkR75W0GElXAZrqu7csVF5kKuWu2RYopXs+05oJnt7x6wFLAIP1JOxFM3sYa1zF+t65wyuiCg8MXI3ev0PfxfW2sv0zC/pgfzRt/zvgrJuiTgjA7ODFhc7PYWqjLEnt2Sha9NN1JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 12:49:49 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 12:49:48 +0000
Message-ID: <b7999b0b-c064-452d-9508-329e01344042@amd.com>
Date: Tue, 28 Jan 2025 18:19:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] KVM: selftests: Add self IPI HLT test
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
 <20250103081828.7060-4-manali.shukla@amd.com>
 <d0926133-d1e3-4007-ab34-6aa2a987b8ec@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <d0926133-d1e3-4007-ab34-6aa2a987b8ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::33) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a10086-cd82-4790-4c0c-08dd3f9a3fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHdkNy9rYWFFeTRqdFZHZ2hkT3pKWVpzejlQMXhMczZxK2tPUDZacHBseFZK?=
 =?utf-8?B?T2xEamUxNEZnQjlIeURib3hZd2h1ZmdGcVJwZDJ1bG9VTkRoTE1nWnJRcC9S?=
 =?utf-8?B?NS9CclhCblFTMmJ4a3hBMG1hYXRpSDJTUjNhY0NMVk5NZGd4OUpwY05Qam1t?=
 =?utf-8?B?Z0dES1paYUplMnd3YU9FajkrcTgvdWllRlVITVNyVy9RaFlHeGRhY1RDL002?=
 =?utf-8?B?a05SL093a3l3MDAxWmE2RTRWbTNLUWxPYk5nci9DRWw3dEV6NlR5Zy9jU1lZ?=
 =?utf-8?B?M0hwakwxS0RNUkxrRlNjUEYyM0JzMkowSDFNTStFcTVqTm01d3hSOUV4RzNU?=
 =?utf-8?B?L2NzTVJ3V3ZDYTRIQjNYWm96MUFNcWNXNCtXTllpNStzb3F2NVI3UE45bFdL?=
 =?utf-8?B?dVhvOW9iNG04ZW8zMldubUY3ekd2OHhYa21KQkJkZ0N5ZjUzUUt5RCtpT0cz?=
 =?utf-8?B?TEtzdmNtNFprT21GOXRCK29zUVQrUk5zUUxaWFJJSWU5NDVoZHFCYU1BMFkx?=
 =?utf-8?B?c0g1TmhNbm95S0EwRXBDR2d6aDNsZnpJYnEybm5halY1SW84eVQyL05hQmxD?=
 =?utf-8?B?ZzZSeHFmaGFFV2Z5MWZ5cVk3SGViN1QreEY3WVRuekZvWEgyNXNGRU1YcWJ3?=
 =?utf-8?B?Njd4N3NDTGhuOXdYTUZHQi9UaTNjUjZuWFZyNll6Nk9NSWpMUzVzbnV0Vkkr?=
 =?utf-8?B?N3hjamgxTTBLQTZzS2kxRHNEeWRVcVk3MGQ3amJwbEtMY1IvYTJMTUdoN2s2?=
 =?utf-8?B?dVlGZllidzhTeDd1cWNuUitlOGZoRW9zRU9GWVR3Yy92T0t5ZTJHeVlMKzdy?=
 =?utf-8?B?akZtdXozS3kxMHo2VHlQSW1qRXJQbXllY1hvWFQvUGN0Nk5rM0VzTVdDdzdy?=
 =?utf-8?B?VnhrWXRFbXVINXJ5bTVOaTFpdFdGb1hadVNrd0h1MzRMVlZ2TkpIUW16YTIx?=
 =?utf-8?B?UUxZazhML0xzUHU2WUZ3d3k5czBQRW9icHdIblE5b2V1ZEcyZW1HTnpMVTdB?=
 =?utf-8?B?U3c4VkszS1N1K1NEbFRQYTA5SWQyRFNqWEx0ZnA3N1lhYjFETjZWd3BFRFIv?=
 =?utf-8?B?dE0xVEQ4bFhabVZoSVFFemNSZmNqeVNpbkMwaDRWZWV1UE0zc0ZadjV0MGMw?=
 =?utf-8?B?amNlMFUwS25zMmxoa0Y4dkxqK2k3dmhkbFM2czdKN2RDV1I4dHNYcW1TVkR5?=
 =?utf-8?B?Y1BPMjNBTzZyQVJPL0ZDMTBGUllZMFNxWDk4N2RyK21DaXdqWnhDVkdCVUlD?=
 =?utf-8?B?alpoQi9YMkxWWHIzQVhiYUFUS0M4d2VTT2ljcHJnMHlnU0owZU1lWGRXck1q?=
 =?utf-8?B?a0RnRGUveVdVcEMrc0UrakRTNVpvdjdpVWp2QXIvSWxsbTRFNVdScEJaMFFW?=
 =?utf-8?B?WjFDK0xOZ2gwL1oyUFgxVjFVM1dkWVhLdm5sb3Q3L2FmdFhkeGI3UnhZQVQ2?=
 =?utf-8?B?Rnl1ZC9CdDVmVU1kZEhrSFkrU2JYVFlPaUxhc2lBb1NZeHkrR0U4b3h1aFJF?=
 =?utf-8?B?SzZBYkt3UFZMZGNLb2FkNFU5QVNxTGJ1Nm9abGRxSk1qOEpRVysza3M3aVNX?=
 =?utf-8?B?L1B5eXVEUVhTVnZjRENEMTZjRjhPU2lkSmc0QWpBbzFNeFg4amJHa3pVdFEr?=
 =?utf-8?B?NlNlQTVoY09Id1FsQ0FqL0psZERWM0llTGVSQ2RJNVZOblQyRklTdEZTYzFr?=
 =?utf-8?B?VG1LZnRrdmZVbnQyLzVZbWFGcU5ka2tsckQrVFUzeE1ZcmkxcnoxNDJNMEd2?=
 =?utf-8?B?NEw1aEY5bDlEdmYybDIxRVJGNDFLbFpSWnl6R3VUclc1c2ZMM1dZM1Z5TGRJ?=
 =?utf-8?B?MjhGZUg5L0ZsTEVsbmpxdENMdW9rdjNjbFZ5NzFKYzM0QnBybWpYNW53ZUc4?=
 =?utf-8?Q?pz2nGh6WDqDTX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlEwcklpdHQwV1c0QnhpdDVDUDZCMm1PM2F1VnBJdEs1eWVKb2o2a2liNlB6?=
 =?utf-8?B?NnA0cHgwMkpTaytRdmI4QUJqY3BjVGY5QW9pR1liR2JtVTJDSm9QcTYzWGpQ?=
 =?utf-8?B?aVBPMy8wVG5xZnhROWxoY1FWRTRaN0xKNU9ramI1MTVZVkJjWVA1RW4rWTl5?=
 =?utf-8?B?SzlSMzh6N3l0ckFiYXVyaGpTRml2K1NrSUVDNlhVaWtYSkc5aExiMmRxL1NH?=
 =?utf-8?B?TkF3a29TelR1WUlSWW9SUS8rQVZxcUVGQWoreVdaU2Uwc1VTZ2Ftc2ZVN1ZD?=
 =?utf-8?B?bytENnBsZEFCYWdUWG9wSEFCMVNFclVKYkZVdUpCYzc2QWRRZ0RVTHVMQlYz?=
 =?utf-8?B?UVo0bWhYbXVvVU4wRlV6ZFAvYlNQdTlKMEhDMHdKb01BMG15QUVtd2xQc3pm?=
 =?utf-8?B?eXNXejVuNmI0Vm1zRU53Q2FzNDJSVVB6V3VTY2prNjB5ZWE3TExSQnNvWmRn?=
 =?utf-8?B?bXNwVDQzckFCeHhGV1JBN2RmZmFUUXZTb2VPNDhoM0I4K3lvOVdkaTlHczlX?=
 =?utf-8?B?ajlJY3c4eEIyaENVQk9mNElJT3ZoYUpHcGI5U0ZzRlBwZjA3cXdVOFo1VGgx?=
 =?utf-8?B?MWtWdHNEa2JPQWpGeE9NWDhOMzRJNFZqZ3VVb25SVE9IbFl3YktWd1N2ZTFu?=
 =?utf-8?B?MnNLOURnZkhFVkxUMytkdXJxNUtwREZST0RDQXJydnJxTXpHYTlyTFFsYUt3?=
 =?utf-8?B?eWY5cjkrQjZDamd6RVNmMGw0d0w0V1MwOHZITW14aUNReWpzTU43TDY0OC9P?=
 =?utf-8?B?WTFMRGI2Smo5TlJhZUIvOHpTRkpVRng2L0NBTCtIYUVkL2J1aW9nU2RaZ0Ew?=
 =?utf-8?B?UUlxZlFlOHd4QmM4ajVIZjZXZ1lDYTE5eHNEbW5xcStoQlphOVE5Ym83WkZi?=
 =?utf-8?B?TG1xRU1hRUZEbXgvcWNwMDdPdUZqTmRVVnZlWWw2NU5tSlpEYkRrank5MWdI?=
 =?utf-8?B?Y3UzWFFKT3FGZExtcnJ0R3R1SHk1RXZUNTVGUkFTNEQ5WStDeDhhT3I5NHRS?=
 =?utf-8?B?NHJ5TFV2S2liNmora2syV1BuaUJnSFVxRTJuMTNzOE9rRllNUW96U1JvU1Fq?=
 =?utf-8?B?L1ArVzFGWUlTQW8weDNOV0pVejgvSnZXS0dzeC9oR3ZhOHZpZHNvTTIxS2Nk?=
 =?utf-8?B?RHJ6cHZhNnVBQ3hGWjJjOUN5V0hPcU9BVkkrWDh0OVJZMDJ2ZnZ5U0ppb3lt?=
 =?utf-8?B?VGIrS21SdURCd2NxQTFIRXA5eUVveGRFUlZuT3pzaW1uUjlGclNWTTZBZVdT?=
 =?utf-8?B?bjlYMnQrSkF4eW5CNWdhZHhYK1cvOEloVlo0TWlIcVpYYnN2VVJkaGNrcEQw?=
 =?utf-8?B?VVBoZ0NtZzN2ZHBLTjhVOERDMzd2ZUlYY1lvclpqZXV4Z1RZZ1hFeXkwKzR1?=
 =?utf-8?B?R1JUbyt2V1UzSGlYY1pYL05VRUVNb0ZDU2Myd3N2Y1B3RUhJU1ZiSXVqam8w?=
 =?utf-8?B?eUFRZFNoRzc5dmRXQzQ2YURvQ05mZTFnT3N0NHNiU1VmcHRQbFhNYkJ5QWJh?=
 =?utf-8?B?MG1UMi8wK05HYmxZS2JRS1h6Z3NQQ1czcWxFRWp2alNmWTJhbjZyc0Vqckhy?=
 =?utf-8?B?YW56VXdvcEhjaVJKcExpcHFCSW5pZGhiZk1zb0FudFVLYW9YOUFpN2syaVhL?=
 =?utf-8?B?M24xaDF0dDhRNjcvQkVjNkdIaG81MFlWKzJ0V2dMWGl0YjhuZEh1ZEJKTlZL?=
 =?utf-8?B?M1kyc2o0cGN1OGg5SzMvcG1aVThWa2dKSFk1cnBtYmtraWV4eEQ0U3hZUTV5?=
 =?utf-8?B?VXhBT1NRK1FKOGhHc1NJcmpGYVZ4ZzM4Q0JHZDRBMXZqMWFCMEU1K2hOVlFo?=
 =?utf-8?B?TTRTOW1CczRYWEU3Mkt6OVYwRk9va3FCV0tmL2daZzlDVE93ZUtzNHI1UmU3?=
 =?utf-8?B?aGJnZGZsVlltV0R2cS9RY1RFMlVpbWl5WW1LalM0UjhtcTZOTGwxM0Y1N3ha?=
 =?utf-8?B?RExuV21ORGYxT3BybjNSaXFobEt1TlJCUmZPSURGZlJzUTdYN3Z5MHlyQkNH?=
 =?utf-8?B?ZWtMN1hoYWZWaFRHckluNkRaNTM1Vno2eEZqbEJwd2RjL21NdjI2cjluRXUw?=
 =?utf-8?B?Ry9PVnRIdDFTNjJpOU12dlBucnpzRVpWM1UzSm1YU0ZPZ3BKTDQydmlwTER6?=
 =?utf-8?Q?AvWFv/0edZvvVr7rzTAA9m/vp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a10086-cd82-4790-4c0c-08dd3f9a3fc3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:49:48.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlj2iwvzdW6wTrtn9pthLn7okbWqeQdKIsGXCtPLb5jJRTrRAr2mmXPIPN2Axb6w4NyuERi1RUZ8l0p9u3Riww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

Hi Neeraj,

Thanks for reviewing my patches.

On 1/28/2025 1:34 PM, Neeraj Upadhyay wrote:
> 
> 
> On 1/3/2025 1:48 PM, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The IPI HLT test simulates a scenario where a pending event is present
>> while the HLT instruction is executed.
>>
>> Evaluates the idle HLT intercept feature of the AMD architecture, if
> 
> Nit: Start as "The test evaluates idle HLT intercept feature ..." ?

Sure.

> 
>> available. If the feature is not present, this selftest can be extended
> 
> If idle halt intercept feature is not present the test exercises
> halt-exits/guest-entry for pending interrupts. So, maybe the test in
> its current form is still useful if idle halt intercept feature is
> not present. Is that understanding wrong? Cross-vCPU IPI or performance> testing of halt exits are future extensions to this test.
> 

Test in its current form is useful when idle halt intercept feature is
not present. I will reword the commit message.


>> in the future to include cross-vCPU IPI testing.
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>>  .../selftests/kvm/include/x86/processor.h     |  1 +
>>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 83 +++++++++++++++++++
>>  3 files changed, 85 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>> index 4277b983cace..d6eda8c19fed 100644
>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>> @@ -135,6 +135,7 @@ TEST_GEN_PROGS_x86 += steal_time
>>  TEST_GEN_PROGS_x86 += kvm_binary_stats_test
>>  TEST_GEN_PROGS_x86 += system_counter_offset_test
>>  TEST_GEN_PROGS_x86 += pre_fault_memory_test
>> +TEST_GEN_PROGS_x86 += ipi_hlt_test
>>  
>>  # Compiled outputs used by test targets
>>  TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
>> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
>> index 1f9798ed71f1..23a34a12be48 100644
>> --- a/tools/testing/selftests/kvm/include/x86/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
>> @@ -197,6 +197,7 @@ struct kvm_x86_cpu_feature {
>>  #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
>>  #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
>>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>> +#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
>>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
>>  
>> diff --git a/tools/testing/selftests/kvm/ipi_hlt_test.c b/tools/testing/selftests/kvm/ipi_hlt_test.c
>> new file mode 100644
>> index 000000000000..09ed8011450f
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/ipi_hlt_test.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + *
>> + */
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include <test_util.h>
>> +#include "apic.h"
>> +
>> +#define INTR_VECTOR     0x30
>> +#define NUM_ITERATIONS   1000
>> +
>> +static bool irq_received;
>> +
>> +/*
>> + * The guest code instruments the scenario where there is a V_INTR pending
>> + * event available while hlt instruction is executed.
>> + */
>> +
>> +static void guest_code(void)
>> +{
>> +	uint32_t icr_val;
> 
> uint64_t ?

Sure.

> 
>> +	int i;
>> +
>> +	x2apic_enable();
>> +
>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | INTR_VECTOR);
>> +
>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>> +		cli();
>> +		x2apic_write_reg(APIC_ICR, icr_val);
>> +		safe_halt();
>> +		GUEST_ASSERT(READ_ONCE(irq_received));
>> +		WRITE_ONCE(irq_received, false);
>> +	}
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_vintr_handler(struct ex_regs *regs)
> 
> s/guest_vintr_handler/guest_intr_handler/ ?
> 

Sure.

> 
>> +{
>> +	WRITE_ONCE(irq_received, true);
>> +	x2apic_write_reg(APIC_EOI, 0x00);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct ucall uc;
>> +	uint64_t  halt_exits;
> 
> Extra space

Sure.
> 
>> +
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +
>> +	vm_install_exception_handler(vm, INTR_VECTOR, guest_vintr_handler);
>> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> 
> virt_pg_map() is not required for x2apic. So, remove?
> 

I missed to remove it. I will remove it.

>> +
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +
>> +	halt_exits = vcpu_get_stat(vcpu, halt_exits);
>> +
>> +	switch (get_ucall(vcpu, &uc)) {
>> +	case UCALL_ABORT:
>> +		REPORT_GUEST_ASSERT(uc);
>> +		/* NOT REACHED */
>> +	case UCALL_DONE:
>> +		break;
>> +
> 
> Nit: empty line not required?

Sure.

> 
> 
> - Neeraj
> 
>> +	default:
>> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +	}
>> +
>> +	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
>> +		TEST_ASSERT_EQ(halt_exits, 0);
>> +	else
>> +		TEST_ASSERT_EQ(halt_exits, NUM_ITERATIONS);
>> +
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
> 

-Manali

