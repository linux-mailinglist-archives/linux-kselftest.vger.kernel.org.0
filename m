Return-Path: <linux-kselftest+bounces-32604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA5AAED11
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 22:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DAD3A26CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3928DF3A;
	Wed,  7 May 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEed460Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDA23DE;
	Wed,  7 May 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649790; cv=fail; b=qDR+B8dWUCu9vn7OIqFSQJmhHxtWYUw4NwUl/xEkiTQcV/ySqnWeWxhFSLNkejHNxgOVqhKGTqSuE87QoPpGgQ8jV9nekJMMnKAl+Rh19/PuBMJrNOoj6xt4alY2+E1+v1qakkhl77EOWBql6vMrGriEXuco/8msa2lnPeZlE3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649790; c=relaxed/simple;
	bh=yTYJklR2esEvMldqxs7jMfAR/VeVoqr890YehQXvnRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hBCKavI/CU7twfsHMZJTyi5JNiEuo6l/cO0FLODqo/vEVi2bQ8H8oO0OQ9eMhiwwIX9PNRkGRD42KqtE/27997vRV6ddPKLcwXVdharshjeiXZ6LDJBS3+c2S2P5p+3rkxE8Xn+6zjTG6m8K4vek7a4/F1+sYXsABmJi+onvsMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UEed460Z; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OylEYkYU4gx120drLjqtjD/sZs5S/tIuW5vlZMflmrlCqnOlWDykYkKtE6zuh2mphik1fwdyCAX3X6p3/75SqXfOcg6LnkNvJOAkw3yfQPWTNPvwMRb7hozek1obrzQFhX+aIUgiKtR8IIkft6oUEowN757iZb96n0NKb3o2coYLNr4J2rJRQZRua7z9vDRjc7mIq4PymTGSjcL/BRREfvWZaNOeEKucyo1s+wKj+V8E4hygxH6By5lfUMfB1XEgDiSXpdC0Xkif3lv5woR3ho9DZULiuyhGjizau+kAdt4LMa8SyBbS7Lc/wo/ZbMa+XT4Obp/lCZ8O/nv4OnvUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTYJklR2esEvMldqxs7jMfAR/VeVoqr890YehQXvnRw=;
 b=IhrlulwqvchKKmuJl31IIvNtTWg3Dg8jsjZYcfDzDB0/oaIWiE3jEjgQKURGPQ3kE4rXXtLIlauXu9z64JfmFpjqf0rIf0VriviFJS1YwfTSy15J8047Yc6Y6Z4y8x709KXkz/0GhxuyQC/fR0oa6ugFXgzEFgrIV0+sfvvxc1vD0V3K7ucQ8chdtgsXDSCyqElCj94iJK6ipSCg6yzowHA1+6Np8jWQUQVOeGD2yOll5ptYNOk8qxiAwvfvkavO5QzQnUTVfMNvaHTf4UMl0l4jTMc80ku0QAcTCO4HCQzjpdqZUYnnohvZY2oD7f5HybODPeguUIiyBip3QlJnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTYJklR2esEvMldqxs7jMfAR/VeVoqr890YehQXvnRw=;
 b=UEed460ZkE/WZJQem1wPPrBGOQ2B/bkW4xOyAR1Wo5ZIRSdodzN0vwxHXET5ArsmNHbgySVuBEcVboWXqXVcR419gSFihA+kmhboUVyN5fTT9BUHKaatgKQVsrP1HRD0NgnSz5FjSrG8uzWplD8DfnDhdSgD/YULvoqOv6HphBnuxUVOfREQYVCmJzatSBxXdkoWKoWAuRVaQBfjIokxovs2EgJKVPzY5ViNrdtN9v+G2EOgedLv9/i/ipDijBKO687nczxgJM1tOA3btd2NOg5NpALefeP5PNwEebPIyTfuoadReQYmhIhNUK0+NFCfMKcDXlrFnj+d4PvDp4+aWg==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.35; Wed, 7 May 2025 20:29:41 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 20:29:41 +0000
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
Thread-Index:
 AQHbvpI68/ihdVxTiEiw4lpvBpBbzLPF1uyAgAAJx4CAAAdlgIABVUcAgAAKsICAAFhQAA==
Date: Wed, 7 May 2025 20:29:41 +0000
Message-ID: <e886c3511fbe9cf7e66b0a142183a5375a42978a.camel@nvidia.com>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
	 <aBpC9_SgUaAA2P0f@mini-arch>
	 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
	 <aBpRX_afG5X_rT_J@mini-arch>
	 <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
	 <6c0a6b462200847d87221dcd7655b6a746012061.camel@nvidia.com>
In-Reply-To: <6c0a6b462200847d87221dcd7655b6a746012061.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN2PR12MB4191:EE_
x-ms-office365-filtering-correlation-id: d5a194e7-01a2-47aa-3efc-08dd8da5e570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTByYjlpZG5GekNYcmdKcjI5dU51MWVFMWFTMHF3VnZKTVpxRDNTenl0RlhE?=
 =?utf-8?B?YlZ5NmRDVi9xVTRXbUlZVy9zeXFGYzhYYlljWXdzQmg1Z015NVRiaWxNUEFp?=
 =?utf-8?B?MkRzSDY4djE0Ni96aDg4S3Uwano3V1AxU2pLeXJ5cTltaG4zbE5OZmNjYUhl?=
 =?utf-8?B?SFFsZUliTWd3cFFURG5EQmFJT0hoTEF6TStaMG9EZWw5Q1I1TkRyMXVrWCtE?=
 =?utf-8?B?dFRnR1VEK2E4QU9TYktUZ1BGUmdsalFHdW9mRUZQbDgzbHhxRVMwUTBzbnNp?=
 =?utf-8?B?QkdmOHlPTXYzWldTL3huL3Z6Q3U4V2JHOVNyWGxiME83QTlRckMxMnI3ZHFQ?=
 =?utf-8?B?RnVIbnMwOXM0b2EveVhLaUF0K0JsTkxtNkNDUTFxdWRURVhEY0U1NG55ejVI?=
 =?utf-8?B?b2hWcHdlTVFySjhPR01qaks1VTZ0QUVmbkxHSFE1U0lCb3grc2xBYmxMczU4?=
 =?utf-8?B?RUkwY3Eyck55Q0c0SEFhek93ZzZSekc1WHMyUGFra29wQ2YxVjV3Zk5mZ3Y4?=
 =?utf-8?B?TmVlVGlTSStBUUd3enhZRDVwZEN1WkljTWs5aWRNNXZQZWFiSnNxbStlelhI?=
 =?utf-8?B?cnMvQms0dXRWU2hVMmdXdnVCaHhYTVVLMTUycElKay92SnpGbG5nbWh3OGY1?=
 =?utf-8?B?N1RlY2ZBRU9NOWs3SndLMUJFczZTTzk2S1JHWHhGa2dNcHMvV2pOcGNvNy9z?=
 =?utf-8?B?aUNLNDN0S1pQcFJYUlNvZVNVYkg2UG9VRDZrc3NFUk1zelRPeUVqNUJaTU04?=
 =?utf-8?B?WFNydUluaGk5M2JIdHZRR212czQ1WkpmRm04WHZHMGROYWd4NDRqd3hkWXJR?=
 =?utf-8?B?MFh0Njg5UnJuZFc3bmprN3graVdnaG1CRGpYdXhHVFl2VUhRSWtUZmU0b3hL?=
 =?utf-8?B?UC92TDQwZkNXb01HMzk1L05NTnJiMnErV3hWOWlnZVR4ZE1DRWVwTjg5eUtK?=
 =?utf-8?B?SDBEaW9CWDNCUGNzeTlWUk5XVUFWQVZjSDdLYUd0UGNRa2xsKzVVdG5wendh?=
 =?utf-8?B?UTk0Zm0xUGdYcEJXSUdid2lpbG9GNG00T0NOS2hWTHdBZ1ZTalhkM0JPQW1w?=
 =?utf-8?B?ellrZFJKclZRZVZ6b2ViTHFYWjlnMU9RbURDUFVtSU9ldGxYcnJwTGlXc2E4?=
 =?utf-8?B?VlUxZnU1enNDTHM3alMveUJybmN2UDR6dUg5VTNnSjI1czJ3aVl0cjBlWmEz?=
 =?utf-8?B?Y21mbDkrUElsODZiTzRNN285SHdrMHUwMm8rZ2tFZWpBT2RMWEd0djF1bUQw?=
 =?utf-8?B?dnk3bkhEMjFGdEVnaUU0dE80V3VWVHVhY3BHb3ViYXR5aFgyNEFNTzU4Wnpu?=
 =?utf-8?B?YXoyRzE3SUgwLzBkWjRXeit3OHBnMEZYRjhXWXNCVk9vUzIrQkZWYW43VXIz?=
 =?utf-8?B?bzBDWXlaREJubUFPdythRXZEb3dtZ1YzRExKNnM3N3VnVitEaDJoV0RKWlNN?=
 =?utf-8?B?SXh3anJQTWdoL1NDemFOYjk5elZiVjFTNW4rbnhCSXJCbDNvdnN1ZXRZUGEz?=
 =?utf-8?B?d1F3c3Q1aWg0Mml2UVpSdE5NSmZ0cFo1MmY3bnJ1eDAyTEpmd0hPZHRzMDJx?=
 =?utf-8?B?RkZUSDZzZmQwYzNmZlorZXBoOU9BTWVDNUlIaUNLbk9LSlFSaFB1UE1YZE43?=
 =?utf-8?B?K1lSSjFLQkcrRHBSR3k0QkZLdlpYaHBBcHA2WVpHWnd0alVFYjVUV0pJZWFp?=
 =?utf-8?B?OXZNN3FqSUNRNUdhVmErY0QxTkVDd1AyVlpjLzFrbUhlVmkxV2RZdlZ1eHJz?=
 =?utf-8?B?Nm5OUDI4UERPeUFkRVpNeWFkRXd4a2draERFY01lTVlmbUtPazB1Wm5ZeVk1?=
 =?utf-8?B?MDFWTGRTVVZRM1hJZDc3cC82QWUvL2xsRXRoSzhjNjUvSGdTUGprSmNEUm12?=
 =?utf-8?B?aGlacStXWUpKNmFmM3Y2cUlBUjU5RHR0b0ExQzFMVmdoUEZVMzhxSmtoUzlJ?=
 =?utf-8?B?SjlCNWtxS3gxeVptVGpBamxjUk1uOWUwRGp0d0tjOC94K3pLL1MxSnYzNVFZ?=
 =?utf-8?B?akNEbHlUWUpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmtEdWJZMERGNzRoWjlJU0d3Tm1pbXJodGRuSFZiZDVucTJYeDNERTA4djJ6?=
 =?utf-8?B?WWVtdXZPenFnS2JvVG1vMmRiam1XdVdvU0RmQkd5OStucDVtNGZiN0VhQWM3?=
 =?utf-8?B?ZUs3QWZsQnBVMiswSVdKSS9Qa1cvVXdGNEgydkg5RjN4MERGVjdmUnQ2WG9n?=
 =?utf-8?B?b3FZR2ptTUlEcVM5NFc4V2tvRGJUNVg1Qk9XOXhoWlh1MXlzK3E4WmcrcFQ5?=
 =?utf-8?B?WHBESENCNk1MMUs0K0FCYmRzWkExK3EyTXRLblI4SlpVSU9MVE91YkRZWWgv?=
 =?utf-8?B?bG0zbjF3b09oYmMvYWtnRU4zOC9UNHc0VEZtalFzRFh4emVDbEtLMk93Qkpz?=
 =?utf-8?B?ekhiU0ZqU0d4NTQzS2FFckVJMy9Yay9vWk55b21MT2p3ZmFwZFpMNXFJMm5B?=
 =?utf-8?B?eGlSQ21BWHg4QjllREIyazBjTmtRd1hFMldPVnVQRGlrbWpKL0VnRGFYNUxa?=
 =?utf-8?B?U3VLNFR3Rmh5ZUVrUWhJNkZBTlVHa1MwZm5OV1loc3hDYXI3UEtXWFRUczAw?=
 =?utf-8?B?eUpoOUFJVTRnRHZ4Q3hEZnlmYWd3QS85b0RGZDNMbkszL21lR2VKSnh0cGU5?=
 =?utf-8?B?YkVKSHIrazBwYys2Q3NtQy9hNmlTOHF3U28vMXJiR3VRaUZLbnhVOFEyS3Vv?=
 =?utf-8?B?L2p6N2JGRlZEOFBMcGdValh5RmJxVXFPTVFnL3d3bGVaY0RCYW9ONk4ybTVm?=
 =?utf-8?B?TUVQejVuZGZKemIrMUhIaXgweDd0QWZXcFFkNUpnM0x2ZjNKWUtTb2NNbnow?=
 =?utf-8?B?YXpjL1hta2NuZjJIVXU4MDBTNG9WZm1mamtwVXVUSWprVSt5dWlKUlRDSnJO?=
 =?utf-8?B?c3Yxd3RnOWs3Y2hIdmFUdW50NkhBSlVXRExNZnBPSFFaWnI2a21mQ3VUU29u?=
 =?utf-8?B?VFhycERtZ0FBQ0RabzY4RmJzNTIxbHpwbTgyeHExNW45aHdDZHQxWUZlQWJL?=
 =?utf-8?B?ZGpxZ3RGMlBnN1UzK1JxbUZlZHkxL1ZzclFEN3ZqR2FTSlZiZFp5NHVMTS9h?=
 =?utf-8?B?ZXptK1hUR05TbUQzdDI0YzExenZnY28zTkw3RTZaVlk0YzZZOSs0a1pqOG1i?=
 =?utf-8?B?Qlh3Z2hCdHNjRHZzM0RjVlBPcXRaRGpBcmttSHlXek5jZkRKN0ttQUJaYnUz?=
 =?utf-8?B?eXJrKzhMdDF3SG1nV0lKejNyRjU4YjdYb3NXSXNDRE1wYWRsTTdpRi9pbjFi?=
 =?utf-8?B?RWNDc0ZoV3BnYTJBR3cxREg0NU5ublJlZnhNamFiYWN5cXBFcnZlanFWazhj?=
 =?utf-8?B?VWtndHhweThwRFdnUVpVOEdTUEVCeFJxRk1EQTlQUHdhbTV4dGpuVC83a1cx?=
 =?utf-8?B?b1dtcitJWGFDQWlPNk9yOC9vMlg4ZWo4d3F0M095c3hXY2ozVG9XNWlsclZH?=
 =?utf-8?B?Z1JhYnRBNmR0dnJ4TUNaMWR4MFZEV2F1NUV0S2JhVHFYN1JTRk5JK0llNFdR?=
 =?utf-8?B?QkFsNVlMdHZVYVBjLy96dU1YSzdrUTRJejB1WEYzTUMxRUwzbUoxaFZZVkFG?=
 =?utf-8?B?ME4wcnpNYU03bmU3OHdsV1MrR2xYYjNqYkd0d0l0MklycnMzbkVacHFCYzJQ?=
 =?utf-8?B?NE5GeDFlSGVGUGhDUWtyUStEa3c3aE1MYWw3WlpJRm5RbDF6VzdJdmhuOXFz?=
 =?utf-8?B?UGM1ZGZKRUEyN2EyRDJKbE5Sd3M1RnFVLy9nWXVybUlyalpYRENjR3MwTjMv?=
 =?utf-8?B?dTZvZkNOWm9RVFNqZDBlaHU4dDB5cXVETHB3N0ZYYTV6TFBJRWlJeWRSQ1lO?=
 =?utf-8?B?eDBIRmhyZ1pBNUV0TDJEdGdwbFE1S3B2bmlWZHdqYUxOTWlybUZQRlkzNXlJ?=
 =?utf-8?B?OHd5UXV2dU1pV29TdjN3MEpGeXBIS2tlNE5SaWx5M0NadEVSNHFaRWVJdU9J?=
 =?utf-8?B?S3hyeWR4dDVMT3ZHUnBTWmU1aDFsS29sa2Y0bFVrdkViNXdTQVFYL0NyWEJa?=
 =?utf-8?B?NXlES1ZpcTJaQXhaV2ZuV2NlOHlyNTN5aEVzZWsxQVlPdEhrd2RLUitLaGNM?=
 =?utf-8?B?UWY5T1lwZ1dzMmJQSXdtbWpDWlhnNmE4bTZOWFBIOEdDNHJuL3BCMmx3M0pV?=
 =?utf-8?B?R1lpSjlteFc2aFp3OGVFYzEvMGpKWkZHTEdZcVdFYlgxQUNobXZYd3MvZUtN?=
 =?utf-8?Q?e5h6ZBNfRG3joBjKRpFWeahXA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D3E55310C2F54498193A707FFAEDF60@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a194e7-01a2-47aa-3efc-08dd8da5e570
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 20:29:41.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEzTVkTmZolv7ggRpKUZyDQAwhw6NAA38EzFVSFRvYl43f6lLwLq19N1W1z7ytx+mDtEZkTMNOVFi7/yr9dfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191

T24gV2VkLCAyMDI1LTA1LTA3IGF0IDE1OjEzICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
ID4gSW4gYW55IGNhc2UsIHBsZWFzZSBob2xkIG9mZiB3aXRoIHBpY2tpbmcgdGhpcyBwYXRjaCB1
cCwgaXQgc2VlbXMNCj4gPiB0aGVyZSdzIGEgcG9zc2liaWxpdHkgb2YgYSByZWFsIGRlYWRsb2Nr
LiBIZXJlJ3MgdGhlIHNjZW5hcmlvOg0KPiA+IA0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+ID4gV0FSTklORzogcG9zc2libGUgcmVjdXJzaXZlIGxv
Y2tpbmcgZGV0ZWN0ZWQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+IGV0aHRvb2wvNDQxNTAgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoNCj4g
PiBmZmZmODg4MTM2NGU4YzgwICgmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzcpeysuKy59LXs0OjR9
LCBhdDoNCj4gPiBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMrMHgzMWUvMHhlMjANCj4gPiANCj4g
PiBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNCj4gPiBmZmZmODg4MTM2NGU4Yzgw
ICgmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzcpeysuKy59LXs0OjR9LCBhdDoNCj4gPiBldGhubF9z
ZXRfZmVhdHVyZXMrMHhiYy8weDRiMA0KPiA+IGFuZCB0aGUgbG9jayBjb21wYXJpc29uIGZ1bmN0
aW9uIHJldHVybnMgMDoNCj4gPiANCj4gPiBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBk
ZWJ1ZyB0aGlzOg0KPiA+IMKgUG9zc2libGUgdW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86DQo+ID4g
DQo+ID4gwqDCoMKgwqDCoMKgIENQVTANCj4gPiDCoMKgwqDCoMKgwqAgLS0tLQ0KPiA+IMKgIGxv
Y2soJmRldl9pbnN0YW5jZV9sb2NrX2tleSM3KTsNCj4gPiDCoCBsb2NrKCZkZXZfaW5zdGFuY2Vf
bG9ja19rZXkjNyk7DQo+ID4gDQo+ID4gwqAqKiogREVBRExPQ0sgKioqDQo+ID4gDQo+ID4gwqBN
YXkgYmUgZHVlIHRvIG1pc3NpbmcgbG9jayBuZXN0aW5nIG5vdGF0aW9uDQo+ID4gDQo+ID4gMyBs
b2NrcyBoZWxkIGJ5IGV0aHRvb2wvNDQxNTA6DQo+ID4gwqAjMDogZmZmZmZmZmY4MzBlNWE1MCAo
Y2JfbG9jayl7KysrK30tezQ6NH0sIGF0OiBnZW5sX3JjdisweDE1LzB4NDANCj4gPiDCoCMxOiBm
ZmZmZmZmZjgzMGNmNzA4IChydG5sX211dGV4KXsrLisufS17NDo0fSwgYXQ6DQo+ID4gZXRobmxf
c2V0X2ZlYXR1cmVzKzB4ODgvMHg0YjANCj4gPiDCoCMyOiBmZmZmODg4MTM2NGU4YzgwICgmZGV2
X2luc3RhbmNlX2xvY2tfa2V5IzcpeysuKy59LXs0OjR9LCBhdDoNCj4gPiBldGhubF9zZXRfZmVh
dHVyZXMrMHhiYy8weDRiMA0KPiA+IA0KPiA+IHN0YWNrIGJhY2t0cmFjZToNCj4gPiBDYWxsIFRy
YWNlOg0KPiA+IMKgPFRBU0s+DQo+ID4gwqBkdW1wX3N0YWNrX2x2bCsweDY5LzB4YTANCj4gPiDC
oHByaW50X2RlYWRsb2NrX2J1Zy5jb2xkKzB4YmQvMHhjYQ0KPiA+IMKgX19sb2NrX2FjcXVpcmUr
MHgxNjNjLzB4MmYwMA0KPiA+IMKgbG9ja19hY3F1aXJlKzB4ZDMvMHgyZTANCj4gPiDCoF9fbXV0
ZXhfbG9jaysweDk4LzB4ZjEwDQo+ID4gwqBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMrMHgzMWUv
MHhlMjANCj4gPiDCoG5ldGRldl91cGRhdGVfZmVhdHVyZXMrMHgxZi8weDYwDQo+ID4gwqB2bGFu
X2RldmljZV9ldmVudCsweDU3ZC8weDkzMCBbODAyMXFdDQo+ID4gwqBub3RpZmllcl9jYWxsX2No
YWluKzB4M2QvMHgxMDANCj4gPiDCoG5ldGRldl9mZWF0dXJlc19jaGFuZ2UrMHgzMi8weDUwDQo+
ID4gwqBldGhubF9zZXRfZmVhdHVyZXMrMHgxN2UvMHg0YjANCj4gPiDCoGdlbmxfZmFtaWx5X3Jj
dl9tc2dfZG9pdCsweGUwLzB4MTMwDQo+ID4gwqBnZW5sX3Jjdl9tc2crMHgxODgvMHgyOTANCj4g
PiBbLi4uXQ0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBob3cgdG8gc29sdmUgdGhpcyB5ZXQuLi4N
Cj4gPiBDb3NtaW4uDQo+IA0KPiBJZiBpdCdzIG5vdCBjbGVhciwgdGhlIHByb2JsZW0gaXMgdGhh
dDoNCj4gMS4gdGhlIGxvd2VyIGRldmljZSBpcyBhbHJlYWR5IG9wcyBsb2NrZWQNCj4gMi4gbmV0
ZGV2X2ZlYXR1cmVfY2hhbmdlIGdldHMgY2FsbGVkLg0KPiAzLiBfX25ldGRldl91cGRhdGVfZmVh
dHVyZXMgZ2V0cyBjYWxsZWQgZm9yIHRoZSB2bGFuICh1cHBlcikgZGV2Lg0KPiA0LiBJdCB0cmll
cyB0byBhY3F1aXJlIHRoZSBzYW1lIGxvY2sgaW5zdGFuY2UgYXMgMSAodGhpcyBwYXRjaCkuDQo+
IDUuIERlYWRsb2NrLg0KPiANCj4gT25lIHNvbHV0aW9uIEkgY2FuIHRoaW5rIG9mIHdvdWxkIGJl
IHRvIHJ1biBkZXZpY2Ugbm90aWZpZXJzIGZvcg0KPiBjaGFuZ2luZyBmZWF0dXJlcyBvdXRzaWRl
IHRoZSBsb2NrLCBpdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGUgbmV0ZGV2DQo+IGxvY2sgaGFzIGFu
eXRoaW5nIHRvIGRvIHdpdGggd2hhdCBvdGhlciBkZXZpY2VzIG1pZ2h0IGRvIHdpdGggdGhpcw0K
PiBpbmZvcm1hdGlvbi4NCj4gDQo+IFRoaXMgY2FuIGJlIHRyaWdnZXJlZCBmcm9tIG1hbnkgc2Nl
bmFyaW9zLCBJIGhhdmUgYW5vdGhlciBzaW1pbGFyDQo+IHN0YWNrDQo+IGludm9sdmluZyBib25k
aW5nLg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCkFsbCBJIGNvdWxkIHRoaW5rIG9mIHdh
cyB0byBkcm9wIHRoZSBsb2NrIGR1cmluZyB0aGUNCm5ldGRldl9mZWF0dXJlc19jaGFuZ2VkIG5v
dGlmaWVyIGNhbGxzLCBsaWtlIGluIHRoZSBmb2xsb3dpbmcgaHVuay4NCkknbSBydW5uaW5nIHRo
aXMgdGhyb3VnaCByZWdyZXNzaW9ucywgbGV0J3Mgc2VlIGlmIGl0J3MgYSBnb29kIGlkZWEgb3IN
Cm5vdC4NCg0KZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMNCmlu
ZGV4IDFiZTdjYjczYTYwMi4uODE3ZmQ1YmMyMWIxIDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvZGV2
LmMNCisrKyBiL25ldC9jb3JlL2Rldi5jDQpAQCAtMTUxNCw3ICsxNTE0LDEyIEBAIGludCBkZXZf
Z2V0X2FsaWFzKGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQpjaGFyICpuYW1lLCBzaXpl
X3QgbGVuKQ0KICAqLw0KIHZvaWQgbmV0ZGV2X2ZlYXR1cmVzX2NoYW5nZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQ0KIHsNCisJLyogRHJvcCB0aGUgbG9jayB0byBhdm9pZCBwb3RlbnRpYWwgZGVh
ZGxvY2tzIGZyb20gZS5nLiB1cHBlcg0KZGV2DQorCSAqIG5vdGlmaWVycyBhbHRlcmluZyBmZWF0
dXJlcyBvZiAnZGV2JyBhbmQgYWNxdWlyaW5nIGRldiBsb2NrDQphZ2Fpbi4NCisJICovDQorCW5l
dGRldl91bmxvY2tfb3BzKGRldik7DQogCWNhbGxfbmV0ZGV2aWNlX25vdGlmaWVycyhORVRERVZf
RkVBVF9DSEFOR0UsIGRldik7DQorCW5ldGRldl9sb2NrX29wcyhkZXYpOw0KIH0NCiBFWFBPUlRf
U1lNQk9MKG5ldGRldl9mZWF0dXJlc19jaGFuZ2UpOw0KDQo=

