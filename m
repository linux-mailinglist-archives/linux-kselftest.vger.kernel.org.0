Return-Path: <linux-kselftest+bounces-22605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D69DBA2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BB1281AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082121B85D6;
	Thu, 28 Nov 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H4Gbz+kw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBE19D06A;
	Thu, 28 Nov 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806583; cv=fail; b=faRF5AuUwl8s2mwLFVSG6OpLX2C7AR9HlwRjg5/gD3h6v77T3zBisOhI9FB2xtFkeBp4w/PQgWE7Y8GIOfYaXCU4+jElHk/Iy7dQpeD1wd4AIiiYu2UOleaqeRxFiFprQ7uHnPf4FHUN6UL9tOCZ0iKyf3wisQ/I1p6ZPRO5nks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806583; c=relaxed/simple;
	bh=dicEYUX6WajpGiz4/l+/zTUDh0lGFBPC0+8Txgh6JZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mRRoAO6m6v5dfuEmKlq1CH9B6gDSoaXF5rQ50fGwH2oecjAvaoNo5m9e2+jOUbk0R1dqhSldPD2IoIkyqNuEMu20qZVIMrYoeyMJ6yM7KRCLw7ucvWF9X4kvgiLmsDn48NX/WWTYuYZmMAkcclhW01s7BhhwWNYq2zQXpdP5DWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H4Gbz+kw; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwKNLMmJ+YTSXA51v2KhXz2LGKpyw/Wx2FW3dWPKtgJ7WQn1CuMeAdbGTMl6NKZRmAA/IWNQe8TxzVxgadkhw0u1abf+YXAwT/rc6RQxbxcDu3fPgPgdWTKW5jabNkJSVsa6c7pR2lSj0xU/v7/duERT0+YIe3MPV4JggOtpMH+qoeZSDixOdIsKvEcgpidHDbj6kravD8H0Dg0/ij8mOMPoEu4ReKhwM3Gc9kReW/dTnUyPDTWFjGwgj72Zi86k8qg+kc+Wf3lqor7YdgcVrqD5hhSg/VS0Tc14Sod9z8GVj0Q4VIIe1POKvqKAafG7/NfCl1a1i5KtTbpJVNSYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFpEdxKVAlwkGx+mitzzx4ccUBZYaO+ZGwu4ZfEdsQM=;
 b=ErCVF7s6Syio2VYzozDfhRQuyuCAgYO4nO5P7PQh17nxCJFPVEcf4xkadlNLusPz/43JYRIzSF8xU4s37MgXtpznh/SF1jSFCfB9Iw6skmE+Rw6AzJUuIFLQ+MsKc4lpfvRFcTVB9i4mh21oUyA4LA8pj+jVupLhySKma26fWnQtlXKysBK1sww9awRvgDRuw3MBXJEByV6sAgYdIFe628HjUUtvEyI/SoP7GFrI/PDGAuO5v4hOv14KeiMbHyjoE0FajeNnSXdtcJ79MhN8CnDmIgxOM1b616biXrHDXSDdi6rB3Pg8TBfFxZ6c+Si3wgzn3aQkISv6pwJYmsngrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFpEdxKVAlwkGx+mitzzx4ccUBZYaO+ZGwu4ZfEdsQM=;
 b=H4Gbz+kwQswNL07J+iCoOhaXz08WLXZp57gX46JQQThea7BXVY2XV6PucwySrHfU3Zzb+1GJEKdYlC9y6w+pBePCMlq0+NHTltRCGEu5ETPdENAsb6EMlq23YWfZ6wx/2N8/PuhPcMLtYFCl94egif4VxFk2UumyWPeK9cx7p38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 15:09:38 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:09:38 +0000
Message-ID: <5331cf45-230d-4d27-abc9-e5d92e5a6c11@amd.com>
Date: Thu, 28 Nov 2024 20:39:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for the Idle HLT intercept feature
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20241022054810.23369-1-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::15) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d2dbfa-8020-41bd-33b5-08dd0fbead6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUdiOTNPbEFnTFF1cU0vOVZ5S0ZUaUJsYUF2aSt5bzBCN1RUdFYzNHh1YXlG?=
 =?utf-8?B?WkZPcmNDN1VZeHdIejJuNVM2OGczeUZDeURFVjFUMnVLejBhUDQxM2o1RzYz?=
 =?utf-8?B?citqUzM5cloxWEY3THc4UHd5RVh6aGRhelpnblNwb1p0ejZKRmR1MjdIeVQz?=
 =?utf-8?B?SnJ1OWVoWElBaUYxangzc0VUb3VHOTV4UUlwMkNnaGF6d1ZEaTdOK01uaVg5?=
 =?utf-8?B?Yk9qUi9XejhIcm5JbEtUNlZ6ZDdEaFR3SVIrdEF3OUNKbWEvWU1WQ21rRWNi?=
 =?utf-8?B?VVFDWnVLUlJnY3BVdWh0UGJKYUpXSS80M01xdjhvbDF3dU80cS9aVlBPUmx4?=
 =?utf-8?B?OVNPQ3RvRitkcFI3eEd4aVZVL2s1bm1Ocm5XOTRJMHZSL3BacUJIUE1uR0JW?=
 =?utf-8?B?ZUE3Y2RtcHNVY2lydlk2VUVueElhNEJncjIrWEhiYUJhTEdkckh4MXJtN1ZP?=
 =?utf-8?B?cWNYeUdjVS8vbE1pN1I3ODdvSnNQbEFKeDNRZUx4cmlwV3V2STlxLzVvWi9U?=
 =?utf-8?B?a0R1eHBYT2Y2UUhOZDBuVk9obGdLL1RSNUJXMm9Dd0Y5YzNvUklCWGVwOGR4?=
 =?utf-8?B?V3Z4aDdoUjBqK0s4ejFBNVlkU3dCTXlRdENNaUt1UWJ3cXYvOUxmRnRLeHRk?=
 =?utf-8?B?WXM3VzFPNHJYK0ZBYUJ4RDQxcHJiL2NCMGxMS3I2dUhXdklGUUEzQ0Faakhu?=
 =?utf-8?B?akJMODdNK1dNSkxsUjVtanJOMEN1T1hSUFowWFlXVkNoZUgzZWluNmRKaUFU?=
 =?utf-8?B?UFZGR2JITW94QytRZ28vZWFaZ0Y2eXJwcFlha2p0QnNmM1lwMUxhc2pBZW8r?=
 =?utf-8?B?T0F3cnU3ZnBZNWtJZE5BSVlZTExCcW5HVUZ1bGdjbUVSQTVYcWxQNzlzTWtI?=
 =?utf-8?B?d1hVbHRKaVM5MzlGN2d2c01KaGI0dGdaUWpkRHVCSTMrcm12VmtsTk5HMUp6?=
 =?utf-8?B?ZzBCQkJWemQ3Z2htQXdYak16djhuTmFJczgyMVZxQmdTbWVpcGNiKy83RE5G?=
 =?utf-8?B?a1VjQklLUzEwdU12Z2RxSS9OZnN6R0xGbWNGYXU2a3JEbmpwMUxBOVBLMktY?=
 =?utf-8?B?ODBFSXBYamRJK0FDcC84dVdYVTFGdjRNbWY0ZUxHcURMZHdzclNId2dlNjNP?=
 =?utf-8?B?djR4bUw4ZzVha2JLaUttTGpSaGw5QnF2WlFZNjU2eDBKaVJBYnd1T1lxZ20v?=
 =?utf-8?B?MnY1ZGZCQkN0Y1VZNC9Kem0vcnVXT2ZTNkE2Qk1yaVJDSHdjbStla1BBRFdx?=
 =?utf-8?B?WTRnZ1dNbEUxbUcyTGZKQW0zbHIzZG1uSmk5VHFKV0cxaFRScDJLOGZvZFdr?=
 =?utf-8?B?MVNaM3hKelJxVlpNczhmN1U5cHFWUXR0NTVML2tHWXdFdEh3d3M4Q3RhUzVy?=
 =?utf-8?B?S0pBWU1kMUgwVEc3M0JidFhoT1JxSFBjYmdGRTBoRy9oS1cvYjFmU1M1U2tF?=
 =?utf-8?B?SEhBVHZVL00zcjBEaTZWdTU1cmh3NlhJV3JkOGsraS9KR1I2cnJjNHhhRXVh?=
 =?utf-8?B?ckQ5aGlCUXJma3RqSnVnSTVTT3lndEhOOFREY00rdEdUaGFMT0FwS1ZTbEgv?=
 =?utf-8?B?YS9pR0xMMWFNWDRjaE9kemNmdFVlT0VSNE9MMnN1MTBHSnFiZVM0T25lRCtZ?=
 =?utf-8?B?ZHprV3Y3R1FweklTNG8rQXgzOHJTYzlLejJhY0tkODB1czBaTTFVRXE3TzQ3?=
 =?utf-8?B?YUErTmlrV0ZMcVErVHN2WGlyWjR3dUNsLyswQnNxV25ZOWNSRWtKNjFLNFZk?=
 =?utf-8?Q?CXzVrVn8o6v+hQjOs0m69LbJzjR2OdyoTbCssIy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ai9RV0ppOVpSZjdNTVV6WWJVTTZxKzBDc2g2eCtFRWpKY2lDNFQxaDYrYjVy?=
 =?utf-8?B?U3B0eXYzejVERlNNcFpId0xFTWNwUmdQV2wyMmRLWTNUaGkrZUYxcUxwTVZF?=
 =?utf-8?B?OENnRkN6SnpCRjM5S0tCVG5VNllqczdudkJNNzZjWkxiYjNKanhpU3ZObG9k?=
 =?utf-8?B?Q3QwUjd2M1M0Unh5OStSenJSVUdOVzcyeEE4aU1uVHhoZVJGZ3cwa3diUy90?=
 =?utf-8?B?djRaVElSR2d2cEl3YlpUNlpaWTB3ZHl5MUEyYkhLNUk1RGk4Q1VEQ3R4NHFs?=
 =?utf-8?B?Ukc0Q29pa0NraWJZVzhNajc1di9ieFdMbG9oOXgyU3l6d3RNSEYwK1lUMG5V?=
 =?utf-8?B?MXEycGdnVW80SXNBdi8wK1ZUMUxoNEJpOE9MWGxxbnBrYUlKaWsvQWgyRkN1?=
 =?utf-8?B?Z3lJK2dhVzN0RDlnejRVQkQzelFSN1l2QVRPNHAvdkxzOGU5eGFQTnZKdnhp?=
 =?utf-8?B?YXhib3d4WXRZdGpuOUR3Q0tMZXpwcEhLOEp0Zk5KemFNR04yNU92ZDFTWlNJ?=
 =?utf-8?B?OUxPZ0Y4US9jTGVWQnlKM09JYTJpR1NCMFJzdGw0R3Q3UnprUVRLSm55ZUx6?=
 =?utf-8?B?a1NXQkZYN2FxNVNzUnFQZGZCakJCNE9meWp0ejlxbXF5cUJrUVplc3NCcnJO?=
 =?utf-8?B?SzZPTFAvT0hYWlN4U3pyZWl6MENxNExCZ3orUi8zaDBIQ1pITmZIdytyb0FF?=
 =?utf-8?B?R010ajFXbFVpQnhNN2dLVkRmQ2VQOGc4b1VjRzZvTm9rOGwxNUxzK1czemo3?=
 =?utf-8?B?Sm9nWldTRVhLSFR1ZEhoVTJVczhCdXo2bUQ1aTQ3bUxJZXdudExPSUEvTmZO?=
 =?utf-8?B?eUhBVjloQVducEpjb2tnU3BmdXIySW40dWVBcnhTaHVDaTJacm4zcjZ2Ynpj?=
 =?utf-8?B?dXJ6MzdDWW1oNU5mNHpQeE52OUVUbnUvQ3Nmd0hPcFVhbnhMenJ3T3lYVklZ?=
 =?utf-8?B?Sjd1Wi95ZDZQc2FxbzN2RkNDQmlVWnVQSTZrL3p4Um01RktCZ1FMeHUyY1dF?=
 =?utf-8?B?bzN6MVk1WEVXbmxpSGNOTmtEeUVWY2tPZlVwc2ZkK0g0WEJqZGZEWW1lcDdn?=
 =?utf-8?B?TzJmTGdaOXRMODNZNXJUMmZxWDdiejdiQzZNVWV6a252MDZZZ1prMEdSSFQw?=
 =?utf-8?B?anFqN05zaktjMDZpQ1pQaUl4d1pWdWFzNlRDNitiU3NkRWJFZHUrSWFMSVVU?=
 =?utf-8?B?alNlYytPaVpSNnc5dDRGZytkdkVmaHdsMWlTNlBYUW1jREJuL1ZSWWxkR3ps?=
 =?utf-8?B?bFFsQ1FPUHYwN0R2ZHdudmZOOWd0cjdQSk5Fem9KZDB5TE11YUwvMEczUnc0?=
 =?utf-8?B?RmFNVXNTejlQb0VSOHNJb3RZRlJ4NzZ4ZWY0Wm9IT1lGbUpVTWlmTTZpayt5?=
 =?utf-8?B?ZlZuTU1yQVFsOHN6RElETzRYUXdDUmczS0ZYVlNpNThtTk9XemZYUFRMa0Yy?=
 =?utf-8?B?S1ZteHM5cDVMYUZES3pmcUtaWXkrT3VtK0R1aEMreG9GOWpVYzhDYzBjMGJr?=
 =?utf-8?B?bzk5NURqQlRnekkyVjN0ZUdKMGNyck8yUElIRGRlbDlqa0doa2VlZlFkRTA1?=
 =?utf-8?B?ZHF5NngwdmFMcnlkRDBKQnZQNmV6R0xIbm1UaVhGNkFIRjlRWXFHYUJkdXh5?=
 =?utf-8?B?SVJWYVhVdmx5SmtpUzBjMCt6dmdibnNMUFNiQ05BUkloOGhmRCtCaUN4eHZQ?=
 =?utf-8?B?amY5L3F2czdpWkpWaVZBb3ltMzJ0ZHBsNi8wWDRPbFE4KzRTOHJSTnlhNVdN?=
 =?utf-8?B?Qjl0c0t4K202a3JCYVhkSnZFVURxTVY2U05TdjViQTZvSHFqdTVIUUlycVdE?=
 =?utf-8?B?YXVjU3pjU3BhVzg3UDZid1VoK3J2RGRGc0pEY0UzWkxJcWIzaXltb2JhOFdJ?=
 =?utf-8?B?ZjZHbmlDa3pYNkI5MmJzV2QzUGNKSHpxODJUblJaVE9UdlpxOWVJM2FkVnYx?=
 =?utf-8?B?cjBVdmY5S1JPZE9mYnUzSlpuR1dBTlVmR203MlE4YVhCMkhmKzY1Mit4YW56?=
 =?utf-8?B?YlZtWVo2b3J5VldpbmJjNU1RelExdHZIekIxVTZVeGszVVpNeWZod0RpQ2Z0?=
 =?utf-8?B?NnRqQUdLNmw3ckFTSTEwcTlPTktLRTBGYzlDVmFFbEtURlZWVVRNRXQ0eDVp?=
 =?utf-8?Q?zEKsIsOuXuK+nS2STxZCioaLa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d2dbfa-8020-41bd-33b5-08dd0fbead6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:09:38.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsLvjGEUJw+6R+44eiy2T+66vJG4hRWVzNFSo/6NF6DhmjXLQeTpjPWpnbNpt3faAfbNNOSwxKvc4yZNYOTaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997

On 10/22/2024 11:18 AM, Manali Shukla wrote:
> The upcoming new Idle HLT Intercept feature allows for the HLT
> instruction execution by a vCPU to be intercepted by the hypervisor
> only if there are no pending V_INTR and V_NMI events for the vCPU.
> When the vCPU is expected to service the pending V_INTR and V_NMI
> events, the Idle HLT intercept won’t trigger. The feature allows the
> hypervisor to determine if the vCPU is actually idle and reduces
> wasteful VMEXITs.
> 
> The idle HLT intercept feature is used for enlightened guests who wish
> to securely handle the events. When an enlightened guest does a HLT
> while an interrupt is pending, hypervisor will not have a way to
> figure out whether the guest needs to be re-entered or not. The Idle
> HLT intercept feature allows the HLT execution only if there are no
> pending V_INTR and V_NMI events.
> 
> Presence of the Idle HLT Intercept feature is indicated via CPUID
> function Fn8000_000A_EDX[30].
> 
> Document for the Idle HLT intercept feature is available at [1].
> 
> This series is based on kvm-next/next (64dbb3a771a1) + [2].
> 
> Experiments done:
> ----------------
> 
> kvm_amd.avic is set to '0' for this experiment.
> 
> The below numbers represent the average of 10 runs.
> 
> Normal guest (L1)
> The below netperf command was run on the guest with smp = 1 (pinned).
> 
> netperf -H <host ip> -t TCP_RR -l 60
> ----------------------------------------------------------------
> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
> ----------------------------------------------------------------
> |         25645.7136            |        25773.2796            |
> ----------------------------------------------------------------
> 
> Number of transactions/sec with and without idle HLT intercept feature
> are almost same.
> 
> Nested guest (L2)
> The below netperf command was run on L2 guest with smp = 1 (pinned).
> 
> netperf -H <host ip> -t TCP_RR -l 60
> ----------------------------------------------------------------
> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
> ----------------------------------------------------------------
> |          5655.4468            |          5755.2189           |
> ----------------------------------------------------------------
> 
> Number of transactions/sec with and without idle HLT intercept feature
> are almost same.
> 
> Testing Done:
> - Tested the functionality for the Idle HLT intercept feature
>   using selftest svm_idle_hlt_test.
> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
> - Tested the Idle HLT intercept functionality on nested guest.
> 
> v3 -> v4
> - Drop the patches to add vcpu_get_stat() into a new series [2].
> - Added nested Idle HLT intercept support.
> 
> v2 -> v3
> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>   a way that each architecture can share the generic types and also
>   provide its own.
> 
> v1 -> v2
> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>   doesn't use string to get stat data based on the comments from Sean.
> - Added self_halt() and cli() helpers based on the comments from Sean.
> 
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=306250
> 
> [2]: https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t
> 
> Manali Shukla (4):
>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>   KVM: SVM: Add Idle HLT intercept support
>   KVM: nSVM: implement the nested idle halt intercept
>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
> 
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/svm.h                    |  1 +
>  arch/x86/include/uapi/asm/svm.h               |  2 +
>  arch/x86/kvm/governed_features.h              |  1 +
>  arch/x86/kvm/svm/nested.c                     |  7 ++
>  arch/x86/kvm/svm/svm.c                        | 15 +++-
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>  9 files changed, 115 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
> 
> 
> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
> prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
> prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
> prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
> prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda

A gentle reminder.

-Manali

