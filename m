Return-Path: <linux-kselftest+bounces-21761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C69C38F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59251C20B35
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B48158535;
	Mon, 11 Nov 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXFBLuCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED21136A;
	Mon, 11 Nov 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309709; cv=fail; b=jdI3qNN1fbwVTkUtwn1/+yjTtFzATFMPz41DB5CAHKXqRWbtdY1pdlYfpNRcQpEU5/KEye5lIKOriyZ8pKkPN6nowFAALuy6WlYyCsKr9diWS8n637QCKPccC0+fr0sPGWBB5UcJa2I0u9KAMseEI7FC+lMa5SQ1ZalaOceqIhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309709; c=relaxed/simple;
	bh=MUllXGzUbP+ziY8Y3YVaJhbUBGZdmjhR2/3CRX8VOC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxvzisvMxIDDc/nEwhzFEjOaz983y0na8gfXP1RU6lPNHQprMa9W20WjN07OyZvRCFGEd/D8tiU0BRqnarYR3mNcn75YQ4KHLIdFRykiuh46RLozplFp/eCs7LayPkCQr+1VIjpzlGJ/lYuye9pe3pPZ2YJoF7w58zISdKS4SQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXFBLuCJ; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSrZwvqy4fHfs5JxOjyoguiZl6xuaaYd7j8coVRmhUJ9moTrwXYyR3SzhPU2SuTNqwZYkxl0QUaYarQi1fmwzshFwRMBLguOqOq46DflmoLU2ekImWFHcO6U6K+t06oQXA+4qpoed0iy454ljlwcVrwk/AvopFnC5VglVMvF9Ty1PXGpb/qbMR0SvGQB4R8/0t4w9gLSIM8KR9UOZBQa9urCTtlMOjCr2h5fTmi5bpyq1GAci62nNddbJVLJ6AZZzHxvtq1E3sm22m+EFyU2bUv3FfNIhqGN4h3yPF5OT0Qh1yryLfLUepzuRC8ZRkeycSks843dcGwy9Kna2QPe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLjNEBICNxpgxGsmvBku7D7o6noENcYzcU4EdF/K6VE=;
 b=KaGIE00o0smm8lKavYHdhzROZOt6EHZr2G49RR1s3gmm3hlqoqcMkAoepvyCElZISyRk3DZ2JzAZoE2dV6jKaKDPabGh36vgNT1DSUnKERMvc2lLt+TClkYwcpmgb3E6/yMMgDEtvetev+pS7OwqpNY2tDvzTHqMsTz0QCmwJ3+iA7ZaAc4Sa2gbsxD7ABufJICbAwOMz6oqDn9ayCY9w0GDSjO1mZJWSqmx4jMhvd6wY5YU6zDv6nohmWNh/avC412WHlyABaEfk3BDvpk8XIL6uhj3eheE3yjn3/Yjx4c/uu5Psg0IO2Uws+uGx0b+oqoEFLb9AZ+keulr0JYpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLjNEBICNxpgxGsmvBku7D7o6noENcYzcU4EdF/K6VE=;
 b=FXFBLuCJEA91/fyNCALU3Xt3Y0NVuwr0qXOpBboCPAhu0pIEMD5B7wZfglEgRA6/z6FJNl1P1dFIhoe3lldpSY82UDOpowSTtZi3ud0e613104PWElJ5MGeLEfL3NnUiOkVAA1QdfcEJ7s5dNKQh+zXlI6L7AsrKjBli+LqvdF6p0FSAxhdj5aXT0Y6qIHJo9V/X6TgrDpC5VdRzfoEgltNCZxpM+YbQlNx6fnoUqGgsqyAuGCD2yYiPtWOIlnjdVUCHSal6Mkc/vtaR8g927BOeq1OBL2yCAT4F0O5nSWvi8z/wpNVx0Fbi55S3eMFpnAsKsnJJmR33wAhe7nD6ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Mon, 11 Nov
 2024 07:21:44 +0000
Received: from IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12]) by IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12%6]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 07:21:44 +0000
Message-ID: <dec53919-034b-4f0e-b415-1bc1de9b0916@nvidia.com>
Date: Mon, 11 Nov 2024 15:21:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: shuah@kernel.org, tglx@linutronix.de, mochs@nvidia.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20241018193411.GA758389@bhelgaas>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <20241018193411.GA758389@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To IA1PR12MB6580.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6580:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: d806bfb5-d6e1-4025-ddff-08dd02217ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi9CTnc3UTJSQ2FxLzVkei9JQ2twODJ5a3NpVGtzZ25tUkhldVVQNU5tSWNJ?=
 =?utf-8?B?VzArSzVBM2pCODVidGkzUGJZTmRnWVRsNHNiTzhmNWJWN29mRFVkOElIbkRY?=
 =?utf-8?B?cHJYVkNmMWxGb0VabXA0RnJuaXp4UE51V2pNU0EvaFhxSXBoZXIyN2ZKQXV1?=
 =?utf-8?B?akZtZHNuUkNXL2JMc21xQ2g1MXFXVkhVNi82SmtaandCd3M3WEJna1NsSW5G?=
 =?utf-8?B?bklYVWVTMVVhYktLbmgvOE1USDUwbjJjcHZ6US9sYStUZ0E2aDdxb0tVQ2Va?=
 =?utf-8?B?NnQ0MmFuR0xBcnRSUkRkZE9TajVhVmMrSnk5c2NUb1RNcWtQWkhMTmV5OEto?=
 =?utf-8?B?NDhxanhvKzVodE95c29RK0prRzNaZHJKK2IzSXpDZUIwYnpkQWhaUFBUUm5Z?=
 =?utf-8?B?cmVmSlp3UnNYRC94MmxVZy92c1QyM3VxWHFaeTB2aS9HMHJnZFU3eW45T3VV?=
 =?utf-8?B?M2lYYjRHMzhIcWdjRmR0Z1krQjNSZnNxME94QmlUMDZCOEVYQjg2RTRxZjJ5?=
 =?utf-8?B?UmFoK0J5UUZqMDVhNU0vcDlBZTdyMVVoL1BlQVgxOHdaY2tlbHlRenp6UWlo?=
 =?utf-8?B?eDBQTml4cnNpTVJDR1ZLTDBiQU1EYmxoSzhLcHVHMkgya2h5M2QvWFVyN1la?=
 =?utf-8?B?ayt4R2JRNm5KZ3YzaEZXblFlaHh6ZHpFSkFlMGJHZ0EzY0dZelB5dkE1bFZI?=
 =?utf-8?B?R1VVRzd2YnZQVHZLRzMxcy9ZZ3dZY3ZMVFNNL2o3ZjErd0p6amZMVGpXR1lI?=
 =?utf-8?B?enlWNldoWlFhOXp6RGQ2SzBkR1U0VGtwZ1JsbzlNV1RibEpmN1ZnR2k0MlVX?=
 =?utf-8?B?dmVyd0dqWHF4emxOUHg2a0NtME15N0t4eDQ4WGMxalQrcExuSm44SXlFdWZD?=
 =?utf-8?B?YkVuTnFTRnpvWUh6VEZSbEx6RGd3dWI0WVc0NW43ZEhIOCs0cFVRelZ4MHYx?=
 =?utf-8?B?MzZNYkZyc0dYZHNjR2o0NzNjbUxSYm9NdTc1bGZDdGtXZk5NWkV1bDA2NHNW?=
 =?utf-8?B?VVFLQUF2anFIYzV0MWRPTVpWSUh2SHFKcWc3OGpLd3ViMEpzWnQ0Q1pIVEZh?=
 =?utf-8?B?VEdSUXVZcG9rTVg2U1BSemw1Z25zd0hSd3paQWd6OEl0eWRKSkpEOGJ2cTZM?=
 =?utf-8?B?MXBnQ3BLWFZIdjE1dmkxa1cyU2w5d1BGZFdTVjcxWWNwTjF4WktvQWRKa3FL?=
 =?utf-8?B?VzFMSW11ZkhEajdvQnZZUXoxU2czMjg3cHdVaEFuM2pRSzdGQXdhdFpTeU5I?=
 =?utf-8?B?bHVkeXRRR0FwL1R0czVJSDYwK05Uc0ZxaHowVmsyajdTNzFlRG5WcTJ5Q2Mw?=
 =?utf-8?B?eEQrZ3FkZitEZU95ZlJVTWdwdkR0TUdRTzExOHlBbzhMU1dlb1R6Ui9mWWU5?=
 =?utf-8?B?aGFhd2k4MGxyMnU2QnFsM2VSeHUrK00rUzRGN3VLa2syUms0cFoxeXRwMkdN?=
 =?utf-8?B?QzM5cmFqQzk0RUZmUzZPbmFJN1pzNDNlM3Roa2l4UjJGZVg4SU9uY1hGL2JH?=
 =?utf-8?B?amdaeERLM2pkQUV1bTJUazVBZnVGbGNHNDJvbUNSNE4vWUxnWXRvQ0JPaXJp?=
 =?utf-8?B?N2twN1J2MUVydmRQak5kb0pJUVE5RTVEYzZWOTZMUDl1L1JOZ244SzZ5emZk?=
 =?utf-8?B?QWpjZkIwcVFIOVJDakkyOHgxdVlSY29pakQwRzFJUU01dXp3ZEJPRGpKaDJ0?=
 =?utf-8?B?NXFHRVZNbXF5UEhkU2dEeGFwNUljZlRpMGExeGkydkJ3eEpYV3Voc1ZLcTF6?=
 =?utf-8?Q?voGalzMzmwXkOwywlmPQX4ntpX/+LJz8Oh2iuhP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpWVDF4V0g5M29yUUN5b0JuZDZFTlpyZ25oVmRDNXhjTy9hOGQxQWpYdDJS?=
 =?utf-8?B?eW5zSU9VcU5QdFAxU0hOb2thc1didi83Ujh3Zko1MHk1dzZLdCtobFNPcDIy?=
 =?utf-8?B?dTFTd0NwWjRuWEpTakkzVnA2SVo1MEJOQ0MzWk1VaEVDd3pCTmhBOUdQK1Fq?=
 =?utf-8?B?WUpEUXdSSGFVNU1jSndLZk5xN2Z2bEVneUZrMjcrNm1vck9qRWpsK21TZG53?=
 =?utf-8?B?cHhQTTJEVXRqNVpuZWVnRjY0Qm9lbUc2MFRzZHJDSjJVZEp1ZU9SWmxtUFl1?=
 =?utf-8?B?bkRDenZ3VUJ3RlNzNWEvLzZ2OEJURFpQTU9ROXR1a2tvbDFYY0Q5ckRnbVdV?=
 =?utf-8?B?U0VWb2xxdWtuMlZnYXE2Ny9FeWlWY1BxSmp5ZVN2ZHh1cDRSMWgxL0FJSWh1?=
 =?utf-8?B?ekxOM005NldkQ0Z3YmZNN3J4dklsV1pNWm9qbkFYSXZhcDg0KzllSGhocitF?=
 =?utf-8?B?ckhQRkRrVTgzNDYySW95c3BLS2F2QXJLemU5cFZIR3lGUlExU1R0b2NhbmNV?=
 =?utf-8?B?K0srK0ZzUUppNXlOWlcxYllIUmdrNjdpVHpiSm02V25jYTd6djcxcUVPQkho?=
 =?utf-8?B?aDRhbnhram8vMHhsVHZPaDNlWTNOKzhYZExZRzJFUnY0WjFGcitEU2p0K3Y1?=
 =?utf-8?B?Rkh6b2Rjb1MyNmhXUXo2RFpUYXJqNVdaYjVkQTVISWMwRmEvNTRMYVVtNm56?=
 =?utf-8?B?a0JVTzZMdFVSb2x2aXFTcGFTNEtCb3duZDFROVRxOCt0Wkt0eXdpMDRiWE9a?=
 =?utf-8?B?N1l4RkFrUFdZdWxkSlp4OWZYVnExOEp5WFlqNm9DcHdLYVAzMGNuWUUxUmJi?=
 =?utf-8?B?TzNZSzR5djZGZXZsMGFtblpxZUZqdTRHNVEwWkczWDhVZ3ZGc2pCVGJEdmxZ?=
 =?utf-8?B?VzhIL2hUYXFXUW0yL3JoOVZndzhQY0s2QXdKbExwVHExQ2xLZzVUZXFRUzhW?=
 =?utf-8?B?Q1Y0WWtmSWdHbHNPWXhBV1RuQmZpd2ZmRTNUWEdrZm9Zb0dTaHJDcGRqdGdn?=
 =?utf-8?B?NHQ3akxMaFZOYmVJZ3U5cnpibWxOMmdZbFRRZjNGQm9URjlFNDBaK1BaUHVO?=
 =?utf-8?B?NFdWcko5VFg4c203M2NPY1h6YUVKdktKeG1OTGtHckhFVUdRbzhsbDdBTzlX?=
 =?utf-8?B?VUpEVjY2Z08vYzA3NmJRVlh6d2VoRU5PS25raVpzN2F4ZnpvUER0dHQ1b1hl?=
 =?utf-8?B?T2F3UG11ZjZ3aDY1R3pLOUc3eUxjL3R6RDFKSG1nR0tUdmZ1djd1dmJqVGJ0?=
 =?utf-8?B?dFVXeFRXRnpvQzZ4eTFnWFlXaG9WK29VWkFjYmxUMHlrakY0SkRxWGlSeFo2?=
 =?utf-8?B?M3FlK0VHdHUrSFpTanh3WDlzZWMrd1VzdTFnUDB2LzFIUjlyZkpjUUZpdW8v?=
 =?utf-8?B?bHhITlV2amxEVno0OFZkd2RiMGduNERrallwRTBlL2pwdkh5NGlXQWlSOVFT?=
 =?utf-8?B?cmovR2hTM0IyY2xvM0pycWw4ZnM1M3FUc2FoYVUzeDdRbW1MNi92dXJuSDcz?=
 =?utf-8?B?TGVBOEdmOGlsOHB2OFYxbE9HZU8zV0wwMmRGaExWWEM1ZHFGNlhWaUNQanF2?=
 =?utf-8?B?dHRLRG11dS9YK2pyK1U5Ym5BVENJYXQ5cVVibjZVY2d4VUs3K05lZitRcU9H?=
 =?utf-8?B?Q1o5K2xFNWxUcG80RVcvRkx5Uy9TRktZZ1Jsb1hEckVmY0sxSEhLYjBNT1Fu?=
 =?utf-8?B?T1MzUXoyeDhCZkxMdG5oNkxYSy9vZ3BoNk94ejI4MkQzT3BMMWlCYWplOUZx?=
 =?utf-8?B?S0JkbGxualcrUHVCRHcvMnZSdk1SMm80V1BaZ2RGdDcySTczQmo0QmRtZnBD?=
 =?utf-8?B?d2RMc0RjR2xMTFpnQTkxTlZIVWcvUndMVWxRaXBOeHUwYnJOKzF1NXJyYm5O?=
 =?utf-8?B?Qjc3R0FSTzNWd3J3NDYrN1FzK3R3MzArbXVrZ3ZCM2VYRzYwQ1cyYi83bUhs?=
 =?utf-8?B?MjAyWmZjbk85bFkzOHlKN2c4bGo3bksySlVMRkpSQzdTN0pDWGNUalZtYVZs?=
 =?utf-8?B?UmZrYVkweW1lTU80TTVCMnZ5bUdrSHV4eFQrVTFTQVh1K3NYd0NKYWgydFBH?=
 =?utf-8?B?K21SeCtXcklhQjQ0dnRRcmovWXYwSVhJVWllaGFidzVueENaeEFhOEJpSGxk?=
 =?utf-8?Q?UTeU1/74o6tWROTYMwiBLLyec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d806bfb5-d6e1-4025-ddff-08dd02217ec2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 07:21:44.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNvkBiflTiPz+CpIDFchsi7gjM7oPrKfHGCnV9pwzeewHSQ2UNCJ7kh+ivlCtfCjKiZQIOxJaxxgQZ1uNWAf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442



On 2024/10/19 3:34 AM, Bjorn Helgaas wrote:
> On Tue, Sep 03, 2024 at 06:44:26PM -0700, Joseph Jang wrote:
>> Validate there are no duplicate hwirq from the irq debug
>> file system /sys/kernel/debug/irq/irqs/* per chip name.
>>
>> One example log show 2 duplicated hwirq in the irq debug
>> file system.
>>
>> $ sudo cat /sys/kernel/debug/irq/irqs/163
>> handler:  handle_fasteoi_irq
>> device:   0019:00:00.0
>>       <SNIP>
>> node:     1
>> affinity: 72-143
>> effectiv: 76
>> domain:  irqchip@0x0000100022040000-3
>>   hwirq:   0xc8000000
>>   chip:    ITS-MSI
>>    flags:   0x20
>>
>> $ sudo cat /sys/kernel/debug/irq/irqs/174
>> handler:  handle_fasteoi_irq
>> device:   0039:00:00.0
>>      <SNIP>
>> node:     3
>> affinity: 216-287
>> effectiv: 221
>> domain:  irqchip@0x0000300022040000-3
>>   hwirq:   0xc8000000
>>   chip:    ITS-MSI
>>    flags:   0x20
>>
>> The irq-check.sh can help to collect hwirq and chip name from
>> /sys/kernel/debug/irq/irqs/* and print error log when find duplicate
>> hwirq per chip name.
>>
>> Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
>> [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/
> 
> I don't know enough about this issue to understand the details.  It
> seems like you look for duplicate hwirqs in chips with the same name,
> e.g., "ITS-MSI" in this case?  That name seems too generic to me
> (might there be several instances of "ITS-MSI" in a system?)
> 

As I know, each PCIe device typically has only one ITS-MSI controller.
Having multiple ITS-MSI instances for the same device would lead to 
confusion and potential conflicts in interrupt routing.

> Also, the name may come from chip->irq_print_chip(), so it apparently
> relies on irqchip drivers to make the names unique if there are
> multiple instances?
> 
> I would have expected looking for duplicates inside something more
> specific, like "irqchip@0x0000300022040000-3".  But again, I don't
> know enough about the problem to speak confidently here.
>

In our case, If we look for duplicates by different irq domains like
"irqchip@0x0000100022040000-3" and "irqchip@0x0000300022040000-3" as 
following example.

     $ sudo cat /sys/kernel/debug/irq/irqs/163
     handler:  handle_fasteoi_irq
     device:   0019:00:00.0
          <SNIP>
     node:     1
     affinity: 72-143
     effectiv: 76
     domain:  irqchip@0x0000100022040000-3
      hwirq:   0xc8000000
      chip:    ITS-MSI
       flags:   0x20
     $ sudo cat /sys/kernel/debug/irq/irqs/174
     handler:  handle_fasteoi_irq
     device:   0039:00:00.0
         <SNIP>
     node:     3
     affinity: 216-287
     effectiv: 221
     domain:  irqchip@0x0000300022040000-3
      hwirq:   0xc8000000
      chip:    ITS-MSI
       flags:   0x20

We could not detect the duplicated hwirq number (0xc8000000) in this case.


> Cosmetic nits:
> 
>    - Tweak subject to match history (use "git log --oneline
>      tools/testing/selftests/drivers/" to see it), e.g.,
> 
>        selftests: irq: Add check for duplicate hwirq
> 
>    - Rewrap commit log to fill 75 columns.  No point in using shorter
>      lines.
> 
>    - Indent the "$ sudu cat ..." block by a couple spaces since it's
>      effectively a quotation, not part of the main text body.
> 
>    - Possibly include sample output of irq-check.sh (also indented as a
>      quote) when run on the system where you manually found the
>      duplicate via "sudo cat /sys/kernel/debug/irq/irqs/..."
> 
>    - Reword "The irq-check.sh can help ..." to something like this:
> 
>        Add an irq-check.sh test to report errors when there are
>        duplicate hwirqs per chip name.
> 
>    - Since the kernel patch has already been merged, cite it like this
>      instead of using the https://lore URL:
> 
>        db744ddd59be ("PCI/MSI: Prevent MSI hardware interrupt number truncation")
> 

If you agree to use irq chip name ("ITS-MSI") to scan duplicate hwirq, I
could send version 2 patch to fix above suggestions.


Thank you,
Joseph.

>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>>   tools/testing/selftests/drivers/irq/Makefile  |  5 +++
>>   tools/testing/selftests/drivers/irq/config    |  2 +
>>   .../selftests/drivers/irq/irq-check.sh        | 39 +++++++++++++++++++
>>   3 files changed, 46 insertions(+)
>>   create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>>   create mode 100644 tools/testing/selftests/drivers/irq/config
>>   create mode 100755 tools/testing/selftests/drivers/irq/irq-check.sh
>>
>> diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
>> new file mode 100644
>> index 000000000000..d6998017c861
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS := irq-check.sh
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/irq/config b/tools/testing/selftests/drivers/irq/config
>> new file mode 100644
>> index 000000000000..a53d3b713728
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/config
>> @@ -0,0 +1,2 @@
>> +CONFIG_GENERIC_IRQ_DEBUGFS=y
>> +CONFIG_GENERIC_IRQ_INJECTION=y
>> diff --git a/tools/testing/selftests/drivers/irq/irq-check.sh b/tools/testing/selftests/drivers/irq/irq-check.sh
>> new file mode 100755
>> index 000000000000..e784777043a1
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/irq-check.sh
>> @@ -0,0 +1,39 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# This script need root permission
>> +uid=$(id -u)
>> +if [ $uid -ne 0 ]; then
>> +	echo "SKIP: Must be run as root"
>> +	exit 4
>> +fi
>> +
>> +# Ensure debugfs is mounted
>> +mount -t debugfs nodev /sys/kernel/debug 2>/dev/null
>> +if [ ! -d "/sys/kernel/debug/irq/irqs" ]; then
>> +	echo "SKIP: irq debugfs not found"
>> +	exit 4
>> +fi
>> +
>> +# Traverse the irq debug file system directory to collect chip_name and hwirq
>> +hwirq_list=$(for irq_file in /sys/kernel/debug/irq/irqs/*; do
>> +	# Read chip name and hwirq from the irq_file
>> +	chip_name=$(cat "$irq_file" | grep -m 1 'chip:' | awk '{print $2}')
>> +	hwirq=$(cat "$irq_file" | grep -m 1 'hwirq:' | awk '{print $2}' )
>> +
>> +	if [ -z "$chip_name" ] || [ -z "$hwirq" ]; then
>> +		continue
>> +	fi
>> +
>> +	echo "$chip_name $hwirq"
>> +done)
>> +
>> +dup_hwirq_list=$(echo "$hwirq_list" | sort | uniq -cd)
>> +
>> +if [ -n "$dup_hwirq_list" ]; then
>> +	echo "ERROR: Found duplicate hwirq"
>> +	echo "$dup_hwirq_list"
>> +	exit 1
>> +fi
>> +
>> +exit 0
>> -- 
>> 2.34.1
>>
> 

