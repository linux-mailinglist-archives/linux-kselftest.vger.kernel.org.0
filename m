Return-Path: <linux-kselftest+bounces-22891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F69E6021
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 22:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC64E166344
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244731BC9EE;
	Thu,  5 Dec 2024 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iWc+FMhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82F18FDCE
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434265; cv=none; b=JyvD/73SUfOjhPngMNVyHnL17OxBDVcZx6N+yOKqO7ahMjGL53qZdERVitMPXw5gsHNGl+uk16jAKzqejS/aiyLvTd0/CEFhsof0Lq9pJZpJeTpLvWBbzZRguJ7QJDDUOyb5Rkak2W0/ZurAPhMykD4q+5apwYUXGlZnKkZBcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434265; c=relaxed/simple;
	bh=hD2+1vy6RYUSGnMZ0ttXTvGPWWJm2B1GfGDmqcwKzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKuWF3DyLyihRPEy/aY5MJANpmSDch+6D/e1rlvGnYFEgNdJmBR7bGG91eE5zSLVuhs4BvOrfm+I4m8Q0tBXrRqcp5BuGCArYmWzRIxG+g+PfHXrWkSTE8C69iA6MkTwTJv1TnJ5YQqAfnmYpcj1GJJ7goH/whH2AgTU/VbCxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iWc+FMhK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7252fba4de1so1645503b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434262; x=1734039062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swrB1X9v62XhnQOwomPfhFuZeA3/Dy25MIYnjNAQ9Aw=;
        b=iWc+FMhK1Fp/UVnkXHVvSw7/XPzUUyOvovm1qWMPTCSjNFUfqn2oC3Vhy4I8LGx2hQ
         zoOmVYnwG1Xya9ZjHC71h43vf0W1OOcmvlz2Pj00ipS9p3s/1U2yOUBjwfHiBHzFadoq
         j/YCCkCeq2cSZ+9SHn5D1ZOkNN3Y3Ip38f0DR3OfokW2i8w3pBA69CC1FksMhSJvP28O
         5tz2pKaetiQ1j5fX1XmSTiVRLcSKSsI/7e6VHtCgLi/ZGNN8vSrzpwjYk0Jx9iBmjsRU
         1WQmUwgOEZjhOg478fCdD47f8Nu+HtUtr9NQpovnmiz4/6YuFAFnoIQIU0yAcPYtPCrX
         NugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434262; x=1734039062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swrB1X9v62XhnQOwomPfhFuZeA3/Dy25MIYnjNAQ9Aw=;
        b=a7Kcuqe6bMqlniCfxZnjkROr+LcdNr5CG02GJwsN7Yi5fMiyHPtCQVf9Hx+sQRSFlE
         uo/atqmcN5AYvjpNzauZc2USvxuQ6ay98/3HBCh8kcd9+SO6xVvsRJfeDHf1py57VuFe
         ZlhVK/neCbOSl8BEoArGzv7aOnrKB1F88aw8KPZqHbhPGg6NiOQvyixJYyjvefgy+mwJ
         t3VsU7Je3G4qi94ajwh3+JBCY8wSUxxO2A2cd++WIu/vPyRFVKMzmMpm8sIpiUQ8H4BC
         tlgXkV9Yjvy5Z4WoptJsR2psPKJjfYUaFIwsDHhpEAYz40p7zc4ZlGyaP5ajrc33hesc
         QiiA==
X-Forwarded-Encrypted: i=1; AJvYcCW14dvTp+4e+ghMYiXySRXvJ/Pt8KEIfDTVKDodkXCb9BtjZLeNjXrjnq9AXk5yW3mcr0L/wHBB4a7FL84CJqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mp/BbhTBuh6PgLbj6Zthiowi3R4dE/3e9hG3rAL3T2N+7R/d
	I/Aizu+66T8gYNsRWDwteFKLV4SWxB13UoDhU2ReMxawSJCCpY/wtz6vC4F8QZ4=
X-Gm-Gg: ASbGnctislwkteEBD7W4wiO3LlUAWGyE09Lcl59dg3nMmibU1qzYM6C4Xq/NDHEhgGZ
	1xqLcgqySREinuuP3dV5WWkPht47uMjZsaedUqauMrhmuPeK5WtlhdKVMJi0LpkpPDKe8nrImHm
	FqToUn7d/AnA23vRyIG9qEKTTESt+NCzNZUaFkCFu9c0crt5bcZIhA7vyCViuRrCQBMN/Pbk5V1
	gbD1bEhTLjGyrIiBITcd59+OW9dRLecabSmdoa7UgXy
X-Google-Smtp-Source: AGHT+IFL9KJFSFdqWEJ5S3rFfqk+7jTG8B4QqZ1/8txfPBPRJMuKSjeQj3xp8kqjhhl1CQpulA+rfw==
X-Received: by 2002:a05:6a00:2196:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-725b8156675mr1310656b3a.13.1733434261665;
        Thu, 05 Dec 2024 13:31:01 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:643d:2bb:e7d1:adbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e8fa7sm1748633b3a.67.2024.12.05.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:31:01 -0800 (PST)
Date: Thu, 5 Dec 2024 13:30:59 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1Ibk8izrtPAywoU@ghost>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <20241205-45c00adab2636bf26ce05f70@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205-45c00adab2636bf26ce05f70@orel>

On Thu, Dec 05, 2024 at 09:04:12AM +0100, Andrew Jones wrote:
> On Wed, Dec 04, 2024 at 06:57:10PM -0800, Charlie Jenkins wrote:
> > When compiling the pointer masking tests with -Wall this warning
> > is present:
> > 
> > pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> > pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> > declared with attribute ‘warn_unused_result’ [-Wunused-result]
> >   203 |         pwrite(fd, &value, 1, 0); |
> >       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> > ignoring return value of ‘pwrite’ declared with attribute
> > ‘warn_unused_result’ [-Wunused-result]
> >   208 |         pwrite(fd, &value, 1, 0);
> > 
> > I came across this on riscv64-linux-gnu-gcc (Ubuntu
> > 11.4.0-1ubuntu1~22.04).
> > 
> > Fix this by checking that the number of bytes written equal the expected
> > number of bytes written.
> > 
> > Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Changes in v2:
> > - I had ret != 2 for testing, I changed it to be ret != 1.
> > - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> > ---
> >  tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > index dee41b7ee3e3..229d85ccff50 100644
> > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
> >  {
> >  	char value;
> >  	int fd;
> > +	int ret;
> >  
> >  	ksft_print_msg("Testing tagged address ABI sysctl\n");
> >  
> > @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
> >  	}
> >  
> >  	value = '1';
> > -	pwrite(fd, &value, 1, 0);
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> > +
> >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> >  			 "sysctl disabled\n");
> >  
> >  	value = '0';
> > -	pwrite(fd, &value, 1, 0);
> > -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> > -			 "sysctl enabled\n");
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> 
> Could make a wrapper function for pwrite() to avoid duplicating the ret
> value check.

I'll change it to a goto statement to avoid duplicating the
ksft_test_result_fail call.

> 
> > +
> > +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > +			 "sysctl disabled\n");
> 
> Why is this changed from expecting 0 for the return and being the
> "sysctrl enabled" test? We still write '0' to tagged_addr_disabled here.

Silly copy mistake, thank you!

> 
> >  
> >  	set_tagged_addr_ctrl(0, false);
> >  
> > 
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> > -- 
> > - Charlie
> >
> 
> Not part of this patch, but now that I looked at
> test_tagged_addr_abi_sysctl() I see that
> ksft_test_result_skip() is duplicated.

Oh huh I hadn't noticed that. I'll send a patch for that I guess, easy
fix.

- Charlie

> 
> Thanks,
> drew
> 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

