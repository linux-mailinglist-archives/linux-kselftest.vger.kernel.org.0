Return-Path: <linux-kselftest+bounces-5643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAE86CB0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C53128417D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1B12C53A;
	Thu, 29 Feb 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgwNgBlL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD312AACE;
	Thu, 29 Feb 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215969; cv=none; b=cVYHi3SMWyqnbzO03oWwOOa76GGOrT9DsvmvAjGpEoFMXeJeXmiooR5zA7NAkZcQbwqrWvKKmww3jBOA+UMmoS5NkVsaFdwoxqO+ZxTF0ZDZfQEWdsr6dSXcPre2WVl5L9SgY4wlXn4K2PUzc7gPO0aiDwesMbNl9kscMcuy5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215969; c=relaxed/simple;
	bh=01GBL4pM/RBuNtNrLzRrSJYob8hE0WMJGlmHyUb0aZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+XL0NR0Pt2b/Z8xVFJBKts6gBt8mxFHoPCa63fYJXQcyoIXjHU59krZX54VNQuv9HBTpsNt28/0TQgt4xsJaPzl8HpoKEvL3mQ/pIxOnelCuUtj99wFS5a2vXhGQ83bXHE0/hU6QSH0ZqpkV/LfVBdTgBx9eZ2q5cw1Ioer0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgwNgBlL; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0deaf21efso503416eaf.0;
        Thu, 29 Feb 2024 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709215967; x=1709820767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6cP9W2AgQHJN8YU3o1XUoIxNAqqR6eg938KJPNmEGw=;
        b=KgwNgBlLjopGold37CewkR6it1uExRFi4kUfUUucePSmFELpkfENqglJC/1zkUJydU
         t4w/S+8PX/06XyTBe9/3idVwvZc+BNud921JqNO3CFwYOh7G0faglj/lQ711pmB3E/+G
         AdzDv9ONRQEeJfrkmzh3sodiIOWxNzCsTmq/LJBDmfDJmrTj20v5Qr7gNJLVV9QZqXt0
         epXntZ0DWve1DLlDh1zchDqv8fvOSE/Sd813Wmvf9Xx3IggnS4o+t9+nFpdSzrpLBSPB
         UnhogjSX2EYO2BnIQvJAxYuhsQ/0lCplkRnmuzmiZqMSS+OSdD/YIRxosDl9MQhkVQIP
         htWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215967; x=1709820767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6cP9W2AgQHJN8YU3o1XUoIxNAqqR6eg938KJPNmEGw=;
        b=Yb1AZjtwdLDqkI/ZpmpmOg4xWOIAzFrsLPq6OY4IOXc+491l0FMCnIUbdUagHpIb0C
         g3ZnwNTdl03EPAl7Ttg+9YekM/nJUplZ6KsLuH234O6M1HXxHoXzPT4M/KXXC2dOrpFj
         xuWcUQd+FOt3twq8o6U+KvKB7mKt1LtPSuwnIA9t5B+KkMf/anAF9Kkk7Mq4Dt5SQXEc
         77yeCcJmwx5gP0TuF8qmc6L9h6tU+ndENns4XX+55WS59aR29m1WhnxqcTF+H6N0aJYX
         TwMICaLHWtBjq4Lr1MVk0Mz4Bo++lSzVTQpYHjXcRsD6PBe43s4X6ScVdykFvRxTD2iU
         1tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQElKVS+ZytkrQW040uxSqVVFpxiZJgsJ5Uavz1/XGeM3IqBkgNAtQnZzT87MeOXBC7vRy8eGmeovZVLYe2xqNdda/g/TQ5rb0WI7n4qcOn7Dd5BiMMA5uI1cgY40OTJNv6fjTBKFKYmOrsblRCjNvseL6HXYpewl0I1hzwdLoaZ6XpFp7Hakg
X-Gm-Message-State: AOJu0YyJAOq7DfPGrMjBIgkYVpwE027E75RTRKOcqS9LO8ZHJw5LsFOv
	jolFKWi/YWMZ7kuJnQEYEaDIkmN+Y20AcGU3hGEYdPGnMdPWEts6
X-Google-Smtp-Source: AGHT+IGoMVeonTVGpUMbSC6NyXoI8L+u+UnR4N1COBsmWbb1vlDZFi37tyMwzHjqwQeUiotKpDL52A==
X-Received: by 2002:a05:6358:428e:b0:17b:9e19:4fb9 with SMTP id s14-20020a056358428e00b0017b9e194fb9mr3273356rwc.22.1709215966734;
        Thu, 29 Feb 2024 06:12:46 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a13f400b00788033be0f6sm136142qkl.58.2024.02.29.06.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 06:12:46 -0800 (PST)
Message-ID: <f9a3d871-dd51-453b-b510-d076ecf0fabd@gmail.com>
Date: Thu, 29 Feb 2024 16:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Guillaume Tucker <gtucker@gtucker.io>
Cc: Mark Brown <broonie@kernel.org>, Helen Koike <helen.koike@collabora.com>,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
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
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
 <20240229111919.GF30889@pendragon.ideasonboard.com>
 <a4fc23e1-5689-4f86-beb7-5b63a0d13359@sirena.org.uk>
 <b3fb89aa-56b4-4b3c-88f6-c6320bf5c489@gtucker.io>
 <20240229122040.GG30889@pendragon.ideasonboard.com>
 <20240229122503.GH30889@pendragon.ideasonboard.com>
Content-Language: en-US
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20240229122503.GH30889@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 2:25 PM, Laurent Pinchart wrote:
> On Thu, Feb 29, 2024 at 02:20:41PM +0200, Laurent Pinchart wrote:
>> On Thu, Feb 29, 2024 at 12:53:38PM +0100, Guillaume Tucker wrote:
>>> On 29/02/2024 12:41, Mark Brown wrote:
>>>> On Thu, Feb 29, 2024 at 01:19:19PM +0200, Laurent Pinchart wrote:
>>>>> On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
>>>>
>>>>>> Of course. You're also welcome to join the #kernelci channel on libera.chat.
>>>>
>>>>> Isn't that a bit pointless if it's no the main IM channel ?
>>>>
>>>> It *was* the original channel and still gets some usage (mostly started
>>>> by me admittedly since I've never joined slack for a bunch of reasons
>>>> that make it hassle), IIRC the Slack was started because there were some
>>>> interns who had trouble figuring out IRC and intermittent connectivity
>>>> but people seem to have migrated.
>>>
>>> In fact it was initially created for the members of the Linux
>>> Foundation project only, which is why registration is moderated
>>> for emails that don't have a domain linked to a member (BTW not
>>> any Google account will just work e.g. @gmail.com is moderated,
>>> only @google.com for Google employees isn't).
>>>
>>> And yes IRC is the "least common denominator" chat platform.
>>> Maybe having a bridge between the main Slack channel and IRC
>>> would help.
>>
>> If the gitlab CI pipeline proposal wants to be considered for inclusion
>> in the kernel, I think it needs to switch to a free software solution
>> for its *main* communication channels.
> 
> And to clarify, I didn't meant the kernel CI project, but only the
> gitlab CI pipeline for the Linux kernel project. I don't know how
> tightly integrated the two projects are though.

They're not tightly integrated so far. However, we're exploring the idea of 
letting GitLab CI submit jobs to KernelCI and get results as a part of the 
pipeline.

Helen already joined the #kernelci channel, and we will maintain a presence 
there for the GitLab CI project.

Nick

