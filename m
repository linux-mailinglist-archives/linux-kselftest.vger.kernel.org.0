Return-Path: <linux-kselftest+bounces-32655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC0AAF7EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239387BDF00
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEE2236FC;
	Thu,  8 May 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c1bysF6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553A22172A;
	Thu,  8 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700434; cv=fail; b=vCLuxsEMZmvinuBqCrV+TvDZnkCRs+5zqYHK5lH7ZAiVKFvwqKZZqAGbnsVaTd85cH+Y1/tn1BV2De6+mSlqKNhVBCdOpNLL+l0e1HNPmdqVJ+9/G7yqqrJl8/ZQf6YYFUtyScngXYKAJBLxQVIjcWWxCMsD7GFATdQeuOBBsGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700434; c=relaxed/simple;
	bh=2Ln1HuKdM/IG1e4CsXpAWdvaGPUPrr3yzlFO9V8mdaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kXUG6NWtk21Pry+F4wX07lFHpeL5xLeKaZwelfAAyuoXnoD2QFF/CDTQvVRQKKZavOmfLFuQvrG/FCrP/YGedF9wVvd8uAWUP9Jb6q8p1+DumDQdEGOB7xHVneu219tpfR92zheARzrDyg4r1pLXNcZ7sBpnHxLoJF53tCwkAQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1bysF6A; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKs3TK2Wht3c5ietoWFz6zOlyENHqycq6drfFSRMavgavR6HhWuL8vVbNuX7kd4ZsTxT6vuQj+3N8mDXjEHUba3WhXKFnt6qxXVeodLF4bz2iK/ImNSJAvcdALtxpWqyD5SrU6mTDBv3INLHqsk9OIWg8JJB6jGQLQa+txxBBlI7tIhvRDYJ7BHxm3T7x+56BplXkdDfNnN5Ucqt5pP1FdtDzEwyXpeYrG7GMtP5l6fFbeOOaZC0zRQ0csmOWj/3RP6UswO09w3aSFY0iP7kR2cudlWB3GFm/NZ/2VcpRWgS6SbgKiQZ8uAHjIhfLB6bggJjSL0inwYagmRknrFL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ln1HuKdM/IG1e4CsXpAWdvaGPUPrr3yzlFO9V8mdaE=;
 b=CWBX790jt1YpHgLgOMIIiajr0LeUSngNcjFr5TB6dTE+AvH76YWSRemQOeReCKyDTsnr97uhDWpQ64wlWu6WL0pXieEArMw6FzNEY+L3mM5rZVHX9V7zvRUbmrmG9jkHsBWZ21M+xkpycClOUAox+Ib5GGtoTopNiQruiKf4gNTmHzE9BSMXxP37Am0WmC0H+RirHPgiJLlBnqkQtNxOeBO9nLMpCvbz/N+pV8awwACEFedJSzsM9GVJlilh7oYVvKpEnUCGjszyjRz0R2+jKF+ettX9zClO1sJP5tKqlGNTpDcTRpDRzcFwFte9LKB6SQ4WU+wyNx+uVlwRtVk37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ln1HuKdM/IG1e4CsXpAWdvaGPUPrr3yzlFO9V8mdaE=;
 b=c1bysF6A8M+3JyjjPtkefT+uWVo3BDtne0MRxOfmGRrsJyELsoFNzTVURQKZMNaJLhXnuMrxje5ywOEtz/ApVa2jqpDuwSxUQjgPbx8GV6NouU1n+JHwZ+oPKs+DxW3nEjCQXckKZhFJRUtMYW3+QXCLMlXm4xcTw5dzLDA+x8citoYYPpmqcLqR7cUJgFU1uhIDVBdDq0+2YVnkJdpoDjjlWtYqxahTx5yua36AuOcpSD12JIHRoDpiuzfJTsDAUa7O9LtaGhIsyWOgQvwJhsC6VMV5Tmz5A1f982SoHOqjkzphV0s0ta1kDcAKtpmnw2P7wMC6qMSBkkRyrQmVbw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Thu, 8 May 2025 10:33:48 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 10:33:48 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Dragos
 Tatulea <dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Thread-Topic: [PATCH net] net: Lock lower level devices when updating features
Thread-Index:
 AQHbvpI68/ihdVxTiEiw4lpvBpBbzLPF1uyAgAAJx4CAAAdlgIABVUcAgAAKsICAAFhQAIAADj4AgADdmoA=
Date: Thu, 8 May 2025 10:33:48 +0000
Message-ID: <dfbf2c60812423a3bcccc06921efdd987a003d36.camel@nvidia.com>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
	 <aBpC9_SgUaAA2P0f@mini-arch>
	 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
	 <aBpRX_afG5X_rT_J@mini-arch>
	 <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
	 <6c0a6b462200847d87221dcd7655b6a746012061.camel@nvidia.com>
	 <e886c3511fbe9cf7e66b0a142183a5375a42978a.camel@nvidia.com>
	 <aBvOpkIoxcr9PfDg@mini-arch>
In-Reply-To: <aBvOpkIoxcr9PfDg@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH2PR12MB4168:EE_
x-ms-office365-filtering-correlation-id: 74cfedd4-d681-45a0-9440-08dd8e1bd165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0xRNm1hWUJGbnlxMEZWeTZiMmY1SG02S3VFZk9FTHh0SFpaUGs5S3FXQmwr?=
 =?utf-8?B?RVlBZUdYRHBkTytVQ2Rxb1BHMXJTM3NITlk3cHFBZFJNTU9hc3hnYlFBK1Zn?=
 =?utf-8?B?MEUzbjZHV0xUMDJNTWYrZHNjNEJnV2VLMVMxdEwxTVVCMTZDOHIvZ2o4QjBY?=
 =?utf-8?B?VGF0Z0d2TU5SVnplMlpqZHNpVWpuOFMvSEV1UjdOYVNMWVljNG1kdlI4dkky?=
 =?utf-8?B?elBqclRvV292ZWFQRkw4ODBpMnZQRGMzaisrNlIwci8rVSthdC9oYXNRSlZv?=
 =?utf-8?B?bHUzTWdKNVhUenU5Z2JOeHF5TWx6OStHUC9vZUlLSEt1SkI2ZHRZeWdSV0Fa?=
 =?utf-8?B?RGRvcTRmcVB1V2x1NzM5b0YyTGV2N0ZMbTc1MnRZUHRoeWNzVjhkb3RwWDhr?=
 =?utf-8?B?MW5aUVpGQU11LzVXSWZ2Zm44MDRoV1BFaUg2aGx5VG5MayszYWwrSGhGTHJC?=
 =?utf-8?B?SVd6UmhzRXI2QkdybjA0TXNYQnFCb0hQNFZiaStjVGpWaXJJNXdxdjRiUDg4?=
 =?utf-8?B?QmlWeU9iSnhMOEdEckQyOFJiaHFWQWFVc3FZREhueGJReENIcTZlUHRXVm15?=
 =?utf-8?B?QXF4bHVMOFA1MUpGZzZlK3oyMUVQMjFsS2hTdGZmd2lLZ1ZNeG11UGc0K0tS?=
 =?utf-8?B?OTMzTWRnSEdUTFJ4cUl3OENiZ0tPZkRXRHJLRTYvYy9mcU5ZZXdac0dINDFG?=
 =?utf-8?B?VGZnS21YemdJWmVrS1VjenM0TWRSNW9FTk85TkZjOEpwVGt5RmRYdXkyRGE2?=
 =?utf-8?B?T2x3TmVRejMwN25iQ1pIVERCZzJXejhxYWtUeHZ2VUpycTVyM1RJMGV0dnVy?=
 =?utf-8?B?Y0tGL3Bwb00xTys4MEJwcll0YmVnYS8wRFFzTFgyMmZPVkJrZURjN2l3UXBt?=
 =?utf-8?B?NUVXbGErSkdscFlnZHNid2ZCL0VDSVBXZjlRd1hwQjJyVlhlbWZnZTZncXZI?=
 =?utf-8?B?MzlJRlRPU1AyZU5pNkhDL1IxdjhRb29ML3ZrRkMvSWs4UHUvRFc4RVp2dDVm?=
 =?utf-8?B?YnNKRVlMTkxvS09HT0ViWklyNHJldXNUVmN3a2xqZ3JZY1BsNU9qdnZNVzhi?=
 =?utf-8?B?cXZxR29PY0xDcXlSMElsemtGdzB2Q3pYVXAzVm42YWhaNG4wMTFHeWRId29k?=
 =?utf-8?B?Smsrc3VjcjlBeE9mY0pWRDZkQkd5ODhsbkozQ25QNGVNZDRIbmI5aWF3TmpN?=
 =?utf-8?B?N3l1ZFdXY21RRUN0QTRiM1dEU1ZkYU8vOXVGWDVlVEQyYXVxd2huUGhmc2lT?=
 =?utf-8?B?WG9kYnllKzZmdlJvaVp2SmE1Q2dBYU5mUmxKQ2hJOHRESXhaT2YyN2RsNzZX?=
 =?utf-8?B?c0xZSVhFUVlZTWtSaEZGV1FOcjllRFRXallMcnBTTnVCTW1IWEZDNnlHbEF2?=
 =?utf-8?B?a1RLRHpsalpqdVRTajFMcEpGMzEwbS9sb2Q4R2pIWHpOcThSVGRiRFB1UWpt?=
 =?utf-8?B?VC9meHhsT1pXQm1xaSs2WWVBYWxDeC9xNHBLbjUzc3RrUGtJdXREL0FSeHp4?=
 =?utf-8?B?WnRBamdpSFlsTUN5MldkRjhpTmYralZFVDBTNWRzeHc0b2YwQnN4b00vSTc3?=
 =?utf-8?B?amhKMXdhaU8vZ1BQOFgzb2IySi9FcEMzM1FMdkhIL1pqNWdiQnIzNnQxODFG?=
 =?utf-8?B?K2V5UWdSUDgzcU1HSkdWVGw1dlZMWGZnWkRxWTVFVUpFM2haTm9aQkdiRm5G?=
 =?utf-8?B?MXM4N21xOUZ0cWdjcWNablB1RVZlaXBDaXhiT1dOOE9DQ2toNXJuV3Z5T3ds?=
 =?utf-8?B?eUJkWDhMcjdjSlY1NTFmUHlWT2NTYStteDJiOVJhOUdiL3RKdEp6QTVoOUs2?=
 =?utf-8?B?RDFUS1ZoT2l3Z3JkUHgvY2kvV2NuVDdzUDQ5SytlQ1lGR1hGOUJhMTVabUtz?=
 =?utf-8?B?UjRnS0NXaDFxZ3gyak13Q1BGNk5WVkUvNHlBS0hMQ0d5enovVlZvTzBSRGVE?=
 =?utf-8?B?MHpiU1hrWWkzbzRsQjAxN0xzeDRnWCtQMGxtN0Eva3lhUEFUSmUwTmVLWVlT?=
 =?utf-8?Q?bQzkmhkczyL18ezDcAoIu9VKVdSjBI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0YwS3F6NUlUZlBmSEYyMlhRb3ZJaWQ2alBzcGFQOFRWVjdVOTJlWEh1aS9L?=
 =?utf-8?B?cGhqbmFDWGhPZ1dxWmVINS9rUFhkK0pCQ2R3MWc1bngwRU1CV0JJcUg1SE4z?=
 =?utf-8?B?a2ZIbm9vakV0cEhHWTdvRUYycSswL3lxZjZEYTJnOHpkWkRSU3FLRVVVR2l1?=
 =?utf-8?B?aVM4U0ovQW9NZWF2MEVpZW1hV3lqMEhUYW9vaTI3YmtPK0JlTFJ1LzByd21t?=
 =?utf-8?B?SjVkWTJkL1pnd1J4ZXkwaXFzYmVlei9nYjd6blhDemg3NCswdE9sTVQvZzZN?=
 =?utf-8?B?UGliRDVsbGNWZzVvcDlpWEYrcXpnQ2Fjb3o3M3NHY0ZTQzRhT0w5eDJDUEZ3?=
 =?utf-8?B?ZnNJM2Rta1BjaCszQVY5S1M2R1BIQkJrSzF6bHp2bDRnM28wMGZjNzk2N0xs?=
 =?utf-8?B?UGVaL3BDM3RRb292N1Z2NVQ3dFN5dXFubDdJYmV4Q1RYaUovK3RZSFRnSDNN?=
 =?utf-8?B?a0VHWFU5anZnY2Fuc081Q3RVeHBzaWFDTUVYZXBxN1NPUGFVNHVVMndPcFQr?=
 =?utf-8?B?cEpITU0yeUNHSWhpSmdLMkFKODAxeC9kNXE2cWFEZlJCQk5JNWVyaUYzdm9N?=
 =?utf-8?B?SGd2Q3l5YUltcWhFZzVJejBoN0ZYc1F5ZGR1ZmJ1VFBNNFVjWDJzWmVkTS9z?=
 =?utf-8?B?Wk5Ta09ESG9pT3hDWEdJOCtLYW5ONmdOVzZvUmJtYldlUFpFQk9VNWhpU1Y2?=
 =?utf-8?B?YnVHY3BnMFM2dER5ak1sYkNUMVNjemkzTzFWZWtmTXlWQjEyRWF6WXdiempk?=
 =?utf-8?B?ZFFkSHZLT3Q3Z1VyNXVGMTRmdkxaL3BxcEJkZU1FV1hRa3lsYnpIdFZzd1VZ?=
 =?utf-8?B?K3g0NENqZXh0TnY5SDN1Sk1ORXVCRlcwUTZKRk1UK2ZnYmpGMEZPM2hvSVFz?=
 =?utf-8?B?QkdxcVh6dWMwd2JRb0ZHc1hZZjRPa2JwcXVyMWtvUVZSOGk4dzY2Z1luY3JL?=
 =?utf-8?B?MlJiQW9WWEkvM0plZTlkdExrVG52YktXYXJadkdld3Q4L3d4RUVuTHUyQzNV?=
 =?utf-8?B?dkdWVllkaytNWTI5SGZDckl0a0V0M092eVVhcHBaUW11TlBQTzBPNlBhbENN?=
 =?utf-8?B?RWlyQU9CWHpzTWJFNmZlNkhZU3FtbGxQSW5YQWltM1QrK0dmdnZBVHVWb2Rr?=
 =?utf-8?B?YTNlQTRaNzVpY2VQRVlsVEc1SmZHdG8vclE2dGhwRzdOakplZ2NnUEI1WmhP?=
 =?utf-8?B?Si9sRktUczBsQXcwTzVOSG5SNXNCWDVaOFRNcG1VbVBjUnVLUFRnUFNNS0ZS?=
 =?utf-8?B?ekVtbVhKOVpVbDlLRWc3TWkyaXduNU0rWnZTM2tzL3VzbTVLekNlOEFIZFpj?=
 =?utf-8?B?Lzg3OC8rd2FLcy9OVFJNL3JlNTg1R3FWeWxOTDEvRDVyc25oNEI5VmNjcFBr?=
 =?utf-8?B?eUdlVTNXbUZlY1piNXBvamFKS2xqMXY2OTJSWXVjOXpIdlBoTnFBREY5SVFN?=
 =?utf-8?B?c0l2WnBtSFEyb2Nia0RYNGdmazNYQS83Ym84bTZiTnNWbEpHRkgyeVlrTFp0?=
 =?utf-8?B?QVZndGhaL3V5YXBjSjhqNW5NWU9NVXpGcU9tbjhhbFRzSEk3TWpBWDFGV25U?=
 =?utf-8?B?WXdEVlllMFQ2WW5yZUJBTXFKc2hTZXRNU3dmZGduN1VtSHUwZEFUSnlQWmYv?=
 =?utf-8?B?ZmJLMnVDYUc4elBBMlBLQzRCb3BKUGJKd21kTHFtdE1rd2VEbWgrckswcmM4?=
 =?utf-8?B?YlBBM3ZueXB2Uk14cEord0E4QTdpekh2QUVUR0FheTJKZW5pbW5Pb2pmYU9M?=
 =?utf-8?B?NC9RL09hRGptc3k4YTN0SFJZRXpLaVRYN1BwUE1vWEVEWVhlMUhhKzcrVlZV?=
 =?utf-8?B?c3l2WnVpTGNtSC9vUC9QaVI5R1RlWjMybzdCbzdYVmVFSGZZUTdUdFM5Nk1N?=
 =?utf-8?B?N3huUnp5alZNVk5aamxWMHdSZUVKaU92ZnhkeFd2ZzR4YTZJQlI1NXNldXFq?=
 =?utf-8?B?OU1yMFJHMXR0U29oVDJpTmw2dlgvSlhSOXBkYW1wUUIvOVFqWE9UblhFWFY1?=
 =?utf-8?B?NDAyRjhQWDlEQXAxS1ZjRk5YOWZtcWVhQVZldFJTeC9XamtydXVHUVRkUk05?=
 =?utf-8?B?ZlpMdjRvUXhmUnZRSWtOQkloTzE4aHdaMWYydll4Qld0dGNYSGduWFJUaXp2?=
 =?utf-8?Q?xNxsioLbkxhgGELjCBFsxHE9M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFB31C1134A06849A55BF06960F598D8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cfedd4-d681-45a0-9440-08dd8e1bd165
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:33:48.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LHJMWDeC6aw0xzt9ibCsQxmmgfStMxR7N2SRAcBtaZ9xfTfwaia3fankVsCDFKBzP8Df/X7pNn4wT1f3JNeyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

T24gV2VkLCAyMDI1LTA1LTA3IGF0IDE0OjIwIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA1LzA3LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI1LTA1
LTA3IGF0IDE1OjEzICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gPiA+IEluIGFueSBj
YXNlLCBwbGVhc2UgaG9sZCBvZmYgd2l0aCBwaWNraW5nIHRoaXMgcGF0Y2ggdXAsIGl0DQo+ID4g
PiA+IHNlZW1zDQo+ID4gPiA+IHRoZXJlJ3MgYSBwb3NzaWJpbGl0eSBvZiBhIHJlYWwgZGVhZGxv
Y2suIEhlcmUncyB0aGUgc2NlbmFyaW86DQo+IA0KPiBIbW0sIGFyZSB5b3Ugc3VyZSB5b3UncmUg
Y2FsbGluZyBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMgb24gdGhlDQo+IHVwcGVyPw0KPiBJIGRv
bid0IHNlZSBob3cgdGhlIGxvd2VyIHdvdWxkIGJlIGxvY2tlZCBpbiB0aGF0IGNhc2UuIEZyb20g
bXkgUE9XLA0KPiB0aGlzIGlzIHdoYXQgaGFwcGVuczoNCj4gDQo+IDEuIHlvdXIgZGV2IChsb3dl
cikgaGFzIGEgdmxhbiBvbiBpdCAodXBwZXIpDQo+IDIuIHlvdSBjYWxsIGxybz1vZmYgb24gdGhl
IF9sb3dlcl8NCj4gMy4gdGhpcyB0cmlnZ2VycyBGRUFUX0NIQU5HRSBub3RpZmllciBhbmQgdmxh
bl9kZXZpY2VfZXZlbnQgY2F0Y2hlcw0KPiBpdA0KPiA0LiBzaW5jZSB0aGUgbG93ZXIgaGFzIGEg
dmxhbiBkZXZpY2UgKGRldi0+dmxhbl9pbmZvICE9IE5VTEwpLCBpdA0KPiBnb2VzDQo+IMKgwqAg
b3ZlciBldmVyeSBvdGhlciB2bGFuIGluIHRoZSBncm91cCBhbmQgdHJpZ2dlcnMNCj4gbmV0ZGV2
X3VwZGF0ZV9mZWF0dXJlcw0KPiDCoMKgIGZvciB0aGUgdXBwZXIgKG5ldGRldl91cGRhdGVfZmVh
dHVyZXMgdmxhbmRldikNCj4gNS4gdGhlIHVwcGVyIHRyaWVzIHRvIHN5bmMgdGhlIGZlYXR1cmVz
IGludG8gdGhlIGxvd2VyIChpbmNsdWRpbmcgdGhlDQo+IMKgwqAgb25lIHRoYXQgdHJpZ2dlcmVk
IEZFQVRfQ0hBTkdFKSBhbmQgdGhhdCdzIHdoZXJlIHRoZSBkZWFkbG9jaw0KPiBoYXBwZW5zDQo+
IA0KPiBCdXQgSSB0aGluayAoNSkgc2hvdWxkIGJlIGxhcmdlbHkgYSBuby1vcCBmb3IgdGhlIGRl
dmljZSB0cmlnZ2VyaW5nDQo+IHRoZQ0KPiBub3RpZmljYXRpb24sIGJlY2F1c2UgdGhlIGZlYXR1
cmVzIGhhdmUgYmVlbiBhbHJlYWR5IGFwcGxpZWQgaW4NCj4gZXRobmxfc2V0X2ZlYXR1cmVzLg0K
PiBJJ2QgbW92ZSB0aGUgbG9jayBpbnRvIG5ldGRldl9zeW5jX2xvd2VyX2ZlYXR1cmVzLCBhbmQg
b25seSBhZnRlcg0KPiBjaGVja2luZw0KPiB0aGUgZmVhdHVyZXMgKGFuZCBtYWtpbmcgc3VyZSB0
aGF0IHdlIGFyZSBnb2luZyB0byBjaGFuZ2UgdGhlbSkuIFRoZQ0KPiBmZWF0dXJlDQo+IGNoZWNr
IG1pZ2h0IGJlIHJhY3ksIGJ1dCBJIHRoaW5rIGl0IHNob3VsZCBzdGlsbCB3b3JrPw0KPiANCg0K
WW91IGFyZSByaWdodCwgaWYgSSByZXN0cmljdCB0aGUgbG93ZXIgZGV2IGNyaXRpY2FsIHNlY3Rp
b24gdG8gb25seSB0aGUNCmNhbGwgdG8gX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzIGZvciB0aGUg
bG93ZXIgZGV2IHRoZXJlJ3Mgbm8gZGVhZGxvY2sNCmFueSBtb3JlLCBiZWNhdXNlIHRoZSBkZXZp
Y2Ugd2l0aCB0aGUgbG9jayBoZWxkIGFscmVhZHkgaGFkIGl0cw0KZmVhdHVyZXMgdXBkYXRlZC4N
Cg0KSSB3aWxsIHNlbmQgYSBuZXcgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIHNvb24gYWZ0ZXIgdGhl
IGZ1bGwgcmVncmVzc2lvbg0Kc3VpdGUgZmluaXNoZXMgYW5kIEkgY29udmluY2UgbXlzZWxmIHRo
ZXJlIGFyZSBubyBtb3JlIGlzc3VlcyByZWxhdGVkDQp0byB0aGlzIHRoYXQgd2UgY2FuIGVuY291
bnRlci4NCg0KPiBDYW4geW91IGFsc28gc2hhcmUgdGhlIGJvbmRpbmcgc3RhY2t0cmFjZSBhcyB3
ZWxsIHRvIGNvbmZpcm0gaXQncyB0aGUNCj4gc2FtZSBpc3N1ZT8NCg0KU3VyZSwgaGVyZSBpdCBp
cywgaXQncyB0aGUgc2FtZSBzY2VuYXJpby4gYm9uZF9uZXRkZXZfZXZlbnQgZ2V0cyBjYWxsZWQN
Cm9uIGEgc2xhdmUgZGV2LCBpdCByZWNvbXB1dGVzIGZlYXR1cmVzIGFuZCB1cGRhdGVzIGFsbCBz
bGF2ZXMNCihib25kX2NvbXB1dGVfZmVhdHVyZXMpLCBhbmQgdGhlbiB0aGUgc2FtZSBsb2NrIGlz
IHJlYWNxdWlyZWQuDQoNCkJ1dCB0aGlzIGlzIGFsc28gZml4ZWQgd2l0aCB5b3VyIHN1Z2dlc3Rp
b24gYWJvdmUuDQoNCiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KIFdBUk5JTkc6IHBvc3NpYmxlIHJlY3Vyc2l2ZSBsb2NraW5nIGRldGVjdGVkDQoNCiBkZXZs
aW5rLzE0MzQxIGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQogZmZmZjg4ODEwZWJkOGM4MCAo
JmRldl9pbnN0YW5jZV9sb2NrX2tleSM5KXsrLisufS17NDo0fSwgYXQ6DQpfX25ldGRldl91cGRh
dGVfZmVhdHVyZXMrMHgzMWUvMHhlMjANCg0KIGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBs
b2NrOg0KIGZmZmY4ODgxMGViZDhjODAgKCZkZXZfaW5zdGFuY2VfbG9ja19rZXkjOSl7Ky4rLn0t
ezQ6NH0sIGF0Og0KbWx4NWVfYXR0YWNoX25ldGRldisweDMxZi8weDM2MCBbbWx4NV9jb3JlXQ0K
IGFuZCB0aGUgbG9jayBjb21wYXJpc29uIGZ1bmN0aW9uIHJldHVybnMgMDoNCiAgICANCiBvdGhl
ciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOiANCiAgUG9zc2libGUgdW5zYWZl
IGxvY2tpbmcgc2NlbmFyaW86DQogICAgDQogICAgICAgIENQVTANCiAgICAgICAgLS0tLQ0KICAg
bG9jaygmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzkpOw0KICAgbG9jaygmZGV2X2luc3RhbmNlX2xv
Y2tfa2V5IzkpOw0KDQogICoqKiBERUFETE9DSyAqKioNCg0KICBNYXkgYmUgZHVlIHRvIG1pc3Np
bmcgbG9jayBuZXN0aW5nIG5vdGF0aW9uDQoNCiA0IGxvY2tzIGhlbGQgYnkgZGV2bGluay8xNDM0
MToNCiAgIzA6IGZmZmZmZmZmODMwZTVhNTAgKGNiX2xvY2speysrKyt9LXs0OjR9LCBhdDogZ2Vu
bF9yY3YrMHgxNS8weDQwDQogICMxOiBmZmZmODg4MTY0YTVjMjUwICgmZGV2bGluay0+bG9ja19r
ZXkpeysuKy59LXs0OjR9LCBhdDoNCmRldmxpbmtfZ2V0X2Zyb21fYXR0cnNfbG9jaysweGJjLzB4
MTgwDQogICMyOiBmZmZmZmZmZjgzMGNmNzA4IChydG5sX211dGV4KXsrLisufS17NDo0fSwgYXQ6
DQptbHg1ZV9hdHRhY2hfbmV0ZGV2KzB4MzBkLzB4MzYwIFttbHg1X2NvcmVdDQogICMzOiBmZmZm
ODg4MTBlYmQ4YzgwICgmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzkpeysuKy59LXs0OjR9LCBhdDoN
Cm1seDVlX2F0dGFjaF9uZXRkZXYrMHgzMWYvMHgzNjAgW21seDVfY29yZV0NCg0KIENhbGwgVHJh
Y2U6DQogIDxUQVNLPg0KICBkdW1wX3N0YWNrX2x2bCsweDY5LzB4YTANCiAgcHJpbnRfZGVhZGxv
Y2tfYnVnLmNvbGQrMHhiZC8weGNhDQogIF9fbG9ja19hY3F1aXJlKzB4MTYzYy8weDJmMDANCiAg
bG9ja19hY3F1aXJlKzB4ZDMvMHgyZTANCiAgX19tdXRleF9sb2NrKzB4OTgvMHhmMTANCiAgX19u
ZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4MzFlLzB4ZTIwDQogIG5ldGRldl9jaGFuZ2VfZmVhdHVy
ZXMrMHgxZi8weDYwDQogIGJvbmRfY29tcHV0ZV9mZWF0dXJlcysweDI0ZS8weDMwMCBbYm9uZGlu
Z10NCiAgYm9uZF9uZXRkZXZfZXZlbnQrMHgyZTAvMHg0MDAgW2JvbmRpbmddDQogIG5vdGlmaWVy
X2NhbGxfY2hhaW4rMHgzZC8weDEwMA0KICBuZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4NTIvMHg2
MA0KICBtbHg1ZV9hdHRhY2hfbmV0ZGV2KzB4MzJmLzB4MzYwIFttbHg1X2NvcmVdDQogIG1seDVl
X25ldGRldl9hdHRhY2hfcHJvZmlsZSsweDQ4LzB4OTAgW21seDVfY29yZV0NCiAgbWx4NWVfbmV0
ZGV2X2NoYW5nZV9wcm9maWxlKzB4OTAvMHhmMCBbbWx4NV9jb3JlXQ0KICBtbHg1ZV92cG9ydF9y
ZXBfbG9hZCsweDQxNC8weDQ5MCBbbWx4NV9jb3JlXQ0KICBfX2Vzd19vZmZsb2Fkc19sb2FkX3Jl
cCsweDg3LzB4ZDAgW21seDVfY29yZV0NCiAgbWx4NV9lc3dfb2ZmbG9hZHNfcmVwX2xvYWQrMHg0
NS8weGUwIFttbHg1X2NvcmVdDQogIGVzd19vZmZsb2Fkc19lbmFibGUrMHhiN2IvMHhjYTAgW21s
eDVfY29yZV0gDQogIG1seDVfZXN3aXRjaF9lbmFibGVfbG9ja2VkKzB4MjkzLzB4NDMwIFttbHg1
X2NvcmVdDQogIG1seDVfZGV2bGlua19lc3dpdGNoX21vZGVfc2V0KzB4MjI5LzB4NjIwIFttbHg1
X2NvcmVdDQogIGRldmxpbmtfbmxfZXN3aXRjaF9zZXRfZG9pdCsweDYwLzB4ZDANCiAgZ2VubF9m
YW1pbHlfcmN2X21zZ19kb2l0KzB4ZTAvMHgxMzANCiAgZ2VubF9yY3ZfbXNnKzB4MTg4LzB4Mjkw
DQogIG5ldGxpbmtfcmN2X3NrYisweDRiLzB4ZjANCiAgZ2VubF9yY3YrMHgyNC8weDQwDQogIG5l
dGxpbmtfdW5pY2FzdCsweDFlMS8weDJjMA0KICBuZXRsaW5rX3NlbmRtc2crMHgyMTAvMHg0NTAN
Cg0KQ29zbWluLg0K

