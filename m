Return-Path: <linux-kselftest+bounces-8754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C18AFEFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FA21C22466
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878783CD6;
	Wed, 24 Apr 2024 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OCErN4fq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2060.outbound.protection.outlook.com [40.92.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A628DDA;
	Wed, 24 Apr 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927586; cv=fail; b=C9JC+Rb5ofre0NYREXFPrb3fPrYEA3yy37bvdYqasdh0BEQA90F+66ua2pTX0GCn6xOhuCBzwKLweQIq74xCKyAsLOGLDr7OySU/q0fJPAgOQb0JqaGZ2+AwHg/137NInr9a9R8pGE2x6PNi4LbwTwM0udpa/d4Okto1OmQfRQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927586; c=relaxed/simple;
	bh=4e7zUCjCGIg2v1ksFVSpaRNGcqC9sjp6wMWhWtPEfyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mzZB3XZRU0D/Kv2sUajtbZZLK0swUoAlaMOZDBFXdV+irKE6q+XKxYbPtAj6opLfQWrCeslqKCwRXTPMOmvEWX6SnEWB/flmfUMJI2uyllICbpqKL4dOs8zkGhpJgeSrOpG6d+PLtnm/UcgMKVBD5eZgr2lvbTtNmdFRlGSa/OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OCErN4fq; arc=fail smtp.client-ip=40.92.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHs9vRNyrIAn2S/lqDfSwcmztSJb9pGVPseW7HRVSit+GpdHQae7RRjdN9A2khhK+P077tfGI7nEffHnenqcPf0LqqZBa0HZYqEwGdD3pa6D2ESw++Zv9fZvR6wQeR3kpjUVNhmRxfhcaADbeuVDK6XVwdW/JlrvwPQF2FdB1UFvdOaV/Rf8JwkKBMLCP7IN1RSQvs0mJAlO40V6UGKyxC7cvevN3C1EOMTz6wVwyORuElSKpLPk/uU4jPpjJJrQL9IQOt+QLRLi05GE+6cjqfz5HM3l6b7I6uCf1E/qS8oHoj6uL9zy9Bh6/NSiOq0tyYeDLbAsMeonRb4kovRZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmjRa81oz7c1UlvZ68M9JfXeqPS8C3YmCdkErwkeeUQ=;
 b=Xknhy/4u9BebBOb5v/p2a9i3IR80Zu3SF9RwdOVdVF5Dpj0FBZ8kcM10QnTj2OhEmv3HyaIS78aZi8gKc/y6WS9QeRGlD2Kc55K1Y8mZmo0PPUS2a8114fxiq9WmdRB2w0v8JTGUTAAK+da8rRkK/n2gRnZggup0vNeqcR2lKzprolT8pp5WE5HORvbkPbwx9FK5ltLDm4t/tOlRGXw5VbG3Zi3gGcoQAJu/+xaGyAIDKo7e571bpv9xu8ZwpOpLPMVBdLOXbe0f+5DxWXwzYoeLUmXSVHGL+pSf3WHpMoBBMswXcJoaphXYMHaYnb3Dxy68RZOKwU8mjkrHEJfERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmjRa81oz7c1UlvZ68M9JfXeqPS8C3YmCdkErwkeeUQ=;
 b=OCErN4fqoi0zskntRkyUovDO0GBJ3EB6tVD9CWZu9lBK01P2FKUbJ/p8Z6iRS3latiyKpW6s6REGvzjaNMcnKIdAemIaqG7s8yHUESM+/fI3BhlIwxaLFR6tEFt8tMi+Csx+fSbr11w/frZwwryf2x9T/mvB9JUtGIJb3tNhxgk3LpEmBGGEDZn1yZsR59KubUSWcH++uHil0IdgWJtkWc2sfEBTvhtHiToH6rnGHfCqt/tvX2qhRvoUyXxmqfB4nHt0wTq30JsYU+BJPGyMDFMamaOeShLlPZXDoP2S82COVymFjW6vjfMlPv4r+t/U7jfDtNOeFI8XFPRDKx4WIQ==
Received: from DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) by
 PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.21; Wed, 24 Apr 2024 02:59:42 +0000
Received: from DS7PR11MB7784.namprd11.prod.outlook.com
 ([fe80::a7b8:abf5:94b8:47b5]) by DS7PR11MB7784.namprd11.prod.outlook.com
 ([fe80::a7b8:abf5:94b8:47b5%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 02:59:42 +0000
Message-ID:
 <DS7PR11MB7784C50A318F0FA92CC334EF97102@DS7PR11MB7784.namprd11.prod.outlook.com>
Date: Wed, 24 Apr 2024 10:59:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
To: Sean Christopherson <seanjc@google.com>,
 Andrew Jones <ajones@ventanamicro.com>, chentao@kylinos.cn
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>,
 Anup Patel <anup@brainfault.org>, Thomas Huth <thuth@redhat.com>,
 Oliver Upton <oliver.upton@linux.dev>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
 <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de> <ZifMAWn32tZBQHs0@google.com>
 <20240423-0db9024011213dcffe815c5c@orel> <ZigI48_cI7Twb9gD@google.com>
Content-Language: en-US
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <ZigI48_cI7Twb9gD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [fAi/PJTUwNToLk3EMq02jJfnfeKQJt3STYnx/+ezCfY=]
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To DS7PR11MB7784.namprd11.prod.outlook.com
 (2603:10b6:8:e1::14)
X-Microsoft-Original-Message-ID:
 <a19e7e66-b2f8-4bed-8c7d-02e9beb95414@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7784:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf1b7bd-b46b-49ff-94b8-08dc640a967c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|56899024|1710799017;
X-Microsoft-Antispam-Message-Info:
	bXXqFeyAJhk2cYe/zY93EYdt9mHI50mdK0mHYMuwNrFn+i5tgGzHPiUHL1L0Ui+t4MdL2Q5UuMcnC6y4RhM7N4F3hL4eM5GVXeuiHBepDz6cERvESQkMxRtmLDOxW2kKj6cOocN1Vp6+SEi6fv/NHlSkF8LnkOHjHT9PgLescFUgiFrr+dodIEEyx6XIut5hTICxJLcdrTdaZRchBzqp9AMBGU0ckpiLFrpwCINgiRAsqozbagbGIHmzE5zms3xUUBqZsnbWOJdMkQs8XCTelgFqPrbX5ZPv2dayZ8nZrpB1/mDK6YDXlHABpZ6ch7a5GJI/klb0/RJZ1CanYww/EDpJs6vAMaUSCd4Kj+R8pyUasKYZKFNXj33oDBUuldjStlVN27YY681Nq7dk0COnRqGIaQU/m+zlu9GcMNLkdI5dKlBLEnIm5k/0fkOKgnI91VxQkgqzgNOWdLCcXY0UtOhRDiypQT1XuC1lXKau+7sQm8Fc6auIip6BgcxoNArRKqRcl3a3ACL5CqBEB/EAvAgZS7/LR297LxXGa8cXDkye9FqKnVLjr1y2ka7BumcRfjnZkffxtW5yy7XZ3FzpKiAM67gnaQYXq/AwjWKmyeUNG3yQB9xUTC4uTixSMA1ZxOTvJyY9dUZl1FAUSbZBAITjSI3AfdmKc+zlU/fCFnroABle/gkQTNjRRuc98GBE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZiVVRrZHJBeWlmMDFnb1VKSXpkWEYwYk9MN25SY2Z1VFhJUURuUDRQZ2p4?=
 =?utf-8?B?cDlZOFJXdUppZ2x2bFRNUG1KRHR2UGxOVHVHbk5JdlYzYkpuMkdySGZNS1FD?=
 =?utf-8?B?MENCTjRZV2Y4YVBjWnlrTldJVTNWY1F3ak8zQm5HdFg4VmpPbFNuQ21BQWx6?=
 =?utf-8?B?amE3TWovN2JQdU5FMWFGa0s5OWNiQVpySitRL1ZrRitYRXFTc0VQUFF4ZEhl?=
 =?utf-8?B?WW1HK0tyTG5zRlRLVmxXWFcyQW9YRlhiMDhOSHhLaUZoYmlNa0c2aVBQQ3N6?=
 =?utf-8?B?bm43a05vSGRldE1lWDlVcHJTWjJyWTFkckwybE9xZkx3ckF3RWIzMzFMS3dl?=
 =?utf-8?B?Y1NrNzRWVXVVMkZVYmJMR2hySGJQMVV2MFk4NTlJbThKaDV5YjdzeUFGOE56?=
 =?utf-8?B?bWgyTjVsQXREZFJINURmNmF5K0ttbGVKd2lPZ05rYWI3WjlPL1dLUzkyQ3VT?=
 =?utf-8?B?YWFJNy9WS1RPczhiQ25UU1hGc1dJNHVBQVRtd2dvazBlQjBodjZZWUhMeEtF?=
 =?utf-8?B?U2p6R3ZqSE1wNFJGSlZtbkp3ZzFZcmI2ZG5mR1I2VHFGWWkrdS9SVUhueWNl?=
 =?utf-8?B?SWtJVFA0OFZkMklYeHpNaWl6NksrTENYcUJRemNBRHphY1A2bDdRVXh2ZmdW?=
 =?utf-8?B?NE9LZHhwZDR3czNGWnNmZmVOTU8yVXpVNGN6dGw0QVQxOTc0QkIvRHNuc0xY?=
 =?utf-8?B?M0VMNjZTOHlkTENLZDFmZjZWbTZoVFUyMUtvWWRTU2ZJa1ZiWHdDdE43dEk4?=
 =?utf-8?B?eE5IRHNGaVFPcER0MC93NWp2REtZN0VyN0Z5MW9ubzZPUnBpczAzRFBaeG05?=
 =?utf-8?B?dzY2NVRBNkx5aS93TWdPeldqRkVDdU1SWldiZzV3a3VQY2dmY3RoUHM0NktW?=
 =?utf-8?B?d2tveDk2SWpzdE16MnlSdDkvb3ljR1dpSitCNWI1WVhHNStUeURYK0FWb1o3?=
 =?utf-8?B?dURMa2N1aWM5aGtWWUF6d1lFbVp4NW1lei9iaUEwRnB2M2lpeVZrNEVuR0hW?=
 =?utf-8?B?Wm05NVVhR3NDRSs5TXNsUlhWRkJmcFF2eHR1eEJKakZhYmlHM2VvQVFjc3ZE?=
 =?utf-8?B?aW4yS1o4MExCUTBJa1NJRjl2V0dMS1JwNlpiWVpBNE5lV0U4T3RHZ05BYlBu?=
 =?utf-8?B?RGlsZWcwdEhVcFl4RGpoaHBzYk5heGJtZnBoVVdyVGM3SEdzY2ZWMFRDS3pl?=
 =?utf-8?B?eE9hVDBEREt1QXNOTFozQlJuRTVsc2NkQmFWa1kzQmhyVnA4SFlXMDFPUTdy?=
 =?utf-8?B?Rk91R3UwVG5qZ1Fibm56K1I4M3pZTDFYUzVodGgvMS9qRjdOKzVkODdtUXVh?=
 =?utf-8?B?S1FkVEM1cFM0UHpLZmxzWUp2dFVZMHN0M0x0bWdwSWVlTWVHa2RwT0tiSUNa?=
 =?utf-8?B?aGU0NXRBZEtjR0hNT1VyK3dGamhmTkxmQk9OQm9LOVNGWnlwTEZqU0ZOenVu?=
 =?utf-8?B?VnJiTUdxbnY1NlFoaEs1dGRvcWNJMFNNKzNrK2NuaHFZN1JlYTc0bWFqUXdX?=
 =?utf-8?B?M2RFNmorOVkzZElFc0FjbEFPdngycEplQURLQTRYZ3JPVzBoNWhOSGdRQmds?=
 =?utf-8?B?aDFJa3crYWh0SG9jT3o4ajJyTFhXdUxKYnlJV2NGSCs1MndJc205RXpiL2t0?=
 =?utf-8?B?RlpPeFJycEhGTUs5eW5ITEJWUFpKVVlxdVFHejdrbWUwZVVlM2x5RWJURENG?=
 =?utf-8?Q?/W4k3WhTLUIYyKY0G2CU?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf1b7bd-b46b-49ff-94b8-08dc640a967c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7784.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:59:41.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756

Thanks all for the reply.

On 2024/4/24 03:15, Sean Christopherson wrote:
> On Tue, Apr 23, 2024, Andrew Jones wrote:
>> On Tue, Apr 23, 2024 at 07:56:01AM -0700, Sean Christopherson wrote:
>>> +others
>>>
>>> On Tue, Apr 23, 2024, Markus Elfring wrote:
>>>> …
>>>>> This patch will add the malloc failure checking
>>>> …
>>>>
>>>> * Please use a corresponding imperative wording for the change description.
>>>>
>>>> * Would you like to add the tag “Fixes” accordingly?
>>> Nah, don't bother with Fixes.  OOM will cause the test to fail regardless, the
>>> fact that it gets an assert instead a NULL pointer deref is nice to have, but by
>>> no means does it fix a bug.
>>>
>>>>> +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
>>>>> @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
>>>>>   	const int state_sz = sizeof(struct kvm_nested_state) + getpagesize();
>>>>>   	struct kvm_nested_state *state =
>>>>>   		(struct kvm_nested_state *)malloc(state_sz);
>>>>> +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
>>>> …
>>>>
>>>> Can “errno” be relevant for the error message construction?
>>> Probably not, but there's also no reason to assume ENOMEM.  TEST_ASSERT() spits
>>> out the actual errno, and we can just say something like "malloc() failed for
>>> blah blah blah".
>>>
>>> But rather than keeping playing whack-a-mole, what if we add macros to perform
>>> allocations and assert on the result?  I have zero interest in chasing down all
>>> of the "unsafe" allocations, and odds are very good that we'll collectively fail
>>> to enforce checking on new code.
>>>
>>> E.g. something like (obviously won't compile, just for demonstration purposes)
>>>
>>> #define kvm_malloc(x)
>>> ({
>>> 	void *__ret;
>>>
>>> 	__ret  = malloc(x);
>>> 	TEST_ASSERT(__ret, "Failed malloc(" #x ")\n");
>>> 	__ret;
>>> })
>>>
>>> #define kvm_calloc(x, y)
>>> ({
>>> 	void *__ret;
>>>
>>> 	__ret  = calloc(x, y);
>>> 	TEST_ASSERT(__ret, "Failed calloc(" #x ", " #y ")\n");
>>> 	__ret;
>>> })
>> Sounds good to me, but I'd call them test_malloc, test_calloc, etc. and
>> put them in include/test_util.h
> Possibly terrible idea: what if we used kmalloc() and kcalloc()?  K is for KVM :-)
I'am agree with that we should keep opening state for other memory 
allocate calls as well.
> I like test_* more than kvm_*, but I'm mildly concerned that readers will be
> confused by "test", e.g. initially thinking the "test" means it's just "testing"
> if allocation is possible.
>
> The obvious counter-argument is that people might also get tripped by kmalloc(),
> e.g. thinking that selftests is somehow doing a kernel allocation.
>
> I almost wonder if we should just pick a prefix that's less obviously connected
> to KVM and/or selftests, but unique and short.
It's a good idea.  The marco should be more versatile, cause we had many 
different way in selftests to check the null pointer or fail state, such 
as '
ksft_exit_fail_*' 'ASSERT_*' 'CHECK*' or just use if statement. 
Different part different developer has different usage habits.
We should think these status quo before doing sth.
>
> Hmm, tmalloc(), i.e t[est]malloc()?  tcalloc() gets a bit close to Google's
> TCMalloc[*], but I suspect that any confusion would be entirely limited to
> Googlers, and I'll volunteer us to suck it up and deal with it :-)
>
> [*] https://github.com/google/tcmalloc

And another question is if we add a new macro, whether these old usage 
should be changed as well.

Thanks for your reply.

Looking forward to your reply.


