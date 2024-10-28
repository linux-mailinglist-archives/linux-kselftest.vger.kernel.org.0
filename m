Return-Path: <linux-kselftest+bounces-20785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BD9B23C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 05:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A531D1F218C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A2154BE3;
	Mon, 28 Oct 2024 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="epRlwL7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE980B;
	Mon, 28 Oct 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730088218; cv=fail; b=QBZsblqhyhaFhH1gkSHPz4c1LN/x1pYswvcYAxJh/Hki/7hwR/LyDwjCq9lL03gpfhgJt4/EJxf1P9i7UxerxjueyYFUquu2DizrUsKpxRNUbF/N/6NvRYNt8N3zBZYi4LVjBPrHrO1MUZGaYTfbO1SZFrgaoUcZdYkdZySV4Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730088218; c=relaxed/simple;
	bh=e1enotVFBMGpUVGxdCYtSJvTr4t3G6S/4BkcgZ3VNLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDxo2Pl6b1YP+wgjSxwQF7xF/eUNbDmCm1rT7KnDoTBYoz8M9PX81n5tzboTbSyZxYH4MEy/wSkX+lL29mblbEq+g2mE/0ycRKTbogUEFiWlHkXPw3VU62Tt1kgtPnnRHkDg9rq4Mozohu4UA4SyGE8sblffTGHL14qLnaKck/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=epRlwL7x; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730088216; x=1761624216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e1enotVFBMGpUVGxdCYtSJvTr4t3G6S/4BkcgZ3VNLs=;
  b=epRlwL7xmhEtMh4SbCAAobY3NYqFo67rp5chbyUezFJ96yCQtYEBMsIf
   gWflL8BLHzhHq0xop6de3ai+Y8sCQUcGh2VpStLlrlTfoolKd+sYwQhyA
   3uHrPRMr9PjaEnqaKRFPj3nYpCratENB7YXONG7nAnH7THhSBuaw7Ingl
   qDVWDw+f50VJCacNOWZGYFh1vd9V7uNts8hFwsfQpYlvah8neYzty252C
   mL6+WfD3jFf03q76QHNfMpRZ7ThB9xgnu296qu71TfqqZdZvJ79XXwFxI
   GDyrZNJf8fV+9Khkyy0RaTHuKTjtY/Y6gUGI3VxTL/SDN5kLVPBIc9vge
   g==;
X-CSE-ConnectionGUID: zFUUZb2hS+2b+b+976ZF3w==
X-CSE-MsgGUID: So1IYeu+SxmQ10UdXSge2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="134885671"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="134885671"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:02:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh+tuhvb6NIJo56SvSwxpY/N4TUz84FwGGuFl13uR8nil0Q96/zX0HIIwR5sK00Dr//SDri28Fyy7AWMsoCW49hbQwaxOT7B+9hBSwCHQ+eU32XMYl70YhT0ntIQJpXoKbsh+wMdBOd5IufH7FAqlKFLwf3b7rublY45kU5L/n3gpMYzwBSin7RDpuv3kHLP+qM1NRufMZp4nHiVs61Rs9OMF4CtU9cPqbefXqZmPvuJ1nr+gXiDejBcxcOtiSzZbdbsPuCwYsrXDJYK3oaiFv6rQX5cL9GDKmF4K+kodxj7gP9v417GFLCSJ3njzAUjbRIUop5FZ4064HGSzoIPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1enotVFBMGpUVGxdCYtSJvTr4t3G6S/4BkcgZ3VNLs=;
 b=VdyvbXHvrTVPTZdhMOd8e3TEoDlHiPIqUH5VSQGBmsO5kg2Isf+NCclao0f5UmYqeo/M0mH7zsnSIbeR3Z1z/GIJIV+okJJ7dNZW84jBM/YdxogVDnKrAdDuI8mvOCBrHMWoxpAmHmfpEzsRyVQYtGhBy6X8A7PrTEv0BYCrL8vnTOYnE6Amb4TDsL8XHBpljfjko7gMtGgj5pT/ygfO75jOuKSL/nKpEROqEx8Vjwvap6kaqrnplT5Wi1rddHJ2lNBKgzCMDAlpaNG4Vsckt61hw9EeIq5xhI60uCNpGeT9Er5g6MAQUdX7aLelILv/JzSDWdlFRS/RFqu6RBnAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB12488.jpnprd01.prod.outlook.com (2603:1096:405:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 04:02:20 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 04:02:20 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Topic: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Index: AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoCAACyDAIAACTkA
Date: Mon, 28 Oct 2024 04:02:19 +0000
Message-ID: <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
In-Reply-To: <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB12488:EE_
x-ms-office365-filtering-correlation-id: 538bb37d-0696-46ea-0c29-08dcf70551d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnB0aFJXcW5KY1FkRzY2R1lCUjNob250WnZYV0lHK0lRY1Z1bml3UDBKYW1X?=
 =?utf-8?B?UWdsTmlMUmc4aU5RRitrRTBOV0JWcFRnSFhIZDg1RHRXUEZsME9yclV5ZVZn?=
 =?utf-8?B?NFBCYldlelFyaFQ4OWFHUTJ2QzVodlZFa3pvb09SV3lJTFVwTXY0MlkxMkVa?=
 =?utf-8?B?RFdTVDVWc1ZEbXpMaGdpUTZOL0pyQTZ3MjFUTitGRFhLbnllbitkdEs3RzdC?=
 =?utf-8?B?bG1vVXRlVnUvZlNBczh5SlBrT2dFd1hnMXgyaDR1ZlUxYnZUV1Z2ZVpHSksr?=
 =?utf-8?B?QTQ5c3F1ei8vZHdXWVV6dzZlTFNHWXdUK0ZhWG9BRi85NDNheVVqVXNmdHI4?=
 =?utf-8?B?YU9VZ2hwZmM4aVZIaFRib1pUOHJheTE4VjdsWXhGYmRnemEzMm1Gb3dLanFi?=
 =?utf-8?B?dkNjVGhZV1VUaFl1bzRSWnpVWk1ZVTlybXRVNnRWRG1VblltQ044SWtidzlh?=
 =?utf-8?B?cDlUWlVLZ2FPTkF3Z2hFYVBNNFh5dW1hOVBRcks0RGVwZTNIKytHamJ1cW9j?=
 =?utf-8?B?Q3RJbk1QREtMRjdiQ1NUMGVlcG94RUc5RTNMQjd5TlM5M2lyNnZxMWlIdEtz?=
 =?utf-8?B?NW9IdU95TVB5TEVDRTkwRWRrWDFwTzEzbzFtbk16dUorZ3UxcmxtVmFVUEk4?=
 =?utf-8?B?K2JoeUk4eUdnTWR5ek1ickx3ejNkcEdUYU5QTTc0UFB0dWM3eS9EZGtrQnNi?=
 =?utf-8?B?YWVxaEFXODdFNnU3eTlWLzFsY1FBbjRRM3k0WWtMT1IwbmtsTml6b09nY3RC?=
 =?utf-8?B?RVdENjRGaXc4T0U4V2ZyVzcxV1NUTkh5WVRmOUFmZWR6bmViYjAvRFZkRTl0?=
 =?utf-8?B?NmlWTmZlZEhjQU9RaDBBZlJJbGNaQis0cVBSVHB6QlNyR3cyOFNiMk42TWRa?=
 =?utf-8?B?K2V2YlhBTjhzcGVJbW1YWEdxWm5VYkRFVm44a2tUSWpodWRwV2JxQWZ2YlhS?=
 =?utf-8?B?cG1BQURJc1VxQ0xOVUNEUW9Md0tkaFdVM0VXMzhxbk0vbWNpY3NUbmJLVE9W?=
 =?utf-8?B?bE9BbTBmTEJMSjFWWWRROGF1MDRmclZVOFFtVUZpSmR3SnYwUVJlZGR2NGxL?=
 =?utf-8?B?V3V3NzBORm91aVRrOG9KMHlVdUQ0Qm9udWJVdEpZRVYydy9tN2pwMklMeWY4?=
 =?utf-8?B?ZFZOK24xQ3d3aDhnNGZYYkhJZXdIZHp2SkNkVmhQMmJDL2pYcWZoR2FpQ1c0?=
 =?utf-8?B?NENpT1RWUWNxTnN0Q1lhbFdFallKbTdHei9qY25CbzdlLzVBZU5oa1Fjcisy?=
 =?utf-8?B?SnZ5REkzZlBwMGVwYXNOaytwMUgvMDNadzNINHpsdjA0Y0dxSTFPakhIeklp?=
 =?utf-8?B?S1VpSE92THZrU1A1YTdYYkY4ZHMxRGl3R294S01QcmdaN3FBcXhhKzc4Tk43?=
 =?utf-8?B?cUlWZFZmd3N1emFPbGF0ZjRXK2x6OHFmeDl6anhGOWRvRHloSEFUZGoySmZu?=
 =?utf-8?B?UWVhUGs0eGFMWS9xVEd5cFhZaFFYOTF0cHpEcGI1Wjl1eFVERW1PeDFRakRN?=
 =?utf-8?B?ZloxUWM3VjlaTDlCKzdXVW1SWWx1V0ZaY09LcjM0Q00yOXNDbmRVWkJZY29q?=
 =?utf-8?B?SWREV2JSamhEOHkzV0pzR1EyKzY2c0xpTitFSEFLdXFibTlCd2l0ZnZmSEtx?=
 =?utf-8?B?TkZtbkxpVWZxYkhkZEF0Q2hZcER5dzBKM2FjMUhoU0ZuTWIydlRwL0tSVEFJ?=
 =?utf-8?B?VHlhY3I0S0Fha3oraXNsZHh0MG1UVVBYYlZTek9US2RCQnJkUWc1VEJCdEll?=
 =?utf-8?B?QjQ2T21wZFBZVTdiQlhEUHg2QmduK0ZRRktTcU5kaDBMQzY0Y3YvYlFNdXdp?=
 =?utf-8?B?UnRoK0dndW5JaWs0eWtLY1lKNndFRTNDMlpkNWFZOUg2VW40ek8yK3JIb0tR?=
 =?utf-8?B?VERzRktYVTVWVlpFY3RJRnp4bG5NcjFNeXRaYTR3U2FJSGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHYvWW1OY3lSZndoT3QzVUh4UEFzbFdUQ1V3UFgwTU93MTBpc0lTamlYUEVG?=
 =?utf-8?B?dmgrMUNNT0cwTWw4dkE5T0FxVUtUN2MybmFwSEs1RFIwM04rdnA2NkdZNFQ5?=
 =?utf-8?B?cEFwa1krYVNQZnFlM0h0eUFNcTZ4dFppcHplbkNDa3dIN2VhZlhuU1YrQkll?=
 =?utf-8?B?aFppWVJaRmlqWFYyUStKZEdkVmNyU0VCbEx3WnRkbEVIcGJaakhGdHpPYTBl?=
 =?utf-8?B?VFZ2RTZuemxueERHc0t2UFVsUXVvWU1VRm1yWSsxUVRveXNrRUU2TzRmUjBx?=
 =?utf-8?B?K05hckdFVUhvU1ZPNnNsWncvK0FpeFl4c2xOUk1jOWwvR3kzVTJTK1VseEx2?=
 =?utf-8?B?UjdMNnNLemI0VFNObUZyZTRFK2p4ek9PcjdHangzSk1SWTAxT1hyY2t4RXlR?=
 =?utf-8?B?bUZBa20wemViV0c4RHo2OTdpZ2RvSHo4R2l5bEhVbzNxNWNuZjN3MjJnQnNU?=
 =?utf-8?B?UUhuUFJhSXNRVzZ6cUpoakFQTGhwMnVpeXFQWEpUMkROZDV5NzUxYkxlaFBr?=
 =?utf-8?B?VVR1UDBTbjB4NExjQUE4WlA3QjhpVlR0ZHNmL1cyRXFXQWRCa1FQTTdIMWZ0?=
 =?utf-8?B?Zk41M1JUVUJ6RFM5Q2NqcHF2K25TR05SZ1FNb0U1STI5dk9qNHdFNjZ6TEV6?=
 =?utf-8?B?Z1ZWeFVNWEtGNEZrdkVSak5hZGNxWk9La294R3Vrdk5wVGdQdTd1R0pPYmhx?=
 =?utf-8?B?TGVQQnQwaDgyRHFZL2JTcStNemxJaVlobk5UNk94WDhPWXJPRTVrRmN1K3k3?=
 =?utf-8?B?WmxVdDhkTnJ6U2d1ZUIrYzhlSXAvMVI3S0c0LzBpYkJJa285ZUlIaEIvTUww?=
 =?utf-8?B?OHdvd0d3LzNHeDVsMGVhbnFZYy83SlpBaktuQkgwZWU4a0FNQW9qUzV0OFhx?=
 =?utf-8?B?WDRGK0pOb0ZkajJPdzBlZURhWlVHR3J3WmZKSXZTaTBtSGllcHJ2Yng3cWFF?=
 =?utf-8?B?enY2VWFFYVExeUR0WTZQVFArVjJzZE5SMmU4V2oyV2Z6OTFMMlB5RTVqTVRL?=
 =?utf-8?B?bzlmZjNidENCdlVENzNEaEx3Y09SWGY5RkZ4ak13Y1ZEOHd3TUFxcE01Qnly?=
 =?utf-8?B?Y05oYy9hTnYxeE9xWi9YbGVKUXN1MjFBSEhEZjFyRzRoNFVZMXRPNk13dzRh?=
 =?utf-8?B?RmZSR2Yyb2d6b1VYNUtwL0pIVjdseVR0M2NMd2dqbkhCczVCV0Y1TU5DVjl0?=
 =?utf-8?B?akJvNFM5UHJwSEFSUmJtNlBtRVV3WE4xQlNCSERzT1hmZ1NyTFh3RHhRR0Zi?=
 =?utf-8?B?QzYvSDlHQURBYnRjNkZ4dkpHd3dPeWE1cndPZ04xWFpSVmJENjVXVEJKVVdS?=
 =?utf-8?B?bzNwYUFFQmpQWHZmWE92WWorUkh0V1Y2ZDBqcEVraTROVFBXWlVWNEl0NlZh?=
 =?utf-8?B?eTc0L3VJV2swdVB4NjBsTDZsVVJaY0FVYk9yTHR2Qk5YSUZ2bDd2bCs2SStI?=
 =?utf-8?B?Y0V4eHVEZmV3WEE3V0hzWUhNNkNFbHhRSzNpMVBXaUhLQStQcnB0Z3c3RU1N?=
 =?utf-8?B?K1FjZDVQTTVic2NHcFYvV0EzZmMrR0xpRnZ3dHdEZjFCTWNSV0VsR3ExU1hE?=
 =?utf-8?B?YitJRldBNzJTYTFOWjd1QlkwdjRJQXVVaVQxSmpPblV0dFZpOXFPczhJUFlu?=
 =?utf-8?B?dEdHYVNFWWVlMUtqc1l4b1JPbTVIbDV1RktPMjl0eWpOczVJaXpnT2lhdzA3?=
 =?utf-8?B?TmJaOFlZTTg5dUdIczJ5TTRFektxbFlNU0xQeGpBcThQcXk1Ulk0K0FteDBl?=
 =?utf-8?B?RWF0L3FjT0sza21ZNjVmZ3pYeEtVd08rWXZSR05VTm5wQ3dVMkRjeUdBZW1I?=
 =?utf-8?B?MndqNGROdEE1RWVCQTlPSmVuSyt2cUUvZUJndGZtUVJ1d0Q0WUh5TUk0L3FH?=
 =?utf-8?B?K0dmQUtnR1QrQXlmc2hhOFZDZE15ZDk2V0JINWdSd0lQNzZjOGsyc3pTWnp1?=
 =?utf-8?B?YngxblFjYXltVFA3TFB2Q3dibG9GWkVYSmhHNDNFUGE1UExsQldGaGYyWWtE?=
 =?utf-8?B?UndpZVZCMUNKNmYwVGtETUFLOFgwc1o4Y0ZBa0g2YlVSL09SNDJsazNxenMz?=
 =?utf-8?B?YituODFtVVRUSjZRZVVPZUFXMG5IRGpWSityVTgzancxVmE1MmxtbUp1Q1Ux?=
 =?utf-8?B?Z0xOdDIxZGE0YXdiZFpMSTVXZjFjdUpwQkZiWHMzK1BKeU1EUTZuMGVXdytO?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0491E1D5976A1F44A1D0DEDC5CE06202@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MrRy97VIxRF0qfxwHx5kVTYVWDTm9KIS9yXDQYfoyvLlEh0TGqmKddNN0xqLM5mrtnK/oM6IZgO3aiBXLgDz919baEaZwdzHrNLOFRVBl5YL0sOO8+uQgVJf840fmPj+llKeKyqRDXgwmC1pbkMUXaVLS4LS3Sn+c5uGwIwnRJh8l+DWr+tMfZ/wOhWfYjB8HD2ysOSvZtzHF5UjEjMo90d4ZtG3v2rdK1rAbUzUKtusbwj/uXPhtNmPdS2Y23UtLNpkzcaU3Cez/cDy9xGnttgdy7ecr8uNQsNNnGNjbFy5vIaTYtJOag+uczKqwzaWJBG6rmLt+9z0+hQN7RX8QI9rWbFswVNrDQ56IuW4iZTMcY7BFou83VsNxYEkrjwaq4B1wf7fHQRWrVOS8DhBTjLXqje1Et3vfLejlfg149eXMW6BWkbrNDhoiKaCrmtZXp6EjtTkeHF8rAubvtLJMIN5Pd9vAO4gDLYrzawhzfl+tCvNoB/YLobIdeD/9dCOClRau8u6CE19b86OX0Cq7898h4yKKl512ddr9XIlBoBzlSQiV9u71qBZVBosUZRGoSgh05H9r2PnjV2/iIXN6rcgr45F86nEoBoFeD+Oj3mWMRVzIREMIc9b58a31iIV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538bb37d-0696-46ea-0c29-08dcf70551d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 04:02:19.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erszTovXdLkdqh4QDwYuANejtihPafffLiDd0dPHfot1JJjU6dd9HHtKiL4rkmZqjT7y2pFQJsu58lxAbGev5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12488

DQoNCk9uIDI4LzEwLzIwMjQgMTE6MjksIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEwLzI3LzI0
IDE4OjUwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMjcvMTAv
MjAyNCAwODoyOCwgU2h1YWggS2hhbiB3cm90ZToNCj4+PiBPbsKgMTAvMjQvMjTCoDE5OjM5LMKg
TGnCoFpoaWppYW7CoHdyb3RlOg0KPj4+PiBDdXJyZW50bHkswqB3YXRjaGRvZy10ZXN0wqBrZWVw
wqBydW5uaW5nwqB1bnRpbMKgaXTCoGdldHPCoGHCoFNJR0lOVC7CoEhvd2V2ZXIsDQo+Pj4+IHdo
ZW7CoHdhdGNoZG9nLXRlc3TCoGlzwqBleGVjdXRlZMKgZnJvbcKgdGhlwqBrc2VsZnRlc3RzwqBm
cmFtZXdvcmsswqB3aGVyZcKgaXQNCj4+Pj4gbGF1bmNoZXPCoHRlc3TCoHZpYcKgdGltZW91dMKg
d2hpY2jCoHdpbGzCoHNlbmTCoFNJR1RFUk3CoGluwqB0aW1lwqB1cC7CoFRoaXPCoGNvdWxkDQo+
Pj4+IGxlYWTCoHRvDQo+Pj4+IDEuwqB3YXRjaGRvZ8KgaGF2ZW4ndMKgc3RvcCzCoGHCoHdhdGNo
ZG9nwqByZXNldMKgaXPCoHRyaWdnZXJlZMKgdG/CoHJlYm9vdMKgdGhlwqBPUw0KPj4+PiDCoMKg
wqDCoMKgaW7CoHNpbGVudC4NCj4+Pj4gMi7CoGtzZWxmdGVzdHPCoGdldHPCoGFuwqB0aW1lb3V0
wqBleGl0wqBjb2RlLMKgYW5kwqBqdWRnZcKgd2F0Y2hkb2ctdGVzdMKgYXMNCj4+Pj4gwqDCoMKg
wqAnbm90wqBvaycNCj4+Pj4NCj4+PiBUaGlzwqB0ZXN0wqBpc24ndMKgcmVhbGx5wqBzdXBwb3Nl
ZMKgdG/CoGJlwqBydW7CoGZyb23CoGtzZWxmdGVzdMKgZnJhbWV3b3JrLg0KPj4+IFRoaXPCoGlz
wqB0aGXCoHJlYXNvbsKgd2h5wqBpdMKgaXNuJ3TCoGluY2x1ZGVkwqBpbsKgdGhlwqBkZWZhdWx0
wqBydW4uDQo+Pg0KPj4gTWF5IEkga25vdyB3aGF0J3MgdGhlIGRlZmF1bHQgcnVuLCBpcyBpdCBk
aWZmZXJlbnQgZnJvbSBgbWFrZSBydW5fdGVzdHNgID8NCj4gDQo+IE5vIGl0IGlzbid0LiAibWFr
ZSBrc2VsZnRlc3QiIHJ1bnMgb25seSB0aGUgdGFyZ2V0cyBtZW50aW9uZWQgaW4gdGhlDQo+IHNl
bGZ0ZXN0cyBNYWtlZmlsZS4gVGhhdCBpcyBjb25zaWRlcmVkIHRoZSBrc2VsZnRlc3QgZGVmYXVs
dCBydW4uDQoNCkhleSwgU2h1YWgsDQoNCg0KVGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uLg0K
SWYgdGhhdCBpcyB0aGUgY2FzZSwgSSBkbyBub3QgaGF2ZSBhbiB1cmdlbnQgbmVlZCBmb3IgdGhl
IGN1cnJlbnQgcGF0Y2gsIGV4cGVjdA0KSSdkIGxpa2UgdG8gYXZvaWQgdGhlIHJlYm9vdCBpc3N1
ZSBhZnRlciBhbiBhY2NpZGVudGFsbHkgYG1ha2UgcnVuX3Rlc3RzYA0KDQpTb21lIGNoYW5nZXMg
YXJlIG1ha2UgYXMgYmVsb3csIHBsZWFzZSB0YWtlIGEgbG9vay4gSSB3aWxsIHNlbmQgaXQgb3V0
IHdlIHJlYWNoIGEgY29uc2Vuc3VzLg0KDQoNCmNvbW1pdCAyMjk2ZjlkODhmZGU0OTIxNzU4YTQ1
YmYxNjBhN2YxYjlkNDY3OGEwIChIRUFEKQ0KQXV0aG9yOiBMaSBaaGlqaWFuIDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+DQpEYXRlOiAgIE1vbiBPY3QgMjggMTE6NTQ6MDMgMjAyNCArMDgwMA0KDQog
ICAgIHNlbGZ0ZXN0cy93YXRjaGRvZy10ZXN0OiBGaXggc3lzdGVtIGFjY2lkZW50YWxseSByZXNl
dCBhZnRlciB3YXRjaGRvZy10ZXN0DQogICAgIA0KICAgICBBZnRlciBgbWFrZSBydW5fdGVzdHNg
IHRvIHJ1biB3YXRjaGRvZy10ZXN0LCBhIHN5c3RlbSByZWJvb3Qgd291bGQNCiAgICAgaGFwcGVu
IGR1ZSB0byB3YXRjaGRvZyBub3Qgc3RvcC4NCiAgICAgYGBgDQogICAgIFsgMTM2Ny4xODUxNzJd
IHdhdGNoZG9nOiB3YXRjaGRvZzA6IHdhdGNoZG9nIGRpZCBub3Qgc3RvcCENCiAgICAgYGBgDQog
ICAgIA0KICAgICBGaXggaXQgYnkgcmVnaXN0ZXJpbmcgYSB0aW1lb3V0IHNpZ25hbCBpbiB3YXRj
aGRvZy10ZXN0LCB3aGVyZSBpdHMNCiAgICAgc2lnbmFsIGhhbmRsZXIgd2lsbCBzdG9wIHRoZSB3
YXRjaGRvZy4NCiAgICAgDQogICAgIEFmdGVyIHRoYXQNCiAgICAgICMgdGltZW91dCAxIC4vd2F0
Y2hkb2ctdGVzdA0KICAgICAgV2F0Y2hkb2cgVGlja2luZyBBd2F5IQ0KICAgICAgLg0KICAgICAg
U3RvcHBpbmcgd2F0Y2hkb2cgdGlja3MuLi4NCiAgICAgDQogICAgIFNpZ25lZC1vZmYtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3dhdGNoZG9nL3dhdGNoZG9nLXRlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3dhdGNoZG9nL3dhdGNoZG9nLXRlc3QuYw0KaW5kZXggYmM3MWNiY2EwZGRlLi45
N2FjYjkwZjhiMzAgMTAwNjQ0DQotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRjaGRv
Zy93YXRjaGRvZy10ZXN0LmMNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3dhdGNoZG9n
L3dhdGNoZG9nLXRlc3QuYw0KQEAgLTMzNSw2ICszMzUsMTAgQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkNCiAgICAgICAgIHByaW50ZigiV2F0Y2hkb2cgVGlja2luZyBBd2F5IVxu
Iik7DQogIA0KICAgICAgICAgc2lnbmFsKFNJR0lOVCwgdGVybSk7DQorICAgICAgIC8qDQorICAg
ICAgICAqIFJlZ2lzdGVyIHRoZSB0aW1lb3V0IHNpZ25hbA0KKyAgICAgICAgKi8NCisgICAgICAg
c2lnbmFsKFNJR1RFUk0sIHRlcm0pOw0KICANCiAgICAgICAgIHdoaWxlICgxKSB7DQogICAgICAg
ICAgICAgICAgIGtlZXBfYWxpdmUoKTsNCg0KDQoNCg0KPiANCj4gVGhlcmUgaXMgYSByZWFzb24g
d2h5IHdhdGNoZG9nIGlzbid0IGluY2x1ZGVkIGluIHRoZSBkZWZhdWx0IHJ1bi4NCj4gSXQgaXNu
J3QgaW50ZW5kZWQgdG8gYmUgcnVuIGJ5IHVzZXJzIGJ5IGRlZmF1bHQgYXMgdGhpcyBpcyB0ZXN0
IGlzDQo+IGp1c3QgZm9yIHRlc3Rpbmcgd2F0Y2hkb2cgYXBpDQo+IA0KPj4NCj4+DQo+Pj4NCj4+
Pj4gVGhpc8KgcGF0Y2jCoGlzwqBwcmVwYXJlwqB0b8KgZml4wqBhYm92ZcKgMsKgaXNzdWVzDQo+
Pj4NCj4+PiBUaGlzwqBzZXJpZXPCoG5lZWRzwqBhwqBzZXBhcmF0ZcKgY292ZXLCoGxldHRlcsKg
ZXhwbGFpbmluZ8KgaG93wqB0aGlzwqBwcm9ibGVtwqBpcw0KPj4+IGJlaW5nwqBmaXhlZC4NCj4+
DQo+PiBDb3ZlciBsZXR0ZXIgaXMgaW4gdGhpcyBwYXRjaCwgc2VlIGJlbG93Og0KPj4gSW4gYWRk
aXRpb24sIHdlIGNhbiBnZXQgdGhlICdIb3cnIGJ5IHJlYWRpbmcgdGhlIHNpbXBsZSBjaGFuZ2Ug
aW4gZWFjaCBjaGFuZ2UuDQo+IA0KPiBUaGF0IGlzbid0IGVub3VnaCB0byB1bmRlcnN0YW5kIHdo
eSB0aGlzIGNoYW5nZSBpcyBuZWVkZWQuDQo+IFNlbmQgcGF0Y2ggc2VyaWVzIHdpdGggYSBjb3Zl
ciBsZXR0ZXIgZXhwbGFpbmluZyB3aGF0IHlvdSBhcmUNCj4gZG9pbmcuDQo+IA0KPj4NCj4+DQo+
Pj4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTrCoExpwqBaaGlqaWFuIDxsaXpoaWppYW5AZnVq
aXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBIZXksDQo+Pj4+IENvdmVywqBsZXR0ZXLCoGlzwqBo
ZXJlLg0KPj4+Pg0KPj4+PiBJdCdzwqBub3RpY2XCoHRoYXTCoGHCoE9TwqByZWJvb3TCoHdhc8Kg
dHJpZ2dlcnJlZMKgYWZ0ZXLCoHJhbsKgdGhlwqB3YXRjaGRvZy10ZXN0DQo+Pj4+IGluwqBrc2Vs
ZnRlc3RzwqBmcmFtd29ya8KgJ21ha2XCoHJ1bl90ZXN0cycswqB0aGF0J3PCoGJlY2F1c2XCoHdh
dGNoZG9nLXRlc3QNCj4+Pj4gZGlkbid0wqBzdG9wwqBmZWVkaW5nwqB0aGXCoHdhdGNoZG9nwqBh
ZnRlcsKgZW5hYmxlwqBpdC4NCj4+Pj4NCj4+Pj4gSW7CoGFkZGl0aW9uLMKgY3VycmVudMKgd2F0
Y2hkb2ctdGVzdMKgZGlkbid0wqBhZGFwdMKgdG/CoHRoZcKga3NlbGZ0ZXN0cw0KPj4+PiBmcmFt
ZXdvcmvCoHdoaWNowqBsYXVuY2hzwqB0aGXCoHRlc3TCoHdpdGjCoC91c3IvYmluL3RpbWVvdXTC
oGFuZMKgbm/CoHRpbWVvdXQNCj4+Pj4gaXPCoGV4cGVjdGVkLg0KPj4+PiAtLS0NCj4gDQo+IHRo
YW5rcywNCj4gLS0gU2h1YWg=

