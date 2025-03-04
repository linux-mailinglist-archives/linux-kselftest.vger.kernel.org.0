Return-Path: <linux-kselftest+bounces-28194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD84A4DA62
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50279177856
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA541FF7B0;
	Tue,  4 Mar 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oz0DMuF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406361FF614;
	Tue,  4 Mar 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083958; cv=fail; b=Y9mF48u2TizYnmQL/gQXriZGAMstJU1s9v7eY0/uYXzsUH5bZVRjkjosqBQlh//yqPEUaDAHfKpkUrXGtAT+0B4o9q9iOy2XMTkxUh4JyKjOGFRlnEGB3rvVmXc6fT1+y/TnJl5mKZ+geUP4KHKzbMikyCT/FVCpyJB/4Ij/Q1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083958; c=relaxed/simple;
	bh=VVjJpOR/9bat4V8SRMgTz8/PYiBSZr6ckjGqWB4XFlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h91cB0czP5wPtSQXo5ky/+NsRJm7Br/G67Vs3TlKhBdlLdY1WCSxPUprTL8GO5VW2zX5Jf0RhdpqUhy1Ju35eDWztmBy2B7iZrZZR1oeTKwbMluxmLd64AM1SStTbgUgXozrgFSmSZNXvWSo7F/a8YjUMnr/8vpmf/GUi4E6bGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oz0DMuF2; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVQG+nF0zcBq9eJmeRD8hg46CynKpLCALq8p3/VxCu0qg+z4coX6Iz7ewPMnvYI69L8gQeM2rvzU1fPrEAFuOVT9GR6UkOSExuMRLCHE2tkOSYgorIK+7YOt6wD12jfDo+CFmwHMtDIrk1f22CRBZl+KPGEHdZ9PMzuqGCvyd7YIiXRVq4zcAsQAKPIPmlydcl8afDDfsU4xfDV2IiRiJjn9l9rCaqA4u21MhKc/8ZkKEL3gixLplK+34vCw0GZ135f6pHgITVNU0PRaS0z3aGvPOOroMTLQAiD95CY9wBFxH7K6YmQQ/yqeIfPt6aQWeBp9PhdKGmrOqCYXpoqgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVjJpOR/9bat4V8SRMgTz8/PYiBSZr6ckjGqWB4XFlE=;
 b=TjLmlumwScl0pNrvaEURp0opet8+6KWwAiBMMXY3mAe+AebiM1jv5RJVkU4fIO6egWwbWs1N74iLU2olrOmNX7M2zNNLBG2qqsloHXRMICAvbE84+Zrfs023QDVojVKzceNhQTgp1cuh++PkN8sR+Z9gQblhgi8qfs6vcZ4zGtdnMyN9/siQbUI5G5nbbtatKWMb6ioVCD7Fqk6yr1fT6ETGgCwyDPz5AmEVN3mhPWAcs154pV5iTwfjPnOQLVIJ22X4fIQuxa9yLxWlW8c9hcdd4896RCxy9esswc/DzBzGAoIhDTOw/HhF6w5lhhycnLteG5wHFXkatU0F7UTgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVjJpOR/9bat4V8SRMgTz8/PYiBSZr6ckjGqWB4XFlE=;
 b=Oz0DMuF2dZPC6ZRYjWxZ6uoKDzUSWEehDmpuPiCt0yNzlS6QQU+BcM56KG0Z3rWBDJdu7XZKAq5Mi8wc/rILBBZUI15X7vxK6b4VRhZHzh0KsfQWxUn4GFuasgn0IImokxwCeNv97qxjIWIg3pBUpxP4YjLTFQJjrZJowYEBoDhzxUPGtmc8IPapUCVOZjkweKFDLuurtmRGmoFvRHV4IXPsQkjSYTIR4qtADnYWl0QlVzxb5Bfigrat2I07CZsNVMwwh4del4CJvMe8pz2xuSKCEcuQ1hjef/r69PFQIYcLOC7XkN4zxfS3f++hxUIYfpqIDXOQNz4gBgir+B8iag==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 10:25:53 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 10:25:53 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "liuhangbin@gmail.com" <liuhangbin@gmail.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	Jianbo Liu <jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Topic: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Thread-Index:
 AQHbiPLkayT55t/yvkep5csWYH7qZLNa102AgAAI3oCAAEMWAIAAAoiAgADW+QCAAIlUgIAGNNGAgAASzwA=
Date: Tue, 4 Mar 2025 10:25:53 +0000
Message-ID: <3a5a4d5f943a361d55f1454d2a7c3189eb398c40.camel@nvidia.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
	 <20250227083717.4307-2-liuhangbin@gmail.com>
	 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
	 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
	 <Z8Bm9i9St0zzDhRZ@fedora>
	 <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
	 <Z8EdatcTr9weRfHr@fedora>
	 <76ed1d018596b81548d095aa2d4a9b31b360479c.camel@nvidia.com>
	 <Z8bFaXOH_Iwi-Nuj@fedora>
In-Reply-To: <Z8bFaXOH_Iwi-Nuj@fedora>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CYYPR12MB8871:EE_
x-ms-office365-filtering-correlation-id: 9d800154-f9fb-4db3-c724-08dd5b06f197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE5ZNVhGWmZKS3RFUG9EMlBhNHEyYjZ6RlJ6amFuNDRJOE5NNXowRTlxU3N6?=
 =?utf-8?B?dWhtUkxsWVNUcVNobVkvOVFramw4alRJVUpPdlR2K2NyMlNNd2VQaU1XdURF?=
 =?utf-8?B?S1luV0hFRllpanNVZE1QUm51RlJjMHNFS2p2Qmo5Y2gxRkhrTXMwbDQyem9Z?=
 =?utf-8?B?UHVvbk9HMFhUVDh3NE1kZ2tyTHlQRzl3ZzNMSE9vZHcxVk4vTzVGSVN4NzhT?=
 =?utf-8?B?SVZVL2FLTXdkZ2lDaDE3UGNsYW5zTWs4KzNyaW5xTGZ6U3dSU3gyK1paQnB3?=
 =?utf-8?B?cGRWazhUN2x1QUl0STRjQTBIcUtMZ1pSU0wzVVB4UmYwYmZiakhpaldEd2tu?=
 =?utf-8?B?KzNlUVdVV29EenhoK0lUMTA2Zmh3UFIvK2RqWWVqVjlvbXpMK3lOY2xJdVpL?=
 =?utf-8?B?djhvMlR0cmhYU3VpV1RMUU9HNXpsc0ZiajdTa3R6NFJkbUs0c2cwaHQvZjR0?=
 =?utf-8?B?Nnh0dHVsWEFjcThJNEtqVjRzV09qRGxCa3B4d1lFdWRIVzNIZUR2eUsxaDhD?=
 =?utf-8?B?MFczamJacitBdmFrV1kwVU5BbUt0Q0pZeG15T21XdWJXeFN3TXo3dGQveU55?=
 =?utf-8?B?Q002cU1oRG9JOEtGM05XODJidlVhS2xHVVI0RWo5YW8zWnd1T09JUC9rZmxM?=
 =?utf-8?B?N2Y2NG54VDM4UTFyeXg1RTZLZEVJTmhiT3dOUW9zTkFKa2cxOU1VcUhxN1cx?=
 =?utf-8?B?eHZ6eS9kT2gzdy82NG02cTVJYS9aMjl2R2p2bTk1QlNTOWJ5M2gwSWl2TE91?=
 =?utf-8?B?N2Q3Nm5vWjlkcjY4L2lDN2REYjJFWWZGQU1VdCt6d0EvTTRYT3lkTno2cm9u?=
 =?utf-8?B?NkVxSFJvVy85Z0srbFpmZ0pZUjFleHYwT2pqazI0ejVENFhJTzRxK2oxRVpy?=
 =?utf-8?B?bkR2T1l2OVhNbFpRMFAwaHpuSEVWS3N4ampYMXZ0VC8vam5DVzhMd25Kc3pM?=
 =?utf-8?B?eGNlS0JmbVBzLzBadWVxS3pwNmppbDUzNzVsbUVSUk5NSXNwUm9wWTNYYW83?=
 =?utf-8?B?UUdKNmtDeFZEZ2FZTnZvT2tJQ1pTYThHS3lMK0Q5R0hibVlxWDBQdnE4R0V2?=
 =?utf-8?B?NUpXdkN5MXNTc01EWW4rNVVqdDNqZnVTNVlwZDd3d3VPS3pNeGlXZ2I0NDlh?=
 =?utf-8?B?ckhhTTQreWhXNzVnZFp2RHlqUmExWWx3ZXltUDYwL1RDbWY2dlhIRDJjdHpn?=
 =?utf-8?B?QXhTS2VsbHprSm81WFFtM0lRTVJMVkZQMnVLK3pYWU56ZWY0WkZrZnp2aFRw?=
 =?utf-8?B?S1JxMWV2UlBxOGMvZGRBOVZNZTBvN2FTZDV5c0ZRbS9JbW5rVUx0cnUxdG1a?=
 =?utf-8?B?dFp1ZUcrWmxLZjBudnRDd1MyY2E2c3hYTzNQSUVUQlFka0p3YXZvVHRudTA2?=
 =?utf-8?B?end2VERVWGZRYWc3amFrdG5VSlp5Q2E0MEpqNmhUYVg5aVFpdnNKRjlBMDVN?=
 =?utf-8?B?SjdWTUt0MnVqMmVqUnY0WnYzSXZYVmZ3T2dnSkNQVXA4TXRBKzMyOEFtV2tD?=
 =?utf-8?B?dEp5MU5qNUE2Szg0YTNGbHN4NG12KzBybUdaZlQwZjBhYVhjcEE2YWthVUph?=
 =?utf-8?B?SnVTS1NXUGhkSVpMQWJGU1JCdzRZVFJFWkNGT0hWK3JVYUdPRllUNjNSSG9v?=
 =?utf-8?B?VC9xb0lGSHYvNk5UckJNUTRmbzVQZEpaVmhMb3Y2bTRiL05Jb0FXZ3kzYm91?=
 =?utf-8?B?TStsVVdVNEdvaHB2M0g1S3A2M0UxeGVMQVExRmdhSHF2MkhaVU1QTCtjZFEy?=
 =?utf-8?B?d3h0Y3FFZGxJRVowZzRzeWllTjlrZ3ZJc0NlZkxaMVh6dy91aFVtN3NFTXFo?=
 =?utf-8?B?VjBMTmRnT2llamZHSzZwODJDNFpWZVdxRlgwQWo1UFZta3lkTWFmLzM0Y0pq?=
 =?utf-8?B?ZUY0UWprcGpPa01CTmwzZ2VlZUEwRHk3V2NpR0YwT2kxcmlYRDRROGhCUDVQ?=
 =?utf-8?Q?HXT8e0ph5eePyTH0fkHrogJzaLfmahM1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHl4dWM1eGRxbEtzMjRSSDBucCtDNFFLcVNuaGVvSS9Ud3hYNGZxSkpmSUxj?=
 =?utf-8?B?M0thV3pzakE2VFJ5TmpKZmYxRy9OMko3RzBodWVNT3FWOFM3NVFXYkt0TTJO?=
 =?utf-8?B?QkV0UFdHYzVCb21DcG83SjVLbXhaOTU4UmRSWmtUdVFJckhQOGpVVTA2dzJZ?=
 =?utf-8?B?bzdmeEREdDZIK2lDVUEyWW1TV00wU0J3MzhHSWNteHV5RUY0T3YwQWlpR0RY?=
 =?utf-8?B?R3A5V2NkZnByOVhwNWQrTjRQdTlYQm9mY0JQYXN1Q0xlckxHcmh4UXgrYk9T?=
 =?utf-8?B?QkxQN28zaTZCOVpvOFcvU3ltN1lQU0F1MS9YRDh5L1dKUWg1MjBQNiswNk5m?=
 =?utf-8?B?aGU2RnBtNFo5cldyVDZhZERIMHo3SnhKY1NSM3Nacnl0aWMwS3JxR0xIc3BM?=
 =?utf-8?B?bUlVL2lHVkJxdDVsSXpQbm4rUWtrVG5pUUY5YmhkLyt5eUlqYU9WL2tyYWM3?=
 =?utf-8?B?QlQ5RWt1a0R1UjlKTXBsQ0Z0OVRub3Z3dHVpT09CZk14MFc1c0FNdC9xZ2Z3?=
 =?utf-8?B?cGhhSDJxbE9pRUhRZjF3S3U5bDNmdXIyOTIxdnNSb1Q2Z0psMDVIMVkrejhv?=
 =?utf-8?B?NkNabGdwczk4U3I4WGlOenNwcjd6RUQ5YUJnQUdEODhtNlpsQ24rT3Y5SEZP?=
 =?utf-8?B?bTNLL3RITmlCV3pHWVlHNE5Wb1o3ck9CNU93d1JYL0c0UDVEN0N0NktWMmlN?=
 =?utf-8?B?a2c2Z3Q1ZGFMeC92QXRkZVlYd3JGMjNCTDk3OUt5OHlYdjUwRkp1MS9CRkxk?=
 =?utf-8?B?VUlHZ2czUEZQOVQySlB2UkJDald3ZEhsZXgyT2FSZGhnbDYrS3Q5ajhOQTM1?=
 =?utf-8?B?NWxWd1JzTUw5T0sxVDNLbzVIV1F6eEdlZEd1aGk1a2ppU3ZISmNGSjJvcURr?=
 =?utf-8?B?RkNRRHRCdnVzeFZ3ZjhuRGx4cndxOTdqTzM1TklnNFk2V0ZPbzNMWlZkRnY3?=
 =?utf-8?B?Z1Jkb0ZCbFdtejAwRXdqSWtudWV0cTAvSm5jTlNsQXllNWFQOTJLai8vZW1M?=
 =?utf-8?B?S3JmNnJMOUpPcFFwbzlWMVp0UVFYeHpsS3AyNVlkT1lSSXFxbWpXMCtvOStZ?=
 =?utf-8?B?SGEwZDRybDMxczVuUGg2Zjd3aWZ6cjE4dkt0b2JmbkMxTU9QODV5Rk9Wem1V?=
 =?utf-8?B?VmlkWWNLb2JYUzZscUZ4MmNDQkxabjNXeEZibmg4N1VmRWl4Skp6eUlCMnFv?=
 =?utf-8?B?QnhhT0pKU1dLMDJIQTNkNmdRdkE2YUV6S0hTZ2NWeHJPT1hjZDJXWWk3eW5K?=
 =?utf-8?B?SGRycVMrZU1NczJKS2RDYXVqMlhHWU5jaURoQUFsV1gxVHF1RElMUzQ2cGFo?=
 =?utf-8?B?TEYxVWtjTFJhYlVkZVhuYWpSZENndmtTSS9lVDVMdjljR3dEZUMrdG1Ya2tL?=
 =?utf-8?B?SFYxRWhUVGpIV1R1WEd2SWZkSm1KT1czNzR0dFJncnU4VFBxN0ZNVGxOeGtH?=
 =?utf-8?B?L0JHdjJRSldWSmR2Y2d2K1FaSDVoNDZPcTBjZ3RBN2lNakVGVGx1RStWV3Ur?=
 =?utf-8?B?YXBBdWFYMUhEc2NSNG1WT2tja3N3L0dWYXAxT3AxbEVoeEZOYW1YUm8vK0c1?=
 =?utf-8?B?Mk1vQWQ5c3FXYlNHcTM5bkc5RFIrOThrQ0pKZ2VtZVRvazBKSENTa1k2SHJq?=
 =?utf-8?B?RmNZcGNVajFGTFFoRGgrYlZMRWxraWVoUkNMMGJHaGkxOXhJL2hUejJ5N25M?=
 =?utf-8?B?Z2VYNnFQN3JYWEJRejRHTHdFdGUwWG1vdHU3Vjl6ZUFOclpoUEdZUjREaWNw?=
 =?utf-8?B?QVFrdWpUbFpnajE2YVpkbnQ5S002L0VGTGExVjloT0R1TGtMbmhWOU1WeXZB?=
 =?utf-8?B?N1ZRbDE4TlRGSkhkVWtjbUVBR2JtMmljQXN2Nk1DQ1A5ZklJUHpGVEJaQlI0?=
 =?utf-8?B?Mi82TXVVd0RiSGJqTkJVZGJsRForR1NOSDYrNTllZHJhUzljSmZTdTNxRDQ4?=
 =?utf-8?B?Nm53eTV0SGJRQkwzUlJZdG4rSTVPekdwbzJianB6SUlEdjYzQ0NnN1kzS1lY?=
 =?utf-8?B?eWU5ejZ1d1BIMlZENkd4UVZ4b1FCNHN2S1lVREhodlREOU5UbCt3WUdxVjZw?=
 =?utf-8?B?KzdRbUNZOU04c0dobW8wbXZaTXk1OXk0OWFyQnBINzVreWRRWXhvWEMzT0lQ?=
 =?utf-8?Q?3B/USAPSlr2L/8qZsKYPhkziK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09A42DF7159D774FB35216A0C12E2E6F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d800154-f9fb-4db3-c724-08dd5b06f197
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 10:25:53.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EotABhaXrmiFcJtFW/XIhN17UzNeWZxvzYCInWMA4J2MHoy81bvc4vJkpJGbCOMrqE2gHTD40Laatgw09+0zWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDA5OjE4ICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
DQo+IEp1c3QgdG8gbWFrZSBzdXJlIEkgYWRkZWQgdGhlIGxvY2sgaW4gY29ycmVjdCBwbGFjZSwg
d291bGQgeW91IHBsZWFzZQ0KPiBoZWxwDQo+IGNvbmZpcm0uDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2JvbmRpbmcv
Ym9uZF9tYWluLmMNCj4gaW5kZXggZTg1ODc4YjEyMzc2Li5jNTlhZDNhNWNmNDMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvYm9uZGluZy9ib25kX21haW4uYw0KPiBAQCAtNTM3LDE5ICs1MzcsMjUgQEAgc3RhdGljIHZv
aWQgYm9uZF9pcHNlY19hZGRfc2FfYWxsKHN0cnVjdA0KPiBib25kaW5nICpib25kKQ0KPiDCoAl9
DQo+IMKgDQo+IMKgCWxpc3RfZm9yX2VhY2hfZW50cnkoaXBzZWMsICZib25kLT5pcHNlY19saXN0
LCBsaXN0KSB7DQo+ICsJCXNwaW5fbG9ja19iaCgmaXBzZWMtPnhzLT5sb2NrKTsNCj4gwqAJCS8q
IFNraXAgZGVhZCB4ZnJtIHN0YXRlcywgdGhleSdsbCBiZSBmcmVlZCBsYXRlci4gKi8NCj4gLQkJ
aWYgKGlwc2VjLT54cy0+a20uc3RhdGUgPT0gWEZSTV9TVEFURV9ERUFEKQ0KPiArCQlpZiAoaXBz
ZWMtPnhzLT5rbS5zdGF0ZSA9PSBYRlJNX1NUQVRFX0RFQUQpIHsNCj4gKwkJCXNwaW5fdW5sb2Nr
X2JoKCZpcHNlYy0+eHMtPmxvY2spOw0KDQpJbnN0ZWFkIG9mIHVubG9ja2luZyBvbiBldmVyeSBi
cmFuY2gsIEkgcmVjb21tZW5kIGFkZGluZyBhICJuZXh0OiIgdGFnDQpiZWZvcmUgdGhlIHVubG9j
ayBhdCB0aGUgZW5kIG9mIHRoZSBsb29wIGFuZCBzd2l0Y2hpbmcgdGhlICJjb250aW51ZSINCnN0
YXRlbWVudHMgd2l0aCAiZ290byBuZXh0Ii4NCg0KPiDCoAkJCWNvbnRpbnVlOw0KPiArCQl9DQo+
IMKgDQo+IMKgCQkvKiBJZiBuZXcgc3RhdGUgaXMgYWRkZWQgYmVmb3JlIGlwc2VjX2xvY2sgYWNx
dWlyZWQNCj4gKi8NCj4gLQkJaWYgKGlwc2VjLT54cy0+eHNvLnJlYWxfZGV2ID09IHJlYWxfZGV2
KQ0KPiArCQlpZiAoaXBzZWMtPnhzLT54c28ucmVhbF9kZXYgPT0gcmVhbF9kZXYpIHsNCj4gKwkJ
CXNwaW5fdW5sb2NrX2JoKCZpcHNlYy0+eHMtPmxvY2spOw0KPiDCoAkJCWNvbnRpbnVlOw0KPiAr
CQl9DQo+IMKgDQo+IMKgCQlpcHNlYy0+eHMtPnhzby5yZWFsX2RldiA9IHJlYWxfZGV2Ow0KPiDC
oAkJaWYgKHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+eGRvX2Rldl9zdGF0ZV9hZGQoaXBzZWMtDQo+
ID54cywgTlVMTCkpIHsNCj4gwqAJCQlzbGF2ZV93YXJuKGJvbmRfZGV2LCByZWFsX2RldiwgIiVz
OiBmYWlsZWQNCj4gdG8gYWRkIFNBXG4iLCBfX2Z1bmNfXyk7DQo+IMKgCQkJaXBzZWMtPnhzLT54
c28ucmVhbF9kZXYgPSBOVUxMOw0KPiDCoAkJfQ0KDQpBZGQgdGhlICJuZXh0OiIgdGFnIGhlcmUu
DQoNCj4gKwkJc3Bpbl91bmxvY2tfYmgoJmlwc2VjLT54cy0+bG9jayk7DQo+IMKgCX0NCj4gwqBv
dXQ6DQo+IMKgCW11dGV4X3VubG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+IEBAIC02MTQsNiAr
NjIwLDcgQEAgc3RhdGljIHZvaWQgYm9uZF9pcHNlY19kZWxfc2FfYWxsKHN0cnVjdCBib25kaW5n
DQo+ICpib25kKQ0KPiDCoAkJaWYgKCFpcHNlYy0+eHMtPnhzby5yZWFsX2RldikNCj4gwqAJCQlj
b250aW51ZTsNCg0KVGhlIGFib3ZlIGlmIHNob3VsZCBiZSBpbiB0aGUgY3JpdGljYWwgc2VjdGlv
biBhcyB3ZWxsLg0KDQo+IMKgDQo+ICsJCXNwaW5fbG9ja19iaCgmaXBzZWMtPnhzLT5sb2NrKTsN
Cj4gwqAJCWlmIChpcHNlYy0+eHMtPmttLnN0YXRlID09IFhGUk1fU1RBVEVfREVBRCkgew0KPiDC
oAkJCS8qIGFscmVhZHkgZGVhZCBubyBuZWVkIHRvIGRlbGV0ZSBhZ2FpbiAqLw0KPiDCoAkJCWlm
IChpcHNlYy0+eHMtPnhzby5yZWFsX2RldiA9PSByZWFsX2RldiAmJg0KPiBAQCAtNjIxLDYgKzYy
OCw3IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QgYm9uZGluZw0K
PiAqYm9uZCkNCj4gwqAJCQkJcmVhbF9kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+eGRvX2Rldl9zdGF0
ZV9mcmVlKGlwc2VjLT54cyk7DQo+IMKgCQkJbGlzdF9kZWwoJmlwc2VjLT5saXN0KTsNCj4gwqAJ
CQlrZnJlZShpcHNlYyk7DQo+ICsJCQlzcGluX3VubG9ja19iaCgmaXBzZWMtPnhzLT5sb2NrKTsN
Cg0KQW5kIEkgcmVjb21tZW5kIHRoZSBzYW1lIHRoaW5nIHdpdGggImdvdG8gbmV4dCIgaGVyZSwg
anVtcGluZyBhdCB0aGUNCmVuZCBvZiB0aGUgbG9vcCwgYmVmb3JlIHRoZSB1bmxvY2suDQoNCj4g
wqAJCQljb250aW51ZTsNCj4gwqAJCX0NCj4gwqANCj4gQEAgLTYzNSw2ICs2NDMsNyBAQCBzdGF0
aWMgdm9pZCBib25kX2lwc2VjX2RlbF9zYV9hbGwoc3RydWN0IGJvbmRpbmcNCj4gKmJvbmQpDQo+
IMKgCQkJaWYgKHJlYWxfZGV2LT54ZnJtZGV2X29wcy0NCj4gPnhkb19kZXZfc3RhdGVfZnJlZSkN
Cj4gwqAJCQkJcmVhbF9kZXYtPnhmcm1kZXZfb3BzLQ0KPiA+eGRvX2Rldl9zdGF0ZV9mcmVlKGlw
c2VjLT54cyk7DQo+IMKgCQl9DQo+ICsJCXNwaW5fdW5sb2NrX2JoKCZpcHNlYy0+eHMtPmxvY2sp
Ow0KPiDCoAl9DQo+IMKgCW11dGV4X3VubG9jaygmYm9uZC0+aXBzZWNfbG9jayk7DQo+IMKgfQ0K
PiANCj4gVGhhbmtzDQo+IEhhbmdiaW4NCg0K

