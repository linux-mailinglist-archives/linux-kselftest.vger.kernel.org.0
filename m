Return-Path: <linux-kselftest+bounces-34597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EADAD3BEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA10C3A7913
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3A230D0D;
	Tue, 10 Jun 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvcaJE73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E031EE7D5;
	Tue, 10 Jun 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567449; cv=fail; b=ncg/2JpSTRqAcCF3e/SWmTUDsiYEk+Paed345ddu9NVwPdnI6j9TdKdqvGooXVCE8hmkFu8/YBC+1KYUAvI2ffmI9qXAHOeuGdXwSeoG/zLqS55QZE+1ve5asFr24BRsQSIa5hUQ5wTTYPhsiRFXWRGf7i56s+Bf2oFRHqeR78A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567449; c=relaxed/simple;
	bh=BAfddwMjvXvfujdvTo5rPGMH52Sb7KXxvaIGb3KWjFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUwXz82Z6NjTq8f073Y3fnDDAkyDt4rOqu4nAvmVIh9l5EBaApbwnnhYolK/dMKHmhDx8+osQWG06mQdqA3DI3ZNkRC98RPtWFfN0gm7+QZ6jmIB89YUWl1YpoUquFgIO+LUgA2rln/XpL8lcFa4LQVaECEOEWbneQRf3BBizVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvcaJE73; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8FSBV4hupDiFc4pqR56FDzIflWrCNRd2dz84c0F6s+I3aZAgKAVDTgNetX38Vfk9Z95HFoAjOi1W1+UH/CY4MqX3RD6SVEZ/MNUbqRximZvAXF/my7qdUQd1O6kntDlIqS7A5qdWMoukZKWb5kMQaca82uIEpj/eJI5325OOBGOuUrszv5K12Vdlp8P+ZWY3M78iXkDmypVORT5fLBIOZROhGwT2bYTMYl6LdmGzVpQNQVgoBZ5PXuYSjy32q6Y6fCkZMmuNzIsTNlcfeDrIgGuvG+yAuSsrPw8qPhKuDwYdHMk4kYXhiniglnUC52OGCbqjleswJF7GAk48oEFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAfddwMjvXvfujdvTo5rPGMH52Sb7KXxvaIGb3KWjFM=;
 b=j65gbS8zvQ0Ff03YvS/JG2ZGwwynFeKaWmlYR7v2FWHiJg4kHGveqPhiGUDPzG2RvId/gxb8HCnsXXU0Y/L7elFvPJf5w2rIui2vNV6eGdezUc9c+V9jMrvn20/waxQrhx81luHs8+yBWGW3PE1gbOTO5xtzQ6DiKNrGhWZ9bv6g2lwXGeH2tOKvfjPhs2xLPb1XXlb8MG0mbJWrhQiBfJtUzyDlbOPYZgTC9sw8l3grLILtTIpErQdgqxEs2f9Tlem86KmWsgF0UDGabnJHzjUAPQSK3UU0SZ+aRtUnlzeZNZGgE4oAlH1q/GPHPc2OHOYfGuaZKw3riZC407mH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAfddwMjvXvfujdvTo5rPGMH52Sb7KXxvaIGb3KWjFM=;
 b=YvcaJE734gVQmp1PhD0r2d23Ax+/psmnYMBWbByFEfqvHGqF1YC0RRpH09r/6oL3qHj5/P4xS85vp2fxN5gbfLBfxQTaAAuwy8Cq/IyNwuQwk7IoXofoVVm+HxDBn1TVzE3ZCweuF5UFnKL5ETtr1OJmkaNoXdLNtGph1LxhRhsQOS0SMdopZfkGgMV0S3WtfFvWTJjQZQejxz/GlhZaJ+QJUuZr+7XyY3tAJjrO2qaSz5sHbkc0muwaOcCVJ4eV5IaAU4VkzNFaPsQwhdZu4Ip62HBPHU1Lf4gEzECgg8mhR8GpUgu86hmBiKzeZsGMG5giGAZeNTM/Cus4BEOcaA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS4PR12MB9564.namprd12.prod.outlook.com
 (2603:10b6:8:27e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 14:57:25 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Tue, 10 Jun 2025
 14:57:24 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"manishc@marvell.com" <manishc@marvell.com>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>, "skalluru@marvell.com" <skalluru@marvell.com>,
	"mheib@redhat.com" <mheib@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "sriharsha.basavapatna@broadcom.com"
	<sriharsha.basavapatna@broadcom.com>, "ajit.khaparde@broadcom.com"
	<ajit.khaparde@broadcom.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "somnath.kotur@broadcom.com"
	<somnath.kotur@broadcom.com>, "ecree.xilinx@gmail.com"
	<ecree.xilinx@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "shshaikh@marvell.com" <shshaikh@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>, "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"louis.peens@corigine.com" <louis.peens@corigine.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	"linux-net-drivers@amd.com" <linux-net-drivers@amd.com>
Subject: Re: [PATCH net-next v2 1/4] udp_tunnel: remove rtnl_lock dependency
Thread-Topic: [PATCH net-next v2 1/4] udp_tunnel: remove rtnl_lock dependency
Thread-Index: AQHb2VtHS/3P9Mx0yUWnOGkydh/8srP8fTkA
Date: Tue, 10 Jun 2025 14:57:24 +0000
Message-ID: <3ba7b85cb4b57b0f6656c57971d368ebe4fd2b36.camel@nvidia.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
	 <20250609162541.1230022-2-stfomichev@gmail.com>
In-Reply-To: <20250609162541.1230022-2-stfomichev@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS4PR12MB9564:EE_
x-ms-office365-filtering-correlation-id: 07badeb5-7522-4320-9cfd-08dda82f1c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NllNVUN5RmxkdldJeXhjVE8rWmJRQ3lxUWpadFBBaXd0SjFiMDcwR0dtVjhE?=
 =?utf-8?B?RXN2OS9TRms3VEIxNytxSFBkc09RMVFZOW1MVXIzdEI1c3BMNGVLSm1RUmNB?=
 =?utf-8?B?dU5iWkpzanVOcUltOWlWcnV3VXdOVWRRdG5aTlV4S1VZNnpua2VIYXVCL251?=
 =?utf-8?B?NmRTU3pJUlJqdVp3cXVwWS8zbU82dDE2SXl1YURCSFA1a3MzeS9wSFdrR2p4?=
 =?utf-8?B?MnVjTGVEZ05oQ2Y2RlJZT2lQSlhlSDhCYmttalE4Z3Bod2I3SndTOW02cG9B?=
 =?utf-8?B?SFo2TG00T3A5SDZKMGNWc1dhVHE4T1o1cS9mN3BXOFZmK0tUNXlFU2VGdVEz?=
 =?utf-8?B?Uis1RWFrSWJndWZyQ0xrcVIxYllaczk3dkJkTHpPMDZLMTh6cjBRZVd1eW1C?=
 =?utf-8?B?bkxNdjRhbHpCTXZsazQyL0ZubDJXZHBLSFc1czNTblJBVzJSVUViUENpVXB6?=
 =?utf-8?B?Vk9tczJRaHJ4Yld3MUxteE44c1dVSkJmVmdXMHlkdDZRRGZhSk1CYzRNU2pn?=
 =?utf-8?B?ZXVneWRwZlFtbXBITWhkWEE3WlZkQzR1TnlTOUVTeTdvd1R1cGlYU0Y4SERu?=
 =?utf-8?B?K29tRUErRm94OTFSYnRhR3h1THhwSHljUThGSEdabGEzMjJQVDN4blpFREZy?=
 =?utf-8?B?RDJIdnd1azk5VmlWbWVUcmVJUzA3RTJid3FTSTdkSlZVRElHVHJSWmp3YWNy?=
 =?utf-8?B?THZqazVqWUpoQXZvYWFEVlNObmhsQmEybjJWZHZmTUJwWXV1SWJnQ0pkYyt5?=
 =?utf-8?B?a3UvbDc0V0xZc1FmcUFhRjl5Zm9ycGRPRmgrNHpGeUtGeXM5ZlZSZ29XK2hv?=
 =?utf-8?B?RG5SNzBRSXdqeGVFUXNIK0FCL053K0cwMmhydGZ3aEVCS1NZcm0wb2hSMnhp?=
 =?utf-8?B?NFlUQU5QblVQcVNmKzNOVE93OXBqdjlpMGdRekxkQjNRL0J0dkpickdydUpO?=
 =?utf-8?B?YW9lTG4zbVJBTDNrS0pYRllpNCswYTllTHhpSUszWk9IRmYyWlF1TVEvQkJa?=
 =?utf-8?B?ZitXcndGVVc4MVhRRGRaWHRFZEIrd1Z0NnZHMjZoSHRPUUlEWXVhTkRjbFlv?=
 =?utf-8?B?SmtsR3ZCelFMT3ZpMjJvU3VuMzVNVFIzVVBpT1ZoYkZWbndER1N0MStZQlVT?=
 =?utf-8?B?VURrTVZWTElidmtBcG90MlJqRkJuQmRuZS9yMExNN0UvR0F1RzNZcFR4bmZT?=
 =?utf-8?B?bFVhVjZwWVRzSC9YaWo0RUV3WUFZcmlJamN4TkcycWtaTlpwZ3hvb1ZaTWJs?=
 =?utf-8?B?K2RIR2Y1Wk1rT0tkdkVLWWVKSVltYUNsK2Q2RVllNFVqbzZaYURtUk5vYnZh?=
 =?utf-8?B?MzM2N29RTnNGb1FpTys0akNzVFUyRTkzUFZiZitWMHBpMUo5Z04rWVNqZHcw?=
 =?utf-8?B?MDlXZEFRbzhtS3ZkMHM0VkhPVXZ5cTJEZ0pQMDNscEN2T3VBRUZWb3JOQ0Q0?=
 =?utf-8?B?TFJpWFFrTW9jOWVCZkU5SmgvZ2JzQUdqQTBGbmVJOW9TaDNSYkUxRFVZTlFn?=
 =?utf-8?B?RGwxWklaajIxY3pQTHdOMUtCaGw4L0haY0dzOGJXTWczVnRZdGMxbG9aTkxO?=
 =?utf-8?B?V25kQWJNMkYyTVBoV0RnTDU3dkVZVUtucnZLT0dWOTZxMCtZTElpNlV4RkIy?=
 =?utf-8?B?UklVWjdlNG1yT3RtTFFZYlg3Q0Z1SjFPSHVWUys4dXJuK1o3YTZZaTFLRU1x?=
 =?utf-8?B?TEV1RDRHMjRaK1lUOTJIZGRkUUFBbFI0bkh5RmZManBjOEZTVkZSbUpTQmRq?=
 =?utf-8?B?eGJDNGtUM0VMdGsrS3NyZzhZdGhQcEtxeUdDdVR0Ny84TG5Fa2VZTzVpcmJS?=
 =?utf-8?B?Y3YxTWhGY1pRdGFVaVVxcnNpZURudDRzaXpyMGdFaTQ2alU1WmhRNEttdTlY?=
 =?utf-8?B?ejdQQ0pBUXpMRWtRNWRrZVUrOEFUbTNvaTB3cmZaUDd4Z1dpT2t0MXRyWU1L?=
 =?utf-8?B?NzYrYWR6MTRua2lwVmgzaGpYMEM0UFh6aTdVWS9scW1KRDdyczJZRDZadzJQ?=
 =?utf-8?B?S1krcm5GWWR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDM3aHRFVlV0dGU4SlhDdkdEMExLc3hLbDdEcDdTaEN2dW9yRzVKZ0JCZlpu?=
 =?utf-8?B?dVJGZGFyczhzZU9Dd3daMXVSU1Z6OC9QUG5LUW9XNHVoMkc0dlRxTlZESS9H?=
 =?utf-8?B?ajNHYmVkVk9rU2hiQjNQeUxoaTRxdDZ1QTh1L09hZFRFR0VOU3NLSXd6RTZP?=
 =?utf-8?B?NmU4UnhVWFREd0Y2NWwxSmV3U0dIUXc4SXhFQVhJRTFVQkNodFBYNGtJMHh5?=
 =?utf-8?B?OUVhOStSdmpMQUExSWlYR3VSOTVNVXVocVB1QzJ4UFVUd055cDJaRi9JNGgx?=
 =?utf-8?B?d1NWVnFQeTY3OHFwTTI2WC9IdTFrN3h2R2xlQmp1WnQ2SDhGejN1aDJIWXVV?=
 =?utf-8?B?bTdEYUhva0ZWcmJrQW5hY0JaSFVrYWZ4RXZrOFIyZmlIdjFDd0RLbEkrYUtT?=
 =?utf-8?B?cTQ4K2JQMFFWQ1A4MTM0WWNvaUJiKzlMcWN1UC9HTFkyM1pXenVWODBTSjNk?=
 =?utf-8?B?N3dVSEFOY3lBaklpWFNBOVRXVGQ3SWJyenZla3gzVzVVR0JLRFZ0djg0OXM5?=
 =?utf-8?B?NWF1UmNVNFkzNjNWcFUrY1NPNmJObGdCYlFOUmhsVDVmMUhLY29WSG4zR1Uz?=
 =?utf-8?B?UTBRaXNsYTQ4VW0zakJyZmNvZXNEdENPa05DaWNTNlVnMURqanA4OVlBdGxK?=
 =?utf-8?B?VHlaeW1PQjZSVFU5UitlTE5OZWRZL1BhVFhqM2ExQnVaQ1VwWktCVUx2bDNl?=
 =?utf-8?B?RlB4VjRZVC81QWtsN0pOWlZCTjZBZnpjUUxGWVJtWk9TNEJHQVUyTXNGSEZQ?=
 =?utf-8?B?dlNIZnQ0Zm1ZVk5BWHJERlFHUGR3Z0J6N1VQV3ZBa3FaTmtSZ04zNEhNWmRO?=
 =?utf-8?B?V3FPWXpFczFuRld2UEpMd1Uxd29ZVkoxbjN1Vnk0Si9ia1BSbnN6amgySnJn?=
 =?utf-8?B?WmppU3Zkd3ZWVzF5bGVPZmpHQkhuNk05QitORGNkVG1jaHgvQXo4RVRIbWF1?=
 =?utf-8?B?dTF3RU1JVU1MTnoxSUpiTzIvUlJnaHVGL2J2dVJnU0wvMHg1bnBTMWxDZ0Yx?=
 =?utf-8?B?eUVqRmJRK2FHczRYdTFOd2pCTUQyVzVYTlNnL1pPT1hnVWl6N1MyNTVYVDdN?=
 =?utf-8?B?VERiVmxMK0RHdmNkS2xPKzRQUWFhNTB4cWxrOHVDbmVuTVFYamdzRmVORlBN?=
 =?utf-8?B?dVNQOFQzcTRZTVN2VUFVUXpiWVgrN3BYb2dCM0plU2NZTm1JZUgvcncwQlRL?=
 =?utf-8?B?aHdLZEg1bzNpVjV1d25COGJKekJJdi9BNXRJR0dLYkJSN1czTGE3cEJTVWN3?=
 =?utf-8?B?QzZpRXNQUkk5NGdkT0t6ekk3WnZqT0ZvaU1jQW9iaEVBWVhKbm83SVd2T1VT?=
 =?utf-8?B?eThyOVR1R0hzeHVNQ3VoNGY3ZlJwTWUzbUxkT1hSblU3YzgrYzQwL084aml5?=
 =?utf-8?B?dUI2c1lMenJhemoyWm5ZWGNZMnFSSkNSemxrdkdDQ1prNWlYYlhaNytYRzNV?=
 =?utf-8?B?NzdoRHZNWVE4ZkhqbzhDby9mWTIyUytWSU83R2xIL0c5bXRPOGFKQlhFbENn?=
 =?utf-8?B?MCt4cnJBZHFlb2NFMWlwL3JxU251ZzRRV0xWSjVqaS9zRCs0dWgycXBZVExy?=
 =?utf-8?B?Ti9PTnRjYi9vdmVqRHMzbGpPYVBGSDdPNkpTQjMwYm1Fajk5NDRCUmNzbHFL?=
 =?utf-8?B?Vk50QkFKTFZWRFd1ckFGcWhTM1ZiQ1QyZWwxRFk1VDhrdVlBUDNPeGRqekpY?=
 =?utf-8?B?NEwvVDdFR2YxV1N2OEh5Qjhteld5eURQU1N0ek9ZNXRJM3F6KytibjJURm5q?=
 =?utf-8?B?ckJnSXV4RzduQTFXVSs2WVE4bnRRQzZrbmpKRDNVdHg1MXNkanZiTFdGdzVx?=
 =?utf-8?B?RldSc1k3T2lkVjBKaGJLU2VhMEo5Qkh6VkJnMGg5WTJ6cjJzN2VsOTZ2bHFj?=
 =?utf-8?B?Q0NvZnZFdjV4c2F5WkVxdkx4ejVrWnlGV1FPdXQ5emZZcWlEZkNGci8vZk93?=
 =?utf-8?B?Sm1YbDlaeDAwdVRvb0hvWTBXTHZNbzFrNytQOHpqWVpBblIxZ2lJWU5nWTVC?=
 =?utf-8?B?U01XYlVIWjFZcTNSZkNaWXE1MDJjeUNoZ3pTSE4zdXVWWEtjbTdYVlNsNTk4?=
 =?utf-8?B?azduUVVvM2NLcVpuMjJwbTQrN2RuR0dLSGl6STdwTnBCdjRaS2JhUkRqdlly?=
 =?utf-8?Q?666q6DkjY5uTnTl0tjLdbMxuJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E059F3564E2D459C79AC0247BD936D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07badeb5-7522-4320-9cfd-08dda82f1c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:57:24.8933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmXeGueLD+JHfleoiUTfpYp1yZZpV/GCBQ6Uug1Y1uOv1eC5g19q97mnwv7GQa3F7/R7D/KQMQUiIfd6T/67lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

T24gTW9uLCAyMDI1LTA2LTA5IGF0IDA5OjI1IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IERyaXZlcnMgdGhhdCBhcmUgdXNpbmcgb3BzIGxvY2sgYW5kIGRvbid0IGRlcGVuZCBv
biBSVE5MIGxvY2sNCj4gc3RpbGwgbmVlZCB0byBtYW5hZ2UgaXQgYmVjYXVzZSB1ZHBfdHVubmVs
J3MgUlROTCBkZXBlbmRlbmN5Lg0KPiBJbnRyb2R1Y2UgbmV3IHVkcF90dW5uZWxfbmljX2xvY2sg
YW5kIHVzZSBpdCBpbnN0ZWFkIG9mDQo+IHJ0bmxfbG9jay4gRHJvcCBub24tVURQX1RVTk5FTF9O
SUNfSU5GT19NQVlfU0xFRVAgbW9kZSBmcm9tDQo+IHVkcF90dW5uZWwgaW5mcmEgKHVkcF90dW5u
ZWxfbmljX2RldmljZV9zeW5jX3dvcmsgbmVlZHMgdG8NCj4gZ3JhYiB1ZHBfdHVubmVsX25pY19s
b2NrIG11dGV4IGFuZCBtaWdodCBzbGVlcCkuDQo+IA0KPiBDYzogTWljaGFlbCBDaGFuIDxtaWNo
YWVsLmNoYW5AYnJvYWRjb20uY29tPg0KPiBTdWdnZXN0ZWQtYnk6IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBGb21pY2hldiA8c3Rm
b21pY2hldkBnbWFpbC5jb20+DQpSZXZpZXdlZC1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZp
ZGlhLmNvbT4NCg0K

