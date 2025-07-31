Return-Path: <linux-kselftest+bounces-38111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F3B174C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D40A83529
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB7220F54;
	Thu, 31 Jul 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO/g3ZQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99F1FDA8E;
	Thu, 31 Jul 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978374; cv=none; b=uiY5LAO6byuwSrH449BzH9Y7Z3NiNu1Fdl6W5fXHmy7zI5gOdsWnmiRDkzV8aieFcxkVNhYnk9tCOG4ew32IgSSJrcXDOBtFbvDAUCDdUA95pVaZTttBTpe7bKDQpd8lJP0na0BzLhYDdFWs/C2e/gDuxKEndMPFkQVI8Abj+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978374; c=relaxed/simple;
	bh=gNSM6zGqUrZRsYnMJQe7Za6UJQwzVnvrC3QwIkpt8r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep88Xamrx8LSc4Mlr9Ni8EivO7BJrvH98SGIM1I8fg2BOnkhX0P96r0r0x9bLtRLBOrq4wJTbdYEJz4PG6JGSDy67mousY23LuX3Sazj1rfJKEUaeB5RoRyo7iz1/c+h3UkpF0dNb8LCG93+b5lK7re6BasfX+AXMNjb94yrqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO/g3ZQU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af91a6b7a06so170399466b.2;
        Thu, 31 Jul 2025 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753978371; x=1754583171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xHS4hiX+qVisM233YfJkSDJSauegSg9zG27O8j1/3Rk=;
        b=YO/g3ZQUsAXkFLQpvgCvQMqTU7uM9KrivLNZ0wcpMlkjKaBMDX3kq1FXVJvT4Pzags
         VECa5YELU39u1AGxt7TAG2NKFxtYoyCilVgn2z5sizmnNMbLLoTAa9Zk+3yLYEXxF54h
         BNTnARoMGUy12pPOairEkK0Pw813YWhGXj9waY8vGCZyxZCmSM25Dzhoq3PhcqeJ1/tz
         dY/BtkYNHl+R5qyXny43PxYc3gQTuo19/onBlPCh+vudmBi1tjWksmF+KqGjUiwq4XPF
         3hNlkgRyXnfbbhO9BcVc6kYQc+AT9l8h2aoACkghHqDxQ9XpYLneR8Ua1ovWWeibnBeD
         4bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978371; x=1754583171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHS4hiX+qVisM233YfJkSDJSauegSg9zG27O8j1/3Rk=;
        b=HfKprwc7liS4oxfrTZVC3Yr8KZi8fLkl7McxFk73hOAgYMTQ7IxWUx3YZboYuZJBxv
         ZYp+zXNj4HvN69+oHGr2DlTA+bjQ1PaIvphT1yuXNY2L1YXi0LRN/nyhdBKUTyMAFTKR
         UG0nMz8BD86cxX55Ah6mZ2b2kw64Xcb3u8dy6cjpNwvjS31efDaYbGW+wKS2HVCuYL3a
         o+AzqeROqTcQEONhrFU4AXd2imlHvD0hgtTIaYcMpRcshoV+diZa5wUNYbbY7PovLB8x
         sVrVOaLQidAiErCS9KoAMjvO1QxNNCemKgivg5p2EuTyDSuC4Hr+QIuwnq7A0Fd5vt7/
         b2+A==
X-Forwarded-Encrypted: i=1; AJvYcCVsb+bUQL8CYMv+RLDmILe0lE0+sjcVFmRlgj8BJE4+JQIRBXHe/I0i02Y6MG10p6ELLVNteerbWCgjgBzRY6qL@vger.kernel.org, AJvYcCXX0EPqZhohXdQERw0DR/09RbHuU462JBeyoQpT1UH4vbz/MmLuMvm2wc1VohP9Esz290p3cZb7FntVMFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmGPs0OZ70bvYZ5lfyb/4ZnUboGznwFeoICUoMRvV6SPeepXY
	Ph99/nVSyfEJ1kz4iiI/h53awEyGY4DY1Y06OXbaWBQ34MgKAp7AUucUMQMocNjFYBjQJtvB20/
	f9yaKeENvk/6nDp6hPrp+Ew8NQn37crc=
X-Gm-Gg: ASbGncvcFMssmbK/CL6w2LmGjJy2VxRO2cupaNLHiBoDnVj38A/8nVqzVPzZHqcICzI
	Z7GZwcHSr2mYoGdMe0U/6783SoGJsz0Q3kccyOenZIg0wCXSdHZMpdJ3AwG0bgZpwSifIcL6X9M
	GdN+hNT95w9X9EEbYkHYrg7hYYOmPQ/pTbjyA4x/fg0MXqNV+b6e/PVGWFC8pw+grdu/9R9eMWe
	Uj9EAItwMCPMZhebKx6EvPyf8TIF3tGq1xw9+9d
X-Google-Smtp-Source: AGHT+IHzwWlmwlPhofR9vtCOjturw1dP55qMgSVbqBO3f2zFd/BL0vru7pfUMcsvroa/FhjGmEiwPsiEwaxaastVyKw=
X-Received: by 2002:a17:907:724b:b0:ae0:d019:dac7 with SMTP id
 a640c23a62f3a-af8fd773bc2mr943475366b.23.1753978370805; Thu, 31 Jul 2025
 09:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728160304.929942-1-vishistriker@gmail.com>
 <CANDhNCpp5DxzRufL9iVj8p0tpNSXG7WPEcTDpLbb2TzrY9HyOw@mail.gmail.com>
 <CAEOVoRwsHdAmn1d_SekD+ddWeUDJCooNsK_wDHxEyvtqkDXQZw@mail.gmail.com> <877bzoihsb.ffs@tglx>
In-Reply-To: <877bzoihsb.ffs@tglx>
From: Vishal Parmar <vishistriker@gmail.com>
Date: Thu, 31 Jul 2025 21:42:38 +0530
X-Gm-Features: Ac12FXz7w34-A-6I7UybI_pM8uVm8mpdtUN1ptsLyQ-s4j4fIadS69IIVh9buTs
Message-ID: <CAEOVoRxst5dJendvy-rG7+WFj1C2VtFXZP-iKQmfxC8Tr+A4dg@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: improve adjtick output readability
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, shuah@kernel.org, anna-maria@linutronix.de, 
	frederic@kernel.org, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi Thomas,

> Please do not top-post and trim your replies.
Thanks, I learned about this netiquette today.
I hope this reply is in the correct format.

> The point John was making:
>
> >> So it might be worth looking into getting the output to be happy with
> >> TAP while you're tweaking things here.
>
> The kernel selftests are converting over to standardized TAP output
> format, which is intended to aid automated testing.
>
> So if we change the outpot format of this test, then we switch it over to
> TAP format and do not invent yet another randomized output scheme.

oh okay, please ignore this patch. no need to review it further.

> For the success case, the actual numbers are uninteresting. In the
> failure case it's sufficient to emit:
>
>         ksft_test_result_fail("Req: NNNN, Exp: $MMMM, Res: $LLLL\n", ...);
>
> In case of regressions (fail), a report providing this output is good
> enough for the relevant maintainer/developer to start investigating
> No?

yes understood, thanks for the explanation.

Thanks,
Vishal

