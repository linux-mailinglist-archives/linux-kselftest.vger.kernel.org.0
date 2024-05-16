Return-Path: <linux-kselftest+bounces-10311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE88C7BBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3EE1F23093
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A082156F29;
	Thu, 16 May 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNm95dxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF4156898
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882754; cv=none; b=NVlhqt9kiH8J5wQ3W0d6B064QS1ySMaQ/kwZILl/5LgLoLNKPOwl1fwB+dxD1BzzwE4bnqJbhYe+VmlGX0n+oJKEsPlmxu50ws3QrK/Z6mwoIQ3EpoIJQIp6EKVtlOmnd5W2PjnRsOPss9WuyN7WAQ/KxGA7kltXblYP/ErWJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882754; c=relaxed/simple;
	bh=bpIGieCWHFwLBK3L/EX06rJ2q6xGlvWxG1zJZRSm8AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2IDTGBVCjeQd77qta0e2u0LmQi40kp/vCUaN4WZqJyfVxTREQHvQ5hjHKsNnLVgOvgY124/WPiVSVu+PAas7fx5DlUpKpqkOOY4Vl7WFMClxWVPI1IiONmTFpuY61AL4etdpM62wW2+58jjphiPQjUYUxEU0Mur+8jzSjqvx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNm95dxT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e1b8718926so9580339f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715882752; x=1716487552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kOPvncac5GEXKOWcgYcErTg+ZSoHGXXhbSEbOdfWFY=;
        b=eNm95dxTa8UqIf5frnF90mZWzlaCUcD6fsjHzbZcToL9ezC8voYY6s4XS/5LV3/yGf
         xqhhFi2Q3VnhDqqO5tzV7M1xLixR67TSVk+nZgwi6Pk/UMhOpGzN4CyYnParMPmBypcE
         PDZdniFAU1K/XcGepD/QRtnT24oIG2kjNI0gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715882752; x=1716487552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kOPvncac5GEXKOWcgYcErTg+ZSoHGXXhbSEbOdfWFY=;
        b=NKAvvX5BL3gOw95JeCTZW2vvGHaKgFqylsHI0nTgfQYO5CWf5/XgGlHX3zt+NVY25Y
         JtEH98+8GjH6osJ+zGZ2z331FxvPPHQUNWVjpPiMu+cgu7FqJyBkKxFSVZ+NHXtgU/Qc
         YDQ7uIs/FJnhYXd4GqBZ13FJJIP3ZdYblNJptpf2QQiBNmG+ZtYQfRllzkUT08+LM8Jf
         FI9ch+aULNO7PS/YmeXk70/TsQsN3dHW7cR9hhTYNXcyY8xnf1haWtuCqgo+u3dZThNf
         QZwad4mQTBO6A5SpQ7GGKuu6kpM5YD74uT59mNSA5gkQMtz73qN7ywLkQVFRdlmFlKNu
         663w==
X-Forwarded-Encrypted: i=1; AJvYcCW0l6Zj2OS9LxKaBiBAVaflqVIwQWb32hzBvO93pceFZSu7f9QYqBC26cr3cIiV4b+RiIAoByfP3wYUtioFbynSjJEbPUNCiegQtOFZGetQ
X-Gm-Message-State: AOJu0YwnzzLJh1P0ujAmt4Zl9RGtADM10AcXOGbOeA5/VY+g3rXXgs8A
	QZX/ynXny0EOPGYw7QDMoUgUQMcBQaRTR7OMVbMH1OmQPw2Pgu1AKRawyKzkexs=
X-Google-Smtp-Source: AGHT+IG9thpIuxuOJl/ateMI7c9MGpJjRHArmdLOc92/CkQSwD6jAwuSSMxSGmhDOz36YwjGKp1fTQ==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr2055903739f.0.1715882751618;
        Thu, 16 May 2024 11:05:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e2031b57bcsm134683339f.8.2024.05.16.11.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 11:05:51 -0700 (PDT)
Message-ID: <a8702e6b-0360-493d-bf8b-94dd7f17e7f1@linuxfoundation.org>
Date: Thu, 16 May 2024 12:05:48 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZkZGP9Io6o9Dhh36@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 11:45, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 16, 2024 at 10:31:13AM -0600, Shuah Khan wrote:
>> I am exploring options and leaning towards reverting the patch
>>
>> daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
>>
>> Your amending the PR helps me if I have to send revert. I am sorry
>> for the trouble.
>>
>> I can all of them together in a second update or after the merge window
>> closes.
> 
> The cgroup commit is already pulled in unfortunately. Can you please handle
> the revert and whatever's necessary to fix up the situation? I'll ask you
> what to do with selftest patches from now on.
> 

Thanks for the update. Yes I am working on fixing the situation and
will send revert for cgroup test patch as well if necessary.

No worries. It is not a problem for you to handle cgroup test patches
in general. I will need your review anyway and letting you handle them
reduces the overhead.

This kind of framework change causes needs to be coordinated.
I should have held back on the framework change on my part.

thanks,
-- Shuah


