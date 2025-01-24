Return-Path: <linux-kselftest+bounces-25073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910AAA1B170
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691427A55DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771D205AA3;
	Fri, 24 Jan 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IhDaNoRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46881D61A3;
	Fri, 24 Jan 2025 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706358; cv=fail; b=FlXGzzKotcQnTsWcpjpV9Bsn1+m34U9ICxd4mlNAju8v2j9Ki4EUCF3uG68eAYPrKMI0igqQiYCwulMz1dbKaoXfAHs4k8Kv1zIvx904j5smIqK4k2xf1CPMlg98+ZkBcvoZZsv6FNE+CypzydCtHu84aKX4/c8PrZq0EOCg0jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706358; c=relaxed/simple;
	bh=2IqLwCU0ZLQV3Ig+pb3BH0JYCPCPHNdmwPDMHL6gdDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvh+u3QEPlmgSttourvTldi7MeY+cjAPVO9xrLL0JhLBkToq09qOm5VyL3b0NwJgN9ne0PUDc+iQsaNQmceTxwGwd9i9JBmaBEQ/pTDM4Ywh5NRvD7Z6f1UH5YgHaD8DBhnQfrDJ9WRLTbAEU/P8dz6zCGogSQnW9qZlWU6f1Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IhDaNoRL; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndYl7/t+9jUCfmOs4l6rLj6Pn1yJD7hp4D0afiRhml5sxl1tG+xiyP5ajwGo/Voa7lOMmjsndEqYsO2ZWRcpyPBmfg1wTbZvD1IJ1VKLER3xOFcfbV0o2Ptfu2An9cHYOgWeIG8H9Fxyb9zph7wNWDIkVX17QyefmeUxcTbCTxPxhUIjRi2THr52raHoAz5SfWN7wERVaPQApkYxb1Cyaf4Rwtgh7lzFcALDcLoAwciDVW/hnH90Hl8sXzk2aoTxPF8cQ65zKQk+2/oKE56mcASDlYJ1j+uuoWrHPvHPmN3D/T4WoND9l4Lnp7w/WAgHz18BAVqjZO2UuQ7/Ts0w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IqLwCU0ZLQV3Ig+pb3BH0JYCPCPHNdmwPDMHL6gdDU=;
 b=J++zY3sz1/h5M8kt4wKH+YBbsTmQKoE6BMehUyjLIGexf98qrZ2bIPWdTzY5cH1sJHyDYLR91zWlNn8CERhfOTKRS/DPxptcfIGKqpAsNkipfQkLYyPzmElHbWD1GxwRIHQftwJ16imZfeaqZv3YXFizmbH25fKtC0FUJ7+aZjoB6//PjTfNs7hfOjG+t6b6Q2JKamZROSzHJRVtSmiLqoGozpe1D246Zv/M1tTUNK818WlEkBHCww9HOtfz0tzc482WBkUYzXY1ufX+Xi7cSYZiGBlkr5ZpDF1NM6OD2+bqNYkSOUzwnYvdSHKtwPs9/XaCnwUImbOVHmxD8CmBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IqLwCU0ZLQV3Ig+pb3BH0JYCPCPHNdmwPDMHL6gdDU=;
 b=IhDaNoRLWaZek0IU5GHcN9Q5dz6+9N7twfLz05InoVKHl2CKJFXT4unibG3jKbv/wIQyKhi0/VdXX12D8Oc0Sc/WkA0CqA4N3bKYrQC3CkkfwMgJfBIbq6egEXTsQbgiJNaIn8RHIq9Bzcn8bdQAellRL0IJdO6E8lvdu3X/G0Ez6LwCNeBO2o66VF3myodkQIMa+pmDyUqRz728tjzQUiEALOKhShg3dwuf56HG/JUTey2f7ZC8xzS+bfjhPDuVdDv2MbUFWlPC7lIgJ8nrTySYoMwtQ6PxpOfHioS6hEMvT1LGK5o7f6taQ7J1HAgcgOXBwvQT3M6pse19wziuHQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Fri, 24 Jan
 2025 08:12:33 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 08:12:33 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"liali@redhat.com" <liali@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH net] bonding: Correctly support GSO ESP offload
Thread-Topic: [PATCH net] bonding: Correctly support GSO ESP offload
Thread-Index: AQHbbajgQrlK0rrUoESpz02Rt3WX0rMlRP6AgABPHoA=
Date: Fri, 24 Jan 2025 08:12:33 +0000
Message-ID: <810c87b1f1c51f659b3f89001907f003973e1c3c.camel@nvidia.com>
References: <20250123150909.387415-1-cratiu@nvidia.com>
	 <Z5MJEShoqJqiNWP6@fedora>
In-Reply-To: <Z5MJEShoqJqiNWP6@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MW4PR12MB6923:EE_
x-ms-office365-filtering-correlation-id: e5f31e70-ef44-4bd0-d01b-08dd3c4edb0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3hKWmZOdVFpTVc4TlpiWDBlVUt6YnNaZjd5c3JYYnpDZDBtWnNGSVo1WVZj?=
 =?utf-8?B?Q3hLZXVzcWtDcGlyRElaa3dqaGNOM0tUTG1VSFlDbysrd1hXY25sOUZOOTAz?=
 =?utf-8?B?UVc3V056cG9UanFzZEFBUXhtQVJCOW5qTytjZ0xVNlpXaURUaHpkUlJuZ0kz?=
 =?utf-8?B?SFZ6V3BsbXM4bkIvVnR0V0p5d3VUOWhIZVNNQVVIZ1d0ZXcyQXBHd3IzeGpF?=
 =?utf-8?B?dUxsd0lEN2xjUEk0c0k5bHQ5WG5FNHlZb1krbHE0ZTA5bGNHTmhJcTJVZWNB?=
 =?utf-8?B?UHhPT3dmZmo3VWJHUFB6cWJ0dVZuR21pd0tmVndmNDFUeU53TWJ6eUp6ZXRx?=
 =?utf-8?B?MjJ3YnU0MnZ5eGFsR05HVEJiM3ErRXR6dGp6ZGM3bG1ncWkyUit5NG9qZGVo?=
 =?utf-8?B?bllGOWZRYS91NHhtaHI5NmF1QTBKOWd3YWM2UTNIKzFyQ2JrMThNWTdINzcw?=
 =?utf-8?B?czMzTlhyU2lodHFYSmtaU1dmUndhQW1nSm4vUWc4eVV5NkRBUHRUTWZIalJP?=
 =?utf-8?B?UUtHZ0FMR0lzSU8wQVBTQzBHTHNtNFBaQm9wMjBISnYrRmtkQXdqNXlSSG9a?=
 =?utf-8?B?OTBDazF4RCtrT1hDbHhaRTBKL0VYb2ZNTWNXeENzUGliS1YxZzRNLzJqbGxo?=
 =?utf-8?B?SHl3UDMzcFpEU0ptUVVqT3RxbVVuZlJ5aHJZdzJDQ0lpaWg3UEVBWXRQR0xM?=
 =?utf-8?B?bVZ4dHF6eUZxdUMweFBVNE1IZUF6SDJYWVdwWHUrclVNYVRETWhWM2pJckh4?=
 =?utf-8?B?VjRPamZGYmxKUkJIOTZ2SnZvUTIveWZqZGNORWRQd1UwU2xrOVpjWVg0UzBa?=
 =?utf-8?B?V3dya0ZHZnJZejlHOXRmL1FTaXZyZGw1emlrdlA4OUszbTZJNUg5RXhiS0Yv?=
 =?utf-8?B?bFNScDg1YmdETUQ2WnJ6VmFwdHFUektoeWcra3NMRHgycUlNeTVYdlB4SmJj?=
 =?utf-8?B?RnZZdzIzUTQ5Z3dLUW1YR0h0UmZmeXNFN0tCKzBNSGVqblBzVFZzc0x1NWx4?=
 =?utf-8?B?aW5iOHNmT0E3NlFMUDVxejlxdjViSE0vaHBSaGNmTGFrSFN2aVVTMWFMUm5u?=
 =?utf-8?B?ZnFUOG1yMVJTRndPZk9US2FjT2ZvdUNXaHNRUWRIUjZ4dVJ6S2k3Q0NFOTg0?=
 =?utf-8?B?MEg3V3UwMGYrY0tNV2Y4VWx3cTUyd0pCUVJmRlR2YytpcFJTdk0xUjdRaEg1?=
 =?utf-8?B?SE8rNkI4QXl3TVgyNEIwS29qc3BUeG9waXZsQnRieXFXckFhUmhDK0pkVDJ5?=
 =?utf-8?B?RlNWTVJqWXYvU3hidzkxbXRpMHpGVWdoc0lNNlZzbGcrRGZVa0RXUHBMbGk3?=
 =?utf-8?B?dTVGUHg4WE1zTnFOUFBidVhZZ1VDeWd4YVFhdjlERHJXZDIvN29NVVNzQzlt?=
 =?utf-8?B?eWRlSkYxcS9uTnlKSHcyZEV2ekZPREltUFRyUVcya3EyOHJSK1pwRjNrbEpu?=
 =?utf-8?B?YUxFNU5MRkZQTzFTVGF6SFJibFNHV3R2TVJMSmYwa0p0MmVwSWczanBwU1Vn?=
 =?utf-8?B?cW5JYVpSYmp2eEF1aDIyNE80NzNaazB2dkU1b1BFWWpVckl0NTBlYnRrL3Zs?=
 =?utf-8?B?SG5qOXFxV2ZrZFc0UzB6NXJoU3RmM012dlZQcjZueEtCRVQ5QnJQL21mSXA4?=
 =?utf-8?B?TkNLNS96SU1ObE56eWIvTWJYdUlndlRXWkFWSnRMTk9FTnpqN296NFY4WEFB?=
 =?utf-8?B?N0lsZURUR2loYkVKdURQMlQrWWJkM1lycGwxOThnVzRiQU1iQ3hzbW50ZW5G?=
 =?utf-8?B?S1pSeHo4ZXROWmtoZU9yeUdaUUI2ZnRpUkV5RHdNVDVkSFNYOS85V3A5TDly?=
 =?utf-8?B?MUNnd2g0di9Ecm41eGhjV2xwM0thNTBEbGRZMkZVbnhlQndBTWdscGJNTUR5?=
 =?utf-8?B?K0RiZklmK0hCMFNZclg2WTRpcVdqQTBJUExDNlc3QlR6MlNMcVl0UDk0RVBX?=
 =?utf-8?Q?ErACOosKORM2LNcXIQiZsEbRlLgtrW/t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlJXYUIwWVdBUS9BQ1hUaXA0Nmxkai8zcitqWDFMTlFJNlNFbUw4aTlVeG9O?=
 =?utf-8?B?KzkzY1NhaUlhVHlBRFlhd2ROaXQ5QXRubXFjU2ptdjhqVERWUWpHaFpiYW12?=
 =?utf-8?B?VXJFSWsxUXhRWVBmZmpOZ0xkZE1hL0xhWTYzV05jZko5LzdXSHBrUG0xaTc4?=
 =?utf-8?B?M0gxL1ZtcUVxQ3NJeWgyWWY3M2R6SHJ0SjUvVXUxS2Q4eUgwSFJoNDlYN2to?=
 =?utf-8?B?Ujk0bmhWRmlJN2dMcFhtUkJVQ3YyeEZJUHpWdUhVUjRMMkNneGFjNzhkZ1Fo?=
 =?utf-8?B?T2xnWUxiQXBseThOUUpiVU9oNVp3OXZOSHdkK0NTSExWalROa1ZQeHd0bGxp?=
 =?utf-8?B?U2lZeGdVTXcxNkpSdzZXQ3JtVHlPbUtINkp1dkdKTHFkZFl6NUpoOVc2cStk?=
 =?utf-8?B?UUY4NHV0M2xOUi9aTVVuNStVbmZOa21wL3Q1bHBHSDAvOXBjVEoybmpvVTFS?=
 =?utf-8?B?U0JUTEx0aGlpMmtoL0JMSHlsL3pvaWdINmlFK1p6RE5FVTNHUXN2a2ErVjZM?=
 =?utf-8?B?NmFpUWJBRWl5REZKb29FWml1RkFpU0dlNUFlNW5TSVJKR1R1dmNHNkcycHI4?=
 =?utf-8?B?andhcXhzd3YwWGc5M092TE43ODRaNkNFNmw3Tng0MWptOXV5WVJiUUhiS3Z1?=
 =?utf-8?B?RU00REdrUlpKVHl6TURJZ2I3K3gvQmJScXltdmtOOTRiN21rSkcvMCs3RFVv?=
 =?utf-8?B?VFRpMDREUU1VUEV4dkFoNHBtdmFNakFsL29oNkFUZnZRUDA2NUFpdU5OV1VO?=
 =?utf-8?B?SWRQUGlwM1MyWnE0MXNtZ2o5R1BOckZxRDdCSlF2cWFWM0dvUkJxemZKbklr?=
 =?utf-8?B?OE1XTThXcVE1MG1VK0pUWERUbmRhcS9vQm4zNWVDeThyRFgwSHRJL1lPczlW?=
 =?utf-8?B?QTZpWTdHZDNCdUJOd1JBOHdibGtHQ3hIOXlOaWxMcjM2eTVzSGdzdDd2amg1?=
 =?utf-8?B?VlFhb3lQTktDeVpJYm9wZDNoMmJ1T0pHQmhCWlZxVHhlSk9SbDhwbHBvRDBz?=
 =?utf-8?B?aVJVYjBheGtWMW5yS3E5VUZwVVFUaWhNZTVIYWcxRGticHJ2SzFBQ2RzWkhv?=
 =?utf-8?B?bFo3SFhjTjVMcUprM3dCc0VqQkpzcUdUZUdOZnBHRWNvM2J5R3hEUFoyQlRz?=
 =?utf-8?B?RDM4emR5MTgwMGg4ZUZFakl4RlN6THpvajYvVDhaTUZab3YwQmR1Q0h1RTF4?=
 =?utf-8?B?V0ppOWdvcnVUSVNyakdmNFdzbFdmenZxQkRtZmNGVmxTSUtRNmIyMHZEUGtp?=
 =?utf-8?B?a2Y0RmVkeTVmaEU0dk9QSmJESE56RUEzcktpY1hJcXl4RzBtcXRweDRSMERH?=
 =?utf-8?B?MzZSWS80VHoySHo0NnY1SVBpV3A5YWFXTGhQWGVxdEhnQkh4ZmsxU1hSaGZw?=
 =?utf-8?B?KzB4RHE4L3k3eGlEWHNsZitYTjBWbytabkhXRzhBbEE2TEppK204QitBSmEx?=
 =?utf-8?B?eGNhYUxiYjZ4NWJaSzFuaG5xajVORExhWEZzQit4SHE4MHQ0eERiN21sVCta?=
 =?utf-8?B?OE1VZDdPRElFVTU4dzdVV2l4K3IwUTloQVo1ZlN4Y0pWOTNodnBEaFpTTWJz?=
 =?utf-8?B?ZWxjK0pSdER6c0p4MlR5N2tOcXdadkQzR2JqV3hPOEVDbm9Ua0RVdXFjdlcy?=
 =?utf-8?B?cmpJc1prRlVtOUJEc3JKRW1ocUZoNjZGeUZuS2hZS2paUGdQbXRHd3EzM2RM?=
 =?utf-8?B?VkcvdDNOVU5IeDYwVGVadDMvK1hoQWNyTTVpckdIZFZKMGprdnBLTnBqaTh1?=
 =?utf-8?B?VmhrRVhkM3NSKzZVL3RhVFhUbURiWnRFZzB6OGY5d3VqSy9wblEzRUlnNm5p?=
 =?utf-8?B?SUduM3JQYkl0TzJlamZnOUtYUHdwcWlhd3B6cW8yYnR5N2JCRFBGbzBIL2NT?=
 =?utf-8?B?bmlNaFhsclRqUGtZaGg2SVRrcXN6dk5HcDg5NEVEUTRGWlU1MFNLRC9yZWgv?=
 =?utf-8?B?K1FvSzRKQWN3ZW8vb1RiOUsxZTJIS1ZlY3V0bXdpb0c3VzZ2V3BCQjUxaEE4?=
 =?utf-8?B?RmVEVkhmK0NqTEczd2NZazdEdCt3dng0bisrODJoTzF6dDVsRElPeDZqTS84?=
 =?utf-8?B?MTgvSWJGbHh2N0J2UWdWTXlCUURSZExNakh0QnM4YUszZllLZ2JEbmFmNUxU?=
 =?utf-8?Q?kaXae9ShexvrtAzu3Wr/MtpaD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B98E3927319FD449B3DC889362B29E4@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f31e70-ef44-4bd0-d01b-08dd3c4edb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 08:12:33.6219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTdT1lP6StUzLjLIGMvjeOEeA2HNRbl6r1JZwMYBvgt9HXerAlcBq9I/35zp84k9DEdmt/ftyF8x2z8YAi2kvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDAzOjI5ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
DQo+IFdoYXQncyBDaGFuZ2UtSWQgaGVyZT8gT3RoZXJzIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkFw
b2xvZ2llcywgSSBmb3Jnb3QgdG8gcmVtb3ZlIGl0LiBJdCdzIGZyb20gZ2Vycml0LCB0aGUgaW50
ZXJuYWwgY29kZQ0KcmV2aWV3IHRvb2wgd2UgdXNlLg0KSSdsbCByZXNlbmQgdjINCg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEhhbmdiaW4gTGl1IDxsaXVoYW5nYmluQGdtYWlsLmNvbT4NCg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3IQ0K

