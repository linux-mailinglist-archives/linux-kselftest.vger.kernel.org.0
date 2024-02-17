Return-Path: <linux-kselftest+bounces-4890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92782858A73
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32476B2874F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B5E149DF8;
	Sat, 17 Feb 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LM4JPYap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1441C8C7
	for <linux-kselftest@vger.kernel.org>; Sat, 17 Feb 2024 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128084; cv=none; b=fa/ZRA9t9e5NLXTZBVd0MzZXaropaBaXf0HyDddOCpy+ACH8qKEDIO9+nooscNcNqhht9UOodbjHqrYSGc8G6+HNpMUQCuOtwnoD7Vy5Ushs9en1lA1mhQS8Xyb10DR/vMhlJyh/0mt/IrztkqfA9eq6s8rG+jZjYdIzs1aD+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128084; c=relaxed/simple;
	bh=twJMaz5hQjLxWg2D2ZOlTmtBY3tmgwGEsmcoi1okmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STmj+fVjFy+vtAUvEPb5NMPrwms/xM3MC+LNZ7+wA5X4yqEC9PMqigzjHyPMFLuWONY/VriD4SjOyfqJW2iKNaTEeKEzcFh/1LpFmmSb7++1hc7WOZ9tmHNHKgQrWU6W+lol2DiqQnY1zcL6cwSucJDzBOzvfRm6dvu88lFRXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LM4JPYap; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d94b222a3aso25880785ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708128082; x=1708732882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcCKG3D7AvePSxZeCEt+RshRF5ENt/rXD6pLatkDrQk=;
        b=LM4JPYap5xEEAOR9XDel1FAmTlNGnZShmaFs1bN2ehNMF0bD4X9662RPDljC4eYh4Z
         xtFMhgF3uCmt/7fBPRgCx1tyo/pcwcS2SM7RwQsCzwMBdRK9wlewow07mlZjOZvqZE/9
         +pjQw+lrEPHGCTzY3sFx//uiFCfBgGwscuyZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708128082; x=1708732882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcCKG3D7AvePSxZeCEt+RshRF5ENt/rXD6pLatkDrQk=;
        b=KuEHTo5llUA5WTaDnL9TGZqPPUWIAD/ca/XvreL4ONisq0mLGncT1ODgbQdXOMB6r/
         uaDTrXP98TSM3IjInAzxlEgHvkS+x7rxYs5rpbiVxLfKGLXQyZ4p86Ij0zVZVBZJBP2Z
         et55dLwn83EOeXr8pfUPNdXpWtEyUAUFCQWEWj57ix1NP3aD1gGiKcPbLni2ekUgwESA
         L2vhWNfE31BkusGDX6JYZZs7Ngt0maIESVlbcOzzm3V0w6r2HCxOqKbGytlt5fEJ5P8M
         h8wfoeNfJc0JMXhCxW1+QF4YLP4sv0OQh/MBDMcpGUVgpQUlAUGi07wNdAIDtE6nJVZl
         Y5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVHO99CIj5OHJLUqltnkNCn60bu2Ae0LK0Cc6KdlYUzm5zOoNlPXyQ3A9uZGjQ1o/hKvgSMvK2OfspJRBJLy9Mn+eG2xFn/J99hBuh2/yGy
X-Gm-Message-State: AOJu0Yz995wbIRMIxwmvftXE0zzyrKNJFCH0rWdAO88oXinCx+I1dLx3
	Bpiup5uJzG3FtAW0s5KRNVuou5WhMY5qbF9RoN/e1dpTzbF0eT9RN5l/Uh574w==
X-Google-Smtp-Source: AGHT+IHZC4htSp/S1o8/xuNw5MoOCc264ogO2hnLmdjTYKiML02zOzt6m83Am38ZfpxtzNSuqYdmUw==
X-Received: by 2002:a17:903:22c4:b0:1db:82fc:8b55 with SMTP id y4-20020a17090322c400b001db82fc8b55mr8278333plg.56.1708128081792;
        Fri, 16 Feb 2024 16:01:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903308c00b001da11733477sm408091plc.75.2024.02.16.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:01:21 -0800 (PST)
Date: Fri, 16 Feb 2024 16:01:20 -0800
From: Kees Cook <keescook@chromium.org>
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org, jlayton@kernel.org, jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Message-ID: <202402161600.BF1D110BB@keescook>
References: <20240209174243.74220-1-sj@kernel.org>
 <20240215011309.73168-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215011309.73168-1-sj@kernel.org>

On Wed, Feb 14, 2024 at 05:13:09PM -0800, SeongJae Park wrote:
> A gentle reminder.
> 
> 
> Thanks,
> SJ
> 
> On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
> > 
> > > On 08/02/2024 21:29, SeongJae Park wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > While mq_perf_tests runs with the default kselftest timeout limit, which
> > > > is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> > > > AWS instances.  Hence, the test always times out.  Increase the timeout
> > > > to 100 seconds.
> > > > 
> > > > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > > > Cc: <stable@vger.kernel.org> # 5.4.x
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >   tools/testing/selftests/mqueue/setting | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >   create mode 100644 tools/testing/selftests/mqueue/setting
> > > > 
> > > > diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> > > > new file mode 100644
> > > > index 000000000000..54dc12287839
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/mqueue/setting
> > > > @@ -0,0 +1 @@
> > > > +timeout=100
> > > > --
> > > > 2.39.2
> > > > 
> > > >
> > > 
> > > Added Vijai Kumar to CC
> > > 
> > > This looks similar to [PATCH] kselftest: mqueue: increase timeout 
> > > https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
> > > which was increasing the timeout to 180 however it's not clear why this 
> > > hasn't been merged yet.

Should it be 100 or 180? Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

