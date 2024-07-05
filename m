Return-Path: <linux-kselftest+bounces-13248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3473928D34
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B28284462
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B416A930;
	Fri,  5 Jul 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TA45mf9O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DC2F32;
	Fri,  5 Jul 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202313; cv=fail; b=EbC9J8YwF1O0BsktC5s+HVIC08BCHVPBIK52YNRgquV1FxOUN01vV3m2JJypOLE3dLUgCEqId9tu1rcvFB1mb2iHULaBLmdU7b6nCK0e1EYh77UOj8/IS7MnhCKHOxBXWBg2WS2eEpoF5u+BYC/0bDg5Qoge2yJuwGCu06Hhaik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202313; c=relaxed/simple;
	bh=JoSLO4chuPNIKrhF0KFE0k9lMb4uAaJgkmsiPwmgoHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NwWLWIRymensdNdLrPih0RwXQODUm+AS4r2WrpSqa8R9peSWhNmKq7l0WsezZC2BSMibroBwhei33V0cLEBanWO0TQJQSY9CMS4OgQeTunZ42yypjxH4gwr8FfT6MElLjq+2ADTUtNZBEJ4hNSBbZLw/PM32gG3dNfnG8NieK84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TA45mf9O; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLBFmJMKFwbFQSQGnvehzUpRcIDjTN9R3wGMivXu65O8d68dGIZ46WVp+u7wMfWWi43RDi90AczzR79rD4pYYRlChwTZT+ZauO2U5t85B3VI2MFZ//43GCPdqSiFDuhpe7ScCu1ifQvMxfNWqfcZZYEuKjGcyBpfdthV1VicWE56O9DJ+BojIuHONsVYfwAs5VXGiOtlQjLqRr9cFJlcddyhAZ6MAK8m5AHkXoaFv1XcD0s+LEWFOLJwVfPUJKjcFXHczuX6RIVeqAiDO1ZFCop1ccYI2S/xEaZMxH8I8rOKrrldaTyd3QJC/USbsMa6zsO53FBaUsplDk6+m5gurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPqXmeestZQiby783hlMauGJsWMQEun1RflflJWZJAM=;
 b=gTGLHdJn03cjYogWXhWVLtGKPXZa1mTRpjymJkeepq8P0/jY0eWg20Uks47+teJQOESVVda+YxodGso76eFD4VcO+BObBnHIYqqfUWj3zzKkJyPtlgS3rsQd3y88AbPkTTxPhumGmCc8jYU6u8yx2CBpbFlIQEx/uLB8ELvrDracMMCLlLoan3tn4SOPGximpPv+MdX5/L1+i8GpuY6y9NL5/0y9j8w3iWj23hKLD+P/xvOsd08bCHdojr+XxH/y6NPrJHonL9ndqkma6oKFQx9sHd0QLOJQ4Hn9ibbrLjHnMjKQvRddLzzZlQs9+LWJbongVRjTQlxwKP9jp2YuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPqXmeestZQiby783hlMauGJsWMQEun1RflflJWZJAM=;
 b=TA45mf9OMep6Yl+CoGT+rU7B2MCLRWkT17EgRiVCKChhfoxkETahTlOdD+WjYaDuz1XOgOAVo2a6ZjAJPZwFvhh37Z7Cw/TifAjZyrCpdW+55MjR3eGb+F0c+8McO8vsGpqpAWA8Ohp/x7nCgF11omEobBUhmrJUAlZz8A28yvfrXd2/oprt5rKgifncok8p+mo3fyk7pcEx7qjbnI8RcD30mv2sfcDPygQ79cktiK9I/szuZXKiaG4Xfi26JMXHU1mimSBOZNTyBa2z7W+7GX9B5dg1cNTN9EjArs1jUoAo1T8P8TD+VxxgfhdMWAIz1vg+uwi7ii5ypccov+cA3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 17:58:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 17:58:27 +0000
Message-ID: <da35faba-b6c7-42bd-86a1-57328ebc9ad8@nvidia.com>
Date: Fri, 5 Jul 2024 07:58:20 -1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:"
 target in Makefile
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240704023324.83564-1-jhubbard@nvidia.com>
 <20240704023324.83564-3-jhubbard@nvidia.com>
 <9b59fc84-2d78-4304-9f39-3a495e438af8@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <9b59fc84-2d78-4304-9f39-3a495e438af8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: e825117e-419e-470e-c3b1-08dc9d1c1289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzU0RHNtaitxZ0FUZktpanlnSlgxVVo4cy8xMEZIY0Y4ZzZLSHhRNjRNU1cy?=
 =?utf-8?B?bVJzazMzUjNmOHVHcjk5L2M3ME9lYjFDM0IwZGNIM0t2K3Q5NENxcFdXSThB?=
 =?utf-8?B?ZnJ3cEpVbTBVdnF0Y0NOei9PaldJM0pTQkxqRGJoYm9KbVg2NmMrNGpoYnBC?=
 =?utf-8?B?VC8vU2JHS3lVeDEwWnhVeEVTMVBsazl1YVBscXZaYytiZmJnd01qMlBBNGJh?=
 =?utf-8?B?VFJwMzBFWjlZRjZjWVlOMnZrS0RNMVVRak4rVk5YV2dHWWRaZjZlL2Nqa3cy?=
 =?utf-8?B?dFhNL0I1RWhuQ3RHMThyQjNQNytJNWJVVXBDOStYcS9POTU0ck1lTWN3a09L?=
 =?utf-8?B?dXJZS2MyOEtubXM1azlGUHovL2lHN2dPMGJSaHZZTzRick9sendDbUplenA0?=
 =?utf-8?B?emdETUZTVFk4Q3RTbVFoZFRJR1F1WnR1emU4cXhlSlE1Y2VsQk5HRExvRDRh?=
 =?utf-8?B?TDFiRUdpT3JpTUp5S2l6TXQzQ01XMXNDeTR2RnFaN1V0NFdZTWNHMWZLdTlH?=
 =?utf-8?B?RVg3RzAxdGdlczRobVRVY1cxb294TVAwM2N5cjltNkNsQnNBYm1MUDBsVS9s?=
 =?utf-8?B?Q3JHcEp1elRSK1pYcURTeWdvOFZrOGlIdzJWRCtSK1JLTXZWT2xBVFI5dFN1?=
 =?utf-8?B?czV6dEM5bUVvSmJWTGY1N0RPUTJjNnNsTEJ0WjZuWFU0dW9rK0lVblBVdnBs?=
 =?utf-8?B?emNmRXgzc0pYQkNhMlM0ZjRUb29vQWZwbUtxN2VOVnVpNzlXQllzUnNrWlFE?=
 =?utf-8?B?QTZDM25GenJOVFdzaUMyMWFGMWVEbXNZbHdLUC80ZzQ1L21LaVowcDBIckdR?=
 =?utf-8?B?MjdkMUUwZS9sbFFQK0ZyZWpzeThYVTdGclZ5NG5PeFlqd2syb0ZqendRUCsy?=
 =?utf-8?B?dTU4eC9xVC8xZEZxemNhQ1hndHgyay9zMlpzbE9wM0JkY1NTd0ZhRjVIT1dt?=
 =?utf-8?B?TXdwQUthWDJwVnphNVVjaTZvMUlFcnNBYkc0NlhMdGthSEFCN0Q3SkIxQkd5?=
 =?utf-8?B?NkdCbGxGU0lYRlBqd0hzcElKYWFpRmd3T0kvTEJWT0VyUlpIT1Z4WldMK3RG?=
 =?utf-8?B?Mnlqc0NldzlWMDloWjlpTTcrN2tQSEIycjlFL1lPODgvYmFIQ0dJMkVNaFdq?=
 =?utf-8?B?dEZRWmVoNUdmRm9va1N4d0NML0lHTDA0ZUp0U01Vd004SnZDekh3NE9MMGg4?=
 =?utf-8?B?Y3VxVnFSQnhUYkZoYVcrbDhNR2NNZEdlbGVEQTZ4MDZYZE1MaUdpeFoxWlBM?=
 =?utf-8?B?OUdiOWZZVm4wLytkMUR5N3dZTzNXZXFhTGZkcDh5QmNIVGNmV201UFJ0cFFG?=
 =?utf-8?B?MG1USWpSazRtaXNmeGVRTGFMeXFYNjRWRGdaRklNTXdLa2tMemhZbUdHM09p?=
 =?utf-8?B?dXBqVmVkbTg1TDFNeWJuNmljK2hsalJjdGtkTGJXeXg1L2liTU5PK1RabE1U?=
 =?utf-8?B?WWMyS1B3ckZwaDRNRm9jR2R5TTQ4eklxOGlCcjhvb1kySnhPVWZmT2Z4ODhF?=
 =?utf-8?B?U2N6Qi83UkowMVFvbnk4NjlEbTFtdEh0T0pOdXVuL2JqNmxYaEV5SnRJTW53?=
 =?utf-8?B?eVZUbmtZZmhsMVFiRmxpaHpjcmxmRDZjREZ3dXVCSkY3UE5DVEZvNzMwdnl2?=
 =?utf-8?B?UllzaXhmRFdiTXhPT1VsRlQ0bi9yWUV4ZmNRZDJaOXI1d2JaTnJhTTJ2YXVM?=
 =?utf-8?B?aDRjbWMxa2IyMzFBZ3N4c0Eyak9YS1RZVUZoNUliL3NHNDhOVkJkVU9JWGRM?=
 =?utf-8?B?R3dnRlR4ZEs1VDNxVHpLOWc2dmVHRVY4TVpMN0c2bXJTbm5lMkQ2M2xvUzNJ?=
 =?utf-8?B?NXlhWU5Id1d0MEdJcFRvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0xrMjNaS0NUaXJCNHFwUHRwazFCWStqb3BYeXpNUlVhNUkvS3hqOElMYmFD?=
 =?utf-8?B?R0I5STFWdEZJT3dkdEkvWTc2ZktPUC9vMnNaNFFPWEdzaFlzUmV5aEFGSUQv?=
 =?utf-8?B?WndoU2hwQTliVXVhcko4ekVXUFNwNWJYNTFEUWN4TXBPWkxNVnVZK1NqdFE5?=
 =?utf-8?B?MXU1Qmx5dm92SW83a0s2V3c3RDBsN0tuWk1nNWp5Y2dJVEVuUXRCSFpobDhD?=
 =?utf-8?B?cjRwT3FING5DeldhWGRWRSs2UVZydDFrVjNKdlJaU3kycW93RkhSekphMDZl?=
 =?utf-8?B?NkVDOXRWcUI4TEVTZTUzbzRnUEY4TlFzWEJQbFdlMnZRN0Zacjc5Vmw4MEJI?=
 =?utf-8?B?c25RQnQvNGdna1BtSXVEZXVmZ3J1L3lmL2RWWHFydVRwamtvVzUrVTJ3SWN3?=
 =?utf-8?B?SlNFcXBDc2QzVE4xaTlrdHo2Qkc0eWthVE9RTldCdk83cGNCRXNENmxEdnNa?=
 =?utf-8?B?R0JiM2VEL1RJRmt6amsrSnE1eWxkUzgreStxU0F3d25FbDlFbHgzUWg4YjNT?=
 =?utf-8?B?ajJSVElDSVRSSVZvdkY4a0pFM0ZRZWlubEF6ckJYYmJyTERyWEZKUU5wSmRV?=
 =?utf-8?B?UjRGU2ZhNHh1R2IrSzdSeFhEVkUrM2IzVmZLMFlYdDZ2SHVIbTVpOEYvcDBJ?=
 =?utf-8?B?WWpRaG12M25ISjYxZkYrTTJKbUdvNThMSW9wa3dzKzg3OW5CQm9vYWhTQ081?=
 =?utf-8?B?Q1RoOUxFWGJlQkFpZEQ2NWlnNjRFcnV2QTZCVldld2RTeUE5N0g1ZmFUOVBx?=
 =?utf-8?B?U01VZTRrSWMrcENLQkFJV2ZLWHV4cEZ0UjV5Sm1paGRZMU54am1ic3lUR0NW?=
 =?utf-8?B?WHI0SWN5OW5sTjZRZDllWkdtRDNsUUhtMHQ2R0J2b3RJUHJuUXk5cCtMeHQz?=
 =?utf-8?B?WnhxSnRtcWFMdXByb1BHMDgwQUV0bTBEQXAvZkJSa0t0SUZRNjFBbThXb2sv?=
 =?utf-8?B?VURVNjhrRUdZR3dmNmpHN0owZE5GbGNtYWVTM3ZQbmJjR1JHUHNrcnYrTVk5?=
 =?utf-8?B?dk1TOGZjZmRIQ0xETXZoeGVPSE50Sk42RWN2cjVKUy9ZK1B2c2ozaXpYNUtn?=
 =?utf-8?B?U2pMZm1vNmVFVm1LZzdONlBBUEJtU3FNSzZlS3BaeW1WVmpuVjV3bkZsZjJw?=
 =?utf-8?B?K0ZJVnp4bm5lNGcxU0xtTUx1S2tYRjRLQitrU0k3Zi9qTzF6TE1yVmc3ZThG?=
 =?utf-8?B?UDc5Nkp5U2dpRlNBRkpUSFRSVGpqQnpZOWNUQng3U1ZaY21GOXExZzJMMEpp?=
 =?utf-8?B?RzZjQXNGR0ZRWmNnZFRsalczNWt0amhHVUk2ZGZQaDMyOXlJTW1kZ0xyRHRH?=
 =?utf-8?B?NnU2WjVaQTkrdGM1ZURsUW5XSjZ5M3huaVBOZlh0cGNIdDd2dUNBOEwrQ2pn?=
 =?utf-8?B?UHZVQ0J3WnA2VnFEQUNscDArSnBUK2hqblA3emkvSmZhTnYzWS93Ui9zV0c1?=
 =?utf-8?B?SjdkRzh2ZjVYQk9DUTNESDc1cy9sMEh3Nk1qZDZwVkovV2daaktSMldvWU5Q?=
 =?utf-8?B?VGUrVVRybERwUTBYNCtuVDJ2T21YVTZjMHA2dVE1dVh5VWR4T3h2Qm5Ldzly?=
 =?utf-8?B?L040V0FhT0ovSi84TCtXMWRBM3E3U3FnV2pHWWxmbVMzOGVpck8xZ1paUFI3?=
 =?utf-8?B?VzlaSXY5Tm9aYUZYejJEMVBpbS9JbFBmSkQ5cVpyWkRpRGF2Z1RaTnhNWXZB?=
 =?utf-8?B?NVpzQjBldXNnaGRvUTlMek80UUdzNGErdWE5YTVKeW9CRDNNVGR0dWM5UjV2?=
 =?utf-8?B?NWp2NEVnV2tNRUlwSjVGK2R6bzNMTUpCeExWeFRYcEY0TFc5NkJtL2NRODU0?=
 =?utf-8?B?RHBEOHFSMC83czNkTms3T01DMm1SL2UybzJIZ2poTHRxNFhPVENqeUtncUdk?=
 =?utf-8?B?R0laT2JaZUVEK2UxMkNKME44eW42ZHRxcWdQb1RDL3F2ZFo2c1czRlRhanRl?=
 =?utf-8?B?clFVWDhITnRYeWE3OVpKbnFrcGxsWmpZNkNrYVh3NmxubldSbUExN3FNQWVX?=
 =?utf-8?B?NUdlbTZ6Z2tJcWw1N2ludUVHZCtOYnNuSUVjSlFQWm9KQmk2a3JJYzdBWVBt?=
 =?utf-8?B?alRzU2l1eHpuWEsyQ1dyN0FzbGJxL1FTZFdubXhLMk8zVkZsdUhBdmEyTHdX?=
 =?utf-8?Q?TSLWT7zHGD7807cX9Xlgi68gP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e825117e-419e-470e-c3b1-08dc9d1c1289
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 17:58:27.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBsOjoZYy6GkgMpO1ZqFi1uMEl+XwZAYuIx3Y/XalvMnIVEZIFXZ/UdAL126E9NX2nj3CLYbG25EJ8kplDKTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

On 7/5/24 10:53, Shuah Khan wrote:
> On 7/3/24 20:33, John Hubbard wrote:
>> There were a couple of errors here:
>>
>> 1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
>> to be built. However, lib.mk already does that because it assumes "bare"
>> program names are passed in, so this ended up creating
>> $(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.
>>
>> 2. lib.mk was included before TEST_GEN_PROGS was set, which led to
>> lib.mk's "all:" target not seeing anything to rebuild.
>>
>> So nothing worked, which caused the author to force things by creating
>> an "all:" target locally--while still including ../lib.mk.
>>
>> Fix all of this by including ../lib.mk at the right place, and removing
>> the $(OUTPUT) prefix to the programs to be built, and removing the
>> duplicate "all:" target.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Why does the summary say mm ?

This is a mistake. I was also preparing some mm work at the time,
and typed the wrong thing.

Could you fix it up to s/mm/vDSO/ for me? Or if it's easier, I can send
an updated patch, let me know.


thanks,
John Hubbard
NVIDIA

> 
>   selftests/mm: remove partially duplicated "all:" target in Makefile
> 
>> ---
>>   tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/vDSO/Makefile 
>> b/tools/testing/selftests/vDSO/Makefile
>> index d53a4d8008f9..209ede5de208 100644
>> --- a/tools/testing/selftests/vDSO/Makefile
>> +++ b/tools/testing/selftests/vDSO/Makefile
>> @@ -1,16 +1,15 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -include ../lib.mk
>> -
>>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday 
>> $(OUTPUT)/vdso_test_getcpu
>> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
>> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
>> +TEST_GEN_PROGS := vdso_test_gettimeofday
>> +TEST_GEN_PROGS += vdso_test_getcpu
>> +TEST_GEN_PROGS += vdso_test_abi
>> +TEST_GEN_PROGS += vdso_test_clock_getres
>>   ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>> -TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
>> +TEST_GEN_PROGS += vdso_standalone_test_x86
>>   endif
>> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
>> +TEST_GEN_PROGS += vdso_test_correctness
>>   CFLAGS := -std=gnu99
>>   CFLAGS_vdso_standalone_test_x86 := -nostdlib 
>> -fno-asynchronous-unwind-tables -fno-stack-protector
>> @@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
>>   LDLIBS += -lgcc_s
>>   endif
>> -all: $(TEST_GEN_PROGS)
>> +include ../lib.mk
>>   $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>>   $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>>   $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
> 
> 
> thanks,
> -- Shuah

