Return-Path: <linux-kselftest+bounces-22892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D359E6023
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 22:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25425281B87
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8F1BC07A;
	Thu,  5 Dec 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pcOft1Cv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CE82C60
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434324; cv=none; b=Ma+P08HiMXiX94u6BeZhPHzlmIOoQtOlVdQ5x+Kxqb7JK3QSj4NscpsSa23bfx8cLs67I8aopf1QK7cQmWpUtQD/rJ4iQ+9+6uvAKturTdQdyWSmgUWEZ9ZVKnsHPtnIZ8/1rbqohsZ/ixAyPvigwiPrscT201g5YNdwavcNoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434324; c=relaxed/simple;
	bh=P+R5oubC763+2QgUM2rsOWDVkGkG1VCYITJmZ9JVJNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYsO5G/IoHnRYdtSUkaFbNb5z9/q6XAcPWsWKWazS8ODwupslH1edIvLnM6QOnYdVAsplXAhNF8jBPM35+XaQUbI3tsN3Dre3BsH0w0MM7dkqF75h+Fy/jY6szgHM7zhr0enkMPSfdW9U6EwORYdj8zv79d3hamA0GjWYzmQGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pcOft1Cv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so1497992b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434322; x=1734039122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wyx22zMgi4pWu73aFiLkcTSA7gkzSkXHytTqPFsaqZE=;
        b=pcOft1Cvc5JzyK0ZiAEFHYaK2b+aM2D6kvC0T/C3LkdeOKBqjNRUQlNpnTUC60uvMO
         FLDDypfwooD/5yYdCiKfCzKqUwRZBzqn8wVmTV+fxpIhoHJ8vdedWytBIcR+BtJDlESc
         hqd0BGyPxCTE5XF5nDP4ss8O/IQsotpx9BVYaE35pvHeTIhkbSSiIOhxdRhbsIs+lBFH
         1QZjBkHfD8VgpRJ6RX/mkgjvnGTF038BOPZ2kAKbAAcWxgwjaqATurE+6xcqX6QgzfV4
         rAoWtLvuO80fPEjXcdIGE6aPNyrUdhL9N1Jrz08q2oImr3pBKU5aIFhUEspbLKOnjfnT
         kdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434322; x=1734039122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyx22zMgi4pWu73aFiLkcTSA7gkzSkXHytTqPFsaqZE=;
        b=kAfc90MN9UgxnzZ4B3MWBnhrSs5c6rS1uV7BlTUqVwg2cYXRcBtq2K2qYdSiTD/30e
         3oHxjlH4ws+A4GaUwZhA7rVRolPyg9gJW2ta7mTaZJAGCOtcfSMKKCJHHW+OU6Gvh0g/
         gRYTm6o46YtH2jrNNzQnXJGEInpJs1knIb/pYdJ6tj9BFHcKBX+cg4se4bpT9Inuq1ZS
         bs2EmI1Q16sOzVRah3NisjZkw2NdZOCg7RE3d4kgiOp36YQaqSbzOKY+vdckPmwMG6cU
         WYigCcR1YOdmi+pIiIhoOYgdY6o3lTLAUco+0MjS8Gq6akY/60g4E+FRiYL8q4TXh/Rg
         qLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaaxgCzD7L5ed1Yu1NEnNLBXgBPb27VqXPSexV4W7yHSepf2c3BoF6QJ/rwO55KcHQmqGsH6nqOlzPKF3WDcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFwuitZwsnXD/0oYodFwQCTIwdGTtd+d07RiYVuTBKvXk4DbM
	LMuNP45uzzW6ov+T7t+0qKWB1R5qsy3oNaGwmaKycj+joOdoCI9ewDUgewst3Hg=
X-Gm-Gg: ASbGncsDeIIc0OtzvLloHjbPveeQMxILp8BEd8Hljd+Amip7sMoyRTTYit43Io8WzQu
	4OWyq3dwcvyBtPoucRHPjdKon7TJpVvsJsDMPXji/AvNZpPUDn1ibpGaT80Bpz1wrPwmvoWMWtK
	2cYsMuG4mr0GesCyXLywrBGtm9fIlL51EjhXXyUnst0g7qN/uzURl5NZxEPQ/rvlNDIgsxJw1E5
	l3sqStUY0TXfKjIe2s794VbAsLOnmlYpOfGaCTKqb4J
X-Google-Smtp-Source: AGHT+IHXX0tWb0QGvBkyLN2duDz1ll0UJfDq+pVWxKWimKIoFpd8ZHB4PzaAYuNDHeontmn7LQfb/w==
X-Received: by 2002:a05:6a00:2e1f:b0:725:2b93:3583 with SMTP id d2e1a72fcca58-725b8185650mr906857b3a.21.1733434322450;
        Thu, 05 Dec 2024 13:32:02 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:643d:2bb:e7d1:adbd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd201fa60bsm895397a12.48.2024.12.05.13.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:32:01 -0800 (PST)
Date: Thu, 5 Dec 2024 13:31:59 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1Ibz-j8LUad571l@ghost>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <697a402b-0305-489d-bf4e-aa5e7fa4b2aa@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697a402b-0305-489d-bf4e-aa5e7fa4b2aa@ghiti.fr>

On Thu, Dec 05, 2024 at 09:11:46AM +0100, Alexandre Ghiti wrote:
> Hi Charlie,
> 
> On 05/12/2024 03:57, Charlie Jenkins wrote:
> > When compiling the pointer masking tests with -Wall this warning
> > is present:
> > 
> > pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> > pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> > declared with attribute ‘warn_unused_result’ [-Wunused-result]
> >    203 |         pwrite(fd, &value, 1, 0); |
> >        ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> > ignoring return value of ‘pwrite’ declared with attribute
> > ‘warn_unused_result’ [-Wunused-result]
> >    208 |         pwrite(fd, &value, 1, 0);
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
> >   tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
> >   1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > index dee41b7ee3e3..229d85ccff50 100644
> > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
> >   {
> >   	char value;
> >   	int fd;
> > +	int ret;
> >   	ksft_print_msg("Testing tagged address ABI sysctl\n");
> > @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
> >   	}
> >   	value = '1';
> > -	pwrite(fd, &value, 1, 0);
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> > +
> >   	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> >   			 "sysctl disabled\n");
> >   	value = '0';
> > -	pwrite(fd, &value, 1, 0);
> > -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> > -			 "sysctl enabled\n");
> > +	ret = pwrite(fd, &value, 1, 0);
> > +	if (ret != 1) {
> > +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> > +		return;
> > +	}
> > +
> > +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > +			 "sysctl disabled\n");
> 
> Why did you change the test from 0 to -EINVAL here?

Thank you for pointing that out, copy-paste issue, I will revert that change!

- Charlie

> 
> Thanks,
> 
> Alex
> 
> 
> >   	set_tagged_addr_ctrl(0, false);
> > 
> > ---
> > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429

