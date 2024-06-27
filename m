Return-Path: <linux-kselftest+bounces-12876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EAC91AEDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C731F22739
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530819AA7C;
	Thu, 27 Jun 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvWHFLk3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835ED13F441
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512089; cv=none; b=DRKbkbGKqPKr8tj1b20euhcaEbu86dWIcKxaysvBVPa64j1BYqeB4Tb6XNhZmNYShEHik47ux84weDp4QAXsHeRzPjArpu+KR9DlLTtLSdBs5JcM75fRsRiPx+Io03v0ircNXGg3s+YE0ZmIzkLLiHEo9hqeL80sH/Pf6Vpiu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512089; c=relaxed/simple;
	bh=2cK5AxOV9l+UMy4wzDeUFqdeQNcGCtOHicEYrQngggg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxE4Kq1md5Ppv4mwHLvuXQvx19U9KUnPM+3Hxuyd9dV47dKRYZx8W4VId5izCdzxChbZYzouCq0IpHET77CmrWRy+JZO1m7U5KGoCvuKGInsiIwrGbolv3CeRo7eKP1yLhTABTvL4JkbzWfQlF+eDMxIyfgo0hLisj+RNNCD5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvWHFLk3; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3d395dcf9so6276739f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719512086; x=1720116886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=NvWHFLk322QjFP8qOJRESXM6xm2Tl1paYsivSxBrsuRv4XPPLEHRpBr3SbUvjoSBAv
         hkI+AXCNnrxAs/Kjpx/i1XK0NFM4f5mCxEccVHn+ZfxAQrB1FV9EkQP0x+Uw4j+6VhdV
         Es71LgBhBZkyusw3VXL4hNkGIAnYT+axy6oS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512086; x=1720116886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=YKzyfWlDzYokKcohpyA+TdaxxOUtLqHPYq1IjnULjU9q89Rq5x4y6cbq3Nt+GBh1cD
         bgRbci6gt7SkTKwf3ys7yM0e7J06RfOgzhoiwBrdjvSC+1slmnaPxlP2NgvLVU1/UVs/
         CWjsANcntI5s1hw38YWy6YQOl5aCVVBCPH1l8FRanJIpRAHVv6X97LCcgiywwKC+Pryr
         8LDZEOrObMXGTt3puqhLtLb0RQsUmN9LgWxel3wbRj/wo84MGJ9N7LQOt52ue7KtN/HV
         3xToNqXwpXbau7qXQ5ZsYUo6TmhaVg2NeAOXLwMYJVyzuHizBjBrZLrFabd0ZQxu5DsM
         Ss/A==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ecN7Qhe+Mz4N0qy4Kh4P/lMf7zulKnODY5INXjgtbmpcbbxGf5taKgPQZg1VoOhnNHEhxNrWGIphgt+bTS1jgjFkLztFfGxiZICKv4i
X-Gm-Message-State: AOJu0YzOvMdQsoUfS6yvC8S1tSYlSACbAPaGMMYr3zl54Apa6eSvvH6j
	oDJKIY9lfXL/I+zO8QGiJa91olK356CsQXMR6LAMfkMzNMX/NKpaVuSacFkRokM=
X-Google-Smtp-Source: AGHT+IFUG5O1SrOnPJRNTLD5kODnctBl78frxmuDBYLRyoOk4cGdplKcVn3bQ6BYVahLxGENnJxatg==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1350449739f.0.1719512085576;
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9d654sm2994739f.13.2024.06.27.11.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Message-ID: <af55d4ae-fefb-4235-a175-83e947ec4c25@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:14:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] selftests: Centralize -D_GNU_SOURCE= to CFLAGS in
 lib.mk
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com,
 seanjc@google.com, kernel-team@android.com, linux-mm@kvack.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625223454.1586259-1-edliaw@google.com>
 <20240625223454.1586259-2-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625223454.1586259-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 16:34, Edward Liaw wrote:
> Centralize the _GNU_SOURCE definition to CFLAGS in lib.mk.  Remove
> redundant defines from Makefiles that import lib.mk.  Convert any usage
> of "#define _GNU_SOURCE 1" to "#define _GNU_SOURCE".
> 
> This uses the form "-D_GNU_SOURCE=", which is equivalent to
> "#define _GNU_SOURCE".
> 
> Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
> "#define _GNU_SOURCE 1", which is less commonly seen in source code and
> would require many changes in selftests to avoid redefinition warnings.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/exec/Makefile             | 1 -
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   tools/testing/selftests/intel_pstate/Makefile     | 2 +-
>   tools/testing/selftests/iommu/Makefile            | 2 --
>   tools/testing/selftests/kvm/Makefile              | 2 +-
>   tools/testing/selftests/lib.mk                    | 3 +++
>   tools/testing/selftests/mm/thuge-gen.c            | 2 +-
>   tools/testing/selftests/net/Makefile              | 2 +-
>   tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>   tools/testing/selftests/proc/Makefile             | 1 -
>   tools/testing/selftests/resctrl/Makefile          | 2 +-
>   tools/testing/selftests/ring-buffer/Makefile      | 1 -
>   tools/testing/selftests/riscv/mm/Makefile         | 2 +-
>   tools/testing/selftests/sgx/Makefile              | 2 +-
>   tools/testing/selftests/tmpfs/Makefile            | 1 -
>   15 files changed, 12 insertions(+), 15 deletions(-)
> 

Andrew,

I am seeing merge conflicts with mm and exec tests. Might be
better to have you take this through your tree?

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


