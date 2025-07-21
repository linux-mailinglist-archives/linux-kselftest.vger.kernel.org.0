Return-Path: <linux-kselftest+bounces-37774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD34B0CBAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8173B167B9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E98238D57;
	Mon, 21 Jul 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNTs3Ys8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD45D19CC28;
	Mon, 21 Jul 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129216; cv=none; b=WIAw/Mbr8N8BLvUi2j3wzKFvIiH6d+OjzPnl7WyZl9vGxwbaGgmz+aN1XmkP4CPhoQ6XK4H/59+bHoR+UmZ8G2XMSKLCcp1Z4L6yCkY88nkWlit902WDY1KGH2k7KfOArEDRszAjfViqNHHXyU10llH+5Fx5kIx4y0bRH2l6vTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129216; c=relaxed/simple;
	bh=QhoaQFtxNxausfHipJnOzeN1CL5MUK8zNLHiVu3g8n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGplBa72K1BD9NC5C3agOqWtGzA6zA02rAXFdL5IcuAmBVjocfQsU+XDjIyCP7PByDi0OZITQgiojLIvjvQjQCOCMCUTuMVbG+uu88bTSFRWcx5LPtfPr89caAbXjXFk8mqjE0uLLLFd8b7oU8VpKZeQR+C+CUeC1L2fhCDGn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNTs3Ys8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so48736a91.1;
        Mon, 21 Jul 2025 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753129214; x=1753734014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhoaQFtxNxausfHipJnOzeN1CL5MUK8zNLHiVu3g8n8=;
        b=TNTs3Ys8eBGIIjsrjlhnaYufJnrq99cmDn7o8GfI1i3u7cv806dHTXqS9/uHR1f7JL
         MeznwZg1nBEwjlu0rkjZwi7CmCKBV5SXsf8pVyGVX9BGR5c0C16zunPjJX2e9D2atbxi
         JKB0QL5e/ikEz9nI6mEP1IsAeem2uPFF3dnDN/OAWx/xelHehKzkHRjo6eiO3bj4xI88
         D5Nk2IcMkg0HW9ZRuAyXPp90CyDaQVgQlfVMp5mlyalLyhQn3/b3R+KS+44sc0VZ3g58
         aiq8nkkPbEf3rhzkXpWdZnzUJ4LJEHSKbYuIHiTPRtpGlpCpcGyR0W7+xj2fkD58tObh
         n+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129214; x=1753734014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhoaQFtxNxausfHipJnOzeN1CL5MUK8zNLHiVu3g8n8=;
        b=lBetLDCKfsUdCL/pkD396yycrjBYvtykgm1WXnoxWLSZU/ylbpDbvSKGmamx9yO5Bu
         cGGPawEtF4aKZmRFk8TXJVCqdQRYHROwDydiZ8ShNj+QujsUsRHZEGfOC7lF/aCS21gL
         mbKpoqbdV5da2FovTnidY0GISH94A/wkvEoq+WCui03wWG5mBX06l19cDOO+nGKswxkL
         viGUoxHWQhChlZd+U8RofFZ/mRH0KQDWpTkO4N6wtKHe5SKAWj1xkyTdRggPIZUX2wNj
         Afzl8zYx/jMLpuGvJU3A51GuQM4SNyPXn4fQQTLtxfv9L3P8oVzj9s1kXSJ07E3nSdj2
         WzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvuPLFFM7Oo0Kj9qUGFZTF1e2XtTXPOaAWcPtaFhMKJWnerKMSQvTnFVkZeScGiC0U4CzWTgzSMbxZTP8JayKD@vger.kernel.org, AJvYcCUwucxTAENt8OWohoYuxPFWOSP1ZltU75Dyukqshx7n+uZpyehJUd4fWRse/KkXdhr7VdINcJEkYW2J/wonz3I=@vger.kernel.org, AJvYcCWFJ2XijynbTlFvXQuYNI3tHx8fQRHkcMIInfSoVGoAjA0dPGr/Hok0ftkLxeIrFEyaAw+qjkMjhNrD@vger.kernel.org, AJvYcCWSwPtDuF0nOlzFiVS4DpQxdZxM6OQTePhcGT2RZDZsZw6buJl8HLDlh0fFbw/wwwswOXEvJaNxH95HDVRY@vger.kernel.org, AJvYcCXuM5ONCpq68oLolwZMBA12je+WFsCN6dYUIUKLKxYePbUitCTSHBpjCwN8iuypKbNRWGUnfoSP6IM=@vger.kernel.org, AJvYcCXvC2UKbmpv9uh/rjOJ/LbequIE4IfzrwfjBwHgD0P6htu8fPamEjLMZP7CkwwRkfv0RRUxYlp0@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP6BJJy2aYxL5MUAfeEiwqW3eRH824/Xx2yOtcCmCxE+3xnYb
	KHXLUVxq6WiJYAnnlUAsFtDPskoNzhewp+4NmbLZCCZNkAhZEoQOGN3kqgh22KSVtQrvymv0LTV
	HEP6KX9TP6fhVFPDVpXq/eV1+jE8gvoo=
X-Gm-Gg: ASbGncuuLAbuvk2QygkKto1xHoaQe1OVxnsqAasMKAaN2lrollhNE8AgOKdw2MeJAba
	oGXpqfKgfrRJFh+7yJQohMGwkrqh4mUiMVWuFWBS0YI/iDoBoQGSDJ7e+AWNY/zgihYPd0OV9h2
	25TP0Ke2UIj/eWCWiodnSgUd5TU4FEAfQdJ7Gs1zm5MobEEo/2e8WKjh9JYwphswbfXbhooGZFT
	ETMdp9f
X-Google-Smtp-Source: AGHT+IGYWFzzB+EaA1sUPW0yxlHljqythmWNIpx8bVOSX58qriu4XgVDPxfn17/Rmpvzl5eSATKzzBGxAaQbrkHzpc8=
X-Received: by 2002:a17:90b:57cf:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-31c9e6e5debmr12843850a91.1.1753129213894; Mon, 21 Jul 2025
 13:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 22:20:01 +0200
X-Gm-Features: Ac12FXwTjwqkUOe19S3QjijBkelsLmO-zTtTU8nCjXVYR5x32YJPDBd3Xx-BAUU
Message-ID: <CANiq72mRWuQRFaouOSazi3GTXoHFaeVpyNMZcP0Lkymb+aXrqA@mail.gmail.com>
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

On Sun, Jul 20, 2025 at 12:42=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).

Did you apply this with `b4`? I think you picked Danilo's Acked-by,
which was for a subset, for other patches too. I can remove it when I
apply it.

(Greg's Acked-by may also have been just for his bits back in the
previous series, but in his case he didn't say anything explicitly)

Cheers,
Miguel

