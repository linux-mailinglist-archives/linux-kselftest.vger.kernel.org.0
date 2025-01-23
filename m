Return-Path: <linux-kselftest+bounces-24996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4EA1A401
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF16163D89
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5C20F07A;
	Thu, 23 Jan 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jyR9FcEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5820F064;
	Thu, 23 Jan 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634507; cv=fail; b=kZ9z+IWr1Om4GWWIZy42MDIn/JCgJECBEUyUMA5f/qFnOqfCzom76NSn6QzOX+gH6B/T5+dalnDBe3/fPXiUot57NIQ7ZWWyqjiz7km4Xo+0kpa/iwS46Z3Mmz34z95QhhLykWPf+NYZBktHVcNsLm2S69p7v62n0Hvz1Aq2JiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634507; c=relaxed/simple;
	bh=CZjzJdROVVYimOdKhGpQyaTGp5RWdmdG9hD7ggw+DFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+TmLr1IAzJLyBqFa2yR436MHai+KtZBIZfPJ1q4DU0KWHx4Kvd5X9Wzke2xQZQzT+r5qrlyIk06mth08OK9Cn+Y8vCJosJF8X3T29ckhLPVpiU/yEk0377tKBAlADlVe2XZihjSwQFANCjBW2J8aWR/3clDs2gT7cSIT7flcHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jyR9FcEP; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+XvOks3tUc1hvyDdJ+Ijeq2tBoJA1gD8A2vIH2HM19Ecy86y3M6jwEiKNLHS8SMwebnWcTLRST9jJDML8Q6fZD4CluB7XkFmIc5nDSIFMqcJRXO2l71IXLXdBhz3YQ0+IHCUjL+ZuJgqWEJjxDjfahsOjQu3Sy+zGT9c9liodJLSefq5n1xGOcv5RclzZRMWLLTXWo5fS6hrKFdksL38IM+y8GBugd2PL4MTO3ggl6L+vFsRQpe4jcIegwR71ulxw868iSQcC78NLjR6QyyCO8+t6+nPJXaMi/2Uuy0cB5LygfEgFV/XGJZO5dLDTu9VD4wZjXbBfg4dkLafUnN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZjzJdROVVYimOdKhGpQyaTGp5RWdmdG9hD7ggw+DFQ=;
 b=PIJO6XwRDbWJJucGBMk3UiZS1cem4k9hgymcA8guswVNEbri9O4KRIyXLCFaxG1L3hW8tdODqa1aPFckgtUNJ51wTPML7ET64fV1zJFlgpZQkG/W7eEy9QVstSPg5V1/aQ3y1WwWpCRpRRHMxya2kqoGpEBEKe4yy7TjyHkBdvRs11sWzwX7TxFVJwph0dogWkBmJaaYT+vw8h0OujbKapzjvw1VENh+Kqu42RzD+C0tF5bN6+JRxH24A+Lego3FhKAkOWI9GFjWQxOcko5tMvordSTGWv4XbijRaHsd6aCkAntIq4nF6Il4X4hz7xQZd6WIqDKemW2RUD9HkugbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZjzJdROVVYimOdKhGpQyaTGp5RWdmdG9hD7ggw+DFQ=;
 b=jyR9FcEPQ7C4cqGLa8cQNmdOpIZxaVILUP4buXNnSJFQPnfNPNrF7z7eojGU0neuaQpjr0YQH/SkEot9b9otUROWYl144Yu6iw4CQDK9GjhxI3m914cxCvLLwkHfOxrq/IMw5AvHB/u1pg2+kq82vjy0wcYzn+2qYIufTmGAX9A1nEAIDYA7/4HYXntgnGRj/R8zcX9YznAO8zKAt6TYFqEUVNxONog+y6iQSMD+l2qxYqZrOG9ANHkPLqIqrywJ9HU2pQFvRwOTjbsfxZ2vdOxNDPhSi6D/LxDbWIB7xdFGmQvj+7jKmkjd/kHFjkjUctQJWD/5GoniaA8hgo7low==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Thu, 23 Jan 2025 12:15:02 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 12:15:02 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "liali@redhat.com"
	<liali@redhat.com>, "razor@blackwall.org" <razor@blackwall.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Topic: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Index: AQHbbNT/TlKnluHwVUefPV+xYgABi7MkRzCA
Date: Thu, 23 Jan 2025 12:15:01 +0000
Message-ID: <40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
References: <20250122135218.183578-1-liuhangbin@gmail.com>
In-Reply-To: <20250122135218.183578-1-liuhangbin@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SJ0PR12MB7067:EE_
x-ms-office365-filtering-correlation-id: 502e0980-5b23-4664-c43e-08dd3ba79022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzUzWk9DenBHOWJSanY2WEZLcVVGZ01vam9UUDNVdFk3MDRkd2IvMDRMcDUr?=
 =?utf-8?B?Y2ZqM0NLVCt3TzEvOHpGZGs5aUZKVnAwSThVT0lKRU5UaFpSOVFBRHA0QzIy?=
 =?utf-8?B?MXIwR0FKb3NxczNRd0xQTjhPRzE1YXMvOEkyQnFzZG1RZ1NzSGpsOFo2bFRS?=
 =?utf-8?B?QWdGQXEwcXJqSFRCUUx6NUxsVEZySDZnWkp4cXdYeDFyQVRVZzNaeGRXY283?=
 =?utf-8?B?ZHdHeXlFV2p3WFQyNW5OMVVjWnlFMzFwZHhTS0dRSWRGSy9JS0VoNC91SjFX?=
 =?utf-8?B?MUZBb0YxQ3FRS3IvcitTNHRGZkxFbDVrMldpVkRnQUM4aU10bTl0RDlGWmN3?=
 =?utf-8?B?Vlc4a3lrcHRLOG9hTVo2NjViSk9EMjBxT0FlQk10VENuUDRrOGtJdlo2dk53?=
 =?utf-8?B?T3RpRGNoOWUvdUNuVVFVVG1TY0ZMNUIvYkQ1VlE4WWR2TWxhalFpeS9ic0Jl?=
 =?utf-8?B?Q2x1WXdtQ3FjQTlkTGM1L08rVjk5bll3VExnczB3OUdQTTZSWHJXeEREUmF6?=
 =?utf-8?B?amxvanoxZWUweVV5N0xZVWI5R0p5Mmc3NmJUVEpQbG9zREVibXhRRzZ3T2xQ?=
 =?utf-8?B?b3ZOSEw0N05ncGFGYUo1NDFFeVhVY0VFM1dQSVZJQmVBR0JrNEdqbjBieEc3?=
 =?utf-8?B?MHZseFpFc2s1OGNSclFzVk1LdG1pc09LSy9PenZ0T0EyQ2MwdVRpeHBncE1p?=
 =?utf-8?B?eUg0TjVKb2xjQ2lLU0ZhNWxJVkRGQTVaVjE5NFBVOGxTYzVpWW9LOFNUSHZK?=
 =?utf-8?B?dmJiNDBOR3ZOTTFQL0N2SndlWk1jUU1HVzVXUTZoME9GOFNYNGIzdjg0Um0y?=
 =?utf-8?B?WEJIUGZwMVE3TTkvWFN5L1h2Z0JGTWFnb2JSQytQMXhZM0gvVm9zZndmbVR3?=
 =?utf-8?B?RXNjSVI4UmcvVXAvbDBmeGZkblZQSVRWQWFVd3psN3dXYWZMdVJNb1B2Rk11?=
 =?utf-8?B?VXRRN0FxMm1jblRKT21mSHdMMWJRQ25NOUN4QnhRUjBIMHVOM25CUWxaS1ha?=
 =?utf-8?B?Z0N6SFd6TXVTSG1aZi9rM016UGZINXo5dzNzUjdubVQ0cGpMdWdSLy83Tjl0?=
 =?utf-8?B?ZG55SzNGMURIcGp6d1dmd09MYmxTR2d5WmNBZG84UlZ2R3VWOGp6UGcvckNM?=
 =?utf-8?B?OFpTQWxuUmNwVlV6VzVINTVtd24xaW5zeHBtaTd6OFhGMllNbFFXeFVkajZh?=
 =?utf-8?B?MThieE9WRUhjWHh5N21lWFlRS3gyRE5oSlB5d2dIYXoyV202MDd1VHNwalZU?=
 =?utf-8?B?TVA1am9DZjdhTlJQeFRQcnB1MlI5dGg0M0Fva21OVG5vVEhjRkFncnFTZUsr?=
 =?utf-8?B?S0pqTy94MkdJVDBWdVBVUGJrM2hVYnlGWWVUWXlvay92WkVzUlZBdWp3ZHFZ?=
 =?utf-8?B?cGx3Y2hMa1MyMGg2UWxvNUhMWStpbFFrTEFRbUZFQ0pQdHJnQ0d2TTAvY0U2?=
 =?utf-8?B?eUszSGRuMXFpUXU1M2JJWXo1MklxZ0RPcm11bnBncm9YTjdHTzNxTi9hK21V?=
 =?utf-8?B?RHpreHBiTVd3dTlPSUI5WHVpR1Zqdjk3enJrOWV3blFCRndLNS91OTV2Vldp?=
 =?utf-8?B?N09QWGphTTJvSDBEeTZlT0VKaEs3Ty9wa2FNUndTelpDc216Sm9nTVdFdEVC?=
 =?utf-8?B?OVZ2NCtRQ09aL0Z6QWxnZnYyVGxvZlM1VzVRMi9pVFpEOWpPN2I1K2x2SzRG?=
 =?utf-8?B?MTd6MGdPMWtlWUd2dTZTS2x6MXNKOS9vM3FHRXVxbFBpdUd5U0t1aE9qNFho?=
 =?utf-8?B?aVJJMG5hQ2ZvdGhzLytjbmxTaC9MQzBlWXc0UkZWTVBpNGdKaU14Q2ZDUUJ1?=
 =?utf-8?B?Z3NKYUxReHV4dlk0RkJQWE44cVBQR25qR0U0L25aUzJoMkRIcVJJRWZnRERQ?=
 =?utf-8?B?UVpBaHFEZGE0WktDMDBaRkxSVEZjTFYxVm96OE12Wm00bnZWb0hpOXpqcjIx?=
 =?utf-8?Q?DAXrtfOtlB88vLIIQYT91KVy1IN4bwVP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVdRWnhBdWNiY1pLd3UrUURnVTFvRTAxZStZTkRNYzVINXlMYlI2Wk90K216?=
 =?utf-8?B?dmpHS3g5ck9tTml6clFiVTJiNkM1Tk9DeWlHRHArVzNsN21GZjdRSHA3R2c4?=
 =?utf-8?B?TW82WC9hMW1zVVNFOHM0cDAyRVJHT08wS2E4b0pheTRsRXJNZVFjclNIVHRZ?=
 =?utf-8?B?VkZCMnlibEV5cWV5TFVVSXpxbkVHVW1NMDdobGJCb0QvZUJSaVYxSGV0ci9E?=
 =?utf-8?B?UXk1TmJqUnVLZUxsc2JjWE9LRHMwMkNqVXVCZmt5aE1MQUpOTG93ME1OOTIw?=
 =?utf-8?B?azVPSlczOTNIN3dOeHY0cmtpcVhpRUZFYWdxYTUvY2UvZnp2czE5NGM2QU9k?=
 =?utf-8?B?ZE0zbW82ZDliZmNKdzNueU51bkpreVUrdGkrRjhSV3hjZzRMV1VkVmRQWGxw?=
 =?utf-8?B?ZFo4N1hvcVR2M21hUXBTSGtPRjZ0eHVQaFJTb0Z4VE4rNHY2Y200ZHkyWnll?=
 =?utf-8?B?L2RNSmNlNzF0ZlVTenNCcytwUndGYjd5UUVvM1phNkFWL2kxb1A4bHB2WHRT?=
 =?utf-8?B?S0FGSG1wWVNOT3hSUDB3NnZvWS9WRjIrUHdDSjljSWhkejc2Q09kQXZ3ODVL?=
 =?utf-8?B?eDBHaFoxOVYxVTdVNk03cFd3L2s0d3dyanR2V3lBaDJtaTRaOTBEN2E2UnZZ?=
 =?utf-8?B?eWxsRlJFSkdkbElRaEpFY1lvVjhONG9CMms2ZDBDQ0kvM0JEcDhDUDVmZE9i?=
 =?utf-8?B?ZjR2SVI0dlZ0RU1kdTkzQlMxNlhzZ09tMHVoUWVSbi9GbGR0eEVoaXNCK1hS?=
 =?utf-8?B?T21URmJRY2ZyNGFYT0RRcnJVNEJ1Rzd5QStWclEycWc2WTNPclBpRDJnVU0y?=
 =?utf-8?B?MGttN0NmWVpPY2NoWjhOVzRwWjNFWFlZM25GUFVSSTlhUW1uQU4yYS8zbXFu?=
 =?utf-8?B?SWtzcVRaTnQzQnhEcmJNKzYrU0R3UGIyZjFUMW84WlhuNWJZWUdWMTBHWGNl?=
 =?utf-8?B?bXUwUzZJTXRSYlNiRXhXNlZzU2N3WER2eDk2WUlEcVZpdllDUGJuNjR5ZWV4?=
 =?utf-8?B?U0Fad0RTUVlpOGt1Rm9RU3JGVHhERDVYRFY0US9ybTNYckNpdkZ2UnIvTXdk?=
 =?utf-8?B?RXdXZVBxeUhGU0lSc1hmWDROcUpYMkNRNjRqZGdsNTVyVENaSzd3cS95RTVj?=
 =?utf-8?B?eFZpenBEVkpFeWhSZzh1TWUvcTN3TThSUXBpUlFXUHNrZmVNY1c5dVVvK2xU?=
 =?utf-8?B?bDlRREJZVXEwTDY1bWdma1Z2aHRqa1BqWmdYR0NOMTlyV3UzTkNMUGxkRHpx?=
 =?utf-8?B?SGE2SEdMS2pSSzk3aW5tZDdXdzZEQ3FCbnk3ajFmaGZLVkJXTzRvaTFBNXMy?=
 =?utf-8?B?aExHb2UyNG9UeThma1h2SHN1OUp3UGRMdFpxZTZxa0dSTW1nRmNxNFhHK0Mw?=
 =?utf-8?B?YlROSzQxWnBSQlpzc0JZZC9JV2tmeHo4ck9LUlRjL2huaXpQUWlhYTB6Q3dj?=
 =?utf-8?B?ZHRyMmFLbktnZnZsWHUzbHlsWFZtaEw5cnFBQzdlcEltNDRReDAxRy9oUkNY?=
 =?utf-8?B?QWxJaitrN0xaanF4NUY0dWxEcEw4MkVHUEVrUmZocmQ3Snhmcno1UHRNUFFK?=
 =?utf-8?B?VXNpNmxIeEVWc01ZUjJEcVFkUDE2VWpNeWw2b21Cd0kzOUlhYzZ2KzN0b001?=
 =?utf-8?B?K3phTDlGMzZENzM1Y3RTbnRPVUJFVTVlcXZ6S0kzQ2liZnQxRTFOTGdrRDFL?=
 =?utf-8?B?ZlZQR2JrNEFidmVxTEhYaGkxUEFRVXZQNVZORVBWQjlFcUhCbExQTnNsV3pX?=
 =?utf-8?B?cDdMbGxhdk9ONzZ6dzlWN1BHdTQvNzBnQXBuU0pvSHhaVFlHVGJScFRIS214?=
 =?utf-8?B?c2lJMjdISS9KTVd2OGpwdm1FQzJoZmdLeS8zQzRLdFR5RVhPQ24vakV5V3Mz?=
 =?utf-8?B?SGgyMWY4MkJUeDV4TnhiSlNwSDJhSmJNM2lhYVVmUkxSNXY3YlpQdzlScGY0?=
 =?utf-8?B?eitVTFdpd3FWWVA5UVFQQkdlZjM2cnFPY0ptL1FwNWJVdGZrL09TQ0pvcERG?=
 =?utf-8?B?TUZMUGNaYURSaERET3R4RlR2NGlvb2xTRklZMGdxNzcybVFuenN5cFJuWFN6?=
 =?utf-8?B?RFZtb3k3RHFjaTAwOTI5akcrQlN1QVdybVJ1TUIzK092WFIvSTFFOVZwU3dr?=
 =?utf-8?Q?mB/hHAcc9WQ8JeQ0XsUZ2g9CY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09E7542A8AAAE242AC50EB6A9F455642@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 502e0980-5b23-4664-c43e-08dd3ba79022
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 12:15:01.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/355AtF4YWERLg3RSaRgOJp3fDLl9jpK/gA5T2wvbvRpGY0OQ3K79C0g/XH9gKRm/okgaM7fZNV5ZRLx1tHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

T24gV2VkLCAyMDI1LTAxLTIyIGF0IDEzOjUyICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
VGhlIGZpeGVkIGNvbW1pdCBhZGRzIE5FVElGX0ZfR1NPX0VTUCBiaXQgZm9yIGJvbmRpbmcNCj4g
Z3NvX3BhcnRpYWxfZmVhdHVyZXMuDQo+IEhvd2V2ZXIsIGlmIHdlIGRvbid0IHNldCB0aGUgZGV2
IE5FVElGX0ZfR1NPX1BBUlRJQUwgYml0LCB0aGUgbGF0ZXINCj4gbmV0ZGV2X2NoYW5nZV9mZWF0
dXJlcygpIC0+IG5ldGRldl9maXhfZmVhdHVyZXMoKSB3aWxsIHJlbW92ZSB0aGUNCj4gTkVUSUZf
Rl9HU09fRVNQIGJpdCBmcm9tIHRoZSBkZXYgZmVhdHVyZXMuIFRoaXMgY2F1c2VzIGV0aHRvb2wg
dG8NCj4gc2hvdw0KPiB0aGF0IHRoZSBib25kIGRvZXMgbm90IHN1cHBvcnQgdHgtZXNwLXNlZ21l
bnRhdGlvbi4gRm9yIGV4YW1wbGUNCj4gDQo+IMKgIyBldGh0b29sIC1rIGJvbmQwIHwgZ3JlcCBl
c3ANCj4gwqB0eC1lc3Atc2VnbWVudGF0aW9uOiBvZmYgW3JlcXVlc3RlZCBvbl0NCj4gwqBlc3At
aHctb2ZmbG9hZDogb24NCj4gwqBlc3AtdHgtY3N1bS1ody1vZmZsb2FkOiBvbg0KPiANCj4gQWRk
IHRoZSBORVRJRl9GX0dTT19QQVJUSUFMIGJpdCB0byBib25kIGRldiBmZWF0dXJlcyB3aGVuIHNl
dA0KPiBnc29fcGFydGlhbF9mZWF0dXJlcyB0byBmaXggdGhpcyBpc3N1ZS4NCj4gDQo+IEZpeGVz
OiA0ODYxMzMzYjQyMTcgKCJib25kaW5nOiBhZGQgRVNQIG9mZmxvYWQgZmVhdHVyZXMgd2hlbiBz
bGF2ZXMNCj4gc3VwcG9ydCIpDQo+IFJlcG9ydGVkLWJ5OiBMaWFuZyBMaSA8bGlhbGlAcmVkaGF0
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGFuZ2JpbiBMaXUgPGxpdWhhbmdiaW5AZ21haWwuY29t
Pg0KPiAtLS0NCj4gdjI6IHJlbW92ZSBORVRJRl9GX0dTT19QQVJUSUFMIGJpdCBpZiBub3Qgc2V0
IGdzb19wYXJ0aWFsX2ZlYXR1cmVzLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVlZGVkLCB0
byBhdm9pZCBoYXZpbmcgYm9uZF9jb21wdXRlX2ZlYXR1cmVzDQptb2RpZnkgYm9uZF9kZXYtPmZl
YXR1cmVzIGRpcmVjdGx5Lg0KQW5kIGluIGdlbmVyYWwsIEkgdGhpbmsgTkVUSUZfRl9HU09fUEFS
VElBTCBzaG91bGQgYmUgc2V0IGluIGJvbmRfc2V0dXANCm9uY2UgYW5kIGxlZnQgb24uDQoNCk5F
VElGX0ZfR1NPX1BBUlRJQUwgaXMgdXNlZCBpbiBfX3NrYl9nc29fc2VnbWVudCB0byBpbnZva2Ug
c2tiX2dzb19vaywNCndoaWNoIGNoZWNrcyBpZiBza2ItPmdzb190eXBlIGlzIGluIChmZWF0dXJl
cyAmIGdzb19wYXJ0aWFsX2ZlYXR1cmVzKS4NCklmIG5vdCwgaXQgbG9jYWxseSBkaXNhYmxlcyBO
RVRJRl9GX0dTT19QQVJUSUFMLiBMYXRlciwgc2tiX3NlZ21lbnQNCmRvZXMgYW5vdGhlciBjaGVj
ayBmb3Igc2tiX2dzb19vayBhbmQgc2tpcHMgc2VnbWVudGF0aW9uIGlmDQpORVRJRl9GX0dTT19Q
QVJUSUFMIGlzIGxvY2FsbHkgZGlzYWJsZWQuDQpTbyBhIHBhY2tldCB3aXRoIFNLQl9HU09fRVNQ
IHNlbnQgb24gYSBkZXZpY2Ugd2l0aCBvbmx5DQpORVRJRl9GX0dTT19QQVJUSUFMIGJ1dCBubyBO
RVRJRl9GX0dTT19FU1Agd2l0aCBiZWhhdmUgY29ycmVjdGx5Og0KX19za2JfZ3NvX3NlZ21lbnQg
d2lsbCBsb2NhbGx5IHJlbW92ZSBORVRJRl9GX0dTT19QQVJUSUFMIGFuZA0Kc2tiX3NlZ21lbnQg
d2lsbCBub3QgZG8gc2VnbWVudGF0aW9uLg0KDQoNCj4gVGhlIGlzc3VlIGlzIHJlcG9ydGVkIGlu
dGVybmFsbHksIHNvIHRoZXJlIGlzIG5vIENsb3NlcyB0YWcuDQo+IA0KPiBCVFcsIEkgc2F3IHNv
bWUgZHJpdmVycyBzZXQgTkVUSUZfRl9HU09fUEFSVElBTCBvbiBkZXYtPmZlYXR1cmVzLg0KPiBT
b21lDQo+IG90aGVyIGRyaXZlcnMgc2V0IE5FVElGX0ZfR1NPX1BBUlRJQUwgb24gZGV2LT5od19l
bmNfZmVhdHVyZXMuIEkNCj4gaGF2ZW4ndA0KPiBzZWUgYSBkb2MgYWJvdXQgd2hlcmUgd2Ugc2hv
dWxkIHNldC4gU28gSSBqdXN0IHNldCBpdCBvbiBkZXYtDQo+ID5mZWF0dXJlcy4NCg0KSXQgc2Vl
bXMgTkVUSUZfRl9HU09fUEFSVElBTCBpcyBuZWVkZWQgb24gYm90aCBmZWF0dXJlcyBhbmQNCmh3
X2VuY19mZWF0dXJlcywgb3RoZXJ3aXNlIHRyYWZmaWMgaXMgbm90IHNlZ21lbnRlZCBhbmQgcGVy
Zm9ybWFuY2UNCnN1ZmZlcnMuDQpuZXRpZl9za2JfZmVhdHVyZXMgcmV0dXJucyB0aGUgaW50ZXJz
ZWN0aW9uIG9mIGZlYXR1cmVzICYNCmh3X2VuY19mZWF0dXJlcywgYW5kIHRoYXQgaXMgdXNlZCB0
byBkcml2ZSBza2JfZ3NvX3NlZ21lbnQuIFRoZSBzYW1lDQphcHByb2FjaCAoZmVhdHVyZXMgJiBo
d19lbmNfZmVhdHVyZXMpIGlzIHRha2VuIGluIGEgZmV3IC5nc29fc2VnbWVudA0KY2FsbGJhY2tz
Lg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMgfCA3ICsrKysr
LS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gYi9k
cml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+IGluZGV4IDdiNzhjMmJhZGE4MS4uMDlk
NWE4NDMzZDg2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gQEAgLTE1OTgsMTAg
KzE1OTgsMTMgQEAgc3RhdGljIHZvaWQgYm9uZF9jb21wdXRlX2ZlYXR1cmVzKHN0cnVjdA0KPiBi
b25kaW5nICpib25kKQ0KPiDCoAl9DQo+IMKgCWJvbmRfZGV2LT5oYXJkX2hlYWRlcl9sZW4gPSBt
YXhfaGFyZF9oZWFkZXJfbGVuOw0KPiDCoA0KPiAtCWlmIChnc29fcGFydGlhbF9mZWF0dXJlcyAm
IE5FVElGX0ZfR1NPX0VTUCkNCj4gKwlpZiAoZ3NvX3BhcnRpYWxfZmVhdHVyZXMgJiBORVRJRl9G
X0dTT19FU1ApIHsNCj4gwqAJCWJvbmRfZGV2LT5nc29fcGFydGlhbF9mZWF0dXJlcyB8PSBORVRJ
Rl9GX0dTT19FU1A7DQo+IC0JZWxzZQ0KPiArCQlib25kX2Rldi0+ZmVhdHVyZXMgfD0gTkVUSUZf
Rl9HU09fUEFSVElBTDsNCj4gKwl9IGVsc2Ugew0KPiDCoAkJYm9uZF9kZXYtPmdzb19wYXJ0aWFs
X2ZlYXR1cmVzICY9IH5ORVRJRl9GX0dTT19FU1A7DQo+ICsJCWJvbmRfZGV2LT5mZWF0dXJlcyAm
PSB+TkVUSUZfRl9HU09fUEFSVElBTDsNCj4gKwl9DQo+IMKgDQo+IMKgZG9uZToNCj4gwqAJYm9u
ZF9kZXYtPnZsYW5fZmVhdHVyZXMgPSB2bGFuX2ZlYXR1cmVzOw0KDQo=

