Return-Path: <linux-kselftest+bounces-32748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F009FAB16C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869D316BBF8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3929117E;
	Fri,  9 May 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="idK6sa0+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE22AC17;
	Fri,  9 May 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799494; cv=fail; b=NW7gSwi8dvzFyQ6ow50bnUMfUaefxpgKRrC0K4oK5fjSenNA6cT2Il2XRTyY34HKiDMEpd37/iy1YhiziBQNIiP86+wfadcGV4Q4v3rObs54yEQt1dwZYi3wZJOnmk+0Tt6flak3YpdHBN7+nxNESrmxW5izOKOgrHQMDEQ0eNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799494; c=relaxed/simple;
	bh=OeT1qiNy9yvfIAM17xHru1D7GkLgUI9AMFNy7QPT6cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fM6TQV3jiG+VLBYLtq9XxU74Q5YgbN4jKTifQHVfmHdMO9KrUwUKAgg3f8JinCOoiym6id/mVInHTxeSszJqHDLQg1lzSngQLhFVFqOCQ8jSxzMZivcGtIlvy4G/ALtkOYXcaWAZ8hHN2J8LgACJN3eO7z4SHeBiEBUTKyY/33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=idK6sa0+; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxOttKxsl2gNbeBoz1w5b+wIP4FP5NlQag0uqtYgUth/O9igx4pHncbZEEB4tghNydP0YoTkMftuL5DIG7+II/EmT51+sXLz+AxGpEehtJ+fDKi894W+orzvdfQP32GXlpKwBvRLFoO0XyDpreXXQMBx5FJxafgFvwmWXckUnUJBgNsLn3DT5im0QV7FWhnkZsVXyj0j070UoGQ4ZiRKIV+PpZ8f81wEvNtZCpHauEbomrx4dV47b0YCPZ5nHodOjtop/dQT1El60zQVuJCewdZcpLC9lDVGrytOjq96brgK2yCq/SxSPsRHdTitqfZvmKapLIG2MqOtP6TE0QWNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbHQam/tarcFsMtGJQNBdniepYa91N8cA5EZTufWYg8=;
 b=Y1iR6hmtYmhU+L2U0YUNTUgmRPh2DEFStWdMdjQETg1xMBi72vVyKYXg+6SgSkChumQFTYwzUbT2P6HYPPPsd+yo4e184oiELCtBd5OoJhq4HsRtSC3CUapabUwPem9/zEYQEQed6CxtP49gsl2Y7Ct73QgtFfhUiHsWnjeGRReyI0AotFm6aggayqc5F3R15McMN22AEM+XEFODTfgUD+JwC2tvGqDJ30zxczBAu0mp2HmA19HkqWjoSUrlh+Zsi7STlvnspBOhU3VSkw3b7wHKw0ZestpeDDLzflxe9xfgeS7HQ7152RuMOGTF4rRCjj4cgAWebQxjbqGHLqiiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbHQam/tarcFsMtGJQNBdniepYa91N8cA5EZTufWYg8=;
 b=idK6sa0+42ofAG+5obTZB2jy4cYjAWbKDP6VQTvyIB4N1jOzHWmF2buAz1+h8hT9R5pkpEnEGFpGqbsjIRXsK5CTE8fGGHvp+yfNkICivGBUR69OpsMeEo2xjgT1caakbELMZwWL2K7Gv04NaizwEdHe9/INCGOcllS20hEUgPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 14:04:49 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 14:04:49 +0000
Message-ID: <30ec902e-821f-7b26-4316-ca0e51ec4a03@amd.com>
Date: Fri, 9 May 2025 09:04:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] KVM: SEV: Disable SEV-SNP support on initialization
 failure
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250508225257.9810-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250508225257.9810-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cb9fdb-d80e-43a5-82f0-08dd8f027625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzlIYmxKbEw1MFoxMHNMeWl5cmNlWlFVZHRkVThYbitXOURoR201L0VXQk82?=
 =?utf-8?B?R25IdFFpQ25mbGhoL0lNSVowVFFaZFZiektiWG9tTXV2WElnRFU0UGlxMXp6?=
 =?utf-8?B?K2E3L2YwN2xhUHBQTWIrTkh3bk5XbmNFbnpUdGFJRGhkWkV5WEhkbUd0Tlc1?=
 =?utf-8?B?eFBONzcxMVdwSThmNE5jc1d4Zk9va0wzd3VQczJvc0tCVnIvRGR6OFU4QklX?=
 =?utf-8?B?cjRmcHZTWHg1VmJyc0tpM3dKMDhlOGVsTDA2K1NLby9GbHU0S3FvRGNsTmpa?=
 =?utf-8?B?cWFsSXROTllSMVh3NXMwYWJkU2hBRDBRQlkvRGFQNDUrWWI1U1ZwSzdsa0ps?=
 =?utf-8?B?WTdQbkZHOHpvTlh0MFp1UXNyeWtlZFVwRzkrRkZBL0J1R0ErdWJNa3Y4a1ZD?=
 =?utf-8?B?YWtOS2F5cjIrUGM2U0R2d2xFbGxsVmVNZHFHNFFUQk52cGdaUlBCNEVPVDZZ?=
 =?utf-8?B?MnlxdGloSmRUcXN0MnJvdWx0MDBFTTZNUHFxTzk2NG8yN0M5dzVmV3dEQVRZ?=
 =?utf-8?B?bGdMNnNYTk1yWk55M09kSlhPQURucjJaRVBDMGM5RFF2LzRqSmVMOExwci9a?=
 =?utf-8?B?cEM1R3d4WmJkc0JSVGVIMlNXL1d4Z3h2bHh2UkxOMVB0S0pzb3luanhaRU5R?=
 =?utf-8?B?YUJrdXFxL2FaalQvUHJlZWIyUWNGR2lhQm02SVUvclRVa3RXTS85UnNWaTBp?=
 =?utf-8?B?UmV3WWZjYmhYT0p0SzBpZjZiUGY1azdBWGRmam8zc3dYQWZzeGd1S1ZpalF6?=
 =?utf-8?B?bVlRZEZmeFhsbGcyTU9lQU9qUUJGcVNwdFFGZW5UZENLVFZ6UGZWVWZta2Fo?=
 =?utf-8?B?Skw4Z3hHcldBU2dHVzVVYUNZRlNiN055K3NKMW9ESTJsVEI3NExQbTFjZzRm?=
 =?utf-8?B?NWlUTzU1eTd4VGxOL1JDUU15ZUJhNWordmxOWkxta0ZqNDYwNTZoeDBjWmYy?=
 =?utf-8?B?MXF0K0wrOWFCUUFJbXlzaEcvRUxGczh1WnVsTXY1emNvcHNUNjJTcWtZZlNz?=
 =?utf-8?B?VWx1RXVnYWF3ZHdDZUt6dkhSaUw0c2Z1OGRaVG1ndHI1TTQxd2hVZ0N3d3ly?=
 =?utf-8?B?THVuSTNHMEZISWpES2t2QVFHQUR4eS9uQVVKNE44TnQwV1VPZlo5T0tndGFZ?=
 =?utf-8?B?cGYrdDk5SHY4eHpMQWs1THFWeFVwOURnTGl3QVJTejQ1UE1LY3J2UFBoL3lT?=
 =?utf-8?B?YnVsdU5MMmI3RHdYUFA1T3NKNDVyNHZqN2ZQVkhwWDgycStGTnNlZmtpNTh0?=
 =?utf-8?B?MCtNelphRUpxTG51aGFZWjlNY2pvSm52MDdkc2lYRzBHT2s2Q2w4SDFGODkz?=
 =?utf-8?B?Q2lEcXRRMmE5bXJ6UnBWeUp2NDU2SnJvTDhpMlpsV2NzVFdJdTdVdFZ4R3E1?=
 =?utf-8?B?R0tZUzdpWjU1R2sySmRKRUs1dWw1UWZmSS9hUTZ6bnRXdWVsSVBCRWJIR0FT?=
 =?utf-8?B?QzV4UXRYUkI2ZTFmbytnOER1VFRkZkJUSEJTbTVDVFU1VkhyQm9jVXc4REdY?=
 =?utf-8?B?cGZIUXV4a29VWThHb0tKc201SjBsSHlTOFYzYXBLSmVKY3gveE5xN21LNmJ2?=
 =?utf-8?B?YXdQTHJvRUNNYTd4cXpQRXZpNWRKM0wzUDZiV2Q5QVBDWVF6a0FvUHpHcGVm?=
 =?utf-8?B?NU05U2plSklWWHZHVFBXazZwL3REdE5aVGgrblNxNW5MUWd5OGFOK1JUb1hO?=
 =?utf-8?B?THFWeitzYlJ5QnpEOHVlbkVlSGNqTmREakxtQ1dhdDdtajJJS2ZseTJTL2pr?=
 =?utf-8?B?UVM3UDRmdm5Rcmg1YkJ5QXFrc1R4bGJoKzNYYmt3azFzaWM5c3ZPK09qYjlq?=
 =?utf-8?B?MUtaV3lGVXRrY0NyMmNVRThOamRBeDhYekFTUWhZa2ErNWphUU1OWU14aGJ4?=
 =?utf-8?B?RFE5aUV2dzNJbFF2UG1KNG1EZGl4aFJDQ25qUU45cGtxcDhOemxVb0FjUnFY?=
 =?utf-8?Q?DFl3CZuCo2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWJIOUJaSjN6b0RWUHExQkZ5WVJVQ1I3RzlvTTVocDVMemIvZEI0NnpEWVFK?=
 =?utf-8?B?OGxBdDVvempBSjNPWW9oakRWdGo3azlmZFZsQjZtR1NxaDUwTi96WndhZkE0?=
 =?utf-8?B?YlZoWDlGeEdaYkljVFVrZERZN0ZDUno5WHY1S0xrT3B4TVdFSTJKVkkvWWxo?=
 =?utf-8?B?Y2YyREhhMFVmdjhKVXdNaWEwU2tpcC9DY2g0VEZidzlEeExDaE9TNVpZYVYz?=
 =?utf-8?B?VDlYcW4xVnhhQXVSYnN3RjAxQ3pWazFrSkp5UlZkYW5uRkVQWXQxa0s5c1pY?=
 =?utf-8?B?RklqZkdHQXRtU1pHVU1xaVhEdkd4WE1pWkFEaXRoQTJZbjJ5c3ZxR05HSENW?=
 =?utf-8?B?SmpxODlOTEhzVmsrSi9WR3ZRRFJFdWRHdTc0U1JKeUY3cG41QU1mdi92OGxE?=
 =?utf-8?B?VnJMT2pGZ1JpNjNucG9EZ3kwTTFNbysvWFZETEJsUVFxQys5cUlBVEE3VkhG?=
 =?utf-8?B?NkdzUytiOExyaDVYRXNNeTlidVpnc3RxOWdKaGRWaEtEaGVnMU9Ud2g4ajI1?=
 =?utf-8?B?VUZmSVNsd1R4N1orUXZFWkVXRTdxcGFnVXRSaHh5ejMzV1dXQXRnRXREOXlF?=
 =?utf-8?B?RmFZT0taZ1poQVB0WTJnZWlhTFV0bTNKYzhVdVpPdEhJenNER3FFalIzcVpL?=
 =?utf-8?B?alFXVTdOeTRVNU8wSzh5LzliSmNWN0o5TVYwS05KM0c2QVlSYlNWWCtGR1Ew?=
 =?utf-8?B?NDVwN2xqVjB5VFZEUm9HUHR6T2FzRXVzS1NUbjgvZFNYdW1FSWoxdnlyUmFL?=
 =?utf-8?B?RGRJdi9lQTl6eEV6MFdOemFDZXpWeEIxZU1SOWtlRFFuZXB0dy9RZ0tqS1lm?=
 =?utf-8?B?VVN5eDMzKzd3S005SGVCa0RvWXgzWUhBL2xpb2lCMjB4ek5QWjJxakhQNUlo?=
 =?utf-8?B?RkVxQzFieFA1bVpmclFoTHozWUxMSUE5eWNmTHpuOGdhZWk1Z1ozU0hKZlZC?=
 =?utf-8?B?MkI4Sjh0Y1o4TlgzZ1NOSTBSMC9NUWhxbkliVXpUMkdRbGhzSDVNSkVSME1F?=
 =?utf-8?B?cHE1TFErbmhsSHBZZGFqallwb09melNtQytGTmVjNXZORWZrRzRDV2IvMVBz?=
 =?utf-8?B?em9tQTIrd0Z4Rk1kdGE3VHoza203S3lCQkJXY3R3YTExTVRDbVI0ejZwOWt2?=
 =?utf-8?B?TDVuajRGc3BMWEd2bWc2djgrWjZQc3MxK3ZuZVp2MDJBQUhuWXA5ODZVdyt6?=
 =?utf-8?B?ZFFkcWRLZHFLSnU1TURKaXNHSndOYVp1V0VLZWxMeVM5RXBjZG1aTFNGT0ps?=
 =?utf-8?B?RE84S1VHaTBCdEZiWnZlZGNlaGFZNnlWUFdoNGQ1dVJXNFJHRm9JekFUcnRT?=
 =?utf-8?B?dlFxS1BOaURvcnZ1SDJ3S0duN3d0bDNvOWMvU2VIeE5QN2ZNL0ZLU0JMQlkr?=
 =?utf-8?B?ZTA5MHM1VHpEVmJQV3R6a0k2YzNtUHQ4S1l5cG5pb0JTNXBtWUNEWmR5WTI1?=
 =?utf-8?B?aEp3SHB0UC9SRDdrbDFia1ViMEN0MStidG9qZHdqczBHektQc2g4cVRYWWsx?=
 =?utf-8?B?YWk1NGo5QUtXaVhxMGpacjFjWnd6M3QwT09xY1F2bXQza013SVdvNEFlWG1P?=
 =?utf-8?B?ZkVEL2JXdVpnM3dLSE5ueWp1YXBaSEFSaFVxL2d1YzJ2OHZEMDEvaG5GN0V1?=
 =?utf-8?B?ci9UWU0yRTdPdkUvTkFNRTdSR2dMRjh1ejNzTHdwZWdHTUpobVZDUEY2NVQr?=
 =?utf-8?B?U3lXb2o2WkRFZHZIcXg1bkRmVUo2WXJQZnBtR01PYm04eWFhVlBhb2VJd0FF?=
 =?utf-8?B?TlRHK1lUc2RXR2g2L3lFYUNBY1pFQVA2Tkdzei9ZU0FLeS9SempuYlRDUlhN?=
 =?utf-8?B?Mm1maityUEZKMmJjU3F6QUFmVDF2L0ZFUTZwcnZZMlYzY0tCcWVJdnRYaU5z?=
 =?utf-8?B?SlBxWWpobWFwN3FkM2kvU0FzNklOa0tRK0RySG43MEQxWlZVcWZFQVJOSkx0?=
 =?utf-8?B?YVBCZ3E5eTFSUjhId2VMNHhYaVRVQ2dBTUFJbitLTnpNbkpOcmpuOXBvWi8v?=
 =?utf-8?B?ZmlrbTFxc1lzc0poT05hZm9IUmp0cjk5MFZDN2wvNTFYaTBZWWhKUXUxMnJo?=
 =?utf-8?B?bDk3RVlzTEl4SXVqdnZlVnVFcWhvTnNORzJiV2hEYTFvTCtSOEJGemE3VXRh?=
 =?utf-8?Q?z0LH8cSy2SLbJhCMJk//a38Uj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cb9fdb-d80e-43a5-82f0-08dd8f027625
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 14:04:49.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwZbbOpdkIkw/7zB5oDYecuxNbnAki70UUL47NFsf84XTtjwgqPpduZYpjhimzDUTBJP1PQFIOuH1QkzPDXD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

On 5/8/25 17:52, Ashish Kalra wrote:
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
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index ada53f04158c..a6abdb26f877 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2934,6 +2934,32 @@ void __init sev_set_cpu_caps(void)
>  	}
>  }
>  
> +static bool sev_is_snp_initialized(void)
> +{
> +	struct sev_user_data_snp_status *status;
> +	struct sev_data_snp_addr buf;
> +	bool initialized = false;
> +	void *data;

No need for 'data', just allocate directly to 'status', no?

> +	int error;
> +

	if (!sev_snp_supported)
		return false;

No need to issue the command if it doesn't matter.

> +	data = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);

GFP_KERNEL instead of GFP_KERNEL_ACCOUNT ?

> +	if (!data)
> +		return initialized;

		return false;

I like explicit values in these conditions, but that's just me.

> +
> +	buf.address = __psp_pa(data);
> +	if (sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error))

You should issue an error message here or not pass in error (I would
prefer the former).

> +		goto out;
> +
> +	status = (struct sev_user_data_snp_status *)data;
> +	if (status->state)
> +		initialized = true;

	initialized = !!status->state; ?

> +
> +out:
> +	snp_free_firmware_page(data);
> +
> +	return initialized;
> +}
> +
>  void __init sev_hardware_setup(void)
>  {
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> @@ -3038,6 +3064,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +	if (sev_enabled) {
> +		init_args.probe = true;
> +		if (sev_platform_init(&init_args))
> +			sev_supported = sev_es_supported = sev_snp_supported = false;
> +		else
> +			sev_snp_supported &= sev_is_snp_initialized();

With changes above, then you can just do:

	sev_snp_supported = sev_is_snp_initialized()

Thanks,
Tom

> +	}
> +
>  	if (boot_cpu_has(X86_FEATURE_SEV))
>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>  			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3064,15 +3098,6 @@ void __init sev_hardware_setup(void)
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

