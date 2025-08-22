Return-Path: <linux-kselftest+bounces-39678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0675B31923
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A63A1D232CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7592FE579;
	Fri, 22 Aug 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZqCNiv0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54F2FC01D;
	Fri, 22 Aug 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868681; cv=none; b=iDkbHIMJJTvhYh0VYU0z1ZsjKpwXTZg0PltpKExiOyyP30lwjpUAgUFxgdpJP9RH0HxxSo7co4pVEiOobyEEEGHS3/KVP8WkQanyKEBKJwXzZk8i5oIEjYae8Q4Wy2IV/Qik5keBSWXSc9OznbhkcPzYvq5epS/H6iznr0T4hYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868681; c=relaxed/simple;
	bh=8BceDHCSEkT6+b6gCRUCPeiwwyxIaZuBlektNFWp3PE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgitTgil7sbHXySlko6wioewhHTsrHxexu0TktVkiQ3J2A54XOaLJAEyB6QDfRFhF3Qk6l5/FnnMfdGgdgkge42xW4lUd/TWVL4vnSKQvsuGwQRY4d2qk62/ibov2wZg2Rsqssoaff1osnJwPF1ymJZsOLkdJOCrmMKNcuBNhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZqCNiv0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb79f659aso345297066b.2;
        Fri, 22 Aug 2025 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755868678; x=1756473478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef2s1qUVb8t3y6YVt3KXh9UEYYOXOefDjOMclrHb6SQ=;
        b=kZqCNiv0JPKl0aWras1UJb+BdU/AqKqqCpImaVNYnU59WX+rs+fVmkNlNE93wNjE5v
         ADJjqjNcv4Pz7oPUEFb6MqiNYtoJqnXqEBA0JK+1jqRXiqtEKGcSCfaN9v7/YQDX8/lw
         ar2UTUCFh+D+DzVwyBsMnQhqC7wxiRuf9EI80M00qG2FrIp9E42vs8P6RieYYgJ1e8g3
         KDnuW9ZXm0B8h3zmn3qJtC5WBdkCeG9biEyiM2lr+wQBLuavnU2sSAfKgFgXf6wwry0J
         UeKji7t08zqcY9+CPX/IEsV5QB8pFDDEH19Bc4D+cXLymzWDQLayTsHSTK/ovlmN/01M
         b5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868678; x=1756473478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef2s1qUVb8t3y6YVt3KXh9UEYYOXOefDjOMclrHb6SQ=;
        b=Lpy1rixGbRHcVI0ecBJjaAcmv995HgPe5XxsTp2EDOlKwzx88BvnnlMm6rEVYCDrK6
         2vghXq9Jzbp1yhc/LWwVmASuTY6KBi9h9qkL9RHNOWYM16D9F2WaDLuK5SIp5ezmqLN1
         +f80DOKOQ0aR0Rz5oFCDRXzwdr3DK5BhgVwWYN0MUt715nPjRm5XdxE3AHkjCo6nXTt5
         3c0XBtEzfcVUCJK8rCvQ92plt+Ihs8tPYWysBCwhePbj8aJyf7cdmqFsi3Hq6acHPm+B
         oIv8Ddnvh5qyQ3k0/qAxb1TAd5t+LULVPb0G7vmN6wNZtI5WKqbHpS8V0jHR5T5RmHN4
         SBBg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Oyw5BTsTGJB7IOpY5sqiWiMGZcF1fpNL3dKxwnPqWlEnwuwTeCmNQt+lSPIsw71WcTOQvBB7kUDtYwye@vger.kernel.org, AJvYcCVcTKjwzRrybYIVayzprp6Vs7qRvYZF5T1NaSimRKss5b7kqVAJweHw60xf9KxLj/fp3yc=@vger.kernel.org, AJvYcCWayK86M94BRKRuaCi4LLxoX60d3OwHX5rbjvhQrmV7Guwi376D9Xf2wg2tSZA99z4/K/8iGHeNSyvzcvaqRoej@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KaYXUlONTXEmY2iXtQKmxyYyKI584j1e1uGAsl9RN6reb/Db
	//QeQXRpMfShoBV3691e/+2vqZEE8TFifih0TCPjgEzJqiPrqwlBKbmQ
X-Gm-Gg: ASbGncvEIbsSQgwomncxTvm5o3c22kE5oLZMTaQRTeYXOg3Rm5pWVRmTrmC6sjlqVz/
	IquvRteHiMKISd704X4Kypsju6/eS6noGZKTiQlOiFcM8SRsCRaAJTNJS38/2MOzn7X1HceJkE3
	sIJfZVgZzblKnhzKlmZzw2LL4BtGTzCUhNAVNhkszM4um9ig/AgMxxcJ8RUm/91i+5gQyMUSguX
	IKZ0+2D9D5G6QCos4QPCE67AT/wQoI11yOrmxsLpOTds2eLFZ72P9Tx1OKsob/hStAJWkzovjx6
	Z4hUJyLpPvAQfq26U8wn9f4Iy4CZdMLhaNZACH7BNaACf07Zp1lPgX/rDEZl3Y26+fqUny2Lmk/
	19Kc0PdQN3unfM2pUQIgq
X-Google-Smtp-Source: AGHT+IGGQ0DK3Isbf1Y0wD0FGWyi9eFO0iGotbSbhsvx2bYMCa7vTs8mEzSYbaprcB3B2bsC1ibX3g==
X-Received: by 2002:a17:907:6096:b0:af6:341a:5ec4 with SMTP id a640c23a62f3a-afe29031d27mr279043366b.16.1755868677461;
        Fri, 22 Aug 2025 06:17:57 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded309f3csm599595866b.32.2025.08.22.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:17:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Aug 2025 15:17:55 +0200
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v12 0/2] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
Message-ID: <aKhuA0xklnLCIbsv@krava>
References: <20250821152713.1024982-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152713.1024982-1-phoenix500526@163.com>

On Thu, Aug 21, 2025 at 03:27:10PM +0000, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
> 
> The current USDT implementation in libbpf cannot parse these two formats,
> causing `bpf_program__attach_usdt()` to fail with -ENOENT
> (unrecognized register).
> 
> This patch series adds support for SIB addressing mode in USDT probes.
> The main changes include:
> - add correct handling logic for SIB-addressed arguments in
>   `parse_usdt_arg`.
> - add an usdt_o2 test case to cover SIB addressing mode.
> 
> Testing shows that the SIB probe correctly generates 8@(%rcx,%rax,8) 
> argument spec and passes all validation checks.
> 
> The modification history of this patch series:
> Change since v1:
> - refactor the code to make it more readable
> - modify the commit message to explain why and how
> 
> Change since v2:
> - fix the `scale` uninitialized error
> 
> Change since v3:
> - force -O2 optimization for usdt.test.o to generate SIB addressing usdt
>   and pass all test cases.
> 
> Change since v4:
> - split the patch into two parts, one for the fix and the other for the
>   test
> 
> Change since v5:
> - Only enable optimization for x86 architecture to generate SIB addressing
>   usdt argument spec.
> 
> Change since v6:
> - Add an usdt_o2 test case to cover SIB addressing mode.
> - Reinstate the usdt.c test case.
> 
> Change since v7:
> - Refactor modifications to __bpf_usdt_arg_spec to avoid increasing its size,
>   achieving better compatibility
> - Fix some minor code style issues
> - Refactor the usdt_o2 test case, removing semaphore and adding GCC attribute
>   to force -O2 optimization
> 
> Change since v8:
> - Refactor the usdt_o2 test case, using assembly to force SIB addressing mode.
> 
> Change since v9:
> - Only enable the usdt_o2 test case on x86_64 and i386 architectures since the
>   SIB addressing mode is only supported on x86_64 and i386.
> 
> Change since v10:
> - Replace `__attribute__((optimize("O2")))` with `#pragma GCC optimize("O1")`
>   to fix the issue where the optimized compilation condition works improperly. 
> - Renamed test case usdt_o2 and relevant files name to usdt_o1 in that O1
>   level optimization is enough to generate SIB addressing usdt argument spec.
> 
> Change since v11:
> - Replace `STAP_PROBE1` with `STAP_PROBE_ASM`
> - Use bit fields instead of bit shifting operations
> - Merge the usdt_o1 test case into the usdt test case

hi,
I can see patchset v12 twice with different stats.. this one's the latter,
but you might want to resend with new version

jirka


> 
> Jiawei Zhao (2):
>   libbpf: fix USDT SIB argument handling causing unrecognized register
>     error
>   selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover
>     SIB handling logic
> 
>  tools/lib/bpf/usdt.bpf.h                      | 47 ++++++++++++++-
>  tools/lib/bpf/usdt.c                          | 58 +++++++++++++++++--
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 44 +++++++++++++-
>  tools/testing/selftests/bpf/progs/test_usdt.c | 30 ++++++++++
>  4 files changed, 170 insertions(+), 9 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

