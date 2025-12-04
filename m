Return-Path: <linux-kselftest+bounces-47051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF14FCA4DB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91CE30981B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03413596E5;
	Thu,  4 Dec 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEFIw/ay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6E3590BE
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870999; cv=none; b=ndoCPP31JlNhgJN2yWPnAEUIs4rrnbAjBCu39yZ/wijVsAsSAX8ZuX/vGYbKmuV5AVl24Hig83RcWu/VRXHMnmmTSUb0oJrHJBuyV7mgHRzLTLsXS5rTwa+FTe8kFe4hhAfB3coY8vz/J6F4AqgFxYWIKNH8/vDqNFsrZc72Jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870999; c=relaxed/simple;
	bh=LssZyxnB/Qt9JOrc1wZ9fPSlCWdCRitPmmyrurmq8kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTG8oCz1L498+DHQJGBS1bLxBzoHS2a13NfLK3tXbtkjo4bp+GBjfZvv3NS4KhpC1Kj1MysxLGZtbBrX0uFeG8z2myor1vDGf9m+58X7SdkYWCJLcvdoXzL9dEyOTRxMn+/phgmmoGzDF0ibPt94I1Am6SdsTuSYsc0PFcuzJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEFIw/ay; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1224261b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870996; x=1765475796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=HEFIw/ayyhHN8KhM6O47o3ytvOcTKfR4wcPQ+DbAc8FZpt84Ejwyp/pXj/rraBRcVk
         G795k7cu6Gs1uOnmQWc+HXG3C8UxJ4+z64LAtszbwRzgGnrCPJomRVcXGJpoOSSYT1UE
         fAyefQCFn/3nnbF66t8aecoDTjOcaLar8CnZspzpc+d70UEcAYW9G8D/I/ZKHQIbM/vg
         bs9VuL+Z3VBUACQHzIfQ01WSA0c0Q1G0dt4QEK+ukUl2jFxVTNOsF6qkBQU6axesywRW
         pqlMpS1Tl9qZ/FJaB/6YfS26hptQACIQH+RT6iVTLDU2EuMqRVp1xRnymTmjBG4tKeG3
         vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870996; x=1765475796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=gN6lZli8yDBVX52PzrDQbTQrUJ4Z5j4uoFqGzmdEwgj+bF/lhIxCxEN79vtEom4al0
         oCLX1Zy6tSJMK556+XvLtHzmJBcCdTrJrRCDlnfh0BSeS6Th7z80AvoFdKboQ51JfOjv
         jan3WsnhpjO+64l+U+4SlvE/XLAZ65rlGv2LwT3At/JhTrU1XOBEZk6Gs8E35usDe1JI
         vXJR6r2sOFM/uvcdISQkDLoTKXiEfyXHEkDqwkSEm/vkyXqaGL0knG2QU3oTW4lBiPSZ
         I5INtbOpqb1V733nHVhohZ55NNwrFSbtZ5a1LVGtnvBMGOIY39r1Ft+Aqom00foPdROj
         zlpA==
X-Forwarded-Encrypted: i=1; AJvYcCWnV54YE+0rrrSrRZI0BcrQf5bIPFU3R/hnaP7oiUzgnms6h9gon1cID45kU0GfhMDFP1lbO1DBW4XmNaCvUZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXM44WtG2iV2Dvbt0VZW+UUVN/ydOlAAY+HzPx8IO/0bEeomld
	WuDivEaKHtdNRaF6ILhdkQV8XH2ub6bgANECAHaXLfJJ1SrFUlNSmWCV
X-Gm-Gg: ASbGnctBIOt5r/pbmnei15L+AVc/rK9jv2eWZz7xlKkMrc0Y5SYKQB1AvjD1PV4LwYi
	nQqknvuLsE6gpLGZ6JZz3XTSlMK4Q/tCUUelaohoYtlXbvnqztqfsFVOHgVqOmWsF6ZZPJlyLl5
	buHyYA0/dbHzn7PxOGMriCkHcQB2AOtJpIMbMC1D4bZImfL891u15JVTFk4nXep5kGAb8kUWmfm
	ZWat/PwViGnayzOvp7YJuR3tswhwIFdM2dD+QhgAP3D8vzyPYXDNRZ3ZxiMz3gP1aK+mgxDmrqD
	qcO5+AzwvblkP1uVsUNBcPqRpr8rnOAFj0KBkC/OBS/s4XILc+3Uzjm8s5b3JOMhtYM70PobtNz
	+4Vpo8E5ZVYE+epagaVvNxI8xT+fzHAew4XDB145ArwnG5vw9WZBKGFkL5aanZdCLBae+b9z9SG
	MT2EiHJ820FSiTYUyyLzR+oF0=
X-Google-Smtp-Source: AGHT+IErVS2JOE3R5hBQa8n4PbPRX0Rck8OX69DTgD6n4Zc+qBzm/AdH+8FlYt/3YOXPNZAECFyIAw==
X-Received: by 2002:a05:7022:6094:b0:11b:ceee:b760 with SMTP id a92af1059eb24-11df0c3b2ebmr5592261c88.23.1764870996269;
        Thu, 04 Dec 2025 09:56:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm9415387c88.9.2025.12.04.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:56:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:56:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <2e069056-645e-46a5-b1a1-44583885e63a@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <20251204094320.7d4429d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094320.7d4429d1@kernel.org>

On Thu, Dec 04, 2025 at 09:43:20AM -0800, Jakub Kicinski wrote:
> On Thu, 4 Dec 2025 09:16:16 -0800 Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:  
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.  
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> > 3) Fix the problems downstream only. Not really a good option but I guess
> >    we'll have to do it if this series (and/or follow-up patches needed to
> >    support glibc older than 2.36) is rejected.
> > 
> > We'll have to carry the patches downstream if 2) is rejected, but at
> > the very least I wanted to give it a try.
> 
> Understood, of course we should fix the warnings!
> If we're fixing warnings, tho, I wouldn't have mentioned -Werror in 
> the _subject_. It doesn't affect which warnings are enabled, AFAIK?

I'll update the subjects and descriptions accordingly.

Thanks,
Guenter

