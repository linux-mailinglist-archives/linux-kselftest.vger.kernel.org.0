Return-Path: <linux-kselftest+bounces-27062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E325BA3D746
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BA9188EF2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928091F0E2A;
	Thu, 20 Feb 2025 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuX7MKbE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A301BD01F;
	Thu, 20 Feb 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048528; cv=fail; b=D5gNap9uX2XRMmq9zsgIcqWq1QgQfcSD24fMsSQyFlML6S7whbkxBD8NMlAdozl6pcwD5+Ge1YwHLfd/o4VPupiZ4BBlyV6GMSSAsVZABoTEjZ4pSKKwBqdHbu5uN73xwpQM64zPDn6GO2CQ0JYmrfnqriJpGPSe8HIDyw0jLPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048528; c=relaxed/simple;
	bh=HsAY9x8t1j/izJeV8U7KFaLu5HL8i2jmlmgBEFLgiBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fHGRNE82DD796lqA/RkbwA2kH+oZOvMPirGNQh/heBr/e6R/WouSvCxj+ajYlOE7ZekXpgcYXqxVRnnQTV5gTQzK6Yk4DAUeP/82VimszBwN+tv4zkZD2m6G4Nf0zPMy/Qx08R2NSzX/Tec2r5o4C+PNrTZ9pFKeLmXU6/ve+4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cuX7MKbE; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9JBox91GFGIGUlKtTtnlEbFHDQ5MmMF/GYtBWWPfyuo76rQGsBFwAezp8Rwq7oeqI7Bh++vwcP2WVk+Cd0IZGgK9SELJn5n2a1zfZp+eglFeFvVWKzFB1TBkqu33wTePdXmsaMh6AXWo3iqrmfB4dd1tRSaLLBMb4L2Efhsp3a81h8tAzi3ff1Bm8ZtnfXhDtA8CK7NlbbXlAUfn5l3m4xH6RGPLq6PZUignZSgciRH1kjNHhemycPiBSreDI7CzmuoqKTLMuRbNnv2hd4yaXfEbeiVf8+xDduaQoGEtY2A2fWk4dkHW8b6Cu3RiTs3Tp2HU7geBFcfqONuklN1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsAY9x8t1j/izJeV8U7KFaLu5HL8i2jmlmgBEFLgiBk=;
 b=PuHGSxfm3ELH7qxPqoudVpsg/dzjurSSPGqNGv+73n1NTC63TIuJ3NHqO25hdF5zo4+68ZkqoCf58LL3hX6g1kORCjrbSRoCqhP6XA3JDpNgqoLR9NaKxLaeuXhv7A8ryPVv+kioyiEQwlRNjW3XIHGcAxsE54tZQnTQLvCUAF2kJPZLHFEr5PxombU/wS57Zi2RtOB1aoyXpybUTHuG0StOXZllQ1SyFOCGt0XaghVqJK3HLqWt42vsfanYDdqwIDa4320exQxATBrYoHVmGzfaZUR7Hy5ZndPH3IJXviqcWralbgE32bhaSKQI1etvLce/05G0FovWDwS8xQCjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsAY9x8t1j/izJeV8U7KFaLu5HL8i2jmlmgBEFLgiBk=;
 b=cuX7MKbEDujY8M6yaE0VLhjPL98cenJjsTVsmKtnImAjhHWstp/AhRyQuTFrMjEnsdKguWg20mt1v2fkVwrFKVhpMdxKsf5q8xtOyYqIOD6H3V/xdTgRbrnyq4QybvKxaNd+8jk0Z9FTIUSNawLF/Oh5a/tJ09RB9iIPxPaP6C/xERJ3FmUIh6vNaQTQ0ZU+ldYcYSaZnDSZJ5voOxztyB7pUKxWeJ+/0XM0IaUNxnf4ruFOglwR9+PMr9rMs/k1aDM0TyOHFgcfwUVBfdcCLmCbC76NePb5WUOmYKRsVOGnAHmsSfpRf3xdWUlxwCbqOu2HCnkTezwEMXSyme4BAQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 10:48:44 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 10:48:43 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "andy@greyhouse.net" <andy@greyhouse.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "sd@queasysnail.net" <sd@queasysnail.net>, Jianbo Liu
	<jianbol@nvidia.com>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"razor@blackwall.org" <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Topic: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Index:
 AQHbS5v4eyZKdm8VYEWNCY/impKAebLirMAAgAEaWQCAAVL/gIAdz0mAgAANmgCABsJ2gIACnm0AgAAO7ICAADwBAIALIyqAgAMNBoCABUM1gIAAgTkAgC/bYgA=
Date: Thu, 20 Feb 2025 10:48:43 +0000
Message-ID: <40e2170b52f1f80fd72405df6901c4323f903e67.camel@nvidia.com>
References: <20241213193127.4c31ef80@kernel.org> <Z3X9pfu12GUOBUY6@fedora>
	 <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com> <Z3u0q5HSOshLn2V0@fedora>
	 <Z33nEKg4PxwReUu_@fedora> <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com>
	 <Z34l6hpbzPP9n65Y@fedora> <Z4d9pVshf3RKQp_o@fedora>
	 <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
	 <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>
	 <Z47jVoQdO9sD19TB@fedora>
In-Reply-To: <Z47jVoQdO9sD19TB@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|SA0PR12MB4381:EE_
x-ms-office365-filtering-correlation-id: 810eab5f-961b-408b-029f-08dd519c251b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUtUWjM0anE3ZWJtTU5iREoyUDNxMzBkYW4zNTlzamJBdHpmZ3RydC9ETlZL?=
 =?utf-8?B?cEJNdHgrOW8vc3NwQ3ZobUlkcndENlpNbldVSWcrL2s3ZjNIa01JV056dUFW?=
 =?utf-8?B?aks1MzFzWnBzR3UrK2d0WjYzbmxxZTBYeU5zT0FRTVlMNGNlb2hqVXVZY3FF?=
 =?utf-8?B?OHZVU0ZLeU80MFlsTzFCemw1SzZNQUNEQUw3ZjUzRUt6K05NRmFpVTRkRzBp?=
 =?utf-8?B?aU8zRW0zUGpkdVZSRWNJZkQ1WTJPaU80Q2ZhMVBjTEUreEppdEE4NU9SdnFN?=
 =?utf-8?B?anV2cWlCNU9sYWVoTXJ2WUFuNmJ6bVpLZ1EyS0NDNlJQWlVDd1Q1OXdQejVE?=
 =?utf-8?B?dmZtV2lNV2tSYWJHb2VZSC9mdTRhSXV3ektMcU1NeldlZmVCazl1N2lldVRU?=
 =?utf-8?B?WWlCL3Q4NkM4UmlTakdRSHRzcUhYWWpyR01VMFo4aTg5NTJVMjRud0tCd1Nj?=
 =?utf-8?B?TFJzVmN1KzA4bDhRZnFwejhrQ0lldDNYZ1hNUWpZZVRCZVRqTU1ZSkhXRC9N?=
 =?utf-8?B?djZtSGpMU0RPZnBIWEhSVlBaLzlRZkppTnZhNkptQUpNK3RuMHJqVzhCMkRM?=
 =?utf-8?B?Z0hLZWFHNkNxME5CYWlWeEpIY3JOYkxKVXpPaitVU1pEanBQK3EzUHk3Mlo4?=
 =?utf-8?B?Rms5NElUUE4zNlZjM1AyMEg0Qm5sRU9DTDdQbnhyUlVLOXQ4N0x3U1pONnJy?=
 =?utf-8?B?VXIyNVBCQ05qSkVCRDQ4cWVBYVNpZU5ZZjVhRlRHdmR0UEtvTEFUQVl6R1Z0?=
 =?utf-8?B?QjdoSlRvcXpJV1VOWnBsVG9wL3FlSGViOUtaV1NKdlBmbUR3c1FmTmJ4TE43?=
 =?utf-8?B?SUEya2lDZmpQR1dnaEUwSEdaSS96OE5ra2gzM3BVaGVpL0g4ejRDUXM5YUVE?=
 =?utf-8?B?SUVtZDhzbFZQUHhIZ0lYdi9zVmZQMitmejNQYlZtZ0JJaFMzZUlIb0pSRDlR?=
 =?utf-8?B?SGdmQU1ueWxHelVLQ25WUzZtVm5Hdy9HUG9Vb1p6ZzBQRlpTSEJQUlIvem5X?=
 =?utf-8?B?TDJuNzlqdk0rKzVSOHRoTm1vT3Q0UjBuWmN6TDJZcC9YNnRMNG1qTEh4NnhE?=
 =?utf-8?B?R3VlaHdFOXFha0Y2MHgrUldNZDNTZExHTDlpZ1ZKNSsxUFBhSnIrZHcyRlZt?=
 =?utf-8?B?V2VrQml4WGF6WHFSREJRMFFQNitOaHlaZU1sdHlNQk1MT1BYc1crQlNlTnU0?=
 =?utf-8?B?b1BLQ1pYQnJuSEVUc3N0VTVqb3RJRHZJdGdnYjNzYkI3YnBnVDcrREJTanBR?=
 =?utf-8?B?QlJNT0xsb0tjVnVTZGkzYmJxM1hZZkVXTUdGSGpOMmtPd2REUS9Na2JtMUdk?=
 =?utf-8?B?QVV2SUpJR1Yra050ZGVOQ3NCZmptTitwUEE3Z2sxaUk0MFVudXpGRXZieDVh?=
 =?utf-8?B?WnlWQkh1UzZQMEVHTHRxTjJQUkR1L2hPeXFmTzdJbm8vWUw2RVl4bGY4TmRh?=
 =?utf-8?B?T2x1YlpocnB2bStsQWxGdjM0NlZrYVRBMzZyOXBaNFIyaTkzYlZ2THFCM0l4?=
 =?utf-8?B?TzFlNjRNYVZEYkdyT25yakhtVGtBbFk0NWt2aXpFNExvazVDanV4ZVRKWVN4?=
 =?utf-8?B?UUNGb0hsWExIYUxZWHlMMG5pMVZMQXRJczdWM3Q1Z0NrRVVhVVV3azZHYmRa?=
 =?utf-8?B?QktUa25NUVNOT0MxQytwcitneWF3MW1UV1YzNDNyVzUxRzJnYmMvbmQyTjUr?=
 =?utf-8?B?ZzhBTHNrVVdLcG1CeUQxZFhwZjYzV1BJVWZZKzdyZER5QmNFNk15Y3g1V3dz?=
 =?utf-8?B?ak0zL3NOT1BUbHc0bDBMMkF3OGkrRCtEUDQ1Q2owZmFCWHJSeTFtSlJtUnJG?=
 =?utf-8?B?VXNpVmZpWldHN1BrbCsyMTUvT3o1L2dTR2h6VFR3Y0Rhczk1MHF3SkNnd2hY?=
 =?utf-8?B?QThWalhGaEVHUCsyaVVZSG9ESVRSRG1ET0NjQ2xiYkJTTUJ0Mldid3pCbDBE?=
 =?utf-8?Q?RtJAsgRK3a6eVC0uBQ+rCHqzd8Df0EL5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUhldzJQUEV5eTB4UUVET0R6TVdESGJ3T29tQTFUeEpBVENRYjBQWUdNeXlu?=
 =?utf-8?B?bDhLZXVxaU15RGtpMW5zelhwQTZCSzBONzZoUmR6UzRIanUzdXlkaS94VVg0?=
 =?utf-8?B?RHZxTjc1aGVvdy9hSmNQQ1Q3alhMVDZQb3dOaWhmeGd3QXNlNEM4TUgxVW9X?=
 =?utf-8?B?QU5OMEFEVHM3Z3FOcmZvaDZET3NiR3JiSE85YXJGRWhKcVZTL0o5eWd5TGlL?=
 =?utf-8?B?RlZsSmRwR3JlajZURVk5cXpDMkQ0ODJkWk5PbVVCcmtCKzloemJXYVBONjRW?=
 =?utf-8?B?SzdxMkVRaU8wSGhxd0JZc3plMWU3cUtkdzU5b0dTcmJUcFpBbHorSTVKS2VY?=
 =?utf-8?B?c1NQR2FCM3QvdnNVMFdCaTVhVDBQamdBOFFtT1dlbDlZYlBaUEFEd1NsM3V2?=
 =?utf-8?B?V1Nwa3ZCeFZITy9QeFNJNm5OSGVRSXY5NytIQkdXUzlLNmloVW1mcHAvajBD?=
 =?utf-8?B?MmpDVVdTTWU0MmtLN05kZ0xDem9kaTBiaGlTN2FMeEpEK1FSYXdIYk5rbXZs?=
 =?utf-8?B?U00vd3ZDZEFSeHlDQTh4TGc0V0FSQyt0bm1kdG44QVUxRWNoTytxbVgxeUor?=
 =?utf-8?B?ZGxaMHRlUFZ2UlZJb3hFRUN6Q0xBWUFncnpQRUtSRmpkOERLT3VvMnZsNEFZ?=
 =?utf-8?B?MENpOG45RXR6N0FsM1VWVlZpdXIvZy91RFFUY1NUWnNzd0s2a3BqWXhkbTBU?=
 =?utf-8?B?YTNZRm00OWo1MmZ0TEtxTWxndmZTRFJGMlg1dW9wKzY2UTN1ZWVkOStzekww?=
 =?utf-8?B?V0dPZTdiRzE4ZkpRVWRTSU5iMUMwekNpTi9rMndqR2Nmd29uSzFnRFBTL29n?=
 =?utf-8?B?SzVUNFNxWldaMFl1RDdMY1RleVdqLzdidVlCLzUrRkVUTzU0NjBNNDh0cEVt?=
 =?utf-8?B?SEREaWlIMHNzUFRmUnprWC9GLzJ2SlhtZEozQTN1TVIzRGdFY1I0SDlLT2lk?=
 =?utf-8?B?bjZ1SytOdkxrcGVBWXkwNFFScnhQWjFXNjJnTVArbGpoSjA0Nlllam5pK09B?=
 =?utf-8?B?Qk96WC9nZ2dlRkJrU2hZTGVPUy9naktMU1gvZFcxT0dXQlJHZG5acHBWVFVw?=
 =?utf-8?B?ZEw1UEhXQ21rNlN2b2tEZjNqZFpHczBPZ2J6MSt3bFJyYUhVeGgvL0Vsdjcw?=
 =?utf-8?B?V2xhd25ueHMvNFRzcEc0QjRGWC95T0tYZ1VsTGxpc3VNQjNxekZ4S3JNdFg2?=
 =?utf-8?B?a1dvdytDM281bE1GTVNvNmtZTVZROEdCWU1VaFBrM1ZpQUVoTytmdkdDZmxa?=
 =?utf-8?B?dE42cE51c1JiMkI5bDZ2SSswT01nRnFaQnQ1TUd3Z2xUNnBQQlZMVXk1aW9E?=
 =?utf-8?B?clZOelJxV0w3SW1CRVJQYmpmbVRVZHlhK0dpR2FZNHUxS3hmMUk4cjRRSFVs?=
 =?utf-8?B?cWxpY0JDZDJLMGhHUnl0QUtQekpkVkczRXgvRXRid2kvRkYrNkJJQi90bFNB?=
 =?utf-8?B?cmpKK2x3eXNJMitzOXZPcnJ4ZXBBTE92TDFlK3R0RVRTMHgya2JMVi9oWE5Y?=
 =?utf-8?B?ZWw5MmtNUEpJUS9YLzNBVTFGTmdJTUMvakFGRk1JWGt2Vjg4Ymk0TkNWNTZW?=
 =?utf-8?B?NWRtbmtzVVF5UGNiZmdOb29IY3RqZVVjdVhnSkt3NGgreFZPMUZQdlQvMHJs?=
 =?utf-8?B?MWhrUk5UR2xIaGhSaGFqQ1d4dmkzZ3paa1AydGZWTGc5ZGt1VmxCdkxIQVgx?=
 =?utf-8?B?VWFGYkFqaERxYStZbWlHcXdRZ2xqQ1J1LzNuVExIbTRQZUNGaElEY3FZWFFL?=
 =?utf-8?B?YXBqZkNUdENjVWEzSVZScVNSdXg0R0lWK0poWFVEWnJTRkZIV2ZwelpzbmRQ?=
 =?utf-8?B?WWdtM0pMTnU5MG5tOXU4U0h1aEVKN3BrWHVtOG0xVXdDaTRuMDVjOUtGZWdi?=
 =?utf-8?B?YnFPUndRRFp5SkxhdWh0S1ZMdDJVcnZSZW9VV1dNK3V4aEY1NWdYS1hlQ0hX?=
 =?utf-8?B?aVJoWkZ0Zm1GUHY1cG42dERUWm0rWUs1ZVkrUkZnb1lFTHU0UG5qVjNvN2pv?=
 =?utf-8?B?STl2bFcveWVHTUg5T0dvNnRUbWxIRGVYTWlBbytxQ3FSK1ljbVRaeGlpSFcw?=
 =?utf-8?B?czUwcTIra2hLbEVpT2JMMmUwZDdvWTh5ZFBxSXViZWRIeFZudnMraFRCZGZI?=
 =?utf-8?Q?kMuRlb7x+2uSrqH6eMaU4he1F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAB184263ACAC49B0B81C7D0B553D5A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 810eab5f-961b-408b-029f-08dd519c251b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 10:48:43.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dptYB5Nrm8MlE4AV+4xZDouDuwmW7BL+Njb5ibl+IS2SGEb4TTn1ROKWRUqj9cco74Ff1WlEuYQ+UsOMXcDkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDIzOjU5ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
PiANCj4gPiBJIGFtIG5vdCBzdXJlIHRoaXMgY2FuIGJlIGZpeGVkIGluIGJvbmRpbmcgZ2l2ZW4g
dGhhdCB0aGUNCj4gPiB4ZG9fZGV2X3N0YXRlX2RlbGV0ZSBvcCBjb3VsZCwgaW4gdGhlIGdlbmVy
YWwgY2FzZSwgc2xlZXAgd2hpbGUNCj4gPiB0YWxraW5nDQo+ID4gdG8gdGhlIGhhcmR3YXJlLiBJ
IGRvbid0IHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBleHBlY3QgZGV2aWNlcyB0bw0KPiA+IG9m
ZmxvYWQgeGZybSB3aGlsZSB0aGUga2VybmVsIGhvbGRzIGEgc3BpbmxvY2suDQo+ID4gQm9uZGlu
ZyBqdXN0IGV4cG9zZWQgdGhpcyBhc3N1bXB0aW9uIG1pc21hdGNoIGJlY2F1c2Ugb2YgdGhlIG11
dGV4DQo+ID4gdGhhdA0KPiA+IHdhcyBhZGRlZCB0byByZXBsYWNlIGEgc3BpbmxvY2sgd2hpY2gg
ZXhoaWJpdGVkIHRoZSBzYW1lIHByb2JsZW0gd2UNCj4gPiBhcmUNCj4gPiB0YWxraW5nIGFib3V0
IGhlcmUuDQo+ID4gDQo+ID4gRG8gdGhlIGRldiBvZmZsb2FkIG9wZXJhdGlvbnMgbmVlZCB0byBi
ZSBzeW5jaHJvbm91cz8gQ291bGRuJ3QNCj4gPiBfX3hmcm1fc3RhdGVfZGVsZXRlIGluc3RlYWQg
c2NoZWR1bGUgYSB3cSB0byBkbyB0aGUgZGV2IG9mZmxvYWQ/IEkNCj4gPiBzYXcNCj4gPiB0aGVy
ZSdzIGFscmVhZHkgYW4geGZybV9zdGF0ZV9nY190YXNrIHRoYXQncyBpbnZva2VkIHRvIGNhbGwN
Cj4gPiB4ZnJtX2Rldl9zdGF0ZV9mcmVlLCBwZXJoYXBzIHRoYXQgY291bGQgYmUgdXNlZCB0byBk
byB0aGUgZGVsZXRlIGFzDQo+ID4gd2VsbD8NCj4gDQo+IFllcywgSSBoYXZlIHRyaWVkIHRvIG1v
dmUgdGhlIGJvbmRpbmcgZ2Mgd29yayBpbiBib25kX2lwc2VjX2RlbF9zYSgpDQo+IHRvIGEgd3EN
Cj4gaW4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L1ozM25FS2c0UHh3UmVVdV9AZmVk
b3JhLy4gaS5lLiBtb3ZlDQo+IHRoZQ0KPiBmb2xsb3dpbmcgcGFydCBvdXQgb2Ygc3BpbiBsb2Nr
IHZpYSB3cS4NCj4gDQo+IMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmJvbmQtPmlwc2VjX2xv
Y2spOw0KPiDCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KGlwc2VjLCAmYm9uZC0+
aXBzZWNfbGlzdCwgbGlzdCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGlwc2VjLT54cyA9PSB4cykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGxpc3RfZGVsKCZpcHNlYy0+bGlzdCk7DQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoaXBzZWMpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgwqDC
oMKgIG11dGV4X3VubG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+IA0KPiBCdXQgd2UgY2FuIHNl
ZSB0aGVyZSBpcyBhbiAoaXBzZWMtPnhzID09IHhzKS4gU28gd2Ugc3RpbGwgbmVlZCB0bw0KPiBt
YWtlDQo+IHN1cmUgdGhlIHhzIGlzIG5vdCByZWxlYXNlZC4gQ2FuIHdlIGFkZCBhIHhzIHJlZmVy
ZW5jZSBpbg0KPiBib25kX2lwc2VjX2RlbF9zYSgpDQo+IHRvIGFjaGlldmUgdGhpcz8NCg0KSGVs
bG8sDQoNCkFmdGVyIHN0YXJpbmcgYXQgdGhlIGlzc3VlIGEgd2hpbGUgbG9uZ2VyLCBJIGFtIGFs
c28gY29udmVyZ2luZyBvbiBqdXN0DQptb3ZpbmcgdGhhdCBtdXRleCBwYXJ0IGZyb20gYm9uZF9p
cHNlY19kZWxfc2Egb3V0IHRvIGEgd3EuIEkgYnJvd3NlZA0KdGhyb3VnaCBhbGwgZHJpdmVyIGlt
cGxlbWVudGF0aW9ucyBvZiAueGRvX2Rldl9zdGF0ZV9kZWxldGUoKSBhbmQgZm91bmQNCm5vbmUg
dGhhdCBzbGVlcHMgb3IgYWxsb2NhdGVzIG1lbW9yeSB3aXRoIEdGUF9LRVJORUwuIFNvIGlmIHdl
IG9ubHkgZml4DQpib25kX2lwc2VjX2RlbF9zYSwgdGhhdCB3b3VsZCBiZSBlbm91Z2ggdG8gbWFr
ZSBpdCBhbGwgd29yayBhZ2Fpbi4NCg0KU28gaXQgc2hvdWxkIGJlIHBlcmZlY3RseSBzYWZlIHRv
IGFkZCBhIHJlZiB0byB4cyBpbiBib25kX2lwc2VjX2RlbF9zYQ0KYmVmb3JlIGZpcmluZyB1cCBh
IHdxIHRvIGRvIHRoZSBtdXRleCBsb2NrICsgbGlzdCB0cmF2ZXJzYWwsIGJlZm9yZQ0KcmVsZWFz
aW5nIHRoZSByZWYuDQp4ZnJtX3N0YXRlIGlzIGFscmVhZHkgdW5saW5rZWQgZnJvbSBldmVyeXRo
aW5nIGJ5IF9feGZybV9zdGF0ZV9kZWxldGUNCmJlZm9yZSB4ZnJtX2Rldl9zdGF0ZV9kZWxldGUg
aXMgY2FsbGVkIGFuZCB0aGUgeGZybV9zdGF0ZV9hbGxvYw0KcmVmZXJlbmNlIGlzIGRyb3BwZWQg
YnkgdGhlIGVuZCBvZiB4ZnJtX2Rldl9zdGF0ZV9kZWxldGUsIHNvIHRoZSBvbmx5DQp0aGluZyBr
ZWVwaW5nIGl0IGFsaXZlIHdvdWxkIGJlIHRoZSByZWZlcmVuY2UgYWRkZWQgaW4NCmJvbmRfaXBz
ZWNfZGVsX3NhLiBXaGVuIHRoYXQgaXMgcHV0IGFmdGVyIHRoZSBsaXN0IHRyYXZlcnNhbCwNCl9f
eGZybV9zdGF0ZV9kZXN0cm95IGdldHMgY2FsbGVkIHdpdGggc3luYyA9PSBmYWxzZSwgd2hpY2gg
cGFzc2VzIG9uDQp0aGUgYmF0b24gdG8gYW5vdGhlciB3cSB0byBkbyB0aGUgZ2MgZm9yIHhzLg0K
DQpUaGlzIGFsbCBzb3VuZHMgcmVhc29uYWJsZS4NCldpbGwgeW91IGNoYXNlIHRoaXMgZG93biBv
ciBkbyB5b3UgcHJlZmVyIG1lIHRvIHNlbmQgdGhlIHByb3Bvc2VkIGZpeD8NCg0KQ29zbWluLg0K

