Return-Path: <linux-kselftest+bounces-28404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BBA54C55
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED174170E85
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894C20D516;
	Thu,  6 Mar 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6fRNZO6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9920B21F;
	Thu,  6 Mar 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268243; cv=fail; b=bi1Q9YPi9rZ8UA1WT4qYlNIfFnvjSxceTeYwiYo5JcnXA0ZKZfULo2MwQplSDZDOFMeGJ5Bd6veTxLoE0Utf85sSYrrfDmIirN/TXNUnZcCOMIL5au51giQv+J9FwbTFNUiBsZ3LVaOoxWkHd8YHKCMk52DkMOuKEqPjOIwwR1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268243; c=relaxed/simple;
	bh=NBW4hd2PYKDdGX9Y7wLrOJ9u2f3o/rlV00WqW6ZARdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpS9FFnB40FKvm7AiPYXghemc073ApyA+A8Zq8S+tduloCxeDadn7Ih8AFZC/coe5ZI6Llc8t718gcsNDIqpm4doGDhel1qtoIDd1ea1mWKX0tSTqP2PMjt60EjgtGD5aWOEihAkhsYVQIKID+++Bx2nBauzIPAE4lOErDwL9JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6fRNZO6; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCZGcJ8eovgEBs+Xsy5h3rpgns4Oc91IgFD4/ZoDIIMLbZ/huFiC8A/FCH78NSTJVKj05MLTwgjXaQgeaQnP//tkNO6nFjvqbSAGjWIq2MZRQFcRRBfse3DvFSyNFXBUbQckNZZHUUNhUCFBfudieNxWDG98HcB+xm7xZ7/IO5m4AsQ+6kvBbRKTSylFysvob9IgedtowYSqo854cfE5ffTjg9yWudckl159da1B4Nv67Y4z7DMwdnUtd90dBY+ANUaCEtbRJz2fUTzLGeyN3rlDMmDSG0/rTRo4t2TVRL9Oc++wbcH+l8cj8E+fGQPAoob+WhXmxhPK2kapuniiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBW4hd2PYKDdGX9Y7wLrOJ9u2f3o/rlV00WqW6ZARdg=;
 b=IobABhkXuPmCwAd+9jhnZk08/d+ktS9Sm5XPmhGcCI1AFD/D7UAX81T1IcPJRzX6Unvjdw7F/uHDzIJdMW0tSZN91hh0Z2imCmbZZHGQXuDB+LQvAeADSTmGVKepZPzKnRbO6syQCOHuWNin9M8LVlqkGgBcxCy1z8AKCwzuq3lKfVkrayEfPuSqiXqiMugUN2rQlesHabU4x7WEa0BUtQaVFlbUwyotJFmUkGgSJgy3irW9eJ4iB9fiMFhi2G+1qP0Lv1NFD8BaV5jtgRr3iZyTQHawYA32FpQ3vhL0/a+zDHgUATr096Jxn1repnO9Ske6Znk/gjlXuhAx4uKN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBW4hd2PYKDdGX9Y7wLrOJ9u2f3o/rlV00WqW6ZARdg=;
 b=r6fRNZO6Rm+7Ad8CCEuil5LM6nxiam9hdOV8tNwb4DZhksj1Mh78wiiBEZKNaPrlBUDFGkYTNQGX+YNtqxzR2AFv4NtLSMrOP6fn+ArEZqvCeJsqIdC6Nf1wGRa8uotDl7lcMQ0UFG305FKKyotUkz+5I7aI4Ky3J/IpvMVJBTfpg0diJkS+mRgMlMUfJ6zkR1WwQkfX38fVAxtHD+RUAGAm6WpdUIMd+AlLJMZQdmWwmdE7RbT2hdDaWqbQ/mjgfOji0i1DnKTLGrLhU8bs3KqlSLJO5HUojR0tz5x/D2jyCMIlXnkufu1uPo6qgMsgRDYJw2ivKHSZFA4KUtr8yA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 13:37:16 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 13:37:15 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: Petr Machata <petrm@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Jianbo Liu <jianbol@nvidia.com>, "jarod@redhat.com"
	<jarod@redhat.com>, "razor@blackwall.org" <razor@blackwall.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Topic: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Index:
 AQHbjQb6WbrTtavr5Eegza7cWS6SJ7NkOeoAgABdn4CAACEiAIABJBuAgAAG4wCAADwGAA==
Date: Thu, 6 Mar 2025 13:37:15 +0000
Message-ID: <60cfc1af3f85dda740ac19ac06a27880e79c9c1e.camel@nvidia.com>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
	 <20250304131120.31135-2-liuhangbin@gmail.com>
	 <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
	 <Z8hcFSElK7iF8u9o@fedora>
	 <f9bf79aff80eae232bc16863aa7a3ea56c80069a.camel@nvidia.com>
	 <Z8ls6fAwBtiV_C9b@fedora> <Z8lysOLMnYoknLsW@fedora>
In-Reply-To: <Z8lysOLMnYoknLsW@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SN7PR12MB6766:EE_
x-ms-office365-filtering-correlation-id: 136cc3e9-989a-431c-ecde-08dd5cb40231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGpTWU1ZcjJ2Vk56Vm5YZ1I4WnRpTHM5YlliVFBsaTZKa242MFRIb1pGUDRJ?=
 =?utf-8?B?YlNtTDVUcHR2bXFqNHFXekgxQWM2TjErSXUzcHExKzdZamtIY3hSeDFZMXZZ?=
 =?utf-8?B?WDhINzBsWWNXdjdtWnc4MDdRMDdqOFRHS1RLSmtYRlZGOVZrTkFMbi9hT2hB?=
 =?utf-8?B?TUdQK2FiM0VLQzJCK3NUaDdtRGlkWXBMYXBUOXhmaTJpZHhCZktOY3Q2aUhZ?=
 =?utf-8?B?VWhuMTVYSWxJOS9ZRlBLVVc2QTJNaXBuOHhIL2F5cUcyUGJ5Z3N2Q1VBV1V6?=
 =?utf-8?B?bjFGMUtWeTN0NnZvTjEwNUc1TzMwQk5RZ2VFQks4YmpWaDE5cXRKZ3psTnhU?=
 =?utf-8?B?djhYVFFvQTdQMFJZVUZxU0cwdkV3aDZrNzFpMDZXcGtLZ1p6eTI0RWRQb3lI?=
 =?utf-8?B?N1VDazJCb0dTVzBuaEcxb2x3SERHaGZtc2dRdjJZdk9Pa3hmMS9XUGdrbGlN?=
 =?utf-8?B?TGJTQmN3cjVWSG93UU5qNDhKR3RCalJ4QjRuZmhXYjBoUUE5RVErSURrcGF4?=
 =?utf-8?B?RXhTU2llWURjK21OZjltamliMldOMFZUOXE4Z2RUeVRNeXBaNkF1TkRJU0pW?=
 =?utf-8?B?YzFzMnBtSm5EcUZwRDRYakNSN01XL3dld2dIbndGQlFxNW5uT3NpV2h4Vlky?=
 =?utf-8?B?aGRMK0dUb1NGSTRFV1UwYkNMUXNZYW5xM1U1dThLMFhkOTE4UzJyQzlwMDl1?=
 =?utf-8?B?QWRpS1g2V1NFeWFyS1VDZnl1VmJJV0JGTmNBN1MyVVV0SzFEWXRud0hHaElj?=
 =?utf-8?B?OFdMaW1sZDZ4UGx2TE1zcGVybm1Zbkh4c0RTQkxEaGJxbnpveGNMcGpmd1Jz?=
 =?utf-8?B?T09WMzRFdUVnQ2lhdC9HRVE3UFZRb2YvQlVBeUEyenVyR2t4bWFNdzhnbVZa?=
 =?utf-8?B?Zy9mcTcwTFVSa1lkU2JPZGZ6VllQbVViQUsweW5HNVJxM0dpUG01WEFRV1F0?=
 =?utf-8?B?Z2kralhZT2s3Y1laN2d1U3l1MEZXbVBaeE5nWTA2MGNNa3R0ZG9XTEs0Qnd3?=
 =?utf-8?B?bWNWRVJHVy9sNEw0VHArTllYVFhsQm9DdWQ5YWlybVNpNzY5anJENjZ2K2ZX?=
 =?utf-8?B?Q01zRFpTeDVycnNWbEs4NVRjUy9yMDNUVTM2di9sYTZMSGg0TmJ6VW12eWF2?=
 =?utf-8?B?VytCWGFGaDBsN0p5b0xRaTlieW5taTl6ZHdhWXVGbzFBVnovd1k2WmIzMXAr?=
 =?utf-8?B?SHpQWjlIY0J0TFRxbzZ0d1I3TFgycSthSlgxYmVBYnhsY3NpVW1vbUNuQVR4?=
 =?utf-8?B?aU92SERhYVR1cTQxZ1RGc1BWUVZoMi90bVlDZkFuK2UwbTRnOFR3dTFHTDBi?=
 =?utf-8?B?a2xuWHBmaHYvQ04vQlQvNmNXY3BBWWZFSHFZeHRuWDhnRlZkNVRCWTFVOHV6?=
 =?utf-8?B?Y2VXZjhpeS8yWkMzVEZiQkRaMjhGdkIxQU1Rdmg1dkgvQlpVM2N1Wmorakt5?=
 =?utf-8?B?NXRnTmRVYXRmdkZJaVpoWENsMGJ0Y1dZMVlDNDlxaHVwZFRqZGh5dDBqOXpD?=
 =?utf-8?B?RUg3Q2lVNWtkU0JwNy9SUmx0c2s0UTU1LzJVd0VUR0NLcjRTSnVKWDltNGtv?=
 =?utf-8?B?djQxODcwMlBzWmlLNE5SQm5pU0xpbGFrbHJBeGZBZlR2V1dJdUhJSzJ5ZWlX?=
 =?utf-8?B?NmduSkI0YnU5cS96dmg3YVpncDY4TXZaMW15Wkg3Vmp3SGlya0pSNFpJNlh1?=
 =?utf-8?B?c3FrZWs5RjhscUNSY1JFUlFTSHk4VU5tUE91STV5cjFiMzc3dlluSG41Mi95?=
 =?utf-8?B?eXZmS0JsODZOTzNYZW1Db1N1VmwvRjBWclFyL1U1MTRlVFVpcjhjb1RYWWI2?=
 =?utf-8?B?V3pJdnM3TFJleDNnYVRKSVVxVVBrTnozZWdiNkQ3dndmQXduZ2RDaUNuYjEx?=
 =?utf-8?B?ZXBSdVdDMVBJcm9JNDllSFJMZ1hZVjhubGVIYVRuVVRCVXlXMThmblYvU3hp?=
 =?utf-8?Q?i58kPltFpzB+mQxValYMq6OtGhdLRlk5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RThOT0UxN1MvdWk4U0ludWVDeG9pMFR3bzAxdHIzbHFMaXhxN0FVRHNlZXJU?=
 =?utf-8?B?M2UvS0s1YytTTnFVUzQwY0d0ODFFQU9XSXRWdmpYSDIzYjloVUE0Z3c5ZXFX?=
 =?utf-8?B?dUpPYnZ4RHdiSUFmMWF4S2gyc1ZkVngzWXZySTIrQ2xybk0yR0dtdjhBcGwv?=
 =?utf-8?B?T0svbzhPd2x4T29qOENjenRnRW9Vb2NnWkk0dXZpaFJCY29PU0w4MzMxOG9G?=
 =?utf-8?B?bU5sWS9CTHZLZmJjejZURy9OWVB4UFQrak5TZEhNZW9pNzA5NnFVQ1RSb053?=
 =?utf-8?B?cWNBT3NoKzA1WlhHSUxXME56NkVnNDE3bmZ1ZzdKTmplRHRqS2hGRnc5UVdM?=
 =?utf-8?B?cEhwVlRCZzI2THNtblBUNHdJZTJPQVg1emlDMHNSUjhNZ2h0RGJUTTVKZi9Q?=
 =?utf-8?B?ak1hSitKbmRsVEJHaGtYWUVmYmVNbU5BcXBTdTUvR0JTRXBreFdUSUM0aWJD?=
 =?utf-8?B?YmVrS2dNaFdNWUdIMWpyK1hYdkZwVjE2TE9ncUpCN2FFK0lJd1hMNUIrUmxU?=
 =?utf-8?B?VlNPSUg5c0k0NXJNcy9SaEpQSkRudGd1ZnVFaXVkQ2puVU02Rk0zbGt0V1o2?=
 =?utf-8?B?bDY2QTRYYWNyZmFxRmJEUFhzVDRzeVNuMjlxMDArYzlIQlFTTmQrNnpVdEZk?=
 =?utf-8?B?Q2dRb0JHVFF2SWVROHdUa3BlVDlxMGZqQmxKWjhrazNVamdjSzJJQnl3b1Ir?=
 =?utf-8?B?ZDhQVGY1YnQwS28rTDgreXJ0RnpsVWdWaE9rVjBSeEd5NlA1Q2lJZlNoTjlN?=
 =?utf-8?B?UXJPUVk1Y1pVUnNjVTdtVnJYUHZvSllITXZ1bzlUbzdxREpKbkNmSHVUaTJl?=
 =?utf-8?B?MjBhUzNlalZUMTc4clpHVTVWODkvRzJiWkdpT1V1OVRlcDhmQUcrTzhFckE0?=
 =?utf-8?B?NEF3dXBpb2VqdGQxMnU2QVFLVVdBdm1uVUgyN1c2WG0vMy9ySW9hNGErS3Jp?=
 =?utf-8?B?QmNOMDZpbUl3dEtQSy9Oa056YjM5UlRuMUpKWDRtb0M2MXRRR3VoczU3UStx?=
 =?utf-8?B?d2hYRi9BNkF2azcxT2NLTVp1a2syN0RKVjliQU5JRUQ2Zm1PTTNzQ0FLSXJy?=
 =?utf-8?B?bWRZTTAzWldZQ0lZa0Y2MDRuQXo0bHZ0eUIraHhBWkpVQlYxTldIVDY2TjQw?=
 =?utf-8?B?TEdJZWtrTjhFYUhoQlZrSGNnd0xEaUNOelM0TFFQa2lrNGJETjNsdlBHWVJK?=
 =?utf-8?B?c3RaMG9kREFUdGI0UmQ1UWVUWHduc2xSblExS1RYOHl6NTkzUG9uN3dpRXds?=
 =?utf-8?B?TEVuUEZibVUvSk1ncFpKTmoyQmdoMjR4SytiM0g4cmpXdVUzVDJSYXBMcFhI?=
 =?utf-8?B?SHhRd0dvWlpRVi9vL21XWG5QUjNONW05WERNV0JGaFRxT3U1S0FHSC96Q2VV?=
 =?utf-8?B?V25rNCtWZi9ocndxSWVjcmJCK0lGRmpTS3ZSQm5HcDI2cmFKTjR3OXo1L2JJ?=
 =?utf-8?B?TE5RRDdyb0o2M3d5bkh2QmFZM1VmZCtWWG15bzNPWFJKNHZlc205RzB4bTRC?=
 =?utf-8?B?RlhLRUo3Yk85RmFmcTU3VmpGYnFTbmhVWHVVN3B1SDUxR201eHcyd0kzMGM4?=
 =?utf-8?B?WSt4UGpmbFF0d2hObE5PaUdkZHpGWmlVVGtWK0t6NlMzZkwrdk1kZytQRmtL?=
 =?utf-8?B?Q1hTelFWaVlXUDdoVkdOd3g4MllaSzRyUnVISCs5VUxSQXVnNEwyenpWQnFX?=
 =?utf-8?B?bnduZ2o0MTQzUEtzQm4vNVQrazN0d0hDUW9XcU9tVFVTMFpTTUFuRWFuN0Y1?=
 =?utf-8?B?RDdzbCs2dzl3VENKek1LbHB5ZnVNVjJQQU53cEhHTXNaK1dZamY0UmpPTkxq?=
 =?utf-8?B?RXphUHZNdyt1bmhpU2VOSFpFb0VrWTM4WEZaMmYzYlhKTzg0WkVhdElvNUt0?=
 =?utf-8?B?b0IwL1pvK01nT0lQZjUrZ0JNMWdjWndpTmQ2Zkt2NVM3YjVxSG0yZ2NmOFBq?=
 =?utf-8?B?NVdjd2VUdFErait2NCtqRXpETlJiTU9QbHVyS0FRWDFQSitUSFV1aThERmsr?=
 =?utf-8?B?Qjhhelkrakg5ZmNOMFpoSllSSTF0VVh5WXdHaDlhWEhFRU9NVk04Tm82YXZ4?=
 =?utf-8?B?dGtNNUorQnYvQTdMWThZaERIZ1A4cmFmZTVKVGZoWWQwR1NlRUl6ZU1WQWNz?=
 =?utf-8?Q?JrsS8Em520ERXTFdYd4EtINGe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6017ACA75198F1439E2DF7E8380329FA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 136cc3e9-989a-431c-ecde-08dd5cb40231
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 13:37:15.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3FzTXRRXxixYGLwqptP3lXWgreAFACfIcOLXr8x6AELsWAqDsdO1gu3PrF1b6C1xgoVLyM0xxvjxaW8wFndTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDEwOjAyICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
PiBGb3IgYm9uZF9pcHNlY19hZGRfc2FfYWxsKCksIEkgd2lsbCBtb3ZlIHRoZSB4c28ucmVhbF9k
ZXYgPQ0KPiA+IHJlYWxfZGV2DQo+ID4gYWZ0ZXIgLnhkb19kZXZfc3RhdGVfYWRkKCkgaW4gY2Fz
ZSB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbi4NCg0KeHNvLnJlYWxfZGV2IG5lZWRzIHRvIGJlIGlu
aXRpYWxpemVkIGJlZm9yZSB0aGUgY2FsbCB0bw0KeGRvX2Rldl9zdGF0ZV9hZGQsIHNpbmNlIG1h
bnkgb2YgdGhlIGltcGxlbWVudGF0aW9ucyBsb29rIGluDQp4c28ucmVhbF9kZXYgdG8gZGV0ZXJt
aW5lIG9uIHdoaWNoIGRldmljZSB0byBvcGVyYXRlIG9uLg0KU28gdGhlIG9yZGVyaW5nIHNob3Vs
ZCBiZToNCi0gZ2V0IHRoZSBsb2NrDQotIHNldCB4c28ucmVhbF9kZXYgdG8gcmVhbF9kZXYNCi0g
cmVsZWFzZSB0aGUgbG9jaw0KLSBjYWxsIHhkb19kZXZfc3RhdGVfYWRkDQotIGlmIGl0IGZhaWxz
LCByZWFjcXVpcmUgdGhlIGxvY2sgYW5kIHNldCB0aGUgZGV2aWNlIHRvIE5VTEwuDQoNClVuZm9y
dHVuYXRlbHksIHRoaXMgZG9lc24ndCBzZWVtIHRvIHByb3RlY3QgYWdhaW5zdCB0aGUgc2NlbmFy
aW8gYmVsb3csDQphcyBhZnRlciBkcm9wcGluZyB0aGUgc3BpbmxvY2sgZnJvbSBib25kX2lwc2Vj
X2FkZF9zYV9hbGwsDQpib25kX2lwc2VjX2RlbF9zYSBjYW4gZnJlZWx5IGNhbGwgeGRvX2Rldl9z
dGF0ZV9kZWxldGUoKSBvbiByZWFsX2Rldg0KYmVmb3JlIHhkb19kZXZfc3RhdGVfYWRkIGhhcHBl
bnMuDQoNCkkgZG9uJ3Qga25vdyB3aGF0IHRvIGRvIGluIHRoaXMgY2FzZS4uLg0KDQo+ID4gDQo+
ID4gYm9uZF9pcHNlY19hZGRfc2FfYWxsKCkNCj4gPiBzcGluX3VubG9jaygmaXBzZWMtPngtPmxv
Y2spOw0KPiA+IGlwc2VjLT54cy0+eHNvLnJlYWxfZGV2ID0gcmVhbF9kZXY7DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oF9feGZybV9zdGF0ZV9kZWxldGUgeC0+c3RhdGUgPSBERUFEDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAgLSBib25k
X2lwc2VjX2RlbF9zYSgpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICAgLSAueGRvX2Rldl9zdGF0ZV9kZWxldGUo
KQ0KPiA+IC54ZG9fZGV2X3N0YXRlX2FkZCgpDQoNCkNvc21pbi4NCg==

