Return-Path: <linux-kselftest+bounces-5629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7386C7F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16B21F24C85
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25527C091;
	Thu, 29 Feb 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HozX1O29"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D57B3E8;
	Thu, 29 Feb 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205740; cv=none; b=qTPj9KzqORphkJUmSwvDEK0/U7tQSPljCkT0PEM+HOLI1YOLfN4rZ75q5cNXt17TiBxo1VVnXnZcHJIfGsA3IL7ZtltJe/e86JF3widSkSqEFTzaraxYlNmac/JzpIGuZii0/K1RbFG6U41pkbD0MJxkikkYRECDDmEguREv43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205740; c=relaxed/simple;
	bh=ooRrQfVr9PreoY33xFWg6TmzCLeY2uu5mZACXstZjiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaLrvCNg8uIubLAFucNoaPDORVVBiS5nBN2TQ+gagltGZGm4J3amQJbloHCFvg30MXoVHcwKwR95ZYA0GDvwVkKWazyM5XdM/44aZBUTWeyIWrmtRO0iEgqnWHJC7DRapxWpKd+qO62LClEN3Hurd/5QWCwR2L7pcJzoGvRhxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HozX1O29; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512e4f4e463so644403e87.1;
        Thu, 29 Feb 2024 03:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205737; x=1709810537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCYVJOxva7cbL0S0SVuUSyy8FG+Nl+cI8gxD3kxwuN8=;
        b=HozX1O29BGbWLBBmVqudidUTmhK/CdLYUbsnrecdYrOABEj+mPLG/n+uwHxUF21ez0
         XirRlb/CH12sJ2MwpeFpLe1ZGcl6J+LWENBUuAcyoeuNMFS3rubKFv88IwAdLG8Pg3fQ
         18nbGSm3w2gj8TVuKQlqnS1REwN9+PYKmYFxSWBk6va9oE5r39d749TlyX5kVfdWPxlx
         DkMhqn8MlIsNLOXnT7CGvj3WfpEyey0hHJmUWAiZGq6JZBszRRpAPiTsUjpKbQQQUYHD
         u5WPY1KJaOIBjRddkfHIuNTXrK1gk9zoQ5iMCCFFwGRLnxi2eSofsQvZAY1ezZounQa8
         Qi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205737; x=1709810537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCYVJOxva7cbL0S0SVuUSyy8FG+Nl+cI8gxD3kxwuN8=;
        b=kUHs8NzNQEI4iixxgwS1UR3sWZzdRIwGdcdUAYdOhj/ky3yoEFQtdiuVtExxznSXqL
         3mrxwtWM/z2ObTWGBpsKcB4FpEyt252CrVMGJXh1EKd0sBwJ4uFi/bQ2k1let97rxEy0
         KuzMZgVtTqHXIxmSZDgkmXvkBeGH6btR4MYGPkC0udcYGa4O3oiwHLCeyqRlBAF1lyD8
         J4LGyYta9bi+vwZSvxfy1WseArNiNPLPLb9r2TIEVWNWtsG13fRjodfSUnA4Bs+z7dn0
         onPbH8DAljvKH2ATWr1HBmKNxF5x0aOynQQBv5rt0c6p/644vf6vhJUL5RNJCmtjU4A3
         w7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW1lv7EsSpsBVrvTt14Nkva+4Z6MxPor4uSYdYT7zXUGrUqYPSzeA8ldWKHZY33Xw7S+MlWJjxsTlj0xIupzrVZAwrhyjfoYPh1AfSzOj/qYoCWR64bJsUSsmZeNtdt2ViBE9hk97de+WUMl1qA3LKMNxwsyE0wMEfGirGEF58Mf296lncowlfP
X-Gm-Message-State: AOJu0YwrAWWFlXkZD8Im6LCZHdhjWBn3Q4TzIAPg5tE/Agc2fVF40nuZ
	jgZLJDpTDltHKK7KkpBYtXv4bYbSl3okFnykPkVljqAx0GLB2Vm3
X-Google-Smtp-Source: AGHT+IEcyGxv3boJhUbIfcxE4GAXJlXVJLOoxb0MGuYy2YDFLHQehEYV64lneBXAaSEL4H2H7EwLgQ==
X-Received: by 2002:ac2:544f:0:b0:512:b3ef:350f with SMTP id d15-20020ac2544f000000b00512b3ef350fmr1193587lfn.49.1709205736954;
        Thu, 29 Feb 2024 03:22:16 -0800 (PST)
Received: from [10.32.57.243] (yritysnetti-5422ea-26.businessinternet.fi. [84.34.234.26])
        by smtp.gmail.com with ESMTPSA id d5-20020a056512368500b005128d0e2a07sm214031lfs.308.2024.02.29.03.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 03:22:16 -0800 (PST)
Message-ID: <2c9e322f-edc9-457b-8c0a-0628c9a5d6f9@gmail.com>
Date: Thu, 29 Feb 2024 13:22:15 +0200
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
 <655f89fa-6ccb-4b54-adcd-69024b4a1e28@gmail.com>
 <20240229111919.GF30889@pendragon.ideasonboard.com>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20240229111919.GF30889@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 1:19 PM, Laurent Pinchart wrote:
> On Thu, Feb 29, 2024 at 01:10:16PM +0200, Nikolai Kondrashov wrote:
>> On 2/29/24 11:34 AM, Laurent Pinchart wrote:
>>> On Thu, Feb 29, 2024 at 11:26:51AM +0200, Nikolai Kondrashov wrote:
>>>> On 2/29/24 01:07, Laurent Pinchart wrote:
>>>>> On Wed, Feb 28, 2024 at 07:55:24PM -0300, Helen Koike wrote:
>>>>>> **Join Our Slack Channel:**
>>>>>> We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
>>>>>> Feel free to join and contribute to the conversation. The KernelCI team has
>>>>>> weekly calls where we also discuss the GitLab-CI pipeline.
>>>>>
>>>>> Could we communicate using free software please ? Furthermore, it's not
>>>>> possible to create an account on that slack instance unless you have an
>>>>> e-mail address affiliated with a small number of companies
>>>>> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
>>>>> for me.
>>>>
>>>> Yes, it's not ideal that we use closed-source software for communication, but
>>>> FWIW I'd be happy to invite you there. Perhaps if you try logging in e.g. with
>>>> a Google account, I'd be able to see and approve your attempt too.
>>>
>>> I don't use Google accounts to authenticate to third-party services,
>>> sorry. And in any case, that won't make slack free software.
>>
>> Of course. You're also welcome to join the #kernelci channel on libera.chat.
> 
> Isn't that a bit pointless if it's no the main IM channel ?

Yes, it's not ideal, but if more people come there, more discussions will 
happen there too.

Nick



