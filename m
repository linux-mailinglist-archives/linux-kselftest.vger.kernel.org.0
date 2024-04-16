Return-Path: <linux-kselftest+bounces-8035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F58A5F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 02:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771361F21B48
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF1A3D;
	Tue, 16 Apr 2024 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k2T2ijEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0018D
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227678; cv=none; b=ruzJ/Zkt+7Y7nukufDgPq5X5ohVoi5F9Z3HgncdG/gggX1eb6ABN3tVWGb9LHcVrxAwW3/mosyWzLZ2sCyTaU3n8udk6p+eNrW5lH1vYmy+zwyimozc4xCc0j+C8Q5pUY2UCjmyFVuxOL12+Tj/VbisYMmY6yD/gg7o7RfpJ8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227678; c=relaxed/simple;
	bh=Uu0M7GIvUdTs6LdT4T9XsdKueP/wSc1aG5j1PLQFwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkjn2FsVZyihHkuGQvAhMbtT/d2KOSQ+gxp93C4KNKbL+ipDRrAPDER6SyOEdYr2b6Il2D4iE0c9etykMxjv+UVInuEPk0zPQwpgctGca0AYUzNN4VRBPuxBQOY0KztCFWg1BumymWylQDyitTZsJcqaLBklERBFp2JzJ/72Pv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k2T2ijEP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso3133491b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 17:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713227677; x=1713832477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tECMZdHIf57W8gG8gWlbX6tFu4h7YfeqS1rrPxFzlBU=;
        b=k2T2ijEPy9ATFpZz/wsPlE3zFzhdzzQn/9qLRM0InwfNvYvNJh8pVl5kKgUy0zNFaK
         OHFP9A0qPNggYNdzB3LI/BGEdnnKDTvwls09p+OCGdfZKK/O8WCPl/yXSei38fcnJ8KY
         hw2q3x0CXGxQJtQoDhqiFRVhz32XvARinF0/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227677; x=1713832477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tECMZdHIf57W8gG8gWlbX6tFu4h7YfeqS1rrPxFzlBU=;
        b=PHmU6yQAemKlsuQE6xb13sB8dSQOhN9dQWHyNUFm40iNU7UsRn7GA36tokvTB6Pqz7
         HrdsBrJzN1tsfv3/L47clpqFzY04xj86v/WxZZ6CnK8tI53yWx+UHylZcK1Fx1YoeU3w
         qr8YspysQrUY+kEW6uSv+Iaoo90x0bvFHvCTjWdXcv1sCx+6AwsxjXh2ecwJo7R1aFpH
         41MLCYTQ4wrNnscbqumTdCuVWqo0q2qY/rTNJMji9sGItDblnAd/vzXPcDKrjO5C0ps/
         DHAHjt5HOw/BDFCIBVzHOhE0vnxjPi0tNrXqRrvRzsayL5NjdDcV9haR+Nxza/AVx8Q2
         X2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW9WBG4lrw/d66/82g5jxs+azWZ1HJZhLWIB62DRs4sLgHgqSPLFRjiDwGQxQ5J2d4guhobBMxrC7CxnJrwH/drvGhPAChIwT7EI16YJBv
X-Gm-Message-State: AOJu0Yy8DpGCMvD9h5N7AcdyZVKYU/fic66N91iEA47jjE84tspG8tEe
	yeqKDFH39h1IZMN7MdGbYauNn1G5EwKPZYv4sGXgQB9k50Jwu4I334HF0tqaKA==
X-Google-Smtp-Source: AGHT+IHBTYQNm0G/5iTIWcqtCpBMx8eO+Lcv57FnkpUl7K+iOvZATxbmc2iNNHMdthR59l4Mz4CqSQ==
X-Received: by 2002:a05:6a21:4987:b0:1a6:b689:8c29 with SMTP id ax7-20020a056a21498700b001a6b6898c29mr10500341pzc.61.1713227676987;
        Mon, 15 Apr 2024 17:34:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b001e24988b99asm8503932plt.250.2024.04.15.17.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 17:34:36 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:34:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, corbet@lwn.net,
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
	groeck@chromium.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
Message-ID: <202404151733.59C3EF3@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240415163527.626541-4-jeffxu@chromium.org>
 <e1744539-a843-468a-9101-ce7a08669394@collabora.com>
 <CABi2SkVnhcOpeA63XoKq97Uc_VyWdLUqYdOtUXxJ1fos5-Tq2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVnhcOpeA63XoKq97Uc_VyWdLUqYdOtUXxJ1fos5-Tq2g@mail.gmail.com>

On Mon, Apr 15, 2024 at 01:27:32PM -0700, Jeff Xu wrote:
> On Mon, Apr 15, 2024 at 11:32 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > Please fix following for this and fifth patch as well:
> >
> > --> checkpatch.pl --codespell tools/testing/selftests/mm/mseal_test.c
> >
> > WARNING: Macros with flow control statements should be avoided
> > #42: FILE: tools/testing/selftests/mm/mseal_test.c:42:
> > +#define FAIL_TEST_IF_FALSE(c) do {\
> > +               if (!(c)) {\
> > +                       ksft_test_result_fail("%s, line:%d\n", __func__,
> > __LINE__);\
> > +                       goto test_end;\
> > +               } \
> > +       } \
> > +       while (0)
> >
> > WARNING: Macros with flow control statements should be avoided
> > #50: FILE: tools/testing/selftests/mm/mseal_test.c:50:
> > +#define SKIP_TEST_IF_FALSE(c) do {\
> > +               if (!(c)) {\
> > +                       ksft_test_result_skip("%s, line:%d\n", __func__,
> > __LINE__);\
> > +                       goto test_end;\
> > +               } \
> > +       } \
> > +       while (0)
> >
> > WARNING: Macros with flow control statements should be avoided
> > #59: FILE: tools/testing/selftests/mm/mseal_test.c:59:
> > +#define TEST_END_CHECK() {\
> > +               ksft_test_result_pass("%s\n", __func__);\
> > +               return;\
> > +test_end:\
> > +               return;\
> > +}
> >
> I tried to fix those warnings of checkpatch in the past, but no good
> solution. If I put the condition check in the test, the code will have
> too many "if" and decrease readability.  If there is a better
> solution, I'm happy to do that, suggestions are welcome.

Yeah, these are more "conventions" from checkpatch. I think it's fine to
ignore this warning, especially for selftests.

-- 
Kees Cook

