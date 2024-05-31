Return-Path: <linux-kselftest+bounces-11062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330A8D6AEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CA41C21128
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF717CA1D;
	Fri, 31 May 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSPqzJel"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DF1CA80
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187985; cv=none; b=q2pSE23IwCY1JHu1LY5V/or3hzqgyaOXk8Xt5ChcXt7HvoUAAWFfGXtnvRBhLV7ect49RrREVv66UITKh95pHBvg8H6PgimRt7vDqWg7hpPKxi1D4CDZBAlKNpzK5qoQg/ZZZJJfRo+GPVe4/wJmNnGwVyvZG86Z+FmGQwHjgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187985; c=relaxed/simple;
	bh=shhio0iNEuO7LiDKGHdia85hkYDhPRfghUqasfZZD+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Md/6pzXi9/PTEVwWtwfjuLMRot2zSqfUTdpnD4UB74oUHhwBXraFic+7gGt+7zYYjyGFnU31cyZDzmh5BoqUDWoYPO7yUdK5q9gvd9EZHelY8cSf+wDwCJrIzqPJxMgdCe8PwcNzPYNrDswpeZDXKoAcEEBzjByPy4kk3sCyAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSPqzJel; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so11683239f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717187982; x=1717792782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6cHgWjpqD8fz5b7y0liRbomCTR9fA7E/zBbxbh5sw4=;
        b=PSPqzJelWORugQHF9dweOJfzNzUSvvGrJQnLuiYc4EPbX+WP1hTPhy8LD8v8K2lwHr
         xf9IbD0sqMuWKYU9W03BR7v9OlVsMnV/tNqbqYF/cnNizW7pELx1ZqBMHOa89tXroCB7
         i/W5uryS1pEQ+pMBEjvJZBqTBNREAhvm5ilUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187982; x=1717792782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6cHgWjpqD8fz5b7y0liRbomCTR9fA7E/zBbxbh5sw4=;
        b=DjaTZCKOtlHhK9V9T6GWWgrB7PgI8kJ5CtSQHpvLWzknhY1Vp3SgDwwvXuAFpqxqzz
         6ErYRdSFsZXizrhh64qmCrh99d13eDUNlyLN9uxOssuRDQ7RZsKxoYkoWHHi3dhMExbC
         HbO7M4h00Lhj0sQh5yCE9hjshCSqtr0lHuNowZDv7IPrxYN5Zv5n5Fkyi/lMtxoG6rc1
         3Oh6by4yG1/aWqWnaiJos472je1tioDIYJQ3WsNVceGB7u88Xh5rkaCg83U9roDAG6qL
         XrZE/Rv/L6Yzak4LDAdK53nT5pO6IsLYq+47pYPi7m/yGialzYwikmxc9ws3Xtm9aAWG
         9tOg==
X-Forwarded-Encrypted: i=1; AJvYcCXzzM109x+nmRx4wnKRtKTJVL6pP1p0f2lew32Y2a8FZOS+Kv/re3RqTEAEAq19dHv8HRW0u5PVF7wH5rFBE02ecQWRrMgTM3ZStAtbX2xj
X-Gm-Message-State: AOJu0Yxv7G+ci4qKbyNKAwc2zVkHJ4MOjeBd9eLfQKmxqp9B8z9LPUAQ
	0eU15avSEF9SIAc5FfEnAXyl/PKQdgt9JQIQ3s5gtcNViuRHFAXLWhpBJC4bhR8=
X-Google-Smtp-Source: AGHT+IEi/yRk3a3BA5WhOOsakdFKAemq7R0bofiAbYYvoIhENWSoZzpQG/FvvYP3/VSRcUgV/PlyQA==
X-Received: by 2002:a5e:8b09:0:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eafff1f512mr323936339f.1.1717187982213;
        Fri, 31 May 2024 13:39:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b562a839acsm269349173.67.2024.05.31.13.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 13:39:41 -0700 (PDT)
Message-ID: <0394faa7-af19-4929-a1e4-00d21d0749aa@linuxfoundation.org>
Date: Fri, 31 May 2024 14:39:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests/futex: clang-inspired fixes
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531200755.128749-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240531200755.128749-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 14:07, John Hubbard wrote:
> Hi,
> 
> Here's a few fixes that are part of my effort to get all selftests
> building cleanly under clang. Plus one that I noticed by inspection.
> 
> Changes since v2:
> 
> 1) Added a sentence to the .PHONY patch, to show that it is removing
>     duplicate code.
> 
> 2) Added the actual clang warning output to the commit description.
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 2) Added Reviewed-by's.
> 
> ...and it turns out that all three patches are still required, on -rc1,
> in order to get a clean clang build.
> 
> Enjoy!
> 
> thanks,
> John Hubbard
> 
> John Hubbard (3):
>    selftests/futex: don't redefine .PHONY targets (all, clean)
>    selftests/futex: don't pass a const char* to asprintf(3)
>    selftests/futex: pass _GNU_SOURCE without a value to the compiler
> 
>   tools/testing/selftests/futex/Makefile                      | 2 --
>   tools/testing/selftests/futex/functional/Makefile           | 2 +-
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
>   3 files changed, 2 insertions(+), 4 deletions(-)
> 
> 
> base-commit: b050496579632f86ee1ef7e7501906db579f3457

Thank you - applied to linux-kselftest fixes branch for next rc.

thanks,
-- Shuah

