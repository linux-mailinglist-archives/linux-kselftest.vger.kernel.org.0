Return-Path: <linux-kselftest+bounces-45804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D15C66480
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9EE83605E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7E2C2AA2;
	Mon, 17 Nov 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDHFB4Zy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449823BD05;
	Mon, 17 Nov 2025 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415363; cv=fail; b=U9XVNePFFRfpMmIaVH6sOjVs1Aofx0ISkthJJUge/DLKOcg+VPPcy3MDyp6ZC1pMa1qAsPhxiDQYhWFdzjT9U+QTj2LcfRDrCfrrr+GmsKN7dAsrvWITSBOMvqLtP2mQGB2/PQwVQYt0unhT/YwZRwptBQ6IihXU6IDX7stIyUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415363; c=relaxed/simple;
	bh=RhWZ2JFctGA4IhDKY5V3oaf3JsemAcHRBcGgiTcT4YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ7SDeOXgIejOtN46eyLwJ5L74Q2VuIW7KRHFMccr05ZnpbeuM3+NXo8cisU/WkLJmRW4/EPL+nvd4XKDHMdUFWh8JfmXT1CLc2qXp4RYqyl/bU67Nd6Pijc6gTBYzHEurxL8/Re9LsKZrbIor7UephrT4gcInnEgR9/26psBMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDHFB4Zy; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOinZUYRb9dkBeSabHnp3keEp37LbO3VW+GnsvskU3BNWVko73gu99riiIiwyKszH2h6hpgyOs50cPmku3y0nbFUr9r6nFqlcRvIdS29WJKfWxouwuewkZSDKd658S/f0su36fP4hoIyc9LrHn2U9fpwvYRPBvMCvjrW4DcMgjF8nmX2CCC4HfZE5VaL8VcifgoB7aTS25/i8LJ8MHMLA9UKZCdO6wVeAn4WcIH/QCSIANxbVHR5dE9KtkoBab48N24KYWs/XsOMQ3udgc7EUb7jMhb2ZwpXb2MHwzLr7ByCkbhKie1fHkBGkqd7wkwFK6Ex5+WvxtGaGWPtPu2i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zgju4LYFSctLsBmi5C+WK4H/VPxvd2PHFuLOVzWthA=;
 b=yOFEg83ngsAsC8uQPQIqcuzjiiVF0BV3IRcFtyhGmo6WN4o7T89PflFH74njpF3cjTOzCXP/KmtB7VHBgEQUsAwmf2ky90Q0WURvzii22XEDVCapHIl2jW+sYI0HnDDsMlghbuPTHoUGcN2owohDtpNtRW8lJ5hnVT+sfYaMJo9s2DBehQzH0SCKes4zM8xoRE4neXsigp9JnziWRo0eSXEPR73x12+ivKuj6wiXKzjqmPzoT+kC6l8GNdtmS+onU57NcQHVu9v89/CDuqWIKWNxZQz51F5JEhmAUKkV7VL5IopTL17VnSnD+zxa5MBEgS44BfZDCpVzgjM/jQkNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Zgju4LYFSctLsBmi5C+WK4H/VPxvd2PHFuLOVzWthA=;
 b=TDHFB4ZypP47IQ33GOevIxv+R37qSNdqzqGBEfikeADpUHex4zMCHf9P6xK7OxUNIcumUUHbGbmrG0ENkX5ndxtf2h3zJu1lL9YMPBzE9DuUp6pHrlNg3fs3tNlR811VJ3hwlHh6xGdJPcb1Fjiq95bBgvYwpSTKPVBY77Xz6XboSlenPhFem2htCtVqu70+4sqD0DxHhGpKJECFBUH2mruXYNUzhEs58WOWRmqtiHq0QsCU20VN/26FUQu7w/wxYg0380RrQild5v2atTxGH3lWaj9uQA1kMt03SflNgw2oEPSAkr6xn23Vz8EnuqxV5jKTM8gJCk+e8CVH0mga5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 21:35:55 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:35:55 +0000
Message-ID: <21173068-5b5c-443a-8362-b05df485681c@nvidia.com>
Date: Mon, 17 Nov 2025 13:35:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20251117080714.876978-1-ojeda@kernel.org>
 <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
 <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
 <CANiq72ki4nMTzTnLN2hH6XY_88=dsEYO8fxr=rUaDnxktPtarw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72ki4nMTzTnLN2hH6XY_88=dsEYO8fxr=rUaDnxktPtarw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e051bd-cad1-4746-8314-08de26214a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1NQMm1sbVAxKzRQZUpGNEVnaE1DSzdRdTA0OFMxcEhjVnY3RFNVZFRaZkpL?=
 =?utf-8?B?S244MVdPSzdaaVFtdDI1RCtsam16UXRsTmVXQWhtalJwWVVNSzZmeGJwZDdz?=
 =?utf-8?B?Y2VzWkNWVElzRzEyM21HYlp0alNtY001RnBYalZQQ0EzZUFSNHVqY21kaEtv?=
 =?utf-8?B?bWlwV3VsVHdMS1Q0NCtmZmtla2UxVjRzVndNelo4SGg2NFp4cTM5Q1pyT2d1?=
 =?utf-8?B?YXhoU1Nib2diTXNORkdxZ1dJQmxKUTdFM2t6OGJxazYvRDgzNmlSUUNEYVdK?=
 =?utf-8?B?cnRuQ3ZJSEtBUTB6bzViMEtrMENheWxMRmplQW9uL25KeVBiVnNORmUrUFll?=
 =?utf-8?B?RVBzajR4ak5yRDArdUgxTlNvOGF6aGdjYmFLNW5Wc2QzZ0c3Ly9ZWUp1RlNl?=
 =?utf-8?B?eElqbHNyZURCVG04T3RFczlDZjYrblhsT0hYSU9pdThHbFN4bEJGMjRTS1JH?=
 =?utf-8?B?akY5Y3Zmb29PMldNNTZqYVYrckpXcnU1UXh5ZEppdHVOSWtZU3Z0dVMzUkt4?=
 =?utf-8?B?UXIwVFdTQXpxNHBzZjRVZFhOdjR0dCtyWkxPeEpPOEhOSUNTTVdKQVVXa1RW?=
 =?utf-8?B?Z2RsVVZLaVRjMHd6OTdzMFRhQlFMa21zMG5RK3FTTjEzelVlQ2JxcXVoeEZI?=
 =?utf-8?B?bXNmUmtQdGYyc1h3V0pKcHR1eG1GdFVQemkvMmN4SkRYUW1rUVh0ZDhlc2tn?=
 =?utf-8?B?SnEyL0VFK0Qybi9DT0MyV0FlNUZMRE00VXdoanR6WWJ6aW1vWlNmQVU2K21K?=
 =?utf-8?B?S0czb3BFSlRzdUJyTWpsK0NTa2FwazRqSzdmSmMyaCtkUXJLd0lNdkpUK3hu?=
 =?utf-8?B?OSs1Z2ZyMTduYlE5bmdSTVBqY1QwWFVmdWtlSGh6L2phc24zbnFzbkV1Vitp?=
 =?utf-8?B?QytUL0JmRkMvR0E0eStoZGgrbUxnc01mWFVUY29SK1laMllNRnFCYmNBcGNC?=
 =?utf-8?B?eG5GbVZjdCtCZldqZXpBOFM2Y3hUN0k4Y0tsaGxKaUxGbHNna1QrYUVWN3NX?=
 =?utf-8?B?QWhzZnJNcVQ3L0RnZ0NLeWc3R1RCYkdZbUFGUDJZNXh6UUpmYmJ1OTgzTkJl?=
 =?utf-8?B?L2ZYUDZLSmIyU2Z4eFJBVnJDQWF2RW5wYlJENjRjMlljL1lqL0Z6SndPMEZm?=
 =?utf-8?B?U1pRZmQrUE9hVnRrVnRndkEvcFpLcUszVzJJS2NQT0MzcnVidEdvZEtuRHlh?=
 =?utf-8?B?a2JOU2xQTGdzejVsVlNCY3JycWVaREFNcEUyb3YwSFdJMTJLNWtNYXMvV0R2?=
 =?utf-8?B?Zy9DdUhpSjVpS2RqSG1jY0pDRFZ3N1NqaEtVNHY1Q3RKSFlYcmVpRi9NQTlC?=
 =?utf-8?B?NUhRNDRsSDlSaWNwTEpELzUrZ3R0c2dzaXRMUUFZdzRub0Nnb3o3bHdMT2pm?=
 =?utf-8?B?alFDOC96cjRqUjF1RHhTbklHMVByMHhVZ29WdTM5UDF5UFdSdFZrUFh0Q01O?=
 =?utf-8?B?ek9yQTJ4M1paQzZITUVyS2UwaHV6blduSTJnaml6MS9SNTQ2bHhYK2ZiSUI4?=
 =?utf-8?B?ejNLT2cxVncwbllQMW5MakkzU3RiQ1Y1ZWQ2UFBkZkFDUG1wTU5XU05RdVFK?=
 =?utf-8?B?dlROVUQrWmhSYngrek1PbGlIdHBOczRwQWw2REVTUzVwdlRwR3ZJOERyMnZB?=
 =?utf-8?B?SHZDY0ZmYTZIdFpHNXlDZHh4VHNqRk5rY3BZVS9FM0Vlc25CcGNBbUlwUFZm?=
 =?utf-8?B?YlROK1hlQ3k3NjJmdnlhQXhGbVkxVEM1UUFTQXB2OHl5cXR3aGFIM3VDcEk5?=
 =?utf-8?B?czJiSTROam5jMGl0VG02SnZSZlVwTU9EVW11R1E4VGI4V1ovOTZVaFc5SkRX?=
 =?utf-8?B?SmorMGlsbGlBU3kydGdzZXd3dlZTeHNjV0dOOXhNRHBrU2dLNk9EdjNSdXhr?=
 =?utf-8?B?OXJaVFl2OXZzdUNDN0o2NlhtQmU0MlJ0Zi8vL2V0ei8reVNOYzlpQkt3Z2V5?=
 =?utf-8?Q?qYoGhHEoMnva5R7LTz6oJI+f8nGtwypW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VHazdDYnZuM1hiRWJsZ2tJV0JsdEhYaVA1a0NtWHN5WlN0djJkOFRPcVhh?=
 =?utf-8?B?cHZnUEh1V0JVTm1JYWRFZFM5MXVmZ2lCK0tXYndIYi8wKzV3OTdZdUgyVzRG?=
 =?utf-8?B?bHpjdWVJUGFhckRuWTRKRkN6Z2pQU2l6MmlZZjNXTDVrMThCY2R0L3VMWTBD?=
 =?utf-8?B?M1dhdWMzZVNZWDIwamZHaXZBL2JHT0tGcXk3SEgvWnUrdU9qM1diVFFBOW56?=
 =?utf-8?B?NzZrSlNxNXNBaGNCVXE1cHZkTzJpejUrSXpNRHZ2SWNESngyVWlPVGRJQVVh?=
 =?utf-8?B?VnBYdlFPRXRGTTgzQjE3MjR5Q2xUNFY0UVpYcmxzeVh4TnI0bUowV1NyNU9z?=
 =?utf-8?B?UEx5WlZTcjVCRFFQT1hZVnhoWmdpRmZKcXloeHp0dDlqclJBNEdzbUJVMUZM?=
 =?utf-8?B?R1VNTHJzTE9CeUVtYzJtSFZWeTNTMEV0NmM3OEVmc3E5Q0JEK1pTb0ZTWWpj?=
 =?utf-8?B?dGttTUIweWV1a3FjNjBjMFE3QzdzTmpnVWZ6R0JITy9KTDN4b2dPa2NwRWhS?=
 =?utf-8?B?OFowZEdxVCtqZ0tPZEcyNjBsUkRULzdvQXo5cXpIQjZaTHYzaWtPT24wOXYx?=
 =?utf-8?B?STNrcDk3dzZUNWRtcGVWTi9oRTI5OXFMOWJxcHY2S3NRWVZ4L1NLRWw1VCt1?=
 =?utf-8?B?aWhQNmR1T2JzdnhIL0tPNEdocllsUGxOR0pRK2YvQWEvZlhwVTZTblVUcEgx?=
 =?utf-8?B?VTc2N1V0TTVNbEIrdEg3dTlBUS9aWk5idmFnNHdlLyt3cWFLdXNqQjlGYlEw?=
 =?utf-8?B?OG80NnkxdmpIVFF5SWVxWjlOTGlzYzZXZUQxRnhsaFdCU2ZCcUFnek5aNmt6?=
 =?utf-8?B?c2pXaURRdEl5cFZkSFNodXhGRDFZQkd1VCt6YVNvdEtBUW0zWE9PRlpIQVlz?=
 =?utf-8?B?c3MxRUJCSmFVSFNzMVNlb1gyc0krVWMxT2xuci9SaGRUNk1xNjhram5RbFhM?=
 =?utf-8?B?M1RrZHU0ZTl2ZG5tekdxbmRCRjhqbkVXWkdNQjcvY0pKb1RvR0lKd3grTXBD?=
 =?utf-8?B?WjM0L3dndW1nZEhrZXJJK0ZBZmJjekN5VkJyTmIvZVlNalJJYU9jYi82alZR?=
 =?utf-8?B?bmtiV1FTdExkTURJN3pNOHRZTlgyTnNUQWlQYjQwa3kzeTkrV1NHUWVHbFVX?=
 =?utf-8?B?SzJaME1PVXFwZXlCWkdSVUZtS1MzbWRMUTY3WXQ3SE9lZk9IcWVKbkpFemlj?=
 =?utf-8?B?R2JXeFlQOFNWdWlUY0FkMVBkbTZ3V0swaFBVNmw2YjRUN1VROFZ6R1QvNEEy?=
 =?utf-8?B?U3NQWU1WckpXaERDL0JvTkJYNW5Bc1ZKaGlVeko3UjBSMS9WbXVlNWVsY212?=
 =?utf-8?B?cDdWOENleG1UQ3NyZ1R5U29zaGkwYlJPQTdQQ2MyVzh4OFhMdDRuVzlHZWpD?=
 =?utf-8?B?RmVUVDNEVGUrNk1wdEl3ZFc0eWR3b1BScHEvaDM3SnhqNlg1UXM2bXMva0h0?=
 =?utf-8?B?ZEh4MUJ3UTZzZ1BkSEFKcmRxV0MydE9yRWJTU3psVndWZFNtcTIrcHdvbFlH?=
 =?utf-8?B?Q1U5dkJ1RERXSXA1VlRINHZpRFViSTlqOVpXTDZxZ3ZFV29uQ1l3bW12RXNk?=
 =?utf-8?B?bkswOHVpVkltS2xHRkdSVk1ybGtXQTBDbmZJeFE0UnZIczQzVyt5MVliQWpC?=
 =?utf-8?B?eGtMWmNlSWptb0JuYWhBNSt3Y0srenU0U29OTDJqUzdHcU5JVTRRcGkxT0wy?=
 =?utf-8?B?WG5LL1ordmtEVkNTUFQ2dGlFWGRYMW12aDlEREo2NVJnRVhtdlQ4TU9vTWR5?=
 =?utf-8?B?M1ExMGRrVi9OVDBkQUp3YlZYOGUrTFAvQjBxeFZrODNjbU4za05rVjdKejQ0?=
 =?utf-8?B?dnhxYkp6OWxJWFVyTGZtS3p1dUdzR3ladjlhWkFwcURVY1pySUh2dk5SNENX?=
 =?utf-8?B?OUk2T09POWlHZUNudkM0bG1BajNKcUFFb2NSU1NidFYxSWdLZHdMQ2RIWHA1?=
 =?utf-8?B?MytPM25TcVFRUVltcEZ5QkV1eEdUZVlzUmJ2OG05Z3pzbCtwR2labHY4ajBn?=
 =?utf-8?B?bklsZm1XSkNCa2dWYlBNN1BYWGxmZTVlOW4wditwRHlaQ28vVXFvZ3hqeHYz?=
 =?utf-8?B?WU5VNEtvWnVnb3pJK2F2VDg1UFJpM3dUcW16ZUpaWXZaUGVFVlNTWTk3bDlh?=
 =?utf-8?Q?UWqvTxsnyidYf3wU0ODaPvsRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e051bd-cad1-4746-8314-08de26214a21
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:35:55.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWRVSBy9S6Sr3BXZ+46ZWWcC8gsaDNrk/74xTgMSo4smjsgJKheO71+/TYGm8s7cekxx1b8eSJFa2qFYcbL4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

On 11/17/25 1:24 PM, Miguel Ojeda wrote:
> On Mon, Nov 17, 2025 at 10:13 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Is rust-next a rebasing branch? I was going to request a non-empty commit
>> body, in order to make it more immediately clear what this does. Something
>> like:
>>
>> The current set of disallowed names is inherited from clippy's defaults [1],
>> which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
>> which so far has no entries for disallowed names.
> 
> What do you mean by "non-empty commit body"? The commit has several
> short paragraphs and mentions the `foo` example (precisely to hint at
> what the lint does).
> 

Yikes, I misread one of the replies (way too quickly) and completely
missed the commit body, sorry for that.

thanks,
-- 
John Hubbard


