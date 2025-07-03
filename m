Return-Path: <linux-kselftest+bounces-36420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09926AF730E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F793BCECD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6804D2E6122;
	Thu,  3 Jul 2025 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Px7qolil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F62E3B07
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543930; cv=none; b=ik8zBM9SKHIHBcIBhpJ7qtGp6BWNA4ncWFlg886ajra+4M8FRelPu1wKeLyFtwZYCCfh83NUpXe7bAxFcia4/r6CygqI7+UT0eH+SAP6lOLhUkh7WDMF5YYSg+TbR/vI7uugIheCZK0q3FouxfCnbt66VQM1DVLcf/+PZpIt0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543930; c=relaxed/simple;
	bh=KVnqP49xtAT/39pjm4SB9D/z0i6aE60n2/FV7cQXGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfkFMwMZ/L1GXAqFt3vMqTDNEfPxtJBW5PHh75Dbtk5Sib+yuL7oUuRw1+D4jgQPWxgfmuLanjYz60zKJng4z4QVPZ9YH5wCLk9E04+4ClRBB9mrYHNCcU0oQuQ9VGOPr6+PyodMQRSWNA3dGFRCTML+QjGQJ6op0JmRLdV+VdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Px7qolil; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4702519f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751543926; x=1752148726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEy1REQsSnGLpJgUJbCYOfsqXwvfobdRMduB/tZDIyg=;
        b=Px7qolilG0WfQoeFjc1mS8RaxY9VEdTeUiX9N+T1IzUGREecADWCG+5vVSIkaCBY+H
         3h23kG1+yfEfc52JwDa/Gyr4cF06QjPP3o0GSw/8zTtLq0f7BvYvJY5+n1yRWi+7wy7/
         0wMsB61OeUWqUbig4hNgZWBHt9g4ofjq7lvIdnmetzZxWJ1/ezJruzVLs6Tl7nhBaeHt
         nkwCrzBpoEdt66fmgucPKr5YJ6ZLm2Fq7yVFeUjVVjZrBG9IDNb2tcatjWqQCKPQdQgs
         V7EqfkHHIWaWLoUxuY2oWiye+Msv4SY4UxX2dIRv6OSxiUJiT3BMZjTuFW2PWH4wEVIn
         h7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543926; x=1752148726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEy1REQsSnGLpJgUJbCYOfsqXwvfobdRMduB/tZDIyg=;
        b=p8i7dyrWZZCedkJ5YPQd8Zm5raejhib9dG8/0PxPESyvoihQvhWw7VIVNEbA1JniCt
         l/1rwnV5QiKWRGqgksHKxve6JCgCqtePv3FPCANazPnCagfUuH9XdXIFqkD9UC25JSct
         buvuF8931SaeqbYOcz1KbKHBj9lRLqh0u3XBbIW+G8j+A5i75pK8u6HSuABXUby6uVnS
         BtL4mAITg2guPUGPOlRCyLov4oe+m3IZn0EbsnaBWqynI3KrLNwS1begdMLeUkRRn/CD
         rsoMnxbY3BtuhWmnkQRTlEvvT9mhXrZKxzAR/XMRyCv2X+aI6fihAciq1Nthj6q636T1
         2OWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNuh9esgMLIsG0klJ4ozFTICFErSAKQhZhuOY535d2j/yyX7NcIQ4LfRdXM5KLx8D/S5GpuRvusNTnfueBJ0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2drVOIasBRpEvS0TZnq/261bw9+JoXzjW7RVLg2lEuNXfTVw
	vKNfVNwoSf5DXr9yajYQRwphj6vxPD96OXzRaYpXaf6m24XwOEDO6pzIHvGyLhQ/LQ==
X-Gm-Gg: ASbGncvRnGlaQF6nswowz0QCeNwjAUqPsHge7FvGH3zxVVoBcKztTTDxrRip9FVPWEI
	0A5kh7PPWDD0KCbg0mA8XmPeFojpFynX4nQEogCXwTFDH+u5GBLes5SYu4nauRyHBf+jMqLCHJD
	pL5ic2CS9sAaY79KODheA//CTHaXjYa7pLeLrwwy4pAKvJhn1ytPQAtsEaJebNcQLMvdFHUQeOH
	ZhVxcfZ5nAwovZVbi1+A7V1XdyjsZhxx0hs5R43Q3PJwyq0QI5LcjsgT2By1aL3HY5Ij44JGq+D
	kL3d52ROVI1+f4+XqVQ4aqLplMHxuLa0jVSTHhaC+5myz6u+b+OjZwSCoHOXmg==
X-Google-Smtp-Source: AGHT+IGmOASa0oMFT6hRpNe8aWb1lP5feRf8X2l4wmfd55rNGbp6qVKK1A5kadBg5n8uLklMz596vA==
X-Received: by 2002:a05:6000:4282:b0:3a5:2694:d75f with SMTP id ffacd0b85a97d-3b201c97157mr5254542f8f.52.1751543926246;
        Thu, 03 Jul 2025 04:58:46 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f218esm161233325ad.78.2025.07.03.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:58:45 -0700 (PDT)
Date: Thu, 3 Jul 2025 19:58:06 -0400
From: Wei Gao <wegao@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Terry Tritton <terry.tritton@linaro.org>, Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	ttritton@google.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
Message-ID: <aGcZDjYh6OLWRFkc@MiWiFi-CR6608-srv>
References: <20250702102157.5222-1-terry.tritton@linaro.org>
 <87y0t6jqnp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0t6jqnp.ffs@tglx>

On Wed, Jul 02, 2025 at 10:15:06PM +0200, Thomas Gleixner wrote:
> On Wed, Jul 02 2025 at 11:21, Terry Tritton wrote:
> 
> > Futex_waitv can not accept old_timespec32 struct, so userspace should
> 
> sys_futex_wait()
> 
> > convert it from 32bit to 64bit before syscall in 32bit compatible mode.
> >
> > This fix is based off [1]
> >
> > Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
> >
> > Originally-by: Wei Gao <wegao@suse.com>
> > Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> > ---
> > Changes in v3:
> > - Fix signed-off-by chain but for real this time
> >
> > Changes in v2:
> > - Fix signed-off-by chain
> >
> >  .../testing/selftests/futex/include/futex2test.h  | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
> > index ea79662405bc..6780e51eb2d6 100644
> > --- a/tools/testing/selftests/futex/include/futex2test.h
> > +++ b/tools/testing/selftests/futex/include/futex2test.h
> > @@ -55,6 +55,13 @@ struct futex32_numa {
> >  	futex_t numa;
> >  };
> >  
> > +#if !defined(__LP64__)
> > +struct timespec64 {
> > +	int64_t tv_sec;
> > +	int64_t tv_nsec;
> > +};
> > +#endif
> 
> Why not use __kernel_timespec which is the actual data type that syscall
> requests?
> 
> > +
> >  /**
> >   * futex_waitv - Wait at multiple futexes, wake on any
> >   * @waiters:    Array of waiters
> > @@ -65,7 +72,15 @@ struct futex32_numa {
> >  static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
> >  			      unsigned long flags, struct timespec *timo, clockid_t clockid)
> >  {
> > +#if !defined(__LP64__)
> > +	struct timespec64 timo64 = {0};
> > +
> > +	timo64.tv_sec = timo->tv_sec;
> > +	timo64.tv_nsec = timo->tv_nsec;
> > +	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
> > +#else
> >  	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> > +#endif
> 
> You simply can do
> 
>         struct __kernel_timespec ts = {
>         	.tv_sec = timo->tv_sec,
>                 .tv_nsec = timo->tv_nsec,
>         };
> 
>   	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
>         
> unconditionally. No?
Thanks for your valuable comments.
Your change has more directly interacts with system calls and simplifies the code without
conditional compilation. 
Only concern from my side is test on very old kernel(But i think this is not problem for kself test)
> 
> Thanks,
> 
>         tglx

