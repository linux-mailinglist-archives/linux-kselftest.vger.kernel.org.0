Return-Path: <linux-kselftest+bounces-9294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227B8BA360
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC891F21C41
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289B1B810;
	Thu,  2 May 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZNMdR4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A431B27D
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689602; cv=none; b=FFTuJudNBzZJjgFATwGEPttd0NE7yoaQ8m6rhb9jvzJ26WGxSve3C1lYv10S/yNz7+HGDkXqDPglzlTmYYEAe/wIfTzbWzMVbIu9kW0wgkxQTrDe/iD4klCkmocWAjct/gKXJPN+sUa6FVPd6JplKSCu8LDXICUoPrgDkttrPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689602; c=relaxed/simple;
	bh=ta50FdtwBu0y4pHKcn/Qfi03YFBFeN2nzNoSc2md4rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV9dxFW3+pcnnrKrraMKW8z4UtZofdyuysqe7un8+sjXd7A/Yu99Z1a2+TJ3qrTrIfWMvxq36rghEwA10I8ii4SdTwIojLWEG4Rj5Mfn3DMFFyPnSfb4hk+9iaIswKDeNMQby5JKCvEvESVTkhOFZVBH61Y7KREDyFv+mlhTArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EZNMdR4R; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed5109d924so7310912b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689600; x=1715294400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFKejRkpdUqALs7RRbss3x8E7ytYFe91um4evBhxt90=;
        b=EZNMdR4R1fAPR7pGphj709R6G7gi2z6bNZPvbZRzhk7gZk+oeQDCTuPuFptQ4OLLO9
         IGhmSrXKOQ1g5ZgH9NnrijOfsUDLskWQ7ROsdWSz1u7KoHPaKxEPQwMjCROVv0zAn2Oh
         aC7F4I171jlqK3dFmjMOa7+8fixT0C+o+Hlyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689600; x=1715294400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKejRkpdUqALs7RRbss3x8E7ytYFe91um4evBhxt90=;
        b=KWkOBZ2vf8+jkIcRKhxEd795Z/RGp7vd5od48UztRX8HFlaQ0vVIIN8S+b0p7qsHum
         YkrqItu5WqnsL/kUe8wdimhtpJbPjJVmG4NyVmrD/Zs/ZofrbMIgyY7zzsJRezsSzkV8
         S+pETHq3a02IIE5i3DKgKdB5j5BmLlBmxFIv+NsNivnj004vY2ydiJs1tMP7WITGbvO1
         YykmHtmpNjBD9m0xuMjX/V4C8YJvWDa18d9XuEfqJ1Yx8pasNYgIsOjHMS0EoGCQPRhE
         N7a89Wt5b+sX5xhmp714EFpcYISoZwqorD7ntaTclvYIyVcBaHf8CYsMbV0KJn/aSSlr
         ezuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzkeiE37TUKiXQOiq1Wva9FPYggW+XYJhpMifrIFr/sJzKNT+f9aYbBPUmCKyi6yCD9olv+qlo/HTRWB/PMIDGVByHolEUFX60y1+Rjmyn
X-Gm-Message-State: AOJu0YymWDGgsAyd5PrL+iwdqkRrqOYGap1iwDtTWdBjyqCglhz5liKN
	GxLJ9dDhjKNsQ+NH+vE3dobpNSaX+yaqoDPo32eah8H2lTQBKhiLozViy+/QWw==
X-Google-Smtp-Source: AGHT+IHZDYwJNE5fvscmVtdk5iGObl1CECGz4gO/Q2ayHOFmZuu6/FcbgJ5RUF+ig7m6xnqqjSb0qA==
X-Received: by 2002:a05:6a21:b10:b0:1ad:6e6:b4c7 with SMTP id lr16-20020a056a210b1000b001ad06e6b4c7mr898849pzb.46.1714689600376;
        Thu, 02 May 2024 15:40:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w11-20020aa7858b000000b006efd89cea71sm1784753pfn.84.2024.05.02.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:39:59 -0700 (PDT)
Date: Thu, 2 May 2024 15:39:59 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Edward Liaw <edliaw@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Bill Wendling <morbo@google.com>,
	David Hildenbrand <david@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [linus:master] [selftests/harness] 8092162335:
 kernel-selftests.sgx.make.fail
Message-ID: <202405021539.F08251ED5C@keescook>
References: <202404301040.3bea5782-oliver.sang@intel.com>
 <202405011330.85D66871E@keescook>
 <c9ad463f-cc67-44eb-bf94-449144e3078b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9ad463f-cc67-44eb-bf94-449144e3078b@collabora.com>

On Thu, May 02, 2024 at 11:33:17AM +0500, Muhammad Usama Anjum wrote:
> On 5/2/24 1:32 AM, Kees Cook wrote:
> > On Tue, Apr 30, 2024 at 11:02:36AM +0800, kernel test robot wrote:
> >> version: kernel-selftests-x86_64-c7864053-1_20240419
> >> [...]
> >> compiler: gcc-13
> >> 2024-04-29 15:02:59 make -j16 -C sgx
> >> [...]
> >> gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=none
> >> /usr/bin/ld: warning: /tmp/lkp/cct4g3SV.o: missing .note.GNU-stack section implies executable stack
> >> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >> In file included from main.c:21:
> >> ../kselftest_harness.h: In function ‘__run_test’:
> >> ../kselftest_harness.h:1166:13: error: implicit declaration of function ‘asprintf’; did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
> >>  1166 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
> >>       |             ^~~~~~~~
> >>       |             vsprintf
> >> cc1: all warnings being treated as errors
> > 
> > What environment is this being built in? "asprintf" should be available
> > via stdio.h, and "kselftest_harness.h" includes that (and _GNU_SOURCE).
> Sometimes the order of include is as following:
> 
> #inlucde <stdio.h>
> #define _GNU_SOURCE
> #inlucde <stdio.h>

Oh, ew. Yeah, I see what you mean.

> The _GNU_SOURCE wasn't defined the first time stdio.h was included hence
> the definition of asprintf isn't present. The second inclusion of stdio.h
> when _GNU_SOURCE is defined is ignored as it was already included.
> 
> This is being fixed in following series:
> https://lore.kernel.org/all/20240430235057.1351993-1-edliaw@google.com

I'll comment there. Thanks!

-- 
Kees Cook

