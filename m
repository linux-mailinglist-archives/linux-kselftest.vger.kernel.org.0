Return-Path: <linux-kselftest+bounces-9991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF68C1F96
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CE7B21157
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974B15FA66;
	Fri, 10 May 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gihc3W53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2052.outbound.protection.outlook.com [40.92.42.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60067C136;
	Fri, 10 May 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329276; cv=fail; b=Cg9KOCQGXbyRgsLo3Wd5h9VRyOOoEu6ZXVup4E8prHvBMeAJCrUjlj1GFjM5pUrJw5GycNo2PxaYzs/s0bzmrZ1+BXxFrxk826tQqlydTjrjB4auX2V610rz/Bs8SNLttJT/3+s7rQ/VkTCq1yXLt751Jx75U5CYVAvBV5fd6TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329276; c=relaxed/simple;
	bh=EV8opBmuJwe07HUysARMr35wijimlzlTAqOloAejvNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iMVQcnz5Xo2LF3epCSCYeKx18+r7j5ucsU+h9c9XDK2friRJCx2ve6AxebH5+aus/IJ/5uILUf+H1ZIwgmvoyIr+rrd3eybXONroIX9EAf3tSSs3WFYsSbCeoxKiNOAFnoV39tS34jXnLhQdNecSZ7VWKr8cbB3SYTbV92SWn5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gihc3W53; arc=fail smtp.client-ip=40.92.42.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxROBGDr/bgR9gdKgT25UQWveF3Mi2wmeSTL7HpV/7hr6jPlK9jF9l01CHYZLo7p5veHJ+rrXFm+3Xb+HEeyZNq/MNfMZQI82H7eEYtxUYklHHOiR56NNoChQPFxiTcgzHtv+UMlTjfvMSrHnJkzFYz2cmuoEgxUJN1q+yrzCg/a+IW1oJwfecwU8tDTExBforIdfDIU/xlihv6UXCZU4xK2jCsruO1yqxEWLGUyoT/JIkuWWa1uUbWFcrrKag2M9YsiD9+TjVISs5fRyYIZO4WHiDxbToLRodBMPLFkdZmOSnV4ytL0ui9S1Vrna1Bddonlq41wSfNAOxJhishzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l22nGYKAGTdZiw2acRkW3debv5c2gpAmpPK6I/XiLqw=;
 b=kFN8wWHdCPK4phsry4452rFDpPeds5jWpgiTb/rXXnK3sBJXyyhMUhY+5aUipMUQnHQjUKhG1sqy4LPgF3cXo9nBkLj6F66onTHmJW0XRJBMXn8wfRDVxxWwsrPmUOOhGhAfleql3+zYmcnrjz3ktR8358wc/mXmrbpStZpirmUqrZLdMCpm3/ujZBp6ciNISTi9R2/Ats6dvFR0nkREjemfD2TgzfGIEAWE9eXH1wWYyJ28uJGD3cFcqcefUr+QaXC0t8sttPE7SiTNeeiWBN2GxwkDB/sJcrablTKlgavQxj3Or8CwnpqaCBWHkvTmN1wY9ctlDlNJljPHLlArsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l22nGYKAGTdZiw2acRkW3debv5c2gpAmpPK6I/XiLqw=;
 b=gihc3W53ONRT+cAGzYDgdoGHnBGE44U8gG8FJWlX6Jb/1Wccphg/rUrIIRTiN1kjv7ClBeKGzs6Nq885+E1H+EnL2pH899POAZRNS94ydNwxTXjK+mR+Dg+A4eRynm9iQ7TsGG5cleaup0tu6wht5w76YmegSYOzOJNDFZY7zux13InwsiiaA1kFAncsEweUeGuPJq5ezE8Sjp/tK+ccvqhEIpXeMCfvV+2cmU08jQv09osdKdAZmi0JiGdhrRzQFA1M/mF3XT85SGD7rWqk9N/s2+oJN6amFWREQgJQPZeGDsVsnpv95WKthwlnUXR65NGiZmz31ltsWI1sD4AEYQ==
Received: from CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22)
 by SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 08:21:12 +0000
Received: from CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::9aa5:422d:f716:1402]) by CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::9aa5:422d:f716:1402%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 08:21:12 +0000
Message-ID:
 <CY8PR11MB777932FEDD8F24325A236B8197E72@CY8PR11MB7779.namprd11.prod.outlook.com>
Date: Fri, 10 May 2024 16:21:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a null pointer check for
 the serial_test_tp_attach_query
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240424020444.2375773-1-chentao@kylinos.cn>
 <20240424020444.2375773-5-chentao@kylinos.cn>
 <79df3541-5557-05fa-a81e-84728d509bfc@iogearbox.net>
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <79df3541-5557-05fa-a81e-84728d509bfc@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [p0vTF+9R9RwnSu3w9DxWdTUPv3ALc66V8P9VTI4gDLA=]
X-ClientProxiedBy: TYWP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::11) To CY8PR11MB7779.namprd11.prod.outlook.com
 (2603:10b6:930:77::22)
X-Microsoft-Original-Message-ID:
 <65b07425-1871-487f-a000-a5b1e6b8d195@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7779:EE_|SA3PR11MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 12162b60-578f-4ef3-ae4d-08dc70ca2750
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	1cznWz3OFch9QTCzJvj/bSDStvPbUAI57wuk5K0/9yiTiUIUAV9JPXxuu+JaSU5kgGz/ciTDKsxxZWnC1XC+a5+VIRb8wuFJAo7OtwKYDIgOk9kJXkLd0s4L0UWu5r0LS65M/TKKvvwpxmMiU7VyMIah/IRqUYUF/l7Qtbozou0oV+pD6SxZTFM+m5tnDtFqkgtycO36AKJfOIfhsCxn4Uo/ZmF7y9csTZXp1teRLJgZ/6240d3HPjm3uQ7ohORjmUB3cyehrObbetQD13LPMMLLonXXpctI9LIgfDcDekUiljBLIsKdZKVomPH1SOELNkPnZ6dRWa1C+PPtEoZC9KwWGUDHGZwdLn5ZaNOxALGYit3JHmfVGq10GUQscY/TVUG9i38nTvUPONCmk0H2BX6FzVhi7l3SkRvXN8M9W+TSXmClYUBI3BWNDx2qGFaY8XCrCAa+MUMDekWlKZgZDJiePDNPFVibRKm5YsY+zzOuOSVsqI0A8ydfJM7SjIfAmrU0DZ1DuMTixcqkOXjr5u6XcK7//ir7/Wq9daW+vbcVdZuparwYCUX7YxjLkwazPuG4nuJumAiBZSS6SEOjqELdXqaoPOPRISY9TfZnguVtl472uTqBNfdnwsBcbJSK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0VabHc4QnJycW42RjI3SjVqN1c5UmxrNkF2Mi9WaHlPRWgycVFtcnduUTJO?=
 =?utf-8?B?bmRPVVVNSUJRMHIxQjliKzZGU1ZLQ203Wm1NamZRWUVuaUpJbUwwTXpqVE9y?=
 =?utf-8?B?dkFuLzNzU1NNYjUwZjlXWktLa29Td3RTcG5mY0tqZXYxcXVMc3pFcVFKK2o4?=
 =?utf-8?B?RkN3UFdFYWUrLzVPcnkwekRkSkpKMWMyc1lwcWJQL25OQWVhYkxLYXFXanJv?=
 =?utf-8?B?cm9pWUk2b2NPN2x4OWtOYXhNOTdtSzFvNGdneVZDYk9peHYzb1RuZHlCS1Ur?=
 =?utf-8?B?OW55cCtydk5TbDVoYlM4a2V2eHF1UVJyenZmR1ZzSGdZYzFXRUNmeTA2TzJJ?=
 =?utf-8?B?UHJkT2tTeHJUVHRkRlNYc1F0UUREb3o1SGpHNHJxZ3ZNWEF4QlNRekJGZW5Q?=
 =?utf-8?B?eERVWVJGdzhRTE43SDRadVIxMW5RMFNYLzFQQyt1WlZzT3dqYXRaSmtUczBM?=
 =?utf-8?B?RjdHemdZMm9FRlN1OC9RbXo5bmc2dW1jcXN3Vkp6UzlaS2FWK1RQb0hRZjlX?=
 =?utf-8?B?OVJmd1ZlbnVOSXV6VmF5eDhnOGdXMGg2YUVGa1kwYUVQZUY4RFNiakxoTWNm?=
 =?utf-8?B?QTVJc0IyRDRXek1mUWpIdlJHTldnZGdENHg3TDRJVWM4dzdFR1hCOTJ0czN1?=
 =?utf-8?B?ZG1BLzlDY0VoV2cvREVJNnhiTGdwZlptb1l4cXg0Uk9kaVBmdTJuWDgxV0lj?=
 =?utf-8?B?U1RTNGFIWHdLdnpGZ0NQNlJDV0NmSWtDWGhkWHUwVWloZEN5blI1a09WaG45?=
 =?utf-8?B?K3hYNERaNTRPWjkzUTFPRnlhNno0cWtqZ0JFd0NiMnVDU1QxUkJoZi9pN1c3?=
 =?utf-8?B?Q2lUNjJMQ3JZZlIySFU5b3p5Ry8rUFNxcUNWYTRUU2tKV25WVWZlVEN2amJx?=
 =?utf-8?B?STc1a3hQQjVVcnRHZ1FDamllM2ptUEEvOHpFUVJqdTFCMHR5aUNJMW4vZWg2?=
 =?utf-8?B?ek42V1ZWcEdJRHBxOG4vNlNBclR3eWRRSzN4NDI5dXE1bHBlM0NRZDA0VlpV?=
 =?utf-8?B?Q1o4aSs5R2dtNVRvZXNuRmVYNUY4Ym4zVlpuNVJTUDFuYngvN0FNWXBQam9j?=
 =?utf-8?B?VXh1d3RvR044dnZ4aUo3V1lFNWtMTVZuZGJPRUM3QTd5N3ZYTUI3MEMwbWtF?=
 =?utf-8?B?NXl2RUtTUnhscXIxRGRsMlRLQXJpUEtkRjRFOWs3SlBBVnhaTXNTMWhZb0RP?=
 =?utf-8?B?MWxxQjQyaU5vZ2FtOFkxcU5YZFdUbmNBbTYrQ0hZWkJDZzJiWTU5TlFmdTdI?=
 =?utf-8?B?R3oxaVY2VldzY05OMnBtazJRN0FiaG5LWW52YlB4RmJQL1lRcHhmdDB5SzZs?=
 =?utf-8?B?dlBnb24xTjRMQ3JkWVNQZkFtZ25Sb2liZzh3dU9qL213NDArUzNsc013bTR2?=
 =?utf-8?B?TEh2dFNqY2JqTGxaZUk0OVBKR1RzSjVwdVV1bk9FMjVWUVNiR0t0ZHJzWWFD?=
 =?utf-8?B?QStIVEhKT3BJZkhXUEp2dVhJMjRJMUdtRUJxblZVZXNzOHc1akdyeTdDQmJJ?=
 =?utf-8?B?dm5JdkowSWR1dDZkMndyQlJjS0xFSzhOaGoxN1NiL2JFV3ZqVnZDc1JZc2hX?=
 =?utf-8?B?U1dFUXVCbndITEtUTVo0Vkg2S0t6Rk1uelIwejlsYlRhQXJEcmE1QTcrMnpT?=
 =?utf-8?B?OEsxOFNtR2Z0M3l6YzRFQU00SEdCZWhTbGxPc2xpdEs2MkZJS0tLenhRODFK?=
 =?utf-8?Q?Mk2e3gVFgu4rH+lqw4EW?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 12162b60-578f-4ef3-ae4d-08dc70ca2750
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:12.7070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487

Thanks all for your reply.

On 2024/5/3 23:47, Daniel Borkmann wrote:
> On 4/24/24 4:04 AM, Kunwu Chan wrote:
>> There is a 'malloc' call, which can be unsuccessful.
>> Add the malloc failure checking to avoid possible null
>> dereference.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c 
>> b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> index 655d69f0ff0b..302b25408a53 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
>> @@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
>>       attr.wakeup_events = 1;
>>         query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
>> +    if (CHECK(!query, "malloc()", "error:%s\n", strerror(errno)))
>
> Series looks reasonable, small nit on CHECK() : Lets use ASSERT*() 
> macros given they are
> preferred over the latter :
>
> if (!ASSERT_OK_PTR(buf, "malloc"))

Thanks, I'll update it in v2:

1: Use ASSERT_OK_PTR instead of CHECK

2: Add a suggested-by tag for you

>
>> +        return;
>> +
>>       for (i = 0; i < num_progs; i++) {
>>           err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, 
>> &obj[i],
>>                       &prog_fd[i]);
>>
>

