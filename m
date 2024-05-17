Return-Path: <linux-kselftest+bounces-10326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A355B8C8043
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 05:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6380328278D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD5B672;
	Fri, 17 May 2024 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KkFX2Qdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3C10A1B
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917629; cv=none; b=VP325galOkPDL7tnSCo1d3LF4eUXfR22kgfE+69QdiERHAVrv8akRUI8XsayVcdJNtM98RJ+5YZzADVBCD9FbOwtfeWT6jhYNhKNCYmwBruVaL3V8smsYj6YMv57OndlSOu5OQykmQwV2l1vHiFnlT1Q2f4iaVVRljkgmiuc5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917629; c=relaxed/simple;
	bh=60WJPyunhwRDxdqK0jmaca+G8J/J7dfoT/EsRzkUIOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFbN5FwGnV+CYbxh6FaqkrgffLtPth9+gE4YEeHPxjWDLSPZnT9vid7i/4aKhPWAmeWGEcJU+puLPuzJr+4zwWbR2V/PQM8PuWaz5+TJG848SE+JA++Hj1jiYtmxTkcgJIrZ4ltVDJHbivAx/Pn6IghgdtktZxj8CNeDhBy+VKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KkFX2Qdv; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d9ef422859so801439f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715917627; x=1716522427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDlOiioY4qBdeDaBJ3EMBjG9W4k3e+q2KQuwlwFm/Wg=;
        b=KkFX2Qdvuhzl5EaGH5xkrhb0yT1vguDmkATYGJXXzKL+60FaUrp0rGhbJAIzha2c8Y
         +HEYSfsGATA7i7Rcq8GakJDptzuDZE7S2ciBMIyojTlAnot1ibQnXvuSgmCpVNmzm6Pv
         oG5WBKMzyD2u4NSVuQlS6NsJTg1ucs84pQE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715917627; x=1716522427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDlOiioY4qBdeDaBJ3EMBjG9W4k3e+q2KQuwlwFm/Wg=;
        b=vi/S3UDzGglzLIhD31PtXXHjnSZAn4FbtukSfS4tlhyTb9U3mPTjV5qORSFsi9RAC6
         sG4gZURvmEdme3xhcdObdLws+sVcVN3K+r7HO9wMm6bj0XGgK+bMTEVJe7eTTfhUWIcJ
         VEdLY9w6P8+xA4O0dKwmNJdaduQa6sQHZEFyazgy3UM3hSyL1mYMZBAjniWUhn3L1OsL
         8rubLoQc20BD/uZoS5iHXDx1Tf0psM6ZqlSBtKR8ca/13zT4XAjAFW+Nu6+ooNPNO/KL
         HAtjNLFA9ww5H9ATorFTrK0/uEJUq79SRPBWTviR/TK/zNA9tKt3lKHaIvMKB3Ge1HVN
         SqVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9SX02iUof7JuD5pcZnO4Mzk3CxQzToYRv35DW3CIYHqAk3o5zqH7HGDCnwLoE/tE5gzkJL/TUGjpGRPsjwKFIio5GnwIPr/y5FPpvzdc3
X-Gm-Message-State: AOJu0YzZ1R2o2osfO5BFuHantm+wBJMQ7KJbND2aVVM4MqTmWqSFHU1T
	w5fdsXLfxExJb2Q1tCv+463hQwv0/7Va2/JvoUN+TYriiaGhoP+akug8jnID4Uc=
X-Google-Smtp-Source: AGHT+IGdK6rFNtMzv/o7w6HNu0tCiqSEnlqZgL7f/KrvB7GNWi1KNGokcDBCge/J7xruX5muwQNDjQ==
X-Received: by 2002:a5e:c748:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e1d865e82emr1709781039f.2.1715917627289;
        Thu, 16 May 2024 20:47:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de473sm4436301173.154.2024.05.16.20.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 20:47:06 -0700 (PDT)
Message-ID: <f3bff4ea-507c-419f-8fca-9276281c3b9e@linuxfoundation.org>
Date: Thu, 16 May 2024 21:47:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
To: Tejun Heo <tj@kernel.org>
Cc: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
 <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
 <ZkYymMDd690uufZy@slm.duckdns.org>
 <9e72d97a-9a04-4423-a711-0c21c1c8b161@linuxfoundation.org>
 <ZkZGP9Io6o9Dhh36@slm.duckdns.org>
 <a8702e6b-0360-493d-bf8b-94dd7f17e7f1@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a8702e6b-0360-493d-bf8b-94dd7f17e7f1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 12:05, Shuah Khan wrote:
> On 5/16/24 11:45, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, May 16, 2024 at 10:31:13AM -0600, Shuah Khan wrote:
>>> I am exploring options and leaning towards reverting the patch
>>>
>>> daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
>>>
>>> Your amending the PR helps me if I have to send revert. I am sorry
>>> for the trouble.
>>>
>>> I can all of them together in a second update or after the merge window
>>> closes.
>>
>> The cgroup commit is already pulled in unfortunately. Can you please handle
>> the revert and whatever's necessary to fix up the situation? I'll ask you
>> what to do with selftest patches from now on.
>>
> 
> Thanks for the update. Yes I am working on fixing the situation and
> will send revert for cgroup test patch as well if necessary.
> 
> No worries. It is not a problem for you to handle cgroup test patches
> in general. I will need your review anyway and letting you handle them
> reduces the overhead.
> 
> This kind of framework change causes needs to be coordinated.
> I should have held back on the framework change on my part.
> 

As mentioned in the other thread

https://lore.kernel.org/linux-kselftest/24975952-b1fa-44a5-bac5-aef538ad0c09@linuxfoundation.org/T/#t

I reverted the following patch and the framework change patch.
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

Will send PR to Linus this weekend.

"selftests/cgroup: Drop define _GNU_SOURCE"
commit c1457d9aad5ee2feafcf85aa9a58ab50500159d2

thanks,
-- Shuah

