Return-Path: <linux-kselftest+bounces-37982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4DB11B6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9071CE28F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D852D4B66;
	Fri, 25 Jul 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BfNgBgy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2107.outbound.protection.outlook.com [40.107.92.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F272D46DF;
	Fri, 25 Jul 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437679; cv=fail; b=YiJVXbhFC9Gun5G4AiUmHuCndaJBZJKnZ7OEoxKehQycv05+Ku9GULzSOyKeI3dxh2mccSHEampSQ2M4UVa6Gnk/ObeIMXVbXoIpX1O9DsPYcJvuIQH1s/fOoTVltL/8Kmi33gSeAteE6UaySSuxqf27g8NHNb4PZyCZg016qhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437679; c=relaxed/simple;
	bh=pHjOD7/zEuAIilb+U+dUQrAxUOvI7EN8doBNUhTq+VQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Joq2/xHOsRC+N8PMnE5S1vkShwNDD5NltrEoBBeWA52QmMN/LN9u+fC/nemAfCOeCUMepYVxe8VNWgJt97zROmukWklFrodNLyFb0tWh1Jx+9unupPBsZbwNFs0a406L4NvCnYKQ67eBSNuMwtEd5W6ZdupAKyWP9xODnjGfjmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BfNgBgy0; arc=fail smtp.client-ip=40.107.92.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XygYQLocamtLXfc3/HraW4kNALlV5S6mzEkENAngqHsiJrsQWWaTyf0sRXGpBgWA9L83TGwU3tNERTIs2plY653Edi8fSrQR/fZtLfZUpN4RzT4i1uVnzBEskc15O96tAMatJn6bKlyI/NQOjN0BfQmL9qnD+j6h6rw+ejeCx4LwfYyCGHRn96n0pn1Bkqd0cnvqNh5OnbNDy3j08Qv4qz+v9oObqGycRiqi4xFqng/11wxYPZpXHEipl49Vad7qgXsc5iqo1+gJwHhS2fTlpkjhNwP2jkeTxr2YX0ig1Z/vd9TyjVIG8/Cs0iC2Mfff69ET9x6wCwLmr8PeTVBi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzNBfVGqB30JnX6wswO/vX3AbqnEPvnL+sx61WsjhoU=;
 b=Wz5bB9MLy3iifAG2lyH+7i32FUjwFg1XxKAHYQ3S54hEG3sq4FqQyYHaCUxGWXWZaLnn2dosDWctu+1DYKDYMnErCLjS8nrcE3FX7ju54ewmL+quHsruoq5RYYyHNafUNGjNgdY1xLlpQbeqXFWt4dySvcVl5wAr8kzPIEN0W+fHpbOip24Ahj4ZN+/h5Sir9OgsX7ntwxSg8Ay6MjEpop/GqMUVryiyR7lYZRMYDUFp/gJHRyhCOYxRhqUu6h5Wgxoqi5YGnjkLbN/COBRDGJCs0De1rzb3lDfz9ebIO1Xix2aJMFrlMAAXyDx5OKkFhvflQXN7NE+yY8enBi+xhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzNBfVGqB30JnX6wswO/vX3AbqnEPvnL+sx61WsjhoU=;
 b=BfNgBgy0B0j3xkK8EzUrQ/3c0NjnewQg+hxcEUij3NsswIj5x8OxWb2SEbs9mQFMbuE1FoO2GZR2mb4VW0kgK0fz279DqBhgRsh/tjt//465QVynsN9xKlzFet2ZvMfKed6h+3Jmf2IZ3sEIrpqcxcoJtOZlA8kgSuVLWrzvAU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.23; Fri, 25 Jul 2025 10:01:14 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 10:01:14 +0000
Message-ID: <ccd8caba-95b9-450e-afb1-deb0c42b781b@os.amperecomputing.com>
Date: Fri, 25 Jul 2025 15:31:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Auger <eauger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
 darren@os.amperecomputing.com
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <92c7e99c-5574-422c-92f1-62d5cde58fec@redhat.com>
 <7bf7bd52-7553-42a7-afdb-a5e95f8699b5@os.amperecomputing.com>
 <86a56veiyy.wl-maz@kernel.org>
 <3be548bf-aee4-46ab-bcbf-15bf629b24da@os.amperecomputing.com>
 <86jz58c5ut.wl-maz@kernel.org>
 <9d5d82f1-b488-4b0a-98c2-27e95d63fc5c@os.amperecomputing.com>
 <867c12czux.wl-maz@kernel.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <867c12czux.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH0PR01MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: c14dee29-f487-466b-d691-08ddcb623090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1VOUFREbTFHa3lleHA1ZTZtenpRTWN6eEwwWE1sa3JKbzZpVUhJR3AxbEtk?=
 =?utf-8?B?eTg4OVBnbEcyU3NsVStGclZHVzZvcGk3VTdKNnQvVGtCVkFRb09YM1VibHVP?=
 =?utf-8?B?VW1lV2ZTRWg5dEN2VmVpWXNOQ0QwYkJ6bnpLRWFibWxUbURRV0gyNE04MjVu?=
 =?utf-8?B?c1RNVlAzQkd3bTRZVEZFbW5LeElCWVlYVjh6Nml4b29MVEloUG9GRGVseUhq?=
 =?utf-8?B?TG1qWDgrVnU2cW9qcTlNUys2cm1leTR5SUVyd1g3Ti94akU2T3BnVnc3OUlw?=
 =?utf-8?B?cGNXalBKdWs1WnNsUEtGMUlYWStva1ZPZFRGWldkMkRDeStxT0tvMWRFQTE5?=
 =?utf-8?B?bVhCM1lpMktWbDV4WTJuRDNBVHo0V1RZazk4WHBHOWgxMFYzREo5K3NWajBi?=
 =?utf-8?B?YWNySGdPbEc1a3BLb0FsWFRnbko0dFo5SE5zWEtwTUxBekdzaU5rb0VUdDhB?=
 =?utf-8?B?ZWNwL1V0UkVhSXhJN1kyRGYxY2wxaWpUZXp2bTE4NDBsT3JZNEx3dkdqdXIw?=
 =?utf-8?B?SlZCQVhCQk5SL2pDN2xQTzJIdmRRNSsya3ZCTjZLb1VBYllpdWU1WFBZQTlu?=
 =?utf-8?B?UnF1WmlXYU1vU2I4RWhGOFNBNnJmZ0FjMU1nRm5mUSswL2pwSDVmVE05RENE?=
 =?utf-8?B?eXlJaEFrRWI5T0N1WnJyNUFkSVJUdkJONDNObW5mWmdyWThIYUZmMmtaV0dY?=
 =?utf-8?B?NFRCdmxSOUhwSmlEejdwUDRuMFRnWis5aDh4K2ljK2d3TmtYR2JMYVdqd0h6?=
 =?utf-8?B?Y0FnMnhpbFM0TS8vM2huZ3p0cVoxM0dFRVVzeERrcWtvUkJxTUpSYyt4a0tF?=
 =?utf-8?B?QU5tbGxpYkYzMlp4L25lT0ZPdWRsa0MyVklwN0htckVBTVF1Y01ROW1haWhZ?=
 =?utf-8?B?YzJEamR3enlteFdDdzFlMXNJYktTanNHZmR6SENWcjlMSm5tSnkxMDlSTlFT?=
 =?utf-8?B?U3NYemowUFQzbU1VcDAweVJrQVo2QVV4MFNTbFVlb3FQQ2o3aXlIZXZPQVE4?=
 =?utf-8?B?WWVYS2w4NlZKdmgyWVhoUVRrRGE4WUlsVmVkRnBYMStpV3poV2pWa3BSRmd2?=
 =?utf-8?B?MC9BQzhLODlXenBQNjV3ZHYwa0NnVXlBSlIyeGR4UmVIeEJ0K01KYTQrSWNm?=
 =?utf-8?B?VXFrWXU1VnhHbTl4ZUVwTlZqTWVyL2gzRGVUcDZORGdZclBOL0d3UjdTdzBj?=
 =?utf-8?B?SEZzZVRnOEJSNnVwWUZzUTVHUFZzN1k3dkJRWnJmZjlCeUxCSlVHbk50enhj?=
 =?utf-8?B?ZE5ZZ3BMb3dCa0Y5S0tRVlpXcTlTcHZyaW5FMTIxa3JkaWd3eU1yKzdLczA5?=
 =?utf-8?B?Rk0vb0kzQUdoY0laUGR4d3RiNm43d0pIRmtGN3EwOW5GTkNqdTNTRXBPR1lo?=
 =?utf-8?B?eVJHZHhudmE0dWQwakxFeWRiT05rbTJJR3hiNnRUUXA3TnhBc2R0TTRXckpV?=
 =?utf-8?B?MXVUdGlGbXRaYkU2NWFSaGM3dXFGWDBna2xZWEJrT2tCNkFzRXEzQkoxZnpm?=
 =?utf-8?B?NWFsbWlWclNqTjdCOXlNQWpRaUVZYjY4bjFxVmVpMlRaTkNhSFlxOUxQZCsw?=
 =?utf-8?B?UUxjMjdFKzViYkQ0NVlTcU1ZaDAvdjdwMGU4VlhFMzd0dzhsUnIxOVdIbU80?=
 =?utf-8?B?NkZCMWtWQ3E1S0FkMFl0Um54Q04yNjRWeEJlMVJBdjRORXNrMThPc1Q4ckVp?=
 =?utf-8?B?dXArNGZXWGZKT0VOcUFXQ0J1cW1WR2MwMjRjUGlFVVFVZnlUbGFnZHdLRm5x?=
 =?utf-8?B?dWQyOUNOaEhKN2srUVFOajdwMVRReHFNTzk3MERtTVNWMkdpZWxFZnZTSHo1?=
 =?utf-8?B?ekc5MSthdjMxREd6dzdDd1dXYzhNRVpqVmllNHhPV0JSbDljbWJJdlk2V1dr?=
 =?utf-8?B?a0NCakU3QVVLS2NRYUxyaXZIWnNwM2ZQcjhYTnJ4dDNDYnh0QmplalhxMWVQ?=
 =?utf-8?Q?kignUDLz410=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3BPSmlaN01wdFBpZGFzVndPNEI3MGVJSDJRbGx0a05wUGJhMHpRc0hZdU5L?=
 =?utf-8?B?UUp6L2Qwc3UxRElQZ2g4d2FzOVZVZ3dERnZLUmZkWGM2OW5lV2R6aWh6bnNy?=
 =?utf-8?B?WGx6NFpvU1lSeS9VdG5iblFYRU5YSDZCTDMwamRHZVM0RFRZSW4wWWJqak5E?=
 =?utf-8?B?a1I3QThHTXBxaHJDK3JZZ1dFOVhXT0p6MWpSeGJDMmZnYjBneVlaVjhrbk5p?=
 =?utf-8?B?TGtWZFkyTURwMTh4TGFia1VIVzZRVjVuNHVXTHhNNTNMK2lLT0ZEeHNqd1Qy?=
 =?utf-8?B?QmpCSXh5MktPLzdJUVdVN0tSUUlFQTRlZGxVaWRCMUNMOEkvZUVPSkxyVlhp?=
 =?utf-8?B?SlRVYnlHbGtmTXk2eUlHcFVybmt3TTljZGhkdHRmc1BNSXUrMkpDeE5QdXFK?=
 =?utf-8?B?djBITVg1WkhkQmptNGNzNmFwWnVFMWd1QU5JRFU4TVRRVzlaY29CbkVXWjVZ?=
 =?utf-8?B?Y0xiNlR4c3d0NXExaDMzdDVsRVhzbE9oYTNYOXVlRklBR0ozd1BZTWdBNnhL?=
 =?utf-8?B?dFpZRk1Oa0dvUWZISGF2Tm9Ka2VERi9FVjYvd0VsZE1qa0oyTUpnSXhGeVAx?=
 =?utf-8?B?VzJuaUUzUGo4RmdGMEVVVVluZG1IbGZaZ3Z0N3pSNjJEdXhoamF4Q3ZOcXhU?=
 =?utf-8?B?cFJvbkNhY0M1M0UxNmt3Qm1ubExMOXVqMEw5RmpFWERWVE85bkQxLzNCVGJD?=
 =?utf-8?B?TFByQUNNRmpPcDhYTllNYXArU2RkUGphUmFWcUIxK0s5ajRzMW5hdXZFMmV4?=
 =?utf-8?B?bDBKSTUrRys2clExdmxJRUt1MGkrdnZDL2V2QnBnbVp1aTlnWlZ6bVN1TUV1?=
 =?utf-8?B?SnlPdnRlWUM3UUI0QlBXNW4yOENGN2xVWWx6akxsUlpWcEZYK1RjLzQ1cUha?=
 =?utf-8?B?QXBqb3JGekU3TlpoelEvM0VGN3Qya0JoREV1azJTc1RKOTZ0MzlMU2l5N2My?=
 =?utf-8?B?SXY1cGtGTGhaQmgxbzIzd3ExY0NuaXNhWm5taUlMNGhCTDg1eXA5V0dPd2lZ?=
 =?utf-8?B?aGl1TVJkaG5mMUtJOU5KSUtRUS9mZEFnNmxWbzJvdXhIK0IvcU5NNDdGOWhD?=
 =?utf-8?B?Sjh3dGtBNktjYUhDWHBWdTc0KzI4Nk1Ob0Z4TUJLbkdEMGV4WWx5aEE5VmVn?=
 =?utf-8?B?bTBDdTRDRzZpSjI2dlBHNjE1ZGVXdFFUKzBNdFpuV0NENUwvckdQSWVqR3Bp?=
 =?utf-8?B?dDNTNlhVR3ZFMVFZaWJmVGNTczl4dUY3eEp2SXc4ZlpHZWpyOFN5OTVJc1hJ?=
 =?utf-8?B?eitQaCsvSlhJNTRIRytKRHZKNVA0OE1KSVFhZlB4UTdaM3Y4MWN4NHp5T1kw?=
 =?utf-8?B?SFlKNS9hLzB2MjRhZmp2bkZmQWJsdVJwaHdTRGw5dTY2N0N5b3UxeG5qMWpW?=
 =?utf-8?B?TDhxbEQ0Y2cvYmo5U0FJdVVCZUtPelZuVWRDNHNhNmU5K0VCWG9lT2NQQzBZ?=
 =?utf-8?B?WDNMK0txSGNFNTNIaXgyRjh1ZU1Ub3lObVV2QUFwcDh6SHo5RktEYi80cWNR?=
 =?utf-8?B?RWovbkdvSGxiRnBwOWJwYzkvdDhTV1cyVG9BNWJuWjFOanhKUUNKK2pndEdL?=
 =?utf-8?B?ZWtmN1VOd3YvVlNLUVFQYVJtOWZSV240VmJTS2tyMnloZGFFOEFNVTlINTFN?=
 =?utf-8?B?ZWliaUtoZlcwSWp2bE9CS29xYzNUWUhpNnQ0T1ZpVlc1a012eUVVdGsyZVl0?=
 =?utf-8?B?QldJUGpxdTNYeHl4Z2FNYVNoUklBRTNnSHpwbGlMUUhuZ1d0c25zcEN0UnNx?=
 =?utf-8?B?TGVENW5BWVZaaEZ1TzJKb2xLSnNXaEtmZVRKRGNPVGtnK0dqb0ZpL2duWmZS?=
 =?utf-8?B?ekwrWmZ4eFZJcEpoSEdJVXN6M0IyaTJPNTFnZi8zdHRQZnVRSGlaNVlNcHhu?=
 =?utf-8?B?WDJXQys2ZWU5aWkzN2ZITytaMmlVaURVNE9TZitaQzU1cmFXdllTbFRCV05J?=
 =?utf-8?B?NTJOUm1NVDRMM3RkbldXcFRLOHdaWlNRWi9KU3N2eHNRdmFOeHliMno5bnh5?=
 =?utf-8?B?U1VXbjdOWFgwUWJCYzZ4V0QzSnAyTEtMTWI1OE9mT2xpN29hSVQ2Skl3TVo2?=
 =?utf-8?B?S0R0NktiaThXbUdMQWtyYjdMbTZZSmxIREZaRUxJYjRPV2hxWVN6NWhac2w5?=
 =?utf-8?B?d3QyMTR1dlo0S0pjT3dwM0l0Wi9aMDZ6UjRSRytHWU9WVlNaWFZ2ck13YnZK?=
 =?utf-8?Q?bH3bbUL4w/2hzguiBh+WipwCHED+qxzr4UPjKvcNp3bG?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14dee29-f487-466b-d691-08ddcb623090
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:01:14.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoHtSf+bE25U1Vanu/Vx612LOd0/iOxaJ4oT0vJnsK0a5fz3U1pPO90PImnY+/CkWiZ6UY0bsHUHUjTN76QHimi+S77ijhb8ayXWMRzqlwO9+Hz9ERG3Vyandqd1G4p4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7492


Hi Marc,

On 6/23/2025 7:41 PM, Marc Zyngier wrote:
> On Mon, 23 Jun 2025 11:31:32 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>> On 6/19/2025 5:15 PM, Marc Zyngier wrote:
>>>>    >
>>>>> Also, running EL2 is the least of our worries, because that's pretty
>>>>> easy to deal with. It is running at EL1/0 when EL2 is present that is
>>>>> interesting, and I see no coverage on that front.
>>>>
>>>> Sorry, I did not get this comment fully.
>>>> When we run selftest on Host with -g option, the guest code will run in vEL2 as L1.
>>>> This is implemented as per comment in V1.
>>>>
>>>> When we run same selftest from L1 shell, then guest_code will be running in EL0/1 like running from L0.
>>>
>>> What good does this bring us if we need to boot a full guest OS to run
>>> tests? What we need is synthetic tests that implement the whole stack:
>>>
>>> - L1 guest hypervisor
>>> - L2 guest hypervisor
>>> - L2 guest
>>> - L3 guest hypervisor
>>> - L3 guest
>>> - [...]
>>
>> IIUC, selftest leverages host OS support and uses various IOCTLs to
>> support the guest_code run. Are you saying to implement all this
>> again (without OS help) in guest_code to run it as hypervisor and
>> launch guest_code2 as NestedVM?.
> 
> The whole point of having small selftests is to run something that is
> simpler several orders of magnitude simpler than the full blown
> OS/hypervisor. So indeed, I'm asking for selftests that build chains
> of guests up to some level and verify that the nesting, as described
> in the architecture, works correctly.
> 

Do you see value in the patches as they are, without the changes to support the bare-metal hypervisor in guest, or will you only consider them if they are first reworked to support the recursive guests?

-- 
Thanks,
Gk

