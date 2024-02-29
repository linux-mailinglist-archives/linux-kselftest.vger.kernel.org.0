Return-Path: <linux-kselftest+bounces-5618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD186C511
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68341B2404C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EAE5CDF6;
	Thu, 29 Feb 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzS66Bce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2F5CDF2;
	Thu, 29 Feb 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198817; cv=none; b=Ykl2QKkBjIRr6KVU1xz+cqkHVR/TMTvOuYAdEJUOh5dtx59J1dWaiX9Gtvgj3neiy6qfALdt4ro1wCpsFIFRhwNEfqYdy5CydV3fylFmlKPq32nt2tlIdJ9I6wwR5Md0xkOAyTs9Gzn3tJHYN0l+v5BrTyg6B+KgCTb9ng0/ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198817; c=relaxed/simple;
	bh=H3DVOzLmQ6k1aiZNO64pehrcmvGMoPGpzkMsjPLddA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2souOSP5Cu47RWKX4XLthk1JYRLt3t3mrpOG+WfEd/5Olt4R9bh4W2eyP6OweQTY7GkUw2OiafAoRObRqrNm7kR8GdZDl3c0jQtI3SOWH/o8g6sDZmwEFADY4thRq4Tt/43j429l8n+g+YMzu61Jqs9iUMoTqXS3oDpOJgQY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzS66Bce; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d2533089f6so7735861fa.1;
        Thu, 29 Feb 2024 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709198813; x=1709803613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUGoQKrYI+CUGIzYiMWNWVHuIqGWUhSm1DPKxOOJHWY=;
        b=hzS66Bcej3pnr7hurc58cBly9l2tkNw3YfXX+a9j3mP6nSJUkYJc7lWJHBlEUb29L/
         YD85meJiikcsC5T5zD413B3mZ9AZoz70PDB73CkumUOAqa6dkHNkizlB73lWabV9kiAa
         AN7hf+QKrByOlI5jS0PA1oezdp1c3+JgqjFptYtW+jPYRomGl2uJ5mc8TDd6FScGQIaU
         zJwTQ4nSDx570AiixFK2WKdy2g6tee0IqeGRr7KjFUEzNJ+RAdtNY7+ZthCb+nPSvtTV
         7B03inZtfgIJjOFAg2PBlZtEA6kmFY8KBmFOlFnXjQ5qp+m64wEBojvJuVCW6U78hD4P
         dy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198813; x=1709803613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUGoQKrYI+CUGIzYiMWNWVHuIqGWUhSm1DPKxOOJHWY=;
        b=Y1qaoexznz2GcMX6rXKmQdFTdpheo7cuO6Q1lY2tWajjUxyNGq/qWiL6EtmW+K8UuJ
         kgUkbnBInOk4gfpB2GVA7uQjyq45i1wsG/8A/P21qN1sUxEXy+SYREOaPryHG2KXMLdW
         /S4ovxZ4LDtcFsA5dPRphSuzczMU2OKRvSBn05j8mp9rxBwzEccHsaPStaRRU9Zskmet
         WwgzfEHbTvaP8H6gwKSHgx0xFAMxY79jWgW/StOLE3RD+0s8hneiVRZjkkNY8HxtxM9L
         f+OotPbgIAl4QBdM024sd0uMEhEhFan0WWeesM3o0xzP7+1u18sko6cpaHg3xPP1QCSh
         7SKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZGoZRfz+coJkoVGGzyhzItGHm32QMu5AzxBnXjRkd8N3PRkRffojsbYA648eIsRl3H/STQnJ1arNlSwjeEg+xObvk38ZFHKoShxlaxBNaMwFjLUM34Lb+sp436henOnui+oga6HQfP23HndlMN8vVx3YuAZJaipDjT/dZc7AzerdJerPl8nGi
X-Gm-Message-State: AOJu0YyHlJFCr5ZqWcb699gs5c9AxYaYdu30iLFZPq285vs54U/xeXO/
	Lq+xc3u9BZQ65XKGdECK9qaW++U12FyxlgDb2Ux5B5d8FMW8HO2H
X-Google-Smtp-Source: AGHT+IEQQGvEUUUJJE0Q32Q1dWpicjPYOMb4ktp8tTjoWEWQsJczQ+GYRu123pV36LqzQ6iLRlTmxA==
X-Received: by 2002:a2e:9496:0:b0:2d2:e704:77a8 with SMTP id c22-20020a2e9496000000b002d2e70477a8mr987605ljh.3.1709198813316;
        Thu, 29 Feb 2024 01:26:53 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e9902000000b002d0f905ddf9sm151234lji.18.2024.02.29.01.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:26:53 -0800 (PST)
Message-ID: <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
Date: Thu, 29 Feb 2024 11:26:51 +0200
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
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Helen Koike <helen.koike@collabora.com>
Cc: linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20240228230725.GF1659@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 01:07, Laurent Pinchart wrote:
> On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
>> **Join Our Slack Channel:**
>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>> Feel free to join and contribute to the conversation. The KernelCI team has
>> weekly calls where we also discuss the GitLab-CI pipeline.
> 
> Could we communicate using free software please ? Furthermore, it's not
> possible to create an account on that slack instance unless you have an
> e-mail address affiliated with a small number of companies
> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> for me.

Yes, it's not ideal that we use closed-source software for communication, but 
FWIW I'd be happy to invite you there. Perhaps if you try logging in e.g. with 
a Google account, I'd be able to see and approve your attempt too.

Otherwise, our video meetings are generally open to everyone and run in Jitsi.

Nick

