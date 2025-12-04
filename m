Return-Path: <linux-kselftest+bounces-47083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DBCA54A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 21:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D1713075A1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 20:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FF35E523;
	Thu,  4 Dec 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N62e52w7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7C35CBD5
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878855; cv=none; b=ZKo0w8pS7ZUY/8ZhLOknfKjs8QzRZAqiQ3PjZ57MXb3xzL+JnATHpYWgpK17sOIbUqGXm0R2Csj0+eDN1xL85sY3VPepmvZKTnXQ2of03a0fP8Sx9BfmFxlVNJ2stnLoQpV7YMoQYXmjVqX9QV7OM4cO45wvQeE/bZsylcEjp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878855; c=relaxed/simple;
	bh=t9dWGhzFN9RsOEfXcG7dxUErpgknpFW7IobkU4qVlBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHTvXg6Vy1C+CaM1cUKyPIbFha8tvtgERP2CcBKFcsyUganVLYzxWH813l4AVRAo4f2HcIEyFsXVcUUlO3L78CNiOURiw3fFKPoxA1d9y+ez1dN8Ue2AvA8sgrLLZcc1QLIL/xslITb8RbuOcDs5fNquYyHKGk3g+vivgNs2Ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N62e52w7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297d4a56f97so18388245ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764878854; x=1765483654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=N62e52w7nqEmdnMJG6OiIt5p9OqhHolPDi1no5b7NSSIJdFmcjWdzSnitjS07UCRPw
         SA+9nHA6jhM7THjX5+ErqQLZ0vdhFQnR8wSMrytxY9OVe8K0p8vH5qW3pYgdsSFcPnry
         wnTIcNPwX5IJkJtbZh5KNkRt/tl1NaX1bVRoJihIlnM7FsuQ4CMCEwWA76N0rOUmT1ma
         99xeZVXzEU1yuaaPYbjxbMH457PXUVHIA89Y5i1U8S8a4lDN3vPDKqvCErVXcck27NEM
         ZfDMuID7PauRhnq2oj3FxtPG9bnitXYF2fFL2W4GMljLxhtbfkFICWhDPse2zpnhL+k+
         CaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878854; x=1765483654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwQDJvoYGc3nz2GzVMDge8eRjx46D+CfeX3mSjr8SeE=;
        b=RLgZbsP+EC9yUSPbr0SJGx5FzQjMEbbynU7FPP/RypeF4XyAdyAFypPunweIPYgPHq
         2sy536r0QPr3d189fBctmsm8bJzH/5Vtxf5BGXbE84gav2R4vqD4PAaU3KpY/fSUundV
         mmUEarGjmAyXzudheJHnkB/AclmLgRrZYqEIdDKkBif5W3vMDoS5JA2ELzHY+dA8ilhX
         xn7+ZxMGAfXUGaX77iYSfDlkT0FcC6OLmejt0ROw0uQRDz4TuHLpPHOK8jRce2c5/9Yq
         eISrGIwwPx5V/9u+6jIqNxSNuanVJD939r3LQlfJ8DKOJpo0DBOTnid/jSqqT2SlDrXF
         51LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPhGjFx/f4DXEBjNTyXBvtiF0i8jHrsEVIQaqPu2mF5G5rcB4JE9n+m6rJVAPa6ZnQUmeJSpt7sq8I5p1arOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zWGzyns/VfpH9bItfNbN6XZ3f2frs7sX3UJPXWJlmwqh+CVG
	P79L8CoxVUekibj3QaLPzUoLjRdLa2r4scEW7Sa+ELriVIWD5LzdLfouHNu6YA==
X-Gm-Gg: ASbGncsNfSt7xPgcUjcjR3tJbJ0GXhEnbIoNAYhHSc/fkelFQZGSJip4JIDKbns0QNr
	jDwnrL2bjUurqCAz1tlgzGWe6yphYEC4LQJIOy60IvY6wFfXMC4GTFaRhbPRpf1ELwxGn4hadR/
	/9Pd7LOIulXUqDABW0mfj/253ux2ioWIEH1zeIPtgqV4Oe8O+AHRgZgoOnd841v1KaD7QpFJoNp
	RYwHK2wRkb/qN4lYU+hF9z+PJzkX8Bm6uXXpYD4Dw4hDj/fNCNY3uellWB6McmeR0+x2qzvJHJe
	wFbfTkKct/+o/2WTtDyvI7ujR3GbywElaDgSKUPfIX1/g031gCBgNkj308KEETtEMv6wzkgpV4V
	zPxXhk45OiQJkWxYjRUWcsVY4CqAtDWUblZfgdM2Qu9f+OqObIIOG5sZjyCsH6dxVBD/LOxNbdR
	gTDWntV8OY6TpszaiYOBrD6qs=
X-Google-Smtp-Source: AGHT+IG9RhYAdYFpkikbhLyKLRnmTqvWGyuDRO7QxR1lVaPfukVM+lNdimabKudFcB5i2SDvSqWrXw==
X-Received: by 2002:a17:902:e807:b0:299:d5a5:3f7b with SMTP id d9443c01a7336-29d684764b1mr90997395ad.53.1764878853433;
        Thu, 04 Dec 2025 12:07:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f006sm27567195ad.50.2025.12.04.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:07:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 12:07:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <0b4dd065-4f96-48e8-a44c-24d891c68a68@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <202512041201.EBE3BF03F5@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512041201.EBE3BF03F5@keescook>

On Thu, Dec 04, 2025 at 12:03:29PM -0800, Kees Cook wrote:
> On Thu, Dec 04, 2025 at 09:16:16AM -0800, Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > > 
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> 
> The series fixes build warnings that appear regardless of -Werror,
> yes? That on its face is an improvement, so maybe just adjust the
> Subject/changelogs?
> 
Yes, I'll do that.

Thanks,
Guenter

