Return-Path: <linux-kselftest+bounces-5816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44DD86FBF3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B0282259
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 08:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BE19452;
	Mon,  4 Mar 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="AfNcS3MZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C912E73;
	Mon,  4 Mar 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541224; cv=none; b=u//ympttv6kXdOeHECVLCsfi9MKC9+BJ+vcIan1mmGiZADewp/q13XGAoMsjp9Mv1gvCO2c4YKtcPA0X0YxPeF9P6kDw2XCGw6dYJDoJpXMvS7Msp2YcupzQFB8QmCCJkl5cY2Oxl/X7sEPEQ1S3157IsPpp2qqm2ThPU8HYRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541224; c=relaxed/simple;
	bh=jKvnvnpM+aBJq1A6rHR3yQc2yuSmruWr8TgLrALi1n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS6R4a7lRtWu8kU0h7TSBGSu/w1hca/yr9K+tP/DBE08NK5+fO2iR1w9ryxylGxz3cw7RMfKYSDuWKrfdGHSaEbHi/eY4R1id7TvqZCAS+lolshEXcNzdoOfhJj7vVG4mJaNz3xHyw5kvuKxKwreFACUwDKlY9q4dtpVGu6nN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=AfNcS3MZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95C611C000A;
	Mon,  4 Mar 2024 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1709541213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTHSqccs0gSHawyzY/q7v34wU0Ao/p7rZ42hjzeaIWE=;
	b=AfNcS3MZXihW4yqhgCLLzoODR3kQMI7e1ytKPDPv/R2CDSfLqkv3F5t97W2AhsE4OMopHk
	yg8qA05nindM+pDRNtW5UdUK/PWtnhEARqfnyQv+3MO3kp7rztjI7naJroMwKWYuzFC0SF
	13KVIfnEMq9KwX9ZMOuIeXkAneMkjrxxs7DK06cZ+Kr08QbXbi0o7tg/5LhwoGEgQZl09M
	KQx+X4C5wxP8G0yhPTwFX73cv6rMOLFluxHlEzbaWYPB36Uf08RUx/NcUgM8KL3Dq/yKp3
	o5GDwGaxqngePLsSf+LyUj9IJ6KP8+skrfQ2cJkZp4LpJYdYqZVfAAn8g/CJeA==
Message-ID: <1788e114-45ea-4593-ae3c-9c2e794b987a@gtucker.io>
Date: Mon, 4 Mar 2024 09:33:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-US
To: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Nikolai Kondrashov <spbnick@gmail.com>,
 Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
 <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
 <51fa8932e57010620e9a9e16a1979f4883e95a7d.camel@collabora.com>
 <3d7e66bc-967e-45ec-a9e9-12dafd3b3e68@gtucker.io>
 <1801a-65e39e80-6d-2f4e1180@80294519>
From: Guillaume Tucker <gtucker@gtucker.io>
In-Reply-To: <1801a-65e39e80-6d-2f4e1180@80294519>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io

On 02/03/2024 10:48 pm, Gustavo Padovan wrote:
> On Friday, March 01, 2024 18:56 -03, Guillaume Tucker <gtucker@gtucker.io> wrote:
> 
>> On 29/02/2024 17:28, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>> Le jeudi 29 février 2024 à 16:16 +0200, Nikolai Kondrashov a écrit :
>>>> On 2/29/24 2:20 PM, Guillaume Tucker wrote:
>>>>> Hello,
>>>>>
>>>>> On 28/02/2024 23:55, Helen Koike wrote:
>>>>>> Dear Kernel Community,
>>>>>>
>>>>>> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
>>>>>> basic test pipeline triggered by code pushes to a GitLab-CI instance. This
>>>>>> initial version includes static checks (checkpatch and smatch for now) and build
>>>>>> tests across various architectures and configurations. It leverages an
>>>>>> integrated cache for efficient build times and introduces a flexible 'scenarios'
>>>>>> mechanism for subsystem-specific extensions.
>>>>>
>>>>> This sounds like a nice starting point to me as an additional way
>>>>> to run tests upstream.  I have one particular question as I see a
>>>>> pattern through the rest of the email, please see below.
>>>>>
>>>>> [...]
>>>>>
>>>>>> 4. **Collaborative Testing Environment:** The kernel community is already
>>>>>> engaged in numerous testing efforts, including various GitLab-CI pipelines such
>>>>>> as DRM-CI, which I maintain, along with other solutions like KernelCI and
>>>>>> BPF-CI. This proposal is designed to further stimulate contributions to the
>>>>>> evolving testing landscape. Our goal is to establish a comprehensive suite of
>>>>>> common tools and files.
>>>>>
>>>>> [...]
>>>>>
>>>>>> **Leveraging External Test Labs:**
>>>>>> We can extend our testing to external labs, similar to what DRM-CI currently
>>>>>> does. This includes:
>>>>>> - Lava labs
>>>>>> - Bare metal labs
>>>>>> - Using KernelCI-provided labs
>>>>>>
>>>>>> **Other integrations**
>>>>>> - Submit results to KCIDB
>>>>>
>>>>> [...]
>>>>>
>>>>>> **Join Our Slack Channel:**
>>>>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>>>>>> Feel free to join and contribute to the conversation. The KernelCI team has
>>>>>> weekly calls where we also discuss the GitLab-CI pipeline.
>>>>>>
>>>>>> **Acknowledgments:**
>>>>>> A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
>>>>>> and KernelCI community for their valuable feedback and support in this proposal.
>>>>>
>>>>> Where does this fit on the KernelCI roadmap?
>>>>>
>>>>> I see it mentioned a few times but it's not entirely clear
>>>>> whether this initiative is an independent one or in some way
>>>>> linked to KernelCI.  Say, are you planning to use the kci tool,
>>>>> new API, compiler toolchains, user-space and Docker images etc?
>>>>> Or, are KernelCI plans evolving to follow this move?
>>>>
>>>> I would say this is an important part of KernelCI the project, considering its
>>>> aim to improve testing and CI in the kernel. It's not a part of KernelCI the
>>>> service as it is right now, although I would say it would be good to have
>>>> ability to submit KernelCI jobs from GitLab CI and pull results in the same
>>>> pipeline, as we discussed earlier.
>>
>> Right, I think this needs a bit of disambiguation.  The legacy
>> KernelCI system from the Linaro days several years ago is really
>> a service on its own like the many other CIs out there.  However,
>> the new KernelCI API and related tooling (kci command line, new
>> web dashboard, modular runtime design etc.) is not that.  It's
>> about addressing all the community requirements and that includes
>> being able to run a same test manually in a shell, or in a VM, or
>> automatically from GitLab CI or using a main generic pipeline
>> hosted by KernelCI itself.  With this approach, there's no
>> distinction between "the project" and "the service", and as we
>> discussed before there shouldn't even be a distinction with
>> KCIDB.  Just KernelCI.
>>
>> However I don't really see this happening, unless I'm missing a
>> part of the story or some upcoming announcement with an updated
>> roadmap.  For some reason the old and established paradigm seems
>> unshakeable.  The new KernelCI implementation is starting to look
>> just like a refresh of the old one with newer components - which
>> is a huge missed opportunity to really change things IMHO.
> 
> Calling that a missed opportunity is a subjective perspective about
> the latest developments in KernelCI. The system implementation is
> one level less important than the actual kernel community engagement
> the project can generate. If one asks people around, the lack of
> community engagement with KernelCI is evident.

Well I would argue that community engagement and technical
development work side-by-side, not as a hierarchy.  You can't run
Android phones or data centers with community engagement, and you
can't write the code without the people.

I was enquiring about this in particluar because I'm preparing a
LF webinar, so I've started another thread to avoid spamming this
one as it's really a side topic:

 
https://lore.kernel.org/all/71f59a56-aef3-4bae-867b-769a0cdd1c1b@gtucker.io/T/#u

> However, after the recent leadership change in the project there is a
> growing effort to bring the kernel community closer to the KernelCI
> project with a renewed focus on high quality test results, clean regression
> reporting, among other things. Then, with an increased number of community
> members involved, we will have the necessary feedback (and funding!) to
> evolve the KernelCI infrastructure and technology to new levels.

In a nutshell, KernelCI started small and then joined the LF.
The scope changed to encompass the whole kernel community, and as
a result a number of things were done: community survey, lots of
conf talks and email discussions with kernel devs etc.  Then some
plan was put in place with the new API and web dashboard designs,
but other priorities slowed things down on this front which is
why it's still not quite there two years later.  That's also why
community engagement has been low.  But that's OK, plans are just
plans and things are catching up again now I think.

And once again, I think this GitLab CI move is great :)

Guillaume

