Return-Path: <linux-kselftest+bounces-32522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7EFAACC79
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F61C0337B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8222857DB;
	Tue,  6 May 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mV1xolWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB421CC62;
	Tue,  6 May 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553655; cv=fail; b=fK20Grwlx03lYGwLZJ8vlTn/2M+ydbUy+8an78zKBP7diLzw83Hwv87tWQF9KWj6Wtq7E8Apa9ge1ntz+4K1gwUFZ76J00EmhUjV/BeWXyle5Qev0Utbk9Ad5/q+0d7xa9etGqx32Om73cmoZm/WkAR3uEqtOYjTdBhbDakUCD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553655; c=relaxed/simple;
	bh=ZmVJzv/v2X5/fYiErM6xaYbiso5JbEu1OKPUUUhMT5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBNKY6J3rzl4u7tSA1KgnppJEmm1JGY1SthbDTFUmQzKOs9f3y/KfWBqhULveNz2DzTePOzvrlQ94h+iywHxmow6+1ifYdESwo4MzfJYWu4GDIx1fmbkO8leeeyXzdexmLDsvdLuXiuhOUYDKAEQK5QR6e/sJv9BnZWm6C6grIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mV1xolWr; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhuY8cFw/WFkJTIa86JXSMPb/q/dq/hcv2V8UoFOrlNT4wvtGLnWTNGgy2u7kpRTfu9YrwQnvRogGcB4cLACCA5SjKc5il5mpF55CMaCuwyS9h+OHUxl/cQk2k6gynbNmaDks2s4FEMRttUqOEveyLeAD7FkI9vrjxNgSRz0TFGojyuwGUOsdH3vhETUvOqw/M9VepNjkU4XZo46e6RGY5O6tv2RpTvOZKEth4ei6T9UZFezNRjGOXnZykkLydfXYraRly6wqUtznSVAks1NGADhRsZjNQVn+CPK9LwKwvt7O2VGKbgv4BHWJ7+BAfSxrntq6euMX4x1F5OGIvsAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmVJzv/v2X5/fYiErM6xaYbiso5JbEu1OKPUUUhMT5w=;
 b=vNsb3KNocZ76ho4WdsyAF2us3Tfv0HYXn1qbgf39C3km56Nvvbdj+jWcVVHThWNJgj1eFeOSf3Z9j/qC7NlayTuaVqqApZodKbRb2H7or4pDUYzc+8DbMfYlXy6wr5oitfmhEu961xtEkZ2rP5ceQyd4KIhVYOm4QQ0vwDPVwWLkidlOBtnaX0Y4YGnOA/P/mYTv5ZF+8AKLUAYz0+ktUSXQxPyGeIANRERPlR2JbPLD8zEJ9T40lMjbm551K47yz3QiVezmWKvQCMGjjpzWEBDgAOwzDjn/44PzfzxjzHZPLDHu1udAMZ+eWo7t8mvmGK/9w9zLhaMoBEOKtFW/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmVJzv/v2X5/fYiErM6xaYbiso5JbEu1OKPUUUhMT5w=;
 b=mV1xolWrvLGW2jy/BfixyuNyu7+WD8Y+JktcaeD8Q8uzVopvqojUfLsiju2UxoRV/GJQb2mnbWCXeEZsCE1KpTuV0LWzXcz9mF4NuFXqvffp7+2traN+yr8HVgPcKmcc9rRihCXZiCMpwAwqsrSNLkzVGF5Nhn20C7Rc8ryXTgCP2kKrpZU/ZTcXHChTOpqhAttqf4+fms9HZl/YuqbZmuS9E1sPXMePspSM3rskSnqSp8aEHevwG/mEKfDQYEssTwNi51gmeBbD8Gd8W58fq6fyhjkzyLq591REHhTSNQvG1iQSt81HxeKkSAD8ErDfXIVc+ny/oOtpEhCT1UPOYA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 6 May
 2025 17:47:26 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 17:47:26 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Thread-Topic: [PATCH net] net: Lock lower level devices when updating features
Thread-Index: AQHbvpI68/ihdVxTiEiw4lpvBpBbzLPF1uyAgAAJx4A=
Date: Tue, 6 May 2025 17:47:26 +0000
Message-ID: <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
	 <aBpC9_SgUaAA2P0f@mini-arch>
In-Reply-To: <aBpC9_SgUaAA2P0f@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|DS5PPFA33D606F8:EE_
x-ms-office365-filtering-correlation-id: 0f41ddd8-8780-4a3b-55e0-08dd8cc61063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cW1BQ3pkdmhSL1hRb1M5bnFoM05adUtORVdpQXo4N1NxeHZaaEhBNWxWdDRY?=
 =?utf-8?B?WkhxK2ZFdWhDeFU2cjRFUWhCckxRVkk3dkR2cWFOME00YndMMlJ4eEwxTUlu?=
 =?utf-8?B?cHZKMmpRZlFPclZvVDUxVnI3TTVMbkxXc3hPSVlKNHp5YnNxMElDQ1Q2c21x?=
 =?utf-8?B?REFSTDZRTEpIVWVqODRNQnhYbXNQYjNkeXFGUisvbmFnVGxJZHJBbHNhd0JE?=
 =?utf-8?B?RzgydjRDTVgzN3VFSGlRcnRIQTRVQlpRczdKbDVhTW82SXJYSm1OWnpFTlpL?=
 =?utf-8?B?c3dUbTB4UTJISTFGSVZqcEFHN0pFTjdXTnpibTIyZWNsVjdYSDVTN0xmYlFZ?=
 =?utf-8?B?blpJOG1xODJ3MC9PRTNXaXZ1Q3UzTWZUZzZIR1FjMnNjelhwWHFBY1ZJSHNI?=
 =?utf-8?B?MnNUUVAzRkhmQXRxNHlLaFp6YzlBWGJzNHBnOFdUTU9iUGVnTjlvVUh3S0dI?=
 =?utf-8?B?K2Nsa0RkWXpIalNEYXc1YjV5dktZdWNCVU9FNTdOZXM5dnc4dkxwd0xsVCs3?=
 =?utf-8?B?SnMvWUcwZ2hPazhYdk5ucVVtYndxOWRTQ1NneFQwcU9sdTZnemJpdGR6ekNQ?=
 =?utf-8?B?RXBCekFHZXltR1g4M3k3WTZtMFhQUmhaZ05kaDJNMkhhTzBraCs5U1RZZXl6?=
 =?utf-8?B?dE5zb0dpdFd2M3lybm14Qml6K0dydDZMVlNpaG9pcmxKRndXbmFlYzcrRkUy?=
 =?utf-8?B?T2RZMU92dEJyZmcxUUZkRmNDNHowVXUvYjRvZlpYNWFISSs2bjBBMWxYOEFv?=
 =?utf-8?B?RXFuUjMxSHFTZDI3RU0relBES2ZLYnpDL0pPNC9Qb3F2cU16bHRSRzJybVpE?=
 =?utf-8?B?VDlUTzR0RFRZZmdFaUFncUQ0QTI1cnFHM0tZZVFPZFppMStPc2c3QTVIZjc5?=
 =?utf-8?B?RmF3ZkdlWkNqNi9BRG4rWWtVazFUQXZCaC9abDNIbHFxVTFxYi95R1d4MzM4?=
 =?utf-8?B?T3RWWFZoaWwrRElpVHowaFpRRmZHdThEYW9KV2hjQTZJZ2RjM2hjQ1FJb25X?=
 =?utf-8?B?TlBLUUhXamNUNk01N2xLejhJUHQ1UEUxNkMwM3F4UTNyYmdXM1VqU1p3eHlX?=
 =?utf-8?B?eWdFTUprSTh5VUl1VkRFSDdWdXd6VW1ONlZjWndKTzFLNnRNaUcxQ01GQnNK?=
 =?utf-8?B?TjBZcld4WjZ2U1Z6L3BURm5TMk9MQWdueGJKc0VDRmdrMENYUnZPNEprS216?=
 =?utf-8?B?S3JqTXZZRkZzNXN1blplVXVzMVB0Qmx3ZFlETkR5TTIrRFI5dXVmaEtZRU1i?=
 =?utf-8?B?NGsrV2VVV1N0SEcvcVlob3NxclpaWER1U21ZNm9OZUJHZ3U5ckg5U0xTYkdk?=
 =?utf-8?B?TVo4SUxNMzB3aVZ2SjNITVRQNEMxcWY3OXg5VTFRVTg2VlB6QU1XcUxYTHhI?=
 =?utf-8?B?SGRwd25laWkwY0wxMFV0Ulp4THdJeUpWdmhwR2pKV2drUjBoZFFzQ0pCenZ3?=
 =?utf-8?B?TXp5aEpQU3BkSDJCRytDa1kydG1GOUVFNnNKRWhEZ1RrV0hCbnBzNzh0Wkg4?=
 =?utf-8?B?a21vNG5rQjU5M1ZqUlVITGRtZUpBRFBQMTNNK0JuMUljSDE3MzVsOGNNUGg4?=
 =?utf-8?B?RlhqMy9UNU05OG45QlE4SmRiYllsYU9ZMmNtLzJ4cE1ZMWNpOHV5YTR4NEZI?=
 =?utf-8?B?Q1dnRGJ0ZTJuUHk0NVp4N3NWVk02eGZJaW13ZUg2bVhoWEN5SkJpZHdSblBh?=
 =?utf-8?B?TUNUbHV3SStsSkcyelIvY3BKL2plNmV2V3BZeWJhalFnSzl5eDBkWVczM0lC?=
 =?utf-8?B?bm9RdWN6dTd1Q0hVbjFUTys4b2dleGQxUE1PeE5jd1BKWEFCWHMrUEY5TmZ2?=
 =?utf-8?B?ckNZcTdrcW82dEJjOHhmUHdPdnE0Sy9hcUN2S0psWUhWYlFBSURsZzQxek95?=
 =?utf-8?B?SWRnTUFaSGQ3VkthNzRFNEJLajlyNXI2RTU0VnNHOGZJclh3aGhSTmVMM2M0?=
 =?utf-8?B?LzZBaXdNNW9RN0ZXV09yZE1yREV0VGdUR2RnR1oxSEs3dlViUDRFbWdqT3h2?=
 =?utf-8?Q?jDPtRoLESzokjromPcs+dBF5Svphsg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWZnSUlSOEFUanJWUWs1ZW9RQnlSQWtHTm9mZkp5cEZsSXlHMWhNYU5aWFUv?=
 =?utf-8?B?bFFmREkyMlVJVHNuTEYxT3FGRWxQRitQSjBJMWZ6eFUzV1RoVEl3WEhvbktI?=
 =?utf-8?B?Qkl6M1ZZOUt4QjNnRWV6U21pZ21kdnBpeDhKR3F0T1RhQUJRSklvRjVyVGhG?=
 =?utf-8?B?bTFjUXpyWGlFSUV6dEIwTEZtTlNycXhSd3VYS3MvTDl3TXNBTjgxT3JVekZv?=
 =?utf-8?B?TjFHQVV0NnovbjN4NzA3eVBEbW1TNWNJVUtWdlVPaEE4ZHMvSnoxRHgvRS80?=
 =?utf-8?B?RDFxS1ovSUpna1ZFTEowOWdNRGZlK1hxWXU3T0VpTG55VUVlaEwzM0hvUURn?=
 =?utf-8?B?cEQ3ZHVtVjg4bks1TE9QSjk2UG10SkYvck1rNGZYcElOb3E3OW5lWHNDTDZP?=
 =?utf-8?B?blZZTHlUMExpRmtER0JNMGNSOHR4MG1hSHc3V3hDYVJEQnhEZEFSc3VMMXNB?=
 =?utf-8?B?UURpSlZpUU1PbWF4N0hYaU5WWW9uZGhhOFVIUXZIY2hsbGRZN2xyR3RYanND?=
 =?utf-8?B?d09jd0pLckNoWW9jalk1dXlHVGZHMmYxei9HMFo3dmtSaitzYkdPdFVXNFZI?=
 =?utf-8?B?Rzl2S3Y3WjJPZ3RGRGRjRHRlbFVvVERvRXAvc29ZWVBoNWxTNGdaSS94NExx?=
 =?utf-8?B?d3F1OTVVNHBXV0duOUFxcGJ5aDJjUDkveEVIbTVVbEJRZE5KTkxpSERlUnRl?=
 =?utf-8?B?aTJBL25oai9OaUI5emFOa1dPeDJ4SG9PVktVZUQ0UEZVK1c4RnF2MmJnclRz?=
 =?utf-8?B?TDJXbVJJc05lUG1DNE1BNVVZNnprRTJqKysraFdrb0dLR1ZtRW9XTzh6N0N1?=
 =?utf-8?B?TXZUbHdIcGpBeURxYTE3d3VDYXB5TkMyMzd1RXFIVS9tSHVkMWg3dm50ckh3?=
 =?utf-8?B?czIrZXh4M3ZXTER0T0U1dHVYRE83STR1TzJFMVFrTE0vVnRwNWxEaG0zelpM?=
 =?utf-8?B?L201eFI2cTNaWWhlYzZ6U3YzRVVYQmpuOUhYdXlXUnVOSlJtbFRyR0pwY2dQ?=
 =?utf-8?B?cHhDVU9JUmNnQzRkQ1FYcDNzb3JDd0Q4SnRtMVlDY3JzWjFjdTBqM3VTTGNL?=
 =?utf-8?B?WDM0QTEwRkFVTjdoL0JtOUxveE40Qi8zUWxnMFhIbkkxd3hRVnk4Y2xoNkdl?=
 =?utf-8?B?a3d6UGNxYWRxMU9SZlFUSmppOFVxRmJyQTgvK3dtM3YwcFZPVWZVKy9FZThr?=
 =?utf-8?B?aEt5UTQ5N0dOUXBOc0tLTExpNUxsQ2ZSZFRpa2tDcnIwZ2NuRjlCQlRZSjd5?=
 =?utf-8?B?K1JURFpUUjdvU3J3QVR3OUcxTGY5MktrTWlTR0FnUVFHbmFLL1BJS0FOQjJC?=
 =?utf-8?B?RFArN3RZQ0ZJbjdSNVpIMW9lcUEzbE8vK1h2MGJIb3NXMmppSTc4TVdBMnFk?=
 =?utf-8?B?MklYcnJIMDJUendyNko2emFyTDFpY3hUSGFuai80aU0zdjJUQXdvR0wvWmph?=
 =?utf-8?B?MlpwS2k2Vnd3RDc4Z2g5NzkrTThPeDVWYit0Rm5ENGo5aXRuY3BzMGQyVGdS?=
 =?utf-8?B?cTRnNHdINHBkUk5tNlFsaW9GMHp1MVB1UzFGdmo0RTN0ZFRsVkc5allkbWZQ?=
 =?utf-8?B?a3NZRGxUNDJTY09hSGNGNjJraWxoOUJRSTNPcGxyODJTWHhjbi9vV2pVeTlP?=
 =?utf-8?B?OEErd3llTEdYU0dGZjM1RUw5Zy9LZlI3NFV3RXNwUDlUTlBITDNmL2VWSzUz?=
 =?utf-8?B?c2tTS2lzbW90Nnp5VzJEZnM5M055Vzlwb1dLampHUzd2S0xpRlhzNWRBb2xG?=
 =?utf-8?B?UFl1TU1GZUN4V1BkMW53WUgwZUFmMGJnMTBNOXJSb01qK1NkT25ENlczTXpJ?=
 =?utf-8?B?RHVFY0ZyRjYzVW9QVmFEb2tUZitZRmxkTHhoNnBnZ2dSSGpmVUVvemVYWGhN?=
 =?utf-8?B?MnkrQ3ByVjNHMW9YSDlmZUNMbkg3UWorcmk4RzJUSDVTekd4LzM0ZSsybVRN?=
 =?utf-8?B?UWxqb3BNWFBHZHR3OUkxOFdnbkVFUjV1eS84NDUvZlpndTFNalZDU0hLL1NK?=
 =?utf-8?B?OGpSYmhlT1JIaSs4TkVUUkNVRFhNdVk3ZWNURUI5ejhOaGgxQ01JYVBES3Na?=
 =?utf-8?B?QmxTdzZwR0w3VUNZRUpld1BHRUFrU2xxYnlwZDVCeksrVTNkOGYrdlJqeWpm?=
 =?utf-8?Q?0Gdv9nszO3g3bneQULkyw6772?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3256564414C6C340ACB5369179264C20@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f41ddd8-8780-4a3b-55e0-08dd8cc61063
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 17:47:26.2550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQ6bgbxkkUshDgPnATaMFYbNZ4Lfn+pJHge6qvV6brYCSH7ia2QnHJHlux1nCJM7KFmV7Fb9AGWVHaveWP9Uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDEwOjEyIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA1LzA2LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gX19uZXRkZXZfdXBkYXRl
X2ZlYXR1cmVzKCkgZXhwZWN0cyB0aGUgbmV0ZGV2aWNlIHRvIGJlIG9wcy1sb2NrZWQsDQo+ID4g
YnV0DQo+ID4gaXQgZ2V0cyBjYWxsZWQgcmVjdXJzaXZlbHkgb24gdGhlIGxvd2VyIGxldmVsIG5l
dGRldmljZXMgdG8gc3luYw0KPiA+IHRoZWlyDQo+ID4gZmVhdHVyZXMsIGFuZCBub3RoaW5nIGxv
Y2tzIHRob3NlLg0KPiA+IA0KPiA+IFRoaXMgY29tbWl0IGZpeGVzIHRoYXQsIHdpdGggdGhlIGFz
c3VtcHRpb24gdGhhdCBpdCBzaG91bGRuJ3QgYmUNCj4gPiBwb3NzaWJsZQ0KPiA+IGZvciBib3Ro
IGhpZ2hlci1sZXZlbCBhbmQgbG92ZXItbGV2ZWwgbmV0ZGV2aWNlcyB0byByZXF1aXJlIHRoZQ0K
PiA+IGluc3RhbmNlDQo+ID4gbG9jaywgYmVjYXVzZSB0aGF0IHdvdWxkIGxlYWQgdG8gbG9jayBk
ZXBlbmRlbmN5IHdhcm5pbmdzLg0KPiA+IA0KPiA+IFdpdGhvdXQgdGhpcywgcGxheWluZyB3aXRo
IGhpZ2hlciBsZXZlbCAoZS5nLiB2eGxhbikgbmV0ZGV2aWNlcyBvbg0KPiA+IHRvcA0KPiA+IG9m
IG5ldGRldmljZXMgd2l0aCBpbnN0YW5jZSBsb2NraW5nIGVuYWJsZWQgY2FuIHJ1biBpbnRvIGlz
c3VlczoNCj4gDQo+IE1lbnRpb25pbmcgdnhsYW4gaXMgYSBiaXQgY29uZnVzaW5nIGhlcmU7IGl0
IHNob3VsZG4ndCBsZXQgeW91IGZsaXANCj4gbHJvIChJDQo+IHRoaW5rKS4gV2hpY2ggdXBwZXIg
YXJlIHlvdSB0ZXN0aW5nIGFnYWluc3Q/DQoNCkl0IGlzIHZ4bGFuLCBidXQgTFJPIGlzIGp1c3Qg
YSByZWQgaGVycmluZyBpbiB0aGlzIGNhc2UsIA0KbWx4NWVfc2V0X2ZlYXR1cmVzIGNhbGxzIGV2
ZXJ5IGZlYXR1cmUgaGFuZGxlciBpbiB0dXJuLCBhbmQgdGhpcyBpcw0KanVzdCB0aGUgZXhhbXBs
ZSBJIHBpY2tlZCBmcm9tIHRoZSBzZWEgb2Ygc3RhY2sgdHJhY2VzLg0KDQo+IA0KPiBUcnlpbmcg
dG8gdW5kZXJzdGFuZCBpZiB3ZSBjYW4gY292ZXIgdGhpcyBjYXNlIGluIHRoZSBzZWxmdGVzdHMu
DQo+IG5ldGRldnNpbSBhbHNvIGRvZXNuJ3QgZXhwb3NlIEZfTFJPIGZlYXR1cmUuLi4gKHlldD8p
DQoNCkkgc2VlIHlvdSBmb3VuZCBhIHdheSB3aXRoIHRlYW1pbmcsIGJ1dCBJIHRoaW5rIGluIGVz
c2VuY2UgYSBzZXF1ZW5jZQ0Kb2YgY29tbWFuZHMgdGhhdCBtYWtlcyBfX25ldGRldl91cGRhdGVf
ZmVhdHVyZXMgY2FsbCBpdHNlbGYgcmVjdXJzaXZlbHkNCm9uY2Ugb24gdGhlIGxvd2VyIGRldiB3
aWxsIHRyaWdnZXIgdGhlIG5ldGRldl9vcHNfYXNzZXJ0X2xvY2tlZCBvbiB0aGUNCmxvd2VyIGRl
di4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQpDb3NtaW4uDQo=

