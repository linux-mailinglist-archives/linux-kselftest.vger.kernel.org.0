Return-Path: <linux-kselftest+bounces-9554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073278BD52B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07D12812A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C05158DD5;
	Mon,  6 May 2024 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYYu7yJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D7158DC4;
	Mon,  6 May 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022536; cv=fail; b=k8+1PXlZmNrNtBB48AQPFCAUH715Wd/HexNQoYW15slBD7y6+vl0ljZ0uQ3aftAikrKs3jxd82z5takQ/p3kLjSonwDoYljZ0bDJ3p8PBxovCSGRrvnlf23OJ4Rw8YZDXQ3fzKQC8a34vmtI5qBlhtceKWEvtEK/1YwLG0TclSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022536; c=relaxed/simple;
	bh=MHFLc+wkGfCsO/IbofmyO0en7lxERUTnEmrUiVCgPGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nG1H8qgJaFxTkx9pxI26W0txqaG+au+7ngOxbuaHO2MwhjeE6Gd0GsrHo3niK1DecnfLOCJISxXmPl0KKtBg4oKHa1tc7hxO1XL3oOra5exPSpS5o+tdIwvx6bXzP14DYLDl9b9dlLCNHTBfgExtjSqca3/mmIl3VJDYmPTmRHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYYu7yJS; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCqkVKUPkBF6sJhP/KeSc31yjQ73/0E290L0PKnuFd4Dp02XVtEWLef4SjJRdTPOUlm6xGIa4oq9+iJ5TRG+KnGH4hyD4GpdUtR3eRxINGIOYM0UKC6jj/xyu4Ak4X17AumVKPHGZBXyd9oJCe/eoK8ElPHR2fihrU6K5UQEYiTWdVPmrHMJnOZOm0X5pbXh37CR/o4XTjba2ytRjPmo+sGFELUT9fKGQ6uehnZB4k6VHlv+h5lUlsTLX64xrSmdWtAi2yhn4gQfPmFTttLRXaBNaF1dTDl5TgfzJJwjokuCRT7Egu7tq0p3x0sWTL37Nc5o1W4Y139tLqT4ni7Mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF6R9Dv58rdqqR0tPk4qRq3YPuNoO3Gre6afZuMBIcw=;
 b=InykGEOhepajALqYQvueU+NIk/aiqqvk2OFUxSB2ssX0EdagRLmzF8JiY0okxeyYTQcTPZEcqmhi8PU7AZBRkUolk+nG3cU9V5JoQ3fXLbxYpyYHT0LgtQtFmUGQC8jE59d76zuuNOIjX90cdneT4rbvgBcfumxxNupAR/DM98JnuLOnPIM8NdyoV1hFvJD4cMGwcR3DfkK8FrGTzev5KZbDb02OjuLTINVtsTMBFLFV4ncYeQbYlmR0D0sFxQPfVFlgmNyxakgIaRrG8rYpeR6ZyowHqg6Cqh9CVuhmaeBNnsoZX+3qSvPU21G943guz/WzQmoWBQHZ58mTzKVfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF6R9Dv58rdqqR0tPk4qRq3YPuNoO3Gre6afZuMBIcw=;
 b=tYYu7yJSf11dyoJmeIFsSkEqygFUec0DapL3anxxdWlWa4obANxXXxCdBVKnPFr28ncZ1GKwRKOYoA7yZbk7URzcFE+2trWpZKaJZf6WFPV7Vk7HBH/hGlLrefa9exqV0u1pDh0NLetfgfVnUEWyCNbD7HHr1U4o2CItSpW8ohkubU1U8T1YNvI7DGFnxa14DVUwlH5nsCvWcWBzwjEQbdipTVNASoYBVUENabir1ixarh8Pr9SPk0Mm9A6qzLG3znfJxHSjCDTbDGBLAnclYeC378oJg2cicwuT3i08t7WFBmwKVnPP5K7NQVC6mzmknMAO5G1aAd+PfVt1AYRzUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:08:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:08:51 +0000
Message-ID: <1ff60e91-ac20-476b-a83e-8f9f2f797eb4@nvidia.com>
Date: Mon, 6 May 2024 12:08:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: build with -fPIE instead of -pie, to make
 clang happy
To: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240504022301.35250-1-jhubbard@nvidia.com>
 <202405061007.F1A46E89@keescook>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <202405061007.F1A46E89@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afdc90e-200f-4de1-28e1-08dc6dfff71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFc4Tk1PTjBUQU8wVTVlTDFxejhETnA4NkU3R1ZDaEorV2tnMEN0RytwdzJw?=
 =?utf-8?B?aW5IWG1kckxoWlNPTnBDYXpUQXBEdStuUndDTXRHVjQybGQ5VWxhbnBiODJG?=
 =?utf-8?B?MkdaWEM3RVdsWWZOTDU1UUgyQ1ZSemVITXh2clM0SjBVVlV4bk9iUXRkNXNR?=
 =?utf-8?B?TnF4RDF1SXBUOFRBOVdNd1oyNFZsazlDcDVZaFFPZnY5RVZhMlc3U2VhSnJz?=
 =?utf-8?B?eEFXZFJYR0xBTkhycDNHY2hyNGJwNXh5WWdwbWZUSnE4RnQvUjVER09Eb3Bt?=
 =?utf-8?B?OE0reTYwbFlvNjdEWExYMkFuYXI2WjBnRkpYTTlkd3dKTWJlVGNuWWZtWWMz?=
 =?utf-8?B?RmV1Wkh6S1hGcHlYOUxwa1F2YWNkTUd0Kys5eFpGclJwcmNzeTdEcjEraGx5?=
 =?utf-8?B?VnNCbzlmd0lWeWY0OGxiaUVnVmdNbnUxNEZGblNESlc3N2kzaGczcVZSbUVP?=
 =?utf-8?B?MFZpOE5DTEtYSjlFdEdmSDVETTB5MWN3cVFtSHl3ZG95UEJ5VDhieFQ4Mis1?=
 =?utf-8?B?MUkxdmJQdjJ3Tk9vMlUzbW56Ukp4U0pkUy96Yml2QlBRejRpZnd3bVAxZUFs?=
 =?utf-8?B?WEwyT1hPRzNPZkVTZ2dRcWJ1KzdLRnpjRlhuQm51NitZZlNXV05HamJTWTNq?=
 =?utf-8?B?NkhOQmdQcVgrYWNUcE1UQ1k2MGlZZHdzV2VKMUgyL0gxbElpWU5hUTByK0JH?=
 =?utf-8?B?NXFIaFZ0NWlhVUk5ai92MUlJeFJQd3hzK3haZXZQUkVzMXQ1MlQwVjBuLzNl?=
 =?utf-8?B?ekN2VFgwY0ZnaHc2UlBCeUIzRXh4K0xLb1R6ZUJpWmJRM0s0ZkNoRmlJYllp?=
 =?utf-8?B?dkZkbkNJWmpSMjg2R0Z5eFd5RFgrQ1BreEFhdzZkY3FRTTdPQW5zZ0IvWThG?=
 =?utf-8?B?RFJmY1EraWxIcDZLR21TeE8yaCtqNlJUNlRxc2VRaTBzWkZkZ3dLRE1SSk1P?=
 =?utf-8?B?YnJHYkhQbHNTQUNiMlZiOUErZWhXcHhGenB1NzloNEMwMXJhdFhualg2OUhj?=
 =?utf-8?B?NER5WldjMVR6TXhwUTZ6bUhnWU9pSEcreWMxeENFYmc4akVkMDBnaHVpUlFl?=
 =?utf-8?B?VVFXYjRRWUk4ekYwZTA0c0loUVlMeWVRcWdvS0VMYmdNb2V4RlNqMWRQOHNT?=
 =?utf-8?B?MEI3aG1YRUlPTmhYZ3h5ZCt4QW44NWFsMHFCaHlCeXhFMlorK1F0cjRRdFpN?=
 =?utf-8?B?UU1xa2ZXKzZFVWVnc0YxbDRpZ0dxRkRBeEU4QmxjYWlkcXZZN0x1ZHJUcWc1?=
 =?utf-8?B?T0pBU3lCT1pRUGJpTEFWdTlSU1dCMmp1MWZzMk1JQ2JUMmNUS01EUlpqTjRw?=
 =?utf-8?B?T3FlMy8wZ0ZQTzViWGt5ODhTR2xTQ29pZUxXQVV5akdQWTBZdW1ZWnAzNUlN?=
 =?utf-8?B?SUFBa1JQYXdPT2NyNDRyT2I4YXRpM2NrajF1THV4SWVCYVpHRDNWb3locysv?=
 =?utf-8?B?cU5KdWhCeTB1NXVVWHZ5eXpza3dRdnpTVGE5bGpRRWJSZzk2M0tONVFZcmlZ?=
 =?utf-8?B?Vi92dmNhTVRtNWFtWXNvdGtZeHRxd2Y1NWFGN1Zsdkg4U3hxUlY0REVrZnZT?=
 =?utf-8?B?S1VvZEVWMUdVZjJKWU4zZ0ZlVjVtbkJNNTJ6WHJVZmh3N3ZMT2VpelEyZGFm?=
 =?utf-8?B?V2liYkRhRVF0UWRuM3FiM2NiWEtMZXNyVk1kYndCRU1yK09EYmtYTTYvTjVJ?=
 =?utf-8?B?NWpJWFJrYlZZbmNqZzFyR1dvRjh0bGsybXB2QXo3blF2T1RvcmllZmRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBYbWNUcktJelU0TkRxd0s5YzBiMnJkQ25iNmhUTHdPVHkwVEw0MmpOQk93?=
 =?utf-8?B?LzRKT0w2SXRZVXorYzhkTWgxVUJnSStSU3NtYXNWOFFMOHVNNFM3RmRLSzJq?=
 =?utf-8?B?dURLYUloemc3VEVZRVNhOVkyYUVYT0VnMmU5MGZxUitZNEVJb2ZqbmN1UGRu?=
 =?utf-8?B?TXlrRkVsOUt2Wm9sYlY2OVNnYU5UTzRRcm5KSTlBblQ1QWhORTlwaWtDVXpL?=
 =?utf-8?B?bjduaWs3ejVFNUhxQ3gzYUJlcVJkSFozTWlEUDdCT2ZvUHJialYrSnVvMkVx?=
 =?utf-8?B?OFViQUNhSEJHRXM5ZFdRdjRaditWdDVhMzhPM25LSlZJejNjaFMxTFRMek4z?=
 =?utf-8?B?L3dLeWV0US9XOS9RbEx0THpjQ1BXcm54aUVpdUNQSVBRcDNEbzgzMHhiSkFy?=
 =?utf-8?B?cjBDYVR2TlY3Z2FQVDQxdU5vcHZQQW9WVWplbU8zM1YySG9xdnp0MkZlU2FZ?=
 =?utf-8?B?WFRLK3lSeUxmRVpUU0JDZE0rWVMyYlVTQ0JpVWtoQ1BxSXNTVXkyaEdOVmtX?=
 =?utf-8?B?aGl6aHFYQUQ5Mlo1RWZsM09CU3ArY05YRlZJbmk4ak9sdHdvcURaN3lEbVN6?=
 =?utf-8?B?K0laSDNsaEFwdFlFcjRwOU12dWRKcDBraG1IWi9GbDlGaGtpdnZuL2cwTnZw?=
 =?utf-8?B?a2JScGJXWkpBdzBaK1lPUUV4UHc3VmRxVHYwTGEvRVVVR29ESlBWUjlDTzhP?=
 =?utf-8?B?emVRN1VXbHI2bTBaMG1YSi8zMDdsQXhMUVFudE91ckpiS3BWVElmcHpOU0V5?=
 =?utf-8?B?S1FMeDZEV0dIem1OcktZRzVobDJOb25EUnUvMWxVazRReVA2M3RzaGVQcGpV?=
 =?utf-8?B?N2s5YXBNTkpqTHdMVFZBOGE3RXdKMEZqOWpBQXJQd2xVdHRVM0VLMjhUQlNa?=
 =?utf-8?B?N2xhYVMweVlJMEtPclJwN3VQem8zNzF1RUpFM0RmY3E0WUpOemVyeG5WQndF?=
 =?utf-8?B?L3VHR3crQTRzbUdGUGNtMmxIZTB4NGZMdHVEbzZ4MmFGN3d6WTNrditXOGgv?=
 =?utf-8?B?bWkxZUhyckJqdUVWWHNDb0JjS3V2WXc1N2FIVUtubGpKNVdPck5RL29JdUpO?=
 =?utf-8?B?eFp1WklqZ2xJRUpjc2hBN3ZTWVZBYi9haGtoVTk3UHZoUlRNYnFVZHl4T3hp?=
 =?utf-8?B?eERJem9rV1hoZUU0MUJQVlRmS1l5dDlQQ2lOYnZ1R1ZVUTZ5dGJ6bVBhcW5Y?=
 =?utf-8?B?bmEvZnZqMUFsdVd3dFFQdldpZVlqZ2dyWUsveFdDT0FrS2tyQ3MwS04yT0Ey?=
 =?utf-8?B?SndWZXd0TVFjZ1VzNEpyQmkvUHJsZkU1c2tVamR0azV1RkhPSXRMT1Y3eGpq?=
 =?utf-8?B?UVlTeVVrWWt4Vk9PZk9UVnFaSDZ1V1p0SlZNYVM3Y3Bob0MzdkVHS2dWOTM1?=
 =?utf-8?B?My9uc2x0Zk1nbFkxYU5iNHF2eEE3bHZiK1BTTmVnUVBPMmYrQmZHTkFkWVls?=
 =?utf-8?B?eUZDZjloOGtrcTBSenllOHVudnoraWZBMDRUdzhIQy9xSGdRZWpvM0ZmUG1i?=
 =?utf-8?B?MzFvdllOdnh3T1hTV09SaDZ1ZmpoR2NVR25kaEZhdEV0Y1lnWkpST0szWVl4?=
 =?utf-8?B?K2h4bzltRzMxWGt6clVqYXpIdlp1NW82SVduMmNWTVVsWjYrM1hvdjVQYkhw?=
 =?utf-8?B?YUNDSWdURmx1cURnWk5wOWhkSkQveGh6MDBQUnp1Y3h5ZE16WG00Wk91VU82?=
 =?utf-8?B?VVNZSksrejV4cVVFT1AydUNHamdZTVNOdCs3bTZTZmdlWVowUjEwWjdXWFht?=
 =?utf-8?B?V2NWUXh6QUpFRGNNR3U1SHJMYU1tS2hDVzV1Z1ppYTN0ZG5UMjZOSmdMSElK?=
 =?utf-8?B?OVMwMmhscVRDMis3NisyalRzb054N0tINGdKNVVOZng1akNvRUNnaGYxY3Nm?=
 =?utf-8?B?dXlvMmwyaUw0dnZjMU1HSUdoMUdKV2NBYTJUbWZJa0diQ1hlSkJ0YmlVQWtI?=
 =?utf-8?B?UzNxL25pclBIWEs0T1JDZFFiUlNqMld3cmNDak1zSVdzQWw4b0JuN2xRTTFk?=
 =?utf-8?B?SDUxT3VBY2lJUGxjU01rUnE4S0FMVGRJTXpNUjZmblhjSVEwTU1RMmxDbmNI?=
 =?utf-8?B?d1AvQzJ2NXM0eXdwTXM3U1hpMTN4NUYzcHB4OEdxVUsvUmVrYkZraThEZVNR?=
 =?utf-8?B?N0F1aGN2dDdVSUF1SUpKaHF6aWhFbWdXL3ZzZHRPQ2hqdG9OK2NKYW9NbXZt?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afdc90e-200f-4de1-28e1-08dc6dfff71e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:08:51.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8e56/MZSVPSwLv2++k098BQZeh7ebFsSphCGcMUeBJlzLLVNTvlbMgdtqqO/HiyAF7Xc1xaIoeP7+j6sB+YDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

On 5/6/24 10:09 AM, Kees Cook wrote:
> On Fri, May 03, 2024 at 07:23:01PM -0700, John Hubbard wrote:
>> clang doesn't deal well with "-pie -static": it warns that -pie is an
>> unused option here. Changing to "-fPIE -static" solves this problem for
>> clang, while keeping the gcc results identical.
>>
>> The problem is visible when building via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> Again: gcc 13 produces identical binaries for all of these programs,
>> both before and after this commit (using "-pie"), and after (using
>> "-fPIE").
>>
>> Also, the runtime results are the same for both clang and gcc builds.
> 
> Thanks for this! It got solved differently here:
> https://lkml.kernel.org/r/20240416152831.3199999-1-usama.anjum@collabora.com
> 
> Does that work for you as well?
> 

Yes it does. Please drop my patch and let's use yours instead, thanks!

(As an aside, outside of the compiler sources themselves, it has
proven quite difficult to find any in-depth documentation of linking
options and behavior--now, and in the past.)

thanks,
-- 
John Hubbard
NVIDIA


