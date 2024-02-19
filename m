Return-Path: <linux-kselftest+bounces-4930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D285285A53D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 15:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111671C21584
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1036AFF;
	Mon, 19 Feb 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jcr4shji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FF36136;
	Mon, 19 Feb 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351275; cv=none; b=DtkRQV/7VbWjqa1pbyBBTm9ug3d2iWoI7vRRdg588ys8yF1zRyEEfMVr7/z2qZINPXgd8fGQZ3GIJ5jCz+2fxJgqFQunGwVGrwccKjAIfCnCuik5lBcBeZOgYTqNXBnfCOkmlzX9Cgxsabjt8U3TwQjKjOVmJfGhiO4wJ0++MCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351275; c=relaxed/simple;
	bh=ikzcV1URla2GgnY93GwPS2bZ/HFf3YKKWO17DlHhvWg=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dsca40eu3gZhArzZEy1UWyFEr1Z+N19C6VA+rKu+HWEBmdR7wOuI1kPsDI3kpwtGQw8z3mM3xp9fv3/QrUSRj2J2spIsTRxusHJ+YEb2O19ev1og9zie6u1HsLewBz3jqWqmsfqQSbNuVuwMlz3LZYPLzticiSeDn1YFW2Mp2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jcr4shji; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708351274; x=1739887274;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=W7gVIamMoMUxGHZcPfOMCqRDKpC788b33nadGhFmXO8=;
  b=Jcr4shjiy6STwx3+Y74P3FZ78VW6hSiz98kFe9s6f5D7O8VIqhN944n4
   i9FOxc2I8khzf4e6EU6nm18Igrszai1QWoSO1IlMIYmO4kIAQiOYh7bRh
   fM2T00HeOj4yAi/P8nmbPa7SotPw+ATfGTZkfQGsMnqQKIEyZruPF2IlJ
   o=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="638842739"
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 14:01:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:5692]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.15:2525] with esmtp (Farcaster)
 id c94ac43a-ba01-480a-b5f1-b87cfce8f244; Mon, 19 Feb 2024 14:01:09 +0000 (UTC)
X-Farcaster-Flow-ID: c94ac43a-ba01-480a-b5f1-b87cfce8f244
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 14:01:08 +0000
Received: from [192.168.11.164] (10.106.83.24) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 14:01:08 +0000
Message-ID: <ee8b746b-aee9-43d8-949b-62017fe0bca0@amazon.com>
Date: Mon, 19 Feb 2024 14:01:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Kees Cook <keescook@chromium.org>
CC: <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<Vijaikumar_Kanagarajan@mentor.com>, <brauner@kernel.org>,
	<jlayton@kernel.org>, <jack@suse.cz>
References: <20240217003142.86297-1-sj@kernel.org>
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <20240217003142.86297-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D001EUB003.ant.amazon.com (10.252.51.38) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 17/02/2024 00:31, SeongJae Park wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Fri, 16 Feb 2024 16:01:20 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
>> On Wed, Feb 14, 2024 at 05:13:09PM -0800, SeongJae Park wrote:
>>> A gentle reminder.
>>>
>>>
>>> Thanks,
>>> SJ
>>>
>>> On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:
>>>
>>>> On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
>>>>
>>>>> On 08/02/2024 21:29, SeongJae Park wrote:
>>>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>>>>
>>>>>>
>>>>>>
>>>>>> While mq_perf_tests runs with the default kselftest timeout limit, which
>>>>>> is 45 seconds, the test takes about 60 seconds to complete on i3.metal
>>>>>> AWS instances.  Hence, the test always times out.  Increase the timeout
>>>>>> to 100 seconds.
>>>>>>
>>>>>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
>>>>>> Cc: <stable@vger.kernel.org> # 5.4.x
>>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>>>> ---
>>>>>>    tools/testing/selftests/mqueue/setting | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>    create mode 100644 tools/testing/selftests/mqueue/setting
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
>>>>>> new file mode 100644
>>>>>> index 000000000000..54dc12287839
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/mqueue/setting
>>>>>> @@ -0,0 +1 @@
>>>>>> +timeout=100
>>>>>> --
>>>>>> 2.39.2
>>>>>>
>>>>>>
>>>>>
>>>>> Added Vijai Kumar to CC
>>>>>
>>>>> This looks similar to [PATCH] kselftest: mqueue: increase timeout
>>>>> https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7
>>>>> which was increasing the timeout to 180 however it's not clear why this
>>>>> hasn't been merged yet.
>>
>> Should it be 100 or 180?
Both options may work, I am more inclined to have this as 180 seconds by 
giving more time for the test to finish, this can be reduced later to 
100 or something else if we start hearing complains about the new timeout.

Hazem
> 
> As mentioned on the previous mail[1], either values are good to me :)
> 
> [1] https://lore.kernel.org/r/20240215011309.73168-1-sj@kernel.org
> 
>> Either way:
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thank you!
> 
> 
> Thanks,
> SJ
> 
>>
>> --
>> Kees Cook
>>


