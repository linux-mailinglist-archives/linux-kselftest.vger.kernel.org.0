Return-Path: <linux-kselftest+bounces-20136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B19A3D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 13:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00CFB20BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5933987;
	Fri, 18 Oct 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LwyULNM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA852F46;
	Fri, 18 Oct 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251336; cv=fail; b=S5qIf93OZeTqiURWVoT8DMsMBgAjLs7s/EwQ4F9UU/EGCfKFLaNG7DXDhfmr3xspCNxg+SfssJl7pJ4k9vPZsiwV7i9BAd+h0VXMLPu7sJ6YWSksYM2E+HFpQqSBA1Ov7OJrQJ7+m7ypRyi6WyGaC+l+4TPE2pv0ea7s4XJ6970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251336; c=relaxed/simple;
	bh=qU0tvk+sT2zkBYKpnmwq/lUBoUfQHosEX3B/gqjLjrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N8AAGosWEEDsC35BmIiK+4KebCF9d4+/ugDyQTO/VDSrGr9KTq5HF3U8T2X7Mr/ZK9/ZTwFcZfgMdPvPYQHGa0mGTaIDfbva9H9fe7b0suMUuBBAmHeKbDY3RNtcEyA80eZVNKgtqs0LHdaRn0qdFCG99C22DfkrOB6Qoh+C8sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LwyULNM+; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud6nj87yPn8NSQ9FFofyNqwRky1DvBygOH7tYIHYm/clA+CkROf2tzEglsAtCh4HX/IqM+2xkGg3PWObtZFOuLUydgUs4Y1poBsYWvFrdQ57gbc3xLBBifDFEs88SkeIDcqj3lLYyBmwyP9EcI3V7LgPAi8AYag2F0CoJyCp2u2cH8KWJSYiwbaqYBI2pPcU2vU3LrsknjProSw6yFgZjKMNmKFQIGaB6elf7F9IOOXnDbnuE/97tFWTAV5VVk6sgNI2H+njwb7NaZm6t4umoIRdi8X2/BX4nCEf5hO0oWh1SigxQOPWz7wT1knbfpWCvws4Cero4rM6whn2ethEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM8J5iyiWCQ/Um0ly89kwTdm+QHcdDGLhuYgH49cj3c=;
 b=AqXhVWr4SatcBoqH8juI8vRnojDDKe/9ypedoMm72IJBCsCbTBkk6iCrfl1ZhU70SvrOh0hwI/xcKHqpT1H7zilC3v4jvFGKU2CX680Hc3o/pK8qwUoKUeHA4Kz6ZlSXcRgXx54hKzlAaOWglSda1n5UdreXT9XbTJQofEoydS72mUqBdDX+lGn6GjtWh8l18rfuqRAYnDY90bsOxs2nFq1OWO4+EuHH/4DpwUHBx9jiQIDgDPSKC5CYlTomPjOA7w/mcJx/ZwYQB1azVtlNd+iaDTGDrwXQ9zNGjyd/ph1oduH2NsdLTKzBg6Mpm91zE9v0NxSxsfrLfwK8yJnQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM8J5iyiWCQ/Um0ly89kwTdm+QHcdDGLhuYgH49cj3c=;
 b=LwyULNM+2YWlva3vnXZcmbzOXojDqsarKcvvsbk/giRajqU0TCuvAp2ASfCqCQbvFg0N0CEjaCvtVB4QTQ7hsdqm48wjQu3Wl6mPlRQjHDd49T7is+6z/0pu+vyZ79iUAm8hAqEtbF2TI6xQPBBwx8yYT+C+EaTM5CpuXTPQn5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.19; Fri, 18 Oct 2024 11:35:32 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 11:35:31 +0000
Message-ID: <7161ccd8-0618-4c3d-86df-beeb7f0b57c0@amd.com>
Date: Fri, 18 Oct 2024 17:05:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241004053341.5726-1-manali.shukla@amd.com>
 <20241004053341.5726-3-manali.shukla@amd.com> <Zw6rJ3y_F-10xBcH@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zw6rJ3y_F-10xBcH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7aff18-18dc-4679-a8e4-08dcef68f913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pzR0MzRDNCWk5PZytmMlE2OGRqRmNFeVVlaXFVd2N1U0JaT21UTUF4MWRp?=
 =?utf-8?B?T1F1UU5saWRSZzc1cWpuSFJxV0RqY09wT1hVWFdJeXlLZnl0TTdZOVFGMG9J?=
 =?utf-8?B?bElLZXZ6dVhQZWdVZ21sdktBZHFVYVNjTEdFQncwaTBxOXpnSVBwTDEzK25U?=
 =?utf-8?B?dHVrK0RDL0thaXhoQVBjSlo2cWh3U0QzTXRXYTFuelIrWHhjNHNROU9XazdH?=
 =?utf-8?B?NlU3bWh5YTgzZDZocS9hcCs0RzJXaTBBNEZuMmVKT1cvRThXWmJKVVM1VmVn?=
 =?utf-8?B?M0pXN3BXVDZMZk1SMFdjNENNTGNQc0N1UXByS0cyQWhmWlFUTWZoSWV1VUdI?=
 =?utf-8?B?NlI5UE81MTR2cm82Q004UGhzTmlONWY4WGhlLzVBV2VxVURCdW53SmJTMDFJ?=
 =?utf-8?B?U2NiaUtxZEZQUEIvaktTY0xKRlJUQzRXbHQzbkEwQVptbmYwajB2aVdLR1dR?=
 =?utf-8?B?SC82UGZMc2FlUUcvaFVwWnh3Y3VHYjVSbno2V1VVOHZNZDN4ZGQ2SzV4b0Nu?=
 =?utf-8?B?aTFEcDh6aWdodHZWTG1RL1pwK3NMV0lkN2lUTDU5clNJYklodkZ4NEVOSWtH?=
 =?utf-8?B?bTZlOEgyWis3R1oyNk1RNEFVZmQxREVkMTE1bWlGWk94MFQvNjJIa1dPNzUz?=
 =?utf-8?B?amxueFFYL3h2VERTZWkwYWUvbTZNOUJEbkdqSk9Hd2cwLzJFZjJaZXpwWmJi?=
 =?utf-8?B?NXQrU3ZDUVd3TWx4cUNqNENhL1NZR0gvVUtqZmpWNkNreFVEeTV4KzdhdmFB?=
 =?utf-8?B?VngwRW9ZeGJDczliVWtkbmw4clFNenFZZnB4KzhWZW1qVmZxSWlCbzF2OG93?=
 =?utf-8?B?cDcrTW9HeER1YXJOMmhRakNlaUtyU2dvMExYa253OVpzWXQxQ0hTdnV2c3lM?=
 =?utf-8?B?ZXRHTWpIVEFlUFZnTkhpZGlJN0pJSmwzUFl1VjN2T2FPNmNRT1ZCdGFyWHlw?=
 =?utf-8?B?bEtNc0xZazVsYlYxMmZ6S0Y5QUVKeHRpMWNLVy9ZYm9nQVdmQXlYOGY0RXZq?=
 =?utf-8?B?bXhDMkMvalNQSjFaSm5GczhsZUtNdlV1TTU3VmdHT3lzT1I2Q05Vc1Y4Nll3?=
 =?utf-8?B?UTduVEptN3BIZ3NPQjVLNFIyb3pFeG1NempsdGtuSDIvNnpRODRGRUhaa0xU?=
 =?utf-8?B?blRNZUpSMFVKWk9tQ3BjRkp1bC82cUcwZGxoN1FuMHdTd0dUNGFFeGM3K1Vn?=
 =?utf-8?B?YUZUSzJuRmFTVlB1TEpzQmJUeHpTNWwxcWdKZjFkczgvL2crT2VURHFyTWE4?=
 =?utf-8?B?TlVXT3pkVDZnT3FmQlVmQ3lsMVJ1UTk0b2FEYThPTUlOdVZHdDBRbW0wTUk1?=
 =?utf-8?B?bGpqVTBHRnJUcjV2VFc1VnpwQW53MnVEMURKTmJSc242Mlc3VzBwSTBpZTVm?=
 =?utf-8?B?OVdPOWJJRnZGTEpXMWYwWFg1MlFwOWVGbjdIUzVwb2pUaFRqNGY1WXFUa2lj?=
 =?utf-8?B?cy9RU0hLMnQ1Yk9CWkpLN09uS2owZzBRMENuTDNXUjdaV1Brc2kwdkN5UTZ0?=
 =?utf-8?B?Q0VLOG1nSXpjSlBFNHBzbVVvL1RGK05vcU42R2JDWlVTa29zL3dTeks0VkRS?=
 =?utf-8?B?SXpuV0VXVi9HY21DZlZPdTZXMGUvSHh1M3Y2bnZZdWtLV0VvWW1HYittZGEy?=
 =?utf-8?B?Q1ZTalIrbUQyRFA3S1FjWDgwc1VFbFNTVmZqTWZXWWtsNVJmZk1ITzc2QTFq?=
 =?utf-8?B?RWthWENOdTVudnpYeVorUlNkVXF6cjVjMjczVERIQW9MZlNNUTgxMEJUeVZJ?=
 =?utf-8?Q?gkxIYbXWoAuGNKwWXuve8Whc0xSTrMwxdlVcivN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERTZUJFakJGaTJkSkYyUWIzYmZlRHc1bGdxdDloOVcwQlpzWStOdkIvcGtK?=
 =?utf-8?B?c0ZBWis4blZOdThJZXBacnZDbGhCSk1SZHAzTDIvN05IejhVajREaStVNDk5?=
 =?utf-8?B?cnY1V1pUUnIyWkNRRVNidlpCdWlCWUlVcld5amdqeFViK1VNLytDSHlHK0pR?=
 =?utf-8?B?WDJGK3RDazFRTFFITnNUS3d5OXRvT3krQ05oZHJvRmhHcTFvdVM0Q05FTFZ0?=
 =?utf-8?B?dmVUd01JV2paL1NIUURhVTd5VmxuVzd5cVZJbzhWUDlRcEVWSE1BaFo2TzlW?=
 =?utf-8?B?RFQvL2U2VTdWOGZnbCtqYjE4RFpqbnBwblV1MUh4aEp5RUN4MW5PREliMUhD?=
 =?utf-8?B?QVRxNEtOTEJYZ1llOTBlTk5jdElmc3RibDFWYm5MN05LVmxZUFNVVEJkdC9F?=
 =?utf-8?B?amJ6WFpBdEI0S3JOMGhDUTlyOGV2KzdZaXpFTkxpeEkySHVYV25ublFPVkFl?=
 =?utf-8?B?VTQwZkNQcHg1QTEzbkk0c0FxMHJneGEwM1R0RVFMSWwzTHFjMm5Lcktva004?=
 =?utf-8?B?eEswdG10WEVmc0JiQk9LWmRQMDRUWjRxY3poUm1Kb3FxUTY5MnJLeXo1VFJm?=
 =?utf-8?B?MkwyVlJuaG5rcDFrNnBpcDNZSmtVMGZuS2VjNHMxclpkdnhvV2xic3JxclBV?=
 =?utf-8?B?azZ1SldrSzNrdDFmWUZ4amFGOEpVS0NkY0lTTDRCam9TNWswcytGR05rc3dG?=
 =?utf-8?B?d3hQc0tMQ2tuSTJjdWFpNVpRMUVvODhJcDdDU3hHbEZLU09oTnZsYmVtWjg3?=
 =?utf-8?B?dFBFTFk5SnNHSlRrWXdGcG01UkNVbkpONjZsOGZNMDZOaDZWSVdudXA1SEhr?=
 =?utf-8?B?VzR0bTNPTC9BOEVtR2RrbHJWcTFLdkVJVitCN0I5OEowVGVLQzdqYXZHVmU4?=
 =?utf-8?B?UXFRVEdYSHJVQ04wczZHeG5Bclp5dFJtVDVlMGpJUGJQZFJJUHZDTGtGUWJh?=
 =?utf-8?B?VGlDN010SlBBUFpUcmE2dEF2OUh1MjFUd01vZnk2Q0puWkhZemJuR0w3aDNK?=
 =?utf-8?B?dXVaZmx6TXpDaDVSUms0YytPcjlzTms3QXYwY1EyTmJXTjNQaGNoaHZWMFdj?=
 =?utf-8?B?T2RoRXN1bEt5ek1CbWQ5aEIvRkxWdVdoODl3bTFDMUNCSUN3QWpXM0F1YU41?=
 =?utf-8?B?Uyt5eWJiT3dIcjVnbUJGV1gydTRPN2pSVGhiY3VQUWttRG1mTFpkVGI4RUNJ?=
 =?utf-8?B?S0JodVpSSytBT3FraEtLdkc3bWxRZmlORlZPeEZXS3VCemcrVHBqMnpqRElQ?=
 =?utf-8?B?VjI4azJJRTYrL3NVb29DOUJtWUZ4RzVwYkV1OHdYbFlzVXlkR3VwSnpid0M5?=
 =?utf-8?B?c1dKYXN1MDg0RFFhNnU1enorY2drRGdIMWQ5UnNvTmdIV1NKQVRrWE43azZC?=
 =?utf-8?B?TUM4eUVBeVZOOSt1VG1aQXppbWRxRHJHaXAzbVdJdnVpTGVLcnF5MzRkTUVC?=
 =?utf-8?B?UmYybVduZjVkNG5IQkdQNE05NlByREFlNFFueXlLMFFyM0JOeTVlV3Y1MnlC?=
 =?utf-8?B?cHhscURhMmdYQnE5REdLUGFrSjdscFI4YXAzd0NGR0RKbmIyNnM1dVdvaHN2?=
 =?utf-8?B?aVJEL2FzdHhRdTh0Qm84UC9LaVlJZUhIa1dmWWh6QnhEWGRJV3FBeVV2b1FX?=
 =?utf-8?B?bldKaFZkdEM3KzdPVUhLSG4yYnFwVi9PTG45bDhlZ2RxR05Yc25vK0pQcGJQ?=
 =?utf-8?B?bmxTNktFU1ZVbjhBWFd0Tmt5TGlXTm1MREF1ekxMM3d4Umh6Q3ZKK01tSWRw?=
 =?utf-8?B?bUtOYkF6YWdsdWROVFFCb3BvanJ1dVNpOEVodC9LSWg2UUpsRlREM2xwaHV0?=
 =?utf-8?B?eEdURiszejc2cEZVdFpFemtEOGQyZVhKcWxLd3ZaTFRWWk0rTmlKZkZJd2g1?=
 =?utf-8?B?QnRGMVdCc2FKVnNxY1hiTTRLZStDR3BqL0R3b1RFWEJwTnM3RlhBT1RuN09N?=
 =?utf-8?B?OVVibURsOWtaUlV1MkRJUCtuRHlROXVuc0ozK1pTVVNPZUZZUzBwQnlEM2dJ?=
 =?utf-8?B?NXBxb1Z1bWVxSFBvcDN1YVphQ2RlR3VvSnY5ZXRQY0FMY3R3MStQT1Z2K3Ju?=
 =?utf-8?B?dDBXL1gxVnZvOEgvb0JlK01IZ0ZxKzJnY3RuNFBjMUJrLytUcW8rL0swSEVy?=
 =?utf-8?Q?J94QiInaD7WOof1ZrQffiMIZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7aff18-18dc-4679-a8e4-08dcef68f913
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:35:31.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCsxlI16mOKqoL+nasHRU2Rd5bYc/tX+iaRdvkoY8vh+lmdFZWNzfm3qJ9qx6m5qX4i3O6rCAOa9+KHFNLsskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

Hi Sean,

Thanks for reviewing my patches.

On 10/15/2024 11:19 PM, Sean Christopherson wrote:
> On Fri, Oct 04, 2024, Manali Shukla wrote:
>> When a VMRUN instruction is executed, the bus lock threshold count is
>> loaded into an internal count register. Before the processor executes
>> a bus lock in the guest, it checks the value of this register:
>>
>>  - If the value is greater than '0', the processor successfully
>>    executes the bus lock and decrements the count.
>>
>>  - If the value is '0', the bus lock is not executed, and a #VMEXIT to
>>    the VMM is taken.
>>
>> The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
>> code A5h, SVM_EXIT_BUS_LOCK.
> 
> I vote to split this into two patches: one to add the architectural collateral,
> with the above as the changelog, and a second to actually implement support in
> KVM.  Having the above background is useful, but it makes it quite hard to find
> information on the KVM design and implementation.
>  

Sure. I will split it into 2 patches.

>> This implementation is set up to intercept every guest bus lock.
> 
> "This implementation" is a variation on "This patch".  Drop it, and simply state
> what the patch is doing.
> 
>> initial value of the Bus Lock Threshold counter is '0' in the VMCB, so
>> the very first bus lock will exit, set the Bus Lock Threshold counter
>> to '1' (so that the offending instruction can make forward progress)
>> but then the value is at '0' again so the next bus lock will exit.
>>
>> The generated SVM_EXIT_BUS_LOCK in kvm will exit to user space by
> 
> s/kvm/KVM
> 
> And again, the tone is wrong.
> 
> Something is what I would aim for:
> 
>   Add support for KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs with Bus Lock
>   Threshold, which is close enough to VMX's Bus Lock Detection VM-Exit to
>   allow reusing KVM_CAP_X86_BUS_LOCK_EXIT.
> 
>   The biggest difference between the two features is that Threshold is
>   fault-like, whereas Detection is trap-like.  To allow the guest to make
>   forward progress, Threshold provides a per-VMCB counter which is
>   decremented every time a bus lock occurs, and a VM-Exit is triggered if
>   and only if the counter is '0'.
> 
>   To provide Detection-like semantics, initialize the counter to '0', i.e.
>   exit on every bus lock, and when re-executing the guilty instruction, set
>   the counter to '1' to effectively step past the instruction.
> 
>   Note, in the unlikely scenario that re-executing the instruction doesn't
>   trigger a bus lock, e.g. because the guest has changed memory types or
>   patched the guilty instruction, the bus lock counter will be left at '1',
>   i.e. the guest will be able to do a bus lock on a different instruction.
>   In a perfect world, KVM would ensure the counter is '0' if the guest has
>   made forward progress, e.g. if RIP has changed.  But trying to close that
>   hole would incur non-trivial complexity, for marginal benefit; the intent
>   of KVM_CAP_X86_BUS_LOCK_EXIT is to allow userspace rate-limit bus locks,
>   not to allow for precise detection of problematic guest code.  And, it's
>   simply not feasible to fully close the hole, e.g. if an interrupt arrives
>   before the original instruction can re-execute, the guest could step past
>   a different bus lock.
> 
>> setting the KVM_RUN_BUS_LOCK flag in vcpu->run->flags, indicating to
>> the user space that a bus lock has been detected in the guest.
>>
>> Use the already available KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to
>> enable the feature. This feature is disabled by default, it can be
>> enabled explicitly from user space.
>>
>> More details about the Bus Lock Threshold feature can be found in AMD
>> APM [1].
> 
> ...
> 
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index d5314cb7dff4..ca1c42201894 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -669,6 +669,11 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>>  	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
>>  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>>  
>> +	/*
>> +	 * The bus lock threshold count should keep running across nested
>> +	 * transitions. Copy the buslock threshold count from vmcb01 to vmcb02.
> 
> No, it should be reset to '0'.  The bus lock can't have been on VMRUN, because KVM
> is emulating the VMRUN.  That leaves two possibilities: the bus lock happened in
> L1 on an instruction before VMRUN, or the bus lock happened in _an_ L2, before a
> nested VM-Exit to L1 occurred.
> 
> In the first case, the bus lock firmly happened on an instruction in the past.
> Even if vmcb01's counter is still '1', e.g. because the guilty instruction got
> patched, the vCPU has clearly made forward progress and so KVM should reset vmcb02's
> counter to '0'.
> 
> In the second case, KVM has no idea if L2 has made forward progress.  The only
> way to _try to_ detect if L2 has made forward progress would to be to track the
> counter on a per-vmcb12 basis, but even that is flawed because KVM doesn't have
> visibility into L1's management of L2.
>  
> I do think we may need to stash vmcb02's counter though.  E.g. if userspace rate-
> limits the vCPU, then it's entirely possible that L1's tick interrupt is pending
> by the time userspace re-runs the vCPU.  If KVM unconditionally clears the counter
> on VMRUN, then when L1 re-enters L2, the same instruction will trigger a VM-Exit
> and the entire cycle starts over.
> 
> Anything we do is going to be imperfect, but the best idea I can come up with is
> also relatively simple, especially in conjunction with my suggestion below.  If
> KVM tracks the RIP that triggered the bus lock, then on nested VM-Exit KVM can
> propagate that RIP into svm_nested_state as appropriate.  E.g.
> 
> 	if (vmcb02->control.bus_lock_counter &&
> 	    svm->bus_lock_rip == vmcb02->save.rip)
> 		svm->nested.bus_lock_rip = svm->bus_lock_rip;
> 	else
> 		svm->nested.bus_lock_rip = INVALID_GVA; /* or '0', as much as that bugs me */
> 
> and then on nested VMRUN
> 
> 	if (svm->nested.bus_lock_rip == vmcb02->save.rip) {
> 		vmcb02->control.bus_lock_counter = 1;
> 		svm->bus_lock_rip = svm->nested.bus_lock_rip;
> 	} else {
> 		vmcb02->control.bus_lock_counter = 0;
> 	}
> 
> 	svm->nested.bus_lock_rip = INVALID_GVA;
> 
> Again, it's imperfect, e.g. if L1 happens to run a different vCPU at the same
> RIP, then KVM will allow a bus lock for the wrong vCPU.  But the odds of that
> happening are absurdly low unless L1 is deliberately doing weird things, and so
> I don't think
> 
>> +	 */
>> +	vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
>>  	/* Done at vmrun: asid.  */
>>  
>>  	/* Also overwritten later if necessary.  */
>> @@ -1035,6 +1040,11 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>>  
>>  	}
>>  
>> +	/*
>> +	 * The bus lock threshold count should keep running across nested
>> +	 * transitions. Copy the buslock threshold count from vmcb02 to vmcb01.
>> +	 */
>> +	vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
> 
> KVM should definitely reset the counter to '0' on a nested VM-Exit, because L1
> can't be interrupted by L2, i.e. there is zero chance that KVM needs to allow a
> bus lock in L1 to ensure L1 makes forward progress.
> 
>>  	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
>>  
>>  	svm_switch_vmcb(svm, &svm->vmcb01);
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 9df3e1e5ae81..0d0407f1ee6a 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1372,6 +1372,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>>  		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
>>  	}
>>  
>> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
>> +		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
>> +
>>  	if (sev_guest(vcpu->kvm))
>>  		sev_init_vmcb(svm);
>>  
>> @@ -3286,6 +3289,24 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
>>  	return kvm_handle_invpcid(vcpu, type, gva);
>>  }
>>  
>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +
>> +	/*
>> +	 * Reload the counter with value greater than '0'.
> 
> The value quite obviously must be exactly '1', not simply greater than '0.  I also
> think this is the wrong place to set the counter.  Rather than set the counter at
> the time of exit, KVM should implement a vcpu->arch.complete_userspace_io callback
> and set the counter to '1' if and only if RIP (or LIP, but I have no objection to
> keeping things simple) is unchanged.  It's a bit of extra complexity, but it will
> make it super obvious why KVM is setting the counter to '1'.  And, if userspace
> wants to stuff state and move past the instruction, e.g. by emulating the guilty
> instruction, then KVM won't unnecessarily allow a bus lock in the guest.
> 
> And then the comment can be:
> 
> 	/*
> 	 * If userspace has NOT change RIP, then KVM's ABI is to let the guest
> 	 * execute the bus-locking instruction.  Set the bus lock counter to '1'
> 	 * to effectively step past the bus lock.
> 	 */
> 

Thank you for highlighting these scenarios (for nested guest and normal guests). 
I had not thought about them. I’m currently going through the comments
and trying to fully understand them. I’ll try out the suggested changes and
get back to you.

- Manali


>> +	 * The bus lock exit on SVM happens with RIP pointing to the guilty
>> +	 * instruction. So, reloading the value of bus_lock_counter to '0'
>> +	 * results into generating continuous bus lock exits.
>> +	 */
>> +	svm->vmcb->control.bus_lock_counter = 1;
>> +
>> +	return 0;
>> +}
>> +
>>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>>  	[SVM_EXIT_READ_CR3]			= cr_interception,
>> @@ -3353,6 +3374,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
>> +	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
>>  	[SVM_EXIT_NPF]				= npf_interception,
>>  	[SVM_EXIT_RSM]                          = rsm_interception,
>>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
>> @@ -5227,6 +5249,11 @@ static __init void svm_set_cpu_caps(void)
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>>  
>> +	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
>> +		pr_info("Bus Lock Threashold supported\n");
>> +		kvm_caps.has_bus_lock_exit = true;
>> +	}
>> +
>>  	/* CPUID 0x80000008 */
>>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>> -- 
>> 2.34.1
>>


