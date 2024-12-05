Return-Path: <linux-kselftest+bounces-22894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68B29E6033
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 22:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAB3281985
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039CF1C8FD7;
	Thu,  5 Dec 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nMWUT7rl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1851BC07A
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434847; cv=none; b=aLo3ri6j/12OKgRvEIPrOdmOFvY5RIQwoPQQqmpjOdVrA8rwO1NpF5ZaxB51lJ8GqYL1NjLFmUDdUzZxpB5otUmwwLN6CrwWrORLdIzZPe7wrg9pos4zbEpmO0zfcZFR8Xoie25sIrEF7Y7OxU98GM+MEqmLEnvFmLYfh+6Hj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434847; c=relaxed/simple;
	bh=IAy04chLo3eZtgzzPRGzr2UrSR3kk3M7KZ7SaOe7jFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoDcGOFw5pAD7o/z+jEMVKeOkyfmI8/2M1jtvwhmZsQ2RsfONFs40gph1vHQ1WCXTfBPrpDl3Cym141pAPeUlYT6XNNK8sG3Erbp88HvEqPhAPAc9ebJAn9yfHs/ZC9YnX8kqvWUOUf1GZBnmaQU0cqpBuQVyOo1ezPBNCrkVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nMWUT7rl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eed4fa2b3aso1142046a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434845; x=1734039645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUO4VmwlwS9KniRNf2k+C8HeNtScfo04esFXfVztpHE=;
        b=nMWUT7rl4ij5gcYG6SFjVKa9GG2M8pnruCWjQFSFfWGDbv4I5GpgMeXlKZFmy1DVXT
         MlK+P+av/XG8o0NI0q1hSXj56TXze0EAHNs3jONvBH0u7XJ5iyfQrv/hVmO3bm2NSv8z
         koY4qtlyeEs6PnRNP4K635uoxoR6MHUDI3G9x9zpEraE2mbmz74hFiRlEOG+DxlI39xS
         YXNXg9v0Diz5ggTTs2MX9X6icv8dsVTzzC/2RX4M1cLX9GB0YYVR1quEirytc7DLnykH
         w2cQON7c7MVD2lCPNbTXQA8oppMs/4LELmMdf4zmlLyFNiymYVtV1EIiO6Oi6Mf5pn9K
         oBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434845; x=1734039645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUO4VmwlwS9KniRNf2k+C8HeNtScfo04esFXfVztpHE=;
        b=tbbHROyAxu1ODA/W4JPzKf1jzAQGnn4ysXHaazOzF6fpKkfwuhikeaEPEjUAsZdh3Q
         VTs6SaRPGlkRewIOkKnv4kwsadumk9ZAS/lNHTXo2H5geLcLtfi98D33id2aRC/3lKVN
         mE53s5oRxtVssmfd6mFjY3o0fevD7UYAHA7VWyA77Q8N1DWuATuAxacCcRC/cb9u2dgo
         +I77LUNi2e8i5YVG1111X7FBR2xTYp8IbHuCnn0zQOPctG+0tSIWknxrrsM270Lp7NF2
         HnkJpfL32zRWK15A1sz3NjiI8qD/qFOcILb1rnnoT6fadsI8Gjp94Y4ukhEfMypKCj3f
         de/w==
X-Forwarded-Encrypted: i=1; AJvYcCV+DoJo75pmJynrI4++R+qhEA00k7+MCn0ilxtyGLeftmuMTHHUxbS+VCcCXBIWCoT9PhMSPEKUOcf5cyBzEhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGVEUzxuEdWJeIpY4pxguKh6KpIsnx6j/Xs2sJAwOSQwPLJ7F
	ZLuPjQCtgSaaEGF8kXV+fEuohKpRo6BMkp+WP6PM5OudrZplF5kQdS1vIFWMfa8=
X-Gm-Gg: ASbGncvJ22+FpWajVrBStvVBLABbKB4XHb8ZhN7ZVjQ1R71sO5Ct5JOUdGV3OWh6mD4
	cqS1wP+cqyU3c1qzN/60nPwOa/7AUuz2S5Ri6yW7Wn5QDA0ZrSzxHIF/ToBEY1/Q8fbfqcCMG60
	da8Xiscy6AZ+5o6uogLD6rCSLVBmp5zmih0fypvja3Vf7DemV/xtydOrIN3fWakZOMRaQ29slEe
	7eoxftSLkasnTIi5Q+I3z3DLhKm+J8yVOMj9336Av8t
X-Google-Smtp-Source: AGHT+IF5ybXEcs76e3fOo5rpErVKtitKRm+7lczuVir2hwC784IqB0KDYLqOXuCZa4uwvcbdbJMPWQ==
X-Received: by 2002:a17:90b:1dcf:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2ef69e16decmr996540a91.10.1733434844979;
        Thu, 05 Dec 2024 13:40:44 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:643d:2bb:e7d1:adbd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffcdd432sm3054184a91.2.2024.12.05.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:40:44 -0800 (PST)
Date: Thu, 5 Dec 2024 13:40:42 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1Id2o5rpQ7D-tHC@ghost>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <20241205-45c00adab2636bf26ce05f70@orel>
 <Z1Ibk8izrtPAywoU@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1Ibk8izrtPAywoU@ghost>

On Thu, Dec 05, 2024 at 01:30:59PM -0800, Charlie Jenkins wrote:
> On Thu, Dec 05, 2024 at 09:04:12AM +0100, Andrew Jones wrote:
> > On Wed, Dec 04, 2024 at 06:57:10PM -0800, Charlie Jenkins wrote:
> > > When compiling the pointer masking tests with -Wall this warning
> > > is present:
> > > 
> > > pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> > > pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> > > declared with attribute ‘warn_unused_result’ [-Wunused-result]
> > >   203 |         pwrite(fd, &value, 1, 0); |
> > >       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> > > ignoring return value of ‘pwrite’ declared with attribute
> > > ‘warn_unused_result’ [-Wunused-result]
> > >   208 |         pwrite(fd, &value, 1, 0);
> > > 
> > > I came across this on riscv64-linux-gnu-gcc (Ubuntu
> > > 11.4.0-1ubuntu1~22.04).
# Testing tagged address ABI sysctl
ok 57 # SKIP failed to open sysctl file
ok 58 # SKIP failed to open sysctl file> > > 
> > > Fix this by checking that the number of bytes written equal the expected
> > > number of bytes written.
> > > 
> > > Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > Changes in v2:
> > > - I had ret != 2 for testing, I changed it to be ret != 1.
> > > - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> > > ---
> > >  tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > index dee41b7ee3e3..229d85ccff50 100644
> > > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
> > >  {
> > >  	char value;
> > >  	int fd;
> > > +	int ret;
> > >  
> > >  	ksft_print_msg("Testing tagged address ABI sysctl\n");
> > >  
> > > @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
> > >  	}
> > >  
> > >  	value = '1';
> > > -	pwrite(fd, &value, 1, 0);
> > > +	ret = pwrite(fd, &value, 1, 0);
> > > +	if (ret != 1) {
> > > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > > +		return;
> > > +	}
> > > +
> > >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > >  			 "sysctl disabled\n");
> > >  
> > >  	value = '0';
> > > -	pwrite(fd, &value, 1, 0);
> > > -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> > > -			 "sysctl enabled\n");
> > > +	ret = pwrite(fd, &value, 1, 0);
> > > +	if (ret != 1) {
> > > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > > +		return;
> > > +	}
> > 
> > Could make a wrapper function for pwrite() to avoid duplicating the ret
> > value check.
> 
> I'll change it to a goto statement to avoid duplicating the
> ksft_test_result_fail call.
> 
> > 
> > > +
> > > +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > > +			 "sysctl disabled\n");
> > 
> > Why is this changed from expecting 0 for the return and being the
> > "sysctrl enabled" test? We still write '0' to tagged_addr_disabled here.
> 
> Silly copy mistake, thank you!
> 
> > 
> > >  
> > >  	set_tagged_addr_ctrl(0, false);
> > >  
> > > 
> > > ---
> > > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> > > -- 
> > > - Charlie
> > >
> > 
> > Not part of this patch, but now that I looked at
> > test_tagged_addr_abi_sysctl() I see that
> > ksft_test_result_skip() is duplicated.
> 
> Oh huh I hadn't noticed that. I'll send a patch for that I guess, easy
> fix.

Oh wait, there are two skips because there are two ksft_test_result() in
this function. I guess I should make it so that if the first pwrite()
fails (for the sysctl disabled test) it should skip the "sysctl enabled"
test.

- Charlie

> 
> - Charlie
> 
> > 
> > Thanks,
> > drew
> > 
> > > 
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

