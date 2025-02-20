Return-Path: <linux-kselftest+bounces-27064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF5A3D8D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E169516A51D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3E1F2C56;
	Thu, 20 Feb 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLKSAyRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024E1EB9E5;
	Thu, 20 Feb 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051219; cv=fail; b=PvIJH9qTDAo288+gIm6qUcWIUW2BtemgK7umgTL4hkAxLrCLY+9mO/0ODdS9zDYo9OqGSh69odORoU5InMgswZB5556GgXd7oigEal7+paNg/lGX3knjmYWXxE/6rYwOn6eiX9k89+wZBaCUvGCeN1fzXBo9EFYAWdX+0yAwolc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051219; c=relaxed/simple;
	bh=PzCpci+snJt4M5fQXCjDHBxcE+kxl61boITWy6m+tmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtqOW2N7y83djoPIYLNbafXytYYtN6uMASxD2O+cAiCtxTd4xmIzq2P5kqGPqCD+ypMEqTM5NsFf00JlxycYgmweHC9087e8620itTOQxZS3mWYsMbJ+rUICwyBFT7TUUVr8Pt3SduwPVViBRJx1pR+rSwX6d0ahEmsp/grgr9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLKSAyRJ; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwHBlaJeswQwUql14j3jUGzrxBbjLFK1bPraxhLekdZrqrpgpJKWZgmsBJA3fLBOcfLlIufmGKpWDT/knuwgrKv9OYRHWtUn6X8iKA/UhZwS13IVJk9p4Ied7GP23UJPy0nEqUaWdNBhXHyPxIdfCotY+/FACx5KwKVD5vXLRgv7Z1RNJ/BSg5pelMvNiFDGOLDf0xS8oOW7P6IEEtoFaozyumtgF4dSrdbTOYzRjFn0exNriX29jR2nPq4Gyp0S3MD/hATOsEuQce2uiiPoQEU8dwPGO9tlf7FniXJ+FBVzoHAgM0Hsd8z8aU5O/RKhFmR5f1vZTBRo8z7Sv8pp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzCpci+snJt4M5fQXCjDHBxcE+kxl61boITWy6m+tmo=;
 b=coZJ6ELBgmF1WrpWeMwo2R3IvbqmB5HKAYzrtZVVo7RwNY86iCvLtmtFWDSoko8RaNv50aLLg0zkjM19ZVo5JWeXN6q967gIlJowaTDSX7YtGD6H8FL7OxCL4WMZHamjBVV49VL+FSiPL7JsHcpXuyd8yn0lnA48WvbdAVitfraYp4bsVyQ5PbZSty6STZY7qoJwg9immPBJIICIXBX32YpO8raLVX76lN10XcYavbJJf6sOtqQNhuruOPf/5ncFOjjxY5mEKPrs8GdUoqQlL8FC1rLsaUZzrUzNBHoHw9KG/Ojme1ENEFvRisVDhpr2iUCOAiD7E/VkjhkBybPKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzCpci+snJt4M5fQXCjDHBxcE+kxl61boITWy6m+tmo=;
 b=DLKSAyRJMpH/phTgv9Imv5Y5Ajpd13SrZJ8uHzJyR10JQcnOhu3GjYi+Be+T6Wu4y4AVeCQ7MAZ7QEqs1tLWccivvdAMV+ElJU0thFeVMBkjy+qH9HR+LpFtVXw8+SBNRKxSfKgzmkkDSI+fO07z7MmDUiO/09e16q1fp/xsHVe8HgrFCXLvLQenShwM8p9qrcr3F4HpZHCpFxalQv6tZdrShBiQgRyZ+Zdscockis6UUNM3xGBI9gwQt40Mqc1mN94BcLHLCaqn3LUQEparLjNZaARplWKr/hfVAvp10NYqxwTyJAL/hgzGBt6UiRaIN/Pmbmess+sVhI75zPMASA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 11:33:35 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 11:33:35 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "andy@greyhouse.net" <andy@greyhouse.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, Jianbo Liu <jianbol@nvidia.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "razor@blackwall.org"
	<razor@blackwall.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Topic: [PATCH net 0/2] bond: fix xfrm offload feature during init
Thread-Index:
 AQHbS5v4eyZKdm8VYEWNCY/impKAebLirMAAgAEaWQCAAVL/gIAdz0mAgAANmgCABsJ2gIACnm0AgAAO7ICAADwBAIALIyqAgAMNBoCABUM1gIAAgTkAgC/bYgCAAAhCgIAABEUA
Date: Thu, 20 Feb 2025 11:33:34 +0000
Message-ID: <d1fe4ccfca946deae476d3bf18e4329068a54af4.camel@nvidia.com>
References: <1d8c901f-e292-43e4-970f-8440b26e92b0@nvidia.com>
	 <Z3u0q5HSOshLn2V0@fedora> <Z33nEKg4PxwReUu_@fedora>
	 <ad289f9a-41c3-4544-8aeb-535615f45aef@nvidia.com> <Z34l6hpbzPP9n65Y@fedora>
	 <Z4d9pVshf3RKQp_o@fedora> <Z4oM0cWuipPCWqeo@gauss3.secunet.de>
	 <021da64bc786df118dff1a9724c6958a517a56cd.camel@nvidia.com>
	 <Z47jVoQdO9sD19TB@fedora>
	 <40e2170b52f1f80fd72405df6901c4323f903e67.camel@nvidia.com>
	 <Z7cPdyDZ9OOIgU7c@fedora>
In-Reply-To: <Z7cPdyDZ9OOIgU7c@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|BL1PR12MB5801:EE_
x-ms-office365-filtering-correlation-id: 8f418425-dfac-4caf-c670-08dd51a26957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkFLRWVtWEZvYXZVYnNuU1NYUXkvVGk4Nm1KNkJieS9mTGgybjh3RHFYRS80?=
 =?utf-8?B?WnhtWTFuUlFQS0FnMmFqSjdZeTlLeUorSkNySHBxL2JNTEwrcjVITGkveUZp?=
 =?utf-8?B?Tk9LeDVZakZQcCtyN0QzbVU4K0RFNWhKdHc3cmpTTTVnTnQzajBVTDUyak1h?=
 =?utf-8?B?dEMrMmV2VEorYzlQWnAzWGR5WFpIWm5kcHFwMnVyeU1qMlg4T3M2cWZWV1hV?=
 =?utf-8?B?dFNZdXQ0OWxKY0k3eXhiZEsrMXcwVFZnQ2duWk00cm4zZlR5SWpXb2pibTBO?=
 =?utf-8?B?S3EreGFxZHJJOUFOZVlWSWd3Ymh2b29Ybm5GTjFLb2ZqT0JGWTZqZkE5bjF6?=
 =?utf-8?B?Q0JxeEpUNnVMYUs3RUxrcFpWWXRGN2hpWkdWRU5kQVNvczY1SmlhVnY1T3RD?=
 =?utf-8?B?YWpnNmVsQ21LekMvZkF3MTNjRU9vak44NzZqRE4xQ3lBUUowUVErVEtoT1B6?=
 =?utf-8?B?cGNWQm0rMmdieWF2SGRDb25BUnZTMlFlWjBTK29jbWZpb1A5S0FSdEVXeDB1?=
 =?utf-8?B?MERycm9GUVRWNENXL3pWcFBEMWlZTVBkWkNiZ1VBVTZpL1lMWFZoc1NQZnY3?=
 =?utf-8?B?KzhrVmxCTHQzVEltd01DUnRLMlZQY0VBN0NHbFhudVcwSG0zbkdCaFdJL3gz?=
 =?utf-8?B?QmRaTVplSVgxWVVTWVBSRUo0YnhOUDlvalAvL1ZyN1hERDRPaDBFTFBPaWFO?=
 =?utf-8?B?UlRCMHVMeW1wY1JZajhIenBISzcvcmdFbW81Qkh1S1YxU2d3TGt3Z0tyZm0v?=
 =?utf-8?B?ZW9CeWZTQklZZVorTXoyV3VUTjlQMkRiQ094bzBvZDh2WThYN24wOGowQktM?=
 =?utf-8?B?cy9BSFBwWEcrbTdqZllBM1ZzTkNuLy9vRmdhMGhsditVQkU1VWdJd2RYQ3JU?=
 =?utf-8?B?Vk83VVNjU1pSYlQrSG9KYkJzWnJialA3MWFZYmVweU93TUdGclpDS0JJb2Q0?=
 =?utf-8?B?Q2YweUZIZGVkVTh0UFRLN1JHM1RJWitTRmprWkhFSnRoelQwWUd3bkpxVHZi?=
 =?utf-8?B?anlmNDdueHZzak1uRXBrdFJCVWNZd1g2L0JLbW9sWXo0ZHJlVWVFVGxCVmJo?=
 =?utf-8?B?ZjBxZFpjUVpFRnBnVVp3cXRqTmR1N0pkcFBlZU9BeWhIcld5OVVoNWwybGRM?=
 =?utf-8?B?VWNVanUyc3U2b1ZUSE90cGF6K0k0YkNiYnduYTNWYUZuQnc5UDN3ekQxclRa?=
 =?utf-8?B?ZFRSbGFFVjRwK2ZFb1V6NzVUWlVVNTQwZlhXeWJzRzZrbEFEMzA0NGRJdXBs?=
 =?utf-8?B?dUxDMWVqdXpIbm9UR3N1WXhyN3dyL3lweXFXSTcrbXVyUjRTOUF5QzdYenhF?=
 =?utf-8?B?MENWY2RZNFo5UjRSUVBQR3F1eHRWaGlQWk51eVMxOG5TTzNkUXNSUTRjcVNp?=
 =?utf-8?B?bWtCTVBjVmVOdGxYRlNPYXNwSGVJTkJlYldEd0t2L2l0L1FEY2p1OUVhemVi?=
 =?utf-8?B?Q0d1S3cvcUthblpnQWUzTHVEcXQvTUlFVXZyV096R3dYQXM2Y2FLNDh5aDZp?=
 =?utf-8?B?NHJ6cTNkT25lZzJPSWk3VllYZEtNNnFiUUtaWjFkREJNbjg0VFhuQUlHbXMr?=
 =?utf-8?B?UjlJWXVyMU9UVDNsakJyWUR0RkFxQkNFS0VNQ0FWYmtLL1kybTdhdWs0UG9z?=
 =?utf-8?B?VVhGMlMwTDViWWp6RlpoWHBEaHkzNzFrbm9ieEQ2NnJLTTUyampOTTJ3WTNt?=
 =?utf-8?B?Z3NacWVwU1VXb0diLzVyNEpvRlZ2VTNHWm8wSU90bk02Wnp4L2lNVElUeENw?=
 =?utf-8?B?cWdGUUd3VWNlU1RoV1ROU2dwYjYrRS9LV3VhM0R1VWNnQ3AzQ29abnNYRTJ4?=
 =?utf-8?B?OE5IK2hNendBK3BFNzhjRmoxTXB5NWNlT042a2VtY0NyWElBNTJ1WVUrb2l5?=
 =?utf-8?B?Sy9acXdpUmdsMyttcTEwdTRXVVByTExEZ1kyVHg4T3hhK1g1M0d0MldhQjFH?=
 =?utf-8?Q?arkrmG/Onj3Su1L0x7FXx1uyU0LuwgFY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3RBYmdISzRzVExLSGo5eWsyS3NKU2xGY3lYNllkUWs3c3JTSm5EUldJUHN3?=
 =?utf-8?B?QU5PSXVnUnpITGE5dTZuTTIyWTZXZ0Z1RktreURYNGltaW9lbmE4TkxDdVFF?=
 =?utf-8?B?UUFHbTN0OEU5ZWdJZCtMdFcvVkJ6b3ZTWEl0S0VZODhZcXFUcThwZlJGYVJQ?=
 =?utf-8?B?SW1hWUJkTHFyU3gxbCs1VnBhZm04VTk2UG1FcmZTcUc1ZXphRmdNNW1KTmx2?=
 =?utf-8?B?MEphODlwdlZYOWNuQnhoNW1oL01aN0hlbVh1Si9UL3RsMEN5ZEdyT29SdStC?=
 =?utf-8?B?eHdUOXlWdEl4T1o3K09LQzRhWWxMMFFYWnliQWJsSjBjVTlqRUNqZWlpZUk5?=
 =?utf-8?B?T3pzZTZTdkZ3ek9ydWdUMmZvcXQ5ZFE2MEg4a3RUUm5SeFlWWlFyVFpYcUdj?=
 =?utf-8?B?WWtIVkxDbHhYcDFKTzljMUlKdGN4bUd2K0w1MTF3TWFBTEp1c3JteXk0YjRz?=
 =?utf-8?B?b0hVVDlkb2NLdFZObUk2cWRpSlorWGJPbDNpdFFSY1dLWDdEK21zVUJrVmlZ?=
 =?utf-8?B?WDBRYmNSMDFsa3R2RzJBeWVDRXpCWU9oSEtiTW5NWjVHSWZZZU1jTEpxQ2I5?=
 =?utf-8?B?UHF1R2RXTlpMWlBxV3ZhUXROTTBibkpRaVM3MURad2VBVFEzOENGVWM0M21s?=
 =?utf-8?B?Q2JtS2tBeWI2bFBJNG5Vb3lDRk5TRldYM09ESHdLUHVGdzlkc1NHNEdFU09J?=
 =?utf-8?B?SWhENFRWZWs5MzhNdXJYdmFucWxXUm9vN2hqeHZFR0pkQkJqaUdFTWZ6bnZn?=
 =?utf-8?B?ZklBYVQxQzFUdjBLUm1MR2o3LzlJQ0RFdlpKMGpsODF1ejVFTWJJdnZJZnht?=
 =?utf-8?B?S3ZHcHNkcXA1YnpaTlY0Y0J1S2F3MFBrbmtlZ3IwWisxQlpXcFJJUmprRFov?=
 =?utf-8?B?OWVVUzdkNFJsTmtPak5VMlZkWERCc3UvcVlNZnBNOUNaM3BNVDZkVWZ0YWFw?=
 =?utf-8?B?SVpVREZ6amFRQlBTZnVTd0I4NmpFSktFazJzdnBJWnd5U2duUVI4emo4aEJY?=
 =?utf-8?B?Y2tSWU54dzlNeEpCNGc2ODVjdVltZUdZdlRMZmNtOHlTam80QytRcGZMK24x?=
 =?utf-8?B?OThoTVdzZHo3dS9nRFJuRmYxRU1rM2p3S2tSMGY1TTZtazJMTmc3VmR6bkhB?=
 =?utf-8?B?NHNDTktidkV5QnBxSmdiV0NJMTB6RHRTVU03bllGK1dqb2k3eGdoVWdGZEk5?=
 =?utf-8?B?SzZaamcxcE0zQnp5Vy81NnlXeDFIcy9RU3FXT0dlMTA2cTl3WVJtQng0enFO?=
 =?utf-8?B?MXIrTnFtWElUOWZCL3orbFlhY1dLSXB3YzFMN1RwZDNqNmJ6Ulkyc0NEdjNU?=
 =?utf-8?B?cEFoWTJHQm5jNHhCc3JQdldZWTBFZFNPVGhweTdhYlJObGlXSnNLWFREOVVP?=
 =?utf-8?B?NHpZU2EwWXlIR3pPc2s1NC9POVBPZ3JXTXBUbHIyc0MzVDRGdVpybDNnZldS?=
 =?utf-8?B?Qi9hQTEzS1o2WGE1dVczWXh1aEhJVG10N09RaDh5VUlIM1lJbk8xTXR2bkJs?=
 =?utf-8?B?aVl0MkdqdytiMU9MN3kvZ2kxcmtJNmFxZlBJcGVNUG5oVUw3dDFSRm1xUUFr?=
 =?utf-8?B?YWd6Vk5pRGwraXhaSnpPUTROQ1dQQjBzWHZCMlByWHJMNVBSNm1pWk5kazJ4?=
 =?utf-8?B?T0s4SkhZeFJEK1pBRHlGUktnV0JKc0RiYTh0UExGQkhtWkM0QVJWRklzenFM?=
 =?utf-8?B?aVgxK0wzZmtFQTMydm1GZEs4alNmM0NXdFVERjBzNXF1clVyeTA3S3QzWG5Q?=
 =?utf-8?B?V0w0UzNlTmJUM29TbUJ1dFg4b0NnNTNyanFYWk1GSVRNaUVFODgyOTM1K1Nk?=
 =?utf-8?B?WTNFTWZ2cWgrMlppMEhpZlNHVExGcnVpMDFEOGFSdW9RRm9ncVFscTB3c3Ry?=
 =?utf-8?B?UVJHLzVKUXlnUXF0bW96aGk3M25MU3RSMGltR3RJTGthbmpHWG1iRkw5N0No?=
 =?utf-8?B?RzcvVWo4T3IzMXFaS0lTRlBvWlVSY3JlNHhJMGtzN203OEZXWmE1NW1TK2N4?=
 =?utf-8?B?RFZTK0d3Qi94R0h6QzAxTm5IZ2VLV3QzMmwxN0ZEU3BESnZoc1BBbkpHS2dI?=
 =?utf-8?B?U3FSMkpCZUgyVlk1QU00V2pMWm1nZWxwOEJTNnpMNTRqMlZodjk3WitqUE5K?=
 =?utf-8?Q?mB4VtE5roTu1og7lIUD/9MdS8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2A5EC4D742195459EA27D51D936DE7F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f418425-dfac-4caf-c670-08dd51a26957
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 11:33:34.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LAO/u/Ld2zMC4iYgC0oFiMAy9Hpf3thCty9f+js3Qtlg7Q9EjLLQjJvvQgkYhtX5fsog54CmMV5HkBJw3z44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDExOjE4ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIGFuZCBjb25maXJtYXRpb24uIExldCBtZSB0cnkg
aXQgZmlyc3QuIEhvcGUNCj4gdW5yZWdpc3RlcmluZyBib25kIGRvZXNuJ3QgYWZmZWN0IHRoZSBn
YyB3b3Jrcy4NCg0KSSB0aGluayB0aGlzIHNob3VsZCBiZSBoYW5kbGVkIG5hdHVyYWxseSBhcyBw
YXJ0IG9mIHRoZSBib25kIGRldmljZQ0KdGVhciBkb3duLiBBIHF1aWNrIHBlZWsgc2hvd3M6DQpi
b25kX3VuaW5pdCAtPiAoZm9yIGVhY2ggc2xhdmUpIF9fYm9uZF9yZWxlYXNlX29uZSAtPg0KYm9u
ZF9jaGFuZ2VfYWN0aXZlX3NsYXZlIChfLCBOVUxMKSAtPiBib25kX2lwc2VjX2RlbF9zYV9hbGwg
ZGVsZXRlcyBhbGwNCm1hdGNoaW5nIHhmcm1fc3RhdGUgZW50cmllcyBmcm9tIGJvbmQtPmlwc2Vj
X2xpc3QsIHdpdGggdGhlIG11dGV4IGhlbGQuDQoNClByZXN1bWFibHksIGEgbmV3IHN0ZXAgYWZ0
ZXIgYWxsIHNsYXZlcyBhcmUgZGVsZXRlZCBzaG91bGQgY2FsbA0KZHJhaW5fd29ya3F1ZXVlIG9u
IHRoZSBuZXcgd29ya3F1ZXVlIHRvIHdhaXQgZm9yIGFueSBzY2hlZHVsZWQgd29yayB0bw0KYmUg
ZG9uZSBiZWZvcmUgZmluYWxseSBkZXN0cm95aW5nIHRoZSB3b3JrcXVldWUuDQoNCkNvc21pbi4N
Cg==

