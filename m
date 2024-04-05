Return-Path: <linux-kselftest+bounces-7314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0789A46B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA982842A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572E17278B;
	Fri,  5 Apr 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgof5Yl/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A61171E66
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343041; cv=none; b=F3rjLu3cIzeiueZ9or+FGfXUF9JyYDMxtrwOPWIxNRAXawPVrgzndZYddvLOzxaDg5gIb7mS2FruWH/45qnuJVId5cY15Qd/Nekht6k1Fw1aieo8SR5Ijyl0rJHVZRMTU2NahdtEaz5NI9MT5AYuyBbfUWHDwwLZrqGaHp6MDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343041; c=relaxed/simple;
	bh=m7oG2Qmos7+pA78FFQa0mcED9SbBpSit9bDHeJjmzQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJZu36cuN40ItGbjhHHwOlEzFkSHz3X4rL9FiJ5jHA9s8BI2WE4SufgxVUbxt3KOH8GSPjCVfVE5JSv8+vWDVb/NoBz5hiS/VnxquiQyGpwPwDlcHA4xZYBUDgpgRc+i1wLTB1f+wmp1uG0vydBKrxM2oymrkDcca6cD8ZnZNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgof5Yl/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a11328dfeso984515ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712343038; x=1712947838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vp44i9Xlfeu0O10COsw98V/v7e0jo8kvUbsVGI+1kuo=;
        b=bgof5Yl/PgEbGbIwPck+Do3VgBLbEy9ZQK+apV9dCcrJbJ7p9PgazTqrOZxooPIKgh
         8EqAtlBS4St3/mGXMYyXNpzAHsUBx5mn3qubOdCirKuA1le+BRhjuDixJBPI8Bakitz1
         +g+J1OTUVE+T17HMXMDxo/xkNInNH9ArdJop4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343038; x=1712947838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp44i9Xlfeu0O10COsw98V/v7e0jo8kvUbsVGI+1kuo=;
        b=ptRrMq2oP3rc2vRr4UCiU55rYsHdtnWosGXt6KP84jgvkQO/ub+V6gu3c2es2L0GML
         DWTT2R+2YU5Y1FoGpe0gA8c2gJ8kqv4zAmCVkYdyHpAuzU3JKJ0k2dkvyw5x6WpLx0At
         ToJlFlFxApsYi3J1OPn+OvfV3tPiK7ON55ehi4VUflyUqjqHP+3xi8O5NpRZz6J7n5O/
         l0u/Ji6M0hWINCtLdGCUr7ijemRE9L1onUxnfh1cIJ8ntCVnFneW+u/5gLdLJVyEf5h/
         5u+XT0myH0kXAoFyw6gNmP4teCwHHOtG4QtfhPElu7kzzNK7zmhhVywll25wXQJH4y0I
         ng3g==
X-Forwarded-Encrypted: i=1; AJvYcCUcQk6D1gY1T6VBXMa6fRJ2fBmCS3UvEP7ZcqeG1Oj6/6FA89cfr9vTk+2PHKeSQf8POWdz9qzYn8ZBWIykkJuVAC55xMYj7wbDSWD/6RSQ
X-Gm-Message-State: AOJu0YyfXujWFH0yVBgf5lhDiHQ7EEm08uYxmLLcAnF7zO6BStz2j2yw
	BrTYmDDOElzRZZKUj9DmKjj7oNWfiD/bL2wFoVfBET+VHNP5y8uL/Ywcv9/9/fY=
X-Google-Smtp-Source: AGHT+IGnMS2NKy+1HVwAPdxdmucJAIWJJEZlmMEtziDgLQxVglpyFfMG5GBRQy0N2McwE23OjduKXA==
X-Received: by 2002:a6b:ec05:0:b0:7d5:bfd3:7237 with SMTP id c5-20020a6bec05000000b007d5bfd37237mr2288245ioh.0.1712343038341;
        Fri, 05 Apr 2024 11:50:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x26-20020a02971a000000b0047ec2b62deasm724949jai.91.2024.04.05.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:50:37 -0700 (PDT)
Message-ID: <84acaa6b-44b6-495a-939f-4a6e49e162c9@linuxfoundation.org>
Date: Fri, 5 Apr 2024 12:50:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: Kees Cook <keescook@chromium.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
 <202404050832.187F972C@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202404050832.187F972C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 09:32, Kees Cook wrote:
> On Fri, Apr 05, 2024 at 08:56:31AM -0600, Shuah Khan wrote:
>> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
>>> "Bail out! " is not descriptive. It rather should be: "Failed: " and
>>> then this added prefix doesn't need to be added everywhere. Usually in
>>> the logs, we are searching for "Failed" or "Error" instead of "Bail
>>> out" so it must be replace.
>>>
>>> Remove Error/Failed prefixes from all usages as well.
>>>
>>> Muhammad Usama Anjum (2):
>>>     selftests: Replace "Bail out" with "Error"
>>>     selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
>>>
>>>    tools/testing/selftests/exec/load_address.c   |   8 +-
>>>    .../testing/selftests/exec/recursion-depth.c  |  10 +-
>>>    tools/testing/selftests/kselftest.h           |   2 +-
>>>    .../selftests/mm/map_fixed_noreplace.c        |  24 +--
>>>    tools/testing/selftests/mm/map_populate.c     |   2 +-
>>>    tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
>>>    tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
>>>    .../selftests/mm/split_huge_page_test.c       |   2 +-
>>>    8 files changed, 108 insertions(+), 108 deletions(-)
>>>
>>

Usama,

Please generate separate patches for each test (one for exec and
one for mm) when you do this kind of work across tests in the
future. I applied them this time.

>> Andrew, Kees,
>>
>> I will apply these to linux-kselftest next as a series since these
>> changes depend on change to tools/testing/selftests/kselftest.h
>> and need to go together.
>>
>> Are you okay with that?
> 
> Sounds good!
> 

Thank you. Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


