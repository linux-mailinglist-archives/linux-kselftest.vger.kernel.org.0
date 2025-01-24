Return-Path: <linux-kselftest+bounces-25083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE6A1B393
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FEC3ACCCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63B1CBEAA;
	Fri, 24 Jan 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1udFkRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C401C4A26;
	Fri, 24 Jan 2025 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714946; cv=fail; b=U87WAGjO4ztwLuYvJ7hXovO39Ov2DWgX0KsiM+e7moDt3ixbwU0Yx7T3GlKu4F9wuymqG9OJZGZC68P8uVdseVq6jWR6nwXnJRQUgMgwiDkNSKAnJVMvWAncHhPop/gHiOOsVsvWYDxJkJ+as1dmEXNnJXu1EhM5uGW/nk8+fOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714946; c=relaxed/simple;
	bh=2wsRMsMVcM74hrwrsLh4QINhbPMpeNOWjyQXWojOjfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i24f9vi1krdej8LRieSY64/xtW1nGeDzRvL5Ts6gfB7Caa9/fnjxu9+k17K+P7R1kxtr2d/R+AdtVAIW+9UkdPYDlDy+M8+VVAya6LbMrqry3IYt17kP1ujAfoHRNhQUlGzWKdw7ujFknmIFLWa2ptbWfcTXk2D4njC5+XlLy4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1udFkRF; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9vAq3CYb4cAoi82IDFl5HKE7vpttFCAAusmRhDxqQezaCZCG803vQd8bO89PHLiVdT2TBI1aETdejfa0CcfzWPUfVMYwc1kChi9+mgOkYeSiFIr6GVRCJZoMAvtfSAf38kFdMfaMWhPPCNBydNCrTpRlO/20pF/HZbQVKiY+7R8AWG1dJewG4hPYs6IULk6TVBJVu4wuWHNKCnpjg+kSBS1GvtQt204vYYyoL29nvahZDV8bbFDPK9+NrtELT5qiMs6RSLTvQjBCgnFO+4vai06ZVh6AgW6WdQ6kkDPpa3ufz1VnQOFK3o1zyoacLZ0eAW8lMmB9tB9Ci6JZ5ycag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wsRMsMVcM74hrwrsLh4QINhbPMpeNOWjyQXWojOjfk=;
 b=TgbjP3V7hmv+k2qgwsm0mQQBsjH2i2WVzw6FFZFnb2BT3nqIEwWEEJ/vNkoATF3t/GW0oGh2I97rHmsbxiCblaLP665FEHtWnPY1D+IWVtEtdhM3ZgnIBFpGufN1ws0kiJWbuxtc+MHNL436VKSTiL5PiVwyMxSDo1Tomgn0yp+k7um7llsJgVZ23G3hnUJL3h78t0YLmazOdH2OJjKfZleHA/zxnVUNUK1Pbkjk5Mp4JNiBbmOd64F1KQ/gimxMRif7b/PF12FAyUxJpA5OPiO4WRHBK+ZvRTGE8V3kBd0XQ7jmp7shmoZevGVUC8ZSmmN5pnBTOIZxq64/7cMRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wsRMsMVcM74hrwrsLh4QINhbPMpeNOWjyQXWojOjfk=;
 b=I1udFkRFGD5NeN4v7L4kBTd0ylvQe5UW1i4fDhNhOe09hAGx0zhSIcNMv1P0T7HRVk5BA5/L0Bv+Qz93Daj+c7vzVavZxM9PZY68aayI+l55W+rn83FlrYLMlp/99GZ2Ja3/k0ro2YHLv3wfge2W1jNlsbV3NsXOYfbhWxMCjUzjMo24/ZQCNLXxwbo0WrRfjhNNflmDidKeXFvbZBTMy4S/zlSwqIcIAwysA6RnOVK/toQSSAaUrTNyFSA7jhnXHjC1WUD56iv4OWqTWjsTUYai2EZa+ecLm6Fvve28aH4YjE8WiHbL+v70IqDSRH+wByGmNqFZwtdaUJzguC4m5Q==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 10:35:41 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 10:35:40 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "razor@blackwall.org" <razor@blackwall.org>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"liali@redhat.com" <liali@redhat.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Boris Pismenny <borisp@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net v2] bonding: Correctly support GSO ESP offload
Thread-Topic: [PATCH net v2] bonding: Correctly support GSO ESP offload
Thread-Index: AQHbbj4fE6Mv4OyE0EysvZIi5LIoH7Mlr4uAgAALYoA=
Date: Fri, 24 Jan 2025 10:35:40 +0000
Message-ID: <2c92e0c58e7d0ab4b06c16f9f1f67f6f9e48d35b.camel@nvidia.com>
References: <20250124085744.434869-1-cratiu@nvidia.com>
	 <Z5Njbd8-ieEcbAEV@fedora>
In-Reply-To: <Z5Njbd8-ieEcbAEV@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN2PR12MB4376:EE_
x-ms-office365-filtering-correlation-id: e55f2b32-9d28-414e-fae8-08dd3c62d905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bThRV1FhK0tzd3hDYjBqcm1MbUtKbzBhMWRmNGMzUmNWU09NeVorQTlNZVRG?=
 =?utf-8?B?QWs2SGs5cGZ6V2xVd1dHTEowQVB6eGNzb2lDS3RiNXo3ZkdIWlFqem43L3c3?=
 =?utf-8?B?Zi9tUkRFUVl1NXg1WGJQeHM5L21aaGxROUlQTmYyTFhmUHhRc2l0VmNBdGhu?=
 =?utf-8?B?dm9tZ0VnYVVJSWNJR0ZxMGFUa0wwUVlCbUsyU0ZyL3NUQVk0bXA2YTZ0VzB2?=
 =?utf-8?B?eE1hMWUzVEVjeXlVaURxenBNM1lpN2VvRzNNMDdWTGlPTlZwOHZUM0UwMU52?=
 =?utf-8?B?MlV0cmc4TmtHTnhSUHo1ejVuV25YR09zYWdoaWtTTCtCNnBPVWYyalg3ZVBU?=
 =?utf-8?B?bVJySlRUT0lrL0xWMXJsKzZqbTF5S1MrR1hidG9NMU9NNUVGcnlZU0RYTUcy?=
 =?utf-8?B?QU4vZk04amRybnhBcW1Ma1piOFFkWVI2UnIvTHRnUERmeTdiSnpQVkFDaCs1?=
 =?utf-8?B?aU9VcldlVGlsUkhSRjBwTlJtaExFRTg3SWJKdW5Vako4eWQyQnd6RVRNdExz?=
 =?utf-8?B?QWN6bm5qdmEvT2VWZVQ4SWxraEtNcjhFS3E4Tno3bzh4Q2liQ3ExUVlYeGda?=
 =?utf-8?B?RHhJN1FtU0pjY1kxb01KOUt2dzdIaUpoL1pldGF0ZjdUK2Z4SmNmT2JkR0Zn?=
 =?utf-8?B?dnZxMXhvRUxTalNKZTlkR0VFY2xZdGx1eS9PaU5UdlJLK3E0Zkpta2pCbng5?=
 =?utf-8?B?b2tseFg3a3lRZTYxSzdGNWdoSGFpVUt3b0tUYjd4T2FYOS9CdlByMkhoR1U2?=
 =?utf-8?B?QWFTcUN6amxXa3kzaTNvRHE2cXFvYmN3S0VHR0E5QnZyMjhLOVl6Vy93SDVE?=
 =?utf-8?B?QldDTUcwSlFPWXdtTEs1aGMzSytVd3FQVDJqY01GWkttTkNEa2ptQlc5RjZx?=
 =?utf-8?B?Y1plMm1xTkJreGkrdUk4UHh3NHFUb3E5bUNWZzc1VDBkOG1ndWNaZ012VHVa?=
 =?utf-8?B?cXBwaVA1d0Y1M0QzZkxiMnNRNmQvQkQxcFo3TVNzRyt4cmliQW1NRnlmY3hR?=
 =?utf-8?B?WEJDaVJuR2x1MmFQeVNweTd2cWtZS3VCTjgyOU9QQnhqVXByTncyK1g5VVpv?=
 =?utf-8?B?ZWhEWUJrQVhGOEtEZHhob3YwM2tmdlVHQ1hoQkQ4aFdjc0liaG10aC90U3JY?=
 =?utf-8?B?d1ZEUzRQMzI1UmZXc3ZodS9IRFMwMmZla28wQTZSakRPNDVKVkJBS2Qra0xU?=
 =?utf-8?B?MnJxL0hOUUxQRDlLbmpHNS9vNmJSV3NqTU1sRkQzb0JpMFd0ZEo4bzdzME9U?=
 =?utf-8?B?bGJldThQaDMwdCtyUDNxU050K0FYZTdKOExnVHVDcTB1R3ZxV3pnNlkrZnpC?=
 =?utf-8?B?SkpNNTJlR1BySS9uUlVhUUVsRE1qNzRpVDd4RExuVVRWekNBNlQ2d1I2cnpa?=
 =?utf-8?B?d2MvV0NaamI4aUFnblhsQTMzZkJFdmRydGYzc3NtYnFSWFBUR1hWSVp4TWlm?=
 =?utf-8?B?ejN0RVduR0xYR2Vld2hPY3lucEVac0hFVHY2YWlLRWlNYUNDU3Q5c0s0YlV5?=
 =?utf-8?B?RFFOSDRvWExmd0JiR2ptWEswVmNGZWJtRVQ0Y2dUOVNtc3VMWDQyUGRIMUJn?=
 =?utf-8?B?a2dybU5vMWJKajU3cWRXaFNCZWk3S3c4RTNFUHF6Z0xmdE44TDkvZE52NS9W?=
 =?utf-8?B?L0paTEJMMmFoOTk1UkdMa2Q5K2twYkVRcXN3anhNbHZySysvOUFYYWh2SGJL?=
 =?utf-8?B?eEdDSTF3RVVxYjdXZTYvTHB6TWFiL0lRUzdyZjBiY2RHa2hQUEhXRDR6bUx0?=
 =?utf-8?B?SnRZTHU3TElzcHJ1R1c0YVBCakxacEYybTlKSkJwMTRXdWg1Nk4rQURwTDhU?=
 =?utf-8?B?am92M3pjcjFYWE04OFhnVDlGL2NYWnZHNExNaDdBcldIc2hNWEQ4STB0Vjdt?=
 =?utf-8?B?Z3Y1alhqc1NjRnVjV2FDOUljSXlVbDF0YVJ4QTlyc0x5Mi9kaHBGaGhqeWFj?=
 =?utf-8?Q?OsQlCROYlGcEYsKc7a8Mc5Q+mxsMFO6H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDJhcUV5Z2VuZWVVdzJ5NlBFRUd1em1QejdaTFd1ZW5naEhKMFROMkUyejFQ?=
 =?utf-8?B?VjF3dUNIWGNLeHI0R0J3ek1tVmJRaEM5cjlobXd3alpuVDB6emV0cUp0V0Ra?=
 =?utf-8?B?M2QyaTd0R0FPZVJCRURITDJ4UUY3VTRLWEliWkZmbEh3TTFycjZmRlI0NFBo?=
 =?utf-8?B?UzRtS085VGNFN09WMXcvUEZGNERJSTVGRjRvMTJsdjROeEVjWFhTZXdNNlhH?=
 =?utf-8?B?SjdlQ1pXUWtqM0Zmb0Y5bFg2T0I3SWdJQWZxRjRGaG1QbEhvcWo1L2d3NEpl?=
 =?utf-8?B?bGtUQnBZS3dCM1JaMk9YUGl3bGxyZG9RTnlkalJCZENOalFONjBmVEtaT3Vr?=
 =?utf-8?B?TDBqRkljdUluRFNKdjgvcVdhRDFEVXNmUXZGUUhYdWtWR2tlb3JYN3NnM0xp?=
 =?utf-8?B?WkducndRdDNzV0lNMnZmOGxyNVNkVHZEYjl1S2tQOTdaSWZsQUZxeHhOeWIw?=
 =?utf-8?B?dzk5NlNtT0w3Q2h6Q0xqL3piNXRkT01scHVFWmNkMDhMZi9BdDc3UnZPajQ3?=
 =?utf-8?B?MG9BWEpZUmpGdTNIM1l2UFR2WWZYMjZtSGhmVjFDM3M1YU9LSld6ZlJ4OXcv?=
 =?utf-8?B?RE94aDhKMHNoMHNCaHdFYUZYQjBzUFdycjhyT0txb0NURnRSMDRYUG14bWU1?=
 =?utf-8?B?emNsbTNMakZMYUU1YTlJcFMzQmFOYlJwM1BzdVFhMDJMM0RGeW9jYW1Nd1Iy?=
 =?utf-8?B?RHVMV0NzV0JPZ2RKODlORG5XejlBWXBhL3VNcUdNUldKNUVwRDFpekw1aVJr?=
 =?utf-8?B?dndDRHBWdzFYOE1XZHo5S0F6bjJnN2IxZDNtaEkvZklIMzhHTzJUbkZKRjJn?=
 =?utf-8?B?NXQrcGtHMzI2UGZ1dU1IRGdLcXdOVUxFaUJJREJLRENNN3E1SmpRVnlWWThy?=
 =?utf-8?B?a0pkUlQ5ZHJPRjc2d0ZUL3FOMnZuV0VYaUgzRHpDamVzMWd3c0dFOGMyL1Rp?=
 =?utf-8?B?L25zMGh4MDZaR1h5OWJmTXV1S29ZaHl5VDYwRDNua3dUQzVyNHl1ZW1yblRB?=
 =?utf-8?B?d05Qdjd2Rjl2bWhDN2RsK2VYelFHUE5jZlYrT1pHTHFWK1RHNFFodHdMVGFK?=
 =?utf-8?B?OUlPazFKUDFOY2JDTFVKWDV6L3pOdnI3eU9raFpJdWtRcitIM05KMXZSUU5n?=
 =?utf-8?B?bzMvUW1xeWRsUWF4WDRQQkFxdmhjTDdjMXYxV1ZiTWxhaU95VlNwdCtiVlBj?=
 =?utf-8?B?SG4rQWt2Rmg5RFBsUU9NL2ZGU2JYU1prZXZDaHpSVEhhMTdXZld2TkhTVy9F?=
 =?utf-8?B?djVYRXg0UW5ZU3pUR3JXZEkxdzZEOC9tUDhEV3FNcTR0RkhYSGtiK3h2czhG?=
 =?utf-8?B?Z3ZSb3ptTGhQZGFaR3V5OGdrd3cyK0xWN28vWmVDdUptWWJRK3FTcXlOQ3Jq?=
 =?utf-8?B?Z3Ayc2FyRFFVR2wvVC9EZ0phYXpDK1NiTUg0WXlrb2cvRHM1K05NZlZweklB?=
 =?utf-8?B?U3hUUlE5V3JGeE5vOHpQbGNtcDhaYUNSRG5sY3ZVMTVmMTBHUXRMbnYrM0Fv?=
 =?utf-8?B?TDhEbXFOeXlpT3AyVXdLcVJOWXJZMHVRV2dzVHJLRGRNWDdVeTFxYzVVOGFp?=
 =?utf-8?B?SEIzUEMza0tVZnl2ckVJNG5TbUlEeUZGdVlKSW9Edkh0YzdweTVxVFBFM2tn?=
 =?utf-8?B?N0RxWWZ1ZEhjcU83VEt1dERsMzFqRklaeU9ET2xIeFUyWWF6TTR4V3RGbjAz?=
 =?utf-8?B?OFZsK05hODgrdW12WHAvanYwUkdvNDBEYjYwNVF6UlhQZmZzZ0s0M0haaXc4?=
 =?utf-8?B?UThKUHZqUElZczlaNTJzUi9YcHdyenZpYmR6eGtPVG5vYmh1N011d2I5MzR1?=
 =?utf-8?B?cUhnN2dTSVpmQjEwZCt4N0xVdmhZakJVb2N1SFdXN2hUa2JJWmUwR0x1NGRt?=
 =?utf-8?B?NGpPbm5PeGV0QXgwWDJBb2gwczhNV1gyZWF5cE8xYW5wWHZCR3dxbTExZVRw?=
 =?utf-8?B?djU3ZkQxZDE3Q3dvemN6eDNwY2w5aHBobGJ3bm9MZnI4L0NDVzhLL01OOEJX?=
 =?utf-8?B?OWcyN2VndDEzdi9LUk9OTFVjakxveVIxeFZqYTFRdlY5bkNLZkhmdW4ybFNM?=
 =?utf-8?B?T3FUUEYraDV1MG9kZjNxd09RRHV2bk5rMFBQNUpISzNqRmFneUdzTUpoNGtp?=
 =?utf-8?Q?gt5WjtvAciWoo5sz94m3pWiRX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC23700FACB43643B9B5FBC3616FF747@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e55f2b32-9d28-414e-fae8-08dd3c62d905
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 10:35:40.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdWNkJkQv3tYWeXCdoolIm3thRAkT0W34vF6ZhQlokQFU6VIepVn01G5IfIcC5ZpTbzwsLGpTjUxuWae6x1avA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA5OjU0ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgMTA6NTc6NDRBTSArMDIwMCwgQ29zbWluIFJhdGl1IHdy
b3RlOg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYyB8IDE5
ICsrKysrKysrKystLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9i
b25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5j
DQo+ID4gaW5kZXggN2I3OGMyYmFkYTgxLi5lNDViYmEyNDBjYmMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMNCj4gPiBAQCAtMTUzOCwxNyArMTUzOCwyMCBAQCBzdGF0aWMgbmV0
ZGV2X2ZlYXR1cmVzX3QNCj4gPiBib25kX2ZpeF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LA0KPiA+IMKgCQkJCSBORVRJRl9GX0hJR0hETUEgfCBORVRJRl9GX0xSTykNCj4gPiDCoA0K
PiA+IMKgI2RlZmluZSBCT05EX0VOQ19GRUFUVVJFUwkoTkVUSUZfRl9IV19DU1VNIHwgTkVUSUZf
Rl9TRyB8IFwNCj4gPiAtCQkJCSBORVRJRl9GX1JYQ1NVTSB8DQo+ID4gTkVUSUZfRl9HU09fU09G
VFdBUkUpDQo+ID4gKwkJCQkgTkVUSUZfRl9SWENTVU0gfA0KPiA+IE5FVElGX0ZfR1NPX1NPRlRX
QVJFIHwgXA0KPiA+ICsJCQkJIE5FVElGX0ZfR1NPX1BBUlRJQUwpDQo+ID4gwqANCj4gPiDCoCNk
ZWZpbmUgQk9ORF9NUExTX0ZFQVRVUkVTCShORVRJRl9GX0hXX0NTVU0gfCBORVRJRl9GX1NHIHwg
XA0KPiA+IMKgCQkJCSBORVRJRl9GX0dTT19TT0ZUV0FSRSkNCj4gPiDCoA0KPiA+ICsjZGVmaW5l
IEJPTkRfR1NPX1BBUlRJQUxfRkVBVFVSRVMgKE5FVElGX0ZfR1NPX0VTUCkNCj4gPiArDQo+ID4g
wqANCj4gPiDCoHN0YXRpYyB2b2lkIGJvbmRfY29tcHV0ZV9mZWF0dXJlcyhzdHJ1Y3QgYm9uZGlu
ZyAqYm9uZCkNCj4gPiDCoHsNCj4gPiArCW5ldGRldl9mZWF0dXJlc190IGdzb19wYXJ0aWFsX2Zl
YXR1cmVzID0NCj4gPiBCT05EX0dTT19QQVJUSUFMX0ZFQVRVUkVTOw0KPiA+IMKgCXVuc2lnbmVk
IGludCBkc3RfcmVsZWFzZV9mbGFnID0gSUZGX1hNSVRfRFNUX1JFTEVBU0UgfA0KPiA+IMKgCQkJ
CQlJRkZfWE1JVF9EU1RfUkVMRUFTRV9QRVJNOw0KPiA+IC0JbmV0ZGV2X2ZlYXR1cmVzX3QgZ3Nv
X3BhcnRpYWxfZmVhdHVyZXMgPSBORVRJRl9GX0dTT19FU1A7DQo+ID4gwqAJbmV0ZGV2X2ZlYXR1
cmVzX3Qgdmxhbl9mZWF0dXJlcyA9IEJPTkRfVkxBTl9GRUFUVVJFUzsNCj4gPiDCoAluZXRkZXZf
ZmVhdHVyZXNfdCBlbmNfZmVhdHVyZXPCoCA9IEJPTkRfRU5DX0ZFQVRVUkVTOw0KPiA+IMKgI2lm
ZGVmIENPTkZJR19YRlJNX09GRkxPQUQNCj4gPiBAQCAtMTU4Miw4ICsxNTg1LDkgQEAgc3RhdGlj
IHZvaWQgYm9uZF9jb21wdXRlX2ZlYXR1cmVzKHN0cnVjdA0KPiA+IGJvbmRpbmcgKmJvbmQpDQo+
ID4gwqAJCQkJCQkJwqANCj4gPiBCT05EX1hGUk1fRkVBVFVSRVMpOw0KPiA+IMKgI2VuZGlmIC8q
IENPTkZJR19YRlJNX09GRkxPQUQgKi8NCj4gPiDCoA0KPiA+IC0JCWlmIChzbGF2ZS0+ZGV2LT5o
d19lbmNfZmVhdHVyZXMgJg0KPiA+IE5FVElGX0ZfR1NPX1BBUlRJQUwpDQo+ID4gLQkJCWdzb19w
YXJ0aWFsX2ZlYXR1cmVzICY9IHNsYXZlLT5kZXYtDQo+ID4gPmdzb19wYXJ0aWFsX2ZlYXR1cmVz
Ow0KPiA+ICsJCWdzb19wYXJ0aWFsX2ZlYXR1cmVzID0NCj4gPiBuZXRkZXZfaW5jcmVtZW50X2Zl
YXR1cmVzKGdzb19wYXJ0aWFsX2ZlYXR1cmVzLA0KPiA+ICsJCQkJCQkJCQ0KPiA+IHNsYXZlLT5k
ZXYtPmdzb19wYXJ0aWFsX2ZlYXR1cmVzLA0KPiA+ICsJCQkJCQkJCQ0KPiA+IEJPTkRfR1NPX1BB
UlRJQUxfRkVBVFVSRVMpOw0KPiA+IMKgDQo+ID4gwqAJCW1wbHNfZmVhdHVyZXMgPQ0KPiA+IG5l
dGRldl9pbmNyZW1lbnRfZmVhdHVyZXMobXBsc19mZWF0dXJlcywNCj4gPiDCoAkJCQkJCQnCoCBz
bGF2ZS0NCj4gPiA+ZGV2LT5tcGxzX2ZlYXR1cmVzLA0KPiA+IEBAIC0xNTk4LDEyICsxNjAyLDgg
QEAgc3RhdGljIHZvaWQgYm9uZF9jb21wdXRlX2ZlYXR1cmVzKHN0cnVjdA0KPiA+IGJvbmRpbmcg
KmJvbmQpDQo+ID4gwqAJfQ0KPiA+IMKgCWJvbmRfZGV2LT5oYXJkX2hlYWRlcl9sZW4gPSBtYXhf
aGFyZF9oZWFkZXJfbGVuOw0KPiA+IMKgDQo+ID4gLQlpZiAoZ3NvX3BhcnRpYWxfZmVhdHVyZXMg
JiBORVRJRl9GX0dTT19FU1ApDQo+ID4gLQkJYm9uZF9kZXYtPmdzb19wYXJ0aWFsX2ZlYXR1cmVz
IHw9IE5FVElGX0ZfR1NPX0VTUDsNCj4gPiAtCWVsc2UNCj4gPiAtCQlib25kX2Rldi0+Z3NvX3Bh
cnRpYWxfZmVhdHVyZXMgJj0NCj4gPiB+TkVUSUZfRl9HU09fRVNQOw0KPiA+IC0NCj4gPiDCoGRv
bmU6DQo+ID4gKwlib25kX2Rldi0+Z3NvX3BhcnRpYWxfZmVhdHVyZXMgPSBnc29fcGFydGlhbF9m
ZWF0dXJlczsNCj4gPiDCoAlib25kX2Rldi0+dmxhbl9mZWF0dXJlcyA9IHZsYW5fZmVhdHVyZXM7
DQo+ID4gwqAJYm9uZF9kZXYtPmh3X2VuY19mZWF0dXJlcyA9IGVuY19mZWF0dXJlcyB8DQo+ID4g
TkVUSUZfRl9HU09fRU5DQVBfQUxMIHwNCj4gPiDCoAkJCQnCoMKgwqAgTkVUSUZfRl9IV19WTEFO
X0NUQUdfVFggfA0KPiANCj4gwqDCoMKgwqDCoMKgwqAgaWYgKCFib25kX2hhc19zbGF2ZXMoYm9u
ZCkpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7DQo+IA0KPiBJ
ZiB0aGVyZSBpcyBubyBzbGF2ZXMsIHNob3VsZCB3ZSBhZGQgdGhlIGdzb19wYXJ0aWFsX2ZlYXR1
cmVzPw0KDQpUaGUgb3RoZXIgcGFydGlhbCBmZWF0dXJlIHNldHMgYXJlIGFkZGVkIGFmdGVyICdk
b25lOicsIHdoeSBub3QgZG8gdGhlDQpzYW1lIGZvciBnc29fcGFydGlhbF9mZWF0dXJlcyBmb3Ig
Y29uc2lzdGVuY3k/ICdnc29fcGFydGlhbF9mZWF0dXJlcycNCmlzIG90aGVyd2lzZSBub3Qgc2V0
IGFueXdoZXJlIGVsc2UgYW5kIHJlbGllcyBvbiBpdCBiZWluZyBzZXQgdG8gemVybw0Kd2hlbiBh
bGxvY2F0ZWQgaW4gYWxsb2NfbmV0ZGV2X21xcy4gSSB0aGluayBpdCdzIGJldHRlciBmb3IgaXQg
dG8gYmUNCmV4cGxpY2l0bHkgaW5pdGlhbGl6ZWQgaW4gYWxsIGNhc2VzIGhlcmUsIGxpa2UgdGhl
IG90aGVyIGZlYXR1cmUgc2V0cy4NCg0KQ29zbWluLg0K

