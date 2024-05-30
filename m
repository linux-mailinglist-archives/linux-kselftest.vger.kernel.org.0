Return-Path: <linux-kselftest+bounces-10931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C4C8D4F9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4FDB2658A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18E208A9;
	Thu, 30 May 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uws32YJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392624B26;
	Thu, 30 May 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085276; cv=fail; b=fp5N9oUv3eR4YFh7jglOGj+B6xiIMR3AzDH9J6q3ynDE8uu9pMNwmqtEarcdoao+p1KAQnzrrkT+rFR3jZlZ7+Inh/CAw8cUWaykm4WXzlnEcHSIcOIO6pDwBSS870qHmukRhPdkgYoBQHVFF2dQjFLqbi9qHq0ZGUOzO+GS7Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085276; c=relaxed/simple;
	bh=ZUW2lWFTRpGTDgmVRGipzaIxAzzkN1bRP422sMIswqk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXR3Ldb7QOm+i5d6lflXfRHfDjJLZPX1ZF8gECEpDDoKJwf8V7dGihYq4aKW/EkX+kKFCobfcFGRqqI68JdG2t+/joHT3FF9VnJ+xLtSwgKdy7f4dwzHJfsDkGl3nefk7m43MVu2GCtc2X1EoR9aQ+wcGNiQcSk9fRWPR6zMlgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uws32YJW; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbsXgQllz2fOnkoQxi0U8FLnQRp8UpgSTdY88U9RiRpynl4PtC6eg0j6xvbGKGM2a8GxsOykP4Crl8O02mBgs/1z+pCEBfSvgS3xHGqV60J5Pf5qQr5GHAQrSV+E91XVttrhYg8L3KgLIJvhzgbXa5XWG6Z2RkEvA8MUFwqbNmy5zNqCmQzqfBKax0zysVjEfxlR1iT6qT6GY/wQpAUlGnuhFvxE7Nzz0C3xdGI+WQx26N9ut87U/LF2bFS/yb1QbXtQg3KCXpmWqn3ElYLM2KKG19fJPepJxffTfQcngbm/IxB7TAhJpF+fZR16qnnqHJgYGKLUIT6T+k5/twy8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ2E0COwH+v1NXHBYD8p+AVa65L7z+n0JKgWXxIMHe8=;
 b=cUMHJ1KFvESYK0J4fZ7I8eDqukyuIpa0i1+zt90b4JCp7mZM+hioRcNPaxcB0UAZ8uwx4y9OVn25+NAdM6Xv3R6RDDKm7nFu37hSiw+XMNGJ1Hzu4ybmRVlQr4d90P0ik3cvnEa17X1Waqx/8JqA2krPrSMk6fsX4Mq5a+lnKfWjj2eEXCdzi3fJU4VBhseakBzYM1GiWyhQjAgPpUBEdJBDFyeGbAFXk6T74QeZB0PVI+ayQFfNmX6Chc3lpuoat1ZkevW68eK4U2Cy3e6xyGg3nJZSb9eAUv96sH6N8lGycuZ7nvyKidj2R0mapdTDWAlWW5raYfUEe/8ZpkGNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ2E0COwH+v1NXHBYD8p+AVa65L7z+n0JKgWXxIMHe8=;
 b=Uws32YJWXRhkq2ogECZ5zHgCCRKhWClUyP41ldejql/CGA453g0nsBqkGeoGs4rpWvrzy1id0aCvp7dPuijdLvO4KeKQl0IzApDiO3LUxy5qZ89PtO74bNW8E8ROREICOkO6BsWKPxj7oxrPOCrfPwbyg5XB44ZR6BHjSVhahYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 16:07:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 16:07:51 +0000
Message-ID: <a01df03c-4ea0-4db9-8808-fd46f080dd7a@amd.com>
Date: Thu, 30 May 2024 11:07:48 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <a1eaca6a-ed3d-4bc2-a5e8-5c43bbef49dd@intel.com>
Content-Language: en-US
In-Reply-To: <a1eaca6a-ed3d-4bc2-a5e8-5c43bbef49dd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:408:e2::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: da6b1548-d982-4415-f34e-08dc80c2a86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGpVdVp2Z3NlNysyamdOSlFsMHdLVzd4Ymk5cU05SElNNjBtd0MwVS82RXpw?=
 =?utf-8?B?OGpaVy9EWDdVWFFENFpQVnNLU3cvMlF3MUxKckRhWG5Va2h3Qko0NndPdEta?=
 =?utf-8?B?YUljN242bmVWdllSVEM3OHZJUHQyUHlqdzNUQXhja0d4cVpMK1JEdm1wdlpL?=
 =?utf-8?B?cllGWDRiS0dUUWFDR2xlZmRIK2ZQQU5sK1A1WmZoRGdtRm04UE85SnhYYlNo?=
 =?utf-8?B?Sm1MV1JqTmRLVjZQaGZyRSt1TXpjQ1JIRDhvRC85YU5BNGswSjlnQ09oK2Rx?=
 =?utf-8?B?RDV3K1NKcysycVFJOHNNa2N4eTJEclhqSDZYaCtsZ21vcndmUVNvbUx1MFB6?=
 =?utf-8?B?VmlWQ0swT2dTbzhEQUNZOXVnMXlwN2hrLzA3c2hnNGNQUnQ4SHNFVmhnT2xU?=
 =?utf-8?B?a0JUTHk2WDlydk1sU3gzN2hOU0RyV1NrNDduMUdqaWMvVENSQllQWG5qTmhX?=
 =?utf-8?B?bThsWTFvc2prR1BtSEMyTUxPeVJNaGp5cHJiaHErc1pxL1hlT2F5emR3TUZB?=
 =?utf-8?B?TjNpVk80TDZuemZtdmw1bWtYU213R0xCMWo3R1BjbTNUVnZKY2tVczlsdWZ2?=
 =?utf-8?B?aXZ3RzZsSkFSNEp5SjBBSTYrdmw3SnBBWFJnTDhnNmxTbUtKL0VYK3Z6YTdq?=
 =?utf-8?B?ZG5qZk1kVDlOT3N2bWhKRlB2bnArMUNIOEtqZmRsV0NobXJUR2cvSmJZajFT?=
 =?utf-8?B?OHBYVStTQVp4UlhGZ3BLMzNVSFFrM0d2NDVqMnNzczJmNDlKMFVpUThFVVV4?=
 =?utf-8?B?UXlPQ3VuK2Uwd09EOEFDMzl3aU5ZR3dzL3g2M29Ra0sxWW01SUYrcmp6NFBX?=
 =?utf-8?B?OHprZGlsNERPZVVGTFRNUHc1aG9hQktmSnFBL1VCbnZQOFVmQ3RseEpvOHFG?=
 =?utf-8?B?Z3VabHNtODlBLzJvb0FUS0lwZXRVKzNJT2tzWE9CY0wyQjAxTGxtT0FoVFZm?=
 =?utf-8?B?aW12TW5VVFFYVjEvakEyMXVuY1luTStyM1lhTzg2LzR4bFhxUHE4dCs1R2U4?=
 =?utf-8?B?NTlaNCtrWWxqQmFlaXcxVzdWYkZrd0FMakRxemswVUlobFY1UURaVW9uWnZr?=
 =?utf-8?B?NWdBY3JZRzdQbyt0N00yUDlBdTNQcEtzWnRNeXpUNUZwbzNyUHdrekdpdUd1?=
 =?utf-8?B?cUE2d1MvUVF4Q1lkelhkQitaNU95K0MrVmExY0ltV1RhSE1CUC92dGZDbk1U?=
 =?utf-8?B?R2RIUkhJeTErVFdlN1dTenVxSEd3WWxUS0YrRG5kWDRpRHlNNlFBU2cwd2lv?=
 =?utf-8?B?N1VLZkgrM3Exd1lodHpaS0R3dWw1azJQdS9KNlpwTnVHZEo1NGVmbmRmeFcy?=
 =?utf-8?B?L3JWeThjZy9LVjB5N05VdExPbUpnRDlEL3VrdmV5SHUrbGRLeHBRVkVFZDN5?=
 =?utf-8?B?UnMwNmhWTVZvWnk0bzVoZUU5b3hTekhBbzAxeFRLem5nYU9mL0RoZWhIem9Y?=
 =?utf-8?B?ckFaS3hGSmlCYklOcTN5MytaZ1phNVRkVjI5R2dVOVhHZWNhWW40MDNsY1R6?=
 =?utf-8?B?ZTJ6b1lhYnMyT29KeFkrbi9vNTErL1BPbVJrTVV5QjJabFlvSXhGN2RpNXk2?=
 =?utf-8?B?NGwxMlhaUW1tUHpTRHNSekczQ0xmWlV0ejBnVXVWUk9ZWjV6ZGsrZSthSlpQ?=
 =?utf-8?Q?5vk28zIVA2rPuLw71LTLHQT7YkAzkg8wOo7YdWJParIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGVQYms4bHlYS0dFbVpyKytGcEVSTS9BODJSYkFFNlhLVmVrSHZMd2FtdDJL?=
 =?utf-8?B?OVpVNmNXcENmNXBaT0tEc1FNd2dpM2VYL2Nna2liRnMyaWgrWThYL0RrYTAx?=
 =?utf-8?B?djJmWGxEMDlQL05kQStwUzB2NVdjQnp5VzFvRmNHVGpOZUtibHNVa2xmUld6?=
 =?utf-8?B?NUJqTlBFQ1V3Yk9YOEt2VzlyT3NWUERrZTZhNXRtaS84Tkh6ZDJ4MVVoMkhW?=
 =?utf-8?B?VkF3am40VDNreDZPSyszak55ajUxdjhFem1CbkI5L3lub1gvSjlycGJzbVll?=
 =?utf-8?B?UXRJMG9ZQlE3Z3dlRjRmYXpuNFlPbXY3cHhqRjhvZXQ1b2d1QndSK3pHY25x?=
 =?utf-8?B?UU45V1d1cjhpTjliZ2pwMXlqRFYxaUtHcVRPbXhaNkZ3V0RoamZXWGVyMWwz?=
 =?utf-8?B?MVdZWWR0Ly9IMFRQZTR3Nm1vd2FCWm9FYUk5Y1hoVHFJYjFueWFUSzNLMEMx?=
 =?utf-8?B?WkQzajRxcENOc0lhRVo0YmtkUkNlWTJwSkQ1ZW9qSk9qR3RaNXMvWnZoYUN4?=
 =?utf-8?B?Mk0yVHlwenpFUHB2azBtMyttRnpvUndyTlpjRUd5Mmd4N2RrcGY4T25EdlQ5?=
 =?utf-8?B?Y0hEcHo0TENidlRwdFBIN2M2ckZCdDFLMkpRRXJjTGx1bGZYNkI5VS9jK3F4?=
 =?utf-8?B?SDFySSs4bzV0UG8zYlRBRWZZUEpST1p6MmFwR1lZQ2NaRmNVREV4bkZ6N25J?=
 =?utf-8?B?N20yVUhkTlc1MnE0cW9xeVc2YzRlR2xweTJJbERTemVzNUkxekZtZWRFMDhY?=
 =?utf-8?B?bUJYN3hFTEFzNDFyU1lkZ3lLZFJldEpjTzc5d3BqMVJ2WldPQndYdVBqT2F1?=
 =?utf-8?B?K3dUVGY2bEdUWit3OWxJSGRObzl4RWJ2dmlyN3BCcEZaZnZyRnNOMmJjQUNM?=
 =?utf-8?B?dkt3cUJaL3prOWNJQ2hnd0dabVY5VndicXlZTk44SWJrUzEzSnIvaTdvajIw?=
 =?utf-8?B?UWhQaitNZUpxTkNMTjhqSEdZa2pVdVh3Vlc5dW5tekVlVGNtcFlCY2drbEdw?=
 =?utf-8?B?YlMwbEVkd2h4T3VvWFJ0bkRmbUNpNXEvN3RDNldmMUhTNGxXd09kZjZOdHNm?=
 =?utf-8?B?bThXN2dFWlpMNXMwNXBwQTBLaGxsZHRiTjdtR0JIbzNkTThIM1RBWW9PRjNv?=
 =?utf-8?B?ZWlOaUNjcHUxbHRBc3dJWFBMTGRiNDlURXRSb0U1WTJ5MDBpK1E0VnVYYnlD?=
 =?utf-8?B?L01rNHlIckhmSFZTRkxjWlU3dmNYbUZlb3ZoV3ROQlJyTG51Y0N2Vk1vUmVZ?=
 =?utf-8?B?TFNjL21hRjBzTzA1a0RGYVNDUWw0dlRtSzVOdFlyc3J5Nm5FbHBTZmtZUmJH?=
 =?utf-8?B?SmNWaXlWLzE1MDBTcUYza295ZTU1d2ZyMlNadWw1WU11ckFWNi9qNFpjeFp6?=
 =?utf-8?B?d1NGOGQ5dE9MV1ZCQklTNzhYelA4UWdqL0xlOWZJdlM5NkRtMGU5dCt3U1lN?=
 =?utf-8?B?bkJUbG5xRzNQU1ZMZ2xnZjdBeUxsb3Rvcmh5SkNWZXNPN0g2SkpHbzFTWnNO?=
 =?utf-8?B?VDFUYktuODVNWVVQaW5OSTdFU2Q0TGRiUGYzY1ZFMGM4RFZxMjdSMVprbkNZ?=
 =?utf-8?B?d3BIakFEcTNyR1lNVENuYkpQQXJZK2k5SzQzQS8zYUlTTTAyWWk5RWhVb0dR?=
 =?utf-8?B?RlJVL3QwakFYVDlVTDNneGRlOUhaNGpITGlxUmF6bVdJZjh1RVFEVC9DVGE1?=
 =?utf-8?B?cXEraXNBOSs4blViUVI3SlBzV09kbEtvaVdPSFZUSkk5RnhjZnN5UDE0Wkx0?=
 =?utf-8?B?VHZsb2dqNXlrQit1a1ZySkFrcGdzcmQ3ZitneTdMY2I5aTdpSEpFVWhpZkVR?=
 =?utf-8?B?MThzNFJCN2VqZThERVhDZlNJTzR4djFJNnloZm01RVd1YzNWSEwxeURZb25q?=
 =?utf-8?B?OUFzUEZhL2dZYmxIbHhaQVlPTGVJd0NhblFWMy9IMEVUVUUyaWpXS1BQQXFa?=
 =?utf-8?B?cFJESFlkaFlnUnBXdTBHaVRVa3dhelp6c21qTlFHRFlJcFVkMkhYOURxeFlV?=
 =?utf-8?B?QzhSTDFrYnhtWmViWmE5ODVxYzN2dlo2Ty96cmlndjdwY1h5Yklrd2haMWpL?=
 =?utf-8?B?OS9SNFZ3bCtTbUJCczZPdXlOYXJyS1RlNDBwUTcyRXNaZis2b2pzd08wNEhJ?=
 =?utf-8?Q?Wz6Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6b1548-d982-4415-f34e-08dc80c2a86f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:07:51.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI0Vl5YmlPWcu9VtGNQXsgL8YHkZQJBxJDKRqLH8TA+MyW0oslQJlRxt6Nma9hMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Hi Reinette,

On 5/9/24 16:10, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/25/2024 1:16 PM, Babu Moger wrote:
>>
>> The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth Allocation)
>> features are not enabled for AMD systems. The reason was lack of perf
>> counters to compare the resctrl test results.
>>
>> Starting with the commit
>> 25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
>> now supports the UMC (Unified Memory Controller) perf events. These events
>> can be used to compare the test results.
>>
>> This series adds the support to detect the UMC events and enable MBM/MBA
>> tests for AMD systems.
>>
>> v2: Changes.
>>     a. Rebased on top of tip/master (Apr 25, 2024)
> 
> Please note that resctrl selftest changes flow upstream via the kselftest
> repo. The latest resctrl selftest changes can be found on the "next" branch
> there.

Yes. Got it.
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/
-- 
Thanks
Babu Moger

