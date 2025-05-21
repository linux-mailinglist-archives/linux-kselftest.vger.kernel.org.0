Return-Path: <linux-kselftest+bounces-33488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0BABFEA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02C24A082D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C922BCF67;
	Wed, 21 May 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBpU5Puw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A116F288;
	Wed, 21 May 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861548; cv=fail; b=R6JldsjbPdJ/dN3+s1PD85il1e1qLH4saLDPhEZPoPrAwgaTwQ1Dza9iYmW2a+xwXrEhXhPNKOoDy8c6aeEigXfNb7dCRFbpk0Nf0wj1EnyHqSzJI8sPjxpzf5SuDMJqjJ9IkSKoFiop80Kz//P495bbYgnTBvrb/JJA5CIbT/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861548; c=relaxed/simple;
	bh=o8kd8N2uGlcO6aY01u3PCsTVRDQLhKhRJVDUjplP8RI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IAXNALzARVgpkZpy2p0ACEyY/er+N0jlkPmtUgVt6c1oHdC35NChmwVI0neQZlsfH/LDwSQxvLUTDch2oxNx2YFNwtbV4jYOGNNwItG0o3Oiurcjrggi2lHCVcrkBUQuaM0R6w6dLROyoJwCtkn1DmoieCYC4glp5xuNm/ZDUH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBpU5Puw; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANGV/d+E8cXPk2sfnBanwrKkOFt1LzZIQ+vyrulslKwRcg53t9t2UwiU+21LRoCH7Y3kupQT4mzpnSisdBGEcVmbrCvh6TE/tUYJp1Upc8a0ndMI45u/QEBi0itPkuuLnvBzyYhtUhaNXExh+unawsjfuQE8wKXBTB9IbSHvhObaJ+GeAa3LARdb52sf4KyaXThBKZaA2dmAm9iH5hZTPRyCQR1xEhkWTh19Fqba/CGZBRkh+Ufh/DQV7oOYrrQ3qIRi3n4NaZzaTL1ab1Qat30HIADL5h2pM280X0TUXM7fP7dVmuwppCiSlUSFsX4XushsfV4CdOs6yOMUexoqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9uJcezJGOqb3tUvDUqihOON0byXR85/mhus/StST+Q=;
 b=nB357gF+NaGSZA95F5BEf4kdqh9WU4eR//0tI43KT8/9h5TiQ41co35PANMIunR8tTFeBx+RkZrwrsuV3bz3hBPcQz01fl39PKLw4nW4RUjnHxkNGjw45VbhCi4akeVEtYn9+dEvyploM/HCC0DxO6Tjgrv+Nf+EJqrbFPqvn0cbWCG2mjCwlW8JTIsR9e//EeeBPaxNpvWPzr+StIpr19TyTzXkBRWS8OPQLtSJ+dhvwv0kVXz80ZRU4o5ujAY6PaDsrl8bdaGKtJR7R+TnPDT8VPwGjWT3U4MajeO3HxCrosLGJ8cGvdafROX9kin0bnlK3sAVtiL+9pi2VuM7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9uJcezJGOqb3tUvDUqihOON0byXR85/mhus/StST+Q=;
 b=jBpU5Puws4PHJOnui+/3CNZtAUACzE54Mg6ofjgF4z/kn7BxHJhHkZ7Y2/wMdQnr8Rp+oIjb3EYn6eLG8FKwivjzP+FvCXq//rh2Thq1tUUDbPqkUgHb0qEyQzb+1ECnvXDUc8EUHH/bf99vMFLdXURmQtLnn/EAv9mpIeoPz3fiqUaurVNVJ4z/Vm1vsaQOGqMZmpbi3DOD5vszl8ogV9+wWZW84+q8eoVpY5GHXUROn68fnjcu8ZgbOQQ2l/ChoYub7uzAy0a1MsD5iyUgVXClQT/+HNMgQ1Hq+bmYgnEp57rsQbtvPudXBtRdhMY/99S63c6EMM13A6tzJdW7sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 21:05:43 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 21:05:42 +0000
Message-ID: <de344976-6117-478f-987c-3d24be590399@nvidia.com>
Date: Thu, 22 May 2025 00:05:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
 <1747766287-950144-3-git-send-email-tariqt@nvidia.com>
 <20250520155957.04b27217@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250520155957.04b27217@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 61400285-ba4e-4f95-d7dc-08dd98ab3f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXJPUDhZaWRaYTVlNlpWQnIvNFRIRXRkSlFyUmR1Uy9LeVhuTEZOSzh4NlNs?=
 =?utf-8?B?dUwwZ2VUaTlxb0cxL1RlaXRCT3RocFVSTWc4dXozRlhQc1ZuZmJtempjcVdm?=
 =?utf-8?B?OUVQdjY4SDM4Rm5CK0pQaGhsZmJ6dVRiQUgwYkJyaGxDNU5jNlg5OGI4RGZt?=
 =?utf-8?B?WjhrVjJFU0hHL09aYkRVQUpzYjZlODg3QlRQMi94ZlF0MVJlWVVSR1RDTEhy?=
 =?utf-8?B?V3cxN1FEQitEczBhSFVxVlBkNm9mOVducmY0dmhyeHZ1dmtlVlhwbWdMSVRD?=
 =?utf-8?B?NHg4KytBQUN0TlZEZkFUSmI0QTVIOWpOQStZTHNhYjR3aDZzRjhRVVFhZHdQ?=
 =?utf-8?B?Tm9HazVibm9FTHZTV2pNL3RtUVQ5NVpsTUw1eXJVa0ppSUxtS2hNRE5UeXBM?=
 =?utf-8?B?UlNVY1E4U24ya2hWOXhDOVdmNGtTNmFaaFlkSEQ2ZE5TRGZrLy9jbWlJOW1p?=
 =?utf-8?B?YTdxNGpXcnJCODcxOVlRT3JHRExDK0RvelVESkFQVTg2Q1FCMmduMjZkYzVQ?=
 =?utf-8?B?aTF5ZXRrUDBSRXNHZExxbzdDTUxLeTF5M0Y0NjhZdngwR204UzR3WXVqK1FY?=
 =?utf-8?B?Z0xvNEFxd2thMGpvNUh2M0kyeVdVcmNTZDBZWHpMYndnSlpHR2xUaEVOSXFF?=
 =?utf-8?B?eFNxRmthRHdpd0lLR3ZkZjFKYUwxYVkzUEVwSG9mRXR2aDlRZVNMS2g3OHF5?=
 =?utf-8?B?bmI1U1N3YzlYOCt1bXJkMVlSUnBqenpOVzhoRFlGUFpza0NLUjdNQzUwWU96?=
 =?utf-8?B?MUdxcVJCZGI5cVZBU2xCRXJuRGkzME5mMm9kblkxS0tpdkN0VFllelFNY2FL?=
 =?utf-8?B?V0s4N2ljbVVoWk51L2FlUTRlSVIzWWZ6bkJkRWlqUVZ2Z2RJamVvY0o1ZWha?=
 =?utf-8?B?MHRlS1FJakVocXFubUtxNjFPdTZTNGdPSDJpYnIvMVl6UlFrR0dZYnVCQnRh?=
 =?utf-8?B?Nk5kWTlPdUsvV1lCZ0tlOHJiYk81TmNqNDRmcHRzSkwvdXA0VWlCQ20yTWxp?=
 =?utf-8?B?S0xoY2daTk1KREdWc0JXSkMyTmhRUnZwUmVZTUI1UFN5dldUZEx6S09rOThx?=
 =?utf-8?B?Tm54c2t3cmhUOHc1alBLSjA4VTk1Kzh3YWJ1MHpsTFM5VjdpdGp5dTNiZjFY?=
 =?utf-8?B?cmQ1N2s1czAyRTlnMEh2RGVkMzkrRGZ5ZnVYOTR0M1BVZVVKZlZEOTlZakRk?=
 =?utf-8?B?QisyK0g3ckwzdmpWNk1RY3dyZTFmTnU2OWRHckErZi9hVTlyVGg4Nmw0OTZt?=
 =?utf-8?B?REpFRXE2ampwVEZqWVdQeGQyQ1FhVnJaUHRPU1NmZjNzelVxSFd4bkxYQnVJ?=
 =?utf-8?B?bG8zQkt1cjF1Mzd6L1Z0dnVENHVSVTZybzJOOVpmdTZJa0pjTENTT3lCRWRy?=
 =?utf-8?B?dDNhbVdDZGFTcDlOL0IxLzBISXFUaE50a2ZaRXFPUTJkV3NHVnVIUTB1a0xK?=
 =?utf-8?B?TlZOb1NvcGhWbUdCdWsrVlpZV2VHTTE1dFFzZHFqSTdFcEtvK1ZBSnNUQ0xF?=
 =?utf-8?B?Q0tuMkoySWZWY0syWTVSczZ3NEZyb096bWo0eVBwTzZFQkhma1dyeGNXYmdO?=
 =?utf-8?B?Y0gyb2liUVNkL3NMbjZabWZKK3NuRXZ3dVpycm5ra2d6bkJGbGhIb2JjNTJ6?=
 =?utf-8?B?Nzh5MUVWN1dQV3grSXdJTWdraTFPRTFGQ1RxVy9VRmRyRmFPVFRTSUtUaEpO?=
 =?utf-8?B?WXVaTU8zNmIxV3JlTmsrN3FwN3dyWXlwNUFVZ0RiTC9yS3pjWkE4L2NlRklP?=
 =?utf-8?B?V0JKSFlRU3VCUkVqN1J3Q09kbTlhdFB4YWpXRE5JUjNuQWJvSkV2V2RqTkRM?=
 =?utf-8?B?TGxBYWEzN3B1K1h4Z2lyNnBkY1I3S2xpaWg0ZS9PZTVrRlFPWE5hU2plMjB1?=
 =?utf-8?B?Tld2aVVGWmN5dG0wUDdYMUV0dXE3cnNta2JyOVpWRXRjV2ljRWJVYWJvaFUz?=
 =?utf-8?Q?lCkBs19Me/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDN3cUlBTHhEemp4STN3Vi9iWEpkcHpQZEFPZDhHQTZPemhNemI2RTJENDRa?=
 =?utf-8?B?MFFWeFY3Sk9EVnFLdHRFVUNmc0hLTmpaWE1WbU8zdzZDbnN4QkUvZUF0eTlX?=
 =?utf-8?B?QVpRZ2lJRGtUQzB4OGZGNmNQMnVMTzcvdUxFd0p4V05hbVdrS2FpdzNMMmln?=
 =?utf-8?B?aGVLSnRzdVl6cGFOdUVFbFlaMnVUMkxVZXY0bEtMZnJ5ZXFEL05ZZU9kb3BK?=
 =?utf-8?B?ZEVjcXJ1eUdTdVV1S2hTTmtSSTdrWU13bEdvNXJ5M21VV1M4S0tVbVVYcnYv?=
 =?utf-8?B?YloyaG1rdDJ2WGVmQlNXWjBDR1M5bVM3R3hOZlhYbmx4T25HUGo3SlVnc0M2?=
 =?utf-8?B?UzlXZEJ6S045S29RZTlkcTFZQ20rVDhkRyt1U1VHZFZPTk9iMDFEV2p3YlQw?=
 =?utf-8?B?bWx1V3kvOVBXaFhxeHJFVUtMN3hYZ0FNTmgxZktJYVpMSkxoUW4vSURiMi9Q?=
 =?utf-8?B?WU5SVllPVWppTkdudys3REdDODRSQjV0ZHkzdC8xNjJ1bnhDUVR2bmZiRmIx?=
 =?utf-8?B?QnlabTdUOWhQRTBoSlFRbDlaWEppUjhZdVBEUFpPenBHT3Nib3hpRUZSSnlX?=
 =?utf-8?B?TzlEUWdqOGNOMlZIRkxtRmFIblZsSUFxVnVBeGhNS3VnV3RtSUpDR3FSYkVG?=
 =?utf-8?B?a2wwa2ZXOE4yeUFkWWNFRWJYL1U5dHRwaHlPb1RCRVpEQlVIR0QzTG9VNCtn?=
 =?utf-8?B?ZHNUV0xIL0VaSjRaSjFPZlZqbGMxUFZGVVRzQzhLSmFGTUdIWXFqRkJaVWJx?=
 =?utf-8?B?Z3BzU1hsM3RCcWF5YzRtL2FHYTJtTFc1NjVqd0hNOUpiVWF5ZUNrSCtnZmdF?=
 =?utf-8?B?VUFpbkV1N1lTamFJRFZEUm16d1VPZHRGbThXQmtpbGdiR0hWT2VjbVRsV2VW?=
 =?utf-8?B?KzlIL1ZCWFB3eXkrSnR0M21JaFRyR2hnelM0UkZOSkZhaXpmRzY4aDYwanlM?=
 =?utf-8?B?OGN4VkNrWmkwNkk1WjY1MTB5NkFCb0lBWFFVWjN2THdlOTJXeVVIQy83UDFH?=
 =?utf-8?B?QmpLYndKLytBdnlpRnRzWjM2Qm5nWUNycnRsU24valduKzVIREhQN3JZaXhV?=
 =?utf-8?B?QTYvR3U4SVhrMExrdUYwVE02aVpyV0pWNGgvODUyN1BOZmc5QnUyQlh3MUZJ?=
 =?utf-8?B?RVRUVkdDL2ZMdG5Dc1UxRW1WU3ZoOU42Vk5DWXBRendubWh4M2FwQmJLR2tP?=
 =?utf-8?B?aWJ3Qkg1dWNhZW1wbkV2ZGRaRHdhU1d2MnBPamdvdDNydWk3eUhoTDFVTEQx?=
 =?utf-8?B?MHIrWkRsOVJSQTNDeWgycnFscVJQOGEzMWQxZkZ1cEw3VFN4SkMycjA5ZlZp?=
 =?utf-8?B?SWVHV1dTOWZLUUk0bUk3RnZ1eEd6MWZxUkNaK2hDcW9VNzh2UEhQRW5CY0tD?=
 =?utf-8?B?SWdpRHZPVTdHTTczSWFLRitwQWMyWXdxWDlVTEQwMmtPLzd5YnlsV0d3UHVV?=
 =?utf-8?B?M3BpMWs0VUNNd1JRN3JycHFCeUlHa3BRVkpnQmtIelRhVG50SkMvZWlQRUs5?=
 =?utf-8?B?MXBOUmhDMVA3K3cwNi9jSE1XbXY0VWl6dTg4YzVuZUNkQXVneXppQlNETWwx?=
 =?utf-8?B?WWhieW9sSWRHdXF5Z0owWDRiQ2FBdEpkYXJBTFNucitKZUhmWFlpMHZpdjc5?=
 =?utf-8?B?ZmMxMlhncEpVVGdaVm03OGVjbTBtRjIwOWNubUZpeFJGdXBMc0hMazZ0bHZR?=
 =?utf-8?B?TU5vczIwU1V5bHVmRE9aTk9iVklUa0hFK3BYRHlORXhMU1BpM1VsRzIrY1RB?=
 =?utf-8?B?Mng3WXJkdlpSVEdTeGFBVjBWajhIZVIzdUtrZ0FiYmRyZ3Q2ellEcXZMVFVw?=
 =?utf-8?B?MkxMSHZ1QkVPelZyNWhGSXl6QnBEZGpDc1pXbXo0N0huaityQktURnZpa24x?=
 =?utf-8?B?Qk5GUndGN3I0SG1wQmovbVdORXd3TkVLQnljcEtZVlpCNFFZLzRHK1hBQndU?=
 =?utf-8?B?eGZHeW9iUEozaXYwYjNCdFJsamN5NmJEOFJOaW5nSGp4MXVBQW04NlNqVnBP?=
 =?utf-8?B?S1ZCK2xzZTBhaXkrcGs2MzZSNTl6VUJ3T0FJNWovamxlSjJPZnNXcVJTNHk5?=
 =?utf-8?B?eFdVTzY4OER6WTZVcUt2K2RQUjM3N2Y4SUJKb1F1cTNEUmROdXJYSU8xZnZy?=
 =?utf-8?Q?GE++N09Rzw/26tD6O38RY7GNk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61400285-ba4e-4f95-d7dc-08dd98ab3f3b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:05:42.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrMngUseo7iTWJJrgyBhu+/2NXaKdVzW46vBasZFCod8U688LvFjuYCJnTIT2VcTNKd2S9+aA2T3enoKAz1sjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894



On 21/05/2025 1:59, Jakub Kicinski wrote:
> On Tue, 20 May 2025 21:38:03 +0300 Tariq Toukan wrote:
>> Test verifies that netdevsim correctly implements devlink ops callbacks
>> that set tc-bw on leaf or node rate object.
> 
> Please add a test that can actually validate a NIC HW.
> The test probably needs to be in Python to use a remote endpoint,
> and should live under tools/testing/../drivers/net/hw
> 
> We had a long conversation about what we expect from the API
> vs how your HW works. One of the test cases should confirm
> the expected behavior, IOW fail on mlx5. Which is fine,
> unlikely that any NIC will have 100% compliance. But at
> least we will be documenting the expectations.

Working on this. Let me know if the netdevsim selftest should stay 
alongside the hardware tests, or be removed.

Thanks!


