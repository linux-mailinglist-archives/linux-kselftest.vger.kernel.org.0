Return-Path: <linux-kselftest+bounces-26981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CAA3C2E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554DA3AC9DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D131F30BE;
	Wed, 19 Feb 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mAnxoEVA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D51DED55;
	Wed, 19 Feb 2025 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977132; cv=fail; b=V9ppC4Y+1aXKrC+395ndOE+3HS+OiUV7xdGcmm69wB29ldcktNKU2Hy8nVnGszG5xtpcojFYgrkZcrmCdihyxD5psSHO+Cv+1/nsgKcDSL7veBEzlNmvFbFOYsMZBjYmXJ7rqU9IgPOq4trFh+hVA6sNKqezbMjtSuQmX0XbuP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977132; c=relaxed/simple;
	bh=PJ7GJyX37qzSuIfr586vyCq72wEqPgGjzNemnoN2zDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyF4FnfRfeBIetlDeavBKSmIneJXwHh2fQIq8ZBclbXo+e1Cz9i1P7E4hdHDSCZ/pbRRsncbJezUqyVvdhKgkGu+plW4pfDk/11d72iZYVPmEVW/uyeMjlLMJWyiVZcOTg19Erz9k2jNwDtV/yVsfEasPSL4c2UL7loLgxxKhmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mAnxoEVA; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJ6DpuNPDoeh4zJ7tnB8Qf2ezsul1cyLw0IQD+ar9YBQrkianGhlEN3nqJ7QwFKR3JXB2dLDLfWU30+Sr7S0cIeufkg5dHdTay1USyEGt8LhVg+PbKNBBcik9MNSaH907+ELWl5VAr6u2GfsUYKh6VbVTIBw5zjK4UxewUSEbv4/KcVZ3Ri7ltuIO+4w4sRVZ4qx8DxJ6rfaNKixImCH2IIQRFdbyCfx5dfgZ04dbgc2iZYGt3yCjqjwHayTU/kFVNiB69zPWCjQ5eOtt7F4De6/7Vhw8hTy8EI35BXk3tieCiKZj58/LJkwpy0t0/g648XF1tLjS/yoGVtMx+2cKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TgIbuo0VFbiqOdUDzuqW1Lq02wDm1rpc8dyNzvE5HU=;
 b=FQUSU751THatixIie2CrmnG+0/PbtlmpTmwE10Ou/LX9sDJCIa1jjzfKRzGQdJIZrzQWpaW3xzUNNDsRY/36GQ7quPtsjCWqDo9tIVsokoaIX4R6HgEFUxpw8Kumz25DrfhEe0waS220Pc3kCJMrwYqGATxE65tO8nVDb2Elm8josf4MtkS7VjK9Cmm2b5yVbj/z0f32EODCa5oolDrJLHTDquxj9Ap3+90bNqDQbUNBw9tHrzg2QakvXsKbA42eL5kCdU0f903eQuUxITXq2dZhzXsqJeHcLZfU+R4r3UvhFCbHsRrETRuhtroVjzqyQTrgWdLIodnB/NHggHlB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TgIbuo0VFbiqOdUDzuqW1Lq02wDm1rpc8dyNzvE5HU=;
 b=mAnxoEVAVLC5pIv7ryV2unsfPinQ+Ptz1NMXZof7X8BZBXKkyenJZ4VLuTYCzRr9T5BN1TcjNViuiBRSaLej6kfddzWY7xJtgWMXALsKUnKeFZ17VcxOLFmud5j/6HElu07+EcmMwuYwpVfjRExCxO8mk/LE1lpIzRpjKEDEJD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:58:47 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:58:47 +0000
Message-ID: <cc0253ec-bf30-49b4-b7fd-15a063c80b9d@amd.com>
Date: Wed, 19 Feb 2025 08:58:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-10-prsampat@amd.com> <Z6wIDsbjt2ZaiX0I@google.com>
 <e3136d20-977a-4e2d-ad7b-c04be1dca1db@amd.com> <Z7Ur3HyM15vFBEvR@google.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <Z7Ur3HyM15vFBEvR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: a657aee1-a857-4d57-306e-08dd50f5e99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajhZbmllM1BKREtVVVZYMGV4YUwxbnIyYjg5VEh5eU03UEF4bGEydks4SlNm?=
 =?utf-8?B?V1hQZEM0dlFFQzMvR2RWc0Rmcm42WTRqejZ3cnVlaFhIQjNvelEvVE5ONkVQ?=
 =?utf-8?B?SzN1S041b0pOWFhSZWE1REtWd0pGUEdZdEdSM3g0R2lzeVdTaThub3pYYXha?=
 =?utf-8?B?ZjNlSkx1NmtZZ3k1VjY3SFRFeGpqZHhmQW1TaXdabWkvclFzdDBTSlF5aC9C?=
 =?utf-8?B?Smtqazk5Y1UzUHBOZDZSaThEUFhYME0rQm1kMmc1dUVqSTFHZ29FYTYraGdz?=
 =?utf-8?B?Y2lLTGlIZTZndUtpTG1OL2VCbkFGdUV3RzhEQlV2NmxVTEpIZTFVYkd6bW1G?=
 =?utf-8?B?enUvbWtlaytIUXUwczdFdktLWFAyZnQ4djNXeFZEdXlVY0prMVRWdC90NDJK?=
 =?utf-8?B?MU1BNk02Tkwzb0FlbGIvTCtTL0Z3RnhKelBtNG03eU5SVlBZbzJhWlBaMFZH?=
 =?utf-8?B?eG83ckpzekxMcG5Ka0U2TXJnMEI4ODdhT0FjdVoweEtySjRTeW1YS1pETmVa?=
 =?utf-8?B?UjlkeUhlZnNsVS95eG1xLzQzSnVoaUc2YW9BQXpsdTZ5VTh3Um5sWVd5R0tQ?=
 =?utf-8?B?Y0Y0ek16UG81M2hYRlpFZWIyOEU5UVZ2TUxuNnZFQmlBbkxQbzlzdGg1SnYy?=
 =?utf-8?B?OXhCUFpmaUo5SFNMRERpalVsNnl3N1h5MU4xWWJLNTZvSUI0T2dxOXdudVFS?=
 =?utf-8?B?aU12REtiK1hrT1dxdDc5ajFKbUtMekpNZU10d0NTOHZGSnhtWXV1NUNSZ0Q2?=
 =?utf-8?B?QXJLSmR5bVFPaGlxcWNJSXZIOHQ1UmNzdElvKzdWdjk2NllpUGxpS0F1aGx3?=
 =?utf-8?B?ZTFaWm9lUWE3UGFDRGpmaUdYNWZ4Zzh3dXJZcEU4VGNlN1B3bFcwbTRUWnJp?=
 =?utf-8?B?SCtMTmF6Mzc1d0dFOUxqeHZlTWR5UFVKV0kraGdJT1psNWVIOENrcFB2cmJV?=
 =?utf-8?B?SzE2NVVmMG9Ua0cvWW9kaml3d01wQmtQOGJDZHNvaWxZOTUwcWo1YXd0d0JQ?=
 =?utf-8?B?Rkk2R0prTHJDd3E5TEJSUUp5WFFxcWc5cENWaFVQMGhkLzZMTitKZWYzN0R6?=
 =?utf-8?B?QmZjTm1CUjRLSW9xRTlNNWVHRmkrM0t0aUJSN0FLS2I2TUQxemFNKzZxVGNI?=
 =?utf-8?B?MVYrczcrQW1vN2dNWE5mYWNTN0M1ckZvUk9QYzBBK3VhemZDRjVxcnAyanVQ?=
 =?utf-8?B?ZTFhaVNwQWVRdkdMdk9UT2ttQTBVazlmOVp5dzcwMXFuZEI1STdBVThONnJR?=
 =?utf-8?B?Zi9ad0lVTEFDVHpUMjlObURQVXRHTkltYUdjZVFVdXRJTmhMT0dKSjZaL0sz?=
 =?utf-8?B?aXhRQUIzUktVL1piK2RCbit1cVk0R0kyb3MwaXpTYWJEbzFnTVdDU05hRkNq?=
 =?utf-8?B?aW0vMmwyTGxVUk1MNlZadkUyRlVKYzRNOWNWYkVodTgxaXV6UWZFS2dMSXBY?=
 =?utf-8?B?cmdRMmlQcmI2WVFkTzYyNjdTS2J4QnVzMlV1YkhITXJoVlBwaTBROTJIYzFx?=
 =?utf-8?B?NlJKQW5UT01JMnVkbWZhLzNzUnI3SEpscWxCWFVwb2drMElRZmdGRlBQNk5u?=
 =?utf-8?B?ZE5sK0YyQW5kSlRqL0tycTRUTEluY2pDZVRuYVYydUR2UU1jN1dud0twQnh5?=
 =?utf-8?B?bitOcWJWNWJBUU5BZnhDcTJEWkMxWlRGWUZrZFUveWNETVhiN2tObUFMZHBP?=
 =?utf-8?B?VEZyVVNTQW1YVmJwUHJaZkNMR2YyLzYya00za0hYMXlzWGYzUlI4UG1YemE5?=
 =?utf-8?B?MlNQQTFpbTJwYzkyUXBLdzhnRThnTEdnL0VGNU1xSlgvY0R5RWltOXlxRXhX?=
 =?utf-8?B?bHJiY0NqMW5HZEhDK0xYaGRoOUtYZk5CRStRZGRqcm9qbTljZkNGc3JxdGpq?=
 =?utf-8?Q?OhEH/mPmEYklk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm90Qmh0QjlLU2NRand1cFFFS1UwT3V4QzRKZGdOc2hFL0ZBTVdXdGFBWGxW?=
 =?utf-8?B?Y2ZacXFZOU1WMUpDL3hZdE9iTWhuT2QvMGZoV3BhckNuTkpQY3AzcnhNc0FF?=
 =?utf-8?B?NnVtL3ppVmJiK3drSi9LZFc5TmhlUWt1cDczUkM1ZUJqeEEyOFVCTTdvUVhV?=
 =?utf-8?B?Und3VTRvQjVtRXd2dlUwZTZwSDd6ekZHSUM4OFBoUzBZdVNlMXR6bXJneHM3?=
 =?utf-8?B?cWt5cHpBYzFvdUF6NFdINi9UQWRSaGFZR0JLSk5XSitPZEd0TnVBTWM3Ky9t?=
 =?utf-8?B?cWdGdTdvVU5nQU9tczdweEU3eDNCUVlweEZKYVJWTzQ5L3dFZVJvTjAvUloz?=
 =?utf-8?B?MlNiSUZrV2QyTmM2K2lpdUxxdEFtSzJVeXlKNjd2Ri8xTGVjNnpBZW5EZnYy?=
 =?utf-8?B?NFVWZlNyUEFKZVZjekM3NWppUGpMQ1hGYjdPR2kwVmk5b01oVEtyV0g1enJ1?=
 =?utf-8?B?aElFSnJSUFlkMFdTaktJN1ZkdG5NM1JabnJ5YjlHWmltYk1zNC9LaFl6bTFq?=
 =?utf-8?B?Tk5tQ0xXbGVNd2U0cElER2RubzFDL1IydWVocmtjT2RXSDVWVmwvWTZqSk5N?=
 =?utf-8?B?S2dlUzBScDZNVFVkblFaWU1EOEl4NWFzZWtHcmRyVDJGeXFnNjR3ZTVZS1hv?=
 =?utf-8?B?cU8yQWcyQ3I4T1doUmZ2SFFLSTREZGtsOFU5TytYVTBLTWdYNElwNzl0SU5j?=
 =?utf-8?B?aTJwU1dCOHJIbUMyWVRSdG13Ry9CclhTVmJNZUd6eVJEcG5uUjRzeThXSVc1?=
 =?utf-8?B?WkZDczRJc01pYlNZS3JsQWZuRUI3Tzg0V1hWSTV3VHllektoUzZreEc5bFNa?=
 =?utf-8?B?VFNMQ0ZNaWh3aHlYNjlJbUd3bklxaFdtN0trWVZ5SDFkeUpGZXhoU0htM2hX?=
 =?utf-8?B?aGNnM1BYajlPQ0dqaGlhZDBJSGx2c29iMlNsTElnN25mRExtWjBnOVlKeVdQ?=
 =?utf-8?B?Rm5oZXliUWFFSDVwdThUbnR0NDZpU3NkY2JHOXcrTVlDRkZkQXMreE95VGxE?=
 =?utf-8?B?RzY4bzNWN3JmTkdGUUhNb1AwV241WVQrVC9RM2l3eml0cG51MWhaVWdKU1Rl?=
 =?utf-8?B?UEQ4TVlmYm04SEp4NWZOMjdyY1pkMUJaNVBJWG5SWU9KTFdMMWxaTzZEMlda?=
 =?utf-8?B?VkRocDRhN2lMNXdPNkhuVlNBZnRpMTBuQk1xajdUWWxFNFM4bldLckpWRHpw?=
 =?utf-8?B?QUt6cmRIbmFUWm8zRHFuWUp2M3NzdUNxRkJFZ2R2TUk1endIUkkraHFHSEtp?=
 =?utf-8?B?bTA1M1JKNmVLK1dwZkxzRHJnVmhyenlaWUN4UzcxcWdYK25WSGdVQlZyekt4?=
 =?utf-8?B?K3VEeVBJdGxTNmFZcXY4TFJmUGJjcnhlQWpGRWlscTVBdUFqdWE3UWw2b3Rl?=
 =?utf-8?B?d3dMMEdlYWFxZjl2MS9CWGgvRStTM0F5NkE3elBjZTJ6bEQzN3FNVGxteDNk?=
 =?utf-8?B?dEUybnBSelFjbytqc3N1YTFRbEFPejlXUVRuQ1pPRm5DaXFacHA4MDJNSmVZ?=
 =?utf-8?B?YlRrZ0lqbTd2UHJ6U3Iwa1RqU1BCTGxsUkl6dnZEWEJHVTRBc0kzRjRCVFFP?=
 =?utf-8?B?MzRmd1JNdmFvMFhMSlBObncwREZ2VitqM2VaUnk4MFRjRTh2QjBVMjJhQlpI?=
 =?utf-8?B?VkV1ZEczZGVqd3BLcnRLcVNsOEpYYnNUcG9xZURtejBEYlNIQ25aV1VHbnNj?=
 =?utf-8?B?aTZsWFlZbk03azRhVXNFdUNWWlBBckhWRWxKcm5RQ0NoOERHQlc2YkZZR0E2?=
 =?utf-8?B?SDZ3Y01hUnFvcmYvMFIxM3FCY0txWHRiMStEOWovM3F1T25wcHEzUjJPSlUy?=
 =?utf-8?B?M1ZRNFRrY1FiMUFiS3U0NEFEdERMUzRWdmlCTUlkMzlLM0Fzemp5R05JU2hu?=
 =?utf-8?B?ZVFubjJTY0J1Tm42K2cwNzNVc2ZXT2pXTEZ2OElxYmhwYlowMlF6ZnU2RVl1?=
 =?utf-8?B?T2RwSDZSaVhiTVMvS3k5dUgvSEV2M1cxc3NjS0IvR1IxQjhUNEo4cHg5ZlRI?=
 =?utf-8?B?MWo1ZlRUT0FSQUdaeXlQajVKdit4WTBRYUFFVEh5WG9tR0tZYnNXZ1dYN3Ew?=
 =?utf-8?B?Y3M1dUlJeGdYM2gva0t0VEpmaGlqOXFOOWRJVlErS2svSzQ0UjFWZFdLQThS?=
 =?utf-8?Q?6BbG9ZsL48cWSPE7IDondNfZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a657aee1-a857-4d57-306e-08dd50f5e99e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:58:47.5606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItjlFNRtANifA8T+bk0zlDIpEn9pkKoDdx96r86PdyedD8XWI9eH21eEDPY0ZwmesBqy72ItM59s80E34HWUWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034



On 2/18/25 6:54 PM, Sean Christopherson wrote:
> On Fri, Feb 14, 2025, Pratik Rajesh Sampat wrote:
>>
>>
>> On 2/11/25 8:31 PM, Sean Christopherson wrote:
>>> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>>>> @@ -217,5 +244,20 @@ int main(int argc, char *argv[])
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
>>>> +		uint64_t snp_policy = snp_default_policy();
>>>> +
>>>> +		test_snp(snp_policy);
>>>> +		/* Test minimum firmware level */
>>>> +		test_snp(snp_policy | SNP_FW_VER_MAJOR(SNP_MIN_API_MAJOR) |
>>>> +			SNP_FW_VER_MINOR(SNP_MIN_API_MINOR));
>>>
>>> Ah, this is where the firmware policy stuff is used.  Refresh me, can userspace
>>> request _any_ major/minor as the min, and expect failure if the version isn't
>>> supported?  If so, the test should iterate over the major/minor combinations that
>>> are guaranteed to fail.  And if userspace can query the supported minor/major,
>>> the test should iterate over all the happy versions too. 
>>>
>>
>> Yes, any policy greater than the min policy (defined in sev-dev.c)
>> should be supported. The sad path tests were intended to be added in the
>> upcoming negative test patch series so that we could have the proper
>> infrastructure to handle and report failures.
>>
>>> Unless there's nothing interesting to test, I would move the major/minor stuff to
>>> a separate patch.
>>
>> Would you rather prefer I do the happy tests here (something like -
>> min_policy and min_policy + 1?) and defer the failure tests for the
>> next patchset? Or, I can remove policy testing from here entirely and
>> introduce it only when the sad path testing infrastructure is ready, so
>> that we can test this completely at once?
> 
> Let's do the latter.  For the initial series, do the bare minimum so that we can
> get that merged, and then focus on the min API version stuff in a separate series.
> The version testing shouldn't be terribly complex, but it doesn't seem like it's
> entirely trivial either, and I don't want it to block the base SNP support.

Sure thing, will do.
Thanks!

