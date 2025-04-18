Return-Path: <linux-kselftest+bounces-31160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FFA93C00
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DBD1B67C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9D21517E;
	Fri, 18 Apr 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilP5BYNu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAB2AE8C;
	Fri, 18 Apr 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744997529; cv=none; b=oyNMut8OCw9dUTmqlDYh/W/BazIx7MOa3As8Tu+QGYLsiVnWMp5reINf92S3rTDNdlq6xjBAUQmG+PdECHHg+1SXNYV4WrYdcfILdLwTHL5lGvd3vAbVpcv9W1x2+pwI/EfkDqL7J7/GPdT4sl8AqpQEiZNPWWCAGRL09YmQNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744997529; c=relaxed/simple;
	bh=jSTCp2ymmy+uFfuftaWDUvFGRj6+FZVVBdAZvDVOzIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvptZ3dNQN9Di+UrP277dJrfwFC9Tu/oTilUlZYSSYnP8LRwevuH9w2o1Y1K0i4/2yzIQ2wAX8IrvQpO3Xf/WHBcfdfrrBTOIHfUsflfEDzHTt047Wdt9BXYLBq3HcmsqHNbLgtcFmgJi5rwxoVc2asNwbcUS67L1mSrjBPq1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilP5BYNu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so454393a91.1;
        Fri, 18 Apr 2025 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744997527; x=1745602327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clva0yAp0RoLW6mZT6T6ibUR6yq4KrFi2ukw098Q4NI=;
        b=ilP5BYNuMPdDb8xPKAUEUcr5sI+43CrdbQLn+tl41e5LjbQfhpRGie6YVL5AEK9Kwz
         BeT040XV1/TJWryqPyB+dvZSzV8Lyp7w1ZpRKMbLiwDujrdc3tZEKtWJTmwb65oyWTfw
         N7+Tcog7mE6Do6pLFQMhZFlYqxnFSYiSZG6n4s8yg7Z93Ns6v4AkAnWYxSHHKU6s8lRf
         +feTXcTgaDsL8/4IV6Z6S125QFlYpeHgNEu4YiSChU9hqaHhFnRuSZESgDtbRk/Q2X1h
         fZ3AErZzta9Jef+21N3V95DP/VV5j6nI0vmp5XXbTJulOsYfgpTP/43hy8Ex1ko6xEqp
         kdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744997527; x=1745602327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Clva0yAp0RoLW6mZT6T6ibUR6yq4KrFi2ukw098Q4NI=;
        b=TsbCSVwmjIRHQ3nLsaIZlHRT65ZPm6Wei/V4VBRtspXlEp9Wx/z69mi0shkdBQ06Xe
         xWgR/8pHN/TiQ2iyvSkMacHdyW0n61aHn2YCMPLhrjEPhVgXyu+hAe7Iuefba0ICkuUO
         rGXXiJrtQbP3o0QPobHfj0XjVPFWx06CCXpL+yW5SK29s/OcUUoGnoBWYr4lAJXvc+xN
         d3jHHswFs9ioLZEL7WVUshT4igtsPzgRNbMRX1t9Bhub8yHGcTcus+sP9MHKtKe23GQQ
         bEb1gpyQwGBDDO8WZcLKBmJU1lwWep5BNo7nR0dgEPLvDZpKAvlVVCbhlMjOB+2heAma
         ldyw==
X-Forwarded-Encrypted: i=1; AJvYcCUtGnUpQ/vFx4tqysTolcIN+1HAVfenVbT0s5NPothUMd8ZzarrfqznHQIqgNghl0lx/deE@vger.kernel.org, AJvYcCVYOpBfI1VNBPLpFSOoMqcuZpRg58oYOkqWdoA96yTaDW2t3zQSiMe27PF+txXsc7G7B//74p1THikHrqDAvk8=@vger.kernel.org, AJvYcCWWxhSVMUPpeB8XqhTQ+jV1xJ7D+URlOLpKbXzAM6fSYYXisU2FXENhblxV40z3Ivm//43vpXd0UWnsUAzR+gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBic/IG3Iw9/7T9rl+Nz4r/RTDPwPO782hjyUcuXmjB86mqDM
	r35K7iuFNz3l/sOTG+Fv9oZuwOD7JuDhfgNpnDMoNMCnazuXu6vK91soIJFmzjoiRE8rl9ZKsp/
	/nNd02YbHhmrx3TtoBgL85tzlZEddNF2a
X-Gm-Gg: ASbGnctjcaJOT41qMFsYaldjhO8fGA2M4WkyjbWOymP2Xp8FZTAJ6DnZnCJQBGOD653
	QAa+zcv9cxlc7TGd9Xs2Jhyn1PGprOMFu8H+dws6YXgljyKUCKa4IHCAiOTzw8C6qsVevyin53I
	flQoAVlBIH/phY4hqCptxhHQ7qj/hSPCjZ
X-Google-Smtp-Source: AGHT+IFGCB+IOuDYclJ8K61LbsGJh6E+OoMCYw0lXGpYH6TLuQWhjPe+Saon4Pg8jZd7JDF/yt9S0IEpG25rHBQctZ8=
X-Received: by 2002:a17:90b:3b82:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-3087bb313f0mr1841717a91.1.1744997526982; Fri, 18 Apr 2025
 10:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418161005.2425391-1-joelagnelf@nvidia.com> <20250418161005.2425391-13-joelagnelf@nvidia.com>
In-Reply-To: <20250418161005.2425391-13-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Apr 2025 19:31:53 +0200
X-Gm-Features: ATxdqUGpUf8fRAb7yDV88wH9iP1OHvfJ7PWdDSkSTjg_35u6EVKbNRdG09rwRpM
Message-ID: <CANiq72nCfBdsfKzP72DWxLBh+Eueack9sS-E97wtsr0UtkAnUA@mail.gmail.com>
Subject: Re: [PATCH 12/14] torture: Add testing of RCU's Rust bindings to torture.sh
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rcu@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 6:10=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> a rust_doctests_kernel kunit run.  Note that kunit wants a clean source
> tree, so this runs "make mrproper", which might come as a surprise to
> some users.  Should there be a --mrproper parameter to torture.sh to make
> the user explicitly ask for it?

One may run KUnit without using `kunit.py`, i.e. by enabling the
Kconfigs and booting the kernel. Would that help?

Cheers,
Miguel

