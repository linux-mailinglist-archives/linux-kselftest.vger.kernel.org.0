Return-Path: <linux-kselftest+bounces-37268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AEAB0438D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82D44E1EB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150182609D4;
	Mon, 14 Jul 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4aCNCmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D92571DD;
	Mon, 14 Jul 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506298; cv=none; b=Jg3Ak7J0RpaP7/TQ8uo/kSO+TpAiN2IArYYvQFuefU64tQc92qO+obE6o4C5ndsivqXdtrQyPvMcurpiAS8ss0DZ8pzOkmbmewWn9zalEQkR+xprjqdtPXGxYQvH2sPZm/ZrX8u9JBkLV9+9yA4+Z1uuyeUtf4opeSZcAGohBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506298; c=relaxed/simple;
	bh=H2Vfa1hTNVLtaQ3ZfRlV+2JX86DONilPDV8aWr5D5/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4AhlEbVarVpe4ql0xU8nxcS4Es/WGiLgqy8/5bojD4xQRi8r5iF6ah9hOuzEPK//QcpG6mb2N0Z6MCRHb+0kpUSQVUSW6SvPeFP+UaGfxT2EX61ypKwgHQcT8M5QGm+f6WdXliBnwCxt3mnq/HCEwERdChSuA8TS8R6d85xyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4aCNCmZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so1164607a91.2;
        Mon, 14 Jul 2025 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506297; x=1753111097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Vfa1hTNVLtaQ3ZfRlV+2JX86DONilPDV8aWr5D5/E=;
        b=f4aCNCmZ1Aj0r3Y+WD0umwp2tFFDkErl/1ZAj0oEkH0KtM3BfnPvoMYSIqkIvi3o4B
         YP4ZKV3yhgzv6tX+Y4bi3UwPKOwDCNUwKE6JCWTagnl1yUPKrbYLQ1n+6993aWfaa8pA
         G0EEZ4a/wUzobX9E6L1VMMjprfUhn2pSzmqIKyjR6V9SJ0Wfjs4L8iOlRtSilNdXO5rq
         5/okjGefXTQYSKdddgemyOn3TAo2cQgvZo8foc/hVB/9touB7t15NXNCjywv8NsrEl5b
         r7H61FLqS4vRaeuPga4W3B+73MspGALC9qbWmkRnzMQTgb/8Irb8R/aJad/emnM4xNB7
         VWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506297; x=1753111097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2Vfa1hTNVLtaQ3ZfRlV+2JX86DONilPDV8aWr5D5/E=;
        b=vfYo6kttb+RC4cJ5CNvz9m9EORkYifO51G8WHwLQtwy7342Sq/Q5NnT4qRy4OROKGd
         z9J4omjQrgLD2eh/YMDmsZIYPMOeLjaOfOodz1gyEqEXgeeMCPG88B3HP8cddB4VaD6q
         8FtP3PMmK8xSK6SY/kT8bWNlz/13xtAuXX/f8x4bE/p+AXqVJ4rqBIEm6RTbZJMIT2Ag
         a+BaoawLdaTQQFmvKh0W8nJTRGynLCYheV0FO9gjfMcaOtplaZJP0/TGILwVl02eFSxN
         YCaqSg32nE0cAb6t3CIRxc3J0d+V74d7zVdNJoTGLHB9TvwM7NT/M6Ncj2TNnqf8b3Gw
         WzCA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGGAqpocemJ3S3L17372Pua6AGf/nEJamokubpptJy9O51cNHNcCpP5GySADV81CcD526jo3BiY4NaPnsBmKz@vger.kernel.org, AJvYcCULz24z4pWU4sdsFUC60n4/j8zvbyACgmsKQm6i3W6ByUjcGE7ly6OY/F9POMLMoSyncIZzjldV2H5rY2bn@vger.kernel.org, AJvYcCVMJfMp7kERUTRt3AZxUZQJqRK1x1hOUICGJx5bEN75GdktyoQurtcWb2FNx9pUb+A/JUdCF1Op9ujmW8yXXuo=@vger.kernel.org, AJvYcCXsBJ4i+rg/42BXKyy60IfyI0wQJ2j4Uzj+DVvnd+mUSz4qyMrUVXsX0XGXWRoRMMdO9B1g0xdERq4Q@vger.kernel.org, AJvYcCXvMQov6Nzat1SW5zQsPM0N1dS25Iv84LDOlnfp3W71Q3o4SlARNLD9WMeR0ZKh8HMs4AuMTG+OMbM=@vger.kernel.org, AJvYcCXw1DpBVbTLqQN6t5XpeDvltxHmguQPyodOIvMKYi55+A/yn+uLctZrM6kB5Hnkam8VOXpozaYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTiglU9oFQoTaYXaZt20lefc/Phi/HynvXd4jtXrtjFfNW0It
	/7AfFduUwB1bgxN/7MH9TWC2eDdRhrONZPL+KSBX3jc3ik+xLK+DdQ1I1926LYCt1z+fT9qthq5
	cifdGMn9Xl478mLZuvoEy+pf4Eqbq7ks=
X-Gm-Gg: ASbGncs89UTvOvFt8Js00O4xOcxUSgBf/6/U7ysMRP/s6JKL2TA/wKSBGlnGokr50JV
	h3CrukIosWiP2uKktLxp9wmPir1CY7GaymajyI1SkZVFmFAi8LbTuPHgMqdzH1NGA/ibQcQYvH1
	IVxi5yu9L5XBQFvfEP/NiWk8HAGgn4NxlQOoq53kuSEAEsvFHmmE5JjAu4U4I5dMjTKcG+TGr52
	P1Icyf+dliyW49+cUA=
X-Google-Smtp-Source: AGHT+IEAaevWA3THWIOPb1Ft9IVMbazdTZ0Roc9iuvAoj1b5HTax5adhB7GCfo0cZ1I1i+dSyxYRJQcg/1n6uYcNd6A=
X-Received: by 2002:a17:90b:558f:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-31c4ca77626mr8723572a91.1.1752506296678; Mon, 14 Jul 2025
 08:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com> <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
 <CAJ-ks9=ZHtzeyyFSZaVuA1t-3C8-hc40n6r8qFWxn628qT-OeA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=ZHtzeyyFSZaVuA1t-3C8-hc40n6r8qFWxn628qT-OeA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 17:18:04 +0200
X-Gm-Features: Ac12FXzX4FOFR5k7wOozEqN2_nmttthJfs0me70_TpwVT6YUdkB9gcZMGomkNT4
Message-ID: <CANiq72kyQQMutGDkHH=McRQens+V+wkHLpiSfivmnAwwgXE62w@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Mon, Jul 14, 2025 at 2:35=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> How should I respin this one? the subject should be drm/panic, I think.

I would mimic what the previous commits did, i.e. drm/panic indeed.

(If I happen to pick it up before a resend, I could fix it on my side)

Cheers,
Miguel

