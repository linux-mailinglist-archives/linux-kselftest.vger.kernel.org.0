Return-Path: <linux-kselftest+bounces-21327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E739B9AAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 23:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CD4B213CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD41E47A4;
	Fri,  1 Nov 2024 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OACfuvdd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73215530C;
	Fri,  1 Nov 2024 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499141; cv=none; b=baAnTXuqjICy59Vu27spA5p9x7z0bdh/UBzjeKqITHQbp8++GNn49gvMdKd97MYqNUY8AD9O0Ua4PPGd/WpCvaY88K/bCZ7/gwHYg7uVMkVif4uNE+3IHMTLFsiR3hHzhuMtId+lUXTeWtRulM/vmN/Lded93cAOlvToxRf3iSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499141; c=relaxed/simple;
	bh=jrHrXNcJXEleBo7WHCMjZ/WP9sEVZDbGwZRks1LDFC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmbx2a2pp52/x1PB3y+Zg1vQWZRQ0/LQF6Pqnx968p7ync1r8gnG4MMXeZ8Z4yKhx1lI75FvzKRIeZubITHapkIkyuJqTX4td8jNPZfrvX7gt5uEUiAO9d2uDWcvKwA8OEK5MgjTIfS72IF/GiKk7sZ+drmnNJt7dIthbnQaOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OACfuvdd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso329769a12.0;
        Fri, 01 Nov 2024 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730499139; x=1731103939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrHrXNcJXEleBo7WHCMjZ/WP9sEVZDbGwZRks1LDFC8=;
        b=OACfuvddvVS3IU+LhXzKSR6231Y5f39pZ7yAdEzj2TdvJhRWLBB+ufC/32Xgfln414
         6Zc5O24JaH2iGmchs7Y6LTjUEKb3dSGPsujFZUWM/3X97XT10Ya63CzVDRIkrZhn8Yrd
         kgrKpju3o5eQsr2AlmQda7t9790YCjKKMDy/IBRxSOa1w06gMnf8oT0RX1vR3a0yUMiL
         p8gHjSWRpzp3rw4nK047cT2kJmrtIrKBK5dnDUnoa0s/mKjlilaRAqsPDHqpEa8PBNUB
         u44uNBR5aPA/8i5/we57B5xRXY81Se51rS7ZXJVdvRmOTIbS9AdrANmA5TxLoVnEUNmT
         9wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499139; x=1731103939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrHrXNcJXEleBo7WHCMjZ/WP9sEVZDbGwZRks1LDFC8=;
        b=Uyeax4nBhvzVWNs6LJ9xD8LKoMaJzxrehJur+EiVPe0ITUImhMXeE67ZJiDCaM1/B9
         dvkQEX2Th+UTJGNSBlhyPdVE5D5qxnkaXRLPRnHaBeQju+dRdVXyeuR1Q5k8taxYQgEE
         kUHg091lDlnke+l8W00yofJ0kj2gnjTzAL0G6GCWvjbR2pQ9WS9DyDuiLFcxSlvUPhoz
         OAigSQv3+6mKsmNJLDMNgGY1qRc2C60jDaQis0ju2CiNWi6krDy9MOp2UY3z1IUeHmyB
         AZmlFO/L8KEmyruO9rPLOER6/6LKaFNZ4I+9zLnKkJucCU1Julo/PVojUndhdJ7yOVjr
         lm5w==
X-Forwarded-Encrypted: i=1; AJvYcCV2jnZ/r2eLga3QXiQ6TYxCzzKnVBJ9jH5TPeLXGxqnb6+sKQtfWLuZ7/aP8tNCVk8FaNrHwkwnTK0ZFks=@vger.kernel.org, AJvYcCX9UnM8X9r5nGNpRfF546eZ2pjVPk7cAlUnwSjyU3NzQ1NtYV/59133tx5U0iMCWLcyZjXaXn885McVjDuQeHs=@vger.kernel.org, AJvYcCXe4iIdXknqTUT5p0KVA8Pz1dWcqqkDiW990cuqibOCGCdH2s5IRQU3zJY15rFnGZoc5Ys9o0FoTEjhKe3m5BY3@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRCigo8oGj4u6hOizhxsYsGCeq9jyF40wdNC9cpKFIWN9eRgX
	pM1TXAMYPf9uVJhSo7iPF+BkUQZbWeZYYBigl3l5Cy3xpvBm2qRXUsPgs7JZDU/AY1MREXvPV7v
	gSmu55VA6I/pQOlt2Ke8fn8kTu1g=
X-Google-Smtp-Source: AGHT+IGbzI0FSdyM/W1ca5+W6TGSUXsE0sQngyXB9w6UKxrgjGeJMonRfnhMiZSdH+yF1zTTjCy4laa9KLwkJQGhYVA=
X-Received: by 2002:a17:902:ce81:b0:20c:6f7e:2cb1 with SMTP id
 d9443c01a7336-210c68db903mr145998245ad.2.1730499139404; Fri, 01 Nov 2024
 15:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com> <20241101064505.3820737-3-davidgow@google.com>
 <ZyVKSKUq_bKH5jn_@Boquns-Mac-mini.local>
In-Reply-To: <ZyVKSKUq_bKH5jn_@Boquns-Mac-mini.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Nov 2024 23:12:06 +0100
Message-ID: <CANiq72=yhH7MEQWxVSVXGa5M5=HXudtS0Xja=w7ViU4Ph1Mpdw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rust: macros: add macro to easily run KUnit tests
To: Boqun Feng <boqun.feng@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> but this lint doesn't make sense to me, I would say we just drop this
> lint?

I am not sure if it is intended to fire there (i.e. to resolve
constants), but seems OK since it is not something one would want
normally to write except in exceptional cases.

So we could drop it globally, but if it is just this case that we
expect, then I think it is better to just `#[expect(...)]` it (or
perhaps use a different example) and then, if we see in the future
that we have quite a few "trivial" comparisons like this, then we can
drop it globally.

Cheers,
Miguel

