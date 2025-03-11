Return-Path: <linux-kselftest+bounces-28783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC24A5D16A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BB03A808E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC7263F31;
	Tue, 11 Mar 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eelnSNsV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A61C6FFD;
	Tue, 11 Mar 2025 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727336; cv=fail; b=pbbUu5XMA5quCUSuSRwIwcSC0DCchvl91hWhX2EOHYb6c/Gjf5kdvr/LQ6mMEvHbvUFej9SndvLTx5wPOZkky7hoiyJtFfCH9ZBXUl6kjoNUhczQnXtYc/zs1uLbocFAxnx5F7IC37SDWNNbCC5ouRc/cHndT5X7e9iHCheDctg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727336; c=relaxed/simple;
	bh=45TPE7FbZSDn2ATFWnaKy5Lrv/FmyxfQ8rOrFt/gxmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKYRyMiqnV/a2AlEI2vzSEn7d73y5gig1M9WX0jNdmVo+MwcxlxHZwLdIrZkjGwbJDSEGMEbAXTgUbs4ll/GvOZNTTSWjmLRWv1Yx0dI7YtgMC6EKyc6/eC41mM00o/Tk+FdYtAHC1POcpceva2fICshc9T6T6XCbo1JmG4IPgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eelnSNsV; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfEICrQbgu1Ls6WSPoFTuVy6V9ypv83r/riSJqQ3/H8MmcGn2Wdf8MuysU4t2m3PkTYm4z5OCAlg0kpufTMM9QSNNHXkemehriig6M+mZAWzoNAGh8dKTmDOBuB7WGXC9WtuumSMj3uDZzV637O/ZVinigp5ePjmfm3TYvztOpXMHC9raTUvReAZpVx5fdL9GG9R5f6aL8yY132ZhRqijHrAzS0RHmghSlDxUEZmPxGLUIPxh2owUKOPyN3kViaa9xnJGTQq9N+BZj2XgBUkPBZZOv3C8RI0yTBftrNvvA7/3thhKA3TGuMDVXnHZLEzCmoEpIrEfzeULdXI1iJJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45TPE7FbZSDn2ATFWnaKy5Lrv/FmyxfQ8rOrFt/gxmA=;
 b=fIzl8htAJY7cU8xiBAEfx6FxWUf3zc6SgITD4rgx6RzIT0hxRX4htXc/0HongUJDL1I+LPkvylGTWg2NO3mapeBCKdgYE6LFTbAII1ad6BNnj1Bg+GPCfaTrtztmbuFJ1nxKeMET8iY1xBUKuQzicKl5WEE7iQSbwAE/SEeuuEedkjl3oBFBPlv6Do6bs8unjF1ylHM0jeBXayTZySruuPjbs0huv2r/EQE0GLsAOfSioQP+3Mf7JXbqtQypZmlD3jo1W2cvdN/4EJzoW3W/pMF+dCz5a/DeE+c/ZhED+H2Rx9yYR8bI1hhfPWthRC+PDrCBRP4kutar80sqyVMj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45TPE7FbZSDn2ATFWnaKy5Lrv/FmyxfQ8rOrFt/gxmA=;
 b=eelnSNsVYfSRNIOWXs5LB4EytVNsBiavHib2cc0/S3wUxySKiBHk6hYhi3IvHsOnJ3VngR0vB0SjoXzu+N//YJAc3cDuCVPQYD6kEfovsfP748RGqKcLffTozyd4L6CCplJD6LBqD2eLT3SFXCkbGvTHKjxkxNdRqpaCSiG6ilmpl8+DkCs403g6a9CfL6nu0vfSArejdjq7w01LHaJTSTYbGlxWeqptT+fHSo5+LiFBniR+d7LhhswBO+FNMas9pPFMJiswzLRLgTMLdtdvzFLDgLkI9yi5w5/tJlg985Vb4kltE07Bg9dBzkufCvfypdNo9Bm+xZqiGK+sCMOs+g==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 21:08:49 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 21:08:49 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "razor@blackwall.org"
	<razor@blackwall.org>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "jarod@redhat.com"
	<jarod@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Jianbo
 Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Thread-Topic: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
Thread-Index: AQHbjw+8kWzklmtO0UewieqlDDmQObNnSuyAgACcqgCABo3aAA==
Date: Tue, 11 Mar 2025 21:08:49 +0000
Message-ID: <f9b85a06113e2c9a7a91f3486efc06edbce4e461.camel@nvidia.com>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
	 <20250307031903.223973-2-liuhangbin@gmail.com>
	 <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
	 <20250307090332.5b556ebb@kernel.org>
In-Reply-To: <20250307090332.5b556ebb@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MW6PR12MB8661:EE_
x-ms-office365-filtering-correlation-id: 490775fc-9108-46e9-08f0-08dd60e0eb5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1JnMk1wSWEzNndGU3c1b1ZLSCtoclpWbzkzbnpQNEVBZlhHMEVERDRlemh6?=
 =?utf-8?B?RDUwTVo3aXYzcVhDYUIvc3d5NlFDYjl0K0hCY29pRnllRWJCNG5jYk13eFpK?=
 =?utf-8?B?NktVQytoZXpBaW1XT01uMXAyVGx3QTFTVWhaTG1wWTUwN1ZCZGtCMzlKSnp3?=
 =?utf-8?B?eUU0ZElXbGNodkdjN0NpRThHcGdMMGtWbnZIeDdSUTFER3J1SnNkbHErd2VU?=
 =?utf-8?B?b1I2UHlhMkh3djlkY3NaUmlhRDNSNGdLd0pzOTFtRkhHUHA4NEo0aTY2aU9j?=
 =?utf-8?B?RndGbUs4UEk3UlRBVjZnODNVVnkzQXhZY3BnTFRzd29kdmlseFd5VTlrVndT?=
 =?utf-8?B?dTNQbkZRVDl2ZmZrV2t4WXRnbDBYTUZ1bzZ6SkJHMUpEVlc1OXJtRkk1RmRk?=
 =?utf-8?B?Ly9MRTM5NWVMWDVBcUp1elRUTHhOTUhkVlR5TzkrT0E3SzcwNi8xc3J3bUZ2?=
 =?utf-8?B?MGE3TlhZaW1WT01mWWhSZkpsYmdXampTWVZnVzAycWorVGtITlVER1ZWWVBF?=
 =?utf-8?B?ZUxtRHFYNEdDWFlSQThjTzJKKzJPekZFUkxrSGozNzI1dkZGWjVNWkgrc09s?=
 =?utf-8?B?d3VicXFseTZheDlIMi9NUEZnOGJVSEVvTm95cFFRcE8xKzRNTjFqRHF5TlRq?=
 =?utf-8?B?VkhMVllvU2NXWmVsUXNETkZ3TmZVSkJ2UDlPOEVvYS9Pb0tOWnUwNDM1OFE0?=
 =?utf-8?B?dlg1RXhXYkxhQlBZWUQ3L1Mvc1BEOGtJMWtGczZPSTlIdjl5N3BBWjRtOU1y?=
 =?utf-8?B?b2s0b2NQd1dVQkZHdTNCWjExS3ZjVGV3MUk2L0FTaE1ML094MVcrVm9oRTRj?=
 =?utf-8?B?ZFNPRyt6ZGk3NmhNdy94N05KREFXR1ExQVZlY3FEdTFIN0NyVU8rWFFidytQ?=
 =?utf-8?B?d1VBeEVldFhIUVNTUXRhZndrajMxRWlFR0ZUTVFGR2ZNUU12VFdGVzRSQTNR?=
 =?utf-8?B?UVgzU1ZBZXpxeGNoZy9sVThFd1JDbFcyczRIRjRoajY0OUVEbEZzNU0zaXU2?=
 =?utf-8?B?WFJoaTlpSWM4akwzWGVOMHdTKzgrdDlUYXRoYmNGQnQzQmxmbkloYWJDUW00?=
 =?utf-8?B?VzMwekg0OEIvR3MyK2VIbU1WR2VNaUszQXNBcldTV1k5Z2JVWWh3a3YxWklp?=
 =?utf-8?B?aE9FZWhMSjE3VFB0a3lGTkJVTHl0VUVvbnVORUdLcmF1dG51WWhGS2J0Z01F?=
 =?utf-8?B?OWRMZTJaSjA4T0FSYjQ4dXhoY2ZyMHN5UlVGbEYwRFlsWFk5bnM4S1dtV3BC?=
 =?utf-8?B?ZHhrTmxieFdBY0xLQUpHMkhlekJlM2dnWkxnb1RwZEtsdit3Rm8xVzZlVFZl?=
 =?utf-8?B?M1diUHBnWGpWVkVtanVJOERFdTQ1VkdUVDZxbWx3WTV0eUJDdjFuWjNvbzl6?=
 =?utf-8?B?RjR2YnRGMlBzTzE5N2lua3dsYkIwUzBtc2lISmI2VjVpVTMwR0JTdEt1cXNT?=
 =?utf-8?B?OC9PSUg2dG10c0x5TjJDamMyb2dFMDN5QW1mWmxjSlhiQUNteTVRclQyaGcy?=
 =?utf-8?B?Z09HUGNaNjVlZy9iUDZaaEtGYXpVTnBNN3Fkek5GVUlzSEpNZkFZV0s5b1gx?=
 =?utf-8?B?TkozWXIxYTNxRDdZa1h3ZS9scFY5aFdHZnFIVjFCRlUzb2F3ZnhPaDAxRkxp?=
 =?utf-8?B?U3dFOGVqc21ZZkFPYkgyRmxFQTk2VGFpZldCa0hsaXYvdHBwd2t1Q2NFb3JJ?=
 =?utf-8?B?eENPeTVEaVlGaGtWcFRjdHBUbktwZFhoQjdxd1ZES25xYkExZ0dObXYybnpP?=
 =?utf-8?B?UW1IMFVqL2wzV29Ub3lZVmZkZTFHZXZUWlFnL2xWNDZTcW0zU3NZUE1IZ2hr?=
 =?utf-8?B?bndaQVdlT0VaUGNhY2RPcXlmdmtDY0o0OE9IZnlUUjF1ekx4d0wraC9HTFp6?=
 =?utf-8?B?WS9wMVkwY3pzbU9xaWpiV1hRVGxwNEd6Vm4vRjVNdlJLTXduUE1rUmU0cWgy?=
 =?utf-8?Q?ptBVNWkhI1mN7RY9/s1KqpsMmZ/eZYmI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNwUjB5TUhVWktNem91dlJ1c24ySks1NWxQb1IvaTMvbUk2eXhmMDd1Y29o?=
 =?utf-8?B?dkNZY0l1NVpvNjE0MHRwbE9URTJVUWFNWmV5TkZSaFdCVnJCTEVRbXFuQlk0?=
 =?utf-8?B?U2JYeXJmU0lwSDdwS0NUZ25zWktlcjl4RXFSYlV3Sk5tQTJkb3BMWGhicjlK?=
 =?utf-8?B?SXV6MG5KN3VFRkFVbnk5cTV6OFpzVlhmb0lXV2F5RjN5TDNveGJ1RUJQemUw?=
 =?utf-8?B?bmVxeEswRy9pYW5HdFluNTRPNkFjb200VlNKMlRXQzZTVXBoOHRhbEN0L3U1?=
 =?utf-8?B?SW9hM09vcjZ3dURYaDNPay9ZNTlnRitVMXBMRW9QRjlYY0tlc3Y5R2UvZGkz?=
 =?utf-8?B?bXRzTThLd1dQUlYzYVpuTnpRTktkQzdpOW4wZ2pqdk1sb3JzTit6cXB1ekFJ?=
 =?utf-8?B?SmtlenA5MnpRdkdVV3JHNXBvdGVha1FNRm9VdWtOWldPVVJiSnpMOW5qa0Zv?=
 =?utf-8?B?eXYxVUdEK3RqT1hLejNJMmVWakhxTnd2TWlVeTZXci95NlhsRzV5djJOd0dR?=
 =?utf-8?B?UkI0ZHpOQ2ZTVlhxVTUvVXFsVnIzR0U1cU9YWWlUcmVlN0hNL2F1ODBWYnF4?=
 =?utf-8?B?SmV3OXlXL3E0Mkg4U0lDSHI3eTBJSnA4a1BmazJ5SHJCSlhvQ3QvTk8wR1Rt?=
 =?utf-8?B?dXlKZ2oxZjdqbENlY2R5K0czZVlNM1VjSlFydk1rRTdOcWlsRjI1azlac3Rw?=
 =?utf-8?B?Z0Q1cWxmTjVMMkoxSlBYY2h1TTB5ZGlIWTVJalp2aWZjQ1Q3aXcwK0hFNm9F?=
 =?utf-8?B?UXNWUUI3SSt6elRKQW5NNWRhWkJ4T2daQnB5bStSbkRoWGFVcHhrZS9tVlFK?=
 =?utf-8?B?bXJDTmlZUDVucElDb1phOXBRd1RlMDAyWXk3c2gzUUc5dXR4a0lPN01JcWh3?=
 =?utf-8?B?a0ZScDc1ZjJSTm84QTJuMjdVSGhmL0l6Rjc4VmYvY2QxRmgyOTY2a1M0OFFx?=
 =?utf-8?B?clljekRoZS9pd0wwaGc3TE1IVzByQ25VbUw1cUZVWXQvVWtqYkJwaTcrYTdj?=
 =?utf-8?B?QzljQVEwbzdGc0g2T25jSzdVcnJnY0JtTTJKTHhlVDNyODcvdER2ajQ2TnVm?=
 =?utf-8?B?UExJQWVKQXNreFNKKzVIc2hWL3ZpeG9QcWFRcjdqOE5QbGV3OGFkVmljdkpV?=
 =?utf-8?B?TncvWVFpSVozQlNyRE5sWG9HelZxYVc0b3lEaHZXbGMxNlBzMGd0Ylo5b05Q?=
 =?utf-8?B?aE9IYVNpVTkrQysza0VEbDNzNkdVMytiZG1RZFFvUkt6T1FWS0FJd05tZ05Z?=
 =?utf-8?B?eTcyQUdiOGpZdFNnamtWMURYZVI5aUJVaWVEcGhTSkZ5bVRMaXpFT3llYy8w?=
 =?utf-8?B?STRDOVlXMmY1U3UrSE9Eai9qdFE4VGVCM2lXeGdQckwzQ01LVzN6S2t5Ymhv?=
 =?utf-8?B?RjlZWEw3M0xoY3dWZHdqblpNOVVpT2t3OEtPeGlvUXFpcEVRV0EwMEpIVHRp?=
 =?utf-8?B?dXprZlVsQUV4emhUMGJ5MjlBNWUyUDJVVEFrTnV4SFM4MHJPTzk5T2lMYUVB?=
 =?utf-8?B?OHphVmQxc1BTbnRoeWRZRkg1VWR0aDFzUmw1b1d3cEtteTdzWm1yS3hjeWp5?=
 =?utf-8?B?SW9MUnMyREZINmhwRFFmL0RtZW1yZXVNWXprb3BPaFNESlpubUs5RU9UdXlq?=
 =?utf-8?B?VWQwSWZKdXRkVmdHaGJvdGRBcFY2ckFBaEs2dzF0ekNEQUFUQXNxV0kzeUw0?=
 =?utf-8?B?d2djUTB3OE5Fd0FPaTl4TFRpbGdYa0oyUEZYMkxSbGVPU2M4LzZsclNSR3Zx?=
 =?utf-8?B?ZUpzQmZhcHdrZXRlSDRMWm9lU2Z4eVEvbmdobG5UYTR2dnJlRklnelEydTAy?=
 =?utf-8?B?S0ZXTlk5NFhJVklPQTlTb1h2N1QyRTFDWVRYTkVCSnptVkFTRXc5Nk5hbGF1?=
 =?utf-8?B?eFNsOVZxRlpuZUN6bmtrb3F4VlhtTWlZK2VGU1lwQ21MVUtqWXRLcE1URXRq?=
 =?utf-8?B?Tkg4andSRDM0WUFycWkySVdSbk5mSzBvSkVVOGc2SWRFa3A0YkMvaXVwZ05J?=
 =?utf-8?B?cHNvUWdDWVRoRjU4cnZKUjlQblVqWklJNFpzN1ZJKzUrSXFNeVJCdXRRNHlL?=
 =?utf-8?B?NGIrdEhZUDM5ckhuM3ZDWndORy9wTHluZnE1R0xjQjBjRXBFSGpvMWwyZng4?=
 =?utf-8?Q?+qBXJoO9zQU5100bmblU+2Tj/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24151BC78313A9469E0D00223F13FE52@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 490775fc-9108-46e9-08f0-08dd60e0eb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 21:08:49.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGMfZdCtQKcjQ4Xv7OXGlRGmUw9eqH3mqZNezR+CdIu1g943NS0OWHd4t9XhEVJgQWkLrvTclmBK4KuXI4Lcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDA5OjAzIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCA3IE1hciAyMDI1IDA5OjQyOjQ5ICswMjAwIE5pa29sYXkgQWxla3NhbmRyb3Yg
d3JvdGU6DQo+ID4gVEJILCBrZWVwaW5nIGJ1Z2d5IGNvZGUgd2l0aCBhIGNvbW1lbnQgZG9lc24n
dCBzb3VuZCBnb29kIHRvIG1lLg0KPiA+IEknZCByYXRoZXIgcmVtb3ZlIHRoaXMNCj4gPiBzdXBw
b3J0IHRoYW4gdGVsbCBwZW9wbGUgImdvb2QgbHVjaywgaXQgbWlnaHQgY3Jhc2giLiBJdCdzIGJl
dHRlcg0KPiA+IHRvIGJlIHNhZmUgdW50aWwgYQ0KPiA+IGNvcnJlY3QgZGVzaWduIGlzIGluIHBs
YWNlIHdoaWNoIHRha2VzIGNhcmUgb2YgdGhlc2UgaXNzdWVzLg0KPiANCj4gVGhhdCdzIG15IGZl
ZWxpbmcgdG9vLCBGV0lXLiBJIHRoaW5rIHdlIGtuZXcgYWJvdXQgdGhpcyBpc3N1ZQ0KPiBmb3Ig
YSB3aGlsZSBub3csIHRoZSBsb25nZXIgd2Ugd2FpdCB0aGUgbW9yZSB1c2VycyB3ZSBtYXkgZGlz
cnVwdA0KPiB3aXRoIHRoZSByZXZlcnQuDQoNClRoZXNlIGFyZSBwcmVleGlzdGluZyByYWNlcyBi
ZXR3ZWVuIHRoZSBib25kIGxpbmsgZmFpbG92ZXIgYW5kIHRoZSB1c2VyDQpyZW1vdmluZyB0aGUg
eGZybSBzdGF0ZXMuIFVubGVzcyB0aGUgdXNlciB3YW50cyB0byBpbnRlbnRpb25hbGx5DQp0cmln
Z2VyIHRoZXNlIGJ1Z3MsIGNoYW5jZXMgYXJlIG5vYm9keSBoYXMgZXZlciBlbmNvdW50ZXJlZCB0
aGVtIGluIHRoZQ0Kd2lsZCBpbiBub3JtYWwgb3BlcmF0aW9uLiBJbiBzdGVhZHkgc3RhdGUsIGJv
bmQgbGluayBmYWlsb3ZlciB3b3JrcywNCmFuZCBhZGRpbmcvcmVtb3Zpbmcgc3RhdGVzIHdvcmtz
LiBJdCdzIHRoZSBjb21iaW5hdGlvbiBvZiB0aGUgdHdvDQpjb250cm9sIHBsYW5lIGV2ZW50cyB0
aGF0IG1heSBoYXZlIGEgY2hhbmNlIHRvIGRvdWJsZSBmcmVlIG9yIGxlYWsNCnN0YXRlcy4NCg0K
SSB3b3VsZCBub3QgcHVsbCBldmVyeXRoaW5nIG91dCBqdXN0IHlldC4NCg0KVG9kYXksIEkgbWFu
YWdlZCB0byBmaW5kIGEgc29sdXRpb24gZm9yIHRoZXNlIHJhY2VzIChJIHRoaW5rKSwgYmFzZWQg
b24NCmEgcGF0Y2ggc2VyaWVzIEkgYW0gcHJlcGFyaW5nIGFnYWluc3QgaXBzZWMtbmV4dCB3aXRo
IG90aGVyIGNoYW5nZXMNCnJlbGF0ZWQgdG8gcmVhbF9kZXYuDQoNCkhhbmdiaW4sIGRvIHlvdSBt
aW5kIGlmIEkgdGFrZSBvdmVyIGZpeGluZyB0aGUgbG9ja2luZyBpc3N1ZSBhcyBwYXJ0IG9mDQpt
eSBzZXJpZXM/IEkgcGxhbiB0byBzZW5kIGl0IHVwc3RyZWFtIHRoZSBmb2xsb3dpbmcgZGF5cy4N
Cg0KQ29zbWluLg0K

