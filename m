Return-Path: <linux-kselftest+bounces-48393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40796CFD738
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE1D30133B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF930497C;
	Wed,  7 Jan 2026 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWiyY8bg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BD2FC890;
	Wed,  7 Jan 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786264; cv=fail; b=GCcM2YLjPcEjV2pdhMGApiHygjjLuyA1W27DU4KQOKjMPS/WeHTwWPHPJpRphwT97MW0oBXx1Xi6MQO8mvQmwCKYD5ITUWRrOaIMYtkEyQkAHUIlSfHBwLrSaSpAsDLMYGoUO51bbuHSDRVkNuxJlOXO4MuQNscqu+btQi7WtXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786264; c=relaxed/simple;
	bh=/Ich3921uQhQM/r/0ygBPlr+pv/i/syPBM1v6VCmuBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VxHtTOhSI3Xave6oLxeBrdpkLIq2hPO1J+LVFzeOdYLXUapED7LF8rKbkIakVbzbYE2QDnQ1+xdb+L0Vfl2E5fUOaDH7c9/EzCADewZnDcL/7bDicg/QTj6teR/eNLniU7qEqu9DhT2MEMyynnIW6khZC2F8Efcyby4WDBOfGss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWiyY8bg; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVPHUKAeD3XIb70L6leoe83V57WwAVGhbttIonJy6cyyZ5BlhiaWdDH8GXmLqcnhpzTQsWayNFXQFlI/L/8GkKmOLgcclKef4cldOeapm/oEUNv9C1d/B+QZqCc+/Jfzd5ojzIKq7+nT6vProAKWf7cfUdxLJEhk32+YNoaxJlVGSziLQVLyy/GwdqOUctGKdb96nMrnQ4NwcYYQHUOrLO7IfzCeHaA9q2JFooz2enJq71dE9gcw65p04ou4mgUKJN71fZhkC4FvCb718WDcsgkJhFkat9KV7riifBgP6UM/AyfE0C93vpO2FBz2ab5tDM84wGY2MEk7IAuyVnXHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ich3921uQhQM/r/0ygBPlr+pv/i/syPBM1v6VCmuBY=;
 b=BeuTlGwSTnCWlOvwWE4m3Xzw1lt4yM/VDOClzWAdvxhw30ub30hAKQLrDx7pTxySGl4h4aINdQ2tEWsAEjZQFGeizjhQN064zIOtQmSlD1s13G60XuDEC0cqw09cJTjbW79Mc6O6sV+3NxrGdRu7X3QllCWg8A/4Koohp2K0FIFDk9xKUj3IzLPe+Y8wGA1KFPad0HE7NupX8oR0t6q5yXUwXe6pAb1vGmDUnH4Rov651092hPI1hayCSrT5GiEhr2IDbQGQbj61Hla7cAt++dLIPCylDCz1VgK4g29dZh0QdCekM/OnpJqTHpvE46Zs1+but41MnMDild0Fl4TlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ich3921uQhQM/r/0ygBPlr+pv/i/syPBM1v6VCmuBY=;
 b=hWiyY8bgi0qw8zCpeiZRV/FKWgeDHqOHEj/OT+KlRN+rGES0Pn4wjA3BWkcgXT736D9+d1gDHmKUVET3N95BcSHxRy/Gt8QOE8zeyBlbkBShWwSSIkP3hYg0iTgkWX/NzSq3yJpV88VDV/SFj6Hp3CYj1FqN97F/lc/bm4dohINEm8mCXuJyf5OW20weyVTHLzhuyGhnUJnhjKRWyce+x3Dn+MPUAsAlU3jz8TZ5HzJIrGSNBzpwS7uDb2meF6cVD3XCUyhkBvaEleN/dNjfNAuhRPLSGAN/rd3gmDbZ5mcREGrji1GOUuZyCUay/YW4jjxWn+MfU35Jrx/udjBkVQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DM4PR12MB5914.namprd12.prod.outlook.com
 (2603:10b6:8:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 11:44:18 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 11:44:18 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: psp: Use first device
 when multiple are present
Thread-Topic: [PATCH net-next 1/2] selftests: drv-net: psp: Use first device
 when multiple are present
Thread-Index: AQHcfirNl7/sgoLShUixTTfHbEXbTrVEX7gAgAI52oA=
Date: Wed, 7 Jan 2026 11:44:17 +0000
Message-ID: <8fe057c5095176f7d188c8c5633b7b7b1a80e22f.camel@nvidia.com>
References: <20260105100424.2626542-1-cratiu@nvidia.com>
	 <20260105100424.2626542-2-cratiu@nvidia.com>
	 <20260105174442.055a67c5@kernel.org>
In-Reply-To: <20260105174442.055a67c5@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DM4PR12MB5914:EE_
x-ms-office365-filtering-correlation-id: 1558c06a-8bf5-4bf3-3c45-08de4de21747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aERLT2FOblZ4Slh2SkU1T0t1VThZL2NudndlRkR3U09HYTdMb04vTTAyck0x?=
 =?utf-8?B?ZjJwWW5YeUJtc2VJUVAxeEs1VkticzZjbVk0YmpmL1Z0SlVPSmFIaFpvbEk5?=
 =?utf-8?B?QlZUTkZvbE9QcE9XQUdaM2hBdnpQVHVacFEzbjdhQUJ5NHdWcGZvdVMvQ3VR?=
 =?utf-8?B?bnJFa1JKbHdTQkNIaFQyWjB5a1E3OVFWejkvalNnQ09XRnJDaGI5bGEwWnYy?=
 =?utf-8?B?N3FReldCbkJ0TCs3RU5SWktpYVFoQ2VuSksrdDRFUmx5UnhLM2drWGJTZjI3?=
 =?utf-8?B?K0NubVJJbUVKT0cyODZVenVwUVRDTElTRVBFMFpWZ0dnYSs4RC9lT1hzdGdG?=
 =?utf-8?B?QXVqeVhPdkE0Mm1LOGxld2hjdS83aFFNb0xOWEtYWWNkVSt2cEZiaGxxcUww?=
 =?utf-8?B?T2kvT3VCRUdib05UTXJlMTZhd2dQVXc0eVQyMDl2VDM4NlNhZG1yT0dhOXAw?=
 =?utf-8?B?Nk9nVVgwYVNvNENLc1IzclNrOVZwQWE3UUdmd2kwUTFGamcyYkdOR0lvbWFU?=
 =?utf-8?B?WmpTcUlmVHJhVmpOcytwQ3JYR0xZbVN2WVVyeTF1QlEyaThkYXFzMDdwem12?=
 =?utf-8?B?eVcyZmQwdlBMa3hHTml5dUlqamYzVFE0SXBvTUxBSlNNWFlYaTJmd1VkMjc1?=
 =?utf-8?B?RklCdFNmWC9zRUFZMXNaN2xiNmNydG5zb3pOM0lVRGpYWExPVUN3Mmc3RVJz?=
 =?utf-8?B?S1Y3RDM4SjcxTEhwakpSQzY5N0ZTSXpVZENESE9RZlRPa0pZeVBmdGp2dzIx?=
 =?utf-8?B?ays3Q1lwdW9sNEt2MWhBMGV0MkZEeTA1U2VUOGNsS3U4TlE1N0NKbTVjTHlQ?=
 =?utf-8?B?ZnJNVW1UK1MrNDJmTWdUQWkwMnNhVU9sR25BeGRmaCs5ZkJ0K1ZzZTFYalpq?=
 =?utf-8?B?bEtkNUtXWTU3ZWlVT0wrZmtwYTdOT1hwOGQySGQ1ZGozdGNZajEzZ2tueUNr?=
 =?utf-8?B?dGJ0djBFbFpMSkRkbkxXc0pTS3Jmb0NQZUJqYi8xeWpuNGxoajVremd5aWxm?=
 =?utf-8?B?QjR3aXoxVXlsTURaSm5UdWhtYzBwa214NEcvR056ZnlmMGliWHVObjFKZk11?=
 =?utf-8?B?V1I4Y2NhZTlacXo5ZW1nOHBLVi9DNHUzMVhjdG84Y0Q4c3h4VGtpc0NxOW51?=
 =?utf-8?B?RjhVOURFMGRzVXI3RTNmR2dHcFhKUDJDUDJJWUNmU0p0eXpWTFEvSi9FeU05?=
 =?utf-8?B?TGdqQStKRjIxSHFoSW84VDFMeDFEYlFCdVRFKzVFdGxqNmtoTUVuOE5kMzZG?=
 =?utf-8?B?YWwxMnlkUHpTZ2t6ODJ3QXd2NnVRcXR3dnhPWmwyMXlJUXpPNzVXeXBUdjlH?=
 =?utf-8?B?T3ZQZmdESW94NGdPbDV4S0R6UGJTZVZzdWNPQ1RhWlVaOUxTRDZsdmdwQzI2?=
 =?utf-8?B?Q0FWVmxwUVhGSlFweTgxbEIrVFVTbm9nNFhkZW5mU0d3VzFVNnJnNWpLVDYr?=
 =?utf-8?B?bHRxR2Z3RG1uOGxROW5UMTFjWXhmaHZ0b09LRnhzcFplZjlyMnF3RXhmK3c3?=
 =?utf-8?B?Ykw1aDVYc044QUE1OFJ3clpKMFp4amV4b0ZqYVV4MmswTDdZSXRiUEVhMTFP?=
 =?utf-8?B?L1RFZThscFNteDdPSTJFa3pSL3hReVJxcWN1cEIyVlhTRnplVEJIb0prSlMv?=
 =?utf-8?B?ZktwN1JpMkx0RVNDZ3pqSzRCLzdaNm1Ub1Z5MWRNZXMxb3RBSnJJSWROUVRw?=
 =?utf-8?B?WGU1dzg5WE11cEpkZUFqaHQxVGFEZTRhK1c4ZUY0R2NhL0FVdTFXTmVRdWdr?=
 =?utf-8?B?RWlHcGxqVUJHZW0xQTY0SmZVYmtGZE13cVRVRlVIR1hsWjlISmtGekdYcVZT?=
 =?utf-8?B?VzlxdmFJWmNGNUV5NkVxdUtHNkdkUXJpbVN3bEhMRG0rcXpld25waGFhOCtY?=
 =?utf-8?B?bjBmNWxlSkcxdkpicUxYM0Z3NXZqYzR5SFNLNGl2a3Vpelp3aUFkampqdU0v?=
 =?utf-8?B?Y1IxVU8vYVJzMjRoR0U2SlBkTzE0V2dma1Rxc1QyRUEzbFFYRXplSTIwdVVP?=
 =?utf-8?B?UEdLUnhWai9rbU9vcVVicEsrY1NsZi9aY3g5QVpNTzFCQ05xT202YjFsZXhU?=
 =?utf-8?Q?quOnQC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3RPT3lNK3VCN0FSQXl2TFA4TWl4OFdzUHB6bk0vQ0ROeDZjREcvbmRPd0My?=
 =?utf-8?B?bEhzeVRjYWtRbGM5bDVlWDFXZUZ3U3RJT3ZUV0RpTjM2S2ZrUzVPVDNXYnRo?=
 =?utf-8?B?ZFRrMFRvbW9lMEFpY0VzcDhjZnp0Qng1dEpDTHJ1dm1IajJLYkFMTkdaU1p4?=
 =?utf-8?B?aVlNVUpEVWg2UmZNbjBRYVhkcjhrN0pCMWlEZE5zODZLNEhWRVZjYVJiL1FP?=
 =?utf-8?B?ZXlyU29ocmZYN25lTmVTZkFFUnFEWG16MEljaFU4aWN3dHVibFp1cTUrSGZv?=
 =?utf-8?B?Z2t0MHJsTnMzZ3dFdGo0ZVJWT1lzTXZCLzVKV01makV0VmowZmFNcGlybWwy?=
 =?utf-8?B?U3A2RWxQU0tScVFHNjJQNWRvbTZVR01OMUpXdjE5Q3VhS0Jqd3MvS0srSVZM?=
 =?utf-8?B?eE1JVkVXV3UzZmhPSk1xTDVLZFFoYkh5ZGRGZ0Uzam56UTdqMTJPU1MwVEhR?=
 =?utf-8?B?eFY2VDFQT3E2MTh2YURhbGFDdG1ZREg5bmlzU2w1bWEwNlpENk5LSm1PbjVM?=
 =?utf-8?B?VWNIcjhLRkVWcTkraFlJUnFyb2pwWXp5bFo2ZVB4TU9zb3I2NVdkTHlhV1ho?=
 =?utf-8?B?MTIrV2NQVDNIVUphNTdvRlhQMjUrZkZhM1RxbjRSTXd4RGg1Y0dPZUFDY0tz?=
 =?utf-8?B?ekJyZFZJM0NpeXEzVHdZdmh3UDNkQjBFN0FZMUU1VGVaSktIK0h3eXB4azFN?=
 =?utf-8?B?cU9BNFJjenlTWUtRdE4rT0ZCSE13VUR5N1haSFRteHZXMm15czkwcUNSZWln?=
 =?utf-8?B?bWw4MHROeWcycnlhMENjSk5LSk4xeVdKZkJ1b3lqTXdEODJsa0Y2UVk5UW4w?=
 =?utf-8?B?WVMzRVVPeFppOFJjWWJtNjgyMjV1OFRvMEhWcnVaTFFtUFdOOERoUDI3SFFB?=
 =?utf-8?B?c2dkYXJaaHdJZDYxVGRnN3JyczJadk1ESEJNZHpZdjVKbkVpbXVia2xTbnhi?=
 =?utf-8?B?a21CNDBsMHMrNVBCNlpnYnhGV2lUVkFXVXdlWmdhanIzMXRDYzJLSXVUMlRO?=
 =?utf-8?B?Q2o3aHVUOFA1Uk5QR2RFaFNQeTdWYlRVOU40cStrUlpNZUJGaHFDSUt4Qnl6?=
 =?utf-8?B?Q0RtMjlueHZIdTZaQmpaOVF0TlozSGtydFY0NmszYkVkVHljbmhmMzh2ZW9h?=
 =?utf-8?B?NWhRZDNuNkFCbGI4UnFodE1PQTdvRHRqYmFRZ0IrZUwzbHcrMDJBY3IrV0Iv?=
 =?utf-8?B?RTNGd2RpYkpEVTBETjhaM1JVaGRER1czL3BtNkZDMDN2K0k1Q01YRDNwdERO?=
 =?utf-8?B?eUJGSW55bzVMbTBCRG5kMTd6dWFwcHhTR2FpQy9HMkdhRXVFem5GdFdjcmlm?=
 =?utf-8?B?UUpYUGlLSEJFVHI4Y0NBL0ZBUklwdWNLWGFSNVpWYmN0V0dncjkvK0dOaVNN?=
 =?utf-8?B?UURMWjB0VWo1WTRkUGMyTHVaNEZoSHc3VWJHaUp3TExaVDZmSWgyckhuS3FG?=
 =?utf-8?B?U0JkNXpySkE1eUlXSWhpcE5pMHM3RjFoSWJiZllTbHlTc3lnY29QblFIS0V3?=
 =?utf-8?B?L2RZWDFNamlTeUE2TUFBVW92THMybmJ2UUJyTU5hcHBtV005MW1rcFVPNE9K?=
 =?utf-8?B?SDJCUXhWOEtUTGFhdnFrcEFJTy9BNDVGZ3U3cTg0eld1UXBjQml1WnB1TGds?=
 =?utf-8?B?aDJFSkxiSGk5bEJvTDUzZmdWU3lVQmpSM2hJSll3WWhRNXZqeTQrT2xBQUZi?=
 =?utf-8?B?OGttY2xRRHAzbkp2UC9EeEh5SUlnYkFNbVhLeDhSbnBMaVB2eDUzb2pJMytQ?=
 =?utf-8?B?Qkc1VXRmK1IxM3VIam01dUNSUkg5cmtpalVXN3p0bUQ4OVhpNEpJeGUzWU03?=
 =?utf-8?B?VTlLVnJzVnFLMUVnWnZRc0VlVjAwU0RURWFCekhSTWxjVzIwQXBuQmtuSVYz?=
 =?utf-8?B?c2dkQkJFT1lOUE95WkhwUWVZNXBVWWZsREpIS3picmpFSU9taE1oNUc0SS9q?=
 =?utf-8?B?RTd2aUxGUlU5L24xV1NheTZmZDN3N2xCb1JVTEh0LzNMM2FqU2NCclZyb0Ez?=
 =?utf-8?B?d0NQcWx5UWNiWFlHNDZFd01lRVlIelZZdmFBMENuQjVjUEpQNXJ6T2hmS0dj?=
 =?utf-8?B?K2VDL1pBOHQwK3lnbDNSbXVNcDVKcEo4TjIzZVpaanFNcG5JVzEyVXNpcHBO?=
 =?utf-8?B?Q1hNeWdpK2dIV0tjdHZSZ3hhV0VQeGlNZGhpRjlxS3RLTTEyQmpPZW9NaXdO?=
 =?utf-8?B?ZnVXTkRncVpXSU43UTNmMFExd0k5TzlrZ2xlbWQwMTVTM3czZm45Yk54c25h?=
 =?utf-8?B?Q3hpbk9TMWRuUUxVOUMvdko5VGJJWStucmZHVDNzeUo1cVg2ZFFLcW1zQnZa?=
 =?utf-8?B?ajR1UEpOdWc5dVNsczNQQ0l3L3E5UnZZNGJRVEhwalNFSjZLbjVEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A7612D8C33C2C4CAF25C061024CC39B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1558c06a-8bf5-4bf3-3c45-08de4de21747
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 11:44:18.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eljhPPaeW6WdeS0SIfWaAFDX/dw6xJrI7ZexhOek5629E8Ojrt8OX7lhlUdiIWX3vrCCuYTw4s/8qbPLhiujGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914

T24gTW9uLCAyMDI2LTAxLTA1IGF0IDE3OjQ0IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCA1IEphbiAyMDI2IDEyOjA0OjIzICswMjAwIENvc21pbiBSYXRpdSB3cm90ZToN
Cj4gPiBUaGUgUFNQIHJlc3BvbmRlciBmYWlscyB3aGVuIG11bHRpcGxlIGRldmljZXMgYXJlIGRl
dGVjdGVkLiBUaGVyZSdzDQo+ID4gYW4gb3B0aW9uIHRvIHNlbGVjdCB0aGUgZGV2aWNlIGlkIHRv
IHVzZSAoLWQpIGJ1dCB0aGF0J3MgY3VycmVudGx5DQo+ID4gbm90DQo+ID4gdXNlZCBmcm9tIHRo
ZSBQU1Agc2VsZiB0ZXN0Lg0KPiA+IA0KPiA+IENoYW5nZSB0aGUgZGVmYXVsdCBiZWhhdmlvciBv
ZiBwc3BfcmVzcG9uZGVyIHRvIHBpY2sgdGhlIGZpcnN0DQo+ID4gZGV2aWNlIGluc3RlYWQgb2Yg
Z2l2aW5nIHVwIGFsdG9nZXRoZXIuDQo+IA0KPiBXZSBrbm93IHdoYXQgaWZpbmRleCB3ZSBleHBl
Y3QgdG8gcnVuIGFnYWluc3QgKGNmZy5yZW1vdGVfaWZuYW1lKQ0KPiB3ZSBjYW4gcmVzb2x2ZSB3
aGljaCBQU1AgZGV2aWNlIGl0IGJlbG9uZ3MgdG8gZWl0aGVyIGluIHRoZSBDIGNvZGUNCj4gb3Ig
aW4gdGhlIFB5dGhvbiBzY3JpcHQuDQoNCkkgc2VlIG5vdyB0aGF0IHRoZSBwc3AgZGV2IGR1bXAg
Y29tbWFuZCBleHBvcnRzIHRoZSBuZXRkZXYgaWZpbmRleA0KYWxvbmdzaWRlIHRoZSBwc3AgZGV2
aWQuIHBzcF9yZXNwb25kZXIgY291bGQgbWF0Y2ggdGhhdCBhZ2FpbnN0IGENCmNvbW1hbmQgbGlu
ZSBhcmd1bWVudCAocmVwbGFjaW5nIC1kKS4gSSdsbCBjb25jb2N0IHNvbWV0aGluZyBhbmQgc2Vu
ZA0KaXQgYXMgbmV4dCB2ZXJzaW9uLg0KDQpDb3NtaW4uDQo=

