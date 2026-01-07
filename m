Return-Path: <linux-kselftest+bounces-48395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B8CFD7C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 12:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A1CF302BD33
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDD30FC1B;
	Wed,  7 Jan 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VDjBhSiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6C2EC080;
	Wed,  7 Jan 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786468; cv=fail; b=TpEwn2wQLG6FCJHxm8OdMClHmGLXpCCAfuD3Xw2rOHf11qH2rAG5Cgu1Ia21bF0D5JQ2qJAegnpHxyWMw0HrVPIHL2ANzRsi3z3l6IYMtwPoNha82kGZoPz1qhHKc/lUtdLunoBrzQdyv9UB0bSuXEFT3U6Hv7qo86xQ5U19OZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786468; c=relaxed/simple;
	bh=H03NIlA8ucPIkYGVz+1OIh0NuY14xaWwYTrjR8ARnBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DjAytOrkLjWgHP+uAhTcQYZ8HXsN770Y6LY5ssW0GG/X+dv/DxlkW4xBhfoRVYmRuK8uR96pXxLESAF1eKLj5TnxWLPWlF8cKMmEovmKLgKtWeBQkK9hNcWKBEVYgWS1UQVS/TSlaz1WUnDzC3g+PbfXrQlv4HvpBGaeO2FBylE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDjBhSiA; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qswnK3a+Lt8fkkDFQ0WBM5XlnldPkecVXpQ+ScrbthgT5hZx41GZBKQoSwCaQFbCWDeYuJwnQONqSMe0Hd3qAeL3l+ODsJATV9lksXD845pn5HHy3tS60B93hNuui+wtfd11O6/xGPEURZARu4rIcXAfYHqRuK5Sjf3KYpoKCvjjDMF7FyU9B4Lo41NBsBPD3tzg9q8fmZWAfWub1kghMPkxjH9KdUymxR1SHxZZghQeo/fJYedmSSmdoc265/Am51ZZsrefRpLSsKf8bOcZVGNc/mBnbCnBqUVtCO5Ipq01X0BOKZ6JoMZyFPHyXFQESXSXpoBbAf2ZficOKoDGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H03NIlA8ucPIkYGVz+1OIh0NuY14xaWwYTrjR8ARnBI=;
 b=Vd8uInj89g12p0n9b1uYXSFL0jlIzPeSf1e7o1bf7E9Cus23ZMIy5sEnogxHbCOgXG+fYE8b+KdvDzyfAJISh5x7pUehpuciAkEzqpbaVoENXwXnxCMwzvgGukskWIW25EHH/TGOv4A5gAJUPbEI3Xmp1T2Z57XH9ojE0lv20aabJ4iGvQL8gcRm7nVdZWB4a3LBOzX4gqsoU1l40vHxf1ad++T7QG6gLYnoteKet+wGoTg+mpDFA6jsO/kZ6hKDLvVHEpr/aV20VTpdhH+S57lRMkN5+1dlAKqznZfXqQJe9Qz3FW70+un4mdAqrncbIsKAHUofJdB25rIVlmyhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H03NIlA8ucPIkYGVz+1OIh0NuY14xaWwYTrjR8ARnBI=;
 b=VDjBhSiAxqhk6RvwrkoV+beUKNbH98X+7WgY7Bqy1xAMSKsRCpt3xSZYKCABlWarOQTKcOPrRzdpTYbQctwsAIDw/FJHY3SCbbyoGNUmZopSANd0yOsh++XEMrLgUQFzxT3HUkIRsF9s02i+tQ9MXo/iJAIz3fIIUKZJLzYPMqzmEfGZuA0gTuIyNiHGNnRYu1VYKVGFhJfLlq+VTcsvqrCt+ujgqwr6m9Hre0wqSIf72268WjutT+A33JQksUOKSYxzXLEwuUUlfHIjzcBUFdH5dPvnxvMK7/GNyCmIJEXAtR0vHdjJ6S39Y6feh2tbTvSE6P122JzPOhflyaOh/w==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DM4PR12MB5914.namprd12.prod.outlook.com
 (2603:10b6:8:67::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 11:47:43 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 11:47:43 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: psp: Don't fail
 psp_responder when no PSP devs found
Thread-Topic: [PATCH net-next 2/2] selftests: drv-net: psp: Don't fail
 psp_responder when no PSP devs found
Thread-Index: AQHcfirOY0C9o3y7EUG6HIq5ASRU9bVEYckAgAI4vgA=
Date: Wed, 7 Jan 2026 11:47:43 +0000
Message-ID: <4094f781edeb87b38594d54dbfeec674ebaf1b13.camel@nvidia.com>
References: <20260105100424.2626542-1-cratiu@nvidia.com>
	 <20260105100424.2626542-3-cratiu@nvidia.com>
	 <20260105175206.7b74067d@kernel.org>
In-Reply-To: <20260105175206.7b74067d@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DM4PR12MB5914:EE_
x-ms-office365-filtering-correlation-id: fb001b66-ced2-4401-78ca-08de4de2918d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U25NWktzWGFHa2RIRTczMExld1VqamRHRzdQbXJBWWw1OVlhWlJkZWEwYk5L?=
 =?utf-8?B?Z2xPajEvN29CV1lUVG1qcWE5MTgwZHl0K3oxQ3ZrUUNwRXVOVkoydlJ1N3Rj?=
 =?utf-8?B?eDZPNEp5WnFYMmRMU2w0V2F5NW5aZnZQVHhSM3p6THZ0WFZRN0RCOWxWZ0RI?=
 =?utf-8?B?NHFYYWg3Zi9rVmozaG0zcmpYUE9BTnZ0dmhjckc1MkRxMWRrNFY3UklMcVR3?=
 =?utf-8?B?OHdLZUkrNFYxMlF5amhEeGN2djdlYWVtYU96RUd3cXV1OFNObXluSFU3b2tG?=
 =?utf-8?B?eU50bHNSeHFBTXd2em1sZDNkTHdXTEhRbHNsb0pjc2UvQStUNlJzT2FiSm5i?=
 =?utf-8?B?UFVOeVdUNExEdlFUb0F0UHZuZWIxSXprTmZBVy9tQU95N3JrUUpKVjlyNzBu?=
 =?utf-8?B?NnBVbHhzdnF4R3lZb3E0bzFMWXVRNHdRdEVaZkUrZ2ptcyszckVSSTJKOW9o?=
 =?utf-8?B?VmlvVGpZSnY3ZWFPNGxPS0tJaVhPU2wwSmpNOG9TK2czSEQzUUZpQnlocnA0?=
 =?utf-8?B?SEJWSEQzL1l6cjVXc3RIUXppWjU3cElsd2ZIZTgzcDRsNE1sTENpR2xFSTVP?=
 =?utf-8?B?SmtRcXZ4OXJCTnpPb0p6Wk5zT0g1UmIvYmVuNDBzYjhIRjdlT09jK1BPU28w?=
 =?utf-8?B?M1oyRnVSeVlvVDZjTlV3TittY0VHNkcvU1dnZWtEMHhYUUI0YStrMU85U3lu?=
 =?utf-8?B?eXAyL1ZYZW5Xd0hDdUxqZmJtbWZzWld4RDNQSnZWa01KRHl2bkE3R3BFZXFW?=
 =?utf-8?B?b3NmYWJNUnhpVHV4MXAwSkZDRWNlSjU4M3MyN0xvUFVQNmY0ZFEvYVMrTG5C?=
 =?utf-8?B?TWN5cUpMYm0xcTdlZjBPWWloOHhIVGEzTlV4cG0vVjhON3NZQW1JK0RYbXhD?=
 =?utf-8?B?cFNTT0VObkJiaElIcFZjazZBcjJ0K0dvRHpWSFlSYUVZczBzR1E4MFQ5TWdr?=
 =?utf-8?B?VDlpcnZLb3EwckxnTU12cDIxTlRFbzdDSTJkRHRVMFBUT2poK0lMNWg2YmJO?=
 =?utf-8?B?K21XMUVheDR3RnpxdTNFMThzZXZZUnJmNGUxdW5TQWY1UForV3FtYi8xcU4x?=
 =?utf-8?B?ODM0ZUZzTW5LcWpuM09kdktPTnJEZWo5eVhMeDFjd1MvUXFMdHNsT3lOZzlw?=
 =?utf-8?B?dGdPd1hjTzBNclp0QXZ5aTJQOStoUnpuNEhuazZVWVdkbWhXSUQ4Qjl6NXNH?=
 =?utf-8?B?eWJyZS9iQkVYWVhPZzlTOENlZWdnNlFyOVErZzJyVUJEMjJSTU0xK25vdlpF?=
 =?utf-8?B?MXlQZ0Nnc1ArUTFoZFpUd0M4UDlyVG1BaklUT2tjcnRLcDRVN0xKZHYxNlhL?=
 =?utf-8?B?N01hc2FTRk1NZEJIWFpVSE8zcjNFVlZFaFpMVGRSM29PNGpDOGVZRGgyUysy?=
 =?utf-8?B?cm8wNmhMalFwb2JKdEx1NEg0anRFcjN6cHdNL2VoRXJycEtkOGpGSFJUVmIy?=
 =?utf-8?B?WmVibVRsSTVhUXhGTkM2cEtUdUFYODBneHNRMkV3ZVpDYWZWaUM3Q0F3SkRX?=
 =?utf-8?B?U3ZOcjZ1NDFiS1Byc1d0enFMRWkxL0NodkNkU1BlTkZWU011eDBhMHVuRjNJ?=
 =?utf-8?B?a1Arc0NHVXAwR2xVZHVWdHJ2U2JncDE3QytCbjhJbWs4eVB2R2YweUYwMEx4?=
 =?utf-8?B?QTF3REtBZDZObzJodmhJR2Z4djdEYWZsa0FwNmRxbUhDTDE4TlBONHpoVE12?=
 =?utf-8?B?TWdYV1U2NERVbDdrTzFmbmNHcDYrVTVBODhiVkdiR2ovMTl6RHVZUXZFcGhh?=
 =?utf-8?B?akdkSnNFeVMwR2RDeWZZS0pKekZ3WDhQQzYwSGVoRXFaRElMTDNYSk9ZL3Z4?=
 =?utf-8?B?LzAwclJlYUVUb2xMVlYyczFDKzAzVDRJMUczZVpsTHZRcERZZ3NFVy9JU3Rl?=
 =?utf-8?B?cUdHVkUzNGFyMlBzRlcxZ29Uc0hGYkd2MmdGdjhGVFZEV2s3dThSd3JOcE9l?=
 =?utf-8?B?M2FKQXV2OUVsZDBxVFpPeDRpYkFFSGwvTi9hYllWN3JJYUVLblJ6NkNNdHJB?=
 =?utf-8?B?WGV5eEdDTlNwa2hZQkFTdXlBM3FXQzgrN0hxc2V5RHpnaFIxNkc0ZnNFbWQ2?=
 =?utf-8?Q?uckitO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmN3UURhTnM3U2N5NmZmQkdQY2lKMDJIZnJXRHJ4Lytadkk2RDBqQTlxTDd0?=
 =?utf-8?B?RkhSOHNSbjJvaWFRaDRCem0wOWp0c0ZZLzZvYWlIallBOHRnbWlvUjh1MmJ6?=
 =?utf-8?B?a21mejZvM1BmazZid3VmMExCcTMzYVgxN25UOEtWdDM0WHJqZWIwRklJem1Q?=
 =?utf-8?B?M3A0SzhaQlBlRmJocE9VN0dTSG13SHFTdDZYUUV5VEd0MGpDSkFpeUFOYVNJ?=
 =?utf-8?B?ZWM0YUNiWW5kSlVoTXhWZTZ0VmltTU12dmFMYTR1WVhNRlIwOWJYWGRveThs?=
 =?utf-8?B?dldnb0ZrUi94b0xEK2FzUzczdHV5bjFIL0t1aFRyaDl1dmJCa210NE8xQmVO?=
 =?utf-8?B?WHQwOXR2bGRZTXpQelRtNzA5K09xVXk4WlIwZk5uckZOWWEvejJBeFpqbzVN?=
 =?utf-8?B?ZmhmbmhtRjNoMTNuV1gxU2pSUE5EenAxTUc4SVVmWXNqUUxWME9RbkdpOTNy?=
 =?utf-8?B?UnVhVG5ZMStGRlozUWthaC9pYXp4OWxtNHZMK2lCTjZ5NnBMZW9QYnhoVENW?=
 =?utf-8?B?NGRlNXVKZ1RlWTFydGZmYmU0eHlERjJtWmdXNFVWZjhyZWd2amdkVTRZMFNp?=
 =?utf-8?B?U2tuTEFtQnVMNGlOcXFPY2lQa3grc1AwN1ZxbHV0Z25FODFiTDc5NUQxWmFm?=
 =?utf-8?B?SSs1NVMzelFKOE5hcVlpWnZNUGhLRVNrTVlzV1pPN0FCSUNlSG9qL1ZyNG1i?=
 =?utf-8?B?WGR5azBMMmQwNGd2TkFiWnZsV25OaXE2MCtIZVBBM08rdTVqVWlmSVB3Q3Bj?=
 =?utf-8?B?RjhpT2MvZU1ZWGhXY2lrYy9yMUdKYndyb1N1US9Ia0hlZ3VvNXBOM2xuZWZY?=
 =?utf-8?B?eGJCZmtRcy9IR0NHWDEyOFRHbldBQUhmQU1uTC8vN3dXZDlDdEY5VmkydWZI?=
 =?utf-8?B?K2NnVzE4a1RsaVVyQkZhSnd5S05UbWREUVBPQkc4eHJ6QWQ2enVLR0ZnSUJ3?=
 =?utf-8?B?VzMwbjVrOGFIaWt4Mk1lcnFIRWNaRy9aMlNZVHZPY2Q2VXZPZ09YalRCakVY?=
 =?utf-8?B?UEJNSkpWbFRxV2VaSWdpUmFXQUlQN2FUR3FNQ1UxZTNxM2R5R3EwQ2NlclVN?=
 =?utf-8?B?cms3WVphdmNndzRMdjJpSnYyeW9QbGtidjlMcFJPU2d6emRPbGNjVlZFWVNw?=
 =?utf-8?B?ZTFoTVlxNHVrN20rZkZFSVl4bmtQVXFsazM3N2Y2dk4xZkdMU25RMDNzMlVj?=
 =?utf-8?B?OEZZNnZZNjFSTTZzOFFseGlJRHNjMW80YTVaNEZCakMyTUZWNUx1VFZqYkxT?=
 =?utf-8?B?WXZFS1dpWXh2WnhaZTlmM1gxZnU5eURqWld6Z3JIaG9Qa2J4WGJYcExjNlQx?=
 =?utf-8?B?V3RyZU9aRjdUK3FCdUVBUDRCeUtaOW9tdGZIbTYya3dYTGYrZVJiM0ZheVV1?=
 =?utf-8?B?UGtOS0Q0L3RKQXBJYlBkNWx5SmRMcE5BTy9ENmUrRCtoRG9YRlc1c3JFY0RX?=
 =?utf-8?B?YlVWZ1JnQUw5REY5NGVldno1R2lCb2UreHJkS1RUYmlFbHRtdDZEMDJieXNT?=
 =?utf-8?B?TzN2NTU2NTJ2WFBYdmFENDNXWUVXQnhMVXVGWnRZam1jS3lId3NPVHRlZ1Fk?=
 =?utf-8?B?eVhvV3d4dUs3VE9vZFNjcG16RkJWVFQwUlNWTmZUdTlBbGtmL0JOOHU3YjFy?=
 =?utf-8?B?Y3BkUTJPT1lIOURCRVg2L05EYnZsOWFhWlQ2MEFsTTRVbHZtdkFNZmN2ZHM4?=
 =?utf-8?B?TTFwMGlQdW02dGtuWjk3NlhhU3dZdW5iaUduY2Vhbkt4cUdlNStlNUZVN2xo?=
 =?utf-8?B?VmZQYmo4a3ZzcTFIN3RQYjVtZ2wzck9IeVgzQlFQUEYyb3JGYUNNT2ZCcGhl?=
 =?utf-8?B?MTRUOXlrR0tkb3Y3SXdMTWtlNndJeDRsck84RC96VGJXb25GdlUvYXJhTjZC?=
 =?utf-8?B?Ny9SRXh0UFlSRThXZ3h0UkU5cUhUbkZib2Yxc1NJWUYwbWRnR2xuUzREcXU4?=
 =?utf-8?B?cEZacW9rc3NCdUd6VmxrZy93amJsU0EvajFQN0hCckY4Y3NyeThyMXFGbkx6?=
 =?utf-8?B?d3ZnU2w4M2htYzl3R3dIN2NJTGtrRXhhdHhEY3ZPSjJkUFBJT1NXaEEzMTNr?=
 =?utf-8?B?R2JEa2lhMEtqSjVRaWxYa0NrLzNFbmhNWHFXTkkvTFg3MHhjZXYrRjlVZWV0?=
 =?utf-8?B?SzUzTUd2R1liOEFiWThHbDdrWVFKcVVtbisyQmkyRTlBZDY5dU9JZjVPL0JN?=
 =?utf-8?B?K2ZPV2UvQmdxekZTU2lIZjMzcTFtODZnL3VKdEgydzhlWEZDZmlKb3FrMVFy?=
 =?utf-8?B?MFhTUmh5L0I4Ylh0MWhSTjJEZWJMckFlem0zejhYTnd5NmxxRGtNb1IrcHNG?=
 =?utf-8?B?NlF0SUlFTENpNHRZaDhRUC9Ec0Z3cEphdXFDa09WMUw1ZC9nb2ErQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38E4AD3C36532743A34386DD48F9C3F5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb001b66-ced2-4401-78ca-08de4de2918d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 11:47:43.2909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6mKaUTr0jy2iEl8/6PnYlH6AgIKown1nqezdacVda0WUsQwHIoEYuc0X8FD+8JKZynJHMSjAc04HeBrDIFzgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914

T24gTW9uLCAyMDI2LTAxLTA1IGF0IDE3OjUyIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCA1IEphbiAyMDI2IDEyOjA0OjI0ICswMjAwIENvc21pbiBSYXRpdSB3cm90ZToN
Cj4gDQo+ID4gQ2hhbmdlIHBzcF9yZXNwb25kZXIgdG8gb3BlbiB0aGUgc2VydmVyIHNvY2tldCBh
bmQgbGlzdGVuIGZvcg0KPiA+IGNvbnRyb2wNCj4gPiBjb25uZWN0aW9ucyBub3JtYWxseSwgYW5k
IGxlYXZlIHRoZSBza2lwcGluZyBvZiB0aGUgdmFyaW91cyB0ZXN0DQo+ID4gY2FzZXMNCj4gPiB3
aGljaCByZXF1aXJlIGEgUFNQIGRldmljZSAofm1vc3QsIGJ1dCBub3QgYWxsIG9mIHRoZW0pIHRv
IHRoZQ0KPiA+IHBhcmVudA0KPiA+IHRlc3QuIFRoaXMgcmVzdWx0cyBpbiBvdXRwdXQgbGlrZToN
Cj4gPiANCj4gPiBvayAxIHBzcC50ZXN0X2Nhc2UgIyBTS0lQIE5vIFBTUCBkZXZpY2VzIGZvdW5k
DQo+ID4gWy4uLl0NCj4gPiBvayAxMiBwc3AuZGV2X2dldF9kZXZpY2UgIyBTS0lQIE5vIFBTUCBk
ZXZpY2VzIGZvdW5kDQo+ID4gb2sgMTMgcHNwLmRldl9nZXRfZGV2aWNlX2JhZA0KPiA+IG9rIDE0
IHBzcC5kZXZfcm90YXRlICMgU0tJUCBObyBQU1AgZGV2aWNlcyBmb3VuZA0KPiA+IFsuLi5dDQo+
IA0KPiBUbyBiZSBjbGVhciAtIGluIHRoaXMgY2FzZSB0aGUgRFVUIGFsc28gZG9lc24ndCBoYXZl
IGEgUFNQIGRldmljZT8NCj4gSSdtIHN0cnVnZ2xpbmcgdG8gY29ubmVjdCB0aGUgZG90cyBvbiBo
b3cgdGhpcyBlcnJvciBtc2cgY291bGQgY29tZQ0KPiBmcm9tIHBzcF9yZXNwb25kZXIuDQoNClRo
aXMgaGFwcGVucyB3aGVuIG9uZSBydW5zIHRoZSBwc3Agc2VsZnRlc3QgYWdhaW5zdCBhIERVVCB3
aXRoIFBTUA0KZGlzYWJsZWQgKGUuZy4gbm8gUFNQIGRldmljZXMgcHJlc2VudCwgb3IgY2FwIGJp
dHMgb2ZmIG9yIHNvbWV0aGluZw0KZWxzZSBub3Qgd29ya2luZykuDQpUaGlzIHBhdGNoIG1ha2Vz
IHBzcF9yZXNwb25kZXIgbm90IGZhaWwgaW4gdGhpcyBjYXNlLCBlc3RhYmxpc2ggdGhlDQpjb250
cm9sIGNvbm5lY3Rpb24gYW5kIGxldCB0aGUgcGFyZW50IHRlc3QgZGV0ZXJtaW5lIHdoaWNoIHRl
c3QgY2FzZXMNCnRvIHJ1bi4NCg0KQ29zbWluLg0K

