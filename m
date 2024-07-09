Return-Path: <linux-kselftest+bounces-13405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CC92C499
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 22:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A01F22F35
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305914F9C5;
	Tue,  9 Jul 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyGOcKJI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390913D63E
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557256; cv=none; b=bwZcvfqltle0E7ONvkSnVudiZv3HQLSrKQAaqkGVpk8FC3FRz38Zur3ayZqzLNTtINb/GxvzSrHTCVGvboi/s9GKTZbhj1S48vxyVLYbaYsBn/8WO4VZpMDNsHOMblSG+Zb9b5qRpDpihmARQDQ+e/f/Oraf94k6krFz4midDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557256; c=relaxed/simple;
	bh=oSSLuaVvZNJdsTu9BmDGZM0FU3LhjFv/rnMNrZfHTas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtHmkgAyzZ0VwtoPZVsl/znKKFUWIxPEopyn8pRfViwWSgqLJvOBUul0ST261UuGAuRC0vImXISgU81yrPsh/85FNkXvb1N6gXPKLEptHxI6nezDl+M9p8XpdQf7gVR/XMPrq92t7KGFCbM5Qki9N1sEsYW0U1sW/uJL6saDweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyGOcKJI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-38362117f6eso3064795ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720557254; x=1721162054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUXBhOV5n1K5bTAMQXFOdx48Z9Kt3voOMhmISQHx+NE=;
        b=gyGOcKJIgwxnJRP9XUJp4z/xr2FTd6IktdqgRjJc6oWnxUyNns+o46KoAt3GGg7EG8
         Iy6KsfARosW2G1CosWCBKNxT5nn7gRtj0bMSmxfpNOb766uF9X9OJddgiq+wJK619rpB
         FVXznVx+XrKqEJTuEPzVu2rj3YBkUlZdpOryA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557254; x=1721162054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUXBhOV5n1K5bTAMQXFOdx48Z9Kt3voOMhmISQHx+NE=;
        b=tM/USdpzTtbofVok1JW/tfh+nwl+3bdoOTSEn2zKnn/1X5aptxzgy4+MyLN316QnKs
         IQKagbiSnidwsyrIJJUhB7cvXRW9gnWEykaKPSGxORh7Gzq6LiCd9o2sVJKl8j8RtsnT
         VuSMwBhZapxS9TFYqmU+SVQ8h/p68L4cZ4GYYAIAksybyIdnnQgSvLWY+zwvXMsCRdw1
         H/yAZmgvZIaP0mFkxcF/pxrGjfBfhd22bJQ7hLJIbt+QTBlm+wvGG4/hwh1YFCuu4k3J
         lcs4/jSbZsEhFXaz7Stu6YjrkToc0olZQKJRkNookAVkFNyGuOZeKCZKR9tLydfP4eVK
         0iuA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bs0IoZHZfWFG7TCzfNatFFJvsBYL05t5iVT4hhVZ+fPgPnm6w/TGVtxsEO1n23WlMJKUL12/tdvPeo43Gx2UMA2aofoRebZIxgJXiLDe
X-Gm-Message-State: AOJu0YxdQI7JXC7JJCtgCvkov4/SI41onPXr4pOqjSD0Pdgvrg2hINaT
	yF7ChPxi//cBTmxkbV62dy7IjFaZj822EyqtRo0hJvRdWwuhS2QJpLhaJE/Bs5g=
X-Google-Smtp-Source: AGHT+IFnaltfqT9pdcjmDKQ5RL1R7ZLBWzlQHgI3b93HGvP83oo06ef5k6SFp1k0XTHt6xuyuG6s7w==
X-Received: by 2002:a92:cf41:0:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-38a53e8fc76mr36039665ab.0.1720557254426;
        Tue, 09 Jul 2024 13:34:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49c21c42sm5740615ab.48.2024.07.09.13.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 13:34:14 -0700 (PDT)
Message-ID: <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
Date: Tue, 9 Jul 2024 14:34:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/24 01:24, John Hubbard wrote:
> Changes since v3:
> 
> 1) Rebased onto Linux 6.10-rc6+.
> 
> 2) Added Muhammad's acks for the series.
> 
> Cover letter for v3:
> 
> Hi,
> 
> Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
> discussed yesterday [1].
> 
> As I mentioned then, this is a bit intrusive--but no more than
> necessary, IMHO. Specifically, it moves some clang-un-inlineable things
> out to "pure" assembly code files.
> 
> I've tested this by building with clang, then running each binary on my
> x86_64 test system with today's 6.10-rc1, and comparing the console and
> dmesg output to a gcc-based build without these patches applied. Aside
> from timestamps and virtual addresses, it looks identical.
> 
> Earlier cover letter:
> 
> Just a bunch of build and warnings fixes that show up when building with
> clang. Some of these depend on each other, so I'm sending them as a
> series.
> 
> Changes since v2:
> 
> 1) Dropped my test_FISTTP.c patch, and picked up Muhammad's fix instead,
>     seeing as how that was posted first.
> 
> 2) Updated patch descriptions to reflect that Valentin Obst's build fix
>     for LLVM [1] has already been merged into Linux main.
> 
> 3) Minor wording and typo corrections in the commit logs throughout.
> 
> Changes since the first version:
> 1) Rebased onto Linux 6.10-rc1
> 
> Enjoy!
> 
> [1] https://lore.kernel.org/44428518-4d21-4de7-8587-04eceefb330d@nvidia.com
> 
> thanks,
> John Hubbard
> 
> John Hubbard (6):
>    selftests/x86: fix Makefile dependencies to work with clang
>    selftests/x86: build fsgsbase_restore.c with clang
>    selftests/x86: build sysret_rip.c with clang
>    selftests/x86: avoid -no-pie warnings from clang during compilation
>    selftests/x86: remove (or use) unused variables and functions
>    selftests/x86: fix printk warnings reported by clang
> 

> Muhammad Usama Anjum (1):
>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp


Usama and John,

I am seeing checkpatch warnings in this series.

v4-3-7
WARNING: externs should be avoided in .c files
#210: FILE: tools/testing/selftests/x86/fsgsbase_restore.c:46:
+unsigned int dereference_seg_base(void);

ARNING: Consecutive strings are generally better as a single string
#156: FILE: tools/testing/selftests/x86/test_FISTTP.c:28:
+	"	fisttps	res16""\n"

WARNING: Consecutive strings are generally better as a single string
#165: FILE: tools/testing/selftests/x86/test_FISTTP.c:48:
+	"	fisttps	res16""\n"

WARNING: Consecutive strings are generally better as a single string
#174: FILE: tools/testing/selftests/x86/test_FISTTP.c:69:
+	"	fisttps	res16""\n"

WARNING: Consecutive strings are generally better as a single string
#183: FILE: tools/testing/selftests/x86/test_FISTTP.c:91:
+	"	fisttps	res16""\n"

total: 0 errors, 5 warnings, 32 lines checked

Can you take a look at these and see if they can be fixed. Send me
v5 with these fixed - I will pull these in for 6.11-rc1

thanks,
-- Shuah

