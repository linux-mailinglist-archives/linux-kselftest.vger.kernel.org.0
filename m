Return-Path: <linux-kselftest+bounces-11784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AAD9059C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FC28535E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A9181D06;
	Wed, 12 Jun 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tx3bVMTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BC17FAC4;
	Wed, 12 Jun 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212854; cv=fail; b=Xdy86E0I1E7+r2ZiZPfninuFfcXAI9WkZx8k5gceP+tdtHUJnjEPSPe/wnsweMZAG2GY3/Li7LlzJUDYX6/bFIMI9XXW3gd17WytD56ZnvuIECy1CFHfUMT+kNrEo/PTSjdw2H99TeQcIhZes3+oMXKvwhNKY9TL4h0/aw7/GXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212854; c=relaxed/simple;
	bh=7pzY/my+mBAZXr/Qe7fYdEdpk90hH7953OvqvVWzr/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VEUXU8SAR3HpkU4/2xBP9IpGQPwo0Bk4KtpEgXwVT/a4nJt12f04QdjuAyCFY0jaDUmrzKpgsxb2dGeSe/82gSpncADrP4rpgsj00zdNQt3gkoDx0CyNxzXZq7ANtJTMu223Ey4Lk4TL/E2m2JeWuFGS9HP1IKUy5rZFVjAVpXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tx3bVMTT; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVkw+4ME2i0z91QikBdjXwWojItbVyrzXhXTg5g+izk74Ej/mugFkZUvZxBr2GONDOyjaWu4gWwcgOvg79d2Ya2zRV3KbkDWtixhVqGi0n491xX9+qwpLjFQGzAOmanJbI9uLrHLkRU2ddfHvsvRNkHyUBhuQxzv1jIUrQgh7hcQgpPxyhKnXTisBOB8j4z2tHn0eFMUTf4epK9FoakB+G60xRTrQEd9wYR8shygH2QdKqiCNh+AvYitTHBMwm87duwxlwVN6ikIHzkbfntfqhoVHH8wnb8Ezx6f4ih6khNVBj2CRbyQ2HWAnaPwhz8Z+C0k+IzHmOy9MmWXpg87cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pzY/my+mBAZXr/Qe7fYdEdpk90hH7953OvqvVWzr/c=;
 b=eGiIqLyybDM3roKq3QHODwK7M4kU+/u112TUEGpj7inHDRSOTYSKZx/m46TI4u+BvjLDcbFUXSt6T5NCJN7dTutUq4nKNTChgPi978HvOiHAUSYFWsHW6tnR7Ezkd/ay2BCcGToMDX70DJ5kBzRMGmt4Tax8OLts8o2o7jmFbybfMWekI/S3gzsW9ZsYoP021+YxxZfgzsUrd7fVMW/yAdV0oBYRpkNOoS+NqOcLV5opQh1DND19sW0qlaKQDrR00u7KvzOcnmgEVwZ3cKRX5m5vT2pfjFpoo+AjkHUOw8Gnf+MKZEy0GgBQ9WH7DlynfpaFQ8qHD1+bwA8hDCJUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pzY/my+mBAZXr/Qe7fYdEdpk90hH7953OvqvVWzr/c=;
 b=Tx3bVMTTQH9Tg8UK3KwH2ouEt0q4WzwRbB1s580h+SMvbYFOFeAblob28zC4uz9G/nmcwWx9ixpaZ1Podt//9uj9Ny7t3EC7tA0wXaG9Jsf6oadUHrcsL4q4JFh9sZpOrs8ZYa5KqOXWWzdG4yrgFMPf/KYNZZuyU+83yOgLssOpZX2mc8/3/22ic5jP9Tjjiigay7m140YBw/B+A9a6WQMffj3aQ1GJ8PPS8MDDd18UpOwSLR6r++pw3VD5GfVhhhbfI6vgjVbroha+tDa0CQy9WQMNRh5yS3svQ8IqTq+0LYStKSWoxqUVpsr3uo7kVZ8+Whx7iHzeoo7Im33Jsw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 17:20:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 17:20:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "davidgow@google.com"
	<davidgow@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "venkat88@linux.vnet.ibm.com"
	<venkat88@linux.vnet.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: fix namespace removal list
Thread-Topic: [PATCH 2/2] nvme: fix namespace removal list
Thread-Index: AQHavOCNsjnOT3jBJUuDAH1ZDwg8O7HEX/oA
Date: Wed, 12 Jun 2024 17:20:48 +0000
Message-ID: <5cb2c809-bfa3-4389-8f60-ea0edf742724@nvidia.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <20240612155135.3060667-2-kbusch@meta.com>
In-Reply-To: <20240612155135.3060667-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8969:EE_
x-ms-office365-filtering-correlation-id: c78307ea-af1f-4628-fc48-08dc8b0400d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230034|376008|1800799018|366010|7416008|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1R6amRvSDJQZEVIN25iaFA1Qk1YUDJmTlE1TS9ubTIvWWp6ZWphNk1zL2Nl?=
 =?utf-8?B?MGdVQWhRZHdXMEwzYmx2c3dkdHcrYlFMNU9mUmFWMTFiUXV0dyt5MTlBdG11?=
 =?utf-8?B?RStXTXgxYWkvN01lNnlGVjJyWUZ2Z0hOK2tOZXA4alRNbzVVZUlzSk5Wejg5?=
 =?utf-8?B?bEV1dDRKYkFRS3RVcmpqR0RsMjdheGVDcXdpV3FibVJrY2lFcExVeUkvSkpI?=
 =?utf-8?B?MkFYdkFzT2QvNXhodnlNRHY1R3NGTzNYMUo1eTFnZ1NDSlJsdVZDMEZYVnBN?=
 =?utf-8?B?WmlwSTYrNFVaSzBLSk4rKzZTTTZGM2pQci9tTkpIYXd2S0paeW1kVFRya3pr?=
 =?utf-8?B?bFZUQkhLRHgxN2IwenVVWC9iOFNOY3FxOWFpN2NyQklvMmdMdkdTeG9HZHZo?=
 =?utf-8?B?NG5Rak4xaXNSWnMxNnFGdStjYjF3aHIxUThSTnhXUTlDRUN0ZXZ3UUZiWkZK?=
 =?utf-8?B?dm9lZkt2QlNBWE51VkF0UFdpcFVYeFRlOEpFbkdPMEthVDdtM1BFdk4yaW1H?=
 =?utf-8?B?V3dKWXBOS0RUb1R0ZW5JWGVrQndZNE1ncXZmV1YrbVEwQml0cXQ2UVhVVmdo?=
 =?utf-8?B?U2Ivc1Jpc1krVi9HN2poc2lDcGdzOWRpWW9aRVU1Z2tHcTZlaUhibDNEbmll?=
 =?utf-8?B?dEZnbktDTmpjWkRkcXFlcm1wbFFWeHRjVDFndEFRSjJIVEExNXYvbkdpczUy?=
 =?utf-8?B?d21WMXYzTW9zcDVadnZHR0pFSThta3NvV3ozQnU5RHl1U3NOYVA0WkRmbkxj?=
 =?utf-8?B?cWExWjIxNlNLNGZub3hpWlpNeXo5UFQ0Q2dnYVRid1JzL0ZZdiswMkdLN2dQ?=
 =?utf-8?B?TGIySXdUMGtpdzgxcU9TeDBwbW94aFk5Tk82cTJ1RWZrcjB2a3FvbDJkQkdZ?=
 =?utf-8?B?ZlJRL3FCVG1WTmNWUmhBZEJYbzM5R29UeWxVeEZLYTRuNitIc21yQU10VW9V?=
 =?utf-8?B?TStRV3FzdGF2N0d0UXJQeHlKdGNGNlFWQklqVk1rZU1xWHcrejV6SmtmYkMv?=
 =?utf-8?B?cTJtNkxvSkVNRTVjOUZpc05CbWRucDZlT3lnS0tRL2N2WXdjMzJOTTZndkFF?=
 =?utf-8?B?cEpBR0pJUUZRMGFqNlVGTkt5N3ZZUkQ1bWF6cUxNby84eEF0ZS8yK3lDTlRE?=
 =?utf-8?B?MUN5emM3ZnNYOXhxb2ZyOU81L3oyaDkrbnBaR3k1bHloUDB2OVh3alFpQ3ZM?=
 =?utf-8?B?cEIzd3lLaVp1TE5nWGhNYWtKRkc0bVBRTlBIaGRmSTVEcnZzek5tVk1FRDA4?=
 =?utf-8?B?MGFRT3gwcEdXeXdIV24vWWZPWEFUQ1l0eEwxbC96YXVqbnBEclRqTDkyRUla?=
 =?utf-8?B?U0hmM3FWTytGUjBtdUs5S0l3UjJGZkp1ZHk1OGt4OG5YRzRtdHNDUHlRUGZ0?=
 =?utf-8?B?dERNZkxWUldiVW52eGtBK3Y3MmprU2RkYzFubnpZRlFXSnNROFVCTEFiL2Zu?=
 =?utf-8?B?aHo3R3o1dWtaMzhJc0lRUnhCZXpUWUcxSEtGQS8vaVFGNVE2aVIxZ0VOazB0?=
 =?utf-8?B?SkYyMUJUeE5yV0lwb1ZwU1pNcVJKK25HeGJKMkJHdVhzLzRmRFJRZThYZkpX?=
 =?utf-8?B?Tmd6b2hzSW1rQ1dRZFZIY2Q0TUNXdUxTRGJIemY4QTY0Q25TVklZVDI5T0RE?=
 =?utf-8?B?eGtrMUY2TTNCQmpQYkhkQ0ZWSzdQYndHUVpZMjJTTDJXeForb1Z6eldvMHNj?=
 =?utf-8?B?UUtPZVBIMFdVUHJ5UHh2RDROQlpQeVJjSnB6cTkwM1FrSW1SOHpvVWRzckhC?=
 =?utf-8?B?YUVCQjAwejVjZTV6V3p0c2x4YzRyUklVcHNHL0M4d2dSdTVjeFArU3gwWTJ6?=
 =?utf-8?Q?fvb7kJjnrDWcgmj/en0vqYMJnoX0Q2XuAtJrU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFAzTFZ6NUhBMlZUdVluNEJSSEtDU0VTNDhwbEpWUGJRS2M0aXJyTWZFN2Fh?=
 =?utf-8?B?WnNWcGFwdW1rRE9mVzBNSWlGNW5qT3p2WGhoSnlobzREbm5kUTU3NEFmNU9S?=
 =?utf-8?B?NzBERmwxb20xNHIzZG1Kc0dOK2N6VXRCOUVybDJsMEc2bHdoNHZia3NSek1Z?=
 =?utf-8?B?NDI0ZWNLbGlzeE5aSzJMa3QvMjJqamRXNTIrdVVhdTU2bDRnZGpud2pud0dX?=
 =?utf-8?B?LzVObXlnSE1EMVZOdjB3TmdCaHcwbzlDNWRwR2ZoUDk3MlFReHNCQUpGZE80?=
 =?utf-8?B?RitNYWIxQktXRzhqUWhKbWQ0NVdUVXA5V0hHUjdHYVc2alZzc1dOSDZuVC9T?=
 =?utf-8?B?cXAzR2ZERW52VnplVmI2NVZrelpxd0dEKzJDNUtEcUNYRUFMTnp2ejl2cEtw?=
 =?utf-8?B?OS9JbHRENGlabEtGYy81Q1dreGQ4VjJCcElBMU5WTEMwbjJqZ1VTREJXT3d2?=
 =?utf-8?B?U2xjU0JnQ0docUJFQ05aN0ZYejVGY09DeDVFakJuZTNBdkRTTSsycTFYQk56?=
 =?utf-8?B?enk5WHBwMTlsdUJDeXA1NWZvdWNSQXkxc29lQURrRDJrRDZLdWlOZTdPMUMw?=
 =?utf-8?B?SzB4d2NsaFF2Z1M4YkF4OFFOcXI0RW0vcnM5cXFTaUl3TFZ0MVIzUE01K3Vz?=
 =?utf-8?B?M3IyQ3IxWnFlSW9tSVpxQlJwZmgraXhadW5nMW9jWURyUUl5TUs3UGJXNUQw?=
 =?utf-8?B?Rm55c1U2K0tsdnZKOEpVd3kyTzV0Z0JvMm5jOVJRWTQxdFBhcG44U2lmTFE0?=
 =?utf-8?B?M0RBN1pya2Vpb1N4M3ZSNGtDZ0ZRck5RMitPSzJLZjFGS2ExUU1GdlJnM2R2?=
 =?utf-8?B?bVVFc3B5cHAzZXFMQTVjRGJEdWpKS3BaOTVHRlh6NTZMck5PeVFCaldMeXlQ?=
 =?utf-8?B?bVR3OUFWcXRmNFlQYWM2KzVBMGF3b3hSaDYyRE9WWUFmK1NqL01EWkFGK3lQ?=
 =?utf-8?B?VDIwMG1hVkw3QWdXN2hPL1hJS2U5amJPUnhFYWF0NUtEa2p6cXpmRFExOHFQ?=
 =?utf-8?B?VUJidFRtUDZZVW41RDg4eG92NEk1MURqekxndDV5cnc1MkZBZ2xqVHVzbHE5?=
 =?utf-8?B?cEgzSkYxYzR1SmVQNjN6NHZqeUFWUS9zc1R4RmNBUnQxbHdLZit6MVd4SUQ4?=
 =?utf-8?B?bWE5Vm9nQ3luQ2pzcC9YcmdqdmlLSmUxdlA1SFJRTXZzKzc2b3hhK3d0a0FV?=
 =?utf-8?B?L3FWTWxPcDZsNGszZGVvR0JSZjR4bU1nUytNMC9qeFhRZGIwSnhaYXNUR016?=
 =?utf-8?B?bkZDTmVRTmlYQzJWOTc5K3NqMWlPQXF6cU0zMkoyQ1huTjBlM1RkRGpNNkky?=
 =?utf-8?B?cU5KcE4xbFUwaCt6Z1JyVG5xQU1TMGV2NkM0bklpQ05aU1hvYU1PQktqVjBZ?=
 =?utf-8?B?SWl6WkViTXBuQ3c1YllOUFloSWxkM1dLQk52RTlFT1pyUnRUQkI1em1HZ2ds?=
 =?utf-8?B?T3F1L2JEbytFYlo3QnlsQlJrR3FHVXZKelZYd2hkNzNOTnZ1aG4zMkFYVEpr?=
 =?utf-8?B?SlNQSk9NaVZZcVpIdnVBTG1RWkxFdHJYYjJ5RjBaNlllTEorazF0RGsvOGk0?=
 =?utf-8?B?TEhzbTdYcHVSKy9nL0JhdkpXSmhveXd4bFFxZHZQbzUxRUhHejQ1Y2FFczRy?=
 =?utf-8?B?aDBDWXd4aVF2V1RxRHFGV1hmL2ZZQjVrM0tKVm51NEpiTjBHWk9LaCtJSWRV?=
 =?utf-8?B?SzNuWVZJWnprbFI0dDRMR2FqdTF4Y3U0YWZVWElvN3M4NkxxUW5tTlRKdHR3?=
 =?utf-8?B?N3dRZlpzMy81YVFBQWltNTY3OWtXRjhZdnY1bmkybjQ5VlJNS3JPOUt6RVdl?=
 =?utf-8?B?aHh2OTFSSGZuZ2N2cTBUeStUQUZjY0pjTmk1WGwyam9MZkdpS3NlWVFmdWxU?=
 =?utf-8?B?bUwvMCtMTHdsTVJQODhxblVvbFpLdGdnRjdsRWV2MEh3Y2x6MkJUdzJ5dG9U?=
 =?utf-8?B?NGRqSjJ2UTRDemFqU1JIZU1yWWV1WktXZkszZmF2WGExeXczUFR5SWdsT1BU?=
 =?utf-8?B?SFM3bzk0NXlybkoyVTNPL0NxdzdRWmNqUmZoT3NhcURxT3Rid0RQWS9mbisw?=
 =?utf-8?B?NzZEMFhXczhYRHlRQ1VGbnBkTkY0QlU3QjNYQ3ZudW90S1dVaUNsMW1wSFJa?=
 =?utf-8?B?KysrVENsMlRmUnR0VE9mRnhnMWxWZVhmK042SUNhSDhqZDQ4bkduS1p6WXBZ?=
 =?utf-8?Q?DtpsgBhvrzs+/2nN8RCXp153Rautx7hMleLvA9SVbUqI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B10F5564506F374DA38C02A06055E6AD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78307ea-af1f-4628-fc48-08dc8b0400d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 17:20:48.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+n1htl6TEjqO43J9+oZ2J5E8xBLNWMKvJA+rq2KYS7IXN2Pil/TCLVF9qNMJgoeAKHnEHPrOHJrRAT8du7RZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

T24gNi8xMi8yNCAwODo1MSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGlzIGZ1bmN0aW9uIHdhbnRzIHRvIG1vdmUgYSBz
dWJzZXQgb2YgYSBsaXN0IGZyb20gYW4gZWxlbWVudCB0byB0aGUNCj4gZW5kIHRvIGFub3RoZXIg
bGlzdCwgc28gZG8gdGhhdCB3aXRoIHRoZSBuZXcgbGlzdF9jdXQgaGVscGVyIGluc3RlYWQgb2YN
Cj4gdXNpbmcgdGhlIHdyb25nIGxpc3Qgc3BsaWNlLg0KPg0KPiBGaXhlczogYmU2NDdlMmM3NmIy
N2Y0ICgibnZtZTogdXNlIHNyY3UgZm9yIGl0ZXJhdGluZyBuYW1lc3BhY2UgbGlzdCIpDQo+IFJl
cG9ydGVkLWJ5OiBWZW5rYXQgUmFvIEJhZ2Fsa290ZTx2ZW5rYXQ4OEBsaW51eC52bmV0LmlibS5j
b20+DQo+IFRlc3RlZC1ieTogVmVua2F0IFJhbyBCYWdhbGtvdGU8dmVua2F0ODhAbGludXgudm5l
dC5pYm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9y
Zz4NCg0Kbm90IGEgYmxvY2tlciwgYnV0IGl0J2QgYmUgcmVhbGx5IHVzZWZ1bCBpZiB3ZSBjYW4g
Z2V0IGEgYmxrdGVzdHMgZm9yIHRoaXMsDQpJJ3ZlIGFza2VkIE9QIHRvIHByb3ZpZGUgc3RlcHMg
YXQgbGVhc3QgLi4uDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

