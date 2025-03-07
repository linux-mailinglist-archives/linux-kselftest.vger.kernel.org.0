Return-Path: <linux-kselftest+bounces-28494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39256A56D62
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837F218956AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1CB23958F;
	Fri,  7 Mar 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gey9rza4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9923817D
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364290; cv=none; b=OvVESItP0UA9JRkHiA0WTdn9xHvInIW4bivGaHCOnbGT0FBzOuZMi6FwJBpkouOQaH4zZlUzmAjXdLQL6koOUhaFyZjjPqkUy2z+APRSrjpo/AhLkIf4c8t1B02fezsH7mYBTW3m2FjrkN1n5heJ9E/AU1m+/vdw1EL1hWHNcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364290; c=relaxed/simple;
	bh=oIuvMztFc5dz78HIibf1fY/IyZ83+m0B2/3Xpj3FtHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHnwIVQGm8SbOPHyQkUebIKLao8AAszvXRp7xu5Fw1uPqbBuobondjLfwmSPMDfMDTkXzPtLFQxS/9TCeWf7+J6y6wBUIf12LLqf3/P4IvYRMlz/hnx4fzDIUMiMv+uDGdoxbAg3Ks/rA8TJj+/1E8R/4FmTvu7QDrWk0rfOn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gey9rza4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bdc607c16so16146655e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741364286; x=1741969086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCwkI3mTb9TuFtkjp33h0Opv3nnmlBn/Bi8OthUIuag=;
        b=gey9rza4RcHYa7T3bLuwBu6cn2AV9+xAsddLHTDHna8c8ZuIqmbWtwTV1h9UBrwat5
         fR64fx8y++MfFdYy+BRkGh3ipp4ZS89V81YXkEzHjeTDBmEUuLL2mOHUsmnf/X0mQB+U
         CSOXg2FEKqYS5AYg8ubodum/ipk/E/9PcIO5e7WYpUjV4hhgKmWnJR7H9trQHHrfeelV
         C7cS7UDkL9IoI3YIY2L9ubVoL4cE04AHknCYAgJCXTZNLo1SGYjxckaHPHzCgFkfAg6r
         MGdiSw4PNAh6pPGl7Aibiq3prfEzuqcgYXb92ftAW/DXh6BSNkL47kg8hhM81u1ixIgq
         znmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364286; x=1741969086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCwkI3mTb9TuFtkjp33h0Opv3nnmlBn/Bi8OthUIuag=;
        b=IG5ywnpOFetOMTw4TZCmMjlB3jydOCH6pY8Opj8rZhHi/Ny+pGWfWOlgDqwfVjuXxb
         EyiQV0D1ZLP4zdm/AfaDb0xugxldnQfO0jrURwR+OHm5y5ZGe0q1o41F1F/EhXuxVYb6
         yy59sedXwq4cMPua+j2Z9FarjbL/2oNbHDVG6fNBHBSr0prdbwsMueyaHUqRtw/1Zbwc
         deJd+Fedd7rw5jIv1aLKlIz+fALBbRUsn4A/pO7EB/2EF5ojABMWbUE+6g2Ww20v1HIm
         JHX/jAl3MGOCFygsJZYFVlv/9oOAIhK9HsOGgA+xaXpyeE6VbbZYvmHOVqdH10cWWdTZ
         YSgA==
X-Forwarded-Encrypted: i=1; AJvYcCXV98oOBldw2u7bz2ROyiH3H3LXZ3wV2tb1Sb8QVaJ3n7P+s409YKWMfYRPCP0sutUNKGsVmwDBj1J5EwkqsNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtImQeIKA6e9F+R5GrOQXXpM3klHIWP5u3R8dgORjk41xEq0N
	ANAgn5F1r1UvLRFs/AA4Ez9REsyYFV+3oC3e7mYPdDe3sysRTpIHBna40u+/eU0=
X-Gm-Gg: ASbGncs4B88cOpQFBpq2vLPB8yaExGnRyDcJuYvNZhk/tQIKG8fR26sdgis+Ffbep5T
	WpUFBawm8eUe3BzFZXphMkroJw+trxGodynj0AaNLuyf//WcZcfH4Uu0UPwW6f2hcRKAw2mChnN
	06+Y2pa1q7+GyPHlklbDRNvqimtjqgUOqUGyoixRj7WPjTR6K4/VSwLsw283k3fCufYnZEyB3Z3
	irfKMP/9hxGLN4TCFlpb4B/jrrFP3wC37+LR4QrUDclKNmcT8y2kpPo8QUneAebcHHB6Qx1kNx8
	VKeqummGWX15amn8rwCyg883/uFWpLPAOnK84hBMMiys8jc=
X-Google-Smtp-Source: AGHT+IGMBR2Hp2OA9Ih2wlEa/vbwb3VUa33IIHpQ9OS7HGryoxL0uxxYnq5ViotX8t1NqsEHP3nLBw==
X-Received: by 2002:a05:6000:1867:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-39132d885bcmr2413534f8f.29.1741364285897;
        Fri, 07 Mar 2025 08:18:05 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm5897036f8f.16.2025.03.07.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:18:05 -0800 (PST)
Date: Fri, 7 Mar 2025 17:18:03 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: crng init: was: Re: [PATCH v5 2/3] printf: break kunit into test
 cases
Message-ID: <Z8scO-LsAWxdYIfJ@pathway.suse.cz>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-printf-kunit-convert-v5-2-5db840301730@gmail.com>

On Fri 2025-02-21 15:34:31, Tamir Duberstein wrote:
> Move all tests into `printf_test_cases`. This gives us nicer output in
> the event of a failure.
> 
> Combine `plain_format` and `plain_hash` into `hash_pointer` since
> they're testing the same scenario.
> 
> --- a/lib/tests/printf_kunit.c
> +++ b/lib/tests/printf_kunit.c
> @@ -178,7 +179,7 @@ test_number(void)
>  }
>  
>  static void
> -test_string(void)
> +test_string(struct kunit *kunittest)
>  {
>  	test("", "%s%.0s", "", "123");
>  	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
> @@ -215,29 +216,6 @@ test_string(void)
>  #define ZEROS "00000000"	/* hex 32 zero bits */
>  #define ONES "ffffffff"		/* hex 32 one bits */
>  
> -static int
> -plain_format(void)
> -{
> -	char buf[PLAIN_BUF_SIZE];
> -	int nchars;
> -
> -	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
> -
> -	if (nchars != PTR_WIDTH)
> -		return -1;
> -
> -	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> -		kunit_warn(kunittest, "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
> -			PTR_VAL_NO_CRNG);
> -		return 0;
> -	}
> -
> -	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
>  #else
>  
>  #define PTR_WIDTH 8
> @@ -247,89 +225,44 @@ plain_format(void)
>  #define ZEROS ""
>  #define ONES ""
>  
> -static int
> -plain_format(void)
> -{
> -	/* Format is implicitly tested for 32 bit machines by plain_hash() */
> -	return 0;
> -}
> -
>  #endif	/* BITS_PER_LONG == 64 */
>  
> -static int
> -plain_hash_to_buffer(const void *p, char *buf, size_t len)
> +static void
> +plain_hash_to_buffer(struct kunit *kunittest, const void *p, char *buf, size_t len)
>  {
> -	int nchars;
> -
> -	nchars = snprintf(buf, len, "%p", p);
> -
> -	if (nchars != PTR_WIDTH)
> -		return -1;
> +	KUNIT_ASSERT_EQ(kunittest, snprintf(buf, len, "%p", p), PTR_WIDTH);
>  
>  	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
>  		kunit_warn(kunittest, "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
>  			PTR_VAL_NO_CRNG);
> -		return 0;

I have simulated the not-yet-initialized crng and got:

[   80.109760] printf_kunit: module verification failed: signature and/or required key missing - tainting kernel
[   80.114218] KTAP version 1
[   80.114743] 1..1
[   80.116124]     KTAP version 1
[   80.116752]     # Subtest: printf
[   80.117239]     # module: printf_kunit
[   80.117256]     1..28
[   80.120924]     ok 1 test_basic
[   80.121495]     ok 2 test_number
[   80.122741]     ok 3 test_string
[   80.123498]     # hash_pointer: crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[   80.124044]     # hash_pointer: EXPECTATION FAILED at lib/tests/printf_kunit.c:256
                   Expected buf == "00000000", but
                       buf ==
                       <28><5f><5f><5f><5f><70><74><72>
                       "00000000" ==
                       <30><30><30><30><30><30><30><30>
[   80.125888]     not ok 4 hash_pointer
[   80.129831]     ok 5 null_pointer
[   80.130253]     ok 6 error_pointer
[   80.131221]     # invalid_pointer: crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[   80.132168]     ok 7 invalid_pointer
[   80.135149]     ok 8 symbol_ptr
[   80.136016]     ok 9 kernel_ptr
[   80.136868]     ok 10 struct_resource
[   80.137768]     ok 11 struct_range
[   80.138613]     ok 12 addr
[   80.139370]     ok 13 escaped_str
[   80.140054]     ok 14 hex_string
[   80.140601]     ok 15 mac
[   80.141162]     ok 16 ip4
[   80.141670]     ok 17 ip6
[   80.142221]     ok 18 uuid
[   80.143090]     ok 19 dentry
[   80.143963]     ok 20 struct_va_format
[   80.144523]     ok 21 time_and_date
[   80.145043]     ok 22 struct_clk
[   80.145589]     ok 23 bitmap
[   80.146087]     ok 24 netdev_features
[   80.146572]     ok 25 flags
[   80.146980]     # errptr: crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[   80.147412]     ok 26 errptr
[   80.148548]     ok 27 fwnode_pointer
[   80.149086]     ok 28 fourcc_pointer
[   80.149090]     # printf: ran 448 tests
[   80.149099] # printf: pass:27 fail:1 skip:0 total:28
[   80.149102] # Totals: pass:27 fail:1 skip:0 total:28
[   80.149106] not ok 1 printf

=> One test failed even though vspritf() worked as expected.

   The "EXPECTATION FAILED" message was a bit tricky because
   it printed "<28><5f><5f><5f><5f><70><74><72>" instead of "(____ptrval____)".

   Two tests succeeded even after a warning message which would make people
   to investigate it.

I suggest to rather skip the test in this case. Something like:

	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
		kunit_skip(kunittest,
			   "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"\n",
			   PTR_VAL_NO_CRNG);
	}


It produces:

[  140.555055] KTAP version 1
[  140.555413] 1..1
[  140.555796]     KTAP version 1
[  140.556115]     # Subtest: printf
[  140.556450]     # module: printf_kunit
[  140.556459]     1..28
[  140.557757]     ok 1 test_basic
[  140.558072]     ok 2 test_number
[  140.558693]     ok 3 test_string
[  140.559278]     ok 4 hash_pointer # SKIP crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[  140.560949]     ok 5 null_pointer
[  140.561257]     ok 6 error_pointer
[  140.561880]     ok 7 invalid_pointer # SKIP crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[  140.564159]     ok 8 symbol_ptr
[  140.565248]     ok 9 kernel_ptr
[  140.566346]     ok 10 struct_resource
[  140.567642]     ok 11 struct_range
[  140.569141]     ok 12 addr
[  140.570395]     ok 13 escaped_str
[  140.571407]     ok 14 hex_string
[  140.572337]     ok 15 mac
[  140.573572]     ok 16 ip4
[  140.574712]     ok 17 ip6
[  140.575743]     ok 18 uuid
[  140.577164]     ok 19 dentry
[  140.578248]     ok 20 struct_va_format
[  140.579400]     ok 21 time_and_date
[  140.580507]     ok 22 struct_clk
[  140.581706]     ok 23 bitmap
[  140.582739]     ok 24 netdev_features
[  140.583808]     ok 25 flags
[  140.585274]     ok 26 errptr # SKIP crng possibly not yet initialized. plain 'p' buffer contains "(____ptrval____)"
[  140.588403]     ok 27 fwnode_pointer
[  140.592141]     ok 28 fourcc_pointer
[  140.592758]     # printf: ran 408 tests
[  140.593219] # printf: pass:25 fail:0 skip:3 total:28
[  140.593706] # Totals: pass:25 fail:0 skip:3 total:28
[  140.594280] ok 1 printf

Best Regards,
Petr

