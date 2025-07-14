Return-Path: <linux-kselftest+bounces-37245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F0B03ECF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533523A2E4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C836248886;
	Mon, 14 Jul 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTAt0zcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7D20AF67;
	Mon, 14 Jul 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496538; cv=none; b=WSP+SrOLrUtkA52/yRePv9IzpAhPMzUOlZ5ni+gfDDJrNhTC6a2vYuHpFZO8Ah5kpf/g0fS+fl5q1z5Z9Go/Vltda7sCQe6Jw7+MAcsomlImZWNUO/fyJK2iDY7dwW78mReLpBF1WkHOfbq1Ry2pjnOGfIAigwOPSSoKjyg13s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496538; c=relaxed/simple;
	bh=rKnLYV6EmHmE3mzoMHqDHoN8VPsmF1S4gphrWDmSfbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGnI4HktYvVhhlJz46hhInURiQFJqVHhCZ2zSiBgiDGvEi+3y2J7xGP9hpHj5SOsmmWQfm+ZscV2PwtucXz9pjl+VEg31AQUBZ+8xYF/sM/i9rV9TWKhSQve2XoqulA3z1pIyCxo1OlFubt4zI5yD9HvFL1uJzDfN5lyNxgFFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTAt0zcR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7703239a12.2;
        Mon, 14 Jul 2025 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752496534; x=1753101334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JJkBY6StLlPiYYNcDOCRaSTmquHRBX1aQ9fP/9Yejg=;
        b=HTAt0zcRenTTuIAy7QHrcU+NnxaEGPRAQN9tSIyMGU2SdFMzuERaYQkPMBRCKOybbw
         0k8BpL9X/XScJYwSDCfdrF0KKHbp/B2nEzQaxsXKA8/NjJi07ke0ijq29Vl2QIRIC6Yg
         QtV5qHL8h2Z/PvebG+ICoQfRVycUlL4205resx/Nx9/PJRBdVjQ9tProGmRMUnovfDnu
         igDleclR2O207edI+QvD6KfccH+f3bZOX9DCtIW8amYahRj0Jkhy55yLUIkEPFxNskJv
         MKt44ZoyH/p+yH9MZ8tAUa32+X1//Fmkd3shyBAJ7UnIQdtxehxMNpWN9MT7eVBbiLeS
         eBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496534; x=1753101334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JJkBY6StLlPiYYNcDOCRaSTmquHRBX1aQ9fP/9Yejg=;
        b=kYJ1xbP+l5WXe9PtCXHI5Zz28Gg9Um6sBSTxWHHdhRSJ4ETTJAbKveK808FeTv/nVL
         OVno4qOQhqxodsWPRdWXzAwftXlbA76ENN+6Gd615nIxQF1kIDUNSUhap9dF9+OYr2Y1
         6MOltHL2uJ+G4QP8CECKG8A0MBAVo0ogsm+7WZV0wUKl8DXxkm4MSvUlbeWyBTCZBz/o
         sXYG608Q0TiiNvY9c0YVjtXPV1vbFgPw5IlkZ4ja7FPODI483JNJgQeFnap1LCXochuB
         PG+sl6Umwn5PJ5j8pu1xefw6hGb21wFAESVQsPm2babWBIe5CoHuVbv5koU1MR35a0au
         FmcA==
X-Forwarded-Encrypted: i=1; AJvYcCU+3RgLUvf2NiU381lhtaSRkoWLEdJpTi6FmN8UGTjCURjAn1kRXksGHdXGZTOPvQMrhRWnTVEji3NeO7mb@vger.kernel.org, AJvYcCUhGBCuCfY+pNyWG4OtLUYeyOkH2+TEqGj8u07G/PaiJFSobQSiNQMWwPRqG0kv2pWonmTftT5DAOE=@vger.kernel.org, AJvYcCVNGUiRgJa3d4MjJmaVQ+3HaX87Bp9agYs9YFc2L6WcmqwYdSOLBxJjMtwamlkoud5eO4K3Ff3B+5ez5V3Jpno=@vger.kernel.org, AJvYcCXLlJTpvLULoU66O+bpqEMLejFaWROSk0YSdyYGrL0gALk/5JPT5kq5dSv+z85/24HS4J208GZY1OCi@vger.kernel.org, AJvYcCXWrTKpfQvGrIzreTDNoRWT8uqf1C9majubdMA6OSC+Jf7xcZlbg6GxVW58nWPR7a57QAT+tHtp@vger.kernel.org, AJvYcCXiSl7mbii0oZ3nc6nA/32wlOCYSPyGvILEe7z62cuowD4lTHCWwMJA0f+0FsFUBRdaXF8zBI55crjEIu72uZOc@vger.kernel.org
X-Gm-Message-State: AOJu0YzRY67yT44xp7eMkHjBIKftmuf6PvahA25X0nhhrlLOVRwLkJAc
	3WV3chcsbeMt8Fdf+jE1p5ipzRgnf/6E810wE02yVxd4PUGNnF0fY+dxpcD24QhYrIrgjaSzZRq
	SDjZqXnxEjMJdIC+UsAG/V7IILal3WHI=
X-Gm-Gg: ASbGncsQvZBOTswBI3UQQaNwNy/oQT9c5D1K9S+CfGQlIjQl6+QKPqFvbaO7gSssTgr
	A0bXv80UYm7/ueigk5wnlIxkTD2Q1WReGvCRFOCRjuUnbmx3NjVUzsMhZYNADaNffhPgZC/W2fh
	XGbyuZA7vpTS9w3QyD9Y3BNZR3H59n4XsM966fIcnvVYwxZQ4FbhhJSGA/rH1Vg2zM4fJN2vM6r
	rE1wiBgvyoW7bXzmU60uFOCsddBf1ZgScURuxKR1sjCYiMXbaAu
X-Google-Smtp-Source: AGHT+IEHpxC5111y9Cj6JQaRaXgMXbAFzbh9lkbxM7Yb2ILuf+3IGoAWfMQm4cez9+Bj4NXuw+pe+X+/AUAJqf9Zudk=
X-Received: by 2002:a17:906:d7d5:b0:ae3:6744:3675 with SMTP id
 a640c23a62f3a-ae6fc0c3796mr1235555966b.48.1752496533691; Mon, 14 Jul 2025
 05:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com> <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
In-Reply-To: <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Jul 2025 08:34:56 -0400
X-Gm-Features: Ac12FXyt7LMvW07NA5KJthMOxTToFChah-hJr4NBCGuAbPJrhV6AWz6kEkIvvTw
Message-ID: <CAJ-ks9=ZHtzeyyFSZaVuA1t-3C8-hc40n6r8qFWxn628qT-OeA@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method names
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:11=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> > Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` b=
y
> > avoid methods that only exist on the latter.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1075
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_panic_qr.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This doesn't look like nova-core. :)

Oops :(

How should I respin this one? the subject should be drm/panic, I think.

