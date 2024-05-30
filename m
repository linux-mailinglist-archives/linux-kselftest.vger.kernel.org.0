Return-Path: <linux-kselftest+bounces-10924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806378D4E7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0B1C2334C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DA186E5C;
	Thu, 30 May 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BH3o7go5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B317D899
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081100; cv=none; b=uXyJQmjcVcpoh57uWxzrjHWfc2nkWq/JCbW/rd2TFSM8YolFjpFHJm/GYilDK2vhih4H92ehaFQfi43sJOYHa1Mf0KC7YOdSf8Qnc9775tqAww2e+Czons1SnuvcfJEDu3IOxfoKKJmv//YlIh3/2smzTB3/XRuIlP4mwlNMQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081100; c=relaxed/simple;
	bh=6frT2cUqOy2QZwW8Jb/ICL917q3xtkQYsWty0q3A7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esePtTkw4JxRHswyRrrtMMYD5ilQZqHZaAdGW2QO6/e6hs8O3mWYhgsbKJaf33dyXL9zPY/KO5xIn7QEkeWwYSybI0qxsc0uTetJQ5wxNPtUuaFfKSwpyrmiwCnQybBZKk/Tv6IfqbJiXI+EwTfhGlBtyiToZJ0n2/ywrzoAu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BH3o7go5; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ead7e95c91so4509039f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717081097; x=1717685897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYQWkDbOOCMyq/o0QgNOHjrEjyrRmklhwNgybQNhet8=;
        b=BH3o7go5uU9GFxLELhp5muo6xJ8S7whMvwe1K3VaD4bBzmCMSMv7mwDr3ulgp2Fm/y
         Z69oQUoGnQ/Spq7svVv9cpB/Lj14DPzZfkUaRdz3rFVgbpeZntqUjAX8vnA2Is8TRkpG
         nulYZLF2D0lNMgZW3sUT0coM3zHucQpq1oyK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081097; x=1717685897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYQWkDbOOCMyq/o0QgNOHjrEjyrRmklhwNgybQNhet8=;
        b=C4AVAXDYrIl7+mADPQE6m2NIbNBUh2QkFmUaP8AC1YsBplpNUr8gdZCcK6QCp0pBs9
         URfhAf/1MjdyzaV4WtFuuD6ApcVC/lNqlmOjnQZ0P1TINUBQUyuW6iE1L6MUB0XbS5Dw
         iMJEq4P6prhTUmQQBOnD/QiARP3JcmIjoX3cG/IeaLXz+nMufz0+BhLPZkE+C5gjtNd4
         VokheBvNZAQoOcHnoX3b2rm3WSVsGvqCHiV7Gv8yYYVftu3KUQr4PaB1mGiKCsrB6PJ3
         c7PWU4wxo7ExoF4ASFtEE9C1DgZEt9OXthd9NHIcy1Ccv7NwEbGdwmw+pSkKzOyDJ98I
         wjYg==
X-Forwarded-Encrypted: i=1; AJvYcCUyjzCKvjiqp+ZVPku595NC9Hy5Dh919tts8Gth2lVLq4YTRdylqLbh1DuYv9Mht733ZdLc3xJIYnYupr0oVUh/tyjFYLPIfo8mQ+RqSmcE
X-Gm-Message-State: AOJu0Yzd2DgtS5crIX/KlOGEfnzen7ZpLYMxs+tlxrNWwgYH7STSli7j
	+bDZufxD6xWaUbLdqmuX/Jdomy8dw6XONK3q4Chex9rd1c75l1g9b5JPlWY7F1w=
X-Google-Smtp-Source: AGHT+IF+c5SyF4FomowgTAfuj5YYGj0MkoKjfwfa0To8fH/UHJshVIcQ2oirqjk7Q32H9m4sYBF/7A==
X-Received: by 2002:a5d:970c:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7eaf5d9611amr259019339f.2.1717081097098;
        Thu, 30 May 2024 07:58:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0f152442asm1842750173.173.2024.05.30.07.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:58:16 -0700 (PDT)
Message-ID: <f4877afd-dc2c-4e54-8b53-c681d3eed045@linuxfoundation.org>
Date: Thu, 30 May 2024 08:58:15 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Alexey Dobriyan
 <adobriyan@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 15:00, John Hubbard wrote:
> Hi,
> 
> Just a bunch of build and warnings fixes that show up when
> building with clang. Some of these depend on each other, so
> I'm sending them as a series.
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1

x86 test patches usually go through x86 tree.

This series requires x86 maintainer review and ack for me
to take this through kselftest tree.


> 
> Enjoy!
> 
> thanks,
> John Hubbard
> 
> John Hubbard (6):
>    selftests/x86: build test_FISTTP.c with clang
>    selftests/x86: build fsgsbase_restore.c with clang
>    selftests/x86: build sysret_rip.c with clang
>    selftests/x86: avoid -no-pie warnings from clang during compilation
>    selftests/x86: remove (or use) unused variables and functions
>    selftests/x86: fix printk warnings reported by clang
> 
>   tools/testing/selftests/x86/Makefile          | 10 +++++++
>   tools/testing/selftests/x86/amx.c             | 16 -----------
>   .../testing/selftests/x86/clang_helpers_32.S  | 11 ++++++++
>   .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++++
>   tools/testing/selftests/x86/fsgsbase.c        |  6 ----
>   .../testing/selftests/x86/fsgsbase_restore.c  | 11 ++++----
>   tools/testing/selftests/x86/sigreturn.c       |  2 +-
>   .../testing/selftests/x86/syscall_arg_fault.c |  1 -
>   tools/testing/selftests/x86/sysret_rip.c      | 20 ++++---------
>   tools/testing/selftests/x86/test_FISTTP.c     |  8 +++---
>   tools/testing/selftests/x86/test_vsyscall.c   | 15 ++++------
>   tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
>   12 files changed, 72 insertions(+), 58 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
>   create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S
> 
> 
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> prerequisite-patch-id: 39d606b9b165077aa1a3a3b0a3b396dba0c20070

thanks,
-- Shuah


