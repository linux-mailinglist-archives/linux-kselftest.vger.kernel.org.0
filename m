Return-Path: <linux-kselftest+bounces-9905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4968C1856
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B7B1C20D6B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D278595F;
	Thu,  9 May 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2qlZQth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24166770FC;
	Thu,  9 May 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289952; cv=fail; b=sNiGVX21TW8jUnAeFxV4vPxnNjYKS1FKJQsoaJOUpI18woZWqyTtK0VE9BXFVejjfDJGDH8HVhZQS315AwxW4yGHV/7cSOEoD3t/mntBPJDhzd/WwifWkawJARbSX7UDNcRPTUknqSZKNPWnsnQ+NHmp2mrF36ZA+ErQro64JzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289952; c=relaxed/simple;
	bh=v/dPybCgGmAKbV+anGBEITVl229qwLNOXzGXtbdA4Fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B8VdmX0oYAQum2DqJ1bcV+rhxjR30qnNswRN5S546SroUURc91yo26PVWTwF+5OyjhcPtMRXZFWdDOG+WsbRbXGG16lxb7+iDnGn5qNnPRB+l+gb6XPBWvvpbAOnIj3ZHedn9yeqoxw0jr4z0eRUwOEl0BoUoXRyEvOB1uhf8PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2qlZQth; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLiOBCbq2UDTAPoGjOPspRoKtQD9MufIvlsYeUozFUjjOWR3wLxnSqJOciWKwhYiBiuqJ880H/uDHNewU/O7pEHMuI+XB3Jjf9k3sd64e0WRmNP+p6Lj/P4LbplxYzAaAVKr/K8TfEWWWRwho+KDk9NcBLlgY8x+lUbTylM0o1kjQAzkIMEPRhewgQ+5lmxxOIqWAv5HlhlcAZJDU48oXKii74osJdDewahnJaxKPxjABtJzw9l2jyBH2uf1mu1c52aTf3wZUOCe/5L3CFFTUr1dVihEM3gxa9O2FtNrHD7GwYqRGvGV8l1vCkQsqH3MSkCGCsm1dOY5Bx+kYRQbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO7EoBy7ZU/ewsoNcVo+CX5B4f7g+z7jQYIOjPWT3BA=;
 b=FpJruB/XDz6JGx7Kne4Pd16vmzTgh0Gx8+a23tdrIATF4bYg9vC+d/vCdT6V1rnC88KbcHYINpBIb331Z9PtDOuUEIc7X8GSJ7D4UnDck7x9MJgGfRodKnOV0lBaVX288tSKRPJ6DVYKNgI3Oxmg36xI5f+AQjs8K9YzybYEiOHn1UQHZJeS6EWVYLuXL8pwowMAITWMUEfx5MGzYw0TTWy6I2/9XICYUE2W02BhEUy6C2MIuBAmVGHPMlsgBAxar6ViHpRdZ2PwAPHdlrD9HOkSpO5EGTotFXdkMfFgvsjAWlWuimj7rV6u7usBxj3isG+EwYgNCERv8I8cRFKvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO7EoBy7ZU/ewsoNcVo+CX5B4f7g+z7jQYIOjPWT3BA=;
 b=Z2qlZQthB0me7OLo3cLtXdtHoKweSFmAxhYamRoJuH6DNHjT6ANSZ2lUrj1evDiJyLeNH3A9grMuWr9zyhR5NJ0QSNZNR4yWkrBlO3LW9eOVnGvsfadFs2t+DE6n72Qv1evYNKO2GnkAh2oN76/Ad2i/AD8b8vPDSCVyl+I+pzsZODytaG32mIObTetsGKl9+fc2dQ1GYwDEf/1ms1pkwBNzYGnfMgmHOq5hiSyRBJUys3kVqvq8g8IBL2dao2geSLCksHXTLzt9NDAtR3Vf/6AB/AN3uvYQtMSyHIjZ5ESrQPSe3WfC3LMqrbgg2IwsV+pk1r9aHGeX+s6QGfa/Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 21:25:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:25:42 +0000
Message-ID: <0e196143-c0bf-4d70-9735-7e6d9a69ea8f@nvidia.com>
Date: Thu, 9 May 2024 14:25:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when
 including lib.mk
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20240509200022.253089-1-edliaw@google.com>
 <20240509200022.253089-4-edliaw@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240509200022.253089-4-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd2a724-fd9c-4157-621e-08dc706e94b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZRWXlENHdzSk5KNkZvKzBkMjNTSUhIRDd3QnZlUDAzZ1ZiZzRlelY4UitS?=
 =?utf-8?B?SEd2Um8rMU5NZm9aMVRlVXBGMWZTd0hBYXE2bGxJL1NPRTVETW9YOHFoMytH?=
 =?utf-8?B?WE1uak5sRlU1YmdrZDlWNWFzemtQNWphS1A2M2krdk55cTYySlpHeTJZYm1u?=
 =?utf-8?B?ekRJWklISnNxTnUxbk5JTzlad0ozRlZTVG1CaG5UNTlSZUpVOEhmMFZuMFdP?=
 =?utf-8?B?NGlyNis4U0xwS1JmUEFnWmRRa252WDNJb1NhMzk1TmFpOUxGNEE2ZkozcjFM?=
 =?utf-8?B?Z1BOUUxPME0xQXhhak14SHo3ay9kWWJyS1ZPNUNVOGx0eDNUaU42WkExRWp0?=
 =?utf-8?B?WFdHaFZjNmNhRjgrUi9ENjJvZkZIRVZwVzVmNVVVSVpmVkZIdmtuQ2Z5dzZQ?=
 =?utf-8?B?ZUVyeVVGckZtS1V5dWNoMVpPTkdIY3E1VklMWmdaZ2pHcm5yeFVDVEtHanBh?=
 =?utf-8?B?eEdLSVZyZjJVd1lYOVVtS3ZKelRZRmJkU0NrNjZPWkpVbU90bGpKb3NQMDNJ?=
 =?utf-8?B?SnMzSzV4MlJtNkZCMGdsbzNaVThkeVlxdmZ4Rk5BRzYrckxMdUU5cmp2UDBN?=
 =?utf-8?B?Y0hLN1hEZVJsVTdPTHltc0dKZjdYN2FCbXpwYmc2dHVDRkpWUEtxTDRKdkcv?=
 =?utf-8?B?by9keEMyWVQ0dXg2NDhVQlpHS2xqWkV1U1dKQ0lQMDdRbS9Lei9QN0dPRzNn?=
 =?utf-8?B?RmR6b29tM2hoczcxTXZGRGdzVDZ6eUtUR3pWdW80TGRUOXFVYmtyMFZmV1ds?=
 =?utf-8?B?bGxQMXlseXo1Mjlqa25SN0wyNzRIRGphS1EvcmJQaTREN1VEQzY4dGZpamFI?=
 =?utf-8?B?VEFpYUx0NG10UzRWOXhpZTZIWHpaK2dud0RsUHRnT0xYUDB1RC9RUUdGcGpL?=
 =?utf-8?B?eEhzenFCUDhDdFpFU09hS0dmdWF1SkRRS1B5bVlwUWE1SUFNYmNZUENDRlNq?=
 =?utf-8?B?UExNRnVLRmRMQkxFZGZCd0NFV1BZbkNaTXNUTE1KQkRqMnE2Qm5DQUY4S0JJ?=
 =?utf-8?B?c1duOTBpaENiWnBHMjFDMWs5L3JXYzl0Z2ZDNklaRmNZVnpWN1NxQ2ttTmtz?=
 =?utf-8?B?SEJjd3VSTWgxOW5tdm9XcCtiNXJFbjg5RTZTWXRoZFRKeFQ0d3Raa3NxYXZM?=
 =?utf-8?B?R1hRc3ZaN2ZQb09yb0tHMUZVYzdmUDduTkZveGcwN1lyakU3dE11TEovS3U3?=
 =?utf-8?B?R3EvVmNMWndsODQ3Q05MZzNyWHlocU5yVTdPNU9DcmduU2dNczk2WUdyZHIz?=
 =?utf-8?B?RWZjb2NldXJ6ckQyVkIrWDVkYTRkaHBTTWZUVjZhSGxEYlMrQ3cycGxYQUJ6?=
 =?utf-8?B?aFlDWmlwb2VaNVdxYkduUE5Qam5EdlNHek9odXdRRlptRXpGUUZGaXc1emxo?=
 =?utf-8?B?K0hZbkdUaVhTWnVpUlpLSksxRGpkWElkTzFRdmVkSTlSbFVCWXZETHNHWm1S?=
 =?utf-8?B?bXo4YjlUdkM5RW45dEs1T0Nsak1ZMHp6V05Uc2pVeG9DdmhZRGIrVmpidlJ5?=
 =?utf-8?B?d0NCT251eG13dzZrVFp5cE9Ka1ZBMFRvYnZpVzlTK3BLeG83YWM4ZjJ2L2xN?=
 =?utf-8?B?ZU4rNGJGOFMvRzFZZWY1ODhTVzdvYVlTend0NGhsb2ZiSWtoR2tTd2tNOEVD?=
 =?utf-8?B?NDd5eFV3NWpiOXZIYzlrcTFNQ1BzczF3NFhJTlZFS1paNW13dnJkbnRpNzFE?=
 =?utf-8?B?UEN2Tmp5MVNzVThFWW1wUWRaMXFldlVKZmE1TkcrTWx0TVVWaHhpN05hL1Jl?=
 =?utf-8?Q?IMmeAQs67qe2gN8dDe8KMuSUos/1GCNvw8ykBpf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUt1RDVUS1QxbzJjYTloN0ZCcXFObExTTngzOEE1ajV2M2pLVUU2ZzE2TW51?=
 =?utf-8?B?RkFHVHlSOVRVWlg3NWhWbS8xSDcrbWl5QTdCcWcyZjBzeDVpa1dtRm8yenQ1?=
 =?utf-8?B?TGdhSmwxeS8zY1VJS1h2ZDNIQTBVcTZCUzVVZERVZFRtNTh5cVFQWnY2emVy?=
 =?utf-8?B?cXQ1R1BlV2pRTXF2cDFjNmFTRUJHZUxxamJOZ1F0TXZ3L1JoZThNemlaSGtr?=
 =?utf-8?B?MmRRUklIQjl1L1NoTnNtZWZZNzdpYUFiSVV2aDRIQmtJWWJQN25hLytPdTVZ?=
 =?utf-8?B?RjV3dmNIMDdhSUFaRjVJNHJobzViTnBkdDF6TGszM1NhWHNiaXEvUFZSOHFr?=
 =?utf-8?B?UlpERVRNaUJ2NG15WnRESkJ0VEZFMWJVdERLUURRa0lZa1lyek5ySlJkZ0gw?=
 =?utf-8?B?RWZub1I5TjBCWitGdExodGxtYmN3TGMvZXVQczlyZW0wR3BLeDV2QTlyT1Vl?=
 =?utf-8?B?STlSdmprU2d5NVRtVTRjT2d6Ui9MUWlrMGtjOUswdnlrY05oODg4ZGRFdFMx?=
 =?utf-8?B?RHE0YmtmWlhwQVlscmNhVG5laytpZWJscWxVVDRkdzJyWjkxNWRiV1ZYQkZr?=
 =?utf-8?B?bERjejhZbXByMVNCeUpJTzBMQlFvaGVjWUllbnpsMUFzUGo0QWJNNU5kVlJ1?=
 =?utf-8?B?bW9mSEVrUlc4ckttQzhyazZjNzJILzRteXJkVmFrczRYZzIrOFZzZ1NweFp4?=
 =?utf-8?B?VWdTTEpxbnFqU3BFbGE3R3RzL2pXaHlQUTkvMWowN3dmRUFLTWpIUnhjTzlD?=
 =?utf-8?B?UnJyVTdWMXNBNUx6WHV1OU0zbGZJRnFxaVpFNzRmMkxWTGorbjFZL1MxS1F3?=
 =?utf-8?B?eERHRE1XUWdoZ3dlVlNjZkNsK0pHL2dJRmdMZ21iM2lXaTJtMmE4K1F6NG5S?=
 =?utf-8?B?MmlHM21WeUdWdmI1VnVCckpRMjlGV2VHbytkbUl6MmQ0dmo0bjZiZm9BcEIv?=
 =?utf-8?B?VzYxTUNMdWlTc2Zlb1lMUksyNVRGMEZtTmJTc3cyUG12bklDREUyQ0YyVFF4?=
 =?utf-8?B?SFN0eHAvYkp5dXVvNTNLdGZlaEpuZGJoQnVld3hjQzJYaXlDeTlOR3Y0MDFK?=
 =?utf-8?B?a0FBaDU3aGdLbUxuWlVNd0pyZkhjMGZVQ0NTT3ZsdVdLcFhKcTVpR2xZVGtZ?=
 =?utf-8?B?dU0yVUhSejAzNy9lQ2xNdEkzaDdBYjdVQXErSno0aWU4M0VlS21yQWk3L21L?=
 =?utf-8?B?VUxpQ0NnSG94cmE4RGRrdFJYUitOQS84aHgyTXJhZVkvUSt4cjYxaWhIY1Jy?=
 =?utf-8?B?enE2S1NxbnYxSDM2cDUzSU9GZTgyUVlkbjl2K2tzZlhYbjQybjk2cUZ4OXJP?=
 =?utf-8?B?SnpjMnM4dDZwU2NDa1Nud2FLM2NkNFF6ODdpODhpWW42THE3NHM2UURRQW1n?=
 =?utf-8?B?ODMxVTNGQ1lvM094QjRxVlozMGhzWUswSjVHK0Z1QW5GcXdYRWhSaFpoWVYx?=
 =?utf-8?B?SmNobmVYdlVWSHg5cm9kdm04b2pQYkFxditIeGQycHpzL0hPbTJVd0oxK2Fu?=
 =?utf-8?B?TldjUHNiaXFHUlNycUVhZFFkWG9iczFCMFQ2bm55SDlHaEFvd1FOb1AvYzNl?=
 =?utf-8?B?MUluYWZmSy91REZ2ZHU3UVZGdjhHaG0vNHZVU3I0YTZxeENGeVVaek8xN095?=
 =?utf-8?B?MHBiT1ZPZS85cHZ3Z3NqNmFPQjhONDZTcE5xSjZIUWY4eWNhUVZSNGlOQmYr?=
 =?utf-8?B?MVpkTk1adENTaC9abi9kVGF5T0taMXdOTms2czYrWmtmSHdtVVF2b1hVZlpu?=
 =?utf-8?B?S01sVHdvaHo3SHN3dWlPV0NraktzaWlPVjlqRHZZZGVrYXRJaXZOcUZ2bEZE?=
 =?utf-8?B?RVpQbW5aanJOUklTWkVlekN2SnVNeHVwRm8wYkRlN0drSWRFaWZBbzdyTUlJ?=
 =?utf-8?B?Nlh4dHR0MVJNbFh4Mkt5VXBPVHpFYjRwNWVCMGRJZksrVFF6OFFGM0pvbUlH?=
 =?utf-8?B?K0tJS1VsNzlSUUhQY0hwK253WUY5MFhMSTBUTGFCRlFHUVJ6OVhQMzd0Mncy?=
 =?utf-8?B?WXpQVnl3U0Z1dDkrV3JjVjVLWGNwN1U5Y2c2akZuVzVUdnhKclBwd291NCtu?=
 =?utf-8?B?ZENUbXp0MHhlZlhJTmRwVm9BNGZLdG9KbDFqajlQL1dFYllUM0k4Q01Hdmxt?=
 =?utf-8?B?ckdnRVNZenAwb09vU1NPa00vNG5XelFVUWR5UzBFS0plR0w2TnlzZWc0VVlB?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd2a724-fd9c-4157-621e-08dc706e94b5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:25:42.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgDaSmE1h3q5zzKBnrYaUAaQAOrG4VG8WmUc5cpgNNqyOH6AdTisL+Yrq8dlXjGXwLjHUWYVbVQjSaKpChoHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830

On 5/9/24 12:57 PM, Edward Liaw wrote:
> lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
> unnecessary to add #define _GNU_SOURCE in the source code.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/Makefile | 4 ++--
>   tools/testing/selftests/lib.mk   | 5 ++++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
>

Hi Edward,

This looks good, with one small refactoring opportunity remaining, though:

> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index f0431e6cb67e..9039f3709aff 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
>     # $(realpath ...) resolves symlinks
>     abs_objtree := $(realpath $(abs_objtree))
>     BUILD := $(abs_objtree)/kselftest
> -  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
> +  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
>   else
>     BUILD := $(CURDIR)
>     abs_srctree := $(shell cd $(top_srcdir) && pwd)
> -  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
> +  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include

As mentioned in [1] (but there are a lot of patches to manage here, and
I think it got overlooked), you could factor out the duplicated
-D_GNU_SOURCE items into a single place:

[1] 
https://lore.kernel.org/all/ac8c217e-4109-4ca7-a7dd-fc4fc8b0a4de@nvidia.com/

thanks,
-- 
John Hubbard
NVIDIA

>     DEFAULT_INSTALL_HDR_PATH := 1
>   endif
>   
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 3023e0e2f58f..e782f4c96aee 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
>   endif
>   
>   ifeq ($(KHDR_INCLUDES),)
> -KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>   endif
>   
>   # In order to use newer items that haven't yet been added to the user's system
> @@ -188,6 +188,9 @@ endef
>   clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>   	$(CLEAN)
>   
> +# Build with _GNU_SOURCE by default
> +CFLAGS += -D_GNU_SOURCE
> +
>   # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>   # make USERCFLAGS=-Werror USERLDFLAGS=-static
>   CFLAGS += $(USERCFLAGS)



