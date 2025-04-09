Return-Path: <linux-kselftest+bounces-30419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4AA8281E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D438C7F79
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D126562C;
	Wed,  9 Apr 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bdTW86Zz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBB143C5D;
	Wed,  9 Apr 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209224; cv=fail; b=XIkXv6Jr/1I11bi4QB1wInWeN+4oCwY0+EbiSbG9f7AKUINzAlTxyIdvUsK3lgcDVjFOrk14EHowNRSa0Lbtr1zuWiYYg/cGP+/e/7+ITbl3vKlMvM8pqyrn5HtpZFGbMWQnZkGqpEB0HorCFSOXCL5ylk/maMOhuFY74FxJuWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209224; c=relaxed/simple;
	bh=m9fGoLk8xxfd6fyriJhsUxN9AZ7yReuH7scAA7PEeyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rY4pLG0At8daCzrmK/55hkHCDzkxB3WXy95y1xh7KMhQqU3Gpv3kIIVK8RAcLZ6FePyPm9jnZrrvG5z0cCZ0LckCMguNHvUJ9+IHq0BB66aHdJLpqnPOXhvxajQGfH8SCzSXQilH34l08zeC5qz2SZ3Pu4hRZYdfkmgvnBxmglw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bdTW86Zz; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVBjwtH9jtOCBJ63MN3EyZ5Li/KK5W/wwAMLbBtMzyjZNAzRGoFCTRvyscP5xKq4XC5IzGCxE8tU7FYCLy/zFGW584zdjFUaI7inls0YzAuTjb1Yy2hGVTcrIJ19xBscQ3/eOC+sCuqzI37GPVXlv9ARipkb6P5yAMPfG4u/YoMKk8nWYZfCxpnkT7IycQ1rg/AcKfz9dEOFEjJi80+V76L9LaRsdXmtNdEFK5l0RvZHsly/wPh/vf8uyeOzc8E8EGgCrj6t7GLpfdVRlnVXfmGbAB1arybBZT+yzAbYSwvREZsgTS2S7Noo/45GY34v4S4YpP9Arl0OI6k+58fchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9fGoLk8xxfd6fyriJhsUxN9AZ7yReuH7scAA7PEeyU=;
 b=UniFcRqEEBggYdpZWG/wkaB7QraYLKCGswoZdcCeOUrFI6313gLt0m4fawC2BNiEzkd00j73An6rZyIMG02UC/7m8BkN58JE781DL1XhMDJsnKukUc12/Vj40kxUs53oUJk8g5O0WPvyyowi5UW7y+jAvDHU2naPT2DZBI1862aL7akl6jMgtYnCMWndV5RZcCpsnSv1zPT8gCL0gg9G9THx+NB13R+0rL0r6SkZJ5yXblkY8ftVlcfmFoWM4OuWI/CBDjyo+n3zIghMFHx+ADgcD6Zo83yDMLpgYwVUBI/HEIVkeFWqa/U5yhaZTtlfllowCl57C9Gw/JG9QhIRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9fGoLk8xxfd6fyriJhsUxN9AZ7yReuH7scAA7PEeyU=;
 b=bdTW86ZzVbbqhGch6CTYqxIU4d5zhvXH6VUZo1K/E6m2p8806d2D7PpIdXZFfCz+TmLuZVbydlmZpxtr1S1JaDaXJJvssOC16sQdkk8vsmzQNowBlizUc9LERWW2MfENapXrLkjyK5pE1nR0DRM0PalFtxqcPJ/kp7xBrqRy6EFTYzmJI6cTCMdvxyM29pUEJB4VVsw3QnctBvc3CY0QOAHLPP36OiKBCNPmxW+pH0zunoReyk2L0dDCBIysV749l675/u69njdnTFkkITbaNeBSMKmYRItOlQra/iTZFPHeKIv0glrsstJ02dXDul78mEeU35yVZqsf5YWRUYhCGw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Wed, 9 Apr 2025 14:33:38 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 14:33:37 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"bbhushan2@marvell.com" <bbhushan2@marvell.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hkelam@marvell.com" <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "jv@jvosburgh.net"
	<jv@jvosburgh.net>, "razor@blackwall.org" <razor@blackwall.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
	"ayush.sawal@chelsio.com" <ayush.sawal@chelsio.com>, Jianbo Liu
	<jianbol@nvidia.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>
Subject: Re: [PATCH net-next 6/6] bonding: Fix multiple long standing offload
 races
Thread-Topic: [PATCH net-next 6/6] bonding: Fix multiple long standing offload
 races
Thread-Index: AQHbp8InuA5LlCZPgUGeUliE9EdSLrOZa2AAgAH92YA=
Date: Wed, 9 Apr 2025 14:33:37 +0000
Message-ID: <d6a3c15014a415b644c361f4678eebb0f1e64c45.camel@nvidia.com>
References: <20250407133542.2668491-1-cratiu@nvidia.com>
	 <20250407133542.2668491-7-cratiu@nvidia.com> <Z_TZjHEOeH4RMXBc@fedora>
In-Reply-To: <Z_TZjHEOeH4RMXBc@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH2PR12MB4136:EE_
x-ms-office365-filtering-correlation-id: 04cd1329-50b3-4758-6d72-08dd77738413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejQzUlduRGFPRUFXSGlqZjM0Nld0Q3NQdGlCdGxOWGlSdmVpLzZqdnFObkJj?=
 =?utf-8?B?bjFaWWVBL0ZVM0lMcTVYQUFvVzBJT0dab29CY2o4MnovTGd3Ly85MmpZZjFH?=
 =?utf-8?B?Z1ZiWnM3RnFvU2hGMzk4OWMrQmt0ZWxJM2pjc05CbUU5ekN2allaUE44RjMx?=
 =?utf-8?B?bWR1b1cvZzM5MWlnS1k0cGJnMEh2bkI4V1pkRWlKcXM1TmRrL0NQN1hvbHdL?=
 =?utf-8?B?UTg4bWQzbFhNajVURm9uVXVmQ3dia1Z1V1VQemlqUEEwQmpabVE0T0RXeDVJ?=
 =?utf-8?B?dUhJRmQyWFlHNzdQT3dHRjkveUZ6ZitvM21LSThra0s3UGZyTng2RFZ1SUg1?=
 =?utf-8?B?YW55T2l2dHAzSFovM1FaQVJSUlBnZ3VWaG1KczljLzNzS1ptazBqRDNRNkhx?=
 =?utf-8?B?THQvYTFqN0pLUnNKOERwU1YyNXhSVVhGQk1uNFJsQSsxS1BHaERjL2NDQTV1?=
 =?utf-8?B?cTBNSDFiRkNaVldNMlgyUnRPM0NobHJCSmhDdERZTWE4YVE0UUUrRkZLR1dx?=
 =?utf-8?B?YW9veDJTL3d6eW1MUXh4ODhpNmhSZC9Tc2JIa1lmKzJvOGNoNkNYUGw2dHJk?=
 =?utf-8?B?YzlKaWJpdmJjeUsrVUlza0JKMGlUS1FOc05xNGhucU5YMHpEdStUZ2JJUm1x?=
 =?utf-8?B?Nld5Y3NXSWFXRU51UXE0eUkwdHBQMUM2ODgvRWhncDdLRW5TOXhDZnRDcmh4?=
 =?utf-8?B?ZXRlN3NLVlNVbzR1L3R3RWgxSERBVXJqWTNnKzBzZ2NWUDVYTUpTMzVSM3Vn?=
 =?utf-8?B?d1BNQkxoc0lEMXJqa1BBY3BiWjJhbisrdG40WTdVdUJIeUJ6ZFpqdXhESmZv?=
 =?utf-8?B?OWtwTllGY0xNby8ra2xpSWxLanlXVlpaazdwWEFNWGtvTzFFbjFGb0ozQ1NL?=
 =?utf-8?B?MzdKOXlQbmhFdUNTN2hkSlBIY2JWNTNRd1pyZWNIN0N5TjNwSTQrVE0vRGRv?=
 =?utf-8?B?TExNZzR5RXowcy9mbm5IY3JSamNaZEErS1M2V0x6cjQ1S1FFaGtoNUpya1JW?=
 =?utf-8?B?OGFTbFY5MG1lR2R4eTg5ZllHQUpORmhKR0dYU2luUVF1RFdJVnFjWWlmQTFG?=
 =?utf-8?B?RFlqT0JIOVE1aUFLWldkZXRBbHJXVFlseVpMazFiUE1aWFJ2dDFXNitzYkVB?=
 =?utf-8?B?NzZVblk2N3hyVUtCTFdOM2pZZTJqTzNVQXBwa2RpTys3U1p1czVGWWVQeEVn?=
 =?utf-8?B?YVJQK1VVN092VERrSDdINU5QVkxhWUNtWFQrZkVGa1NYcU8xL3drUmpBaXZm?=
 =?utf-8?B?dG1SNTJqUUVzbDQrQ29mKzhhbThSRWtrOTkzL0psU1lMRCtkRE53QjV5amhp?=
 =?utf-8?B?VUs3ZnpEdTdRRHVJVVFNYTN1M0VzV3hJU0tXRmhEM1E3R0NibTR1RjZicC9w?=
 =?utf-8?B?Ui96REFhaTlTQTRFcTV2L29MZ3daQXdQMHBoY0o3dEEwVFhxNlV0c0VrdnVk?=
 =?utf-8?B?T25tejk5ZjF6SllqUjIzODI5N0ZlbytCdWlCeWo2Qms3WStKY3ZmcWo4Wm1I?=
 =?utf-8?B?OCthS1FQWndIVjJGbmVJOFVsZlE4MHNOUXluWk5oeVhsaXZuaFdaVHhZa0Q4?=
 =?utf-8?B?bnlUcWRIMU1RYnZQbjJ2TStvQmlrNG5VTjB2eXNHTmVvRGRKc2NxWmRLRlJU?=
 =?utf-8?B?dzJHWUxVY2I3TWpkYk05V3E0QTY4K2kzenZNM1dxWEZ4RDJnc2FQL1k5S2pF?=
 =?utf-8?B?elJOYXBpMUdQUTVhdXdnRzVDSGRSVFY2N1BtWkYreWVKbElyM3IveGtZd1V1?=
 =?utf-8?B?cmI3WDBGWS9XUzdEWTRQRnFuQnB4RDY3NitlRmF2R0RyYWhNOFduZDA3eG0z?=
 =?utf-8?B?OThCdGdLWEYvbTB6RVZzdWM1Skk4UDlaUC9DZnhYV1pYQ0RWRGtEd1B3WVc2?=
 =?utf-8?B?cEl4QUd0SFhEMkE3Tk1XSGxKUENBeFc2UWFUZU9wOEVNd3dGSmlWcWpwOExU?=
 =?utf-8?B?Qi9sRHZSL2JXU0N3QnhJWm81Q3RrNHJncTNLeDJSQ08zNzVsa0Jpd0djV1Vs?=
 =?utf-8?B?Y1F3cU5UOEx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTJ1V3UxSWRKemVSSWxaWjVPNkRQMUtvaGRaTXhNM0htU0FQVFkvZlpoRmEw?=
 =?utf-8?B?Sks3K0tGSE13NGRqbFd6U0FyV1o3aVpLcVJPbFpmQUI1NENDcTZkRzYwaWNs?=
 =?utf-8?B?MndFM0JXUTJDUWF6WnZvbGsxTkpaK2poVHFxUThzWFkrcFo5TUJ6UkliNzFh?=
 =?utf-8?B?aVRvMUtTSm5KTUxNYUZISXJ2cWUyVExiZ0E1c0VqZzh1bHk2Ynp0K0JyVlkr?=
 =?utf-8?B?czVHclUyRXVQMmxLeXFGTi96UHdxWms2RTl0djgyOGM5Z3VYc2RHbkw0Zk9D?=
 =?utf-8?B?RlZETTRBWE0xNmZGNDZUTDUrdDlWN1QzQ3l6Q0FCeUNjTnpiWDZYdEt2Vmps?=
 =?utf-8?B?aEpGMktCaUVNVXVWRkk3bkhXR3VkZW5BWUNxbkdiNzRyaGFUNDY5aStXSjkw?=
 =?utf-8?B?TWFBKzIvU0cyREZUOThSMGZWTldBMXlzbGszNEtkOU54cUJ1U0RZRWZHRGNr?=
 =?utf-8?B?aHlxUEpET2dJSzNQWFduL0dWamRWOUtrQUUrR1JhUWNMYXN4emsvWmJHaVlu?=
 =?utf-8?B?RUw1NXFkNGdoYlU0KzdpVlFYUms1dEV0T0dMTVJUZFNUejFScFM1dXlHdnR0?=
 =?utf-8?B?YmIwM3JhcjJPUVg4ME5MRS95U1dyeng4ei9uNnY3NkR3dTgrT3ZSL2xtTjgz?=
 =?utf-8?B?dHN5azI0bklpMS9nUzBEV2NNemY3VlNud01UQVZzUEcxanVsYUVsQVVBK3p0?=
 =?utf-8?B?WUlpMjc5VVRHeWVrQTdtTUltdWY4dDR6bXJ5NFhxQXZiOG9Bbk9ySUtYNVRp?=
 =?utf-8?B?VHluRitnSUhucE1INjJzUHA0amVPblFiSGxPSUZZV0M5Wm0xbW9IbG0zNndG?=
 =?utf-8?B?ODdhWnRBbUZ5RmhVSEdIZ21zMTJZeFJ2Sk1QSGZucEY2by9zc21RbTJGa3BQ?=
 =?utf-8?B?VTVobDdMUFdPek5BajNsUW8rWEFlcFd3UDB1dzlSMzRWYUtHRk95ZC9uZldU?=
 =?utf-8?B?eENMYkJlRlpmUUUzdmdaT1lDTEdERGRNYk9VWE55Vm5HVDhaTklBV2JpcWNR?=
 =?utf-8?B?YXhTMndnUlJ1cnJiTmVqMkcrRXRqQnlpSjFrN0N2OW9BSktlRUdPVTZZM3VC?=
 =?utf-8?B?T2I1TXREekFxNktnQncyODMzaXVmUFVqcUpoZW9CWkFWMzJkUzlDdDZUT2NG?=
 =?utf-8?B?Wlh2OTRmb3JMclZGd0diVDdEWVRHM3BrSjdrc1EzQzRKbHdGN0tyalVORW9E?=
 =?utf-8?B?YXFIQjZIQWdOaFlKR1VzZ0JKZ0U4WGozZmJ4QWtVaUcxeE9hS1pCVWJucEF0?=
 =?utf-8?B?NWF5OU5TbndVd2h4aDBEejE4QWVVVTJSZW5LNXcrU0xQZ3FaQ1V5NStCVVBN?=
 =?utf-8?B?MWl6THQ3Vmt5SXdxS1FEYlZXb05uQ1NCcWNzcHp0SlJCd1VLVnl5dmhIU253?=
 =?utf-8?B?Q0J0R0lSVC9CYVhVMHhrR29INlFEMEdaU2U1ZXdqMzhvUDBDUDMyallxaW9m?=
 =?utf-8?B?NTJRR1VZWmV6UmRmNmZXSFZUQ2VDT3lwUHBIelRpM250SHJhVEwwZVdkdUtJ?=
 =?utf-8?B?TGZHZ0F0d0svcVdaTk5hY3FvVTFrcmtIZGd2anpFY2ZYUUVYMU1QWFBRaS9R?=
 =?utf-8?B?eno2MytKa0tTQ29wV1dseWw3VmtGeGFrb1hGb254VkVhUitnSUNqVk1scWFu?=
 =?utf-8?B?U3NpN2VncnVFUjV1STBCeXp4Y0pnVm9RQklBYitKU3FDTXErOFdtTXFBajh6?=
 =?utf-8?B?bUZoRXIrNS9iWUY5TzhoSEQ3RUNONDJCQVBGLzlaTmpIbVZKd3JnbEl0NjRT?=
 =?utf-8?B?amZPS25UTW45YkRjVmpiRlpTbEFHL041MzBUWVlwNk9leEk4TVZGS1g1STlz?=
 =?utf-8?B?a2wyeGx0UlNzaGNPTjBDSnJORFliODQrcHZEOEhBTFBpWXNUVkxiektGcnVk?=
 =?utf-8?B?bkdGelZtSGh6MjM1ditwVGxMQStKZ210bytCakg0ZXRUQTl3L2lwWS9LWTg5?=
 =?utf-8?B?MG9lVjY2SWttT1dLYzN4OVhzMlJwcjF3ZUszZ3c3c2hFY1hPMjgwYTYvWXo4?=
 =?utf-8?B?SEp5WG5sbytWOE12bXdOQkl6ZmxreEF4dVNNNUx3STYzRnNLVnN2UzF0WkRq?=
 =?utf-8?B?L3AvYzczMjZ6SmpqUUQrL0oyOUJ4bE5hRlY3ajRZWWlOMHY1aVdNSTcrSjlT?=
 =?utf-8?Q?kxY2Cf3kuJecJcFYhu7gENrNY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1C568E05D77C45A8097A27E7B1BE8A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cd1329-50b3-4758-6d72-08dd77738413
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 14:33:37.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSrfmvnCaKJCuiXNqMdQTQ8IDfLDRL9DGmpuMV1d8CubdX4QZyjesBVFASlIjsGCguZll4lpPpN+g5hqTJM8SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDA4OjA4ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
SGkgQ29zbWluLA0KPiANCj4gVGhhbmtzIGEgbG90IGZvciB0aGUgZml4ZXMuIFdpdGggeW91ciBw
YXRjaCBhcHBsaWVkLiBJIHNlZSB0aGUNCj4gYm9uZF9pcHNlY19kZWxfc2EoKSBzdGlsbCBoYXMg
V0FSTl9PTih4cy0+eHNvLnJlYWxfZGV2ICE9IHJlYWxfZGV2KTsNCj4gDQo+IERvIHlvdSB0aGlu
ayBpZiB3ZSBzdGlsbCBoYXMgdGhpcyBwb3NzaWJpbGl0eT8gSWYgeWVzLCBzaG91bGQgd2UgZG8N
Cj4geGRvX2Rldl9zdGF0ZV9kZWxldGUoKSBvbiB4cy0+eHNvLnJlYWxfZGV2IG9yIHJlYWxfZGV2
Pw0KDQpZb3UgYXJlIHJpZ2h0LCB0aGUgV0FSTl9PTiBkb2Vzbid0IG1ha2Ugc2Vuc2UgYW55IG1v
cmUuDQpib25kX2lwc2VjX2RlbF9zYSgpIGNhbiBnZXQgdGhlIHNhbWUgdHJlYXRtZW50IGFzIGJv
bmRfaXBzZWNfZnJlZV9zYSgpLA0KSSdsbCBkbyBzbyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpD
b3NtaW4uDQo=

