Return-Path: <linux-kselftest+bounces-10304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE68C79CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0520C1F22F78
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA714EC42;
	Thu, 16 May 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KygvtkIO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21614D435
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874612; cv=none; b=GQEjqpfWNcTIxU01XQTqBVfz6XvUH0hWNw6DW5h3tGlsOKMTNuacAqHUDvHqxO5M19qpadtcMFtZWYcQQZfxJVP8dqzoetd327fNYBmSRNGkm0jnm6kmi3bvxL7cTdYcEwwVZPY9BaIJRR2FU5wtH53sZp37BpNQO03RpcHdQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874612; c=relaxed/simple;
	bh=C2S+Wcg1T1bDn7HdR6vfDNd7hPYvGbP2fXOfs5dd6ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIL3aNTA5oS4Oq8s3sTjYCEfK5z4+ykyUTcBKicNZtqj3MVw1H2j9Hk/UpOHg04fr+V1uJANW77ZA23fOlwxdsLQMTvGV7tWy2svqIZiKCyuanV9jE/brRJ/JIuTeMa9ZgriYUjxMtL1nl6P6Oc3XiOvq6W4vob5DU+42GsdTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KygvtkIO; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1fb2a81fdso5154439f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715874609; x=1716479409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+iK/FVhZ4HUNEOzdTMBxIyNYiEbX2AZzsfqmN9W/BY=;
        b=KygvtkIOUT6biaordQ3w+WUwvxASyMz+pLz1DE35nNfEcMRVZuxGNLdnzw+5wWRTwm
         yyHTTtqgNTEzM6KudcdfQC2/D8IuNtsWcLtH5kaymoUzF2tLZUA8cuP4HP+1v/IULPzU
         083xnHcDCF3WUP/jSfZqSpJT+xHb8fEuCsJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874609; x=1716479409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+iK/FVhZ4HUNEOzdTMBxIyNYiEbX2AZzsfqmN9W/BY=;
        b=SryTKTNVqphp0ZLcaBmlr/DJyCDa4pH16do5DkVD9l6/ZriRSdtg+W1I/bKWilhAB9
         Izw3jswi4jehXVJQD+4D8IfOvA5diayXvUml7f+yPqRMvpYv7TOq/7kU5mtELjzautAZ
         rm/bqygiK++MYjtWWFLWWyNxPXVrd5IMyd3czGxXrOqi/JUz7ih6ztzLTWvacklJ2uMf
         qkeZhDspLRFUv5nSVnw/5wyHIiGxLllJjAnWhnGxBu5XdeJhu3LG/KtaGZMkae2Xri4H
         YZpumLrE3XQabRwtGXVepdjNb0ZIVkm3H2EyGLEN/ytGE2Ar43Ex76MyfFQ8QHkMFtsq
         BLaw==
X-Forwarded-Encrypted: i=1; AJvYcCXdgHEttXGzk3/F6AUf8BjsaX7/g4JsPKv7omJM3P+c1gkp5mjPbgz9c7he2HJ0ONld/xoAYMMDWCX/nQGNgC71KcH1MGAKTagvnkfw3KQP
X-Gm-Message-State: AOJu0Yw0SlIZjG67Aq2qOff5Vfumm2LZ4x/ihTJ8lQFNLUmwD1VXMYT7
	RT1m90muwK6seBVc1CNFc3ZGQ07ifUz46fqilZhpUYz+HHS3pXxWIkLU7XgOa8M=
X-Google-Smtp-Source: AGHT+IFJbIeUVLI7ISOMfUKtjb3QlrF6+MESxVkubwkrIwTVWoi4y8+3A4qy7lb3Ntw2ajnuWMf8Hw==
X-Received: by 2002:a05:6602:59e:b0:7d9:eeb8:ddeb with SMTP id ca18e2360f4ac-7e1b5202ae8mr1886131739f.2.1715874608958;
        Thu, 16 May 2024 08:50:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de185sm4147976173.150.2024.05.16.08.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:50:08 -0700 (PDT)
Message-ID: <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
Date: Thu, 16 May 2024 09:50:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
To: Tejun Heo <tj@kernel.org>, Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 11:02, Tejun Heo wrote:
> On Fri, May 10, 2024 at 12:06:25AM +0000, Edward Liaw wrote:
>> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
>> redefinition warnings.
>>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
> 
> Applied to cgroup/for-6.10.
> 
> Thanks.
> 

Hi Tejun,

Please don't include this in your PR to Linus. This patch series needs
to go together as it is causing several build warns and some errors.

thanks,
-- Shuah

