Return-Path: <linux-kselftest+bounces-36295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F40BCAF116F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDA1C2558F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44D2472B1;
	Wed,  2 Jul 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PncWELkh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40681DF27E
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451440; cv=none; b=HwTB8xxVJYmNPRL4RX4tWeg9acYbW2eCvlo6xl4v8QpTo1+CjB88yxRpDMxrpWMjxlCyiLrp/AEkYjEYtvbrRi5C5+b5+w+GtnhaSfrcIES8wziOaUgwOC0jsKYFmjrv+/WAb50LftmxxaN5oNHX2XCn/h64ck3KksH8BINkSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451440; c=relaxed/simple;
	bh=OQXKIEV7E/i3m2568pnhNxUhnfzOk+xoGPAzZX26p2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5u8YUHPubrFd34MO98usxDbY6bndQQojjzmtAk8Gm2TkBP+P1gQevo5SYG9uCIcvL0TegYDnOxHvHRuqambz0r/ySa1jWCxgeUG/wvDAtTRlBe+JNF24OhpRp+tQ8MxXvWyD8BrtmQvT+wYR7bpB5lZ4AiAcwshniz3mlHrJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PncWELkh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-711a3dda147so72151567b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Jul 2025 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751451438; x=1752056238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OQXKIEV7E/i3m2568pnhNxUhnfzOk+xoGPAzZX26p2g=;
        b=PncWELkhYStIDYvpkt+cmLi7ceI/MofG9FKaUWvhVtX9ofMSsD5BZAujzKYZeVgJVs
         t5HSNQhofqMPKHNfIeXWEvkAyYA0U9XM9KatJuTxoN0yDgyWnpndEdlu6LNMQQ9VMcqv
         PM2TTpOvd9+Elb+lkD/ben5swF79YAN7A0oxo0KEqxzpgA4c7kqm/IxPUbTGrz+0JFQE
         +N7Pb+kniaZcR9XiyO+hJjbksJ4dRskhEJ2qZ6kwndynMBfX0bdB2s/BNeUkGWgInv8g
         XAy/UbR9lmPv9+hTiPwuXkgHbjS05hVg7h5BZaPizZUWt7ael40h08qsla7QkOxMnRXW
         rKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451438; x=1752056238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQXKIEV7E/i3m2568pnhNxUhnfzOk+xoGPAzZX26p2g=;
        b=NhUhD/dFoNkUkVDcSnnpYg9r/78MYEMmTIFF1GI0KKBXXvnlvOh5yQMls8EfmM4Vfd
         o92uU9SyRsBkkMcXQ6Y45+iAC0khnqOjR9b40RQFpTwCQOW2SbSI+qnh6/ec6SbsMqDe
         5EQf/yE6es7qapIC4ixIoIZ3XVLCswjXIlUGRhSjFqn2ZFgoFQPeDVpYUMn/Zl+R0aC7
         FCaY5fJCRizdxCWREW1tGJ9ufNryvPM2HL4I7hRfVNZgq+NAwtNoCarIFVydbAPTQFmT
         XJ3EUkdsqsIGYXoZFDZeMOZpokm+s/H4I+IS6AZxkMZoBOPI/WMoSEApudMIAVOwGtZV
         pAUA==
X-Forwarded-Encrypted: i=1; AJvYcCXLhnqhpyvrxgc9cfhujVxZvqqx6nhUXW1FfqBsb6nnbxIPHVIZ6745R1KN/x6yRNFgayEntZKBaVH7NsGKgw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDJyIQXFEce/wP/kzW7qLyickLUXXljmhlf2ZzYRjZcLImySk
	fQq5RgdFIwA6jbFdJGBcHDqDQ32peiN9RGUdxlbBwMNgrS1dkfGa7t31nbe0/VxYeG1Cq38UgzK
	yGAEsOKoKglbMx0eVSf/CF0D1PNH13OrR32bkiFwHBg==
X-Gm-Gg: ASbGncseafGhUAj85ZrT9Q8WOPT9rJGyNAmLBaAfyPSQG9cIIFDI2LL3VVIiLGqzvi1
	TjL99sKfZ18S3YfTFAVbg4/RuONetY9Iz5Ya/W+tgPynPJAl2bcfF+gKE02ucGilmKmg3V5T4h4
	WapZxWuUdBU2r024o932AJon550ZazSz9X51IDz6lj93868yxEUrKuBA==
X-Google-Smtp-Source: AGHT+IFkxNQMKBmmJ9CHpNmpP2Eu7W4sPO7KthCl2z1kt7FCPHBJbjsCw8uI9+EZQUZEtSbd0EqItRiyQR16Ssqrmf4=
X-Received: by 2002:a05:690c:4a0b:b0:6fb:a696:b23b with SMTP id
 00721157ae682-7164d571f91mr29995547b3.33.1751451437681; Wed, 02 Jul 2025
 03:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701142313.9880-1-terry.tritton@linaro.org> <87ikkblkff.ffs@tglx>
In-Reply-To: <87ikkblkff.ffs@tglx>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Wed, 2 Jul 2025 11:17:06 +0100
X-Gm-Features: Ac12FXzqBxkveVShIhOUpDdDjk97AbKpwZ2ofDUlNcnP0hGUSjlvZVzO9wDFzKE
Message-ID: <CABeuJB3voQYT0FZ2ETBL_OVW6Lec6bOntLfKQd_J-huJJOyzHA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	ttritton@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Wei Gao <wegao@suse.com>
> > Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
>
> This is still wrong.
>
> If it is based on someone else work, then you need to attribute it
> Originally-by and omit the Signed-off-by of the original author.
>
> If you just picked it up and adopted it to a later kernel version then
> you need to add 'From: Original Author' and preserve his Signed-off-by.
>
> If you collaborated with him, then you want to use Co-developed-by.
>
> All of this is documented in Documentation/process/
>

Ah sorry, I thought it was just the order that was wrong.

Thanks for pointing me in the right direction!

