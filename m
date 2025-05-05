Return-Path: <linux-kselftest+bounces-32405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C7AA99D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FF7189029B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198326A08A;
	Mon,  5 May 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOMPUeg1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB418C322;
	Mon,  5 May 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464192; cv=fail; b=kYw8b4dS4DStsBMd9SKgQge7ffvIEa8WlflhX2lta20q4L/3DB/ml8pfOXqK7uRncRb85fi+Bvgcfo9Cv6Hy5E8BRD4tM/GrOt9upIjAbJJeoOSre8/QeqJOZkfMGYq8UHacNIZngDBhxMPv/oAXLwTiBDSSkFCGOeUAYmXBXf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464192; c=relaxed/simple;
	bh=keyg/9v+aZushOnHnPvDYA7HyUcfd0knuJg/AEZp3IA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQikDf4YBMS9xA1ODyt4wzj8yEZYhBmxwavy3IC/cGjcfcF6uxT55ch6rd/FZQYLQ3tNkYbQ0din8neKTpgzVkEas4N1uXhUFcu+X6fN/iEff4Ev6r9igWMABeqr+AsMety66EpcBSBvnRmwJY/GS6HhVHNCPKG1xC7giuWerlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOMPUeg1; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzQFlGTHw49u9yfsCb8AerY//WBItMNIEGySpjYM9Ek6cQqDK9K3sQHT6K5GBuDOLAx06RouTJbhMNQipkn6Vxhuls957GVSkTb1GAXhXwpQdtM3MPR0CPvwGVndIx7YA0H27NlWv/Hq90O7xTOgJERY8zwM3J7AhjihE6we/+f0UTYoBS+L21nDfOlq28l5sfC4Pyi81cf/t6QXroA1STtbUYp7lpmbV3KBoDTG/hjtpGfqC+3U0uQGRBPt+cOXi7Mrr2TxJscurk0sbGkEuu9SnKrFB35NiCY9ylhpDNQMUSMBkwxyMjubNNT7Ru87eJ5dRkbyFMX/qmdaZDSU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjjoBsMpREQy5vE3GtrRfJjR68T+koDjMVZphYHHwLk=;
 b=ulOo3fXPEYhqjzqlvCl745gYpBeawaFF4TUSbIljWPr/YABggUjIsrf82sb2F8C3DzIibVTgpIa7AOUeODGcD2yS8Z9RGWHbhfi6A+jy3IY0oUeKDwcGRCY+RecMdvG/NL6OPPzfIT/ThF2t2HddZwABW4b/uaQGodpTXKWQoIU0VHD4aCJXbNBHJc4paSX5YBYjYg78J7gZ054HitZ+PgepdQLxNS34gy96RXVBj9mi4Fd/VRLhgc0dBfoUYkyItMj6dwMna+T5CkH8aFKON1UuOKnmv953F7BSJsoBRIBplWQyoMD3vHfpChM8740QVz4+s+i4JdSnfos5LkTtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjjoBsMpREQy5vE3GtrRfJjR68T+koDjMVZphYHHwLk=;
 b=VOMPUeg1BX5ayd0EpHcmOvPgJFRvFdsf03zFkRuEAbjJiRQkWdvtwHu5TPnLfn7UuYVg5KTWiDGgClAW5MfAlzDES4lDkOpaLEyvFmSkOxAcc60JClCnRXnni0Rd/PCHS+GNeoA9B0QTLsJpeBZzMjk6CIjn8vHhQFZ/bxm6a7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 16:56:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 16:56:27 +0000
Message-ID: <ec43f447-095e-4baf-8610-8279b565f162@amd.com>
Date: Mon, 5 May 2025 18:56:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, skhan@linuxfoundation.org,
 song@kernel.org, alexei.starovoitov@gmail.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com,
 simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-3-tjmercier@google.com>
 <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
 <CABdmKX2iNk22h-KxUr4yvZO80yeRRjMfoC7yjiZ-aR_f1k402g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX2iNk22h-KxUr4yvZO80yeRRjMfoC7yjiZ-aR_f1k402g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:208:234::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 060a0f8e-c03c-4418-bba4-08dd8bf5c69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmUvMkxKcldSdlpwVmRmNUZ6YWhDQ1JtVnV6bHlJZXFxR3lPVWppV3lPY3gr?=
 =?utf-8?B?MEFUcER6YkJWMUNrSXViRnlLa2YwdEk0L3lrQ2xUUlB5MXZDM0hoUUZ5Z29l?=
 =?utf-8?B?VVZvalo4Y1dCU2pjZXVxWk9OMjZZcXlSTGV6bFUzR0pVT3lSNm9FK3JWdW1p?=
 =?utf-8?B?ZVdVRkxadzNvanBidWV5QXJSTHlaVjFHK2FpaDRwWUJCREcyaE1SV3Q2VEsy?=
 =?utf-8?B?M0MxS1VBb0lhYUJQMmdtdFFndkVGaGJ1eU94dlpWdnFvaUQvTUtVWEZISEJC?=
 =?utf-8?B?Ry91QzNlaFNoeTlKTUlQRTNlbktnNEUwS1hlanMyMzBVcUROR0d2RkFZTUZn?=
 =?utf-8?B?Tk13TmFCNjZrUWVHdVcyOHp5citWZlBUWlZuRXRqNFJ4bk1uSmNYVzdMQWJs?=
 =?utf-8?B?bkZyOHBBR3FJaitrcVIzQ2h4RVlNaVVsUVRkOHJiL3JhYXA5N0dhWHQ2V1Ru?=
 =?utf-8?B?TFlDa1lGWUhsVTQwenZpU1ZIb2FtNjlRRmtSeEZyenVJc3I0Z0Erb05mSllL?=
 =?utf-8?B?cnA4clQ5VTRlMEtCQWFReGNkV2pJSk1GVWVFcjVDbVNLSzREZVVzUTU2UkJS?=
 =?utf-8?B?YkNQZStUSXV1a1V0azlnanpGTC84ZmRFM3JBQ0VGbzlNclFsWlhHS3VUdW51?=
 =?utf-8?B?SXZVd1drREZ1eVNCV0JuU2M5WkFpeGY5akZqakFsdkRkUzM3MkI0cUpMMVVO?=
 =?utf-8?B?bDVFTEpvbGdMM0RUd04zN3JrOUc2aUNmdFZvTFBXYWJuTG8zSlR6ajNSb2p5?=
 =?utf-8?B?Q0ZlZWpXeWc3S2VXZzhWaDlzWmZLRlJtRVY3ak95ZWt1WGp0Y1ZOeDM1MEpU?=
 =?utf-8?B?Q2RUUm9hSmd3YndkL2ZOdVRIS2RxVzl3SzZlQ1gxaEk0Vi9Yell2NHRlUlI1?=
 =?utf-8?B?WGdDVWU2K0FXQytMT20yWDhyeFMxNHRCQ3JrN2I2aFZaaHhuTFc0SnZuM2ZP?=
 =?utf-8?B?QjJYVjJCQXFhdzRmSFlwTDB3TzkzRStFZU0yZjZQWmx5VU5OV1laZGVNcUEz?=
 =?utf-8?B?WWdBazFhWU8xNVBOYTBGY01wbFg3K01uR0lxUmpHNkFtZW8xWGpycEhGUUdx?=
 =?utf-8?B?THJNZ3Y4di9FWnRrb2txVjZ6czZVQkU3Um9WMmJwK2wvU25yeThWRm1lZjBO?=
 =?utf-8?B?allxR2F4Sld3bTZRTmRpaFE1cEdaL3FLNjRCQXBKbVljV2FNL05KdURrTEhE?=
 =?utf-8?B?aXBWVHVYNENBamhubnE0ZkZVMDRVREFMbmRhTTdYNDI1UWoxOVYvZlNBUjVC?=
 =?utf-8?B?MXpwNVBhTUhWdGZrUCthODYycm14WDVyOFpXRS8xOCtpejlQVVJlSTBXM0tG?=
 =?utf-8?B?QnFaQzhlYkRFaHFkOUNFK0FEamRURnE2ZnBhUlZPWWRZeTFFbmduYTNUN1BW?=
 =?utf-8?B?YlJVb2VzRlZNNzEwV0JDNW8zcVhNUGxKY3ZVa1A3ZVlYMlhUUVQzN0taTThI?=
 =?utf-8?B?TmVaeEdpZWFZUXp2ZGZWZ1BYT2ZsdElKbEptc2poWkJFdWR5T2E4bStXc29j?=
 =?utf-8?B?a25CRVVzUEdhY0JJWkdQeGNoRkRTamZXcnFIeTd0cGh6aXdFaFpsd1ptWlpn?=
 =?utf-8?B?Y1YzU0RNV2R0M2lJRHYreDVFU0xwLzV3YjFic0xwb0hVdnRmSkkxa0NaTlNS?=
 =?utf-8?B?dUVzWERIdWJyOXpyMHhLV0dVNEttZFhzc2N6UW1DRFU5MU9IdkdnbkZDVFFG?=
 =?utf-8?B?dUlyTEE4ZUx2d2loNTF4bkhUK2Z0SVdFR2JVZjRHU2JPTjRTbnI1TlFTMjJ4?=
 =?utf-8?B?dXFMbVZMSUdJUERodzdVOFVBbEJoQkRUUHBSTGFhM01HUVgzNWhYZzJacE9V?=
 =?utf-8?B?VEU5S2tzMVQ4anErMlFtdGc2N3QvanU1SHVLb1lhdXNkNkxTYkV5QThXN0tz?=
 =?utf-8?B?R1ZhaGZTdWduREZhV1diOXo4M0k5aGgwT25DdHZsWHlqY2xGTmlTYkF2aXVr?=
 =?utf-8?Q?K6qp108A0fY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0IxMlBVYnhlNkx5Tk5KQmJYMnNrbFBmZjBBUkowMEtLTWpmTjN5ZFF1d05T?=
 =?utf-8?B?Y3kxYmR5UURTbUoxRk8zTnphVHZlODU3cFhqT1ZwSDE5a0N6MFhkU2dscWhr?=
 =?utf-8?B?TzBEK0FPRCtWelAzVVhHcEVKSWJhNm1MaWhab2lKM0pacDBmR2EyZmw3ckJl?=
 =?utf-8?B?ZjZPVEJYc0YwV1A4dEpyMElRZGZmS0c2OURXUE9kWFFVeDBIQytyb1Izck9s?=
 =?utf-8?B?bVRjVlVxV3hjY3RyMkhxSE1LQURxdWUyQlIxQ29pT2N0ZHRBRFdkQ2ZweXRC?=
 =?utf-8?B?UGxPOHlHSVZ2RkczSXJMU3ByMEVyS01ueDE4Y0pKZWRNZ05NdWlGU3FZWjJG?=
 =?utf-8?B?bHcxb3hTZFl0Z2orU2VRSUo4TGJNNmd3aCtrNVZJeEdPc0diVnZxQktFU2lQ?=
 =?utf-8?B?Tk1TcWhNbkxJVzZud3lxd0dlYWZWMUIwcTFJUFVuc0QweitrY2pwaWJoVWU2?=
 =?utf-8?B?aGRjUUVtUkhpRyt3RW1hTmJsMlBtR2oxUlQ5bDcrVC9nRE5RODY5SDg5UzJn?=
 =?utf-8?B?SEZCcmRPKzBHb0dxWUpIRG81aDVRaVk5OVlnZTE1OUF4OWhhdjNibS96eklF?=
 =?utf-8?B?SkI1cDZQM3dEVXBiN3hvWDdRT0FUdjFPc0ZmM1Y0TzlERFZzWUttemtQSEFm?=
 =?utf-8?B?VTJaSk9jSm5LS3pmdU5mZzdralpjMFBWZXZMYlZONTNCRnViaksraUlhU1Va?=
 =?utf-8?B?cUtRZlluWC9kQkdnaFVQWTZKd04rLzI5ZVBhQW44VXhxdEY4MGVoSG43TGxl?=
 =?utf-8?B?bURkcUVwalZJejJrTGtKS0dRb1VOekl3a3lhWHVYWVBKTGEyZDMyN09KMlF5?=
 =?utf-8?B?Q2E3blRqVGZ1ZGIzNklkczA0ZFo3amhQbUxYcWtQS21uZkJ2cXZ3ZXVnenJD?=
 =?utf-8?B?VzlNTUx3YVF5N1hDYy9sdGxaWDR1ZFNBQjl4aUZ6by9sSTgvTGl1VTBvbjkz?=
 =?utf-8?B?b2lsY0tsakNPdDBPY2VKYUN3NjFpZC8zeXhhSXVhWGxTa1p0bkg2eW9MOWdo?=
 =?utf-8?B?S09FdGx3bFhMYk8rMGJhOExqMDd5OFhZR0gySmhXL25vRFhNa05QNnBKYlJ1?=
 =?utf-8?B?QUNObEJ1dTNwQzNCUGpYNXFqdjhaOFhCYkcyZ1RvdGxRYWhsUkp4VC9NMlp6?=
 =?utf-8?B?RkhUQTNLSVY1RGdNN1F2c2Z2MlMwcEMyTmpYeFQxanM5ZDNhMnRzMWJYVVVk?=
 =?utf-8?B?SzBjRUJSb2trVkJmMkFqbUZXOTFUK2VKczQ1TXY3MU1iQkxSWTB0d0s2UnE2?=
 =?utf-8?B?aXBydHlHTVNqT09LL04vQmJTeC9TTUtwZllQNllGNlJzaFNOSDFzVFViQUl6?=
 =?utf-8?B?VitEOXMrMXVLZDZUNzJaOHJaNVllN2RjakRGU1Rzb0wwWFRXR0ROL2VsNFg2?=
 =?utf-8?B?b0RNOU5OV3dDM2NoVksyZzJVdXBNTXdLMkZYcmZGRWxwUnNMSytPK3NWK2pO?=
 =?utf-8?B?VTJodFl3SE9GdkhJMjhQdkdHZVRCMkZuRTlVVGk2Rkc1SWxaZnpBRnE2VUNK?=
 =?utf-8?B?UE1ZY2E3dUNBaStiZ1o2LzM3c2EvbkJFTk5odElCSFBxbkc3bUh6bEVlSHoz?=
 =?utf-8?B?UmJaZ1VlUnBzaXVXQ1VJSnRSRk9jZHdJUDVDRVMrbGZxazlMRjdab1pGQWo4?=
 =?utf-8?B?SjNnTXlqaDNlNHVrQWFnN3MyZkFuVFRWejM5bEJEQ2FTZ0dkdVNvSmVDUUlq?=
 =?utf-8?B?c2pMRE1MeUF0U21iYXNtZGlKWlF3eVBRV2tDcUVidjFQUW9wdzhobUtibkNh?=
 =?utf-8?B?T2ZqbnVpT0R6cjd6cjl1Mm9DbUJ2bTFqVDljczIyZ2VUV2UrNUpubXpKVm1B?=
 =?utf-8?B?RlVrNVFkQXdDR2xqK2I3TFlmSDlvczlUTU9EaGhtbUw1K3h5YmtXM3V6UDFl?=
 =?utf-8?B?VHBzNWNodUVGRFNYV3c4SlBWSm9qT3I5SStvU1RabXovUlNLRFJIdVdsckJm?=
 =?utf-8?B?OFlTU1JwaFlGaDU3WUtWbnl0S0IwS2VSOUFTSnFkZ2ZNQm9LY3AvWHF4Wi9V?=
 =?utf-8?B?TmFRVTN4WWRYNUdUM29ycy9oSFdHbDVoSWZVV3ZwVit6dS9nUklLYWhCcTBJ?=
 =?utf-8?B?NWVhd0xLUnNkd0VrY3RDbWFFWmQ1ektRNThoTmQ5RmZ0YTBiSkc4eFFMbWcz?=
 =?utf-8?Q?tyYjLUtShCUP+XmzxYHcwsv9M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060a0f8e-c03c-4418-bba4-08dd8bf5c69e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:56:27.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVN4VsBgAi70pPXkYHQopz5rO5uWot/4dQW2Xf16bfElYavR9pNchufmugj0KfjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

On 5/5/25 18:33, T.J. Mercier wrote:
> On Mon, May 5, 2025 at 4:17 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 5/5/25 00:41, T.J. Mercier wrote:
>>> The dmabuf iterator traverses the list of all DMA buffers.
>>>
>>> DMA buffers are refcounted through their associated struct file. A
>>> reference is taken on each buffer as the list is iterated to ensure each
>>> buffer persists for the duration of the bpf program execution without
>>> holding the list mutex.
>>>
>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>> ---
>>>  kernel/bpf/Makefile      |   3 +
>>>  kernel/bpf/dmabuf_iter.c | 134 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 137 insertions(+)
>>>  create mode 100644 kernel/bpf/dmabuf_iter.c
>>>
>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>> index 70502f038b92..3a335c50e6e3 100644
>>> --- a/kernel/bpf/Makefile
>>> +++ b/kernel/bpf/Makefile
>>> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
>>>  obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>>> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
>>> +obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
>>> +endif
>>>
>>>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>>>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
>>> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
>>> new file mode 100644
>>> index 000000000000..968762e11f73
>>> --- /dev/null
>>> +++ b/kernel/bpf/dmabuf_iter.c
>>> @@ -0,0 +1,134 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright (c) 2025 Google LLC */
>>> +#include <linux/bpf.h>
>>> +#include <linux/btf_ids.h>
>>> +#include <linux/dma-buf.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/seq_file.h>
>>> +
>>> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
>>> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *dmabuf)
>>> +
>>> +static struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
>>> +{
>>> +     struct dma_buf *ret = NULL;
>>> +
>>> +     /*
>>> +      * Look for the first/next buffer we can obtain a reference to.
>>> +      *
>>> +      * The list mutex does not protect a dmabuf's refcount, so it can be
>>> +      * zeroed while we are iterating. We cannot call get_dma_buf() since the
>>> +      * caller of this program may not already own a reference to the buffer.
>>> +      */
>>> +     mutex_lock(&dmabuf_list_mutex);
>>> +     if (dmabuf) {
>>
>> That looks like you try to mangle the start and next functionality in just one function.
>>
>> I would just inline that into the dmabuf_iter_seq_start() and dmabuf_iter_seq_next() functions.
> 
> Primarily this is to share between the open coded iterator (next
> patch) and this normal iterator since I didn't want to duplicate the
> same list traversal code across both of them.

Ah, ok that makes a bit more sense. It would still be nicer if it's in two functions since the logic doesn't share anything common except for taking the lock as far as I can seee.

>>
>>
>>> +             dma_buf_put(dmabuf);
>>> +             list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
>>
>> That you can put the DMA-buf and then still uses it in list_for_each_entry_continue() only works because the mutex is locked in the destroy path.
> 
> Yup, this was deliberate.
>>
>>
>> I strongly suggest to just put those two functions into drivers/dma-buf/dma-buf.c right next to the __dma_buf_debugfs_list_add() and __dma_buf_debugfs_list_del() functions.
> 
> By two functions, you mean a get_first_dmabuf(void) and a
> get_next_dmabuf(struct dma_buf*)? To make the dma_buf_put() call a
> little less scary since all the mutex ops are right there?

Yes, exactly that's the idea. The comment above is good to have as well, but it only works one way.

If somebody changes the DMA-buf code without looking at this here we are busted.

Regards,
Christian.

>>
>>
>> Apart from those style suggestions looks good to me from the technical side, but I'm not an expert for the BPF stuff.
>>
>> Regards,
>> Christian.
> 
> Thanks for your comments and reviews!
> 
>>> +                     if (file_ref_get(&dmabuf->file->f_ref)) {
>>> +                             ret = dmabuf;
>>> +                             break;
>>> +                     }
>>> +             }
>>> +     } else {
>>> +             list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
>>> +                     if (file_ref_get(&dmabuf->file->f_ref)) {
>>> +                             ret = dmabuf;
>>> +                             break;
>>> +                     }
>>> +             }
>>> +     }
>>> +     mutex_unlock(&dmabuf_list_mutex);
>>> +     return ret;
>>> +}
>>> +
>>> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
>>> +{
>>> +     if (*pos)
>>> +             return NULL;
>>> +
>>> +     return get_next_dmabuf(NULL);
>>> +}
>>> +
>>> +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>> +{
>>> +     struct dma_buf *dmabuf = v;
>>> +
>>> +     ++*pos;
>>> +
>>> +     return get_next_dmabuf(dmabuf);
>>> +}
>>> +
>>> +struct bpf_iter__dmabuf {
>>> +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
>>> +     __bpf_md_ptr(struct dma_buf *, dmabuf);
>>> +};
>>> +
>>> +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
>>> +{
>>> +     struct bpf_iter_meta meta = {
>>> +             .seq = seq,
>>> +     };
>>> +     struct bpf_iter__dmabuf ctx = {
>>> +             .meta = &meta,
>>> +             .dmabuf = v,
>>> +     };
>>> +     struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
>>> +
>>> +     if (prog)
>>> +             return bpf_iter_run_prog(prog, &ctx);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
>>> +{
>>> +     return __dmabuf_seq_show(seq, v, false);
>>> +}
>>> +
>>> +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
>>> +{
>>> +     struct dma_buf *dmabuf = v;
>>> +
>>> +     if (dmabuf)
>>> +             dma_buf_put(dmabuf);
>>> +}
>>> +
>>> +static const struct seq_operations dmabuf_iter_seq_ops = {
>>> +     .start  = dmabuf_iter_seq_start,
>>> +     .next   = dmabuf_iter_seq_next,
>>> +     .stop   = dmabuf_iter_seq_stop,
>>> +     .show   = dmabuf_iter_seq_show,
>>> +};
>>> +
>>> +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
>>> +                                     struct seq_file *seq)
>>> +{
>>> +     seq_puts(seq, "dmabuf iter\n");
>>> +}
>>> +
>>> +static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
>>> +     .seq_ops                = &dmabuf_iter_seq_ops,
>>> +     .init_seq_private       = NULL,
>>> +     .fini_seq_private       = NULL,
>>> +     .seq_priv_size          = 0,
>>> +};
>>> +
>>> +static struct bpf_iter_reg bpf_dmabuf_reg_info = {
>>> +     .target                 = "dmabuf",
>>> +     .feature                = BPF_ITER_RESCHED,
>>> +     .show_fdinfo            = bpf_iter_dmabuf_show_fdinfo,
>>> +     .ctx_arg_info_size      = 1,
>>> +     .ctx_arg_info           = {
>>> +             { offsetof(struct bpf_iter__dmabuf, dmabuf),
>>> +               PTR_TO_BTF_ID_OR_NULL },
>>> +     },
>>> +     .seq_info               = &dmabuf_iter_seq_info,
>>> +};
>>> +
>>> +static int __init dmabuf_iter_init(void)
>>> +{
>>> +     bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id = bpf_dmabuf_btf_id[0];
>>> +     return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
>>> +}
>>> +
>>> +late_initcall(dmabuf_iter_init);
>>


