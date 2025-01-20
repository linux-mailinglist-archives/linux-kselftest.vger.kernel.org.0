Return-Path: <linux-kselftest+bounces-24800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D738A16FF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA64165DFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38EA1E9B0E;
	Mon, 20 Jan 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0bDTGIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE51BA89C;
	Mon, 20 Jan 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389814; cv=fail; b=suz4DnjpGM/lWOPGWlU34xOYg9V512fOz67XCIsZ5+HycO/b2AcxvrJ5u7T2JIY5As9+x55qJRrmKASGqO6QZ80Lut6vJ3mkkNKxItonlYdoktVT/EX3gZNbq/UVAiVVrAJRiSr0cw/nnOR4cb2mAGF/yvH3tUle/zAhPKqgjls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389814; c=relaxed/simple;
	bh=ZbLB9jpCArUAsnRMfOZ0gvtkrRVnr3DccqEx8jA4syo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GCJUH+unouAVHMXPekYTXLU1WG8HDPJLfEX1UbwRlms9nK+brUc83XDurGZs2GqzbdDlJQhOQCBRUA//Ws2CdssTVLFe3ezzybH0XbxD1Z2XxeZy7xXEmcG1xM1A4FUD0ELCQbLkRM+F4XrxmVlmB5RkskSsnx1YExYJqsQoLKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0bDTGIG; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a69o1lwBOxjbDQ9fEknzsOJZx6y4OObR9cCN5KDhayg4PqBMvOQtwGKa/Ubimz4DIIG9shF9hllBo5vkwKWO8INUnAfSglMcHwy+tRi9ZAK/mXYPXCpJQ1FkAV6MkqghU7Fz9LoX9aX/gMfvmGqEZddomxThZzlIJc3NrdWXNhDZaWXXJKOEA1B/rxxVVwf62eSigR4gcpppa8tQ49uJjCMvOPh9e3oIN98nHCl0BVt8R2xZ5swbKb3rc+k56OK/srOZ7/BPbSc4AXQwpeqbFdXkROtRjdb+2rjKIqak7buJCkZxwJdIi/gLbbhGq0hf2qgAImecugHSqsfKmOKkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbLB9jpCArUAsnRMfOZ0gvtkrRVnr3DccqEx8jA4syo=;
 b=UJ3wuRwajvqp95nom8vCneUXvFgL9eiDVe+WJ5V7v34p2yD52wYcbxtX0cuex+H2cDr+pvkRiU4poooLsw5hUoUOKPoBIToDIIlXlv3qohAYuLOuitAWXW2CXqjFxA5t1YBgE7L+aqpcZjWkVbRlYHHFSZLu/Co6DVfVXG5+w9JZ91rvRDy+PIZl25iehruL2xmEDlO1uLu0BHc6a/sTJc60tY5ylSlAHCWpZVTI9C34SEYl1poZcYAWha4mBtnMPpNQShKpmVpMHOz6q81g0fmg3Ayg2bZoKF04WrsiHF62zmNx5JUykTTSvbkFVQnD6Mg5xtGtGgb5RLhF5oEgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbLB9jpCArUAsnRMfOZ0gvtkrRVnr3DccqEx8jA4syo=;
 b=R0bDTGIGGxxMSDvyDvKbyZ9pNd34uPi/AwTYdWv+xN/zU9pmB4DTVkrTU0wSugr/CagYhM7N+rkB8HdKCqpLigBDSimW5b6gTTY1Htmp6lGY4rpk5lY5Ne9ajS93mTkF/R5dTTxOSyeStn45RL43139NOBkGtad4azhIVBckZWF5omm2Ks7sibydJIENpj2OF6aTu+2F8cMl1/bpaLXbwfTzCVpgiQRIByH5bsMIua5RGoFMj4OGduJeiNq4+QqLR/cvrXO91IBXpEuTs+DusenmbbJjR1nWgK9jDbNGWLvgZTu3MIOWMtAS3d2pz/qdbMc4SEluOChcV4Wm983yuw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:16:49 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:16:49 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "andy@greyhouse.net" <andy@greyhouse.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "razor@blackwall.org" <razor@blackwall.org>, Jianbo
 Liu <jianbol@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Topic: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Index:
 AQHbS5v4eyZKdm8VYEWNCY/impKAebLirMAAgAEaWQCAAVL/gIAdz0mAgAANmgCABsJ2gIACnm0AgAAO7ICAADwBAIALIyqAgAMNBoCABUM1gA==
Date: Mon, 20 Jan 2025 16:16:49 +0000
Message-ID: <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>
References: <20241212062734.182a0164@kernel.org> <Z1vfsAyuxcohT7th@fedora>
	 <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
	 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com> <Z3u0q5HSOshLn2V0@fedora>
	 <Z33nEKg4PxwReUu_@fedora> <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
	 <Z34l6hpbzPP9n65Y@fedora> <Z4d9pVshf3RKQp_o@fedora>
	 <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
In-Reply-To: <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH3PR12MB8234:EE_
x-ms-office365-filtering-correlation-id: 4603f450-0d13-4228-1028-08dd396dd7fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXZ4UGxUTEFrSWZuWHV3cUM0S3lyMDNMQzNlTHRIMFJJdXJGZGNZNXg2ZUZu?=
 =?utf-8?B?bzZXZHNUSjUwN3Jtd3k2c1N2c3RiNzFaOE4xRVVDNzZCYXk3SmVGWG9yK1Rq?=
 =?utf-8?B?bk1ZaGgxc254MXhJMDJZS2YzUXhxZnNReVV0OXZ6bWF4bzlrVDZkRUVXVzY4?=
 =?utf-8?B?UTF5VzAvV0hRQ21ZcmlRN0VjaFdzYlhOZ0RyZlVoWUNCZmUzL2Q4TUJYSEZQ?=
 =?utf-8?B?MTlHalFDbXJyZWdLQytGbkxxQU4yZjkzVkRHVkFEVmdLR2M5SkFOQXJoZmll?=
 =?utf-8?B?QkU0d09tRVE4dFMwbWFoVk8zMVY3aXphYlBDaDdSNFUzQkQwenRBUkcwUmwx?=
 =?utf-8?B?WlAzWDE0YXh1Wk44alBMZEh5YWhHeURqTVdISXNtNGNnVUliNXJlbmF3SlEv?=
 =?utf-8?B?SDg1VU5hSkMrWjBoZUtJMUhMMXRqZlkvNFBid0tPazZhS0Ryb0JWYVFLS1Uv?=
 =?utf-8?B?R25FMmNJclY0TUtRVUJ3Y3VQU1VmbDc3cDFHUE93WmIrSWdqUUFheTh4TEpo?=
 =?utf-8?B?MjFoVlpFQWI4WitxT0JMNlBOYngrZmF2Ny9MTTFNd20ydm5ZWjQxVEt2UUt0?=
 =?utf-8?B?Z2g5eUV5TUhCeHpiWFRVQkxGTklUbkt1MUVlZHRjdWl4a1BBc0czQURtZUZq?=
 =?utf-8?B?MWl3cytPc1BXQW9neW1RZ0dwRzJnYTZBZVpLc2dFUlErcytGMUtCdDNXTkJJ?=
 =?utf-8?B?TjZTMlROZ3lUSGtFdE1heVdacXBJelhvd3NzV3A1S0tNVGF1WklPQzZqRnRB?=
 =?utf-8?B?NEhIeUFYc2YyTU1xUmRlaVNza3VUc3NDVDlyLzRvRjRSaWdjNlZjMk9VS3N3?=
 =?utf-8?B?bWpoQURRQTdDVUVTaXJ0cmlpNDlLZklqOEdZU3VTK0dPSGZiNUVqcGF2aVdW?=
 =?utf-8?B?RkJrZExzM3kwZG9kWVFwK3VXNW01NHl5djBKcitVWTdwUmpvNUdsU00wTnU3?=
 =?utf-8?B?ZkZlSmRwajRIYzNmQWRaWUFGK0hITW9WZlZDU3U0TWk0cTNVV2RSeTRKYmFm?=
 =?utf-8?B?ZTM1SFpwcERHN3dBYVlZeU9sMTZjUElmM3l0bWpTUlB3aTZlU1ppMVVyWS8r?=
 =?utf-8?B?NGtxT3ZZeDZmU2ZnUkkwbnRRT1pKbzRZT0x4RFZQWWhZbVc5TjhaTnNzUXVm?=
 =?utf-8?B?dzZRZThHaXdpd1VhTzZ5SFhUK1B1bUFOd0wzeWtPRWFHdXpBMmVlUmpSUUpD?=
 =?utf-8?B?a3hHS0I2akN4cjYvb0w0RWdxampNREdKUDF2SjZ6dzBIU3dlbXlPRGhheUU4?=
 =?utf-8?B?OEFxTUFtWXBLU0NjTXNFWWZxbk5XTDdmWEV3aitXdHRNTDBEanlXcUlQUytX?=
 =?utf-8?B?a1pReFViUyt0b05CSWJMUVNPLzBxckdaZ3ZjWW5rdnBXUk5hMytnY0RXdGZj?=
 =?utf-8?B?VG0rM2FHRUdsSE1Lcll6dFl4WVEyOWJRc1NLOU5qZlNTbEpjaHcra0VxQ2hB?=
 =?utf-8?B?VzdVb0l4U1R1WWNaakwxL09ieXdGSE41TEJ2b3l3aGl5VUc0bHBNYUNQZkho?=
 =?utf-8?B?STdpUmFrT0VTS3BsQkE3WW9EQVVjUHFVcXVndHdtdGoxQXFTQWlhSHozNzFr?=
 =?utf-8?B?clhnZjZJWDViNjNTcHAzN1NaSmRBTlQ1dEV0UTFiSlFoLzNRYXNIVkdzZ1NF?=
 =?utf-8?B?S3RObDkvR1lHY2JyNDVRbld6MlBuenR1S21SVVVZOVpoYWtpU1hwQlp5cjJZ?=
 =?utf-8?B?eThNY2diZnQwdWcveXp5cXhWZ2F6UFArSVA5Z0dMTlMzZEJGZ29WWmJ1a2Js?=
 =?utf-8?B?ZXBhNnFublRhbThwcE14RWJWUER5RU5hMGpSa1Z6NjRVTVcweUNKOTRBV2Q4?=
 =?utf-8?B?OXhaMkJZWW45ZlVsU2hqRmZHQW42UXRmZ2dkVVNTN2dYb3JHNUlUc3FZckdm?=
 =?utf-8?B?QTZ4c0JjWTh0OGxHbkRSTVRkNjdENk8rdUF2M0l5M01LZXhnRFZMeS9qU0Nx?=
 =?utf-8?Q?627qh+5ud4Kv8DLZghsFjWJrq/xam+9q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWZuMmNtU1JISzhtVTVPWXNadVJYRHZ1OTNKNnZRNUJ5Z1M2bVo0MUc1eHJV?=
 =?utf-8?B?d1NDQ05oNVlmZFlZTkhnOXp5UEE3UklBZzhjQ2dCRS9aZWozcGo5MVhlSUZ5?=
 =?utf-8?B?cXlYMmhHOEgyUml0Mm9EY1JxczhTMWNHdHdBay9yTVZYMjB1aTlMaVRQMHRq?=
 =?utf-8?B?UW5vdURBb3hrNDNDV3BUTW1ZanQ4ZFdoamhMSWhSTnlNN0pTVnBZa3pySitn?=
 =?utf-8?B?REtPcGxJSjFuUk5JNFFTOTdGRzFlUjZwM2pKWFpVeEVyTXFFbmRkdVdBajEx?=
 =?utf-8?B?d1Q3eVUvaDR0VitIY2Vwb3E0YTlOcUYxbnFUeUVXa3ZzcGkzMlFXdS9YWVpr?=
 =?utf-8?B?ZC9Odi9CUzA3azBkeUtYaVFEMTJQQUNxaDRobjkvL0tNM2d6S21vZlh0V2g0?=
 =?utf-8?B?Mnl3UmZQeFVFY044MjMveWhIZENIbWJicFhjS3hZMU5EcFNIVVQ3M2s1MzM5?=
 =?utf-8?B?OFRhRzUwRE5CU1lTNDlna2ZFbmFRTjUvRk9VZlV1THFNUUh4ZHloeGtxWmFy?=
 =?utf-8?B?QXdoeWFodlkrTERFZ2crNlU0OHpEM05naWNQVTl6SVNSQnNSZThRb3Bvd1ZW?=
 =?utf-8?B?VFZ5RUZmYkNFbkdyR1poVFQ2cVhURVZ3b1UzajIyUSs3TkxrQi9YMXQyY2x0?=
 =?utf-8?B?SUxBa3l5RHBYeTNpc0dqYkZQVHR1YTNwRGNRUHhPUlBrdk9mZ1JWeTgvUFRy?=
 =?utf-8?B?bHJVZkR0b2t4amRpVThiNkI1QzA5KzRjRkFLa0dFTFJGMkFOaGFiMkVReTRD?=
 =?utf-8?B?eDhMODcxUkN6dWhnVjh4MFR0elVWK0M3WjNDYWIyU2ZjaUxmTC85TFpOblRa?=
 =?utf-8?B?cUYxZ2pCbzh3YllpUHRIQ3RGS0NqT2VmSk1WTVFiYzdJeUllOU1VTXA2Uk9M?=
 =?utf-8?B?MkgrVEVtQVZhMDlTR0lPRlA3d01kMkxyL2tpVmtGeWRhQ2pVSFR5am8reHFN?=
 =?utf-8?B?TmZXSUlBY1pyZXhnVmcyOXJtUTFRbGNGOXhoWnFuSlhDelRlMGZpeHNwUEQ5?=
 =?utf-8?B?ZzFLaFRDbFR0aWo5ZFR5WDdWRGhML0RiNkRncVkwOG13K3FLRmZ0aWhKVllz?=
 =?utf-8?B?VDBVWG8vd3UxWjFGWEFBSVVjdW4zOFdTejdrbkh0QXlYbXZFZk04eGpwN3lz?=
 =?utf-8?B?UmwvMHdYcCtuRDFEa21lRHBxSlY2cHVaSGFUN3BLclplcGRZV3JHVW5ZcjFQ?=
 =?utf-8?B?WFdocjNTcFBKMHBIMEgwdGZPRjRuM1BlYk9sUHgvc0lLT3hkb0pqV3E1dTZQ?=
 =?utf-8?B?SC9kUVhPZGNTZWVkOHkyMEIzOE4zaExwSVhKSVJsYS84ZGZncmZLOTl4SWJZ?=
 =?utf-8?B?SjI3Qmt3UWxCR05mMERXRXVNYW94Ykh6V3pBTkIwU3VxMWhiS3dmOHVaNDN3?=
 =?utf-8?B?QkZpT1pveUpua2RPLzJSMWRJMGVCYklYeWtQNUhxZGF3MUlvelIxYlpkaDVO?=
 =?utf-8?B?UGVxMWk4N3o4b2RIYjltTGcxekVwaWVJdnZiZUNwZHFUSlhGWjdRSFQyNFA1?=
 =?utf-8?B?d2JtaWxkNGx2WUZ5Z1pyUGRPVll1ZVY4S2F2blBRa1NJcXp6T1o5U0dxaWxD?=
 =?utf-8?B?dVJsaGJVZE95c0VFTE4vbzNhYXFld0FlUnZpa0F6VXB0SG1XL3VjZTAzYWNB?=
 =?utf-8?B?TC9CdlRwTTMwNy9WQWpONm1YbHlsVXlHVDlTMkhPNTcrMUhJdFhITWZnMkVO?=
 =?utf-8?B?S2dCMlFIcm9VR3RBWThzNnVNZHN4bDBzZms3aEJSbHp4UUYzVXhpTTVsL09E?=
 =?utf-8?B?dElkUVpucmVaWE1CY1krNGxQbzZyTm9TR21COU40QzNxZFhUSm81ZHFuZUdH?=
 =?utf-8?B?bnhYYUtnelhwTVJ1QmthMGVBV1FpYW94TU9UTjJRWGlzaWN5Szdnd0Q0djVM?=
 =?utf-8?B?VFlzNUhDVlpobmFwSFU1RXovNjRDa0lPU0gyVnU5WERrei9aNjF0M2p5Yzc3?=
 =?utf-8?B?OThveG8yc21vOW1USThlelVCYlJjbTV4czl3YWRmQ3R3bnZveHhwSW44VTJR?=
 =?utf-8?B?b3lZWFZ5eHhBeUQ2NW9zN2cwdkJJYTFLSVdGcitTc1JEU2V2UVlDKzlVRWVi?=
 =?utf-8?B?eWhOWHgxRmFXdkh2ekdMdTVLQythd2E3OUZRd0RDQUdLV21tdnVaUUNJMEdw?=
 =?utf-8?Q?2s3qxXP7LqISQPuJ7to/7iyEG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F9779FF420C7D45923D93FD567D0791@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4603f450-0d13-4228-1028-08dd396dd7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:16:49.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fZh398rDg141Dt6VLZH+3zS4lMy3vVNa8tNPMa882e0POQEYH5MWzFadpcquXisKxjaByJZZsXWiszZtthpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

T24gRnJpLCAyMDI1LTAxLTE3IGF0IDA4OjU0ICswMTAwLCBTdGVmZmVuIEtsYXNzZXJ0IHdyb3Rl
Og0KPiA+IA0KPiA+IEhpIEppYW5ibywNCj4gPiANCj4gPiBJIHRhbGtlZCB3aXRoIFNhYnJpbmEg
YW5kIGl0IGxvb2tzIHdlIGNhbid0IHNpbXBseSBkbyB0aGlzLiBCZWNhdXNlDQo+ID4gYm90aA0K
PiA+IHhmcm1fYWRkX3NhX2V4cGlyZSgpIGFuZCB4ZnJtX3RpbWVyX2hhbmRsZXIoKSBjYWxsaW5n
DQo+ID4gX194ZnJtX3N0YXRlX2RlbGV0ZSgpIHVuZGVyDQo+ID4gc3BpbiBsb2NrLiBJZiB3ZSBt
b3ZlIHRoZSB4ZnJtX2Rldl9zdGF0ZV9kZWxldGUoKSBvdXQgb2YNCj4gPiBfX3hmcm1fc3RhdGVf
ZGVsZXRlKCksDQo+ID4gYWxsIHRoZSBwbGFjZXMgbmVlZCB0byBiZSBoYW5kbGVkIGNvcnJlY3Rs
eS4NCj4gPiANCj4gPiBBdCB0aGUgc2FtZSB0aW1lIHhmcm1fdGltZXJfaGFuZGxlcigpIGNhbGxp
bmcNCj4gPiB4ZnJtX2Rldl9zdGF0ZV91cGRhdGVfc3RhdHMgYmVmb3JlDQo+ID4gX194ZnJtX3N0
YXRlX2RlbGV0ZSgpLiBTaG91bGQgd2UgYWxzbyB0YWtlIGNhcmUgb2YgaXQgdG8gbWFrZSBzdXJl
DQo+ID4gdGhlIHN0YXRlDQo+ID4gY2hhbmdlIGFuZCBkZWxldGUgYXJlIGNhbGxlZCBhdCB0aGUg
c2FtZSB0aW1lPw0KPiA+IA0KPiA+IEhpIFN0ZWZmZW4sIGRvIHlvdSBoYXZlIGFueSBjb21tZW50
cz8NCj4gDQo+IENhbid0IHlvdSBqdXN0IGZpeCB0aGlzIGluIGJvbmRpbmc/IHhmcm1fdGltZXJf
aGFuZGxlcigpIGNhbid0IHNsZWVwDQo+IGFueXdheSwgZXZlbiBpZiB5b3UgcmVtb3ZlIHRoZSBz
cGlubG9jaywgaXQgaXMgYSB0aW1lciBmdW5jdGlvbi4NCj4gDQoNCkkgYW0gbm90IHN1cmUgdGhp
cyBjYW4gYmUgZml4ZWQgaW4gYm9uZGluZyBnaXZlbiB0aGF0IHRoZQ0KeGRvX2Rldl9zdGF0ZV9k
ZWxldGUgb3AgY291bGQsIGluIHRoZSBnZW5lcmFsIGNhc2UsIHNsZWVwIHdoaWxlIHRhbGtpbmcN
CnRvIHRoZSBoYXJkd2FyZS4gSSBkb24ndCB0aGluayBpdCdzIHJlYXNvbmFibGUgdG8gZXhwZWN0
IGRldmljZXMgdG8NCm9mZmxvYWQgeGZybSB3aGlsZSB0aGUga2VybmVsIGhvbGRzIGEgc3Bpbmxv
Y2suDQpCb25kaW5nIGp1c3QgZXhwb3NlZCB0aGlzIGFzc3VtcHRpb24gbWlzbWF0Y2ggYmVjYXVz
ZSBvZiB0aGUgbXV0ZXggdGhhdA0Kd2FzIGFkZGVkIHRvIHJlcGxhY2UgYSBzcGlubG9jayB3aGlj
aCBleGhpYml0ZWQgdGhlIHNhbWUgcHJvYmxlbSB3ZSBhcmUNCnRhbGtpbmcgYWJvdXQgaGVyZS4N
Cg0KRG8gdGhlIGRldiBvZmZsb2FkIG9wZXJhdGlvbnMgbmVlZCB0byBiZSBzeW5jaHJvbm91cz8g
Q291bGRuJ3QNCl9feGZybV9zdGF0ZV9kZWxldGUgaW5zdGVhZCBzY2hlZHVsZSBhIHdxIHRvIGRv
IHRoZSBkZXYgb2ZmbG9hZD8gSSBzYXcNCnRoZXJlJ3MgYWxyZWFkeSBhbiB4ZnJtX3N0YXRlX2dj
X3Rhc2sgdGhhdCdzIGludm9rZWQgdG8gY2FsbA0KeGZybV9kZXZfc3RhdGVfZnJlZSwgcGVyaGFw
cyB0aGF0IGNvdWxkIGJlIHVzZWQgdG8gZG8gdGhlIGRlbGV0ZSBhcw0Kd2VsbD8NCg0KQ29zbWlu
Lg0KDQoNCg==

