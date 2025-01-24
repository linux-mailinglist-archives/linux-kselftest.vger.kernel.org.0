Return-Path: <linux-kselftest+bounces-25116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F524A1B9E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833697A4879
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350416F8E9;
	Fri, 24 Jan 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJsUgIbD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E115C120;
	Fri, 24 Jan 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734618; cv=fail; b=h8bmaKWcFvWmDEYxuZwAmUmW/eFbZ6wmhVncnWuWra3E6Nd8k6fg6rCNvUlONN7/zeBZFdvvUH2Ml+umMwklEpddXU8A1XlElii+/kJJy5rvTDRGbvm5J2NBm99ZtehweN8R0Ig/FvDB6bF0muQ86j8Z8f6trMADOQ2Tbt0KKHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734618; c=relaxed/simple;
	bh=VmXhlRbRvh2cfsBHgUTQ28CZTx4qHo7nqL1JZuSMXWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbzsXxw95WKebr7k69+lH1RnCKg04hzlQFwMEs1R3hIVv7r+A0pC1Q/dFJfcSYUM0yWEMxbEveOKFuZYQQC8Clu1SmCQZ8R2CB+txqxAvqyxUTbWeUd/v6PJaARe+f/lGsWYkKf6cDgtANT7YKvy9GzsdxGeA7UZi/HQXl+YXfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJsUgIbD; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeRAQFiMD5c64Plt7FkpDKX3q9Q/HTcjU3DlnNYVcjLl5YGxzizs3p5M2keM0KEgB4KaXjxCfwetJLTOCIRLugY2RGXAa1Ioe+SsKExFWT8advp35jja1KzAC28Cgcw5CSSvW1t9WdUtQ6IQic3yNpKssx0slkPyh8C3kHyQsv5P9PNoHXtskb0R2N4IFggH9e2rX7Y6TE5nit4aYlMMmxa8kK/Nas/loqYDBLOr2wAqgC452U7uJFf35DvrH2BV7UUR778G4a4wrZ0R7pH6UjtkXfPRMAtEn/OyPvU+tSWUaZkF9WUeU3mLGoqER3U08vCDxTPayf7x2Rtp4B2SkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmXhlRbRvh2cfsBHgUTQ28CZTx4qHo7nqL1JZuSMXWo=;
 b=BgJ3NGNELZYINn36TH0vbnrp/2+Amig2HIP88VmA+OrIQIwYzJsAobSzCSe5gEkCrHu7EKzuZg3dp78ln9UoZB9U1aIM4/P51DeATn2enL4jOfQOIaySWZqbXEVhcFA2Fcj2CAaIMxd6YQwh+0kA+IYR6MN73kAmYWgUVSgcBDS5N/hWQn404k1BCt2SNY6yAPIZuYs9EWpn4YWBCpBPvx6LTa6Ym/YhV32uLupxYkCVik3xd6Ia7wT+z1k7691QJVTcrrqQxXlvqzpXA8XOWK8S1LZObxgJ4jxX5S+a3X1smH9mKLXanKN2tt+SjVAmwLur/rUoq+MxFNrIleudfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmXhlRbRvh2cfsBHgUTQ28CZTx4qHo7nqL1JZuSMXWo=;
 b=RJsUgIbDCH7+rcNyN5DfdzTgHqXAVZEyePWzHkGRtUGkqDSWaO2J4UUTWmbJ03ZYSHdSyjCmUmMLPf7hm9kmCWht+kEqTRgE0pMotfsDvZtcvRclQP383FQYHLsWHN96sakW9s0ryS0ru2tuylu50VCCQ6uFD6+j7dY/KBWv95BS7tnUn+pm3RrarQUn8XcTwwYw6I6CUSbdx80xUKlEkSFwhVs6BF192PW9aw2V0G6GWYOBzuFLAXPnf/+HZIzPMDIEhQ5hRLAmY4BPLGUFCZEbSxEu/qvYCCvfYnnqeOhVXduX9y1naoAS/fO+nYYwByi88EhOLdpkKODyqn6O9Q==
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 16:03:33 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::9cb4:c3f3:3ee:699c]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::9cb4:c3f3:3ee:699c%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 16:03:32 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "razor@blackwall.org"
	<razor@blackwall.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "liali@redhat.com" <liali@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>
Subject: Re: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Topic: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Index: AQHbbNT/TlKnluHwVUefPV+xYgABi7MkRzCAgAA09oCAAZY8gIAABvWA
Date: Fri, 24 Jan 2025 16:03:32 +0000
Message-ID: <b702b3c1caaa913905009296fa82e36fae264691.camel@nvidia.com>
References: <20250122135218.183578-1-liuhangbin@gmail.com>
	 <40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
	 <fc63c005a8f2fd6a34a055c1ac484bc36869f8a8.camel@nvidia.com>
	 <20250124073833.2b2e2f4c@kernel.org>
In-Reply-To: <20250124073833.2b2e2f4c@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6549:EE_|LV3PR12MB9236:EE_
x-ms-office365-filtering-correlation-id: c41ac5de-3597-46e6-40a3-08dd3c90a660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1RCTEx5amw5aExqNHlUU0dGTTcxSjdNQStkZlJDWnpCWW53ODFwSE1QMlFn?=
 =?utf-8?B?ZS85S1p2TFYwV3pVeFZVbzNWTk5wRitiZUxzOHp2WTRnbXNuWllzeXdWeEhm?=
 =?utf-8?B?cXFtYkI5WXVta2ZYVEJiTmd3UitTb0tWVDZFQ0FnLzZZR2ZzWjJzY213K1lK?=
 =?utf-8?B?UVczUGl0dVFpQTV3WENCbEFNY3prL3FuZjlOU2x1ckhBUFRYWjBlaVFOZXB1?=
 =?utf-8?B?QjE1UGxXblg3Q2xLOGRud0xTckNKbEtTM2dQdjBPZjZCNDJxenRwcjRuVUpQ?=
 =?utf-8?B?eTNvdDlGVldTQlpUcEFCN3B1dmkvcWRCNmYvc3VNQi9LMGdMNDQ2YW5HZjN3?=
 =?utf-8?B?aSt6UElhZ28rdFV4S290eVpDYkg2bTZpS2J1aG5Pb0lvaCt5WXRPTkJkRytC?=
 =?utf-8?B?NEJLN1krRGFYcVlKN0xJTVlrbFhwRVRPdks5QzhhR0dqM2VuSWFnekgrcW5N?=
 =?utf-8?B?RXRoTXRiaHBBMkY4UTM4WDd5bnNOQ3FoQ21YQlM3cVJod2luajBKd3FYN3NB?=
 =?utf-8?B?cWxvVExZYkhaUjdQcTZJQkRjL2lXdFhqN1lxTWw0VmVFVVp3NEttMVZ3KzFU?=
 =?utf-8?B?UDArbmg3NVdJZ3IrekY0aHc1a1NtblFackNoN0czbWpQVXRTeVRrLzRzOVFp?=
 =?utf-8?B?ZDJCYUErU1ZPKzQyclFXUStZUnpaQjJkVjN0bHdkaUhjajZHenJUalRRTExX?=
 =?utf-8?B?aWVOTWVPblNtM21UQmk3OUVXMmNFSS9TeFVVanJZRlpscWE4K3BmeG1kY3pR?=
 =?utf-8?B?Ky8wUExFY1NHL0pUTktWbDNDOHN5bmx6YTl3c3BDN28xQXY3MVhIZEx0YVRV?=
 =?utf-8?B?bk85ckFadVFHSklzSEdwN0MxS0Y5YXM3bEZ0ZHFLNXp6a0hDRDFTRzRXQzhH?=
 =?utf-8?B?Z1lFb3AzUlF1em83Y2J4RnRIeEdBOGhGYnlNZldneThDdDJHOUlPenlJYld4?=
 =?utf-8?B?ekd5VWUrUDF3RFhJZkI3OFRNblpvTFdzRERRWjQ4SytBRDRIRG16dldMalVz?=
 =?utf-8?B?SnZNWnUzN1gxTjR0dUVadlRDRWxmYU0wU2ltamk3d1hqbjYrbTVBUzZuK3Bu?=
 =?utf-8?B?Y3lpVnp4NG53VE1uc1BuaHptVC9paWlKbTNMZEhPK2pObElDOEJNbTIvbXZj?=
 =?utf-8?B?akRTUThJLzhPb1pQSC9IWGFtbDhLTjYzekxDc2dsM2ZsTXJVcU9zWmZCYVNV?=
 =?utf-8?B?U1pGYjBrY21VczVzT2pObDR6enZqZnhrNk9kQkJlcFphbzh4aHZ6SWJ5OEdr?=
 =?utf-8?B?ZDhFb1BqNlVPZFpCY085aDdtOHd6d2xITnFMS3Z5UFVYZ1M5YnNWazBTS2Nk?=
 =?utf-8?B?NXBIRjJ2Q2VpbkFRVGRnQ0xxSnJHR3dZVlhzUDBaS2tXaEx5NXdzR1BreHVO?=
 =?utf-8?B?N0JIYWFrZmRucG5WLzlqYnhsQWtwbm5zSjNGV0k3WEJPV2NaOWYrbTFxSzdE?=
 =?utf-8?B?Njg0L2NwY21PYXlwa0htQzNwSkxrSDRZTWpUczV4QUZIV0MvYW1WY2Z0WXRo?=
 =?utf-8?B?aUxHY3BXVVJydFdpcU1STGE2Q2ljVlpiSmdOSUN1cy9WcEphYWhIMUE0S0xs?=
 =?utf-8?B?YnVaeWZtMDBYdnZ4NEZaRXIxZU56SldXcUZ1RWlkQjRLRlRlQlpTVitOREsx?=
 =?utf-8?B?WFo2UVFkVWZxZmFQYndBZVhpUGowVEJoVXdnaHZLMEtXemppK0VjMCtIbi9Q?=
 =?utf-8?B?RXA4VGVoUmVXdTRVSU5XZXJibFJmL3dWTTJKTGFzR2RnNVF1UjVPbk9lZFJR?=
 =?utf-8?B?WE9xbVlHblk1RzdVcDVMSW5VS2pxbklBZ01KbGQyZ0xDbGROUkR6UHlGTDFJ?=
 =?utf-8?B?VlRtd29jYy84dUNhUk8rRjlLbWNjLzZWQ1ZBMWhSdmJzTExVQjI2N0x5VXNL?=
 =?utf-8?B?MWtWV3JDMXJIVVloOFF0TlZjbkVVSmJMSklpWGV4YjR2Q0cxUUQxQ2thbW5F?=
 =?utf-8?Q?svtQ+3GojfXsSKUQFvOabkCfKBSWEk8p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHFoSTI3TVliUzFZL3JJcmRBYUNIa3lSS2UrS0szMzdDYzY1YnloVHJLbGVt?=
 =?utf-8?B?VHVsTS9NUGI2MjAvNm5oSDQ4SmgrNUQyUHlPY0RxV0RHbG1nTEIzRXJlYms3?=
 =?utf-8?B?ZTJvSkNFS2cwU0RQYXNKQUl1cmtSOU81cGNOWFJpRnAwb0xCazV6cFdWYmdt?=
 =?utf-8?B?Y05CK1Q2d3ltTk1aL3k5UXc5RVJJV29YdjY0bms5L3lUZDQxc3QwcEhWN2ZM?=
 =?utf-8?B?ZVNxam1HNVN5WlhkcFhGcjhyZXNmdTZBVGp4QzdCOVlQSkU2UkZJa3ZvUnph?=
 =?utf-8?B?OUYxQitGd0pHaksrdVNsR1RRU1FJRmt4MERpell5eEF5R2pyWWY0aUhVSlEx?=
 =?utf-8?B?LzdEZmJGS3YxMGtFcFdnV3cyYlZzeXI3VE9kYW1sWlJEK0hIRm05b2hvUWg2?=
 =?utf-8?B?NEd2RnhtSHBxVklvWXBES2JqeUk2am83c2tmam1nekxRYjByeVhtM3RMM1pi?=
 =?utf-8?B?OGx2S0lXU3NRMlNwa1JoK0h5OUNtWXk1K0MxY29jYi9zYnFleS9yWE9mTlpS?=
 =?utf-8?B?UnBWdi94cDZSVjl0djJZRVZLd3k1a1dRMnM4UVBSc2RCbzVvcU9mMWFRazJL?=
 =?utf-8?B?Y0xzOFY0MTdPY29zTGUveHY3NnRsZDE2eW43bWg1Y1BEVk12UDE4MlVwOEVv?=
 =?utf-8?B?K01LZXpId1Z5dCtpUkZSK1FqcXNib2dqSW9sWS9HejE0dllwTi9vQU12S3Jm?=
 =?utf-8?B?YlhpTGM2WEpsTHI1ekdCazhZN2tUbXlyZWRPbE0xTk9wOVFZWlhYZWQ4Szha?=
 =?utf-8?B?a1Q0cXFLN2hwSFZNUW4zOVNyNnk4V2s1V1AyL25LQ2FGaWhsMHdoVFdYekxG?=
 =?utf-8?B?eklZT0t4WXNiY29Tem5xdm1sMkZMdHBpb1ZDN280dVQ2NGNPTHRSZHIzcWox?=
 =?utf-8?B?cjczTE5EUU1taEp5TEVuMVNzQ3d1a1hPWjhRbXZHNDZqaEYvckRBNVQ1N3ll?=
 =?utf-8?B?cUdNNXgwNzI1U3NqM1VmNWlMc2JmejFqTmFmdW80TG81RFlWOTI3M1kxSWRI?=
 =?utf-8?B?RFl2Y0QzaE8vem5GODlGSnliQU43QlE4Y05CcGE2YnF5L3dzbnZPOVFOdm9z?=
 =?utf-8?B?dXFLczQ0Qis0cGVpQ2ZCakxxZGRoc3hSYUN3Z2FGeFdadkNrSE4yQTRpdFk5?=
 =?utf-8?B?NW1GV2o2aTVPanh6RTdUc1FwL1lvdGxXbnQzRXAzTi9YRU82ZGh1dFpNc1Np?=
 =?utf-8?B?YXBmK2tIY0VvbXd2NWNjV0RUazl5SHZVRGdmTk1DalB6MmtLL3hDRmhrenFZ?=
 =?utf-8?B?bGFwZVhwajFURTYvNHcxR2hXcGoyY2RlWnFVYk5leFJaM0VOeCtpSis0MTdR?=
 =?utf-8?B?ajJyOWw4WXI0MzY2NjdoelB3WkpxRDNYK3lCYXpNU0lIY3dicEtpcEI3Tzcx?=
 =?utf-8?B?S3ZDU3BrK1FKUkkrcXRjTHJEVk1idHpKZDZjSFNOQWJaQytxclhCSFhudmx3?=
 =?utf-8?B?eDgwRHZSZ0MrSlhpOGVGc1pFYkFIUjRHLzA3TU9MMUM5ZnBzamU0Tm0yd0hH?=
 =?utf-8?B?RWVYeEFtNUJ2TXhDaVlJM3k5RStieDE1SUpJcm83OGRBNVhXclZmdmhKNEVL?=
 =?utf-8?B?bkczUXZTR1dQV3pBODVCT1luMVU0cnpndmtvZitwck45V1dkUmNVTmpWaFl2?=
 =?utf-8?B?aHZodTk1TlNaVDlrV3BwMlA2djNvT3R0UkU2QTMyM2d6emVjOHRBZFRmWU9a?=
 =?utf-8?B?QVo5RmczYmQxcE15NVJkVU1EcnpqQ2svRDZNN2VrMHNsSk9tVDFRVmkvUEJ5?=
 =?utf-8?B?Z3FNeS9UK3Y2bGFpWHF0WVFqd0tLdHo2MnNyb05CM0Jhd1pZclBMWmRrb1BL?=
 =?utf-8?B?SHkzUCtLQWIwMXNPNVJjSmtTZ3Z2K0FQV3pLalluSFVhamcrUmJBQjZhdzda?=
 =?utf-8?B?Sk9DNUxQQjNxTzJpNmp1U3lGZW9VSmc0eUpnY1JlTUtJbHdpb1QrcERXdE5I?=
 =?utf-8?B?WjdUVzBkcjUzSzA0MmkxSmx1MFdnTHB2Um5hdEVZeFFOd2piRjB3L2sxa2cr?=
 =?utf-8?B?d1JiYXAwUm5BS2crZlp5cTl0YkJ0RENHSm8ydkJuSXI1VmtOTDRlNnFZN2kw?=
 =?utf-8?B?alZsOEUxSkJpZTkrV0NuWDN2QWNFek9WRUErRndZN3dzeTJuZGpUdkEzR1dr?=
 =?utf-8?Q?2n8NueMN4YINcHF651wUGFuRd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D530C91A937D44AAC956CB8391F13E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41ac5de-3597-46e6-40a3-08dd3c90a660
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 16:03:32.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ5QCAWZgs8ozhhve6603/kQ8Oc2OR1ivcDl8Nig8pXSg2Zb8WL5QD6+LP4sJwHQxSj0DZ0G/iRfh7VF7bXNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA3OjM4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAyMyBKYW4gMjAyNSAxNToyNDozNyArMDAwMCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gSSd2ZSBzZW50IGFub3RoZXIgcGF0Y2ggdG8gc3VnZ2VzdCB0aGVzZSBjaGFuZ2VzLg0K
PiANCj4gRlRSIHRoaXMgaXMgbm90IHRoZSBub3JtYWwgd2F5IHRvIHByb2NlZWQgaW4gY29kZSBy
ZXZpZXcsDQo+IHBsZWFzZSB0cnkgdG8gc2hhcmUgeW91ciBmZWVkYmFjayByYXRoZXIgdGhhbiB0
YWtpbmcgb3Zlcg0KPiB0aGUgc3VibWlzc2lvbiAodW5sZXNzIHRoZSBvcmlnaW5hbCBhdXRob3Ig
ZXhwbGljaXRseSBhc2tzDQo+IHlvdSB0bykuDQoNCkFwb2xvZ2llcywgSSBkaWRuJ3Qgd2FudCB0
byB0YWtlIG92ZXIgdGhlIHN1Ym1pc3Npb24sIGJvdGggbWUgYW5kDQpIYW5nYmluIHdlcmUgc2lt
dWx0YW5lb3VzbHkgbG9va2luZyB0byBmaXggdGhpcyBpc3N1ZS4gSSB3YXMgYWJvdXQgdG8NCnNl
bmQgbXkgZml4IHdoZW4gSSBzYXcgaGlzIHByb3Bvc2VkIG9uZSAodGhpcyB0aHJlYWQpIGFuZCBp
biB0aGUNCmludGVyZXN0IG9mIGV4cGVkaXRpbmcgdGhlIHNvbHV0aW9uLCBJIGRlY2lkZWQgdG8g
c2VuZCBtaW5lIGluIGFkZGl0aW9uDQp0byBjb21tZW50aW5nIGhlcmUuDQoNCkdpdmVuIHRoYXQg
d2Ugd2VyZSBib3RoIGZpeGluZyB0aGUgc2FtZSB0aGluZywgd291bGQgYWRkaW5nIFNpZ25lZC1v
ZmYtDQpieSB3aXRoIGJvdGggb2YgdXMgYmUgb2s/DQoNCkNvc21pbi4NCg==

