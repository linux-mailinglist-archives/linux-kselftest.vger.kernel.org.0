Return-Path: <linux-kselftest+bounces-31305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B18A9703C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBEE189D188
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D9228EA50;
	Tue, 22 Apr 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1seoP+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B0EEBB;
	Tue, 22 Apr 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334931; cv=none; b=OFt6RvxrgBAK1d1uH5ZuXbFMb7Pu1NRlLjSDGhtbqX82u9aRc8u4+oFCrW6oK4x5sdZI7bsjOqmaue8Rk6MdbD48UEK02BZ4ZmuBFJ9wiLUpWUl9wSUUF5Ri3IbcYwzki3c5l374K0uugZngZkqJV7ZOV6kxfQ/SIagb2UZOzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334931; c=relaxed/simple;
	bh=zZKF9nOH8sEPJErHTOsvwYFx9dUfb3L1BJmkI6VuiUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQsLCmduvc+NTPoXud6xxbT3R6pkkO68nC2hEx3SnQz9w4JWDCgjHAtHxxf8Jzs71jbbgl5k11KiX+Xb+/Wz98N0WXbXr2Jnw0iQPqn1DrafS+kqIWm9MGXMi1vBDdimz7CFARG+2fKbzaw4POGZ2Qm+5GwKMBO7dD1WfCFN0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1seoP+A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af8cb6258bcso239816a12.3;
        Tue, 22 Apr 2025 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745334929; x=1745939729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZKF9nOH8sEPJErHTOsvwYFx9dUfb3L1BJmkI6VuiUo=;
        b=Z1seoP+AZVnbXBhyUfCB5LcGeR/jQwabr+dVjCbLXVgwwBtYX3fHEbWVrxb+z/VIor
         /1KXQkom5I1Mqmzupqc7HjQr5Sg7ISLOO+YTkUboHFAatku/Li1/+XUEHh0cw4iev5I7
         PS9yMJGIa7HF4+A8WxdaQipy/OtcpWE2HmytJSID++6qHYjDRqjX+W9nX2Dzw7e21H7v
         3iokcj/DJ2ezKxBY2zidC+eHC20IgmAdc4Xh8hOG1VMgw15VYU6ILbHkBKt1IcMQC19r
         tQEHi0rH8dQQ3Maa0OGycOcan6FwnNSIOqo/DJH7aS7PjMSkTdaJ5flA7THRVlM0aBx1
         J9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334929; x=1745939729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZKF9nOH8sEPJErHTOsvwYFx9dUfb3L1BJmkI6VuiUo=;
        b=r+DCZHJixW1FxhfWCpLsiremgsGnIf3NWJptAqcVdt6CktPMODu92KveFQjcc8wzjO
         SAmRzk9bSimYGFSrcT5U/3p3dKi9I/NRy0AgQMKuFQdtk4hPM92Nv6z2dBf67YYGR9d7
         pZvXaqEoPXM5rVUR2RRFeE446szAtvwV0KVF7Q460F3COq0oSr1bNTnl/hGjRtHw+6/I
         l8v4BGTiRAVmBs0FE0/LGMMyZLf/yuyf6J72FpRnzC8gDkZ1lC3hxon45+t4/2+mBH2a
         8f72ZRYP4tuktIwrqKPgHRm1JD47PR3TYXHkFytOvTkaJRxrVHF31Z6H9mYDrwKNCUcn
         3WeA==
X-Forwarded-Encrypted: i=1; AJvYcCU8WoPXH7Ly5lHdsjLzD3BjhUdiLkXNiSIvRIxY/JvSpFo+kPMoDiCJXGeOSx+rCYre1tAgg4IRnBjCtrCb@vger.kernel.org, AJvYcCUbk6jUOADrQWGooGnCdGaowN/f52dCs0sm8u6u1dSIRnffBuxI+uq9YUVa3RcLtaBqgZw1IJ3xMirIZjE3CjTV@vger.kernel.org, AJvYcCUevxR7Ij5CySBz9r95QYMaQxRCQDeF5ld0jnxwO0Gb059dwTQk8Cn/E3roybov1VKMYHWFpPMDfU1A6bA=@vger.kernel.org, AJvYcCVtqx1wSdGvEaZrAQK+R1ZeaCxsQQUfli3Nm09aldhyTQ44ATI2X1In8HbC3by/CTtbc83gOvBiS/sD@vger.kernel.org, AJvYcCVymSz5SKJXWKsHsTdJlNS0fxYADwqvkKAwaFqOVw5tUrmrgekxF6XIgEouKytlrqOC+sKuBZhNvubBfBhuskA=@vger.kernel.org, AJvYcCWKgGM6Z007qiWPCPjpzMN9VDbE4tSoMbsc4msQgiWQ6uKcT9f8nosUyH2nCI9ENcJgBevrpsv1JTBz@vger.kernel.org, AJvYcCWOH0OKf/VsJ4z6o3vufLSv+qRFC2UNL8/pJJ5M+GDc6WX8caXYytMb1Ttz09eopP5Cj9BIFBmpfXHUytwM@vger.kernel.org, AJvYcCXViCqsSfu1rijaOTBgaKmZqlGH3yjGiWUFadRzCF49g1UON8ESzM/xf9yTPUlY0XlAC/6sZfuH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+lng6FjWA2ZOhYq7FnlJ1f2Wzgyb7voiCOODwmVWV8sfO/IWw
	+U7z30+fE1/GJCEkxtIyLznKS1+hWB7534AHVH8tzP1MxwLGQHoJ5W66iJwSQB7ucIdrgAaD4I9
	nKpNTY8NCBb26hMK3TkB8qP2ECYo=
X-Gm-Gg: ASbGncuxu90GAftl1muSeiY+m6S59aO7p3e9MnfY78sEvaDHab+uDTTo/7OTRAApnHM
	pOHa4/BkMN3vMVoP/x/Nhl/OVgfrbHLTjsgIKW9VvUV+I6LtuO7D4Krv1grES0TJDd3JnZ1G/2U
	F3pgHvzQaBWQGayHsoN6prGQ==
X-Google-Smtp-Source: AGHT+IEuT6KxYsdhSw5cCeMrUaqYdXW9YE/wChmli/G+cfCYNzLRiA7m7gmwaKew+OoBnqvuuEbFo8HJGHR2tvaOM7M=
X-Received: by 2002:a17:90b:3501:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3087bde06ddmr9204562a91.5.1745334929331; Tue, 22 Apr 2025
 08:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com> <68014084.0c0a0220.394e75.122c@mx.google.com>
 <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com>
 <680160b8.050a0220.223d09.180f@mx.google.com> <CAJ-ks9=TXjk8W18ZMG4mx0JpYvXr4nwnUJqjCnqvW9zu2Y1xjA@mail.gmail.com>
 <aAJrOV88S-4Qb5o0@Mac.home>
In-Reply-To: <aAJrOV88S-4Qb5o0@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Apr 2025 17:15:16 +0200
X-Gm-Features: ATxdqUEzkXpfnBhiY7k29QsDY3HizJvfa3BhU5YB5Skka6eAvbENy4JVzwfqVy4
Message-ID: <CANiq72meaJr5noasX+4p7r5BM1H4tCa33eLrsta00Vpk-cF7VQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] rust: enable `clippy::as_underscore` lint
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:09=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> I'm leaning towards to 2 and then 3, because using `as` can sometimes
> surprise you when you change the type. Thoughts?

Having explicit functions sounds good to me, and would also help
migrating later easily to anything else (because all cases are
explicitly tagged and easy to grep for).

Cheers,
Miguel

