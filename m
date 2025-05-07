Return-Path: <linux-kselftest+bounces-32581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D85AAE346
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8D9C1706
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFF289801;
	Wed,  7 May 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBnPV6c0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2928001E;
	Wed,  7 May 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628532; cv=fail; b=CefULtvxgRc8h+2HWFQVCe+aFANnlKNq+a7CAVM2PeG+le6n2vLnj7Fasu/wpw5aa/QhuUDsFqp1ek4+V5spGWcF/w2grVW1NlkB35uEkb8tLczlBG8cOrJwMFe2UCZN3MIP7u0UXfL4IZ/g0CKDaIPt8vZkKNwySgpVN41uWvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628532; c=relaxed/simple;
	bh=m6RHk49Kfd3wZh1HfWKitnMcjn8AqlCemOeWhgkKV7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fafZw8UDOx1Y6HY/mkMOUNEBwA2CmW+NwyNA0Ee2xKLZrW77BGOHO6dE1gBjRhrcPwuAnghPeAlsCsjhfvC52zCxsToD10hYP/X0SPzh94v/vLZS90ske74yo2Kmpzu3KkV5+shhNuPANg7UOF38dME25/hBNzYrPWmGJX6y+XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBnPV6c0; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0witTjzGxbPHq8JURy4HbfcSIu+30T8AaDWtpr6ZSiLZZQZBtsI+Xly4E25XdnRUWNso1w6W6T7/KMVXl1guKFfKMMee2VHepKooVAFaaoW2EhtNvDswvlv/t0LWFFk0uEaYw8Qx52TQuikV0yoIzTUv6uDV613vtNEYAkR8oCHdlhh89+NPvVMHTAASu/+pfTSXCZWAHZPexeOAR98UX6ugTuT7802In1BTXDXBoSAc2hSRm5l3/8qsK8VQbE0DRyfnTws86u9++/2zW9xVa9YP3QUBSC4vAaZOOjddvkgRM1Du1oEhadjfQmKjHlyRinseJzUb/YkoGoJNOP0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6RHk49Kfd3wZh1HfWKitnMcjn8AqlCemOeWhgkKV7E=;
 b=DJDRU6jvO1edi8rv87ZvbEj3w31WS7nvChKly2ubug8cKP9uQX5R44Hg7HkFMHgikU9ceZ7vFyA8xifzv0Ob+7kRMi08i8hx0kNNWtw6R7PCnRcPxe0wdQiHG68XNMVmnZa+PzAeti7NhbXC0vzYcjIoXBZ+KnUUDDNTKTorNv5KPsEADIeQUlwd+WKz1YFnFMdNtIOVx8mwgjCSimggWGH4haAAQKQ1l7ZEI+SmTyE7fyWafeIGw4LsKyABq6xVpwscGUzrgMNy63DHEkcz4VNZLmghKk2ulbOXWA57lcDl4ufZqo1XlXnUDyjQNbQVzABeBUfEPlGxTld3kkFovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6RHk49Kfd3wZh1HfWKitnMcjn8AqlCemOeWhgkKV7E=;
 b=EBnPV6c0Fkvhg+79nacC9N9j/vjFNGZlkB/Pg81zFzs4IiWPUrXHibt0JE0+RD7MfW3CMUHH0xraWLxYcH1LhMnxYfQNuyt/ghKKOz+X2Qf90p5h8+rDzErIV9L2hyoTdrLnG6bfa+KBD3i4ougOi6YLHIVHlvXJqyNnvgkedEvyO2w2I0WpZWVC2wny+4+Y8Tb7RRwil8RNWWwI+ZkKOBmrEF+uF09HusKLTEuv8TT26NdhJlo+0Rab4qQJC5VhY4wJDZKNvDtjGs1NI0L6tapdLK/Uu/S9SwFwYnmw38UpPCb6IC1a5kkbZJeGcPUp0+6dHXK/auDeP5U3i1HcXA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 14:35:22 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 14:35:21 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Dragos
 Tatulea <dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Thread-Topic: [PATCH net] net: Lock lower level devices when updating features
Thread-Index: AQHbvpI68/ihdVxTiEiw4lpvBpBbzLPF1uyAgAAJx4CAAAdlgIABVUcA
Date: Wed, 7 May 2025 14:35:21 +0000
Message-ID: <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
	 <aBpC9_SgUaAA2P0f@mini-arch>
	 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
	 <aBpRX_afG5X_rT_J@mini-arch>
In-Reply-To: <aBpRX_afG5X_rT_J@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|IA1PR12MB7518:EE_
x-ms-office365-filtering-correlation-id: d9c1da53-877f-44c2-1347-08dd8d7465b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmhZRG5VQmRuM3V4b2dwTlhjOFA5TjBhU0FTS0g4dmkvbFFnTGozb0xGdWJm?=
 =?utf-8?B?NnlpNjFBd2FRejBYYjArUzU5QmwzZE1QMW1sL3QrYXhyZnJFaEtuSW02RWE0?=
 =?utf-8?B?YlBuTjlmK1d2Sm9pTnV2UXF3TlVCcUFDaDFuRkJwQjltcXZNSmR0OURpRUsv?=
 =?utf-8?B?bkxOMWhCcThpQytvck9XcGR6RVZ3QmF4NGcyTHIycUpDbHljclduSXJwK2lJ?=
 =?utf-8?B?Y1FmUkg0WnBLeE45YjFhRFltUGtmd2VGT000ZU9saHowT1lpZFBZNmI4UXZl?=
 =?utf-8?B?Y1JaY1pUZ2dvMGo3MnpYcGJJb3dDbCtSaVVINkQzVHF2ejRhSzcvdC9TamZM?=
 =?utf-8?B?YzZxVXNDa0dPT3pPSlJ0WmVwek1hM1NwN1VYN0d3SXV4My9lN0xvcFZCbjNS?=
 =?utf-8?B?K1pIT253TjlxL0hDL3pnek13ZkJJOHdoU1dmemVVa3FXZHY4UVlKQ1V6OUQ1?=
 =?utf-8?B?bHFiRXo1ZDZHeDlac0w2RndYY2syVkVVaE5LYkV1eENmMWg1UmluU2RidGZQ?=
 =?utf-8?B?MlYrcVdKd1BLbURGQ3o2UDBwQ2gwT09kL0ZDbGdCa3MzRlRMZ0RieTFDUHpP?=
 =?utf-8?B?c01rMzlISllURndzQ1F2UGhSbDdXLzdLd2dSZitGNlhXbXRHQk5Pb2VlQjBD?=
 =?utf-8?B?M1ZheEhiY05VVnZwditvZDYzdis1aTI2dENzdFlOMGxkU3Rsd2ZKTnJDZkl3?=
 =?utf-8?B?VVplNk85RHBxVDNVRGU5a3pHa1dLT3JkN1UvOVFqdXlDZU02VWxPYm1LYUs2?=
 =?utf-8?B?Q0orUkVjcFRwb2E3eW1kRmRJSDdvVkduL0g4V2J6K2VWUk1PZkplVHU1QnUy?=
 =?utf-8?B?TGNpZittTjRDYjl0eU8rT3B1NkpuUktBcjJ3dUU4Zytua3hrNDltR2EwL3J2?=
 =?utf-8?B?RCtaM0FjVnQxSHE1WUNDTldxWUZBL0JEM0RRTko2ZlovNE9ZYW9aYy9RMEtG?=
 =?utf-8?B?RlNDcGZMSW9qUHNlRmRPSFN6QnJLSVVnZ2duMEFtOVBoWE1GWUlXQ2Z0Ykdy?=
 =?utf-8?B?QTVEME5qYTVubnVyUXJ0cEUrVTJ2ellvQWUwRnVZVHJCbXBLNnRBYTlTenUv?=
 =?utf-8?B?QnBUSSt5RXhDUFZFTXk3cDBxMEJHUnlzQ29zeUplaHZpQWl0OWZqblpmNFZq?=
 =?utf-8?B?K1grZnhWa0JsWGVaRmtpQk93WjhMazc0SFNyVk1jUVNBU0VtNTQzdXk2elNS?=
 =?utf-8?B?ZDJmQjhjSUxkTWkzbExKdTlQVXVvandQWnBEWUdJWG1PbkpIR25QcXVLTFl1?=
 =?utf-8?B?MWlRM1pORnB1T3hyZnIwYXpPcHhOcXRZRldjdzdNa3N4cU42cE9IdE94Qncz?=
 =?utf-8?B?ejJNdjlOWTFvOTZpMUpjVjVXYjNpa1A3ZkZmWk80dkQyaU90bWtEVGlIc1NO?=
 =?utf-8?B?NmxuL2dkTCtLL0hwN0Q2OCtyeEhZTVJzVzgvUXhmcCtsWmFRRUpUd2s0R0FC?=
 =?utf-8?B?VVpXSHFLaEJnRVErWllEUXBFdjU2TkFmOHNGK3ptcmI1VEJzQSs1c3NPSytE?=
 =?utf-8?B?YnBZSUZCUExvSnBuVzRCVXJTOUNBTTd1c1lqMDRlVXdMWXMyZ1VBZWFsNFVS?=
 =?utf-8?B?TlU1eXB0VVBiTmdYekd1RnpCaU5IQlpLcVlzMGJaN280b0d0YWo0N05tVGhr?=
 =?utf-8?B?S3JoOFFDaDYrckZCOVlXVEdrSGZNRjZPNjU3UWhFYjYyK1FKNFc2TEsxNlhl?=
 =?utf-8?B?LzVUcFA3dGpBTXN5UzV0V3NtL3VDWjYvTFc5V1hTRlNlQWdRN3dPZWcySjVx?=
 =?utf-8?B?TEhYNUx4U2NSVWUyNFhQTCtZZ0twbm10N0tSUTM0cGgrYUZFRXA1c2pGbWRh?=
 =?utf-8?B?N0JZU2VnVWdLYTYwWmxqWGg2di96V1BwR1NKWmpDM291SGIwa0NHUStSVVJ5?=
 =?utf-8?B?S0QxRS9ieTZpd0N0d2xWMWYyakJMZ0RucmlkRXg2YmJmMnRRWnA0N2pqWGZW?=
 =?utf-8?B?Rm0zc0drZlhacVZuRDM2NW9qZGRvb1RCYnIyRkI3TWkzL1hjdE4zNHQ3Zkh5?=
 =?utf-8?B?bU1SYTd4MkdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGZhNUtQVks5S0hNMk1uZU1BbzJsdUNlR01qcDU1ejlKOUdqb1BUQ0ZWS0J5?=
 =?utf-8?B?ZkZ6LzBWVFdKZVFMSzNOZ01LKzkxYnh2N0VsVkppdjY5TUxRMjQxazdySFhJ?=
 =?utf-8?B?cEVOQ0hNR3ZTVFAxT3B6RkdnYk5QWFRjZFMrWlBiSTlBaEFsSCswZGs0S2dt?=
 =?utf-8?B?RHlYd09pWDJJejVSTHBleGtsUlI4b2FTNFlNNjVFQ2JpWGtDTGhmL3ZSdURW?=
 =?utf-8?B?T08zZzJEYWNMN3pyZ0tJaG1UdktGZFRhK1NJSEM1SkRYa2FmZFU5dEtmZFlN?=
 =?utf-8?B?eGFLZzQ1YlY4YmxURUNxNGo5cC9rKzBhR2tGODVGWEFXY0dHVEJ0SzVSSzdh?=
 =?utf-8?B?ZUhxbWpRY3dVUS8zcHpxRGpUMzB2UCsxbjNQYVNvS3lPdjdtNHNoZVRkNnZy?=
 =?utf-8?B?RU51U3NvRHU5a0RIYm0vbmJsL2R2ZW1iRTBXUkJpMnE3UExSaWpxVkh6ZGRN?=
 =?utf-8?B?YkNxYkVKZENob0lqSUx0TjlBeUlxcDl2R09pQUc1Ymg1SXVtckl4Vm9MbWZh?=
 =?utf-8?B?QllJd1E1bUVCb0FsNUVjREdRZXp3amNoQjFEWUtETGgxUytGNVZZZWZjR2JD?=
 =?utf-8?B?UjhOOUlvSkI5L2plZHJQbm1XQ016ak42Qmk4SEltQll5dkpqLzZxTTdsSnFn?=
 =?utf-8?B?VEt2NElBTlRwclhkY01oUmtSelZVWFV6YnZPTnZaWWdHeTkrdjlQWmRvbEtI?=
 =?utf-8?B?K2NvM2hOcjFPdkVPeVUzMnBObG5aSzgwMUlsR2dBaTRmT2hzdTdxOWRqNGtK?=
 =?utf-8?B?YUV3ck5nQURZNmoxQXBIOXdUYUZNTkxxMWZVREF2QVgrTEZvOE9uN1RVQW4y?=
 =?utf-8?B?cXVvZHUzbmZuNDFvcHVQNWNYTE1LQWlTeWdUM0hNakpPcHpmSmhhRDYxMXBP?=
 =?utf-8?B?NGFxT2dlT3JhUWFyeE4rcjNWNkUvWm5QWW5vZVBuS2hYZGcvMTVJZHVWY2NS?=
 =?utf-8?B?OFlORTRpZTJzNENiK0U2WmZEaDVZSTJvcVlRbHRyaFFhUWVZY1hGUjZQUVNO?=
 =?utf-8?B?T0NhbVFmeU5TYTM5cENpemNTVis5RDJBS3haQTF5K3ljVFhnQ0N3OTBONXBy?=
 =?utf-8?B?WmFCMjRGLytjdjBsMSs2cEVxYUtVSCt3V1ltSno3Z2YxMk9kRFhiZWVoVlRN?=
 =?utf-8?B?NUg1b3poeGdsQXB0ci9pcUhVdWF4bGZ6UUlHbVpEd1RBVlR3NGwrekZVcFJm?=
 =?utf-8?B?ZkRnZWhZQ0pNcVA5T2FLaExFcEw0amNrVXQySzFINndrUHZhZlFreGtNd1lB?=
 =?utf-8?B?bUE0Q1hMNHB3UjVKa3NQL1Y2d0ZpZXNxbTBkdi9TRVRaUThDWGVVS3dpVnk4?=
 =?utf-8?B?aXE1OEN0MGFQb05saEdOQWp0dHFSVnpRRHl0dXdsbFo1clA2U3ZSOFlCdkxi?=
 =?utf-8?B?VzhCbEJGckl2SlpmZlplckRmS1dDdndIZDBUbExDd0VNcDM1dXZsYnNJTHRu?=
 =?utf-8?B?eENCQ0ZSNWUrWXU0UW4rTDc4UkltZThYUVNBRDhyNHByMyswUFpIZlJSRHdW?=
 =?utf-8?B?NHpkQmp5QWpjdld1VWM0dkZGNHZjejJvVVFTWVVVRGhCNERWbExqbCtSVkd1?=
 =?utf-8?B?OUQ2ZDZackZvb2RsRnRIT2FIb2NRd1V3bm5sd08vS0dZczYwSlNNUnZ3Q2xZ?=
 =?utf-8?B?dkhhbk5mOGlrVDYxZHl3UmpCL3NhZW9YQkc5NFdCbTdnQmpTUlZnOVkyN2lV?=
 =?utf-8?B?WE5ZZlZxSGJoUWlUN214TVVYY0V0bldJMXF2U3ZmZi9zZ0VocnU0UGpSSUEr?=
 =?utf-8?B?UTBTdXNWcWczMjByOEVQWnFlUUhla3dSSWJDNERHQ2ZVSWFWQUt6RzZkVVVq?=
 =?utf-8?B?WDE3c1AvVGVldUJnS3ZYZCtvSXA1UXdrYzVOTzVzbitGemJMcytuYVM0WmlK?=
 =?utf-8?B?NjNvOGpqUUhUSVhyd2dlL3BpczNjazY0bUs2R29QVGc4ejMvc2kzZFZqM3lB?=
 =?utf-8?B?cVlNcHZydWlOMTRKZFlSakN1UlUxQlVrQnlzeGhyQi8ycHRCeS9NelpYMjNv?=
 =?utf-8?B?M05SV0Z2bWNMM2J4WC9IR1Y5d2dXb25Tb2tKYTh6ZEIzMmV2SXlURUJDQlJz?=
 =?utf-8?B?dE9ZT3VTQk9lWW9laXdSbmRNWEgyTVV6dnNQdXlITy96YVcwODhzcytlQ2dU?=
 =?utf-8?Q?dNR3MTomPVLFHAZFi9jnbHbUF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9445DF7071DC6469F2FB86C6B830B64@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c1da53-877f-44c2-1347-08dd8d7465b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 14:35:21.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io79UHPvTsvCMvGns15a2bkYNA7o775dnRDkdQdCB690EHMw4zFXwldXfJ4dyitEyKH530/TohWU+8qrJsg4qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDExOjEzIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA1LzA2LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+IA0KPiANCj4gUmlnaHQsIGJ1
dCBuZXRkZXZfc3luY19sb3dlcl9mZWF0dXJlcyBjYWxscyBsb3dlcidzDQo+IF9fbmV0ZGV2X3Vw
ZGF0ZV9mZWF0dXJlcw0KPiBvbmx5IGZvciBORVRJRl9GX1VQUEVSX0RJU0FCTEVTLiBTbyBpdCBk
b2Vzbid0IHByb3BhZ2F0ZSBhbGwNCj4gZmVhdHVyZXMsDQo+IG9ubHkgTFJPIEFGQUlDVC4NCg0K
R290IGl0LCBJIGRpZG4ndCBsb29rIGludG8gd2hhdCBuZXRkZXZfc3luY19sb3dlcl9mZWF0dXJl
cyBhY3R1YWxseQ0KZG9lcyBiZXNpZGVzIG5vdGljaW5nIGl0IGNhbiBjYWxsIF9fbmV0ZGV2X3Vw
ZGF0ZV9mZWF0dXJlLi4uDQoNCkluIGFueSBjYXNlLCBwbGVhc2UgaG9sZCBvZmYgd2l0aCBwaWNr
aW5nIHRoaXMgcGF0Y2ggdXAsIGl0IHNlZW1zDQp0aGVyZSdzIGEgcG9zc2liaWxpdHkgb2YgYSBy
ZWFsIGRlYWRsb2NrLiBIZXJlJ3MgdGhlIHNjZW5hcmlvOg0KDQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KV0FSTklORzogcG9zc2libGUgcmVjdXJzaXZlIGxv
Y2tpbmcgZGV0ZWN0ZWQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpldGh0b29sLzQ0MTUwIGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQpmZmZmODg4MTM2
NGU4YzgwICgmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzcpeysuKy59LXs0OjR9LCBhdDoNCl9fbmV0
ZGV2X3VwZGF0ZV9mZWF0dXJlcysweDMxZS8weGUyMA0KDQpidXQgdGFzayBpcyBhbHJlYWR5IGhv
bGRpbmcgbG9jazoNCmZmZmY4ODgxMzY0ZThjODAgKCZkZXZfaW5zdGFuY2VfbG9ja19rZXkjNyl7
Ky4rLn0tezQ6NH0sIGF0Og0KZXRobmxfc2V0X2ZlYXR1cmVzKzB4YmMvMHg0YjANCmFuZCB0aGUg
bG9jayBjb21wYXJpc29uIGZ1bmN0aW9uIHJldHVybnMgMDoNCg0Kb3RoZXIgaW5mbyB0aGF0IG1p
Z2h0IGhlbHAgdXMgZGVidWcgdGhpczoNCiBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBzY2VuYXJp
bzoNCg0KICAgICAgIENQVTANCiAgICAgICAtLS0tDQogIGxvY2soJmRldl9pbnN0YW5jZV9sb2Nr
X2tleSM3KTsNCiAgbG9jaygmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzcpOw0KDQogKioqIERFQURM
T0NLICoqKg0KDQogTWF5IGJlIGR1ZSB0byBtaXNzaW5nIGxvY2sgbmVzdGluZyBub3RhdGlvbg0K
DQozIGxvY2tzIGhlbGQgYnkgZXRodG9vbC80NDE1MDoNCiAjMDogZmZmZmZmZmY4MzBlNWE1MCAo
Y2JfbG9jayl7KysrK30tezQ6NH0sIGF0OiBnZW5sX3JjdisweDE1LzB4NDANCiAjMTogZmZmZmZm
ZmY4MzBjZjcwOCAocnRubF9tdXRleCl7Ky4rLn0tezQ6NH0sIGF0Og0KZXRobmxfc2V0X2ZlYXR1
cmVzKzB4ODgvMHg0YjANCiAjMjogZmZmZjg4ODEzNjRlOGM4MCAoJmRldl9pbnN0YW5jZV9sb2Nr
X2tleSM3KXsrLisufS17NDo0fSwgYXQ6DQpldGhubF9zZXRfZmVhdHVyZXMrMHhiYy8weDRiMA0K
DQpzdGFjayBiYWNrdHJhY2U6DQpDYWxsIFRyYWNlOg0KIDxUQVNLPg0KIGR1bXBfc3RhY2tfbHZs
KzB4NjkvMHhhMA0KIHByaW50X2RlYWRsb2NrX2J1Zy5jb2xkKzB4YmQvMHhjYQ0KIF9fbG9ja19h
Y3F1aXJlKzB4MTYzYy8weDJmMDANCiBsb2NrX2FjcXVpcmUrMHhkMy8weDJlMA0KIF9fbXV0ZXhf
bG9jaysweDk4LzB4ZjEwDQogX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4MzFlLzB4ZTIwDQog
bmV0ZGV2X3VwZGF0ZV9mZWF0dXJlcysweDFmLzB4NjANCiB2bGFuX2RldmljZV9ldmVudCsweDU3
ZC8weDkzMCBbODAyMXFdDQogbm90aWZpZXJfY2FsbF9jaGFpbisweDNkLzB4MTAwDQogbmV0ZGV2
X2ZlYXR1cmVzX2NoYW5nZSsweDMyLzB4NTANCiBldGhubF9zZXRfZmVhdHVyZXMrMHgxN2UvMHg0
YjANCiBnZW5sX2ZhbWlseV9yY3ZfbXNnX2RvaXQrMHhlMC8weDEzMA0KIGdlbmxfcmN2X21zZysw
eDE4OC8weDI5MA0KWy4uLl0NCg0KSSdtIG5vdCBzdXJlIGhvdyB0byBzb2x2ZSB0aGlzIHlldC4u
Lg0KQ29zbWluLg0K

