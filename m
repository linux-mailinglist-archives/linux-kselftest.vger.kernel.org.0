Return-Path: <linux-kselftest+bounces-332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB87F198C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1C28105B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D020321;
	Mon, 20 Nov 2023 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lJkZgICw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2030.outbound.protection.outlook.com [40.92.74.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A3BA;
	Mon, 20 Nov 2023 09:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsSR2NTNCV/Oe6mCIZ4ekmNNFZugMU7RsONWeUu5RMkys4gbHre1xriaM99avAWM9dwSYv14FgUrwf7qxE7GzgSfeWjp6YFbcFBcndZ2Q/lOcrtLAasd0H3QiMvNB9kzsW69VjS0ZomMoEIntU/rCAWC5XSy9K96q+FYpPeIaEx7cX1BqA79rBxWcI6Q42uXfLfDfoKM50B1zN20lZM/32TKSWl/+1dXSFytp69Dtdgndzbx9AVUrZiMYLTuRrPHUiOVuWAD1zdmdmBoDmu30s4LFErwVF07wHkjCFQlC+ngjUzj4BtTl/Ee3F1EHMRT9Sfemt/4QI9wQXFuVCa9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhbUSE9kB4lE2hk8DkGlJiGcef9zD/kSbgW/BVB8yso=;
 b=EngIDG/1CWtuMjMK1yVKIhZkbza9uBtc5ejf3ZecvROmH3YHejMQ3vJ666NPGBl6PXvL55xbw2e5/3AwWc503Ohaoc6ayOnPkq9wjFGg61vwwsEJckmCtz81+0Zujcre7Uyd3efCOuicYzVyf9PhAuJbRzlZGU5TyRFT0oQGyHM1m9Rei4xWF8VL1mePET/bicr5a6Fo1DUWVVNMTgs0zwerILJ1KDvWd+cEPC33wROnrUGiR/VBnzXkc6vo2505DthsaTzTdmvWxbiD+YLv9CWqYDJcXh+hTs56qFEE+SJggdMgaILlI9eBsaMeehObkiBKJasFRFefVv+fwIB0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbUSE9kB4lE2hk8DkGlJiGcef9zD/kSbgW/BVB8yso=;
 b=lJkZgICwsZlfloSNKp8ZHU6E8288QA2xgwXN5FPUEbJnytQ1IuMLJ9u8u2Il5spmbkHL/1S4fIuZcZYyAuvn2/+akzCB7BzebTJu6bYi8xkYQ9oHjPrVzVPlJCm9CPFQ023DUIk9Dngbxs9iCO1vHtr+nOIgWjQ2vj9lwLbPXYZrPnQMhjv2hqB7g57HHKw5/bhxcaeyEEyUg8jpeJrCn/ozh8dgW1V6o/O6X0Zg/EMLWUH0xs+cDsS2cLgRfQyRqFEqqc3rbmGc3P7IXlTt8ncYFgph150UvzZdX1EbF6vNN3a2d1Zb+yfu6k0+dK8EN38E6Q8rKP3Mj+ExyZDhng==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by GVXPR10MB5816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:15:46 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 17:15:46 +0000
Date: Mon, 20 Nov 2023 22:45:27 +0530
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, andrii.nakryiko@gmail.com,
	mykolal@fb.com, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Replaces the usage of
 CHECK calls for ASSERTs in bpf_tcp_ca
Message-ID:
 <GV1PR10MB6563596BC3E2B01F664010C7E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563A7938B9B403861CA88F3E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <14c7dea0-242c-4b47-929c-7cbd1d7e202a@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c7dea0-242c-4b47-929c-7cbd1d7e202a@linux.dev>
X-TMN: [25HpmqNQsxr73/HO/Utg9TGpT30FKA7y]
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231120171527.GA388225@nmj-network>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|GVXPR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df99e4d-e42f-4315-370b-08dbe9ec555e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KgnNmONZ2M3DTu+BRL2tz1deS3FK8WAMerR7o491RU9zCFL0Zg2x30iynZA6UrmYrQg2wPhcuQlhLn7k4EwGFUknN0MnDx1ChfYBvitYMPAVmHozbEwjXizlywQctmHJVzt/04nfF37btvUI2nsB1U8V+gF/qwXah0xqNRWDRhO14Cu91FYg6WbKSAdcFW0CCv8CKbxrZMEtxehR+Q3+QVAUFq2lJD/LBzIChQSSQy8Gy6QxCB4LPhtYhOWTIrsJsI3S92GSUc8CJeh0IgagfOjNQ71dR28G21YJQ+GDkSaWjViynXUYnctszJZnx0VLj+nGhrdVnHhfdtd4B0t99E+OTG0kug4Yp4GGmV6BaF0VIfuuIEJ0BNCXHS0vvNlWgLG063T53ZT2GWPxeFHW1tbX4F1jeIh4OeyAOir30CaVe6O+x7O7nIn6SkYnrPq0bhZyW7MuwNBXT1iBz90PV/DP7yb2dGz/EBOrkVLKnxlUdfjPrdvTdd1nCxvVlkeGKv0z2rBKt3lAbPlnGswISXnUnqGWqitwpISEg0/2s4Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxytGJiBvNUMIQaaF7TOgKMogBqADD3miG79IylrbRl022nQsaaM68oxKcv8?=
 =?us-ascii?Q?Fz+kae5r5ZwpOm1qVVqgqF2Z60Xt2cNlOLpYoAxdeU4juwubPv6UNpXqMqL4?=
 =?us-ascii?Q?yHTBso84It4Tom0e5CNoFXcKQ/PJpfFFT3xzVRYTsqrVt78LAK2A3PxYNK33?=
 =?us-ascii?Q?AwBQgQyB/MMs6EB/X+n42s0v21v0dl8SCMWjg6FRSOnW6lAHYwu2s1RVtFPu?=
 =?us-ascii?Q?l7eticGejThqDAYXi91HKIJNZ21Z6cNsjJu2X1K68ZEyxL6vL0YDHsePQ725?=
 =?us-ascii?Q?9e4G0LemnbttjVU4pjnhIq6PoC5hhnZJbRgFf8As3Z8QP7e2I/mqSFPKWDwR?=
 =?us-ascii?Q?uEXo6L0p/E/dCg0viFxDAXbpB+MKi2w+W8t9WGOdBtNvTZSn7zio1s/4RgVL?=
 =?us-ascii?Q?6BLObCc/QC1yuwSawR4vNM4jeK39bBO7tcvmWpACq/HTFQCTuYYGN2mDs84g?=
 =?us-ascii?Q?QYEJ9114EMp3K2u5kD30I6CxIfzWXZtR5kob9Z24FISX+AT5FdMg9j/esEBf?=
 =?us-ascii?Q?5wY7PSqjXBcRV1Rz2j1y+e7qUBiX0fkMxKq03gvQWs7reVBboROj16DX3RkM?=
 =?us-ascii?Q?yenAU/pUcljzc4+asegTRis+rkvrcA4vX9NZBFUyR0WxGgso+WmDQyMg3C9J?=
 =?us-ascii?Q?J9ju4QDAyILtwhh4A4TS8gk0XXnu0X2LO+zyh+rcIoiaPGWB4Sp1L8K9hX6C?=
 =?us-ascii?Q?MUurtPIf6QALIxhUx0WAuk2DjuoD/tboZFARj+7NRn3AYbEILZ9efXqfyBjU?=
 =?us-ascii?Q?0XfwJFC70GWmpGA06O3i85RsA20Jk1kZJPANPpOWA8Z8xYQrlH/lD2DkKgVw?=
 =?us-ascii?Q?TZztifl4xHV1fMAVhJO3O5SFmKe7+96+4IJRU+IdN6FEC26byHn88lT2q7kr?=
 =?us-ascii?Q?OawlZrNZsNZa5ECK05V9QRZRLFJJc1yNZp758gns1MQnWTjBmZQye1CSi6Bf?=
 =?us-ascii?Q?lhpliov5vP3ZoSUyyutKcBKlb9+J4WrMXQYTS2KAMJ6hvrxRZR7Szl6AvMdf?=
 =?us-ascii?Q?DSQ+Q6d66P45/QP6iHjXyfmrQW/P617sgg6VyFNKPPyHi3iY9pxJ+4I/dU3j?=
 =?us-ascii?Q?Ik2UcVaGM3IU1ewfbBOjVfUa9Sv6mq/NCukPmEiSP+N+mL9XQIJLx7Up23k9?=
 =?us-ascii?Q?BpG4IK5WdMbJMTLfVKY/oPD5SJBR4f/VifB2uY4MfSredYm0R05Pw2RbjMJk?=
 =?us-ascii?Q?8UfORJZk/QeqvnnNKEwpqYLm6TQGu7eu2g/CB8Dvy5tx4J9VT9QcgRhDPyE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df99e4d-e42f-4315-370b-08dbe9ec555e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:15:46.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5816

Hello Yonghong,
On Mon, Nov 20, 2023 at 07:22:59AM -0800, Yonghong Song wrote:
> > -		if (CHECK(!err || errno != ENOENT,
> > -			  "bpf_map_lookup_elem(sk_stg_map)",
> > -			  "err:%d errno:%d\n", err, errno))
> > +		if (!ASSERT_NEQ(err, 0, "bpf_map_lookup_elem(sk_stg_map)") ||
> 
> !ASSERT_ERR(err, "bpf_map_lookup_elem(sk_stg_map)")
> might be simpler than !ASSERT_NEQ(..).
> 
Sure, that makes sense. I'll change it in v3.
> > -	pthread_join(srv_thread, &thread_ret);
> > -	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
> > -	      PTR_ERR(thread_ret));
> > +	err = pthread_join(srv_thread, &thread_ret);
> > +	ASSERT_OK(err, "pthread_join");
> 
> The above is not equivalent to the original code.
> The original didn't check pthread_join() return as it
> is very very unlikely to fail. And check 'thread_ret'
> is still needed.
> 
Yes that is true, but the v1 [1] broke the tests because the
ASSERT_OK_PTR(thread_ret, "pthread_join") kept failing, even
though all the asserts within the `server()` function itself
passed.

Also, isn't asserting `thread_ret` technically checking the
`server()` function instead of `pthread_join`? So should we
have two asserts here? One for `server` and one for `pthread_join`
or is it not necessary?
i.e:
```
ASSERT_OK_PTR(thread_ret, "server");
ASSERT_OK(err, "pthread_join");
```

Upon taking a second look, I now think that the reason why
`ASSERT_OK_PTR(thread_ret, "pthread_join");` failed in v1 might
have been because it calls `libbpf_get_error` which returns
`-errno` when the pointer is `NULL`.

Since `server`'s return value is not a bpf address, which
`ASSERT_OK_PTR` expects it to be, do you that think we should
explicitly set `errno = 0` prior to returning NULL on server?
That way that assert would pass even when the pointer is NULL
(which is the case when `server` returns successfuly).

[1] - https://lore.kernel.org/lkml/GV1PR10MB6563A0BE91080E6E8EC2651DE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM/

As always, thank you for your feedback.

Yuran Pereira

