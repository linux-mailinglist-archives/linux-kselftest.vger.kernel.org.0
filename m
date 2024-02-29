Return-Path: <linux-kselftest+bounces-5634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2686C917
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F10428C5E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D67D096;
	Thu, 29 Feb 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b="e6dw9jxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998B7D087;
	Thu, 29 Feb 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209252; cv=none; b=o/G6BcS0TFL8xTYcKP/dnqFF2XXSIGDG5qZhxtT/HkPw5Z6ORllTcq4oh9vkBB+c3LOOu2qALEQA4NLAh+g6fifQOc+4ELjWDgDWLoCTrvnm/9V2NBKlaXC1OZnvtpqV8xd869xbrX8vZVjwN4aTkirrRsoD/pkYzzqj0P3yGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209252; c=relaxed/simple;
	bh=RlnmNwfAubItairh/Sb6i8cl7duHp+kM134vUP/udRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N2tvGII0IUirPycAQmOGGV1WXLgzpH+7tccSOGaP9f6mPasa0MyldNwWQHQmyy/qcmbS6wWthrVQeKZ44qxRf2pPg7zTPc9MeudF7+2yac92uVBHP9A0PDIZ+nVIrk3SUL/T9FUJT3+LsvJ2PLbl3g644hzGX3HMqtHN3dus2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io; spf=pass smtp.mailfrom=gtucker.io; dkim=pass (2048-bit key) header.d=gtucker.io header.i=@gtucker.io header.b=e6dw9jxm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtucker.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtucker.io
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF335C000C;
	Thu, 29 Feb 2024 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
	t=1709209244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6cMCmcnKMLLaSkCY/Q3FEaIM22/n5JPr+A3k3857Ak=;
	b=e6dw9jxmOjxEWGL4CwLLpcu3etN9VgBLkvgGBS77nGo2i9JzqcGhXcMi/ZSamcRjBIgJcC
	8rMyWgs5i1dkhCkBSSstzl76l5Url9CebPIMUY3HOFlqtJFVe78xbWwcys1jzPAL5xiJI9
	c4cNPvbfFqC7+JJ4lcc/JQ3Co5dc62CJKdsQ2LnpqvTFvilVwOA1EIRjdCIOF/FPg7nyEU
	AkY74Rh4APJZ4cJBP18refisPFoFZm8tJjfp0LZBDIFjJFy5+xPhV6Jpw+8fxNxBhQkuJN
	dtF8DxpoYoTODY6x5CIgUtN3qYPB1OTIcr5EcDRC1GKU/nraf/VxFHNRA/XmMA==
Message-ID: <d99d026e-ed32-4432-bab3-db75296e67d8@gtucker.io>
Date: Thu, 29 Feb 2024 13:20:41 +0100
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
To: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
From: Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <20240228225527.1052240-1-helen.koike@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io

Hello,

On 28/02/2024 23:55, Helen Koike wrote:
> Dear Kernel Community,
> 
> This patch introduces a `.gitlab-ci` file along with a `ci/` folder, defining a
> basic test pipeline triggered by code pushes to a GitLab-CI instance. This
> initial version includes static checks (checkpatch and smatch for now) and build
> tests across various architectures and configurations. It leverages an
> integrated cache for efficient build times and introduces a flexible 'scenarios'
> mechanism for subsystem-specific extensions.

This sounds like a nice starting point to me as an additional way
to run tests upstream.  I have one particular question as I see a
pattern through the rest of the email, please see below.

[...]

> 4. **Collaborative Testing Environment:** The kernel community is already
> engaged in numerous testing efforts, including various GitLab-CI pipelines such
> as DRM-CI, which I maintain, along with other solutions like KernelCI and
> BPF-CI. This proposal is designed to further stimulate contributions to the
> evolving testing landscape. Our goal is to establish a comprehensive suite of
> common tools and files.

[...]

> **Leveraging External Test Labs:**
> We can extend our testing to external labs, similar to what DRM-CI currently
> does. This includes:
> - Lava labs
> - Bare metal labs
> - Using KernelCI-provided labs
> 
> **Other integrations**
> - Submit results to KCIDB

[...]

> **Join Our Slack Channel:**
> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> Feel free to join and contribute to the conversation. The KernelCI team has
> weekly calls where we also discuss the GitLab-CI pipeline.
> 
> **Acknowledgments:**
> A special thanks to Nikolai Kondrashov, Tales da Aparecida - both from Red Hat -
> and KernelCI community for their valuable feedback and support in this proposal.

Where does this fit on the KernelCI roadmap?

I see it mentioned a few times but it's not entirely clear
whether this initiative is an independent one or in some way
linked to KernelCI.  Say, are you planning to use the kci tool,
new API, compiler toolchains, user-space and Docker images etc?
Or, are KernelCI plans evolving to follow this move?

Thanks,
Guillaume


