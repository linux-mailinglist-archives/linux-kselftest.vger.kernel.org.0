Return-Path: <linux-kselftest+bounces-24877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF59A17F99
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB9B1884B36
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D381F3D20;
	Tue, 21 Jan 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mf7Oeg5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2101.outbound.protection.outlook.com [40.92.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DE1F37D0;
	Tue, 21 Jan 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469199; cv=fail; b=ZhDaQvTAwK0D2zBufQfaDDmP7SaG8AVPVId9EUUCaoqC9AX/g/hKicLm2/7trJHpVEIZ9MLlAyfYEhTVzu5IbhMbmN/s1p04o8cY13F8KN7v+6FUgYPbsEeTJyxu1L30XSZisTzEWJNRfjq6XwWxEFAgeJEmMfYuE7ot1VdzIBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469199; c=relaxed/simple;
	bh=l24siGaScwLAOvygjHeXpXLjJOXRl4FOU7dvCvp0Hns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fb0Dq528GktGPHpuV3zUKCoXtTo1Mkf/XxPUPjMhZ3gsr+GHJ0QNAB4LgYUOWQHA3BCUNdRpPrRD68Fhe5Oghac2Dr/rokYwc30XmMIfin7ymyd9j7eYWI3BozHKTyEkgwJe+HKCiWtkGgO11yothuyeNRL4DBBXkOiIS4oLzt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mf7Oeg5Z; arc=fail smtp.client-ip=40.92.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbERSHDhTWhkC1zttkS68lIysdJ2eOUpOA9Pe/jbOvjWuhC3cQuAArV7jGsZb/YtYAe2WFgFiIQ+qe5YeShYF0lWSp/XSwjq77QwIPXiJNnWPUuiHSO0F/Ce7lE0x+r0hVvSPF1BhiyD0fZ3OZfAF09KqdkOcbhzI7Fr5rTCrxfmitsLOg/qvybLYZ6p0ir7SqTjRuo11RhmjERuFGzbmKKJoH4w/jgbXAkzx1wH3KeZlTHReslrxZWABZJb5ryttdShuo9W146xedO4T+U+keK4O8I6m8qP49Ac5OpQ4D0v+WGAiXURVlJ5911nOyy0+6oOwS46erk4lZyAn6Rj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l24siGaScwLAOvygjHeXpXLjJOXRl4FOU7dvCvp0Hns=;
 b=FqyVTPgpBHlEQWfENWLou32JRpdZfPwoGoJ90UUDKcPrZq61LzWOJVtDigjIgmWbHKEJBDrqHMl/T9XgmyMy4oCtAOUtPBZkqUUeJgVVkD0v/XErmk0VLCXVCRrjUAAFqpVpidwi57qkehPqMvaNLT8dIoElhjnvLGD3AK9v61ITM/IuSrWW+nICsKT42Gumx6MvtS3TXkKiHLEImTmfLS9ufVuNsycSw3yKZx/YmaDVidmZngFHb9aEgX2Zn8dfuDF4+4W2iWotF7zcZa6Fpwncn7HCB+7isF/a3dXFZtza3D1GwTylebspaXTztw1zW6i4F2SXPK1DEJPK1w7GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l24siGaScwLAOvygjHeXpXLjJOXRl4FOU7dvCvp0Hns=;
 b=mf7Oeg5ZU34yc7j90WhUtgT1BEVEf0SPOPB0CApf/cYacw34veuWi1bq1iJiTGq2pwm8eTGO35T2ncOxP6fGrEbAPj8V/zcVWFaMOjRKAL3q6DuDFsQhlrnbi0TzeB6p+ORAkSp6bWUYFY5p5x6AZASvt6QW02pd/M1iQgOlEciBgB79rUP727haN5+MkAywP3Uss0V4kc9ljFNihlXHfBhiDI7ZyYwCXsA1KkKcg9kdxKOgv67f99NURE/vMjw4pYH4qbgrgW29xhd6wjJnnmRH7nwG7fwb0jx3RmjhEKeXb9+xHqvAzDYPRE/0P+0geWT/0MpPcM4D4aZEC8kXjQ==
Received: from CH0PR20MB3932.namprd20.prod.outlook.com (2603:10b6:610:d8::9)
 by PH7PR20MB4360.namprd20.prod.outlook.com (2603:10b6:510:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.7; Tue, 21 Jan
 2025 14:19:51 +0000
Received: from CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13]) by CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13%7]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 14:19:51 +0000
Message-ID:
 <CH0PR20MB39327090E69E2929157A5E63CEE62@CH0PR20MB3932.namprd20.prod.outlook.com>
Subject: Re: [PATCH v10 00/14] riscv: Add support for xtheadvector
From: nexp_0x17@outlook.com
To: charlie@rivosinc.com
Cc: ajones@ventanamicro.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net,
 cyy@cyyself.name, 	devicetree@vger.kernel.org, evan@rivosinc.com,
 guoren@kernel.org, heiko@sntech.de, 	jernej.skrabec@gmail.com,
 jrtc27@jrtc27.com, jszhang@kernel.org, 	krzk+dt@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robh@kernel.org, samuel.holland@sifive.com, samuel@sholland.org,
 shuah@kernel.org, 	wens@csie.org
Date: Tue, 21 Jan 2025 22:19:41 +0800
In-Reply-To: <ZzVkJd1lGy0TsjlW@ghost>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
		 <CH0PR20MB393254369E401BF068005C7FCE752@CH0PR20MB3932.namprd20.prod.outlook.com>
		 <ZzVkJd1lGy0TsjlW@ghost>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
X-ClientProxiedBy: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To CH0PR20MB3932.namprd20.prod.outlook.com
 (2603:10b6:610:d8::9)
X-Microsoft-Original-Message-ID:
 <471d556c988316e21cfbcb814c50c20a2714ca13.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR20MB3932:EE_|PH7PR20MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 678a7a61-1267-4cbb-6fe6-08dd3a26ab5a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|6090799003|19110799003|8060799006|5072599009|461199028|15080799006|10035399004|440099028|12091999003|41001999003|3412199025|4302099013|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1ZhdjB5N09RTkh3aW94blJUNGpvL25aOFFrVERrSEwwT09zV2hpWHFVWklU?=
 =?utf-8?B?cHpLTG9ISDU1UDN6T29aNUNOcktOcDdDWTJjYXljWGZ1MjVBaDBMbFM0VU0y?=
 =?utf-8?B?NlJkTmsyYkNsZzBDL0RaYWFITkxGSURiYkhOaFNPb0VIbTlqdlExQ1dHZlBl?=
 =?utf-8?B?b2VNTXFvU1pRUlhmeXdrWVdJcUVTMEtsRW1TdW1BUTBiL21iRFJMRG9jNnla?=
 =?utf-8?B?STVhYVpiL2lQcEI0c0dYVGNBNzhjdUo3MlBqNEJmcnp4LzFzOThsdjluSTN5?=
 =?utf-8?B?WnFseDdqdGxHQklMaG5ocGRIdkkvOExROWNobzVxWFpKcUZWeDhWV0V4aWY0?=
 =?utf-8?B?NjBaNlpvZFBDZ2dpT2ZUSjdWRDcvMWgwdjExSVk1Mms4MzlZZnlhdTJnaFEx?=
 =?utf-8?B?d0tWWE1CRDloZDZrWHJpZHBobHdmaTZOMHBuS1FKSmZQMU4rKzBSTXUrdHVM?=
 =?utf-8?B?Z0FiRkwzbnMxa0lmTzhnTlF6QXVBY2xpQXhjT0ROUzA5MDFMNHZEVTJqTUo1?=
 =?utf-8?B?VTlSMHFKcU9jckxObDdWaGFVVm1XcndRc3h4OXVySVB6VkxGazZDa1MrWjdK?=
 =?utf-8?B?KzhTdGNSeWhXMGROb3JvSlFjYU4wWTZJTmh1d3B4bm1uNXEyNCtoL0gvSGt4?=
 =?utf-8?B?RGpTU2tEQTRIbGdHZjY5SWx5cFVUWUErR1ZNcTlrMzh4UVcxeEdXT2FiV3pJ?=
 =?utf-8?B?MnpFa2hvUmJuTVR6YWlCMDhCREJZZFdvWWoxeGFrNFpoUTF6VkE1S3ZJOUxp?=
 =?utf-8?B?Q1AycEsvaXh3RXJEWmlXRk9rMThINktETElvTWxlWElVQWlYNGdaLzJicDlE?=
 =?utf-8?B?SHV1SjJKMEhuTVhpTFp1ZkxCOHlwWDRjVW1waVc4RS9ZSHdSZVZZM1NLQ2NZ?=
 =?utf-8?B?dGhOeEVLNzNiNHJzZXpsd2NnbHMyT3dBb0UyR01VeU9kQXZRYjlCc2I2bEE3?=
 =?utf-8?B?cGx0a3M4a0djT29yUTdBMEVUUkhVSWhBd2tUK2tReFk1RWp3UFFjTWRBVi9R?=
 =?utf-8?B?QVVoSFRqSjBZck5waHVFbEpJTUE4WTlKWElBYUVqOWRPSWNleEpCNStWajJR?=
 =?utf-8?B?ZWJ3Q3FESENjM2pOMGRTbTF0OHhISHhpTStVZCt5ZWZuVVN4VUE2YnB5Yk82?=
 =?utf-8?B?cjhVRjRnRGVYaU5xenZmWDBydFFnT1BBSm5Od1IxK3kwSkpYSzhoM1EyVXFs?=
 =?utf-8?B?Y3JNUjZHSHBiYWk0NHU4NFhISGlqUjF2WCtVVldMWXB1Y01UQXcrU2g3V2xJ?=
 =?utf-8?B?czFWZW1kZG44MzdUa0VQR0JBSlZETTAxclNiL1kyQVV6RlpaTHFhSnV1TDZH?=
 =?utf-8?B?UmZZUWtZWjFkOE91Z2Y5NTQ2U1RTYkY1ck1VNmNlTzNNY2RSaUVZY1pJYmI2?=
 =?utf-8?B?VDBJOWlJOURMZW1sTUlxUjZMUGlQbEhqMVJzRmQxNGtxUWUwUUZNRVhXZFNh?=
 =?utf-8?B?OUY1RFJaL3diQkZhZHFadFFIUzhRM3ByektPRGdKWUpDZWZwZ1hJMFFWN2NW?=
 =?utf-8?B?b3lDQUQ1Q1BvRzJ0UEhWSFVhMjY4dlVZeUtEYTMyYjNaYWJJN3FIc2dWTHFt?=
 =?utf-8?B?Uk43b2RLVG9FNW1IZURwWWNvOC9zdXlja2phWTlaSGhET2kvelZJbC9BQWFr?=
 =?utf-8?B?cFRPbTVDRFJxeHFNWmJuNEo1RjdFbkQyYmYyTEJmYTVhQlFqaW53d3BLS0di?=
 =?utf-8?B?L3MrL1AybE1jQUZGRXU4L2dsVlYxSklUUFRrQlVYd0ZSMTBRSi9JbGwya3Vr?=
 =?utf-8?Q?skZEnoqltDNucjUZ8w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNrako2S0VVZDhwL05kZTV4YStrY1c1eTlvVXA1eE9WVVFlcW4xeVBkZVB5?=
 =?utf-8?B?d2VXOXoxZFozU2xVcElWeFY1bTlldTdYdUNsVE1xdDMxWDN4NjhHMEJrTXJK?=
 =?utf-8?B?YjFtVVkrMUpXRCt0ZlF1d2x4UG94Rm04MmRja1hPR1NQMEV5RjExUGtqdURy?=
 =?utf-8?B?aURGZEp1bitlUWdpM1hHcFFsbjZDTFJCMU1ydGsyTWN2YVVkRTA0YnRKTmh3?=
 =?utf-8?B?VlZ3dkUzSWlyVGFnZlpSNG15eWZmU1BJTEQ5MmM5WldDL1VPekFOSEEwRS9N?=
 =?utf-8?B?NkhUN3Q3UVZHeFEvZWxSRTVyOS9pMmtNR0JrdUxHTmZ2VmZtS0pBbzl4Rmxn?=
 =?utf-8?B?bWZPT2Rpc2pwVjMwMjhmSnlZT2VsdTRIYStoN09mbkRvMVY3Z3JVOW51TmF1?=
 =?utf-8?B?R2pBRWZ5eS9iSDEzdyt0K3E4S05yM3VaQmpBUXl6R0c4dWVSbzVzK2xwb0No?=
 =?utf-8?B?VE9KbmJ3MTNvend1Yi9pQk14Z0F5eVlZcjNubVl2L3QzSzNoK1NRM0d4Visw?=
 =?utf-8?B?OHFzYm1qV1RjR2JwZG1jTTlDZ25oT1l6ZEN6V2ZUaDE0YlFTVG1EOHRzSjFX?=
 =?utf-8?B?Um5JOE5CSUk4VG05SW9iWG5MWldyUlcxWEtHOW84YjlGVGtQN1lqUEFJL2x2?=
 =?utf-8?B?aG8rWjM1bEVvRng4RzVOcnlZbHIyRnFzL1FJZ3FHbllIcDlGWkoyYitTZ1Zy?=
 =?utf-8?B?V1EraGFTT3Y4OTJIQmUramhQTFVLY0ZsWmRtWDVtTEh4ckVsbVZTdnBRbUhn?=
 =?utf-8?B?UllDa0JiWGtGSVpJRFhvY2s3dzlEc1EzalpqMGlnaG5NSCt2RHlhOTFwY01t?=
 =?utf-8?B?bEpqaUVZWVRTUExQVzZ1Z2ErMXRuTmM0dm05Q2xkcnNMQWh6aFFBQTJNOWJ4?=
 =?utf-8?B?Y1RjeDQ5SjgwTlBOV0oyQ01kRmlaQlo3eG5hNkYxa1hBOHNvMktrTEl4eGtj?=
 =?utf-8?B?dFZncW94REl5aHVQTmZkaEp5cm1IdHlxTDJvYkpFZFg5R2pkOWlmM3pnaXBu?=
 =?utf-8?B?VTVad0hRTVJZKzdDa3BDOFZScTYvSDg3WktyYTJZWGlXUUdZZThpM0xyeHhq?=
 =?utf-8?B?dnJxeXlBU1c4dGJ3bzJTWkxWSksrOE9nUjBvM2tSMkp6TWdVa2d3aW5BY3Jj?=
 =?utf-8?B?SlFwZGNFWUw4akdPTHZpQVUrWnhCS1R3UncxSFNLUGNlSndWUkdzdG9CUHNN?=
 =?utf-8?B?RUZWUk02bkd4ZnM5V0ROdlhmb21YUjREeUkyMys3Q216aFdVUHl6TEgySnVh?=
 =?utf-8?B?c3VidXR0T3Jsc0JuUWsxMGVwQUVOWE9oUXd4RmF2SDBMNmhQSDljM2sxYWVj?=
 =?utf-8?B?aVl0dFY0MmZwU2dqdTJuS3YrUG1yNytsd2V3R0ZON21wSVFxVkRqWE55SElw?=
 =?utf-8?B?Ri9uSGNGNm5PR2tQKzBocDhHdmF4N3RpM1dmVnNRQmhSYjNuZ0xvNVJ2aEJO?=
 =?utf-8?B?bVdwcEpGR2VCMzVXSWxUWWxnWFRSTFkrcEN0V3luWElqUDJTRDJBbDk5VnBt?=
 =?utf-8?B?UWZMMy82Y0M2ZCtlNGZ2U2pxRVhldnZFeEFZQ3pVeGt5VVU5aWl5WVFWZWVP?=
 =?utf-8?B?RnpORlorV0gwQTdDRzJGRWlpMlBzNEJlbXZueE5FeEE3OHdBbFBrUmMwQUlY?=
 =?utf-8?B?YWZtTVlhZmJWMnJ2MlBxckJndisxMWh2OXJyZHV6Rk4wZHhoTThkWU8vSW5z?=
 =?utf-8?B?TFVTTGR6cEJYRHBvUko2aXMwd1hiK01nbnN2VnJDcUdKcDI2N0duVnpvdStE?=
 =?utf-8?Q?S9X+DCkCqfF46xTxIU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678a7a61-1267-4cbb-6fe6-08dd3a26ab5a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3932.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 14:19:51.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4360

On Wed, 2024-11-13 at 18:44 -0800, Charlie Jenkins wrote:
> On Mon, Sep 30, 2024 at 12:07:23AM +0800, Aoba K wrote:
> >=20
> > On 2024/9/12 13:55, Charlie Jenkins wrote:
> > > xtheadvector is a custom extension that is based upon riscv
> > > vector
> > > version 0.7.1 [1]. All of the vector routines have been modified
> > > to
> > > support this alternative vector version based upon whether
> > > xtheadvector
> > > was determined to be supported at boot.
> > >=20
> > > vlenb is not supported on the existing xtheadvector hardware, so
> > > a
> > > devicetree property thead,vlenb is added to provide the vlenb to
> > > Linux.
> > >=20
> > > There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0
> > > that is
> > > used to request which thead vendor extensions are supported on
> > > the
> > > current platform. This allows future vendors to allocate hwprobe
> > > keys
> > > for their vendor.
> > >=20
> > > Support for xtheadvector is also added to the vector kselftests.
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > >=20
> > > [1]
> > > https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9=
489361c61d335e03d3134b14133f/xtheadvector.adoc
> > >=20
> > > ---
> > > This series is a continuation of a different series that was
> > > fragmented
> > > into two other series in an attempt to get part of it merged in
> > > the 6.10
> > > merge window. The split-off series did not get merged due to a
> > > NAK on
> > > the series that added the generic riscv,vlenb devicetree entry.
> > > This
> > > series has converted riscv,vlenb to thead,vlenb to remedy this
> > > issue.
> > >=20
> > > The original series is titled "riscv: Support vendor extensions
> > > and
> > > xtheadvector" [3].
> > >=20
> > > The series titled "riscv: Extend cpufeature.c to detect vendor
> > > extensions" is still under development and this series is based
> > > on that
> > > series! [4]
> > >=20
> > > I have tested this with an Allwinner Nezha board. I used SkiffOS
> > > [1] to
> > > manage building the image, but upgraded the U-Boot version to
> > > Samuel
> > > Holland's more up-to-date version [2] and changed out the device
> > > tree
> > > used by U-Boot with the device trees that are present in upstream
> > > linux
> > > and this series. Thank you Samuel for all of the work you did to
> > > make
> > > this task possible.
> > >=20
> > > [1]
> > > https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezh=
a
> > > [2]
> > > https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f=
1429e9a0b48
> > > [3]
> > > https://lore.kernel.org/all/20240503-dev-charlie-support_thead_vector=
_6_9-v6-0-cb7624e65d82@rivosinc.com/
> > > [4]
> > > https://lore.kernel.org/lkml/20240719-support_vendor_extensions-v3-4-=
0af7587bbec0@rivosinc.com/T/
> > >=20
> > > ---
> > > Changes in v10:
> > > - In DT probing disable vector with new function to clear vendor
> > > =C2=A0=C2=A0 extension bits for xtheadvector
> > > - Add ghostwrite mitigations for c9xx CPUs. This disables
> > > xtheadvector
> > > =C2=A0=C2=A0 unless mitigations=3Doff is set as a kernel boot arg
> > > - Link to v9:
> > > https://lore.kernel.org/r/20240806-xtheadvector-v9-0-62a56d2da5d0@riv=
osinc.com
> > >=20
> > > Changes in v9:
> > > - Rebase onto palmer's for-next
> > > - Fix sparse error in arch/riscv/kernel/vendor_extensions/thead.c
> > > - Fix maybe-uninitialized warning in
> > > arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> > > - Wrap some long lines
> > > - Link to v8:
> > > https://lore.kernel.org/r/20240724-xtheadvector-v8-0-cf043168e137@riv=
osinc.com
> > >=20
> > > Changes in v8:
> > > - Rebase onto palmer's for-next
> > > - Link to v7:
> > > https://lore.kernel.org/r/20240724-xtheadvector-v7-0-b741910ada3e@riv=
osinc.com
> > >=20
> > > Changes in v7:
> > > - Add defs for has_xtheadvector_no_alternatives() and
> > > has_xtheadvector()
> > > =C2=A0=C2=A0 when vector disabled. (Palmer)
> > > - Link to v6:
> > > https://lore.kernel.org/r/20240722-xtheadvector-v6-0-c9af0130fa00@riv=
osinc.com
> > >=20
> > > Changes in v6:
> > > - Fix return type of is_vector_supported()/is_xthead_supported()
> > > to be bool
> > > - Link to v5:
> > > https://lore.kernel.org/r/20240719-xtheadvector-v5-0-4b485fc7d55f@riv=
osinc.com
> > >=20
> > > Changes in v5:
> > > - Rebase on for-next
> > > - Link to v4:
> > > https://lore.kernel.org/r/20240702-xtheadvector-v4-0-2bad6820db11@riv=
osinc.com
> > >=20
> > > Changes in v4:
> > > - Replace inline asm with C (Samuel)
> > > - Rename VCSRs to CSRs (Samuel)
> > > - Replace .insn directives with .4byte directives
> > > - Link to v3:
> > > https://lore.kernel.org/r/20240619-xtheadvector-v3-0-bff39eb9668e@riv=
osinc.com
> > >=20
> > > Changes in v3:
> > > - Add back Heiko's signed-off-by (Conor)
> > > - Mark RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 as a bitmask
> > > - Link to v2:
> > > https://lore.kernel.org/r/20240610-xtheadvector-v2-0-97a48613ad64@riv=
osinc.com
> > >=20
> > > Changes in v2:
> > > - Removed extraneous references to "riscv,vlenb" (Jess)
> > > - Moved declaration of "thead,vlenb" into cpus.yaml and added
> > > =C2=A0=C2=A0 restriction that it's only applicable to thead cores (Co=
nor)
> > > - Check CONFIG_RISCV_ISA_XTHEADVECTOR instead of
> > > CONFIG_RISCV_ISA_V for
> > > =C2=A0=C2=A0 thead,vlenb (Jess)
> > > - Fix naming of hwprobe variables (Evan)
> > > - Link to v1:
> > > https://lore.kernel.org/r/20240609-xtheadvector-v1-0-3fe591d7f109@riv=
osinc.com
> > >=20
> > > ---
> > > Charlie Jenkins (13):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: riscv: Add xtheadve=
ctor ISA extension
> > > description
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: cpus: add a thead v=
len register length
> > > property
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: dts: allwinner: Add xthea=
dvector to the D1/D1s
> > > devicetree
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: Add thead and xtheadvecto=
r as a vendor extension
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: vector: Use vlenb from DT=
 for thead
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: csr: Add CSR encodings fo=
r CSR_VXRM/CSR_VXSAT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: Add xtheadvector instruct=
ion definitions
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: vector: Support xtheadvec=
tor save/restore
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: hwprobe: Add thead vendor=
 extension probing
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: hwprobe: Document thead v=
endor extensions and
> > > xtheadvector extension
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests: riscv: Fix vector tes=
ts
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests: riscv: Support xthead=
vector in vector tests
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: Add ghostwrite vulnerabil=
ity
> > >=20
> > > Heiko Stuebner (1):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISC-V: define the elements of t=
he VCSR vector CSR
> > >=20
> > > =C2=A0 Documentation/arch/riscv/hwprobe.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > > =C2=A0 Documentation/devicetree/bindings/riscv/cpus.yaml=C2=A0 |=C2=
=A0 19 ++
> > > =C2=A0 .../devicetree/bindings/riscv/extensions.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > > =C2=A0 arch/riscv/Kconfig.errata=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > > =C2=A0 arch/riscv/Kconfig.vendor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 ++
> > > =C2=A0 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> > > =C2=A0 arch/riscv/errata/thead/errata.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 28 ++
> > > =C2=A0 arch/riscv/include/asm/bugs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 22 ++
> > > =C2=A0 arch/riscv/include/asm/cpufeature.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> > > =C2=A0 arch/riscv/include/asm/csr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +
> > > =C2=A0 arch/riscv/include/asm/errata_list.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
3 +-
> > > =C2=A0 arch/riscv/include/asm/hwprobe.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +-
> > > =C2=A0 arch/riscv/include/asm/switch_to.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> > > =C2=A0 arch/riscv/include/asm/vector.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 225
> > > +++++++++++----
> > > =C2=A0 arch/riscv/include/asm/vendor_extensions/thead.h=C2=A0=C2=A0 |=
=C2=A0 48 ++++
> > > =C2=A0 .../include/asm/vendor_extensions/thead_hwprobe.h=C2=A0 |=C2=
=A0 19 ++
> > > =C2=A0 .../include/asm/vendor_extensions/vendor_hwprobe.h |=C2=A0 37 =
+++
> > > =C2=A0 arch/riscv/include/uapi/asm/hwprobe.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> > > =C2=A0 arch/riscv/include/uapi/asm/vendor/thead.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > > =C2=A0 arch/riscv/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0 arch/riscv/kernel/bugs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 55 ++++
> > > =C2=A0 arch/riscv/kernel/cpufeature.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 58 +++-
> > > =C2=A0 arch/riscv/kernel/kernel_mode_vector.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> > > =C2=A0 arch/riscv/kernel/process.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> > > =C2=A0 arch/riscv/kernel/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> > > =C2=A0 arch/riscv/kernel/sys_hwprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > > =C2=A0 arch/riscv/kernel/vector.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 +-
> > > =C2=A0 arch/riscv/kernel/vendor_extensions.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > > =C2=A0 arch/riscv/kernel/vendor_extensions/Makefile=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0 arch/riscv/kernel/vendor_extensions/thead.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++
> > > =C2=A0 .../riscv/kernel/vendor_extensions/thead_hwprobe.c |=C2=A0 19 =
++
> > > =C2=A0 drivers/base/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 3 +
> > > =C2=A0 include/linux/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > =C2=A0 tools/testing/selftests/riscv/vector/.gitignore=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +-
> > > =C2=A0 tools/testing/selftests/riscv/vector/Makefile=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 17 +-
> > > =C2=A0 .../selftests/riscv/vector/v_exec_initval_nolibc.c |=C2=A0 94
> > > +++++++
> > > =C2=A0 tools/testing/selftests/riscv/vector/v_helpers.c=C2=A0=C2=A0 |=
=C2=A0 68 +++++
> > > =C2=A0 tools/testing/selftests/riscv/vector/v_helpers.h=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +
> > > =C2=A0 tools/testing/selftests/riscv/vector/v_initval.c=C2=A0=C2=A0 |=
=C2=A0 22 ++
> > > =C2=A0 .../selftests/riscv/vector/v_initval_nolibc.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 68 -----
> > > =C2=A0 .../selftests/riscv/vector/vstate_exec_nolibc.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 20 +-
> > > =C2=A0 .../testing/selftests/riscv/vector/vstate_prctl.c=C2=A0 | 305
> > > +++++++++++++--------
> > > =C2=A0 42 files changed, 1048 insertions(+), 272 deletions(-)
> > > ---
> > > base-commit: 0e3f3649d44bf1b388a7613ade14c29cbdedf075
> > > change-id: 20240530-xtheadvector-833d3d17b423
> >=20
> >=20
> > Hello Charlie,
> >=20
> >=20
> > Apologize for the last email, when dealing with pastebin it deleted
> > the last
> > version...
> >=20
> > tl,dr for the last email: Patches not boot on Sipeed Lichee RV Dock
> > (with
> > same D1 SoC).
> >=20
> > Logs here:
> >=20
> > https://fars.ee/XFzR
> >=20
> > (the board resets without kernel panic)
>=20
> Apologies, this thread slipped by me. This looks to be the same issue
> as was experienced here [1] and fixed here [2].
>=20
> [1] https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/
> [2]
> https://lore.kernel.org/linux-riscv/20240820034850.3189912-1-apatel@venta=
namicro.com/
>=20
> Since you are on 6.11-rc2 that patch is probably not in your tree, as
> it
> was merged in 6.11-rc4 unfortunately. Can you try updating your
> kernel
> to include that patch?
>=20
> - Charlie
>=20
>=20
> >=20
> >=20
> > Cheers,
> >=20
> > Aoba K

Apologies for the delayed response. According to Patchwork, the patch has b=
een=C2=A0
replaced by another one. I have tested the master branch (6.13-rc2) from li=
nux-riscv=C2=A0
instead, and the board now boots and drops me into the shell as expected.

Thank you for your assistance!



