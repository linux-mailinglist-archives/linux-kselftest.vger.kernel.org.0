Return-Path: <linux-kselftest+bounces-37780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC493B0CC17
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67BF1AA5E04
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99E23AB85;
	Mon, 21 Jul 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYPNb6bP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39401B4242;
	Mon, 21 Jul 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130975; cv=none; b=m05V7HfHZUH0OJSCokcKrzzra4IqMSpUNw060/AoLqQnj2ItNHH7dytkLJ9X0TwFs8J5Bd98cOl3qZlZT6sn9Pxw8KizGoN8XX3rWMoIUfcD+XbfLqxoJ4hTiOffIhyCuECszBK47XndE8XaUTTWbFvArv6WAawfOCVNB1LOrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130975; c=relaxed/simple;
	bh=Jm4/f5kXKS+Wl1CcII+41ZXoz6y4+E758tZ9swKVMQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+a/a4gGDwasNxLbdzZisf9KoNAorPQxk44+zrjzKKrn3Ko2UlKTaWVGarGFgBxg+3wTYVIC1fGktnvNyga+AemDEdJpYwwvs7SwfWwhUQMLFh2VvJplcIqdVJIfyI0AJcEk9cqG48lBCAgfsGWZ0I7eBvlVCW8JJ0kR7Fw9klM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYPNb6bP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313756c602fso944364a91.3;
        Mon, 21 Jul 2025 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753130973; x=1753735773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm4/f5kXKS+Wl1CcII+41ZXoz6y4+E758tZ9swKVMQI=;
        b=EYPNb6bPD2Q88Pi99uq8bOWN1khOfdFoCPE9cXE5+5g88t7v5LHjZ60VbgLfa84I17
         M91JprxHaefCkg/1H9sa6BkGLSYSM2QaFxD9YT4z6jj92fv2dCYi6Mfl8djfH6l6Kem0
         9257kJemoAiUXoSvOE+7w0C59+et641IiuQ95NOo7YeW3g/chM9B6Cr3jvjRUNNCZxq6
         e3lO6vwkP6Ld2iXn3GJfUSVg4xJA6Pa49D3RVN2SqVMv7WU0kN3qq4corBdD914nfJmY
         ReZH3ix8CCb38knP/lKWJaizm1mlfmrT9jdrsH+J5xCFO4VG3R9ea4NjSnZl5IAgK2ZS
         +yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130973; x=1753735773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm4/f5kXKS+Wl1CcII+41ZXoz6y4+E758tZ9swKVMQI=;
        b=NOaBSJmwoEzYerfqClggKjttIbIbfoX2HNmr11de1ybna8o7q9LWwsgkwaxZWY0hP2
         MW4nyMLBUuujLGcqnztZwdcBjKM9QRwQRyKHP+7DVv8a2Tzxx9B9+CmnnQZm49+bgm/p
         hk//5C6+CCh/jxcscHRkTThpeGfo0/AmgIW3jJJtm8EH3WAHxnGXInD6bV6i28rm4ne4
         sLwv8SMAsD7OpnMJXEYhy2gdR3gVy8jIQFDjKrLWOxs9fXYTMmPFrF9aeoRTirzwDD6p
         FoWzhHrO5w0oXou4FcmwbkWQULR50AJpIDKIhL7/AEXBhf1wXUTFOaesBMCwu/XzkWNV
         S8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ30gdsVrC48jt+v952B14GUiKkdjfWDWbrHAUkT8QUzINedI545OL0E8Pmufaqk212jvnrRaW@vger.kernel.org, AJvYcCUbqZat11GBrfJOCY4p/qWA2TuVPINL4wOlesQ17ij6mQHbDj22rrn2364lwT9h7TBp7qw8qCe0wYgGTon8Y+8=@vger.kernel.org, AJvYcCVQHv17a54c8oGVs38MJPS3oL57ucksbPKw71oWPY1R79bm96Epi9TNIEMreoI9BrOhyFnsDdoJDFiYmc1e@vger.kernel.org, AJvYcCVphFqyA5bQYVihQ05ZPbh2tyESKBfAK+cUceFuUVXqEd47FR8rhFBhzIdLXem2bjfIeF8/my25LElI@vger.kernel.org, AJvYcCW8cVvtM+C1406j6sEBoONqlBnG1cjycZuMfgXDwt4ic6qSgQwIRWiP6YxCxAWM9Bp89QVAMFiy3Bk=@vger.kernel.org, AJvYcCWc4jvhhl7WtURhYio4uFlSJwRgfnWnQETLFfy9X/0U9ilVc5ukgheVZUIpeH5pfISEmShZp1PWay0gaMvjhtTK@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhQrauNQ21kuehqBmVwnPWkQAzHT8Hbpm3oLC2MzH3PqPYP2V
	dqBB9q4I/8gZ8yF4sgpx+29hPkbBUc39MtpKjKBeipf2Bw3qSuqtsW8UBPbQvD0BpHU+l1fUs4M
	05TwBGRu6sROndcTXw48YH++5Jxj4i/o=
X-Gm-Gg: ASbGncu3t/lMV39KodE1s8fom3fCVvYbT7hrtYGfHqbnn/rxvArDJznSwQpUBCv1vBL
	3aJ1mydRHCHljqhuNUP/WJyl6m0eBpz4FG8wGb/7pHqjoXJXbd/+0p+7tbBd2Q5efXSrMXts/X8
	Ufh8CftIuQVPqyXW9Qi8UAn30B8DJBscE6ny2CO+oiSJyhztMgkg7BxCis1a71aO+KK8noVrAhO
	EUrBhlx
X-Google-Smtp-Source: AGHT+IGyu0ZkPugEWXzEljdlyIx6mfONy+WiSMjlOMcnsFBAw2hx+lOle+FP3aaXLnvDiZ06RuT2JKWt9T9VrBBHr2E=
X-Received: by 2002:a17:90a:da8d:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-31c9e75ef95mr11696365a91.3.1753130972963; Mon, 21 Jul 2025
 13:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
 <CANiq72mRWuQRFaouOSazi3GTXoHFaeVpyNMZcP0Lkymb+aXrqA@mail.gmail.com> <CAJ-ks9ne+YFezFvQ8nZH2UTjwqb3+3JtG0ztqecN-A46tC5SSw@mail.gmail.com>
In-Reply-To: <CAJ-ks9ne+YFezFvQ8nZH2UTjwqb3+3JtG0ztqecN-A46tC5SSw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 22:49:19 +0200
X-Gm-Features: Ac12FXxJIljI0Qgyxggn4RfqwM5u2m4U83LSCHwh8qf8prqbA__S0tFkUzwI8nA
Message-ID: <CANiq72nWsKd1DA=3O_XNYipw0PQ5iOX0gDyqYdGzMqTDZAdukg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rust: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Yes, please do. I did indeed use b4 - and Alice also let me know that
> this was not correct. Sorry about that! Same is true for 2a, I'll
> reply to that email as well.

Sounds good, thanks for confirming!

> I believe it was for everything, as he didn't specify otherwise.

Sometimes maintainers may mean it only for the things they actually
maintain, especially for big series where it may be obvious -- in
Greg's case, it is harder to assess since the series is small and he
is a top maintainer anyway.

Cheers,
Miguel

