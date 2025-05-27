Return-Path: <linux-kselftest+bounces-33829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53739AC45A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 02:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738EA189C400
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3BD1853;
	Tue, 27 May 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDRmieMe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2F366;
	Tue, 27 May 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304545; cv=none; b=sbm8ytcakx0sYPBsREeZoqkHY9a9CEYJtVuLp5oYleaqdn4ZlZGxzYSInb9i50yHcBOPV9dAGYIMsmXaPsR6R9ftFEv5AVkQBu2O28K/Zo6GiPfi3GuDRqoyj/FXPyletEt6/kBJ6JJUEy9srGOKpyWSwO3nRtIef2Nhq1TEfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304545; c=relaxed/simple;
	bh=2rzQq5yLfjvOmTTYtmk60CDfVK8FMvHBMNx7m1BjYnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3tgUPHJQ6S5pmpV20PNEyaHeLWtITT82dCNDFxd0bwLmPvhWV94eP3aOBZEdZ7mR8AWWn3tRIaXj/Y+ONx60d3XF10iFC6z8GfzIZdjTj+K013O1ydboy7Mnm5H9G7VNs2bBmOkuuJFfJxrPKn+X0GehVkjOrhZoFnlY5s7xXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDRmieMe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3087a70557bso489413a91.2;
        Mon, 26 May 2025 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304543; x=1748909343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rzQq5yLfjvOmTTYtmk60CDfVK8FMvHBMNx7m1BjYnI=;
        b=VDRmieMe8dGdNwS2Lwrv6yvjOzm6ni+06kpAnnyG49zmk3RVfAWrbPuomE2x+urmek
         hq3gvfO3ZKy9H0UkCZ08zqmc/tm314/5QanPNw+MbjyQJGpPtvaStrH+f7RS77mS9n1k
         3lxYU241vulpDEVursg+xLuA2H+M6duZ/6xtJwdSSTQbP10eqyNbeiQ5lcpXtlJH4aSZ
         boufNC/O53k+xCXEfl6iGtsPPIr+z6P+wA6upZyi3vH85EDRplfCj24gAAZ34jP4uqDs
         0hf2kd2L+ywF/66JLiXx+9JBVLv3a3huH0vSPcOlEbfgM2PYRvB/j14S545iaM59KTci
         pebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304543; x=1748909343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rzQq5yLfjvOmTTYtmk60CDfVK8FMvHBMNx7m1BjYnI=;
        b=Cobyabj0tVIeCLL2QiVlHG8syfcKNYhqu24UHxA8xVtfYVgq4clPz68gcBfhRfKOXo
         3cPtdFEM29DmyhOWKnFJeeS1HK4d2Vybrw7Xg1FSxtdyyfH8FxzPe/VrwmV3WhZmQMso
         86mVcCf4ve7v4OuK3EkwERfUcCmIVc+CK7yLxb+HwFX9RXs5mfl1il5StCn3nAywebSd
         1mhQ6jfoEl+dnJFboKQ3rzMcDFLA46Mg3O/GQtKwGPqiR++GL2FmhmGLZSjMqEtCLrhI
         219MtrqxKwad9gE5Do8OQ1upks31/xsCzSFFBhfTwCimfqGJSMK6HY+d8rV7hmCSMSIl
         2F/A==
X-Forwarded-Encrypted: i=1; AJvYcCUy6YN7cbHTqCGCiCvF+JO2rVvcEWSXNcly4P9pXpQ6QhRYF1XIL0/lKklwyJgNjx+M2LNTOojd1oHw8KY=@vger.kernel.org, AJvYcCVK54hpsMoin9nEMdxhyectoWOtgTXWUSyqG+aA8fAyzbvawkwWPOdIPHaKSeAa3+XYlTisWgD3OaY4N+CEegGG@vger.kernel.org, AJvYcCVQV975KLtIxWM1KG9mWI8p5HyAUOxSAbitYjIenvcwV40ygKVL3Uh+xjWz6UlzTbEFCyBexHaeVsoUJZU0LhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSfPPfLmJHTYsvnEhMZdIcP++GaoKaqjSL/J4f9kCnetZKb/eF
	4/HSsSz/xvnFcO6TT4ZzWeZ+5IjH6AfshSasl5vys0wWJyYKdtAo6+FIy85+DUashYGl6o8DvDB
	gXf4KkXkxwJA6xXjdQ2vHDryJi2S7vwY=
X-Gm-Gg: ASbGncujQ78NHV3IjDENouWOGbUTfgua4xEVlYNoKaVmUB6iYfgcl9jmPb3i3OFuiKX
	IOUz0QdnrOCDKDVflZHkufJ9WB2jGcLx0Z8BS+YV7CXwJJ2dwoPNQ/Y1LDS8n+tsv2M1l5IXIHY
	gNlBxOYvC/YxKwJT3B33n4ri0PvtHkKUTZ
X-Google-Smtp-Source: AGHT+IHY6vduokEbcDZbsaJP+Df5U3wkP1/4ZR/q0IrJRApNtoX6odgNCZguNrzIkQpVmMEUhIC4NLmz4dpXZUFw1Hw=
X-Received: by 2002:a17:902:cf03:b0:21f:356:758f with SMTP id
 d9443c01a7336-23414f2f960mr66050825ad.3.1748304542991; Mon, 26 May 2025
 17:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-2-ojeda@kernel.org>
 <CABVgOSnTYwYtoMXCC-mUxV=A2quCrA+CD1Qe32n=qddxLKpcUw@mail.gmail.com>
In-Reply-To: <CABVgOSnTYwYtoMXCC-mUxV=A2quCrA+CD1Qe32n=qddxLKpcUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 02:08:51 +0200
X-Gm-Features: AX0GCFuLlqQmhMR9CPFwVVMh5b02Mj0zAcZXwOB02-yOXPW14jBMHCFaWkavBk0
Message-ID: <CANiq72nhr24L-yKU8rFjCRTeY1yJ2FGNYP2RfmO=_+XgLgHFTw@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: kunit: support KUnit-mapped `assert!` macros in `#[test]`s
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:02=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Nice! While I do think there may still be some cases where we might
> want to use KUnit-specific macros in the future (particularly if we
> have more complex, multithreaded test contexts), this is definitely
> better for most cases.
>
> I also managed to test it against the 1.88 nightly, and the message is
> looking good.
>
> Reviewed-by: David Gow <davidgow@google.com>

Thanks for all the feedback and for testing it, David! Very much appreciate=
d.

Given you were happy with this first version already and that others
want to use it soon, I did a few final minor tweaks and I am applying
it.

Cheers,
Miguel

