Return-Path: <linux-kselftest+bounces-23876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C827A00BA7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1183A28F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB61A9B5D;
	Fri,  3 Jan 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYGhJx19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DFEEBB;
	Fri,  3 Jan 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919316; cv=none; b=PsT3u1HiQd95QOQMZucHszRMhKQEvvm77SIh7VmIN8LqkQBSetKvY+Ufy80ff1uaXf+u4RuRThcZuNMpHuksT4LX5DcWPJTfzLlf8uBO9jW9Bq91z452vYU5DgcETOPWEjEw4qjXE7YOtlmXUC9qbR81Nd+so/5XrKvUZ6cnC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919316; c=relaxed/simple;
	bh=v8XTnh3FrjBpDTGUIMIEXyZChw4qfS/sAiIqpIJcrdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQQ1GIRLLQicQG+0DZ9mrVAc4vMXQ+f0CS1R1ddd6uIiUZ408VyJq9SmpBy6gJMa4ZJSx9bbJ8LiuaMNMDPoRjtRKxcl1ZwWrevusczNMxARFw7UPNjpzTDNKqe1O2EFN4D5wsC1yPpacRMd8vCg3vpvAesqqmkpQnnLbbfSswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYGhJx19; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644db9f3cso17251825ad.2;
        Fri, 03 Jan 2025 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735919314; x=1736524114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ0ZFHg1UhVx59ziT2yB8Ah8dFaXGwOjNvAYlk4PRXc=;
        b=LYGhJx192dkS8KiwT1T9QAbH2m2P0XUUy0yIBzqyw+OyXxgV+Xx+/AJkLHvgkrMZfU
         H8LVbbj18S/K8JT/n7LWIS0lyclgyOlxhtvKaAEtnBvgmPaLLwQ4kloVVnCs6MRpGkSE
         2DsudxBcHmO14SZpgJG1xr4hH4oKMiWjVtX/lqqJ2rUNiJjMeu+FmCpP3BdHFnBmtsij
         VyI9QNAUZm2E49q7RakRdzdedMt338DwHJHf0ch3rmSU8OxvEYMuwX+AFXnY+nrljY/v
         aDIMRJeEthygOVMRSFDGRGeLpFjXSPyZzqPlAjdrhs97qjFD6VriPPYTsSDmm8oKhtRv
         l3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735919314; x=1736524114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ0ZFHg1UhVx59ziT2yB8Ah8dFaXGwOjNvAYlk4PRXc=;
        b=fJmtvRgiV53sK1Zw4Z33WlqdS7TuOr2haaNjYPkOZhBB+C8GaYz/SVAmfGPm06XPbW
         BTooUlr7utoGFznEn4+Goz7oiVLuEuCvaboDnfZdRTiFJrFQG1knl5/FvFKQusW1+bS+
         +l3nOy34ShLA6MyfBjWbYmi4RhF5TD/kf8VPUs/Mpf0HvUc8ytTH2wO0/C8X2I+Clzo4
         QWhzQDi6+30CcoQiGEGWAI9CmdSDA9feqEgj3Z1G0R9UWjQULmo78RLxXLBV6zziE5V5
         GQRLOAARokzYkmUP3A5loL7H65gZKBOsHuQQ6Z43ebfUn4vtLMuiQui+vp3QwOuwnYn6
         +IaA==
X-Forwarded-Encrypted: i=1; AJvYcCWF2AYqhKnCSPBAvphopzTp82iLwl1F1IX60AUlpWRi1iyNiUg8VA3nDpieh6+R0PTtxUgxUVNbnmgzNQ0fdGUW@vger.kernel.org, AJvYcCXCw/xpqTiPAfyEDKK3H7zKqD7YjgSkO+8+E/otLD7u3XTXzH/fm54AmgN0cTCERhes30ccjRZ5M+yBn4g=@vger.kernel.org, AJvYcCXdfkeRQc1QKS2NvFJUzgH6e5n9Wxg1QvTWCTqm/xoi/2NyJeBPAzXmP8pa4VD6TdYobO3tt108+mFI1LYvvTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoQo7HAcYwbUYhkrwF2pxs0msSpNqgb4ebx0aJDj4igcnaUNo
	0I/5aqjP/61G/bUCF+yfioRc5lkW/irLdMBAw5Xc4Ykus3ozqVkh/AppOFy/tWJ6cP3dX/BIluC
	Jp/tpUcFffKP1xq1e7bDx+JFjxvg=
X-Gm-Gg: ASbGncv4bhl4lZX+ary6bkVG5sfTmQt4GLyOIZweEGYC7uMSGAyEZqJi6vJJ4l+OTyY
	3R/wgAS4UCyMV/4YlxFXQCQFoWOYYvuP/gTvH1w==
X-Google-Smtp-Source: AGHT+IEC3Y25x4G4wmOqSarjtQ2yJi34gmfsmq4j2BPZ3BCrEs8OBCnu2HCI7EPfXTY02/zk7UEclFesfWjHYRHeZ98=
X-Received: by 2002:a17:903:1209:b0:215:a81b:42e1 with SMTP id
 d9443c01a7336-219e6eb62e2mr249842295ad.8.1735919314544; Fri, 03 Jan 2025
 07:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com>
In-Reply-To: <20241213081035.2069066-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Jan 2025 16:48:22 +0100
Message-ID: <CANiq72nekbmSond9VK8TVO76YdCV8BKX1nPzpHhNJTS_CqR-oA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:10=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> v5 here is a small set of fixes and a rebase of the previous versions.
> If there are no major issues, I'd like to land this soon so it can be
> used and tested ready for 6.14.

Thanks as usual David for keeping this one alive over time.

I was thinking of applying this or giving you an Acked-by so that you
take it, but I ended up noticing a few things that I think need fixing
(the recommended mocking wouldn't work, warns/errors with 1.83,
duplicated/unused `static`s, intermediate mutable references being
created), so I sent a review. The good news is that we can simplify
the code (especially the generated one) while fixing those at the same
time. I hope the review helps.

I have put the review result here too (in a single commit, since I was
testing and didn't expect to fixup, sorry), in case it helps to see
the final result:

    https://github.com/ojeda/linux/commit/151681df53ac8ad52086f6758b51c6fb4=
414427b

If you agree with the changes (at least the big ones, i.e. that I
didn't miss something), then I think we can take it through KUnit or
Rust, though it may be a good idea to have the result in the list for
a few days (and/or put it early next cycle) given the magnitude of the
changes.

Finally, it is not a blocker for 6.14 or otherwise, but we should
eventually add/explain the new features in
`Documentation/rust/testing.rst`.

Thanks again!

Cheers,
Miguel

