Return-Path: <linux-kselftest+bounces-12129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DA90C441
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08F02810F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA513BAC7;
	Tue, 18 Jun 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9zCuv/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008F13AD2B
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693795; cv=none; b=nYUDkowtVsJLlFtDBpEYOgYTm6pvkYbO8Tb+tsRPUn9wnYKOGr3L/76WW4c8FxL71NNGwkSIqJwaO3Bykc0JIx1k2sOc1U/ZI0xaQGL3aFCevv/F/Jmz6CM/S0JdAdPicgJqQk1CIObI9lUFx34LQQ++z4AKDvbJXK7oTHvLEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693795; c=relaxed/simple;
	bh=4NJ1McSbZs2bBPMZ7nNcaP112RpmYeIohtjBsFTLr/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtt5lQpS2u303Q2GlsLwVoeDWZrAUojDZxOzD/MMeVRtUs5/3jTwKNHuz0KGZ4L7y4BleiHSUH+/k8Tto6G8/4TnNP1FU45TfX+zeNNzzXJIG6bmtMNtCUDHtntXGqc/u5xCk84/Ws8f/oxC1IdiNvXPKGuCru8GTrtBrl0c0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9zCuv/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718693793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BjXGn7SpC4HAkT4lUvp5F9/7ZHjW+CPkuO5AAhEulr8=;
	b=H9zCuv/G7YlnB9ZEk9ki1PtWjklThAbMk20ee8AEirEX7Oqi1AFl0ubUXN/gV1wf3QtkF6
	m9/c09d3StWxpumAIrWo+wyTf1fEOYBVVL055zFegOO5cl6zebKrtyRNFHnqEjV+TkcuXe
	F579B7zepXpEsbDJN7kkWhowllJCaYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-d9VtKzq3MZ6eyhA48J5E-g-1; Tue, 18 Jun 2024 02:56:31 -0400
X-MC-Unique: d9VtKzq3MZ6eyhA48J5E-g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f06558bc3so3562578f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 23:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693790; x=1719298590;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjXGn7SpC4HAkT4lUvp5F9/7ZHjW+CPkuO5AAhEulr8=;
        b=vdkLtmliNmJLhnE2gFj1SpBmpEuS7fyHYMf0/sqAhGWe4wVOm2BnhU8whV6SMnMcdt
         66vhDclmQjzke4c2N/SI+KlAl1qoZKWF36P3hSQfzSu/gWbg2+XLM7cTLHzWCUPTDbFA
         YSF1tuLRiRW6QS5yN1F6i9GCcY27xXNkYi1l09ZWLHQWz54qwXkEYTOAXdrpXz506G5G
         woxl0QaL4FWDvPKRqDaHwQSegeVf72QHaa1OEohgQNXRD4mHXAF9ypbin2mGh1DSn/JC
         D9dD95nmd1hunOy1SHQXmDWgb11ndau51r0yS0k3BbgEwgKg+72fOVPrGnFcu2mR/f9P
         z76Q==
X-Forwarded-Encrypted: i=1; AJvYcCWocQL0bIUvc9wPBZubCpTSl+nwh/lzU5ZDSlJ2vNNACdadgr6OkhAKDZP0MDBk/JOas/N/Awru+0D0O3UTnuFNT7+e2YL3WqJcvIlaUPpI
X-Gm-Message-State: AOJu0YzI/dtXZLZZhF3gg7JbFK72Bc3GeqA7A0NhUsCS3l2Z05UTAliS
	dudRkyKF1M+Y2XB1Fp9S2hV50KzjFLAjmMGYWSDGVqQ9nuB0OWs3Byrq7uk+aOZTqtKiBSwGwDb
	w6Oq6JqoxApAHwsw99MF/nD6GBRlDbpoNRANbdKUO772xh7JKnT66xmo1w1d8dsl1Tg==
X-Received: by 2002:a05:6000:188d:b0:360:82c7:f07f with SMTP id ffacd0b85a97d-36082c7f5dbmr6829777f8f.57.1718693790237;
        Mon, 17 Jun 2024 23:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGujDfzorPxgwvTzQzfY7PmBz5PJ8AoJhQJTgMSXeyewdb08Cf6D/mxjJRjKihjXviRcqbTsw==
X-Received: by 2002:a05:6000:188d:b0:360:82c7:f07f with SMTP id ffacd0b85a97d-36082c7f5dbmr6829757f8f.57.1718693789826;
        Mon, 17 Jun 2024 23:56:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f228asm13524414f8f.73.2024.06.17.23.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 23:56:29 -0700 (PDT)
Message-ID: <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
Date: Tue, 18 Jun 2024 08:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-2-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240618022422.804305-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.24 04:24, John Hubbard wrote:
> The selftests/mm build isn't exactly "broken", according to the current
> documentation, which still claims that one must run "make headers",
> before building the kselftests. However, according to the new plan to
> get rid of that requirement [1], they are future-broken: attempting to
> build selftests/mm *without* first running "make headers" will fail due
> to not finding __NR_mseal.
> 
> Therefore, include asm-generic/unistd.h, which has all of the system
> call numbers that are needed, abstracted across the various CPU arches.
> 
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
> 
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/mseal_test.c | 2 +-
>   tools/testing/selftests/mm/seal_elf.c   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 41998cf1dcf5..58c888529f42 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -3,7 +3,7 @@
>   #include <linux/mman.h>
>   #include <sys/mman.h>
>   #include <stdint.h>
> -#include <unistd.h>
> +#include <asm-generic/unistd.h>
>   #include <string.h>
>   #include <sys/time.h>
>   #include <sys/resource.h>
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
> index f2babec79bb6..27bf2f84231d 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -2,7 +2,7 @@
>   #define _GNU_SOURCE
>   #include <sys/mman.h>
>   #include <stdint.h>
> -#include <unistd.h>
> +#include <asm-generic/unistd.h>
>   #include <string.h>
>   #include <sys/time.h>
>   #include <sys/resource.h>

Still confused. Let's take a look at "microblaze".

arch/microblaze/include/asm/unistd.h
  -> #include <uapi/asm/unistd.h>

arch/microblaze/include/uapi/asm/unistd.h
  -> #include <asm/unistd_32.h>
   -> Generated during "make headers"

usr/include/asm/unistd_32.h is generated via
arch/microblaze/kernel/syscalls/Makefile with the syshdr command.

So we never end up including asm-generic/unistd.h directly on 
microblaze, but rather converts it (IIUC) to something else.

That will work as expected here?

-- 
Cheers,

David / dhildenb


