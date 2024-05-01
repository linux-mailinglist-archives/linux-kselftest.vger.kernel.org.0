Return-Path: <linux-kselftest+bounces-9245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048908B90A4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 22:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31161C215C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A37165FAB;
	Wed,  1 May 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fYjB+qp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE61649DD
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595580; cv=none; b=PUuh+anVt6U3MDbn8Gc/334TvFWNAf3Vk8nlsAW6dNG4SDKAGYDAXX7xkZiT+Rhexp30xj0vszIyNC4a6AJYrKody9jsEltS9xFvMHdtXx2erCRTJQ781bmzWLelqW6uW8uV+I7/RiycYQJS50ZvhPYWzPiKy1tAnTOTeKvvlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595580; c=relaxed/simple;
	bh=7u09dhiLhMiZkNIQVDdsM2vMvd2FkyZDIN6bSmYFGJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1cpm7K8Y1VFDu8cby9LSWlBRbqJap+5yDCmC38ThJhJR3blKQUEZx0+ER/OgWI/bl4FTEH78QpfaThJFatxGH9RflT6i4PGW1wexzQLIdjYQb41cDb2vFfVaCyW31GXTWc+mXc3Z6JEAoSosVayF3C197xBc7wWy5tbz/BlM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fYjB+qp5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso6643548b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714595578; x=1715200378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iqz8S2QdA0EJsKIz/4lOvCmgl9u2Epz/damWnWsK8Mg=;
        b=fYjB+qp52e2Oc1X6Hg4yUA5NHrmzmW1REOerc5b6410UY3wYuP/oAg4F2OIqMPGsDT
         GLoJk82eVmo6Wx5OIObMex/8aeshF6ucOnGCN3MlOi49n9cNifwdr8Y8OvR28SIFSPuw
         oWdx8jylqU6A1+27GcU8TL8/x8HT8qa/lHioA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595578; x=1715200378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqz8S2QdA0EJsKIz/4lOvCmgl9u2Epz/damWnWsK8Mg=;
        b=Er07qRgd1zvGv7rq/6v+UH74lRRqAuKMoI85moTiqER8mkI9+PPLpmOsymfnFwTEbC
         mGmEKsiA+stPpbxYEIhn+oEJJ8TK1GuXY742rB3QHPYLNIKQ6hCM+G6HpkEC/lcroPBg
         JGAu3Hv0SFOUX4Cvlp/COFVtnDPKSUoRAWEtuItVTSHq9wisqOrPnyQ6KT7DoYTldD7B
         4TlyYgayWhGFiTTRDsySTSm7xE6YSdkbWZCwydKdgBqzZOBnMcgrgNcP+1L1d5quRdPm
         lgumyMsqiDUnUZJU07o204Jk/LnaggM3AJRP6GccLi3kJKoKP526W6JnVvRQDXs0EaDE
         1C2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJhzDopjyPEec613TrY78aCzbQ5cferLC/JvTL9p07nmEpYDPLGpwC4+nYmsRKI/1QIjro/b5Yr8HmwG5To4DXiaklYxB5izO6TPRxYZ+s
X-Gm-Message-State: AOJu0Yx9GAtleY9U0ZFrSXpHhtZM3QKE28ZiYmG1OcS5iZmTtctN2Tn4
	/hzH8COaDc0rEvc8ReuO3bEJxEndSx6emfUanv8A1UZCLPn8nPllqxUM2BLz9w==
X-Google-Smtp-Source: AGHT+IGqPLrt1qdSnEoH66ufcC64x4kO88+Homj7/Uv9EXsQgLfCXVYl8bDOr9JM5JLUL69tbhsw2A==
X-Received: by 2002:a05:6a20:7fa4:b0:1a7:a3ee:5e4a with SMTP id d36-20020a056a207fa400b001a7a3ee5e4amr3685712pzj.33.1714595578310;
        Wed, 01 May 2024 13:32:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gq41-20020a056a003be900b006f0da46c019sm20801345pfb.219.2024.05.01.13.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:32:57 -0700 (PDT)
Date: Wed, 1 May 2024 13:32:57 -0700
From: Kees Cook <keescook@chromium.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Edward Liaw <edliaw@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
Subject: Re: [linus:master] [selftests/harness]  8092162335:
 kernel-selftests.sgx.make.fail
Message-ID: <202405011330.85D66871E@keescook>
References: <202404301040.3bea5782-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202404301040.3bea5782-oliver.sang@intel.com>

On Tue, Apr 30, 2024 at 11:02:36AM +0800, kernel test robot wrote:
> version: kernel-selftests-x86_64-c7864053-1_20240419
> [...]
> compiler: gcc-13
> 2024-04-29 15:02:59 make -j16 -C sgx
> [...]
> gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=none
> /usr/bin/ld: warning: /tmp/lkp/cct4g3SV.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> In file included from main.c:21:
> ../kselftest_harness.h: In function ‘__run_test’:
> ../kselftest_harness.h:1166:13: error: implicit declaration of function ‘asprintf’; did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
>  1166 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
>       |             ^~~~~~~~
>       |             vsprintf
> cc1: all warnings being treated as errors

What environment is this being built in? "asprintf" should be available
via stdio.h, and "kselftest_harness.h" includes that (and _GNU_SOURCE).

-- 
Kees Cook

