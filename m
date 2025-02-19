Return-Path: <linux-kselftest+bounces-26957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B056A3BE79
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D61895F86
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54061E520A;
	Wed, 19 Feb 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GtfQbXRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020104.outbound.protection.outlook.com [52.101.193.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B81E284C;
	Wed, 19 Feb 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969261; cv=fail; b=CDDEMTl+f/jhyOXjJM/JhghRqwLr9g1yB48MV3bU4s8qszcuS81xKm4QalHQCEJmIkteeE4/ZoHlE2S7ftLXB/yNGqBuElpX8QUVkghkMdcyYWCeJuJqocby7ufN08JD9FoI5q8XoUOGDnUEImBxfxM3AeETekZSrKwQ80wdi/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969261; c=relaxed/simple;
	bh=HHnB6ykZWhUxI66fNCko+nKXUUEeG9c0aDk+ot+Phdg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6qnjD0dx9XUOoiu0VOYPBcrIFjgX8aEaqCURnFQUyPlgu3Kuwn39Wv8tA1echxqqJnRZrLFAJCRoGnePOOkaAKKrMe5L4YtMqZKzYh1im/T9XJwvCFWyTg7cCS1rkvrxieOgZVm1F0xUcETUzH7a5wXnj0kvJpqJzTAnNtayNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GtfQbXRG; arc=fail smtp.client-ip=52.101.193.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot7wK0v39htRG8krWEjQ1/IcMuFsy3X+/BuHuqtgENIGkuY3QVVjydUNdUnpaYDADEE7UcBQlTfssEMIXB9o4s/uoe3RFblrNEEDsRwdFaXGxCDgNNVIEyMRJ4YcOQz/Ek3k9//4jL5Yom8jQk+8ztxlWnY3WA4U4Zmom4CRmJcX30YPq94ZFCkqsVfg55+6Hhm9uEjrnbGHlsHkP8jjnUrrL0hzPV+/xXnNyqyXu4/53QFPhgANnBqdpky07EdzaN2GfinazXwZ3xuOsEj/1Zt7mRuuwrcv7xeiHYLBjRZ6lI5cYScjD4dAuGIJVB3I7b4qpcEwqyO4QAofxcDCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbKaIHxho2feYh+C+9q1wXqZjtUj9B3WdPEoRvpon00=;
 b=Z86mCUWL9wtBVAbwZs+FlM/whWZ5Bfyp/c5e0CJh0ZHjO/FFZyfC/hT0zM6pkEGa8W3m1ogxtxyzEBdkrOQBtRFMH98BxTSCt1K+4DEGttQqjHvDYo7VHl2nRHlojTVsps3pNjHdlAVwVdSvFrH1LTnCgM7oz7YtAJNQDvpWhImIx4nHGbOFGmza1gSuKC/kHBb8tdkUUg0HDq/WAlb0GL0Y/YAxIYo3ghS+05zmaQi+0OIWkKRscifgerAUXvokPeNOFTmnsn3tlo83QJwLz+i97ENmfN/QxEAPlmzULEdAwGNJbSabekLH6SaDhq/8YudWyMk+OHRmUqRLvbyeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbKaIHxho2feYh+C+9q1wXqZjtUj9B3WdPEoRvpon00=;
 b=GtfQbXRGaQsfWcNi+PY/L5E3aR79ZL4q7s/uY2JI9b1i+w+d2P0lA18j1lxkmbkuFQwlQpOlNIhGWke84nyhyOB1LrSxxoR4OxzbD28OrtAbV7tOVcNr/++UhPR0gCBiOQYyKQe7ctUwo29sla46ipnQJODP1xGTm7Qrz+QgiKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH0PR01MB8165.prod.exchangelabs.com (2603:10b6:510:297::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Wed, 19 Feb 2025 12:47:34 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 12:47:34 +0000
Message-ID: <9bb48635-ce40-4710-8c43-be10ef217d9d@os.amperecomputing.com>
Date: Wed, 19 Feb 2025 18:17:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] KVM: arm64: nv: selftests: Add guest hypervisor
 test
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, darren@os.amperecomputing.com,
 scott@os.amperecomputing.com
References: <20250206164120.4045569-1-gankulkarni@os.amperecomputing.com>
 <20250206164120.4045569-2-gankulkarni@os.amperecomputing.com>
 <86o6zeu668.wl-maz@kernel.org>
 <9b4a8665-4fb8-42e7-b63f-d154ae75a4f0@os.amperecomputing.com>
 <86jza1ua7w.wl-maz@kernel.org>
 <5192ba8d-577a-4bd6-b8ee-7e3547f2c86b@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <5192ba8d-577a-4bd6-b8ee-7e3547f2c86b@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH0PR01MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 879ffa86-0664-4855-b2b6-08dd50e3950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0dsQjhKOHBoWHYzTk5Ga0tHakZ4dGlqNUV4cUpXRTFOZ2RhQ2x2YTBjTkI0?=
 =?utf-8?B?WUZyTW5EU3lGVldKOEp6anlQb05Ud2JRNENaVzZPZ3JRMmluTllIenpnbndp?=
 =?utf-8?B?M3BqaGRDR0w1T3FJRS8vblRvb2Q0ZzF6dTdwK3ZoK3JmcUxHU2ZXZjVSYlpN?=
 =?utf-8?B?ckMvRjV2Z3FvdzZpZWR2aXd6TkY4YTRZbVJxblJmbGhzTFAyeDVjdVJLUzYv?=
 =?utf-8?B?VTRGTnlocVZPZk5Ic2dQTThPalhacGVJUExoRnlmdkpTYVJsa3NIeWo4NUtw?=
 =?utf-8?B?MzU0YUkrS2dHeFM1cWNvNXJCbEVBdFFDVjltT3NLZW9qVkJPeklMTksvNDlX?=
 =?utf-8?B?M25EQzFNSHd3SWdIUjVndGdxUUdETDhRZFZvUEY5QlZqUWZJTVBLNmlTSVIy?=
 =?utf-8?B?L0t1d2ZHYzNlbFZZY2d5Y0Q5cFd1RTlzdG1tSDVpMUpQRCtNSlFLUzdWbkRj?=
 =?utf-8?B?UHpFNGdiL210RDFNUDZjdVJFeFdxRVRacE00T0JoT0VNdThoOGVtL1RUd0VX?=
 =?utf-8?B?K0NBVVl1WHoxY1dqTGdyTFJpU3VGTjI2d2drMW9KZzNOaXJia3JieEVuVWht?=
 =?utf-8?B?WFRSOTlCYUpKL05QKzdjbC9rVlFBOWQxRlBwN0JhQW4rWjAyTmFrSkRKRGl6?=
 =?utf-8?B?SEpLNGs1NGFGSXh1YkFNejBlaEphMUY0dTl6QU1sdklvRUNCbngzSEN0OUJZ?=
 =?utf-8?B?NmFsT1hNMmx0Wnlva2hvT0x0K2xlLzJGTlp1WVRkb20xZ2dNWUFxUy9OWnJo?=
 =?utf-8?B?SzhCbUQxdWN4dGJGL1RvTDY2UzBFL3hPaTREaEN6VUFabXNaajdEcTdTT0FX?=
 =?utf-8?B?aUNhTDNNL1FnQmE4dEcvOEMzaDZGQ3BPRDRaU3ZFRWxLczU5UmZZWmRiV2t1?=
 =?utf-8?B?N2VyVnVLTkxpYU1wMURrUHFYQW5CZjVZVFdTUnA4NXJZT05PQzAyTmkrREV2?=
 =?utf-8?B?UlJlRWwzK0hGampBUDdMcTNSNUJOd0owWmF2bS85MzV0bStZSUZrRHFSTTRz?=
 =?utf-8?B?TlJEOUN0bDZMZVdkRDA0eFJ0NkdtekIranhGK3FHWTBWTkd4WHBNbHd3MEFz?=
 =?utf-8?B?WWUvUnYwSFhxVlMrM1hreFYwbndHdXNNZE1RdTFsZ21sSHBHaGR5ZWdnWU1x?=
 =?utf-8?B?aFBmUWdIZXJNMHRiQzF1SDhoS3J3dGZwN3VYcjNwc3lOMXlmbytIbHp3eE9t?=
 =?utf-8?B?L0o1QnJLY2RJcEhxVmdKNEphUHpYeDI3cDhtUUs2Q1NiWlFzOU9MV2t4VTRQ?=
 =?utf-8?B?VkhQRXBlbE9mV2t1b1VKN24yZEJqQnpMMk00YVM4eVRsZi91MkROK3VLZWF4?=
 =?utf-8?B?VlRwUFpDRDRYams2ampvR3E0TmlsK0pVU2kxNkg3cG85blhqQUJVTzdmR28v?=
 =?utf-8?B?dlpZZ1k5QmpBYlhxa0FyK0NHa1FNelFlSE1JaGVIVXFJbGMrblV2VmlNb2NR?=
 =?utf-8?B?WnlMemlLRjRnbi9xejJObGZFZFk2OUpqcll4UzB2WHlVZVJMZWpNRmMrcklM?=
 =?utf-8?B?VFFkdG1CeituMmYwOGZhMXZEWDlOdmYxSFAwb2xNaEp2ZkExQTdBZHlxTXhP?=
 =?utf-8?B?MGI5eXNlcUowSEgxMnV4c04yaUFxVmd3cWQvakd3VXRzb1lUdThmL2ZVRnkr?=
 =?utf-8?B?WGpTSml4MnA1VkhYNmN5L3FGUlJuWUlaS2FOdUlXRkZCNXNxeDdaRHhXdm1k?=
 =?utf-8?B?dmk3clIyQkJ3ODdjb21ESys4ZUR1c014eUNWcy9lU3dDRUN2TjR0cUFPNTJn?=
 =?utf-8?B?UlZpR1FWUkt6bWNna01tcDBnMi9JeVZpcDV6N2lDSzVaaWUyektxUU5TNmJQ?=
 =?utf-8?B?U0dnVGhIa3F1NVprc3pHRVJZemRlZENYcWlTajBhcmtDMnJWbit1MDVlUnd1?=
 =?utf-8?Q?0XZGb7+0DYIyS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVFDWFg5THIwaUdpSlY0cWFvMXJVUzBBdEtrOG1JcGxibC9PaWxaZ0ZFNUQ3?=
 =?utf-8?B?NGdJUlFrblpzYUpMeGRtNVYrb3NkQXd1bXJ4ZWl5Qlc3MTlzU1g1SGYyVFc2?=
 =?utf-8?B?REV1T2F3VGszbVFmbnRTaEtUTkJ0SkhVd05MQTU2cjFNYnNEb21SeUR2ZlJv?=
 =?utf-8?B?TkwzYXJtREo3Ykw0TzVtbzAvU3U3S0ZyNlEvQ2N5eUFuYW8ySndaanQ0WklJ?=
 =?utf-8?B?aVpBWVBzek9NOFN1ZDBWd1Rma2l0aE1WMWlZQnZDQW1LLzF0MXpHZC9EUzBK?=
 =?utf-8?B?YWNMVy9oMHJsNUh0aS9LVEd2MHdOaDhqUExEUitsL3pBOWM2Z0pBUHVzOVI5?=
 =?utf-8?B?RW1uMHpkV1I2S1lRZHdpUFBnanNFUXNCdXF6d2JFRHRMckZBUDVES3oydjJE?=
 =?utf-8?B?bDFQY1pna2RqazRBTlFsUXBubzIybXZQaTdobnhiTGExaFczeFc3b2NJRU5H?=
 =?utf-8?B?YUJSV0lCd0h3WlRLdWdtT3NvODBtN01yd256SUlVdVpSWDBHajdra3ZLQVl2?=
 =?utf-8?B?a0JqTkJSWUlCMVdFK3pSU09kaWMrYjVkOERrWDJXU1UyY2svSFhoVXBQTndq?=
 =?utf-8?B?bFdHUlJXNjcwZ2NncFRWK0tGYitVTmRPNkJjVklxVHY0ZDhGS1VNcWxxRmZ0?=
 =?utf-8?B?MzJZT1JWdFZDaTdRSm9jQVJ1K2xyVGszNVNaY3BnSFBQQ2NZb3NRSUZUUWNn?=
 =?utf-8?B?RDlhek5oQ3RneHQrRkVqZmgzeVpVZzJEYjdxQm10KzZ4VUtuZHc3SEpSTzlK?=
 =?utf-8?B?WjFlQlNZOVF5Ync2OHJBS2pqOFFCQTZXN3l3N1RGMDJVY3RJSmpJTldBTnFY?=
 =?utf-8?B?Q0wvSnNNOGlaOGFQaWJ4cUtNMjdWTmdlUjFhRVZ2N3lvRUIzYWxvTFB3STFt?=
 =?utf-8?B?WEU1S2NzTVBtTVlMbXkvSFovalV2dGlkS2QvcnJ3UTRVZmNHd0NaNzN3SmtN?=
 =?utf-8?B?RU85UEQxWHhHYkJHbnlqeHNpRUJxSGNVTkVZd3haakMyN3pQTFlRTmJBZm8w?=
 =?utf-8?B?NHIvODh1cWVWb3I3WTRKTGt6NmRXM1lZRVk1TWlpMGZIZlo2YkMydlptTEtm?=
 =?utf-8?B?MC9uME9LRE1ib0U0MkxtUXVPSjE1YnVmclNmbzB3SzlHeG92SEVQcms3ZzV6?=
 =?utf-8?B?d1VLalZZUGNJVFFmbTJFTjQvczkvdlRjL01WVjlSMldIM3BsRW15SmxxUi9M?=
 =?utf-8?B?ODdFamdzMDdrQ3pZYUtRTGdSK0V4U3I3NG03V1llTXpuWUNPbnhmRCszQU00?=
 =?utf-8?B?dXhzTFRZbWs4NEp6NTRWUmhnSjJMYzV2RmV0d3drVlhLdTRCb1IycDBUSkFL?=
 =?utf-8?B?b1A5amt1T2RRUHJBU21tM0p2Zkp3NWMxNTVyNG42Q01JMXRBNDRQKzA1VTlp?=
 =?utf-8?B?NzI3dGpVbE1sWWdyUk16SllvZEJ5TFdVVXM3aHAyV1hHSzFwOTZDeHFzU2Jp?=
 =?utf-8?B?ZWNURjJsLzlLQVRSN2Vpd0NKNlFWRW5qRThqQ0JzRGd6QjBoNTNhaTFONkk1?=
 =?utf-8?B?bWRxTHVSaDQ2bkg1K3F6Vnh1L01xVGh3MUVnOVZLV2JhQzNPRWo0ZXZraXIw?=
 =?utf-8?B?WHBVd3E0VHZlQUpXbEladm5kaGdCQ2NvY0NISTdqb081ZzhTaHZZd1R4MXAy?=
 =?utf-8?B?UWd2ZHdzcmhySG1NOGRhR3hDOUkwcW1YSUZ4Ui9mR2RYOEV0eGJMc3RiMCtr?=
 =?utf-8?B?YzlYNHJKRXJPeWpUM0pkUjc2cDFSbmpTcWtOMER4TUtvL0xIMmhMbW4xV0to?=
 =?utf-8?B?eU8rVHhOZVBFQk9kQWRWV0d2d3hQK250dE55MDZIb2pOS2laQm1wdjFwRGxs?=
 =?utf-8?B?UTJkZWRMUlprWWZWNytENHBhblk4L1NESWluWlNxaVFzZ0tlUDdQWDFDNFFq?=
 =?utf-8?B?RnJ1ekxxVDAzZlAxZkltUThqY25yY0Y5bHhwMGoycUF4MU83TFZTVmFmK2VG?=
 =?utf-8?B?U2lzaU9YS1JCVnowTjBzbzUzbW1vUzBQcW9lSkdJamxDQTdsREpWcGRVTmlh?=
 =?utf-8?B?M1pzVU5lelR2TFhLeG8vYjR2bTlYdVAyZGpUellzank1OEd4alAxSXN6RGwz?=
 =?utf-8?B?WDhSc1U1cHY5L3FiOXloRGYyanVsaldWU1Z4aFVVUHlHMkpqTVJoSVp4UzhO?=
 =?utf-8?B?aEhOV09LTXFranZwSmJZejlhV3M4TFU2N0d0YWZtWmVVRHRZU1lMSGxBUk1h?=
 =?utf-8?Q?LnYqc0R9S+TqrC6eT2LHxxspg6XRvcOpnQwq09FvgMph?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879ffa86-0664-4855-b2b6-08dd50e3950b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:47:34.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr5/rqtnIoqkD3q9hC+jS175o8ehgttsJeU5Bn/f61oIPu9zn8ezQN3FZ2Pt8QS1QjbD7Z2jzSKJ5mHd1RWUzF38haeH0lBG+B5t3Lt4sHnHHY15AdQ5pYOHcj4z+Lzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8165



On 07-02-2025 10:16 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 07-02-2025 07:29 pm, Marc Zyngier wrote:
>> On Fri, 07 Feb 2025 13:26:41 +0000,
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>>>> +    if (is_vcpu_nested(vcpu)) {
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CPTR_EL2), fpen);
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_SCTLR_EL2), 
>>>>> sctlr_el1);
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TCR_EL2), tcr_el1);
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MAIR_EL2), 
>>>>> DEFAULT_MAIR_EL1);
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TTBR0_EL2), 
>>>>> ttbr0_el1);
>>>>> +        vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_TPIDR_EL2), vcpu- 
>>>>> >id);
>>>>
>>>> How about some of the basics such as HCR_EL2, MDCR_EL2? A bunch of
>>>> things there do have an impact on how the guest behaves, and relying
>>>> on defaults feels like a bad idea.
>>>
>>> Sure, I will try to have these registers also set to required value
>>> explicitly.
>>>
>>>>
>>>> This also assumes VHE, without trying to enforce it.
>>>
>>> Ok, I will try to set specific bits of HCR_EL2 to force it run in VHE.
>>>
>>>>
>>>> Finally, how to you plan to make all the existing tests run as EL2
>>>> guests if TPIDR_EL1 isn't populated with the expected value? Surely
>>>> you need to change the read side...
>>>

IIUC, we need not write to TPIDR_EL2, instead write always to TPIDR_EL1 
and in guest code(like function cpu_copy_el2regs in Linux kernel) copy 
TPIDR_EL1 value to TPIDR_EL2.

OR, Write to both TPIDR_EL1 and TPIDR_EL2 in the test code itself during 
vcpu setup.

-- 
Thanks,
Ganapat/GK


