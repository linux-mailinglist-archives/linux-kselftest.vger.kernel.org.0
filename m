Return-Path: <linux-kselftest+bounces-27613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE6A461B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0974B3B0211
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E6218AB4;
	Wed, 26 Feb 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jrIHwxAa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB42904;
	Wed, 26 Feb 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578730; cv=fail; b=GKEzxCNhnOGLP/mb6BmWOvRJsfR/fkdXAVzjoTHejAP+dlyAexjSnbzI2UuKPoXUix6AMqoB/tPM9UtpN+kUKsivuQts7f8xwJQ89XvHBOW17XIw+UuQ9uhZEutC8En8DY/yHcvOZmCV6gYi3IYqm0G1bCJ+ZtslPf2Rphx2JT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578730; c=relaxed/simple;
	bh=zpwmIojlP1TChiyxumrQ4+SOUS7yikV09HChuqfGqII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jv1B7Qz2zmrCVfLf7FXd0UtN2/NerYp53u8bc1wgUZpc8/JyjNYN2i89tx7CD6VWawfkwJgnluuzVHJ6qqx71iuNgVBvwZmhKPABhvkqkVPMeCc/87zcKbHDUHwNT4RVoYP0tQ8MJYlhoY6DgseH69vT0N9seXLHxV/e8M9BLZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jrIHwxAa; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PppXoDBRKL9RSDsBVIOZF43E85kON2hQ4sVS4fAmh3B1gBbVSDV6/YluNs+taeQhv8MlYK3VXeyx+QSZWcFpnOgIv+bJAQOxFESwnOO9VpNTdF+U8AOxklCFsp0s6/lXKFA1EPgFnXbqjTwk0e02DNJOkQG4mOwS1GJmVY1OECa3MLI1WZKYSvNjDgLDqi/onRSw8zW9GiM3vmXhhKT3XRvuHXCbNwAG8jLsKwnDRxnnawZ25/w9N3IHXmS84fghWNKatFp/CecPKVZZadJm9OoMM5e4ZBdGzQg9UBaB3rHaccr+pBjdg9wi1t6srYzEv3vXNe8f4AgJFUkUHm+VNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpwmIojlP1TChiyxumrQ4+SOUS7yikV09HChuqfGqII=;
 b=HOefOqbuqOgIeAcGmJi4Doq1PQNVaRmtGaIY3TN5ESK7zzU41/iloKny90kV5OsKMKrxHENU/LbP6o82pf5NdxxPmznlyNbtLtfi81/Janiba+26LnYd1x45q3fm+VshY2qHSC3EOfQJGYU+l+sH266/PQXYLKPuSuVl/Zf8TfS7XrFKKPxVM5WVRi3t1eu1XtNs5sHaNhAKJy7H6Ot838rysAjgkdsg9Td7injwli6d2MRetOcpua4+hx9yFFLMVtfPMt290ng/9IKekmQkOpiFs46JtVfnPjIKvRswsUzCXLMm6TijQFUmd0sp1kgwUcFuBxaXYfgP65VB10n1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpwmIojlP1TChiyxumrQ4+SOUS7yikV09HChuqfGqII=;
 b=jrIHwxAaDrUYZJRLZyspEqv5SAHheqW61YMyZ6OOBWMa2wctyNdqHyL1lQOab3xNMKgfcp3ph3OVafDWxg3hWQoBUr2yun/sywKoEJX/AGxj8um2l8TPP3EVt1lVG6XehDtSNUsOp2O/QPIR/vOWVPpaGN5F1527UqjzitGoK4mlxdxvyzTsNHVJjeuRWC9PSG9+xjvirqVmalbsRj6G6fg/CKXtXdMsNhXjzj3wLrG2YzUfr8jWc7BbVMZfxWi7+MVVdBY707SOD3Ko9nMg9GJF28JafjYhoFEm758isjWLiOPnGKNDOFBOqYv8sHKcBtMt/qBIuqM65u1S0ftZTQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Wed, 26 Feb
 2025 14:05:22 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 14:05:21 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, Jianbo
 Liu <jianbol@nvidia.com>, "jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "jv@jvosburgh.net"
	<jv@jvosburgh.net>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Topic: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Thread-Index: AQHbh2ll1/r6krzjmEu6zwJW6lI7lLNYDFAAgAFMEYCAABWRAIAAEUCAgAAg6wA=
Date: Wed, 26 Feb 2025 14:05:21 +0000
Message-ID: <f0dbb1cfdda52597b068aa785a876b48020ad975.camel@nvidia.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
	 <20250225094049.20142-2-liuhangbin@gmail.com>
	 <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
	 <Z77jc8AB3D2xWczl@fedora>
	 <0605dc53cdcee5ea71b89114f2318dd5d0a83276.camel@nvidia.com>
	 <Z78EA2LEuFAwufNJ@fedora>
In-Reply-To: <Z78EA2LEuFAwufNJ@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MW4PR12MB6897:EE_
x-ms-office365-filtering-correlation-id: 04cf69d3-78c4-4c6b-dd08-08dd566e9be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enNBNFZDR0pZZlJudlBrN2pIeENWU2x0ZjhuS2JZZWFHd201d2VFVjkyOC93?=
 =?utf-8?B?UWdnUkU3MDZFdXROVVdZa1I0dFpoNkk5aUlZcTRhazhsTmk5cGtmTnNyVGlX?=
 =?utf-8?B?K2ZNbDNSRzQ2SjJlNVlHVjR3UDVNVTFzKzhhSUlhUzFLOGdCZ3BvTDV6ZDBm?=
 =?utf-8?B?SFBhTXJqd3F3aUYrVDBIWFpJMzFlN2l4QXdiMytRK1NCQ0RnTjVSdlE1bGtQ?=
 =?utf-8?B?cG9DdG5MOEN2cXJ3a1FINUEvNkRnWXBKSUloOTFtajlSU3VzYjhmZ3pOcEVk?=
 =?utf-8?B?STdvbzJZb0xlRUtxMzVDeU44Z3FVVHppVHpIOXV0TDZQay93QU1KTTRiZzAx?=
 =?utf-8?B?Z3d1NHh6T0JodlM2SlZ2T3J6dFBsZUI1ZnpUcUp5NFkzaGY0aEZFQlRqbmlm?=
 =?utf-8?B?NXpCQ0p4UGMwNC9GSGJrYmljZlFlL1RtWjdFUkpjTkRWdGhXZjJYRXFyMDBi?=
 =?utf-8?B?WFFvMjZTNHhra3RRRHMzQ244NDNwbHNXbm5aL2w5VG1OZU0zbStIU003Yis2?=
 =?utf-8?B?VXpUbUpIL2MxR25hZmRtSWlycGpFMEs4dVZ4T1RNRTJpQ09uTUcreVhNdk9N?=
 =?utf-8?B?YUlZbk02a0c0M3VhRHNkSzJZV0N4TnEyckxPNlZMelRlb3k0amQ0Y0huTUpa?=
 =?utf-8?B?ZnB0WWp5ankvcyswUGNkZnl0REhIeHIyNVlPL1BvZExabzFmY1dFWXg5c1VQ?=
 =?utf-8?B?UkhDRXNRQnpKTFlaRzhGMS9tQ1lpSk5QNjNveVU1UHRQUGRYcXRudVY3T3pr?=
 =?utf-8?B?VDZrdlhuckNldlBKbnRxWGpBdllNVk91ekpTVlZUayt2M05GVjlMTWVFbk5M?=
 =?utf-8?B?YXMrTnpoVUxRTEZRS3MrUTVpb0x2RkNaRzdaR0RZWHhGOFFqRlFsMUhzMTRz?=
 =?utf-8?B?UWtZalNRV2RvNU12STRzUTJlUng1ckxPMVcwZEZ3c1ljSDJZZ2lVclhXeTAr?=
 =?utf-8?B?bm80ajVYZnNUWlpCZGp4Um5XZG5mS2VQaXVlTURWTUFNMEk5UVVuQUxXSWFu?=
 =?utf-8?B?T2grYzh0OTVFQVdEbXE4a1AyU2lsc2hTSmJZOXJIRW9xcS8wbVlPdXZ2UVlO?=
 =?utf-8?B?RGt2dnJicHJzRXNxUmdmS3p2NjVCcDE5d2Z2bHg2Rk1XUmFOeC91WFJSY2gx?=
 =?utf-8?B?UmFWbUNMeHh4SVRrcGpKUzYvdHVUaEFlejd6ZXorclRWd3ZpM2FhdmpJZnhr?=
 =?utf-8?B?N0dDRnorNnJnUTgxRkNsOHN2SUJGNXRnMDNhOHJoNXk4RkV6aVhtZTNvdTU1?=
 =?utf-8?B?elI0WmFORGpNVmNIOGZIWjdqdGhrT0N1N1BYTGVoYXp1bjE4b0lBSElSTGxq?=
 =?utf-8?B?ZC84endTeFBLSlErMzlvRUs4c0t2bzNNWFNuZHhGOExFcWorcEF1YmxoZHZs?=
 =?utf-8?B?NXhsamF5NnVUZFlrTXhJVFJpQkFLOENCYUI1d0RBdVUveTJaRU9EbW1kVml5?=
 =?utf-8?B?OEJ5bnowU2txZUpqOHphbDFHWDNMdjVZU3JMc1Iwd3VOOUhxSkZrOE1Nam1E?=
 =?utf-8?B?U3BJUHNUMUZqYzRPUUMzc2ErcXZqYzBoSTJtQ0JLTE9scWV5RjRaQ0YyQXpI?=
 =?utf-8?B?VWM3ajM2aksrVTFvWWpydGMxSUFBVGdwbnBLVnZPVGsrUXBBV2lxMmc2dVZ3?=
 =?utf-8?B?WlRCVG45QmFxNzBqNEMwZExTTjN1Z3F0eDB3cXE5UjZreXRyckRCMTVmRGJq?=
 =?utf-8?B?by83Z0h1L3pOK3Uxc0hkeDZKS0QzWDV6VGtvTElLcllsZy9tWklVc2J0NktU?=
 =?utf-8?B?cHRzWjN5MGxvS3V2RWNWajVDQ1lUdzV0bDRZUlg0S2RWczRyUHJVOXJ0eVQv?=
 =?utf-8?B?R01RZEVEWVpxSXdxU21hWUpzUmJhU2ZRYWtiSlpQbGdjSFh5ZzRYblRnSUJD?=
 =?utf-8?B?MFh6WWtPR0p1SmFWNm1SdU95ZE9WNVo3SVhsVkFnNzQ4M2FVOHdDVnM0OGxB?=
 =?utf-8?Q?Ko7YHYEtreI8yw9dfHRKC9rvAozV2GrG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmszS1pRR0VNamF2MHZqMDhhNkZEUHBIU1FaYm9ITFowOHFLK3FSVmM4WndT?=
 =?utf-8?B?bFVlWjJJVE1JZnVVN2JBMjRuTE40NXQzRDZZY3FDeEpvbDlCQ2c0NldNYjIx?=
 =?utf-8?B?SFJFb2hMR2ZPRjdyNEpnNUhBd3Voc3ZSSlVkSTkwdklrKzg3VUFVdk04UUJL?=
 =?utf-8?B?Rm02Wm1VcDVwVVoweCsvOG54VTJMQWRDZnhvYWIxVGlKZXQrRzN4MU0yWHR3?=
 =?utf-8?B?eFZuK2hPV0N6cVF4cHE5WVJzOFlHMmpQL3JJWkdLR3h3VllPNjUwYVQrS2hE?=
 =?utf-8?B?TnFoREtaNGdGTmxSNXpWdWkxbFZ6dnRBMVdPeTV3OVcxMWtEbEtBWXdzNC91?=
 =?utf-8?B?RmNIYzNxQ1RIcVhkbVk2Z1N6dlNSNVhTa21OTDVTaUIwWERnR0tqZ0VJZEZL?=
 =?utf-8?B?Mmd1d1g3RlFZSVdXRzRGZUU2ZFppUGRmS2FXVm9sS3ZhWUJScVFPRHRCcnJZ?=
 =?utf-8?B?ZHgrMFl3OE9LUENLQXFIZzVxTEgwVFJqWllVWmZwK3laU1NXblV4eVBFSE5N?=
 =?utf-8?B?YmJQWWVPSU5uZGVLcTdsN2dYd3h1SURIRGh3MWNjS0pSZWRyTFM1NFFkVTJO?=
 =?utf-8?B?Y0NiK081c3MxTzR1RnBWWi82QXB3eVEva1NnNzVuUnFWekNBdUJwd3FkK3lM?=
 =?utf-8?B?N0orc0ZnKy80aW5hT2pCaVdJanJ0em9WblpTRFZuVmlzSmJoMWt4a0FhOUgy?=
 =?utf-8?B?K2JJK0hmSjZTc3BQN0tqdmUyMmhCR2tEdm1uTm9QL2tCaHg2b2JPRlN1eUJo?=
 =?utf-8?B?c0I5L1ErNUNQeFRJRkphWVlOWHlIVG1pczNBTmd5S3BIdy9PTHVYajUwejNw?=
 =?utf-8?B?aEhROXJrdzBPRTQxT05VNDF2WUpYOThFLzIvMzJnWk1va0YzZjJTaWptOTFY?=
 =?utf-8?B?RmY0eExheG9ocHRXQ1FoRFJxK2ZmSnFCL1JNRFBjU0c4VEpXb0xpd3JLQXpx?=
 =?utf-8?B?bW1OdlJhVURLSmx4akt4ZFZpakt2VlNWWldId280cmllSUR1c21kRHN4Y1hr?=
 =?utf-8?B?NFlBSkFkcWFqc2ZFbGF3MG1wS1BhSjFHKzBrNXU2eEkzN3prbjhFT1JuL2Qx?=
 =?utf-8?B?NVBMUEpvZGI1dUxsVURQUzRSbW92RWsyQVF2NmI4QnFyNThDbXdNQVE3amJ0?=
 =?utf-8?B?U2I5MnpYdjNCazBNSWRBbXZYRndXTEVMQzRYSUFLclFHcWk5V3EzdzVQd1VH?=
 =?utf-8?B?V3k1ajkwZVZHeHB4MlBjYk5RUVc0SERyK0pCM0t1RjR6NTk0cnlOU3dKbDQr?=
 =?utf-8?B?b3FveWxMcUVKSm9wTXplLzBOZ3lsNGxLeHdFUTV0YlZ1T2tCMHJFNWU3NWdV?=
 =?utf-8?B?OHZZL092TG1ucW5kRmtQUTV3eVE1VlNTMXdzc0RaZjZreEQrcWdDSy9BNGtJ?=
 =?utf-8?B?RVU2N1FhWmJMZ21jeXZsWTZFd2NBUTEwbktmSmhkN0RSMHEyczc3Y2FnZXc2?=
 =?utf-8?B?anQ2VmJNS2tPZmN1L3hrR2JidmZaajlSMURPN2MrNS9TUlZ6U1RGVnMxNFBj?=
 =?utf-8?B?cGxZK3JvRkFGUHd4NTVFdWlYV29TZ09mdzdiQWs4TnZjSEMxbDgyaERQSzln?=
 =?utf-8?B?dGR4UGx0dHNzMTZ3WVhSSXIyNHgyWjBqdHBsaDM3VEhZdW8zTTN1bjRkcXNS?=
 =?utf-8?B?NTd3OXJ1Q1ZiazlzRFdoMnU3UkNEcjFCeUpzNU5SaXZFOFBablFZVjdoN0xK?=
 =?utf-8?B?Y21UTW5NWWpjaTY4STMzU0k4TWpJRTFNSUZ5RGJRZnR6WVRXeXNVQUw5Q3lN?=
 =?utf-8?B?YzlkSmJhWVcxbVlLK2xZOE50S1lzVXB3TDFrLzBDVzRzcVpFdjR6QTcrbVF2?=
 =?utf-8?B?QlBsUGZXYXJIUExZbXVVbU4vd2RlOGE4Znp6cDNoVEdKRkdLOWsvS00vd2Nq?=
 =?utf-8?B?aDZINzJRdzU4cGxzTkVWcWNOUWZhb2FrZXZZTEdrNDFVTW5VOXQvNVZ1Mkdk?=
 =?utf-8?B?ODMxVVNZZmpKVVp1dTNiZ3BLSXlzNWRid21EVmRFekFJbE4vdHllMUU1eWkz?=
 =?utf-8?B?SXZXQW9ScVVKVWVSSmtLOU9PMStMZ1dEN2xaRDdxeG45Y3EvOXNBcU95dGJ2?=
 =?utf-8?B?MlFtRlZiajF2NzNHUzdnRERzZU0wNWordURsTmd5N1lhUTZpZ1VhNkpRam1E?=
 =?utf-8?Q?NVk+o9BZ6Qp1YGRtC/tpXvtwi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09B226F25691494F87685453292B0194@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cf69d3-78c4-4c6b-dd08-08dd566e9be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 14:05:21.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyzHGVMqsb10RRRkA6qgZWNR9jf47GEhXcEz+4UlUJAoan/veJXVMbxsPL3YcMsCVYT3a0rn3avgSbtvXRETsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

T24gV2VkLCAyMDI1LTAyLTI2IGF0IDEyOjA3ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
DQo+IER1cmluZyBib25kaW5nIHRlc3RpbmcsIHdlIGFsc28gZm91bmQgYSBjYXNlIHRoYXQgd291
bGQgdHJpZ2dlcg0KPiB0aGUgV0FSTl9PTih4cy0+eHNvLnJlYWxfZGV2ICE9IHJlYWxfZGV2KS4N
Cj4gDQo+IElmIHdlIGNyZWF0ZSBhY3RpdmUtYmFja3VwIG1vZGUgYm9uZGluZyBhbmQgY3JlYXRl
IGlwc2VjIHR1bm5lbCBvdmVyDQo+IGJvbmRpbmcgZGV2aWNlLCB0aGVuIHJlbW92ZSBib25kaW5n
IGRldmljZS4gVGhlcmUgaXMgYSBwb3NzaWJpbGl0eQ0KPiB0aGF0DQo+IHRoZSBib25kIGNhbGwg
Ym9uZF9pcHNlY19kZWxfc2FfYWxsKCkgdG8gZGVsZXRlIHRoZSBpcHNlYyBzdGF0ZQ0KPiBmaXJz
dCwNCj4gdGhlbiBjaGFuZ2UgYWN0aXZlIHNsYXZlIHRvIGFub3RoZXIgaW50ZXJmYWNlLg0KPiAN
Cj4gQXQgdGhlIHNhbWUgdGltZSwgaXBzZWMgZ2Mgd2FzIGNhbGxlZCBhbmQgdGhlbiBib25kX2lw
c2VjX2ZyZWVfc2EoKS4NCj4gVGhpcyB3aWxsIGNhdXNlIHRoZSB4cy0+eHNvLnJlYWxfZGV2ICE9
IGFjdGl2ZV9zbGF2ZSBhcyB0aGUgZmFpbG92ZXINCj4gdHJpZ2dlcmVkLiBUaGUgY2FsbCB0cmFj
ZXMgbG9va3MgbGlrZToNCj4gWy4uXQ0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIGFub3RoZXIgc2l0
dWF0aW9uIHRoYXQgY291bGQgbm90IHNpbXBseSBmaXQNCj4gMy4gImlmICh4cy0+eHNvLnJlYWxf
ZGV2ICE9IHJlYWxfZGV2KSwgZ290byBvdXQuDQo+IEknbSBub3Qgc3VyZSB3aGF0J3MgdGhlIHhz
LT5rbS5zdGF0ZSBzaG91bGQgYmUgZHVyaW5nDQo+IHhmcm1fc3RhdGVfZ2NfdGFzaygpLg0KPiBJ
cyBpdCBhbHNvIHNldCB0byBYRlJNX1NUQVRFX0RFQUQsIGJlY2F1c2UgSSBkaWRuJ3Qgc2VlIGl0
Lg0KDQpYRlJNX1NUQVRFX0RFQUQgaXMgc2V0IGluIF9feGZybV9zdGF0ZV9kZWxldGUoKSAoYW5k
IG90aGVyIHBsYWNlcyBmb3INCndoYXQgc2VlbXMgbGlrZSBlcnJvciBjb25kaXRpb25zKSwgcGx1
cyB0aGVyZSdzIGEgV0FSTl9PTih4LT5rbS5zdGF0ZQ0KIT0gWEZSTV9TVEFURV9ERUFEKSBpbiBf
X3hmcm1fc3RhdGVfZGVzdHJveSgpLiBUaGlzIGxhc3QgZnVuY3Rpb24gaXMNCnRoZSBtYWluIHdh
eSB4ZnJtIHN0YXRlcyBhcmUgZGVzdHJveWVkLCBiZXNpZGVzIHhmcm1fZGV2X3N0YXRlX2ZsdXNo
DQphbmQgeGZybV9zdGF0ZV9maW5kICh3aGVyZSB4ZnJtX3N0YXRlX2RlbGV0ZSArIHhmcm1fZGV2
X3N0YXRlX2ZyZWUgYXJlDQp1c2VkIGRpcmVjdGx5KS4NClNvIEkgYW0gcHJldHR5IHN1cmUgdGhh
dCB3aGVuIGJvbmQgLnhkb19kZXZfc3RhdGVfZnJlZSgpIGlzIGNhbGxlZCB2aWENCmVpdGhlciBv
bmUgb2YgdGhlIGFib3ZlIHRocmVlIG1lY2hhbmlzbXMsIHRoZSBzdGF0ZSBzaG91bGQgYmUNClhG
Uk1fU1RBVEVfREVBRC4gQnV0IG1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZy4NCg0KPiANCj4g
RXNwZWNpYWxseSBpZiB0aGUgYm9uZCBjaGFuZ2UgYWN0aXZlIHNsYXZlIGFuZCB4ZnJtX3N0YXRl
X2djX3Rhc2soKQ0KPiBydW4NCj4gaW4gcGFyYWxsZWwsIGxpa2UNCj4gDQo+IMKgIGJvbmRfaXBz
ZWNfZGVsX3NhX2FsbCgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZnJtX3N0YXRlX2djX3Rhc2soKQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgeGZybV9kZXZfc3RhdGVfZnJlZSgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib25kX2lwc2VjX2ZyZWVf
c2EoKQ0KPiDCoCBib25kX2lwc2VjX2FkZF9zYV9hbGwoKQ0KPiANCj4gSWYgdGhlIHhzLT5rbS5z
dGF0ZSBpcyBub3QgWEZSTV9TVEFURV9ERUFELiBIb3cgdG8gYXZvaWQgdGhlDQo+IFdBUk5fT04o
eHMtPnhzby5yZWFsX2RldiAhPSByZWFsX2RldikgaW4gYm9uZF9pcHNlY19mcmVlX3NhKCkNCj4g
YW5kIGhvdyB0byBtYWtlIGJvbmRfaXBzZWNfYWRkX3NhX2FsbCgpIG5vdCBhZGRlZCB0aGUgZW50
cnkgYWdhaW4uDQoNCkkgYW0gcHJvcG9zaW5nIHlvdSBjaGFuZ2UgdGhpcyBXQVJOX09OIHRvIGFu
IGlmLCBhdm9pZCBjYWxsaW5nDQp4ZG9fZGV2X3N0YXRlX2ZyZWUgb24gcmVhbF9kZXYgaW4gdGhh
dCBjYXNlIGFuZCBqdXN0IHJlbW92ZSB0aGUgZW50cnkNCmZyb20gYm9uZC0+aXBzZWMuDQoNCkNv
c21pbi4NCg==

