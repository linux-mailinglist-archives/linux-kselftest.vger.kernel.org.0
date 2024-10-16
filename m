Return-Path: <linux-kselftest+bounces-19789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3699FD53
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AE91C226AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E61171D;
	Wed, 16 Oct 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ooWUcUBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61C107A0;
	Wed, 16 Oct 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039440; cv=fail; b=hdIhm1Nzwuc1fEqtDdqELRXZutSUMGmGdAgNL7JZobztb2+0fk/rsyr/7W4XfFPJL0c9mASTmGT5/Ooe6GiFBdyijvRuxyoet9ZthW3XxNhZosjq6XxjN8PRBLnpdEyokuTFpbHPPHZdj1ifk72Z75IlkIEHojyiZWSRfWZKYdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039440; c=relaxed/simple;
	bh=VBlXQWhby8iYVtULlTbatvBJrX7uO7aOZ1CnwgXsZU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcKmQ+HqiNJYkIyzjQeG8UwaGc/YzjDRwLDiZC1ZkdgjXXAyToQ6dWGyC9Oo/XPhigTiEXp9AykdI4oHbuEdsGA1gPLTegLRk5/xzwGVq4trNvgCZUFKRZGMLP13in3PlDRSDVoKwGCap8KXof6jpYAIzOEnj7fyhvh0WPxICQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ooWUcUBA; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729039438; x=1760575438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VBlXQWhby8iYVtULlTbatvBJrX7uO7aOZ1CnwgXsZU8=;
  b=ooWUcUBAOvye0DqNlbOM2246CtWFEx5IL274CaZv5ImJxprMZ3+LBBUw
   n/LiYGAb8MzIsLhxpaPuwQqHBwdBkiP2WqyxF60PJEVKVkRZCg9CR/JI6
   cCYd3/FTcoDSaqvyaFwAYqwtaI0ZO6K+R3CoeqzvJj4aPTtzkeyjPY3Jr
   ULNLq7/VYv7JrjZsg8LHoSvKcoNokHyX8FRUnSzE3LffR4Kot7KzcElQg
   E9GLLD9TTNtNp5hvNrw9rJWRPlyCh2oCVqDqdcOada79R+KmDWhh3BMz3
   OBqJztGf1B62e6+P0edBHH38kX6W0ow2OsBGuBgIGpt8WNEOtNq75RCkK
   A==;
X-CSE-ConnectionGUID: 2cCMhMp2TZOLb3rUOVY2/w==
X-CSE-MsgGUID: /GgXUDcLSQ+xsK9oU15H+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="133743005"
X-IronPort-AV: E=Sophos;i="6.11,206,1725289200"; 
   d="scan'208";a="133743005"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:42:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHC/WTIOp0nAvoIqe4uYlrCVKdetUUJJovPNtyh0TGI/uUkKwr/Ph0ORxzDPXOR/n1YXNuSp5U+UlL6fEegkm/W0uJ7dRiK/cVG0RDVsAINECWstQQeKN22GSbQAb4haRCJorYWukvScUtPs9SzlryoClhy8ESV4aivOZ39aznpfeXAX7xaRUQQjPyJGdeao2D6evPb3F6yenKE0wbMKLIe/JVhqSulWHuzCvCXfyHqFXadw0uxs3cUGubNyYfs2BQkPcxYkYy6XKQCPDwjWdpnyVMm1/ov1THeROxPcYcuBNeM7dbs0HwULIFgpvbMvwqfNLUKQHF8+9j33vYa/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBlXQWhby8iYVtULlTbatvBJrX7uO7aOZ1CnwgXsZU8=;
 b=X6KzYPOSj+M8LJ+uyfcd1xgN86K/vvCPuoj/pljBrq9G3DmPLZO53ZOkpdUz7L3YGVVrcPaSGO9DTtpU3y+9cH47WGLRSh5n2b/5SCPsS6wvYu13+X88Ts15AaKVveQIJ8tpsBgiMugiWwiTMuU9EFeR28b9YWam+6Hrz7IPU743138TJid+ocjN4F++Cpm0psUdesn3zu6uX6a4TJuuv6u8yzWsLiZ/GPOVCj9EWNwcrjT/MZMwLFs9wk9csCvNbAcoTPgWo2h3hYIJdIToLbB+DEnDKIlphy04onU0obYs5VjUxb/rtuUv+abEHd4z9dXhJ4dp5zr2rRS2z/jz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB7067.jpnprd01.prod.outlook.com (2603:1096:604:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 00:42:43 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 00:42:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests: Add a few missing gitignore files
Thread-Topic: [PATCH 1/3] selftests: Add a few missing gitignore files
Thread-Index: AQHbHp6h7sKcm6nC9kyklV8hFL+a4LKH80EAgACYHIA=
Date: Wed, 16 Oct 2024 00:42:41 +0000
Message-ID: <7c0589df-d96b-4897-aff2-2584c2cc4470@fujitsu.com>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
 <087279ce-7fd0-49f3-b578-2d1b82852e3d@linuxfoundation.org>
In-Reply-To: <087279ce-7fd0-49f3-b578-2d1b82852e3d@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB7067:EE_
x-ms-office365-filtering-correlation-id: 5b25b92e-6beb-430c-13d0-08dced7b7208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlY1L05GbHNYUUpvL3VUaEMzb2pOUWVPMGlNb0N3ZnRoRm1INzk0Q00wQkFo?=
 =?utf-8?B?eWYrU2FoUFJrbXQvY3IvdFhrT0RKay94RjdMOGV0MkJ5TExPRTVVR0xHWVdB?=
 =?utf-8?B?ZEd4dUdMVk01Q1UzVVM3ODdHQzZ3VXlTcTF4MkVRUVVhYk44T0YwSkFqWFpO?=
 =?utf-8?B?U0lNL1dRU01QV1pwSjgxbWV4MENocytlUE1Da3hvY01MQ24rYlplSzhFNHhv?=
 =?utf-8?B?dW1wMU9VK2xkWVd1YUxLSzhRd0ZBejl6Q1gyZ0cwWXVCcTBzaDYxeTQ1czlK?=
 =?utf-8?B?azhMSFcxQllVR2JJQmEwM1U2V05odjFjRU85MnpRQ2xxZnVkMnBMMlBxMU5z?=
 =?utf-8?B?bVlQUEJ5aU1zMFQrNW9FMHlKYTFFYU5tWTdlL0xZMlZtdGJRblJsNTBWZHpz?=
 =?utf-8?B?Y0xwNnJhK2ROR0JHcTBHTmcvU0dIVGxOL2d0a0hqOXRROGZhZFd6WHpGK3Jl?=
 =?utf-8?B?WDJzWTBESC9hNXR4bUs5Zld1S2FDTjJQYXlNNWNlZzAwbXMvSm1JSExweEt3?=
 =?utf-8?B?U2pSK2EyMmFBbjB4MjNnb2NueUVOeXVscEovYW5MT2RRYTA2RW83UXlTOU9v?=
 =?utf-8?B?ZmtUTW81a0xsdFBwZlN1UUg3N2ZkbjNKcFBOdTdORGZFWnhPaXpHcCt6Q3dT?=
 =?utf-8?B?SjNWay9qTHpuOWR0QlpGaXlYaDBxVFcxVlJhTHdjZnRDRWowNHYyN3FCWlNU?=
 =?utf-8?B?bDB5clR1VXM1Nk1xOExVQnZkQXFkMmhoWHFOZVh3YnNvOG5oRC9YV01RWnlh?=
 =?utf-8?B?Mmd3cHo5S0Jta2hXemUxeXpqSFpzUGRpMmlKemdQdVFzWS8vUzVUbjZTMDV2?=
 =?utf-8?B?MUZHcGlMT1FIK0MvWXBJQkgveGVxSy91ckRtT05BZnhrRE9vcXN2YkNUdnVC?=
 =?utf-8?B?NlVyWHM3K2R0OUN4bFNiWjlpcktheERYaEQza29KeFN2djk1T1ZwOStYS01F?=
 =?utf-8?B?S0NQbkRnYkdRVGlOVkZ1V1M2d0t5UXFlbWY4dStMNkZFRWxvOStyWjJhMHdZ?=
 =?utf-8?B?WC9ET1FpZ3BITEdJSHQxdC82UE1xOWdYZEY3YUtLVnc4TDFmYXJRTU1OMnR3?=
 =?utf-8?B?RnhWcVUvelQ4QW9nNlpFTjdwSysvOTlVY2ovMlczK05hUDRqZzBGUFBMeGpt?=
 =?utf-8?B?YitNSHFvVXZ3VmFlMWkzeGFCdWM2eHVBUk1aZldpSEZtaUtZTWQzWkpYa1hr?=
 =?utf-8?B?YjRBMUV4Rmxkc2tKeEtXci9TcVFYVmFTNk5xTFlOa0ExZVp6WExqVVBOdlB4?=
 =?utf-8?B?ZXhqSVlGcm1xL2U5S29iWlZCL1FDNnJYaXVvVnI3YmU3U1k2UHRmZzVrSEpZ?=
 =?utf-8?B?RFVCcVFEYnU1S0x4REx5Q3RqV3RMWmRObDB2MnVXeGZscXZ5blhGUlVkamN0?=
 =?utf-8?B?bzJvc3FjVUUvMEgvVmRKZkwxdzFpK1FkSllLUUNRZk1OaFVJNEV4T1hjQ2Mx?=
 =?utf-8?B?RmtOOGZ2TU9WQlpjLzJDTXE2Y1orN2xhOGd2UGlpY0FIbm1QL0Z4U0l3WXhs?=
 =?utf-8?B?QXBUWXNGM2p1SDJ5ZlR3NzFTVUtnSlRmVmdDVUZEUWQ4S2p4QmdTTExXdGg3?=
 =?utf-8?B?TW54N2E1OWRhbVh1VVVRWlNrTGd5eFAvOEU2aEJrN2pQdlRXUHA2SEhpYjlT?=
 =?utf-8?B?RkxCZFQwRXo4UWdES0lMTDVtRUk0b0JvRnYzYklpT1ZKQko5Q2thWGQ1ZmUy?=
 =?utf-8?B?T2p4ZUM4QlBoWEJPWHU4cEpCZHdjbW5mcDJRZDZKWWc1TWtCaytrQkVtdTJH?=
 =?utf-8?B?Ujl2bE9wSm1yZVdianZ0ZXdESGswOTZkSlNWRG9iZkNHSWszUnBNVXpzdFBL?=
 =?utf-8?Q?BAsRe9lpKqK4Z+nonLvfITwfeKKAnpjxKIv4s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3BmRjRlL3YxZTZKVTBoWHZmdXFqOWxjU1hpYWRmbDVBempTT1IxWXBrdi9O?=
 =?utf-8?B?cmdJYStYNXErQVpBaDk4QzVCeVZhZHdac3hNRWVKR2VwNENMczB2NHVEanow?=
 =?utf-8?B?RkdzSmN0c0JSUGd0T0x3WEhNVy9ML3FPWjFFQmZwdWJJeFZCZGpnQnFKQVFp?=
 =?utf-8?B?Nk0rNFIxUkNuR3R4RG5oOXlRUW4rNzRoUXdreUJVNlBFSk41aGU2T1h1ZGJS?=
 =?utf-8?B?blhOeTJjSUVXRHFGYXFGYVFyK0hjT0xqNTNzVTlGMWV2Z0R5b3dOdmxoNk1y?=
 =?utf-8?B?QjdGdGhhSFZPeVFHS1VJN01mZkRIZzQrU2Y1Z25BeUNPcWk5dHIyV21Qd0dh?=
 =?utf-8?B?bDA2MjhIekdYakxlaXZJWDVzaHp5TFYzUktNeHMyeE9vUmltQzdpbTdzS2hk?=
 =?utf-8?B?ZUJYMUlESW5NaGRhSmFvSUVXWVBORGUrSlpVemNXbFJwUi9RYkNsUXBSV0pu?=
 =?utf-8?B?VGhvckt6NVF6UjJWaDhPd2JQR24xcnhxVEtwY0lsdU9pdUkzMUVDMXlkeU9K?=
 =?utf-8?B?eWlnM0tzZ1pXOUhKQkthZVUzcWw5QWh2aHBGU0hoWmg5WVJzSWFvVjBvYXJY?=
 =?utf-8?B?NEFqSG0yMzA3V0NhKzhvaGY3MWdxc05sUVBramI5TFNjMGxxUkxXTzJtb29Y?=
 =?utf-8?B?Sml1b3ZkaGFDdVhkMHJLK29MRWZiV1VFVmpzK0Y0VXJQNUt6bkRVOElHUzgv?=
 =?utf-8?B?RCswakdLNFhoTitVQjFQUG9IL29iNXE1eHNhM0pZd2prZUxLNFZqKzJ2OWN3?=
 =?utf-8?B?aTVzb2dpeWI1T2Z2aHo5WjJ1c011N1pzYkxYRldjaWFXdlIvZkU5aUg2T1pV?=
 =?utf-8?B?d0s3SkpSU0dvSTVFQTgyc3RrM3NxMkdXd0NKVWFER1Y4djU4ZS83ZmFjRzFt?=
 =?utf-8?B?ZmZGL2FKa0FsWXZVOFhQUGc0dEFjMTlVbTdlYmtjcEZ5R1hNQ2Zmc1YxQjZh?=
 =?utf-8?B?STAzR2ZnTVg3MUpCQzNvQkpZbFBuMGo5bTJIeFFYMEpUM1FCZzZSYjBRYVJH?=
 =?utf-8?B?WVpjRUx5MmRpamlSWkJiMVlUbTZOR1JrbFBjdVl1TUpiMzdMRllYTWpZWjVz?=
 =?utf-8?B?N3EvNWZoME8vbVdzTnZvcjFPQWtHMlhhcVZPU0FPcnJiTWVUME1HWHNHV1JJ?=
 =?utf-8?B?MjFFM1JYZXZWVWtVYlNLSDAwWGhCQnhEZTFCMXZ0SVBTL2NLYXBtYkZ0TXoy?=
 =?utf-8?B?MXVtc0V1UUF6ajRZQ3VwNmQ1SkVnbGdhTzdwQ1ZycjNtNHRJOFRtYkxkS3Vk?=
 =?utf-8?B?VEdRR0NBOFlXamlla0Y5MUtNVW5oeTRVYjZqbCtUYjE3ZjgraW9ZVDZLaEJD?=
 =?utf-8?B?cDdWWDZVaVViWmdFTStPUW1mY0lnSXlWK0d4em1MVDV1TDhWNTNTODJSVDE0?=
 =?utf-8?B?RWxKR1dlaGRhWU94QzQvQzVoanVXM3lXQ1lQYUx4Ry9QOXBuSmp1STZjeDZ3?=
 =?utf-8?B?NUw0ZjhIWGkzMVQ0RnIwWjNyQkRRMHdSWms4RUNET3UwTVNQNFNRYlRVZFNC?=
 =?utf-8?B?Z0xYbWowZmJhb1ZjMmJYd3l4YWFZU2FjUFVqYW1TYVFnMStGNFovYjJNdVAy?=
 =?utf-8?B?Uno2cTVPaG51cVBoMllicksvME1wMTU2akdVUE5mOHI1b2dWdE5HZmxBTm9R?=
 =?utf-8?B?c1Z3enRsMnRkVHUxUVhQSWw1eEdTdTR6NWlaeWtlZFU4YzV4R3dJUFAraXJI?=
 =?utf-8?B?eUxQYnNXVmczRU5SQ0xrK1k2ODVxM3A1c1Z4cGJHOTdrdTJ4bUdld2NldnVh?=
 =?utf-8?B?L1FnVGVPV3hBamR1V1R1YXVUQVpVZHJWdmordkR0eHNydDI5VlQ1ditCV0Qv?=
 =?utf-8?B?TExndk10SU9MK21zdzEwaHQ2NTRMNDlUMDRhUDJScUY1TlR1MmZZWDJpUjF5?=
 =?utf-8?B?QWxvazBsR05ZODFPa2VxNytMNG1iNTNzMWFGcGhpak9UYVk1QnpuNzgxSDNq?=
 =?utf-8?B?Z0x2VUtEQmdOd2NVaEZRQnNYRThHc0dGUDdlUnZtcGM4SHZFZHdOVzFidWdp?=
 =?utf-8?B?OVNqWldRbE5sTmc1MVc1eUxQMkNHVjFlWTZYWm5sSmkyMWRkVVlsSmpKSWhY?=
 =?utf-8?B?NkVYdi9WdHBBS1diLzlwWEtXVGI0SzIzUGhrM0svSGVhWHlXSTk3YW5idUI0?=
 =?utf-8?B?aWx2T3hDQis3L1dzSHpzamVudDlGelB3bGhtWVp1N1JudXkzT2JRaDYrcmNk?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FA352D14BE1A74688DF1E7AA2E23984@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MP9dAuSlTFzgqjWgU6V3NSGcaB3NXblbwTdewoNLfEfOD93dprGz2S4U7UQiKhyvQNMY1st55c0jWCD3EM4TX4fVMOXJxwh1M3GvRz7y571nz+3jmEIIS++4aSGJozWbiMHj0vKwUiJGa9FwO2gy4cvdzV8R4jVXdNPGQZ3qLye7K2xEtAT8eCd429/bJlx8bayEDe1DG0dU0nKqXyry5YRBxRhMkNzsUy2uhH7kvdXhwJh2jAwE4X8dFCQcKl6jNh0828ZC21oOvqqGEBcvEZFGBz3dd2IEM6gykzxs6g1cdZcnndXC7AxDBFy/XHpobBbJRI7bGVnqxWU3nOIzpmUG+E3N7lV3a9U44SDJm1ne6Kl7WgEa756CxO8XbEE7NuBj5rV8A/MDoTqp9tADlwIxzsFn4GquhqsYsndsh4OAbcAs35MepXc8ZI6VQrGY0lC/AMUhAINQdV3bg9JOJaBKKKIZNJBLW9onYc7ckJY83gSBl/6T5Y3J+3SlZHewZHbdzHW4K5Zp3clY1eESgNAj0TtpcxeDK+G1jTwe7uOk/CEk3+Ue+KqIEz5qCEg7KhUa3jXpjHAqqls1KoIrLE+lmVeZOByHEjIe59r9t8jws026hF7HQM/MlBIJLFEm
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b25b92e-6beb-430c-13d0-08dced7b7208
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 00:42:42.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AiHYZ6RAOrMcPjHUidDWRitkOihboALCYyanc7ab4Fb+z4TZlVmfzyE05glcrT5qa1fcQwRHAqk4tmb0tW+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7067

DQoNCg0KT24gMTUvMTAvMjAyNCAyMzozOCwgU2h1YWggS2hhbiB3cm90ZToNCj4gT24gMTAvMTQv
MjQgMTk6MDgsIExpIFpoaWppYW4gd3JvdGU6DQo+PiBCaW5hcnkgZmlsZXMgc2hvdWxkIGJlIGFk
ZGVkIHRvIC5naXRpZ25vcmUNCj4+DQo+PiAnZ2l0IHN0YXR1cycgY29tcGxhaW5zOg0KPj4gVW50
cmFja2VkIGZpbGVzOg0KPj4gKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4g
d2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCj4+IMKgwqDCoMKgwqAgYWxzYS9nbG9iYWwtdGltZXIN
Cj4+IMKgwqDCoMKgwqAgYWxzYS91dGltZXItdGVzdA0KPj4gwqDCoMKgwqDCoCBmaWxlc3lzdGVt
cy9zdGF0bW91bnQvc3RhdG1vdW50X3Rlc3RfbnMNCj4+IMKgwqDCoMKgwqAgbW0vaHVnZXRsYl9k
aW8NCj4+IMKgwqDCoMKgwqAgbW0vcGtleV9zaWdoYW5kbGVyX3Rlc3RzXzMyDQo+PiDCoMKgwqDC
oMKgIG1tL3BrZXlfc2lnaGFuZGxlcl90ZXN0c182NA0KPj4gwqDCoMKgwqDCoCBuZXQvbmV0Zmls
dGVyL2Nvbm50cmFja19yZXZlcnNlX2NsYXNoDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiDCoCB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9hbHNhLy5naXRpZ25vcmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMiArKw0KPj4gwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3Rh
dG1vdW50Ly5naXRpZ25vcmUgfCAxICsNCj4+IMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21t
Ly5naXRpZ25vcmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKysN
Cj4+IMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9uZXRmaWx0ZXIvLmdpdGlnbm9yZcKg
wqDCoMKgwqDCoMKgwqAgfCAxICsNCj4gDQo+IFlvdSBhcmUgc2VuZGluZyAzIHBhdGNoZXMgd2l0
aG91dCBhIGNvdmVyIGxldHRlciBhbmQgeW91IGFyZSBtaXNzaW5nDQo+IGtleSBwZW9wbGUgd2hv
IHNob3VsZCByZXZpZXcgdGhlIHBhdGNoZXMuDQo+IA0KPiBDb21iaW5pbmcgc2V2ZXJhbCBzdWJz
eXN0ZW0gY2hhbmdlcyBpbiBvbmUgcGF0Y2ggbGVhZHMgdG8gbWVyZ2UNCj4gY29uZmxpY3RzLg0K
PiANCj4gUnVuIGdldF9tYWludGFpbmVycyB0byBzZWUgd2hvIGFsbCB0aGUgcGF0Y2ggc2hvdWxk
IGJlIHNlbnQuDQoNCkhleSBTaHVzaCwNCg0KSSBzZWUgd2hhdCB5b3UgYXJlIGNvbmNlcm5pbmcu
Li4NCg0KSSBkaWRuJ3QgZG8gdGhhdCBiZWNhdXNlIHRoaXMgcGF0Y2ggc2V0IGlzIHNpbXBsZSwg
YW5kIG5vdCB0ZWNobmljYWwgc3BlY2lmaWMgZm9yDQp0aGVpciBzdWJzeXN0ZW1zLiBJIGp1c3Qg
dG8gbWFrZSB0aGUgY29kZSBvYmV5IHRoZSBnZW5lcmljICpSVUxFKi4NCi0gYmluYXJ5IGZpbGVz
IGdlbmVyYXRlZCBieSBrYnVpbGQgc2hvdWxkIGJlIGluIC5naXRpZ25vcmUNCi0gdGVzdCByZXN1
bHQgYWxzbyBzaG91bGQgYmUgaW4gLmdpdGlnbm9yZSBhbmQgY2xlYW5lZCBieSBtYWtlIGNsZWFu
DQotIHRlbXBvcmFyeSBmaWxlIHNob3VsZCBiZSBjbGVhbmVkIGFmdGVyIHRlc3QgZmluaXNoZWQu
DQoNCg0KQW55d2F5LCBJIHdpbGwgc2VwYXJhdGUgdGhlbSBwZXIgdGhlaXIgc3Vic3lzdGVtcyBs
YXRlciBhcyB5b3VyIHN1Z2dlc3Rpb24uDQoNClRoYW5rcw0KWmhpamlhbg0KICANCg0KPiANCj4+
IMKgIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Fsc2EvLmdpdGlnbm9yZSBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Fsc2EvLmdpdGlnbm9yZQ0KPj4gaW5kZXggMTJkYzNmY2QzNDU2Li4xNDA3ZmQy
NGE5N2IgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hbHNhLy5naXRp
Z25vcmUNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Fsc2EvLmdpdGlnbm9yZQ0K
Pj4gQEAgLTEsMyArMSw1IEBADQo+PiDCoCBtaXhlci10ZXN0DQo+PiDCoCBwY20tdGVzdA0KPj4g
wqAgdGVzdC1wY210ZXN0LWRyaXZlcg0KPj4gK2dsb2JhbC10aW1lcg0KPj4gK3V0aW1lci10ZXN0
DQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3Rh
dG1vdW50Ly5naXRpZ25vcmUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9z
dGF0bW91bnQvLmdpdGlnbm9yZQ0KPj4gaW5kZXggODJhNDg0NmNiYzRiLi42NmEyMWYyODk0NTMg
MTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVtcy9zdGF0
bW91bnQvLmdpdGlnbm9yZQ0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5
c3RlbXMvc3RhdG1vdW50Ly5naXRpZ25vcmUNCj4+IEBAIC0xLDIgKzEsMyBAQA0KPj4gwqAgIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+PiDCoCAvKl90ZXN0DQo+PiAr
c3RhdG1vdW50X3Rlc3RfbnMNCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9tbS8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vLmdpdGlnbm9yZQ0K
Pj4gaW5kZXggZGEwMzBiNDNlNDNiLi4yYWMxMWI3ZmNiMjYgMTAwNjQ0DQo+PiAtLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS8uZ2l0aWdub3JlDQo+PiArKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9tbS8uZ2l0aWdub3JlDQo+PiBAQCAtNTEsMyArNTEsNSBAQCBodWdldGxiX21h
ZHZfdnNfbWFwDQo+PiDCoCBtc2VhbF90ZXN0DQo+PiDCoCBzZWFsX2VsZg0KPj4gwqAgZHJvcHBh
YmxlDQo+PiAraHVnZXRsYl9kaW8NCj4+ICtwa2V5X3NpZ2hhbmRsZXJfdGVzdHMqDQo+PiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L25ldGZpbHRlci8uZ2l0aWdub3Jl
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L25ldGZpbHRlci8uZ2l0aWdub3JlDQo+PiBp
bmRleCAwYTY0ZDZkMGUyOWEuLmVlZjhkNTc4NGU5NCAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9uZXRmaWx0ZXIvLmdpdGlnbm9yZQ0KPj4gKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L25ldGZpbHRlci8uZ2l0aWdub3JlDQo+PiBAQCAtNCwzICs0
LDQgQEAgY29ubmVjdF9jbG9zZQ0KPj4gwqAgY29ubnRyYWNrX2R1bXBfZmx1c2gNCj4+IMKgIHNj
dHBfY29sbGlzaW9uDQo+PiDCoCBuZl9xdWV1ZQ0KPj4gK2Nvbm50cmFja19yZXZlcnNlX2NsYXNo
DQo+IA0KPiB0aGFua3MsDQo+IC0tIFNodWFo

