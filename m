Return-Path: <linux-kselftest+bounces-18234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B229C97EEC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A38281546
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16DA19924A;
	Mon, 23 Sep 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cRAown0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7A18E25
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107297; cv=none; b=hkXyIMcrYj5NZg461Cl7f/AJDR/c88hoO8385sEchiNLjye6n46HTmcFuia4ffhiSC/EW04LiC3r8MNUiJDziRrJK5ACBeTOuYnhRW0Qfic/TrUuPHUlTGHOsKhVPKr90W+84nGNiBSykByAHl1fI0i1taqgvMEWdKy+6RoIDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107297; c=relaxed/simple;
	bh=yspVqEEveq6ZyrJvWKmdhNPB1+L73B7yIVlcbXkjREk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScEeGOdKkR9IFLIcKGg1NT8MeFgdfk0uy2O7/rAfPAZH2dXbg3AM6p7IzBtoXEbd/QiyOn+/ENIiKolyNH8FyUO0vFj8ZK1Y3r1qzVPgDd2i5gNcUAyqwwB7DD5CFO8RSI2u0XCBHaPD9hnO4EporYdke5HSph3e8ASA/a9iFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cRAown0/; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so239260739f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727107294; x=1727712094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEml613ScxlbxV2rYvuLeC1V8WRj6hDYMm4pZjj0Dbk=;
        b=cRAown0/DK4sI6Izpm2MnU5EVHW6aSyonp/kPVwmARNCUjwP7/WJ29mROR0Yuqw/3a
         1CEupIiUt8O1a3VV67WncL0tLPvFPVS9+ku8aDRxPGs39W6/s9VAX1iFnGUu6shm92UP
         ZHejrxISjz4BMYeNvmI7Gu8RJq+QOw4lO0nNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107294; x=1727712094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEml613ScxlbxV2rYvuLeC1V8WRj6hDYMm4pZjj0Dbk=;
        b=lFfYQXtbr3PJI3mFxftOGhePVfLgufEVNCiXCyrtMrIRxO82MCJMgDfTNAcekoQkzp
         rB21We4dNZHCvXpMw5Be/kO+siGG/IuKoeD69TNADKOR4pqgM5M6KtfOFko7lThKgEc8
         1T9J0Bm+iM/eAl3mG0mUE7jco6/+2sHJM10PBd8wVXnWlq9qpTaYd61InpJlrrAlj8si
         zf3m1A/DUwfxeTlyaVwhbgWbj3Rjh94wJ86CUrUK2XGV6AIcPF1wGD26pDYTeLM9v++L
         aWIYdIZv2aujHj3GHlfzdfpVxTqhFO6a2WFMc0cAe3tAIQdi3xKkwxHiprH5PtyTKj3U
         r/RA==
X-Forwarded-Encrypted: i=1; AJvYcCU66F4Ne9UyvIkoUML2dXj50+SM7DxiCaEeWbo5EGCmKc4obH4OR4YZ3XGHKg2lGITM9UXTONKzNUN9smNnV4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjyc/T7ntFv6JexrBJvm3e/InedmUGSeCp4mF8fxR7xNWkgK8
	KFcl3zk6NGnuUtfJuyCPs/uemCORfLccXJ5wULmY6CL56nUeKzjg5X44dKgXI2w=
X-Google-Smtp-Source: AGHT+IH1YGCGJJ3r++ctoT2ootUH7ze8FehY9Z9KUJuVPkNr2J3rM+XTA+PCfIdF8RFkh6IHB4QBAg==
X-Received: by 2002:a05:6602:6d08:b0:82c:ec62:6602 with SMTP id ca18e2360f4ac-8320b328ce5mr990358739f.12.1727107294259;
        Mon, 23 Sep 2024 09:01:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492b9676sm562541739f.33.2024.09.23.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:01:33 -0700 (PDT)
Message-ID: <92f63189-851c-44d1-951e-6a6c39eb223f@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:01:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923053836.3270393-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 23:38, Muhammad Usama Anjum wrote:
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
> __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
> __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that:
> x86	374
> x86_64	323
> 
> The value of __NR_userfaultfd was changed to 282 when
> asm-generic/unistd.h was included. It makes the test to fail every time
> as the correct number of this syscall on x86_64 is 323. Fix the header
> to asm/unistd.h.
> 
> Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index fc90af2a97b80..bcc73b4e805c6 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -15,7 +15,7 @@
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <math.h>
> -#include <asm-generic/unistd.h>
> +#include <asm/unistd.h>
>   #include <pthread.h>
>   #include <sys/resource.h>
>   #include <assert.h>

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

