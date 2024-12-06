Return-Path: <linux-kselftest+bounces-22921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E453D9E77AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95471281AD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114632206BC;
	Fri,  6 Dec 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e03ZJxOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9A22068F
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507155; cv=none; b=D0qls9gOj5FGbLXns+zzIECUgC684A0IoXOa96aWhPMw6f4aG9y+XHbDUnLtMIT+oc0oin5ZkRkOVkSiQVv6wzdurC0VMB7PhPmmayR6SWBPjodc6N3XNWepENQEbuASSGqCIokH/bBfqfyBQcuHSTBu9H91dPGlReFPssI038s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507155; c=relaxed/simple;
	bh=wxbHZEG25b4UJVUzFrEpQoV30rmbLRfnM5RBOwgdl7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlLP29oi+kPh2LD5vp+wq5YnZp+xXL+91Z5bTdM3ctHN8WAg1GzJ2c0XKWAgEwdC/LFUdTMIIR22zCw3y5tipRJEc3mP2HvhnzwccOrx+KkyMjzzrDaJjY9y3Va+Cbyo/WCnsA6doA9rdWRwYgey2AbCZVea9iIfRcQUvREEoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e03ZJxOH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725935d001cso2065930b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733507152; x=1734111952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAooZwBPcM5TGhZsHqOQgvHTchJ3PXQRaHlWWctMQ14=;
        b=e03ZJxOHE8k0Z0uHs7WUDrw8B6PwGMuScIGNI2QrZMnS671sxh7BhbjiL4E1cmWQDW
         cW04cX1b4rxy7cCwC8mk/ZrdeanwJ0FgEXaWky8efUtjPb275Qwr4+QQEnbR/gDGySfT
         U+yBBO+j97Az1qKGQzuihayBNIxD/Dibaperhus6ZS9zhuiuxsT96n7YvSpabxJn/7jk
         HyUdBweM23Q/P/7iHkI35dX7c/45UCtvIBGaunQptZn5zX2WHA2PXuh9LzuKf4itl9oE
         cTSDFqW4MpVVNoJmmSnZjHwgpGoHcxqzwVu7ebk9mOdYCQO7smwcNJglW4oQGIB19OKK
         tMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507152; x=1734111952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAooZwBPcM5TGhZsHqOQgvHTchJ3PXQRaHlWWctMQ14=;
        b=e00eQ3AyeY+SDx8lDJmhJad/hZu3htklcGHadGgIBmCJqVrKSMyrF3RWBsKoKhjGXu
         F5tNoFVYnINDqgFfcDlaNKPPcr4KDpHmw2R0ViJjMQ1ZchKiayI+u9tycfn+eEJehHfG
         sN8Xf6Z7H6v6+AkP44WiL51TlaiCW/2udN5uKa1OZuI8YtiJy2vYo0YLwijlkNUwPl6M
         P5JoUA7giQ7iAhcZLy+eh5SzZs9K2OAk+hfFgp8WocZ3rDoNAqmwb4CXv/flEDzA1Hlw
         D4LFigqu+Ig3QFR1eAWN3jSPoe2zfzo4l49LfOOrWXxHqfUcVwqq8UQTWqnYkLYcTj+n
         vlJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBCf5lqIT8806Hlg/LV/qB/g1smOR6Dvdaj92RsJ8vtzAGSOoJOEzGjA3lXgaZiL8p+1xLA1n8y8a4biZ/Hwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tPK7WoY8mjWVVi0ZRSMt+00wHm8/C7lqVQMIduXtwfwCjI4B
	09oru8rbQAGqbGndqAKXpqrT7/p6JLpTtlE50GZb9Fnh5SNZEB5uFTlMlED33zc=
X-Gm-Gg: ASbGncvUgW3XiCxqeeRN9TAf/fHTvqynhqI71w/w/HIIkbidhbrBTVKCm5SqvXPALl+
	41gjTLTSUN4FON8TPQAlpXunpHkpYecisbx/mbbtfrabMTAHMO1HWFfZ39UtTrNhcwGjrvjNicW
	15lhy2HzBFeAe+HIcLx+I/lIvySWM4GkhYAcnRloSD8hTjKecefGmwv+aGImb4ZxSOF2Br7p4k3
	siaElddIz6kz13YYDY8UWy/mgy9lZJZzdV5TbWyhM9JwQ==
X-Google-Smtp-Source: AGHT+IHnqHSI43jh4cv+SNvOzcNy+9f7ZIxwNmcWDWx/wr/KBsfJsS57hR/xKlrk05+r5QDxzOqqZw==
X-Received: by 2002:a17:902:dac5:b0:215:8103:6339 with SMTP id d9443c01a7336-21614da9ab6mr56714085ad.41.1733507152396;
        Fri, 06 Dec 2024 09:45:52 -0800 (PST)
Received: from ghost ([2600:1010:b0ba:197a:c0e9:4a0e:e502:edf9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e875sm31382665ad.19.2024.12.06.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:45:51 -0800 (PST)
Date: Fri, 6 Dec 2024 09:45:48 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4] riscv: selftests: Fix warnings pointer masking test
Message-ID: <Z1M4TNU0p1PgJOIL@ghost>
References: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>
 <20241206-6f0aafe057dc10df9a9e02a5@orel>
 <Z1MyrgQJsHQscdZ2@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1MyrgQJsHQscdZ2@ghost>

On Fri, Dec 06, 2024 at 09:21:50AM -0800, Charlie Jenkins wrote:
> On Fri, Dec 06, 2024 at 10:15:17AM +0100, Andrew Jones wrote:
> > On Thu, Dec 05, 2024 at 01:49:31PM -0800, Charlie Jenkins wrote:
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
> > > 
> > > Fix this by checking that the number of bytes written equal the expected
> > > number of bytes written.
> > > 
> > > Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > Changes in v4:
> > > - Skip sysctl_enabled test if first pwrite failed
> > > - Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com
> > > 
> > > Changes in v3:
> > > - Fix sysctl enabled test case (Drew/Alex)
> > > - Move pwrite err condition into goto (Drew)
> > > - Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com
> > > 
> > > Changes in v2:
> > > - I had ret != 2 for testing, I changed it to be ret != 1.
> > > - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> > > ---
> > >  tools/testing/selftests/riscv/abi/pointer_masking.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > index dee41b7ee3e3..759445d5f265 100644
> > > --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> > > @@ -189,6 +189,8 @@ static void test_tagged_addr_abi_sysctl(void)
> > >  {
> > >  	char value;
> > >  	int fd;
> > > +	int ret;
> > > +	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
> > >  
> > >  	ksft_print_msg("Testing tagged address ABI sysctl\n");
> > >  
> > > @@ -200,18 +202,32 @@ static void test_tagged_addr_abi_sysctl(void)
> > >  	}
> > >  
> > >  	value = '1';
> > > -	pwrite(fd, &value, 1, 0);
> > > +	ret = pwrite(fd, &value, 1, 0);
> > > +	if (ret != 1) {
> > > +		ksft_test_result_skip(err_pwrite_msg);
> > 
> > It seems like we should have a better way to keep the count balanced than
> > to require a ksft_test_result_skip() call for each test on each error
> > path. Every time we add a test we'll have to go add skips everywhere else.
> 
> It's only a problem if there are multiple tests in a single test
> function like there is here. Since the tests disable then reenable it
> makes sense to have them in one function, but does require us to do the
> skipping.

I guess it is sufficient to leave out the skip here, if the first one
fails we can just continue and let the second one fail too.

- Charlie

> 
> > 
> > > +		goto err_pwrite;
> > > +	}
> > > +
> > >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> > >  			 "sysctl disabled\n");
> > >  
> > >  	value = '0';
> > > -	pwrite(fd, &value, 1, 0);
> > > +	ret = pwrite(fd, &value, 1, 0);
> > > +	if (ret != 1)
> > > +		goto err_pwrite;
> > > +
> > >  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> > >  			 "sysctl enabled\n");
> > >  
> > >  	set_tagged_addr_ctrl(0, false);
> > >  
> > >  	close(fd);
> > > +
> > > +	return;
> > > +
> > > +err_pwrite:
> > > +	close(fd);
> > > +	ksft_test_result_fail(err_pwrite_msg);
> > >  }
> > 
> > I don't think the goto reduces much code or improves readability much. A
> > wrapper function should do better. I was thinking something like
> > 
> >  static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
> >  {
> >    int ret = pwrite(fd, buf, count, 0);
> >    if (ret != count) {
> >       ksft_perror(msg);
> >       return false;
> >    }
> >    return true;
> >  }
> > 
> > 
> >  value = '1';
> >  if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
> >     ksft_test_result_fail(...);
> > 
> >  value = '0';
> >  if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
> >     ksft_test_result_fail(...);
> > 
> > 
> 
> Will do, thanks!
> 
> - Charlie
> 
> > >  
> > >  static void test_tagged_addr_abi_pmlen(int pmlen)
> > > 
> > > ---
> > > base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> > > -- 
> > > - Charlie
> > > 
> > 
> > Thanks,
> > drew

