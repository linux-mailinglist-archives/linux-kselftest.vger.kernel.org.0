Return-Path: <linux-kselftest+bounces-20244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5E9A602E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F8E2866B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12921E3DDD;
	Mon, 21 Oct 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC1wTz1o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDF1E32B0
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503248; cv=none; b=BuQXEOd8Ks6/WhSBbz5rgTEc7QVPDn7jJC5q/ocN0FWWZyCH94QXFhHQQz6kdONZEexT2SsapKOla547hJQ9pG0ITOvfE/7KKC7MEwd0D9qogtNMO7Y01v84A34fVlVvh9zGXzzP5pODdsBR6lBp0LGi08Q8+EBF/lWtYmYtSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503248; c=relaxed/simple;
	bh=WKXZCgs18X9S5ywX9Jm7kT5M22O5Qvm/MvLJ/K2dOVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuo+4R2TGSVoYSXlqUCjK53ICCh1CjCZtTGS6SWxKRok5EyBn5jrNJ3a6REJCZT65cxzNKTO1CtEmIbdYM1173SRmBpaNVwNARVw3pQIKGX0Joa6zfLZGbaKxI6/cFzzgo1O9JFZg3aP+J6ZjgntS5QYzdKjvc4tCtWgQ9MV4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC1wTz1o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729503245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1qrMQuES5B03MGFeoy/Tls0FHqUcPfUE/C/kE01yJ0=;
	b=CC1wTz1oWBryQnPEcLYR/+4PtrIcIS7AAJJoFA4SHctA546AYwI31Wm8KdJQbwALH5pXc/
	8KWHBuvAAo4iWqrXSZHthq+L4GKO9uPanKRc6y/LY0N2Z4/SPfJXt8pSV5oekWe64bU8C8
	a7OEzO3T87tmwTOQxqnUuULsuVRGfL4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Uea6MRRBN6yrw8vwoCkuUg-1; Mon, 21 Oct 2024 05:34:02 -0400
X-MC-Unique: Uea6MRRBN6yrw8vwoCkuUg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ead6c504so2434083e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 02:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503241; x=1730108041;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1qrMQuES5B03MGFeoy/Tls0FHqUcPfUE/C/kE01yJ0=;
        b=jYefQ3I5MzaqFep1i88spLBi3dgT6SKErOt9P6iygvyvyQggNzOvDoUd6h/Lq1+97+
         he9/IyD9NBqTgzY7WRaALsrSF9Y99OqRLpYcEcWADXvn0rQtilxjge3boIj3zy/LOLdt
         kieg3HSo8rcYXenS3LAZPJptGYfiOsv+GFCLfZRKFzAdwxXU7Qia76JmOdELqiqNopr3
         x6p2v4wJQk56B5PIq+mAlhRxToByoADC1tiuTMFkXCfb/RB5Nir2cTHPRhAZB4cd68qo
         tR6ecbDQGfkL2NBWtd9mFkk8Yb3SFXOPJWVICA73TeFgk1HMLfaGV99l3x9fq1ATYHzt
         RDaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJplEHy1mxw54zWg0D7aS10WU+3qse3vur3JIYrEinYd/PsgqxhZR5HMSEGWkpkaf1mjCNG3g24sfgMDYKPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAWuxFGNYLDmnRIDXKItN/DBEYGSqe/J9MDT/XBR9o9cpWtP8
	mIfWG57pSmIpIbH773YMdbWiCBc3f3qoGWR1M9OUpfHI6yM3/7RH1ebGu+MDt/q7tB/YhJ0qD8u
	YgU9w6RN60xVHv5d+v+VqmZVyKFjS5DcSPXHiFQxkEoXLUCQMBnZQShFjVRhoSaYcsQ==
X-Received: by 2002:a05:6512:b19:b0:539:df2f:e115 with SMTP id 2adb3069b0e04-53a1521993cmr4562871e87.23.1729503241164;
        Mon, 21 Oct 2024 02:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9rOgj5iTkXbIp620Wgo630E2yBpSB1XyYMCGTDIjsvmCiEgeU3T276NXuPJl62rHEL7ftng==
X-Received: by 2002:a05:6512:b19:b0:539:df2f:e115 with SMTP id 2adb3069b0e04-53a1521993cmr4562842e87.23.1729503240709;
        Mon, 21 Oct 2024 02:34:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570dd5sm51388215e9.3.2024.10.21.02.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:33:59 -0700 (PDT)
Message-ID: <4a775fd6-cb07-46eb-aa15-026e61317c16@redhat.com>
Date: Mon, 21 Oct 2024 11:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] Wrong value of __NR_userfaultfd in
 asm-generic/unistd.h
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Kim Phillips <kim.phillips@arm.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.10.24 um 08:48 schrieb Muhammad Usama Anjum:
> Hi,
> 
> The asm-generic/unistd.h file has wrong __NR_userfaultfd syscall number which
> doesn't even depend on the architecture. This has caused failure of a selftest
> which was fixed recently [1].
> 
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that it
> is different for different arch:
> x86	374
> x86_64	323
> ARM     347/358
> 
> It seems include/uapi/asm-generic/unistd has wrong 282 value in it. Maybe I'm
> missing some context.. Please have a look at it.
> 
> The __NR_userfaultfd was added to include/uapi/asm-generic/unistd.h in
> 09f7298100ea ("Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)").

This is not specific to __NR_userfaultfd, just take a look at some of the other 
syscalls (e.g., __NR_membarrier).

Now, some of the files you list above are "generated". Doing it on a clean tree:

$ grep -rnIF "#define __NR_userfaultfd"
arch/arm64/include/asm/unistd32.h:789:#define __NR_userfaultfd 388
tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282


But now comes the tricky part: an architecture defines whether it wants to

(a) Use the asm-generic unistd.h
(b) Use a custom one

E.g.,

$ cat include/uapi/linux/unistd.h
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
#ifndef _LINUX_UNISTD_H_
#define _LINUX_UNISTD_H_

/*
  * Include machine specific syscall numbers
  */
#include <asm/unistd.h>

#endif /* _LINUX_UNISTD_H_ */


For example on riscv arch/riscv/include/asm/unistd.h  will include 
arch/riscv/include/uapi/asm/unistd.h which will include "asm-generic/unistd.h".

If you follow the flow on x86, you'll find that it will not include that 
asm-generic one as default.

So the asm-generic variant only applies if an arch wants to do it in the generic 
way.

$ find tools -name unistd.h
tools/arch/x86/include/uapi/asm/unistd.h
tools/arch/arc/include/uapi/asm/unistd.h
tools/arch/riscv/include/uapi/asm/unistd.h
tools/arch/hexagon/include/uapi/asm/unistd.h
tools/arch/arm64/include/uapi/asm/unistd.h
tools/arch/loongarch/include/uapi/asm/unistd.h
tools/include/uapi/asm-generic/unistd.h
tools/include/nolibc/unistd.h

Consequently, the asm-generic one should never be used directly.

-- 
Cheers,

David / dhildenb


