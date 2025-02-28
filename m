Return-Path: <linux-kselftest+bounces-27874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF46A4975F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 11:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B039F1659F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D2625A2A8;
	Fri, 28 Feb 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZcmUVV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672051C3029;
	Fri, 28 Feb 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738723; cv=fail; b=avCwejQcBpLgjcwRgowBSYljPcMaW2wVAXnRDaQo+irJbBlSAlhEVSKTBJ1AEqOH2yN0Z+CcBcI0TBIOjyrZg9E5owDgf6zfAjA1VJRD2wILd+palgn2GlX6EnV3ZNAz0UhKWVzq/FOJun/64S85gr1IU8KIBN6JRGPDqnISId0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738723; c=relaxed/simple;
	bh=Z0AV6SLvE+lWj3m0LPLnRQkLzWUijiXZmPuWgewLixo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tLDofImT0OTjR9DVCJDWTjzHcgcJTzpj3wNbk048aG3au+zCbfi0v2FwzzLj2yYwsQB4xlrwU/aMCUEfTDGaCLvSIjcm9mvzF40Wj9idYuH/lSBd9l/OilyKzjfJruFXKyA8nNNF1pc54zsdymsMMZ/j+G9FtnwkGQXZn/4B94E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZcmUVV1; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhwLx+7OafMpixi4AhXc17t+/kR1l3/x5msIS42QBHe8U/cf2QbpwxQjv4DeOtT+em3LtuQITFj110ILZlQT5zda9zDNE5SUr5qMIagBggoBoSalT/ayy7g66eSvrj8Ipyl1c+BpmIIl+FG5IVKu14yFeNyOdIWbF0QC+S4TLhei406ftIEqEfWSAdLVV3QYpJgIeTfWjqsDbl1tTjp5hIixWW/yb3aLMQy0cv/O13nbHOABsFGiV7S/d3Kfbdj1+EuiifDYtBh9qvDsDN5ZKPiHmRjQuxolbliE08Iz26Wc/OYHeLAzcWc9hETWv+M5CQVFuE24xqHxKEZSbSFnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0AV6SLvE+lWj3m0LPLnRQkLzWUijiXZmPuWgewLixo=;
 b=oELWUpCggdW5CE5/1K+QfXliKCi8mRleyiyglwebAPmqNdf4VTBkP//FbiQY2EdhrZict+TaSGwXMIQ4lIpufH/BlnnB2+UKYrmp51lpSxi7c1371hnWF6M2WAj9Ge++Bb/neJuInlru91mAfOhzOtv7E7ui2fwl9nkkkovvkZH96NfUkl9o42khZUdhC0p47fMsvvESsM4sEH0Er5DmLa6HaOIplMG5ZYpcKv6Tae5kW5c1D9CEXyVhx9N89vrz+HN9wSvErfoEIJznl100olGiQM04HdA+HISWNQhnUEj2AVlY6ww0eU0VPTjMhTlD7yA8BR5+VpgTDL9BG7u65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0AV6SLvE+lWj3m0LPLnRQkLzWUijiXZmPuWgewLixo=;
 b=tZcmUVV14IMdRctmHLO3ete2x+4IRpfLA5SqbileOm0+CAYKoQNCmRSzZyrpnfelBpF7zdRrH6P6qtuxDQeUD6puiXQpprOkABtDzFwGWZFmZvHUtcFbpuHRrm4IjP3uYKry9qMtc4cq6Em8VOrRBTvDXgmX9GLLoAPQ/bf1Eao51KfxWmIXvp1yrSKXVN8rvSfDuv5v7NH5LKfIpilXKDQQQrKmdzBZPbI46m4w/qSbz2+V/4ihNtunhP5PwcCpZbjkv43hg7I8Fn2LHNjV3RQc8ab92V+0sukxM+ejSjhP99q66LinoszrqUz18/QzpM4/j+37OGJJg/cEOzkjyg==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 10:31:58 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 10:31:58 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "razor@blackwall.org" <razor@blackwall.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "jarod@redhat.com"
	<jarod@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Topic: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Index:
 AQHbiPLkayT55t/yvkep5csWYH7qZLNa102AgAAI3oCAAEMWAIAAAoiAgADW+QCAAIlUgA==
Date: Fri, 28 Feb 2025 10:31:58 +0000
Message-ID: <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
	 <20250227083717.4307-2-liuhangbin@gmail.com>
	 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
	 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
	 <Z8Bm9i9St0zzDhRZ@fedora>
	 <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
	 <Z8EdatcTr9weRfHr@fedora>
In-Reply-To: <Z8EdatcTr9weRfHr@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH3PR12MB9024:EE_
x-ms-office365-filtering-correlation-id: 98caaa95-66c2-4aab-3148-08dd57e32156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUxjeTRwNytWaFJ6OElJZC9oUjQwd2hoR3dWR3BXdmFVVXo1UVI2Vjc4clo0?=
 =?utf-8?B?V1JIa05vcVhuMkRscTQwU21UUklyaE15M0J5ZTB4Q29xYktBVkV5a0pzUEhX?=
 =?utf-8?B?bW9maGllTjEyb0FEcHdoa2x3TWhoRkhxS3JZMmVSSzNzOS9abFQ1L0tZeEJa?=
 =?utf-8?B?dnNrL01mb1ByeFUxWEJVL0tSaWgzRWw2OEZjMlRHN2cvaFFCVzZPajRxN2lE?=
 =?utf-8?B?VlBDL2NDY01qUXFHUEprblhJVFd3aDdELzFqS1RWQUd3TkRrQmg1ejVZamg2?=
 =?utf-8?B?K2pURGRXVHdVZThtSVBnQUVOZVM2akVVSnoxbi91Q29scDJqdWREejAzWFJr?=
 =?utf-8?B?aEpKTGlrTU5ocFdaRERPbWpZZE9seWJ5d25ZeHc4QU5JK3gwNDdYYjBIb1RP?=
 =?utf-8?B?bXgyODJ1Nk1aMGJ5aVNHM0tzbkxEcVVKRkdzeDErYjkwLzIrTFZOditGM1Jp?=
 =?utf-8?B?dXMvN05zOWIxZjlWUzhMVkJXOTVJYWphZzB2NjAzLzV0TWptMHR1ZTVIMHdQ?=
 =?utf-8?B?MVhIZlBjRDFVUGtFUFBiRUhWR0t1b0NUeVdCUlV5aUZiTTNIWVpnQWczTlkw?=
 =?utf-8?B?U1JiaDI3bHpGaStxWGIvdkNZWlQwMnphd1orcjZCaVZLMXh5ak1BUlZpVGpG?=
 =?utf-8?B?TG1jL3FiWFZnbFg0V2F0alV6OWppSyt1WkVxRkFMb05weWQ4WHBsVVQwQk43?=
 =?utf-8?B?cUQ0Nnh3bE5LbldIZXN6aGEyRzNESXJRbWJRb0dqelhOWHJOeWc0VllyTlRZ?=
 =?utf-8?B?cE1aTFc1ME1CL3JXSWFDTVY4a1NqYTI3N29EMVZ4Q29UdzJtMHlwNTNJZ01Q?=
 =?utf-8?B?a09MTFpZTmk1ODMrRmhFNVBGSVcrRVpVYXZxd2FXSVFJM3JlNy9Kcy9XRzdp?=
 =?utf-8?B?R1M1V0VqelZ5S0d6UG82dUIvTGpmUVJCRzBISlhOekx0MCtocGRkR0xvejd6?=
 =?utf-8?B?eTJPZmNYcElqa2cwQUZDK3RXNHZxdWNCSUVBWGxIMmYwa0o4ZnJHcU9VZENk?=
 =?utf-8?B?YXdKMEVWYlNEZ0VhWXlmMHBMbE9maWFFWXpEKzFUdENDd2dRZ2hzdlNmbjVl?=
 =?utf-8?B?b0VhTHRKWHZFUGFkOGd0Vk9UeUpEaGdPUGZHemZUUDRvLzR0ZGlwRXM0Tzlr?=
 =?utf-8?B?ZjFwSWVpTjd5T2RudzIwZ2JZaWtvT0tOMjc3ZGk5N1NibkFpVVN4RjViSkwy?=
 =?utf-8?B?eHgyNmcxeVVrTHdsd2EyMk5wUy9EalZZT0J4Q2JVcHArNklQaWRheGg5YWRD?=
 =?utf-8?B?dEtmSlV0RytUU3RaVkNKMHNUVTRLS3FOMkczTkYzbTIyN0FadStVSjJqbjFj?=
 =?utf-8?B?dWxtRVFCQUFiempiMGYxSG4rWXhPLy9QamhuUHU1R2lTeFNaYUtMWkxqeVh4?=
 =?utf-8?B?eDRZb09qTkM1U2FSL0s1cFNLa1VmRlRrdU50U0FCSFgyUGlzdTFIemxXY09C?=
 =?utf-8?B?elRCRERvRGgwM2UwblEwZjhHS1ZKbG5jczUyNS9QWEtoRVg5NFJzRGlkaCtl?=
 =?utf-8?B?VWFsaUtLL1lhRTFqdlBSVjJqSlRhdFlPQmlxUURaTnN1NkZxNjBCd0VPTjQ5?=
 =?utf-8?B?cjVxNmExQ2hGVG9EM2xidVE0ZTRHbEp0dFkyMXpFbkVsbWRhMG5ENU9rTy8z?=
 =?utf-8?B?eG5Iam83U0RvOUxJcHNQaHZGY0VuYzBjRjBZaFdmeURhSkxTL2ZoNks5MDZH?=
 =?utf-8?B?YmdjbDBITUp5T3VNL1NXdjNqa0U3TlNSN0JwS29WTEs3ZDZmY3k3RVhydmVq?=
 =?utf-8?B?cjRSaGNnUGJYM2FTVHc2elNYZiszWFA0VTBlMDhzTWhjKzFVTmo0MHFoQmtV?=
 =?utf-8?B?SVc3eVlraURmZGVKcjlEM2l0UzBmcGxUWmV6dzFhUnczeWN5S09lNERYUFZF?=
 =?utf-8?B?M25ieGY5NzNvRWlsb2lGRmtXbEZ2UTNPTXZ6KzdrUDB6dFhPejFsVnUzSzE5?=
 =?utf-8?Q?RFWnYBRbtj3rBqoYffP8DmXdRR4Bg7jN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWplUnQ5MFFIaTZZOW5DaGVRemJKZzNhUktVNTN2Q3hJNkhaTFhoZmVyNmxU?=
 =?utf-8?B?VHI1bGJWZGpqR3pMTVZXZFZxdFA1U2M4SHQweERJS1Q1TTdzQktWdEpBTWpU?=
 =?utf-8?B?VGZDb3lsdEVtMVp4MzQ3NU1vSTI5SFB3eXlNS3FjU3I5eE5HSWZUdm53WG5L?=
 =?utf-8?B?UkZYeVd1WnlBK0crcUg5bUlyU2lLbTNpd25QU2E4WEQ5OGVSSjBLQ0FZaUli?=
 =?utf-8?B?NEluV1BLS2kyQVRmMDMxeHYyU29nUXpMMzdXdmlyL2FwS2xHWWZ4VUt4bE10?=
 =?utf-8?B?bFdzcmFSTHI3VEl6WkpKNHhuSXZMZUVHOEVEd2QvUW4wbEhrb2lRVmRleXY0?=
 =?utf-8?B?aVV5VlRYU0lvejJLZ3JQanlUa0NxNVQvSHBjSVY4cy8zb0VDUXFqUUtrZGJu?=
 =?utf-8?B?T3lSb1FrSVRqYWpqU2ZiWTI4Sk9sSGRsbE93aEhZbjl2RDVmOHZKQU5kTkdX?=
 =?utf-8?B?MFpGcGMyTEJvK3k5ai80c1pvVVN1VnNBVVFTeGgvWTR2SDBBdVBFclJXMFlO?=
 =?utf-8?B?WWg2R2xobk5LWjBHUUVWYjhVS3hoYWVzZmJDcFExVDBFYnozalNxK0UrbDBz?=
 =?utf-8?B?dmo1NlZrNVdLSk03YU9JdmlvcTFRdkZXblg2bzQzMTlzeGdqT29vbzlPNTNE?=
 =?utf-8?B?VFR1Q2dWYmlpWDd3LzZydUtKS3ZTMUx0SjdvczNFcnRVT2trRnhlWTZRalh0?=
 =?utf-8?B?allqbjVuRHFqaWFnMXVzTFpXdWJyZHMxOTIra2NGVkFwZjhiTTgxdkNLeWZm?=
 =?utf-8?B?YTRJOHlGY0taL3gwbFp3ZkpRVHBsMnpFWElveUwrYlhBdG03WEp0WHk4cG9S?=
 =?utf-8?B?NWpBcXV1NlJ4NTZkSXowTVRJWGFHMDdzcHRTODk4eUp4MEswdDVZRVhITUhP?=
 =?utf-8?B?dEI5ZVRxWXV6ZWdPMnNJV3djbkxwNlJLSFdNK2NEY0FUMkIrY25vV2M5Y0JO?=
 =?utf-8?B?cXZrUDQyM2hvZG5lR28wQzdjUjJ1a0U0RUFwRkRGa0xLUFhuZkQxN29zd3hY?=
 =?utf-8?B?RnFVaFd1ZVhYZTVBdG51eHJnSGlZNHpMKzBqYkUySEQxTGc4elFQYjUxeldI?=
 =?utf-8?B?L284S2hOZzhmdmdXbmE4RVMwS3RoZk84c2k4dmVLN1hUS2drM1FHUTZROTE4?=
 =?utf-8?B?dnJvMGdLNE1SOWtkVlBPa1h5c1VVdXUvZ01HWnRIOEJraHlsM0FheE1mUE9i?=
 =?utf-8?B?NUt1MkNYUFN4WkVpL3FsdStyeit5V2lIaFN6SUFJOUc3eTFDZUNCRTJ4YllI?=
 =?utf-8?B?UmRYNkZKaEk0WU1CVzREYjJKbmxReTc4NEhQY3FIM0E2YzNCZ0EzWFlJTzR6?=
 =?utf-8?B?NXd6elNTekczUFkwWTJWVmsrMVlUMnFUUk5mdVJWVHNMekgzcHNSNUlFRHlZ?=
 =?utf-8?B?U2dGUTNsWkF1SlVyMlFZY2doSWh5QTgxbDV4VUVpUHhNUUFZbUphRUtwNWpW?=
 =?utf-8?B?V3REdUZjeUdCYkNhczhNcG9DMyt1SlpKRlFWZ3pZM3o3TWJOT3dZS1NLWXhV?=
 =?utf-8?B?M3pPcHdnaWU4QnpQTnVUSC92eE1GeVRBTEpPR3d6T1Z1K25GOGs5S1M0UGJY?=
 =?utf-8?B?OUZoTFc3ODlRS3c3Vk5mblNwamNFVDhvYXVoa1R6RFdIK1RpZG5QYzNpWHdG?=
 =?utf-8?B?OEljb3dybXQ3RGtZME5QN0lHTURkVTNrVUw4ODUyd25XajA4WUtVOVI5WkxU?=
 =?utf-8?B?Qk9VUWFsY0xPR0JLdy96MzdRa2QxZnlrT251SGV5aFQ2TWYxQzdEazhNUW51?=
 =?utf-8?B?d0tNcXRJdEh6ZVBjTGw4TXZOOUpkOGMrNyt2M2cvKzNrQWtVOW42ekRBTlIz?=
 =?utf-8?B?STAzNUxOcDZieDVkSHFTajkrNHV5dW9tN0FjckJkWVdvWHkybnh3Wi9SbC9a?=
 =?utf-8?B?TFpzQ0ZlUlF6V3RDT2ROUUNubU85eWh5bGJiMG5qN0cvclRXVVZzbUdsUjhw?=
 =?utf-8?B?YzAyNFBKcHJKQWtqM3A0UW1TMWRRdWpwOWVDTVJORFU5Nlc2anpMNSs0amMx?=
 =?utf-8?B?aHM3bm9oSHI1Mnl4OU5lSWlJK205WUhUbUtIMzVMemtGMlk4eWhzeS9RVUNa?=
 =?utf-8?B?Y0puWm5nM2FweGpRRkQ5TWp0YzFkeFFuenRySnNLbGhCNG1TdTg3KzhJRXBL?=
 =?utf-8?Q?jTOfO5MymDF33hL+VsD3+WYz4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9C79842AC323489230648423DC7ABF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98caaa95-66c2-4aab-3148-08dd57e32156
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 10:31:58.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKZoqKO7L2Pnvhk4VCsVEGue27204RL/Fpx39+uU3xeirUgsmXlzdjB32Fz/ELkJK4zH4KgSx9AI5pHfipVAmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

T24gRnJpLCAyMDI1LTAyLTI4IGF0IDAyOjIwICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMDM6MzE6MDFQTSArMDIwMCwgTmlrb2xheSBBbGVrc2Fu
ZHJvdiB3cm90ZToNCj4gPiA+ID4gT25lIG1vcmUgdGhpbmcgLSBub3RlIEknbSBub3QgYW4geGZy
bSBleHBlcnQgYnkgZmFyIGJ1dCBpdA0KPiA+ID4gPiBzZWVtcyB0byBtZSBoZXJlIHlvdSBoYXZl
DQo+ID4gPiA+IHRvIGFsc28gY2FsbMKgIHhkb19kZXZfc3RhdGVfZnJlZSgpIHdpdGggdGhlIG9s
ZCBhY3RpdmUgc2xhdmUNCj4gPiA+ID4gZGV2IG90aGVyd2lzZSB0aGF0IHdpbGwNCj4gPiA+ID4g
bmV2ZXIgZ2V0IGNhbGxlZCB3aXRoIHRoZSBvcmlnaW5hbCByZWFsX2RldiBhZnRlciB0aGUgc3dp
dGNoIHRvDQo+ID4gPiA+IGEgbmV3DQo+ID4gPiA+IGFjdGl2ZSBzbGF2ZSAob3IgbW9yZSBhY2N1
cmF0ZWx5IGl0IG1pZ2h0IGlmIHRoZSBHQyBydW5zDQo+ID4gPiA+IGJldHdlZW4gdGhlIHN3aXRj
aGluZw0KPiA+ID4gPiBidXQgaXQgaXMgYSByYWNlKSwgY2FyZSBtdXN0IGJlIHRha2VuIHdydCBz
ZXF1ZW5jZSBvZiBldmVudHMNCj4gPiA+ID4gYmVjYXVzZSB0aGUgWEZSTQ0KPiA+ID4gDQo+ID4g
PiBDYW4gd2UganVzdCBjYWxsIHhzLT54c28ucmVhbF9kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+ID4g
Pnhkb19kZXZfc3RhdGVfZnJlZSh4cykNCj4gPiA+IG5vIG1hdHRlciB4cy0+eHNvLnJlYWxfZGV2
ID09IHJlYWxfZGV2IG9yIG5vdD8gSSdtIGFmcmFpZCBjYWxsaW5nDQo+ID4gPiB4ZG9fZGV2X3N0
YXRlX2ZyZWUoKSBldmVyeSB3aGVyZSBtYXkgbWFrZSB1cyBsb3QgbW9yZSBlYXNpbHkuDQo+ID4g
PiANCj4gPiANCj4gPiBZb3UnZCBoYXZlIHRvIGNoZWNrIGFsbCBkcml2ZXJzIHRoYXQgaW1wbGVt
ZW50IHRoZSBjYWxsYmFjayB0bw0KPiA+IGFuc3dlciB0aGF0IGFuZCBldmVuIHRoZW4NCj4gPiBJ
J2Qgc3RpY2sgdG8gdGhlIGNhbm9uaWNhbCB3YXkgb2YgaG93IGl0J3MgZG9uZSBpbiB4ZnJtIGFu
ZCBtYWtlDQo+ID4gdGhlIGJvbmQganVzdCBwYXNzdGhyb3VnaC4NCj4gPiBBbnkgb3RoZXIgZ2Ft
ZXMgYmVjb21lIGRhbmdlcm91cyBhbmQgbmV3IGNvZGUgd2lsbCBoYXZlIHRvIGJlDQo+ID4gY2Fy
ZWZ1bGx5IHJldmlld2VkIGV2ZXJ5DQo+ID4gdGltZSwgY2FsbGluZyBhbm90aGVyIGRldmljZSdz
IGZyZWVfc2Egd2hlbiBpdCB3YXNuJ3QgYWRkZWQgYmVmb3JlDQo+ID4gZG9lc24ndCBzb3VuZCBn
b29kLg0KPiA+IA0KPiA+ID4gPiBHQyBtYXkgYmUgcnVubmluZyBpbiBwYXJhbGxlbCB3aGljaCBw
cm9iYWJseSBtZWFucyB0aGF0IGluDQo+ID4gPiA+IGJvbmRfaXBzZWNfZnJlZV9zYSgpDQo+ID4g
PiA+IHlvdSdsbCBoYXZlIHRvIHRha2UgdGhlIG11dGV4IGJlZm9yZSBjYWxsaW5nDQo+ID4gPiA+
IHhkb19kZXZfc3RhdGVfZnJlZSgpIGFuZCBjaGVjaw0KPiA+ID4gPiBpZiB0aGUgZW50cnkgaXMg
c3RpbGwgbGlua2VkIGluIHRoZSBib25kJ3MgaXBzZWMgbGlzdCBiZWZvcmUNCj4gPiA+ID4gY2Fs
bGluZyB0aGUgZnJlZV9zYQ0KPiA+ID4gPiBjYWxsYmFjaywgaWYgaXQgaXNuJ3QgdGhlbiBkZWxf
c2FfYWxsIGdvdCB0byBpdCBiZWZvcmUgdGhlIEdDDQo+ID4gPiA+IGFuZCB0aGVyZSdzIG5vdGhp
bmcNCj4gPiA+ID4gdG8gZG8gaWYgaXQgYWxzbyBjYWxsZWQgdGhlIGRldidzIGZyZWVfc2EgY2Fs
bGJhY2suIFRoZSBjaGVjaw0KPiA+ID4gPiBmb3IgcmVhbF9kZXYgZG9lc24ndA0KPiA+ID4gPiBz
ZWVtIGVub3VnaCB0byBwcm90ZWN0IGFnYWluc3QgdGhpcyByYWNlLg0KPiA+ID4gDQo+ID4gPiBJ
IGFncmVlIHRoYXQgd2UgbmVlZCB0byB0YWtlIHRoZSBtdXRleCBiZWZvcmUgY2FsbGluZw0KPiA+
ID4geGRvX2Rldl9zdGF0ZV9mcmVlKCkNCj4gPiA+IGluIGJvbmRfaXBzZWNfZnJlZV9zYSgpLiBE
byB5b3UgdGhpbmsgaWYgdGhpcyBpcyBlbm91Z2g/IEknbSBhDQo+ID4gPiBiaXQgbG90IGhlcmUu
DQo+ID4gPiANCj4gPiA+IFRoYW5rcw0KPiA+ID4gSGFuZ2Jpbg0KPiA+IA0KPiA+IFdlbGwsIHRo
ZSByYWNlIGlzIGJldHdlZW4gdGhlIHhmcm0gR0MgYW5kIGRlbF9zYV9hbGwsIGluIGJvbmQncw0K
PiA+IGZyZWVfc2EgaWYgeW91DQo+ID4gd2FsayB0aGUgbGlzdCB1bmRlciB0aGUgbXV0ZXggYmVm
b3JlIGNhbGxpbmcgcmVhbF9kZXYncyBmcmVlDQo+ID4gY2FsbGJhY2sgYW5kDQo+ID4gZG9uJ3Qg
ZmluZCB0aGUgY3VycmVudCBlbGVtZW50IHRoYXQncyBiZWluZyBmcmVlZCBpbiBmcmVlX3NhIHRo
ZW4NCj4gPiBpdCB3YXMNCj4gPiBjbGVhbmVkIHVwIGJ5IGRlbF9zYV9hbGwsIG90aGVyd2lzZSBk
ZWxfc2FfYWxsIGlzIHdhaXRpbmcgdG8gd2Fsaw0KPiA+IHRoYXQNCj4gPiBsaXN0IGFuZCBjbGVh
biB0aGUgZW50cmllcy4gSSB0aGluayBpdCBzaG91bGQgYmUgZmluZSBhcyBsb25nIGFzDQo+ID4g
ZnJlZV9zYQ0KPiA+IHdhcyBjYWxsZWQgb25jZSB3aXRoIHRoZSBwcm9wZXIgZGV2aWNlLg0KPiAN
Cj4gT0ssIHNvIHRoZSBmcmVlIHdpbGwgYmUgY2FsbGVkIGVpdGhlciBpbiBkZWxfc2FfYWxsKCkg
b3IgZnJlZV9zYSgpLg0KPiBTb21ldGhpbmcgbGlrZSB0aGlzPw0KPiANClsuLi5dDQoNClVuZm9y
dHVuYXRlbHksIGFmdGVyIGFwcGx5aW5nIHRoZXNlIGNoYW5nZXMgYW5kIHJlYXNvbmluZyBhYm91
dCB0aGVtDQpmb3IgYSBiaXQsIEkgZG9uJ3QgdGhpbmsgdGhpcyB3aWxsIHdvcmsuIFRoZXJlIGFy
ZSBzdGlsbCByYWNlcyBsZWZ0Lg0KRm9yIGV4YW1wbGU6DQoxLiBBbiB4cyBpcyBtYXJrZWQgREVB
RCAoaW4gX194ZnJtX3N0YXRlX2RlbGV0ZSwgd2l0aCB4LT5sb2NrIGhlbGQpIGFuZA0KYmVmb3Jl
IC54ZG9fZGV2X3N0YXRlX2RlbGV0ZSgpIGlzIGNhbGxlZCBvbiBpdCwgYm9uZF9pcHNlY19kZWxf
c2FfYWxsDQppcyBjYWxsZWQgaW4gcGFyYWxsZWwsIGRvZXNuJ3QgY2FsbCBkZWxldGUgb24geHMg
KGJlY2F1c2UgaXQncyBkZWFkKSwNCnRoZW4gY2FsbHMgZnJlZSAoaW5jb3JyZWN0IHdpdGhvdXQg
ZGVsZXRlIGZpcnN0KSwgdGhlbiByZW1vdmVzIHRoZSBsaXN0DQplbnRyeS4gTGF0ZXIsIHhkb19k
ZXZfc3RhdGVfZGVsZXRlKCA9PSBib25kX2lwc2VjX2RlbF9zYSkgaXMgY2FsbGVkLA0KYW5kIGNh
bGxzIGRlbGV0ZSAoaW5jb3JyZWN0LCBvdXQgb2Ygb3JkZXIgd2l0aCBmcmVlKS4gRmluYWxseSwN
CmJvbmRfaXBzZWNfZnJlZV9zYSBpcyBjYWxsZWQsIHdoaWNoIGZvcnR1bmF0ZWx5IGRvZXNuJ3Qg
ZG8gYW55dGhpbmcNCnNpbGx5IGluIHRoZSBuZXcgcHJvcG9zZWQgZm9ybSBiZWNhdXNlIHhzIGlz
IG5vIGxvbmdlciBpbiB0aGUgbGlzdC4NCg0KMi4gQSBtb3JlIHNpbmlzdGVyIGZvcm0gb2YgdGhl
IGFib3ZlIHJhY2UgY2FuIGhhcHBlbiB3aGVuIA0KYm9uZF9pcHNlY19kZWxfc2FfYWxsKCkgY2Fs
bHMgZGVsZXRlIG9uIHJlYWxfZGV2LCB0aGVuIGluIHBhcmFsbGVsIGFuZA0KaW1tZWRpYXRlbHkg
YWZ0ZXIgX194ZnJtX3N0YXRlX2RlbGV0ZSBtYXJrcyB4cyBhcyBERUFEIGFuZCBjYWxscw0KYm9u
ZF9pcHNlY19kZWxfc2EoKSB3aGljaCBoYXBwaWx5IGNhbGxzIGRlbGV0ZSBvbiByZWFsX2RldiBh
Z2Fpbi4NCg0KSW4gb3JkZXIgdG8gZml4IHRoZXNlIHJhY2VzIChhbmQgb3RoZXJzIGxpa2UgaXQp
LCBJIHRoaW5rDQpib25kX2lwc2VjX2RlbF9zYV9hbGwgYW5kIGJvbmRfaXBzZWNfYWRkX3NhX2Fs
bCAqbmVlZCogdG8gYWNxdWlyZSB4LQ0KPmxvY2sgZm9yIGVhY2ggeHMgYmVpbmcgcHJvY2Vzc2Vk
LiBUaGlzIHdvdWxkIHByZXZlbnQgeGZybSBmcm9tDQpjb25jdXJyZW50bHkgaW5pdGlhdGluZyBh
ZGQvZGVsZXRlIG9wZXJhdGlvbnMgb24gdGhlIG1hbmFnZWQgc3RhdGVzLg0KDQpDb3NtaW4uDQo=

