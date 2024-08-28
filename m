Return-Path: <linux-kselftest+bounces-16638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DD963647
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 01:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2076DB24EA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31FB1AED32;
	Wed, 28 Aug 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFWixOpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37341AED2B;
	Wed, 28 Aug 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888306; cv=none; b=t9/wCx4jQY9jFccUB6KWbJvexA6frHp2jVdBcvU9in5hIMHp9jp+ZuR+YdryZ7+uwzC+WqTzeWP3AIzXkgu1rjEFKoomxa8c6NtScfwV2PWf9yDbmhkTSvCgtyTrble291mG1YwWAWtnHULsZvZgq38p1UiE5jpOf7kZ/s8zQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888306; c=relaxed/simple;
	bh=KXNRip9T1NpjH/FC1tS186H85OnP7eRtBnItU+WbbKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiN4VvuQMsqJ/fNsO4C9Msh0HxP8vasN/pIphCRlSfkoUbE8KebQUUxqLWbh6QsWbQdbIpQ3XC3dwatQhsk/rnnB3EcwP/gW3SSpgwD2yzQIRmcHQaUTcQLiLfzofBkD2HdiKcFApaS6M6GxuC9In+G9U9Y7/PkamxGDJ6dM774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFWixOpi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428141be2ddso349505e9.2;
        Wed, 28 Aug 2024 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724888303; x=1725493103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB1r80w0tSniiEQsoRZPgz9PdJTE/Shx5Zcwt2Wg6DQ=;
        b=YFWixOpie6vhAhSVeJcNECxK5KoW+iUyULiXXdw5tnuNgKIC8Nt/t/88D036Ob6FsE
         DvkaISAyocH2ILgNbhVUpk4NWjdeVik6voz4GDHizHQwRKrjlmHoVv1XJ9guPjtFnHXM
         HXYJyTbne+lQ33wqR+OYyMpJbk/JQN+jn6EhJFxxnTrWgMLdPlUlu4L493R7rbOwL7li
         aRPjsp11D1GtnjoemdvMuMGSyXZ0ZhKxjV2y90ks2OfuBZaCQ9RKX0ftoE4SgHCvZfzN
         Ni6aSOgj/vT/nUUrf+OJ3BFWw6p/KgmQAGlpZxsOLf/hbClqe4MFliRpxvWIYuRPFeTA
         bp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888303; x=1725493103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB1r80w0tSniiEQsoRZPgz9PdJTE/Shx5Zcwt2Wg6DQ=;
        b=PlHFuU25Vd3drbCSH4CWhZfZ9lZ+oM5JeFgVV4dKcUyOmRiJ/lvbPif9iCEA/0cj/F
         uFFW1yHZmuOpgMx/VlXrnZ8zd4UVaRxqLwu3JKlF4ua/mVCygPd6O7EM/cBklUOupviM
         sad0JISP/KGDNnPNw0Z4FzZq2b4GfjgeZ5TosPnfFrmmPhEzZJKloVCgZqBwchHM6b/J
         pNbNnpJCbl1S6juJi6T2vQR8b1LEj/8rLFVrJR69QRh32q8QPJp0e2pJ6SwBajfk7XeH
         dmkulU0NYZei+JNmU1APWvB6RiMlxHOVkhl3vTirgLkrZLAVfcdt4wmPjqaRcT7Gvjbb
         +KSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPMDbQNQv3Fp/q5Pz3v+p3/vVXOix4RMBUwzzVXLQkQCBa/8UdTpAM2KN98inJSowW7aQm1+XqpNhu56oY4t0=@vger.kernel.org, AJvYcCXrn1H7cBxdkwgVl5PpHT/wGv+XPdtW6ZyhFuC5EFoxWk6Nl1ZFewVx/wrhSROXGm6ZhRTZz7zv5W4KGLrN4Y2g@vger.kernel.org
X-Gm-Message-State: AOJu0YxXX6g1pJXvfIWiKktUMT3WXuufc74Wgd70HCkCPrmuoeO68m/e
	PGHtgQiNFCl8umHQVYbs+lL3oA2ykqvs7vQmrj5TDLS5oWslq/NM
X-Google-Smtp-Source: AGHT+IGE1Tr+5K8rbiq3aX2JG+RGnBONvXmau7cJ8JCt6fwWWs0mojGwXLpROhTgTUD7IBRMv3s2Qg==
X-Received: by 2002:a05:600c:1389:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-42bb01e6befmr7932745e9.29.1724888302650;
        Wed, 28 Aug 2024 16:38:22 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639da86sm33548165e9.20.2024.08.28.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 16:38:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 00:38:19 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, rientjes@google.com, 
	keescook@chromium.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
Message-ID: <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
References: <20240828225522.684774-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828225522.684774-1-jeffxu@chromium.org>

+CC vma reviewers
On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> mmap(MAP_FIXED) should return EPERM when memory is sealed.
> 
> Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_vma")

Thank you for the patch!
This Fixes: is wrong, the bug was added during Liam's rebasing of his munmap patch
set on mine.

> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mmap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 80d70ed099cf..0cd0c0ef03c7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> +		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> +		if (error == -EPERM)
> +			return -EPERM;

Not sure if it makes sense to special case this. We should probably deal with this inside
vms_gather_munmap_vmas and just pass through the error we get.

Otherwise LGTM. Liam?

(we should also squash this into the offending commit)

-- 
Pedro

