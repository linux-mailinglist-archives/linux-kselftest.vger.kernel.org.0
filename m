Return-Path: <linux-kselftest+bounces-37777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE51B0CBD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242D1AA1EC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30034239E9E;
	Mon, 21 Jul 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqvP+GEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662427DA7F;
	Mon, 21 Jul 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129915; cv=none; b=oiPpWp3fp+YLsCGKT55v1+GTrZ3GYDT0aqftfzyMsXc1l5xYbFiaNYAheYq1WTOeP7vK8+G2J7bJ5xIY3JaBqg44Tnc2BGM63ja7B7us1G7eW6JrRlm5/IQtCnSuFEOhl/VWoVeAZ4xrAnqhA4rKgTwaKaM+U557zDxXgb9DG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129915; c=relaxed/simple;
	bh=g5A9KOanO+cfCnC2DzKbBgwUK1XEgUVRRT2guId11mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge45oDoSYOwGC90zFQGIFwjfVlV9qp4tMZRfXB10h9tMsHzdtC2LM7cjn/MOhE6zLHLJSZkCExb5/RVhY6/BY2T4JWIe2vejkxs0SOzi27B6mJm8EWTGu2YnWLYkHGRO179lY61F8HAU0KwThhePXGUcvJbdjW81mNAkOEcnxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqvP+GEz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-555163cd09aso3869018e87.3;
        Mon, 21 Jul 2025 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753129911; x=1753734711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5A9KOanO+cfCnC2DzKbBgwUK1XEgUVRRT2guId11mE=;
        b=jqvP+GEzmMIcut//TyCN8goYafOKEx7WWtTZlUZZw9DTkw+S8CtShjFEYm5TUdU7X1
         lt8bA5t1sidQzh6fOtaSkDkYd8zKKQvVH6toSft9n5Pe5DQ1k/8BsaELg1R8XDpxq1BJ
         9kFA3OULtLj7ta5BofKRTL0/UwLy3rXHIUCifiN03cbylhAg+FKOiUerazazoS3Tqb01
         wzkec3UTd5GMarJrAu+zS32hSK83HNVLIn4Tx1fMEbeWUVVQLg440ygux5pT7+h7h7yv
         dY+x6fX/r9o+iktyJWUtdlfc7/p7YbifSGz36Fbs33+oPdH+k1RvI3fH2V6MXS+i74DV
         LSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129911; x=1753734711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5A9KOanO+cfCnC2DzKbBgwUK1XEgUVRRT2guId11mE=;
        b=ZhSDU55M6JUs+tCmXCmDpRaTQ2htQy5GRMbY+SZu6m0Z9eegjOBuU2OZvg8+7vSp8D
         Nam0hDxd8HLxQ1+A+nLhxQaf59Eu5Ivk3jGnqTp6RbgWiORQZBZ+DMlVlAlU2eFEFxo5
         hV1Lc9RkIM4g48gN/ndZlfIc6ZZ9k5IuOUpBnbqLHoKH2yIxGKuoaT3WuzZrGC4ykSO+
         TaRkQAyWk7IO2Nx6J0qxq0MbJigTPo/KvjPvvAjHZBWo6Fbo06y6bcLz/MSUJI7+K3WU
         lUEff4ZTcTDKqFCrSfoyYSV5ktd1mAQhPWWi8snaQ7iWJnw1xr/ON5ARKxixT9uMRDNC
         ryTw==
X-Forwarded-Encrypted: i=1; AJvYcCUiiuO8Wuctfe/jzEhK4bLRU+I1AH//FHLJWmYyn0nqa/KbMwYIXyW7Ecq8MqFhn6KO5DOQnfuM@vger.kernel.org, AJvYcCUwyfeHnzEhA13mSyrkfVDBO8SsWAb1czJBhWt6uM1aSv4tnBX0JB4mgGFVc8fZNjgTwymliEin2UPG@vger.kernel.org, AJvYcCWBtxK2QE2Y/tZenAhzz/2U8icLMDLSu7D0eyi3O6FaDqyMwKyWNusaYC5Xv2EBw9HHhbu8W9tu3LSmIuMKQWnI@vger.kernel.org, AJvYcCWIeBbz8zNDSbPVMB5grQdD4rmv4Q0QWx/g0g5XBYcuQyg6WXz1DTgQHj3Q2f3hMt2Z5p8R3VNfBiOm3uhVHL8=@vger.kernel.org, AJvYcCXMBJfeVWwNtv1TJXqGaa3y7wEDBbEk6+eG2jLxLlsls966lRWPtTEK8MVzOSIM84XPIWPefF+MohI=@vger.kernel.org, AJvYcCXoPs77LppdhX7FpPr4QU1IzlnSXJYfbJYZwUlkwqwrajA2QblNjEV4e6OwYLa5t1q8hzIMqblc+HV3RxH7@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJFGOigDcRLBY+2kS97lJn2JomPtG5euRRER8uE27Tmse27+3
	eu+c3wNFzf2EOvIh+OoON2mxTilm5qLpAGhtCnVcA7KaxZLI3fDNlblT8edZLDk6d6Rau2eN0dP
	FUNtHWXg11p4CPkA1QQYrL5G9wQ6NKtg=
X-Gm-Gg: ASbGncvrXVb/eHF7D1gciTIGxsQJRrNOVgyUP5LpEsZOfMeuQ2wHI0WcpC52tIVXS/C
	XCPZ0zp31ljm2L05qv828rXQfnPVCiB+lZwpOuT1XW2Zb4tA1L+WjPClow+eoH0esGwgvclSC3t
	MSgguEte4t/XIVIrP85lzDJ2nSwUrBQJkWZ5DsHXNBqXCbwr39wqfUgHcQ6ScRCS4sefugvlkZ3
	zWjf5gJC2xWvIvLxCM=
X-Google-Smtp-Source: AGHT+IFR2lRHIzOwJj3JIlIo6gx45Mp51Ht2b7RDYiFrG52gvnrp+p/uZ3Tj+777Jg5nVJOtwaPjIzJjlMYwrAVYkHM=
X-Received: by 2002:a05:6512:398d:b0:553:35ad:2f45 with SMTP id
 2adb3069b0e04-55a29729104mr5367527e87.50.1753129911239; Mon, 21 Jul 2025
 13:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com> <CANiq72mRWuQRFaouOSazi3GTXoHFaeVpyNMZcP0Lkymb+aXrqA@mail.gmail.com>
In-Reply-To: <CANiq72mRWuQRFaouOSazi3GTXoHFaeVpyNMZcP0Lkymb+aXrqA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 21 Jul 2025 16:31:15 -0400
X-Gm-Features: Ac12FXwThiyNWkPFtuHHqyDRKx2RF3BqA4YU0Qjx3AoUK2MCPhmxxwTXBXJI9Qc
Message-ID: <CAJ-ks9ne+YFezFvQ8nZH2UTjwqb3+3JtG0ztqecN-A46tC5SSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rust: use `core::ffi::CStr` method names
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Mon, Jul 21, 2025 at 4:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Jul 20, 2025 at 12:42=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> > can be taken through Miguel's tree (where the other series must go).
>
> Did you apply this with `b4`? I think you picked Danilo's Acked-by,
> which was for a subset, for other patches too. I can remove it when I
> apply it.

Yes, please do. I did indeed use b4 - and Alice also let me know that
this was not correct. Sorry about that! Same is true for 2a, I'll
reply to that email as well.

> (Greg's Acked-by may also have been just for his bits back in the
> previous series, but in his case he didn't say anything explicitly)

I believe it was for everything, as he didn't specify otherwise.

