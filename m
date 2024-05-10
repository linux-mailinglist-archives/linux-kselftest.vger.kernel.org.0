Return-Path: <linux-kselftest+bounces-9992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F08C1FED
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A31F229EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984C15FD03;
	Fri, 10 May 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DLL4VGX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2080.outbound.protection.outlook.com [40.92.19.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34EA15F322;
	Fri, 10 May 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330443; cv=fail; b=Gz3/rz2pb3PBJbnQPc+6RWuHXbWcK/62M8flIBc6qxoeLAfektljYITgvlMXmX7tf9O6lV5Ht/kfqWXFTrmYYMsDBfsef0+anX+LNSqE2UTAoPuNbKPu/T3SPI4qJv+qm7zjAb/+SQmOmKdqwW99DekmReESZoFls6F2mRzl+gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330443; c=relaxed/simple;
	bh=GNGk/GfuFG78DxLRXoXKIe9xrnlyICBPCFXJ06m10WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bD3mnRPQcvFSEJqLFKNO+v4NsHy+KnGKr5pPZ2mOCU0cxpElYYN45nBw+bAdMD13gNIZ6wgOuX26qsFX2jNE+yvuqWshd1CahPxA4SQVFioB7RRGBeKiez+1zds2Og94BZYIVbIutR3CsPMUDHBLxoSlNzhHf1fH2oB4I6Og8w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DLL4VGX0; arc=fail smtp.client-ip=40.92.19.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6goZZHiag1gH4odHoC9LU26qu+nXqjmhg8usAs1gNHEegqvTavxZ2fcXhwu4ppL7YHDanoHe32kiSfcYN0NFDobr5e9yqjsCLeAtmCGe/a6UOWnzjXxpl5TFTvUwpQE9Sc+GuTKup2mq16yY6FG7mzo9pvs3aNIZXlTF9zQW98EmctIlLQoIgkM5qoU/+3SJpCcDOg2CCA4o2uHPWTAI8dFh/pzn3rqb3Py6kBT85CJefA3GZQ5GoP+8xLdBHIQ6Cufi48XbtkV9UwSE6sx9fDmodQ+foE5egfmRPXhOlymOjPQ2EbXlgOQBQtK9Ec6OsmyU1+j7bXJV9P8j9yQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJamwaEH7nd2OCAr9ujkttRmD+eEpB5DydR4Ywn+qPQ=;
 b=RG9pIufZWPBfssBEhVclPFJ9vn5LfXbS5cx+W52JxBSRXSzWPmNZQbOZGDEqmcow54UtwqZp65FV4GIoCOI4OQAXADBp6CDqz6oAHn/IPY4wKneawcxcYY7T+lHFaolWR5TqqjngN83N4lonnnJF/wVt6peATZGiauyqSC9NFiRAfVyAxgQiCHAQ0Oa9b9dhm//r0YBBgpxMrAsKOfh880wz3Ua7nrjb6ZjjIxcZYKC76czupTFTKw7+L+RWcY3oFyJJH8puY5+Pv50db2ykr5R6qxtTIRegF5UCkMkY2pQmoP9A1O5YoLuUsw5SBrms0fmSVZ8Kk4cUc/E58pKw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJamwaEH7nd2OCAr9ujkttRmD+eEpB5DydR4Ywn+qPQ=;
 b=DLL4VGX0oT4wqebxMeJjwPqDkeRAvQxg7OCO9OWM8ShC6OnpaW7yDt3ibgmvJx513948Sg0XyPUZDCseUPwuwT5Ntf+gtAUC7TSHHSbY7aryUrSz4wdB526s0AilvrlDNhsVZGUmJZsv+ri3aKTYzyBRiNKVPANFwpHLVo419QmTUdVln59AbVXb48qoVugMDO18d6sEhIdjHUchZnvEulbrl5etYh9+O5IGfMoJK5ajut5BuiE3Yp44sWJEbWFqChM9NmRvD87LI4cy9Dj4aeFVYQSO9UQS88s2eSLQJmeQ9avt9DRmlTycIZqypxJ0abrgD9YwUzGnA6Kfj9vhsQ==
Received: from CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 08:40:39 +0000
Received: from CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::9aa5:422d:f716:1402]) by CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::9aa5:422d:f716:1402%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 08:40:38 +0000
Message-ID:
 <CY8PR11MB777929A2326482E8F5F00F6B97E72@CY8PR11MB7779.namprd11.prod.outlook.com>
Date: Fri, 10 May 2024 16:40:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
 Oliver Upton <oliver.upton@linux.dev>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Markus Elfring <Markus.Elfring@web.de>, Kunwu Chan <chentao@kylinos.cn>,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Anup Patel <anup@brainfault.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
 <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de> <ZifMAWn32tZBQHs0@google.com>
 <20240423-0db9024011213dcffe815c5c@orel> <ZigI48_cI7Twb9gD@google.com>
 <20240424-e31c64bda7872b0be52e4c16@orel> <ZikcgIhyRbz5APPZ@google.com>
 <Zik_Aat5JJtWk0AM@linux.dev> <ZiqEFqomGLmDR7dg@google.com>
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <ZiqEFqomGLmDR7dg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [HoJQAhhZY1jHxCy6948iISefv/aRSyMANkZIURfhIkg=]
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To CY8PR11MB7779.namprd11.prod.outlook.com
 (2603:10b6:930:77::22)
X-Microsoft-Original-Message-ID:
 <54505156-c27f-44a3-8420-ec1e5e6e687a@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7779:EE_|LV8PR11MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cbe149-3663-40b7-edb1-08dc70ccde11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|56899024|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	y41/ccBnYJ6AOy6vMqVzHl43hlrfwjFIqJZqE17gNBrTYK12b9y0jEjPd8LikJBa++p1G8Cx54XhEyMfgm6C6G8iovv9e+lmEZlEHzrSZo9V7dBDj5Vi9eyEDlb2gzzrGMKoL111bN2CWoXbb/ZfJOXJD3uwi+otoGL1EiMnv6V7VEtczkgSsOLcdqKcQiXado+6rZ8LSjKwOqhwzPPD0wOhLXtiMAT8b3dKaNyNKfu3ZazwjxzdX8MOLg3WsaksZvMN0aNnnRkTD3R8M7qwQLiqloP4GoJKF1T+zL6+0sEevHHJSSkoRs1z888Z2cyN+SxpXvJM/SHfIsWxuaE89jeT+VEHyYFdEu3KrvA/q48F2ddQZVCjKdnmnXK+JLOaCO2XldXGGFe7z9gOLPyyjJqg3Ij8A3jTZMaGJGdAsDO41PfryoS2DY2ixY/b4wBY1MQtPEo/Vg8WGzxudmnf9OU3O+2TOu4LWmMqoVh/kv9v8K6tJRB+HXgCGzs3JCSZaxPZtcHIN5WN+0k/Rdf14CNGdKBw/TNLybaqkgKWZhddisZGZ52qfb+NxDX952G8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9XTmNGdzVjSWdtU1pTbUFpeHg0K2pndUtiRjI0VmhSTlFNNFdOK01DU1dV?=
 =?utf-8?B?RzNEeDFRVGVLQjE2T2pSQTFMbTVMaldGam5Oazdrc0RpZWZXejJGZUMvbytp?=
 =?utf-8?B?dlNvUXhnWk10c21pbG1SWjRXVnczRVhOQ21rT2FyY0RUOXpZcGFtZDkyeUVI?=
 =?utf-8?B?TmNob3BhVkVHcXBjV3M0YU1uS0grd2tydE0yY1FMSURacGZrVWlNSm5IZHdW?=
 =?utf-8?B?cW5sK1ZJY2JwVExkRUE5QlRqSHQ3ditTMFpiblRhT2RYK2NCcmJpejV5c0d2?=
 =?utf-8?B?b1lvSmkwOHoyazhFUHJNYVpRODVuQktzeGZSTUNEZkI5cXovaXB3Y0l1Q3Nm?=
 =?utf-8?B?MWFxNEtNVWtaQXBtaHJaRkpPTUtPR0d5aDk4MHNNWm5ub1NHRi9lbnhINHli?=
 =?utf-8?B?SWVrT3ZNNnRpeGhBNkJKVzBPYTZtWUg5MllsS2Yvc0pNRnIycDRURTNiSGlQ?=
 =?utf-8?B?eFN4aFpqMmVYK0N1Z3FMZE00QUIrTlhtYWNuL1VUVDJkNEVpSTE1bDNkMzFi?=
 =?utf-8?B?aEZhd3l1RS9SbHprTUxrcFlGTERxUER1OTlHNFJKMkRvRXNlbEdSbjRPS3Er?=
 =?utf-8?B?Y1daNTh4RzhxMytwcUkxa3JOQ0xyT05DcXRIeHp2RW41dTI5eitpbUtUZG5x?=
 =?utf-8?B?OTZuckxKUVBpR29MNVF3Vm1lTVB5M09LaXNDSEJ4SVBPc09qOHVJajFPa2lu?=
 =?utf-8?B?d3JBVXlWdlhpWU41MGpiWmM0UjAzdGNmWUFFbzdOR0pxSG1uRzhSRkxEYXp5?=
 =?utf-8?B?Smd6c2N4S3drbkV3emo4T2EyZWp0V2txdFVRVHpUYWl1b3dtZFZXWHc4K2Jy?=
 =?utf-8?B?TjBuYzI2S1RqUzhSMEo3VUpuZXY0RHp4Q1E3WWJ5UFBJUGRneDQxUUF5NHB6?=
 =?utf-8?B?NkpPUWMvcThuZFk0aWN0bEo5R1hrd05XZWtrMitEZzhBcjFJWDNjT1NOZFB6?=
 =?utf-8?B?T3k0TG1iQnY4b2ZiZ1FJWG1ENjR1R0E1MkowaDd1cGlKWmRaVEU0OXo2cXF2?=
 =?utf-8?B?NlZ6VVdFbGd3ZUt3TmZYaGN1SFRaWnlscXFVL0NSZW1ieW0zVVlmYi9zNjIz?=
 =?utf-8?B?a2orOFhXMHN6bjJjRUNSWFhEUmpZT3Yrcy9HeWxEQk5wZDIvOXhuMWVVby9E?=
 =?utf-8?B?Y0ltd2Z4eHpoL3V2N1ltcTVEL2MrK083WnB6YStpeU55WTFESHEzOS9wTWxG?=
 =?utf-8?B?WW5GZStoOXdEOTFQajlUWkhteXExY3BHckp0eWVlWHovdWlXb2UwWHN5UldW?=
 =?utf-8?B?bVRBekl3eWF1YXhhNXZudGljV2VwVFlBOEFGLzhaWmlnRm5wa1dJdzk3aVFl?=
 =?utf-8?B?M2tmLzVCb1p3Y052Mms0aWxPQjQ3N2h1NDZCRlFSS0kxTHJqdFc5ZlBLSUxl?=
 =?utf-8?B?Y3Nyb2VXS0JBcU83Um9rU09kMm1nWFl0T01iaUI0cFR1R081R21sQ0dYSUpl?=
 =?utf-8?B?VHFLdnUxenVHOGx3cEhkSndudGpyNGovZjlpOHl1L1NTMTNNN1pDWmtYa0lX?=
 =?utf-8?B?QjQxNldmYlpZWlBpOUt1VU1tUGVTeWVIRmlZSnY0bWNXa3lBaDd5dEZmVVkw?=
 =?utf-8?B?VDdOd1UrY0ZYZkF2UTdqejRqNlhuL0k3UGJwaHRJR2VTK0JsaityNS9xcFJu?=
 =?utf-8?B?MUd2T0hzNU1Sb3ZTblhsK0k0RjBST0ZLZHpYZ0pYTVpiTG9RakVkdFQwK1RE?=
 =?utf-8?Q?2/hi3fodrsWGkwoAknTu?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cbe149-3663-40b7-edb1-08dc70ccde11
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:40:38.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606

Thanks for reply.

On 2024/4/26 00:25, Sean Christopherson wrote:
> On Wed, Apr 24, 2024, Oliver Upton wrote:
>> Hey,
>>
>> On Wed, Apr 24, 2024 at 07:51:44AM -0700, Sean Christopherson wrote:
>>> On Wed, Apr 24, 2024, Andrew Jones wrote:
>>>> On Tue, Apr 23, 2024 at 12:15:47PM -0700, Sean Christopherson wrote:
>>>> ...
>>>>> I almost wonder if we should just pick a prefix that's less obviously connected
>>>>> to KVM and/or selftests, but unique and short.
>>>>>
>>>> How about kvmsft_ ? It's based on the ksft_ prefix of kselftest.h. Maybe
>>>> it's too close to ksft though and would be confusing when using both in
>>>> the same test?
>>> I would prefer something short, and for whatever reason I have a mental block
>>> with ksft.  I always read it as "k soft", which is completely nonsensical :-)
>> I despise brevity in tests, so my strong preference is to use some form
>> of 'namespaced' helper. Perhaps others have better memory than
>> I do, but I'm quick to forget the selftests library and find the more
>> verbose / obvious function names helpful for jogging my memory.
> Hmm, I generally agree, but in this case I think there's value in having the
> names *not* stand out, because they really are uninteresting and would ideally
> blend in.  I can't envision a scenario where we don't want to assert on an OOM,
> i.e. there should never be a need to use a raw malloc(), and so I don't see much
> value in making it obvious that the call sites are doing something special.
>
>>>> I'm not a huge fan of capital letters, but we could also do something like
>>>> MALLOC()/CALLOC().
>>> Hmm, I'm not usually a fan either, but that could actually work quite well in this
>>> case.  It would be quite intuitive, easy to visually parse whereas tmalloc() vs
>>> malloc() kinda looks like a typo, and would more clearly communicate that they're
>>> macros.
>> Ooo, don't leave me out on the bikeshedding! How about TEST_MALLOC() /
>> TEST_CALLOC(). It is vaguely similar to TEST_ASSERT(), which I'd hope
>> would give the impression that an assertion is lurking below.
> Yeah, but it could also give the false impression that the macro does something
> fancier, e.g. this makes me want to peek at TEST_MALLOC() to see what it's doing
>
> 	cpuid = TEST_MALLOC(kvm_cpuid2_size(nr_entries));
>
> whereas this isn't quite enough to pique my curiosity.
>
> 	cpuid = MALLOC(kvm_cpuid2_size(nr_entries));
>
> So I have a slight preference for just MALLOC()/CALLOC(), but I'm also ok with a
> TEST_ prefix, my brain can adapt.  One of those two flavors has my vote.

According to the previous discussion, so which method do we need to use now?

If you have a consensus, if necessary, I can continue to do this work.

We had many different way in selftests to check the null pointer or fail 
state, such as 'ksft_exit_fail_*' 'ASSERT_*' 'CHECK*' or just use if 
statement.

If we add a new macro, whether these old usage should be changed as well.




