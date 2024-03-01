Return-Path: <linux-kselftest+bounces-5774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525B86EB85
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 22:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9776A1C21709
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42558ADE;
	Fri,  1 Mar 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="F+UgJ7+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A759166;
	Fri,  1 Mar 2024 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330198; cv=none; b=CfOQe5YFrsgiUQ3QxetkVCsD7nP+MTJiuGDioJYGeAD/Q+fC4HmboMBHk+Y/4qpjF/rOuS77EnHGNUhlafzQidY0ZDwu6GDyKWSGhTvrimNVfGiCj2Im5VHLMxkfiOoPANAe/5dS5IEEoxyYVJMsirbQXB7NEE3HIoSXh9xUFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330198; c=relaxed/simple;
	bh=E2YV3tNGVJSt5ox+0FBmlTMWY0RfCcLTCc12+DIDQEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+l8ANxm6yQ3gjDdT2tKtmhYfCiDSUZx01Jkj8a3uKAB9piipKrMpOq2BOvIliWS43po6/+h1HahTGwyJ1iadPCeyeMg2fkpBCPMYxgFX69fv9T5hB4wVo/ITLRupAcG2YWmUNAx6/Vmj40ge6RBdJOHB4WVXxMTN/ygUicp8tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=F+UgJ7+W; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6DA21BF204;
	Fri,  1 Mar 2024 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1709330193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex6e7ljG1u9CpeqxUac1ORmdsnFmutQlF+JwXX6GWe4=;
	b=F+UgJ7+Wlx7CID/E0C31iTFp3J7wvXkMR8t3SEApCU6UE+1DR/ebRqy5mmra9ttxxEtKTU
	01jx5p8xCvFmNeT1nbkUVnwo1pFNn/rQjxEGzctzP7MxSM1xMxmbo9PFJtNmUarKd3JxOp
	bx7n5eR7K1rds4JZGo06V8PTGlQ2Y/c6sWiduCOwVv4WFYTMzF4Wo4UNv0kzrKY0nFNhtx
	foNNQGp159yAGYFzGwTwKwe/KB2g5x6lzRSXe4fIqBfQAqDGEyZ6XGf65lLl9xr+hSYEFl
	S3pSXbz7ZKdtRxvmMCfJyKJXDBvbPwzfa6dhbssWPsvtjmySbaeBNZuGxW5mHg==
Message-ID: <3d7e66bc-967e-45ec-a9e9-12dafd3b3e68@gtucker.io>
Date: Fri, 1 Mar 2024 22:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-GB
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Nikolai Kondrashov <spbnick@gmail.com>,
 Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
 <a5726043-1906-44ba-a6ee-a725a2776269@gmail.com>
 <51fa8932e57010620e9a9e16a1979f4883e95a7d.camel@collabora.com>
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <51fa8932e57010620e9a9e16a1979f4883e95a7d.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io

On 29/02/2024 17:28, Nicolas Dufresne wrote:
> Hi,
> 
> Le jeudi 29 février 2024 à 16:16 +0200, Nikolai Kondrashov a écrit :
>> On 2/29/24 2:20 PM, Guillaume Tucker wrote:
>>> Hello,
>>>
>>> On 28/02/2024 23:55, Helen Koike wrote:
>>>> Dear Kernel Community,
>>>>
>>>> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
>>>> basic test pipeline triggered by code pushes to a GitLab-CI instance. This
>>>> initial version includes static checks (checkpatch and smatch for now) and build
>>>> tests across various architectures and configurations. It leverages an
>>>> integrated cache for efficient build times and introduces a flexible 'scenarios'
>>>> mechanism for subsystem-specific extensions.
>>>
>>> This sounds like a nice starting point to me as an additional way
>>> to run tests upstream.  I have one particular question as I see a
>>> pattern through the rest of the email, please see below.
>>>
>>> [...]
>>>
>>>> 4. **Collaborative Testing Environment:** The kernel community is already
>>>> engaged in numerous testing efforts, including various GitLab-CI pipelines such
>>>> as DRM-CI, which I maintain, along with other solutions like KernelCI and
>>>> BPF-CI. This proposal is designed to further stimulate contributions to the
>>>> evolving testing landscape. Our goal is to establish a comprehensive suite of
>>>> common tools and files.
>>>
>>> [...]
>>>
>>>> **Leveraging External Test Labs:**
>>>> We can extend our testing to external labs, similar to what DRM-CI currently
>>>> does. This includes:
>>>> - Lava labs
>>>> - Bare metal labs
>>>> - Using KernelCI-provided labs
>>>>
>>>> **Other integrations**
>>>> - Submit results to KCIDB
>>>
>>> [...]
>>>
>>>> **Join Our Slack Channel:**
>>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>>>> Feel free to join and contribute to the conversation. The KernelCI team has
>>>> weekly calls where we also discuss the GitLab-CI pipeline.
>>>>
>>>> **Acknowledgments:**
>>>> A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
>>>> and KernelCI community for their valuable feedback and support in this proposal.
>>>
>>> Where does this fit on the KernelCI roadmap?
>>>
>>> I see it mentioned a few times but it's not entirely clear
>>> whether this initiative is an independent one or in some way
>>> linked to KernelCI.  Say, are you planning to use the kci tool,
>>> new API, compiler toolchains, user-space and Docker images etc?
>>> Or, are KernelCI plans evolving to follow this move?
>>
>> I would say this is an important part of KernelCI the project, considering its 
>> aim to improve testing and CI in the kernel. It's not a part of KernelCI the 
>> service as it is right now, although I would say it would be good to have 
>> ability to submit KernelCI jobs from GitLab CI and pull results in the same 
>> pipeline, as we discussed earlier.

Right, I think this needs a bit of disambiguation.  The legacy
KernelCI system from the Linaro days several years ago is really
a service on its own like the many other CIs out there.  However,
the new KernelCI API and related tooling (kci command line, new
web dashboard, modular runtime design etc.) is not that.  It's
about addressing all the community requirements and that includes
being able to run a same test manually in a shell, or in a VM, or
automatically from GitLab CI or using a main generic pipeline
hosted by KernelCI itself.  With this approach, there's no
distinction between "the project" and "the service", and as we
discussed before there shouldn't even be a distinction with
KCIDB.  Just KernelCI.

However I don't really see this happening, unless I'm missing a
part of the story or some upcoming announcement with an updated
roadmap.  For some reason the old and established paradigm seems
unshakeable.  The new KernelCI implementation is starting to look
just like a refresh of the old one with newer components - which
is a huge missed opportunity to really change things IMHO.

This may sound like a bit of a tangent, facilitating GitLab CI
for the upstream kernel is of course significant progress in any
case - no question about that.  My comment is more about why it's
being driven hand-in-hand with KernelCI in what seems like a
diverging direction from KernelCI's announced plans.  Why push
for a GitLab-centered orchestration when there's a more universal
solution being proposed by the project?  I would find it easier
to understand - and I sense I'm not the only one here reading the
thread - if KernelCI wasn't mentioned that many times in the
cover letter and if the scripts didn't have KCI_* in so many
places, basically if this was clearly an independent initiative
such as KUnit, 0-day or regzbot.

> I'd like to add that both CI have a different purpose in the Linux project. This
> CI work is a pre-merge verification. Everyone needs to run checkpatch and
> smatch, this is automating it (and will catch those that forgot or ran it
> incorrectly). But it can go further by effectively testing specific patches on
> real hardware (with pretty narrow filters). It will help catch submission issues
> earlier, and reduce kernelCI regression rate. As a side effect, kernelCI infra
> will endup catching the "integration" issues, which are the issue as a result of
> simultenous changes in different trees. They are also often more complex and
> benefit from the bisection capabilities.
> 
> kernelCI tests are also a lot more intensive, they usually covers everything,
> but they bundle multiple changes per run. The pre-merge tests will be reduced to
> what seems meaningful for the changes. Its important to understand that pre-
> merge CI have a time cost, and we need to make sure CI time does not exceed the
> merge window period.

You're referring to the legacy KernelCI, to illustrate the point
I made earlier.  The plan with the new implementation was to be
able to do pre-merge testing as well as many other things,
basically to provide a platform able to cope with the diversity
of workflows across the kernel subsystems and the complexity of
the "system under test" itself.


Well, let's see how this goes and it does look quite promising.
Evolution is always a chaotic process, especially in a complex
project like this.  I'm not expecting to get all the answers to
the questions I have but it seemed important to raise this point
and seek a bit more clarity around KernelCI.

Guillaume


