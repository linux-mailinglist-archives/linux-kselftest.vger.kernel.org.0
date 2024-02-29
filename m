Return-Path: <linux-kselftest+bounces-5627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02B86C7BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C731F250C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486E7AE61;
	Thu, 29 Feb 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNX8kW0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DF7AE4E;
	Thu, 29 Feb 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205022; cv=none; b=IkoRkPDZgefPOLh9rMBWTLTBG2fY5q7sKovTaQ8i8HGGIF5ZmXfoYkSjbR6FIz6SkduYF1WSQGGJsUbWl+Wd4W1hdsD1r/dtpp9zeqhvhn5UHWT0n73ti0mlJKTPFB/RQ9f6l5z65f+4oa2Lklu7v/mOX911awq+tS9MHld41ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205022; c=relaxed/simple;
	bh=pN/tSJjuwssSSwy9xAYBREIgl/Vm4/Oz1DWXTc9me3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSL6AjN8V5PCedPq9KoJXIVj5VP9C00s7Ys+qFHzGrwJEISwr4XKmOn2AgCYFOk1LpRDkf+FWWrjvAltwx/ktq2icMOplX2A7LIo3IT31MAlI5sTFe2c+LXFDS7oSGDyWnGa+30vgQDtFyU9nuUTRVbAhg7ksAyrjU9VXfPxGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNX8kW0h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512e4f4e463so632814e87.1;
        Thu, 29 Feb 2024 03:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205019; x=1709809819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIBPoOk+1kYrUDtUJWUP6LK4VMtPXxz+WnWICgzvGsc=;
        b=kNX8kW0hIh69svYkIMjXK2Zfna7FvnvX/9vXPhnzjAPMhCW2451Ka+ZlrISnv6AOmI
         J3Z0zQ1GfArUb8HSiycK48dKj1G8UCC8X+MJ2naxSXM9k/RnsAJhi6gNFi/QvGtHnYcK
         13rK8NcxVzuUP05KEiajgUa8pj6GsmJMp4Uenk6IIhoB0DcgET3BiS3gjBzpFNm+pKxB
         /zQ8WB3YYjVWgrI0cXOfn8v6oA68ULOQpZ54HcY7FfDjR0tUNSqB8fs6CPTZitqXLxc1
         fCQ9orQWIQ6wE7n1f8ork3416G2GPD5wof4eeF1DnAZF5yd5Bse2vcZOJ0skABDdmL2Z
         BqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205019; x=1709809819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIBPoOk+1kYrUDtUJWUP6LK4VMtPXxz+WnWICgzvGsc=;
        b=WsEQeJBPrpRZ6h37mfNqp7uDpTawrZEr5PmfmklbvFFGpQCPzk88GzHsQdM4+5s3xn
         zLvlGCegQKR0pm6o0y4g4yTUI/xVTsaSP0dP29Ik3mjuofB6yFuE/P6IoElQ+zecfpCn
         Ldxj+xoUKYV3TL4MEe48QmmeIx6hWPbg1sGa1LbjMcz6XHntSHDoHRTKFleFF1RPwBDz
         tZCh2kYZCgrhFpk2WlUFnGCZ6J0X+/oS49avv/+3e8ublzH53G42bJUcRsupjafqkXqJ
         cRoGoetPje5qLxaakpQgjXU8Fh8wencRJKT0VcfcEi37yoOFHRPxteWOHIG8LCUfTG05
         JeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJMXoUlde2Zpqx2HxFqZjrEz/lMtR/bzpOo3Qnzpqm2jDavJwUsRneQqTL1Ywkpaxnq2AZCP62eS0AScSNhu3vaYMMwINYKknO1hiZ1LDL1TxAOYklqDEKQccqGIjDcVMFkpa/j/h+RQ9xl6kSnc6Vv6xl9D/OMCPEFYAwCXHrKCajpssPzWfj
X-Gm-Message-State: AOJu0YzEVF8ZJvGLM3uWrj4i3td3p9BXB2BSCxdh1fP7WAdaXRuQCqRm
	uF57lEBYENew6KpbFqI8AmtEvYkz09ltVEEDxS/9PjQRPedeWJtY
X-Google-Smtp-Source: AGHT+IE1rn1IKpuRyvo4Opm0Zt3B82O24f9hp/M7IbQ1wdOiuJCWMOZg3kcfpBECPXoLQ+BpqOoHNg==
X-Received: by 2002:ac2:547a:0:b0:513:22d2:ede8 with SMTP id e26-20020ac2547a000000b0051322d2ede8mr1329851lfn.39.1709205018795;
        Thu, 29 Feb 2024 03:10:18 -0800 (PST)
Received: from [10.32.57.243] (yritysnetti-5422ea-26.businessinternet.fi. [84.34.234.26])
        by smtp.gmail.com with ESMTPSA id m17-20020ac24ad1000000b005128d91b9f2sm210079lfp.161.2024.02.29.03.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 03:10:18 -0800 (PST)
Message-ID: <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
Date: Thu, 29 Feb 2024 13:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
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
 <20240228230725.GF1659@pendragon.ideasonboard.com>
 <0a5bf7d1-0a7e-4071-877a-a3d312d80084@gmail.com>
 <20240229093402.GA30889@pendragon.ideasonboard.com>
Content-Language: en-US
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20240229093402.GA30889@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 11:34 AM, Laurent Pinchart wrote:
> On Thu, Feb 29, 2024 at 11:26:51AM +0200, Nikolai Kondrashov wrote:
>> On 2/29/24 01:07, Laurent Pinchart wrote:
>>> On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
>>>> **Join Our Slack Channel:**
>>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>>>> Feel free to join and contribute to the conversation. The KernelCI team has
>>>> weekly calls where we also discuss the GitLab-CI pipeline.
>>>
>>> Could we communicate using free software please ? Furthermore, it's not
>>> possible to create an account on that slack instance unless you have an
>>> e-mail address affiliated with a small number of companies
>>> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
>>> for me.
>>
>> Yes, it's not ideal that we use closed-source software for communication, but
>> FWIW I'd be happy to invite you there. Perhaps if you try logging in e.g. with
>> a Google account, I'd be able to see and approve your attempt too.
> 
> I don't use Google accounts to authenticate to third-party services,
> sorry. And in any case, that won't make slack free software.

Of course. You're also welcome to join the #kernelci channel on libera.chat.

It's much quieter there, though.

Nick

