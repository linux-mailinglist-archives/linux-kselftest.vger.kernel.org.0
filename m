Return-Path: <linux-kselftest+bounces-32883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4EAB47C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 01:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941A119E3870
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAE29A317;
	Mon, 12 May 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AZONmH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9F2951CF;
	Mon, 12 May 2025 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747091239; cv=fail; b=ly6UketoBO95HX8joiPjWNzw0upWUTnfMEMYINvkonUQtzgsJu7pnRpkalHa0yDbiLnCO7NhjHiH3661ZamkvZcgTb0v7fV+cHL7wL8QeYQXFkSVPkjDEp6ep+ibZWZKPuHUzAY0l5TG2M4bvf5d8rEIkct69afr4A0iBmAkuTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747091239; c=relaxed/simple;
	bh=rkHfOtOD6MVuZmKLg0XcNNqQGsVdCQQ2/fhUFs7moUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsQDLO/QnX2lHQzW0xiOTO6G4OBgvL4C1UbWfgGSmWG0GgjSZRU4rOdr4zWvRHH9U99t9kAc1+XQjK3O7QrQL2yndud8u/bhA+R7BidFkwA1oPi+qbqJpuqXE5qXTkASMhmLw3ZnFN7GKvf0VViKSZ9MkjTfA7wIO9eOBksM0mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AZONmH4; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPNzuA0DaNPkpNpNJmeBeQfTCTMxqY9POgc7zjEvDPSkE6anjnBLJK9Vk96CBVmyWGFrYIClGVaFFWww2iGPIrzDgm5tJXZipKzWzYU8aWMgbKWnqdLMBoAR2vAoSGtsUMymYTJRpd8TRl0LXitj+D5QZAs5mk2CTM7iyXJG3iT8ZJhmgCzPs9pl/5dGbwMxUFWmRy38VGt+ex2LE0mr8wWSVhzAAdiCiyhuetsaS1amT8GfKDsQmlRiMUKg3yCB7W4QFN9cLW0zqAzLr+MBVEv08ec3UR11a5V/zhgR6ARiiAht7YeiS/K+UTp+44G3FyQ/CXscEk1pk6u0qKzFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRVs/enrSl7Occ0Kf5weQZRK2syGKhbKYUQ/FbJ7FsA=;
 b=DvhoLAJgZuwog11Uo2pqPtB1BWtrVqP+8+gHvteR+2h/IsS5/GErTNzAxk0pxmeGPuk6rIe7+/SWgsUgfl/bKW92PK/yuu4wKscUoKtUvERp+olPz3XBdBmFLBts08BttjvJFN15BK2cAoZYWapLh+27FmgOhIn5F1nnKFbOxC8OZQgW6F1yZJ0bPE2HOmrDO/O3ejtK2nHwVrcoBddGkQhkmKqYiYrxj3yD5XJJ9XoEY+NRYNU+84Pt59SWudRWTVhWv4JmXq8gDqrfsnSNuimYFsjBTP0Lr3qlDdB88Rrrn7LtzmfRxcFRNiYH1DU4pQW9U+17fMkwYoAtAB2Glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRVs/enrSl7Occ0Kf5weQZRK2syGKhbKYUQ/FbJ7FsA=;
 b=3AZONmH4asNmmpkL3MhxJ0iUoYYTBkDkIGkxv4eUS47TOXfX03dV9kzWJfs1VOW+dGOM9zlsRBn1P1mgDS85QU8/kx5dp+cHUbn8lW19yjaWJFKBIequPjjeP3mJN1ncneb/zF4n74Dcppo/TXf7l18LgBCSHPME49lqXY/VOz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 23:07:13 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%3]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 23:07:13 +0000
Message-ID: <708cfa2d-0a5a-4f83-bf43-97a63a8ae4ea@amd.com>
Date: Mon, 12 May 2025 18:07:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: SEV: Disable SEV-SNP support on initialization
 failure
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, thomas.lendacky@amd.com, shuah@kernel.org,
 prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20250512221634.12045-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20250512221634.12045-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0070.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::33) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a6c319-27b2-44e3-d05c-08dd91a9bb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUFJM0dUNTZWZ1MwQWs4M1o3d0pHZjBHazY1YTZ6MXhrVzRqYXkxa0hWaXVO?=
 =?utf-8?B?M2hiTU15Q2ZTOUh6cUtmcTFJcW5hVFlKVk1MVUI2Sm5uRVVDdzdBMjdSOEU4?=
 =?utf-8?B?RkRTWUJuUmFXNEgvOEk0cEdyVjd5QWkwZjFMMWFjNUFYMzhOVVQwdmxBTzUx?=
 =?utf-8?B?Q2FrRFJEQmRPWldQNG9OU3NKYVFobitWaEFLVUtkdFVwZUVJc2FZTWp3NGJE?=
 =?utf-8?B?Q3lUSEhOUHAzWDE3d1FML1hHVnUzcDY3UGlycm51TUJGejNFcGhhQjFkYkJH?=
 =?utf-8?B?Y201TVY3VEZLcmRSYjlpdVdTSnRTV0tkc21VTVEvTzRHNG5ONEdKOXZBY0ZK?=
 =?utf-8?B?UEhKTGNVY042Ym5JbHlSc24wcDBkU1QvLzMzUUFnN1pMbitWODkvaFdEUU9x?=
 =?utf-8?B?QXV1TzgyQlIzTHRyYytVYWdWcCtSa3hiMmszamJBQzZ0cFM0UlliNG9hUDNU?=
 =?utf-8?B?YXlBeVQ2MkQrNkY1UG5OYjdNV29CQmxYVERDM2hxYmU2T0ZrSWtpY3kyM1hs?=
 =?utf-8?B?K2QzVld0ZVBSYlgwdytna2ZjdXM1QWVLeDBkc2ZMSEJCQldNNm45MGh2UXZo?=
 =?utf-8?B?ODVqM09UZ1pBOFNKREhBSnJiMXZZcXJBelNEclJOL1dSaTlld0YrbWo0aEp4?=
 =?utf-8?B?c0Y4OXRoemt2QmtYbm5mSG9hZ0s4SzIybVdLOTkxdDRMYWU4K2xmYVpXdXRy?=
 =?utf-8?B?RGg1OW96V3VTVDV0Qm93SlhPSi8yN0FyZEJRWEJIZDNUbTB6SlFOdGVUNi9C?=
 =?utf-8?B?OUN1ajVQbmtIQmVVVkdYOTZuWFBhK2ErNUZNMmFMQzRhaDFmaDVtTVIvbUlO?=
 =?utf-8?B?WkNKUytTVXNuTlI0dTd4aVVuME9qcUROalhzSTcyb3ZzVWpqNEsrd0tYTmxZ?=
 =?utf-8?B?S1RDUWY1bWFQckVMQTk2TG5iQStqTmRoNXBndWVHbDZTcHNpcHpCZEJINktZ?=
 =?utf-8?B?S05Gb3dURUZDR01EL1Z1ZVZYYWM5dXp4blhBaWloRDhWU2kvZEZ0TGJXMlo4?=
 =?utf-8?B?a2tLWGlmMG93VlZ4VUdpRlhURnBucXZSVWFQRDFUQ2xGczlldGRadFFrNlhN?=
 =?utf-8?B?b3hPSVpOUmVBWnJnSmlsdnJTRWRDMlBPQlBjWXR4cXFzSE5pVmhzbnM5RlBR?=
 =?utf-8?B?TGQxczB5eXZqNStWNVppdldYU1VOQnhlYldoZUJzKzFGazAwek8renBXajhY?=
 =?utf-8?B?bnpBQ3dpMTRLRURmNk44a1MrTWpEZjlFblFDTGxQV2s0UjFlUUl0Z0pTUngx?=
 =?utf-8?B?VlBMUmhpdFAyMldRcVl6R05GMG5qV1d6QXhha2hlaytFSDRhaStWcUljZlpm?=
 =?utf-8?B?UFZHK1dGU2ExR0JWTk5reDBjNlBFVGMrSVJjbUxHdkdJaVlxc2pqbEYzc1pG?=
 =?utf-8?B?NFRmYWoxSTRGc2VHeHJ4Tmx0czB5RENxMGgrcjBzZlE0cjBSQVNsMzV4NzFy?=
 =?utf-8?B?MDJmRVJvUGFkRE1zWHZKTzJVSVllNnFrbkFseEpBTTZ0d1Q5SkhQbVF0empP?=
 =?utf-8?B?UkpIclptMFVzd1g5Mjc2NjZjb0lFVW9UY2o3S1Z3VlAxYnlTdHJ1Vmk4VnM1?=
 =?utf-8?B?RlhvTmNuZHBYK1E0UHpnUElRSHp5VDlrZCtIdjFmd1JvZU1ZTDJDVjFNVmpL?=
 =?utf-8?B?cjdjck03Yy9rTXBmTGdVcjg1UFlROGYzUEVEVldBc2U1YkZQUXJ6bmlQdjlQ?=
 =?utf-8?B?UUNlWi9sUldMZERBaG91am85bGc2aVQ3R0oxd0FUbWJvOENud2g0Sk5SeGVt?=
 =?utf-8?B?Nm1pckZHQ1JoVDJ6eEVNVlE0NU5qdmZNdTV3SzViUzVUdkJmV3JHT1M1RXkz?=
 =?utf-8?B?eVpXVllOb21UaW1oeU9RMk13U2RzSWpDb0tNVCt3YUMrTGdVNzhmMm5NOEdB?=
 =?utf-8?B?b1NreHUxNW1xbXZ5ZzVYZjBjMVpKUHJkS2JyT1hTNGlwd0w1MlhRd3FRSC9Z?=
 =?utf-8?B?RDVTZmIzQjJBbnJBb1oxb1lSTnZiVTcydkY2Mnpzd1d2SkhqTXhHK1g4VXJt?=
 =?utf-8?B?OWR5VFBHa1FRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDBzamlVZnB2eEdVMnNFY2pMMXVCZWZad1lBK0V5Zkg5N3hlcmEybkUvdGh3?=
 =?utf-8?B?TEhmS29mNEhjYjJTamVneGREOUpCVDZRTERQYTNJMkkvV1I3d0Q5Q05OUFJK?=
 =?utf-8?B?UFRnWU9ua3lFOG9TbktlMEFTYTgyR3lUVmdCRUFQaGgwbUZBam94eGEweEdt?=
 =?utf-8?B?UFRpUWsxMWFHY0pDMjN1eGttZUt6anhTRW02allZeEM5MENMMkRQcGRnejZP?=
 =?utf-8?B?dkM2ZWNjbGp4d21DdkdiaVJCQ2wwK0hZcW92MDJ1R2ZEc0RUNUdydVkxcUJG?=
 =?utf-8?B?WnFBeDd1dWVSWjk4K2dRMnc1dHRwVVRaSndvekRvM1N6bS9NUngzbDNacmFO?=
 =?utf-8?B?bmpCZTJ1cVduZm1PR3QySm15eThDcW1rSkduMEgzNnFkMDFHTG9IU01DWG9C?=
 =?utf-8?B?czVLblprUmNaQVNzZjRVb0ZtMlpXRFRNWEt0a21RM283RG9oNDZZdVBkWSs4?=
 =?utf-8?B?TnFBbW1ZTkYzbk1veTJVcFlnMmVGT1R2bGcyWkZrOGlXdUI3TE52ejYxdThW?=
 =?utf-8?B?YlorYUtBcVRyWHFPd2pobVRyTWNNajhyS1BoL3NXT3o0NFBEOGpaMDVwNytl?=
 =?utf-8?B?VFZRUm1teFh6dEFDMHVOYzcwUHgyWFIwTWZkUk56OEgzMXdsS0ZhM0tkVlhG?=
 =?utf-8?B?NXVGNXV1U29TellZWFE0NDZBb2RCZjBQaDE3S1FZekxTZUNTMEdHeWFIbjJF?=
 =?utf-8?B?TEluOHNsaVl4TDFaOGU0UzNqc3l5RXhkM2o4WDJkc2Z3TjhtRndtOWg2YUl5?=
 =?utf-8?B?NW5oRnUyVWxmMThmSWFva2g0MUY4T3FsenhIc3hTTHVUbDg2UWo4bnRnUzBv?=
 =?utf-8?B?ZEF6M3ZndG5Ld3d5eVRVNlVnR3dYdjhFNVZDU280NE1PRmZta3E4cmZ3eDJX?=
 =?utf-8?B?UG55VlNVNGZSUzJ5djJPKzVOZDc5Vy8vTWhJSHdZMldyakdWNEVzU3pZejMv?=
 =?utf-8?B?T0x3NlRDdkpKS3lGMmhEL2xvdG9NTHBRZ3dyZEtBbkw3U2Q1dXJHKzN6c2NG?=
 =?utf-8?B?WVpFZkM5QlBtVitsYkdsMVNPZnVhNlJLN05UUXZkM1VJU2p5Ym1YUkpxZnli?=
 =?utf-8?B?R1Rnait4aU80M3FYQ0dxaitobW1jd2FWZ1QwdWZkSHVVSUZrcEdWUkZVcENZ?=
 =?utf-8?B?RlNET0JZSjVoSDNvT0lRbndXcUNBUGRTVXB5TjF6MzFIbU1jdXRiN2NtZnQw?=
 =?utf-8?B?cERkeXF3d3prb0pmRzI4QUxNNVhPdTN3K3ZqWWhnKzkwZm1QNmNPaUI1SGVX?=
 =?utf-8?B?cjUxVkJISmpjY3V4T3J3VitLNnZvc2R6b25WSkgycTdqNUtmb2swMnZFZ0FH?=
 =?utf-8?B?QWc3RDhabm9QV0pSM3VqQm5aRGlpNm5nQlMxd1dTMUxvOEliSmZZRURORUo0?=
 =?utf-8?B?S3pNdWFCbHNGTFNrNC9YTm02dGtjUm5QaHN6a2Q3YWh5b0xPR0VkRUNDZ1VK?=
 =?utf-8?B?NGJRREVIYWlJVkJUYTRHaUkwOCtNcE1Qbi9pNndqc0N0MXRFWjhnNjhCcEpV?=
 =?utf-8?B?L2hES0ZqRENKM2IzZ3hNQkY4Vm5Cc0ZtKzR1M0Z2aEFBMkFhU25nUVZJalJy?=
 =?utf-8?B?dlNBdUpKcXo5UlpCemUrMUJsOWJxZXQ0TmxwTWEydjZUQmJXMmsxN2phb29U?=
 =?utf-8?B?dGQxdVJTUjNLazZnVERWakx0VHZFSzVNT25NM0tjR0xVciswMVhEc1V4OFVG?=
 =?utf-8?B?VmUya2RpenlJVFZrVEVVUG9CZVBvbWNTQlRhUDBOZ3IzVG9FTzhxTzF4enJS?=
 =?utf-8?B?QktkbUtMbjNIemN0RkhZNlVGWWV5Z09oanM4YVI0akoxWFd4bU9zTldTazFP?=
 =?utf-8?B?aENnbVJMNktERk5ObXF6ZlovR2M5RSt1U2FMVDVYWndWOGdCOGRURG5RYVZo?=
 =?utf-8?B?QmdJM2taK0c5MWFleitoNWVDTDM1QXNmKzJYa2NZRDVPZDFRKzgzeDZua3JD?=
 =?utf-8?B?ZGxCZWF2TU1tQUdubFRQVlBkN1RwY3dvRjEzZWxwcDZENGhQVUlkQnl1QUtP?=
 =?utf-8?B?eCt4cDcvQ2F5OWRPSlRlZTV0QkhvVEZ3NlRwdEU1WVVoRzg1T3ZnV2VIQUc0?=
 =?utf-8?B?eTI4bnM0YmJJVXd0NDZmR3FUaG5Ldk1yUTdteFVCNERnTy9XSGVNeUNpMGR0?=
 =?utf-8?Q?bcf5ptZpEPcuGVi28OjllQBMg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a6c319-27b2-44e3-d05c-08dd91a9bb4a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 23:07:13.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atVCh/cxn4or0zEyWHxgCAfABu5HQ9BET+WOTpIDF6bPEcxIHx18rh0iJFUno8UGn8G1aW9rd5q79oEqCVlwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459



On 5/12/2025 5:16 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it.
> 
> The platform may have SNP enabled but if SNP_INIT fails then SNP is
> not supported by KVM.
> 
> During KVM module initialization query the SNP platform status to obtain
> the SNP initialization state and use it as an additional condition to
> determine support for SEV-SNP.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Pavan Kumar Paluri <papaluri@amd.com>

Thanks,
Pavan

> ---
>  arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index dea9480b9ff6..8c3b12e3de8c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2935,6 +2935,33 @@ void __init sev_set_cpu_caps(void)
>  	}
>  }
>  
> +static bool is_sev_snp_initialized(void)
> +{
> +	struct sev_user_data_snp_status *status;
> +	struct sev_data_snp_addr buf;
> +	bool initialized = false;
> +	int ret, error = 0;
> +
> +	status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!status)
> +		return false;
> +
> +	buf.address = __psp_pa(status);
> +	ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);
> +	if (ret) {
> +		pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
> +		       ret, error, error);
> +		goto out;
> +	}
> +
> +	initialized = !!status->state;
> +
> +out:
> +	snp_free_firmware_page(status);
> +
> +	return initialized;
> +}
> +
>  void __init sev_hardware_setup(void)
>  {
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> @@ -3039,6 +3066,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +	if (sev_enabled) {
> +		init_args.probe = true;
> +		if (sev_platform_init(&init_args))
> +			sev_supported = sev_es_supported = sev_snp_supported = false;
> +		else if (sev_snp_supported)
> +			sev_snp_supported = is_sev_snp_initialized();
> +	}
> +
>  	if (boot_cpu_has(X86_FEATURE_SEV))
>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>  			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3065,15 +3100,6 @@ void __init sev_hardware_setup(void)
>  	sev_supported_vmsa_features = 0;
>  	if (sev_es_debug_swap_enabled)
>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
> -
> -	if (!sev_enabled)
> -		return;
> -
> -	/*
> -	 * Do both SNP and SEV initialization at KVM module load.
> -	 */
> -	init_args.probe = true;
> -	sev_platform_init(&init_args);
>  }
>  
>  void sev_hardware_unsetup(void)


