Return-Path: <linux-kselftest+bounces-18152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4FD97D0D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 06:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F214A28418A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 04:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B09C2AEF1;
	Fri, 20 Sep 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ODIEsdOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017714290;
	Fri, 20 Sep 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726808222; cv=fail; b=GVEPuE78jRyx1jZOiVeZfp+jwaZXRgQ9276B+rXeQw0TaFdjrn4paLPRrGmf1Rzpxlj1Hz0wfh3QHJwnW3YmLg+7ePyyX/+KL5Pi48RqTQkdwzrx1tc5Vz5+9OPtXivuktyRJhisbALuRqKonxVPpL7CavaZqrPJi4XcuTQMC28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726808222; c=relaxed/simple;
	bh=Yi24It3EbqRXuXPPc35vwfsi0L15FfImi2dpjCCb02Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0MEFOef5dJIIEW5oqAWcM6rvugTEQRBVOO0rUOFl3Ujtn5PY+BxnvBlOKcpGTds7uPkD9QOkkcjNFrk/dkz8rIqpNuTgzljux/RdYAQB6nHkNZRm/keUBZ21I6VMieE4UR6iDPrYsM8Hp8ULbB0vihOAvuqt+I3e8mXxuYWyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ODIEsdOZ; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbLR/ZheX1T9ovbmV4SZ7+v5kDm5BMEvrd1Lr085eh+2w1S60hLVjZ2wIOgy7iapJmxr6QdSSY5ZvfRdl8Scmtd/w2D+IG78n5N1pPXvQhrxhsjFAsX/GOu78YajGzHCZexR2KLlgr1uZAJInZWu5XsQxnyKWOcWl6uOQeuunM3djB87244oXkXie2p7BSDosgttG8yT49Bit91a4nRddI0/vfuLnTsuB1YoU+e9NFgcIP4zxHXbskU+SE8+QYnH6mA+1tAtASA2EMNSkQ5KXd/TwBXfZc2XM0hKnswJwqlxRRkzbeiRf4OM2oNaH2EqWhI7Yx4GcPnJTbOGpMy24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi24It3EbqRXuXPPc35vwfsi0L15FfImi2dpjCCb02Y=;
 b=Sc/CSCxIRjOylwxDTiVdGbT3I+w7kKxetjx40U6f1lphUqmRi8ST1T8W8VQwF1uCfMdas2LwLNg0Qiva3XA2oSMromRj79BvuG1kTQj6NI4CUYQwxRZ9IH088rvcyocYCLsSF9CN1tDmALWsWLuaSW9qd1X1l6G55WdEhpVbBxJk2d4MpCz9dGIB9ga7pQ0vf5uVAs9+/J2IJP//Kb5uk/OzE/d6Q+Dc++cTCG8lv1wbWpLi9GUVFy1KdoLzxcuhd14yjvRMwlAMyu2lU+0Dqcj7135D1hMqRlR45Zh8OgK0+1dR/wpFpcKHlJ4wwH5ln3Gc8BquLxqKHruSD7bc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi24It3EbqRXuXPPc35vwfsi0L15FfImi2dpjCCb02Y=;
 b=ODIEsdOZdwxD6d4gFBUYoz7q/dPFXyiLqG9E5DIrZzB6CbCmnBXyBI1k/7/9+pdkyG/KEXKU8f3NdDnha6gA4gXrb7zJKlHyf/uJh9Ig9yFMnyMy4LlGrvciTzpiO4DElIAqYULdOUKv2H0f6qRwa34t70KyL2LV0ZziA///eJUUsG3zmURAr6LLQDWXB7LTWNSrOQrAJIq9DkWkcmRq7Ww5NoauPh6jo6QzkUoRvqjVu54pl0q/Fw3zaQ1AsbwkxCTZnO4uy0Po4NlNGFBVpAQWfMOjZKLuvrs96gkhR7pdC9avxx7X8L38Jp/6XuQMAA5DXiy8fBw36X4mFZbg/Q==
Received: from DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 04:56:58 +0000
Received: from DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb]) by DM6PR11MB4236.namprd11.prod.outlook.com
 ([fe80::ea6a:8f25:ead5:8dfb%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 04:56:57 +0000
From: <Mohan.Prasad@microchip.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <horms@kernel.org>,
	<brett.creeley@amd.com>, <rosenp@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<willemb@google.com>
Subject: RE: [PATCH net-next v2 2/3] selftests: nic_basic_tests: Add selftest
 case for speed and duplex state checks
Thread-Topic: [PATCH net-next v2 2/3] selftests: nic_basic_tests: Add selftest
 case for speed and duplex state checks
Thread-Index: AQHbCOSlvQ7K91w7q0WPWb9W8OejN7JdfWiAgAKc8rA=
Date: Fri, 20 Sep 2024 04:56:57 +0000
Message-ID:
 <DM6PR11MB42366C3098D9DB2C5319B99C836C2@DM6PR11MB4236.namprd11.prod.outlook.com>
References: <20240917023525.2571082-1-mohan.prasad@microchip.com>
 <20240917023525.2571082-3-mohan.prasad@microchip.com>
 <66eac9a9e3e22_29b986294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <66eac9a9e3e22_29b986294c7@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4236:EE_|DS7PR11MB6296:EE_
x-ms-office365-filtering-correlation-id: d3ff2c99-5913-41db-17bf-08dcd930a7b9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3dTcklnLzFteHlkb08wVHozUTJuTFQxUG5EdDFacElGQi9PTmlya2FPUllJ?=
 =?utf-8?B?MndQeFQ3QXhGU3NuWWZiQU8rUXJEVlNsT3dGbXE5WTFQWmpPblA4YjZpNVdW?=
 =?utf-8?B?VUZTdG9Gb21POVhuQUJ3TUlieXdHZEVDZjJYZmxaR3FEVnFnVldiUldwSGhU?=
 =?utf-8?B?c21oMFNuQkRzNEQ2MmhFblM1dGN0UVJ1WFNQWUM1ZFZESml2b3RkTnVneFRo?=
 =?utf-8?B?TkN3VlRoWE9KbFBnYjRjSmR1ZzMrQ2VlWi8vTlFKNitrOFpVY2Jnb0JxUG1T?=
 =?utf-8?B?ZmdIaWkzN0d3SCtPcTMvdjl1NFd4V3FObDlNeEZHZTVnUFJaeG9rYnNackZS?=
 =?utf-8?B?UXAyeU16SXphaStLYjhZR2pHNS9kWGlqdXM3S2YwRzB6dFpOR25IbVNDd0g0?=
 =?utf-8?B?bkFsS1JEdG5tRzVzS2NuanlkVmpEZkVxVVhIazZSak5Vd3dwSUFvVW1KWEpm?=
 =?utf-8?B?UjF0bkorWVRqQ09IL0xKTlFIRzM4dnVDWTRhbExZOVBUZFVjODZ5ZTBFNkRw?=
 =?utf-8?B?MkJJamErMFg3L2I3NWxUZXpsTkNuek8renhHQU1nK1p3L2JoV3RaSzFWVy9Q?=
 =?utf-8?B?b3dNRUI4dUY2VFgxSWt4czZPZzYyMGp1eFNqemJlUkRWZjBCU0s0bUhMV2h0?=
 =?utf-8?B?R1BTaFhWSDFZK0ppWiszTGt5YWtHOE9Fek9Wc0h2ZTREQnEwZ3pRdUZTU2ZO?=
 =?utf-8?B?bW5ZcHVKNjQzQ0ZYV20wY2x4VnlOZmFSenA3YnRnY0VEUDMyRE1vMnBnYzZT?=
 =?utf-8?B?UXFySDh4VFNCOXZuMVJ4VFFEemdpWjNEcjZvRkhnb0dkWC9GYXplZm9vcXpK?=
 =?utf-8?B?Z0xLOTN2WDZlNkRMY3Bxa0VheXNvWS91SW5Za2U4WUdjQzF0dUhzc1FPbUIw?=
 =?utf-8?B?R1VFSzQ5MjlDcld5RC94WUVlWExVVlVzQzNjL3FIU2NOVFBObkdsQWdRc2sx?=
 =?utf-8?B?OFl6OWRURXJUU1gvQ3RmM0dRRDI3aUw5blI3bGRtS01KVW5UcjNhRVhmL3hr?=
 =?utf-8?B?OEVObnZXeFFRN0ZGa3FLb0YvNkNZUXJ0K2NvaStHVGpGdmJ6Rmg1YUdTUm81?=
 =?utf-8?B?ZjBKR3dZR3dXdHZEQWpQbTlKeWNLaUNyMTBaRktLU1Z0SGNRS28wb0ZNYjY1?=
 =?utf-8?B?Y1EzcEo4WWlsSEdCZWhBTFdKUEtYR2RDYlNwMHcwSjQ4Szg1ZnRiU3YyVWUr?=
 =?utf-8?B?d0hvbmVsTkdxYUNDdW9tNUc1MmQ2am5IWkVLN3prMHVCdzdXb1J4VUNRVnR3?=
 =?utf-8?B?MlJXNXF5ckJYWXFubWxyQVo0cnUzRklyT0FXTGJGa21DR1FTWDNKam1hU3Ns?=
 =?utf-8?B?VEN0U3NIalpjSkVrT0pNVWJWeGRNUnhoeVpWVFVTT05uZjNwV2lwL2grS2J3?=
 =?utf-8?B?N1J0SWJzVlY0b0xyRWdZeENqUFVxTUtxeVZBMVN2ZWJnYmlES2RHWnRZOGtB?=
 =?utf-8?B?VUFpaElYKzhydE9wcVR4amRPSVlHV1lGanNtNytUR1FuMGRpSTl6bHdwOTQv?=
 =?utf-8?B?UFNjaVhWVlNBeE1IYlFKekU2ZkU0NWtDNnBicWJFeU5Lc3V3Nk1EU2czdzRo?=
 =?utf-8?B?NGh6VW5yYW1oUlI0NUh2QUdpV1lqSHFDZnJHZmxGWURlM2d1NGZEYWt4dmR5?=
 =?utf-8?B?MTNodi9xM2R2ZkQ4TmJUeGZuTURWNGxDWFRzRjVjb1JwamVNNW1PTmlSSTNN?=
 =?utf-8?B?MkF2MER2VnlxNERpOU56Zys5bkE4c21EWkZiUXRJYXEyaVdoZmtEYml6eStZ?=
 =?utf-8?B?MHl3ZVpwMURjaG9vMzhHSCtLN3dmWGJqNCtnQnpKUGxwSUtDY3hFOWR3UUIv?=
 =?utf-8?B?STNUcDhvWlJGQ21UcnNZUWZFc0kzaEFVNENLc2QvWjNxZmZaaytMVlhBYlAw?=
 =?utf-8?B?aW8ramtSTjFHZmhXbW55aXR3SGs5RHZCc3ZHOVUzVmFmYWc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3o4VWF2NHZWek96Nlh2UGxIdGk3VG0xSW9KV1VKdVlCQXZqYlEvZVI4UHpV?=
 =?utf-8?B?UFJuZ1pMdTZtbEMrN0xRT3hESUlxbklQT3EyUi9DeDcrbURqQys0WmhSTHhq?=
 =?utf-8?B?TkNaV3hKck8vb0NMK3hCbnY3aTdlUGNWcmJ3Y05mYXg3OFhYazVSVStnQ3hK?=
 =?utf-8?B?czFlYUozd1lVaWJGenN5L3c1QnRFbVpHRDJJSlhNZUhjMWZoT0ZYL2t4L1N6?=
 =?utf-8?B?dnVRaHRkTkl4L0FxRGc0azlKU0s3TUxNaTBUYU9aem1xTFVqVFBQKytaTGhM?=
 =?utf-8?B?ZUtGR2pOOGVRTGcxYWd3ZGNzblJpUTQrR29CczlOa0pPcC83OTBsR3kxQUwv?=
 =?utf-8?B?QUVBa2lUTzNOOEhuNVQwL2tlSE0ySEVCZXBHT21xcngzZEVJcHRGZWJHbG5n?=
 =?utf-8?B?di9tR0UxdWVOUG5KeFUyU0ZwdWxRLzhvMU9DNEIvSUZUNEhjNTlCRDJCRTA1?=
 =?utf-8?B?bWZPZUpBUEN4L0JWUW9vemlOT0VmdEFsL3c3UGp6dWlFbDY0SUsvL0RncVdw?=
 =?utf-8?B?ZUtuY0FvY2pNT1VuSXdEbjB5cDlYd01SaGpLL0VSVnNEOXlwVU5nWW9idEk0?=
 =?utf-8?B?UlZHQndQd2lDZmFwZDFlOXh6cmpvWjcwUmg2NTloWVFRZ3VtQm5HVU10Nytz?=
 =?utf-8?B?TmNJZjFXMVVuWEk1Y0xmbG5mWGkzRlFqQ2gwWm4rc0JCQ2RPeTVjdnNBdEdT?=
 =?utf-8?B?VHQrT3BRTTRqaDh1aTZPUFYzR2hScE5iTlAvcW9TcDZLOWJMYW5tUjIwSWdM?=
 =?utf-8?B?SFFoUTVBYUNHeTU0U1M1aVJ1eUdzaUUzMTd1TTVQeTJTc21EbzdLd25xUlJN?=
 =?utf-8?B?eDh2MXp2NTZTaDlzYVpYQ1g5RGlSYlBjRVN3bEVRU0tBc29kMzFTL0l0ejQz?=
 =?utf-8?B?ZnloRFJMdGlGcWxFallDNXZIQi91anNLa3poV1YvWmxzaGwrL0JUa2hzc2E1?=
 =?utf-8?B?SlZQSkZ1Ymx6aEUyWUptVlFZZmcrTVJwK1lCaWJIMkhwdm5HQnpTRW1kZE1K?=
 =?utf-8?B?VDZtWkhwdmlXYjc5elZ0clFUNmIvRVZBYlRINGpsWkdPQytvbHlkZzFuMVNP?=
 =?utf-8?B?THlkTlFOcCtGS2x4bm1nQzIzYXdiNFZvcGkrRWxJRDJrc21MM2RyeWpaRERX?=
 =?utf-8?B?UXdrUW5CVUlNNncxbkdoNDZ2NlVvRVRUeHhpTHllejI0cXUrem1vWVhPQ0h1?=
 =?utf-8?B?QXk1ZStGV2VsQ0lUNU9rV2FBOERuSWhEWjYxdGxseGkwYkl3eEZnd2k0K2Vo?=
 =?utf-8?B?ekdvaUE0eXJQRjNUVk9YVE9SNlY4eWM3cnRsL3RyTnpGQXlyYzF3b2tkdi9R?=
 =?utf-8?B?M2Z5T2taR0R4b2xoRlZxWHkvOHBRWk9yeitHM1ZXZGwzWVl5UlhQcGkvMjdF?=
 =?utf-8?B?YkdyZnhXRldmTkIxcEY4RnhlQTZ6VjdHRTVNNm5FU00xWnRmNk5ncCtWVG1G?=
 =?utf-8?B?aytlRm9aQ0t2RlRraTVsNGJyYUtRTjlKaG9VQW42Yk8ya0szcE1SNGdRNWly?=
 =?utf-8?B?dW9rdXhNSUVtZXJIdHlhUklpbEVUazBlVXZ2T25jQ0c0akFnOXhnRWpCYkt4?=
 =?utf-8?B?Yi9qbTdrT0VNWDYwV01tUlVRUlBONWNkdkNCY0NhaEx3Q0p3WkVkeTVNVHAx?=
 =?utf-8?B?VVZNczJjVS91SnJ2SVFDUncvZzZ2aXFJUFNkbEg0c3JoUXgrY0xnNk9najhp?=
 =?utf-8?B?Tis1NnVHa3JTUzNQczFZanNHZDJxYVZtZzFxUkp1Mk5sRmEwM3FrbGRqc2Nx?=
 =?utf-8?B?cnRFYmdURmwwMzhRWnRsM1BEOFB5UVpZV3pmUkpzVGRaTGxlR0xUNCtkcTRt?=
 =?utf-8?B?SHFMNFJ2cVFMQmFhYWxWN0dMTFV5RUNJWVREWFUwNEVwYjdSd1pheERJVHp5?=
 =?utf-8?B?MnpiWVJoWW9HeTFDcG42ZzRjL3FUOEVvSUlTVFY0amF0dVFNMEovaG9jbGhh?=
 =?utf-8?B?bmwvVGNuWGxIVDlLcVRRcWZwL1l2MHk2ZWdOY3NyK0VHM3VGcjFaczMyRDVt?=
 =?utf-8?B?WElpY0VYZG8xbFZHeWIvTzhZTXZlTjQzeXYwb2pwNzlLaWRueGFBdzJFazBi?=
 =?utf-8?B?RGY1T3hoSE9XWWIyVmgwTlhHbG9yNEFjaDhGQ0xlK0VDTm5nUjc0UE1nMm4w?=
 =?utf-8?Q?haVWWbCvVOo2mEI74q1Ev8brq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ff2c99-5913-41db-17bf-08dcd930a7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 04:56:57.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HF3CEaDyh2l6xer2oY3JEQ++MuAwD77H0FM7oBHRXER501hoF2UZbHSG4XDoa/X6zNw/vosfqOPBncDcwaAtunWjcgYebFtEEmzz2WI3a2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296

SGkgV2lsbGVtLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuDQoNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBNb2hhbiBQcmFzYWQgSiB3cm90
ZToNCj4gPiBBZGQgc2VsZnRlc3QgY2FzZSBmb3IgdGVzdGluZyB0aGUgc3BlZWQgYW5kIGR1cGxl
eCBzdGF0ZSBvZiBsb2NhbCBOSUMNCj4gPiBkcml2ZXIgYW5kIHRoZSBwYXJ0bmVyIGJhc2VkIG9u
IHRoZSBzdXBwb3J0ZWQgbGluayBtb2RlcyBvYnRhaW5lZCBmcm9tDQo+ID4gdGhlIGV0aHRvb2wu
IFNwZWVkIGFuZCBkdXBsZXggc3RhdGVzIGFyZSB2YXJpZWQgYW5kIHZlcmlmaWVkIHVzaW5nDQo+
ID4gZXRodG9vbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vaGFuIFByYXNhZCBKIDxtb2hh
bi5wcmFzYWRAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RyaXZlcnMvbmV0L2h3
L25pY19iYXNpY190ZXN0cy5weSAgICAgICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2h3L25pY19iYXNpY190ZXN0cy5w
eQ0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvbmljX2Jhc2lj
X3Rlc3RzLnB5DQo+ID4gaW5kZXggMjdmNzgwMDMyLi5mZjQ2ZjI0MDYgMTAwNjQ0DQo+ID4gLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvbmljX2Jhc2ljX3Rlc3Rz
LnB5DQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvaHcvbmlj
X2Jhc2ljX3Rlc3RzLnB5DQo+ID4gQEAgLTQyLDYgKzQyLDE0IEBAIGZyb20gbGliLnB5IGltcG9y
dCBldGh0b29sICAiIiJHbG9iYWwgdmFyaWFibGVzIiIiDQo+ID4gIGNvbW1vbl9saW5rX21vZGVz
ID0gW10NCj4gPg0KPiA+ICtkZWYgY2hlY2tfYXV0b25lZ290aWF0aW9uKGlmbmFtZTogc3RyKSAt
PiBOb25lOg0KPiA+ICsgICAgYXV0b25lZyA9IGdldF9ldGh0b29sX2NvbnRlbnQoaWZuYW1lLCAi
U3VwcG9ydHMgYXV0by1uZWdvdGlhdGlvbjoiKQ0KPiA+ICsgICAgcGFydG5lcl9hdXRvbmVnID0g
Z2V0X2V0aHRvb2xfY29udGVudChpZm5hbWUsICJMaW5rIHBhcnRuZXINCj4gPiArYWR2ZXJ0aXNl
ZCBhdXRvLW5lZ290aWF0aW9uOiIpDQo+ID4gKw0KPiA+ICsgICAgIiIiQ2hlY2sgaWYgYXV0by1u
ZWcgc3VwcG9ydGVkIGJ5IGxvY2FsIGFuZCBwYXJ0bmVyIE5JQyIiIg0KPiA+ICsgICAgaWYgYXV0
b25lZ1swXSAhPSAiWWVzIiBvciBwYXJ0bmVyX2F1dG9uZWdbMF0gIT0gIlllcyI6DQo+ID4gKyAg
ICAgICAgcmFpc2UgS3NmdFNraXBFeChmIkludGVyZmFjZSB7aWZuYW1lfSBvciBwYXJ0bmVyIGRv
ZXMgbm90DQo+ID4gKyBzdXBwb3J0IGF1dG8tbmVnb3RpYXRpb24iKQ0KPiA+ICsNCj4gPiAgZGVm
IGdldF9ldGh0b29sX2NvbnRlbnQoaWZuYW1lOiBzdHIsIGZpZWxkOiBzdHIpOg0KPiA+ICAgICAg
Y2FwdHVyZSA9IEZhbHNlDQo+ID4gICAgICBjb250ZW50ID0gW10NCj4gPiBAQCAtMTEyLDYgKzEy
MCwyNSBAQCBkZWYgdmVyaWZ5X2F1dG9uZWdvdGlhdGlvbihpZm5hbWU6IHN0ciwNCj4gZXhwZWN0
ZWRfc3RhdGU6IHN0cikgLT4gTm9uZToNCj4gPg0KPiA+ICAgICAga3NmdF9lcShhY3R1YWxfc3Rh
dGUsIGV4cGVjdGVkX3N0YXRlKQ0KPiA+DQo+ID4gK2RlZiBzZXRfc3BlZWRfYW5kX2R1cGxleChp
Zm5hbWU6IHN0ciwgc3BlZWQ6IHN0ciwgZHVwbGV4OiBzdHIpIC0+IE5vbmU6DQo+ID4gKyAgICAi
IiJTZXQgdGhlIHNwZWVkIGFuZCBkdXBsZXggc3RhdGUgZm9yIHRoZSBpbnRlcmZhY2UiIiINCj4g
PiArICAgIHByb2Nlc3MgPSBldGh0b29sKGYiLS1jaGFuZ2Uge2lmbmFtZX0gc3BlZWQge3NwZWVk
fSBkdXBsZXgNCj4gPiAre2R1cGxleH0gYXV0b25lZyBvbiIpDQo+ID4gKw0KPiA+ICsgICAgaWYg
cHJvY2Vzcy5yZXQgIT0gMDoNCj4gPiArICAgICAgICByYWlzZSBLc2Z0RmFpbEV4KGYiTm90IGFi
bGUgdG8gc2V0IHNwZWVkIGFuZCBkdXBsZXggcGFyYW1ldGVycyBmb3INCj4ge2lmbmFtZX0iKQ0K
PiA+ICsgICAga3NmdF9wcihmIlNwZWVkOiB7c3BlZWR9IE1icHMsIER1cGxleDoge2R1cGxleH0g
c2V0IGZvcg0KPiA+ICsgSW50ZXJmYWNlOiB7aWZuYW1lfSIpDQo+ID4gKw0KPiA+ICtkZWYgdmVy
aWZ5X3NwZWVkX2FuZF9kdXBsZXgoaWZuYW1lOiBzdHIsIGV4cGVjdGVkX3NwZWVkOiBzdHIsDQo+
IGV4cGVjdGVkX2R1cGxleDogc3RyKSAtPiBOb25lOg0KPiA+ICsgICAgdmVyaWZ5X2xpbmtfdXAo
aWZuYW1lKQ0KPiA+ICsgICAgIiIiVmVyaWZ5aW5nIHRoZSBzcGVlZCBhbmQgZHVwbGV4IHN0YXRl
IGZvciB0aGUgaW50ZXJmYWNlIiIiDQo+ID4gKyAgICB3aXRoIG9wZW4oZiIvc3lzL2NsYXNzL25l
dC97aWZuYW1lfS9zcGVlZCIsICJyIikgYXMgZnA6DQo+ID4gKyAgICAgICAgYWN0dWFsX3NwZWVk
ID0gZnAucmVhZCgpLnN0cmlwKCkNCj4gPiArICAgIHdpdGggb3BlbihmIi9zeXMvY2xhc3MvbmV0
L3tpZm5hbWV9L2R1cGxleCIsICJyIikgYXMgZnA6DQo+ID4gKyAgICAgICAgYWN0dWFsX2R1cGxl
eCA9IGZwLnJlYWQoKS5zdHJpcCgpDQo+ID4gKw0KPiA+ICsgICAga3NmdF9lcShhY3R1YWxfc3Bl
ZWQsIGV4cGVjdGVkX3NwZWVkKQ0KPiA+ICsgICAga3NmdF9lcShhY3R1YWxfZHVwbGV4LCBleHBl
Y3RlZF9kdXBsZXgpDQo+ID4gKw0KPiA+ICBkZWYgdGVzdF9saW5rX21vZGVzKGNmZykgLT4gTm9u
ZToNCj4gPiAgICAgIGdsb2JhbCBjb21tb25fbGlua19tb2Rlcw0KPiA+ICAgICAgbGlua19tb2Rl
cyA9IGdldF9ldGh0b29sX2NvbnRlbnQoY2ZnLmlmbmFtZSwgIlN1cHBvcnRlZCBsaW5rDQo+ID4g
bW9kZXM6IikgQEAgLTEzNiw2ICsxNjMsMjUgQEAgZGVmIHRlc3RfYXV0b25lZ290aWF0aW9uKGNm
ZykgLT4gTm9uZToNCj4gPiAgICAgIGVsc2U6DQo+ID4gICAgICAgICAgcmFpc2UgS3NmdFNraXBF
eChmIkF1dG8tTmVnb3RpYXRpb24gaXMgbm90IHN1cHBvcnRlZCBmb3INCj4gPiBpbnRlcmZhY2Ug
e2NmZy5pZm5hbWV9IikNCj4gPg0KPiA+ICtkZWYgdGVzdF9uZXR3b3JrX3NwZWVkKGNmZykgLT4g
Tm9uZToNCj4gPiArICAgIGNoZWNrX2F1dG9uZWdvdGlhdGlvbihjZmcuaWZuYW1lKQ0KPiA+ICsg
ICAgaWYgbm90IGNvbW1vbl9saW5rX21vZGVzOg0KPiA+ICsgICAgICAgIEtzZnRTa2lwRXgoIk5v
IGNvbW1vbiBsaW5rIG1vZGVzIGV4aXN0IikNCj4gPiArICAgIHNwZWVkcywgZHVwbGV4X21vZGVz
ID0gZ2V0X3NwZWVkX2R1cGxleChjb21tb25fbGlua19tb2RlcykNCj4gPiArDQo+ID4gKyAgICBp
ZiBzcGVlZHMgYW5kIGR1cGxleF9tb2RlcyBhbmQgbGVuKHNwZWVkcykgPT0gbGVuKGR1cGxleF9t
b2Rlcyk6DQo+ID4gKyAgICAgICAgZm9yIGlkeCBpbiByYW5nZShsZW4oc3BlZWRzKSk6DQo+ID4g
KyAgICAgICAgICAgIHNwZWVkID0gc3BlZWRzW2lkeF0NCj4gPiArICAgICAgICAgICAgZHVwbGV4
ID0gZHVwbGV4X21vZGVzW2lkeF0NCj4gPiArICAgICAgICAgICAgc2V0X3NwZWVkX2FuZF9kdXBs
ZXgoY2ZnLmlmbmFtZSwgc3BlZWQsIGR1cGxleCkNCj4gPiArICAgICAgICAgICAgdGltZS5zbGVl
cChzbGVlcF90aW1lKQ0KPiA+ICsgICAgICAgICAgICB2ZXJpZnlfc3BlZWRfYW5kX2R1cGxleChj
ZmcuaWZuYW1lLCBzcGVlZCwgZHVwbGV4KQ0KPiA+ICsgICAgZWxzZToNCj4gPiArICAgICAgICBp
ZiBub3Qgc3BlZWRzIG9yIG5vdCBkdXBsZXhfbW9kZXM6DQo+ID4gKyAgICAgICAgICAgIEtzZnRT
a2lwRXgoZiJObyBzdXBwb3J0ZWQgc3BlZWRzIG9yIGR1cGxleCBtb2RlcyBmb3VuZCBmb3INCj4g
aW50ZXJmYWNlIHtjZmcuaWZuYW1lfSIpDQo+ID4gKyAgICAgICAgZWxzZToNCj4gPiArICAgICAg
ICAgICAgS3NmdFNraXBFeCgiTWlzbWF0Y2ggaW4gdGhlIG51bWJlciBvZiBzcGVlZHMgYW5kIGR1
cGxleA0KPiA+ICsgbW9kZXMiKQ0KPiA+ICsNCj4gDQo+IERvIHRoZXNlIHRlc3RzIHJlc2V0IGNv
bmZpZ3VyYXRpb24gdG8gdGhlaXIgb3JpZ2luYWwgc3RhdGU/DQoNCkN1cnJlbnRseSB0aGVzZSB0
ZXN0cyBkbyBub3QgcmVzZXQgY29uZmlndXJhdGlvbiB0byB0aGVpciBvcmlnaW5hbCBzdGF0ZS4N
Ckhvd2V2ZXIgcmVzZXR0aW5nIHdvdWxkIGJlIGEgZ29vZCBpZGVhLCBJIHdpbGwgZWl0aGVyIGRv
IGl0IGhlcmUgKG9yKSBhdCB0aGUgZW5kIG9mIHRoZSB0ZXN0cy4NCg0KPiANCj4gTW9yZSBoaWdo
IGxldmVsOiBiYXNpYyB0ZXN0IGlzIG5vdCB2ZXJ5IGRlc2NyaXB0aXZlLiBDYW4gdGhleSBoYXZl
IGEgbW9yZQ0KPiBwcmVjaXNlIG5hbWU/IFBlcmhhcHMgbGluayBsYXllciBvcGVyYXRpb25zIG9y
IGxpbmsgbGF5ZXIgY29uZmlnPw0KDQpJIHdpbGwgaGF2ZSBhIGNoZWNrIG9uIHRoZSBuYW1pbmcg
YW5kIHVwZGF0ZSBpdCBhY2NvcmRpbmdseS4NCg==

