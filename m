Return-Path: <linux-kselftest+bounces-47052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B3CA51AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 20:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A4C1307BB4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628535FF5D;
	Thu,  4 Dec 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY4ORmZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496335FF64
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871122; cv=none; b=WMg93nriMbeMKGA/1eRFlaLR0eVogCYpnu4i/0YYcy+v2glqSz7LoR5H/pTU562QED/7zgz3z744J+gKb8EnBiKDi3AiynUBeClZzQ+okPeDQWZsZfnqvfZeWfNUm2q2IuZ6yt25mD3dlEwDr7l8+6wgPNx0oD4rE03nkOlDmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871122; c=relaxed/simple;
	bh=M61YqHUOtUork5VnW7pM/Mojz5Hm0vLf3JZ2HTVr3lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJMtHxAvjTBYzyElK5xNTVJcuP0dyrElW7p42b50dt903ul2F8PVVxauariHClg2ny4FVVwM2fcWy/Y4UmA0AeWGlsEWmv3xm/PFnBZBYepBEU1ne0PYpNo8B4F6egv5aln5CR4gP1e2uvw7yyHUhVw6mG2H3H2NEpyOUI6rAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY4ORmZL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so1129947a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871119; x=1765475919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=HY4ORmZLBYzOdCUWObP7rSVJNZCX+aHieIFOY+XQnM/6dOsnZ02o7P4txafcZlkgGz
         0MbNeFn0fDCTerN5bAfHfJ4Qcqd5VXxaQ8iVWSz8IIYU2P4S/uBspS2fCfqWlAxGrojq
         5RRunddNABa8WgZHRxXDnN1vOnpJcHS5k7PDjFVXd4dpU86HBoNr2K/PCWTVxlKn/2oL
         jIBQvBRatRIVfVU/UogKDCeFlFofcWSQazAzuvl3BnDKt/+XgkxtBsy/0KOKncPDlPYV
         jDbCI1+Qhymnqh5+K4rap1GSp0WckFrLYv/0d/CznRy+CLPwhe8K/iPso6Vy2uA+lJJw
         0p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871119; x=1765475919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=jQMDbzCAZUvHkfbfuh2nsUausw4jRitdJR3NVN5QZ2kDhNxXcLuuDtkxvuOqUlRmTT
         ffFQ8SE+12wiJEBi6KyBgNHI7zJOZRicwwUzaq9AM5Gk9UcQcSFqoglEsxT+2CpcTTxE
         uogk5/V3TwZvtZfrwqevt5RkFLdTwr+vAnKzHVjetxYhoH9RLQyDVSsY0caTOhDNNB4v
         x2tv34kwBLpIoQHFTfigWbU8f64lpEQ15zCRR5YRUXwpO9g2fHLEKTxKhzCZCo7cmVgs
         r8mNmJt7oRZOYaaS6D9AwWpg4AWT2eG7DHH7lWN4Grdl9pXjT+jlbbuA5s94uF14DMbJ
         QEcA==
X-Forwarded-Encrypted: i=1; AJvYcCUR+EYvVI5wc5joKYInmPUhi4cTg+eq1J8FCyvb2mg2gDs/WYN2jWEcne+nADk0zStMSg+feKJLuujAOjmnVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKrE89sktYLoXSNYYxIA3H9aLzUQe9g0tZz/wxRGBd+dPN1mR
	aCoLd8KtXO0cqq1bMmTI2dFBhf4guQkKYNxy4/ALVfjlSlEKb/2Vdt28
X-Gm-Gg: ASbGnct/I57w38SqXMVG97EebzTHSKIZCPgGbn5tYh5csNXF4fIksbsGyeoe0TuxA0e
	vEyCVbTw1lZR5+Uck0aCpZg5AhrlLVINeYbXDPigKn3VvQuM+NhIV9jMgG8pAuH4gVuPaKltt+U
	6/7MUofKZ6/vTobt4L7v5W2igWmRmmzzdgvgix6wwe+CMSDU3L2xECa1EzltAa5VlOALA5Fib9Y
	/BWg5m+I1k431hKUKRGqVHx8xV6Bhjw5GY1gOAyII/3CDriBGZfbv0QK87qCa7VECk6tSHV+xa/
	H41EFnQMIG/5tshqprU8vJqRiMxYdw3dnZS3+MCzvJWQS8x16/s9LUCvSUn+WdhMlteRK642QR6
	I8w86tQMnQUuLDafzcyrC7IdOst0AvOfYcXmntpcYvFdWGNTRDCpr/uJE4spCHl5Zqv6MgLb7An
	RsqXGIMHvjWr22wwiYfEnTEAw=
X-Google-Smtp-Source: AGHT+IHd2CViZquu8rDIVJve8lgSXsL5f4xbCLXW1g3SwVu/83f5GjAIV9Uz6obIchoDu07uphYeuw==
X-Received: by 2002:a17:90b:3852:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-349126bd337mr6610930a91.32.1764871119341;
        Thu, 04 Dec 2025 09:58:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817397d0sm2431869a12.6.2025.12.04.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:58:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:58:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 06/13] selftest: af_unix: Support compilers without
 flex-array-member-not-at-end support
Message-ID: <f58ae2ae-49f8-46cd-bd24-2d358cb36f15@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204161729.2448052-7-linux@roeck-us.net>
 <20251204094054.01c15d1e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094054.01c15d1e@kernel.org>

On Thu, Dec 04, 2025 at 09:40:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:20 -0800 Guenter Roeck wrote:
> > -CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
> > +CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
> 
> Hm, the Claude code review we have hooked up to patchwork says:
> 
>   Is cc-option available in the selftest build environment? Looking at
>   tools/testing/selftests/lib.mk (included at line 14), it doesn't include
>   scripts/Makefile.compiler where cc-option is defined. When cc-option is
>   undefined, $(call cc-option,...) expands to an empty string, which means
>   the -Wflex-array-member-not-at-end flag won't be added even on compilers
>   that support it.
> 
>   This defeats the purpose of commit 1838731f1072c which added the warning
>   flag to catch flexible array issues.
> 
>   For comparison, tools/testing/selftests/nolibc/Makefile explicitly
>   includes scripts/Makefile.compiler before using cc-option.
> 
> Testing it:
> 
> $ make -C tools/testing/selftests/ TARGETS=net/af_unix Q= V=1
> make: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests'
> make[1]: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests/net/af_unix'
> gcc -isystem /home/kicinski/devel/linux/usr/include -Wall  -D_GNU_SOURCE=     diag_uid.c  -o /home/kicinski/devel/linux/tools/testing/selftests/net/af_unix/diag_uid
> 
> looks like the flag just disappears. Even tho:
> 
> gcc version 15.2.1 

Oops :). I didn't expect that, sorry. Thanks for finding!

... and I guess it's time to set up AI in my environment.

Guenter

