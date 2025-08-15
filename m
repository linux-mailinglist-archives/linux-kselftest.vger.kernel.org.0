Return-Path: <linux-kselftest+bounces-39104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AAB2801D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2CD603E9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B3301004;
	Fri, 15 Aug 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a621F5wb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6B2C3264;
	Fri, 15 Aug 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261883; cv=none; b=Ssc0NBDJFkX+4XJbMUY2fFODzGzqBrKKOMZ3VdArVklAxLG8+YFOpKEgjqNoa3NG4EWtudDo/v2mZTDg/we7Rm9HZRMUuBkF3214yK4PfLG/dMDiWXtEOFS0rj8G0k+T5Dn1SZCMlfbOsdY/wo0MwFUgHJgewvF4M69X2jZz51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261883; c=relaxed/simple;
	bh=gdXFBB295mBNGVsJgAbR1vP0UTgaD4mZH6tytmxhwnQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpuIfTxZzsxARCC8Ene5DxHChVo9JFcIOoJvAY6n6/1FvAwBFH62aVCkQyVudBxow7Ayi6puHg7V/W+9bWVVzmngLz36RmyMF3luiB/8j6KiD3zZgJXZvnobHyB/fP7lw8xA+gU5+4zWbScZ1Ejx1voXd6Nus74AJeKDoxoW43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a621F5wb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7347e09so306522366b.0;
        Fri, 15 Aug 2025 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755261880; x=1755866680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjeBt9GCyvF4EZYxj/on9NBWCQ0HQWui55lR9+/qkb0=;
        b=a621F5wbZ7lOLge1xfuqFv4jc0tNRqysphcZwt9hlYCIIuFH+3D82hNbcYhrEPZTbX
         8HrEIsnpWxIN06ZHqbltnXhhiPfUCfLqyRjUCOKTgZOuKn/qmiQrTX0PzzZ9Bm8GtU1i
         m82J/Cz6Qyhbr+WcgLmwUeF6lSvRgqq4WoPrW80JdhS4F9yAq0BCszMQIJsZP6jzkxPp
         e1vkD+CLdW3G94bKjLUAAKbtrU/9UY6qBCQhrmaykTAE8KxbZ0dd1KfeUhkkqOUIEp8n
         +t39q47kYwHd59hveWflMOoCdfOh7KZZhk8Wh2Xe2CQejyBo5FJrADSLoLrpVhS5hQnc
         W//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755261880; x=1755866680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjeBt9GCyvF4EZYxj/on9NBWCQ0HQWui55lR9+/qkb0=;
        b=c8v2TrcxsrBiXD7BdH8oZJ7ejl9P+l2v2xbvAvYOAqC2PdeCR6DvV5GVW6rYGvRH7N
         eAJp7HLrP7368QzZn+rQ+IxIBGezosgokiCK73kpFbo9w0Rq66ttOAGgAb4JURc5cG/f
         WPbLYTTZ6dwuDFctjOg7Nkw+IoLydTBACV/3c6aA2EmSzrkm1TPQtlQrAciJOw4n+ak3
         94S1FiLjpvUCbIv4967gPRXnFZjAPCslmX8Xb9vI5Ub7bTI8Oxmw4hn13BN+DZWB8lDd
         8EpCRsGsTlAvb5py0Vuq98S/lnese3bWvGRjJHeFLmW++aVCIEsHC6kxaHqvqryxqc/d
         /i7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoeINI+mIFDOs9Qg9t2w6R4EvbQFFbVUKsliuKrL713BtIXMl0fUp/ThVrsQKhKQlrQAi5Ijxl09hq72qPQToW@vger.kernel.org, AJvYcCVldQkL7nuwn+fBWJYBMI5/23E9nIBQzbvNWWdb3Yz1YFXA9D8rAKK/+isezLKMbl+1TC8jFIRKOullG9RG@vger.kernel.org, AJvYcCXrkA2d1JVXsZbuFPaeqo5DmM+fRRa8au2iXR0HiGu2iV4WVS6ZsgGkeXFW+vd1gv90oTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVW+dxTBXYOq86BxqAquiv5nk59jCuaJ/B68MdAQMeg8+rfZvU
	kGIbn+9o/xf1t48DFV6Tm2qa0nCG8f40T+l1H2GPF8h+FvzBcIOrGd28
X-Gm-Gg: ASbGncuYMRCsAeBu8phKgBbglEGGxIeGhIaALugP1iw3qbykhNAYzX9hLbRHb3siBiy
	cLrk+MW1HDRFVSTKuT+PIq7BOieHr0oHtVJ0a8sSV9wsmaRjuWRstBV5IWqvzL4AI5fQdy+DO5P
	XEmSRI4YDsn/GcTPjtey4qzY6zn/SfuPEyrap3YIdMYCrgeF0Bi2VcBpUE6UY2sYjjEws8tsgbf
	J6yGfZaFzybHWqJa5r085OQoh2ftWt2Ww/MyFydFub5aHATuHKCb1FIhaqkfIwJUUt8b93oGQ8a
	hiqTJvTWSwWO+Ogp7dRrwv9kpGAsI6KANgw6/vDnVSom+nZ7DQd5CKrmYDJL5oFC94cw1S72RQL
	u6wPo/mUowg==
X-Google-Smtp-Source: AGHT+IHG+YotOlvULIwtil5MjsG5WCy1TrbFl0wpQ0pvXdVu8f9TwR47lcgTFQCHv+6evIR/26cmdw==
X-Received: by 2002:a17:907:3e9f:b0:afa:2672:8c49 with SMTP id a640c23a62f3a-afcdc1d40cbmr180056266b.18.1755261879931;
        Fri, 15 Aug 2025 05:44:39 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9d3112sm1413205a12.9.2025.08.15.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:44:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Aug 2025 14:44:32 +0200
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v10 3/3] selftests/bpf: make usdt_o2 reliably
 generate SIB USDT arg spec
Message-ID: <aJ8rsK2-XcPXNX7h@krava>
References: <20250814160740.96150-1-phoenix500526@163.com>
 <20250814160740.96150-4-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814160740.96150-4-phoenix500526@163.com>

On Thu, Aug 14, 2025 at 04:07:39PM +0000, Jiawei Zhao wrote:
> usdt_o2 is intended to exercise the SIB (Scale-Index-Base) argument
> handling in libbpf's USDT path. With GCC 13 this reliably produced a
> SIB-form argument (e.g. 8@(%rdx,%rax,8)), but with newer GCC (e.g. 15)
> the compiler frequently optimizes the probe argument into a plain
> register (e.g. 8@%rax) or a stack slot, so the test stops covering the
> SIB code path and becomes flaky across toolchains.
> 
> Force a SIB memory operand in the probe by:
> * placing the base pointer into %rdx and the index into %rax using an
>   empty inline asm with output constraints ("=d", "=a") and matching
>   inputs
> * immediately passing base[idx] to STAP_PROBE1.
> * only enable on x86 platform.
> 
> This makes the compiler encode the operand as SIB (base + index8),
> which in .note.stapsdt shows up as 8@(%rdx,%rax,8) regardless of GCC
> version. A memory clobber and noinline prevent reordering/re-allocation
> around the probe site.
> 
> This change is x86_64-specific and does not alter program semantics; it
> only stabilizes the USDT argument shape so the test consistently
> validates SIB handling. Clang historically prefers stack temporaries for
> such operands, but the selftests build with GCC, and this keeps behavior
> stable across GCC versions without introducing a separate .S file.
> 
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  .../selftests/bpf/prog_tests/usdt_o2.c        | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> index f02dcf5188ab..e46d5743ad24 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> @@ -15,11 +15,19 @@ __attribute__((optimize("O2")))
>  int lets_test_this(int);
>  static volatile __u64 array[1] = {test_value};
>  
> -static __always_inline void trigger_func(void)
> +static noinline void trigger_func(void)
>  {
> +#if defined(__x86_64__) || defined(__i386__)
>  	/* Base address + offset + (index * scale) */
> -	for (volatile int i = 0; i <= 0; i++)
> -		STAP_PROBE1(test, usdt1, array[i]);
> +	/* Force SIB addressing with inline assembly */
> +	const __u64 *base;
> +	__u32 idx;
> +	/* binding base to %rdx and idx to %rax */
> +	asm volatile("" : "=d"(base), "=a"(idx) : "0"(array), "1"((__u32)0) : "memory");
> +	STAP_PROBE1(test, usdt1, base[idx]);

hum, I still end up with

	  stapsdt              0x0000002a       NT_STAPSDT (SystemTap probe descriptors)
	    Provider: test
	    Name: usdt1
	    Location: 0x00000000007674c9, Base: 0x00000000035bc698, Semaphore: 0x0000000000000000
	    Arguments: 8@%rax

disasm being:

	static noinline void trigger_func(void)
	{
	  76749f:       55                      push   %rbp
	  7674a0:       48 89 e5                mov    %rsp,%rbp
		/* Base address + offset + (index * scale) */
		/* Force SIB addressing with inline assembly */
		const __u64 *base;
		__u32 idx;
		/* binding base to %rdx and idx to %rax */
		asm volatile("" : "=d"(base), "=a"(idx) : "0"(array), "1"((__u32)0) : "memory");
	  7674a3:       ba 20 49 9c 03          mov    $0x39c4920,%edx
	  7674a8:       b8 00 00 00 00          mov    $0x0,%eax
	  7674ad:       48 89 55 f8             mov    %rdx,-0x8(%rbp)
	  7674b1:       89 45 f4                mov    %eax,-0xc(%rbp)
		STAP_PROBE1(test, usdt1, base[idx]);
	  7674b4:       8b 45 f4                mov    -0xc(%rbp),%eax
	  7674b7:       48 8d 14 c5 00 00 00    lea    0x0(,%rax,8),%rdx
	  7674be:       00
	  7674bf:       48 8b 45 f8             mov    -0x8(%rbp),%rax
	  7674c3:       48 01 d0                add    %rdx,%rax
	  7674c6:       48 8b 00                mov    (%rax),%rax
	  7674c9:       90                      nop
	#else
		STAP_PROBE1(test, usdt1, array[0]);
	#endif
	}
	  7674ca:       90                      nop
	  7674cb:       5d                      pop    %rbp
	  7674cc:       c3                      ret


I wonder we could also try to bring in Andrii's usdt.h [1] and overload usdt
arguments like outlined in the hack below (full code in [1])

we will probably need smarter and sustainable change, but you I guess you get
the idea

jirka


[1] https://github.com/anakryiko/usdt
[2] git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git usdt_hack
---
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
index e46d5743ad24..7bb098c37de5 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
@@ -4,6 +4,8 @@
 
 #include "../sdt.h"
 #include "test_usdt_o2.skel.h"
+#define USDT_ARGS ".asciz \"(,%%rax,8)\"\n"
+#include "usdt.h"
 
 #if defined(__GNUC__) && !defined(__clang__)
 __attribute__((optimize("O2")))
@@ -28,6 +30,7 @@ static noinline void trigger_func(void)
 #else
 	STAP_PROBE1(test, usdt1, array[0]);
 #endif
+	USDT(krava, test1, 1, 2);
 }
 
 static void basic_sib_usdt(void)
diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index 549d1f774810..960ebd6aa88b 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -403,6 +403,10 @@ struct usdt_sema { volatile unsigned short active; };
 	__asm__ __volatile__ ("" :: "m" (sema));
 #endif
 
+#ifndef USDT_ARGS
+#define USDT_ARGS __usdt_asm_args(__VA_ARGS__)
+#endif
+
 /* main USDT definition (nop and .note.stapsdt metadata) */
 #define __usdt_probe(group, name, sema_def, sema, ...) do {					\
 	sema_def(sema)										\
@@ -418,7 +422,7 @@ struct usdt_sema { volatile unsigned short active; };
 	__usdt_asm1(		__usdt_asm_addr sema)						\
 	__usdt_asm_strz(group)									\
 	__usdt_asm_strz(name)									\
-	__usdt_asm_args(__VA_ARGS__)								\
+	USDT_ARGS										\
 	__usdt_asm1(		.ascii "\0")							\
 	__usdt_asm1(994:	.balign 4)							\
 	__usdt_asm1(		.popsection)							\

