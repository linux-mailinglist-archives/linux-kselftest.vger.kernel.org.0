Return-Path: <linux-kselftest+bounces-24539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D9A115F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 01:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1651695C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD823B0;
	Wed, 15 Jan 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RI8Mfrd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566A1876
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900070; cv=none; b=soKKqSiZS2A38x4c4j9UI004cpZOK0uBgf+X8UVZKNujGn+WmD4r7gvZ8qxU1WJMV+4o3jLq8o/6ohxMGL32Fhx1/NJcJeedX5X2+azeU0VuburxDVhRB7FAe95BHeD6lU2epjBrDPJrOxcjoyK+htEOpfn7f/Z8C6NZ2k7KfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900070; c=relaxed/simple;
	bh=O0qTtB+zZrm/orJLyLqvBwYs4M10BzLG72XW5iJNl5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lq3fAAOn5/+7vEht22HCkZ/bWiipaV+nfdc331q4wxVx0S5Pkpf2Fy/HgUMRf+UEfcAmu9npe9HTKqyHlZzRJiADt6U92wy3CPyK9PU0sQgypf1ttfuz3AXhZ0+BEQrBX35DMa4uxzn1+LuOA9BLSvmwZ8p2AImggv4TYVbMdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RI8Mfrd5; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a777958043so21146905ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736900067; x=1737504867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zi0cGbsSWcjei/FmFQ8GZN9F14dK0pBaQEx/pWI04A4=;
        b=RI8Mfrd5S/bzGrqS/l/e5sa4hEP9M4nsVbMGQNdBnEaKWIrvS7kqAyBNpTo6Kms7ZY
         Zb9jsyTz+x3oldUrri4Lc3ruKqf3wFhEK0a15kVPJp1GXrpJMcvwHAEMI+XBO2bj6wDg
         gfLIyKQ3GAj3vi7SlZA7IK9p5qUnehNlN726Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736900067; x=1737504867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi0cGbsSWcjei/FmFQ8GZN9F14dK0pBaQEx/pWI04A4=;
        b=jLhghIsKV5IwcubuQOtbTcJC/BpNgoglpccCfEJQUgLe8lFn5sw0vrSuHiusjVZk59
         F8ZVtBvo+zBk2AziSmHnY9Hh2PjdN5RPlCkkITBkgwYTUo8MwsH1VGagsSt4MPCMrmfq
         Xw2tZvUkgmbcBsozc1k+nssgy1B2JDATj48/xzOXPPspBrwjVMCjFGE1rgt37waBH2X8
         MNQQsa/iqMAuu9oviYvxLA11MTrTpLLUqAohZfyJN7snaDrB15sp/3cGBdgBfxVi8ZUs
         HnE61h+XaWstojmvQlcxzgcJTb2klNwHi98lQR5lnzFyeHDAu135ttduJYDvwkTNzilW
         joGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpKULsqSWcUItpbZRj5LbArT/GWdN4h/pTcKNFADTLMfFCL7NHh0m8OermuXljXcuFkM1iFxt/Gm7NMXlI6EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvtIUmGQ08+ft3PK3SegZzDs2hyMBXmscZVT/xLZBXj9Wxiyr
	x91WhFlW2kr5M0baCGrVHBCDBxHLFrBnFbmqcNoS+k/Jjq9j/nMcdtsXNOW7kq0=
X-Gm-Gg: ASbGncvcCzjhQc3a5r/ywWdzD329XbcMgCTtOtu9MVAO/g8Jf0RF+vAVWGRhclGczYu
	brOQ5xH1JuUfN/fKG0J361WDuqg1EpZ1e0annexjTo6Lx2OZcvTji+TC6M/DwDTHBAn5anvwa5G
	MApn3tu/ABAPdF+DCb1EBPs94EN8ZC+U/NgnJdAOCy1yk/8X1Oi38HK1lgfh5d97s06oeBfpWmm
	ZpG6hvuMZPewk7pENPr2dATvEpyeABpl3hJ0mRQklpPAxjUBBiMJdmRgE2CUL/Ckqc=
X-Google-Smtp-Source: AGHT+IEdoNPbkBbn9CnzEh4euZf9jB75Vd6xeyvKGWpwgSFD4Lie6iDixMRv7ODFpjm5Wc+UzmRN6A==
X-Received: by 2002:a05:6e02:1648:b0:3ce:78ab:d6be with SMTP id e9e14a558f8ab-3ce78abd778mr48881375ab.4.1736900067242;
        Tue, 14 Jan 2025 16:14:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b5fa1efsm3741371173.26.2025.01.14.16.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 16:14:26 -0800 (PST)
Message-ID: <9b7228cf-29ed-4f35-8b8a-b4f8482c434e@linuxfoundation.org>
Date: Tue, 14 Jan 2025 17:14:25 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix handling of glibc without rseq
 support
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Raghavendra Rao Ananta
 <rananta@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 07:51, Mathieu Desnoyers wrote:
> When porting librseq commit:
> 
> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
> 
> from librseq to the kernel selftests, the following line was missed
> at the end of rseq_init():
> 
>    rseq_size = get_rseq_kernel_feature_size();
> 
> which effectively leaves rseq_size initialized to -1U when glibc does not
> have rseq support. glibc supports rseq from version 2.35 onwards.
> 
> In a following librseq commit
> 
> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
> 
> to mimic the libc behavior, a new approach is taken: don't set the
> feature size in 'rseq_size' until at least one thread has successfully
> registered. This allows using 'rseq_size' in fast-paths to test for both
> registration status and available features. The caveat is that on libc
> either all threads are registered or none are, while with bare librseq
> it is the responsability of the user to register all threads using rseq.
> 
> This combines the changes from the following librseq commits:
> 
> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
> 
> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Hi Mathieu,

Can you double check these commits and make sure these are right
ones in the mainline rc7?

I am seeing "Unknown commit id" warnings on all of these - my
repo is at 6.13 rc7

Also would you like to add Reported-by for Raghavendra Rao Ananta?

thanks,
-- Shuah

